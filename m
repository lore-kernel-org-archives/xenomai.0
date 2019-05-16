From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai Mercury and PREEMPT_RT
References: <1823257552.1557117297954.94.KebiMail.daeyoungsong@cnu.ac.kr>
 <4c39d8ca-3c98-4b35-6b06-2013dc80134b@xenomai.org>
 <1907767262.9872848.1557212015078.JavaMail.zimbra@wolfram.com>
Message-ID: <f5509493-8ef4-f7df-feba-e700dc2ded02@xenomai.org>
Date: Thu, 16 May 2019 17:51:51 +0200
MIME-Version: 1.0
In-Reply-To: <1907767262.9872848.1557212015078.JavaMail.zimbra@wolfram.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Per Oberg <pero@wolfram.com>
Cc: =?UTF-8?B?7Iah64yA7JiB?= <daeyoungsong@cnu.ac.kr>, xenomai <xenomai@xenomai.org>

On 5/7/19 8:53 AM, Per Oberg wrote:
> 
> ----- Den 6 maj 2019, på kl 10:07, xenomai xenomai@xenomai.org skrev:
>> On 5/6/19 6:34 AM, 송대영 via Xenomai wrote:
>>> [webmailreconf.public.do?24538165]
> 
>>> Hello, expert.
> 
>>> I have a question about Xenomai Mercury and PREEMPT_RT.
>>> Following "Xenomai 3 – An Overview of the Real-Time Framework for
>>> Linux", Mercury is based on PREEMPT_RT and only offers API emulation.
>>> Is Mercury's latency performance better than PREEMPT_RT?
> 
>> No, it merely uses what native preemption provides for.
> 
> So, just to be clear. Are you saying that it should be "Just as good" as PREEMPT.RT when the kernel is fully patched? (Whatever that means...)
> 
> Now, I don't want to start a flame-war here, that would be stupid. But I really want to know your opinion on this (see for eaxmple claims made in [1]). May we assume that the Mercury performance would be quite close to Cobolt performance ?

The so-called "Mercury" layer allows to run the Xenomai APIs (e.g.
alchemy, vxworks, pSOS) on a single kernel system, i.e. without
assistance of any co-kernel like Cobalt. This is a mediating interface
library getting the real-time POSIX services it needs to run those APIs
from the plain glibc, instead of libcobalt. Therefore, this purely
user-space layer cannot bring more real-time guarantees than the
underlying native kernel is able to deliver.

Regarding this presentation at ELCE 2016, one of the many claims was
that native preemption delivers about the same if not better worst case
latency figures than a dual kernel configuration like Xenomai/cobalt
does on Altera's SoCFPGA Cyclone V. This does not involve Mercury.

As mentioned in slide #25 of the presentation [1], the benchmark leading
to this conclusion ran on an Altera SocFPGA Cyclone V, with two Cortex
A9 cores. However, there is no mention of the kernel, I-pipe or Xenomai
releases being tested, which is unfortunate. The test was about
measuring the response time to an external device interrupt from a
user-space task, but we don't know what the Xenomai test application
looked like, neither do we know which driver code was involved in
performing real-time I/O on the input and output pins operated by
Xenomai, which is again unfortunate since this is key to timely
behavior. From an engineering standpoint, when 431999999 samples are
below 65µ and only 1 sample is above 95µ over a 12 hours long test, it
seems legitimate to wonder whether some bug might be hiding under the sofa.

Also, I'm unsure why CPU isolation (isolcpus=) was omitted from the
Xenomai test although it is present for the best-performing native
preemption test. On this particular hardware which exhibits a
not-that-snappy outer L2 cache with write-allocate policy enabled, this
is an
unfortunate choice too. This means that for such test, the native
preemption test has benefited from hot cache conditions most of the time
since the stress load was always running on a separate CPU. At the
opposite, the Xenomai test application was continuously battered by
costly cache misses as the stress threads kept causing I/D cache line
evictions, pushing away the real-time code and data each time the
sampling thread slept waiting for the next measurement period on the
shared CPU.

