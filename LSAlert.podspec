

Pod::Spec.new do |s|

  

  s.name         = "LSAlert"
  s.version      = "1.0.0"
  s.summary      = "A custom UIAlertView."

  
  s.description  = <<-DESC 
  					这是一个自定义的UIAlertView，支持多按钮，无按钮，带图片的展示
                   DESC

  s.homepage     = "https://github.com/tianyc1019/LSAlert"
  

  s.license      = "MIT"
  

  s.author             = { "John_LS" => "tianyc1019@icloud.com" }
  

  # s.platform     = :ios
   s.platform     = :ios, "9.0"

 

  s.source       = { :git => "https://github.com/tianyc1019/LSAlert.git", :tag => "1.0.0" }


  

  s.source_files  = "LSAlert/**/*.{swift}"
  # s.exclude_files = "Classes/Exclude"

  

end
