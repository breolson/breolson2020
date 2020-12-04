Pod::Spec.new do |s|
  s.name             = 'breolson2020'
  s.version          = '0.1.0'
  s.swift_version    = '5.0'
  s.summary          = 'A short description'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/breolson/breolson2020'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'breolson' => 'breolson@student.21-school.ru' }
  s.source           = { :git => 'https://github.com/breolson/breolson2020.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'breolson2020/Classes/*.swift'
  s.resources = 'breolson2020/Classes/*.xcdatamodeld'
  
  # s.resource_bundles = {
  #   'breolson' => ['breolson/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit', 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end

