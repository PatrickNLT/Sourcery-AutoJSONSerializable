# coding: utf-8

Pod::Spec.new do |s|
  s.name     = 'Sourcery-AutoJSONSerializable'
  s.version  = '0.3.0'
  s.license  = 'MIT'
  s.summary  = '…'
  s.homepage = 'https://github.com/Liquidsoul/Sourcery-AutoJSONSerializable'
  s.author   = { 'Sébastien Duperron' => '@liquidseb' }
  s.source   = { :git => 'https://github.com/Liquidsoul/Sourcery-AutoJSONSerializable.git', :tag => s.version }

  s.description = '…' \
                  '…'

  s.ios.deployment_target = '8.0'

  s.preserve_paths = 'Templates'
  s.source_files = 'Sources/AutoJSONSerialization/JSONSerializable.swift', 'Sources/AutoJSONSerialization/JSONDeserializable.swift'

  s.subspec 'Date' do |date|
    date.ios.deployment_target = '10.0'
    date.osx.deployment_target = '10.12'
    date.source_files = 'Sources/AutoJSONSerialization/Date+JSONSerialization.swift'
  end
end
