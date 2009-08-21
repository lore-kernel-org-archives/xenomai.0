From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1250869487.4031.2.camel@domain.hid>
References: <1250696784.3014.31.camel@domain.hid>
	<1250869487.4031.2.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 21 Aug 2009 18:00:01 +0200
Message-Id: <1250870401.2988.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Xenomai v2.4.9
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-08-21 at 11:44 -0400, Andreas Glatz wrote:
> Hi,
> 
> Is there a reason why the following patch didn't make it into 2.4.9?
> 

Yes, unless I'm mistaken, no feedback received about that specific patch
(only about the previous one). Besides, this may have some impact on
other ppc platforms, so this needs more testing just to make sure this
does not introduce any regression for them.

In any case, the pipeline layer is decoupled from the Xenomai code base,
so you don't have to wait for another Xenomai release including an
updated pipeline patch. Just pick the I-pipe that fits from the Adeos
download area when it is available.

> See: https://mail.gna.org/public/xenomai-help/2009-08/msg00023.html
> 
> I included it into our system. I didn't see any problems so far...
> 

Good news. Thanks.

> Regards,
> 
> Andreas
> 
> 
> On Wed, 2009-08-19 at 17:46 +0200, Philippe Gerum wrote:
> > Here is the ninth maintenance release for the v2.4.x branch:
> > 
> > http://download.gna.org/xenomai/stable/xenomai-2.4.9.tar.bz2
> > 
> > Special note to PowerPC (32/64) users: the FPU management code has been
> > sanitized an awful lot in this release compared to 2.4.8 and earlier
> > for this architecture. Really.  Several bugs which may badly break the 
> > floating-point registers state "in some circumstances" have
> > been fixed.
> > 
> > Therefore I would strongly recommend to upgrade your Xenomai baseline
> > to 2.4.9, and ideally, kernel 2.6/powerpc users should also move their
> > I-pipe support to 2.6.30-2.7-00, or at the very least backport _both_ of
> > the following patches, in that order, to their kernel tree:
> > 
> > 1. http://git.denx.de/?p=ipipe-2.6.git;a=blobdiff;f=arch/powerpc/kernel/fpu.S;h=503de51bed94cc2fc4d17b4342885d0329ba5c1b;hp=2436df33c6f4433d7e7f54b88caad6ba570cf3f6;hb=4a9cffba3407f1238646847aad06712d8952a310;hpb=4d121ab41bda8a269c20b0a1077af8f3ef400105
> > 2. http://git.denx.de/?p=ipipe-2.6.git;a=commitdiff;h=0024416dcce817854cbf80eff420b21ef615672c;hp=d0353a6d1b4b4af7f6990dfa27055c799b3756a9
> > 
> > People running a 2.4.25 kernel (the only one officially supported by
> > Xenomai from the legacy 2.4/ppc kernel series) should definitely
> > upgrade to the following I-pipe patch, to close a few important
> > issues, including the FPU ones:
> > http://download.gna.org/adeos/patches/v2.4/ppc/adeos-ipipe-2.4.25-ppc-DENX-2.2-01.patch
> > 
> > Panic mode mitigation: This is a PowerPC-related issue only. Other
> > architectures were not affected by those bugs.
> > 
> > = You have been warned =
> > 
> > Not scared enough? Ok. Here is the short log for v2.4.9:
> > 
> > Gilles Chanteperdrix (3):
> >       arm: fix syscalls with gcc 4.3.2
> >       arm: Disable preemptible switch.
> >       posix: fix shm leak
> > 
> > Graf Yang (1):
> >       blackfin: Update __sched_latency for blackfin processors
> > 
> > Matteo Facchinetti (1):
> >       rtcan: fix MPC5xxx_GPIO definition for 2.6.2[0-4] kernels
> > 
> > Philippe Gerum (54):
> >       powerpc: add calibration data for Freescale's ADS8272
> >       powerpc: add calibration data for TQ's TQM8560
> >       powerpc: upgrade Adeos/powerpc support
> >       build: upgrade to autoconf >= 2.62
> >       powerpc: add calibration info for 440EP Yosemite
> >       powerpc: update Adeos/powerpc support
> >       powerpc: unify calibration values for PA-Semi
> >       powerpc: upgrade I-pipe/2.4 support to 2.4.25-ppc-2.0-01
> >       x86: upgrade I-pipe support to 2.6.29.5-x86-2.4-01
> >       x86: upgrade I-pipe to 2.6.29.5-x86-2.4-02
> >       powerpc: init FPU for userland Xenomai threads as well
> >       powerpc: discard useless backup field
> >       powerpc: fix fpu backup area layout
> >       nucleus: fix potential init race of the main pod
> >       powerpc: sanitize kthread init stack setup
> >       nucleus: port to 2.6.30
> >       native: force no more than PTHREAD_STACK_MIN bytes for stack size
> >       powerpc: enable FE0/FE1 exceptions during fpu init
> >       powerpc: flip FE0/FE1 when saving/restoring the FPU in RT mode
> >       x86: fix wrap_switch_iobitmap() for 2.6.30
> >       x86: remove now useless I/O bitmap switch code
> >       nucleus: do not dereference thread memory after deletion
> >       powerpc: raise SYS_STACKPOOLSZ to 128Kb for 64bit archs
> >       nucleus: use larger default sizes for heap and stack pool
> >       powerpc: reserve stack overhead in kthread trampoline
> >       powerpc: sanitize FPU handling helpers
> >       testsuite: add missing compiler barriers to switchtest
> >       testsuite: do not specify stack sizes lower than PTHREAD_STACK_MIN
> >       powerpc: upgrade legacy I-pipe support to 2.4.25-ppc-2.1-00
> >       powerpc: upgrade legacy I-pipe support to 2.6.20-powerpc-1.9-00
> >       powerpc: upgrade I-pipe support to 2.6.30-powerpc-2.6-03
> >       arm: upgrade I-pipe support to 2.6.28-arm-1.12-03
> >       arm: upgrade I-pipe support to 2.6.28-arm-1.13-01
> >       x86: fix 2.6.30 build in 32bit mode
> >       x86: upgrade I-pipe support to 2.6.30-x86-2.4-05
> >       powerpc: upgrade I-pipe support to 2.6.30-powerpc-2.7-00
> >       rtai: fix build with CONFIG_PROC_FS disabled
> >       blackfin: upgrade I-pipe support to 2.6.30-1.11-00
> >       asm-generic: stop using deprecated find_task_by_pid_type_ns()
> >       x86: fix include for kernel >= 2.6.30
> >       doc: fix GIT tree detection
> >       blackfin: do not consider IPEND[4] for scheduling deferral
> >       powerpc: reinstate FE0/FE1 depending on the per-task fpexc_mode
> >       powerpc: do not leak MSR_FP when back to secondary mode
> >       powerpc: upgrade legacy I-pipe support to 2.4.25-ppc-2.2-01
> >       nucleus: trap wrong interrupt state upon return from hardening
> >       nucleus: postpone sanity check to allow for signal receipt
> >       arm: upgrade I-pipe support to 2.6.30-arm-1.14-00, 2.6.28-arm-1.12-04, 2.6.29-arm-1.13-02
> >       scripts: use default autoconf version
> >       powerpc: upgrade legacy I-pipe support to 2.6.20-powerpc-1.9-01
> >       build: update version stamp
> >       build: bootstrap
> >       doc: regenerate documentation
> > 
> > Stefan Kisdaroczi (1):
> >       debian: fix kernel patch preparation script not to truncate init/Kconfig
> > 
-- 
Philippe.



