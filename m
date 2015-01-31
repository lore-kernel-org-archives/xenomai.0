Message-ID: <54CCAA6D.4030007@xenomai.org>
Date: Sat, 31 Jan 2015 11:11:57 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAEMXjGyps7NpBUYgC4j4TrVKbiAZsceiuQ71TymDtXz-a3fqbA@mail.gmail.com>
In-Reply-To: <CAEMXjGyps7NpBUYgC4j4TrVKbiAZsceiuQ71TymDtXz-a3fqbA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] POSIX skin, task crashes Linux when run as RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Steve B <sbattazzo@gmail.com>, xenomai@xenomai.org

On 01/31/2015 12:52 AM, Steve B wrote:
> Hello,
> 
> I have a task running at 100Hz on a Beaglebone Black that seems to crash
> sporadically when I set its parameters to SCHED_FIFO with any priority, and

AFAICT, this should be the basic issue to investigate. Is there any
feedback on the kernel console? any crash report? Or is it just locking
up hard?

> it does not produce the crash when I set it to SCHED_OTHER.
> However when I set it to SCHED_OTHER the jitter is much larger, so we
> really want to get it running stable on SCHED_FIFO if possible.

As expected, SCHED_OTHER won't give you any rt guarantee, hence the
jitter. A SCHED_OTHER thread driven by Xenomai is allowed to wait for
Xenomai resources (e.g. pending on a sema4, waiting on a condvar,
blocking on a message queue), but won't be able to compete with
SCHED_FIFO threads for the CPU.

> Jitter is not currently measured precisely, but the difference is such that
> it can be eyeballed on an oscilloscope watching the messages go back and
> forth.
> Looking at /proc/xenomai/stat this task tends to draw up to about 30% of
> CPU at full load.
> 

You mean when running into the SCHED_OTHER class? If so, the mode
switches might explain such load only if the thread calls a Xenomai
service from its work loop, which forces the transition to primary mode,
which is required for competing for Xenomai resources.

Once the syscall has been handled, a SCHED_OTHER thread is moved back to
secondary/linux mode. So we have two mode switches per Xenomai syscall
which involves a transition for SCHED_OTHER threads. This differs from
SCHED_FIFO threads which switch lazily to the required mode, and stay
there until another transition to the converse mode is required.

> The symptom is that the Linux system becomes largely unresponsive, and the
> task still runs and generates occasional printouts.
> But it quickly goes from 100Hz (self-measured and reported once every few
> seconds) to less than 1Hz and I usually can't kill it off without resetting
> the board.
> 
> I know that the task is doing quite a lot of mode switches due to
> interfacing with hardware that doesn't have an RTDM driver available.
> I may be able to bump that part off to a non-RT task triggered with a
> pthread_cond_wait or a semaphore or something, but I was sort of planning
> to accept the mode switches as long as the timing is still "good enough."

In the SCHED_OTHER case, calling a regular linux driver won't cause any
mode switch, since the thread "naturally" executes in the linux domain
(i.e. secondary mode). On the contrary, a SCHED_FIFO task will have to
switch mode in such situation though.

> 
> Are there any techniques I can employ to troubleshoot this, or is it a
> simple matter of the task being too CPU intensive and starving out Linux,
> or that I really need to be getting rid of the mode switches?
> Or is it possible that there's a bug in Xenomai that can be dug out from
> this?
> 

More information is needed to better understand the issue, including
details about what the work loop is actually doing (see
http://xenomai.org/asking-for-help/).

Enabling CONFIG_XENO_OPT_WATCHDOG might help detecting runaway threads
which belong to Xenomai's SCHED_FIFO class, but this won't apply to your
test with SCHED_OTHER.

Maybe CONFIG_LOCKUP_DETECTOR might trigger in case a linux-driven thread
overconsumes the CPU (i.e. either a Xenomai SCHED_OTHER thread in linux
mode, or a regular pthread).

It is definitely possible that your workload overconsumes CPU depending
on the available CPU horsepower on your platform, but we can't be sure
until we know more about your setup. This said, mode switching is a
costly operation, especially with Xenomai 2.x (compared to 3.x). So the
design should use only a very few of them in a normal work cycle if
absolutely required, and preferably none, unless the later is paced at a
reasonably slow rate in the timeline.

There are ways to exchange messages between a plain regular pthread and
a Xenomai SCHED_FIFO thread without involving any mode switch (see the
XDDP protocol from the RTIPC driver). Other ways exist to share
resources and/or synchronize between Xenomai SCHED_OTHER and SCHED_FIFO
threads, at the expense of mode switches for the former. The best pick
depends on the nature of your workload.

-- 
Philippe.

