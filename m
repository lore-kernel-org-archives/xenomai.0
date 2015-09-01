Message-ID: <55E5E453.1080400@xenomai.org>
Date: Tue, 01 Sep 2015 13:45:55 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
In-Reply-To: <CAJqUr7ybpmgOev-iPaQ-iMEAF8SBocn54vyYSbLcm9spMY=FBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai/ipipe arm64 port
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, don@mperpetuo.com

On 08/24/2015 08:13 PM, Don Mahurin wrote:
> Hi all,
> 
> We would like to submit our current work on the arm64 port of
> ipipe/xenomai. We hope that this contribution will encourage further
> development of arm64 support in ipipe/xenomai.
> 
> This port was largely developed on ipipe-3.10 as a base, so it is likely to
> be the most well tested there. Though recently, we have also ported these
> changes to ipipe-3.14.44. ( We noticed that 3.10 is missing from rc7. Is
> this intended, or will 3.10 support return? )
> 
> At the end of this message are the relevant git repos and branches for the
> arm64 port. Also included is a build script to build a minimal busybox
> linux system which may be ran using qemu (arm64 virt).
> 
> 
> Development status:
> 
> The 3.14 port is missing the fast-syscall changes (in entry.S) from armv7,
> and instead contains the 3.10 entry.S changes forward ported to 3.14.
> 
> FPU support is incomplete.
> 
> Smokey tests:
> 
> 3.10/rc6 smokey tests all pass
> 3.14/rc6 smokey tests all pass
> 3.14/rc7 smokey tests sched-quota and sched-tp fail
> 
> 
> git repos:
> 
> https://gitlab.mperpetuo.com/it/xenomai-3.git
> https://gitlab.mperpetuo.com/it/ipipe.git
> https://gitlab.mperpetuo.com/it/build-scripts.git
> 
> ipipe/xenomai arm64 branches:
> 
> ipipe-core-3.10.32-arm-10-arm64-2c, v3.0-rc6-arm64-1c
> ipipe-core-3.14.44-arm-11-arm64-2, v3.0-rc6-arm64-1c
> ipipe-core-3.14.44-arm-12-arm64-2, v3.0-rc7-arm64-1c
> 
> 

Don,

I picked up your trees (branches below):

- ipipe branch: ipipe-core-3.14.44-arm-12-arm64-2
- xenomai branch: v3.0-rc7-arm64-1c).

I then merged them on HiKey's octacore A53 [0] vendor tree [1] previously
patched with ipipe:
- ipipe -core-3.18.12-arm-4.patch

root@linaro-developer:/usr/xenomai/bin# cat /proc/ipipe/version
12

root@linaro-developer:/usr/xenomai/bin# cat /proc/xenomai/version


3.0-rc7

root@linaro-developer:/usr/xenomai/bin# cat /proc/cpuinfo
Processor       : AArch64 Processor rev 3 (aarch64)
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32
CPU implementer : 0x41
CPU architecture: AArch64
CPU variant     : 0x0
CPU part        : 0xd03
CPU revision    : 3

Hardware        : HiKey Development Board

With these changes in, I was able to execute the xeno-test suppported suite [non
SMP] (results below).

During the latency tests + dohell however I was getting a number of these events.
Have you happen to notice them during your runs?


[  210.661546] ls[1638]: unhandled level 2 translation fault (11) at 0x00000000,
esr 0x92000006
[  210.789815] pgd = ffffffc034fab000
[  210.853570] [00000000] *pgd=0000000037f8c003, *pud=0000000037f8c003,
*pmd=0000000000000000
[  210.923645]
[  211.029789] CPU: 0 PID: 1638 Comm: ls Not tainted 3.18.0-ipipe+ #3
[  211.135697] task: ffffffc034eb2ec0 ti: ffffffc035228000 task.ti: ffffffc035228000
[  211.239840] PC is at 0x7fb2d65b90
[  211.335692] LR is at 0x7fb2d58e60
[  211.343190] pc : [<0000007fb2d65b90>] lr : [<0000007fb2d58e60>] pstate: 40000000
[  211.503681] sp : 0000007fc4bfeda0
[  211.605713] x29: 0000007fc4bfeda0 x28: 0000000000000000
[  211.615535] x27: 000000002ae23100 x26: 0000000000000000
[  211.805734] x25: 000000002ae23130 x24: 000000002ae2ccb0
[  211.815575] x23: 0000007fb2e977f0 x22: 0000000000429000
[  212.005751] x21: 0000000000000000 x20: 0000000000000000
[  212.085690] x19: 0000007fb2e2e178 x18: 000000000000000d
[  212.095575] x17: 0000007fb2d58e44 x16: 0000000000429318
[  212.269880] x15: 0000007fb2e2f588 x14: 0000000000000000
[  212.359708] x13: 0000000001000000 x12: 0000000000000002
[  212.449749] x11: 0101010101010101 x10: 0000000000000000
[  212.579720] x9 : ff717373602e3231 x8 : 000000002ae25590
[  212.676101] x7 : 0000000000000000 x6 : 0000000000000000
[  212.779470] x5 : 0000000000000005 x4 : 0000000000000000
[  212.880130] x3 : 0000000000000000 x2 : 0000000000000000
[  212.959890] x1 : 0000000000000000 x0 : 0000000000000000




