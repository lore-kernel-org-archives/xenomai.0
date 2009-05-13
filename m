Message-ID: <4A0AE9EF.1010107@domain.hid>
Date: Wed, 13 May 2009 17:40:31 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A0AC1C8.4050006@domain.hid> <4A0AC3F9.9090103@domain.hid>
	<4A0AC8A6.1000701@domain.hid> <4A0AE2AC.7010302@domain.hid>
In-Reply-To: <4A0AE2AC.7010302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Troubles with switchtest
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Hi Gilles,
>>>>
>>>> I'm currently facing a nasty effect with switchtest over latest git head
>>>> (only tested this so far): running it inside my test VM (ie. with
>>>> frequent excessive latencies) I get a stalled Linux timer IRQ quite
>>>> quickly. System is otherwise still responsive, Xenomai timers are still
>>>> being delivered, other Linux IRQs too. switchtest complained about
>>>>
>>>>     "Warning: Linux is compiled to use FPU in kernel-space."
>>>>
>>>> when it was started. Kernels are 2.6.28.9/ipipe-x86-2.2-07 and
>>>> 2.6.29.3/ipipe-x86-2.3-01 (LTTng patched in, but unused), both show the
>>>> same effect.
>>>>
>>>> Seen this before?
>>> The warning about Linux being compiled to use FPU in kernel-space means
>>> that you enabled soft RAID or compiled for K7, Geode, or any other
>> RAID is on (ordinary server config).
> 
> By the way, I wonder how MMX accelerated software raid works on K7,
> since the way I understand the code, calls to kernel_fpu_begin() can not
> be nested.
> 
> If you think they can be nested, then we can make switchtest test fpu in
> Linux kernel-space when these options are enabled.

Sorry, I haven't looked that close into the in-kernel FPU handling so
far. What users are nested in the standard kernel? Or is it RAID in itself?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

