Message-ID: <4B4C84AC.3020207@domain.hid>
Date: Tue, 12 Jan 2010 15:18:20 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>
	<4B4BADDD.7070900@domain.hid>
	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>
In-Reply-To: <001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Viper board (ARM XScale) problems with
	Xenomai-2.4.10
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
Cc: Xenomai help <xenomai@xenomai.org>

Ivan Kalatchev wrote:
> Hi Gilles,
> 
>> Yes good idea, old patches contain a deadly bug which has been
>> fixed only recently. Going one step further, I think you should try
>> Xenomai 2.5.0. It really has interesting features for ARM, such as
>> unlocked context switch, which really decreases interrupt latency.
>> 
> 
> I actually did try 2.5.0, but problem was I couldn't compile it. My
> compiler fails when it reaches src/skins/native/timer.c:
> 
> --------- Making all in src make[1]: Entering directory
> `/mnt/drive-1/build/xenomai-2.5.0/src' Making all in include make[2]:
> Entering directory `/mnt/drive-1/build/xenomai-2.5.0/src/include' 
> make  all-am make[3]: Entering directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/include' make[3]: Nothing to be
> done for `all-am'. make[3]: Leaving directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/include' make[2]: Leaving
> directory `/mnt/drive-1/build/xenomai-2.5.0/src/include' Making all
> in rtdk make[2]: Entering directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/rtdk' make[2]: Nothing to be
> done for `all'. make[2]: Leaving directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/rtdk' Making all in skins 
> make[2]: Entering directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/skins' Making all in common 
> make[3]: Entering directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/skins/common' make[3]: Nothing
> to be done for `all'. make[3]: Leaving directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/skins/common' Making all in
> native make[3]: Entering directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/skins/native' /bin/sh
> ../../../libtool  --tag=CC   --mode=compile arm-linux-gcc
> -DHAVE_CONFIG_ H -I. -I../../../src/include  -O2 -D_GNU_SOURCE
> -D_REENTRANT -Wall -pipe -march= armv5 -D__XENO__ -D__IN_XENO__
> -Wstrict-prototypes -I../../../include    -MT lib native_la-timer.lo
> -MD -MP -MF .deps/libnative_la-timer.Tpo -c -o libnative_la-t imer.lo
> `test -f 'timer.c' || echo './'`timer.c libtool: compile:
> arm-linux-gcc -DHAVE_CONFIG_H -I. -I../../../src/include -O2
> -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv5 -D__XENO__
> -D__IN_XENO__ -Ws trict-prototypes -I../../../include -MT
> libnative_la-timer.lo -MD -MP -MF .deps/ libnative_la-timer.Tpo -c
> timer.c  -fPIC -DPIC -o .libs/libnative_la-timer.o {standard input}:
> Assembler messages: {standard input}:115: Error: register or shift
> expression expected -- `adds r5,r 8,lsr#31' {standard input}:116:
> Error: register expected, not '#0' -- `adcs r0,#0' {standard
> input}:117: Error: register expected, not '#0' -- `adc r1,#0' 
> {standard input}:119: Error: bad arguments to instruction -- `adds
> r5,r8' {standard input}:120: Error: bad arguments to instruction --
> `adcs r0,r9' {standard input}:121: Error: register expected, not '#0'
> -- `adc r1,#0' {standard input}:123: Error: bad arguments to
> instruction -- `adds r5,r8' {standard input}:124: Error: bad
> arguments to instruction -- `adcs r0,r9' {standard input}:125: Error:
> register expected, not '#0' -- `adc r1,#0' {standard input}:177:
> Error: register or shift expression expected -- `adds r5,r 8,lsr#31' 
> {standard input}:178: Error: register expected, not '#0' -- `adcs
> r0,#0' {standard input}:179: Error: register expected, not '#0' --
> `adc r1,#0' {standard input}:181: Error: bad arguments to instruction
> -- `adds r5,r8' {standard input}:182: Error: bad arguments to
> instruction -- `adcs r0,r9' {standard input}:183: Error: register
> expected, not '#0' -- `adc r1,#0' {standard input}:185: Error: bad
> arguments to instruction -- `adds r5,r8' {standard input}:186: Error:
> bad arguments to instruction -- `adcs r0,r9' {standard input}:187:
> Error: register expected, not '#0' -- `adc r1,#0' make[3]: ***
> [libnative_la-timer.lo] Error 1 make[3]: Leaving directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/skins/native' make[2]: ***
> [all-recursive] Error 1 make[2]: Leaving directory
> `/mnt/drive-1/build/xenomai-2.5.0/src/skins' make[1]: ***
> [all-recursive] Error 1 make[1]: Leaving directory
> `/mnt/drive-1/build/xenomai-2.5.0/src' make: *** [all-recursive]
> Error 1
> 
> I looked at time.c but couldn't figure out what's causing this.

It comes from a macro written in assembly in include/asm-arm/arith.h.
However, this code compiles fine here for armv5. You are probably using
a toolchain that is incompatible with this assembly code. What version
of binutils are you using? If that is not hard to you, please upgrade to
a more recent toolchain. Otherwise, we will try to get your assembly to
accept this code (but looking at the error messages, it looks hopeless).

> 
> 
>> The interrupt controller depends on the SOC you are using, so
>> normally, if the PXA controller is not buggy, it should not be
>> buggy on any PXA. Now, if it does not work for your board, it may
>> be for several reasons, I would appreciate if you could trace the
>> reason why handle_level_irq does not work, because it should.
>> 
>> I would also be curious to know why handle_edge_irq works with USB 
>> driver. Maybe the USB driver has some quirks for this case?
> 
> I did trace the reason. (took me long time, as the only tool I have -
> printk). The regular linux kernel when doing chained interrupts

I also use only printk.

> doesn't call mask/unmask for MUX interrupts during 'demultiplexing'
> of chained interrupt. So mask of the MUX interrupt stays as it was
> set during enabling of MUX interrupt - enabled. But when Xenomai
> changed interrupt handler to be level_irq, it calls mask_ack_irq
> during acknowledgment - see __ipipe_ack_level_irq. As a result, MAX
> mask is assigned to 0 and MAX interrupt became disabled for some
> time. Looks like just because it happens during walking of pipe line
> when interrupts are enabled, it runs into conflict with hardware that
> supposed to produce trigger at this moment.

Yes, the PXA interrupt controller is bogus, and needs the interrupts to
remain enabled to work, as explained in another mail.

Please do not forget to CC the list.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

