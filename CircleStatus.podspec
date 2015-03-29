Pod::Spec.new do |spec|
  spec.name         = "CircleStatus"
  spec.version      = "1.2.0"
  spec.summary      = "Ring shaped chart with legend option."
  spec.homepage     = "https://github.com/natalia-osa/"
  spec.license      = 'Apache 2.0'
  spec.author       = { "natalia.osiecka" => "osiecka.n@gmail.com" }
  spec.source       = { :git => 'https://github.com/natalia-osa/CircleStatus.git', :tag => '1.2.0'}

  spec.requires_arc = true
  spec.ios.deployment_target = '5.1.1'
  spec.source_files = 'CircleStatus/CircleStatus/*.{h,m}'

  spec.frameworks   = ['Foundation', 'UIKit', 'CoreGraphics']

  spec.subspec 'Core' do |cs|
      cs.dependency 'NOCategories'
  end
end
