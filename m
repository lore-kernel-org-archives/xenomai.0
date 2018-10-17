From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Date: Wed, 17 Oct 2018 13:31:46 +0200
Message-Id: <1539775907-5124-4-git-send-email-sebastian.smolorz@gmx.de>
In-Reply-To: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
Subject: [Xenomai] [PATCH 3/4] net/tcp: Fix bug when obtaining RST socket's
 private structure from its rtdm_fd pointer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: Sebastian Smolorz <sebastian.smolorz@gmx.de>
---
 kernel/drivers/net/stack/ipv4/tcp/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 8605a8c..2678e6a 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -182,7 +182,7 @@ static struct {
 } rst_socket_container;
 
 #define rst_fd		(&rst_socket_container.dummy.fd)
-#define rst_socket	(*(struct tcp_socket *)rtdm_private_to_fd(rst_fd))
+#define rst_socket	(*(struct tcp_socket *)rtdm_fd_to_private(rst_fd))
 
 static u32 tcp_auto_port_start = 1024;
 static u32 tcp_auto_port_mask  = ~(RT_TCP_SOCKETS-1);
-- 
2.7.4


