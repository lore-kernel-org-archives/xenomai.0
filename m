References: <CAFLxGvy9BSEiRwzJximQLEqn_n=OfgaQcvKpxWSSRYPeeGn-yA@mail.gmail.com>
 <2c2f612c-5a56-0bb7-735c-4d3c4fe13aaa@siemens.com>
 <CAFLxGvzDE0NpXGjxEyGhnjC__3oEq4iSkcDJzFPWB68S6wF2dA@mail.gmail.com>
 <aa766270-994e-2cc4-1e37-52b3dc55e132@siemens.com>
 <878s2hi0b9.fsf@xenomai.org>
 <fdb021ad-034e-8fd5-7c0f-44a153c7a55c@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: rt_task_shadow() secondary mode
In-reply-to: <fdb021ad-034e-8fd5-7c0f-44a153c7a55c@siemens.com>
Date: Thu, 08 Jul 2021 14:51:13 +0200
Message-ID: <874kd5hsu6.fsf@xenomai.org>
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
Cc: Richard Weinberger <richard.weinberger@gmail.com>, xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 08.07.21 12:09, Philippe Gerum wrote:
>> 
>> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
>> 
>>> On 08.07.21 11:51, Richard Weinberger wrote:
>>>> On Thu, Jul 8, 2021 at 11:25 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>> The general philosophy of Xenomai is that applications should not rely
>>>>> on the exact switching behavior. So the question would be why your
>>>>> application needs one or the other behavior?
>>>>
>>>> In this particular case the application uses the ioctl() system call
>>>> to call into a
>>>> xenomai kernel module. The module implements the rt and nrt variant of
>>>> ioctl() and
>>>> the application assumes which version of the ioctl() implementation
>>>> will get reached.
>>>
>>> ...that might be the actual design bug. If a driver implements the a
>>> service for both calling modes, the service should effectively do the
>>> same, ie. should be mode-agnostic. Seems, this was violated here.
>>>
>>> Jan
>> 
>> True, but this said, rt_task_shadow() should definitely leave the caller
>> into secondary mode if called for SCHED_OTHER, since this would be the
>> natural execution stage in that case. So rt_task_shadow() behaves like
>> the documentation states, but should not in this particular case
>> (prio=0).
>> 
>
> Then it needs to be understood what technically triggers this and
> resolved, likely via an explicit migration.
>

Sure, good exercise for the reader to get ones feet wet with libalchemy.
If somebody wants to tackle this: check callers of
threadobj_run_corespec() in libcopperplate.

The common case in this routine is to force a switch back to primary
mode for the caller, on exit from threadobj_shadow(). We may want to
make this conditional to the scheduling policy and priority. Following
threadobj_init() for the content of idata may help too.

-- 
Philippe.

