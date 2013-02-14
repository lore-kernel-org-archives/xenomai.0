Message-ID: <511C911B.2080609@zultron.com>
Date: Thu, 14 Feb 2013 01:24:11 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Announcing beta x86 Xenomai kernel packages:  squeeze,
	precise, lucid
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: emc-developers@lists.sourceforge.net, Xenomai <xenomai@xenomai.org>

Hello emc-dev and xenomai lists,

I'm very pleased to announce the availability of one-size-fits-all
Xenomai kernel packages for x86 arch.  These packages have been
successfully tested on umpteen motherboards at this point, and are ready
for wider testing.

* Beta status *
Distros: Ubuntu Precise and Lucid; Debian Squeeze
Architectures: i686 and amd64
Xenomai version: v2.6.2.1, released 2013/01/25
Kernel version: v3.5.7 vanilla
Kernel config:  Ubuntu 3.5 stock kernel with Xenomai additions

The instruction wiki page on linuxcnc.org is somewhat oriented toward
LinuxCNC users, but most will apply to the general audience:

  http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernelPackages

*Note to existing users*:  The packages are now hosted on Michael's
infrastructure, which can rebuild and publish them far faster than mine.
 Please note the URL change and update /etc/apt/sources.list.

Michael Haberler (mhaberler) and I (zultron) invite testers to ask
questions on IRC in either the #linuxcnc-devel or the newly-created
#xenomai channels on freenode.  (Of course, any Xenomai-related
discussion on #xenomai is welcome, not restricted to packages.)

---------

Huge thanks to skunkworks/Sam Sokolik and Schooner/Mick from the
LinuxCNC community for persistence while identifying and solving several
tough problems on their myriad systems.

Great thanks to Gilles Chanteperdrix and Jan Kiszka, Xenomai developers,
for their responsiveness to our dozens of questions.

And of course thanks to Michael Haberler for his tenacity while solving
problems, testing and helping testers.

Happy testing!

	John

