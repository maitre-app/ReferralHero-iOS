

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "ReferralHero-iOS"
  spec.version      = "1.0.0"
  spec.summary      = "The ReferralHero SDK is a powerful tool for integrating referral functionality into your application."

  spec.description  = "It provides a seamless way for users to refer friends, track referrals, and incentivize user engagement. This repository contains all the necessary code and documentation to help you get started with integrating the ReferralHero SDK into your swift project."
  spec.homepage     = "https://github.com/maitre-app/ReferralHero-iOS"


  # spec.license      = "MIT"
  spec.author             = { "Lamar Duffy" => "lamar@referralhero.com" }
  spec.platform     = :ios, "13.0"

  spec.source       = { :git => "https://github.com/maitre-app/ReferralHero-iOS.git", :tag => spec.version.to_s }

  spec.source_files  = "ReferralHero/**/*.{h,m,swift}"
  spec.swift_versions = "5.0"

end
