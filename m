Message-ID: <1521026342.8992.21.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Wed, 14 Mar 2018 12:19:02 +0100
In-Reply-To: <6cb98615-fa18-9c11-affd-5bcda302ed44@xenomai.org>
References: <1521024178.8992.7.camel@sprinte.eu>
 <6cb98615-fa18-9c11-affd-5bcda302ed44@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Strange behaviour after calling clock_settime
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Le mercredi 14 mars 2018 à 12:00 +0100, Philippe Gerum a écrit :
> On 03/14/2018 11:42 AM, Julien Blanc wrote:
> > 
> > Hi,
> > 
> > The current xenomai documentation states that it is allowed to call
> > clock_settime with CLOCK_REALTIME parameter to set the value of the
> > xenomai realtime clock. On our board, the value at bootup is always
> > 0
> Assuming you run in dual kernel mode, i.e. using Cobalt?
> Assuming you run Xenomai 3.whatever?

Yes, dual kernel using cobalt / xenomai 3.0.5. Target architecture is
armv5l.

> > (so, epoch), despite the hardware clock being correctly set.
> > 
> > However, we experience bad behaviour when doing so. Notably,
> > alchemy
> > condition variables seems to no longer work.
> This is vague. What does "no longer work" mean, specifically? Soft
> hang,
> kernel crash, does not unblock upon signal, timeout fails to trigger
> or
> call always fails on timeout?

Specifically, signaling most of the time no longer works (ie, the
thread is stucked in the rt_cond_wait_xx call, despite the
rt_cond_signal call being done). By "most of the time", i mean that
this usually do not work, but it happened to work sometimes when in a
debugging session. I already checked that this is not a simple
applicative race condition issue (ie, the signalling being done before
the call to wait).

> There are smoke tests in the standard installation for testing basic
> POSIX mechanisms with Cobalt:
> 
> # smokey --run=posix*
> 
> Those tests may take up to ~25s or so to complete. Also, you will
> need a
> properly calibrated timer to pass some of them, esp. those testing
> the
> clocks. So you may want to run "autotune" to get the timer gravity
> values right before running the smoke tests.

Here are the results before touching the CLOCK_REALTIME :

# autotune 
== auto-tuning started, period=1000000 ns (may take a while)
irq gravity... 999 ns
kernel gravity... 8499 ns
user gravity... 15499 ns
== auto-tuning completed after 35s

# smokey --run=posix*
posix_clock OK
posix_cond OK
posix_fork OK
mutex_trylock not supported
posix_mutex OK
posix_select OK

After setting CLOCK_REALTIME :

# smokey --run=posix*
posix_clock OK
posix_cond OK
posix_fork OK
mutex_trylock not supported
posix_mutex OK
posix_select OK

So, i'll try to do a simple test program that reproduce the issue we
encounter. Thanks for your answer

Julien


