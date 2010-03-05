Message-ID: <4B90EB0D.6060705@domain.hid>
Date: Fri, 05 Mar 2010 12:29:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8E24B4.9000806@domain.hid>
	<4B8E260D.7070809@domain.hid>	<4B8E281F.1040308@domain.hid>
	<4B8E28D2.6020808@domain.hid> <4B8FFBCD.9020305@domain.hid>
	<4B8FFDC0.4080903@domain.hid> <4B90173C.9080008@domain.hid>
	<4B90E628.1090005@domain.hid>
In-Reply-To: <4B90E628.1090005@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Potential heap corruption on thread cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>, "Hillier, Gernot" <gernot.hillier@domain.hid>

Wolfgang Mauerer wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> Hi Gilles,
>>>>>>>>
>>>>>>>> I'm pushing your findings to the list, also as my colleagues showed
>>>>>>>> strong interest - this thing may explain rare corruptions for us as well.
>>>>>>>>
>>>>>>>> I thought a bit about that likely u_mode-related crash in your test case
>>>>>>>> and have the following theory so far: If the xeno_current_mode storage
>>>>>>>> is allocated on the application heap (!HAVE_THREAD, that's also what we
>>>>>>>> are forced to use), it is automatically freed on thread termination in
>>>>>>>> the context of the dying thread. If the thread is already migrated to
>>>>>>>> secondary or if that happens while it is cleaned up (i.e. before calling
>>>>>>>> for exit into the kernel), there is no problem, Xenomai will not touch
>>>>>>>> the mode storage anymore. But if the thread happens to delete the
>>>>>>>> storage "silently", without any migration, the final exit will trigger
>>>>>>>> one further access. And that takes place against an invalid head area at
>>>>>>>> this point.
>>>>>>>>
>>>>>>>> Does this make sense?
>>>>>>> Yes, it is the issue we observed.
>>>>>>>
>>>>>>>> If that is true, all we need to do is to force a migration before
>>>>>>>> releasing the mode storage. Could you check this?
>>>>>>> No, that does not fly. Calling, for instance, __wrap_pthread_mutex_lock
>>>>>>> in another TSD cleanup function is which could be called after the
>>>>>>> current_mode TSD cleanup is allowed and could trigger a switch to
>>>>>>> primary mode and a write to the u_mode.
>>>>>>>
>>>>>> Good point. Mmh. Another, but ABI-breaking, way would be to add a
>>>>>> syscall for deregistering the u_mode pointer...
>>>>> That is the thing we did to verify that we had this bug. But this
>>>>> syscall would be also called too soon, and suffers from the TSD cleanup
>>>>> functions order again.
>>>>>
>>>> Right, the only complete fix without losing functionality is to add an
>>>> option to our ABI for requesting kernel-managed memory if dynamic
>>>> allocation is necessary (i.e. no TLS is available).
>>> No. TLS may as well suffer from the same issue, since it is handled by
>>> the glibc or libgcc, over which we have no control. So yes, it may work
>>> by chance today, but may as well stop working tomorrow. We use
>>> kernel-managed memory all the time, final point.
>> I think we are still in the solution finding process, no need for early
>> conclusions.
>>
>> See, we actually do not need kernel-managed storage for u_mode at all.
>> u_mode is an optimization, mostly for our fast user space mutexes. We
>> can indeed switch off all updates by the kernel and will still be able
>> to provide all required features - just less optimally. Adding a third
>> state, "invalid", we can make all mutex users assume they need the slow
>> syscall path on uncontended acquisition. And assert_nrt will probably be
>> happy about a syscall replacement for u_mode when it became invalid.
> 
> Thinking about the "fast" part in "fast userspace mutex": Would it be an
> argument in favour of not using the global semaphore heap that said
> memory is uncached on some architectures? Or is that irrelevant?

Several answers:
- whether memory is cached is mostly irrelevant for real-time. The worst
case remains the same. Of course it is a bit less irrelevant when we are
trying to get free time to run a general-purpose OS as idle task.
- we are talking about arms, right. When not using FCSE, the cache is
small and the kernel flushes it at every context switch, so the chances
for getting a cache miss are in fact pretty high.
- on arm, the cost of a system call is still way higher than two RAM
accesses.
- simpler solutions usually yield less bugs, as shown by the bug whe are
discussing.
- according to the comments we read on the mailing list about 2.5.1
stability, having something which works correctly is kind of urgent.

-- 
					    Gilles.

