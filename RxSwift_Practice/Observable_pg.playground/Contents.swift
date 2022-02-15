import UIKit
import RxSwift

let disposeBag = DisposeBag()

/*
 ## PublishSubject
 - 기본적으로 객체이다.
 - 구독과 이벤트 방출을 둘 다 할 수 있는 객체 이다.
 - 기본값을 줄 필요가 없다. (초기화하지 않아도 됨)
 
 -> 구독자(subscriber)이자 옵저버(observer) 인 것!
 */

let subject = PublishSubject<String>() // 이 객체는 string 타입의 이벤트만 방출 가능

subject.onNext("issue 1")

// 위의 까지만 하면 구독을 하지 않았기 때문에 아무일도 일어나지 않는다.

subject.subscribe { event in
  print(event)
}

subject.onNext("issue 2")
subject.onNext("issue 3")

/*
 출력
 next(issue 2)
 next(issue 3)
 */

// 모든 이벤트는 구독이 이루어진 후에 일어난다.
// 그렇기 때문에 구독을 하기 전에 발생한 이벤트는 프린트 되지 않는다.


// dispose 한 이후에 작성한 이벤트 issue4는 무시되기 때문에 출력되지 않는다.
subject.dispose()
subject.onNext("issue 4")


// completed 한 경우 oncompleted 까지만 출력된다.
// subject.onCompleted()
// subject.onNext("issue 4")

// dispose 한다면 그 이후의 이벤트는 다 무시된다.
// subject.dispose()
// subject.onCompleted()
// subject.onNext("issue 4")



