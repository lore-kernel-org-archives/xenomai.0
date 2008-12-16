Message-ID: <4947B958.7030100@domain.hid>
Date: Tue, 16 Dec 2008 15:21:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4947AE91.8010000@domain.hid>
In-Reply-To: <4947AE91.8010000@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] xnpipe: Fix racy callback handlers
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

Jan Kiszka wrote:
> Hi,
> 
> someone just dumped another kernel oops on my desk which points to the
> xnpipe subsystem: xnpipe_release was called, invoking
> __pipe_input_handler ie. the registered input_handler of the native pipe
> services. And that handler tried to call an invalid monitor callback
> (but no one ever set a monitor handler).
> 
> So I looked at how the nucleus deals with input_handler registration,
> deregistration, and invocation where it also passes some cookie that
> points to the native pipe object here. Looks like that code is racy /wrt
> concurrent cleanup of kernel and user side.
> 
> What is the intended locking policy when dereferencing the tuple of
> xnpipe_state_t.input_handler and xnpipe_state_t.cookie? Sometimes the
> handler is called under nklock, sometimes only both values are obtained
> and then nklock is dropped before invoking the handler (which is bogus
> as cookie may become invalid in the meantime). Even worse,
> xnpipe_release does not care at all about locking when calling
> input_handler as its last duty - and that's obviously where my customer
> just caught an oops.
> 
> In other words: Can't we always hold nklock while checking for
> input_handler != NULL and then invoking it with the corresponding
> cookie? This will just require us to properly clear input_handler on
> xnpipe_disconnect.
> 

Here is an attempt to fix the bugs. Compile-tested. The assumption is
still that we can (and must) call all handlers under nklock.

------------>

Invocation of input, output and alloc handler must take place under
nklock to properly synchronize with xnpipe_disconnect. Change all
callers to comply with this policy.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/pipe.c |   96 ++++++++++++++++++++++-----------------------------
 1 files changed, 42 insertions(+), 54 deletions(-)

diff --git a/ksrc/nucleus/pipe.c b/ksrc/nucleus/pipe.c
index b592437..1f8ebf7 100644
--- a/ksrc/nucleus/pipe.c
+++ b/ksrc/nucleus/pipe.c
@@ -331,6 +331,10 @@ int xnpipe_disconnect(int minor)
 
 	xnpipe_minor_free(minor);
 
+	state->output_handler = NULL;
+	state->input_handler = NULL;
+	state->alloc_handler = NULL;
+
 	xnlock_put_irqrestore(&nklock, s);
 
 	if (need_sched)
@@ -674,14 +678,14 @@ static int xnpipe_release(struct inode *inode, struct file *file)
 		}
 	}
 
-	xnlock_put_irqrestore(&nklock, s);
-
 	if (state->asyncq) {	/* Clear the async queue */
-		xnlock_get_irqsave(&nklock, s);
 		removeq(&xnpipe_asyncq, &state->alink);
 		__clrbits(state->status, XNPIPE_USER_SIGIO);
 		xnlock_put_irqrestore(&nklock, s);
+
 		fasync_helper(-1, file, 0, &state->asyncq);
+
+		xnlock_get_irqsave(&nklock, s);
 	}
 
 	xnpipe_cleanup_user_conn(state);
@@ -689,6 +693,9 @@ static int xnpipe_release(struct inode *inode, struct file *file)
 	if (state->input_handler)
 		state->input_handler(MINOR(inode->i_rdev),
 				     NULL, -EPIPE, state->cookie);
+
+	xnlock_put_irqrestore(&nklock, s);
+
 	return err;
 }
 
