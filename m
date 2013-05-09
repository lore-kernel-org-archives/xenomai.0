Message-ID: <518BF710.9030500@xenomai.org>
Date: Thu, 09 May 2013 21:20:48 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5144D3E9.2050205@xenomai.org>
	<5144D524.4000302@web.de>	<5144D5AB.3080004@xenomai.org>
	<5144D5E3.9050601@web.de> <5144DB0F.9050901@xenomai.org>
	<518BDD9D.10804@xenomai.org> <518BE3C5.4090203@web.de>
	<518BE49D.2010404@xenomai.org> <518BE4CE.6020107@web.de>
	<518BE4FC.6060507@xenomai.org> <518BE6D2.4090304@web.de>
	<518BEAA2.1060703@xenomai.org> <518BEC1B.7080000@web.de>
	<518BECA5.3020602@xenomai.org> <518BEDEC.7060302@web.de>
	<518BF5F7.5070205@xenomai.org>
In-Reply-To: <518BF5F7.5070205@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __get_user/__put_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@web.de>, Xenomai <xenomai@xenomai.org>

On 05/09/2013 09:16 PM, Gilles Chanteperdrix wrote:
> On 05/09/2013 08:41 PM, Jan Kiszka wrote:
>
>> On 2013-05-09 20:36, Gilles Chanteperdrix wrote:
>>> On 05/09/2013 08:34 PM, Jan Kiszka wrote:
>>>
>>>> On 2013-05-09 20:27, Gilles Chanteperdrix wrote:
>>>>> On 05/09/2013 08:11 PM, Jan Kiszka wrote:
>>>>>
>>>>>> On 2013-05-09 20:03, Gilles Chanteperdrix wrote:
>>>>>>> On 05/09/2013 08:02 PM, Jan Kiszka wrote:
>>>>>>>
>>>>>>>> On 2013-05-09 20:02, Gilles Chanteperdrix wrote:
>>>>>>>>> On 05/09/2013 07:58 PM, Jan Kiszka wrote:
>>>>>>>>>
>>>>>>>>>> On 2013-05-09 19:32, Gilles Chanteperdrix wrote:
>>>>>>>>>>> On 03/16/2013 09:50 PM, Gilles Chanteperdrix wrote:
>>>>>>>>>>>
>>>>>>>>>>>> On 03/16/2013 09:28 PM, Jan Kiszka wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> On 2013-03-16 21:27, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>> On 03/16/2013 09:25 PM, Jan Kiszka wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 2013-03-16 21:19, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> xenomai asm-generic/syscall.h defines __xn_put_user/__xn_get_user as
>>>>>>>>>>>>>>>> aliases for __put_user/__get_user, which implementation, for the ARM
>>>>>>>>>>>>>>>> architecture calls might_fault() which triggers an ipipe_root_only() check.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> So, the question is, what is the best way of avoiding this issue? Remove
>>>>>>>>>>>>>>>> the call to might_fault() when compiling with CONFIG_IPIPE enabled?
>>>>>>>>>>>>>>>> Define __ipipe_safe_put_user which avoids the call to might_fault() ?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Adjust might_fault() in a way that it only considers atomic non-root
>>>>>>>>>>>>>>> contexts as problematic.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> atomic meaning with hardware irqs off? or within an irq handler? This
>>>>>>>>>>>>>> requires xenomai...
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> Hard irqs off || head domain stalled, I would say.
>>>>>>>>>>>>
>>>>>>>>>>>> ok, done, thanks.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Actually, it does not work, the WARN_ON triggers in __rt_heap_bind for
>>>>>>>>>>> instance, which does some copies from user with hard irqs off.
>>>>>>>>>>
>>>>>>>>>> Hmm, isn't that a real bug? The nucleus should then try to migrate to
>>>>>>>>>> Linux while the nklock is held - ouch...
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> In theory, the fault should be fixed up without requiring a migration. I
>>>>>>>>> will test this.
>>>>>>>>
>>>>>>>> In theory, user space could also provide an invalid pointer.
>>>>>>>
>>>>>>>
>>>>>>> Yes, this is what I am going to test, but an invalid pointer cause the
>>>>>>> fault to be fixed up so that the copy_from_user return -EFAULT.
>>>>>>>
>>>>>>
>>>>>> I don't think we fix-up over the head domain. Rather, the nucleus
>>>>>> receives the information that a fault has happened over the head domain
>>>>>> and migrates to root.
>>>>>
>>>>>
>>>>> It depends on where the notification happens in the I-pipe patch. You
>>>>> could allow the kernel to fix-up the fault without notifying the
>>>>> nucleus. I thought I did that in the past, but apparently not in the
>>>>> latest patches as a segfault in rt_heap_bind causes a switch to
>>>>> secondary mode, but the nklock is automatically released as part of the
>>>>> migration to secondary mode.
>>>>>
>>>>> I am not sure the fix-up code is completely unsafe to be called over non
>>>>> root domain, as it only uses preempt_disable, preempt_enable,
>>>>> list_for_each_entry_rcu and only if the exception is found in a kernel
>>>>> module.
>>>>>
>>>>
>>>> Maybe.
>>>>
>>>> But why do we need to hold the nklock across the __rt_bind_helper in
>>>> __rt_queue_bind at all? Other binding services apparently don't have
>>>> this need.
>>>
>>>
>>> I suppose because we do not want the heap vanishing under our feet while
>>> we access its contents with the xnheap_* accessors.
>>
>> Right, but the general pattern for this is
>>
>> 	obj = xnregistry_fetch(handle)
>> 	get_nklock()
>> 	if (valid(obj))
>> 		do_something_with(obj)
>> 	put_nklock()
>
>
> Seems rather to be get_nklock before xnregistry_fetch.
>
>

Yes. The other pattern is only used when the fetched handle shall be 
revalidated before actual use. __rt_bind_helper does not revalidate, so 
the handle is fetched under lock.

-- 
Philippe.

