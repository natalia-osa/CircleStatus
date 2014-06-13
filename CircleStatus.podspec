Pod::Spec.new do |spec|
  spec.name         = "CircleStatus"
  spec.version      = "1.1"
  spec.summary      = "View showing circular chart with legend. There is customisable number and range of colours on outer ring with background transparency/colours configuration, legend off/on, legend location setup."
  spec.homepage     = "http://appunite.com/"
  spec.license      = 'Apache 2.0'
  spec.author       = { "natalia.osiecka" => "natalia.osa@appunite.com" }
  spec.source       = { :git => 'https://github.com/natalia-osa/CircleStatus.git', :tag => '1.1'}

  spec.requires_arc = true
  spec.ios.deployment_target = '5.0'
  spec.source_files = 'CircleStatus/CircleStatus/*.{h,m}'

  spec.frameworks   = ['Foundation', 'UIKit', 'CoreGraphics']
end
