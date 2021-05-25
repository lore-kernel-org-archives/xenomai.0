Subject: Re: "rtdm/nrtsig: move inband work description off the stack"
References: <2098c9e4-4fb1-ef49-2c2d-d2c6573499b5@siemens.com>
 <87lf83cj7k.fsf@xenomai.org>
 <14ad027b-f326-5ea8-9cce-cb4b82984a23@siemens.com>
 <87y2c3b092.fsf@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3bf57e72-9992-0ab4-a956-d6f6197bfe24@siemens.com>
Date: Tue, 25 May 2021 12:38:08 +0200
MIME-Version: 1.0
In-Reply-To: <87y2c3b092.fsf@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 25.05.21 12:01, Philippe Gerum wrote:
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> On 25.05.21 10:46, Philippe Gerum wrote:
>>>
>>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>>
>>>> Hi Philippe,
>>>>
>>>> [1] makes rtdm_schedule_nrt_work a rather heavyweight service, compared
>>>> to what it was (and even over I-pipe). xnmalloc is nothing you would
>>>> expect from a "send a signal" service, specifically from
>>>> rtdm_nrtsig_pend which does not even make use of the sending extra payload.
>>>>
>>>> Can we do better? Also for xnthread_signal (fd and udd usecases are not
>>>> time-sensitive anyway).
>>>>
>>>
>>> Nope, I cannot see any significantly better option which would still
>>> allow a common implementation we can map on top of Dovetail / I-pipe.
>>>
>>
>> E.g. pre-allocate the work object for data-free signals and use that -
>> or not send it when it is in use, thus pending.
>>
> 
> Ok, let's recap:
> 
> - rtdm_nrtsig_pend(): does not allocate anything, merely uses a
>   user-provided memory block, containing a request header. Current
>   callers should either already care for not resending a request
>   uselessly because it is pending (e.g. [1]), or their internal logic
>   should prevent that (e.g. [2]). This interface always convey user data
>   by reference.

Ah, I fantasized that rtdm_nrtsig_pend would call rtdm_schedule_nrt_work
to do the work, it's the other way around. False alarm here.

> 
> - rtdm_schedule_nrt_work(): does allocate a nrtsig_t struct in order to
>   convey a request block we cannot squeeze into a work_struct, since the
>   latter is in itself an anchor type the user may embed into its own
>   private argument block. I'm unsure ensuring that
>   rtdm_schedule_nrt_work() calls do not pile up would be worth it, as
>   this call is not supposed to be used frenetically on some hot path in
>   the first place. But if we'd want to do that, then we would have to
>   change the signature of rtdm_schedule_nrt_work(), so that we gain a
>   persistent context data we could use for determining whether a nrt
>   work request is in flight. We could not probe the work_struct for that
>   purpose, that would be racy.
> 
> Do you see any way to have a smarter rtdm_schedule_nrt_work() without
> changing its signature?

There is no rule that prevents changing the signature if that is needed.
However, the kernel is fine without allocation as well, using a very
similar signature.

I do not yet understand way we need that indirection via the rtdm_nrtsig
on Dovetail. I thought we can trigger work directly from the oob domain
there, can't we? How do you handle such a case in evl so far?

And the third case remains xnthread_signal, btw.

Jan

> 
> [1]
> kernel/drivers/net/addons/cap.c:		rtdm_nrtsig_pend(&cap_signal);
> kernel/drivers/net/addons/cap.c:		rtdm_nrtsig_pend(&cap_signal);
> kernel/drivers/net/addons/proxy.c:
> rtdm_nrtsig_pend(&rtnetproxy_rx_signal);
> 
> [2]
> kernel/drivers/testing/switchtest.c:				rtdm_nrtsig_pend(&ctx->wake_utask);
> kernel/drivers/testing/switchtest.c:		rtdm_nrtsig_pend(&ctx->wake_utask);
> kernel/drivers/testing/switchtest.c:			rtdm_nrtsig_pend(&ctx->wake_utask);
> 

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

