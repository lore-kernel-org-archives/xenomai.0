Message-ID: <4B4CE50D.20907@domain.hid>
Date: Tue, 12 Jan 2010 22:09:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>	<4B4C96D5.7060902@domain.hid>
	<003e01ca93cb$45fb6d30$d1f24790$@kalatchev@domain.hid>
In-Reply-To: <003e01ca93cb$45fb6d30$d1f24790$@kalatchev@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Viper board (ARM XScale)
	problems	with	Xenomai-2.4.10
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
>>> May be there should be some sort of Howto about it on Xenomai
>>> site?
>> Actually this is described in the howto porting the I-pipe for arm
>> to a new board: http://www.xenomai.org/index.php/I- 
>> pipe:ArmPorting#New_variables_and_functions see ipipe_irq_mux_p and
>> ipipe_demux_irq
>> 
>> But the problem is that the generic code changed and I missed that 
>> change, so the old way is documented, not the new one.
> 
> I actually read that document, but thing is that CPLD interrupt on
> Viper is not MUX interrupt, although it is chained interrupt. That's
> why I missed it. So may be HOWTO should still mention chained
> interrupts specifically in addition to MUX interrupts. Just a
> thought.

Chained interrupt and muxed interrupt are the same thing.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

