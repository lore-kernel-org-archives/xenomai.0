Date: Thu, 30 Apr 2015 23:34:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150430213404.GC1993@hermes.click-hack.org>
References: <CAKC9m6fXKqNhwy3sZ9zqzoAu=Xb7TUSxceogpE7xxB9-J=11wQ@mail.gmail.com>
 <20150430183147.GZ1993@hermes.click-hack.org>
 <CAKC9m6cXp+ZQdZG2qCQA5+J2m0W-2hnLniL0wswfSu5aD32wwg@mail.gmail.com>
 <20150430201409.GA1993@hermes.click-hack.org>
 <20150430212151.GD24389@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150430212151.GD24389@csclub.uwaterloo.ca>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Thu, Apr 30, 2015 at 05:21:51PM -0400, Lennart Sorensen wrote:
> On Thu, Apr 30, 2015 at 10:14:09PM +0200, Gilles Chanteperdrix wrote:
> > "architected timer" is the name of the timers available since cortex
> > A15 (on A7 also, I guess it allows big/little to run exactly the
> > same code on both cores), and I thought I had understood it was also
> > available on armv8. These timers are guaranteed to operate a long
> > period of time without wrapping (something like tens of years), so
> > they do not have a resolution as high as they could have (especially
> > since implementations use less than 32 bits of the higher 32 bits).
> 
> The A15 (and A7, A17, A12, etc) timer is certainly handy.  Some designs
> have managed to screw it up though (like the exynos 5420, where samsung
> decided they were going to use their own timer design from previous
> designs, and not initialize or even run the A15 timer, so the register
> is there, the timer is there, but it isn't running and hence you can't
> use it, which pretty much means no chance of KVM on the exynos chips
> given it assumes the architecture timer can be used by the guest too).
> 
> Good thing we use the TI am572x instead, which does have the architecture
> timer, although with an errata I had to come up with a software fix for.
> The speed is slightly wrong but consistently so.

I had tested architected timers on omap5432, and I believe the
counter frequency was something like 5 MHz, and a high latency, this
looks like a serious regression when omap4 had the global timer
running at 500 MHz and a 22ns latency in user-space (including the
time to jump to the kernel helper), which is better than the latency
I have on an atom N230 where reading the tsc is a dedicated
instruction (like architected timers actually).

-- 
					    Gilles.

