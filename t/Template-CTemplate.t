# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Template-CTemplate.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 12;
use Template::CTemplate;
BEGIN { 
  use_ok('Template::CTemplate::Template');
  use_ok('Template::CTemplate::Dictionary');
};

Dictionary: {
  my $dict = Template::CTemplate::Dictionary->new('STOLEN');
  isa_ok $dict, q{Template::CTemplate::Dictionary};
  is $dict->name(), q{STOLEN}, q{Dictionary name returned correctly};
  $dict->set_value("WHOM", "Santa Claws");
  $dict->set_int_value("WHOM", 2);
  $dict->set_global_value("WHOM", "hehe");

  my $subdict = $dict->add_section_dictionary("BOB");
}

Template: {
  is &Template::CTemplate::DO_NOT_STRIP, 0, q{Template modifier correct};
  is &Template::CTemplate::STRIP_BLANK_LINES, 1, q{Template modifier correct};
  is &Template::CTemplate::STRIP_WHITESPACE, 2, q{Template modifier correct};

  my $tpl = Template::CTemplate::Template->new('demo.tpl', &Template::CTemplate::DO_NOT_STRIP);

  isa_ok $tpl, q{Template::CTemplate::Template};
  $tpl->set_template_root_directory("/tmp");
  is $tpl->template_root_directory(), q{/tmp/}, q{Template root directory};
  is $tpl->template_file(), q{./demo.tpl}, q{Template file name};
  $tpl->set_template_root_directory('.');
}

Blog_entries_example: {
  my $tpl = Template::CTemplate::Template->new('t/example.tpl', &Template::CTemplate::STRIP_BLANK_LINES);
  my $dict = Template::CTemplate::Dictionary->new('');
  $dict->show_section('NO_BLOG_ENTRIES');

  my $output = $tpl->expand($dict);
  is $output, "Welcome to todays blog entries:\n  Sorry, but there's no blog entries today!\n", q{no entries};

  my $dict2 = Template::CTemplate::Dictionary->new('');
  my $blog_entries = [
    { DATE => '2007-10-01', SUBJECT => 'SCO go down in flames', WHOM => 'Bob' },
    { DATE => '2007-10-02', SUBJECT => 'Gmail gets IMAP', WHOM => 'Charlie' },
  ];

  for my $entry (@$blog_entries){
    my $sec = $dict2->add_section_dictionary('BLOG_ENTRY');
    for my $k (keys %$entry){
      $sec->set_value($k, $entry->{$k});
    }
  }

  my $out = $tpl->expand($dict2);
  my $cmp = <<EOF;
Welcome to todays blog entries:
  Date: 2007-10-01
  Subject: SCO go down in flames
  Who: Bob
  Date: 2007-10-02
  Subject: Gmail gets IMAP
  Who: Charlie
EOF

  is $out, $cmp, q{list of entries};

}
