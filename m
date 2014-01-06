MIME-Version: 1.0
Date: Mon, 6 Jan 2014 15:30:33 +0000
Message-ID: <CAKJ14NdsfwK4Vj=UpYb6p9bvFE=1ZoQb6ss--9f-WqXOXGDn2g@mail.gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Command line freeze during xeno-regression-test on
	omap4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I managed to produce a kernel (v3.8.13) with xenomai 2.6.3 ipipe patch and
rootfs (debian wheezy) with xenomai 2.6.3 libraries for my Pandaboard ES
(omap4460). The simple regression test, which only calls dd during the
switchtest, works fine. However the regression test with the linux test
project (ltp-full-20130904) scripts causes some sort of system lock up.
After that I only can ctrl-c xeno-regression-test (i.e. switchtest), which,
however, doesn't help to regain console access (neigher over ethernet nor
serial).

Here's what I did:

-- Building --
As recomended in the Xenomai 2.6 readme I followed the instructions in [1]
to produce a kernel and filesystem. To get a xenomai kernel I had to do
three things differently:

*) I used: git checkout origin/v3.8.x -b tmp
*) I applied ipipe-core-3.8.13-arm-3.patch from the xenomai-2.6 git tree as
described in the Xenomai 2.6 readme
*) I disabled KGDB and TIDSPBRIDGE since those produced compile errors (see
config [2])

After a while I obtained the following messages from dmesg [3] and from the
command prompt:

root@arm:~# cat /proc/version
Linux version 3.8.13-x3.6 (aglatz@linuxvbox) (gcc version 4.7.3 20130328
(prerelease) (crosstool-NG linaro-1.13.1-4.7-2013.04-20130415 - Linaro GCC
2013.04) ) #4 SMP Sat Jan 4 15:54:20 GMT 2014

-- Testing Linux --
To see if everything works I downloaded and cross-compiled
ltp-full-20130904 [4] with the same toolchain and flags (-march=armv7-a
-mfpu=vfp3) as the xenomai libs and runtime. I started ltp with "./runltp
-p -l dohell-2014-01-06-1.log -S xenomai.skiplist" and after a while it
finished with a few failed tests [5]. The console access, however, worked
fine.

-- Testing Xenomai --
First I sucessfully could run the simple xenomai regression test:
xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m /tmp 100" -t
2 which produced the output in [6] and the following additional messages
with dmesg:

[  476.215057] Xenomai: RTDM: closing file descriptor 1.
[  477.434936] Xenomai: Posix: destroying semaphore f0069c00.
[  477.440887] Xenomai: Posix: destroying mutex f0069a00.
[  477.475372] xnheap: destroying shared heap 'rt_heap: heap' with 16384
bytes still in use.
[  479.008453] Xenomai: Switching rt_task to secondary mode after exception
#0 from user-space at 0x9620 (pid 2145)
[  480.574462] Xenomai: watchdog triggered -- signaling runaway thread
'rt_task'
[  480.582061] [sched_delayed] sched: RT throttling activated
[  557.336425] Xenomai: Posix: closing message queue descriptor 3.

and  "cat /proc/xenomai/*" produced [7].

When I started the realistic xenomai regression test: xeno-regression-test
-l "/usr/lib/xenomai/testsuite/dohell -m /tmp -l /opt/ltp" -t 2 everything
seemed fine at first - I could logon and start top to inspect the running
processes. However, the command line (over serial and ethernet)
consistently freezes after a while (at different ltp tests though). First I
thought it's the massive system load which doesn't leave CPU for the
console... however ctrl-c of xeno-regression-test does not help to regain
console access... even after waiting for ~10mins I could not regain access
to the existing consoles nor new consoles over ethernet. It seems to me
that every syscall into the kernelspace causes the calling process getting
blocked and never scheduled again.

-- Remaining questions --
*) Has anyone experienced something similar and/or found a(n)
explanation/fix/workaround?
*) Are there more debugging options I could try?

Thanks for any help,

Andreas

-- References --
[1] http://eewiki.net/display/linuxonarm/PandaBoard
[2]
https://dcn060062.dcn.ed.ac.uk/main.php?cmd=image&var1=XenomaiOnArm%2F3.8.13-x3.6.config
[3]
https://dcn060062.dcn.ed.ac.uk/main.php?cmd=image&var1=XenomaiOnArm%2Fdmesg_after_boot.txt
[4]
https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20130904/ltp-full-20130904.tar.xz/download
[5]
https://dcn060062.dcn.ed.ac.uk/main.php?cmd=image&var1=XenomaiOnArm%2Fdohell-2014-01-06-1.log
[6]
https://dcn060062.dcn.ed.ac.uk/main.php?cmd=image&var1=XenomaiOnArm%2Fxeno-regression-test_simple.txt
[7]
https://dcn060062.dcn.ed.ac.uk/main.php?cmd=image&var1=XenomaiOnArm%2Fxeno-regression-test_realistic_proc.txt
