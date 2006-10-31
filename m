From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Buildbot finds unresolved
	=?iso-8859-1?q?symbols=09=60xnarch=5Fatomic=5Fxchg=27?=
Date: Tue, 31 Oct 2006 13:09:47 +0100
References: <200610310737.58954.niklaus.giger@domain.hid>
	<45470076.8030601@domain.hid>
In-Reply-To: <45470076.8030601@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610311309.48160.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Am Dienstag, 31. Oktober 2006 08:51 schrieb Wolfgang Grandegger:
> Hi Niklaus,
>
> Niklaus Giger wrote:
> > Hi
> >
> > I see the following failure since revision 1771. e.g.
> > http://ngiger.dyndns.org/buildbot-full/ppc_f/builds/56/step-mk_kernel/1
> >
> > kernel/built-in.o: In function `xnintr_irq_handler':
> > intr.c:(.text+0x34334): undefined reference to `xnarch_atomic_xchg'
> > intr.c:(.text+0x34424): undefined reference to `xnarch_atomic_xchg'
> > kernel/built-in.o: In function `xnpod_schedule':
> > (.text+0x38470): undefined reference to `xnarch_atomic_xchg'
> > kernel/built-in.o: In function `xnpod_schedule_runnable':
> > (.text+0x39f28): undefined reference to `xnarch_atomic_xchg'
> > kernel/built-in.o: In function `xnpod_init':
> > (.text+0x3a770): undefined reference to `xnarch_atomic_xchg'
> > make: *** [.tmp_vmlinux1] Fehler 1
>
> I lost track somehow. What version of the Linux kernel, ADEOS-IPIPE and
> Xenomai are you using?
Usually, quite a recent one. My main target is a custom PPC405 target, running 
U-Boot, Linux 2.6.14, adeos-ipipe-2.6.14-ppc-1.5-01.patch.

When I refer to the buildbot (acontinuos integration tool), I mean the the 
buildbot master, running at http://ngiger.dyndns.org/buildbot/ . It tracks 
the most recent svn version of the buildbot and builds them for various 
target (simulator, ppc405 posix, pp405 vxworks, tqm_q with rtnet, ppc60x).
Each build contains (if one looks at the different build steps) all the 
relevant information (kernel, ipipe-version, .config) etc.

For details of the above mention build go to:
http://ngiger.dyndns.org/buildbot-full/ppc_f/builds/56
and following the different build logs pointed by the stio links.

Documentation about the xenomai buildbot can be found at:
http://ngiger.dyndns.org/xenomai-data/xeno_buildbot.pdf

Best regards
 
-- 
Niklaus Giger

