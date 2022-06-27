
## Driver vs Observable

RxSwift에서는 다른 Rx구현체와 다르게 Driver가 존재한다.
Observable과 Driver는 각각 언제 사용할까?

</br>

- Driver : UI layer에서 좀 더 직관적으로 사용하도록 제공하는 unit 이다.
  - Observable은 상황에 따라 `MainScheduler`와 `BackgroundScheduler`를 지정해줘야 함.
  - Driver는 `MainScheduler`에서 사용.




</br>
</br>
</br>

### 참고 링크
- [언제 Driver와 Observable을 사용해야할까? - 민소네](http://minsone.github.io/programming/reactive-swift-observable-vs-driver)