root@linaro-developer:/usr/xenomai/bin# ./xeno-test
Started child 1574: /bin/bash /usr/xenomai/bin/xeno-test-run-wrapper ./xeno-test
++ echo 0
++ testdir=/usr/xenomai/bin
++ /usr/xenomai/bin/smokey --run
arith OK
bufp skipped (no kernel support)
iddp skipped (no kernel support)
leaks OK
posix_clock OK
posix_cond OK
posix_fork OK
mutex_trylock not supported
posix_mutex OK
posix_select OK
rtdm skipped (no kernel support)
sched_quota skipped (no kernel support)
sched_tp skipped (no kernel support)
sigdebug skipped (no kernel support)
timerfd OK
vdso_access OK
xddp skipped (no kernel support)
++ /usr/xenomai/bin/clocktest -D -T 30 -C CLOCK_HOST_REALTIME
XNVDSO_FEAT_HOST_REALTIME not available
== Testing built-in CLOCK_HOST_REALTIME (32)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0                  0.0            0.000          0            0.0
clock_gettime failed for clock id 32
XNVDSO_FEAT_HOST_REALTIME not available
++ /usr/xenomai/bin/clocktest -T 30
== Testing built-in CLOCK_REALTIME (0)
CPU      ToD offset [us] ToD drift [us/s]      warps max delta [us]
--- -------------------- ---------------- ---------- --------------
  0  -1404413153131434.2            0.028          0            0.0
++ /usr/xenomai/bin/switchtest -T 30
== Testing FPU check routines...
== FPU check routines: unimplemented, skipping FPU switches tests.
== Threads: sleeper-0 rtk-1 rtk-2 rtup-3 rtup-4 rtus-5 rtus-6 rtuo-7 rtuo-8
RTT|  00:00:01
RTH|ctx switches|-------total
RTD|        8208|        8208
RTD|        8208|       16416
RTD|        8210|       24626
RTD|        8208|       32834
RTD|        8208|       41042
RTD|        7961|       49003
RTD|        8208|       57211
RTD|        8210|       65421
RTD|        8210|       73631
RTD|        8231|       81862
RTD|        8208|       90070
RTD|        8185|       98255
RTD|        8208|      106463
RTD|        8154|      114617
RTD|        8213|      122830
RTD|        8208|      131038
RTD|        8208|      139246
RTD|        8210|      147456
RTD|        8208|      155664
RTD|        8208|      163872
RTD|        8210|      172082
RTT|  00:00:22
RTH|ctx switches|-------total
RTD|        8249|      180331
RTD|        8210|      188541
RTD|        8208|      196749
RTD|        8208|      204957
RTD|        8210|      213167
RTD|        8231|      221398
RTD|        8208|      229606
RTD|        8210|      237816
RTD|        7992|      245808
++ start_load
++ echo start_load
++ check_alive /usr/xenomai/bin/latency
++ echo check_alive /usr/xenomai/bin/latency
++ wait_load
++ read rc
Started child 1630: dohell 900
Started child 1635: /usr/xenomai/bin/latency
== Sampling period: 1000 us
== Test mode: periodic user-mode task
== All results in microseconds
warming up...
RTT|  00:00:01  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      4.167|      7.106|     16.667|       0|     0|      4.167|     16.667
RTD|      4.167|      7.116|     18.334|       0|     0|      4.167|     18.334
RTD|      4.167|      6.843|     12.500|       0|     0|      4.167|     18.334
RTD|      4.167|      6.939|     13.334|       0|     0|      4.167|     18.334
RTD|      4.167|      6.937|     17.500|       0|     0|      4.167|     18.334
...
...
...
RTT|  00:06:19  (periodic user-mode task, 1000 us period, priority 99)
RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--lat worst
RTD|      4.167|      6.143|     11.667|       0|     0|      3.334|     60.000
RTD|      4.167|      6.214|     13.334|       0|     0|      3.334|     60.000
RTD|      4.167|      6.213|     11.667|       0|     0|      3.334|     60.000
RTD|      4.167|      6.241|     12.500|       0|     0|      3.334|     60.000
RTD|      4.167|      6.126|     11.667|       0|     0|      3.334|     60.000
RTD|      4.167|      6.206|     12.500|       0|     0|      3.334|     60.000
RTD|      4.167|      5.984|     12.500|       0|     0|      3.334|     60.000
RTD|      4.167|      6.132|     13.334|       0|     0|      3.334|     60.000



[0] https://www.96boards.org/products/ce/hikey/
[1] https://github.com/96boards/linux

