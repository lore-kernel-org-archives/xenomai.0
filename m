MIME-Version: 1.0
In-Reply-To: <56A9E753.2090006@xenomai.org>
References: <CABaOOZ3YZn8wUym7q1ix3HBT2Vtg_O2pjp7Kab4w=X1euVBPWw@mail.gmail.com>
 <56A9E753.2090006@xenomai.org>
Date: Thu, 28 Jan 2016 12:21:42 +0200
Message-ID: <CABaOOZ3oei9WEh74m6STQCar6E_-YgRsGrH+joP0LhQQxpPm7A@mail.gmail.com>
From: Stratiyenko Roman <picoworm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Task resume problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

resume() calls every rttask cycle, so if first resume() will not resume
AFrttask, the second will.

I think the problem can be only if:
1. Some my program memory leaks destroyed rttask structure, so when I call
resume(), the pointers are invalid.
2. The problem is inside xenomai.

I will try to find out where is it.
Thanks for helping.


2016-01-28 12:02 GMT+02:00 Philippe Gerum <rpm@xenomai.org>:

> On 01/28/2016 10:37 AM, Stratiyenko Roman wrote:
> > Hi.
> >
> > Can anybody help me with one not easy to debug problem.
> > Problem happens once per week or two weeks.
> >
> > I have 2 user-level rt-task.
> > One task (rttask) is scheduled isochronous using rt_task_wait_period()
> and
> > have an max priority: 99
> > Second task (AFrttask) is started once, then it suspends from itself and
> > resumes from the first task.
> >
> > Program works as expected, but sometimes (very very rarely) AFrttask not
> > resuming.
> > I connected to the running process using GDB and tracked it. rttask works
> > as expected, It calls resume function of the second task, but second task
> > is not resuming.
> >
> > Here is the dump of /proc/xenomai/sched/stat
> > CPU  PID    MSW        CSW        XSC        PF    STAT       %CPU  NAME
> >   0  0      0          2537012    0          0     00018000   89.1
> [ROOT/0]
> >   0  25095  14         18         75         0     000680c0    0.0  main
> >   0  25097  352        25832      25486      0     00048041    0.0
> AFrttask
>
> STAT == 0x48041, bit #0 means (still) forcibly suspended
> (include/cobalt/uapi/kernel/thread.h), which may mean your tasks raced:
> rttask could have attempted to wake up AFrttask when the latter did not
> self-suspend yet. Wake up notifications are not buffered.
>
> Task suspend/resume constructs are inherently unsafe by design, they are
> present in the API only for the purpose of easing migration from legacy
> RTOS environments, but I would definitely recommend _not_ to use them as
> common inter-task synchronization mechanisms.
>
> --
> Philippe.
>
