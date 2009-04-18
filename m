From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <b131c9f0904170844w2f81b3acrc1b9386734a3ac28@domain.hid>
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
	<49DC6612.40802@domain.hid>
	<1239696760.5780.12.camel@domain.hid>
	<49E45473.4050409@domain.hid>
	<1239708396.5780.34.camel@domain.hid>
	<49E4750B.6060602@domain.hid>
	<1239709765.5780.40.camel@domain.hid>
	<49E4793D.2010105@domain.hid>
	<1239717322.5780.62.camel@domain.hid>
	<49E49A0B.1040307@domain.hid>
	<b131c9f0904170844w2f81b3acrc1b9386734a3ac28@domain.hid>
Content-Type: text/plain
Date: Sat, 18 Apr 2009 12:27:49 +0200
Message-Id: <1240050469.26554.128.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai LTTng support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vikesh rambaran <vikesh.rambaran@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Vikesh Rambaran <vikesh.rambaran@domain.hid>, xenomai-help <xenomai@xenomai.org>

On Fri, 2009-04-17 at 17:44 +0200, vikesh rambaran wrote:
> Hi
> 
> On Tue, Apr 14, 2009 at 4:13 PM, Jan Kiszka <jan.kiszka@domain.hid>
> wrote:
>         Vikesh Rambaran wrote:
>         > On Tue, 2009-04-14 at 13:53 +0200, Jan Kiszka wrote:
>         >> Vikesh Rambaran wrote:
>         >>> On Tue, 2009-04-14 at 13:35 +0200, Jan Kiszka wrote:
>         >>>>>> NMI watchdog, see Xenomai machine kconfig menu, use
>         nmi_watchdog=2 to
>         >>>>>> finally enable it at the kernel command line.
>         >>>>>>
>         >>>>> There are build issues with NMI enabled.
>         >>>>>
>         >>>>> Would you prefer testing with the latest git updates, or
>         can i just
>         >>>>> replace the following in hal32.c (line 139)
>         >>>>>
>         >>>>> - die_nmi(regs, buf);
>         >>>>> + die_nmi(buf, regs, 1);
>         >>>> If your CPU is not too new, this may suffice. Otherwise
>         you should
>         >>>> switch over to the development head (upcoming 2.5) as
>         there we have
>         >>>> up-to-date NMI support.
>         >>>> BTW, trying 2.5-devel might be useful anyway to check if
>         the picture
>         >>>> changes (maybe we even see a clearer error with that
>         branch...).
>         >>>>
>         >>> Ok, thanx. I have a Core Duo and a Core 2. Will try the
>         'short' approach
>         >>> first as our external git access at work is blocked.
>         >
>         > Tried the test with NMI enabled and die_nmi(buf, regs, 1);
>         > No additional Xenomai / IPIPE info is displayed on the
>         serial console.
>         >
>         > What type of response were we hoping for ? Reset ?
>         
>         
>         Nope. Some error message that the NMI watchdog triggered. You
>         should see
>         NMI increases in /proc/interrupts and /proc/xenomai/irq. But
>         if you are
>         on Intel Core processors, you need the patches in git head.
>         2.4.7 does
>         not support your CPUs.
> 
> Here's serial console output of two scenarios that produced a kernel
> panic using kernel 2.6.28.7
> with xenomai-head-6759ba0580f10f7465c8a205a68ce49e552ea77f
> 

Does this patch show any improvement?
http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.28.9-x86-2.2-07.patch

You may want to try this one if you plan to run 2.6.29 as well.
http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.29.1-x86-2.3-01.patch

-- 
Philippe.



