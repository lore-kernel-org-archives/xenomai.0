MIME-Version: 1.0
Date: Fri, 30 Jan 2015 15:52:49 -0800
Message-ID: <CAEMXjGyps7NpBUYgC4j4TrVKbiAZsceiuQ71TymDtXz-a3fqbA@mail.gmail.com>
From: Steve B <sbattazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] POSIX skin, task crashes Linux when run as RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I have a task running at 100Hz on a Beaglebone Black that seems to crash
sporadically when I set its parameters to SCHED_FIFO with any priority, and
it does not produce the crash when I set it to SCHED_OTHER.
However when I set it to SCHED_OTHER the jitter is much larger, so we
really want to get it running stable on SCHED_FIFO if possible.
Jitter is not currently measured precisely, but the difference is such that
it can be eyeballed on an oscilloscope watching the messages go back and
forth.
Looking at /proc/xenomai/stat this task tends to draw up to about 30% of
CPU at full load.

The symptom is that the Linux system becomes largely unresponsive, and the
task still runs and generates occasional printouts.
But it quickly goes from 100Hz (self-measured and reported once every few
seconds) to less than 1Hz and I usually can't kill it off without resetting
the board.

I know that the task is doing quite a lot of mode switches due to
interfacing with hardware that doesn't have an RTDM driver available.
I may be able to bump that part off to a non-RT task triggered with a
pthread_cond_wait or a semaphore or something, but I was sort of planning
to accept the mode switches as long as the timing is still "good enough."

Are there any techniques I can employ to troubleshoot this, or is it a
simple matter of the task being too CPU intensive and starving out Linux,
or that I really need to be getting rid of the mode switches?
Or is it possible that there's a bug in Xenomai that can be dug out from
this?

Cheers,

Steve
