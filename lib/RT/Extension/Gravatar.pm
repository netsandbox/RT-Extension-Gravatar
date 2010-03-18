package RT::Extension::Gravatar;

use 5.008;
use strict;
use warnings;

our $VERSION = '0.01';

require RT::User;
package RT::User;

use Digest::MD5 qw(md5_hex);
use LWP::UserAgent;

sub GravatarUrl {
    my $self = shift;
    my $email = $self->EmailAddress;
    return undef unless defined $email && length $email;
    
    my $gravatar_base_url;
    if ( defined $ENV{HTTPS} and $ENV{'HTTPS'} eq 'on' ) {
        $gravatar_base_url = 'https://secure.gravatar.com/avatar/';
    } else {
        $gravatar_base_url = 'http://gravatar.com/avatar/';
    }
    
    return $gravatar_base_url . md5_hex( lc $email );
}

sub HasGravatar {
    my $self = shift;
    my $ua = LWP::UserAgent->new;
    my $url = $self->GravatarUrl();
    $url .= "?default=404";
    my $response = $ua->get( $url );
    
    return ! $response->is_error( 404 );
}

1;

__END__

=head1 NAME

RT::Extension::Gravatar - Adds gravatar images to rt

=head1 SYNOPSIS

This Plugin adds an gravatar image to the following pages:

	- more about ...
	- modify user
	- preferences => about me

=head1 FUNCTIONS

=over 2

=item GravatarUrl

Return the gravatar image url of the user

=item HasGravatar

Return true if the user has an gravatar image

=back

=head1 INSTALLATION

Installation Instructions for RT-Extension-Gravatar:

	1. perl Makefile.PL
	2. make
	3. make install
	4. Add 'RT::Extension::Gravatar' to @Plugins in /opt/rt3/etc/RT_SiteConfig.pm
	5. Clear mason cache: rm -rf /opt/rt3/var/mason_data/obj
	6. Restart webserver

=head1 AUTHOR

Christian Loos <chr.loos@googlemail.com>

=head1 COPYRIGHT AND LICENCE
 
Copyright (C) 2010, Christian Loos.
 
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<http://bestpractical.com/rt/>

L<http://gravatar.com/>

=cut
