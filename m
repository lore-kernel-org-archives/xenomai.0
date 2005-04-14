Subject: Re: [Adeos-main] RE: Interrupt Latency Question
From: Michael Neuhauser <mike@domain.hid>
In-Reply-To: <425E90A3.5050103@domain.hid>
References: 
	 <1CFEB358338412458B21FAA0D78FE86D4F0D3F@rennsmail02.eu.thmulti.com>
	 <425E90A3.5050103@domain.hid>
Content-Type: text/plain
Message-Id: <1113510049.15964.3.camel@domain.hid>
Mime-Version: 1.0
Date: Thu, 14 Apr 2005 22:20:49 +0200
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Fillod Stephane <stephane.fillod@domain.hid>, Wolfgang Grandegger <wolfgang.grandegger@domain.hid>, rtai@domain.hid, adeos-main@gna.org

On Thu, 2005-04-14 at 17:47, Philippe Gerum wrote: 
> Fillod Stephane wrote:
> 
> > I keep on hearing people are having feeling that their latency
> > can be caused by TLB misses/cache refills, but never seen proof.
> > Is there some literature about that subject? Nobody in the RTAI 
> > community had curiosity to explain and fix this interesting problem?
> 
> AFAIC, the curiosity is there, and better understanding the caching 
> behaviour of the nucleus is planned before fusion turns 1.0; after all, 
> the core can run inside a regular Linux process so we could even use 
> cachegrind for this. The same goes for Adeos, except that cachegrind is 
> obviously out of reach, so the usual tough way is currently followed, 
> when time allows.
> 
> For instance, this explains why the CONFIG_ADEOS_NOTHREADS came into 
> play in recent Adeos releases, but with limited success, since the cost 
> of switching domain stacks on low-end machines (Pentium 90Mhz-based 
> slug, Geode/x86 266 and IceCube/ppc) was apparently not worth the effort 
> of coding up this mode. On mid-range to high-end boxen,
> the perceived benefits so far are nil, except perhaps that you don't 
> have to fiddle
> with non-Linux allocated stacks inside your interrupt handlers (e.g. 
> "current" determination hack for x86). Maybe other have had better 
> results trying a similar approach on other archs (Michael, with ARM?), I 

Non-threaded Adeos helps a little on ARM, but the gain is nothing
compared to the penalty created by the way the caches work on ARM: as
virtual addresses are used to access the cache, it is necessary to flush
it completely *every* time a different process is switched in. This can
be demonstrated by running a simple test program like the following in
parallel to a real-time Adeos domain:
main() { 
            fork();
            while (1)
                sched_yield();
	}
Worst-case latencies are achieved really quick with this setup :-)

Things are even worse if the dcache is configured for write-back:
interrupts have to be disabled during the write-back (switch_mm() call
in schedule()) and that adds 70 us to the worst-case latency on a 166
MHz ARM9 CPU (depends also on the RAM speed of course). You can get rid
of this by using write-through caching, but that decreases the
average-case performance.

The only solution (I have found) to the cold-cache-after-process-switch
problem would be to use MMU-less uClinux (see
http://www.linuxdevices.com/articles/AT2598317046.html)
or a scheme like FASS (see
http://www.disy.cse.unsw.edu.au/Software/FASS/) but both have their
disadvantages.

Mike
-- 
Dr. Michael Neuhauser                phone: +43 1 789 08 49 - 30
Firmix Software GmbH                   fax: +43 1 789 08 49 - 55
Vienna/Austria/Europe                      email: mike@domain.hid
Embedded Linux Development and Services    http://www.firmix.at/


