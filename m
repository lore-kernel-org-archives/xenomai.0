From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 1 May 2015 10:36:31 -0400
Message-ID: <20150501143631.GH24389@csclub.uwaterloo.ca>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430183147.GZ1993@hermes.click-hack.org>
 <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
 <20150430201409.GA1993@hermes.click-hack.org>
 <20150430212151.GD24389@csclub.uwaterloo.ca>
 <20150430212749.GB1993@hermes.click-hack.org>
 <20150501134547.GF24389@csclub.uwaterloo.ca>
 <20150501135651.GE1993@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150501135651.GE1993@hermes.click-hack.org>
Subject: Re: [Xenomai] Ipipe-core patched kernel fails to start when certain
 platform drivers are enabled
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, May 01, 2015 at 03:56:51PM +0200, Gilles Chanteperdrix wrote:
> 6MHz is still not a lot (even omap3 did better than that).
> 
> And no, a A 56 bits counter running at 6MHz does not wrap in 2794
> seconds, it wraps in:
> 
> (2^56) / 6000000 = 12009599006 s
> 
> That is:
> 12009599006 / (365 * 24 * 3600) = 380 years
> 
> So, you are safe, it can be considered to avoid wrapping for a
> reasonable amount of time.
> 
> Which means really, that I do not understand why the frequency is so
> low.

I hava a suspicition that the 6.144MHz was chosen because it is what
S/PDIF requires to run 48Khz audio.  Some it may have something to do
with multimedia handling.

And in low power mode they run it from 32.768 KHz * 375 / 2.

Sure looks like they could have easily made it faster, although making
it faster wouldn't necesarily make it any more accurate depending on
how it is implemented.  After all if it is just taking a 20MHz system
clock input and incrementing from that, then there isn't much point
running it faster.  If you can run it from the PLL circuit that runs
the CPU core on the other hand, that would be interesting.  Of course
that frequency can scale up and down if cpu frequency scaling is enabled.

> 56 bits at 1 GHz would wrap in two years using the same computation,
> that clearly would violate ARM specs. But 60 MHz for instance would
> wrap in 38 years, that would seem reasonable.

Does the kernel have a bug then:

[    0.000000] OMAP clockevent source: timer1 at 32786 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps every 65536000000000ns
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000335] Architected cp15 timer(s) running at 6.14MHz (phys).
[    0.000370] sched_clock: 56 bits at 6MHz, resolution 162ns, wraps every 2794592043008ns
[    0.000376] Switching to timer-based delay loop
[    0.100554] Calibrating delay loop (skipped), value calculated using timer frequency.. 12.29 BogoMIPS (lpj=6147)

I think 2794592043008ns = 2794.592043008s, and I must admit I assumed
the kernel knew what it was talking about.  It looks like it does not.

I agree that thing isn't going to wrap ever.

I see a few patches have gone in to that code since 3.14, so perhaps
someone has fixed that printout.

-- 
Len Sorensen

