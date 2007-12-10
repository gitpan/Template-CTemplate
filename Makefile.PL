#!/usr/bin/perl

use strict;
use warnings;
#use 5.008008;
use ExtUtils::MakeMaker;

my $CC = 'g++';
my $LDFLAGS = [qw(
./ext/ctemplate-0.8/libctemplate_nothreads_la-arena.o
./ext/ctemplate-0.8/libctemplate_nothreads_la-template.o
./ext/ctemplate-0.8/libctemplate_nothreads_la-template_dictionary.o
./ext/ctemplate-0.8/libctemplate_nothreads_la-template_from_string.o
./ext/ctemplate-0.8/libctemplate_nothreads_la-template_modifiers.o
./ext/ctemplate-0.8/libctemplate_nothreads_la-template_namelist.o
./ext/ctemplate-0.8/libctemplate_nothreads_la-template_pathops.o
)];


use File::Spec;
use Cwd;

my $curdir = getcwd();
my $ctemplate_dir = File::Spec->catdir($curdir, 'ext', 'ctemplate-0.8');
chdir($ctemplate_dir);

(system("./configure") == 0) or die "Could not configure ctemplate libraries";
(system("make") == 0) or die "Could not make ctemplate libraries";

chdir($curdir);

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'              => 'Template::CTemplate',
    'VERSION_FROM'      => 'lib/Template/CTemplate.pm', # finds $VERSION
    'PREREQ_PM'         => {}, # e.g., Module::Name => 1.1
     ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Template/CTemplate.pm', # retrieve abstract from module
       AUTHOR         => 'Scott McWhirter <cpan@konobi.co.uk>') : ()),
   
   # 'LIBS'              => [map { s/^-L//g; $_ } @$LDFLAGS], # e.g., '-lm'
    'DEFINE'            => '', # e.g., '-DHAVE_SOMETHING'
    'CC'                => $CC,
    'LD'                => '$(CC) $(LDFLAGS)',
    LDFLAGS             => join(' ', @$LDFLAGS),
    'INC'               => "-I./ext/ctemplate-0.8/src/", # e.g., '-I/usr/include/other'
    # 'OBJECT'          => '$(O_FILES)', # link all the C files too
    'XSOPT'             => '-C++',
    'TYPEMAPS'          => ['perlobject.map'],
);
