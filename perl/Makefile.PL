use ExtUtils::MakeMaker;

WriteMakefile(
    'AUTHOR'		=> 'Thomas Liske <liske@ibh.de>',
    'LICENSE'		=> 'gpl',
    'NAME'		=> 'apt-dater-host',
    'VERSION_FROM'	=> 'lib/apt-dater-host.pm',
    'PREREQ_PM'		=> {
	Module::Find => 0,
    },
);
