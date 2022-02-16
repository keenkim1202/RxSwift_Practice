## Variable <- deprecate될 예정. BehaviorReplay를 대체할 것을 고려하자.
 - BehaviorSubject를 래핑하고 있으며, 현재 값을 상태로 가지고 있는다.
 - complete, error 이벤트가 발생하지 않으며, variable이 해제될 때 자동으로 complete 되다.
 
 - 문자열을 초기값으로 준 경우
```swift
let varaiable = Variable("init value")
varaiable.value = "changed value"

varaiable.asObservable()
  .subscribe {
    print($0)
  }
// 출력결과
/*
next(changed value)
*/
```

- 배열을 초기값으로 준 경우
```swift
let varaiable = Variable([String]())
varaiable.value.append("item 1")

varaiable.asObservable()
  .subscribe {
    print($0)
  }
  
// 출력결과
/*
next(["item 1"])
*/
```

- variable이 옵저버블로 바뀐 다음부터는, 값이 바뀔 때마다 실행된다.
- iOS에서 배열의 값이 변경하고자 할 때, 배열 안에서 값을 추가하고 지워주는 작업을 해야하는 불편함을 해소해준다.
```swift
varaiable.value.append("item 2")

// 출력결과
/*
next(["item 1"])
next(["item 1", "item 2"])
*/
```

 
## 특징
 - subject, observable과 다르게 새로운 요소를 추가하기 위해서 onNext를 사용할 수 없다.
 - variable은 상태값이기 떄문에 에러가 발생하지 않는 것ㅇ르 보장하기 때문에 error 이벤트를 발생시킬 수 없다.
 - variable 해제될 때 자동으로 complete 되기 때문에 complete 이벤트를 발생시킬 수 없다.
 
## 언제 사용하는가?
 - 현재 값을 확인하고 싶을 때