In addition, the 10Khz sampling loop which is presented may be too fast
to uncover the actual cost of cache misses. The faster the real-time
loop, the fewer the opportunities for the non real-time work to disturb
the shared environment both run in. Running a slower, 1Khz loop seems
more appropriate to lower the odds of cache evictions, at least if one
is looking for real-world runtime conditions where a system may have to
execute a significant amount of code concurrently, some of which
requiring low jitter in wake up times, but not necessarily for pacing
high frequency loops.

Although there is not enough information to exactly reproduce this
benchmark configuration, we can easily run a simple timer-based test
scenario with what is at hand, which is the same SoCFPGA hardware, and
the latency test developed by the native preemption team, which Xenomai
can run too. To confirm whether CPU isolation may have played a role in
these results, the Xenomai test should run twice, once on an isolated
CPU, next without this optimization. I'll try to give an exhaustive
description of the test recipe I used, so that it be can reproduced
easily in your kitchen:

* native preemption setup

- download kernel 5.0.14 in source form, apply -rt8 patch from [2].
- enable maximum preemption (CONFIG_PREEMPT_RT_FULL).
- boot the kernel with "isolcpus=1 threadirqs".
- check that no threaded IRQ can compete with SCHED_FIFO,98. Normally
  there should be none of them, but you may want to double-check if you
  have custom IRQ settings at boot time.
- switch to a non-serial terminal (ssh, telnet); significant output to
  a serial device might affect the worst case latency on some
  platforms with native preemption because of implementation issues in
  console drivers, so the console should be kept quiet. You could also
  add the "quiet" option to the boot args as an additional precaution.
- for good measure, turn off SCHED_FIFO throttling by setting
  /proc/sys/kernel/sched_rt_runtime_us to -1. This should definitely
  not be needed for the kind of test we are about to run, but let's
  move this away for peace of mind.
- wakeup events are produced by a timer, so there is no IRQ threading
  for these ones which are fully handled from a so-called hard IRQ
  context, so no IRQ (software) priority issue. Since the TWD
  timer we use from the Cortex A9 is a per-core beast, there won't be
  any CPU affinity issue either: a tick on CPU1 will wake up the
  sampling thread on CPU1.

* Xenomai setup

- git clone code from [3], which is kernel 4.19.33 including the
  I-pipe patch.
- git clone the Xenomai code from [4], which is the base of the
  upcoming 3.1 release.
- boot the kernel with "isolcpus=1"
- run the "autotune" utility to best calibrate the core timer gravity
  values (more info at [5]). This is not required here since the default
  values are close enough for this SoC though.

Although the base kernel releases are not identical, they are still
close enough, and experience shows that the figures are fairly stable
regardless of the kernel release under test, at least with a working
Xenomai port.

* for both kernel setups

- turn off all debug features and tracers in the kernel configuration.
- ensure that all CPUs keep running at maximum frequency by enabling
  the "performance" CPU_FREQ governor, or disabling CPU_FREQ entirely.
- turn CPU_IDLE on, disabling the ARM_CPUIDLE driver for entering the
  idle state via basic WFI. This said, you could alternatively enable
  ARM_CPUIDLE on this particular platform, this should not increase
  the worst case latency.
- disable graphic support to rule out any weird GPU driver issue.

* stress load

For both tests, part of the stress load is generated by the 'hackbench'
program mentioned in the presentation, which is available from [6],
linked against the plain glibc. Running it with 40 groups is enough to
bring the system down to a crawl. The command started at the beginning
of both runs is:

# while :; do hackbench -g 40 -l 30000 >/dev/null 2>&1; sleep 1; done&

However, running 'hackbench' is not enough to observe the worst latency
peaks on most platforms. Since we want to estimate such worst case,
let's tickle the dragon's tail by adding a plain simple 'dd' loop in the
background, reading a large enough bulk of memory from /dev/zero
repeatedly. In effect, this pounds the memory subsystem badly by
continuously clearing RAM, putting more pressure on data caches. The
command used is:

