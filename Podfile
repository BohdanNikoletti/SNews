# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
def unit_testing_pods
  pod 'RxBlocking'
  pod 'RxAlamofire'
  pod 'RxTest'
  pod 'Quick'
  pod 'Nimble'
end

def general_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxAlamofire'
  pod 'RxDataSources'
  pod 'NotificationBannerSwift'
  pod 'ReachabilitySwift'
  pod 'RealmSwift'
  pod 'SwiftLint'
  pod 'FTLinearActivityIndicator'
  pod 'SkeletonView'
end

target 'SNews' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  general_pods

  target 'SNewsTests' do
    inherit! :search_paths
    unit_testing_pods
  end

  target 'SNewsUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
post_install do |installer|
   installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
         target.build_configurations.each do |config|
            if config.name == 'Debug'
               config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
            end
         end
      end
   end
end
