Message-ID: <48637FC1.2050708@domain.hid>
Date: Thu, 26 Jun 2008 13:38:41 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <406CC9939904F143B9D42CEEA3E56E563331EA@oab1mx1.oneaccess.intra>
In-Reply-To: <406CC9939904F143B9D42CEEA3E56E563331EA@oab1mx1.oneaccess.intra>
Content-Type: multipart/mixed; boundary="------------010601060209080804090101"
Subject: Re: [Xenomai-help] help: pipe + event flag group (or
 other	synchronisation mechanism
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
To: Filip Van Rillaer <Filip.VanRillaer@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------010601060209080804090101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Filip Van Rillaer wrote:
> Hello, 
> 
> Our application is written with some kind of super-loop scheduling : we
> have many drivers that call rt_event_signal (when data have been written
> to the hardware or new data are available to be processed) and 1 task
> that is calling rt_event_wait. After receiving an event, the superloop
> task is then reading/writing the data from/to the appropriate
> driver. Those calls to the drivers must never block (except to some
> locking to protect the consistency of data-structures) to garantuee the
> real-time behaviour of the application.
> Now we want to communicate with the Linux-domain and thought we have to
> use the Xenomai pipe-object for that purpose.
> 
> How can the superloop task in Xenomai receive an event from
> the pipe-object when data are available to be read/written (so
> without already reading the data)?
> 
> The ideal solution would be if one can ask the pipe-driver to call a
> user-callback function when there is a change in the status (read/write)
> or an equivalent system to the EPOLL interface (from the uclinux domain).

There is a mechanism already available from the core message pipe
implementation, but it is not exported by the native API interface.

So you have two options:

- ask user-space to notify kernel space explicitly _after_ each sending; for
that you may even use rt_event_signal() from a plain Linux task to send a
specialized event to your superloop.

- try the attached patch, which exports the needed bits. It is called
rt_pipe_monitor(). Absolutely untested.

> 
> Best regards,
> Filip.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

--------------010601060209080804090101
Content-Type: text/x-diff;
 name="async-pipe-monitoring.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="async-pipe-monitoring.patch"

Index: include/native/pipe.h
===================================================================
--- include/native/pipe.h	(revision 3989)
+++ include/native/pipe.h	(working copy)
@@ -32,6 +32,9 @@
 
 #define P_MINOR_AUTO	XNPIPE_MINOR_AUTO
 
+#define P_EVENT_INPUT	1
+#define P_EVENT_CLOSE	2
+
 typedef struct rt_pipe_placeholder {
     xnhandle_t opaque;
 } RT_PIPE_PLACEHOLDER;
@@ -64,6 +67,8 @@
 
     xnheap_t *bufpool;         /* !< Current buffer pool. */
 
+    void (*monitor)(struct rt_pipe *pipe, int event);
+
     xnheap_t privpool;         /* !< Private buffer pool. */
 
     size_t fillsz;		/* !< Bytes written to the buffer.  */
@@ -139,6 +144,9 @@
 int rt_pipe_flush(RT_PIPE *pipe,
 		  int mode);
 
+int rt_pipe_monitor(RT_PIPE *pipe,
+		    void (*fn)(RT_PIPE *pipe, int event));
+
 #ifdef CONFIG_XENO_OPT_NATIVE_PIPE
 
 int __native_pipe_pkg_init(void);
Index: ksrc/skins/native/pipe.c
===================================================================
--- ksrc/skins/native/pipe.c	(revision 3989)
+++ ksrc/skins/native/pipe.c	(working copy)
@@ -115,6 +115,28 @@
 	return retval;
 }
 
