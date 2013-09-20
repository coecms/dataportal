node default {

    class {'apache':
        default_mods => false,
    }

    class {'java':}

    package {["git", "subversion", "unzip"]:}
    file {["/var/git","/var/svn"]:
        ensure => directory,
    }
    
    vcsrepo { "/var/git/test":
        ensure => bare,
        provider => git,
        require => [Package["git"],File["/var/git"]],
    }

    vcsrepo { "/var/svn/test":
        ensure => present,
        provider => svn,
        require => [Package["subversion"],File["/var/svn"]],
    }

    subgit { "/var/git/sub":
        svn_url => "file:///var/svn/test",
        require => Vcsrepo["/var/svn/test"],
    }
}
