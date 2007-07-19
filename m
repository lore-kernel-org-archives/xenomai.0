Message-ID: <2ff1a98a0707190106q6662cca8vdac75661e21e0576@domain.hid>
Date: Thu, 19 Jul 2007 10:06:59 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <2862c2c80707182309r2d49f8b6xeb85601230a4be43@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2862c2c80707130245j3f9b09b3i2b461c4e1521c53d@domain.hid>
	<2862c2c80707170336t45ad3266pc5b5f7769623a900@domain.hid>
	<2ff1a98a0707170609u5da092a1nf32d4789b579717@domain.hid>
	<2862c2c80707172257x5f41d8c4p5df5282be4ba98a2@domain.hid>
	<18077.48173.286511.400122@domain.hid>
	<2862c2c80707180036t6e64ccban83924d445d80f9c0@domain.hid>
	<2ff1a98a0707180135q24ab6515kf573215edf0aaafa@domain.hid>
	<2862c2c80707180255h7197a055i58b90228bc2c52df@domain.hid>
	<2ff1a98a0707180739y59f673c3tc7d8668877686212@domain.hid>
	<2862c2c80707182309r2d49f8b6xeb85601230a4be43@domain.hid>
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
To: Yeoh Chun Yeow <yeohchunyeow@domain.hid>
Cc: "Xenomai-help@domain.hid" <xenomai@xenomai.org>

On 7/19/07, Yeoh Chun Yeow <yeohchunyeow@domain.hid> wrote:
> >
> > > My console ttyS0 uses the DBGU, and the port->irq is 1 (AT91_ID_SYS).
> > > Although RTC uses the same interrupt, but it is disabled. We don't use
> > > system timer which uses the same interrupt pin in xenomai. Any ideas?
> >
> > Try adding the following piece of code at the beginning of the I-pipe
> > version of the at91rm9200_timer_init function in
> > arch/arm/mach-at91rm9200/at91rm9200_timer.c:
> >
> >         /* Disable all timer interrupts */
> >         at91_sys_write(AT91_ST_IDR, AT91_ST_PITS |
> AT91_ST_WDOVF |
> > AT91_ST_RTTINC | AT91_ST_ALMS);
> >         (void) at91_sys_read(AT91_ST_SR);       /* Clear
> any pending interrupts */
> Dear Gilles,
>
> Thanks. After disabling the system timer interrupt at the starting of timer
> init function, the problem is solved. Thanks again!
>
> By the way, I would like know if you ever try the 2.6.20-at91-patch in your
> testing and find out the problem. Whenever I patch my kernel with this
> 2.6.20-at91-patch, the system is stalled in a very early stage, not even
> reaching the request_irq in atmel serial driver.

I tried to apply it and verified that there was no reject, assuming
that the changes made by this patch would not disturb the I-pipe
patch. Apparently, I was very wrong. I will have a look at this.

-- 
                                               Gilles Chanteperdrix

