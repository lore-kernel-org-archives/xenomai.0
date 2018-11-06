From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH v2 4/8] net/tcp: Copy data back to user buffer in
 rt_tcp_recvmsg
Date: Tue,  6 Nov 2018 11:00:22 +0100
Message-Id: <1541498426-2916-5-git-send-email-sebastian.smolorz@gmx.de>
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

A bug in rt_tcp_recvmsg() prevented an application to receive data
over an RTTCP socket. Data was not copied back to the application's
buffer but rather into a temporary kernel buffer.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 2678e6a..3242a08 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -2084,17 +2084,10 @@ static ssize_t rt_tcp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg, int m
 
 	len = iov[0].iov_len;
 	if (len > 0) {
-		buf = xnmalloc(len);
-		if (buf == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		ret = rtdm_copy_from_user(fd, buf, iov[0].iov_base, len);
-		if (!ret)
-			ret = rt_tcp_read(fd, buf, len);
-		xnfree(buf);
+		buf = iov[0].iov_base;
+		ret = rt_tcp_read(fd, buf, len);
 	}
-out:
+
 	rtdm_drop_iovec(iov, iov_fast);
 
 	return ret;
-- 
2.7.4


