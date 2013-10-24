package RT::Extension::Gravatar;

use 5.008003;
use strict;
use warnings;

our $VERSION = '0.03';

require RT::User;
package RT::User;

use Digest::MD5 qw(md5_hex);
use LWP::UserAgent;

sub GravatarUrl {
    my $self = shift;

    my $email = $self->EmailAddress || '';
    return unless length $email;
    
    my $url = ($ENV{'HTTPS'}||'') eq 'on'
        ? 'https://secure.gravatar.com/avatar/'
        : 'http://gravatar.com/avatar/';
    
    return $url . md5_hex(lc $email);
}

sub HasGravatar {
    my $self = shift;

    my $url = $self->GravatarUrl;
    return 0 unless $url;

    $url .= "?d=404";

    my $ua = LWP::UserAgent->new;
    my $response = $ua->get($url);
    
    return $response->is_success;
}

=head1 NAME

RT::Extension::Gravatar - Adds gravatar images to rt

=head1 DESCRIPTION

This Plugin adds an gravatar image to the following places:

=over

=item More about the requestors widget

=item Modify user page

=item About me (Preferences)

=item User Summary

=back

=head1 INSTALLATION

=over

=item perl Makefile.PL

=item make

=item make install

=item Edit your /opt/rt4/etc/RT_SiteConfig.pm

Add this line:

    Set(@Plugins, qw(RT::Extension::Gravatar));

or add C<RT::Extension::Gravatar> to your existing C<@Plugins> line.

=item Clear your mason cache

    rm -rf /opt/rt4/var/mason_data/obj/*

=item Restart your webserver

=back

=head1 METHODS ADDED TO OTHER CLASSES

=head2 RT::User

=head3 GravatarUrl

Return the gravatar image url of the user.

=head3 HasGravatar

Return true if the user has an gravatar image.

=head1 AUTHOR

Christian Loos <cloos@netsandbox.de>

=head1 LICENCE AND COPYRIGHT
 
Copyright (C) 2010-2013, Christian Loos.
 
This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<http://bestpractical.com/rt/>

L<http://gravatar.com/>

=cut

1;
