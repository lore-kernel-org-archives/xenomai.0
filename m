From: Travis Stratman <tstratman@domain.hid>
In-Reply-To: <1273875426.6334.461.camel@domain.hid>
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D72A@alpine.pivotalsys.com>
	<4BED7D5B.6050605@domain.hid>
	<1273866035.6334.435.camel@domain.hid>
	<4BEDC668.40708@domain.hid>
	<1273875426.6334.461.camel@domain.hid>
Date: Fri, 14 May 2010 18:37:45 -0500
Message-Id: <1273880265.6334.487.camel@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_mutex created prior to main causes
	board	to	freeze?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, 2010-05-14 at 17:17 -0500, Travis Stratman wrote:
>  > > Using strace I was able to determine that the first statements in main()
> > > were not even reached. The strace output would generally stop on access
> > > to /dev/rtheap or rt_sigaction(SIGXCPU...). My suspicion was the global
> > > object instantiation calling rt_mutex_create().
> > 
> > I would suspect an issue with the fast mutexes, since they require a
> > shared heap to have been mapped prior to the mutex creation. But if you
> > say you saw the same issue on 2.4.8, it must be something completely
> > different. I will try and reproduce the issue ASAP.
> > 
> 
> Thanks! Come to think of it I don't recall ever seeing access to rtheap
> on the 2.4.8 traces, just the rt_sigaction. BTW the code is being
> cross-compiled using gcc-4.2.4 arm-linux-gnueabi-g++ with -march=armv5te
> -mtune=arm926ej-s flags. Let me know what else I can provide that will
> be helpful.

I went back and took an strace of the code that caused the board to fail
on 2.5.2 with the pointers initialized in main() but before mlockall().
This is where the strace stops:
....
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x1020000
syscall_983045(0x101fee0, 0x101fee0, 0x1020638, 0x10205b8, 0x1023058, 0, 0x58, 0xf0005, 0xffff5bfc, 0x1023058, 0x1023000, 0x1cd8b1c, 0, 0x1cd87f8, 0x8, 0x1
001ffc, 0x20000010, 0x101fee0, 0xc4a0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) = 0
mprotect(0x141f000, 4096, PROT_READ)    = 0
mprotect(0x135d000, 4096, PROT_READ)    = 0
mprotect(0x134e000, 8192, PROT_READ)    = 0
....

On the second and third time that I ran after resetting it it got a
little farther:
....
mprotect(0x141f000, 4096, PROT_READ)    = 0
mprotect(0x135d000, 4096, PROT_READ)    = 0
mprotect(0x134e000, 8192, PROT_READ)    = 0
mprotect(0x1229000, 8192, PROT_READ)    = 0
mprotect(0x103e000, 4096, PROT_READ)    = 0
munmap(0x101c000, 4779)                 = 0
epoll_wait(0x101fa88, 0x1cbae14, 0x1cbae1c, 0x10279a0) = 984
ipc_subcall(0x101fa90, 0xc, 0x101faa8, 0xffffffec) = 0
rt_sigaction(SIGRTMIN, {0x1027f3c, [], SA_SIGINFO|0x4000000}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0x1027e10, [], SA_RESTART|SA_SIGINFO|0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
brk(0)                                  = 0x2c000
brk(0x4d000)                            = 0x4d000
futex(0x122f348, FUTEX_WAKE, 2147483647) = 0
rt_sigaction(SIGILL, {0x10431ec, [ILL], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGILL, {SIG_DFL}, {0x10431ec, [ILL], SA_RESTART|0x4000000}, 8) = 0
open("/dev/mem", O_RDONLY|O_SYNC)       = 3
mmap2(NULL, 4096, PROT_READ, MAP_SHARED, 3, 0xfffa0) = 0x101c000
close(3)                                = 0
open("/dev/rtheap", O_RDWR)             = 3
ioctl(3, 0, 0xc1eef410)                 = 0
mmap2(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) = 0x1421000
close(3)                                = 0
open("/dev/rtheap", O_RDWR)             = 3
ioctl(3, 0, 0xc03c5088)                 = 0
mmap2(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0)
....

The relevant code in main() looks like this:
----
  g_terminate = new SyncObject<int>("terminate");
  g_log_level = new SyncObject<int>("log level");
  g_temperature = new SyncObject<int>("temperature");
  g_set_point = new SyncObject<SetPoint> ("Set Point");
  g_decimation = new SyncObject<int>("decimation");
  g_flow_feedback = new SyncObject<int>("flow feedback");
  g_valve_override = new SyncObject<int>("valve override");

  signal(SIGTERM, handleShutdownSignal);
  signal(SIGINT, handleShutdownSignal);

  signal(SIGXCPU, handleTaskModeChange);

  mlockall(MCL_CURRENT | MCL_FUTURE);
----

I then moved the instantiation back below mlockall() and tested to make
sure that it was still working (it does). To make for a more
reproducible test I added a mutex directly in main() and tested it
before and after the mlockall(), leaving all other code as-is. i.e.:
----
RT_MUTEX test_mutex;
....
rt_mutex_create(&test_mutex, "test_mutex");
----

If rt_mutex_create() is before mlockall() the board freezes. If it is
after, the application continues. strace shows similar behavior to the
above listings.

However, when I added a similar test to a very simple timer task
application that I have, I could not reproduce the issue.

Thanks
> 
> -Travis
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


