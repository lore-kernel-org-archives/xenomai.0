References: <2098c9e4-4fb1-ef49-2c2d-d2c6573499b5@siemens.com>
 <87lf83cj7k.fsf@xenomai.org>
 <14ad027b-f326-5ea8-9cce-cb4b82984a23@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: "rtdm/nrtsig: move inband work description off the stack"
In-reply-to: <14ad027b-f326-5ea8-9cce-cb4b82984a23@siemens.com>
Date: Tue, 25 May 2021 12:01:29 +0200
Message-ID: <87y2c3b092.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 25.05.21 10:46, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> Hi Philippe,
>>>
>>> [1] makes rtdm_schedule_nrt_work a rather heavyweight service, compared
>>> to what it was (and even over I-pipe). xnmalloc is nothing you would
>>> expect from a "send a signal" service, specifically from
>>> rtdm_nrtsig_pend which does not even make use of the sending extra payload.
>>>
>>> Can we do better? Also for xnthread_signal (fd and udd usecases are not
>>> time-sensitive anyway).
>>>
>> 
>> Nope, I cannot see any significantly better option which would still
>> allow a common implementation we can map on top of Dovetail / I-pipe.
>> 
>
> E.g. pre-allocate the work object for data-free signals and use that -
> or not send it when it is in use, thus pending.
>

Ok, let's recap:

- rtdm_nrtsig_pend(): does not allocate anything, merely uses a
  user-provided memory block, containing a request header. Current
  callers should either already care for not resending a request
  uselessly because it is pending (e.g. [1]), or their internal logic
  should prevent that (e.g. [2]). This interface always convey user data
  by reference.

- rtdm_schedule_nrt_work(): does allocate a nrtsig_t struct in order to
  convey a request block we cannot squeeze into a work_struct, since the
  latter is in itself an anchor type the user may embed into its own
  private argument block. I'm unsure ensuring that
  rtdm_schedule_nrt_work() calls do not pile up would be worth it, as
  this call is not supposed to be used frenetically on some hot path in
  the first place. But if we'd want to do that, then we would have to
  change the signature of rtdm_schedule_nrt_work(), so that we gain a
  persistent context data we could use for determining whether a nrt
  work request is in flight. We could not probe the work_struct for that
  purpose, that would be racy.

Do you see any way to have a smarter rtdm_schedule_nrt_work() without
changing its signature?

[1]
kernel/drivers/net/addons/cap.c:		rtdm_nrtsig_pend(&cap_signal);
kernel/drivers/net/addons/cap.c:		rtdm_nrtsig_pend(&cap_signal);
kernel/drivers/net/addons/proxy.c:
rtdm_nrtsig_pend(&rtnetproxy_rx_signal);

[2]
kernel/drivers/testing/switchtest.c:				rtdm_nrtsig_pend(&ctx->wake_utask);
kernel/drivers/testing/switchtest.c:		rtdm_nrtsig_pend(&ctx->wake_utask);
kernel/drivers/testing/switchtest.c:			rtdm_nrtsig_pend(&ctx->wake_utask);

-- 
Philippe.

