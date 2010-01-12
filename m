Message-ID: <4B4CD5E8.7040904@domain.hid>
Date: Tue, 12 Jan 2010 21:04:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>
	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>
	<4B4C96D5.7060902@domain.hid>
	<002101ca93a1$a39d4050$ead7c0f0$@kalatchev@domain.hid>
	<4B4CA076.1050205@domain.hid>
	<002501ca93ae$2b168850$814398f0$@kalatchev@domain.hid>
In-Reply-To: <002501ca93ae$2b168850$814398f0$@kalatchev@domain.hid>
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
>>> my gcc is 3.3.4
>>> 
>>> I changed arith.h as you suggested, and it compiled, but then
>>> linker couldn't find rthal_arm_nodiv_ullimd definition, as there
>>> is no  code for it for __GNUC__ < 4.
>> Ok, you need to change the other #ifdef a bit further.
> 
> When I added __GNUC__ >= 4 to both #if __LINUX_ARM_ARCH__ in
> asm-arm/arith.h, I again received compiler error for some reason. Is
> there way to do what nodiv_ullimd is doing through Linux's do_div ?
> That's what I usually use.

If you are interested in nodiv_llimd vs do_div based llimd, see the test
case named "arith".

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

