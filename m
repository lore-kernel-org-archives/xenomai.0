Message-ID: <2862c2c80707182309r2d49f8b6xeb85601230a4be43@domain.hid>
Date: Thu, 19 Jul 2007 14:09:07 +0800
From: "Yeoh Chun Yeow" <yeohchunyeow@domain.hid>
In-Reply-To: <2ff1a98a0707180739y59f673c3tc7d8668877686212@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_73169_27760686.1184825347102"
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2ff1a98a0707170300o5d36e9f9i96b5a11fb4c7a87e@domain.hid>
	<2862c2c80707170336t45ad3266pc5b5f7769623a900@domain.hid>
	<2ff1a98a0707170609u5da092a1nf32d4789b579717@domain.hid>
	<2862c2c80707172257x5f41d8c4p5df5282be4ba98a2@domain.hid>
	<18077.48173.286511.400122@domain.hid>
	<2862c2c80707180036t6e64ccban83924d445d80f9c0@domain.hid>
	<2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
	<2862c2c80707180255h7197a055i58b90228bc2c52df@domain.hid>
	<2ff1a98a0707180739y59f673c3tc7d8668877686212@domain.hid>
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

------=_Part_73169_27760686.1184825347102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,

Thanks. After disabling the system timer interrupt at the starting of timer
init function, the problem is solved. Thanks again!

By the way, I would like know if you ever try the 2.6.20-at91-patch in your
testing and find out the problem. Whenever I patch my kernel with this
2.6.20-at91-patch, the system is stalled in a very early stage, not even
reaching the request_irq in atmel serial driver.

Please advice. Thanks

regards,
chun yeow


> > My console ttyS0 uses the DBGU, and the port->irq is 1 (AT91_ID_SYS).
> > Although RTC uses the same interrupt, but it is disabled. We don't use
> > system timer which uses the same interrupt pin in xenomai. Any ideas?
>
> Try adding the following piece of code at the beginning of the I-pipe
> version of the at91rm9200_timer_init function in
> arch/arm/mach-at91rm9200/at91rm9200_timer.c:
>
>         /* Disable all timer interrupts */
>         at91_sys_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_WDOVF |
> AT91_ST_RTTINC | AT91_ST_ALMS);
>         (void) at91_sys_read(AT91_ST_SR);       /* Clear any pending
> interrupts */
>
> --
>                                                Gilles Chanteperdrix
>

------=_Part_73169_27760686.1184825347102
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Gilles,<br><br>Thanks. After disabling the system timer interrupt at the starting of timer init function, the problem is solved. Thanks again!<br><br>By the way, I would like know if you ever try the 2.6.20-at91-patch
 in your testing and find out the problem. Whenever I patch my kernel with this 2.6.20-at91-patch, the system is stalled in a very early stage, not even reaching the request_irq in atmel serial driver. <br><br>Please advice. Thanks
<br><br>regards,<br>chun yeow<br><br><div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>&gt; My console ttyS0 uses the DBGU, and the port-&gt;irq is 1 (AT91_ID_SYS).
<br>&gt; Although RTC uses the same interrupt, but it is disabled. We don&#39;t use<br>&gt; system timer which uses the same interrupt pin in xenomai. Any ideas?<br><br>Try adding the following piece of code at the beginning of the I-pipe
<br>version of the at91rm9200_timer_init function in<br>arch/arm/mach-at91rm9200/at91rm9200_timer.c:<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Disable all timer interrupts */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;at91_sys_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_WDOVF |<br>
AT91_ST_RTTINC | AT91_ST_ALMS);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(void) at91_sys_read(AT91_ST_SR);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Clear any pending interrupts */<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gilles Chanteperdrix<br></blockquote></div>
<br>

------=_Part_73169_27760686.1184825347102--

