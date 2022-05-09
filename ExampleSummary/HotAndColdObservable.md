# Hot & Cold Observable

> `“Hot” and “Cold” Observables`  
> When does an Observable begin emitting its sequence of items? It depends on the Observable.   
> A “hot” Observable may begin emitting items as soon as it is created,  
> and so any observer who later subscribes to that Observable may start observing the sequence somewhere in the middle.  
> A “cold” Observable, on the other hand, waits until an observer subscribes to it before it begins to emit items,  
> and so such an observer is guaranteed to see the whole sequence from the beginning. 

</br>
</br>

## Hot(=inside) Observable
- 생성됨과 동시에 `item`을 방출한다.
- 나중에 구독한 `Observer`는 `Sequence`의 중간부터 관찰하기 시작한다.

### 특징: multicasting
- data가 `Observable` 밖에서 생성된다.
- 여러 구독자가 data를 공유할 수 있다.
- data가 생산될 때 구독자가 없으면 해당 데이터를 잃어버리게 된다.

</br>
</br>

## Cold(=outside) Observable
- `Observer`가 구독하기 전까지 `item`을 방출하지 않고 기다린다.
- `Sequence`의 전체를 볼 수 있다.

### 특징: unicasting
- data가 `Observable` 안에서 생성된다.
- `Observable`은 lazy여서 옵저버가 구독해야 value를 실행한다.

</br>

- 각각의 구독자가 `Observable`을 실행하면 data는 공유되지 않는다.
- `Observable`이 구독자마다 새로운 실행을 하기 때문에 구독자마다 값이 모두 달라진다.
- data를 `Observable`밖에서 생성하면 `Hot Observable`로 만들 수 있다.

</br>
</br>

## 예제 코드

```swift
let cold = Observable<Int>.create { ob in
    ob.onNext(Int.random(in: 0...10))
    return Disposables.create()
}

let num = Int.random(in: 0...10)
let hot = Observable<Int>.create { ob in
    ob.onNext(num)
    return Disposables.create()
}

//let hot = Observable.just(Int.random(in: 0...10))

cold.subscribe(onNext: { print($0)}) // 9
cold.subscribe(onNext: { print($0)}) // 3

hot.subscribe(onNext: {print($0)}) // 2
hot.subscribe(onNext: {print($0)}) // 2
```


</br>
</br>

- [공식문서](http://reactivex.io/documentation/observable.html)
- [참고링크](https://luukgruijs.medium.com/understanding-hot-vs-cold-observables-62d04cf92e03)
