Message-ID: <507548DE.2000305@xenomai.org>
Date: Wed, 10 Oct 2012 12:07:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr>	<505EBD61.1050009@wanadoo.fr>	<505F0D40.9030105@xenomai.org>	<50741C5B.4060206@wanadoo.fr>
	<5074986C.8000509@xenomai.org> <50749A03.9090607@xenomai.org>
	<50749C71.2020100@xenomai.org> <5075260E.2050402@wanadoo.fr>
	<507528E4.4050809@xenomai.org> <50752A42.9080303@web.de>
	<50752C0C.3050803@xenomai.org> <50752D7E.7010207@web.de>
	<507538C8.7040706@xenomai.org> <50753980.7020409@web.de>
	<50753EA0.7070007@xenomai.org> <50754849.9030205@web.de>
In-Reply-To: <50754849.9030205@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Target frozen with rtcan_virt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Thierry Bultel <thierry.bultel@wanadoo.fr>, Wolfgang Grandegger <wg@denx.de>, xenomai@xenomai.org

On 10/10/2012 12:04 PM, Jan Kiszka wrote:
> On 2012-10-10 11:23, Gilles Chanteperdrix wrote:
>> On 10/10/2012 11:01 AM, Jan Kiszka wrote:
>>> On 2012-10-10 10:58, Gilles Chanteperdrix wrote:
>>>> On 10/10/2012 10:10 AM, Jan Kiszka wrote:
>>>>> On 2012-10-10 10:04, Gilles Chanteperdrix wrote:
>>>>>> On 10/10/2012 09:56 AM, Jan Kiszka wrote:
>>>>>>> On 2012-10-10 09:51, Gilles Chanteperdrix wrote:
>>>>>>>> On 10/10/2012 09:38 AM, Thierry Bultel wrote:
>>>>>>>>> Hi Gilles,
>>>>>>>>>
>>>>>>>>> Many thanks,
>>>>>>>>> The first patch does not work, the second does.
>>>>>>>>> I think the reason for 1st patch why is that in rtcan_virt, we have
>>>>>>>>>
>>>>>>>>> rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
>>>>>>>>> rtdm_lock_get(&rtcan_socket_lock);
>>>>>>>>>
>>>>>>>>> ...
>>>>>>>>> --->        rtcan_rcv(rx_dev, &skb);
>>>>>>>>> ....
>>>>>>>>>
>>>>>>>>> rtdm_lock_put(&rtcan_socket_lock);
>>>>>>>>> rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);
>>>>>>>>>
>>>>>>>>> and rtcan_rcv->rtcan_rcv_deliver->rtdm_sem_up(&sock->recv_sem);
>>>>>>>>>
>>>>>>>>> thus the same re-scheduling stuff with interrupts locked.
>>>>>>>>>
>>>>>>>>> Are you not not afraid of side effects with the second patch, 
>>>>>>>>> since you change the overall behaviour ?
>>>>>>>>> Won't you prefer a only locally modified rtcan_virt ?
>>>>>>>>
>>>>>>>> We should ask Jan's opinion. In any case, if we adopt the second patch,
>>>>>>>> we might want to try and reduce the overhead of xnpod_unlock_sched.
>>>>>>>>
>>>>>>>
>>>>>>> We were signaling the semaphore while holding a spin lock? That's a
>>>>>>> clear bug. Your patch is aligning rtcan to the pattern we are also using
>>>>>>> in RTnet. We just need to make sure (haven't looked at the full context
>>>>>>> yet) that sock remains valid even after dropping the lock(s).
>>>>>>
>>>>>> The second patch idea was to lock the scheduler while spinlocks are
>>>>>> held, so that posting a semaphore while holding a spin lock is no longer
>>>>>> a bug.
>>>>>
>>>>> Sounds a bit hacky,
>>>>
>>>> Well, that is what the linux kernel does.
>>>>
>>>>  but I think we have this pattern
>>>>> (RTDM_EXECUTE_ATOMICALLY)
>>>>
>>>> RTDM_EXECUTE_ATOMICALLY is a bit of a misnomer, if you do:
>>>> RTDM_EXECUTE_ATOMICALLY(foo(); rtdm_sem_up(); bar());
>>>> foo() and bar() are not executed atomically if sem_up wakes up another
>>>> thread.
>>>>
>>>> So, I do not see how RTDM_EXECUTE_ATOMICALLY solves the issue we are
>>>> talking about.
>>>
>>> RTDM_EXECUTE_ATOMICALLY holds the nucleus lock across the encapsulated
>>> code, executing it atomically as rescheduling is postponed until the end
>>> of the block.
>>
>> Err... no. Absolutely not.
> 
> Err... absolutely right.
> 
> The good news is: we don't need to worry about such kind of locking. In
> rtcan_raw_recvmsg, the socket is locked via the RTDM context as we are
> in a handler. So it won't disappear when we drop the lock, and your
> first patch is fine.

Which one? The first one does not seem to work because the rtdm locks
seem to be nested. The second one would probably need to find a way to
reduce the overhead of xnpod_unlock_sched(). What can be done, however,
is adding a call to xnpod_lock_sched()/xnpod_unlock_sched() in
RTDM_EXECUTE_ATOMICALLY.


-- 
					    Gilles.

