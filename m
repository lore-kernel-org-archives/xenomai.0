Message-ID: <495D073E.3060002@domain.hid>
Date: Thu, 01 Jan 2009 19:11:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>	<49330CD3.4090700@domain.hid>	<4933BAE2.3000502@domain.hid>	<4933F1A4.8060209@domain.hid>	<4933F18F.7080103@domain.hid>
	<4933FE5A.5060501@domain.hid>	<49355B5D.8070802@domain.hid>
	<49355A59.4050600@domain.hid>	<49357C02.1090001@domain.hid>
	<49358003.1080705@domain.hid> <493BF43B.4080208@domain.hid>
	<493FA528.3060307@domain.hid> <495CC649.1070203@domain.hid>
	<495CF915.6010506@domain.hid>
In-Reply-To: <495CF915.6010506@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread cancelation and scheduling magics
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> Gilles Chanteperdrix wrote:
>> Wolfgang Grandegger wrote:
>>> Wolfgang Grandegger wrote:
>>>> Hi Gilles,
>>>>
>>>> Gilles Chanteperdrix wrote:
>>>>> Wolfgang Grandegger wrote:
>>>>>> I'm also puzzled why pthread_setschedparam() does make a mode switch
>>>>>> to secondary mode (sometimes).
>>>>> That is normal. The glibc caches threads priority value, so we have to
>>>>> call __real_pthread_setschedparam to update them. This issue has been
>>>>> solved differently on trunk, but unfortunately, we can not backport this
>>>>> modification on v2.4.x branch.
>>>> To get you right. With v2.4.x it is not possible with the POSIX skin to
>>>> change the priority of a real-time thread in the primary mode without
>>>> loosing determinism (because it will switch to secondary mode). What
>>>> options do I have?
>>> I gave Xenomai trunk a try and pthread_setschedparam() does not switch
>>> to secondary mode any more on my PowerPC test system. Nice, I just get
>>> an Oops in thread_delete from time to time. More on that issue later.
>>> For my ARM i.mx31 system, a need a few patches to get the Xenomai src's
>>> compiled:
>>>
>>> Index: include/asm-generic/bits/bind.h
>>> ===================================================================
>>> --- include/asm-generic/bits/bind.h	(revision 4450)
>>> +++ include/asm-generic/bits/bind.h	(working copy)
>>> @@ -72,7 +72,7 @@
>>>  	err = XENOMAI_SYSCALL1(__xn_sys_current, &current);
>>>  	if (err) {
>>>  		fprintf(stderr, "Xenomai: error obtaining handle for current "
>>> -			"thread: %s\n", strerror(err));
>>> +			"thread: %s\n", strerror(-err));
>>>  		exit(1);
>>>  	}
>>>  	__xeno_set_current(current);
>>> Index: include/asm-arm/syscall.h
>>> ===================================================================
>>> --- include/asm-arm/syscall.h	(revision 4450)
>>> +++ include/asm-arm/syscall.h	(working copy)
>>> @@ -228,7 +228,7 @@
>>>  	volatile unsigned long long *const tscp = __xn_tscinfo.u.fr.tsc;
>>>  	volatile unsigned *const counterp = __xn_tscinfo.u.fr.counter;
>>>          const unsigned mask = __xn_tscinfo.u.fr.mask;
>>> -	register unsigned long long after, before;
>>> +	register unsigned long long result;
>>>          unsigned counter;
>>>  
>>>          __asm__ ("ldmia %1, %M0\n": "=r"(result): "r"(tscp), "m"(*tscp));
>>>
>>>
>>> When I then start my application or cyclictest I get:
>>>
>>> -bash-3.2# ./cyclictest -n 
>>> Xenomai: error obtaining handle for current thread: Operation not permitted
>>>
>>> As the latency program works fine, it seems to be a problem with the
>>> POSIX skin. Any idea what it is?
>> What version of gcc are you using ? When trying to get xenomai running
>> on an ARM platform, I found out that gcc 4.3.1 and 4.3.2 have a bug on
>> ARM which thrashes the parameters passed to  some xenomai syscalls.
> 
> The new ELDK 4.2 for ARM11 with VFP support [1] uses:
> 
>   $ armVFP-linux-gcc --version
>   armVFP-linux-gcc (GCC) 4.2.2
> 
> Nevertheless, the problems do not show up with Xenomai v2.4.x and
> therefore it's unlikely that Xenomai syscalls do not work properly.
> 
> [1] http://www.denx.de/en/News/WebHome#NewsEldk42Arm

Ok. So this is not the same bug. I am about to reproduce the issue. I
wanted to do it at work, but have been struggling (still unsuccessfully)
to get a working toolchain with EABI and NPTL for big endian arm. I am
using crosstool-ng which made an apparently working version of gcc 4.3.2
 until I found that it had a bug, and since then any attempt to make a
toolchain with an earlier version of gcc and/org glibc failed for
different reasons.

So, if anyones knows of a working combination of gcc/glibc/binutils for
big-endian arms with EABI and NPTL, I am interested.

-- 
					    Gilles.

