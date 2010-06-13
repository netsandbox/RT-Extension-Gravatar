use inc::Module::Install;

RTx         'RT-Extension-Gravatar';
all_from    'lib/RT/Extension/Gravatar.pm';
readme_from 'lib/RT/Extension/Gravatar.pm';

no_index( 'package' => 'RT::User' );

WriteAll;
