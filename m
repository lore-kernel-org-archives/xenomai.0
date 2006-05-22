Message-ID: <44718DC4.10009@domain.hid>
Date: Mon, 22 May 2006 12:09:08 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] non-RT-safe rtdm_event_*wait
References: <446C264A.7040206@domain.hid> <446F09B8.6000609@domain.hid>
	<44716DC0.7080709@domain.hid>
In-Reply-To: <44716DC0.7080709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: grugh@domain.hid, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Given that, a shadow thread which remains in secondary mode is seen as
>>suspended by the Xenomai scheduler, which means that the additional
>>overhead is close to nil (aside of an additional shadow tcb), until it
>>tries to grab the resource and thus moves to the primary domain, just
>>for going to sleep.
> 
> 
> I'm not concerned about a passive shadow, my aim is to reduce the impact
> of active shadow threads without strict timing requirements. When there
> is a larger number of them, they should not influence RT scheduling
> significantly for just being woken up.
> 

This issue already exists now, since interrupts are off when Linux 
performs a context switch, so that we can't wreck the whole thing by 
allowing a shadow to preempt it in the middle of the mm switch. Since 
non-RT shadow would run at priority level 0, my feeling is that it would 
not change the current situation, except perhaps on SMP where the nklock 
would be held a little more.

> The other point might be the code path length of both non-RT wakeup
> suspend/wakeup mechanisms. It's only an assessment, but I think this way
> would be shorter. Anyway, numbers would speak clearer, and I guess this
> should be done first before any further design decision.
> 

Agreed.

> 
>>IOW, I would rather use the allow-non-SCHED_FIFO-shadow patch to allow
>>regular Linux tasks to pend seamlessly on Xenomai sync objects as true
>>shadows, and add to the rtdm blocking syscall handler some code that
>>would transparently promote any calling regular task as a Xenomai shadow
>>on the fly, before undergoing the request. The other advantage of such
>>approach is that the non-RT pending task is still known from the Xenomai
>>sub-system (/proc/xenomai/ interface and so on), which may be useful
>>given that it interacts with it. You could still apply a FIFO pending
>>order with mixed RT and non-RT tasks the same way.
> 
> 
> Hmm, on-demand shadowing might be an option. Ok, once non-SCHED_FIFO is
> merged, we should have a look at both approaches from the performance
> POV and compare potential differences with the required additional code.
> 
> 
>>Moving RTDM to native preemption would also be simpler, since RTDM would
>>expect the issue to be handled at core level directly, and in the
>>preempt-rt case, the issue of the caller's domain is actually a non-issue.
>>
> 
> 
> Well, this is already the case for my proposal: no special handling of
> rtdm_event_* depending on the caller's context anymore.
> 

But still, you have to change RTDM's code do implement that, more than 
you would have to do in promoting a regular task as a non-RT shadow.

> Jan
> 


-- 

Philippe.

