From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 7/8] drivers/ipc: bufp: fix rd/rd and wr/wr races
Date: Fri, 31 Jan 2020 16:27:12 +0100
Message-Id: <20200131152713.1811748-8-rpm@xenomai.org>
In-Reply-To: <20200131152713.1811748-1-rpm@xenomai.org>
References: <20200131152713.1811748-1-rpm@xenomai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Philippe Gerum <rpm@xenomai.org>

Concurrent reads or writes to a buffer causing nested buffer space
reservations could end up in a miscalculation of the number of bytes
remaining to be read or written. Fix this by updating these counts
only once the last reservation is committed.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/ipc/bufp.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index 3d0929df7..45c917eb0 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -43,8 +43,10 @@ struct bufp_socket {
 
 	off_t rdoff;
 	off_t rdrsvd;
+	int rdsem;
 	off_t wroff;
 	off_t wrrsvd;
+	int wrsem;
 	size_t fillsz;
 	rtdm_event_t i_event;
 	rtdm_event_t o_event;
@@ -188,6 +190,7 @@ redo:
 		rdoff = sk->rdoff;
 		sk->rdoff = (rdoff + len) % sk->bufsz;
 		sk->rdrsvd += len;
+		sk->rdsem++;
 		rbytes = ret = len;
 
 		do {
@@ -213,14 +216,17 @@ redo:
 			rdoff = (rdoff + n) % sk->bufsz;
 		} while (rbytes > 0);
 
+		if (--sk->rdsem > 0)
+			goto out;
+
 		resched = 0;
-		if (sk->fillsz == sk->bufsz) /* -> writable */
+		if (sk->fillsz == sk->bufsz) /* -> becomes writable */
 			resched |= xnselect_signal(&sk->priv->send_block, POLLOUT);
 
-		sk->rdrsvd -= len;
-		sk->fillsz -= len;
+		sk->fillsz -= sk->rdrsvd;
+		sk->rdrsvd = 0;
 
-		if (sk->fillsz == 0) /* -> non-readable */
+		if (sk->fillsz == 0) /* -> becomes non-readable */
 			resched |= xnselect_signal(&sk->priv->recv_block, 0);
 
 		/*
@@ -431,6 +437,7 @@ static ssize_t __bufp_writebuf(struct bufp_socket *rsk,
 		wroff = rsk->wroff;
 		rsk->wroff = (wroff + len) % rsk->bufsz;
 		rsk->wrrsvd += len;
+		rsk->wrsem++;
 		wbytes = ret = len;
 
 		do {
@@ -459,14 +466,17 @@ static ssize_t __bufp_writebuf(struct bufp_socket *rsk,
 			wroff = (wroff + n) % rsk->bufsz;
 		} while (wbytes > 0);
 
-		rsk->fillsz += len;
-		rsk->wrrsvd -= len;
+		if (--rsk->wrsem > 0)
+			goto out;
 
 		resched = 0;
-		if (rsk->fillsz == len) /* -> readable */
+		if (rsk->fillsz == 0) /* -> becomes readable */
 			resched |= xnselect_signal(&rsk->priv->recv_block, POLLIN);
 
-		if (rsk->fillsz == rsk->bufsz) /* non-writable */
+		rsk->fillsz += rsk->wrrsvd;
+		rsk->wrrsvd = 0;
+
+		if (rsk->fillsz == rsk->bufsz) /* becomes non-writable */
 			resched |= xnselect_signal(&rsk->priv->send_block, 0);
 		/*
 		 * Wake up all threads pending on the input wait
-- 
2.24.1