@@ -798,11 +805,9 @@ static ssize_t xnpipe_write(struct file *file,
 			    const char *buf, size_t count, loff_t *ppos)
 {
 	xnpipe_state_t *state = (xnpipe_state_t *)file->private_data;
-	xnpipe_alloc_handler *alloc_handler;
-	xnpipe_io_handler *input_handler;
 	struct xnpipe_mh *mh;
-	void *cookie;
 	int pollnum;
+	int err;
 	spl_t s;
 
 	if (count == 0)
@@ -818,19 +823,16 @@ static ssize_t xnpipe_write(struct file *file,
 		return -EPIPE;
 	}
 
-	alloc_handler = state->alloc_handler;
-	input_handler = state->input_handler;
-	cookie = state->cookie;
-
       retry:
 	pollnum = countq(&state->inq) + countq(&state->outq);
-	xnlock_put_irqrestore(&nklock, s);
 
-	if (alloc_handler)
+	if (state->alloc_handler) {
 		mh = (struct xnpipe_mh *)
-		    alloc_handler(xnminor_from_state(state),
-				  count + sizeof(*mh), cookie);
-	else {
+		    state->alloc_handler(xnminor_from_state(state),
+					 count + sizeof(*mh), state->cookie);
+		xnlock_put_irqrestore(&nklock, s);
+	} else {
+		xnlock_put_irqrestore(&nklock, s);
 		mh = (struct xnpipe_mh *)xnmalloc(count + sizeof(*mh));
 		if (mh == NULL &&
 		    count + sizeof(*mh) > xnheap_max_contiguous(&kheap))
@@ -858,17 +860,22 @@ static ssize_t xnpipe_write(struct file *file,
 	xnpipe_m_size(mh) = count;
 	xnpipe_m_rdoff(mh) = 0;
 
-	if (copy_from_user(xnpipe_m_data(mh), buf, count)) {
-		if (alloc_handler == NULL)
+	err = copy_from_user(xnpipe_m_data(mh), buf, count);
+
+	xnlock_get_irqsave(&nklock, s);
+
+	if (err) {
+		if (state->alloc_handler == NULL)
 			xnfree(mh);
-		else if (input_handler)
-			input_handler(xnminor_from_state(state), mh,
-				      -EFAULT, state->cookie);
+		else if (state->input_handler)
+			state->input_handler(xnminor_from_state(state), mh,
+					     -EFAULT, state->cookie);
+
+		xnlock_put_irqrestore(&nklock, s);
+
 		return -EFAULT;
 	}
 
-	xnlock_get_irqsave(&nklock, s);
-
 	appendq(&state->inq, &mh->link);
 
 	/* If a Xenomai thread is waiting on this input queue, wake it
@@ -878,26 +885,20 @@ static ssize_t xnpipe_write(struct file *file,
 	    xnsynch_wakeup_one_sleeper(&state->synchbase) != NULL)
 		xnpod_schedule();
 
-	xnlock_put_irqrestore(&nklock, s);
-
-	if (input_handler) {
-		int err =
-		    input_handler(xnminor_from_state(state), mh, 0, cookie);
-
-		if (err != 0)
+	if (state->input_handler) {
+		err = state->input_handler(xnminor_from_state(state), mh, 0,
+					   state->cookie);
+		if (err)
 			count = (size_t) err;
 	}
 
-	if (file->f_flags & O_SYNC) {
-		xnlock_get_irqsave(&nklock, s);
-		if (!emptyq_p(&state->inq)) {
-			if (xnpipe_wait(state, XNPIPE_USER_WSYNC, s,
-					emptyq_p(&state->inq)))
-				count = -ERESTARTSYS;
-		}
-		xnlock_put_irqrestore(&nklock, s);
+	if (file->f_flags & O_SYNC && !emptyq_p(&state->inq)) {
+		if (xnpipe_wait(state, XNPIPE_USER_WSYNC, s, 0))
+			count = -ERESTARTSYS;
 	}
 
+	xnlock_put_irqrestore(&nklock, s);
+
 	return (ssize_t) count;
 }
 
@@ -905,11 +906,9 @@ static int xnpipe_ioctl(struct inode *inode,
 			struct file *file, unsigned int cmd, unsigned long arg)
 {
 	xnpipe_state_t *state = (xnpipe_state_t *)file->private_data;
-	xnpipe_io_handler *io_handler;
 	int err = 0, n, minor;
 	struct xnpipe_mh *mh;
 	xnholder_t *holder;
-	void *cookie;
 	spl_t s;
 
 	minor = xnminor_from_state(state);
@@ -936,21 +935,16 @@ static int xnpipe_ioctl(struct inode *inode,
 		   design problem anyway. */
 
 		n = 0;
-		io_handler = state->output_handler;
-		cookie = state->cookie;
 
 		xnlock_get_irqsave(&nklock, s);
 
 		while ((holder = getq(&state->outq)) != NULL) {
-			xnlock_put_irqrestore(&nklock, s);
-
 			mh = link2mh(holder);
 			n += xnpipe_m_size(mh);
 
-			if (io_handler)
-				io_handler(minor, mh, 0, cookie);
-
-			xnlock_get_irqsave(&nklock, s);
+			if (state->output_handler)
+				state->output_handler(minor, mh, 0,
+						      state->cookie);
 		}
 
 		state->ionrd -= n;
@@ -959,23 +953,17 @@ static int xnpipe_ioctl(struct inode *inode,
 	case XNPIPEIOC_IFLUSH:
 
 		n = 0;
-		io_handler = state->input_handler;
-		cookie = state->cookie;
 
 		xnlock_get_irqsave(&nklock, s);
 
 		while ((holder = getq(&state->inq)) != NULL) {
-			xnlock_put_irqrestore(&nklock, s);
-
 			mh = link2mh(holder);
 			n += xnpipe_m_size(mh);
 
 			if (state->input_handler)
-				state->input_handler(minor, mh, 0, cookie);
+				state->input_handler(minor, mh, 0, state->cookie);
 			else if (state->alloc_handler == NULL)
 				xnfree(mh);
-
-			xnlock_get_irqsave(&nklock, s);
 		}
 
 	kick_wsync:

