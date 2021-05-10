Pod::Spec.new do |spec|

  spec.name         = "LayoutBuilder"
  spec.version      = "0.9.0"
  spec.summary      = "LayoutBuilder is an operator-based DSL layout relationship builder"

  spec.description  = <<-DESC
LayoutBuilder is an operator-based DSL layout relationship builder. It allows you to create constraints programmatically simpler and more elegant than ever. 
And it is very flexible.
                   DESC

  spec.homepage     = "https://github.com/multimediasuite/LayoutBuilder"
  spec.license      = { :type => "MIT", :file => "LICENSE" }


 
  spec.author             = { "Ihor Malovanyi" => "mail@ihor.pro" }
  
  spec.ios.deployment_target = "9.0"
  spec.swift_version = "5.4"
  spec.osx.deployment_target = "10.10"
  #spec.watchos.deployment_target = "2.0"
  #spec.tvos.deployment_target = "9.0"


  spec.source       = { :git => "https://github.com/multimediasuite/LayoutBuilder.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/LayoutBuilder/**/*.{h,m,swift}"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
