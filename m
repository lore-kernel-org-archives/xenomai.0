Message-ID: <4370E49F.3070305@domain.hid>
Date: Tue, 08 Nov 2005 18:47:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] scheduling order of dying shadow threads
References: <4370641D.7010906@domain.hid>
	<4370C966.3030903@domain.hid>
	<4370D2B8.8070608@domain.hid>
In-Reply-To: <4370D2B8.8070608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Jan Kiszka <kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>Jan Kiszka wrote:
>>
>>>Hi Philippe,
>>>
>>>I think this one is for you: ;)
>>>
>>>Sebastian got almost mad with his CAN driver while tracing a strange
>>>scheduling behaviour during shadow thread deletion for several days(!) -
>>>and I was right on the way to follow him yesterday evening. Attached is
>>>a simplified demonstration of the effect, consisting of a RTDM driver
>>>and both a kernel and user space application to trigger it.
>>>
>>
>>I've spotted the issue in nucleus/shadow.c. Basically, the root thread
>>priority boost was leaking to a non-shadow thread due to a missing
>>priority reset in the lostage APC handler, whilst a shadow was in the
>>process of relaxing. Really funky bug, thanks! :o> Fixed in the repo
>>hopefully for good. The scheduling sequence is now correct with your
>>demo app on my box.
>>
> 
> 
> Yep, looks good here as well. Great and quick work! Just don't expect
> that someone can follow your explanations easily. :)
> 

Well, sorry. Here is a more useful explanation :

The demo thread in your code calls sleep(1) before exiting, which causes the 
underlying shadow thread to relax. The same would happen without sleeping, since 
  a terminating thread is silently relaxed by the nucleus in any case as needed.

When relaxing the current thread, xnshadow_relax() first boosts the priority of 
the root thread (i.e. the placeholder for Linux in the Xenomai scheduler) right 
before suspending itself. Before that, a wake up request has been scheduled 
(using an APC), so that lostage_handler will be called, which will in turn 
invoke wake_up_process() for the relaxing thread. This is needed because shadows 
running in primary mode are seen as suspended in the Linux sense in 
TASK_INTERRUPTIBLE state. The reason for this is that both Xenomai and Linux 
schedulers must have a mutually exclusive control over a shadow, they should not 
be allowed to both fiddle concurrently with a single thread context; conversely, 
relaxed thread operating in secondary mode are seen as suspended on the XNRELAX 
condition by the nucleus.

IOW, what we want to do here is some kind of transition from the Xenomai to the 
Linux scheduler for the relaxing shadow thread.
This way, we make sure that the Linux scheduler will get back in control for the 
   awaken shadow thread, which ends up running in secondary mode once it has 
been resumed by wake_up_process().

Problem is that the unless we actually reset the root thread priority to the 
lowest one in lostage_handler in order to revert the priority boost done in 
xnshadow_relax, there is a short window of time during which a normal Linux task 
that has been preempted by the APC request that runs lostage_handler could run 
and wreck the scheduling sequence (e.g. your main() context). The fix is about 
downgrading the root thread priority and waking the relaxed shadow up in the 
same move, so that the priority scheme is kept intact.

Now the question is: why does the root thread priority need to be upgraded while 
relaxing a shadow? The answer is simple: when relaxing a shadow, you are not 
expected to change tasks in a Xenomai or Linux sense, you are only changing the 
Xenomai exec mode for a shadow, which means that we must ensure that giving 
control back to the Linux kernel just for the purpose of changing the current 
exec mode won't cause the current priority level of the relaxing thread to be 
lost and spuriously downgraded to the lowest one of the system.
So we just boost it to be equal to the one of the relaxing thread; this way, the 
Linux kernel code undergoes a Xenomai RT priority boost so that Linux cannot be 
preempted by lower priority Xenomai threads. When a shadow thread running in 
secondary mode is switched in, the root thread priority always inherits the 
Xenomai priority level for that thread; conversely, when a non-Xenomai/regular 
Linux task is scheduled in, the root thread priority is downgraded to the lowest 
Xenomai priority.

If one thinks a bit ahead now, having this scheme in place, we should be able to 
benefit from every improvement in the vanilla Linux kernel granularity toward 
real-time guarantees. Because we don't break the priority scheme moving in and 
out of the Linux domain, a Xenomai scheduling decision remains consistent with 
the Linux priority scheme, which is a necessary condition for providing a high 
integration level between Xeno and the vanilla kernel.

> I think this issue has some similarity with the one I once stumbled over
> regarding non-RT signalling to Linux. I'm not going to repeat my general
> concerns regarding the priority boosting of the root thread now... ;)
> 

Each time you spot a bug like this, your stack of concerns should lose at least 
one element, isn'it? :o>

Until Linux is really able to provide a fine-grained, non-disruptive and not 
easily disrupted (e.g. locking semantics in drivers), and low-overhead core 
implementation for RT support, Xeno will need to provide its own primary 
scheduler for latency-critical duties, the seamless mode migration just 
described being there to guarantee a seamless integration.

The day Linux does provide this support, we will be able to focus on the abtract 
RTOS core, RT interface skins, traditional RTOS emulators, and drivers, instead 
of compensating for the current lack of determinism, rebasing Xeno's scheduling 
support over native tasks and the native Linux scheduler. Oh, yeah... _That_ 
would be a great day. But for now, we still need two cooperating schedulers for 
some time ahead, I think. Sigh...

> Jan
> 

-- 

Philippe.

