package Bio::Medpost;

our $VERSION = '0.01';

use strict;
use File::Temp qw/ :POSIX /;
use Exporter::Lite;
our @EXPORT = qw(medpost);

use Bio::Medpost::Var;


sub medpost {
  my $sentence = shift;
  $sentence=<<SENTENCE;
.I65536
.Tfoobar
.A$sentence
.E
SENTENCE
  
  my ($fh, $file) = tmpnam();
  
  print {$fh} $sentence;
  close $fh;
  chdir $Bio::Medpost::Var::medpost_path;
  my $r = [
	   map{/(.+)_(.+)/; [$1, $2]}
	   split / /, `$Bio::Medpost::Var::medpost_script $file`
	  ];
  unlink $file;
  return $r;
}


1;

__END__

=head1 NAME

Bio::Medpost - Part of speech tagger for MEDLINE text

=head1 USAGE

    use Bio::Medpost;

    $r = medpost('We observed an increase in mitogen-activated protein kinase (MAPK) activity.');

    use Data::Dumper;

    print Dumper $r;

If you need to change the script path of B<medpost>, please refer to L<Bio::Medpost::Var>.

=head1 SEE ALSO 

http://bioinformatics.oupjournals.org/cgi/content/abstract/20/14/2320

=head1 THE AUTHOR

Yung-chung Lin (a.k.a. xern) E<lt>xern@cpan.orgE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself

=cut
