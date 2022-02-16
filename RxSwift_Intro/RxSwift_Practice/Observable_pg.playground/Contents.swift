import UIKit
import RxSwift
import RxCocoa
// BehaviorRelay

// RxCocoa 프레임워크 안에 있다.
let disposeBag = DisposeBag()

// 정리하면,,
let relay = BehaviorRelay(value: ["item 1"])
var value = relay.value // 변수에 relay의 초기값을 담아둔다.

value.append("item 2") // 추가해주고 싶은 값을 value변수에 추가한다.

relay.accept(value) // replay에 value변수를 추가한다.

// 옵저버블로 변경 & 구독
relay.asObservable()
  .subscribe {
    print($0)
  }



// 예시
/*
 // 값이 문자열인 경우
// 선언
let relay = BehaviorRelay(value: "init value")

// 옵저버블로 변경 & 구독
relay.asObservable()
  .subscribe {
    print($0)
  }

// value를 변경할 수 없다. (get-only)
// relay.value = "change value"

// 새로운 값을 받을 수 있는 함수는 있다.
relay.accept("change value")
*/


// 값이 배열인 경우
// 빈 문자열배열을 초기값으로 가진 객체 선언
/*
let relay = BehaviorRelay(value: [String]())

// 마찬가지로 value를 변경이 불가능하다. (get-only)
// relay.value.append("item 1")

// 새로운 배열을 만들어 추가해준다.
relay.accept(["item 1"])

relay.asObservable()
  .subscribe {
    print($0)
  }
 */

// Q. 만약 배열을 선언할 때 초기값이 있었다면???
/*
let relay = BehaviorRelay(value: ["init value"])

// 마찬가지로 value를 변경이 불가능하다. (get-only)
// relay.value.append("item 1")

// 새로운 배열을 만들어 추가해준다.
// relay.accept(["item 1"])

// Q. 초기값을 유지하고 싶다면?
// 초기값에 새로 추가할 배열을 더해주면 된다.
relay.accept(relay.value + ["item 1"])

relay.asObservable()
  .subscribe {
    print($0)
  }
*/

