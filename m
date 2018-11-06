From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Subject: [PATCH v2 3/8] net/tcp: Fix bug when obtaining RST socket's private
 structure from its rtdm_fd pointer
Date: Tue,  6 Nov 2018 11:00:21 +0100
Message-Id: <1541498426-2916-4-git-send-email-sebastian.smolorz@gmx.de>
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


