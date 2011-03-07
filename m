MIME-Version: 1.0
Date: Sun, 6 Mar 2011 23:32:05 -0500
Message-ID: <AANLkTik7MKLjvrZY1BsowqBtodJoP7fUt6--H4WOS-W4@domain.hid>
From: Eric Eric <ericrebates@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] irqloop hangs on Beagleboard ARM with 2.5.5.2/2.6.33
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi, I'm attempting to run irqloop/irqbench and irqloop just appears to
hang indefinitely.  Behavior is the same with -t0 and -t1.  I am able
to successfully run other tests such as latency and switchtest.  Below
is the output of strace ./irqloop -t1. xeno_irqbench is loaded, I have
a null modem cable connected to an x86 running irqbench and have
disabled the serial log output and serial tty on the beagle.

futex(0x40040d60, FUTEX_WAKE_PRIVATE, 2147483647) = 0
open("/dev/rtheap", O_RDWR)             = 3
ioctl(3, 0, 0xc08aa1d8)                 = 0
mmap2(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x4017a000
close(3)                                = 0
futex(0x40040d64, FUTEX_WAKE_PRIVATE, 2147483647) = 0
futex(0x40040c8c, FUTEX_WAKE_PRIVATE, 2147483647) = 0
futex(0x40040d50, FUTEX_WAKE_PRIVATE, 2147483647) = 0
rt_sigaction(SIGXCPU, {0x400362f0, [], SA_SIGINFO|0x4000000}, NULL, 8) = 0
mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
sched_getparam(2947, { 0 })             = 0
sched_getscheduler(2947)                = 0 (SCHED_OTHER)
brk(0)                                  = 0x12000
brk(0x33000)                            = 0x33000
rt_sigaction(SIGWINCH, {0x40036e58, [],
SA_RESTART|SA_SIGINFO|0x4000000}, {SIG_DFL, [], 0}, 8) = 0
--- SIGWINCH (Window changed) @ 0 (0) ---
sched_setscheduler(2947, SCHED_OTHER, { 0 }) = 0
rt_sigreturn(0x1)                       = 0
futex(0x40040c90, FUTEX_WAKE_PRIVATE, 2147483647) = 0
munlockall()                            = 0
sched_get_priority_max(SCHED_FIFO)      = 99
rt_sigaction(SIGINT, {0x8adc, [INT], SA_RESTART|0x4000000}, {SIG_DFL,
[], 0}, 8) = 0
rt_sigaction(SIGTERM, {0x8adc, [TERM], SA_RESTART|0x4000000},
{SIG_DFL, [], 0}, 8) = 0
rt_sigaction(SIGHUP, {0x8adc, [HUP], SA_RESTART|0x4000000}, {SIG_DFL,
[], 0}, 8) = 0
mlockall(MCL_CURRENT|MCL_FUTURE)        = 0

Thanks for any assistance.

- Eric

