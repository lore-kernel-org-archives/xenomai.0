Message-ID: <4B73218A.9080306@domain.hid>
Date: Wed, 10 Feb 2010 22:13:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NfBdX-0001ga-4b@domain.hid>
	<4B72A7E2.5020001@domain.hid>	<4B72A9DA.1090104@domain.hid>
	<4B730A04.9040908@domain.hid> <4B731608.6010803@domain.hid>
	<4B73180C.6070301@domain.hid> <4B73207C.6020400@domain.hid>
In-Reply-To: <4B73207C.6020400@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Make
 xnarch_init_timeconv an uninlined weak function
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> GIT version control wrote:
>>>>>>> Module: xenomai-jki
>>>>>>> Branch: for-upstream
>>>>>>> Commit: 6b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>>>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=6b40653e9c3c4a2433bb4e91344fc378eb860f75
>>>>>>>
>>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>> Date:   Wed Feb 10 13:24:29 2010 +0100
>>>>>>>
>>>>>>> Make xnarch_init_timeconv an uninlined weak function
>>>>>>>
>>>>>>> Otherwise the wrong set of time conversion variables might get
>>>>>>> initialized when using > 1 skin libraries.
>>>>>> If that would be possible, then it is the conversion variables which
>>>>>> should made be weak, not the function.
>>>>>>
>>>>>> The way I see it, the posix and native skins currently get a different
>>>>>> set of variables and functions, which works, but with your change, since
>>>>>> there is only one function, only one set of variable gets initialized by
>>>>>> the two function calls. And one skin just broke.
>>>>>>
>>>>>> Or am I missing something? Does the patch fix a problem you really had?
>>>>> Frankly, I wasn't able to test in the field yet as replacing the libs
>>>>> there is non-trivial. But I was able to observe that only one set of
>>>>> functions is used - which is logical considering the weak marks. And
>>>>> this breaks due to the static inline initialization.
>>>>>
>>>>> However, let's mark both functions and variables weak to fix the issue
>>>>> and avoid leaving unused variables around. Will update my patch in a minute.
>>>> Ok. I am reverting this patch until you provide me with another
>>>> solution. It causes latency to segfault purely and simply at startup on
>>>> my dual PIII.
>>>>
>>> Cannot reproduce yet. Do you have a backtrace?
>> No. But the problem is probably the same as the one signaled by Henri,
>> a misplaced weak directive ending up in a symbol with no address at all.
>> Since the current situation works, I am going to wait for the "clean"
>> fix which puts some code/data in the src/skins/common directory.
>>
> 
> Find it in my tree. But it's not yet well tested.

I do not like it either. Functions which are in src/skins/common should
still be weak, since this lib is included in all the skins libraries.

xnarch_init_timeconv does not need to be exported, it may only be called
in common (bind.c, or timeconv.c, or something like that).

xnarch_tsc_to_ns/ns_to_tsc have no reason to be put in arith.h,
timeconv.h was about just right. Maybe create asm-generic/timeconv.h?

-- 
					    Gilles.

