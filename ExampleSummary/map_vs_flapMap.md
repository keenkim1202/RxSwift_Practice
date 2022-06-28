# Map VS FlatMap

## Map
- map은 이벤트를 바꾼다. E Type을 R Type 이벤트로 바꾼다.
```swift
public func map<R>(_ transform: @escaping (Self.E) throws -> R) -> RxSwift.Observable<R>
```

- 클로저에 연산 값을 리턴


## FlatMap
- 이벤트를 다른 Observable로 바꾼다.
```swift
 public func flatMap<O: ObservableConvertibleType>(_ selector: @escaping (E) throws -> O) -> Observable<O.E>
```

- 클로저에 Obervable을 리턴
- 
