platform :ios, '13.0'

target 'MedicalApp' do
  use_frameworks!
  pod 'Alamofire'
  pod 'SwiftGen', '~> 6.6.2'
  pod 'netfox', '~> 1.19'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'Moya', '15.0.0'
  pod 'IHKeyboardAvoiding', '4.7'
  pod 'TPKeyboardAvoiding', '1.3.3'
  
  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
              end
          end
      end
  end
end
