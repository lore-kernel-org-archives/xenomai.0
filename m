From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C234A15.2030708@domain.hid>
References: <4C0692A9.2080806@domain.hid>
	<1276080083.18906.52.camel@domain.hid>
	<4C234A15.2030708@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 Jun 2010 18:01:59 +0200
Message-ID: <1277654519.2305.7.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] Mayday support
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, Tschaeche IT-Services <services@domain.hid>

On Thu, 2010-06-24 at 14:05 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > I've toyed a bit to find a generic approach for the nucleus to regain
> > complete control over a userland application running in a syscall-less
> > loop.
> > 
> > The original issue was about recovering gracefully from a runaway
> > situation detected by the nucleus watchdog, where a thread would spin in
> > primary mode without issuing any syscall, but this would also apply for
> > real-time signals pending for such a thread. Currently, Xenomai rt
> > signals cannot preempt syscall-less code running in primary mode either.
> > 
> > The major difference between the previous approaches we discussed about
> > and this one, is the fact that we now force the runaway thread to run a
> > piece of valid code that calls into the nucleus. We do not force the
> > thread to run faulty code or at a faulty address anymore. Therefore, we
> > can reuse this feature to improve the rt signal management, without
> > having to forge yet-another signal stack frame for this.
> > 
> > The code introduced only fixes the watchdog related issue, but also does
> > some groundwork for enhancing the rt signal support later. The
> > implementation details can be found here:
> > http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=4cf21a2ae58354819da6475ae869b96c2defda0c
> > 
> > The current mayday support is only available for powerpc and x86 for
> > now, more will come in the next days. To have it enabled, you have to
> > upgrade your I-pipe patch to 2.6.32.15-2.7-00 or 2.6.34-2.7-00 for x86,
> > 2.6.33.5-2.10-01 or 2.6.34-2.10-00 for powerpc. That feature relies on a
> > new interface available from those latest patches.
> > 
> > The current implementation does not break the 2.5.x ABI on purpose, so
> > we could merge it into the stable branch.
> > 
> > We definitely need user feedback on this. Typically, does arming the
> > nucleus watchdog with that patch support in, properly recovers from your
> > favorite "get me out of here" situation? TIA,
> > 
> > You can pull this stuff from
> > git://git.xenomai.org/xenomai-rpm.git, queue/mayday branch.
> > 
> 
> I've retested the feature as it's now in master, and it has one
> remaining problem: If you run the cpu hog under gdb control and try to
> break out of the while(1) loop, this doesn't work before the watchdog
> expired - of course. But if you send the break before the expiry (or hit
> a breakpoint), something goes wrong. The Xenomai task continues to spin,
> and there is no chance to kill its process (only gdb).

I can't reproduce this easily here; it happened only once on a lite52xx,
and then disappeared; no way to reproduce this once on a dual core atom
in 64bit mode, or on a x86_32 single core platform either. But I still
saw it once on a powerpc target, so this looks like a generic
time-dependent issue.

Do you have the same behavior on a single core config, and/or without
WARNSW enabled?

Also, could you post your hog test code? maybe there is a difference
with the way I'm testing.

> 
> # cat /proc/xenomai/sched
> CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
>   0  0      idle    -1      -         master     RR         ROOT/0

Eeek. This symbolic stat mode label looks weird.

>   1  0      idle    -1      -         master     R          ROOT/1
>   0  6120   rt      99      -         master     Tt         cpu-hog
> # cat /proc/xenomai/stat
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          0          0     00500088    0.0  ROOT/0
>   1  0      0          0          0     00500080   99.7  ROOT/1
>   0  6120   0          1          0     00342180  100.0  cpu-hog
>   0  0      0          21005      0     00000000    0.0  IRQ3340: [timer]
>   1  0      0          35887      0     00000000    0.3  IRQ3340: [timer]
> 
> Jan
> 


-- 
Philippe.



