From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200704120818.00897.jweber@domain.hid>
References: <200704111656.18894.jweber@domain.hid>
	<b647ffbd0704111535l4e756c77he276a57f0f5f32cb@domain.hid>
	<200704120818.00897.jweber@domain.hid>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 16:05:26 +0200
Message-Id: <1176386727.5022.50.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Linux system calls from RT kernel task
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Thu, 2007-04-12 at 08:18 -0500, Jeff Weber wrote:
> On Wednesday 11 April 2007 17:35, Dmitry Adamushko wrote:
> > On 11/04/07, Jeff Weber <jweber@domain.hid> wrote:
> > > Are there any restrictions against calling the Linux kernel, namely
> > > do_gettimeofday(), from a Xenomai kernel task?
> > >
> > > Does the kernel space task switch from primary to secondary mode, just as
> > > a user space task would?
> >
> > No.
> Ok, so is a Xenomai kernel-based thread essentially locked into primary mode?

Basically, secondary mode does not exist for kernel threads, so the
answer is yes.

The best way to understand this is to get back to the way kernel-based
Xenomai threads are implemented: they are pure Xenomai abstractions
running as some kind of in-kernel co-routines, which are _not_ based on
Linux kernel threads (i.e. task_structs). As a consequence of this, the
regular Linux scheduler does not even know about them, and in any case,
can't schedule them. For this reason, only the Xenomai scheduler is able
to control those threads, and as such, those are essentially primary
mode things. In that sense, a task runs in primary mode because it is
controlled by the Xenomai scheduler, and switches to secondary mode as a
result of its control being transferred to the regular Linux scheduler.

Another hint to figure out why this works this way is to consider how
modes are switched between primary and secondary for any given Xenomai
thread: such switching occurs at the syscall interface level in kernel
space, right after the user-space to kernel transition. IOW, right now,
the secondary mode can only be defined for tasks having a user-space
side.

This implementation (i.e. the way kernel-based Xenomai threads are
defined) will change in Xenomai 3 when running over a fully preemptible
kernel, but this is likely to stay as it is when used in co-kernel mode.

>   
> And if so, would calls to rt_task_set_mode(T_PRIMARY,0,0) then be illegal?

You would get -EINVAL.

> >
> > Regarding the use of Linux kernel functions, consider it from the
> > point that your rt task (in general, any activity from the primary
> > domain) could have interrupted the Linux kernel at any (well, almost)
> > point.. i.e. some spin_locks can be held by the kernel and if you
> > happen to call a function from the primary domain that does use these
> > locks - well, nothing good is going to happen. In general, it's a no
> > go.
> What's the best general way to describe the list of functions that can use 
> these locks, so I can avoid this scenario in the future?
> 

In short, any activity which is currently controlled by the regular
Linux core:

1) any regular Linux thread, user-space or kernel-based created outside
the Xenomai realm.
2) any user-space Xenomai thread running in secondary mode (vs all
kernel-based Xenomai threads and user-space Xenomai threads running in
primary mode).
3) any Linux interrupt handler when the kernel logic allows this (vs
interrupt handlers installed by Xenomai to process real-time events).
4) any asynch callbacks fired by the regular kernel, like softirqs etc.
Xenomai APCs (asynch procedure calls) also belong to this category,
since Xenomai delegates their handling to Linux, which in turn fires
them as soon as possible when it is back in control of the hardware (vs
strict real-time operation mode).

Anything outside of this list cannot use these locks without leading to
"unexpected results".

> 	Jeff
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



