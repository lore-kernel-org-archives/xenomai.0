Message-ID: <4B4C96D5.7060902@domain.hid>
Date: Tue, 12 Jan 2010 16:35:49 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>
	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>
In-Reply-To: <002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Viper board (ARM XScale) problems
	with	Xenomai-2.4.10
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
> Gilles,
> 
>> It comes from a macro written in assembly in
>> include/asm-arm/arith.h. However, this code compiles fine here for
>> armv5. You are probably using a toolchain that is incompatible with
>> this assembly code. What version of binutils are you using? If that
>> is not hard to you, please upgrade to a more recent toolchain.
>> Otherwise, we will try to get your assembly to accept this code
>> (but looking at the error messages, it looks hopeless).
> 
> I'm using original toolchain that came with development for Viper
> board from Arcom. That probably was time of 2.4 kernels... Trouble
> with upgrading of toolchain I'm afraid of - is that all packages,
> libraries etc., that I used thus far with our embedded application
> will become obsolete and will need to be recompiled with this new
> compiler.

Ok, what version of gcc/binutils ? You can workaround this build issue,
by using the generic implementation of xnarch_nodiv_llimd. In
incldude/asm-arm/arith.h, replace

#if __LINUX_ARM_ARCH >= 4
with
#if __LINUX_ARM_ARCH >= 4 && __GNUC__ >= 4

Assuming that your gcc version is 3.something.

> 
> As to my first problem with assigning of general interrupt handler to
> chained irq acknowledgment, I'll try to change my code to go with it,

Please try what I told you: replacing handle_irq with __ipipe_handle_irq
in Linux' original irq handler.

> as my real-time handler for chained interrupt does actually call some
> 'acknowledgment' that is based on general interrupt handler. It's
> just it took quite a time to figure out weird behaviour of my
> application when I switched to new Xenomai and couldn't find any info
> about how Xenomai changes chained interrupts handling. That caused
> some frustration. May be there should be some sort of Howto about it
> on Xenomai site?

Actually this is described in the howto porting the I-pipe for arm to a
new board:
http://www.xenomai.org/index.php/I-pipe:ArmPorting#New_variables_and_functions
see ipipe_irq_mux_p and ipipe_demux_irq

But the problem is that the generic code changed and I missed that
change, so the old way is documented, not the new one.

> 
> Thanks a lot for you help.
> 
> Best regards,
> 
> Ivan
> 
> 
> 
> _______________________________________________ Xenomai-help mailing
> list Xenomai-help@domain.hid https://mail.gna.org/listinfo/xenomai-help


-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

