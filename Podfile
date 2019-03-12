
def sharedpods
  pod 'Alamofire'
  pod 'IGListKit', '~> 3.0'
  pod 'lottie-ios'
  pod 'Moya', '~> 12.0'
  pod 'Moya/RxSwift', '~> 12.0'
  pod 'ObjectMapper'
	pod 'RxCocoa'
  pod 'RxOptional'
	pod 'RxSwift'
  pod 'Shallows', '~> 0.9.0'
  pod 'SwiftLint'
  pod 'SwiftyJSON'
  pod 'Then'
  pod 'UIImageViewAlignedSwift'
  pod 'R.swift'

  # Animation
  pod 'pop', '~> 1.0'
  pod 'SnapKit'
  pod 'GoogleMaps'

end


target 'SocialBoard' do
  use_frameworks!
	platform :ios, '10.0'
	
	sharedpods

#Unit Test Target
  target 'SocialBoardTests' do
    use_frameworks!
    inherit! :search_paths
	sharedpods
    pod 'Quick'
    pod 'Nimble'
  end

#UI Test Target
  target 'SocialBoardUITests' do
    use_frameworks!
    inherit! :search_paths
	sharedpods
  end

end


