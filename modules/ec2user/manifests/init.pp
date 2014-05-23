## \file    modules/ec2-user/manifests/init.pp
#  \author  Scott Wales <scott.wales@unimelb.edu.au>
#  \brief
#
#  Copyright 2013 Scott Wales
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

class ec2user {
  $ec2key_array = split($::ec2_public_keys_0_openssh_key,' ')
  $ec2key = $ec2key_array[1]

  # Create a default user
  user {'ec2-user':
    ensure     => present,
    managehome => true,
    home       => '/home/ec2-user',
  } ->
  file {'/home/ec2-user/.ssh':
    ensure => directory,
  } ->
  ssh_authorized_key {'ec2 public key':
    ensure => present,
    key    => $ec2key,
    user   => 'ec2-user',
  }

  sudo::conf {'ec2-user':
    content => "ec2-user ALL=(ALL) NOPASSWD: ALL\n",
    require => User['ec2-user'],
  }
}
