Message-ID: <4B8BDCED.8030501@domain.hid>
Date: Mon, 01 Mar 2010 16:27:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1Nl4tX-0001N9-Hb@domain.hid>
	<4B881E9D.1050101@domain.hid>	<4B88203F.2020907@domain.hid>
	<4B8903E1.3020805@domain.hid> <4B8B7540.609@domain.hid>
	<4B8B84BC.90300@domain.hid> <4B8B971D.5080807@domain.hid>
	<4B8B98F5.10602@domain.hid> <4B8BA361.1040807@domain.hid>
	<4B8BC277.4010108@domain.hid> <4B8BC62F.6090403@domain.hid>
	<4B8BCC09.8030100@domain.hid> <4B8BCDB5.2010103@domain.hid>
	<4B8BCF48.70603@domain.hid> <4B8BD4D4.2060109@domain.hid>
In-Reply-To: <4B8BD4D4.2060109@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : RTDM+POSIX: Avoid
 leaking binding objects on errors
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
>>>>>> Jan Kiszka wrote:
>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>> Jan Kiszka wrote:
>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>>>> Jan Kiszka wrote:
>>>>>>>>>>>>> Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>> GIT version control wrote:
>>>>>>>>>>>>>>> diff --git a/ksrc/skins/posix/mq.c b/ksrc/skins/posix/mq.c
>>>>>>>>>>>>>>> index 11f47c0..a896031 100644
>>>>>>>>>>>>>>> --- a/ksrc/skins/posix/mq.c
>>>>>>>>>>>>>>> +++ b/ksrc/skins/posix/mq.c
>>>>>>>>>>>>>>> @@ -1283,6 +1283,7 @@ int pse51_mq_select_bind(mqd_t fd, struct xnselector *selector,
>>>>>>>>>>>>>>>  	return 0;
>>>>>>>>>>>>>>>  
>>>>>>>>>>>>>>>        unlock_and_error:
>>>>>>>>>>>>>>> +	xnfree(binding):
>>>>>>>>>>>>>>>  	xnlock_put_irqrestore(&nklock, s);
>>>>>>>>>>>>>>>  	return err;
>>>>>>>>>>>>>>>  }
>>>>>>>>>>>>>> Ok. Will pull. But I really need to fix that.
>>>>>>>>>>>>>>
>>>>>>>>>>>>> Ack - now that I see it myself.
>>>>>>>>>>>>>
>>>>>>>>>>>> I fixed this in my branch and added another patch to transform EIDRM
>>>>>>>>>>>> into EBADF when selecting a (half-)deleted RTDM device. Please merge.
>>>>>>>>>>>>
>>>>>>>>>>> Wait! When the sync object behind some file descriptor is deleted but
>>>>>>>>>>> the descriptor itself is still existing, we rather have to return that
>>>>>>>>>>> fd signaled from select() instead of letting the call fail. I beed to
>>>>>>>>>>> look into this again.
>>>>>>>>>> It looks to me like a transitory state, we can wait for the sync object
>>>>>>>>>> to be deleted to have the fd destructor signaled. It should not be long.
>>>>>>>>> That's not an issue of waiting for this. See e.g. TCP: peer closes
>>>>>>>>> connection -> internal sync objects will be destroyed (to make
>>>>>>>>> read/write fail). But the fd will remain valid until the local side
>>>>>>>>> closes it as well.
>>>>>>>> It looks to me like this is going to complicate things a lot, and will
>>>>>>>> be a source of regressions. Why can we not have sync objects be
>>>>>>>> destroyed when the fd is really destroyed and use a status bit of some
>>>>>>>> kind to signal read/write that the fd was closed by peer?
>>>>>>> It is way easier and more consistent to unblock reader and writers via
>>>>>>> destroying the sync object than to signal it and add tests for specific
>>>>>>> states to detect that. Keep in mind that this pattern is in use even
>>>>>>> without select support. Diverging from it just to add select awareness
>>>>>>> to some driver would be a step back.
>>>>>> Ok. As you wish. But in that case, please provide a unit test case which
>>>>>> we can run on all architectures to validate your modifications. We will
>>>>>> not put this test case in xenomai repository but will create a
>>>>>> repository for test cases later on.
>>>>> As it requires quite some infrastructure to get there (or do I miss some
>>>>> preexisting select unit test?), I can just point to RTnet + TCP for now:
>>>>> run rtnet/examples/xenomai/posix/rttcp-server + client over rtlo and
>>>>> terminate the client prematurely. This does not happen if you run the
>>>>> very same test without RTnet loaded (ie. against Linux' TCP).
>>>>>
>>>>> Just pushed the corresponding fix.
>>>> I really do not understand what you are trying to do. What is the
>>>> problem exactly, and how do you fix it? You are reserving 384 more bytes
>>>> on the stack. What for?
>>>>
>>> "We already return an fd as pending if the corresponding xnsynch object
>>> is delete while waiting on it. Extend select to do the same if the
>>> object is already marked deleted on binding.
>>>
>>> This fixes the return code select on half-closed RTnet TCP sockets from
>>> -EIDRM to > 0 (for pending fds)."
>>>
>>> HTH.
>>>
>>> Regarding the additional stack requirements - yes, not nice. Maybe we
>>> can avoid this by clearing the in_fds in select_bind_all while
>>> processing it unless an fd is marked deleted. Would also avoid passing a
>>> separate fds to it.
>> To be more precise, it looks to me like each call to bind_one is
>> supposed to set the bit of the corresponding fd, so, if bind_one fails
>> because the fd is in the transitory state (the one which I do not like),
>> bind_all should simply set this bit to 1. And there does not seem to be
>> any need for additional parameters, additional space on stack, or
>> anything else.
> 
> Right, the trick is likely to properly maintain the output fds of
> bind_all in that not only pending fds are set, but others are cleared -
> avoids the third bitmap. Still playing with such an approach.

xnselect_bind, called by bind_one should take care of setting/clearing
individual bits, at least, it is the way it currently works.

-- 
					    Gilles.

