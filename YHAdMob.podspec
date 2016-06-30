#https://github.com/MaiyaT/YHAdMob.git


Pod::Spec.new do |s|

    s.name             = 'YHAdMob'
    s.version          = '1.0.0'
    s.summary          = 'GitHub MaiyaT - YHAdMob.'

    s.description      = <<-DESC
    YHAdMob url is https://github.com/MaiyaT/YHAdMob.git.
    DESC

    s.homepage         = 'https://github.com/MaiyaT/YHAdMob'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '林宁宁' => '763465697@qq.com' }
    s.source           = { :git => 'https://github.com/MaiyaT/YHAdMob.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'
    s.platform     = :ios, '7.0'

    s.source_files = 'YHAdMob/Classes/**/*.{h,m}'
    s.vendored_frameworks = 'YHAdMob/lib/*.framework'
    s.preserve_paths = 'YHAdMob/lib/*'

#s.module_map = 'YHAdMob/lib/GoogleMobileAds.framework/**/module.modulemap'

    s.vendored_libraries = 'YHAdMob/lib/*.a'
    s.resource_bundles = {
        'YHAdMob' => ['YHAdMob/Assets/*.{png,bundle}']
    }


    # s.frameworks = 'UIKit', 'MapKit'

    s.requires_arc = true

    s.public_header_files = 'GoogleMobileAds/GoogleMobileAds.h'

    s.xcconfig = {'OTHER_LDFLAGS' => '-ObjC -lstdc++','CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => "true",'ENABLE_BITCODE' => "false"}
#,'LIBRARY_SEARCH_PATHS' => "$(PODS_ROOT)/YHAdMob/YHAdMob/lib"

    s.frameworks = 'UIKit','MapKit','AdSupport','CoreLocation','QuartzCore','SystemConfiguration','CoreTelephony','Security','StoreKit','CoreGraphics','ImageIO','CoreLocation','MobileCoreServices','CFNetwork','CoreText','Foundation'


    s.libraries = 'z','stdc++','sqlite3','iconv','z.1.2.5','icucore','z.1'

    s.dependency 'YHBase'


end
