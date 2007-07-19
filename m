From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <469F4A98.3080307@domain.hid>
References: <469BF43D.1040704@domain.hid> <46973753.6010206@domain.hid>
	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>
	<22554361.1184054457326.JavaMail.ngmail@domain.hid>
	<2026261.1184070574283.JavaMail.ngmail@domain.hid>
	<1982070.1184078400928.JavaMail.ngmail@domain.hid>	<4693A702.1010604@domain.hid>
	<913919.1184311634860.JavaMail.ngmail@domain.hid>
	<21969019.1184569651818.JavaMail.ngmail@domain.hid>
	<29054475.1184842736562.JavaMail.ngmail@domain.hid>
	<469F4A98.3080307@domain.hid>
Content-Type: text/plain
Date: Thu, 19 Jul 2007 14:19:09 +0200
Message-Id: <1184847549.28303.46.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Sporadic PC freeze after rt_task_start
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, "M. Koehrer" <mathias_koehrer@domain.hid>

On Thu, 2007-07-19 at 13:27 +0200, Jan Kiszka wrote:
> M. Koehrer wrote:
> > Hi!
> > 
> > After a couple of over-night test runs, I finally got an NMI watchdog detected lockup with the sporadic freeze option.
> > I started the system with the argument nmi_watchdog=1 (also isolcpus=1).
> > See the code below. As I have not connected a serial console, I have attached a screen shot in a fairly
> > bad quality as jpg file... However, it is good enough to be able to read everything... 
> > The lockup is in function rpi_pop [xeno_nucleus].
> > It is called from gatekeeper_thread and from default_wake_function.
> > See the attached jpg for details.
> 
> Looks like we are stuck on rpilock, Philippe.
> 

Seems likely, yes. Switching the nucleus DEBUG option would engage the
lockup detector, and pull the brake whenever the nucleus fails to grab
the rpilock.

Mathias, I guess this test has not been run with the nucleus debug
option enabled. Any chance to get a disassembly of the rpi_pop routine
as compiled into your kernel, so that we could check if we are really
stuck on this lock, or rather on some infinite walk into a corrupted RPI
list?

> And when looking at the holders of rpilock, I think one issue could be
> that we hold that lock while calling into xnpod_renice_root [1], ie.
> doing a potential context switch. Was this checked to be save?

xnpod_renice_root() does no reschedule immediately on purpose, we would
never have been able to run any SMP config more than a couple of seconds
otherwise. (See the NOSWITCH bit).

> Furthermore, that code path reveals that we take nklock nested into
> rpilock [2]. I haven't found a spot for the other way around (and I hope
> there is none)

xnshadow_start().

> , but such nesting is already evil per se...

Well, nesting spinlocks only falls into evilness when you get a circular
graph, but since the rpilock is a rookie in the locking team, I'm going
to check this.

Ok, I'm tackling this lockup issue now. I first need to reproduce it.
More news later.

> 
> Mathias, already tried your test case with our old friend "priority
> coupling" switched off? *If* this lock-up is actually due to rpilock
> brokenness, switching the feature off should make it disappear.
> 

It would be nice to switch on the nucleus DEBUG feature, especially the
queue debugging one. I understand this may hide the bug due to the
alteration of timings, but still, it would be useful to know whether a
configuration without NMI but with such debug knob on would trigger the
alarm.

> Jan
> 
> 
> [1]http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/shadow.c?v=SVN-trunk#435
> [2]http://www.rts.uni-hannover.de/xenomai/lxr/source/include/nucleus/pod.h?v=SVN-trunk#308
> 
-- 
Philippe.



