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
    s.source_files  = "TPFBasicSDK/TPFBasicSDK/**/*.{h,m}"
    s.requires_arc = true
  
  end