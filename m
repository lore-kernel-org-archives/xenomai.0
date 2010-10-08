From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 21:38:10 +0200
Message-ID: <1286566690.13186.199.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai forge
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


We need a playground for experimenting with the 3.x architecture. I have
set up a GIT tree for this purpose, which currently contains legacy
removal and preliminary cleanup work I've been doing lazily during the
past months, periodically rebasing on -head.

This tree is there for Xenomai hackers to work on radical changes toward
Xenomai 3.x; this is NOT for production use. It is expected to be in a
severe state-of-flux for several months from now on, until the updates
on the infrastructure calm down. The plan is to work on this tree, until
it makes sense to turn it into the official xenomai-3.0 tree eventually.

Some CPU architectures currently supported in Xenomai 2.5.x may not be
supported in this tree yet, until the dust settles, at some point (we do
plan to support all of them eventually, though). The bottom line is to
have powerpc (32/64), arm and x86 (32/64) available early; blackfin may
be there early too, since their reference kernel tracks mainline closely
as well. So this may leave us with nios2 lagging behind for a while.

The same goes for RTOS emulators such as VxWorks, pSOS and friends. They
have to be rebased on a new emulation core fully running in user-space
we experimented with Xenomai/SOLO, so their legacy 2.x incarnations have
been removed from the tree. This tree only features the POSIX, native
and RTDM skins for now.

The 3.x roadmap was published many moons ago on our web site [1], so I
won't rehash the final goals for this architecture. However, the major
development milestones can be outlined here:

* legacy support removal (mainly: kernel 2.4 support and in-kernel skin
APIs are being phased out, except the RTDM driver development API).
* introduction of a new RTOS emulation core, which can run on top of the
POSIX skin, or over the regular nptl.
* port of the existing Xenomai/SOLO emulators (VxWorks, pSOS) over the
new core. At some point, we shall decide whether it still makes sense to
provide VRTX and uITRON emulators on this new core, given the lack of
useful feedback we got for those for the past eight years. It seems that
nobody cares for them actually.
* integration of the missing bits to fully support our current dual
kernel software stack over -rt kernels as well (i.e. no I-pipe),
typically RTDM native.

For sure, all theses tasks will entail various cleanup, streamlining,
and sanitization activities all over the place, over time.

The forge can be found at:
git://git.xenomai.org/xenomai-forge.git

Ok, just go wild now.

[1] http://www.xenomai.org/index.php/Xenomai:Roadmap#Toward_Xenomai_3

-- 
Philippe.



