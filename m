From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4ADB56C1.8020103@domain.hid>
References: <4AD8A87C.4040706@domain.hid>
	<1255799737.2862.15.camel@domain.hid>  <4ADB100B.1060300@domain.hid>
	<1255884524.2862.77.camel@domain.hid>  <4ADB56C1.8020103@domain.hid>
Content-Type: text/plain
Date: Tue, 20 Oct 2009 12:00:54 +0200
Message-Id: <1256032854.2862.117.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Native: Fixing auto-cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2009-10-18 at 19:56 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Sun, 2009-10-18 at 14:54 +0200, Jan Kiszka wrote:
> >> Philippe Gerum wrote:
> >>> On Fri, 2009-10-16 at 19:08 +0200, Jan Kiszka wrote:
> >>>> Hi,
> >>>>
> >>>> our automatic object cleanup on process termination is "slightly" broken
> >>>> for the native skin. The inline and macro magic behind
> >>>> __native_*_flush_rq() blindly calls rt_*_delete(), but that's not
> >>>> correct for mutexes (we can leak memory and/or corrupt the system heap),
> >>>> queues and heaps (we may leak shared heaps).
> >>> Please elaborate regarding both queues and heaps (scenario).
> >> Master creates heap, slave binds to it, master wants to terminate (or is
> >> killed, doesn't matter), heap cannot be released as the slave is still
> >> bound to it, slave terminates but heap object is still reserved on the
> >> main heap => memory leak (just confirmed with a test case).
> > 
> > This fixes it:
> > 
> > diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
> > index 0a24735..0fcb3c2 100644
> > --- a/ksrc/skins/native/heap.c
> > +++ b/ksrc/skins/native/heap.c
> > @@ -340,6 +340,11 @@ static void __heap_post_release(struct xnheap *h)
> >  		xnpod_schedule();
> >  
> 
> + xeno_mark_deleted(heap);
> 

Actually, we need more than this:

diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
index 0a24735..5d43fa7 100644
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -323,6 +323,7 @@ int rt_heap_create(RT_HEAP *heap, const char *name, size_t heapsize, int mode)
 static void __heap_post_release(struct xnheap *h)
 {
 	RT_HEAP *heap = container_of(h, RT_HEAP, heap_base);
+	int resched;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -332,14 +333,24 @@ static void __heap_post_release(struct xnheap *h)
 	if (heap->handle)
 		xnregistry_remove(heap->handle);
 
-	if (xnsynch_destroy(&heap->synch_base) == XNSYNCH_RESCHED)
+	xeno_mark_deleted(heap);
+
+	resched = xnsynch_destroy(&heap->synch_base);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	if (heap->cpid) {
+		heap->cpid = 0;
+		xnfree(heap);
+	}
+#endif
+	if (resched)
 		/*
 		 * Some task has been woken up as a result of the
 		 * deletion: reschedule now.
 		 */
 		xnpod_schedule();
-
-	xnlock_put_irqrestore(&nklock, s);
 }
 
 /**
@@ -404,7 +415,7 @@ int rt_heap_delete_inner(RT_HEAP *heap, void __user *mapaddr)
 
 	/*
 	 * The heap descriptor has been marked as deleted before we
-	 * released the superlock thus preventing any sucessful
+	 * released the superlock thus preventing any successful
 	 * subsequent calls of rt_heap_delete(), so now we can
 	 * actually destroy it safely.
 	 */
diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
index 527bde8..35e292b 100644
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -286,6 +286,7 @@ int rt_queue_create(RT_QUEUE *q,
 static void __queue_post_release(struct xnheap *heap)
 {
 	RT_QUEUE *q = container_of(heap, RT_QUEUE, bufpool);
+	int resched;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -295,14 +296,24 @@ static void __queue_post_release(struct xnheap *heap)
 	if (q->handle)
 		xnregistry_remove(q->handle);
 
-	if (xnsynch_destroy(&q->synch_base) == XNSYNCH_RESCHED)
+	xeno_mark_deleted(q);
+
+	resched = xnsynch_destroy(&q->synch_base);
+
+	xnlock_put_irqrestore(&nklock, s);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	if (q->cpid) {
+		q->cpid = 0;
+		xnfree(q);
+	}
+#endif
+	if (resched)
 		/*
-		 * Some task has been woken up as a result of
-		 * the deletion: reschedule now.
+		 * Some task has been woken up as a result of the
+		 * deletion: reschedule now.
 		 */
 		xnpod_schedule();
-
-	xnlock_put_irqrestore(&nklock, s);
 }
 
 /**
@@ -366,7 +377,7 @@ int rt_queue_delete_inner(RT_QUEUE *q, void __user *mapaddr)
 
 	/*
 	 * The queue descriptor has been marked as deleted before we
-	 * released the superlock thus preventing any sucessful
+	 * released the superlock thus preventing any successful
 	 * subsequent calls of rt_queue_delete(), so now we can
 	 * actually destroy the associated heap safely.
 	 */
diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
index 28c720e..a75ed3b 100644
--- a/ksrc/skins/native/syscall.c
+++ b/ksrc/skins/native/syscall.c
@@ -2073,24 +2073,17 @@ static int __rt_queue_delete(struct pt_regs *regs)
 {
 	RT_QUEUE_PLACEHOLDER ph;
 	RT_QUEUE *q;
-	int err;
 
 	if (__xn_safe_copy_from_user(&ph, (void __user *)__xn_reg_arg1(regs),
 				     sizeof(ph)))
 		return -EFAULT;
 
-	q = (RT_QUEUE *)xnregistry_fetch(ph.opaque);
-
-	if (!q)
-		err = -ESRCH;
-	else {
-		/* Callee will check the queue descriptor for validity again. */
-		err = rt_queue_delete_inner(q, (void __user *)ph.mapbase);
-		if (!err && q->cpid)
-			xnfree(q);
-	}
+	q = xnregistry_fetch(ph.opaque);
+	if (q == NULL)
+		return -ESRCH;
 
-	return err;
+	/* Callee will check the queue descriptor for validity again. */
+	return rt_queue_delete_inner(q, (void __user *)ph.mapbase);
 }
 
 /*
@@ -2604,24 +2597,17 @@ static int __rt_heap_delete(struct pt_regs *regs)
 {
 	RT_HEAP_PLACEHOLDER ph;
 	RT_HEAP *heap;
-	int err;
 
 	if (__xn_safe_copy_from_user(&ph, (void __user *)__xn_reg_arg1(regs),
 				     sizeof(ph)))
 		return -EFAULT;
 
-	heap = (RT_HEAP *)xnregistry_fetch(ph.opaque);
-
-	if (!heap)
-		err = -ESRCH;
-	else {
-		/* Callee will check the heap descriptor for validity again. */
-		err = rt_heap_delete_inner(heap, (void __user *)ph.mapbase);
-		if (!err && heap->cpid)
-			xnfree(heap);
-	}
+	heap = xnregistry_fetch(ph.opaque);
+	if (heap == NULL)
+		return -ESRCH;
 
-	return err;
+	/* Callee will check the heap descriptor for validity again. */
+	return rt_heap_delete_inner(heap, (void __user *)ph.mapbase);
 }
 
 /*

> But I still think this approach has too complex (and so far
> undocumented) user-visible semantics and is going the wrong path.
> 

Granted, this is a bit convoluted. This stems from the fact that should
a shared heap deletion fail due to -EBUSY, you have to keep the mapping
alive for other threads sharing the same mm context that the caller, so
that the memory segment does not get wiped away "inadvertently". This is
basically why the last unmapping is done by the nucleus itself, since
all the tested conditions for the deletion to succeed have to be done
from a syscall context in order to preserve atomicity.

However, the only undocumented behavior is that failing to delete a heap
keeps its descriptor alive, thus allowing further bindings to it; which
is basically what a failing rmmod allows for a module for instance.
People can live with this for now.

> >  	xnlock_put_irqrestore(&nklock, s);
> > +
> > +#ifdef CONFIG_XENO_OPT_PERVASIVE
> > +	if (heap->cpid)
> > +		xnfree(heap);
> > +#endif
> >  }
> >  
> >  /**
> > diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
> > index 527bde8..50af544 100644
> > --- a/ksrc/skins/native/queue.c
> > +++ b/ksrc/skins/native/queue.c
> > @@ -303,6 +303,11 @@ static void __queue_post_release(struct xnheap *heap)
> >  		xnpod_schedule();
> >  
> >  	xnlock_put_irqrestore(&nklock, s);
> > +
> > +#ifdef CONFIG_XENO_OPT_PERVASIVE
> > +	if (q->cpid)
> > +		xnfree(q);
> > +#endif
> >  }
> >  
> >  /**
> > 
> >> I'm not sure if that object migration to the global queue helps to some
> >> degree here (it's not really useful due to other problems, will post a
> >> removal patch) - I've build Xenomai support into the kernel...
> >>
> > 
> > This is a last resort action mainly aimed at kernel-based apps, assuming
> > that rmmoding them will ultimately flush the pending objects. We need
> > this.
> 
> Kernel-based apps do not stress this path at all, their objects are
> already in the global queue. Only user-allocated objected can be requeued.
> 

When I'm reading "will post a removal patch", I tend to have a Pavlovian
reaction considering that you want to remove all the global queue
mechanism, which is what I nacked. No objection to stop using it for
userland resources though.

> And that either indicates open issues in the cleanup path (ie. some
> objects may practically never be deleted) or is superfluous as a
> deferred cleanup mechanism will take care (namely the one of the xnheap).
> 
> > 
> > We might want to avoid linking to the global queue whenever the deletion
> > call returns -EBUSY though, assuming that a post-release hook will do
> > the cleanup, but other errors may still happen.
> 
> Even more important: -EIDRM, or we continue to risk serious corruptions.
> Better remove this altogether.
> 

-EBUSY is returned precisely because the heap is still in a sane state;
obviously, if you want to kill the front end descriptor instead, then
-EIDRM would be required, no problem with this. But there is no risk of
corruption today if one uses the internal deletion protocol properly.

> > 
> >>>> I'm in the process of fixing this, but that latter two are tricky. They
> >>>> need user space information (the user space address of the mapping base)
> >>>> for ordinary cleanup, and this is not available otherwise.
> >>>>
> >>>> At the time we are called with our cleanup handler, can we assume that
> >>>> the dying process has already unmapped all its rtheap segments?
> >>> Unfortunately, no. Cleanup is a per-skin action, and the process may be
> >>> bound to more than a single skin, which could turn out as requiring a
> >>> sequence of cleanup calls.
> >>>
> >>> The only thing you may assume is that an attempt to release all memory
> >>> mappings for the dying process will have been done prior to receive the
> >>> cleanup event from the pipeline, but this won't help much in this case.
> >> That's already very helpful!
> >>
> > 
> > Not really, at least this is not relevant to the bug being fixed.
> > Additionally, the release attempt may fail due to pending references.
> 
> For which kind of objects? What kind of references? At least according
> to the docs, there is only the risk of -EBUSY with heaps and queues. All
> other objects terminate properly.

I'm talking bout internal references. The deletion caller has to
maintain a numaps reference on the object it destroys while it makes
sure the deletion may be applied. Most of the logic stems from this.

> 
> > 
> >>> This attempt may fail and be postponed though, hence the deferred
> >>> release callback fired via vmclose.
> >> I already started to look into the release callback thing, but I'm still
> >> scratching my head: Why do you set the callback even on explicit
> >> rt_heap/queue_delete? I mean those that are supposed to fail with -EBUSY
> >> and then to be retried by user land?
> > 
> > Userland could retry, but most of the time it will just bail out and
> > leave this to vmclose.
> > 
> >>  What happens if rt_heap_unbind and
> >> retried rt_heap_delete race?
> >>
> > 
> > A successful final unmapping clears the release handler.
> 
> rt_heap_unbind would trigger the release handler, thus the object
> deletion, and the actual creator would find the object destroyed under
> its feet despite failed deletion is supposed to leave the object intact.
> That's the kind of complex semantics I was referring to.

You seem to be mixing heaps, queues and other objects. As far as those
are concerned, the creator still holds a reference, so unbinding them
would not trigger the release handler.

> 
> Let's get this right: If the creator of a shared semaphore deletes that
> object, it's synchronously removed; anyone trying to use it is informed.
> That's reasonable to expect from heaps and queues as well, IMHO. The
> only exception is the mapped memory of the associated heaps. It must not
> vanish under other users feet. But they will no longer be able to issue
> native commands on those objects.
> 

Yes, we are still discussing the option of invalidating the front-end
object upon deletion, regardless of what has to be done with the backend
resource, fair enough. I agree this is a common pattern, but this is not
immediately required to have a correct behavior.

> > 
> >> Anyway, auto-cleanup of heap and queue must be made none-failing, ie.
> >> the objects have to be discarded, just the heap memory deletion has to
> >> be deferred. I'm digging into this direction, but I'm still wondering if
> >> the none-automatic heap/queue cleanup is safe in its current form.
> >>
> > 
> > This seems largely overkill for the purpose of fixing the leak. Granted,
> > the common pattern would rather be to invalidate the front-end object
> > (heap/queue desc) and schedule a release for the backend one (i.e.
> > shared mem). However, the only impact this has for now is to allow apps
> > to keep an object indefinitely busy by binding to it continuously albeit
> > a deletion request is pending; I don't think this deserves a major
> > change in the cleanup actions at this stage of 2.5. Cleanup stuff
> > between userland and kernel space is prone to regression.
> 
> It's not overkill, it's required to reduce complexity, simplify the
> semantics, and reducing risks of more hidden bugs in yet unstressed
> corner cases. IMHO, -EBUSY on rt_heap/queue_delete is inappropriate.
> 

Well, I can tell you that there are quite a few corner cases you would
face in rewriting the queue/heap cleanup code. I'm not saying this
should not be done, I just won't merge this to 2.5.0 to avoid more
regressions. Let's fix the obvious for now, such as the missing
descriptor deallocation in the post-release callback, and schedule a
global cleanup refactoring for 2.5.1.

> Jan
> 
-- 
Philippe.



