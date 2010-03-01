Message-ID: <4B8C358E.9050303@domain.hid>
Date: Mon, 01 Mar 2010 22:45:50 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>
	<4B86FCBB.10203@domain.hid>	<4B86FFA0.3000403@domain.hid>
	<4B870134.2040802@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>	<4B87FC70.90903@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
	<CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>
	<4B8C2490.1040604@domain.hid> <4B8C25B9.8090705@domain.hid>
	<4B8C26F7.3020306@domain.hid> <4B8C2797.2000501@domain.hid>
	<4B8C29E1.7070404@domain.hid> <4B8C2B3E.8020505@domain.hid>
	<4B8C2C35.6030006@domain.hid> <4B8C2FE6.5000406@domain.hid>
	<4B8C30DA.3000705@domain.hid> <4B8C33FC.3080806@domain.hid>
In-Reply-To: <4B8C33FC.3080806@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Same issue exists in user space. And rt_cond_wait_inner needs fixing.
>>>>> And then there is a spurious sign inversion:
>>>>>
>>>>> diff --git a/src/skins/native/cond.c b/src/skins/native/cond.c
>>>>> index 478321d..f874678 100644
>>>>> --- a/src/skins/native/cond.c
>>>>> +++ b/src/skins/native/cond.c
>>>>> @@ -96,9 +96,9 @@ int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mutex, RTIME timeout)
>>>>>  				&saved_lockcnt, XN_REALTIME, &timeout);
>>>>>  
>>>>>  	while (err == -EINTR)
>>>>> -		err = -XENOMAI_SKINCALL2(__native_muxid,
>>>>> -					 __native_cond_wait_epilogue, mutex,
>>>>> -					 saved_lockcnt);
>>>>> +		err = XENOMAI_SKINCALL2(__native_muxid,
>>>>> +					__native_cond_wait_epilogue, mutex,
>>>>> +					saved_lockcnt);
>>>>>  #endif /* !CONFIG_XENO_FASTSYNCH */
>>>> Ok for the sign inversion, but in this case the status is Ok. We call
>>>> cond_wait_epilogue only if prologue returned -EINTR, and update the
>>>> status, this is what we want.
>>>>
>>>> There is only one way out which will not break the ABI: do not call
>>>> cond_wait_epilogue in the kernel-space cond_wait_prologue.
>>>>
>>> Unfortunately, that ABI is broken: If we get -ETIMEDOUT on cond wait an
>>> -EINTR on mutex lock, we lose the former, don't we?
>>>
>>> If we can't find a workaround, I'm for breaking the ABI for this
>>> particular service - but let's search for an alternative first.
>>>
>> The only way around ABI changes: save the return code of cond_wait
>> /somewhere/ across prologue and epilogue syscalls - but where???
>>
> 
> In-kernel RT_TASK, that's probably the only place. Once
> __rt_cond_wait_epilogue has acquired the mutex (or failed without
> receiving a -EINTR), it can then pick up the original error that this
> task received from rt_cond_wait_prologue and return it. What do you think?

I was thinking about the same idea, by using the xnthread errno.
However, it is not reentrant, in the sense that if a signal handler
emits a syscall which overrides this value, we are toast.

-- 
					    Gilles.

