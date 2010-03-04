Message-ID: <4B8FFDC0.4080903@domain.hid>
Date: Thu, 04 Mar 2010 19:36:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B8E24B4.9000806@domain.hid>
	<4B8E260D.7070809@domain.hid>	<4B8E281F.1040308@domain.hid>
	<4B8E28D2.6020808@domain.hid> <4B8FFBCD.9020305@domain.hid>
In-Reply-To: <4B8FFBCD.9020305@domain.hid>
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
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>, Gernot Hillier <gernot.hillier@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Hi Gilles,
>>>>>
>>>>> I'm pushing your findings to the list, also as my colleagues showed
>>>>> strong interest - this thing may explain rare corruptions for us as well.
>>>>>
>>>>> I thought a bit about that likely u_mode-related crash in your test case
>>>>> and have the following theory so far: If the xeno_current_mode storage
>>>>> is allocated on the application heap (!HAVE_THREAD, that's also what we
>>>>> are forced to use), it is automatically freed on thread termination in
>>>>> the context of the dying thread. If the thread is already migrated to
>>>>> secondary or if that happens while it is cleaned up (i.e. before calling
>>>>> for exit into the kernel), there is no problem, Xenomai will not touch
>>>>> the mode storage anymore. But if the thread happens to delete the
>>>>> storage "silently", without any migration, the final exit will trigger
>>>>> one further access. And that takes place against an invalid head area at
>>>>> this point.
>>>>>
>>>>> Does this make sense?
>>>> Yes, it is the issue we observed.
>>>>
>>>>> If that is true, all we need to do is to force a migration before
>>>>> releasing the mode storage. Could you check this?
>>>> No, that does not fly. Calling, for instance, __wrap_pthread_mutex_lock
>>>> in another TSD cleanup function is which could be called after the
>>>> current_mode TSD cleanup is allowed and could trigger a switch to
>>>> primary mode and a write to the u_mode.
>>>>
>>> Good point. Mmh. Another, but ABI-breaking, way would be to add a
>>> syscall for deregistering the u_mode pointer...
>> That is the thing we did to verify that we had this bug. But this
>> syscall would be also called too soon, and suffers from the TSD cleanup
>> functions order again.
>>
> 
> Right, the only complete fix without losing functionality is to add an
> option to our ABI for requesting kernel-managed memory if dynamic
> allocation is necessary (i.e. no TLS is available).

No. TLS may as well suffer from the same issue, since it is handled by
the glibc or libgcc, over which we have no control. So yes, it may work
by chance today, but may as well stop working tomorrow. We use
kernel-managed memory all the time, final point.

> 
> But I thought a bit more about a workaround for the existing ABI. We
> basically need a way to free some memory as late as possible on thread
> deletion. Even when leaving garbage collection that no one really wants
> aside, there might be some semi-perfect user-space-only solution:
> 
> pthread_create_key says that TSD destructors are re-run after the first
> round if their key value is still non-NULL. So we could at least work
> around the already rare case that some TSD destructor past ours tries to
> access an RT mutex or otherwise migrates the thread to RT again. For
> this, we just need a counter (next to the mode storages) for the round.
> If we are in round #1, we would restore the key value again instead of
> freeing it. On run #n < PTHREAD_DESTRUCTOR_ITERATIONS, we would finally
> free it in the hope we are the last interested in it. This just requires
> PTHREAD_DESTRUCTOR_ITERATIONS > 1, and that the application does not do
> this ugly dance as well AND also performs Xenomai calls.

I have thought of another simpler fix: we leak the u_mode when
kernel-support is too old, and whine loudly about it. For the other case
(newer kernel-support with older user-space support), I was thinking
about something else, which I still find complicated and far from
perfect: handling the exit syscall by setting the u_mode pointer to NULL
because we know at that time the u_mode pointer points to free memory.

-- 
					    Gilles.

