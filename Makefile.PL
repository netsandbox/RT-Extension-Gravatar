use inc::Module::Install;

RTx         'RT-Extension-Gravatar';
all_from    'lib/RT/Extension/Gravatar.pm';
readme_from;

repository 'https://github.com/cloos/RT-Extension-Gravatar';

requires 'Crypt::SSLeay';
requires 'Digest::MD5';
requires 'LWP::UserAgent';

no_index( 'package' => 'RT::User' );

sign;
WriteAll;
