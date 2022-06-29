class role::mssqlserverrole {

  #This role would be made of all the profiles that need to be included to make a database server work
  #All roles should include the base profile
  include profile::base
  include chocolatey

  dsc_psrepository { 'Trust public gallery':
    dsc_name               => 'PSGallery',
    dsc_ensure             => 'Present',
    dsc_installationpolicy => 'Trusted',
  }

  package { 'notepadplusplus':
    ensure   => '8.4.2',
    provider => 'chocolatey',
    source   => 'https://community.chocolatey.org/api/v2/',
  }
  
  dsc_psmodule { 'SqlServerPowerShell':
    dsc_name            => 'SqlServer',
    dsc_ensure          => 'Present',
    dsc_requiredversion => '21.1.18256',
  }
  
  dsc_psmodule { 'dbatools':
    dsc_name            => 'dbatools',
    dsc_ensure          => 'Present',
    dsc_requiredversion => '1.1.109',
  }
  
  #package { 'InstallSSMS':
  #  ensure          => 'Present',
  #  name            => 'SSMS-Setup-ENU_1812',
  #  source          => 'C:\\Temp\\SSMS-Setup-ENU_1812.exe',
  #  install_options => '/install /quiet /norestart',
  #  productid       => '990516C3-F457-4E25-B13E-B1599B2F4156',
  #}
  
  package { 'Microsoft SQL Server Management Studio - 18.12':
    ensure          => 'Present',
    source          => 'C:\\Temp\\SSMS-Setup-ENU_1812.exe',
    install_options => '/install /quiet /norestart',
  }
}
