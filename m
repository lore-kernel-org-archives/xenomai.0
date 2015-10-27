From: Vasudev Kamath <vasudev@copyninja.info>
Date: Tue, 27 Oct 2015 05:43:07 +0000 (UTC)
Message-ID: <loom.20151027T063128-689@post.gmane.org>
References: <6b0caf4dfe7d407988717a23fb855097@EX132MBOX1B.de2.local>
 <53832095.10901@xenomai.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Using Preempt RT with I-Pipe/Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Philippe,

Philippe Gerum <rpm <at> xenomai.org> writes:

> 
> Fixing up ipipe_lock.h to switch the regular locks (i.e. neither 
> ipipe/raw) to the sleeping rt_ spinlock variant is pretty much all you 
> should have to do these days.
> 
> My last experience merging I-pipe+preempt-rt dates back to kernel 2.6.x, 
> so a few more conflicts might have popped up since then though. This 
> said, I did not see any showstopper in recent kernels that would prevent 
> such combo from working.
> 
> e.g.:
> 
> +#ifdef PREEMPT_RT
> + #define __regular_spin_lock_irqsave(lock, flags)		\
> +	do { rt_spin_lock(std_spinlock(lock)); flags = 0; } while (0) /* can't 
> discard flags */
> +#else
> +#define __regular_spin_lock_irqsave(lock, flags)		\
> +	__real_raw_spin_lock_irqsave(&std_spinlock(lock)->rlock, flags)
> +#endif
> 
> #define PICK_SPINLOCK_IRQSAVE(lock, flags)				\
> 	do {								\
> 		if (ipipe_spinlock_p(lock))				\
> 			(flags) = __ipipe_spin_lock_irqsave(ipipe_spinlock(lock)); \
> 		else if (std_spinlock_raw_p(lock))				\
> 			__real_raw_spin_lock_irqsave(std_spinlock_raw(lock), flags); \
> 		else if (std_spinlock_p(lock))				\
> -			__real_raw_spin_lock_irqsave(&std_spinlock(lock)->rlock, flags); \
> +			__regular_spin_lock_irqsave(lock, flags); \
> 		else __bad_lock_type();					\
> 	} while (0)
> 
> and so on for all other helpers defining a preempt-rt specific variant.

I'm also trying to use both Xenomai IPipe with RT_PREEMPT patch and stumbled
across this thread. I should say I'm novice in RT world so I just followed
your hint above and did this patch to ipipe_lock.h. I'm using Kernel 3.14.25
with Xenomai 2.6 from Git (snapshot 546d1fd)

