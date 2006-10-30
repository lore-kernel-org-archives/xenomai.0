From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Bug in taskSuspend for user mode vxworks
Date: Mon, 30 Oct 2006 08:09:43 +0100
References: <200610252346.34150.niklaus.giger@domain.hid>
	<200610292202.49810.niklaus.giger@domain.hid>
	<4545AA69.9080609@domain.hid>
In-Reply-To: <4545AA69.9080609@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610300809.43844.niklaus.giger@domain.hid>
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
Cc: xenomai@xenomai.org

Am Montag, 30. Oktober 2006 08:31 schrieb Wolfgang Grandegger:
> Niklaus Giger wrote:
> > Am Samstag, 28. Oktober 2006 20:36 schrieb Wolfgang Grandegger:
> >> Niklaus Giger wrote:
> >>> Am Samstag, 28. Oktober 2006 14:54 schrieb Niklaus Giger:
> >>>> Am Freitag, 27. Oktober 2006 18:38 schrieb Philippe Gerum:
> >>>>> On Wed, 2006-10-25 at 23:46 +0200, Niklaus Giger wrote:
> >>>>>> Hi
> >>
> >> My impression from our last discussion was that your toolchain is
> >> somehow broken as I was unable to reproduce your problems on (almost)
> >> the same hardware
> >>
> >>> I think I really have to reactivate my old Walnut board to have common
> >>> platform to test with Wolfgang Grandegger.
> >>
> >> It would make more sense to use the ELDK4 for comparison. I don't think
> >> it depends on the hardware.
> >
> > As I forced my son to run on his MacMini (Intel Core Duo) only Linux and
> > no MacOsX (he discovered widelands and was quite happy), I had a platform
> > where I could install the CD with ELDK 4.0, which I had laying around.
> >
> > After some setting up of my environment and tweaking my scripts to work
> > with ELDK (e.g. adding --host=ppc CC=ppc_4xx-gcc to my xenomai/configure)
> > I ended
>
> --host=ppc-linux is already enough with CROSS_COMPILE=ppc_4xx- set.
>
> > up with a nice environment and rootfs with much more precompiled programs
> > than I had ever before. Debugging on the platform is now as good as on my
> > PowerBook.
> >
> > My situation is now as follows:
> > - ELDK 4.0 installed on Debian Etch MacMini
> > - Using ELD 4.0 rootfs ppc_4xx
> > - compiled the kernel uImage, modules, xenomai using ppc_4xx-gcc
> >    (but NOT adding any -mcpu=40x flag to the compiler)
> >
> > The trap 0 in  /proc/xenomai/fault seems to count on each invocation of
> > simple 0:           51    (Data or instruction access)
> > gdb however no does not show anything abnormal, as it says now
> >
> >> This GDB was configured as "ppc-linux"...Using host libthread_db library
> >> "/lib/tls/libthread_db.so.1".
> >>
> >> (gdb) run
> >> Starting program: /bin/simple
> >> [Thread debugging using libthread_db enabled]
> >> [New Thread 805422032 (LWP 639)]
> >> root_thread_init 4[New Thread 805455088 (LWP 642)]
> >>
> >> Program exited normally.
> >> (gdb) quit
> >
> > Though I am still puzzled.
>
> Could you please send me your Makefile or the compile command to make
> "simple", then I would give it a try on my setup.
>
Here are the commands
ppc_4xx-gcc -I../.. -I/home/hcu/rootfs/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -I/net/ng/mnt/data.ng/hcu/project/vx_skin -D__XENO__ -g -DVXWORKS    -c -o 
simple.o simple.c
ppc_4xx-gcc -o simple 
simple.o -L/home/hcu/rootfs/usr/xenomai/lib -lpthread  -lvxworks

Thanks for your help.

Will be busy till tomorrow evening. 

Best regards

-- 
Niklaus Giger

