Subject: Re: [Xenomai-help] pSOS skin questions
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF246A2543.EA63CD8F-ONC12571EA.002E004F@uk.marconicomms.com>
References: <OF246A2543.EA63CD8F-ONC12571EA.002E004F@uk.marconicomms.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 13:29:26 +0200
Message-Id: <1158319766.5009.75.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Thomas Necker <Thomas.Necker@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-09-15 at 11:46 +0200, Thomas Necker wrote:
> I started to experiment with Xenomai's pSOS skin. I'm running Xenomai 
> 2.2.2 on
> a 2.4 kernel. So far I managed to get some tasks running and some messages 
> sent.
> Now I'm stuck with some timer issues. So here are my questions:
> - Is somebody out there actually using the pSOS skin? Who should I send 
> patches to?

Please send your patches to xenomai@xenomai.org. They will be reviewed
and possibly picked from there.

In any case, the pSOS interface is carefully maintained, and bugs will
be fixed as they are reported. Providing a simple testcase to reproduce
the issue will help. Bug reports should also be posted to
xenomai@xenomai.org.

> - While tm_wkafter finally works, I had no success with tm_evafter. It 
> seems that the
>   timeout doesn't work - no event is sent after the specified time. 
> Setting the timer to
>   periodic also doesn't have any effect (well, rt_start_timer is 
> deprecated as I understand,
>   at least the vxworks skin sets the timer mode as needed, but what about 
> the pSOS skin?)

It depends. For kernel space pSOS apps, you need the pSOS skin as a
kernel component, and it only works with the periodic timer, which is
started when the skin initializes. Make sure to build the native and
POSIX skin as modules (or maybe disable them if you don't need them), so
that they don't force aperiodic timing, which would conflict with pSOS;
the pSOS skin could then be built either statically into the kernel or
as a module.

For pSOS emulation over the UVM in user-space, the virtual machine
provides periodic timing over the global aperiodic mode, IOW: just
enable the nucleus and uvm supports, and keep the default timing
configuration suggested when configuring the kernel (i.e. aperiodic
enabled, periodic disabled), this will work.

> - I compiled the pSOS, UVM and Native support as kernel modules. The 
> program runs
>   when loading xeno_native and xeno_uvm. I cannot load xeno_psos though 
> ("unresolved
>   symbol print_backtrace"). Do I need that module?
> 

If you want to run the pSOS interface over the UVM, you just need the
nucleus and the uvm support. If you want to run kernel space pSOS apps,
then you need the nucleus and the psos module.

> Thanks,
> Thomas
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



