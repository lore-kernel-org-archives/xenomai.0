MIME-Version: 1.0
In-Reply-To: <54D0A0C2.3050905@xenomai.org>
References: <CAEMXjGyps7NpBUYgC4j4TrVKbiAZsceiuQ71TymDtXz-a3fqbA@mail.gmail.com>
 <54CCAA6D.4030007@xenomai.org>
 <CAEMXjGyNHrnCRXjVQq8FaWAVdzN1x3079QT0J_bCx_8VfNoQxA@mail.gmail.com>
 <54D0A0C2.3050905@xenomai.org>
Date: Tue, 3 Feb 2015 08:58:42 -0800
Message-ID: <CAEMXjGxgqgM3HG-nwVAkQUSM-ub3BT22YtsLMq-A9coPPzDOHQ@mail.gmail.com>
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

A typical issue is an error reported by some blocking call - for
> instance when reading data from some RT device - going unnoticed by the
> application, which then iterates and so on. Normally, this causes a hard
> lockup due to the RT scheduling priority, but if your work loop also
> switches mode due to plain linux calls, then the system might just be
> brought to a crawl instead.
>
> That would explain why the Xenomai watchdog does not trigger either,
> since you do frequent transitions to secondary/linux mode, the real-time
> core does not detect the lockup condition which is N secs spent in
> primary/rt mode without transition to linux (N=4 by default).
>
>

> Before anything else, I would definitely make sure that each and every
> call to a blocking service in any rt work loop is checked for error
> condition.
>
>
After re-distributing the part of the main work loop that I suspected was
doing the mode switches (moved to another thread which I tried both
SCHED_FIFO and SCHED_OTHER), all of the mode switches just went along to
the other thread, the main loop does about 10 during initialization and
then never increases.
Interestingly this freed things up at crash time just enough to get this
sort of message on my dmesg:
"[sched_delayed] sched: RT throttling activated"

If I just prevent that routine from running, thus getting rid of all the
recurring mode switches, the crash still happens.

The blocking call error thing is interesting. I do have some supplementary
threads (all SCHED_FIFO) that are reading off of the hardware with blocking
calls and feeding messages to the main work thread to be processed.
Interestingly these blocking reads (to non-RTDM devices) are not causing
any mode switches, so my assumption was that these threads are actually
keeping in secondary mode once they get started.
However it looks like the reads are rigged to report when the return value
is less than zero, which I have not seen happen so far.

> My top suspicion now is that the main thread is occasionally hogging CPU
> > and some percentage of the time it's enough to throw off Linux, but I am
> > just trying to figure out if there's some way I can prove or disprove
> that
> > easily. It seems to be independent of whether or not my other (non-RT)
> > threads are even running at all.
> >
>
> This is my understanding as well.
>

Since my blocking reads are set up to report errors and exit program, and I
still see the problem when I eliminate all of the mode switches, it seems
this points to the work loop not leaving enough time for Linux to do what
it needs to do.. how we can fix that is another issue. Thanks for all of
the info, this has been very educational!

Steve
