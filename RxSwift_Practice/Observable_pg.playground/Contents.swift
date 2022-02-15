import UIKit
import RxSwift

// Relay Subject
let disposeBag = DisposeBag()

// subject와 구독자는 동일한 값을 가지고 있고, 버퍼 사이즈 만큼 값을 전달 받을 수 있다.
// 버퍼 사이즈를 기반으로 이벤트에 replay(답신)을 하는 것이다.
let subject = ReplaySubject<String>.create(bufferSize: 2)

// 1, 2, 3이 방출되었지만, 버퍼사이즈 만큼의 값을 전달 받을 수 있기 때문에
subject.onNext("issue 1")
subject.onNext("issue 2")
subject.onNext("issue 3")

// 구독했을 때 1은 방출되지 않는다. (실질적으로 값을 넘겨준 갯수는 버퍼의 크기 만큼)

// 구독한 subject의 최근값을 버퍼 사이즈만큼 프린트한다. (2,3)
subject.subscribe { event in
  print("first", event)
}.disposed(by: disposeBag)

// onNext에서 방출한 이벤트들을 출력한다. (4,5,6)
subject.onNext("issue 4")
subject.onNext("issue 5")
subject.onNext("issue 6")

// 새로 구독한 subject의 최근값을 버퍼 사이즈만큼 프린트한다. (5,6)
subject.subscribe { event in
  print("second", event)
}.disposed(by: disposeBag)
