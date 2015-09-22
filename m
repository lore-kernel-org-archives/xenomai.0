MIME-Version: 1.0
In-Reply-To: <5600F8DE.30705@xenomai.org>
References: <CAFkYNwZV3xY_QU5E+zdFNGeeM=O4jo897wppbGCg40HumoojBQ@mail.gmail.com>
 <5600F8DE.30705@xenomai.org>
Date: Wed, 23 Sep 2015 00:32:11 +1200
Message-ID: <CAFkYNwaW5+nnDmumwt_zFFn01oWY5CsS5Fbmj1wB0aPF7om-4w@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai tests
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

By regenerating ./configure using autoreconf -fi, I managed to compile
xenomai-3-3.0-rc7 natively on PandaBoard. All things are put in their own
place by make install. However, when running latency, it produces

> latency
0"000.000| BUG in low_init(): [main] mlockall: Cannot allocate memory

> xeno-config --info
Xenomai version: Xenomai/cobalt v3.0-rc7 --
Linux arm 3.18.20-ipipe #1 SMP Tue Sep 22 21:04:49 NZST 2015 armv7l armv7l
armv7l GNU/Linux
Kernel parameters: console=ttyO2,115200n8 root=/dev/mmcblk0p1 ro
rootfstype=ext4 rootwait fixrtc
I-pipe release #5 detected
Cobalt core disabled on this system

> dmesg | grep -i xenomai
<nothing came back>

> dmesg | grep -i ipipe
[    0.000000] Linux version 3.18.20-ipipe (qws@qws-MacBookPro) (gcc
version 4.9.2 (Ubuntu/Linaro 4.9.2-10ubuntu10) ) #1 SMP Tue Sep 22 21:04:49
NZST 2015
[    0.623763] 3.18.20-ipipe #1 Not tainted
[    0.623994]   [<c00d3094>] __ipipe_do_sync_stage+0x288/0x2d0
[    0.624011]   [<c0008634>] __ipipe_grab_irq+0x5c/0x70
[    0.624321] CPU: 1 PID: 22 Comm: kblockd Not tainted 3.18.20-ipipe #1
[    0.624479] [<c00843b4>] (trace_hardirqs_on_caller) from [<c05da7f4>]
(__ipipe_fast_svc_irq_exit+0x4/0x18)
[    0.624504] [<c05da7f4>] (__ipipe_fast_svc_irq_exit) from [<c001aacc>]
(ipip_test_and_stall_root+0x2c/0x3c)
[    0.624524] [<c001aacc>] (ipipe_test_and_stall_root) from [<c0086e58>]
(lock_acquire+0x44/0x108)
[    0.728394] Switched to clocksource ipipe_tsc
[    2.464800] usb usb1: Manufacturer: Linux 3.18.20-ipipe ehci_hcd
[    6.364516] usb usb2: Manufacturer: Linux 3.18.20-ipipe musb-hcd


I have googled, but those are beyond my comprehension. Would you somebody
help please?

Is Cobalt not enabled? if yes, what do those return messages from dmesg |
grep -i ipipe? I presume if Cobalt is enabled, the memory allocation issues
would be cleared, wouldn't it?

Appreciate any comments please.

Thank you




On 22 September 2015 at 18:44, Philippe Gerum <rpm@xenomai.org> wrote:

> On 09/21/2015 02:15 PM, vibnwis wrote:
> > Having managed to compile Xenomai apps and libs, I went to install them
> on
> > target. The way I installed is by creating a xenomai directory in /usr
> and
> > set PATH to /usr/xenomai/bin, /usr/xenomai/lib etc.
> > However, when I ran latency I got this error message
> >   0"000.000| BUG in low_init(): [main] mlockall: Cannot allocate memory
> >
> > and when I ran xeno latency -T 25, I got these error messages,
> >
> > Xenomai: /dev/rtheap is missing
> > (chardev, major=10 minor=254)
> >
>
> /dev/rtheap is specific to Xenomai 2.x, it is irrelevant to Xenomai 3.x.
> Looking at the log messages, you are definitely mixing 3.x kernel
> support with 2.x libraries and executables. You may want to start from a
> fresh and clean installation.
>
> > In the installed directory, it does not have dev direcotry but bin, etc,
> > sbin, lib, share, demo, include. The target does not have rtheap dev as
> > well. Where and how it is created?
> >
> > The dmesg | grep -i xenomai produced
> >
> > [    0.666100] [Xenomai] scheduling class idle registered.
> > [    0.666112] [Xenomai] scheduling class rt registered.
> > [    0.666309] I-pipe: head domain Xenomai registered.
> > [    0.668400] [Xenomai] Cobalt v3.0-rc7 (Exact Zero)
> >
> >
> > Appreciate any comments, please.
> >
> > thank you
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > http://xenomai.org/mailman/listinfo/xenomai
> >
>
>
> --
> Philippe.
>
