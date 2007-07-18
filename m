Message-ID: <2862c2c80707180255h7197a055i58b90228bc2c52df@domain.hid>
Date: Wed, 18 Jul 2007 17:55:03 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_63635_18054796.1184752503617"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707160352n26db7ac2sddee9a6e6e7dd9c8@domain.hid>
	<2862c2c80707170210s437674f6ua7283d3e03e97a1b@domain.hid>
	<2ff1a98a0707170300o5d36e9f9i96b5a11fb4c7a87e@domain.hid>
	<2862c2c80707170336t45ad3266pc5b5f7769623a900@domain.hid>
	<2ff1a98a0707170609u5da092a1nf32d4789b579717@domain.hid>
	<2862c2c80707172257x5f41d8c4p5df5282be4ba98a2@domain.hid>
	<18077.48173.286511.400122@domain.hid>
	<2862c2c80707180036t6e64ccban83924d445d80f9c0@domain.hid>
	<2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
Subject: Re: [Xenomai-help] Enable I-PIPE - kernel boot hangs in the
	AT91RM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

------=_Part_63635_18054796.1184752503617
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

My console ttyS0 uses the DBGU, and the port->irq is 1 (AT91_ID_SYS).
Although RTC uses the same interrupt, but it is disabled. We don't use
system timer which uses the same interrupt pin in xenomai. Any ideas?

regards,
chun yeow

On 7/18/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org > wrote:
>
> On 7/18/07, Yeoh Chun Yeow < yeohchunyeow@domain.hid> wrote:
> > Dear Gilles,
> >
> > I think that the interrupt is shared for supporting up to 4 UARTs (ttyS0
> --
> > S3) available in the system.
>
> No, from reading arch/arm/mach-at91rm9200/at92rm9200_devices.c
> uart DBGU uses irq AT91_ID_SYS i.e. 1
> uart 0 uses irq AT91RM9200_ID_US0 i.e. 6
> uart 1 uses irq AT91RM9200_ID_US1 i.e. 7
> uart 2 uses irq AT91RM9200_ID_US2 i.e. 8
> uart 3 uses irq AT91RM9200_ID_US3 i.e. 9
>
> >
> > Whenever the request_irq for ttyS0 is invoked, the system will go to
> > atmel_interrupt and loop. There is no change for other ports, such as
> ttyS1
> > ... to even register their interrupts.
> >
> > Who else generates the interrupt? Any idea?
>
> First, try to know which uart ttyS0 is using (for instance, by
> printing port->irq before the request_irq which causes the problem).
> Then read the AT91 datasheet to know who else generates the same
> interrupt. Look in the kernel source if there is a driver for this
> other peripheral, if yes, then enable it in kernel configuration, if
> no, then write a small interrupt handler which acknowledges this other
> interrupt. On the AT91, the way to acknowledge an interrupt is usually
> to read a status register somewhere.
>
> Note that if ttyS0 is using the DBGU uart, the interrupt is
> AT91_ID_SYS, which is probably used by a lot of drivers.
>
> P.S: please do not forget to cc the mailing list.
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_63635_18054796.1184752503617
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles, <br><br>My console ttyS0 uses the DBGU, and the port-&gt;irq is 1 (AT91_ID_SYS). Although RTC uses the same interrupt, but it is disabled. We don&#39;t use system timer which uses the same interrupt pin in xenomai. Any ideas?
<br><br>regards,<br>chun yeow<br><br><div><span class="gmail_quote">On 7/18/07, <b class="gmail_sendername">Gilles Chanteperdrix</b> &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
gilles.chanteperdrix@xenomai.org
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On 7/18/07, Yeoh Chun Yeow &lt;<a href="mailto:yeohchunyeow@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

yeohchunyeow@domain.hid</a>&gt; wrote:<br>&gt; Dear Gilles,<br>&gt;<br>&gt; I think that the interrupt is shared for supporting up to 4 UARTs (ttyS0 --<br>&gt; S3) available in the system.<br><br>No, from reading arch/arm/mach-at91rm9200/at92rm9200_devices.c
<br>uart DBGU uses irq AT91_ID_SYS i.e. 1<br>uart 0 uses irq AT91RM9200_ID_US0 i.e. 6<br>uart 1 uses irq AT91RM9200_ID_US1 i.e. 7<br>uart 2 uses irq AT91RM9200_ID_US2 i.e. 8<br>uart 3 uses irq AT91RM9200_ID_US3 i.e. 9<br>

<br>&gt;<br>&gt; Whenever the request_irq for ttyS0 is invoked, the system will go to<br>&gt; atmel_interrupt and loop. There is no change for other ports, such as ttyS1<br>&gt; ... to even register their interrupts.<br>
&gt;
<br>&gt; Who else generates the interrupt? Any idea?<br><br>First, try to know which uart ttyS0 is using (for instance, by<br>printing port-&gt;irq before the request_irq which causes the problem).<br>Then read the AT91 datasheet to know who else generates the same
<br>interrupt. Look in the kernel source if there is a driver for this<br>other peripheral, if yes, then enable it in kernel configuration, if<br>no, then write a small interrupt handler which acknowledges this other<br>
interrupt. On the AT91, the way to acknowledge an interrupt is usually
<br>to read a status register somewhere.<br><br>Note that if ttyS0 is using the DBGU uart, the interrupt is<br>AT91_ID_SYS, which is probably used by a lot of drivers.<br><br>P.S: please do not forget to cc the mailing list.
<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_63635_18054796.1184752503617--

