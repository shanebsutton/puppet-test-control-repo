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

  package { 'notepadplusplus':
    ensure   => '8.4.2',
    provider => 'chocolatey',
    source   => 'https://community.chocolatey.org/api/v2/',
  }

  #package { 'InstallSSMS':
  #  ensure          => 'Present',
  #  name            => 'SSMS-Setup-ENU_1812',
  #  source          => 'C:\\Temp\\SSMS-Setup-ENU_1812.exe',
  #  install_options => '/install /quiet /norestart',
  #  productid       => '990516C3-F457-4E25-B13E-B1599B2F4156',
  #}

  package { 'Microsoft SQL Server Management Studio - 18.12':
    ensure          => '15.0.18420.0',
    source          => 'C:\\Temp\\SSMS-Setup-ENU_1812.exe',
    #install_options => '/install /quiet /norestart',
    install_options => '/Quiet',
  }

  sqlserver_instance { 'TESTINSTANCE01':
    source                => 'C:\\Temp\\SQL2019',
    name                  => 'TESTINSTANCE01',
    features              => ['SQLEngine'],
    security_mode         => 'SQL',
    sa_pwd                => 'ReallyBadPassword12!',
    #sql_svc_account       => '',
    #sql_svc_password      => '',
    #agt_svc_account       => '',
    #agt_svc_password      => '',
    sql_sysadmin_accounts => 'ssutton_gcp',
    install_switches      => {
      'INSTALLSHAREDDIR'       => 'C:\\Program Files\\Microsoft SQL Server',
      'INSTALLSHAREDWOWDIR'    => 'C:\\Program Files (x86)\\Microsoft SQL Server',
      'INSTANCEDIR'            => 'C:\\Program Files\\Microsoft SQL Server',
      'SQLUSERDBDIR'           => 'D:/',
      'SQLUSERDBLOGDIR'        => 'L:/',
      'SQLTEMPDBDIR'           => 'T:/',
      'SQLTEMPDBLOGDIR'        => 'T:/',
      'SQLSVCSTARTUPTYPE'      => 'Automatic',
      'AGTSVCSTARTUPTYPE'      => 'Automatic',
      'BROWSERSVCSTARTUPTYPE'  => 'Automatic',
      'SQLCOLLATION'           => 'SQL_Latin1_General_CP1_CI_AS',
      'SQLTEMPDBFILECOUNT'     => 8,
      'SQLTEMPDBFILESIZE'      => 128,
      'SQLTEMPDBFILEGROWTH'    => 64,
      'SQLTEMPDBLOGFILESIZE'   => 128,
      'SQLTEMPDBLOGFILEGROWTH' => 64,
      'TCPENABLED'             => 1,
      'NPENABLED'              => 0,
      'SQMREPORTING'           => 0,
      'UPDATEENABLED'          => 1,
      'UPDATESOURCE'           => 'C:\\Temp\\Updates',
    },
  }

  sqlserver_features { 'Generic Features':
    source           => 'C:\\Temp\\SQL2019',
    features         => ['Conn','IS'],
    is_svc_account   => '',
    is_svc_password  => '',
    install_switches => {
      'ISSVCSTARTUPTYPE' => 'Manual',
    },
  }

  # CU1
  package { 'SQL Server 2019 RTM Cumulative Update (CU) 1 KB4527376':
    ensure          => installed,
    source          => 'C:\\Temp\\Updates\\sqlserver2019-kb4527376-x64_01dcaca398f0c3380264078463fc1a6cc859ec7c.exe',
    #install_options => '/install /quiet /norestart',
    install_options => ['/Quiet', '/Action=Patch', '/AllInstances', '/IAcceptSQLServerLicenseTerms'],
  }
}
