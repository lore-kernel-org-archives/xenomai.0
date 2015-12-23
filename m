From: Steven Seeger <steven.seeger@nasa.gov>
Date: Wed, 23 Dec 2015 14:14:14 -0500
Message-ID: <1658062.jOZnPEAolN@wirbelwind>
In-Reply-To: <20151223184341.GB3877@hermes.click-hack.org>
References: <2558065.W1DNnPs8ZD@wirbelwind>
 <20151223184341.GB3877@hermes.click-hack.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [Xenomai] userspace absolute timer value
Reply-To: steven.seeger@nasa.gov
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wednesday, December 23, 2015 19:43:41 Gilles Chanteperdrix wrote:
> If I understand correctly, your problem is that struct timespec
> tv_sec member has 32 bits. Well, I am afraid there is not much we
> can do about that (I heard mainline has a plan to switch to a new
> timespec with a 64 bits tv_sec, but I do not know how much of that
> plan has been implemented).

Yes, this is exactly my problem.

> 
> Can you not call clock_settime to set a wallclock offset which will
> at least allow CLOCK_REALTIME to behave as expected ?

The issue is with the testsuite/latency app. It uses 
clock_gettime(CLOCK_MONOTONIC) and adds a millisecond to that value and then 
uses that as the absolute start time of the latency thread. All calculates are 
based off this primed value. 

There really is no reason for my board to come up with such a ridiculous 
timebase value. I have no idea why it does that. I set it to 0 very early in 
the kernel boot cycle and it fixed the issue. (This board is loaded via jtag so 
there may be some weirdness there.) This fix will last 136 years, right? :) My 
point was just that if the timebase is not a reasonable value I think this bug 
will manifest. 

IMHO there is no benefit to allowing us to say we want some task to start in 
the year 500,000,000,000 so there isn't really a need for such large numbers 
in this one use-case.

Your idea of a fix is essentially correct, and should work across all systems. 
However, I was trying to run the standard latency app which should also work 
across all systems! :)

Steven


