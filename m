Message-ID: <425E90A3.5050103@domain.hid>
Date: Thu, 14 Apr 2005 17:47:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] RE: Interrupt Latency Question
References: <1CFEB358338412458B21FAA0D78FE86D4F0D3F@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D4F0D3F@rennsmail02.eu.thmulti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: Wolfgang Grandegger <wolfgang.grandegger@domain.hid>, rtai@domain.hid, adeos-main@gna.org

Fillod Stephane wrote:
> Wolfgang Grandegger wrote:
> 
>>It's also my experience, that the large latencies are
>>due to TLB misses and cache refills, especially the
>>latter one. What helps is L2 cache or fast memory.
>>For example, on an MPC 5200 I get significately better
>>latencies with DDR-RAM than with SDRAM (which is ca. 
>>20% slower).
> 
> 
> I keep on hearing people are having feeling that their latency
> can be caused by TLB misses/cache refills, but never seen proof.
> Is there some literature about that subject? Nobody in the RTAI 
> community had curiosity to explain and fix this interesting problem?
>

AFAIC, the curiosity is there, and better understanding the caching 
behaviour of the nucleus is planned before fusion turns 1.0; after all, 
the core can run inside a regular Linux process so we could even use 
cachegrind for this. The same goes for Adeos, except that cachegrind is 
obviously out of reach, so the usual tough way is currently followed, 
when time allows.

For instance, this explains why the CONFIG_ADEOS_NOTHREADS came into 
play in recent Adeos releases, but with limited success, since the cost 
of switching domain stacks on low-end machines (Pentium 90Mhz-based 
slug, Geode/x86 266 and IceCube/ppc) was apparently not worth the effort 
of coding up this mode. On mid-range to high-end boxen,
the perceived benefits so far are nil, except perhaps that you don't 
have to fiddle
with non-Linux allocated stacks inside your interrupt handlers (e.g. 
"current" determination hack for x86). Maybe other have had better 
results trying a similar approach on other archs (Michael, with ARM?), I 
don't know. OTOH, the cache issues that could be triggered by the layout 
of the Adeos domain descriptor (adomain_t) still bother me, and have not 
been checked in depth so far AFAIK.

> If not, what about showing (or not) that the large latencies are due
> to TLB misses/cache refills with a tool like Flushy?
> 
> Using Flushy would be like using low-end hardware. It's far easier to
> make 
> performance improvements on low-end hardware than high-end. It works as
> a 
> magnifying glass. It reminds me a comment on Gnome mailing list, where
> an 
> end-user wished that developers had high-end compile machine, but slow 
> hardware to test with.
> 

More precisely, we need fast compile machines, low-end testing platforms 
and fat brains. Guess which one I'm personally missing right now... :o>

> 
>>>Have a look at http://rtai.dk/cgi-bin/gratiswiki.pl?Latency_Killer
>>>To get real bad cases, try the Flushy module.
>>>You can try also to disable caches for better predictability, but it
> 
> really
> 
>>>hurts :*)
>>
>>I will try it on an embedded PowerPC platform a.s.a.p.
> 
> 
> After thought, there would be a better design for Flushy. Instead of 
> an infinite loop in a separate module(process), we should instead call
> the TLB flush/cache invalidate right before entering the RT world
> from ADEOS. Therefore, we should get "predictable" worst case latencies
> wrt 
> TLB/cache conditions.
> 
> Where is the best place in ADEOS to do that?

I'd say arch/ppc/kernel/adeos.c:__adeos_sync_stage(), this is the 
interrupt log syncer. You will find this pattern:

     if (adp == adp_root) {
	/* dispatching ISR to Linux */
     } else {
	/* dispatching ISR to non-root domains. This is where you likely 	 
want to play with the cache, before calling the handler. */
     }

> The earlier, the better. Tapping at the exception level would be the
> best, right before saving registers, but we need couple registers to
> call the 
> TLB/cache flush.
> Any idea?
> 

Only to interpose before the pipelining stuff comes into play, you could 
  hook __adeos_grab_irq(), still in arch/ppc/kernel/adeos.c. It's called 
right after the address translation has been switch on by the exception 
transfer block, so it's quite early already.

> I've Cc:'d the adeos-main list to reach some more gurus.
> 
> 
>>>Note: if it turns out this latency is due to cache misses, then
> 
> solutions
> 
>>>exist.
>>
>>Can you be more precise here.
> 
> 
> With reproducible latencies, we can then use OProfile (where available)
> to
> spot slow areas. We have to sort out whether TLB misses, I-cache misses
> or
> D-cache misses is the bigger culprit. Make your guess :-)
> Modern processors have cache control instructions, like prefetch for
> read,
> zero cache line, writeback flush, etc. With nice cpp macros, we can use
> them (where available) ahead of time in the previously spotted places, 
> to render the memory access latency predictable.
> 
> Do you think that will do it? Anybody has experience to share?
> 
> 
> Thanks


-- 

Philippe.

