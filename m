References: <20160618130822.GB18433@hermes.click-hack.org>
 <8e8bb173-eda9-bab4-6236-634da1e396cb@xenomai.org>
 <20160618133734.GD18433@hermes.click-hack.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6da3c6da-6194-9e35-85ce-5f205a19affa@xenomai.org>
Date: Sun, 19 Jun 2016 19:28:43 +0200
MIME-Version: 1.0
In-Reply-To: <20160618133734.GD18433@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ftrace dispatch function broken on 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 06/18/2016 03:37 PM, Gilles Chanteperdrix wrote:
> On Sat, Jun 18, 2016 at 03:21:40PM +0200, Philippe Gerum wrote:
>> On 06/18/2016 03:08 PM, Gilles Chanteperdrix wrote:
>>> Hi Philippe,
>>>
>>> it seems since I-pipe commit
>>> b115c4094d734e19fa7a96be1bf3958b3d244b8b on the ipipe-3.18 branch:
>>>     Revert "ipipe: Register function tracer for direct and exclusive invocation"
>>>     
>>>     This reverts commit e00888b4aae45d9b84698a62079dde14c9be5fd3.
>>>     
>>>     We now have an I-pipe-compatible dispatching function for ftrace.
>>>
>>> The ftrace dispatching function causes the following warning at
>>> boot on x86_32 with all warnings/debugs enabled:
>>> [    4.730812] I-pipe: head domain Xenomai registered.
>>> [    4.737967] I-pipe: Detected illicit call from head domain 'Xenomai'
>>> [    4.737967]         into a regular Linux service
>>>
>>> Because it calls preempt_disable(), which is not safe to be called
>>> form root domain, when runnning over 2.6.x on an architecture such
>>> as x86_32 which does not have IPIPE_HAVE_SAFE_THREAD_INFO.
>>>
>>> Should we make the ftrace dispatching function really I-pipe
>>> compatible by calling ipipe_preempt_disable() in that case instead?
>>> or should we make the patch revert conditional to !IPIPE_LEGACY or
>>> IPIPE_HAVE_SAFE_THREAD_INFO (but that would make only the I-pipe
>>> tracer work in that case).
>>>
>>
>> I would go for the change which has the lesser impact on the mainline
>> code; that would be option #1.
> 
> Ok. Something else. Commit fdb5d54d04b8c3b6b6a6ad7ac2b6248cf0b415e0:
>     ipipe: Avoid rescheduling from __ftrace_ops_list_func in illegal contexts
>     
>     The ftrace callback dispatcher may be called with hard irqs disabled or
>     even over the head domain. We cannot allow any rescheduling in that
>     case, but also do not have: only non-urgent events are expected to be
>     kicked-off from ftrace callbacks, and those will at latest be handled on
>     the next Linux timer tick.
> 
> Added the following code to the ftrace dispatch function:
> +#ifdef CONFIG_IPIPE
> +       if (hard_irqs_disabled() || !__ipipe_root_p)
> +               /*
> +                * Nothing urgent to schedule here. At latest the timer tick
> +                * will pick up whatever the tracing functions kicked off.
> +                */
> +               preempt_enable_no_resched_notrace();
> +       else
> +#endif
> +               preempt_enable_notrace();
> 
> Should not this go to the generic definition of preempt_enable() ? I
> mean if in the !LEGACY case, it is now legal to call
> preempt_enable() over non root contexts or with hard irqs off, so,
> does it really make sense to fix all the preempt_enable() spots one
> by one?
> 

That would add a useless branch to hundreds of code paths, which can
never run with hard irqs off and/or over the head domain. Besides, this
might prevent the context check in schedule_debug() to run, papering
over a bug. On the other end, specifically annotating the very few code
spots affected by the pipeline, which must not reschedule after
re-enabling preemption seems better maintenance-wise.

I would just use a specific annotation folding all the lengthy code
block above into a single statement.

-- 
Philippe.

