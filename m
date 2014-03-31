From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Mon, 31 Mar 2014 16:42:57 -0400
Message-ID: <20140331204257.GT17765@csclub.uwaterloo.ca>
References: <20140331174555.GO17765@csclub.uwaterloo.ca>
 <5339B015.3080008@xenomai.org>
 <20140331182404.GP17765@csclub.uwaterloo.ca>
 <20140331191502.GQ17765@csclub.uwaterloo.ca>
 <5339BF3C.8090906@xenomai.org>
 <20140331191849.GR17765@csclub.uwaterloo.ca>
 <20140331193742.GS17765@csclub.uwaterloo.ca>
 <5339C5AC.4040409@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5339C5AC.4040409@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
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

On Mon, Mar 31, 2014 at 09:44:44PM +0200, Gilles Chanteperdrix wrote:
> Ok, thanks, will fix in 3.14 patch.
> 
> > 
> > Also my version of arch/arm/include/asm/barrier.h turned out a bit
> > different (I was trying to avoid changing the kernel code as much as
> > possible).  Diff versus yours is:
> 
> I do not really see differences...
> 
> 
> 
> > +#define dmb(option) __asm__ __volatile__("" #option : : : "memory")
> 
> ...except this which is wrong (ish, shst are probably not valid
> instructions, and only make sense as suffixes after dmb). It should not
> even compile.

Hmm, I guess that case never is hit in my config.  I am running SMP.
I am willing to agree mine is probably wrong then.

So comparing the diff I have against yours so far they are amazingly
close to identical.  I found the arch_timer_arm.c changes were nicer in
your version so I am putting that in now, and the powerpc/kernel/irq.c
you dealt with (I had no idea what was going on there), so i am grabbing
that too.

I found a change in your version of kernel/context_tracking.c that I am
going to grab.  Seems to be mostly an ordering difference, but checking
ipipe stuff first makes sense.

I found I had missaplied a bit in kernel/sched/core.c, which explains
why I thought it looked odd while applying it.

I moved to your version of barrier.h for arm.  Everything else seems
like just whitespace differences, so I will give this a try.

-- 
Len Sorensen

