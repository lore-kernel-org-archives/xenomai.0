From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTingRPWqG1SZAaNs4TKeJFXicZWGqmL2A1rT8vrf@domain.hid>
References: <AANLkTingRPWqG1SZAaNs4TKeJFXicZWGqmL2A1rT8vrf@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 09:21:10 +0100
Message-ID: <1301041270.2079.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Scheduling questions...
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Eric <ericrebates@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2011-03-24 at 19:47 -0400, Eric Eric wrote:
> Hello, I've been reading through some of the documentation and have a
> few questions regarding scheduling:
> 
> - API docs say that rt_task_set_mode can allow a task to undergo
> round-robin scheduling.  This seems to imply that we can have an
> environment of mixed round-robin and FIFO task scheduling.  Is this
> correct?  If so, what is the scheduling relationship between tasks
> running in FIFO and RR modes?

RR are FIFO threads within the same priority group.

> 
> - I am concerned about Linux starvation.  For example, suppose a
> misbehaving RT task spins and burns CPU indefinitely (watchdog
> notwithstanding).  I would still like to preempt this task and allow
> Linux to run for up to some maximum time (say up to 30mS every 200mS).
>  So, if using RR scheduling, is there a way to use rt_task_slice to
> allocate time to Linux?  Is there a Linux shadow thread that I can
> allocate time to?

Xenomai implements sporadic server scheduling. See SCHED_SPORADIC,
usable with int pthread_setschedparam_ex().

> 
> Thank you.
> 
> - Eric
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



