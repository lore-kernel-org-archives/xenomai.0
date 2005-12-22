Message-ID: <43AA80C8.7060307@domain.hid>
Date: Thu, 22 Dec 2005 11:32:40 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] in-kernel timer benchmark
References: <43A5AE20.804@domain.hid>
In-Reply-To: <43A5AE20.804@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi all,
> 
> this is fully working proposal how to re-enable in-kernel timer latency
> benchmarks.
> 
> More precisely, it adds a new RTDM device "rtbenchmark<X>" (and also a
> new RTDM class) which can execute either a kernel task or timer
> periodically. The benchmark device generates all the usual latency data
> which can be retrieved from userspace via IOCTLs. I patched the existing
> latency tool to open the device and read the data from there instead of
> running its own latency task.
> 
> README for a quick test:
> 
>  o apply patch and rebuild everything (don't forget to re-prepare the
>    kernel and also call scripts/bootstrap, I added some files)
> 
>  o load xeno_timerbench (+ xeno_native, xeno_rtdm, ...)
> 
>  o run "latency -D0" to start in-kernel timer task test on device
>    "rtbenchmark0"
> 
>  o run "latency -D0 -t" to start in-kernel timer handler test (i.e.
>    without scheduling latency) on device "rtbenchmark0"
> 

Worked like a charm here.

> This is rather fresh code, handle with care! ;) Moreover, I would like
> to hear your comments if the extension of the latency tool is the right
> way to got or if we better split things up. The problem I see is that
> this patch makes latency depend on xeno_rtdm being loaded.
>

IMO, using RTDM here is definitely the right thing, and depending on it 
for the purpose of benchmarking is acceptable if we admit that 
additional and more complex benchmarks we may provide in the future will 
most likely benefit from using RTDM as a mean to exchange data and get 
control requests from user-space. Better not having to invent some 
braindamage FIFO-based messaging protocol each time we want to enrich 
the benchmark/test collection anyway. Production systems will likely 
don't care about the benchmark suite, so configuring out RTDM if 
otherwise unneeded would still be a no-brainer.

On the split/no-split issue, I'd keep it the way you crafted it, i.e. 
both tests integrated. After all, they both measure the same latencies 
(pure timer test option put aside) even if they happen to do the 
measurements in different exec contexts. I will have two remarks though:

- a clearer message upon failure to start the kernel-based test (likely 
due to the absence of the benchmark module) should be sent. Some hint 
telling the user that "modprobe xeno_timerbench?" would not be a bad 
idea to issue would likely be useful.

- some information when starting/running? the current test that tells us 
which benchmark is currently running.

> PS: I likely broke src/testsuite/latency/runinfo.

This patch should do it, whether the listed features are available as 
modules or statically bound to the kernel:

-latency:rtdm+native:!./latency;popall:control_c
+latency:rtdm+native+timerbench:!./latency;popall:control_c

-- 

Philippe.

