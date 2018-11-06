From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH v2 7/8] net/tcp: return already copied number of bytes to
 recv() callers when peer socket terminates
Date: Tue,  6 Nov 2018 11:00:25 +0100
Message-Id: <1541498426-2916-8-git-send-email-sebastian.smolorz@gmx.de>
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

In the following situation a recv() call to a RT-TCP socket returned 0
although there was data already copied to the caller's buffer:

- S1 connects to S2
- S1 calls recv() with buffer size b1
- S2 sends data of size b2 < b1
- S1 receives the data, copies it to its buffer and waits for more data
- S2 terminates the connection
- S1 receives the FIN packet and also starts its shutdown procedure
     which includes returning from the recv() call. But instead of
     returning the number of bytes which were already copied
     it returned 0.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 134469c..828f7d1 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -1909,6 +1909,11 @@ static ssize_t rt_tcp_read(struct rtdm_fd *fd, void *buf, size_t nbyte)
 		return (copied ? copied : ret);
 
 	    case -EIDRM: /* event is destroyed */
+		if (ts->is_closed)
+			return -EBADF;
+
+		return copied;
+
 	    default:
 		if (ts->is_closed) {
 		    return -EBADF;
-- 
2.7.4


