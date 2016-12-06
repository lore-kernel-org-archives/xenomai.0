MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Tue, 6 Dec 2016 15:56:56 +0100
Message-ID: <CAMJ=MEeueNfVgXx9eHbv69P4c3jQWDtR7QxSio_-M5buDu0O5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Mercury: roundrobin scheduling using Linux scheduler.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

Round-robin scheduling is implemented in Mercury by
starting a per-thread timer that sends a signal to the thread
when its budget is consumed.

There are several good reasons to implement round-robin
in this way, one of them being the complete freedom at
application level to decide what the round-robin interval is.

On the other hand, there are also several reasons to use
the Linux round-robin mechanism:
- most probably less overhead
- sched_yield not being async-safe (some sources mention
  it is safe while others say it is not)
- application receives a lot of signals in various places in
  the application and library code

The last one is the most important for us at the moment.
We observe strange crashes in glibc sporadically in our
product. We have created a test program that can reproduce
the issue in a couple of minutes/hours.
In fact it is a combination of RT thread, priority inherited
mutexes and signals. If any of the 3 needed elements is
removed, the issue is not seen anymore.

After chasing long time (by experts in the area) for the
root-cause, it has been identified. It was located in the
Linux kernel. Details can be found in the link:
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=locking/core&id=dbb26055defd03d59f678cb5f2c992abe05b064a

Since this bug it is actually triggered by the Xenomai
Mercury behavior and never has seen before (the issue
exists already for 10 years), it makes me worry that we
will hit other issues in the future as well. (in the kernel or
in the glibc)
It was mentioned several times in the discussions that
we are most probably using the system in a mode that is
not common at all.

Therefor I would like to start a discussion on this.
Would it be possible/acceptable to make it a configuration
option, or even better a tunable to use the Linux scheduler
instead of the signal mechanism?

As a kind of experiment I have created an implementation
based on a compilation flag in the copperplate code, did
some testing with it and it behaves well I think.

If the community is open for such a thing, I'm willing to spend
some additional effort to change the implementation into a
run-time flag (tunable).

The impact in the code will basically be:
- do not handle (start /stop) the per-thread timer.
- return the correct policy in prepare_rr_corespec

The default behavior could be kept as today.

Any feedback on this is welcome.

Ronny

