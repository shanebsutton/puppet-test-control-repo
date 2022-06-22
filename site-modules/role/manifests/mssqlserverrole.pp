class role::mssqlserverrole {

  #This role would be made of all the profiles that need to be included to make a database server work
  #All roles should include the base profile
  include profile::base
  include chocolatey

  package { 'notepadplusplus':
    ensure   => '8.4.2',
    provider => 'chocolatey',
  }
}
