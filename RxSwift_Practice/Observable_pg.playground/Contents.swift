import UIKit
import RxSwift

// Variable <- deprecate 될 예정. BehaviorRelay를 사용하도록 하자
let disposeBag = DisposeBag()

// behavior subject와 상태를 래핑하고 있다. -> 현재 값을 상태로 가지고 있다.
// 그리고 해당 프로퍼티를 통해 값에 접근할 수 있다.
// behavior subject를 사용하한 시점부터, 변수에 어떤 초기값을 넘겨주어야 한다.

// let varaiable = Variable("init value")
// varaiable.value = "changed value"

let varaiable = Variable([String]())
varaiable.value.append("item 1")


varaiable.asObservable()
  .subscribe {
    print($0)
  }

// variable이 옵저버블로 바뀐 다음부터는, 값이 바뀔 때마다 실행된다.
// 이것이 좋은 이유는 배열의 값이 바뀔떄 우리는 배열 안에서 값을 추가하고 지워주는 작업을 해야한다.
varaiable.value.append("item 2")

// complete, error 이벤트가 발생하지 않으며 variable이 해제될 때 자동으로 complete 된다.
