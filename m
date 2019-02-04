From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 04/18] drivers/ipc: bufp: fix read-write,
 write-write preemption cases
Date: Mon,  4 Feb 2019 11:56:33 +0100
Message-Id: <20190204105647.5034-5-rpm@xenomai.org>
In-Reply-To: <20190204105647.5034-1-rpm@xenomai.org>
References: <20190204105647.5034-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

The token-based approach for detecting preemption while data is being
moved into or out of the ring only protects from read vs read races,
not from races involving a write side. For instance, a reader might
read dirty data being changed by a writer concurrently, or two writers
might compete writing two distinct messages at the same place in the
ring space.

To address this issue, use a slot-based implementation which
atomically reserves exclusive portions of the ring space readers and
writers will be accessing locklessly. Those slots are guaranteed to
never overlap among read and write requests, until the lockless
operation finishes.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/ipc/bufp.c | 118 ++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 68 deletions(-)

diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index e1c867288..4fa6593c3 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -42,10 +42,10 @@ struct bufp_socket {
 	char label[XNOBJECT_NAME_LEN];
 
 	off_t rdoff;
+	off_t rdrsvd;
 	off_t wroff;
+	off_t wrrsvd;
 	size_t fillsz;
-	u_long wrtoken;
-	u_long rdtoken;
 	rtdm_event_t i_event;
 	rtdm_event_t o_event;
 
@@ -115,8 +115,8 @@ static int bufp_socket(struct rtdm_fd *fd)
 	sk->rdoff = 0;
 	sk->wroff = 0;
 	sk->fillsz = 0;
-	sk->rdtoken = 0;
-	sk->wrtoken = 0;
+	sk->rdrsvd = 0;
+	sk->wrrsvd = 0;
 	sk->status = 0;
 	sk->handle = 0;
 	sk->rx_timeout = RTDM_TIMEOUT_INFINITE;
@@ -162,11 +162,10 @@ static ssize_t __bufp_readbuf(struct bufp_socket *sk,
 	struct bufp_wait_context wait, *bufwc;
 	struct rtipc_wait_context *wc;
 	struct xnthread *waiter;
+	size_t rbytes, n, avail;
+	ssize_t len, ret, xret;
 	rtdm_toseq_t toseq;
-	ssize_t len, ret;
-	size_t rbytes, n;
 	rtdm_lockctx_t s;
-	u_long rdtoken;
 	off_t rdoff;
 	int resched;
 
@@ -181,18 +180,15 @@ redo:
 		 * We should be able to read a complete message of the
 		 * requested length, or block.
 		 */
-		if (sk->fillsz < len)
+		avail = sk->fillsz - sk->rdrsvd;
+		if (avail < len)
 			goto wait;
 
-		/*
-		 * Draw the next read token so that we can later
-		 * detect preemption.
-		 */
-		rdtoken = ++sk->rdtoken;
-
-		/* Read from the buffer in a circular way. */
+		/* Reserve a read slot into the circular buffer. */
 		rdoff = sk->rdoff;
-		rbytes = len;
+		sk->rdoff = (rdoff + len) % sk->bufsz;
+		sk->rdrsvd += len;
+		rbytes = ret = len;
 
 		do {
 			if (rdoff + rbytes > sk->bufsz)
@@ -200,37 +196,30 @@ redo:
 			else
 				n = rbytes;
 			/*
-			 * Release the lock while retrieving the data
-			 * to keep latency low.
+			 * Drop the lock before copying data to
+			 * user. The read slot is consumed in any
+			 * case: the non-copied portion of the message
+			 * is lost on bad write.
 			 */
 			cobalt_atomic_leave(s);
-			ret = xnbufd_copy_from_kmem(bufd, sk->bufmem + rdoff, n);
-			if (ret < 0)
-				return ret;
-
+			xret = xnbufd_copy_from_kmem(bufd, sk->bufmem + rdoff, n);
 			cobalt_atomic_enter(s);
-			/*
-			 * In case we were preempted while retrieving
-			 * the message, we have to re-read the whole
-			 * thing.
-			 */
-			if (sk->rdtoken != rdtoken) {
-				xnbufd_reset(bufd);
-				goto redo;
+			if (xret < 0) {
+				ret = -EFAULT;
+				break;
 			}
 
-			rdoff = (rdoff + n) % sk->bufsz;
 			rbytes -= n;
+			rdoff = (rdoff + n) % sk->bufsz;
 		} while (rbytes > 0);
 
-		sk->fillsz -= len;
-		sk->rdoff = rdoff;
-		ret = len;
-
 		resched = 0;
-		if (sk->fillsz + len == sk->bufsz) /* -> writable */
+		if (sk->fillsz == sk->bufsz) /* -> writable */
 			resched |= xnselect_signal(&sk->priv->send_block, POLLOUT);
 
+		sk->rdrsvd -= len;
+		sk->fillsz -= len;
+
 		if (sk->fillsz == 0) /* -> non-readable */
 			resched |= xnselect_signal(&sk->priv->recv_block, 0);
 
@@ -416,11 +405,10 @@ static ssize_t __bufp_writebuf(struct bufp_socket *rsk,
 	struct bufp_wait_context wait, *bufwc;
 	struct rtipc_wait_context *wc;
 	struct xnthread *waiter;
+	size_t wbytes, n, avail;
+	ssize_t len, ret, xret;
 	rtdm_toseq_t toseq;
 	rtdm_lockctx_t s;
-	ssize_t len, ret;
-	size_t wbytes, n;
-	u_long wrtoken;
 	off_t wroff;
 	int resched;
 
@@ -429,24 +417,21 @@ static ssize_t __bufp_writebuf(struct bufp_socket *rsk,
 	rtdm_toseq_init(&toseq, sk->tx_timeout);
 
 	cobalt_atomic_enter(s);
-redo:
+
 	for (;;) {
 		/*
-		 * We should be able to write the entire message at
-		 * once or block.
+		 * No short or scattered writes: we should write the
+		 * entire message atomically or block.
 		 */
-		if (rsk->fillsz + len > rsk->bufsz)
+		avail = rsk->fillsz + rsk->wrrsvd;
+		if (avail + len > rsk->bufsz)
 			goto wait;
 
-		/*
-		 * Draw the next write token so that we can later
-		 * detect preemption.
-		 */
-		wrtoken = ++rsk->wrtoken;
-
-		/* Write to the buffer in a circular way. */
+		/* Reserve a write slot into the circular buffer. */
 		wroff = rsk->wroff;
-		wbytes = len;
+		rsk->wroff = (wroff + len) % rsk->bufsz;
+		rsk->wrrsvd += len;
+		wbytes = ret = len;
 
 		do {
 			if (wroff + wbytes > rsk->bufsz)
@@ -454,33 +439,30 @@ redo:
 			else
 				n = wbytes;
 			/*
-			 * Release the lock while copying the data to
-			 * keep latency low.
+			 * We have to drop the lock while reading in
+			 * data, but we can't rollback on bad read
+			 * from user because some other thread might
+			 * have populated the memory ahead of our
+			 * write slot already: bluntly clear the
+			 * unavailable bytes on copy error.
 			 */
 			cobalt_atomic_leave(s);
-			ret = xnbufd_copy_to_kmem(rsk->bufmem + wroff, bufd, n);
-			if (ret < 0)
-				return ret;
+			xret = xnbufd_copy_to_kmem(rsk->bufmem + wroff, bufd, n);
 			cobalt_atomic_enter(s);
-			/*
-			 * In case we were preempted while copying the
-			 * message, we have to write the whole thing
-			 * again.
-			 */
-			if (rsk->wrtoken != wrtoken) {
-				xnbufd_reset(bufd);
-				goto redo;
+			if (xret < 0) {
+				memset(rsk->bufmem + wroff + n - xret, 0, xret);
+				ret = -EFAULT;
+				break;
 			}
 
-			wroff = (wroff + n) % rsk->bufsz;
 			wbytes -= n;
+			wroff = (wroff + n) % rsk->bufsz;
 		} while (wbytes > 0);
 
 		rsk->fillsz += len;
-		rsk->wroff = wroff;
-		ret = len;
-		resched = 0;
+		rsk->wrrsvd -= len;
 
+		resched = 0;
 		if (rsk->fillsz == len) /* -> readable */
 			resched |= xnselect_signal(&rsk->priv->recv_block, POLLIN);
 
-- 
2.17.2


