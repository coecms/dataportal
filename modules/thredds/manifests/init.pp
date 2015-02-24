## \file    init.pp
#  \author  Scott Wales <scott.wales@unimelb.edu.au>
#
#  Copyright 2015 ARC Centre of Excellence for Climate Systems Science
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

class thredds {
  $catalina_base = '/var/lib/tomcat6'
  $webapps       = "${catalina_base}/webapps"

  $source = 'ftp://ftp.unidata.ucar.edu/pub/thredds/4.3/current/thredds.war'

  exec {'wget thredds.war':
    command => "wget ${source} -O ${webapps}/thredds.war",
    path    => ['/usr/bin','/bin'],
    creates => "${webapps}/thredds.war",
    require => Package['tomcat'],
    notify  => Service['tomcat'],
  }

  file {"${webapps}/thredds.war":
    require => Exec['wget thredds.war'],
  }

  file {'/var/thredds':
    ensure => directory,
    owner  => 'tomcat',
    group  => 'tomcat',
  }

  $content_dir = '/var/thredds'
  file {[$content_dir,"${content_dir}/thredds"]:
    ensure => directory,
    owner  => 'tomcat',
    group  => 'tomcat',
  }

  file {"${content_dir}/thredds/threddsConfig.xml":
    ensure => file,
    source => 'puppet:///modules/thredds/threddsConfig.xml',
  }
  file {"${content_dir}/thredds/catalog.xml":
    ensure => file,
    source => 'puppet:///modules/thredds/catalog.xml',
  }
}
