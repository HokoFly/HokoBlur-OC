Pod::Spec.new do |s|
  s.name             = 'HokoBlur-OC'
  s.version          = '0.0.1'
  s.summary          = 'A HokoBlur implementation fully written in Objective-C'

  s.homepage         = 'https://github.com/HokoFly/HokoBlur-OC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HokoFly' => 'yuxfzju@gmail.com' }
  s.source           = { :git => 'https://github.com/HokoFly/HokoBlur-OC.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'HokoBlur-OC/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HokoBlur-OC' => ['HokoBlur-OC/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
