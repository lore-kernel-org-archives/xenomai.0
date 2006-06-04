Message-ID: <4482E469.5030303@domain.hid>
Date: Sun, 04 Jun 2006 16:47:21 +0300
From: Heikki Lindholm <holindho@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
References: <17536.40316.183366.284818@domain.hid>	<44813683.9040202@domain.hid>	<17537.48372.286093.220257@domain.hid>	<17537.50730.965937.485975@domain.hid>	<4481EE11.9040109@domain.hid>
	<17538.55525.494004.44221@domain.hid>
In-Reply-To: <17538.55525.494004.44221@domain.hid>
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
> Heikki Lindholm wrote:
>  > Yes, Altivec is separate from the FPU. Hopefully nobody uses FPU in the 
>  > kernel - AFAIK currently not, but you never know about closed-source 
>  > drivers and such. Whereas, Altivec, I think, is something that should, 
>  > eventually, be supported by the real-time domain, too. Adding Altivec 
>  > support is very similar to the existing fpu support, and being that it 
>  > has to tackle the kernel-using-altivec issue anyway, it's probably nicer 
>  > to add fpu kernel support as well. Only problem is that it will increase 
>  > the context switch time. 
> 
> Maybe we could add an XNSIMD flag for Altivec and SSE, distinct from
> XNFPU, so that only the task that really use SIMD instructions would pay
> the price of the switch ?

Sounds like a plan to me.

>  > I'd remember that using the FPU bits (instead 
>  > of task state) from the processor will pretty much cause saving state on 
>  > every transition to xeno, because of the kernel's lazy usage model (on 
>  > UP; SMP will do that anyway).
> 
> I do not understand what you mean: on x86 the state of the ts bit in cr0
> is enough to know if the FPU was used either in kernel-space or in
> user-space. I know power pc is a bit different because the state of the
> FPU is saved by the user/kernel switches, but is not the state of the
> MSR_FP bit enough to know if FPU was used in kernel-space ?

Yes, the MSR_FP bit is enough to know that FPU was/is being used, but as 
I recall, the problem is that it seldom is off after somebody has used 
FPU. More clearly put, if a task uses FPU, MSR_FP gets set. After that, 
if no other task shows interest in the FPU, its state doesn't get saved 
and MSR_FP stays on until some other task wants to use the FPU, at which 
point the FPU state is saved and MSR_FP reset. This is what I meant...

...But looking at xeno code again and thinking this over again, it 
doesn't seem so bad to guess FPU usage from MSR_FP, because it doesn't 
change the situation much, it just needs an extra (static) space for 
saved kernel FPU regs somewhere. I actually implemented this back when I 
was fixing the FPU bug, but didn't submit it then, because I thought it 
might not be so useful.

-- hl

