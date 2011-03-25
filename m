Message-ID: <4D8C6BC2.2050808@domain.hid>
Date: Fri, 25 Mar 2011 11:17:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTingRPWqG1SZAaNs4TKeJFXicZWGqmL2A1rT8vrf@domain.hid>
In-Reply-To: <AANLkTingRPWqG1SZAaNs4TKeJFXicZWGqmL2A1rT8vrf@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

Eric Eric wrote:
> Hello, I've been reading through some of the documentation and have a
> few questions regarding scheduling:
> 
> - API docs say that rt_task_set_mode can allow a task to undergo
> round-robin scheduling.  This seems to imply that we can have an
> environment of mixed round-robin and FIFO task scheduling.  Is this
> correct?  If so, what is the scheduling relationship between tasks
> running in FIFO and RR modes?
> 
> - I am concerned about Linux starvation.  For example, suppose a
> misbehaving RT task spins and burns CPU indefinitely (watchdog
> notwithstanding).  I would still like to preempt this task and allow
> Linux to run for up to some maximum time (say up to 30mS every 200mS).
>  So, if using RR scheduling, is there a way to use rt_task_slice to
> allocate time to Linux?  Is there a Linux shadow thread that I can
> allocate time to?

It looks like you misunderstand round-robin: round-robin only occurs
between tasks running at the same priority. That is what makes it
compatible with FIFO scheduling. And that is the way RTOSes have always
been doing this, and it is even in the posix specification with the
SCHED_RR policy and the sched_yield() service.

-- 
					    Gilles.

