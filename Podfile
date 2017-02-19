# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

def shared_testing_pods 
  pod 'Nimble'
end

target 'TTPChallenge' do
  pod 'PromiseKit'
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'JSQMessagesViewController'
  pod 'PKHUD'
  
end

target 'UnitTests' do
  shared_testing_pods
end

target 'UITests' do
  shared_testing_pods
end
