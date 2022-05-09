## 시작하기

이제 초콜릿 맛 좀 볼까요?   
페이지 상단 또는 하단에서 튜토리얼 프로젝트를 다운받아주세요.  
받으신 뒤에는 `Chocotastic.xcworkspace`파일을 열어주세요.  
빌드하고 실행해 보세요.  
아래와 같이 각각의 유럽 국가에서 살 수 있는 초콜릿의 가격을 리스트로 보여주는 화면을 보시게 될 겁니다. 

초콜릿을 탭해서 장바구니에 담아보세요!  
우측 상단의 장바구니를 탭해보세요! 

다음 페이지에서 결제로 진행하거나 카트를 리셋할 수 있습니다.  
결제버튼을 클릭하면 신용카드 입력폼이 나오도록 되어있어요.  

튜토리얼을 진행하다 보면 이 화면을 완전히 반응형 프로그래밍으로만 만들게 될 거예요. 지금은 카트 버튼을 눌러서 카트 요약 화면으로 돌아갑시다.  
그리고 리셋 버튼을 탭해서 장바구니를 비우고 메인 화면으로 돌아가세요. 

</br>
</br>

## 시작 지점: Nonreactivity 

앱이 어떻게 동작하는지 보셨으니 이제 앱이 어떻게 동작하는지를 알아볼 차례군요.  
`ChocolatesOfTheWorldViewController.swift` 파일을 열어보세요. 기본적인 `UITableViewDelegate`와 `UITableViewDataSource` 익스텐션이 보일겁니다. 

그럼 이제 `updateCartButton()`을 보세요.  
이 메서드는 카트 버튼을 현재 카트에 들어있는 초콜릿의 개수와 함께 업데이트 해주고 있습니다. 이 메서드는 두 인스턴스를 통해 카트를 업데이트 해주고 있어요. 
```
1. viewWillAppear(_:) : 뷰 컨트롤러가 보이기 전에
2. tableView(_:didSelectRowAt:) : 유저가 새로운 초콜릿을 카트에 담았을 때
```

위 두 경우는 명령형으로 장바구니 개수를 변경해주고 있어요. 꼭 명시적으로 메서드를 호출해서 개수를 업데이트 해줘야 하는거죠.  

이제 이 코드를 반응형 테크닉을 사용해 다시 써볼겁니다. 그러면 버튼이 알아서 업데이트를 하게 될거예요. 

</br>
</br>

## RxSwift: 장바구니 개수를 반응형으로 세도록 만들기

장바구니에 담긴 아이템의 개수를 참조하는 메서드들은 `ShoppingCart.sharedCart`라는 싱글턴을 참조하고 있어요.  
`ShoppingCart.Swift` 파일을 열어보시면 싱클턴 인스턴스 내에 기본적으로 변수가 선언되어 있는 것을 보실 수 있을거예요. 

```swift
var chocolates: [Chocolate] = []
```

지금 당장은 이 chocolates라는 변수의 변화를 감지하지는 못하실거예요.  
`didSet` 클로저를 사용하실 수도 있지만, `didSet`은 전체 배열이 업데이트 되었을 때만 불러와집니다.  
배열 원소의 일부가 변경되었을 때는 `didSet`이 호출되지 않지요. 

다행히도 RxSwift가 이 문제를 해결할 수 있습니다. `chocolates` 변수를 아래와 같은 코드로 변경해보세요.
```swift
let chocolates: BehaviorRelay<[Chocolate]> = BehaviorRelay(value: [])
```
> 참고 : 이렇게 변경하시면 아마 사이드바에 오류가 뜨게 될겁니다. 곧 고칠거니까 걱정 마세요.

이런 문법을 보고 머리가 어질어질 하실 수도 있어요. 뭐가 어떻게 돌아가는지 설명을 해드릴게요. 
가장 중요한 것은 `chocolates`이라는 `Chocolate` 객체들을 원소로 하는 Swift 배열로 만들어 준 바로 그것을 
RxSwift의 `BehaviorRelay`의 타입으로 정의해 준 것이라고 생각하시면 됩니다. 

`BehaviorRelay`는 클래스이기 때문에, reference semantics(참조 특성)를 사용합니다.  
즉, `chocolates`가 `BehaviorRelay` 인스턴스를 참조하고 있다는 것을 의미합니다.

`BehaviorRelay`는 `value`라는 프로퍼티를 가집니다. 이 프로퍼티에 `Chocolate` 객체의 배열을 저장하는 것이죠. 
`BehaviorRelay`의 장점은 `asObservable()` 메서드를 호출할 때 드러납니다.  
수동으로 매번 `value`를 체크할 필요 없이, `Observer`를 추가해서 변하는 값을 감시할 수 있는것이죠. 
값이 바뀔 때, `Observer`가 알려주니까 어떠한 업데이트에도 반응할 수 있게 됩니다. 

단점이라고 하면 만약 여러분이 `chocolates`의 배열 안에 뭔가를 바꿔주거나 접근하려고 할 때, 무조건 `accept(_:)`를 통해서 접근하셔야 한다는 거예요. 
`BehaviorRelay`내의 이 메서드가 `value` 프로퍼티를 업데이트 해 주는 녀석입니다. 
그래서 컴파일러가 그렇게 빼액 울어대고, 에러 뭉텅이를 보여주는거죠. 그럼 이제 한번 고쳐볼까요?

</br>
</br>

### ShoppingCart.swift 파일에서...
`totalCost()` 메서드를 찾고  
다음의 라인을 :
```swift
return chocolates.reduce(0) {
```
아래와 같이 바꾸세요 :
```swift
return chocolates.value.reduce(0) {
```

</br>

`itemCountString()` 메서드를 찾고  
다음의 라인을 :
```swift
guard chocolates.count > 0 else {
```
아래와 같이 바꾸세요 :
```swift
guard chocolates.value.count > 0 else {
```

</br>


다음의 라인을 :
```swift
let setOfChocolates = Set<Chocolate>(chocolates)
```
아래와 같이 바꾸세요 :
```swift
let setOfChocolates = Set<Chocolate>(chocolates.value)
```

</br>

마지막으로
다음의 라인을 :
```swift
let count: Int = chocolates.reduce(0) {
```
아래와 같이 바꾸세요 :
```swift
let count: Int = chocolates.value.reduce(0) {
```

</br>
</br>

### CartViewController.swift 파일에서...
`reset()` 메서드를 찾고  
다음의 라인을 :
```swift
ShoppingCart.sharedCart.chocolates = []
```
아래와 같이 바꾸세요 :
```swift
ShoppingCart.sharedCart.chocolates.accept([])
```

</br>
</br>

### ChocolatesOfTheWorldViewController.swift 파일로 돌아와...
`updateCartButton()` 메서드가 적용된 부분을
아래와 같이 바꾸세요 :
```swift
cartButton.title = "\(ShoppingCart.sharedCart.chocolates.value.count) \u{1f36b}"
```

</br>

`tableView(_:didSelectRowAt:)` 메서드를 찾고
다음의 라인을 :
```swift
ShoppingCart.sharedCart.chocolates.append(chocolate)
```
아래와 같이 바꾸세요 :
```swift
let newValue =  ShoppingCart.sharedCart.chocolates.value + [chocolate]
ShoppingCart.sharedCart.chocolates.accept(newValue)
```

</br>

웨우!! 위의 작업을 통해 애러들을 처리하고 Xcode를 행복하게 만들어줬네요.  
이제 당신은 반응형 프로그래밍의 이점을 취하고 `chocolates`를 감시할 수 있습니다!


