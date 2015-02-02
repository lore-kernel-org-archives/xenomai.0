MIME-Version: 1.0
In-Reply-To: <54CCAA6D.4030007@xenomai.org>
References: <CAEMXjGyps7NpBUYgC4j4TrVKbiAZsceiuQ71TymDtXz-a3fqbA@mail.gmail.com>
 <54CCAA6D.4030007@xenomai.org>
Date: Mon, 2 Feb 2015 13:12:25 -0800
Message-ID: <CAEMXjGyNHrnCRXjVQq8FaWAVdzN1x3079QT0J_bCx_8VfNoQxA@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] POSIX skin, task crashes Linux when run as RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On Sat, Jan 31, 2015 at 2:11 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 01/31/2015 12:52 AM, Steve B wrote:
> > Hello,
> >
> > I have a task running at 100Hz on a Beaglebone Black that seems to crash
> > sporadically when I set its parameters to SCHED_FIFO with any priority,
> and
>
> AFAICT, this should be the basic issue to investigate. Is there any
> feedback on the kernel console? any crash report? Or is it just locking
> up hard?
>
>
I tried 'dmesg -w' in another telnet session, the only kernel message I saw
after starting up my application was that one of my serial ports had a
buffer overrun once (I don't believe this is related). No messages at the
time of the crash. I would say it's mostly locking up hard as it takes a
very long and indeterminate amount of time to CTRL-C out of the
application, and my other telnet sessions don't respond well (or at all) to
inputs on the command line. The application still gives some printouts, but
about a hundred or to a thousand times slower than nominal.


> > it does not produce the crash when I set it to SCHED_OTHER.
> > However when I set it to SCHED_OTHER the jitter is much larger, so we
> > really want to get it running stable on SCHED_FIFO if possible.
>
> As expected, SCHED_OTHER won't give you any rt guarantee, hence the
> jitter. A SCHED_OTHER thread driven by Xenomai is allowed to wait for
> Xenomai resources (e.g. pending on a sema4, waiting on a condvar,
> blocking on a message queue), but won't be able to compete with
> SCHED_FIFO threads for the CPU.
>
> > Jitter is not currently measured precisely, but the difference is such
> that
> > it can be eyeballed on an oscilloscope watching the messages go back and
> > forth.
> > Looking at /proc/xenomai/stat this task tends to draw up to about 30% of
> > CPU at full load.
> >
>
> You mean when running into the SCHED_OTHER class? If so, the mode
> switches might explain such load only if the thread calls a Xenomai
> service from its work loop, which forces the transition to primary mode,
> which is required for competing for Xenomai resources.
>
>
I am using some XDDP writes as well as writes to non-RTDM hardware, so I
suppose that I will get a handful of mode switches no matter which type of
thread it is.

More information is needed to better understand the issue, including
> details about what the work loop is actually doing (see
> http://xenomai.org/asking-for-help/).
>
> Enabling CONFIG_XENO_OPT_WATCHDOG might help detecting runaway threads
> which belong to Xenomai's SCHED_FIFO class, but this won't apply to your
> test with SCHED_OTHER.
>
> Maybe CONFIG_LOCKUP_DETECTOR might trigger in case a linux-driven thread
> overconsumes the CPU (i.e. either a Xenomai SCHED_OTHER thread in linux
> mode, or a regular pthread).
>
> It is definitely possible that your workload overconsumes CPU depending
> on the available CPU horsepower on your platform, but we can't be sure
> until we know more about your setup. This said, mode switching is a
> costly operation, especially with Xenomai 2.x (compared to 3.x). So the
> design should use only a very few of them in a normal work cycle if
> absolutely required, and preferably none, unless the later is paced at a
> reasonably slow rate in the timeline.
>
>
I am seeing mode switches for that thread increasing at a rate of about 100
for each time I look at /proc/xenomai/stat by hand (less than one second),
so it seems like it's on the order of a couple or a few per cycle actually.
I've been hoping to eliminate those somehow.


> There are ways to exchange messages between a plain regular pthread and
> a Xenomai SCHED_FIFO thread without involving any mode switch (see the
> XDDP protocol from the RTIPC driver). Other ways exist to share
> resources and/or synchronize between Xenomai SCHED_OTHER and SCHED_FIFO
> threads, at the expense of mode switches for the former. The best pick
> depends on the nature of your workload.
>
> I actually found XDDP to be very handy for another part of my application,
but I hadn't thought of using it for the part where the main thread puts
its messages out to hardware. I may look into it for this as well, but I
have been thinking that porting the driver to RTDM is the actual best
solution if it turns out the mode switches are part of the critical path.

I'm not sure yet how much I can disclose about what our main working thread
is doing aside from "a whole lot of floating point operations." It is
actually a bit of a black box to me as well currently. I understand that I
can get the best help if I'm able to provide more info, but since I'm not
sure, I was first hoping to just get some generic troubleshooting
strategies so I can know where to look.

My top suspicion now is that the main thread is occasionally hogging CPU
and some percentage of the time it's enough to throw off Linux, but I am
just trying to figure out if there's some way I can prove or disprove that
easily. It seems to be independent of whether or not my other (non-RT)
threads are even running at all.


At any rate, thanks very much for the suggestions!
