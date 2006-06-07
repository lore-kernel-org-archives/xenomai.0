Message-ID: <44871B5A.6090307@domain.hid>
Date: Wed, 07 Jun 2006 20:30:50 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
References: <17536.40316.183366.284818@domain.hid>
	<17543.5163.684144.582942@domain.hid>
In-Reply-To: <17543.5163.684144.582942@domain.hid>
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
> Gilles Chanteperdrix wrote:
>  > 
>  > Now that the big context switches bugs have been solved, here is a patch
>  > that adds a unit test for context switches and FPU switches
>  > with various type of threads (kernel, user, user in secondary mode,
>  > not using FPU, using FPU, etc...). As is the case of the latency test
>  > there is a small RTDM driver in kernel-space, put in the benchmark
>  > class, even though this test is for unit testing, not for benchmarking.
>  > 
>  > The FPU switches need a small piece of code architecture dependent,
>  > put in <asm/xenomai/fptest.h>, currently only implemented for x86.
>  > 
>  > The kernel-space driver is called xeno_switchtest.ko, the user-space
>  > testing tool is called switchtest, because there is already a context
>  > switch benchmarking tool called "switch".
> 
> Here is an updated version, applying the remarks of Jim and Jan:
> renamed rtbenchmark rttesting, and renamed the already existing context
> switch benchmark switchbench. The patch is large but contains mostly
> renames.
> 
> I would prefer to commit this version before implementing the other
> changes, namely allowing kernel-space non real-time tasks to use the FPU
> and merging the context switches benchmark test with this test.
> 
> +
> +/* Thread type. */
> +typedef enum {
> +    IDLE = 0,
> +    RTK  = 1,        /* kernel-space thread. */
> +    RTUP = 2,        /* user-space real-time thread in primary mode. */
> +    RTUS = 3,        /* user-space real-time thread in secondary mode. */
> +    RTUO = 4,        /* user-space real-time thread oscillating
> +                        between primary and secondary mode. */
> +} threadtype;
> +
> +typedef enum {
> +    FP   = 1,        /* arm the FPU task bit (only make sense for RTK) */
> +    UFPP = 2,        /* use the FPU while in primary mode. */
> +    UFPS = 4         /* use the FPU while in secondary mode. */
> +} fpflags;
> +


IDLE and FP at least look like a bit too generic, potentially subject to 
name clashes. Otherwise, that's fine with me.

-- 

Philippe.

