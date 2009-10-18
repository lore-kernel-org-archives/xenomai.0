From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4ADB100B.1060300@domain.hid>
References: <4AD8A87C.4040706@domain.hid>
	<1255799737.2862.15.camel@domain.hid>  <4ADB100B.1060300@domain.hid>
Content-Type: text/plain
Date: Sun, 18 Oct 2009 18:48:44 +0200
Message-Id: <1255884524.2862.77.camel@domain.hid>
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

On Sun, 2009-10-18 at 14:54 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Fri, 2009-10-16 at 19:08 +0200, Jan Kiszka wrote:
> >> Hi,
> >>
> >> our automatic object cleanup on process termination is "slightly" broken
> >> for the native skin. The inline and macro magic behind
> >> __native_*_flush_rq() blindly calls rt_*_delete(), but that's not
> >> correct for mutexes (we can leak memory and/or corrupt the system heap),
> >> queues and heaps (we may leak shared heaps).
> > 
> > Please elaborate regarding both queues and heaps (scenario).
> 
> Master creates heap, slave binds to it, master wants to terminate (or is
> killed, doesn't matter), heap cannot be released as the slave is still
> bound to it, slave terminates but heap object is still reserved on the
> main heap => memory leak (just confirmed with a test case).

This fixes it:

diff --git a/ksrc/skins/native/heap.c b/ksrc/skins/native/heap.c
index 0a24735..0fcb3c2 100644
--- a/ksrc/skins/native/heap.c
+++ b/ksrc/skins/native/heap.c
@@ -340,6 +340,11 @@ static void __heap_post_release(struct xnheap *h)
 		xnpod_schedule();
 
 	xnlock_put_irqrestore(&nklock, s);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	if (heap->cpid)
+		xnfree(heap);
+#endif
 }
 
 /**
diff --git a/ksrc/skins/native/queue.c b/ksrc/skins/native/queue.c
index 527bde8..50af544 100644
--- a/ksrc/skins/native/queue.c
+++ b/ksrc/skins/native/queue.c
@@ -303,6 +303,11 @@ static void __queue_post_release(struct xnheap *heap)
 		xnpod_schedule();
 
 	xnlock_put_irqrestore(&nklock, s);
+
+#ifdef CONFIG_XENO_OPT_PERVASIVE
+	if (q->cpid)
+		xnfree(q);
+#endif
 }
 
 /**

> 
> I'm not sure if that object migration to the global queue helps to some
> degree here (it's not really useful due to other problems, will post a
> removal patch) - I've build Xenomai support into the kernel...
> 

This is a last resort action mainly aimed at kernel-based apps, assuming
that rmmoding them will ultimately flush the pending objects. We need
this.

We might want to avoid linking to the global queue whenever the deletion
call returns -EBUSY though, assuming that a post-release hook will do
the cleanup, but other errors may still happen.

> > 
> >> I'm in the process of fixing this, but that latter two are tricky. They
> >> need user space information (the user space address of the mapping base)
> >> for ordinary cleanup, and this is not available otherwise.
> >>
> >> At the time we are called with our cleanup handler, can we assume that
> >> the dying process has already unmapped all its rtheap segments?
> > 
> > Unfortunately, no. Cleanup is a per-skin action, and the process may be
> > bound to more than a single skin, which could turn out as requiring a
> > sequence of cleanup calls.
> > 
> > The only thing you may assume is that an attempt to release all memory
> > mappings for the dying process will have been done prior to receive the
> > cleanup event from the pipeline, but this won't help much in this case.
> 
> That's already very helpful!
> 

Not really, at least this is not relevant to the bug being fixed.
Additionally, the release attempt may fail due to pending references.

> > This attempt may fail and be postponed though, hence the deferred
> > release callback fired via vmclose.
> 
> I already started to look into the release callback thing, but I'm still
> scratching my head: Why do you set the callback even on explicit
> rt_heap/queue_delete? I mean those that are supposed to fail with -EBUSY
> and then to be retried by user land?

Userland could retry, but most of the time it will just bail out and
leave this to vmclose.

>  What happens if rt_heap_unbind and
> retried rt_heap_delete race?
> 

A successful final unmapping clears the release handler.

> Anyway, auto-cleanup of heap and queue must be made none-failing, ie.
> the objects have to be discarded, just the heap memory deletion has to
> be deferred. I'm digging into this direction, but I'm still wondering if
> the none-automatic heap/queue cleanup is safe in its current form.
> 

This seems largely overkill for the purpose of fixing the leak. Granted,
the common pattern would rather be to invalidate the front-end object
(heap/queue desc) and schedule a release for the backend one (i.e.
shared mem). However, the only impact this has for now is to allow apps
to keep an object indefinitely busy by binding to it continuously albeit
a deletion request is pending; I don't think this deserves a major
change in the cleanup actions at this stage of 2.5. Cleanup stuff
between userland and kernel space is prone to regression.

> Jan
> 
> PS: Mutex cleanup leak is fixed now.
> 

Nice. Thanks.

-- 
Philippe.



