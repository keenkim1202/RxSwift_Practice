import UIKit
import RxSwift

// disposing을 책임지는 냐석.
let disposeBag = DisposeBag()

// 이렇게 작성함으로써 언제 dispose가 적절하게 이루어질지 알 수 있다.
Observable.of("A", "B", "C")
  .subscribe {
    print($0)
  }.disposed(by: disposeBag)

// create function
// 나만의 옵저버블 생성
Observable<String>.create { observer in
  observer.onNext("A")
  observer.onCompleted() // completed가 되었기 때문에 뒤에있는 onNext가 실행되지 않음
  observer.onNext("?")
  return Disposables.create()
}.subscribe { // 생성한 옵저버블 구독
  print($0)
} onError: {
  print($0)
} onCompleted: {
  print("Completed..")
} onDisposed: {
  print("Disposed..")
}.disposed(by: disposeBag)




