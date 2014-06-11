Pod::Spec.new do |spec|
  spec.name         = "CircleStatus"
  spec.version      = "1.0"
  spec.summary      = "View showing circular chart with customisable number and range of colours on outer ring with background transparency/colours configuration."
  spec.homepage     = "http://appunite.com/"
  spec.license      = 'Apache 2.0'
  spec.author       = { "natalia.osiecka" => "natalia.osa@appunite.com" }
  spec.source       = { :git => 'https://github.com/natalia-osa/CircleStatus.git', :tag => '1.0'}

  spec.requires_arc = true
  spec.ios.deployment_target = '5.0'
  spec.source_files = 'CircleStatus/CSView.{h,m}'

  spec.frameworks   = ['Foundation', 'UIKit', 'CoreGraphics']
end
