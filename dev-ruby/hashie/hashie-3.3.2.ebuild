# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

USE_RUBY="ruby19 ruby20 ruby21"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="Hashie is a small collection of tools that make hashes more powerful"
HOMEPAGE="http://intridea.com/posts/hashie-the-hash-toolkit"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( dev-ruby/activesupport )"

all_ruby_prepare() {
	# Remove bundler and fix one spec that depends on its requires
	#rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die
	sed -e '/pry/ s:^:#:' -i spec/spec_helper.rb || die
}
