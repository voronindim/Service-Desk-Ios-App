# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'App'
use_frameworks!

def rx_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

def lottie_pods
  pod 'lottie-ios'
end

def toast_pods
  pod "ToastViewSwift"
end

def feature_task_register
  rx_pods
  lottie_pods
  toast_pods
end

target 'FeatureTaskRegister' do
  project 'Modules/FeatureTaskRegister/FeatureTaskRegister.xcodeproj'
  feature_task_register
end

target 'Service-Desk-Ios-App' do
  project 'Service-Desk-Ios-App.xcodeproj'

  use_frameworks!
  
  feature_task_register
  
  # Pods for Service-Desk-Ios-App

end
