## Relay Subject

- subject와 구독자는 동일한 값을 가지고 있고, 버퍼 사이즈 만큼 값을 전달 받을 수 있다.
- 버퍼 사이즈를 기반으로 이벤트에 replay(답신)을 하는 것이다.

```swift
let subject = ReplaySubject<String>.create(bufferSize: 2)
```

### replaySubject 구독해보면
- 1, 2, 3이 방출되었지만, 버퍼사이즈 만큼의 값을 전달 받을 수 있기 때문에
```swift
subject.onNext("issue 1")
subject.onNext("issue 2")
subject.onNext("issue 3")

subject.subscribe { event in
  print("first", event)
}.disposed(by: disposeBag)
```
- 구독했을 때 1은 방출되지 않는다. (실질적으로 값을 넘겨준 갯수는 버퍼의 크기 만큼)
- 구독한 subject의 최근값을 버퍼 사이즈만큼 프린트한다. (2,3)

### 이어서 이벤트를 발생시키면
- onNext에서 방출한 이벤트들을 출력한다. (4,5,6)
```swift
subject.onNext("issue 4")
subject.onNext("issue 5")
subject.onNext("issue 6")

// 새로 구독한 subject의 최근값을 버퍼 사이즈만큼 프린트한다. (5,6)
subject.subscribe { event in
  print("second", event)
}.disposed(by: disposeBag)
```

## 언제 사용하는가?
 - 최근값 1개 외에 더 많은 값이 필요할 때
 - BehaviorSubject는 최근값 1개까지만 방출하므로.
 - 버퍼들은 메모리가 가지고 있으며, 데이터 타입이 메모리를 크게 차지하는 값이라면 메모리 부하가 나타날 수 있습니다.
