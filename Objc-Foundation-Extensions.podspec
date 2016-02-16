Pod::Spec.new do |s|
  s.name             = "Objc-Foundation-Extensions"
  s.version          = "0.1.0"
  s.summary          = "A few helpful extensions to some Foundation classes."

  s.homepage         = "https://github.com/ThePantsThief/Objc-Foundation-Extensions"
  s.license          = 'MIT'
  s.author           = { "ThePantsThief" => "tannerbennett@me.com" }
  s.source           = { :git => "https://github.com/ThePantsThief/Objc-Foundation-Extensions.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.1'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
end
