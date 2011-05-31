Message-ID: <4DE52CEF.5090000@domain.hid>
Date: Tue, 31 May 2011 20:01:19 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4DE4D2F1.20305@domain.hid>
	<1306859397.2153.52.camel@domain.hid>		<4DE51973.70104@domain.hid>
	<1306861115.2153.67.camel@domain.hid> <4DE5202F.70309@domain.hid>
	<4DE52C36.9010306@domain.hid>
In-Reply-To: <4DE52C36.9010306@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Fragile lock usage tracking for auto-relax
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 2011-05-31 19:58, Gilles Chanteperdrix wrote:
> On 05/31/2011 07:06 PM, Jan Kiszka wrote:
>> On 2011-05-31 18:58, Philippe Gerum wrote:
>>> On Tue, 2011-05-31 at 18:38 +0200, Jan Kiszka wrote:
>>>> On 2011-05-31 18:29, Philippe Gerum wrote:
>>>>> On Tue, 2011-05-31 at 13:37 +0200, Jan Kiszka wrote:
>>>>>> Hi Philippe,
>>>>>>
>>>>>> enabling XENO_OPT_DEBUG_NUCLEUS reveals some shortcomings of the
>>>>>> in-kernel lock usage tracking via xnthread_t::hrescnt. This BUGON in
>>>>>> xnsynch_release triggers for RT threads:
>>>>>>
>>>>>> 	XENO_BUGON(NUCLEUS, xnthread_get_rescnt(lastowner) < 0);
>>>>>>
>>>>>> RT threads do not balance their lock and unlock syscalls, so their
>>>>>> counter goes wild quite quickly.
>>>>>>
>>>>>> But just limiting the bug check to XNOTHER threads is neither a
>>>>>> solution. How to deal with the counter on scheduling policy changes?
>>>>>>
>>>>>> So my suggestion is to convert the auto-relax feature into a service,
>>>>>> user space can request based on a counter that user space maintains
>>>>>> independently. I.e. we should create another shared word that user space
>>>>>> increments and decrements on lock acquisitions/releases on its own. The
>>>>>> nucleus just tests it when deciding about the relax on return to user space.
>>>>>>
>>>>>> But before hacking into that direction, I'd like to hear if it makes
>>>>>> sense to you.
>>>>>
>>>>> At first glance, this does not seem to address the root issue. The
>>>>> bottom line is that we should not have any thread release an owned lock
>>>>> it does not hold, kthread or not.
>>>>>
>>>>> In that respect, xnsynch_release() looks fishy because it may be called
>>>>> over a context which is _not_ the lock owner, but the thread who is
>>>>> deleting the lock owner, so assuming lastowner == current_thread when
>>>>> releasing is wrong.
>>>>>
>>>>> At the very least, the following patch would prevent
>>>>> xnsynch_release_all_ownerships() to break badly. The same way, the
>>>>> fastlock stuff does not track the owner properly in the synchro object.
>>>>> We should fix those issues before going further, they may be related to
>>>>> the bug described.
>>>>>
>>>>> Totally, genuinely, 100% untested.
>>>>>
>>>>> diff --git a/ksrc/nucleus/synch.c b/ksrc/nucleus/synch.c
>>>>> index 3a53527..0785533 100644
>>>>> --- a/ksrc/nucleus/synch.c
>>>>> +++ b/ksrc/nucleus/synch.c
>>>>> @@ -424,6 +424,7 @@ xnflags_t xnsynch_acquire(struct xnsynch *synch, xnticks_t timeout,
>>>>>  						 XN_NO_HANDLE, threadh);
>>>>>  
>>>>>  		if (likely(fastlock == XN_NO_HANDLE)) {
>>>>> +			xnsynch_set_owner(synch, thread);
>>>>>  			xnthread_inc_rescnt(thread);
>>>>>  			xnthread_clear_info(thread,
>>>>>  					    XNRMID | XNTIMEO | XNBREAK);
>>>>> @@ -718,7 +719,7 @@ struct xnthread *xnsynch_release(struct xnsynch *synch)
>>>>>  
>>>>>  	XENO_BUGON(NUCLEUS, !testbits(synch->status, XNSYNCH_OWNER));
>>>>>  
>>>>> -	lastowner = xnpod_current_thread();
>>>>> +	lastowner = synch->owner ?: xnpod_current_thread();
>>>>>  	xnthread_dec_rescnt(lastowner);
>>>>>  	XENO_BUGON(NUCLEUS, xnthread_get_rescnt(lastowner) < 0);
>>>>>  	lastownerh = xnthread_handle(lastowner);
>>>>>
>>>>
>>>> That's maybe another problem, need to check.
>>>>
>>>> Back to the original issue: with fastlock, kernel space has absolutely
>>>> no clue about how many locks user space may hold - unless someone is
>>>> contending for all those locks. IOW, you can't reliably track resource
>>>> ownership at kernel level without user space help out. The current way
>>>> it helps (enforced syscalls of XNOTHER threads) is insufficient.
>>>
>>> The thing is: we don't care about knowing how many locks some
>>> non-current thread owns. What the nucleus wants to know is whether the
>>> _current user-space_ thread owns a lock, which is enough for the
>>> autorelax management. This restricted scope makes the logic fine.
>>
>> Nope, this does not work for threads that undergo policy changes (see
>> reply to Gilles).
> 
> Is it a really useful use-cache?

The question is rather if it a valid one.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

