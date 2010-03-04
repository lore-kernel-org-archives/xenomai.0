Message-ID: <4B901B53.2050605@domain.hid>
Date: Thu, 04 Mar 2010 21:42:59 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8E24B4.9000806@domain.hid>
	<4B8E260D.7070809@domain.hid>	<4B8E281F.1040308@domain.hid>
	<4B8E28D2.6020808@domain.hid> <4B8FFBCD.9020305@domain.hid>
	<4B8FFDC0.4080903@domain.hid> <4B90173C.9080008@domain.hid>
In-Reply-To: <4B90173C.9080008@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "Mauerer, Wolfgang" <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>, "Hillier,
	Gernot" <gernot.hillier@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Hi Gilles,
>>>>>>>
>>>>>>> I'm pushing your findings to the list, also as my colleagues showed
>>>>>>> strong interest - this thing may explain rare corruptions for us as well.
>>>>>>>
>>>>>>> I thought a bit about that likely u_mode-related crash in your test case
>>>>>>> and have the following theory so far: If the xeno_current_mode storage
>>>>>>> is allocated on the application heap (!HAVE_THREAD, that's also what we
>>>>>>> are forced to use), it is automatically freed on thread termination in
>>>>>>> the context of the dying thread. If the thread is already migrated to
>>>>>>> secondary or if that happens while it is cleaned up (i.e. before calling
>>>>>>> for exit into the kernel), there is no problem, Xenomai will not touch
>>>>>>> the mode storage anymore. But if the thread happens to delete the
>>>>>>> storage "silently", without any migration, the final exit will trigger
>>>>>>> one further access. And that takes place against an invalid head area at
>>>>>>> this point.
>>>>>>>
>>>>>>> Does this make sense?
>>>>>> Yes, it is the issue we observed.
>>>>>>
>>>>>>> If that is true, all we need to do is to force a migration before
>>>>>>> releasing the mode storage. Could you check this?
>>>>>> No, that does not fly. Calling, for instance, __wrap_pthread_mutex_lock
>>>>>> in another TSD cleanup function is which could be called after the
>>>>>> current_mode TSD cleanup is allowed and could trigger a switch to
>>>>>> primary mode and a write to the u_mode.
>>>>>>
>>>>> Good point. Mmh. Another, but ABI-breaking, way would be to add a
>>>>> syscall for deregistering the u_mode pointer...
>>>> That is the thing we did to verify that we had this bug. But this
>>>> syscall would be also called too soon, and suffers from the TSD cleanup
>>>> functions order again.
>>>>
>>> Right, the only complete fix without losing functionality is to add an
>>> option to our ABI for requesting kernel-managed memory if dynamic
>>> allocation is necessary (i.e. no TLS is available).
>> No. TLS may as well suffer from the same issue, since it is handled by
>> the glibc or libgcc, over which we have no control. So yes, it may work
>> by chance today, but may as well stop working tomorrow. We use
>> kernel-managed memory all the time, final point.
> 
> I think we are still in the solution finding process, no need for early
> conclusions.
> 
> See, we actually do not need kernel-managed storage for u_mode at all.
> u_mode is an optimization, mostly for our fast user space mutexes. We
> can indeed switch off all updates by the kernel and will still be able
> to provide all required features - just less optimally. Adding a third
> state, "invalid", we can make all mutex users assume they need the slow
> syscall path on uncontended acquisition. And assert_nrt will probably be
> happy about a syscall replacement for u_mode when it became invalid.
> 
> This invalid state (maybe u_mode == -1 with TLS, and mode_key == NULL
> without it) is entered during thread clean up with the help of a TSD
> destructor. The destructor will then deregister our u_mode storage from
> the kernel so that it doesn't matter if we release the memory
> immediately and explicitly (w/o TLS) or leave this to glibc (/w TLS).
> And in this model, it also doesn't matter when precisely the destructor
> is called.

We have to add a syscall to propagate this value to kernel-space, and
clutter the kernel-space code which uses u_mode with tests to see if
u_mode is valid or not, and we have to clutter the code which uses
u_mode in user-space to handle that invalid state. And every time we add
a user of u_mode, we have to think about the invalid state. A lot of
clutter.

The two last issues may be removed by handling the invalid state only in
the function which returns the current mode. If the state is invalid,
then issue the syscall. Admittedly, we get two syscalls for mutex locks,
but who cares.

However, what for? Allocating u_mode in the process private sem_heap, as
I suggest since the beggining, looks so much simpler. No test, no
special case, the address is always valid as long as the tcb is valid.

> 
>>> But I thought a bit more about a workaround for the existing ABI. We
>>> basically need a way to free some memory as late as possible on thread
>>> deletion. Even when leaving garbage collection that no one really wants
>>> aside, there might be some semi-perfect user-space-only solution:
>>>
>>> pthread_create_key says that TSD destructors are re-run after the first
>>> round if their key value is still non-NULL. So we could at least work
>>> around the already rare case that some TSD destructor past ours tries to
>>> access an RT mutex or otherwise migrates the thread to RT again. For
>>> this, we just need a counter (next to the mode storages) for the round.
>>> If we are in round #1, we would restore the key value again instead of
>>> freeing it. On run #n < PTHREAD_DESTRUCTOR_ITERATIONS, we would finally
>>> free it in the hope we are the last interested in it. This just requires
>>> PTHREAD_DESTRUCTOR_ITERATIONS > 1, and that the application does not do
>>> this ugly dance as well AND also performs Xenomai calls.
>> I have thought of another simpler fix: we leak the u_mode when
>> kernel-support is too old, and whine loudly about it. For the other case
> 
> Leaking is not nice, but I guess an application will crash sooner over
> the bug than this leak becomes a reason for a failure.
> 
>> (newer kernel-support with older user-space support), I was thinking
>> about something else, which I still find complicated and far from
>> perfect: handling the exit syscall by setting the u_mode pointer to NULL
>> because we know at that time the u_mode pointer points to free memory.
>>
> 
> That would reduce the probability of a crash, right. Probably the best
> we can do for old user land. And I don't think if should take more than
> two lines of code in the syscall dispatching path.

A bit more, we have to deal with the old user-space detection.
Noise would came from the kernel with this solution too.

-- 
					    Gilles.

