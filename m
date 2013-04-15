MIME-Version: 1.0
Date: Sun, 14 Apr 2013 20:01:18 -0700
Message-ID: <CAJjOJyYC0v3d1w21XdQ+tyGbTAoxaPbtHVL1qf0B5JJwrtsg0g@mail.gmail.com>
From: Jonathan Wallace <jonmon6691@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Using spi_async with and rtdm periodic task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi!

I'm trying to write a spi driver with RTDM but I've read in at least a
couple places that spi_sync can't be used with rt tasks.
That definitely makes sense to me, but I was wondering if I could use
spi_async. I don't particularly care about the latency or jitter of the spi
operation as long as it actually occurs every period.

My idea was to protect the spi system with an rtdm_mutex_t by locking it
when it is created, and unlocking it once the spi driver is probed. The
task attempts to lock the mutex without a timeout and schedules a transfer
with spi_async, or just waits another period if it can't (Other more
important things happen in the task, missing spi isn't a show-stopper).
Then the spi callback unlocks the mutex. This should prevent the real time
task from muking with spi while the kernel is working with it right? Or am
I missing something else?

Thanks,
-Jon Wallace
