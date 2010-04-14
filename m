Message-ID: <4BC581A2.7000000@domain.hid>
Date: Wed, 14 Apr 2010 10:49:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1O1e8n-0007uc-At@domain.hid> <4BC57FB0.40203@domain.hid>
	<4BC5813D.80508@domain.hid>
In-Reply-To: <4BC5813D.80508@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Fix historic msleep
	wrapping
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> GIT version control wrote:
>>> Module: xenomai-jki
>>> Branch: queues/proc
>>> Commit: f14c48e888b7f811f4c040b3b7ff0783fe115978
>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=f14c48e888b7f811f4c040b3b7ff0783fe115978
>>>
>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>> Date:   Mon Apr  5 17:25:29 2010 +0200
>>>
>>> Fix historic msleep wrapping
>>>
>>> Probably only an academic exercise: Fix the rounding bug in msleep
>>> wrapper for kernels < 2.4.28.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>
>>> ---
>>>
>>>  include/asm-generic/wrappers.h |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
>>> index 15d9837..64ec43f 100644
>>> --- a/include/asm-generic/wrappers.h
>>> +++ b/include/asm-generic/wrappers.h
>>> @@ -197,7 +197,7 @@ do {									\
>>>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,28)
>>>  #define msleep(x) do {				 \
>>>  	set_current_state(TASK_UNINTERRUPTIBLE); \
>>> -	schedule_timeout((x)*(HZ/1000));         \
>>> +	schedule_timeout(((x)*HZ)/1000);         \
>>>  } while(0)
>>>  #endif
>> Mmm... changing that code again? What about replacing it with the close
>> patch we discussed?
> 
> The close patch (actually a rewrite of it) will only avoid polling on
> the context reference count. Other polling is part of the RTDM API and
> cannot be easily removed.

Yes sorry. I thought this was the msleep used by the close syscall. I
hated that msleep and that loop, in debugging phases of RTDM drivers,
this also explains why I am so much in favour of the close patch...

-- 
					    Gilles.

