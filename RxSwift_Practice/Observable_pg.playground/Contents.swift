import UIKit
import RxSwift

// Behavior Subject
let disposeBag = DisposeBag()

// 초기값을 가진다.
let subject = BehaviorSubject(value: "inital value") // 초기값 부여하기

// subscribe가 발생하면, 발생한 시점 이전에 발생한 이벤트 중 가장 최신의 이벤트를 전달받는다.
subject.onNext("last last issue") // 가장 최신 이벤트만 출력되므로 얘는 출력 안된다.
subject.onNext("last issue") // 구독 전에 작성을 해도 출력이 된다.

subject.subscribe { event in
  print(event)
}

subject.onNext("issue 1")

// publish 와 다른점 1가지
// behavior는 값을 하나 방출해야하고 내가 방출하지 않으면 자동으로 지난값을 방출한다.
