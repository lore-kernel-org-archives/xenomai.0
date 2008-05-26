MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18491.14108.445958.567163@domain.hid>
Date: Tue, 27 May 2008 00:18:04 +0200
In-Reply-To: <483B29A6.2000209@domain.hid>
References: <480A4AF3.9010502@domain.hid>
	<18489.35854.502315.832894@domain.hid>
	<4839907C.4000102@domain.hid>
	<18489.37401.679912.195018@domain.hid>
	<483AA731.8050404@domain.hid>
	<18491.4848.804078.354303@domain.hid>
	<483B29A6.2000209@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Debian package xenomai-2.4.3-4 available
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roland Stigge <stigge@domain.hid>
Cc: xenomai@xenomai.org

Roland Stigge wrote:
 > Hi,
 > 
 > Gilles Chanteperdrix wrote:
 > > Shipping the xenomai tarball with the debian directory has a real added
 > > value: it allows people to build debian package without anything else,
 > > this is an unofficial package, of course, but it can be built before the
 > > Debian patch is generated.
 > 
 > Well, for people who catch the package within the few hours between
 > Xenomai release and the Debian version of it. ;-)

We like the Xenomai package to be as much "self-contained" as possible,
which is why it ships with the generated autotools files, the generated
documentation, the drivers and examples directories, and why I would
prefer it to ship with a working debian directory.

 > 
 > > IMO, it would make your life easier if you considered the debian
 > > directory part of the Xenomai package, and start working from this
 > > directory. If you ask for it, we can probably even give you write
 > > access to the repository, so that the debian packaging effort is fully
 > > integrated to Xenomai.
 > 
 > As discussed earlier this year: Every Debian package is a (small) fork
 > of the respective "upstream" release, with own Debian release numbers
 > between upstream releases, e.g. 2.4.4-1 and 2.4.4-2. Maintaining this at
 > xenomai.org would require branches on every (minor) Xenomai release,
 > e.g. 2.4.3 and 2.4.4 (besides me having repository write access),
 > because Debian revisions usually come out more often than "upstream"
 > versions (as you have seen 2.4.3-1 ... 2.4.3-7). Therefore, I prefer
 > maintaining it at Debian like most other packages. We already have
 > "trunk" and the stable release branches at xenomai.org. The above would
 > require an additional level of branching, maintenance and
 > synchronization work.
 > 
 > Another solution at Debian is called "native" packages where Debian
 > revisions and upstream versions are synchronized (i.e. no separate
 > Debian revisions). The problem here is that at every point in time,
 > Debian can decide to do a new revision (e.g. within a few hours on
 > security fixes) which may not be in the interest of other xenomai
 > maintainers. E.g. this way, Debian would decide when 2.4.5 and 2.4.6 (or
 > 2.4.4.1 and 2.4.4.2?) will be released. This doesn't scale well with the
 > number of Linux distros. ;)
 > 
 > For non-native packages in Debian (as Xenomai is currently), the debian/
 > directory is separated out into the .diff.gz patch which is good for
 > seeing how e.g. debian/rules looks like. If I would take the current
 > "upstream" tarball and only patch debian/rules in the diff.gz, the
 > resulting contents of the file is no recognizable from the patch alone.
 > Therefore, this is not common practice in Debian.
 > 
 > Further, it's not only me who works on Debian packages. Sometimes, when
 > I'm not available, one of the other 1000 Debian developers will do
 > Debian adjustments to the xenomai package in Debian. I guess you don't
 > want to give all of them write access to xenomai.org. ;)
 > 
 > So you have the choice between the following possibilities:
 > 
 > 1) Leave the process as it is (Debian using the upstream tarball,
 > stripped from debian/*, and adding an own debian/* in a separately
 > shipped patch)
 > 
 > 2) Give me (and maybe Debian as a whole) write access to Xenomai.org and
 > the right to branch at every "normal" Xenomai release, doing Debian
 > revisions. Problem here: Additional work for Debian because not only
 > Debian revisions must be done but also synchronization to the v2.4.x
 > (stable) brach and trunk. (I.e. changes are most often in 3 places)
 > 
 > 3) Give me (and maybe Debian as a whole) write access to Xenomai.org and
 > the right to do xenomai releases whenever Debian wants (i.e. "native"
 > Debian package)
 > 
 > I guess you prefer (1)? ;-)

I am sorry to use this argument, because I love Debian as an end-user
(actually, I installed my first Debian in 1997 and upgraded it until
now, copying my hard disks when changing machines), but as far as I
understood, the way Debian maintained a patch to the ssh package is the
reason why a bug could remain unnoticed during two years in Debian
distributions, including so-called "stable" distributions. So, maybe it
is time for a change.

The only problem I have with the current scheme is that merging back
debian patches in xenomai repository is rendered hard by the fact that
the patch is generated against an empty debian directory. So, it looks
to me like it would be much simpler for you to simply keep Xenomai own
debian directory and generate patches against it. Of course it makes the
patch a bit less readable, but I do not see how it violates a Debian
policy.

But of course, if you insist, this probably can be worked around by
writing some merging script.

-- 


					    Gilles.

