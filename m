Message-ID: <4BC865F1.5000303@domain.hid>
Date: Fri, 16 Apr 2010 15:28:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1O2jBF-0000vQ-JB@xenomai.org> <4BC855E6.106@domain.hid>
	<4BC85899.90700@domain.hid> <4BC85EF5.3000008@domain.hid>
	<4BC8617E.4060307@domain.hid>
In-Reply-To: <4BC8617E.4060307@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Wolfgang Mauerer : RTDM: Fix
 potential NULL pointer dereference
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
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> GIT version control wrote:
>>>>> Module: xenomai-jki
>>>>> Branch: for-upstream
>>>>> Commit: 55ebde80258b5b6c3d29d37b5f30a3199faf0881
>>>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=55ebde80258b5b6c3d29d37b5f30a3199faf0881
>>>>>
>>>>> Author: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
>>>>> Date:   Tue Mar 30 11:13:33 2010 +0200
>>>>>
>>>>> RTDM: Fix potential NULL pointer dereference
>>>>>
>>>>> The rework in 95278926edc559d4 misses the case that context can be NULL,
>>>>> which can (and has) triggered a kernel oops. Take care of this case.
>>>>>
>>>>> Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>> I still think that fix is a useles waste of time. Let us merge
>>>> Philippe's patches instead.
>>> Please accept that Philippe's patch is orthogonal to this bug.
>>>
>>> And it didn't work as-is. I'll post a rework which has the same benefit
>>> (avoiding to poll on pending context references) - once it is tested.
>> Ok. I am fine with any variation as long as:
>> - close returns immediately even if the request is not taken into
>> account immediately;
>> - the file descriptor index is available again as soon as close returns;
>> - the kernel objects attached to the file descriptor are destroyed when
>> the last reference to it is closed.
> 
> That's precisely what I implemented. Additionally, I had to take care of
> RTDM drivers deferring the close via EAGAIN and some other minor aspects.

I am afraid EAGAIN gets translated automatically into ENOMERGE ;-)

> 
>> In shoft: POSIX conformance.
> 
> At least blocking has nothing to do with POSIX (some drivers will
> continue to block in their close handlers). And - AFAIU - the order of
> releasing the fd internally and blocking on something during close is
> not specified.

The point is that the close handler should not be called when close is
called, but when the last reference to the file descriptor is closed,
asynchronously if need be. So, it may block. But the close service
should return immediately.

Maybe it is not POSIX, but it is the way it should be, and the way
people expect a sane driver API to answer. Crappy drivers which do not
answer to SIGINT are simply not acceptable and only a waste developer
time (and POSIX mandates EINTR in that case).

-- 
					    Gilles.