+static int __pipe_input_handler(int bminor,
+				xnpipe_mh_t *mh, int retval, void *cookie)
+{
+	RT_PIPE *pipe = (RT_PIPE *)cookie;
+	
+	if (pipe->monitor == NULL)
+		return retval;
+
+	if (retval == 0)
+		/* Callee may alter the return value passed to userland. */
+		retval = pipe->monitor(pipe, P_EVENT_INPUT);
+	else if (retval == -EPIPE)
+		pipe->monitor(pipe, P_EVENT_CLOSE);
+
+	/*
+	 * We don't notify the kernel endpoint about userland errors,
+	 * such as passing invalid buffer addresses (i.e. -EFAULT).
+	 */
+
+	return retval;
+}
+
 int __native_pipe_pkg_init(void)
 {
 	return 0;
@@ -229,6 +251,7 @@
 	pipe->buffer = NULL;
 	pipe->bufpool = &kheap;
 	pipe->fillsz = 0;
+	pipe->monitor = NULL;
 	pipe->status = 0;
 	pipe->handle = 0;	/* i.e. (still) unregistered pipe. */
 	pipe->magic = XENO_PIPE_MAGIC;
@@ -274,7 +297,7 @@
 
 	minor = xnpipe_connect(minor,
 			       &__pipe_output_handler,
-			       NULL, &__pipe_alloc_handler, pipe);
+			       &__pipe_input_handler, &__pipe_alloc_handler, pipe);
 
 	if (minor < 0) {
 		if (pipe->bufpool == &pipe->privpool)
@@ -372,7 +395,7 @@
 	}
 
 	removeq(pipe->rqueue, &pipe->rlink);
-
+	pipe->monitor = NULL;	/* Stop monitoring. */
 	err = xnpipe_disconnect(pipe->minor);
 
 	if (pipe->buffer != NULL) {
@@ -1049,6 +1072,74 @@
 	return xnpipe_flush(minor, mode);
 }
 
+/**
+ * @fn int rt_pipe_monitor(RT_PIPE *pipe, int (*fn)(RT_PIPE *pipe, int event))
+ *
+ * @brief Monitor a message pipe asynchronously.
+ *
+ * This service registers a notifier callback that will be called upon
+ * specific events occurring on the channel.  rt_pipe_monitor() is
+ * particularly useful to monitor a channel asynchronously while
+ * performing other tasks.
+ *
+ * @param pipe The descriptor address of the pipe to monitor.
+ *
+ * @param fn The notification handler. This user-provided routine will
+ * be passed the address of the message pipe descriptor receiving the
+ * event, and the event code.  Two events are currently defined:
+ *
+ * - P_EVENT_INPUT is sent when the user-space endpoint writes to the
+ *   pipe.
+ *
+ * - P_EVENT_CLOSE is sent when the user-space endpoint is closed.
+ *
+ * The notification handler is called on behalf of a fully atomic
+ * context; therefore, care must be taken to keep its overhead
+ * low. The Xenomai services that may be called from a notification
+ * handler are restricted to the set allowed to a real-time interrupt
+ * handler.
+ *
+ * @return Zero is returned upon success. Otherwise:
+ *
+ * - -EINVAL is returned if @a pipe is not a pipe descriptor.
+ *
+ * - -EIDRM is returned if @a pipe is a closed pipe descriptor.
+ *
+ * - -ENODEV or -EBADF are returned if @a pipe is scrambled.
+ *
+ * Environments:
+ *
+ * This service can be called from:
+ *
+ * - Kernel module initialization/cleanup code
+ * - Kernel-based task
+ *
+ * Rescheduling: never.
+ */
+
+int rt_pipe_monitor(RT_PIPE *pipe, void (*fn)(RT_PIPE *pipe, int event))
+{
+	int minor, err;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	pipe = xeno_h2obj_validate(pipe, XENO_PIPE_MAGIC, RT_PIPE);
+
+	if (!pipe) {
+		err = xeno_handle_error(pipe, XENO_PIPE_MAGIC, RT_PIPE);
+		xnlock_put_irqrestore(&nklock, s);
+		return err;
+	}
+
+	pipe->monitor = fn;
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return 0;
+	
+}
+
 /*@}*/
 
 EXPORT_SYMBOL(rt_pipe_create);
@@ -1061,3 +1152,4 @@
 EXPORT_SYMBOL(rt_pipe_alloc);
 EXPORT_SYMBOL(rt_pipe_free);
 EXPORT_SYMBOL(rt_pipe_flush);
+EXPORT_SYMBOL(rt_pipe_monitor);

--------------010601060209080804090101--

