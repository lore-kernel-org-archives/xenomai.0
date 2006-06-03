Message-ID: <44813683.9040202@domain.hid>
Date: Sat, 03 Jun 2006 10:13:07 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
References: <17536.40316.183366.284818@domain.hid>
In-Reply-To: <17536.40316.183366.284818@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix kirjoitti:
> Now that the big context switches bugs have been solved, here is a patch
> that adds a unit test for context switches and FPU switches
> with various type of threads (kernel, user, user in secondary mode,
> not using FPU, using FPU, etc...). As is the case of the latency test
> there is a small RTDM driver in kernel-space, put in the benchmark
> class, even though this test is for unit testing, not for benchmarking.

Some months back when I was debugging an FPU bug on the ppc, I made 
similar test cases. Do you test the Linux side at all (does linux 
user/kernel task's fpu state get messed)? Though, I'm not sure if any 
driver uses FPU in linux kernel, but at least the PPC Altivec unit is 
used by RAID drivers. Btw. at least back then, Xenomai would have messed 
FPU state for a linux kernel task.

> The FPU switches need a small piece of code architecture dependent,
> put in <asm/xenomai/fptest.h>, currently only implemented for x86.
> 
> The kernel-space driver is called xeno_switchtest.ko, the user-space
> testing tool is called switchtest, because there is already a context
> switch benchmarking tool called "switch".

-- hl

