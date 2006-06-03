Message-ID: <4481EE11.9040109@domain.hid>
Date: Sat, 03 Jun 2006 23:16:17 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
References: <17536.40316.183366.284818@domain.hid>	<44813683.9040202@domain.hid>	<17537.48372.286093.220257@domain.hid>
	<17537.50730.965937.485975@domain.hid>
In-Reply-To: <17537.50730.965937.485975@domain.hid>
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
> Gilles Chanteperdrix wrote:
>  > Heikki Lindholm wrote:
>  >  > Gilles Chanteperdrix kirjoitti:
>  >  > > Now that the big context switches bugs have been solved, here is a patch
>  >  > > that adds a unit test for context switches and FPU switches
>  >  > > with various type of threads (kernel, user, user in secondary mode,
>  >  > > not using FPU, using FPU, etc...). As is the case of the latency test
>  >  > > there is a small RTDM driver in kernel-space, put in the benchmark
>  >  > > class, even though this test is for unit testing, not for benchmarking.
>  >  > 
>  >  > Some months back when I was debugging an FPU bug on the ppc, I made 
>  >  > similar test cases. Do you test the Linux side at all (does linux 
>  >  > user/kernel task's fpu state get messed)? 
>  > 
>  > No, currently the only Linux regular task, the idle task, does not use
>  > FPU, but it may be changed easily.
>  > 
>  >  > Though, I'm not sure if any 
>  >  > driver uses FPU in linux kernel, but at least the PPC Altivec unit is 
>  >  > used by RAID drivers. Btw. at least back then, Xenomai would have messed 
>  >  > FPU state for a linux kernel task.
>  > 
>  > x86 has the same issue: RAID driver use mmx, sse or sse2, and manually
>  > disable preemption, clear the ts bit, save the FPU registers
>  > contents before using mmx, sse or sse2, and restore the original state
>  > when done. If Xenomai ever preempts at that point, and the underlying
>  > task has not use its FPU, the contents of the FPU registers will be
>  > lost.
>  > 
>  > The only fix I see is to change the FPU switching code to only rely on
>  > the state of the FPU hardware FPU bits, and not on the status bits of
>  > the interrupted task.
> 
> Actually, only the mmx code is problematic because mmx registers are
> aliased to the regular floating point registers. sse and sse2 use
> distinct registers, so as long as real-time code does not use SSE
> registers, there is no problem. Altivec seems to be in the same 
> case as SSE, or am I missing something ?

Yes, Altivec is separate from the FPU. Hopefully nobody uses FPU in the 
kernel - AFAIK currently not, but you never know about closed-source 
drivers and such. Whereas, Altivec, I think, is something that should, 
eventually, be supported by the real-time domain, too. Adding Altivec 
support is very similar to the existing fpu support, and being that it 
has to tackle the kernel-using-altivec issue anyway, it's probably nicer 
to add fpu kernel support as well. Only problem is that it will increase 
the context switch time. I'd remember that using the FPU bits (instead 
of task state) from the processor will pretty much cause saving state on 
every transition to xeno, because of the kernel's lazy usage model (on 
UP; SMP will do that anyway).

-- hl


