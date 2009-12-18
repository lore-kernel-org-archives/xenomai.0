From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4B2B3DC0.3000804@domain.hid>
References: <4B2B3DC0.3000804@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Dec 2009 18:11:32 +0100
Message-ID: <1261156292.2216.600.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux-Xenomai Priority Coupling and T_RPIOFF
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Josh Bowman <jbowman@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2009-12-18 at 03:30 -0500, Josh Bowman wrote:
> Hi,
> 
> I'm trying to turn off the "priority coupling" feature for a specific
> Xenomai task in our application. (The task in question is a
> communications thread, and the only time it goes into secondary mode
> is when it calls read() or write() on a TCP socket. At that time, it
> will not be holding the RT_MUTEX that protects the data it shares with
> the other xenomai tasks, so it should not impact the scheduling of the
> other real time tasks in the system.  But giving Linux a real time
> priority could starve out other equal- and lower-priority real time
> tasks in the system.)
> 
> Anyway, turning off the CONFIG_XENO_OPT_PRIOCPL kernel option works
> fine, and seems to do want I want. But there's a note in the config
> documentation that says I should be able to leave that option On, and
> just turn off priority coupling for a specific task at runtime.
> According to the API docs, it seems I should be able to write:
> 
>     int prevMode = 0;
>     int err = rt_task_set_mode( 0, T_RPIOFF, &prevMode );
> 
> from the context of the xenomai task.  (I've also tried passing 0
> instead of &prevMode.)  Either way, it always seems to return -EINVAL
> (meaning "either setmask or clrmask specifies invalid bits.")
> 
> So I have two questions:
> 1.  Is there a bug here, or am I misreading the docs? How do I turn
> off priority coupling at runtime?

There was a bug, this patch should fix it:
http://git.xenomai.org/?p=xenomai-2.4.git;a=commit;h=04b9c404364568befa99dfc67a5c73d46353323f

> 2.  Is there any reason I would want to leave CONFIG_XENO_OPT_PRIOCPL
> enabled?

In case you need the strictest priority scheme to be enforced, even for
the few API calls which have to switch to secondary mode in order to
deliver the requested service, like when creating threads/tasks. To make
this possible, both Xenomai and Linux schedulers have to synchronize
somehow, with respect to the priority of the threads they share (a
Xenomai thread is basically a Linux thread mated to an extension called
a "real-time shadow", which makes it runnable by the Xenomai scheduler
as well).

Typically, rt_task_create/spawn() have to resort to a regular,
glibc-based pthread_create() for creating a new linux thread, before
attaching the shadow, and promoting it to the Xenomai domain. Now, let's
say that Xenomai task A with prio 20, is the parent thread, task B is
the child.

Without prio coupling of both Xenomai's and Linux's schedulers, one
would have the following sequence of events:

task A: rt_task_create(B);
		pthread_create(B)
		=> internally, task A moves to secondary mode,
		Effective prio for A down to -1 (Linux, lowest in 		Xenomai
scheduler).
In effect, A loses precedence over all primary mode tasks until it
switches back to primary mode, despite it has a higher priority level,
Xenomai-wise.

Now, with prio coupling, one would get instead:

task A: rt_task_create(B);
	pthread_create(B)
	=> internally, task A moves to secondary mode,
	Linux prio up to 20 in the Xenomai scheduler while A is controlled by
the Linux scheduler (and not Xenomai's).
i.e. The Xenomai priority scheme is not affected for A.

In short, if your application never switches to secondary mode while
expecting the priority scheme to be 100% strict, then you don't need
prio coupling.

> 
> I'm using Xenomai 2.4.10 on x86 with Linux 2.6.28.9 and ipipe
> 2.6.28.9-x86-2.2-07.  (I've also tested with Linux 2.6.30.8 and ipipe
> 2.6.30.8-x86-2.4-06, with the same result.)
> 
> Thanks for your help,
> Josh
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.



