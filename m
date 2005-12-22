From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17322.62424.94946.83579@domain.hid>
Date: Thu, 22 Dec 2005 19:43:36 +0100
Subject: Re: [Xenomai-core] [RFC] in-kernel timer benchmark
In-Reply-To: <43A5AE20.804@domain.hid>
References: <43A5AE20.804@domain.hid>
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
 > This is rather fresh code, handle with care! ;) Moreover, I would like
 > to hear your comments if the extension of the latency tool is the right
 > way to got or if we better split things up. The problem I see is that
 > this patch makes latency depend on xeno_rtdm being loaded.

I agree with Philippe: having a driver for the various benchmarking
needs is a good idea, we could imagine adding ioctls for the various
loads, etc... But I would vote for a split between the user-space
latency measurement tool and the display tool for kernel-space latency.

A minor issue: in the 2.4 portion of ksrc/drivers/Makefile, should not
CONFIG_XENO_DRIVERS_benchmark be replaced with
CONFIG_XENO_DRIVERS_TIMERBENCH ?

It is a very interesting tool indeed (especially since I would need such
a tool to benchmark the various solutions to improve nucleus timers
scalability :). But it would be nice to be able to create several tasks
or several timers without having to open one file descriptor by
timer/task. Or if you want one file descriptor by timer/task,
rt_tmbench_ioctl_nrt should return an error when trying to start the
task or timer twice.

-- 


					    Gilles Chanteperdrix.

