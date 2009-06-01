From: Vikesh Rambaran <Vikesh.Rambaran@domain.hid>
Date: Mon, 1 Jun 2009 10:17:47 +0200
Message-ID: <5F0B1AF0FEA4EB4F8AC9F4CF3AF6DC1E933A9E0554@domain.hid>
References: <1243616178.27443.21.camel@domain.hid>
In-Reply-To: <1243616178.27443.21.camel@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [Xenomai-core] Xenomai v2.4.8
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi
Thanx for the release.

However, could you please check the xenomai-2.4.8.tar.bz2 file.=20
It seems to be missing a few files and folders (eg ksrc, scripts).

Keep well
Vicki

________________________________________
From: xenomai-core-bounces@domain.hid [xenomai-core-bounces@domain.hid] On Beha=
lf Of Philippe Gerum [rpm@xenomai.org]
Sent: Friday, May 29, 2009 6:56 PM
To: xenomai@xenomai.org
Cc: xenomai@xenomai.org
Subject: [Xenomai-core] Xenomai v2.4.8

Here is the eighth maintenance release for the v2.4.x branch.  Short
log follows:

=20       [nucleus]

=20       * Suppress switch warning upon signal receipt when the process
=20       is being debugged.
=20       * Fix host tick propagation.
=20       * Prevent early timer shots due to rounding imprecision.
=20       * Fix computation of heap overhead.
=20       * Move xnarch_set_irq_affinity out of intr lock.
=20       * Introduce channel information in LTTng markers.

=20       [posix]

=20       * Fix access checks in select().
=20       * Fix errnoneous -EINVAL error return with mmap() of non
=20         page-aligned length.

=20       [native]

=20       * Fix message pipe streaming mode.
=20       * Make optimized tsc<->ns conversion routines available to
=20         user-space.

=20       [vxworks]

=20       * Add missing rescheduling in semaphore deletion code.

=20       [vrtx]

=20       * Fix sc_[e]tcreate().
=20       * Rework mutex support.

=20       [powerpc]

=20       * Do not restore ALTIVEC/SPE regs for kernel threads.
=20       * Port to Emerson's MVME7100 dual core SBC.
=20       * Upgrade Adeos support to 2.6.29.4-powerpc-DENX-2.6-00.

=20       [arm]

=20       * Upgrade Adeos support to 2.6.29-arm-1.13-00.

=20       [x86]

=20       * Fix miscompilation of __do_strncpy_from_user().
=20       * Yet another round of FPU management fixes.
=20       * Upgrade Adeos support to 2.6.29.4-x86-2.4-01.

=20       [blackfin]

=20       * Upgrade Adeos support to 2.6.28.10-blackfin.git-1.10-00.

=20       [can]

=20       * ixxat-pci: fix problems with device probing.
=20       * ixxat-pci: disambiguate PCI device id.
=20       * mscan: fix build problems with recent kernel versions.


http://download.gna.org/xenomai/stable/xenomai-2.4.8.tar.bz2

git://xenomai.org/xenomai-2.4.git

--
Philippe.



_______________________________________________
Xenomai-core mailing list
Xenomai-core@domain.hid
https://mail.gna.org/listinfo/xenomai-core



