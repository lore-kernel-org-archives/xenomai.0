From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4C28AC49.3080209@domain.hid>
References: <4C0692A9.2080806@domain.hid>
	<1276080083.18906.52.camel@domain.hid>
	<4C234A15.2030708@domain.hid>
	<1277654519.2305.7.camel@domain.hid>
	<4C28AC49.3080209@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Jul 2010 17:44:57 +0200
Message-ID: <1278431097.1939.7.camel@domain.hid>
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Tschaeche IT-Services <services@domain.hid>

On Mon, 2010-06-28 at 16:06 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Thu, 2010-06-24 at 14:05 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> I've toyed a bit to find a generic approach for the nucleus to regain
> >>> complete control over a userland application running in a syscall-less
> >>> loop.
> >>>
> >>> The original issue was about recovering gracefully from a runaway
> >>> situation detected by the nucleus watchdog, where a thread would spin in
> >>> primary mode without issuing any syscall, but this would also apply for
> >>> real-time signals pending for such a thread. Currently, Xenomai rt
> >>> signals cannot preempt syscall-less code running in primary mode either.
> >>>
> >>> The major difference between the previous approaches we discussed about
> >>> and this one, is the fact that we now force the runaway thread to run a
> >>> piece of valid code that calls into the nucleus. We do not force the
> >>> thread to run faulty code or at a faulty address anymore. Therefore, we
> >>> can reuse this feature to improve the rt signal management, without
> >>> having to forge yet-another signal stack frame for this.
> >>>
> >>> The code introduced only fixes the watchdog related issue, but also does
> >>> some groundwork for enhancing the rt signal support later. The
> >>> implementation details can be found here:
> >>> http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=4cf21a2ae58354819da6475ae869b96c2defda0c
> >>>
> >>> The current mayday support is only available for powerpc and x86 for
> >>> now, more will come in the next days. To have it enabled, you have to
> >>> upgrade your I-pipe patch to 2.6.32.15-2.7-00 or 2.6.34-2.7-00 for x86,
> >>> 2.6.33.5-2.10-01 or 2.6.34-2.10-00 for powerpc. That feature relies on a
> >>> new interface available from those latest patches.
> >>>
> >>> The current implementation does not break the 2.5.x ABI on purpose, so
> >>> we could merge it into the stable branch.
> >>>
> >>> We definitely need user feedback on this. Typically, does arming the
> >>> nucleus watchdog with that patch support in, properly recovers from your
> >>> favorite "get me out of here" situation? TIA,
> >>>
> >>> You can pull this stuff from
> >>> git://git.xenomai.org/xenomai-rpm.git, queue/mayday branch.
> >>>
> >> I've retested the feature as it's now in master, and it has one
> >> remaining problem: If you run the cpu hog under gdb control and try to
> >> break out of the while(1) loop, this doesn't work before the watchdog
> >> expired - of course. But if you send the break before the expiry (or hit
> >> a breakpoint), something goes wrong. The Xenomai task continues to spin,
> >> and there is no chance to kill its process (only gdb).
> > 
> > I can't reproduce this easily here; it happened only once on a lite52xx,
> > and then disappeared; no way to reproduce this once on a dual core atom
> > in 64bit mode, or on a x86_32 single core platform either. But I still
> > saw it once on a powerpc target, so this looks like a generic
> > time-dependent issue.
> > 
> > Do you have the same behavior on a single core config,
> 
> You cannot reproduce it on a single core as the CPU hog will occupy that
> core and gdb cannot be operated.
> 
> > and/or without
> > WARNSW enabled?
> 
> Just tried and disabled WARNSW in the test below: no difference.
> 
> > 
> > Also, could you post your hog test code? maybe there is a difference
> > with the way I'm testing.
> 
> #include <signal.h>
> #include <native/task.h>
> #include <sys/mman.h>
> #include <stdlib.h>
> 
> void sighandler(int sig, siginfo_t *si, void *context)
> {
> 	printf("SIGDEBUG: reason=%d\n", si->si_value.sival_int);
> 	exit(1);
> }
> 
> void loop(void *arg)
> {
> 	RT_TASK_INFO info;
> 
> 	while (1)
> 		if (!arg)
> 			rt_task_inquire(NULL, &info);
> }
> 
> int main(int argc, const char *argv[])
> {
> 	struct sigaction sa;
> 	RT_TASK task;
> 
> 	sigemptyset(&sa.sa_mask);
> 	sa.sa_sigaction = sighandler;
> 	sa.sa_flags = SA_SIGINFO;
> 	sigaction(SIGDEBUG, &sa, NULL);
> 
> 	mlockall(MCL_CURRENT|MCL_FUTURE);
> 	rt_task_spawn(&task, "cpu-hog", 0, 99, T_JOINABLE|T_WARNSW, loop,
> 		(void *)(long)((argc > 1) && strcmp(argv[1], "--lethal") == 0));
> 	rt_task_join(&task);
> 
> 	return 0;
> }

I can't reproduce this issue, leaving the watchdog threshold to the
default value (4s).

> CONFIG_XENO_OPT_WATCHDOG=y
> CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=60

60s seems way too long to have a chance of recovering from a runaway
loop to a reasonably sane state. Do you still see the issue with shorter
timeouts?


> CONFIG_XENO_OPT_SHIRQ=y
> CONFIG_XENO_OPT_SELECT=y
> 
> #
> # Timing
> #
> CONFIG_XENO_OPT_TIMING_PERIODIC=y
> CONFIG_XENO_OPT_TIMING_VIRTICK=1000
> CONFIG_XENO_OPT_TIMING_SCHEDLAT=0
> 
> #
> # Scalability
> #
> CONFIG_XENO_OPT_SCALABLE_SCHED=y
> # CONFIG_XENO_OPT_TIMER_LIST is not set
> CONFIG_XENO_OPT_TIMER_HEAP=y
> # CONFIG_XENO_OPT_TIMER_WHEEL is not set
> CONFIG_XENO_OPT_TIMER_HEAP_CAPACITY=256
> ...
> 
> Maybe this has some influence as well. The 'RR' correlates with starting
> the hog, with or without gdb.
> 
> Jan
> 

-- 
Philippe.



