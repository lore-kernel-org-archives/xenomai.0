Message-ID: <4B4CEA10.5060800@domain.hid>
Date: Tue, 12 Jan 2010 22:30:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>	<4B4C96D5.7060902@domain.hid>	<003e01ca93cb$45fb6d30$d1f24790$@kalatchev@domain.hid>	<4B4CE50D.20907@domain.hid>
	<003f01ca93ce$170e7550$452b5ff0$@kalatchev@domain.hid>
In-Reply-To: <003f01ca93ce$170e7550$452b5ff0$@kalatchev@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Viper board (ARM
	XScale)	problems	with	Xenomai-2.4.10
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ivan Kalatchev <ivan.kalatchev@domain.hid>
Cc: 'Xenomai help' <xenomai@xenomai.org>

Ivan Kalatchev wrote:
>> Chained interrupt and muxed interrupt are the same thing.
>>
> 
> Then may be for Viper __ipipe_mach_irq_mux_p should be
> 	__ipipe_mach_irq_mux_p(irq)(((irq)== IRQ_GPIO_2_x) || ((irq)==gpio_to_irq(VIPER_CPLD_GPIO)))
> ?
> 
> Then it would take care of viper handling CPLD IRQ automatically.

Yes, that would be the old way. But as you pointed out, the code
changed, so the new way, is to avoid duplicating the demux code into an
__ipipe_mach_demux_irq function and simply conditionnaly replace
handle_irq with __ipipe_handle_irq in Linux demux code.


-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

