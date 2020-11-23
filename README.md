# Naver ID Login SDK for iOS

iOS 용 네이버 ID 로그인 라이브러리 및 예제 프로젝트를 포함하고있습니다.<br>
자세한 내용은 [개발자 센터 튜토리얼](https://developers.naver.com/docs/login/ios/)에서 확인하실 수 있습니다.

## 설치

네이버 아이디로 로그인은 [CocoaPods](https://cocoapods.org/)를 통해 제공됩니다. CocoaPods 는 다음 명령으로 설치할 수 있습니다.

```
$ gem install cocoapods
```

라이브러리를 사용하기 위해서는, 프로젝트 루트의 `Podfile`을 다음과 같이 수정합니다

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<프로젝트 명>' do
    pod 'naveridlogin-sdk-ios', '~> 4.0'
end
```

수정 후, 프로젝트 루트에서 `pod install` 명령을 통해 설치합니다.

## 샘플앱 실행 방법

```
pod try naveridlogin-sdk-ios
```

# License

See [LICENSE](LICENSE) for full license text.

Copyright 2017 Naver Corp.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
