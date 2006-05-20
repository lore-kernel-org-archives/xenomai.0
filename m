Message-ID: <446F09B8.6000609@domain.hid>
Date: Sat, 20 May 2006 14:21:12 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] non-RT-safe rtdm_event_*wait
References: <446C264A.7040206@domain.hid>
In-Reply-To: <446C264A.7040206@domain.hid>
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
> Hi,
> 
> attached is an experimental patch to allow blocking from non-RT context
> on RTDM events. Petr Cervenka made me think about this extension which
> could partially open RTDM drivers also for non-shadowed, i.e. standard
> Linux tasks.
> 
> Why not simply shadowing non-RT waiters? Because this kind of sync
> support should be cheaper than adding yet another (though low-prio) task
> to the real-time domain ("should" == I didn't benchmark my believe). And

I would rather move the logic to the sync object at nucleus level since 
it's a useful feature for all skins, but doing so, we would also drag a 
fair amount of complexity just for the sake of not having to shadow a 
Linux task. IMHO, leaving this at the skin level forks the 
implementation of the synchronization management, which raises the issue 
of duplicating functionalities only depending on the calling context.

Looking at the issue differently, we already know that we could shadow 
SCHED_NORMAL/SCHED_OTHER threads without promoting them to the 
SCHED_FIFO class - you actually submitted this patch, and it's waiting 
for -rc2 to be released before I merge it into mainline.

Given that, a shadow thread which remains in secondary mode is seen as 
suspended by the Xenomai scheduler, which means that the additional 
overhead is close to nil (aside of an additional shadow tcb), until it 
tries to grab the resource and thus moves to the primary domain, just 
for going to sleep.

IOW, I would rather use the allow-non-SCHED_FIFO-shadow patch to allow 
regular Linux tasks to pend seamlessly on Xenomai sync objects as true 
shadows, and add to the rtdm blocking syscall handler some code that 
would transparently promote any calling regular task as a Xenomai shadow 
on the fly, before undergoing the request. The other advantage of such 
approach is that the non-RT pending task is still known from the Xenomai 
sub-system (/proc/xenomai/ interface and so on), which may be useful 
given that it interacts with it. You could still apply a FIFO pending 
order with mixed RT and non-RT tasks the same way.

Moving RTDM to native preemption would also be simpler, since RTDM would 
expect the issue to be handled at core level directly, and in the 
preempt-rt case, the issue of the caller's domain is actually a non-issue.

-- 

Philippe.

