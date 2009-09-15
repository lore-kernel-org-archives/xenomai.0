MIME-Version: 1.0
Date: Tue, 15 Sep 2009 10:27:00 -0500
Message-ID: <9aa019ba0909150827u38360ec1m7b749838ab0c54c4@domain.hid>
From: James Kilts <jameskilts@domain.hid>
Content-Type: multipart/alternative; boundary=000feaf27c6ae8a0fd04739f69f5
Subject: [Xenomai-help] Interrupt only runs once
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000feaf27c6ae8a0fd04739f69f5
Content-Type: text/plain; charset=ISO-8859-1

I'm porting Xenomai/I-pipe to the NS921x (an arm9-based) platform, but I'm
having problems getting the interrupts to re-enable after the first
interrupt triggers.

A kernel driver module is being used to test the interrupt latency using an
input GPIO pin which triggers a dedicated external IRQ, to which the ISR
responds by toggling a different GPIO pin.  I realize that there are test
applications which do very similar things, and that the RTDM skin is
preferable over the native API.  Still, I would like to understand why the
interrupt is not being properly acknowledged and reset.

If the ISR manually performs the ACK and EOI using platform specific calls,
subsequent interrupts are handled properly.  My understanding was that
Xenomai should re-enable the interrupt for processing without such
intervention.  How do I force Xenomai to clear and re-enable the interrupt
to handle subsequent interrupts?

Thanks,
James



static int __init turnaround_irq_measure_init(void)
{
    ....

    retval = rt_intr_create(&irq_response_desc,
"ns9xxx_measure_irq_rt_response",
                            TURNAROUND_INPUT_IRQ,
turnaround_irq_measure_response,
                            NULL, NULL);

    if (retval == 0)  // 0 is success
    {
        set_irq_type(TURNAROUND_INPUT_IRQ, IRQ_TYPE_EDGE_FALLING);
        retval = rt_intr_enable(&irq_response_desc);

        if (retval != 0)  // 0 is success
        {
            console_print("Turnaround test driver rt interrupt enable:
FAILED\n");
        }
    }
    else
    {
        console_print("Turnaround test driver rt interrupt create:
FAILED\n");
    }

    return 0;
}


static int turnaround_irq_measure_response(struct xnintr *intr)
{
    /* Set GPIO pin low */
    gpio_set_value(TURNAROUND_OUTPUT_GPIO, 0);

    /* Wait 50 microseconds */
    rt_timer_spin(50000);

    /* Set GPIO pin high */
    gpio_set_value(TURNAROUND_OUTPUT_GPIO, 1);

    /* Start listening again */
    /* NOTE:  These two lines should not be necessary */
    ns9xxx_ack_irq(TURNAROUND_INPUT_IRQ);
    ns9xxx_eoi_irq(TURNAROUND_INPUT_IRQ);

    return RT_INTR_HANDLED;
}

--000feaf27c6ae8a0fd04739f69f5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I&#39;m porting Xenomai/I-pipe to the NS921x (an arm9-based) platform,
but I&#39;m having problems getting the interrupts to re-enable after the
first interrupt triggers.<br>
<br>A kernel driver module is being used to test the interrupt latency
using an input GPIO pin which triggers a dedicated external IRQ,
to which the ISR responds by toggling a different GPIO pin.=A0 I realize th=
at there are
test applications which do very similar things, and that the RTDM skin
is preferable over the native API.=A0 Still, I would like to understand
why the interrupt is not being properly acknowledged and reset.<br>
<br>If the ISR manually performs the ACK and EOI using platform specific ca=
lls, subsequent interrupts are handled properly.=A0 My understanding was th=
at Xenomai should re-enable the interrupt for processing without such inter=
vention.=A0 How do I force Xenomai to clear and re-enable the interrupt to =
handle subsequent interrupts?<br>


<br>Thanks,<br>James<br><br><br><br>static int __init turnaround_irq_measur=
e_init(void)<br>{<br>=A0=A0=A0 ....<br><br>=A0=A0=A0 retval =3D rt_intr_cre=
ate(&amp;irq_response_desc, &quot;ns9xxx_measure_irq_rt_response&quot;,<br>=
=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 TURNAROUND_INPUT_IRQ, turnaround_irq_measure_response,<br>


=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 NULL, NULL);<br><br>=A0=A0=A0 if (retval =3D=3D 0)=A0 // 0 is succes=
s<br>=A0=A0=A0 {<br>=A0=A0=A0 =A0=A0=A0 set_irq_type(TURNAROUND_INPUT_IRQ, =
IRQ_TYPE_EDGE_FALLING);<br>=A0=A0=A0 =A0=A0=A0 retval =3D rt_intr_enable(&a=
mp;irq_response_desc);<br>


<br>=A0=A0=A0 =A0=A0=A0 if (retval !=3D 0)=A0 // 0 is success<br>=A0=A0=A0 =
=A0=A0=A0 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 console_print(&quot;Turnaround=
 test driver rt interrupt enable: FAILED\n&quot;);<br>=A0=A0=A0 =A0=A0=A0 }=
<br>=A0=A0=A0 }<br>=A0=A0=A0 else<br>=A0=A0=A0 {<br>=A0=A0=A0 =A0=A0=A0 con=
sole_print(&quot;Turnaround test driver rt interrupt create: FAILED\n&quot;=
);<br>


=A0=A0=A0 }<br><br>=A0=A0=A0 return 0;<br>}<br><br><br>static int turnaroun=
d_irq_measure_response(struct xnintr *intr)<br>
{<br>=A0=A0=A0 /* Set GPIO pin low */<br>=A0=A0=A0 gpio_set_value(TURNAROUN=
D_OUTPUT_GPIO, 0);<br><br>=A0=A0=A0 /* Wait 50 microseconds */<br>=A0=A0=A0=
 rt_timer_spin(50000);<br><br>=A0=A0=A0 /* Set GPIO pin high */<br>=A0=A0=
=A0 gpio_set_value(TURNAROUND_OUTPUT_GPIO, 1);<br>



<br>=A0=A0=A0 /* Start listening again */<br>=A0=A0=A0 /* NOTE:=A0 These tw=
o lines should not be necessary */<br>=A0=A0=A0 ns9xxx_ack_irq(TURNAROUND_I=
NPUT_IRQ);<br>=A0=A0=A0 ns9xxx_eoi_irq(TURNAROUND_INPUT_IRQ);<br><br>=A0=A0=
=A0 return RT_INTR_HANDLED;<br>

}<br><br>
<br>

--000feaf27c6ae8a0fd04739f69f5--

