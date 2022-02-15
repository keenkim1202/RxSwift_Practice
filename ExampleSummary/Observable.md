
## Observable : 관측 가능한 객체를 의미한다.
- Observable이 어떤 값을 방출하면 옵저버가 그 값을 확인하는 것이다.

## Observable 이 전달하는 세 가지 이벤트
 
 - 이벤트가 전달되는 시점은 Observer가 구독(subscribe) 시작한 시점이다.
 - subscribe는 Observable과 Observer를 연결하는 역할 -> 두 요소를 연결해야 이벤트가 전달된다.)
 ```swift
 public enum Event<Element>
  case next(Element)
  case error(Swift.Error)
  case completed
 }
 ```
 
 #### onNext
 - Observable은 새로운 항목들을 배출할 때마다 이 메소드가 호출된다.
 
 #### onError
 - Observable이 기대하는 데이터가 생성되지 않았거나 다른 이유로 오류가 발생할 경우 이 메소드가 호출된다.
 
 #### onCompleted
 - 오류가 발생하지 않고 더 이상 배출할 항목이 없는 경우에 이 메소드가 호출된다.
 - onCompleted, onError 둘 중 하나의 이벤트로 종료되었다면 관련된 리소스가 자동으로 해지된다.
 - Observable별로 해지하는 건 번거롭기 때문에 DisposeBag()을 사용하여 disposable을 담아두었다가 한번에 해지하는 것이다.

## just 
: 1개의 값을 방출한다.
- 구독해보면 1이 나오고 완료 메세지가 나온다.

```swift
let observable = Observable.just(1)
```

## of, from 
: 여러개의 값을 방출한다.
- 둘다 배열을 넘겨주지만, 차이점이 있다.

### of 
: 여러개의 원소를 지켜봄 (옵저버블 배열을 만든다.)
- 2는 원소 각각을 방출한다.  1 -> 2 -> 3 -> completed
- 3은 배열을 방충한다. [1,2,3] -> completed

```swift
let observable2 = Observable.of(1, 2, 3) // Observable<Int>
let observable3 = Observable.of([1, 2, 3]) // Observable<[Int]>
```

### from
: 각각의 원소를 옵저버블로 만든다.
- from은 배열값만 받을 수 있다.

```swift
let observable4 = Observable.from([1, 2, 3, 4, 5]) // Observable<Observable<Int>>
```

## subscribe 
: Observable값에 접근할 수 있다.
```
observable4.subscribe { event in
  // print(event)
  if let element = event.element {
    print(element)
  }
}


observable3.subscribe { event in
  // print(event)
  if let element = event.element {
    print(element)
  }
}
```

## onNext
- onNext를 활용하여 원소에 순서대로 접근할 수 있다.

```swift
let subscription4 = observable4.subscribe(onNext: { element in
  print(element)
})
```

## Dispose
- 구독을 하고 난 후에 disposing 하는 방법에 대해 알아보자.
- 구독을 생성하면, 구독자가 리턴될 것이다.
- 구독자는 항상 특정 시퀀스를 listening 하거나 observing 할 것이다.
- 이 구독을 처리하지 않으면 메모리 누수가 생길 수 있다.

```swift
subscription4.dispose() // 이렇게 해주면 됨
```
-> dispose를 제대로 처리해주지 않거나 까먹는 경우도 있음. dispose하는 다른 방법도 알아보자

