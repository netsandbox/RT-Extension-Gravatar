use inc::Module::Install;

RTx 'RT-Extension-Gravatar';

repository 'https://github.com/cloos/RT-Extension-Gravatar';

requires 'Crypt::SSLeay';
requires 'Digest::MD5';
requires 'LWP::UserAgent';

requires_rt '4.0.0';
rt_too_new '4.4.0';

no_index( 'package' => 'RT::User' );

sign;
WriteAll;
