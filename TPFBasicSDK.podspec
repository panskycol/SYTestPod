Pod::Spec.new do |s|

    s.name         = "TPFBasicSDK"
    s.version      = "1.0.0"
    s.summary      = "TPFBasicSDK."
    s.description  = <<-DESC
                      this is TPFBasicSDK
                     DESC
    s.homepage     = "https://github.com/panskycol/TPFBasicSDK"
    s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
    s.author             = { "王传海" => "wangchuanhai@360.cn" }
    s.platform     = :ios, "10.0"
    s.source       = { :git => "https://github.com/panskycol/TPFBasicSDK.git", :tag => s.version }
    s.source_files  = "TPFBasicSDK/**/*"
    s.requires_arc = true

     ## 构建的模块类型
    s.vendored_frameworks = "TPFBasicSDKUpload/TPFBasicSDK.framework"
    s.resources = "TPFBasicSDKUpload/TPFBasicSDKBundle.bundle"

  end