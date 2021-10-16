Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '11.0'
  s.name             = 'IPager'
  s.summary          = 'iPager is a flexible simple pager for iOS'
  s.description      = 'iPager is a flexible simple pager for iOS'

  s.version          = '1.0.0'

  s.homepage         = 'https://github.com/YousefAnsary/iPager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Youssef El-Ansary' => 'yousef.ansary@gmail.com' }
  s.source           = { :git => 'https://github.com/YousefAnsary/iPager.git', :tag => "#{s.version}" }
  s.social_media_url = 'https://www.linkedin.com/in/yousefansary/'

  s.framework = "UIKit"
  
  s.source_files = "Sources/IPager/*.{swift}"
  
  s.swift_version = "4.0"

end
