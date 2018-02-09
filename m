From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44eflvcaft.fsf@lowell-desk.lan>
 <31210f5e-1137-54e8-9e22-7562de250614@xenomai.org>
 <115c0698-ad5f-2dae-4ed4-1e027839eae1@xenomai.org>
Date: Fri, 09 Feb 2018 09:50:30 -0500
In-Reply-To: <115c0698-ad5f-2dae-4ed4-1e027839eae1@xenomai.org> (Philippe
 Gerum's message of "Fri, 9 Feb 2018 11:11:17 +0100")
Message-ID: <44d11e1akp.fsf@be-well.ilk.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] rtdm_timer_start latency?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Philippe Gerum <rpm@xenomai.org> writes:

> On 02/09/2018 11:02 AM, Philippe Gerum wrote:
>> On 02/09/2018 12:45 AM, Lowell Gilbert wrote:
>>> Am I correct in assuming that when calling rtdm_timer_start(), I should
>>> not be getting multi-second latencies before the first call to the timer
>>> routine? Just checking before I dig in too far.
>>>
>> 
>> Of course not. I suspect an absolute expiry time is given with a
>> relative mode spec.
>> 
>
> More generally, an absolute expiry time which is not based on the right
> clock specified by the mode argument.
>
> i.e.
>
> expiry = rtdm_clock_monotonic(), mode = RTDM_TIMERMODE_REALTIME => BAD
> expiry = rtdm_clock_realtime(), mode = RTDM_TIMERMODE_ABSOLUTE => BAD
> expiry = rtdm_clock_realtime() or _monotonic(), mode =
> RTDM_TIMERMODE_RELATIVE => BAD

Okay, that makes sense.

I was using 0 for expiry, because I really just wanted the periodic
wakeup. I don't remember why I didn't create a periodic task instead of
using a timer.

What clock do I want to use to get the timer started? Once it starts, it
runs fine; but it often takes two or three seconds before the first call
into the handler.

To put it another way, I'm trying to figure out what am I doing wrong in:
		ret = rtdm_timer_start(&pstate.collect.timer, rtdm_clock_read() + 1,
				       pstate.collect.period,
				       RTDM_TIMERMODE_RELATIVE);

Thanks again.

