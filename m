Message-ID: <4480CEE3.40309@domain.hid>
Date: Fri, 02 Jun 2006 17:50:59 -0600
From: Jim Cromie <jim.cromie@domain.hid>
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

Gilles Chanteperdrix wrote:
> Now that the big context switches bugs have been solved, here is a patch
> that adds a unit test for context switches and FPU switches
> with various type of threads (kernel, user, user in secondary mode,
> not using FPU, using FPU, etc...). As is the case of the latency test
> there is a small RTDM driver in kernel-space, put in the benchmark
> class, even though this test is for unit testing, not for benchmarking.
>
> The FPU switches need a small piece of code architecture dependent,
> put in <asm/xenomai/fptest.h>, currently only implemented for x86.
>
> The kernel-space driver is called xeno_switchtest.ko, the user-space
> testing tool is called switchtest, because there is already a context
> switch benchmarking tool called "switch".
>
>   

does this maybe warrant a rename of both, to preclude the inevitable
'whats the difference between' Qs (sent or unsent) ?

