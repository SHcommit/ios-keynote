## 📌 iOS-Keynote !!

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
