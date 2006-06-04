MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17539.7418.750870.735149@domain.hid>
Date: Sun, 4 Jun 2006 19:48:42 +0200
Subject: Re: [Xenomai-core] [rfc] unit testing context switches.
In-Reply-To: <4482E469.5030303@domain.hid>
References: <17536.40316.183366.284818@domain.hid>
	<44813683.9040202@domain.hid>
	<17537.48372.286093.220257@domain.hid>
	<17537.50730.965937.485975@domain.hid>
	<4481EE11.9040109@domain.hid>
	<17538.55525.494004.44221@domain.hid>
	<4482E469.5030303@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Heikki Lindholm <holindho@domain.hid>
Cc: xenomai@xenomai.org

Heikki Lindholm wrote:
 > Gilles Chanteperdrix kirjoitti:
 > > Heikki Lindholm wrote:
 > >  > Yes, Altivec is separate from the FPU. Hopefully nobody uses FPU in the 
 > >  > kernel - AFAIK currently not, but you never know about closed-source 
 > >  > drivers and such. Whereas, Altivec, I think, is something that should, 
 > >  > eventually, be supported by the real-time domain, too. Adding Altivec 
 > >  > support is very similar to the existing fpu support, and being that it 
 > >  > has to tackle the kernel-using-altivec issue anyway, it's probably nicer 
 > >  > to add fpu kernel support as well. Only problem is that it will increase 
 > >  > the context switch time. 
 > > 
 > > Maybe we could add an XNSIMD flag for Altivec and SSE, distinct from
 > > XNFPU, so that only the task that really use SIMD instructions would pay
 > > the price of the switch ?
 > 
 > Sounds like a plan to me.

Actually that is a bad idea on x86, because the fxsave instruction that
saves the whole FP context, including SSE registers, is faster than the
fsave instruction that only save the regular FP registers. We are
discussing about operations that take around 500 ns on a 1GHz PIII with
cold cache.

I would be curious to know how many cycles the FP and altivec registers
save take on power pc.

-- 


					    Gilles Chanteperdrix.

