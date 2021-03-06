

Pod::Spec.new do |s|

  s.name         = "ColorfulWoodUIUser"
  s.version      = "1.0.16"
  s.summary      = "User Interface Design."

  s.homepage     = "https://github.com/gs01md"

  s.license      = "MIT"

  s.author       = { "ColorfulWood" => "103377808@qq.com" }

  s.source       = { :git => "https://github.com/gs01md/ColorfulWoodUIUser.git", :tag => "#{s.version}" }

  s.source_files = "ColorfulWoodUIUser/ColorfulWoodUIUser/**/*"

  s.platform     = :ios, "8.0"

  s.frameworks   = 'UIKit'
#s.libraries    = 'sqlite3','c++','icucore'

  s.dependency    'Masonry'
  s.dependency    'ColorfulWoodUIBase'

#s.dependency    'ColorfulWoodTools'

#s.dependency    'IQKeyboardManager'
#s.dependency    'JSONModel'
#s.dependency    'SDWebImage'

#s.ios.vendored_libraries = 'ColorfulWoodUIUser/ColorfulWoodUIUser/MyFrameworks/*.a'
#s.ios.vendored_frameworks = 'ColorfulWoodUIUser/ColorfulWoodUIUser/MyFrameworks/*.framework'





end
