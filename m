Subject: Re: [Xenomai-help] problems using rt_queue_alloc: returns 0
	although enough memory available (xenomai 2.2.3)
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <457820B7.3030603@domain.hid>
References: <OF0E0E01F1.79314A79-ONC125723D.002F4B91-C125723D.004B0598@domain.hid>
	<457820B7.3030603@domain.hid>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 19:12:49 +0100
Message-Id: <1165601570.9091.42.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org, juergen.lanner@domain.hid

On Thu, 2006-12-07 at 15:09 +0100, Jan Kiszka wrote:
> juergen.lanner@domain.hid wrote:
> > Hi gentlemen!
> > 
> > I had a problem with real time queues recently and want to know if I
> > understood something wrong or if it is a real problem.
> > 
> > The problem was that I couldn't alloc enough memory for my message in the
> > internal buffer before sending it.
> > 
> > I tried to bring some light into the problem by printing the data I get
> > from rt_queue_inquire to see the queue's state in more detail.
> > But this seems ok (at least from my point of view)
> > 
> > Did anybody see the problem as well? What could be the reason?
> 
> I do not yet fully understand your problem (a self-contained demo
> program can help to explain a scenario better). But if you are trying to
> find out how many memory is still free in a queue-pool, rt_queue_inquire
> will not help you. It always returns the full pool size without any
> message allocated.
> 
> Maybe we could enhance this interface by the currently available pool
> memory if this is desired.
> 

I think it is. Returning the pool size without giving back any hint
about the currently available amount of memory in this pool is
pointless.

Juergen, the following patch returns the _used_ amount, so you should be
able to figure out the remaining memory easily. Applies against 2.3-rc
and will be committed there since it's a fairly trivial change which
fills a real gap; you should be able to backport it easily to 2.2.x.

===================================================================
--- include/native/queue.h	(revision 1924)
+++ include/native/queue.h	(working copy)
@@ -49,8 +49,10 @@
 
     size_t qlimit;		/* !< Queue limit. */
 
-    size_t poolsize;		/* !< Size of pool memory. */
+    size_t poolsize;		/* !< Size of pool memory (in bytes). */
 
+    size_t usedmem;		/* !< Amount of pool memory used (in bytes). */
+
     char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
 
 } RT_QUEUE_INFO;
Index: ksrc/skins/native/queue.c
===================================================================
--- ksrc/skins/native/queue.c	(revision 1924)
+++ ksrc/skins/native/queue.c	(working copy)
@@ -56,9 +56,10 @@
 	int len;
 	spl_t s;
 
-	p += sprintf(p, "type=%s:poolsz=%lu:limit=%d:mcount=%d\n",
+	p += sprintf(p, "type=%s:poolsz=%lu:usedmem=%lu:limit=%d:mcount=%d\n",
 		     q->mode & Q_SHARED ? "shared" : "local",
-		     xnheap_usable_mem(&q->bufpool), q->qlimit, countq(&q->pendq));
+		     xnheap_usable_mem(&q->bufpool), xnheap_used_mem(&q->bufpool),
+		     q->qlimit, countq(&q->pendq));
 
 	xnlock_get_irqsave(&nklock, s);
 
@@ -987,6 +988,7 @@
 	info->nmessages = countq(&q->pendq);
 	info->qlimit = q->qlimit;
 	info->poolsize = xnheap_usable_mem(&q->bufpool);
+	info->usedmem = xnheap_used_mem(&q->bufpool);
 	info->mode = q->mode;
 
       unlock_and_exit:

-- 
Philippe.



