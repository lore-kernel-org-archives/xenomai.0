From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH v2 2/8] net/tcp: fix listen() and shutdown() IOCTL calls
Date: Tue,  6 Nov 2018 11:00:20 +0100
Message-Id: <1541498426-2916-3-git-send-email-sebastian.smolorz@gmx.de>
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

listen() and shutdown() pass their simple int argument directly casted to
void *arg, not as a pointer to their value.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index c713635..8605a8c 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -1790,8 +1790,6 @@ static int rt_tcp_ioctl(struct rtdm_fd *fd,
     struct _rtdm_getsockopt_args _getopt;
     const struct _rtdm_setsockopt_args *setopt;
     struct _rtdm_setsockopt_args _setopt;
-    const long *val;
-    long _val;
     int in_rt;
 
     /* fast path for common socket IOCTLs */
@@ -1815,10 +1813,7 @@ static int rt_tcp_ioctl(struct rtdm_fd *fd,
 		return rt_tcp_connect(ts, setaddr->addr, setaddr->addrlen);
 
 	case _RTIOC_LISTEN:
-		val = rtnet_get_arg(fd, &_val, arg, sizeof(long));
-		if (IS_ERR(val))
-			return PTR_ERR(val);
-		return rt_tcp_listen(ts, *val);
+		return rt_tcp_listen(ts, (unsigned long)arg);
 
 	case _RTIOC_ACCEPT:
 		if (!in_rt)
@@ -1829,10 +1824,7 @@ static int rt_tcp_ioctl(struct rtdm_fd *fd,
 		return rt_tcp_accept(ts, getaddr->addr, getaddr->addrlen);
 
 	case _RTIOC_SHUTDOWN:
-		val = rtnet_get_arg(fd, &_val, arg, sizeof(long));
-		if (IS_ERR(val))
-			return PTR_ERR(val);
-		return rt_tcp_shutdown(ts, *val);
+		return rt_tcp_shutdown(ts, (unsigned long)arg);
 
 	case _RTIOC_SETSOCKOPT:
 		setopt = rtnet_get_arg(fd, &_setopt, arg, sizeof(_setopt));
-- 
2.7.4


