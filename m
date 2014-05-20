Message-ID: <537B507F.7080304@xenomai.org>
Date: Tue, 20 May 2014 14:54:23 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20140502141307.B6A14EC0@centrum.cz>,
 <53639AC8.1000507@xenomai.org>, <20140506101735.3A0BEBEB@centrum.cz>,
 <5368A3A2.1010302@xenomai.org>, <20140506112918.F5E14FAA@centrum.cz>,
 <5368DC2C.5000505@xenomai.org>, <20140507151310.0F980ADD@centrum.cz>,
 <536BA891.3060605@xenomai.org>,
 <20140512143736.8105A76F@centrum.cz> <5370C807.7050809@xenomai.org>
 <20140520142729.DABA4B8B@centrum.cz>
In-Reply-To: <20140520142729.DABA4B8B@centrum.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] non-blocking rt_task_suspend(NULL)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Petr Cervenka <grugh@centrum.cz>
Cc: Xenomai <xenomai@xenomai.org>

On 05/20/2014 02:27 PM, Petr Cervenka wrote:
>> Od: Philippe Gerum
>>
>>>>
>>>> Thanks. Could you drop the previous instrumentation patches, and give a try at this one? It fixes a flaw in the logic for maintaining the thread information bits, which may have caused the issue you observed:
>>>>
>>>> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
>>>> index 0a2ee19..22fa91d 100644
>>>> --- a/ksrc/nucleus/pod.c
>>>> +++ b/ksrc/nucleus/pod.c
>>>> @@ -1391,7 +1391,8 @@ void xnpod_suspend_thread(xnthread_t *thread, xnflags_t mask,
>>>> 		}
>>>> #endif /* CONFIG_XENO_OPT_PERVASIVE */
>>>>
>>>> -		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | XNWAKEN | XNROBBED);
>>>> +		xnthread_clear_info(thread, XNRMID | XNTIMEO | XNBREAK | \
>>>> +				    XNWAKEN | XNROBBED | XNKICKED);
>>>> 	}
>>>>
>>>> 	/* Don't start the timer for a thread indefinitely delayed by
>>>>
>>>
>>> I applied the new patch and I was not able to reproduce the -EINTR problem to this moment. But one of the machines I tried during long term test over the weekend got frozen. But it could be also from different reason. What do you think?
>>
>> Could you enable all debug features (CONFIG_XENO_OPT_DEBUG), and
>> particularly CONFIG_XENO_OPT_WATCHDOG? The system will be significantly
>> slowed down due to the consistency checks on all internal lists (i.e.
>> DEBUG_QUEUES), but this may give us some hints about the freeze.
>>
>
> I have enabled almost all debug features and tortured several PCs for a week without a single problem. Thank you all for your help.
>

Ok, thanks for testing this extensively. The suggested patch has been 
pushed to the maintenance tree.

-- 
Philippe.

