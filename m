From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Mar 2014 13:45:55 -0400
Message-ID: <20140331174555.GO17765@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I am trying to port xenomai 2.6.3 and ipipe to 3.12 kernel, since 3.8
keeps randomly screwing up sigchld handling and causing segfaults in
programs at random.  3.12 does not do this, so rather than spent a lot
of time tracking down the difference, I am moving forward instead.

I took the ipipe 3.11 git tree diff and applied it against 3.12.14,
and fixed up the issues I found in applying the patch (I think there is
one powerpc issue I commented out because I couldn't make sense of it,
but since I currently am playing with arm, I don't mind that).
I compiled and booted with IPIPE turned on, and it did not appear to
cause any problems.

I then applied the xenomai-2.6 git tree patches to the kernel, and fixed
up a few compile issues (mainly CONFIG_GENERIC_HARDIRQS is gone and is
to be assumed to always be on with new kernels).  This too boots, and
the xenomai modules load without crashing.

switchtest seems to run OK and does this:

root@omap5:~# /usr/lib/xenomai/testsuite/switchtest 
== Testing FPU check routines...
d0: 1 != 2
d1: 1 != 2
d2: 1 != 2
d3: 1 != 2
d4: 1 != 2
d5: 1 != 2
d6: 1 != 2
d7: 1 != 2
d8: 1 != 2
d9: 1 != 2
d10: 1 != 2
d11: 1 != 2
d12: 1 != 2
d13: 1 != 2
d14: 1 != 2
d15: 1 != 2
== FPU check routines: OK.
== Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 rtk_fp_ufpp0-5 rtk_fp_ufpp0-6 rtup0-7 rtup0-8 rtup_ufpp0-9 rtup_ufpp0-10 rtus0-11 rtus0-12 rtus_ufps0-13 rtus_ufps0-14 rtuo0-15 rtuo0-16 rtuo_ufpp0-17 rtuo_ufpp0-18 rtuo_ufps0-19 rtuo_ufps0-20 rtuo_ufpp_ufps0-
21 rtuo_ufpp_ufps0-22 sleeper_ufps1-0 rtk1-1 rtk1-2 rtk_fp1-3 rtk_fp1-4 rtk_fp_ufpp1-5 rtk_fp_ufpp1-6 rtup1-7 rtup1-8 rtup_ufpp1-9 rtup_ufpp1-10 rtus1-11 rtus1-12 rtus_ufps1-13 rtus_ufps1-14 rtuo1-15 rtuo1-16 rtuo_ufpp1-17 rtuo_ufpp1-18 rtuo_ufps1-19 rtuo_ufps1-20 rtuo_u
fpp_ufps1-21 rtuo_ufpp_ufps1-22
RTT|  00:00:01
RTH|---------cpu|ctx switches|-------total
RTD|           1|       17041|       17041
RTD|           0|       17041|       17041
RTD|           1|       17043|       34084
RTD|           0|       16974|       34015
RTD|           1|       17045|       51129
RTD|           0|       17043|       51058
RTD|           1|       16974|       68103
RTD|           0|       16840|       67898
RTD|           0|        5033|       72931
RTD|           1|        5035|       73138
...

And /proc/xenomai/stat shows:
root@omap5:~# cat /proc/xenomai/stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          6271365    0     00500080   94.2  ROOT/0
  1  0      0          6288303    0     00500088   94.2  ROOT/1
  0  4501   1          1          0     00b00380    0.0  switchtest
  0  0      0          2929       0     00004082    0.0  rtk1/0
  0  0      0          2929       0     00004082    0.0  rtk2/0
  0  0      0          2929       0     00104082    0.0  rtk3/0
  0  0      0          2929       0     00104082    0.0  rtk4/0
  0  0      0          2929       0     00104082    0.0  rtk5/0
  0  0      0          2929       0     00104082    0.0  rtk6/0
  0  4505   2          2931       0     00304182    0.0  rtup0-7
  0  4506   2          2931       0     00304182    0.0  rtup0-8
  0  4507   2          2931       0     00304182    0.0  rtup_ufpp0-9
  0  4508   2          2931       0     00304182    0.0  rtup_ufpp0-10
  0  4509   3          3          0     00300380    0.0  rtus0-11
  0  4510   3          3          0     00300380    0.0  rtus0-12
  0  4511   3          3          0     00300380    0.0  rtus_ufps0-13
  0  4512   3          3          0     00300380    0.0  rtus_ufps0-14
  0  4513   490        1955       0     00300380    0.0  rtuo0-15
  0  4514   490        1955       0     00300380    0.0  rtuo0-16
  0  4515   490        1955       0     00300380    0.0  rtuo_ufpp0-17
  0  4516   490        1955       0     00300380    0.0  rtuo_ufpp0-18
  0  4517   490        1955       0     00300380    0.0  rtuo_ufps0-19
  0  4518   490        1955       0     00300380    0.0  rtuo_ufps0-20
  0  4519   490        1955       0     00300380    0.0  rtuo_ufpp_ufps0-21
  0  4520   490        1955       0     00300380    0.0  rtuo_ufpp_ufps0-22
  1  0      0          2941       0     00004082    0.0  rtk1/1
  1  0      0          2941       0     00004082    0.0  rtk2/1
  1  0      0          2941       0     00104082    0.0  rtk3/1
  1  0      0          2941       0     00104082    0.0  rtk4/1
  1  0      0          2941       0     00104082    0.0  rtk5/1
  1  0      0          2940       0     00104082    0.0  rtk6/1
  1  4522   2          2940       0     00304182    0.0  rtup1-7
  1  4523   2          2940       0     00304182    0.0  rtup1-8
  1  4524   2          2940       0     00304182    0.0  rtup_ufpp1-9
  1  4525   2          2940       0     00304182    0.0  rtup_ufpp1-10
  1  4526   3          3          0     00300380    0.0  rtus1-11
  1  4527   3          3          0     00300380    0.0  rtus1-12
  1  4528   3          3          0     00300380    0.0  rtus_ufps1-13
  1  4529   3          3          0     00300380    0.0  rtus_ufps1-14
  1  4530   492        1963       0     00300380    0.0  rtuo1-15
  1  4531   492        1963       0     00300380    0.0  rtuo1-16
  1  4532   492        1963       0     00300380    0.0  rtuo_ufpp1-17
  1  4533   492        1963       0     00300380    0.0  rtuo_ufpp1-18
  1  4534   491        1962       0     00304182    0.0  rtuo_ufps1-19
  1  4535   491        1962       0     00304182    0.0  rtuo_ufps1-20
  1  4536   491        1962       0     00304182    0.0  rtuo_ufpp_ufps1-21
  1  4537   491        1962       0     00304182    0.0  rtuo_ufpp_ufps1-22
  1  0      0          1228306    0     00000000    0.1  IRQ27: [timer]

So I think it can't be all bad.

However I keep getting illegal instruction on most of the other testsuite
programs.  I must admit I have NOT recompiled the xenomai runtime and
libraries after upgrading the kernel from 3.8 to 3.12, since the xenomai
version is the same and I figured it wouldn't matter (I was going to
try that soon though, just in case).

