#
# Be sure to run `pod lib lint TLSModules.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TLSModules'
  s.version          = '1.0.12'
  s.summary          = 'TLSolution에서 사용하는 모듈 라이브러리 입니다.'
  s.description      = 'TLSolution에서 진행되는 모든 프로젝트에서 기본적으로 사용되는 모듈들의 소스코드가 담겨있는 Library입니다.'

  s.homepage         = 'https://www.tlsolution.co.kr'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jjeui0308@gmail.com' => 'jjeui0308@gmail.com' }
  s.source           = { :git => 'https://github.com/TLCompany/TLSModules-iOS.git', :tag => '1.0.12' }
  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files = 'Source/**/*'
  s.platforms = {
      "ios": "12.0"
  }
  
  s.ios.resource_bundles = {
     'TLSModules' => ['Resources/**/*.xcassets']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire'
end