# dd if=/dev/zero of=/dev/null bs=32M &

* test application

We can use the 'cyclictest' latency measurement code also available from
[6], linking it against the plain glibc for the native preemption test,
or against Xenomai's POSIX libcobalt interface for the dual kernel
setup. The source code of the pre-compiled version of 'cyclictest' for
Xenomai is available at [7]. The command starting the measurement for
12hrs is:

# cyclictest -l43200000 -a 1 -m -n -p98 -i1000 -h200 -q > results.lat&

This test application is pinned to the isolated CPU #1 which has been
excluded from the load balancing scheme, process memory is locked. The
latency sampling thread is set to SCHED_FIFO,98 in both tests, since
this is the highest priority level we may use for a user-space
application without interfering with critical kernel activities in the
native preemption case. Actually we could have used priority 1 for
Xenomai for the same latency results, since the Xenomai scheduler always
has precedence over the regular kernel scheduler. The sampling frequency
is set to 1Khz. The so-called "clock_nanosleep mode" is used, which is
definitely the best case for native preemption.

--

The results obtained running this test can be downloaded from [8]. They
don't match the figures presented at ELCE, on the very same hardware,
although they should have followed the same trend but did not. In
isolated mode, Xenomai achieved 50µ worst case latency, bumping to 83µ
without CPU isolation, while native preemption went to 117µ with CPU
isolation.

I gave as many details as possible regarding the settings I used for
native preemption on this SoC, so that anything I might have overlooked
could be quickly spotted by an expert in this field. Just let me know.
The Xenomai part should be ok though.

> 
> And how about communication with hardware communication in a PREEMT_RT setup? Without special RT-drivers what can we expect?  For me it's not about when something can be computed but rather when it can be commuicated.
> 

I don't think there is a definitive answer to this. It would depend on
several aspects, such as a particular implementation of the driver and
the locking constructs used there for instance, whether there is some
kernel layer above the VFS between your application and the driver
handling the actual I/O requests to the hardware, what would be the
worst runtime conditions for latency, what would be the runtime settings
like irq thread priorities and so on.

> 
> [1] http://linuxgizmos.com/real-time-linux-explained/
> 
> Qute: "While Xenomai performed better on most tests, and offered far less jitter, the differences were not as great as the 300 to 400 percent latency superiority claimed by some Xenomai boosters, said Altenberg. When tests were performed on userspace tasks — which Altenberg says is the most real-world, and therefore the most important, test — the worst-case reaction was about 90 to 95 microseconds for both Xenomai and RTL/PREEMPT.RT, he claimed."
> 
> 

I must admit that I don't have any formal explanation about such a
difference between those results and the ones I just obtained, not
having access to the test material presented at ELCE. Maybe we managed
to lower the Xenomai worst case latency by 49% on this hardware since
2016 which would be great news, and native preemption got worse by about
32% during the same period of time, which would be sad.

I'm reassured by the fact that the most recent results are consistent
with those I have been seeing over the years on all architectures I came
across running a variety of tests, which is a relief.

This said, I would refrain from generalizing the results of either my
benchmark or any benchmark, especially those supporting a PR stunt:
there is a multitude of combinations of real-time use cases, platforms,
runtime conditions and requirements. How meaningful are those results
depends on such combo, not to speak of the implementation of the
application itself. The devil is in the detail.

[1]
https://events.static.linuxfound.org/sites/events/files/slides/praesentation_1.pdf
[2]
https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patches-5.0.14-rt8.tar.xz
[3] https://gitlab.denx.de/Xenomai/ipipe-arm (branch master)
[4] https://gitlab.denx.de/Xenomai/xenomai (branch next)
[5]
https://xenomai.org/documentation/xenomai-3/html/man1/autotune/index.html
[6] git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
[7] https://gitlab.denx.de/Xenomai/xenomai/tree/next/demo/posix/cyclictest
[8] https://xenomai.org/downloads/xenomai/benchmarks/cyclone-v/socfpga/2019/

-- 
Philippe.

