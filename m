Message-ID: <4B8B98F5.10602@domain.hid>
Date: Mon, 01 Mar 2010 11:37:41 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1Nl4tX-0001N9-Hb@domain.hid>
	<4B881E9D.1050101@domain.hid>	<4B88203F.2020907@domain.hid>
	<4B8903E1.3020805@domain.hid> <4B8B7540.609@domain.hid>
	<4B8B84BC.90300@domain.hid> <4B8B971D.5080807@domain.hid>
In-Reply-To: <4B8B971D.5080807@domain.hid>
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
>>> Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> GIT version control wrote:
>>>>>>> diff --git a/ksrc/skins/posix/mq.c b/ksrc/skins/posix/mq.c
>>>>>>> index 11f47c0..a896031 100644
>>>>>>> --- a/ksrc/skins/posix/mq.c
>>>>>>> +++ b/ksrc/skins/posix/mq.c
>>>>>>> @@ -1283,6 +1283,7 @@ int pse51_mq_select_bind(mqd_t fd, struct xnselector *selector,
>>>>>>>  	return 0;
>>>>>>>  
>>>>>>>        unlock_and_error:
>>>>>>> +	xnfree(binding):
>>>>>>>  	xnlock_put_irqrestore(&nklock, s);
>>>>>>>  	return err;
>>>>>>>  }
>>>>>> Ok. Will pull. But I really need to fix that.
>>>>>>
>>>>> Ack - now that I see it myself.
>>>>>
>>>> I fixed this in my branch and added another patch to transform EIDRM
>>>> into EBADF when selecting a (half-)deleted RTDM device. Please merge.
>>>>
>>> Wait! When the sync object behind some file descriptor is deleted but
>>> the descriptor itself is still existing, we rather have to return that
>>> fd signaled from select() instead of letting the call fail. I beed to
>>> look into this again.
>> It looks to me like a transitory state, we can wait for the sync object
>> to be deleted to have the fd destructor signaled. It should not be long.
> 
> That's not an issue of waiting for this. See e.g. TCP: peer closes
> connection -> internal sync objects will be destroyed (to make
> read/write fail). But the fd will remain valid until the local side
> closes it as well.

It looks to me like this is going to complicate things a lot, and will
be a source of regressions. Why can we not have sync objects be
destroyed when the fd is really destroyed and use a status bit of some
kind to signal read/write that the fd was closed by peer?

> 
> Jan
> 


-- 
					    Gilles.

