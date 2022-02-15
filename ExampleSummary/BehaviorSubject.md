# Behavior Subject

1. 초기값을 가진다.
```swift
let subject = BehaviorSubject(value: "inital value") // 초기값 부여하기
```

2. subscribe가 발생하면, 발생한 시점 이전에 발생한 이벤트 중 가장 최신의 이벤트를 전달받는다.
테스트 해보자.


### test1: subject를 구독하고 event를 프린트해보자.
```swift
subject.subscribe { event in // here
  print(event)
}

subject.onNext("issue 1")

// 출력결과
/*
  issue 1
*/
```

### test2: subject를 구독하기 전에 이벤트를 하나 방출해보자.
```swift
subject.onNext("last issue") // here

subject.subscribe { event in
  print(event)
}

subject.onNext("issue 1")

// 출력결과
/*
  last issue
  issue 1
*/
```
- behavior는 지닌값을 하나 방출하기 때문에 출력된다.

### test3: subject를 구독하기 전에 이벤트를 두개를 방출해보자.
```swift
subject.onNext("last last issue") // here
subject.onNext("last issue")

subject.subscribe { event in
  print(event)
}

subject.onNext("issue 1")

// 출력결과
/*
  last issue
  issue 1
*/
```
- behavior는 지닌값을 '하나' 방출하기 때문에 'last last issue'는 출력되지 않는다.

## PublishSubject 와 다른점 1가지
- behavior는 값을 하나 방출해야하고 내가 방출하지 않으면 자동으로 지난값을 방출한다. (test2,3)
