## \file    modules/roles/manifests/common.pp
#  \author  Scott Wales <scott.wales@unimelb.edu.au>
#
#  Copyright 2014 ARC Centre of Excellence for Climate Systems Science
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

# Common stuff for all servers
class roles::common {

  # Setup hostname
  host {$::fqdn:
    ip           => $::ec2_public_ipv4,
    host_aliases => $::hostname,
  }

  # Set up admin users
  $admins = hiera_hash('admins',{})
  create_resources('roles::admin',$admins)
}
