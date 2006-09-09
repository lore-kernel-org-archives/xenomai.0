Subject: Re: [Xenomai-help] max size for pipes and rt-fifos?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1157723967.4992.13.camel@domain.hid>
References: <44FF3A22.5060901@domain.hid> <44FFE509.3090009@domain.hid>
	<4500789C.9070804@domain.hid>  <1157723967.4992.13.camel@domain.hid>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 18:05:17 +0200
Message-Id: <1157817917.5033.19.camel@domain.hid>
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
To: Jeff Webb <jeff.webb@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Fri, 2006-09-08 at 15:59 +0200, Philippe Gerum wrote:
> On Thu, 2006-09-07 at 14:53 -0500, Jeff Webb wrote:
> > Thanks for your input, Jan.
> > 
> > Jan Kiszka wrote:

[...]

> > > Allocation in Xenomai pipes works differently...
> > 
> > Is there some reason the RTAI FIFO emulation is not handled the same way?  I believe the real RTL and RTAI FIFOs are handled like the Xenomai pipes are done now -- using kmalloc or vmalloc:
> >

[...]

> This patch on top of 2.2.2 should fix the leakage. This said, I'm going
> to rework the fifo emulation a bit to get closer to the RTAI behaviour.

The following patch against stock 2.2.2 improves the RTAI fifo
emulation. It reduces the overhead induced by sending highly scattered
data over a short period of time, and basically provides a much saner
implementation.

I'd be interested to have some feedback about this; I plan to change the
data streaming mode of message pipes from the native API the same way.
TIA,

--- include/rtai/fifo.h	(revision 1562)
+++ include/rtai/fifo.h	(working copy)
@@ -26,6 +26,8 @@
 
 #if defined(__KERNEL__) || defined(__XENO_SIM__)
 
