use inc::Module::Install;

RTx         'RT-Extension-Gravatar';
all_from    'lib/RT/Extension/Gravatar.pm';
readme_from 'lib/RT/Extension/Gravatar.pm';

requires 'Crypt::SSLeay';

no_index( 'package' => 'RT::User' );

WriteAll;
