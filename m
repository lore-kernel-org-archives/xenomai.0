References: <E1aYgex-0004LE-7y@sd-51317.xenomai.org>
 <20160224211048.GA31084@hermes.click-hack.org> <56CE1D68.5070309@siemens.com>
 <20160224212028.GB31084@hermes.click-hack.org> <56CE1EF6.5040408@siemens.com>
 <20160225151143.GE31084@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <56CF1AF7.3020608@siemens.com>
Date: Thu, 25 Feb 2016 16:17:11 +0100
MIME-Version: 1.0
In-Reply-To: <20160225151143.GE31084@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : cobalt/timer: Make
 xntimer_get_overruns robust against stopped timers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2016-02-25 16:11, Gilles Chanteperdrix wrote:
> On Wed, Feb 24, 2016 at 10:21:58PM +0100, Jan Kiszka wrote:
>> On 2016-02-24 22:20, Gilles Chanteperdrix wrote:
>>> On Wed, Feb 24, 2016 at 10:15:20PM +0100, Jan Kiszka wrote:
>>>> On 2016-02-24 22:10, Gilles Chanteperdrix wrote:
>>>>> On Wed, Feb 24, 2016 at 10:07:47PM +0100, git repository hosting wrote:
>>>>>> Module: xenomai-jki
>>>>>> Branch: for-forge
>>>>>> Commit: 8e6d76e07af74056f6cb4d8cfb192485d07732f7
>>>>>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=8e6d76e07af74056f6cb4d8cfb192485d07732f7
>>>>>>
>>>>>> Author: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> Date:   Wed Feb 24 21:44:41 2016 +0100
>>>>>>
>>>>>> cobalt/timer: Make xntimer_get_overruns robust against stopped timers
>>>>>>
>>>>>> xntimer_get_overruns might be called on meanwhile stopped timers,
>>>>>> specifically by cobalt_timer_deliver. We crash if we try to dequeue a
>>>>>> stopped timer, and we should not restart it as well.
>>>>>>
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>>  kernel/cobalt/timer.c |   14 ++++++++------
>>>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
>>>>>> index db6263d..3e85a53 100644
>>>>>> --- a/kernel/cobalt/timer.c
>>>>>> +++ b/kernel/cobalt/timer.c
>>>>>> @@ -602,13 +602,15 @@ unsigned long long xntimer_get_overruns(struct xntimer *timer, xnticks_t now)
>>>>>>  		overruns = xnarch_div64(delta, period);
>>>>>>  		timer->pexpect_ticks += overruns;
>>>>>>  
>>>>>> -		q = xntimer_percpu_queue(timer);
>>>>>> -		xntimer_dequeue(timer, q);
>>>>>> -		while (xntimerh_date(&timer->aplink) < now) {
>>>>>> -			timer->periodic_ticks++;
>>>>>> -			xntimer_update_date(timer);
>>>>>> +		if (xntimer_running_p(timer)) {
>>>>>> +			q = xntimer_percpu_queue(timer);
>>>>>> +			xntimer_dequeue(timer, q);
>>>>>> +			while (xntimerh_date(&timer->aplink) < now) {
>>>>>> +				timer->periodic_ticks++;
>>>>>> +				xntimer_update_date(timer);
>>>>>> +			}
>>>>>> +			xntimer_enqueue_and_program(timer, q);
>>>>>>  		}
>>>>>> -		xntimer_enqueue_and_program(timer, q);
>>>>>
>>>>> This looks wrong. xntimer_get_overruns should not be called on a
>>>>> stopped timer. We want the caller to return an error if called on a
>>>>> stopped timer, not the condition being silently ignored.
>>>>
>>>> The pattern that should trigger this (only tried with custom clocks so far):
>>>>
>>>> - let a periodic timer send a signal
>>>> - block the signal so that it is queued
>>>> - stop the timer (timer_settime(0))
>>>> - process the signal (sigwait)
>>>>
>>>> I don't see why the latter call should fail and not retrieve the queued
>>>> signals.
>>>
>>> Ok, but with your patch periodic_ticks no longer gets incremented in
>>> that case, which looks wrong to me.
>>>
>>
>> To my understanding, we are only interested in the overruns in case of
>> stopped timer. Isn't periodic_ticks reset again start?
> 
> I am not sure I understand your sentence. Both the POSIX timer
> interface and the Linux timerfd interface keep track of the overruns
> at each tick, so no, we are interested in the overruns for every
> tick.
> 
> The aim of this piece of code is to prevent xntimer_get_overruns to
> account twice for the same overrun. I am not sure I understand well
> enough the problem you are trying to avoid to know if yes or no, the
> date should be incremented, but it seems simple to keep the part
> that increments timer->perdiodic_ticks and only make the
> unqueue/requeue code conditional.

The timer is stopped in the case the change covers, so periodic_ticks
plays no role any more until the timer is restart - in which case
periodic_ticks is reset anyway.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

