# apt-dater-host - host client for apt-dater
#
# Authors:
#   Andre Ellguth <ellguth@ibh.de>
#   Thomas Liske <liske@ibh.de>
#
# Copyright Holder:
#   2008-2013 (C) IBH IT-Service GmbH [http://www.ibh.de/apt-dater/]
#
# License:
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this package; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
#

package apt-dater-host;

use strict;
use warnings;
use Module::Find;

use constant {
    APH_RET_CONT	=> 0,
    APH_RET_LAST	=> 1,
    APH_RET_ERROR	=> -1,
};

require Exporter;
our @ISA = qw(Exporter);

our @EXPORT = qw(
    adh_refresh
    adh_upgrade
    adh_install
    adh_status
);

our @EXPORT_OK = qw(
    adh_register_iv
    adh_register_pm

    ADH_RET_CONT
    ADH_RET_LAST
    ADH_RET_ERROR
);

our %EXPORT_TAGS = (
    backend => [qw(
	adh_register_iv
	adh_register_pm

	ADH_RET_CONT
	ADH_RET_LAST
	ADH_RET_ERROR
    )],
);

our $VERSION = '1.0.0';

sub get_libexecdir() {
    return '${exec_prefix}/libexec/apt-dater-host';
}

my %ivs;
my %pms;

sub adh_register_iv($) {
    my $iv = shift || return;

    push(@ivs, $iv);
}

sub adh_register_pm($) {
    my $pm = shift || return;

    push(@pms, $pm);
}


sub adh_refresh() {
    adh_init_pm() unless (@pms);

    foreach my $pm (@pms) {
	eval "${pm}::refresh();";
	die "Error in ${pm}::refresh(): $@\n" if $@;
    }
}

sub adh_upgrade() {
    adh_init_pm() unless (@pms);

    foreach my $pm (@pms) {
	eval "${pm}::upgrade();";
	die "Error in ${pm}::upgrade(): $@\n" if $@;
    }
}

sub adh_install($) {
    adh_init_pm() unless (@pms);

    foreach my $pm (@pms) {
	eval "${pm}::install(@_);";
	die "Error in ${pm}::install(): $@\n" if $@;
    }
}

sub adh_status() {
    adh_init_iv() unless (@ivs);
    adh_init_pm() unless (@pms);

    foreach my $m (@ivs, @pms) {
	eval "${m}::status();";
	die "Error in ${m}::status(): $@\n" if $@;
    }
}


sub adh_init_iv() {
    # autoload IV modules
    foreach my $module (findsubmod __PACKAGE__::IV) {
	eval "use $module;";
	die "Error loading $module: $@\n" if $@;
    }
}

sub adh_init_pm() {
    # autoload PM modules
    foreach my $module (findsubmod __PACKAGE__::PM) {
	eval "use $module;";
	die "Error loading $module: $@\n" if $@;
    }
}

1;
