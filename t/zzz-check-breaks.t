use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::CheckBreaks 0.009

use Test::More;

SKIP: {
    eval 'require Moose::Conflicts; Moose::Conflicts->check_conflicts';
    skip('no Moose::Conflicts module found', 1) if not $INC{'Moose/Conflicts.pm'};

    diag $@ if $@;
    pass 'conflicts checked via Moose::Conflicts';
}

my $breaks = {
  "MooseX::Storage" => "<= 0.46"
};

use CPAN::Meta::Requirements;
my $reqs = CPAN::Meta::Requirements->new;
$reqs->add_string_requirement($_, $breaks->{$_}) foreach keys %$breaks;

use CPAN::Meta::Check 0.007 'check_requirements';
our $result = check_requirements($reqs, 'conflicts');

if (my @breaks = grep { defined $result->{$_} } keys %$result)
{
    diag 'Breakages found with MooseX-Role-Parameterized:';
    diag "$result->{$_}" for sort @breaks;
    diag "\n", 'You should now update these modules!';
}


done_testing;
