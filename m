Message-ID: <49674C62.5090009@domain.hid>
Date: Fri, 09 Jan 2009 13:08:50 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>	<49330CD3.4090700@domain.hid>	<4933BAE2.3000502@domain.hid>	<4933F1A4.8060209@domain.hid>	<4933F18F.7080103@domain.hid>	<4933FE5A.5060501@domain.hid>	<49355B5D.8070802@domain.hid>	<49355A59.4050600@domain.hid>	<49357C02.1090001@domain.hid>	<49358003.1080705@domain.hid>
	<493BF43B.4080208@domain.hid>	<493FA528.3060307@domain.hid>
	<495CC649.1070203@domain.hid> <495CF842.5000100@domain.hid>
In-Reply-To: <495CF842.5000100@domain.hid>
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
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

Philippe Gerum wrote:
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
>>
> 
> A common issue happens when pthread_self() is inlined in the syscall arg list.
> Early gcc 4.x for powerpc has this problem; never tried with newer releases, but
> rather made sure to use a temporary variable to pass this value to the syscall.

The issue on arm is a similar issue: the problem comes from the
"mode_buf" parameter now passed to pthread_create which clobbers the
register r0, normally used to pass the syscall number.

I am still trying to figure out if it is a bug in Xenomai's syscall
inline assembly, or a bug in gcc or binutils. And even if it is a bug in
the toolchain, I am afraid we will have to find a workaround in the
syscall inline assmbley anyway.

-- 
                                                 Gilles.

