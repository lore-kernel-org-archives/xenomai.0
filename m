From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 1 May 2015 11:11:53 -0400
Message-ID: <20150501151153.GI24389@csclub.uwaterloo.ca>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430183147.GZ1993@hermes.click-hack.org>
 <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
 <20150430201409.GA1993@hermes.click-hack.org>
 <20150430212151.GD24389@csclub.uwaterloo.ca>
 <20150430213404.GC1993@hermes.click-hack.org>
 <20150501142042.GG24389@csclub.uwaterloo.ca>
 <20150501143045.GH1993@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150501143045.GH1993@hermes.click-hack.org>
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

On Fri, May 01, 2015 at 04:30:45PM +0200, Gilles Chanteperdrix wrote:
> The point is: the cortex A9 global timer runs at half the processor
> frequency, that is 500 MHz for a 1GHz processor: that gives a much
> better resolution than a timer with a frequency lower than 10 MHz
> you get with a cortex A15. So since the cortex A15 is newer than the
> cortex A9, it could be expected to do better or at least be
> equivalent, rather than do much worse.

Did any of the A9 designs allow changing the speed on the fly the way
the A15 and others do?

I certainly like the idea of a 500MHz timer.

> > Now they do have lots of other timers in the chip that can be programmed.
> > I wonder if that could be used to make something much better.
> > 
> > I am pretty sure the omap5432 uses 6.144 MHz just like the am572x was
> > supposed to (if it wasn't for the errata that makes it 6.147541
> > MHz instead).
> 
> Yes, 5MHZ, 6 MHZ, that is the same bad order of magnitude.
> 
> > Looking at the manual for the am572x it looks like the general purpose
> > timers are only 32 bit and can run at either 32.768 KHz or system clock
> > (usually 20 MHz).  That's not much help.
> 
> Once again: Xenomai extends 32 bits counter to 64 bits in software.
> So, a 32 bits counter running at 20 MHz is still better than the
> architected timer running at 6MHz. 6 MHz is so low that by reading
> twice the counter in less than 166ns (which is really really doable
> on these processors), you could get twice the same value. On cortex
> A9, I could read the counter twice in userspace in 22ns, and get
> different values. On cortex A9, anything lower than 50 MHz would
> not have been sufficient for user-space.

Yep, that makes sense.  160 ns is a long time on a 1GHz CPU.

It looks like one of the clock sources for the timers is
./sys_clkin2/abe_dpll_sys_clk_mux/abe_dpll_clk_mux/dpll_abe_ck/dpll_abe_x2_ck/dpll_abe_m2x2_ck/abe_clk/aess_fclk/abe_giclk_div/clk_rate
which is 361267200 Hz (at least right now it is), so that might actually
be able to be used to make a nice counter.  All the other sources are
either external clock input pins, or sysclk1 (20 MHz usually) or sysclk2
(22.5792 MHz).  The 361267200 is 16 * sysclk2.

I wonder how to create a clocksource from a general purpose timer.

-- 
Len Sorensen

