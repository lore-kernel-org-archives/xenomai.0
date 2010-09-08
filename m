Message-ID: <4C87C33D.1060809@domain.hid>
Date: Wed, 08 Sep 2010 19:09:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C8605E6.4000400@domain.hid> <4C862A3B.2050300@domain.hid>
	<4C8713A2.9010705@domain.hid> <4C87418D.1090601@domain.hid>
	<4C87C126.1050203@domain.hid>
In-Reply-To: <4C87C126.1050203@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Oops during rt_event_wait();
 formerly "How do I force..."
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bob Feretich <bob.feretich@domain.hid>
Cc: xenomai@xenomai.org

Bob Feretich wrote:
>   I changed the subject from "How do I force a core dump on a page fault 
> event?", because the thread's topic has drifted.
> Comments inline...
> On 9/8/2010 12:55 AM, Gilles Chanteperdrix wrote:
>> ...Snipped...
>>> No. This problem started occurring when I integrated the whole system
>>> together. I'm going to have to work on it a bit to reduce it to a
>>> suitable code segment .
>>> The Xenomai content of the loop is:
>>> while (!end) {
>>>       ...
>>>       rc = rt_event_wait(&event1,..);
>>>       ...
>>>       rc = rt_event_clear(&event1,..);
>>>       ...
>>>       rc = rt_event_wait(&event2,..);
>>>       ...
>>>       rc = rt_event_clear(&event2,..);
>>>       ...
>>>       rc = rt_event_wait(&event3, TM_NONBLOC, ...);
>>>       if (rc==0) end = 1;
>>> }
>> Is this is a loop using all the CPU (all the events with TM_NONBLOCK) ?
> No, just the last wait has TM_NONBLOCK. CPU utilization for the task is 
> about 2%.

Ok.

> 
> I examined my use of the rt_event mechanism, trying to identify how my 
> use might be unusual.

Well, the first unusual thing I see, is that you wait sequentially for
several events. Since each event has 32 bits, you should not really
require more than one event.

> 
>     * The above calls are in a rt-user-task and are bracketed with
>       bind/unbind, outside the loop. The task starts in secondary mode,
>       performs the loop in primary mode, then finishes in secondary mode.
>     * rt_event_create and rt_event_delete occur in a rtdm driver init
>       and exit routines.
>     * However, rt_event_signal is invoked in interrupt handlers. I think
>       that this may be unusual. Normally, interrupt handlers would use
>       the rtdm_event mechanism.
> 
> Could rt_event_signal be sensitive to being invoked from the context of 
> a real time interrupt?

rt_event_signal is documented as being able to be invoked in interrupt
handlers.

> 
> Interrupt handler stack space is usually quite small. Does 
> rt_event_signal make heavy use of the stack?

The interrupts handler do not use separated stacks on this architecture.
The stack of whatever kernel thread is preempted by the interrupt
handler is used. But no, rt_event_signal does not require special a lot
of stack space.

Anway, have you tried gdb to see where the error points?

-- 
					    Gilles.

