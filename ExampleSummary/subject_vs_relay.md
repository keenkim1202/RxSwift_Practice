# Q. Subject와 Relay의 차이는?

## Subject
- `Observerable` 이면서 `Observer` 일 수 있다.
- 데이터를 `emit` 하고 `subscribe` 할 수 있다.


PublishSubject

## Relay
- `RxCocoa` import 해서 사용할 수 있다.
- UI를 위해서 만들어 졌다.
- `onError`, `onComplete` 가 없고, `dispose` 할 때까지 종료되지 않는다.
