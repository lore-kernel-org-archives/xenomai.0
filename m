From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH v2 5/8] net/tcp: fix TCP connection termination
Date: Tue,  6 Nov 2018 11:00:23 +0100
Message-Id: <1541498426-2916-6-git-send-email-sebastian.smolorz@gmx.de>
In-Reply-To: <1541498426-2916-1-git-send-email-sebastian.smolorz@gmx.de>
References: <1541498426-2916-1-git-send-email-sebastian.smolorz@gmx.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Closing a connected TCP socket initiates a handshake procedure. The
closing socket is supposed to receive two more packets and send one
ACK at the end. RTnet's TCP stack tries to get a reference to a
socket before writing data to its buffer. Taking a reference to an
RTnet socket in Xenomai 3 is realized by calling rtdm_fd_lock() which
fails when a socket is about to be closed.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 3242a08..c066e06 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -249,15 +249,18 @@ static struct rtsocket *rt_tcp_v4_lookup(u32 daddr, u16 dport)
 {
     rtdm_lockctx_t  context;
     struct tcp_socket *ts;
+    int ret;
 
     rtdm_lock_get_irqsave(&tcp_socket_base_lock, context);
     ts = port_hash_search(daddr, dport);
 
-    if (ts && rt_socket_reference(&ts->sock) == 0) {
-
-	rtdm_lock_put_irqrestore(&tcp_socket_base_lock, context);
+    if (ts != NULL) {
+	ret = rt_socket_reference(&ts->sock);
+	if (ret == 0 || (ret == -EIDRM && ts->is_closed)) {
+		rtdm_lock_put_irqrestore(&tcp_socket_base_lock, context);
 
-	return &ts->sock;
+		return &ts->sock;
+	}
     }
 
     rtdm_lock_put_irqrestore(&tcp_socket_base_lock, context);
-- 
2.7.4


