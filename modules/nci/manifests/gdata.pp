## \file    modules/nci/manifests/mount.pp
#  \author  Scott Wales <scott.wales@unimelb.edu.au>
#  \brief
#
#  Copyright 2014 Scott Wales
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

# Mount a /g/data1 project
define nci::gdata (
  $gid = undef,
) {
  $mountpoint = "/g/data1/${title}"

  file {$mountpoint:
    ensure => directory,
  }

  group {$name:
    ensure => present,
    gid    => $gid,
  }

  mount {$mountpoint:
    ensure  => mounted,
    device  => "nnfs2.nci.org.au:/mnt/gdata1/${title}",
    fstype  => 'nfs',
    options => 'ro,nolock',
    require => [Package['nfs-utils'],File[$mountpoint]],
  }
}
