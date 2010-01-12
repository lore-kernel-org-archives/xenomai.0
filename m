Message-ID: <4B4CFD27.1030602@domain.hid>
Date: Tue, 12 Jan 2010 23:52:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <001101ca930a$1052fa70$30f8ef50$@kalatchev@domain.hid>	<4B4BADDD.7070900@domain.hid>	<001f01ca9390$5fa20db0$1ee62910$@kalatchev@domain.hid>	<4B4C84AC.3020207@domain.hid>	<002001ca9399$99b07c40$cd1174c0$@kalatchev@domain.hid>	<4B4C96D5.7060902@domain.hid>	<002101ca93a1$a39d4050$ead7c0f0$@kalatchev@domain.hid>	<4B4CA076.1050205@domain.hid>	<002501ca93ae$2b168850$814398f0$@kalatchev@domain.hid>	<4B4CD5E8.7040904@domain.hid>	<004301ca93d8$4f6ca660$ee45f320$@kalatchev@domain.hid>	<4B4CFAF1.80204@domain.hid>
	<004401ca93d9$61d05530$2570ff90$@kalatchev@domain.hid>
In-Reply-To: <004401ca93d9$61d05530$2570ff90$@kalatchev@domain.hid>
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
>> Could you show me the error messages? The assembly sequence is pretty
>> simple.
>>
> 
> {standard input}:142: Error: bad arguments to instruction -- `adds r0,lr'
> {standard input}:143: Error: bad arguments to instruction -- `adcs ip,r2'
> {standard input}:144: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:148: Error: bad arguments to instruction -- `adds r0,r4'
> {standard input}:149: Error: bad arguments to instruction -- `adcs ip,r1'
> {standard input}:150: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:152: Error: bad arguments to instruction -- `adds r0,r5'
> {standard input}:153: Error: bad arguments to instruction -- `adcs ip,r2'
> {standard input}:154: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:224: Error: bad arguments to instruction -- `adds r4,r8'
> {standard input}:225: Error: bad arguments to instruction -- `adcs r5,ip'
> {standard input}:226: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:228: Error: bad arguments to instruction -- `adds r4,r9'
> {standard input}:229: Error: bad arguments to instruction -- `adcs r5,lr'
> {standard input}:230: Error: register expected, not '#0' -- `adc r3,#0'
> {standard input}:237: Error: bad arguments to instruction -- `adds r4,fp'
> {standard input}:238: Error: bad arguments to instruction -- `adcs r5,ip'
> 
> I just checked ARM instructions and adds for instance should be  
> 	adds r0,r1,r2  # where r0 = r1 + r2
> 
> but in arith.h there are only 2 arguments ??

Well, we probably do not check the same ARM manual, because mine allows
adds with two arguments. Anyway, you can try to fix the assembly. I
guess you can repeat the first argument before each add. Otherwise, I
can send you a .o, which I will ask you to disassemble to know what your
version of binutils wants.

-- 
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

