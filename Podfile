platform :ios, '10.0'

use_frameworks!
inhibit_all_warnings!

target '测试界面Swift' do
  
  pod 'LookinServer', :configurations => ['Debug']

  pod 'SnapKit', '~> 5.0.0'
  pod 'RxSwift', '~> 5.0'
  pod 'RxCocoa', '~> 5.0'
  pod 'RxDataSources', '~> 4.0.1'
  pod 'RxRelay', '~> 5.0'
  pod 'Kingfisher', '~>5.15.8'
  pod 'SteviaLayout', '~>4.7.3'
  
 
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
          end
      end
  end
end
