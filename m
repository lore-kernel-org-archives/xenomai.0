Message-ID: <43825E4C.4030002@domain.hid>
Date: Tue, 22 Nov 2005 00:54:52 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] define your own pipe heap
References: <4382201C.8040503@domain.hid>
In-Reply-To: <4382201C.8040503@domain.hid>
Content-Type: multipart/mixed; boundary="------------010203020905010009080801"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------010203020905010009080801
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Hi there,
> 
> yea, I also want to join this endless pipe discussion! ;)
> 
> We ran into troubles here due to large messages that should be sent via
> native pipes. Large means larger than the default message heap, the
> system heap, of the pipe subsystem so far. That raised the question why
> we should not provide some interface (and the required internal patches)
> to maintain per-pipe heaps. At least optional. This would allow to
> create pipe channels with even some megabyte space as we used them under
> RTAI.
> 
> I would provide the required patches, but I'm not yet sure if we better
> extend rt_pipe_create with an additional parameter bufsize (0 = default,
> i.e. system heap, 0 > allocate per kmalloc or vmalloc) or if we add
> another function like rt_pipe_bufsize to allocate a dedicated heap after
> creation.
> 

A patch says more than thousand words. ;)

As a first approach, I picked the second variant and implemented a new
function called rt_pipe_setpool. I also had to extend rt_pipe_alloc and
rt_pipe_free so that the right pool is used by them.

Note, the patch is yet untested and is also lacking documentation. It's
just intended to gain some feedback.

Jan

--------------010203020905010009080801
Content-Type: text/x-patch;
 name="rt_pipe_setpool.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_pipe_setpool.patch"

Index: skins/native/pipe.h
===================================================================
--- skins/native/pipe.h	(Revision 165)
+++ skins/native/pipe.h	(Arbeitskopie)
@@ -37,6 +37,8 @@
 
 #ifdef __KERNEL__
 
+#include <nucleus/heap.h>
+
 #define XENO_PIPE_MAGIC 0x55550202
 
 typedef xnpipe_mh_t RT_PIPE_MSG;
@@ -57,6 +59,10 @@
 
     RT_PIPE_MSG *buffer;	/* !< Buffer used in byte stream mode. */
 
+    xnheap_t *bufpool;	/* !< Current buffer pool. */
+
+    xnheap_t privpool;	/* !< Private buffer pool. */
+
     size_t fillsz;		/* !< Bytes written to the buffer.  */
 
     u_long flushable;		/* !< Flush request flag. */
@@ -87,6 +93,9 @@
 		   const char *name,
 		   int minor);
 
+int rt_pipe_setpool(RT_PIPE *pipe,
+                    size_t poolsize);
+
 int rt_pipe_delete(RT_PIPE *pipe);
 
 ssize_t rt_pipe_read(RT_PIPE *pipe,
@@ -113,9 +122,11 @@
 		     size_t size,
 		     int mode);
 
-RT_PIPE_MSG *rt_pipe_alloc(size_t size);
+RT_PIPE_MSG *rt_pipe_alloc(RT_PIPE *pipe,
+                           size_t size);
 
-int rt_pipe_free(RT_PIPE_MSG *msg);
+int rt_pipe_free(RT_PIPE *pipe,
+                 RT_PIPE_MSG *msg);
 
 ssize_t rt_pipe_flush(RT_PIPE *pipe);
 
Index: skins/native/syscall.c
===================================================================
--- skins/native/syscall.c	(Revision 165)
+++ skins/native/syscall.c	(Arbeitskopie)
@@ -3332,7 +3332,7 @@
     /* Zero-sized messages are allowed, so we still need to free the
        message buffer even if no data copy took place. */
 
-    rt_pipe_free(msg);
+    rt_pipe_free(pipe,msg);
 
     return err;
 }
@@ -3374,7 +3374,7 @@
     if (!__xn_access_ok(curr,VERIFY_READ,__xn_reg_arg2(regs),size))
 	return -EFAULT;
 
-    msg = rt_pipe_alloc(size);
+    msg = rt_pipe_alloc(pipe,size);
 	
     if (!msg)
 	return -ENOMEM;
@@ -3386,7 +3386,7 @@
     if (err != size)
 	/* If the operation failed, we need to free the message buffer
 	   by ourselves. */
