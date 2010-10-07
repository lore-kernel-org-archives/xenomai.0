From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4CAE04B1.9070503@domain.hid>
References: <4CAAF0CA.7060603@domain.hid> <4CAB24D9.5000308@domain.hid>
	<4CAB2994.40505@domain.hid> <4CAB2B37.7010104@domain.hid>
	<4CAB2C4B.6090005@domain.hid> <4CAB2D1C.70907@domain.hid>
	<4CAB305B.60406@domain.hid> <4CAB3450.5090105@domain.hid>
	<4CAC3F55.4050007@domain.hid>
	<1286471281.13186.79.camel@domain.hid>
	<4CAE04B1.9070503@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Oct 2010 22:48:12 +0200
Message-ID: <1286484492.13186.85.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Overcoming the "foreign" stack
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On Thu, 2010-10-07 at 19:34 +0200, Jan Kiszka wrote:
> Am 07.10.2010 19:08, Philippe Gerum wrote:
> > On Wed, 2010-10-06 at 11:20 +0200, Jan Kiszka wrote: 
> >> Am 05.10.2010 16:21, Gilles Chanteperdrix wrote:
> >>> Jan Kiszka wrote:
> >>>> Am 05.10.2010 15:50, Gilles Chanteperdrix wrote:
> >>>>> Jan Kiszka wrote:
> >>>>>> Am 05.10.2010 15:42, Gilles Chanteperdrix wrote:
> >>>>>>> Jan Kiszka wrote:
> >>>>>>>> Am 05.10.2010 15:15, Gilles Chanteperdrix wrote:
> >>>>>>>>> Jan Kiszka wrote:
> >>>>>>>>>> Hi,
> >>>>>>>>>>
> >>>>>>>>>> quite a few limitations and complications of using Linux services over
> >>>>>>>>>> non-Linux domains relate to potentially invalid "current" and
> >>>>>>>>>> "thread_info". The non-Linux domain could maintain their own kernel
> >>>>>>>>>> stacks while Linux tend to derive current and thread_info from the stack
> >>>>>>>>>> pointer. This is not an issue anymore on x86-64 (both states are stored
> >>>>>>>>>> in per-cpu variables) but other archs (e.g. x86-32 or ARM) still use the
> >>>>>>>>>> stack and may continue to do so.
> >>>>>>>>>>
> >>>>>>>>>> I just looked into this thing again as I'm evaluating ways to exploit
> >>>>>>>>>> the kernel's tracing framework also under Xenomai. Unfortunately, it
> >>>>>>>>>> does a lot of fiddling with preempt_count and need_resched, so patching
> >>>>>>>>>> it for Xenomai use would become a maintenance nightmare.
> >>>>>>>>>>
> >>>>>>>>>> An alternative, also for other use cases like kgdb and probably perf, is
> >>>>>>>>>> to get rid of our dependency on home-grown stacks. I think we are on
> >>>>>>>>>> that way already as in-kernel skins have been deprecated. The only
> >>>>>>>>>> remaining user after them will be RTDM driver tasks. But I think those
> >>>>>>>>>> could simply become in-kernel shadows of kthreads which would bind their
> >>>>>>>>>> stacks to what Linux provides. Moreover, Xenomai could start updating
> >>>>>>>>>> "current" and "thread_info" on context switches (unless this already
> >>>>>>>>>> happens implicitly). That would give us proper contexts for system-level
> >>>>>>>>>> tracing and profiling.
> >>>>>>>>>>
> >>>>>>>>>> My key question is currently if and how much of this could be realized
> >>>>>>>>>> in 2.6. Could we drop in-kernel skins in that version? If not, what
> >>>>>>>>>> about disabling them by default, converting RTDM tasks to a
> >>>>>>>>>> kthread-based approach, and enabling tracing etc. only in that case?
> >>>>>>>>>> However, this might be a bit fragile unless we can establish
> >>>>>>>>>> compile-time or run-time requirements negotiation between Adeos and its
> >>>>>>>>>> users (Xenomai) about the stack model.
> >>>>>>>>> A stupid question: why not make things the other way around: patch the
> >>>>>>>>> current and current_thread_info functions to be made I-pipe aware and
> >>>>>>>>> use an "ipipe_current" pointer to the current thread task_struct. Of
> >>>>>>>>> course, there are places where the current or current_thread_info macros
> >>>>>>>>> are implemented in assembly, so it may be not simple as it sounds, but
> >>>>>>>>> it would allow to keep 128 Kb stacks if we want. This also means that we
> >>>>>>>>> would have to put a task_struct at the bottom of every Xenomai task.
> >>>>>>>> First of all, overhead vs. maintenance. Either every access to
> >>>>>>>> preempt_count() would require a check for the current domain and its
> >>>>>>>> foreign stack flag, or I would have to patch dozens (if that is enough)
> >>>>>>>> of code sites in the tracer framework.
> >>>>>>> No. I mean we would dereference a pointer named ipipe_current. That is
> >>>>>>> all, no other check. This pointer would be maintained elsewhere. And we
> >>>>>>> modify the "current" macro, like:
> >>>>>>>
> >>>>>>> #ifdef CONFIG_IPIPE
> >>>>>>> extern struct task_struct *ipipe_current;
> >>>>>>> #define current ipipe_current
> >>>>>>> #endif
> >>>>>>>
> >>>>>>> Any calll site gets modified automatically. Or current_thread_info, if
> >>>>>>> it is current_thread_info which is obtained using the stack pointer mask
> >>>>>>> trick.
> >>>>>> The stack pointer mask trick only works with fixed-sized stacks, not a
> >>>>>> guaranteed property of in-kernel Xenomai threads.
> >>>>> Precisely the reason why I propose to replace it with a global variable
> >>>>> reference, or a per-cpu variable for SMP systems.
> >>>>
> >>>> Then why is Linux not using this in favor of the stack pointer approach
> >>>> on, say, ARM?
> >>>>
> >>>> For sure, we can patch all Adeos-supported archs away from stack-based
> >>>> to per-cpu current & thread_info, but I don't feel comfortable with this
> >>>> in some way invasive approach as well. Well, maybe it's just my personal
> >>>> misperception.
> >>>
> >>> It is as much invasive as modifying local_irq_save/local_irq_restore.
> >>> The real question about the global pointer approach, is, if it so much
> >>> less efficient, how does Xenomai, which uses this scheme, manage to have
> >>> good performances on ARM?
> >>
> >> Xenomai has no heavily-used preempt_disable/enable that is built on top
> >> of thread_info. But I also have no numbers on this.
> >>
> >> I looked closer at the kernel dependencies on a fixed stack size.
> >> Besides current and thread_info, further features that make use of this
> >> are stack unwinding (boundary checks) and overflow checking. So while we
> >> can work around the dependency for some tracing requirements, I really
> >> see no point in heading for this long-term. It just creates more subtle
> >> patching needs in Adeos, and it also requires work on Xenomai side. I
> >> really think it's better provide a compatible context to reduce
> >> maintenance efforts.
> >>
> >> So I played a bit with converting RTDM tasks to in-kernel shadows. It
> >> works but needs more fine-tuning. My proposal for 2.6 now looks like this:
> >>
> >>  - add mm-less shadow support to the nucleus (changes in
> >>    xnarch_switch_to and xnshadow_map)
> >>  - convert RTDM tasks to in-kernel shadows
> >>  - switch current and thread_info on Xenomai task switches
> >>  - make in-kernel skins optional, default off
> >>  - let in-kernel skins dependent on disabled tracing
> > 
> > I agree with your approach of moving to kernel space shadows, this is
> > the best way to get rid of foreign stacks. Those are a relic of the
> > kernel-only era, this introduces painful constraints, e.g. in low-level
> > thread switching code (i.e. so-called "hybrid" scheduling) and other
> > weirdnesses. This definitely has to go.
> > 
> > I'm on a wait and see stance about generalizing the use of the ftrace
> > framework for our needs; like Gilles saw with ARM, I must admit that I
> > did notice a massive overhead on low-end ppc as well when we moved the
> > pipeline tracer over it. I'm aware of the mcount optimizations that
> > should be there when cycles really matter, and that ftrace does branch
> > directly to the trace function when only a single one exists, but this
> > may not be easy to keep after the generalization has taken place.
> > Anyway, I'll wait for more data to make my opinion.
> 
> As I said, ftrace is more the a simple mcount-tracer. And it's standard,
> distros start to enable it in their production kernels these days
> (except for the function tracer).
> 
> If the overhead of the ftrace's mcount is too high on low-end platforms
> (I personally haven't tried it there yet), it would probably be a good
> idea to develop some optimizations or allow some variant that does not
> suffer that much - but upstream then.
> 
> > 
> > However, those changes can't be targeted at 2.6. The rationale for
> > issuing 2.6 is really about cleaning up some ABI issues and merging
> > invasive but non-critical infrastructure changes, so that we can
> > maintain the 2.x series for a long time without being stuck by the ABI
> > constraints of 2.5.x. Your proposal is clean material for 3.x though,
> > given that we won't even have to bother with in-kernel skin APIs there.
> 
> OK, I see. This will be too late for our next version I'm afraid.
> 
> But maybe we can establish some intermediate solutions, at least for
> x86-64 where we do not have that many problems with kernel-stack-based
> information. That would allow to explore the potentials of ftrace and
> tools a bit earlier.
> 

We could use your tree to host this provided you rebase on -head, and
feed the forge with that material when it is a ready for prime time.

> > 
> > This said, I understand we need a branch to experiment radical changes
> > aimed at 3.x, but xenomai-head is no place for that. I have been
> > tracking -head for some time, doing massive cuts in the code to
> > eliminate most of the obvious legacy we don't want to care about anymore
> > (e.g. 2.4 kernel support, in-kernel skin APIs, and a few others). I will
> > shortly open a new tree on git.xenomai.org called "forge" with that code
> > base, so that we have the proper playground to get wild with our
> > chainsaws in the Xenomai core aimed at 3.x.
> 
> Looking forward to seeing this.
> 
> I actually ran into one compatibility conflict with my shadow rtdm task
> as well: Someone specified rtdm_task_init as RT-safe, and some strange
> network stack called RTnet indeed made use of this.

Yeah, kids these days...

>  Would be easier to
> simply require a driver update for a new RTDM version than establishing
> a compatibility workaround.
> 

It would make sense to me as well. There are not that many opportunity
to change some bad rules from a good game, and one of them happens now
with 3.x.

> Jan
> 

-- 
Philippe.



