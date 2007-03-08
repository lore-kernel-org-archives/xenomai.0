Subject: Re: [Xenomai-help] rt_pipe_write() returns -ENOMEM
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45ECACFB.9060703@domain.hid>
References: <45EC4111.6070104@domain.hid>
	<45EC428E.5060306@domain.hid>	<45EC4AF4.7000808@domain.hid>
	<45EC4F8E.905@domain.hid>	<45EC5946.9030508@domain.hid>
	<45EC61B0.3020907@domain.hid>
	<17900.31172.233075.597047@domain.hid>
	<45ECACFB.9060703@domain.hid>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 16:55:45 +0100
Message-Id: <1173369345.17515.41.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Markus.Franke@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2007-03-06 at 00:51 +0100, Markus Franke wrote:
> Well, I just want to use the RT Pipes as if they are a normal fifo.
>  That
> is, the fifo has a bounded amount of memory and if the number of written
> bytes exceeds this threshold the data which was firstly written into the
> fifo should be dropped.

Actually, writing to a normal fifo (as UNIX pipes) rather blocks the
caller, unless non-blocking i/o is in effect. This said, real-time
message pipes have to be different, since the kernel endpoint is not
expected to block for the non real-time user-space side to consume the
data, otherwise, we would somehow synchronize the high-piority work with
some low-priority task. Which in turn means that some support for
flushing the i/o queues managed by the kernel endpoint space is indeed
missing. The patch below attempts to address this - will be part of 2.4:

Index: include/native/pipe.h
===================================================================
--- include/native/pipe.h	(revision 2279)
+++ include/native/pipe.h	(working copy)
@@ -128,7 +128,8 @@
 int rt_pipe_free(RT_PIPE *pipe,
                  RT_PIPE_MSG *msg);
 
-ssize_t __deprecated_call__ rt_pipe_flush(RT_PIPE *pipe);
+int rt_pipe_flush(RT_PIPE *pipe,
+		  int mode);
 
 int __native_pipe_pkg_init(void);
 
Index: include/nucleus/pipe.h
===================================================================
--- include/nucleus/pipe.h	(revision 2279)
+++ include/nucleus/pipe.h	(working copy)
@@ -31,6 +31,9 @@
 #define XNPIPE_NORMAL  0x0
 #define XNPIPE_URGENT  0x1
 
+#define XNPIPE_IFLUSH  0x1
+#define XNPIPE_OFLUSH  0x2
+
 #define XNPIPE_MINOR_AUTO  -1
 
 #ifdef __KERNEL__
@@ -141,6 +144,9 @@
 
 int xnpipe_inquire(int minor);
 
+int xnpipe_flush(int minor,
+		 int mode);
+
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
Index: ksrc/skins/native/pipe.c
===================================================================
--- ksrc/skins/native/pipe.c	(revision 2279)
+++ ksrc/skins/native/pipe.c	(working copy)
@@ -934,6 +934,71 @@
 	return xnheap_free(pipe->bufpool, msg);
 }
 
+/**
+ * @fn int rt_pipe_flush(RT_PIPE *pipe, int mode)
+ *
+ * @brief Flush the i/o queues associated with the kernel endpoint of
+ * a message pipe.
+ *
+ * This service flushes all data pending for consumption by the remote
+ * side in user-space for the given message pipe. Upon success, no
+ * data remains to be read from the remote side of the connection.
+ *
+ * The user-space equivalent is a call to:
+ * ioctl(pipefd, XNPIPEIOC_FLUSH, 0).
+ *
+ * @param pipe The descriptor address of the pipe to flush.
+ *
+ * @param mode A mask indicating which queues need to be flushed; the
+ * following flags may be combined in a single flush request:
+ *
+ * - XNPIPE_IFLUSH causes the input queue to be flushed (i.e. data
+ * coming from user-space to the kernel endpoint will be discarded).
+ *
+ * - XNPIPE_OFLUSH causes the output queue to be flushed (i.e. data
+ * going to user-space from the kernel endpoint will be discarded).
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
+ * - Interrupt service routine
+ * - Kernel-based task
+ *
+ * Rescheduling: never.
+ */
+
+int rt_pipe_flush(RT_PIPE *pipe, int mode)
+{
+	int minor;
+	spl_t s;
+
+	xnlock_get_irqsave(&nklock, s);
+
+	pipe = xeno_h2obj_validate(pipe, XENO_PIPE_MAGIC, RT_PIPE);
+
+	if (!pipe) {
+		int err = xeno_handle_error(pipe, XENO_PIPE_MAGIC, RT_PIPE);
+		xnlock_put_irqrestore(&nklock, s);
+		return err;
+	}
+
+	minor = pipe->minor;
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return xnpipe_flush(minor, mode);
+}
+
 /*@}*/
 
 EXPORT_SYMBOL(rt_pipe_create);
@@ -945,3 +1010,4 @@
 EXPORT_SYMBOL(rt_pipe_stream);
 EXPORT_SYMBOL(rt_pipe_alloc);
 EXPORT_SYMBOL(rt_pipe_free);
+EXPORT_SYMBOL(rt_pipe_flush);
Index: ksrc/nucleus/pipe.c
===================================================================
--- ksrc/nucleus/pipe.c	(revision 2279)
+++ ksrc/nucleus/pipe.c	(working copy)
@@ -502,6 +502,57 @@
 	return xnpipe_states[minor].status;
 }
 
+int xnpipe_flush(int minor, int mode)
+{
+	xnpipe_state_t *state;
+	struct xnpipe_mh *mh;
+	xnholder_t *holder;
+	spl_t s;
+
+	if (minor < 0 || minor >= XNPIPE_NDEVS)
+		return -ENODEV;
+
+	state = &xnpipe_states[minor];
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (mode & XNPIPE_OFLUSH) {
+		ssize_t n = 0;
+
+		while ((holder = getq(&state->outq)) != NULL) {
+			xnlock_put_irqrestore(&nklock, s);
+
+			mh = link2mh(holder);
+			n += xnpipe_m_size(mh);
+
+			if (state->output_handler != NULL)
+				state->output_handler(xnminor_from_state(state),
+						      mh, 0, state->cookie);
+
+			xnlock_get_irqsave(&nklock, s);
+		}
+		state->ionrd -= n;
+	}
+
+	if (mode & XNPIPE_IFLUSH) {
+		while ((holder = getq(&state->inq)) != NULL) {
+			xnlock_put_irqrestore(&nklock, s);
+
+			if (state->input_handler != NULL)
+				state->input_handler(minor, link2mh(holder), -EPIPE,
+						     state->cookie);
+			else if (state->alloc_handler == NULL)
+				xnfree(link2mh(holder));
+
+			xnlock_get_irqsave(&nklock, s);
+		}
+	}
+
+	xnlock_put_irqrestore(&nklock, s);
+
+	return 0;
+}
+
 /*
  * Clear XNPIPE_USER_CONN flag and cleanup the associated data queues
  * in one atomic step.
@@ -1060,3 +1111,4 @@
 EXPORT_SYMBOL(xnpipe_recv);
 EXPORT_SYMBOL(xnpipe_inquire);
 EXPORT_SYMBOL(xnpipe_setup);
+EXPORT_SYMBOL(xnpipe_flush);

-- 
Philippe.



