## PublishSubject
 - 기본적으로 객체이다.
 - 구독과 이벤트 방출을 둘 다 할 수 있는 객체 이다.
 - 기본값을 줄 필요가 없다. (초기화하지 않아도 됨)
 
 -> 구독자(subscriber)이자 옵저버(observer) 인 것!
 
```swift
let disposeBag = DisposeBag()
let subject = PublishSubject<String>() //  객체는 string 타입의 이벤트만 방출 가능

subject.onNext("issue 1")
```

- 위의 까지만 하면 구독을 하지 않았기 때문에 아무일도 일어나지 않는다.

```swift
subject.subscribe { event in
  print(event)
}

subject.onNext("issue 2")
subject.onNext("issue 3")
```
<details><summary>위의 출력 결과</summary>
  <p>
    
```
 next(issue 2)
 next(issue 3)
```
    
 - 모든 이벤트는 구독이 이루어진 후에 일어난다.
 - 그렇기 때문에 구독을 하기 전에 발생한 이벤트는 프린트 되지 않는다.
  </p>
</details>



## dispose() 이후에 이벤트를 방춣하면?
- dispose 한 이후에 작성한 이벤트 issue4는 무시되기 때문에 출력되지 않는다.

```swift
subject.dispose()
subject.onNext("issue 4")

// 출력결과
/*
next(issue 2)
next(issue 3)
*/
```

## onCompleted() 이후 이벤트를 방출하면?
- completed 한 경우 oncompleted 까지만 출력된다.
```swift
subject.onCompleted()
subject.onNext("issue 4")

// 출력결과
/*
next(issue 2)
next(issue 3)
completed
*/
```

## dispose() 이후 onCompleted()를 쓰면?
- dispose 한다면 그 이후의 이벤트는 다 무시된다.

```swift
subject.dispose()
subject.onCompleted()
subject.onNext("issue 4")

// 출력결과 // 
/*
next(issue 2)
next(issue 3)
*/
```



