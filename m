Message-ID: <4BB5A57B.8070403@domain.hid>
Date: Fri, 02 Apr 2010 10:06:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>	
	<4BB53566.3010601@domain.hid> <4BB53643.2080604@domain.hid>
	<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
In-Reply-To: <j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Henri Roosen wrote:
> We have the same requirement for which we also have no solution. One
> of our threads has a configurable priority of which at the lowest
> priority the thread should behave like an idle task that is only
> scheduled when all xenomai threads are idle and also the Linux domain
> is idle. The thread might use rtdm-drivers and xenomai mutexes and
> therefore has to be moved to the Xenomai domain. But then it always
> has higher priority than any threads scheduled in linux.
> 
> Actually, when seen from the first domain, this requirement would be
> solved when we could set a first domain priority for the second
> domain... Gilles, is that what is meant by the SCHED_IDLE policy for
> Linux?

What I meant is that this problem really looks like a problem with Linux
scheduler, not with Xenomai scheduler. You want your task scheduled when
Linux has not any other task to run, the fact that it will be run when
Xenomai has no other task to run simply follows from the fact that Linux
tasks are already run when Xenomai has not any Xenomai task to run.

And in fact SCHED_IDLE already exists and does what you expect. However,
I do not know if a task running with SCHED_IDLE may have a shadow (I
guess not), that is our real problem now.

-- 
					    Gilles.

