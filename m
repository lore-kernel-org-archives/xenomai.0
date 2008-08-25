Message-ID: <48B2E40B.4070401@domain.hid>
Date: Mon, 25 Aug 2008 18:55:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B2D1C4.5010306@domain.hid> <48B2E115.4070107@domain.hid>
	<48B2E194.3040905@domain.hid> <48B2E37E.5040004@domain.hid>
In-Reply-To: <48B2E37E.5040004@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fast native mutexes vs. RT_MUTEX_INFO.lockcnt
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> Jan Kiszka wrote:
>>>> Hi,
>>>>
>>>> next issue on my way towards fast native mutexes: as mutexes are now
>>>> mostly acquired in user space, the recursion counter lockcnt will only
>>>> be maintained in the context of the owning thread (at best: its process)
>>>> in user space. No update on the kernel-side lockcnt will take place
>>>> anymore, thus rt_mutex_inquire can only return 0 or 1, no > 1. Is it OK
>>>> to break the ABI here?
>>>>
>>> I think so, we might lose some debug information, but that's the price for much
>>> better performances. I can't imagine any sane code iterating lockcnt-times
>>> blindly to unlock a mutex it owns until it is free. Nah, of course not...
>>>
>>> Btw, I guess that the /proc information about mutexes would have to be reworked
>>> as well.
>> Haven't looked into this yet (or haven't stumbled over any issue). What
>> conflict / lack of data do you have in mind here?
>>
> 
> Basically, exporting the lock owner and the locking depth is likely no more
> possible for userland optimized mutexes.

Ah, that's also visible at that place. But the owner is still available
as userland writes its own xnthread_t into the lock variable. We just
face the same issue as with RT_MUTEX_INFO.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

