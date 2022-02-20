Pod::Spec.new do |spec|

  spec.name         = "LayoutBuilder"
  spec.version      = "0.9.5"
  spec.summary      = "LayoutBuilder is an operator-based DSL layout relationship builder"

  spec.description  = <<-DESC
LayoutBuilder is an operator-based DSL layout relationship builder. It allows you to create constraints programmatically simpler and more elegant than ever. 
And it is very flexible.
                   DESC

  spec.homepage     = "https://github.com/multimediasuite/LayoutBuilder"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }


 
  spec.author             = { "Ihor Malovanyi" => "mail@ihor.pro" }
  
  spec.ios.deployment_target = "10.0"
  spec.swift_version = "5.5"
  spec.osx.deployment_target = "10.15"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"


  spec.source       = { :git => "https://github.com/multimediasuite/LayoutBuilder.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/LayoutBuilder/**/*"

end
