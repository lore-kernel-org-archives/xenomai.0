Message-ID: <53832095.10901@xenomai.org>
Date: Mon, 26 May 2014 13:08:05 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <6b0caf4dfe7d407988717a23fb855097@EX132MBOX1B.de2.local>
In-Reply-To: <6b0caf4dfe7d407988717a23fb855097@EX132MBOX1B.de2.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using Preempt RT with I-Pipe/Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/25/2014 09:59 PM, Stoidner, Christoph wrote:
> Hi at all,
>
> I need some sort of real time behaviour in secondary domain, so I am trying to merge Preempt RT patch with I-Pipe/Xenomai. Since Preempt RT as well as I-Pipe doing some specific changes to kernel's spinlock handling (mostly in  "include/linux/spinlock.h") this becomes a bit of tricky. The challenge seems to combine Preemp RT's "rt_spin_lock" with I-Pipe's "ipipe_spinlock".
>
> My first approach was to instrument I-Pipe's "PICK_SPINLOCK" macros with Preempt RT's "rt_spin_lock" calls. In detail that means I have added calls of rt_spin_lock to all PICK_SPINLOCK macros for each spinlock type  that is not an I-Pipe spinlock. However I am not sure if that is the best solution and if it is correct for all situations.
>
> Has someone experiences how to merge these spinlocks or what to consider at all when using Preempt RT with I-Pipe/Xenomai?
>

Fixing up ipipe_lock.h to switch the regular locks (i.e. neither 
ipipe/raw) to the sleeping rt_ spinlock variant is pretty much all you 
should have to do these days.

My last experience merging I-pipe+preempt-rt dates back to kernel 2.6.x, 
so a few more conflicts might have popped up since then though. This 
said, I did not see any showstopper in recent kernels that would prevent 
such combo from working.

e.g.:

+#ifdef PREEMPT_RT
+ #define __regular_spin_lock_irqsave(lock, flags)		\
+	do { rt_spin_lock(std_spinlock(lock)); flags = 0; } while (0) /* can't 
discard flags */
+#else
+#define __regular_spin_lock_irqsave(lock, flags)		\
+	__real_raw_spin_lock_irqsave(&std_spinlock(lock)->rlock, flags)
+#endif

#define PICK_SPINLOCK_IRQSAVE(lock, flags)				\
	do {								\
		if (ipipe_spinlock_p(lock))				\
			(flags) = __ipipe_spin_lock_irqsave(ipipe_spinlock(lock)); \
		else if (std_spinlock_raw_p(lock))				\
			__real_raw_spin_lock_irqsave(std_spinlock_raw(lock), flags); \
		else if (std_spinlock_p(lock))				\
-			__real_raw_spin_lock_irqsave(&std_spinlock(lock)->rlock, flags); \
+			__regular_spin_lock_irqsave(lock, flags); \
		else __bad_lock_type();					\
	} while (0)

and so on for all other helpers defining a preempt-rt specific variant.

-- 
Philippe.

