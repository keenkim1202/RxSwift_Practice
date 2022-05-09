# RxSwift_Practice
- RxSwift를 공부하면서 내용정리하는 레포입니다.
- 배우면서 하나씩 정리하고 틀린 부분 혹은 부족한 부분이 있다면 수정해 나갈 계획입니다.

## 참조 링크
- [RactiveX 공식문서](https://reactivex.io/documentation/ko/observable.html)

## RxSwift를 사용하는 이유는?
- 함수형 프로그래밍인 Swift에 반응형을 더해주는 라이브러리.
- 일관성이 없는 비동기 코드를 하나의 비동기 코드로 개발이 가능하게 해준다.
- thread 처리가 쉬워지므로 callback 지옥에서 탈출할 수 있다. -> 데이터 갱신 처리가 쉬워지고 코드도 깔끔해진다.
- 대신.. 러닝커브가 높고 디버깅이 어렵다.

## 사용시 주의할 점
- 메모리 누수
- 순환참조

## 내용정리
### Observable
- Observer가 Observable 객체를 구독한다.
- Observable이 방출하는 하나 혹은 다수의 항목에 Observer가 반응한다.
- Observable이 객체를 방출할 때까지 항상 감시하는게 아니라, 어떤 객체가 배출되면 그 시점을 감시하는 감시자를 Observer 안에 두고 그 관찰자를 통해 방출 알람을 받는다.

- [just / of / from ](ExampleSummary/Observable.md)
- [ Dispose / DisposeBag ](ExampleSummary/Dispose.md)

### Subject
- subject는 Observable과 Observer의 역할을 동시에 수행한다.
- 자체적으로 데이터를 생성하는 동시에 관찰자의 역할도 될 수 있기 때문이다.
- [PublishSubject](ExampleSummary/PublishSubject.md)
- [BehaviorSubject](ExampleSummary/BehaviorSubject.md)
- [RelaySubject](ExampleSummary/ReplaySubject.md)
- [BehavoirRelay](ExampleSummary/BehaviorRelay.md)

### Examples
- raywenderlich - Getting Started With RxSwift
  - [프롤로그 해석](raywenderlichEx/getting_started_with_rxswift.md)
  - 예제 프로젝트

