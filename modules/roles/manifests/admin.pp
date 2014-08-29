## \file    modules/roles/manifests/admin.pp
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

# Admin user
define roles::admin (
  $home   = "/home/${name}",
  $pubkey = undef,
) {

  user {$name:
    home       => $home,
    managehome => true,
  }

  if $pubkey {
    # Split up the pubkey for use by Puppet
    $components = split($pubkey, ' ')

    $type    = $components[0]
    $key     = $components[1]
    $comment = regsubst($pubkey,'^\S+\s+\S+\s+(.*)$','\1')

    ssh_authorized_key{"${name} ${comment}":
      key  => $key,
      type => $type,
      user => $name,
    }
  }

}
