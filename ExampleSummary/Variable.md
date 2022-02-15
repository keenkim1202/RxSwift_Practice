## Variable
 - BehaviorSubject를 래핑하고 있으며, 현재 값을 상태로 가지고 있는다.
 - complete, error 이벤트가 발생하지 않으며, variable이 해제될 때 자동으로 complete 되다.
 
## 특징
 - subject, observable과 다르게 새로운 요소를 추가하기 위해서 onNext를 사용할 수 없다.
 - variable은 상태값이기 떄문에 에러가 발생하지 않는 것ㅇ르 보장하기 때문에 error 이벤트를 발생시킬 수 없다.
 - variable 해제될 때 자동으로 complete 되기 때문에 complete 이벤트를 발생시킬 수 없다.
 
## 언제 사용하는가?
 - 현재 값을 확인하고 싶을 때
