Pod::Spec.new do |spec|
  spec.name         = "CircleStatus"
  spec.version      = "1.1.1"
  spec.summary      = "Ring shaped chart with legend option."
  spec.homepage     = "http://appunite.com/"
  spec.license      = 'Apache 2.0'
  spec.author       = { "natalia.osiecka" => "natalia.osa@appunite.com" }
  spec.source       = { :git => 'https://github.com/natalia-osa/CircleStatus.git', :tag => '1.1.1'}

  spec.requires_arc = true
  spec.ios.deployment_target = '5.0'
  spec.source_files = 'CircleStatus/CircleStatus/*.{h,m}'

  spec.frameworks   = ['Foundation', 'UIKit', 'CoreGraphics']
end
