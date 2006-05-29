MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17531.5942.353611.748409@domain.hid>
Date: Mon, 29 May 2006 17:45:58 +0200
Subject: Re: [Xenomai-core] Xenomai on PXA255
In-Reply-To: <1148913934.5494.15.camel@domain.hid>
References: <1148554757.9498.19.camel@domain.hid>
	<17530.65147.519598.892978@domain.hid>
	<1148912044.9574.30.camel@domain.hid>
	<1148913934.5494.15.camel@domain.hid>
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
To: Stelian Pop <stelian.pop@domain.hid>
Cc: xenomai@xenomai.org

Stelian Pop wrote:
 > If you have specific questions feel free to ask. But I suggest you read
 > and try to understand the code first.

Maybe we could provide a quick overview of how this works, Stelian,
please correct me if I am wrong. 

If we start before rthal_timer_request is called, when the timer is
handled by Linux, we see that __ipipe_decr_ticks is set to
__ipipe_mach_ticks_per_jiffy, so that __ipipe_grab_irq does not
reprogram the timer. But __ipipe_mach_timerstolen is set to 0, so
integrator_timer_interrupt reprogram the timer at each tick.

Now, when rthal_timer_request (defined in  ksrc/arch/arm/hal.c) is
called when Xenomai start handling the timer, we can see the two
different modes:

- in periodic mode, ipipe_tune_timer get called (indirectly via
  rthal_set_timer, defined in include/asm-generic/hal.h), so
  the proper value of __ipipe_decr_ticks is computed using
  __ipipe_mach_ticks_per_jiffy, and __ipipe_mach_set_dec get called by
  __ipipe_grab_irq at each tick to reprogram the timer

- in aperiodic (aka one-shot) mode, ipipe_tune_timer does not get
  called, so __ipipe_decr_ticks remains set to
  __ipipe_mach_ticks_per_jiffy and __ipipe_grab_irq does not call
  __ipipe_mach_set_dec. Instead, __ipipe_mach_set_dec is called for
  each shot by Xenomai (function rthal_timer_program_shot in
  include/asm-arm/hal.h)

In both modes, __ipipe_mach_timerstolen is set to 1, so that
integrator_timer_interrupt never reprograms the timer. 

When CONFIG_IPIPE is set, integrator_timer_interrupt never acks the
timer interrupt, instead, it gets ack'ed and unmasked in
__ipipe_ack_timerirq, installed as an acknowledge function for the timer
IRQ in __ipipe_enable_pipeline.

-- 


					    Gilles Chanteperdrix.

