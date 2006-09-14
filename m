Subject: Re: [Xenomai-help] read returns more bytes than requested?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4505E719.3030405@domain.hid>
References: <4505E719.3030405@domain.hid>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 15:09:45 +0200
Message-Id: <1158239386.5040.105.camel@domain.hid>
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

On Mon, 2006-09-11 at 17:45 -0500, Jeff Webb wrote:
> I am having some success porting my RTLinux application, but I have encountered a strange error.
> 
> I have this snippet of code that is reading data from an rtai-skin FIFO:
> 
>   result = read(runtime2io_fd, &resp, sizeof(resp));
>   if (result != sizeof(resp))
>     {
>       printf("requested %d bytes, got %d\n", sizeof(resp), result);
>       snprintf(err_str, MAX_STR_LEN, "cannot read response from %s",
>                RUNTIME2IO_FIFO_DEV);
>       sim_halt(err_str);
>       return;
>     }
> 
> I get the following output:
> 
>   requested 312 bytes, got 1220
>   halting the sim: cannot read response from /dev/rtf1
> 
> I didn't think that a read could return more bytes than was requested.  Does anyone understand this behaviour?  This is code that works under RT-Linux.  I am trying to determine why it is working differently under xenomai.

Another round of refactoring the message pipe support. This time, it
introduces the ability to get partial reads from the /dev/rtp* device
endpoint, instead of requiring read() calls to collect all of the
pending data at once. The remaining work will allow the same from the
real-time API endpoint. This patch applies against the latest patch
sent.

--- include/nucleus/pipe.h	(revision 1607)
+++ include/nucleus/pipe.h	(working copy)
@@ -57,6 +57,7 @@
 
     xnholder_t link;
     unsigned size;
+    unsigned rdoff;
     
 } xnpipe_mh_t;
 
@@ -156,6 +157,8 @@
 
 #define xnpipe_m_size(mh) ((mh)->size)
 
+#define xnpipe_m_rdoff(mh) ((mh)->rdoff)
+
 #endif /* __KERNEL__ */
 
 #endif /* !_XENO_NUCLEUS_PIPE_H */
Index: ksrc/nucleus/pipe.c
===================================================================
--- ksrc/nucleus/pipe.c	(revision 1607)
+++ ksrc/nucleus/pipe.c	(working copy)
@@ -371,6 +371,7 @@
 
 	inith(xnpipe_m_link(mh));
 	xnpipe_m_size(mh) = size - sizeof(*mh);
+	xnpipe_m_rdoff(mh) = 0;
 	state->ionrd += xnpipe_m_size(mh);
 
 	if (flags & XNPIPE_URGENT)
@@ -668,11 +669,11 @@
 			   char *buf, size_t count, loff_t *ppos)
 {
 	xnpipe_state_t *state = (xnpipe_state_t *)file->private_data;
+	int sigpending, err = 0;
 	size_t nbytes, inbytes;
 	struct xnpipe_mh *mh;
-	int sigpending, err;
 	xnholder_t *holder;
-	ssize_t ret = 0;
+	ssize_t ret;
 	spl_t s;
 
 	if (!access_ok(VERIFY_WRITE, buf, count))
@@ -701,59 +702,57 @@
 		holder = getq(&state->outq);
 		mh = link2mh(holder);
 
-		if (sigpending && !mh) {
+		if (!mh) {
 			xnlock_put_irqrestore(&nklock, s);
-			return -ERESTARTSYS;
+			return sigpending ? -ERESTARTSYS : 0;
 		}
 	}
 
-	if (mh) {
-		nbytes = xnpipe_m_size(mh); /* Cannot be zero */
-		inbytes = 0;
+	/*
+	 * We allow more data to be appended to the current message
+	 * bucket while its contents is being copied to the user
+	 * buffer, therefore, we need to loop until: 1) all the data
+	 * has been copied, 2) we consumed the user buffer space
+	 * entirely.
+	 */
 
-		/*
-		 * We allow more data to be appended to the current
-		 * message bucket while its contents is being copied
-		 * to the user buffer, therefore, we need to loop
-		 * until:
-		 * 1) all the data has been copied,
-		 * 2) we consumed the user buffer space entirely.
-		 */
+	inbytes = 0;
 
-		do {
-			if (inbytes <= count) {
-				xnlock_put_irqrestore(&nklock, s);
-				/* More data could be appended while doing this: */
-				err = __copy_to_user(buf + inbytes, xnpipe_m_data(mh) + inbytes, nbytes);
-				xnlock_get_irqsave(&nklock, s);
-				if (err) {
-					ret = -EFAULT;
-					break;
-				}
-				inbytes += nbytes;
-				nbytes = xnpipe_m_size(mh) - inbytes;
-			} else {
-				/* Return buffer is too small - message is lost. */
-				ret = -ENOBUFS;
-				break;
-			}
-		} while(nbytes > 0);
+	for (;;) {
+		nbytes = xnpipe_m_size(mh) - xnpipe_m_rdoff(mh);
 
-		if (ret < 0)
-			inbytes = xnpipe_m_size(mh);
-		else
-			ret = (ssize_t) inbytes;
+		if (nbytes + inbytes > count)
+			nbytes = count - inbytes;
 
-		state->ionrd -= inbytes;
+		if (nbytes == 0)
+			break;
 
-		if (state->output_handler != NULL)
-			ret = state->output_handler(xnminor_from_state(state),
-						    mh, ret, state->cookie);
+		xnlock_put_irqrestore(&nklock, s);
+		/* More data could be appended while doing this: */
+		err = __copy_to_user(buf + inbytes, xnpipe_m_data(mh) + xnpipe_m_rdoff(mh), nbytes);
+		xnlock_get_irqsave(&nklock, s);
+
+		if (err) {
+			err = -EFAULT;
+			break;
+		}
+
+		inbytes += nbytes;
+		xnpipe_m_rdoff(mh) += nbytes;
 	}
 
+	state->ionrd -= inbytes;
+	ret = inbytes;
+
+	if (xnpipe_m_size(mh) > xnpipe_m_rdoff(mh))
+		prependq(&state->outq, &mh->link);
+	else if (state->output_handler != NULL)
+		ret = state->output_handler(xnminor_from_state(state),
+					    mh, err ?: ret, state->cookie);
+
 	xnlock_put_irqrestore(&nklock, s);
 
-	return ret;
+	return err ?: ret;
 }
 
 static ssize_t xnpipe_write(struct file *file,
@@ -799,6 +798,7 @@
 
 	inith(xnpipe_m_link(mh));
 	xnpipe_m_size(mh) = count;
+	xnpipe_m_rdoff(mh) = 0;
 	__copy_from_user(xnpipe_m_data(mh), buf, count);
 
 	xnlock_get_irqsave(&nklock, s);


-- 
Philippe.