-	rt_pipe_free(msg);
+	rt_pipe_free(pipe,msg);
 
     return err;
 }
@@ -3436,7 +3436,7 @@
 	}
     else
 	{
-	msg = rt_pipe_alloc(size);
+	msg = rt_pipe_alloc(pipe,size);
 	
 	if (!msg)
 	    return -ENOMEM;
@@ -3449,7 +3449,7 @@
     err = rt_pipe_stream(pipe,buf,size);
 
     if (msg)
-	rt_pipe_free(msg);
+	rt_pipe_free(pipe,msg);
 
     return err;
 }
Index: skins/native/pipe.c
===================================================================
--- skins/native/pipe.c	(Revision 165)
+++ skins/native/pipe.c	(Arbeitskopie)
@@ -50,8 +50,6 @@
 #include <native/registry.h>
 #include <native/pipe.h>
 
-static xnheap_t *__pipe_heap = &kheap;
-
 static int __pipe_flush_apc;
 
 static DECLARE_XNQUEUE(__pipe_flush_q);
@@ -83,6 +81,14 @@
 
 #endif /* CONFIG_XENO_NATIVE_EXPORT_REGISTRY */
 
+static void __pipe_flush_pool (xnheap_t *heap,
+                               void *poolmem,
+                               u_long poolsize,
+                               void *cookie)
+{
+    xnarch_sysfree(poolmem,poolsize);
+}
+
 static inline ssize_t __pipe_flush (RT_PIPE *pipe)
 
 {
@@ -122,8 +128,10 @@
 				   size_t size,
 				   void *cookie)
 {
+    RT_PIPE *pipe = (RT_PIPE *)cookie;
+
     /* Allocate memory for the incoming message. */
-    return xnheap_alloc(__pipe_heap,size);
+    return xnheap_alloc(pipe->bufpool,size);
 }
 
 static int __pipe_output_handler (int bminor,
@@ -131,8 +139,10 @@
 				  int retval,
 				  void *cookie)
 {
+    RT_PIPE *pipe = (RT_PIPE *)cookie;
+
     /* Free memory from output/discarded message. */
-    xnheap_free(__pipe_heap,mh);
+    xnheap_free(pipe->bufpool,mh);
     return retval;
 }
 
@@ -240,6 +250,7 @@
 	return -EPERM;
 
     pipe->buffer = NULL;
+    pipe->bufpool = &kheap;
     pipe->fillsz = 0;
     pipe->flushable = 0;
     pipe->handle = 0;    /* i.e. (still) unregistered pipe. */
@@ -289,6 +300,38 @@
     return err;
 }
 
+int rt_pipe_setpool(RT_PIPE *pipe,
+                    size_t poolsize)
+{
+    int err;
+    void *poolmem;
+
+    if (!xnpod_root_p())
+	return -EPERM;
+
+    if ((poolsize == 0) || (pipe->bufpool == &pipe->privpool))
+	return -EINVAL;
+
+    poolmem = xnarch_sysalloc(poolsize);
+
+    if (!poolmem)
+	return -ENOMEM;
+
+    err = xnheap_init(&pipe->privpool,
+                      poolmem,
+                      poolsize,
+                      PAGE_SIZE); /* Use natural page size */
+    if (err)
+	{
+	xnarch_sysfree(poolmem,poolsize);
+	return err;
+	}
+
+    pipe->bufpool = &pipe->privpool;
+
+    return 0;
+}
+
 /**
  * @fn int rt_pipe_delete(RT_PIPE *pipe)
  *
@@ -337,14 +380,15 @@
     if (!pipe)
 	{
 	err = xeno_handle_error(pipe,XENO_PIPE_MAGIC,RT_PIPE);
-	goto unlock_and_exit;
+	xnlock_put_irqrestore(&nklock,s);
+	return err;
 	}
 
     if (__test_and_clear_bit(0,&pipe->flushable))
 	{
 	/* Purge data waiting for flush. */
 	removeq(&__pipe_flush_q,&pipe->link);
-	rt_pipe_free(pipe->buffer);
+	rt_pipe_free(pipe,pipe->buffer);
 	}
 
     err = xnpipe_disconnect(pipe->minor);