For example:

root@omap5:~# strace /usr/lib/xenomai/testsuite/mutex-torture-native 
....
futex(0xb6fb719c, FUTEX_WAKE_PRIVATE, 2147483647) = 0
open("/dev/rtheap", O_RDWR)             = 3
ioctl(3, 0, 0xeef15010)                 = 0
mmap2(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0xf56bb) = 0xb6fc7000
close(3)                                = 0
futex(0xb6fb7248, FUTEX_WAKE_PRIVATE, 2147483647) = 0
open("/dev/rtheap", O_RDWR)             = 3
ioctl(3, 0, 0xbf155180)                 = 0
mmap2(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0xf54ef) = 0xb6e0a000
close(3)                                = 0
futex(0xb6fb724c, FUTEX_WAKE_PRIVATE, 2147483647) = 0
futex(0xb6fb71a8, FUTEX_WAKE_PRIVATE, 2147483647) = 0
futex(0xb6fb7320, FUTEX_WAKE_PRIVATE, 2147483647) = 0
mlockall(MCL_CURRENT|MCL_FUTURE)        = 0
rt_sigaction(SIGXCPU, {0x9069, [], SA_SIGINFO|0x4000000}, NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [WINCH], [], 8) = 0
rt_sigaction(SIGWINCH, {0xb6fad6d1, [], SA_RESTART|SA_SIGINFO|0x4000000}, {SIG_DFL, [], 0}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
futex(0xb6fb72e4, FUTEX_WAKE_PRIVATE, 2147483647) = 0
write(2, "simple_wait\n", 12)           = ? ERESTARTSYS (To be restarted)
--- SIGWINCH (Window changed) @ 0 (0) ---
sched_setscheduler(4540, SCHED_FIFO, { 2 }) = 0
rt_sigreturn(0x1)                       = 2
write(2, "simple_wait\n", 12simple_wait
)           = 12
sched_get_priority_min(SCHED_FIFO)      = 1
sched_get_priority_max(SCHED_FIFO)      = 99
mmap2(NULL, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6e02000
mprotect(0xb6e02000, 4096, PROT_NONE)   = 0
sched_get_priority_min(SCHED_FIFO)      = 1
sched_get_priority_max(SCHED_FIFO)      = 99
clone(child_stack=0xb6e08fa8, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=0xb6e094d8, tls=0xb6e09930, child_tidptr=0xb6e094d8) = 4541
sched_setscheduler(4541, SCHED_FIFO, { 2 }) = 0
futex(0xb6e09684, FUTEX_WAKE_PRIVATE, 1) = 1
+++ killed by SIGILL +++
Illegal instruction

I am going to have to try it with gdb, and hopefully that will give me
a clue.

Does anyone have any hints on how to track this down, or even for how
to properly test that moving to 3.12 is actually working.

I will send some patches when I get this working.

-- 
Len Sorensen

