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

package apt-dater-host::IV::Generic;

use strict;
use warnings;

use apt-dater-host qw(:backend);

sub status() {
    return ADH_RET_CONT;
}

1;
