Subject: Re: [Xenomai-core] [Fwd: [rfc][patch] queued spinlocks (i386)]
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4603DA8F.8050900@domain.hid>
References: <4603DA8F.8050900@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 15:34:51 +0100
Message-Id: <1174660491.4606.17.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Fri, 2007-03-23 at 14:47 +0100, Jan Kiszka wrote:
> That idea sounds worthwhile for xnlocks as well, doesn't it?

Not sure, yet. Real starvation on xnlocks would require non-RT activity
to be completely locked out on all CPUs in the first place for that to
happen, which would be the sign of a serious design flaw. I see no way
to solve such initial problem by adding some fairness to the lock
dispatching policy in primary mode.

Still, thinking about this patch, since there is a price to pay for this
approach due to serious cache-bouncing on high contention, using the
waiter priority to manage the pending queue instead of a simple FIFO
ticketing would be at least logically better, but likely even more
costly.

> 
> There is a follow-up discussion [1] on whether MS is holding a patent on
> this, but so far the survey is that no conflict exists.
> 
> Jan
> 
> [1] http://lkml.org/lkml/2007/3/23/82
> 
> 
> email message attachment ([rfc][patch] queued spinlocks
> (i386).eml.eml.eml)
> > -------- Forwarded Message --------
> > From: Nick Piggin <npiggin@domain.hid>
> > To: Linux Kernel Mailing List <linux-kernel@domain.hid>
> > Cc: Ravikiran G Thirumalai <kiran@domain.hid>, Ingo Molnar
> > <mingo@domain.hid>
> > Subject: [rfc][patch] queued spinlocks (i386)
> > Date: Fri, 23 Mar 2007 09:59:11 +0100
> > Newsgroups: gmane.linux.kernel
> > 
> > plain text document attachment ([rfc][patch] queued spinlocks
> > (i386).eml.eml.eml)
> > Implement queued spinlocks for i386. This shouldn't increase the size of
> > the spinlock structure, while still able to handle 2^16 CPUs.
> > 
> > Not completely implemented with assembly yet, to make the algorithm a bit
> > clearer.
> > 
> > The queued spinlock has 2 fields, a head and a tail, which are indexes
> > into a FIFO of waiting CPUs. To take a spinlock, a CPU performs an
> > "atomic_inc_return" on the head index, and keeps the returned value as
> > a ticket. The CPU then spins until the tail index is equal to that
> > ticket.
> > 
> > To unlock a spinlock, the tail index is incremented (this can be non
> > atomic, because only the lock owner will modify tail).
> > 
> > Implementation inefficiencies aside, this change should have little
> > effect on performance for uncontended locks, but will have quite a
> > large cost for highly contended locks [O(N) cacheline transfers vs
> > O(1) per lock aquisition, where N is the number of CPUs contending].
> > The benefit is is that contended locks will not cause any starvation.
> > 
> > Just an idea. Big NUMA hardware seems to have fairness logic that
> > prevents starvation for the regular spinlock logic. But it might be
> > interesting for -rt kernel or systems with starvation issues. 
> > 
> > 
> > Index: linux-2.6/include/asm-i386/spinlock.h
> > ===================================================================
> > --- linux-2.6.orig/include/asm-i386/spinlock.h
> > +++ linux-2.6/include/asm-i386/spinlock.h
> > @@ -29,69 +29,23 @@
> >  
> >  static inline int __raw_spin_is_locked(raw_spinlock_t *x)
> >  {
> > -	return *(volatile signed char *)(&(x)->slock) <= 0;
> > +	return unlikely(x->qhead != x->qtail);
> >  }
> >  
> >  static inline void __raw_spin_lock(raw_spinlock_t *lock)
> >  {
> > -	asm volatile("\n1:\t"
> > -		     LOCK_PREFIX " ; decb %0\n\t"
> > -		     "jns 3f\n"
> > -		     "2:\t"
> > -		     "rep;nop\n\t"
> > -		     "cmpb $0,%0\n\t"
> > -		     "jle 2b\n\t"
> > -		     "jmp 1b\n"
> > -		     "3:\n\t"
> > -		     : "+m" (lock->slock) : : "memory");
> > -}
> > +	unsigned short pos = 1;
> >  
> > -/*
> > - * It is easier for the lock validator if interrupts are not re-enabled
> > - * in the middle of a lock-acquire. This is a performance feature anyway
> > - * so we turn it off:
> > - *
> > - * NOTE: there's an irqs-on section here, which normally would have to be
> > - * irq-traced, but on CONFIG_TRACE_IRQFLAGS we never use this variant.
> > - */
> > -#ifndef CONFIG_PROVE_LOCKING
> > -static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
> > -{
> > -	asm volatile(
> > -		"\n1:\t"
> > -		LOCK_PREFIX " ; decb %[slock]\n\t"
> > -		"jns 5f\n"
> > -		"2:\t"
> > -		"testl $0x200, %[flags]\n\t"
> > -		"jz 4f\n\t"
> > -		STI_STRING "\n"
> > -		"3:\t"
> > -		"rep;nop\n\t"
> > -		"cmpb $0, %[slock]\n\t"
> > -		"jle 3b\n\t"
> > -		CLI_STRING "\n\t"
> > -		"jmp 1b\n"
> > -		"4:\t"
> > -		"rep;nop\n\t"
> > -		"cmpb $0, %[slock]\n\t"
> > -		"jg 1b\n\t"
> > -		"jmp 4b\n"
> > -		"5:\n\t"
> > -		: [slock] "+m" (lock->slock)
> > -		: [flags] "r" (flags)
> > -	 	  CLI_STI_INPUT_ARGS
> > -		: "memory" CLI_STI_CLOBBERS);
> > +	asm volatile(LOCK_PREFIX "xaddw %0, %1\n\t"
> > +		     : "+r" (pos), "+m" (lock->qhead) : : "memory");
> > +	while (unlikely(pos != lock->qtail))
> > +		cpu_relax();
> >  }
> > -#endif
> >  
> >  static inline int __raw_spin_trylock(raw_spinlock_t *lock)
> >  {
> > -	char oldval;
> > -	asm volatile(
> > -		"xchgb %b0,%1"
> > -		:"=q" (oldval), "+m" (lock->slock)
> > -		:"0" (0) : "memory");
> > -	return oldval > 0;
> > +	unsigned short qtail = lock->qtail;
> > +	return likely(cmpxchg(&lock->qhead, qtail, qtail+1) == qtail);
> >  }
> >  
> >  /*
> > @@ -105,18 +59,14 @@ static inline int __raw_spin_trylock(raw
> >  
> >  static inline void __raw_spin_unlock(raw_spinlock_t *lock)
> >  {
> > -	asm volatile("movb $1,%0" : "+m" (lock->slock) :: "memory");
> > +	asm volatile("addw $1,%0" : "+m" (lock->qtail) :: "memory");
> >  }
> >  
> >  #else
> >  
> >  static inline void __raw_spin_unlock(raw_spinlock_t *lock)
> >  {
> > -	char oldval = 1;
> > -
> > -	asm volatile("xchgb %b0, %1"
> > -		     : "=q" (oldval), "+m" (lock->slock)
> > -		     : "0" (oldval) : "memory");
> > +	asm volatile(LOCK_PREFIX "addw $1,%0" : "+m" (lock->qtail) :: "memory");
> >  }
> >  
> >  #endif
> > Index: linux-2.6/include/asm-i386/spinlock_types.h
> > ===================================================================
> > --- linux-2.6.orig/include/asm-i386/spinlock_types.h
> > +++ linux-2.6/include/asm-i386/spinlock_types.h
> > @@ -6,10 +6,11 @@
> >  #endif
> >  
> >  typedef struct {
> > -	unsigned int slock;
> > +	unsigned short qhead;
> > +	unsigned short qtail;
> >  } raw_spinlock_t;
> >  
> > -#define __RAW_SPIN_LOCK_UNLOCKED	{ 1 }
> > +#define __RAW_SPIN_LOCK_UNLOCKED	{ 0, 0 }
> >  
> >  typedef struct {
> >  	unsigned int lock;
> > 
> > 
> > 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



