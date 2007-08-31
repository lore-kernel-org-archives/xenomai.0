From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1188506941.6009.251.camel@domain.hid>
References: <b6ad4ed70708301343t4fd6c9b6j854c993001e34bb6@domain.hid>
	<1188506941.6009.251.camel@domain.hid>
Content-Type: text/plain
Date: Fri, 31 Aug 2007 09:09:55 +0200
Message-Id: <1188544196.6009.259.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] error compiling xenomai 2.4-rc1 and rc2
	with	linux kernel 2.6.22.5
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: John Yamokoski <yamokosk@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-08-30 at 22:49 +0200, Philippe Gerum wrote:
> On Thu, 2007-08-30 at 16:43 -0400, John Yamokoski wrote:
> > Greetings,
> > 
> > I ran into compile errors when trying to compile both xenomai 2.4-rc1
> > and rc2 with linux 2.6.22.5 and the latest adeos patch. First here are
> > my system details:
> > 
> The I-pipe 1.10 series will only compile with the current development
> trunk, which will soon be released as Xenomai 2.4-rc3. You need to stick
> with the 1.9 series for -rc2 and older versions.
> 

This said, a compat mode allowing to build previous Xenomai releases
with the latest I-pipe core will be introduced in 1.11, so that users
may still upgrade the interrupt pipeline separately from the Xenomai
release in use.

> > Kernel: 2.6.22.5
> > Adeos patch: adeos-ipipe-2.6.22-i386-1.10-00.patch
> > gcc: 4.1.2
> > distro: Debian 4.1.1-21
> > 
> > Here were the compile errors: (The error was identical for rc1 and
> > rc2)
> > 
> > CC      kernel/xenomai/arch/generic/hal.o 
> > kernel/xenomai/arch/generic/hal.c: In function 'rthal_apc_handler':
> > kernel/xenomai/arch/generic/hal.c:397: error: 'ipipe_declare_cpuid'
> > undeclared (first use in this function)
> > kernel/xenomai/arch/generic/hal.c:397: error: (Each undeclared
> > identifier is reported only once 
> > kernel/xenomai/arch/generic/hal.c:397: error: for each function it
> > appears in.)
> > kernel/xenomai/arch/generic/hal.c:399: warning: implicit declaration
> > of function 'ipipe_load_cpuid'
> > kernel/xenomai/arch/generic/hal.c:411: error: array subscript is not
> > an integer 
> > kernel/xenomai/arch/generic/hal.c:412: error: array subscript is not
> > an integer
> > kernel/xenomai/arch/generic/hal.c:413: error: array subscript is not
> > an integer
> > kernel/xenomai/arch/generic/hal.c:416: error: array subscript is not
> > an integer 
> > kernel/xenomai/arch/generic/hal.c: In function 'rthal_apc_schedule':
> > kernel/xenomai/arch/generic/hal.c:602: error: 'ipipe_declare_cpuid'
> > undeclared (first use in this function)
> > kernel/xenomai/arch/generic/hal.c:603: warning: ISO C90 forbids mixed
> > declarations and code 
> > kernel/xenomai/arch/generic/hal.c:612: error: array subscript is not
> > an integer
> > make[5]: *** [kernel/xenomai/arch/generic/hal.o] Error 1
> > make[4]: *** [kernel/xenomai/arch/generic] Error 2
> > make[3]: *** [kernel/xenomai/arch] Error 2 
> > make[2]: *** [kernel/xenomai] Error 2
> > make[1]: *** [kernel] Error 2
> > make[1]: Leaving directory
> > `/home/yamokosk/apps/linux-2.6.22.5-xenomai'
> > make: *** [debian/stamp-build-kernel] Error 2
> > 
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



