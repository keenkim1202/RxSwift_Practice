## Dispose
- 구독을 하면 구독자가 리턴되고, 구독자는 객체의 변화를 감시한다.
- 이 구독을 중지시키는 방법이 dispose 하는 것이다.
```swift
subscription.dispose() // 다음과 같이 구독 사항을 subscription이라는 상수에 담고 명시적으로 dispose 해줄 수 있다.
```
- 구독이 중단되면, Observable은 더 이상 이벤트를 발생시키지 않는다.

-> 구독마다 별도의 dispose를 관리하는 것은 별로 좋지 않은 방법이다. 번거롭기도하고 까먹을 수도 있다. (메모리 누수의 위험)
-> 그래서 아래의 DisposeBag을 사용한다.

## DisposeBag
- dispose객체들을 담는 가방
- 여러개의 Observable 객체들을 담아 dispose 할 수 있다.

```swift
let disposeBag = DisposeBag()
```

- 이렇게 작성함으로써 언제 dispose가 적절하게 이루어질지 알 수 있다.
```swift
Observable.of("A", "B", "C")
  .subscribe {
    print($0)
  }.disposed(by: disposeBag)
```

## Create
- Observable의 명시적 next 이벤트를 만들 때 아래와 같이 사용했다.
```swift
Observable.of(1, 2, 3)
```
- create 연산자를 통해서도 아래와 같이 Observable을 생성할 수 있다.

```swift
Observable<String>.create { observer in
  observer.onNext("A") // 1
  observer.onCompleted() // 2
  observer.onNext("?") // 3
  return Disposables.create() // 4
}
```
1. Observer에게 next 이벤트를 발생 시키고 이때 전달되는 element는 "A"
2. Observer에게 compelted 이벤트를 발생시킨다.
3. Observer에게 next 이벤트를 발생 시키고 이때 전달되는 element는 "?"
4. dispose를 리턴한다.

- 아래와 같이 구독해서 실행해보자.
```swift
Observable<String>.create { observer in
  observer.onNext("A")
  observer.onCompleted()
  observer.onNext("?")
  return Disposables.create()
}.subscribe {
  print($0)
} onError: {
  print($0)
} onCompleted: {
  print("Completed..")
} onDisposed: {
  print("Disposed..")
}.disposed(by: disposeBag)
```
- 다음과 같이 프린트 된다.
```
A
Completed..
Disposed..
```

- 여기서 dispose 하지 않거나 onCompleted 하지 않으면 메모리 누수가 발생!!

## DisposeBag의 해제 시점은??
- 직접 해제
```swift
disposeBag = nil
```
- class가 deinit 되면 자동으로 해제

## 요약
- 옵저버블 타입을 구독하면 Disposable 이 리턴된다.
```
Disposable = 옵저버블 시퀀스로부터 구독취소된 구독 객체들 
```
- 옵저버블이 동작하고 있는 동안 dispose를 하면 취소가 된다.
  - DisposeBag = dispose된 객체들을 담는 곳
  - DisposeBag = thread safe 하게 disposable들을 deinit에 추가해주는 역할을 한다.

- 일종의 RxSwift에서 ARC같은 리소스 매니징을 해주는 녀석이다.
- 그저 여기에 담은 후 다른 disposeBag으로 대체하거나 비워주면 알아서 관리해준다.


