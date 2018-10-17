From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Date: Wed, 17 Oct 2018 13:31:44 +0200
Message-Id: <1539775907-5124-2-git-send-email-sebastian.smolorz@gmx.de>
In-Reply-To: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
Subject: [Xenomai] [PATCH 1/4] net/tcp: return ufd in rt_tcp_accept()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Fix compilation error in rt_tcp_accept() when returning its socket's own file
descriptor.

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index c5e42bc..c713635 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -1668,7 +1668,7 @@ static int rt_tcp_accept(struct tcp_socket *ts, struct sockaddr *addr,
     ts->is_accepted = 1;
     rtdm_lock_put_irqrestore(&ts->socket_lock, context);
 
-    ret = rt_socket_fd(&ts->sock)->fd;
+    ret = rtdm_fd_ufd(rt_socket_fd(&ts->sock));
 
  err:
     /* it is not critical to leave this unlocked
-- 
2.7.4


