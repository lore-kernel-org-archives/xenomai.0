From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <9aa019ba0909150827u38360ec1m7b749838ab0c54c4@domain.hid>
References: <9aa019ba0909150827u38360ec1m7b749838ab0c54c4@domain.hid>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 17:47:24 +0200
Message-Id: <1253116044.2676.153.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt only runs once
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: James Kilts <jameskilts@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-09-15 at 10:27 -0500, James Kilts wrote:
> I'm porting Xenomai/I-pipe to the NS921x (an arm9-based) platform, but
> I'm having problems getting the interrupts to re-enable after the
> first interrupt triggers.
> 
> A kernel driver module is being used to test the interrupt latency
> using an input GPIO pin which triggers a dedicated external IRQ, to
> which the ISR responds by toggling a different GPIO pin.  I realize
> that there are test applications which do very similar things, and
> that the RTDM skin is preferable over the native API.  Still, I would
> like to understand why the interrupt is not being properly
> acknowledged and reset.
> 
> If the ISR manually performs the ACK and EOI using platform specific
> calls, subsequent interrupts are handled properly.  My understanding
> was that Xenomai should re-enable the interrupt for processing without
> such intervention.  How do I force Xenomai to clear and re-enable the
> interrupt to handle subsequent interrupts?

It looks like an I-pipe issue, not a Xenomai one. Xenomai asks the
I-pipe to re-enable the interrupt line via the ipipe_end() handler, and
for some reason, that handler does not seem to do the right thing on
your board.

Which I-pipe patch are you using (kernel version and I-pipe release)?

> 
> Thanks,
> James
> 
> 
> 
> static int __init turnaround_irq_measure_init(void)
> {
>     ....
> 
>     retval = rt_intr_create(&irq_response_desc,
> "ns9xxx_measure_irq_rt_response",
>                             TURNAROUND_INPUT_IRQ,
> turnaround_irq_measure_response,
>                             NULL, NULL);
> 
>     if (retval == 0)  // 0 is success
>     {
>         set_irq_type(TURNAROUND_INPUT_IRQ, IRQ_TYPE_EDGE_FALLING);
>         retval = rt_intr_enable(&irq_response_desc);
> 
>         if (retval != 0)  // 0 is success
>         {
>             console_print("Turnaround test driver rt interrupt enable:
> FAILED\n");
>         }
>     }
>     else
>     {
>         console_print("Turnaround test driver rt interrupt create:
> FAILED\n");
>     }
> 
>     return 0;
> }
> 
> 
> static int turnaround_irq_measure_response(struct xnintr *intr)
> {
>     /* Set GPIO pin low */
>     gpio_set_value(TURNAROUND_OUTPUT_GPIO, 0);
> 
>     /* Wait 50 microseconds */
>     rt_timer_spin(50000);
> 
>     /* Set GPIO pin high */
>     gpio_set_value(TURNAROUND_OUTPUT_GPIO, 1);
> 
>     /* Start listening again */
>     /* NOTE:  These two lines should not be necessary */
>     ns9xxx_ack_irq(TURNAROUND_INPUT_IRQ);
>     ns9xxx_eoi_irq(TURNAROUND_INPUT_IRQ);
> 
>     return RT_INTR_HANDLED;
> }
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



