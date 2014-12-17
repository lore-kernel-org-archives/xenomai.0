Date: Wed, 17 Dec 2014 14:22:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141217132235.GA4096@hermes.click-hack.org>
References: <20141211163807.GD27793@hermes.click-hack.org>
 <609e4e03a401411fa6bc14de1ad4d3a5@EX132MBOX1A.de2.local>
 <ea7b0e38bbc54fb693aa93e0acd4cb22@EX132MBOX1A.de2.local>
 <54d4a4e8070b4811bfa13471cce38745@EX132MBOX1A.de2.local>
 <20141215132315.GK11058@hermes.click-hack.org>
 <40a594c20ef2443e9f61bbf12885a3c2@EX132MBOX1A.de2.local>
 <20141215142021.GL11058@hermes.click-hack.org>
 <80c7a5eb4be9451eb0f847a58ee91c27@EX132MBOX1A.de2.local>
 <20141215151954.GN11058@hermes.click-hack.org>
 <322873cb03ce4d91b6217ebf8e3ef714@EX132MBOX1A.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <322873cb03ce4d91b6217ebf8e3ef714@EX132MBOX1A.de2.local>
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Dec 17, 2014 at 12:24:23PM +0000, Stoidner, Christoph wrote:
> 
> After some research I have ended up now in APC'c thread handling (see code snipped below, out of ksrc/arch/generic/hal.c). From my point of view there could be occur the "lost wakeup problem". That means in detail that rthal_kicker() calls wakeup when rthal_apc_thread() has returned from rthal_apc_handler() but not yet called set_current_state(). After that, when kicker has finished, the APC thread calls set_current_state() and goes to sleep. Thus, the wakeup is lost. Or do I overlook something?  Maybe we should use a waitqueue here?
> 
> 
> static int rthal_apc_thread(void *data)
> {
>     unsigned cpu = (unsigned)(unsigned long)data;
> 
>     set_cpus_allowed(current, cpumask_of_cpu(cpu));
>     sigfillset(&current->blocked);
>     current->flags |= PF_NOFREEZE;
>     /* Use highest priority here, since some apc handlers might
>        require to run as soon as possible after the request has been
>        pended. */
>     rthal_setsched_root(current, SCHED_FIFO, MAX_RT_PRIO - 1);
> 
>     while (!kthread_should_stop()) {
>         set_current_state(TASK_INTERRUPTIBLE);
>         schedule();

You can obtain the same effect as with a wait queue by replacing the
schedule() above with:

	  if (rthal_apc_pending[cpu] == 0)
	     schedule();

However, using a wait queue will make the code easier to read.

>         rthal_apc_handler(0, NULL);
>     }
> 
>     __set_current_state(TASK_RUNNING);
> 
>     return 0;
> }
> 
> void rthal_apc_kicker(unsigned virq, void *cookie)
> {
>     wake_up_process(rthal_apc_servers[smp_processor_id()]);
> }

-- 
					    Gilles.

