Message-ID: <4B8D1FE6.50503@domain.hid>
Date: Tue, 02 Mar 2010 15:25:42 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NmR5I-0003k9-N5@domain.hid>	<4B8D0359.4070504@domain.hid>	<4B8D0466.7040403@domain.hid>	<4B8D0542.1020904@domain.hid>
	<4B8D05B3.1020202@domain.hid>	<4B8D07D7.4040108@domain.hid>
	<4B8D091A.7070908@domain.hid>	<4B8D0BA5.505@domain.hid>
	<4B8D0CE7.6020101@domain.hid>	<4B8D11A6.9070400@domain.hid>
	<4B8D12FA.6040807@domain.hid>	<4B8D13E9.3010109@domain.hid>
	<4B8D14BE.8050503@domain.hid>	<4B8D164D.7000906@domain.hid>
	<4B8D16B9.8090609@domain.hid>	<4B8D1A07.4050804@domain.hid>
	<4B8D1AD8.5070507@domain.hid>
In-Reply-To: <4B8D1AD8.5070507@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Native: Fix return
 code of in-kernel rt_cond_wait[_until]
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

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>> Ok for returning -EINTR, it is documented. Kernel-space is not so
>>>>>>>>> different from user-space, rt_task_unblock could wake-up a kernel-space
>>>>>>>>> task blocked in a call to rt_cond_wait.
>>>>>>>>>
>>>>>>>>> However, if the epilogue returns an error, we must return it.
>>>>>>>>>
>>>>>>>> OK for this. Pushed an update, but I also modified it further to avoid
>>>>>>>> returning without the mutex lock unless that one is also failing. Maybe
>>>>>>>> in-kernel POSIX requires the same fix, will check.
>>>>>>> Still not OK. You should reacquire the mutex only if the error is 0,
>>>>>>> -ETIMEDOUT or -EINTR. With any other error, we do not know if we can
>>>>>>> call the epilogue safely.
>>>>>> We _must_ reacquire the mutex - but, granted, we actually have to take
>>>>>> care of invalid cond objects. Lot's of bugs...
>>>>> No. If the error is another error than 0, -ETIMEDOUT, or -EINTR, it
>>>>> means that the error was detected prior to freeing the mutex. So, we do
>>>>> not have to re-acquire the mutex. Quoting POSIX:
>>>>>
>>>>> "Except in the case of [ETIMEDOUT], all these error checks shall act as
>>>>> if they were performed immediately at the beginning of processing for
>>>>> the function and shall cause an error return, in effect, prior to
>>>>> modifying the state of the mutex specified by mutex or the condition
>>>>> variable specified by cond."
>>>>>
>>>>> POSIX does not talk about -EINTR, because it states that in this case,
>>>>> we should return 0 to the application.
>>>> OK, but EIDRM was missing in your list. Will adjust both patches.
>>> No, EIDRM is part of the "other errors than ETIMEDOUT and 0"
>>>
>> I interpret the spec fairly differently here: It states that we have to
>> leave the mutex state behind *as if* the error was already detected on
>> entry - thus we are expected to restore its state.
> 
> No. We must return prior to modifying its state. Not change its state
> then restore it.
> 
> There is no EIDRM anyway, I return 0, and the user gets EINVAL when
> calling pthread_cond_wait again.

No, this is not even the way it works. EIDRM can not happen, because
pthread_cond_destroy will return EBUSY as long as a thread is blocked in
a call to pthread_cond_wait. This is allowed by POSIX.



> 


-- 
					    Gilles.

