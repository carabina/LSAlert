

Pod::Spec.new do |s|



  s.name         = "LSAlert"
  s.version      = "0.0.1"
  s.summary      = "A custom UIAlertView"
  s.description  = <<-DESC
                      基于swift3.0的自定义UIAlertView
                   DESC
  s.homepage     = "https://github.com/tianyc1019/LSAlert"
  s.platform     = ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.license      = "MIT"
  s.author       = { "John_LS" => "tianyc1019@icloud.com" }
  s.source       = { :git => "https://github.com/tianyc1019/LSAlert.git", :tag => "0.0.1" }
  s.source_files  =  "LSAlert/LSAlert/*.{swift}"
  
end