+#define RTFIFO_SYNCWAIT  0
+
 typedef struct rt_fifo {
 
     xnholder_t link;		/* !< Link in flush queue. */
@@ -43,7 +45,7 @@
 
     size_t fillsz;		/* !< Bytes written to the buffer.  */
 
-    u_long flushable;		/* !< Flush request flag. */
+    u_long status;		/* !< Status information. */
 
     int (*handler)(unsigned minor); /* !< Input handler. */
 
Index: ksrc/skins/rtai/fifo.c
===================================================================
--- ksrc/skins/rtai/fifo.c	(revision 1562)
+++ ksrc/skins/rtai/fifo.c	(working copy)
@@ -24,42 +24,6 @@
 
 static RT_FIFO __fifo_table[CONFIG_XENO_OPT_PIPE_NRDEV];
 
-static int __fifo_flush_apc;
-
-static DECLARE_XNQUEUE(__fifo_flush_q);
-
-static inline ssize_t __fifo_flush(RT_FIFO * fifo)
-{
-	ssize_t nbytes = fifo->fillsz + sizeof(xnpipe_mh_t);
-	void *buffer = fifo->buffer;
-
-	fifo->buffer = NULL;
-	fifo->fillsz = 0;
-
-	return xnpipe_send(fifo->minor, buffer, nbytes, XNPIPE_NORMAL);
-	/* The buffer will be freed by the output handler. */
-}
-
-static void __fifo_flush_handler(void *cookie)
-{
-	xnholder_t *holder;
-	spl_t s;
-
-	xnlock_get_irqsave(&nklock, s);
-
-	/* Flush all fifos with pending data. */
-
-	while ((holder = getq(&__fifo_flush_q)) != NULL) {
-		RT_FIFO *fifo = link2rtfifo(holder);
-		__clear_bit(0, &fifo->flushable);
-		xnlock_put_irqrestore(&nklock, s);
-		__fifo_flush(fifo);
-		xnlock_get_irqsave(&nklock, s);
-	}
-
-	xnlock_put_irqrestore(&nklock, s);
-}
-
 #define X_FIFO_HANDLER2(handler) ((int (*)(int, ...))(handler))
 
 static int __fifo_exec_handler(int minor,
@@ -82,7 +46,8 @@
 	RT_FIFO *fifo = __fifo_table + minor;
 	int err;
 
-	xnfree(mh);
+	fifo->fillsz = 0;
+	__clear_bit(RTFIFO_SYNCWAIT, &fifo->status);
 
 	if (retval >= 0 &&
 	    fifo->handler != NULL &&
@@ -96,66 +61,96 @@
 {
 	int i;
 
-	__fifo_flush_apc =
-	    rthal_apc_alloc("fifo_flush", &__fifo_flush_handler, NULL);
-
-	for (i = 0; i < CONFIG_XENO_OPT_PIPE_NRDEV; i++) {
+	for (i = 0; i < CONFIG_XENO_OPT_PIPE_NRDEV; i++)
 		inith(&__fifo_table[i].link);
-	}
 
-	if (__fifo_flush_apc < 0)
-		return __fifo_flush_apc;
-
 	return 0;
 }
 
 void __rtai_fifo_pkg_cleanup(void)
 {
-	rthal_apc_free(__fifo_flush_apc);
 }
 
 int rtf_create(unsigned minor, int size)
 {
+	int err, oldsize;
 	RT_FIFO *fifo;
-	int err;
+	void *buffer;
 	spl_t s;
 
 	if (minor >= CONFIG_XENO_OPT_PIPE_NRDEV)
 		return -ENODEV;
 
+	/* <!> We do check for the calling context albeit the original
+	   API doesn't, but we don't want the box to break for
+	   whatever reason, so sanity takes precedence over
+	   compatibility here. */
+
+	if (!xnpod_root_p())
+		return -EPERM;
+
+	if (!size)
+		return -EINVAL;
+
 	fifo = __fifo_table + minor;
 
 	err = xnpipe_connect(minor,
 			     &__fifo_output_handler,
 			     &__fifo_exec_handler, NULL, fifo);
 
+	if (err < 0 && err != -EBUSY)
+	    return err;
+
 	xnlock_get_irqsave(&nklock, s);
 
 	++fifo->refcnt;
 
 	if (err == -EBUSY) {
-		if (fifo->bufsz < size) {
-			/* Resize the fifo on-the-fly if the specified buffer size
-			   for the fifo is larger than the current one; we first
-			   flush any pending output. */
+		/* Resize the fifo on-the-fly if the specified buffer
+		   size is different from the current one. */
 
-			if (__test_and_clear_bit(0, &fifo->flushable)) {
-				removeq(&__fifo_flush_q, &fifo->link);
-				__fifo_flush(fifo);
-			}
-			/* Otherwise, there is no currently allocated buffer. */
-			fifo->bufsz = size;
+		buffer = fifo->buffer;
+		oldsize = fifo->bufsz;
+
+		if (buffer == NULL) /* Conflicting create/resize requests. */
+			goto unlock_and_exit;
+
+		if (oldsize == size) {
+			err = minor;
+			goto unlock_and_exit; /* Same size, nop. */
 		}
 
+		fifo->buffer = NULL;
+		/* We must not keep the nucleus lock while running
+		 * Linux services. */
+		xnlock_put_irqrestore(&nklock, s);
+		xnarch_sysfree(buffer, oldsize);
+		xnlock_get_irqsave(&nklock, s);
+	} else
+		fifo->buffer = NULL;
+
+	xnlock_put_irqrestore(&nklock, s);
+	buffer = xnarch_sysalloc(size + sizeof(xnpipe_mh_t));
+	xnlock_get_irqsave(&nklock, s);
+
+	if (buffer == NULL) {
+		if (!err)
+			/* First open, we need to disconnect upon
+			 * error. Caveat: we still hold the lock while
+			 * flushing the message pipe's input and
+			 * output queues during disconnection. */
+			xnpipe_disconnect(minor);
+
+		--fifo->refcnt;
+		err = -ENOMEM;
 		goto unlock_and_exit;
 	}
 
-	/* <!> We don't pre-allocate the internal buffer unlike the
-	   original API. */
-	fifo->buffer = NULL;
+	err = minor;
+	fifo->buffer = buffer;
 	fifo->bufsz = size;
 	fifo->fillsz = 0;
-	fifo->flushable = 0;
+	fifo->status = 0;
 	fifo->minor = minor;
 	fifo->handler = NULL;
 
@@ -163,18 +158,22 @@
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	return 0;
+	return err;
 }
 
 int rtf_destroy(unsigned minor)
 {
+	int refcnt, err = 0, oldsize;
 	RT_FIFO *fifo;
-	int refcnt;
+	void *buffer;
 	spl_t s;
 
 	if (minor >= CONFIG_XENO_OPT_PIPE_NRDEV)
 		return -ENODEV;
 
+	if (!xnpod_root_p())
+		return -EPERM;
+
 	fifo = __fifo_table + minor;
 
 	xnlock_get_irqsave(&nklock, s);
@@ -182,23 +181,33 @@
 	refcnt = fifo->refcnt;
 
 	if (refcnt == 0)
-		refcnt = -EINVAL;
+		err = -EINVAL;
 	else {
 		if (--refcnt == 0) {
-			if (__test_and_clear_bit(0, &fifo->flushable)) {
-				removeq(&__fifo_flush_q, &fifo->link);
-				xnfree(fifo->buffer);
+			buffer = fifo->buffer;
+			oldsize = fifo->bufsz;
+
+			if (buffer == NULL) { /* Fifo under (re-)construction. */
+				err = -EBUSY;
+				goto unlock_and_exit;
 			}
 
 			xnpipe_disconnect(minor);
+			fifo->refcnt = 0;
+			xnlock_put_irqrestore(&nklock, s);
+			xnarch_sysfree(buffer, oldsize);
+
+			return 0;
 		}
 
 		fifo->refcnt = refcnt;
 	}
 
+unlock_and_exit:
+
 	xnlock_put_irqrestore(&nklock, s);
 
-	return refcnt;
+	return err;
 }
 
 int rtf_get(unsigned minor, void *buf, int count)
@@ -223,6 +232,11 @@
 		goto unlock_and_exit;
 	}
 
+	if (fifo->buffer == NULL) {
+		nbytes = -EBUSY;
+		goto unlock_and_exit;
+	}
+
 	nbytes = xnpipe_recv(minor, &msg, XN_NONBLOCK);
 
 	if (nbytes < 0) {
@@ -256,9 +270,9 @@
 
 int rtf_put(unsigned minor, const void *buf, int count)
 {
-	ssize_t outbytes = 0;
+	ssize_t outbytes;
+	size_t fillptr;
 	RT_FIFO *fifo;
-	size_t n;
 	spl_t s;
 
 	if (minor >= CONFIG_XENO_OPT_PIPE_NRDEV)
@@ -273,52 +287,37 @@
 		goto unlock_and_exit;
 	}
 
-	while (count > 0) {
-		if (count >= fifo->bufsz - fifo->fillsz)
-			n = fifo->bufsz - fifo->fillsz;
-		else
-			n = count;
+	if (fifo->buffer == NULL) {
+		outbytes = -EBUSY;
+		goto unlock_and_exit;
+	}
 
-		if (n == 0) {
-			ssize_t err = __fifo_flush(fifo);
+	if (count > fifo->bufsz - fifo->fillsz)
+		outbytes = fifo->bufsz - fifo->fillsz;
+	else
+		outbytes = count;
 
-			if (__test_and_clear_bit(0, &fifo->flushable))
-				removeq(&__fifo_flush_q, &fifo->link);
+	if (outbytes > 0) {
+		fillptr = fifo->fillsz;
+		fifo->fillsz += outbytes;
 
-			if (err < 0) {
-				outbytes = err;
-				goto unlock_and_exit;
-			}
+		xnlock_put_irqrestore(&nklock, s);
 
-			continue;
-		}
+		memcpy(xnpipe_m_data(fifo->buffer) + fillptr,
+		       (caddr_t) buf, outbytes);
 
-		if (fifo->buffer == NULL) {
-			fifo->buffer =
-			    (xnpipe_mh_t *)xnmalloc(fifo->bufsz +
-						    sizeof(xnpipe_mh_t));
+		xnlock_get_irqsave(&nklock, s);
 
-			if (fifo->buffer == NULL) {
-				outbytes = -ENOMEM;
-				goto unlock_and_exit;
-			}
-
-			inith(&fifo->buffer->link);
-			fifo->buffer->size = count;
+		if (__test_and_set_bit(RTFIFO_SYNCWAIT, &fifo->status))
+			outbytes = xnpipe_send_more(fifo->minor, fifo->buffer, outbytes);
+		else {
+			outbytes = xnpipe_send(fifo->minor, fifo->buffer,
+					       outbytes + sizeof(xnpipe_mh_t), XNPIPE_NORMAL);
+			if (outbytes > 0)
+				outbytes -= sizeof(xnpipe_mh_t);
 		}
-
-		memcpy(xnpipe_m_data(fifo->buffer) + fifo->fillsz,
-		       (caddr_t) buf + outbytes, n);
-		fifo->fillsz += n;
-		outbytes += n;
-		count -= n;
 	}
 
-	if (fifo->fillsz > 0 && !__test_and_set_bit(0, &fifo->flushable)) {
-		appendq(&__fifo_flush_q, &fifo->link);
-		rthal_apc_schedule(__fifo_flush_apc);
-	}
-
       unlock_and_exit:
 
 	xnlock_put_irqrestore(&nklock, s);
@@ -329,24 +328,13 @@
 int rtf_reset(unsigned minor)
 {
 	RT_FIFO *fifo;
-	spl_t s;
 
 	if (minor >= CONFIG_XENO_OPT_PIPE_NRDEV)
 		return -ENODEV;
 
 	fifo = __fifo_table + minor;
+	fifo->fillsz = 0;
 
-	xnlock_get_irqsave(&nklock, s);
-
-	if (__test_and_clear_bit(0, &fifo->flushable)) {
-		removeq(&__fifo_flush_q, &fifo->link);
-		xnfree(fifo->buffer);
-		fifo->buffer = NULL;
-		fifo->fillsz = 0;
-	}
-
-	xnlock_put_irqrestore(&nklock, s);
-
 	return 0;
 }
 
Index: include/nucleus/pipe.h
===================================================================
--- include/nucleus/pipe.h	(revision 1562)
+++ include/nucleus/pipe.h	(working copy)
@@ -130,6 +130,10 @@
 		    size_t size,
 		    int flags);
 
+ssize_t xnpipe_send_more(int minor,
+			 struct xnpipe_mh *mh,
+			 ssize_t size);
+
 ssize_t xnpipe_recv(int minor,
 		    struct xnpipe_mh **pmh,
 		    xnticks_t timeout);
Index: ksrc/nucleus/pipe.c
===================================================================
--- ksrc/nucleus/pipe.c	(revision 1562)
+++ ksrc/nucleus/pipe.c	(working copy)
@@ -306,6 +306,12 @@
 
 	__clrbits(state->status, XNPIPE_KERN_CONN);
 
+	if (state->output_handler != NULL) {
+		while ((holder = getq(&state->outq)) != NULL)
+			state->output_handler(minor, link2mh(holder),
+					      -EPIPE, state->cookie);
+	}
+
 	if (testbits(state->status, XNPIPE_USER_CONN)) {
 		while ((holder = getq(&state->inq)) != NULL) {
 			if (state->input_handler != NULL)
@@ -315,12 +321,6 @@
 				xnfree(link2mh(holder));
 		}
 
-		if (state->output_handler != NULL) {
-			while ((holder = getq(&state->outq)) != NULL)
-				state->output_handler(minor, link2mh(holder),
-						      -EPIPE, state->cookie);
-		}
-
 		if (xnsynch_destroy(&state->synchbase) == XNSYNCH_RESCHED)
 			xnpod_schedule();
 
@@ -369,11 +369,6 @@
 		return -EBADF;
 	}
 
-	if (!testbits(state->status, XNPIPE_USER_CONN)) {
-		xnlock_put_irqrestore(&nklock, s);
-		return -EPIPE;
-	}
-
 	inith(xnpipe_m_link(mh));
 	xnpipe_m_size(mh) = size - sizeof(*mh);
 	state->ionrd += xnpipe_m_size(mh);
@@ -383,6 +378,11 @@
 	else
 		appendq(&state->outq, xnpipe_m_link(mh));
 
+	if (!testbits(state->status, XNPIPE_USER_CONN)) {
+		xnlock_put_irqrestore(&nklock, s);
+		return (ssize_t) size;
+	}
+
 	if (testbits(state->status, XNPIPE_USER_WREAD)) {
 		/* Wake up the userland thread waiting for input
 		   from the kernel side. */
@@ -403,6 +403,34 @@
 	return (ssize_t) size;
 }
 
+ssize_t xnpipe_send_more(int minor, struct xnpipe_mh *mh, ssize_t size)
+{
+	xnpipe_state_t *state;
+	spl_t s;
+
+	if (minor < 0 || minor >= XNPIPE_NDEVS)
+		return -ENODEV;
+
+	if (size < 0)
+		return -EINVAL;
+
+	state = &xnpipe_states[minor];
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (!testbits(state->status, XNPIPE_KERN_CONN)) {
+		xnlock_put_irqrestore(&nklock, s);
+		return -EBADF;
+	}
+
+	xnpipe_m_size(mh) += size;
+	state->ionrd += size;
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return (ssize_t) size;
+}
+
 ssize_t xnpipe_recv(int minor, struct xnpipe_mh **pmh, xnticks_t timeout)
 {
 	xnpipe_state_t *state;
@@ -640,10 +668,11 @@
 			   char *buf, size_t count, loff_t *ppos)
 {
 	xnpipe_state_t *state = (xnpipe_state_t *)file->private_data;
+	size_t nbytes, inbytes;
 	struct xnpipe_mh *mh;
+	int sigpending, err;
 	xnholder_t *holder;
-	int sigpending;
-	ssize_t ret;
+	ssize_t ret = 0;
 	spl_t s;
 
 	if (!access_ok(VERIFY_WRITE, buf, count))
@@ -679,30 +708,51 @@
 	}
 
 	if (mh) {
-		xnpipe_io_handler *handler = state->output_handler;
-		void *cookie = state->cookie;
+		nbytes = xnpipe_m_size(mh); /* Cannot be zero */
+		inbytes = 0;
 
-		ret = (ssize_t) xnpipe_m_size(mh);	/* Cannot be zero */
-		state->ionrd -= ret;
+		/*
+		 * We allow more data to be appended to the current
+		 * message bucket while its contents is being copied
+		 * to the user buffer, therefore, we need to loop
+		 * until:
+		 * 1) all the data has been copied,
+		 * 2) we consumed the user buffer space entirely.
+		 */
 
-		xnlock_put_irqrestore(&nklock, s);
+		do {
+			if (inbytes <= count) {
+				xnlock_put_irqrestore(&nklock, s);
+				/* More data could be appended while doing this: */
+				err = __copy_to_user(buf + inbytes, xnpipe_m_data(mh) + inbytes, nbytes);
+				xnlock_get_irqsave(&nklock, s);
+				if (err) {
+					ret = -EFAULT;
+					break;
+				}
+				inbytes += nbytes;
+				nbytes = xnpipe_m_size(mh) - inbytes;
+			} else {
+				/* Return buffer is too small - message is lost. */
+				ret = -ENOBUFS;
+				break;
+			}
+		} while(nbytes > 0);
 
-		if (ret <= count) {
-			if (__copy_to_user(buf, xnpipe_m_data(mh), ret))
-				ret = -EFAULT;
-		} else
-			/* Return buffer is too small - message is lost. */
-			ret = -ENOBUFS;
+		if (ret < 0)
+			inbytes = xnpipe_m_size(mh);
+		else
+			ret = (ssize_t) inbytes;
 
-		if (handler != NULL)
-			ret =
-			    handler(xnminor_from_state(state), mh, ret, cookie);
-	} else {		/* Closed by peer. */
+		state->ionrd -= inbytes;
 
-		xnlock_put_irqrestore(&nklock, s);
-		ret = 0;
+		if (state->output_handler != NULL)
+			ret = state->output_handler(xnminor_from_state(state),
+						    mh, ret, state->cookie);
 	}
 
+	xnlock_put_irqrestore(&nklock, s);
+
 	return ret;
 }
 
@@ -999,6 +1049,7 @@
 EXPORT_SYMBOL(xnpipe_connect);
 EXPORT_SYMBOL(xnpipe_disconnect);
 EXPORT_SYMBOL(xnpipe_send);
+EXPORT_SYMBOL(xnpipe_send_more);
 EXPORT_SYMBOL(xnpipe_recv);
 EXPORT_SYMBOL(xnpipe_inquire);
 EXPORT_SYMBOL(xnpipe_setup);

-- 
Philippe.



