#
# Be sure to run `pod lib lint KPCalendar.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KPCalendar"
  s.version          = "0.1.0"
  s.summary          = "A short description of KPCalendar."
  s.description      = <<-DESC
                       This is a description of KPCalendar

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/kunal08pandey/KPCalendar"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "kunalpandey2014" => "kunal.pandey@fareportal.com" }
  s.source           = { :git => "https://github.com/kunal08pandey/KPCalendar.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'KPCalendar' => ['Pod/Assets/*.png']
  }
  s.resources = 'Pod/Classes/**/*.xib'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
s.dependency 'NSDate-Extensions'
end
