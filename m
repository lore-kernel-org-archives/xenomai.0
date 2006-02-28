Message-ID: <440467F3.7020903@domain.hid>
Date: Tue, 28 Feb 2006 16:10:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] resume/suspend periodic timing issue
References: <C0299D36.256C%steve@domain.hid>
In-Reply-To: <C0299D36.256C%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steve@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Steven Seeger wrote:
> Every other RTOS I've ever used would disagree with you. However, I can wrap

set_periodic/wait_period are used to define a timeline, with a base period 
dedicated to process a bounded work cycle. If your application decides to kill the 
timeline by skipping work cycles voluntarily in order to process e.g. error states 
or interactive break, it needs to reset the timeline by calling set_periodic anew, 
which seems quite reasonable to do, since the old timeline is now dead in the 
water. If this is not some error recovery work or break state, but regular 
processing, then it should fit in the normal work cycle, otherwise there is no 
point in using set_periodic/wait_period to time it in the first place.

Beyond that, comparing with other RTOS behaviours does not fly that well, because 
some which actually implement this kind of construct might well raise an exception 
to some health manager entity for signaling the overrun (e.g. arinc653), in which 
case, one would end up having to hack the error handler so that it swallows those 
exceptions silently, for the interesting purpose of making a valid case out of an 
error case...

We could pass rt_task_wait_period() a pointer to an integer that would collect the 
count of overruns, and reset this count after the first overrun has been signaled. 
But this would not fix the initial problem in the application, though.

> the suspend/resume functions with a call to set period. Thanks for the tip.
> 
> Steven
> 
> On 2/28/06 6:21 AM, "Jan Kiszka" <jan.kiszka@domain.hid> wrote:
> 
> 
>>Steven Seeger wrote:
>>Just imagine that your task is attached to a continuously running timer
>>as soon as you request this via rt_task_set_periodic. So, if you feel
>>like suspending the task for a while, detach it from that timer again
>>(infinite period). Putting this functionality into the RTOS is a bit
>>overkill in my eyes.
>>
>>This is a corner use-case, so not everyone should pay for implementing
>>it in a generic way, only the user who really wants it (by having to
>>write a few extra lines).
>>
>>Jan
>>
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

