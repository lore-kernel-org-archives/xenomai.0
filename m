Message-ID: <5440DD6E.30605@xenomai.org>
Date: Fri, 17 Oct 2014 11:12:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CABaOOZ2YOda_cUS-tskNxDZ6sNekMqnPnbu6p8Qp4kvjRzDMyA@mail.gmail.com>	<543E9BAE.2010808@xenomai.org>	<543E9CF5.6080400@xenomai.org>	<CABaOOZ1Hb5YYBXt2jtyTZWVnA03EGohaVChzEJ0X9=od2=SeNw@mail.gmail.com>	<543F8974.4070400@xenomai.org>	<CABaOOZ0aEf8F3EzW=w4R1OgK0SGzE9VnDAJHV+swmSc3EF9O-w@mail.gmail.com>	<543F900D.3050500@xenomai.org>
 <CABaOOZ0gmn2XnoF+pzPVWEU0Fh7WfafJduk5qUnknp5pk8V2bQ@mail.gmail.com>
In-Reply-To: <CABaOOZ0gmn2XnoF+pzPVWEU0Fh7WfafJduk5qUnknp5pk8V2bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Manual context switch from userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Stratiyenko Roman <picoworm@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/17/2014 11:04 AM, Stratiyenko Roman wrote:
> Thank you for helping. I replaced swapcontext with longjmp. All works good.
> No switch to secondary mode.
> 
> As about using threads, I do not fully understand how scheduler works.
> Maybe after I will get more experience in multithreading, I will do as you
> recommend.

Well the rule for SCHED_FIFO is quite simple. At any time, the task with
the highest priority which has been ready for the longest time runs.

This means that when a task runs, it will continue running unless it
wakes up a task with higher priority, or relinquishes cpu by manually
scheduling, calling sched_yield, or gets suspended by calling a service
which suspends its caller, such as pthred_cond_wait, sem_wait, or
pthread_mutex_lock. Of course this is assuming that no time base event
can wake-up a task with higher priority. You get that if you do not use
timers, directly, or indirectly through timed services (nanosleep,
pthread_cond_timedwait, mq_timedsend, etc...).

-- 
                                                                Gilles.

