# Map VS FlatMap

## Map
- map은 이벤트를 바꾼다. `E` Type을 `R` Type 이벤트로 바꾼다.
```swift
public func map<R>(_ transform: @escaping (Self.E) throws -> R) -> RxSwift.Observable<R>
```

- 클로저에 연산 값을 리턴
- `Observable`로 부터 방출되는 item을 (Observable이 아닌) 다른 타입으로 바꾸고 싶을 때 map을 사용한다.


## FlatMap
- 이벤트를 다른 `Observable`로 바꾼다.
```swift
 public func flatMap<O: ObservableConvertibleType>(_ selector: @escaping (E) throws -> O) -> Observable<O.E>
```

- 클로저에 `Obervable`을 리턴
- `button.tap.asObservable()`을 API 통신 결과를 가지고 있는 `Observable<[String]>` 으로 바꿔줄 때 사용한다.


## map, flatMap를 활용한 비동기 작업 순차 처리
- APIService에서 Observable<SomeModel>을 리턴하도록 구현
 - 스트림에서 flatMap을 통해 데이터를 획득
 - 얻어온 데이터를 map 또는 do(onNext:) 에서 처리하고난 후 적절한 값을 다음 스트림에 전달
