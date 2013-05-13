name             "chef-teamcity-install"
maintainer       "Mathieu Levesque-Lavallee"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures TeamCity"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"
depends 'java'
depends 'apt'
depends 'user'