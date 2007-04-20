MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Message-ID: <17961.10754.445787.669761@domain.hid>
Date: Fri, 20 Apr 2007 23:00:50 +0200
In-Reply-To: <1176998001.8782.30.camel@domain.hid>
References: <1176585372.15994.14.camel@domain.hid>
	<17958.43866.983944.630780@domain.hid>
	<1176964723.2508.9.camel@domain.hid>
	<1176998001.8782.30.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] [PATCH] Support EABI enabled kernels on ARM
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>
Cc: xenomai@xenomai.org

Stelian Pop wrote:
 > Le jeudi 19 avril 2007 ~ 08:38 +0200, Stelian Pop a ~crit :
 > > Le jeudi 19 avril 2007 ~ 01:35 +0200, Gilles Chanteperdrix a ~crit :
 > > > Stelian Pop wrote:
 > > >  > Hi,
 > > >  > 
 > > >  > The attached patch adds an option to make Xenomai userspace issue EABI
 > > >  > syscalls. This is needed to make Xenomai work with kernels compiled with
 > > >  > CONFIG_EABI.
 > > >  > 
 > > > I get a problem with this patch: I am in the no EABI case in user-space
 > > > and kernel-space, and when starting latency, I get an "Illegal
 > > > instruction" message. If I revert this patch, latency starts
 > > > correctly. Any idea ?
 > > 
 > > Hmm, I might have screwed up here. A quick looking points me to this
 > > change:
 > > 
 > > +#define __SYS_REG
 > > +#define __SYS_REG_LIST
 > > +#define __syscall "swi\t" __sys1(XENO_ARM_SYSCALL) ""
 > > 
 > > Does replacing XENO_ARM_SYSCALL with (0x00900000 + XENO_ARM_SYSCALL)
 > > fixes it ?
 > > 
 > > I may be able to mount a test platform later today if this needs further
 > > debugging...
 > 
 > I have finally managed to get my old-ABI toolchain to work and can
 > confirm that the modification above fixes the problem.
 > 
 > The whole section of include/asm-arm/syscall.h must read:
 > 
 > #ifdef CONFIG_XENO_ARM_EABI
 > #define __SYS_REG register unsigned long __r7 __asm__ ("r7") = XENO_ARM_SYSCALL;#define __SYS_REG_LIST ,"r" (__r7)
 > #define __syscall "swi\t0"
 > #else
 > #define __SYS_REG
 > #define __SYS_REG_LIST
 > #define __NR_OABI_SYSCALL_BASE	0x900000
 > #define __syscall "swi\t" __sys1(__NR_OABI_SYSCALL_BASE + XENO_ARM_SYSCALL) ""
 > #endif
 > 
 > Sorry for the annoyance.

Yep, that was it, thanks.

-- 


					    Gilles Chanteperdrix.

