Message-ID: <4B8D162E.90305@domain.hid>
Date: Tue, 02 Mar 2010 14:44:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1NmR5I-0003k9-N5@domain.hid>
	<4B8D0359.4070504@domain.hid>	<4B8D0466.7040403@domain.hid>
	<4B8D0542.1020904@domain.hid> <4B8D05B3.1020202@domain.hid>
	<4B8D07D7.4040108@domain.hid> <4B8D091A.7070908@domain.hid>
	<4B8D0BA5.505@domain.hid> <4B8D0CE7.6020101@domain.hid>
	<4B8D11A6.9070400@domain.hid> <4B8D12FA.6040807@domain.hid>
	<4B8D13E9.3010109@domain.hid> <4B8D154B.6050005@domain.hid>
In-Reply-To: <4B8D154B.6050005@domain.hid>
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

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Ok for returning -EINTR, it is documented. Kernel-space is not so
>>>>> different from user-space, rt_task_unblock could wake-up a kernel-space
>>>>> task blocked in a call to rt_cond_wait.
>>>>>
>>>>> However, if the epilogue returns an error, we must return it.
>>>>>
>>>> OK for this. Pushed an update, but I also modified it further to avoid
>>>> returning without the mutex lock unless that one is also failing. Maybe
>>>> in-kernel POSIX requires the same fix, will check.
>>> Still not OK. You should reacquire the mutex only if the error is 0,
>>> -ETIMEDOUT or -EINTR. With any other error, we do not know if we can
>>> call the epilogue safely.
>> We _must_ reacquire the mutex - but, granted, we actually have to take
>> care of invalid cond objects. Lot's of bugs...
>>
> 
> Was only an issue of my POSIX patch, native was not touching cond in the
> epilogue. Update pushed.

Ok. I have work to do, so, will stop commenting each of your patches.
But no, I will not take this one.

-- 
					    Gilles.

