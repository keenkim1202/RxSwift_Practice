import UIKit
import RxSwift

// MARK: Observable : 관측 가능한 객체를 의미한다.
// Observable이 어떤 값을 방출하면 옵저버가 그 값을 확인하는 것이다.

// MARK: just : 1개의 값을 방출한다.
// 구독해보면 1이 나오고 완료 메세지가 나온다.
let observable = Observable.just(1)

// MARK: of, from : 여러개의 값을 방출한다.
// 둘다 배열을 넘겨주지만, 차이점이 있다.

// of : 여러개의 원소를 지켜봄 (옵저버블 배열을 만든다.)
/*
 2는 원소 각각을 방출한다.  1 -> 2 -> 3 -> completed
 3은 배열을 방충한다. [1,2,3] -> completed
 */
let observable2 = Observable.of(1, 2, 3) // Observable<Int>
let observable3 = Observable.of([1, 2, 3]) // Observable<[Int]>

// from : 각각의 원소를 옵저버블로 만든다.
// (from은 배열값만 받을 수 있다.)
let observable4 = Observable.from([1, 2, 3, 4, 5]) // Observable<Observable<Int>>

// MARK: subscribe : Observable값에 접근할 수 있다.
observable4.subscribe { event in
  // print(event)
  if let element = event.element {
    print(element)
  }
}


observable3.subscribe { event in
  // print(event)
  if let element = event.element {
    print(element)
  }
}

// onNext를 활용하여 원소에 순서대로 접근할 수 있다.
let subscription4 = observable4.subscribe(onNext: { element in
  print(element)
})

// MARK: Dispose
/*
 구독을 하고 난 후에 disposing 하는 방법에 대해 알아보자.
 
 구독을 생성하면, 구독자가 리턴될 것이다.
 구독자는 항상 특정 시퀀스를 listening 하거나 observing 할 것이다.
 이 구독을 처리하지 않으면 메모리 누수가 생길 수 있다.
 */
subscription4.dispose() // 이렇게 해주면 됨

// dispose를 제대로 처리해주지 않거나 까먹는 경우도 있음. dispose하는 다른 방법도 알아보자