[PS: Wanted to attach the patch but Gmane didn't provide a option so pasting
it here]
diff --git a/include/linux/ipipe_lock.h b/include/linux/ipipe_lock.h
index f71d2f1..7959a65 100644
--- a/include/linux/ipipe_lock.h
+++ b/include/linux/ipipe_lock.h
@@ -42,6 +42,20 @@ typedef struct {
 #define std_spinlock_raw(lock)	((raw_spinlock_t *)(lock))
 #define std_spinlock(lock)	((spinlock_t *)(lock))
 
+/* Thanks to Philippe Gerrum for this snippet
+ * https://www.mail-archive.com/xenomai@xenomai.org/msg05815.html
+ */
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define __regular_spin_lock_irqsave(lock, flags)                       \
+	do { rt_spin_lock(std_spinlock(lock)); flags = 0; } while (0) /* Can't
+								       * discard
+								       * flags
+								       * */
+#else
+#define __regular_spin_lock_irqsave(lock, flags)                       \
+	__real_raw_spin_lock_irqsave(&std_spinlock(lock)->rlock, flags)
+#endif
+
 #define PICK_SPINLOCK_IRQSAVE(lock, flags)				\
 	do {								\
 		if (ipipe_spinlock_p(lock))				\
@@ -49,7 +63,7 @@ typedef struct {
 		else if (std_spinlock_raw_p(lock))				\
 			__real_raw_spin_lock_irqsave(std_spinlock_raw(lock), flags); \
 		else if (std_spinlock_p(lock))				\
-			__real_raw_spin_lock_irqsave(&std_spinlock(lock)->rlock, flags); \
+			__regular_spin_lock_irqsave(lock, flags);       \
 		else __bad_lock_type();					\
 	} while (0)
 
@@ -79,6 +93,14 @@ typedef struct {
 		__ret__;						\
 	 })
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define __regular_spin_unlock_irqrestore(lock, flags)                   \
+	do { rt_spin_unlock(std_spinlock(lock)); flags = 0; } while (0)
+#else
+#define __regular_spin_unlock_irqrestore(lock, flags)                   \
+	__real_raw_spin_unlock_irqrestore(&std_spinlock(lock)->rlock, flags);
+#endif
+
 #define PICK_SPINUNLOCK_IRQRESTORE(lock, flags)				\
 	do {								\
 		if (ipipe_spinlock_p(lock))				\
@@ -88,10 +110,18 @@ typedef struct {
 			if (std_spinlock_raw_p(lock))			\
 				__real_raw_spin_unlock_irqrestore(std_spinlock_raw(lock), flags); \
 			else if (std_spinlock_p(lock))			\
-				__real_raw_spin_unlock_irqrestore(&std_spinlock(lock)->rlock, flags); \
+				__regular_spin_unlock_irqrestore(lock, flags); \
 		}							\
 	} while (0)
 
+#ifdef CONFIG_PREEMPT_RT_FULL
+#define __regular_spin(op, lock)	\
+	rt_spin_lock(std_spinlock(lock))
+#else
+#define __regular_spin(op, lock)					\
+	__real_raw_spin##op(&std_spinlock(lock)->rlock)
+#endif
+
 #define PICK_SPINOP(op, lock)						\
 	({								\
 		if (ipipe_spinlock_p(lock))				\
@@ -99,7 +129,7 @@ typedef struct {
 		else if (std_spinlock_raw_p(lock))			\
 			__real_raw_spin##op(std_spinlock_raw(lock));	\
 		else if (std_spinlock_p(lock))				\
-			__real_raw_spin##op(&std_spinlock(lock)->rlock); \
+			__regular_spin(op, lock);               	\
 		else __bad_lock_type();					\
 		(void)0;						\
 	})

After the patch Kernel did compile, though I've not tested the compiled
kernel yet. Since I've no idea if what I've done is correct or not I would
be happy to get some review on this patch from you or fellow Xenomai folks.

Also after the patching I did see several kernel compile warning similar to
the below

kernel/ipipe/core.c: In function 'ipipe_alloc_virq':
kernel/ipipe/core.c:825:2: warning: passing argument 1 of 'rt_spin_lock'
from incompatible pointer type [enabled by default]
In file included from include/linux/spinlock.h:310:0,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from kernel/ipipe/core.c:24:
include/linux/spinlock_rt.h:21:56: note: expected 'struct spinlock_t *' but
argument is of type 'struct __ipipe_spinlock_t *'
kernel/ipipe/core.c:833:2: warning: passing argument 1 of 'rt_spin_unlock'
from incompatible pointer type [enabled by default]
In file included from include/linux/spinlock.h:310:0,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from kernel/ipipe/core.c:24:
include/linux/spinlock_rt.h:24:56: note: expected 'struct spinlock_t *' but
argument is of type 'struct __ipipe_spinlock_t *'
kernel/ipipe/core.c: In function 'ipipe_request_irq':
kernel/ipipe/core.c:863:2: warning: passing argument 1 of 'rt_spin_lock'
from incompatible pointer type [enabled by default]
In file included from include/linux/spinlock.h:310:0,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from kernel/ipipe/core.c:24:
include/linux/spinlock_rt.h:21:56: note: expected 'struct spinlock_t *' but
argument is of type 'struct __ipipe_spinlock_t *'
kernel/ipipe/core.c:881:2: warning: passing argument 1 of 'rt_spin_unlock'
from incompatible pointer type [enabled by default]
In file included from include/linux/spinlock.h:310:0,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from kernel/ipipe/core.c:24:
include/linux/spinlock_rt.h:24:56: note: expected 'struct spinlock_t *' but
argument is of type 'struct __ipipe_spinlock_t *'
kernel/ipipe/core.c: In function 'ipipe_free_irq':
kernel/ipipe/core.c:896:2: warning: passing argument 1 of 'rt_spin_lock'
from incompatible pointer type [enabled by default]
In file included from include/linux/spinlock.h:310:0,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from kernel/ipipe/core.c:24:
include/linux/spinlock_rt.h:21:56: note: expected 'struct spinlock_t *' but
argument is of type 'struct __ipipe_spinlock_t *'
kernel/ipipe/core.c:909:2: warning: passing argument 1 of 'rt_spin_unlock'
from incompatible pointer type [enabled by default]
In file included from include/linux/spinlock.h:310:0,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from kernel/ipipe/core.c:24:
include/linux/spinlock_rt.h:24:56: note: expected 'struct spinlock_t *' but
argument is of type 'struct __ipipe_spinlock_t *'

Again I couldn't figure out the reasons for warning, and will be happy to
find some hints on fixing this.

Thanks in Advance,





