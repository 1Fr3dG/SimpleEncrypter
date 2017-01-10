Pod::Spec.new do |s|
  s.name             = 'SimpleEncrypter'
  s.version          = '1.1.2'
  s.summary          = 'A simple protocol for Data->Data encrypt.'

  s.description      = <<-DESC
This is designed for my apps, so that I can easily change real encrypter.
                       DESC

  s.homepage         = 'https://github.com/1fr3dg/SimpleEncrypter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alfred Gao' => 'alfredg@alfredg.cn' }
  s.source           = { :git => 'https://github.com/1fr3dg/SimpleEncrypter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'

  s.source_files = 'Sources/*'
  
  s.dependency 'CryptoSwift'
  s.dependency 'SwiftCompressor'
  s.dependency 'GzipSwift'
end
