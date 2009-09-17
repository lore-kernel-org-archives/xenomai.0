MIME-Version: 1.0
In-Reply-To: <1253116044.2676.153.camel@domain.hid>
References: <9aa019ba0909150827u38360ec1m7b749838ab0c54c4@domain.hid>
	<1253116044.2676.153.camel@domain.hid>
Date: Thu, 17 Sep 2009 12:26:08 -0500
Message-ID: <9aa019ba0909171026i51de25a7g6e0c5fd60273747@domain.hid>
From: James Kilts <jameskilts@domain.hid>
Content-Type: multipart/alternative; boundary=00c09f89942ea99fb00473c94f0d
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--00c09f89942ea99fb00473c94f0d
Content-Type: text/plain; charset=ISO-8859-1

Philippe,

Indeed it was a problem with __set_irq_handler() not assigning appropriate
handlers, since this board doesn't fall into any of the existing handler
categories.

Thanks for your help.

James


On Wed, Sep 16, 2009 at 10:47 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Tue, 2009-09-15 at 10:27 -0500, James Kilts wrote:
> > I'm porting Xenomai/I-pipe to the NS921x (an arm9-based) platform, but
> > I'm having problems getting the interrupts to re-enable after the
> > first interrupt triggers.
> >
> > A kernel driver module is being used to test the interrupt latency
> > using an input GPIO pin which triggers a dedicated external IRQ, to
> > which the ISR responds by toggling a different GPIO pin.  I realize
> > that there are test applications which do very similar things, and
> > that the RTDM skin is preferable over the native API.  Still, I would
> > like to understand why the interrupt is not being properly
> > acknowledged and reset.
> >
> > If the ISR manually performs the ACK and EOI using platform specific
> > calls, subsequent interrupts are handled properly.  My understanding
> > was that Xenomai should re-enable the interrupt for processing without
> > such intervention.  How do I force Xenomai to clear and re-enable the
> > interrupt to handle subsequent interrupts?
>
> It looks like an I-pipe issue, not a Xenomai one. Xenomai asks the
> I-pipe to re-enable the interrupt line via the ipipe_end() handler, and
> for some reason, that handler does not seem to do the right thing on
> your board.
>
> Which I-pipe patch are you using (kernel version and I-pipe release)?
>
> >
> > Thanks,
> > James
> >
> >
> >
> > static int __init turnaround_irq_measure_init(void)
> > {
> >     ....
> >
> >     retval = rt_intr_create(&irq_response_desc,
> > "ns9xxx_measure_irq_rt_response",
> >                             TURNAROUND_INPUT_IRQ,
> > turnaround_irq_measure_response,
> >                             NULL, NULL);
> >
> >     if (retval == 0)  // 0 is success
> >     {
> >         set_irq_type(TURNAROUND_INPUT_IRQ, IRQ_TYPE_EDGE_FALLING);
> >         retval = rt_intr_enable(&irq_response_desc);
> >
> >         if (retval != 0)  // 0 is success
> >         {
> >             console_print("Turnaround test driver rt interrupt enable:
> > FAILED\n");
> >         }
> >     }
> >     else
> >     {
> >         console_print("Turnaround test driver rt interrupt create:
> > FAILED\n");
> >     }
> >
> >     return 0;
> > }
> >
> >
> > static int turnaround_irq_measure_response(struct xnintr *intr)
> > {
> >     /* Set GPIO pin low */
> >     gpio_set_value(TURNAROUND_OUTPUT_GPIO, 0);
> >
> >     /* Wait 50 microseconds */
> >     rt_timer_spin(50000);
> >
> >     /* Set GPIO pin high */
> >     gpio_set_value(TURNAROUND_OUTPUT_GPIO, 1);
> >
> >     /* Start listening again */
> >     /* NOTE:  These two lines should not be necessary */
> >     ns9xxx_ack_irq(TURNAROUND_INPUT_IRQ);
> >     ns9xxx_eoi_irq(TURNAROUND_INPUT_IRQ);
> >
> >     return RT_INTR_HANDLED;
> > }
> >
> >
> > _______________________________________________
> > Xenomai-help mailing list
> > Xenomai-help@domain.hid
> > https://mail.gna.org/listinfo/xenomai-help
> --
> Philippe.
>
>
>

--00c09f89942ea99fb00473c94f0d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe,<br><br>Indeed it was a problem with __set_irq_handler() not assig=
ning appropriate handlers, since this board doesn&#39;t fall into any of th=
e existing handler categories.<br><br>Thanks for your help.<br><br>James<br=
>
<br><br><div class=3D"gmail_quote">On Wed, Sep 16, 2009 at 10:47 AM, Philip=
pe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
ai.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
<div class=3D"im">On Tue, 2009-09-15 at 10:27 -0500, James Kilts wrote:<br>
&gt; I&#39;m porting Xenomai/I-pipe to the NS921x (an arm9-based) platform,=
 but<br>
&gt; I&#39;m having problems getting the interrupts to re-enable after the<=
br>
&gt; first interrupt triggers.<br>
&gt;<br>
&gt; A kernel driver module is being used to test the interrupt latency<br>
&gt; using an input GPIO pin which triggers a dedicated external IRQ, to<br=
>
&gt; which the ISR responds by toggling a different GPIO pin. =A0I realize<=
br>
&gt; that there are test applications which do very similar things, and<br>
&gt; that the RTDM skin is preferable over the native API. =A0Still, I woul=
d<br>
&gt; like to understand why the interrupt is not being properly<br>
&gt; acknowledged and reset.<br>
&gt;<br>
&gt; If the ISR manually performs the ACK and EOI using platform specific<b=
r>
&gt; calls, subsequent interrupts are handled properly. =A0My understanding=
<br>
&gt; was that Xenomai should re-enable the interrupt for processing without=
<br>
&gt; such intervention. =A0How do I force Xenomai to clear and re-enable th=
e<br>
&gt; interrupt to handle subsequent interrupts?<br>
<br>
</div>It looks like an I-pipe issue, not a Xenomai one. Xenomai asks the<br=
>
I-pipe to re-enable the interrupt line via the ipipe_end() handler, and<br>
for some reason, that handler does not seem to do the right thing on<br>
your board.<br>
<br>
Which I-pipe patch are you using (kernel version and I-pipe release)?<br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; Thanks,<br>
&gt; James<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; static int __init turnaround_irq_measure_init(void)<br>
&gt; {<br>
&gt; =A0 =A0 ....<br>
&gt;<br>
&gt; =A0 =A0 retval =3D rt_intr_create(&amp;irq_response_desc,<br>
&gt; &quot;ns9xxx_measure_irq_rt_response&quot;,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TURNAROUND_INP=
UT_IRQ,<br>
&gt; turnaround_irq_measure_response,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, NULL);<b=
r>
&gt;<br>
&gt; =A0 =A0 if (retval =3D=3D 0) =A0// 0 is success<br>
&gt; =A0 =A0 {<br>
&gt; =A0 =A0 =A0 =A0 set_irq_type(TURNAROUND_INPUT_IRQ, IRQ_TYPE_EDGE_FALLI=
NG);<br>
&gt; =A0 =A0 =A0 =A0 retval =3D rt_intr_enable(&amp;irq_response_desc);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 if (retval !=3D 0) =A0// 0 is success<br>
&gt; =A0 =A0 =A0 =A0 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 console_print(&quot;Turnaround test driver rt =
interrupt enable:<br>
&gt; FAILED\n&quot;);<br>
&gt; =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 }<br>
&gt; =A0 =A0 else<br>
&gt; =A0 =A0 {<br>
&gt; =A0 =A0 =A0 =A0 console_print(&quot;Turnaround test driver rt interrup=
t create:<br>
&gt; FAILED\n&quot;);<br>
&gt; =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 return 0;<br>
&gt; }<br>
&gt;<br>
&gt;<br>
&gt; static int turnaround_irq_measure_response(struct xnintr *intr)<br>
&gt; {<br>
&gt; =A0 =A0 /* Set GPIO pin low */<br>
&gt; =A0 =A0 gpio_set_value(TURNAROUND_OUTPUT_GPIO, 0);<br>
&gt;<br>
&gt; =A0 =A0 /* Wait 50 microseconds */<br>
&gt; =A0 =A0 rt_timer_spin(50000);<br>
&gt;<br>
&gt; =A0 =A0 /* Set GPIO pin high */<br>
&gt; =A0 =A0 gpio_set_value(TURNAROUND_OUTPUT_GPIO, 1);<br>
&gt;<br>
&gt; =A0 =A0 /* Start listening again */<br>
&gt; =A0 =A0 /* NOTE: =A0These two lines should not be necessary */<br>
&gt; =A0 =A0 ns9xxx_ack_irq(TURNAROUND_INPUT_IRQ);<br>
&gt; =A0 =A0 ns9xxx_eoi_irq(TURNAROUND_INPUT_IRQ);<br>
&gt;<br>
&gt; =A0 =A0 return RT_INTR_HANDLED;<br>
&gt; }<br>
&gt;<br>
&gt;<br>
</div></div>&gt; _______________________________________________<br>
&gt; Xenomai-help mailing list<br>
&gt; <a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
&gt; <a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blan=
k">https://mail.gna.org/listinfo/xenomai-help</a><br>
--<br>
<font color=3D"#888888">Philippe.<br>
<br>
<br>
</font></blockquote></div><br>

--00c09f89942ea99fb00473c94f0d--

