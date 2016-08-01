Date: Mon, 1 Aug 2016 22:39:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160801203957.a4n2d4ucquczjluc@hermes.click-hack.org>
References: <20160709132949.GA22236@hermes.click-hack.org>
 <20160801132946.368f30eb@md1em3qc>
 <20160801123510.jxujyigrecnbpkiy@hermes.click-hack.org>
 <64e9fed7-ae79-b7fc-04f7-0e74ef1c9239@siemens.com>
 <20160801140555.7wtzxtbqnd7iecd6@hermes.click-hack.org>
 <2930884c-9198-1da8-40ab-b9ad8bd360e0@siemens.com>
 <20160801173334.v5twlqgs73obpeup@hermes.click-hack.org>
 <2b4ba869-5e35-9a23-aaa2-bf4b7096a480@siemens.com>
 <20160801192343.z2kkr2zhlis7gkoz@hermes.click-hack.org>
 <e08d5e7f-e031-102b-c582-e93a77de1c9a@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e08d5e7f-e031-102b-c582-e93a77de1c9a@siemens.com>
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On Mon, Aug 01, 2016 at 09:58:34PM +0200, Jan Kiszka wrote:
> Sorry if I wasn't clear enough. I can only recommend to re-read the
> Xenomai code, specifically xnarch_switch_to (hint: clts, stts...), and
> then compare to the upstream kernel again and the commit I cited. It's
> probably best you figure this out yourself.

> >> Commit 304bceda6a upstream:
> >>
> >>     x86, fpu: use non-lazy fpu restore for processors supporting xsave
> >>     
> >>     Fundamental model of the current Linux kernel is to lazily init and
> >>     restore FPU instead of restoring the task state during context switch.
> >>     This changes that fundamental lazy model to the non-lazy model for
> >>     the processors supporting xsave feature.

I do not think that you are not clear. The commit message is clear
enough and in line with how I have been seeing Linux switching FPU
context on x86 for years: it was switching out FPU context during
context switch to avoid SMP races, and switching in FPU context upon
FPU faults (at the very beginning, with some refinements as time
changed, with a counter that caused switching to eager after 5
context switches where the FPU had been used), hence "lazily restore
FPU" in the commit message; this was lazy switching. Xenomai saves
and restores unconditionally (if the XNFPU bit is set) the FPU
context at every context switch.

Look at Xenomai 2.1 code:
https://git.xenomai.org/xenomai-2.0.git/tree/nucleus/pod.c#n2139

This is __xnpod_switch_fpu, the function which switches the FPU
context.

And this function is called here:
https://git.xenomai.org/xenomai-2.0.git/tree/nucleus/pod.c#n2446

That is, in the middle of the context switch. No fault. Nothing
lazy. Ergo eager.

The particular instructions used (clts, stts) has nothing to do with
whether this is eager or not. Yes, clts and stts may be slow on new
high end hardware, but as I said, we do not care about new high end
hardware, because it has no valid reason whatsoever to be running a
dual kernel.

-- 
					    Gilles.

