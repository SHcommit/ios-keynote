## 📌 iOS-Keynote !!

--- 

🚨 **Keynote 3-1미션 완료: 23.7.20일**

## 📌 \[요약\]

- RandomGeneratable protocol 구현
- Alpha, Alphabet, Nubmer, UniqueId random generator 선언 
- UniqueIdRandomGeneratorStorage protoco, impl 구현 ( 추후 slideManager에서 관리<ins></ins>
- Rect model 설계
- RectModelAbstractFactory 선언[](https://github.com/SHcommit/ios-keynote/commit/6872c9a1e966f57b2e2a2616edd304720d469246)

## ✨ \[작업 내용\]

*\- RandomGeneratable protocol*

랜덤 값을 생성하는 RandomGeneratable protocol을 구현 후 Alpha, number, alphabet 각각의 random generator를 설계했습니다. 외부에서 이 타입들을 사용할 때 existential type으로 지정해서 의존성 주입을 통해 느슨한 결합을 했습니다.

\- RectModel, RGBAModel and @PropertyWrapper

Rect의 정보를 담는 RectModel을 선언했고, 이때 변상연님이 알려준 @PropertyWrapper를 통해 wrapperValue를 이용해 RGBAModel을 구현했습니다. 주어진 제약조건 이외의 값이 대입되는 경우를 대처했습니다.

\- SlideView, RectModel AbstractFactory

슬라이드뷰와 RectModel에 대한 abstract factory를 선언 후 후자의 경우 RectModelFactory가 언급한 프로토콜을 준수했습니다.

## 📸 \[미션 완료 스크린샷\]

- os_log를 사용했습니다.

<img src="https://github.com/softeerbootcamp-2nd/ios-keynote/assets/96910404/cfd12f43-ad79-4a30-bb2d-e37ba8021297" width="600" class="jop-noMdConv">

## 📚 \[레퍼런스 (또는 새로 알게 된 내용) 혹은 궁금한 사항 or 공부해야 할 것\]
- Factory method, abstract factory
- @PropertyWrapper
- Protocol공부.. 
- MVC 패턴 분리.. MVC또한 input, output으로 의존성 분리 가능

MVC 관련 읽으면 좋을 <a href="https://medium.com/@vialyx/ios-idiomatic-swift-mvc-design-pattern-b35910361b0a">개념 포스트</a>

protocol에 관해 읽으면 좋을 <a href="https://engineering.linecorp.com/ko/blog/about-
swift-type-system">라인 기술블로그 타입시스템!</a>

Swift 성능 이해하기(<a href="https://academy.realm.io/kr/posts/letswift-swift-performance/">realm</a>)

왜 protocol은 any를 써야하는가? <a href="https://github.com/apple/swift-evolution/blob/main/proposals/0335-existential-any.md#motivation">0335-existential-any.md</a>

나중에 볼 wwdc동영상.. protocol관련 <a href="https://developer.apple.com/videos/play/wwdc2016/416/">링크</a>

Swift Factory pattern <a href="https://i-colours-u.tistory.com/39?category=1004905">개념 포스트</a>

---

🚨 **Keynote 3-2, 3-3, 3-4 미션 부분 완료: 23.7.28일**

## 📌 \[요약\]

- SlideManager protocol을 사용함으로 바인딩을 통해 VC 객체로부터 의존성 분리
- SlideMenu 선택에 따른 Slide content 업데이트 
- Stepper 변환 시 notificationCenter를 통해 관련된 뷰들 데이터 갱신
- 클래스 내 기능을 담당할 수 있도록 + 디미터 법칙 지키도록 구현

## ✨ \[작업 내용\]

객체간 의존성을 느슨한 결합으로 만들수 있게 코드를 작성했습니다. 왼쪽에slide menu뷰와 그 이외의 오른쪽 영역 또한 테이블 뷰로 구현했는데, 단점은 오른쪽 영역의 테이블 뷰는 스크롤을 제한함으로 selectRow() 또는 scrollToRow는 마찬가지로 각각 관련된 델리게이트 메서드tableview(_:didSelectedRowAt:), scrollViewDidScroll(_:) 메서드가 호출이 되지 않음을 알게 되었고, reloadRow 또는 reloadData를 하지 않으면 명시적으로 cell의 데이터를 업데이트 할 수 없음을 알게되었습니다.

여기서 느낀점은 뷰 안에 여러개의 서브 뷰를 놓을 경우, 데이터를 받거나 갱신할 때 특정 뷰에 대한 데이터 주입을 잘 다뤄야 한다는 중요성을 다시 한번 알게되었습니다.

아쉬운점은 한개의 테이블 뷰와 한개의 뷰를 구현했다가, "재사용을 하는 테이블 뷰가 좋지않을까?" 두 개의 테이블 뷰로 화면을 구성했다,, 다시 한개의 테이블 뷰만 사용하도록 리빌딩하면서,, 시간이 많이 들어 다른 미션을 구현하지 못했다는 점입니다.. 테스트 코드도 작성하지 못했습니다..

## 📸 \[미션 완료 스크린샷\]


![ezgif com-video-to-gif](https://github.com/SHcommit/ios-keynote/assets/96910404/5578bc0d-2020-40ab-b396-9c535d367fb2)



## 📚 \[레퍼런스 (또는 새로 알게 된 내용) 혹은 궁금한 사항 or 공부해야 할 것\]

[공부했던 리스트]

- 테이블 뷰 재사용 큐 관련 흥미 진진한.. 실험을 진행했습니다. (<a href="https://dev-with-precious-dreams.tistory.com/">포스트 링크</a>)
- MVVM 패턴의 개념 MVC와 차이점 정리
- protocol any, some, composition 개념 공부

[공부해야 할 리스트]
- hitTest
- RxSwift
- JK iOS Master님의 pop 설계 프로젝트 정주행
