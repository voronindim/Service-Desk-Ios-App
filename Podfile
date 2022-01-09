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

def kingfisher_pods
  pod 'Kingfisher', '~> 7.0'
end

def feature_task_register
  rx_pods
  lottie_pods
  toast_pods
  kingfisher_pods
end

def feature_employees_register
  rx_pods
  lottie_pods
  toast_pods
  kingfisher_pods
end

def feature_login
  rx_pods
  lottie_pods
  toast_pods
end

target 'Networking' do
  project 'Modules/Networking/Networking.xcodeproj'
end

target 'FeatureLogin' do
  project 'Modules/FeatureLogin/FeatureLogin.xcodeproj'
  feature_login
end

target 'FeatureTaskRegister' do
  project 'Modules/FeatureTaskRegister/FeatureTaskRegister.xcodeproj'
  feature_task_register
end

target 'FeatureEmployeesRegister' do
  project 'Modules/FeatureEmployeesRegister/FeatureEmployeesRegister.xcodeproj'
  feature_employees_register
end

target 'Service-Desk-Ios-App' do
  project 'Service-Desk-Ios-App.xcodeproj'

  use_frameworks!
  
  rx_pods
  lottie_pods
  toast_pods
  kingfisher_pods
end