@@ -356,10 +400,11 @@
 
     xeno_mark_deleted(pipe);
 
- unlock_and_exit:
-
     xnlock_put_irqrestore(&nklock,s);
 
+    if (pipe->bufpool == &pipe->privpool)
+	xnheap_destroy(&pipe->privpool,__pipe_flush_pool,NULL);
+
     return err;
 }
 
@@ -572,7 +617,7 @@
     /* Zero-sized messages are allowed, so we still need to free the
        message buffer even if no data copy took place. */
 
-    rt_pipe_free(msg);
+    rt_pipe_free(pipe,msg);
 
     return nbytes;
 }
@@ -767,7 +812,7 @@
 	/* Try flushing the streaming buffer in any case. */
 	return rt_pipe_send(pipe,NULL,0,mode);
 
-    msg = rt_pipe_alloc(size);
+    msg = rt_pipe_alloc(pipe,size);
 	
     if (!msg)
 	return -ENOMEM;
@@ -779,7 +824,7 @@
     if (nbytes != size)
 	/* If the operation failed, we need to free the message buffer
 	   by ourselves. */
-	rt_pipe_free(msg);
+	rt_pipe_free(pipe,msg);
 
     return nbytes;
 }
@@ -886,7 +931,7 @@
 
 	if (pipe->buffer == NULL)
 	    {
-	    pipe->buffer = rt_pipe_alloc(CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ);
+	    pipe->buffer = rt_pipe_alloc(pipe,CONFIG_XENO_OPT_NATIVE_PIPE_BUFSZ);
 
 	    if (pipe->buffer == NULL)
 		{
@@ -984,7 +1029,7 @@
 }
 
 /**
- * @fn RT_PIPE_MSG *rt_pipe_alloc(size_t size)
+ * @fn RT_PIPE_MSG *rt_pipe_alloc(RT_PIPE *pipe,size_t size)
  *
  * @brief Allocate a message pipe buffer.
  *
@@ -1010,10 +1055,11 @@
  * Rescheduling: never.
  */
 
-RT_PIPE_MSG *rt_pipe_alloc (size_t size)
+RT_PIPE_MSG *rt_pipe_alloc (RT_PIPE *pipe,
+                            size_t size)
 
 {
-    RT_PIPE_MSG *msg = (RT_PIPE_MSG *)xnheap_alloc(__pipe_heap,size + sizeof(RT_PIPE_MSG));
+    RT_PIPE_MSG *msg = (RT_PIPE_MSG *)xnheap_alloc(pipe->bufpool,size + sizeof(RT_PIPE_MSG));
 
     if (msg)
 	{
@@ -1025,7 +1071,7 @@
 }
 
 /**
- * @fn int rt_pipe_free(RT_PIPE_MSG *msg)
+ * @fn int rt_pipe_free(RT_PIPE *pipe,RT_PIPE_MSG *msg)
  *
  * @brief Free a message pipe buffer.
  *
@@ -1049,9 +1095,9 @@
  * Rescheduling: never.
  */
 
-int rt_pipe_free (RT_PIPE_MSG *msg)
+int rt_pipe_free (RT_PIPE *pipe,RT_PIPE_MSG *msg)
 {
-    return xnheap_free(__pipe_heap,msg);
+    return xnheap_free(pipe->bufpool,msg);
 }
 
 /*@}*/
Index: testsuite/klatency/latency-module.c
===================================================================
--- testsuite/klatency/latency-module.c	(Revision 165)
+++ testsuite/klatency/latency-module.c	(Arbeitskopie)
@@ -83,7 +83,7 @@
 	maxjitter = maxj;
 	avgjitter = sumj / sample_count;
 
-	msg = rt_pipe_alloc(sizeof(struct latency_stat));
+	msg = rt_pipe_alloc(&pipe,sizeof(struct latency_stat));
 
 	if (!msg)
 	    {
@@ -103,7 +103,7 @@
 	   ourselves. */
 
 	if (rt_pipe_send(&pipe,msg,sizeof(*s),0) != sizeof(*s))
-	    rt_pipe_free(msg);
+	    rt_pipe_free(&pipe,msg);
 	}
 }
 

--------------010203020905010009080801--

