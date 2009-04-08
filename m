From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <49DCF4A7.807@domain.hid>
References: <49DCF4A7.807@domain.hid>
Content-Type: text/plain
Date: Thu, 09 Apr 2009 00:21:54 +0200
Message-Id: <1239229314.7007.42.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Excess getpid calls??
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: John Wojnaroski <castle@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-04-08 at 12:01 -0700, John Wojnaroski wrote:
> Hi
> 
> We're running several apps with scheduled realtime task using 
> rt_task_spawn() in a flight simulator.  There are two apps each for a 
> pilot and copilot and each app has 8 periodic tasks running at various 
> duty cycles from 1Hz to 50Hz.
> 
> A concern was raised as to whether the calls to getpid() were 
> excessive.  See trace ouput below....
> 
> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> 
> [1006]$ ps augx | grep -i copilot
> root      3561 24.7  5.6  51936 58108 ?        RLl  Apr01 2455:02 
> Source/Main/copilot --file=glass.cfg --window=0 0 2400 1050
> hcsl     20859  0.0  0.0   1820   532 pts/4    S+   09:55   0:00 grep -i 
> copilot
> (09:55) <hcsl on spire>: ~
> [1007]$ sudo !!
> sudo strace -p 3561 -c
> Process 3561 attached - interrupt to quit
> Process 3561 detached
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
> 92.78    0.179969           2     90067           getpid
> 5.67    0.010999           5      2247           ioctl
> 1.55    0.003000           1      2247           gettimeofday
> 0.00    0.000000           0         9           poll
> ------ ----------- ----------- --------- --------- ----------------
> 100.00    0.193968                 94570           total
> 
>  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> 
> We have not bored down into the xenomai source to see exactly what is 
> going on or where or how the calls are made as we've been quite happy 
> with the performance and stability.
> 
> Might someone shed a bit of light on the matter and should we be concerned?
> 

The Xenomai userland libs do not issue those calls routinely; actually,
only the interface library to the VxWorks emulator is known to directly
issue the getpid() call only once, when starting a watchdog server task
for the first time, which very unlikely matches your case.

Assuming that you are using the native Xenomai API, you may want to call
the rt_task_set_mode() service in order to set the T_WARNSW bit, so that
your application receives a SIGXCPU signal when it tries to issue a
Linux syscall such as getpid() (see examples/native/sigxcpu.c for some
demo code), then dump a backtrace to locate the call site. Issuing such
Linux calls in the middle of some RT processing is wrong, since it kicks
the application out of real-time mode until it reaches a Xenomai syscall
again, which is likely not what you want. So in short, yes, you should
be concerned for latency reasons.

Another option to locate the offending call spot is to use GDB, assuming
that getpid() indeed happens while your system is running, and not
simply as part of your application init chores. In that case, you may
try to run the app over GDB, setting a breakpoint on the getpid()
routine, setting a breakpoint "ignore count" high enough to dismiss the
calls due to the application setup code, during which running Linux
services is likely legit. Dumping the backtrace after the nth breakpoint
is eventually reached would give you some insight about who's doing
what:

e.g. to stop after the 1000th invocation of the getpid() service from
your app, and see who is doing so:

$ sudo su
# gdb Source/Main/copilot
(gdb) b getpid
Function "getpid" not defined.
Make breakpoint pending on future shared library load? (y or [n]) y
Breakpoint 1 (getpid) pending.
(gdb) ignore 1 1000
(gdb) run --file=glass.cfg --window=0 0 2400 1050
Breakpoint 1 in getpid () from ...

(gdb) bt


NOTE: you did not tell us about your setup:

- the Xenomai version number
- which kernel release and architecture
- which glibc/uClibc release/flavour.

> Thanks
> John W.
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



