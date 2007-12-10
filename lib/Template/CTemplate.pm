package Template::CTemplate;

#use 5.008008;
use strict;
use warnings;

require Exporter;

our $VERSION = '0.01_01';

require XSLoader;
XSLoader::load('Template::CTemplate', $VERSION);

1;
__END__

=head1 NAME

Template::CTemplate - Perl bindings for Google CTemplate

=head1 SYNOPSIS

  use Template::CTemplate;
  
  my $tpl = Template::CTemplate::Template->new(
    'blog.tpl', Template::CTemplate::DO_NOT_STRIP
  );

  my $dict = Template::CTemplate::Dictionary->new('ENTRIES');

  $dict->show_section("FOO");
  $dict->set_value("TITLE", "Templating for the masses");

  my $output = $tpl->expand($dict);

=head1 NOTE

This library is at a very early stage, and is of B<EXTREME> alpha quality.

=head1 DESCRIPTION

This is currently a very basic set of bindings to google's ctemplate
libraries. Please see L<http://code.google.com/p/google-ctemplate/> for
more details.

Most of the implementation is exercised by the unit tests. Please see
those for more implementation details and examples.

=head1 TODO

  * Documentation
  * Examples
  * More Perl/XS based wrappings, ::Simple like

=head1 AUTHOR

Scott McWhirter, E<lt>cpan@konobi.co.ukE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Scott McWhirter

This library is available under the terms of the BSD license.

Please see the enclosed LICENSE file for details.

=cut

