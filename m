Message-ID: <4D0A7CD2.4000301@domain.hid>
Date: Thu, 16 Dec 2010 21:55:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BAY149-w131A596DF2F2249BFEFAA3E4150@domain.hid>,
	<1292524810.1837.261.camel@domain.hid>
	<BAY149-w569BBC6219044CB125C68BE4150@domain.hid>
In-Reply-To: <BAY149-w569BBC6219044CB125C68BE4150@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and timers.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Chris Stone <chris.linux@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

Chris Stone wrote:
> Thanks for your reply, and I realize that I am now getting off topic
> for this list, but if the explanation is easy perhaps I could impose
> on you a little further. How does one fix the POSIX code to deal with
> this issue? When sem_timedwait() returns with ETIMEDOUT, how does one
> know that the time was changed by another task and the timeout was
> not the duration that was asked for?

The answer is that POSIX is a big mess with regard to this issue... Some
functions allow to choose between relative and absolute timeouts
(clock_nanosleep, timer_settime), others allow to change the clock
(pthread_cond_timedwait), since using CLOCK_MONOTONIC automatically
solves this issue, some use relative timeouts. Others such as
sem_timedwait, pthread_mutex_timedlock pthread_timedjoin, offer no choice.

We could add some pthread_mutexattr_setclock_np and sem_setclock_np
services, but then your code would only run with Xenomai, which makes
POSIX a little less useful.

Note that usually, a timeout is an unexpected rare event not in need for
a lot of precision, and clock_settime should not make big jumps, I do
not think using sem_timedwait to create a periodic task was the plan.
Also note that Xenomai and Linux clock are separated, so, if Linux calls
clock_settime, Xenomai timers will not see it.

-- 
                                                                Gilles.

