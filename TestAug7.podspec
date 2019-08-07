Pod::Spec.new do |spec|

  spec.name         = "TestAug7"
  spec.version      = "0.0.1"
  spec.summary      = "A library written in swift"

  spec.description  = "We are creating the new app for handling the whole app networking process"

  spec.homepage     = "https://github.com/Ansh-Singh/ABC"

  spec.license      = "License"


  spec.author             = { "Ansh-Singh" => "meeelan9@gmail.co.in"}

 spec.ios.deployment_target = "10.0"
 spec.swift_version = "4.0"
  
  spec.source       = { :git => "https://github.com/Ansh-Singh/ABC.git", :tag => "#{spec.version}"}


  spec.source_files  =  "TestAug7/**/*.{h,m,swift}"

spec.dependency "MBProgressHUD"
spec.dependency "IQKeyboardManagerSwift"
spec.dependency "DropDown"
spec.dependency "CountryPickerSwift"
spec.dependency "GooglePlacesSearchController"
spec.dependency "Alamofire"

end