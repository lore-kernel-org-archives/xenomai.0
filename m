Message-ID: <4DDD4F14.4050201@domain.hid>
Date: Wed, 25 May 2011 20:48:52 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4DDA66CF.2010307@domain.hid> <4DDB349B.5030209@domain.hid>
	<4DDB76C6.2090008@domain.hid> <4DDB7B3D.2030607@domain.hid>
	<4DDB7C2C.4030206@domain.hid> <4DDB8136.10506@domain.hid>
	<4DDB8A1D.4050704@domain.hid> <4DDB8B5F.9070906@domain.hid>
	<4DDBA341.6060009@domain.hid> <4DDBA4D6.5070106@domain.hid>
	<4DDBB82D.6040803@domain.hid> <4DDBBAAF.2090008@domain.hid>
	<4DDCE5EA.5020900@domain.hid> <4DDCEEEB.9050500@domain.hid>
	<4DDCF223.2020307@domain.hid> <4DDCF3B8.8080209@domain.hid>
	<4DDCF49F.2020708@domain.hid>
In-Reply-To: <4DDCF49F.2020708@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL] native: Fix msendq fastlock leakage
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 05/25/2011 02:22 PM, Jan Kiszka wrote:
> On 2011-05-25 14:19, Gilles Chanteperdrix wrote:
>> On 05/25/2011 02:12 PM, Jan Kiszka wrote:
>>> On 2011-05-25 13:58, Gilles Chanteperdrix wrote:
>>>> On 05/25/2011 01:20 PM, Jan Kiszka wrote:
>>>>> On 2011-05-24 16:03, Gilles Chanteperdrix wrote:
>>>>>> On 05/24/2011 03:52 PM, Jan Kiszka wrote:
>>>>>>> On 2011-05-24 14:30, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>> Do you already have an idea how to get that info to the delete hook
>>>>>>>>>>>>> function?
>>>>>>>>>>>>
>>>>>>>>>>>> Yes. We start by not applying the list reversal patch, then the sys_ppd
>>>>>>>>>>>> is the first in the list. So, we can, in the function ppd_remove_mm,
>>>>>>>>>>>> start by removing all the others ppd, then remove the sys ppd (that is
>>>>>>>>>>>> the first), last. This changes a few signatures in the core code, a lot
>>>>>>>>>>>> of things in the skin code, but that would be for the better...
>>>>>>>>>>>
>>>>>>>>>>> I still don't see how this affects the order we use in
>>>>>>>>>>> do_taskexit_event, the one that prevents xnsys_get_ppd usage even when
>>>>>>>>>>> the mm is still present.
>>>>>>>>>>
>>>>>>>>>> The idea is to change the cleanup routines not to call xnsys_get_ppd.
>>>>>>>>>
>>>>>>>>> ...and use what instead? Sorry, I'm slow today.
>>>>>>>>
>>>>>>>> The sys_ppd passed as other argument to the cleanup function.
>>>>>>>
>>>>>>> That would affect all thread hooks, not only the one for deletion. And
>>>>>>> it would pull in more shadow-specific bits into the pod.
>>>>>>>
>>>>>>> Moreover, I think we would still be in troubles as mm, thus ppd,
>>>>>>> deletion takes place before last task deletion, thus taskexit hook
>>>>>>> invocation. That's due to the cleanup ordering in the kernel's do_exit.
>>>>>>>
>>>>>>> However, if you have a patch, I'd be happy to test and rework my leakage
>>>>>>> fix.
>>>>>>
>>>>>> I will work on this ASAP.
>>>>>
>>>>> Sorry for pushing, but I need to decide if we should role out my
>>>>> imperfect fix or if there is chance to use some upstream version
>>>>> directly. Were you able to look into this, or will this likely take a
>>>>> bit more time?
>>>>
>>>> I intended to try and do this next week-end. If it is more urgent than
>>>> that, I can try in one or two days. In any case, I do not think we
>>>> should try and workaround the current code, it is way to fragile.
>>>
>>> Mmh, might be true. I'm getting the feeling we should locally revert all
>>> the recent MPS changes to work around the issues. It looks like there
>>> are more related problems sleeping (we are still facing spurious
>>> fast-synch related crashes here - examining ATM).
>>
>> This is the development head, it may remain broken for short times while
>> we are fixing. I would understand reverting on the 2.5 branch, not on -head.
> 
> I was thinking loudly about our (Siemens) local branch, not -head. We
> are forced to use head to have features like automatic non-RT shadow
> migration.

Now that I think about it, leaking a few bytes in the private heap is
completely harmless, since it is destroyed anyway, and xnheap_free does
enough checks to avoid clobbering already freed memory, though
destroying this heap last is the way to go, as I have already said.

A bit less in the global heap, but this one should be used less often,
and from your explanation, I understand this is not the case you are
interested in, otherwise you would not care if xnpod_userspace_p() is
working.

In any case, it should not cause crashes, it is just a leak.

> 
>>
>>> Another thing that just came to my mind: Do we have a well-defined
>>> destruction order of native skin or native tasks vs. system skin? I mean
>>> the latter destroys the local sem_heap while the former may purge
>>> remaining native resources (including the MPS fastlock). I think the
>>> ordering is inverted to what the code assumes (heap is destructed before
>>> the last task), no?
>>
>> IMO, the system skin destroy callback should be called last, this should
>> solve these problems. This is what I was talking about.
> 
> OK. Still, tasks aren't destroyed on mm shoot-down but via a dedicated
> do_exit callback that is invoke by the kernel a few instructions later.
> Nothing we can directly influence from Xenomai code.

We do not care, we only use the mm pointer value as a key, and this one
is still available when the exit callback is called. So, we have the mm
pointer, we can have the process private ppd, normally, we have all that
we need. It is just a question of finding an interface which is not too
intrusive.

-- 
                                                                Gilles.

