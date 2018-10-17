From: Sebastian Smolorz <sebastian.smolorz@gmx.de>
Date: Wed, 17 Oct 2018 13:31:47 +0200
Message-Id: <1539775907-5124-5-git-send-email-sebastian.smolorz@gmx.de>
In-Reply-To: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
References: <1539775907-5124-1-git-send-email-sebastian.smolorz@gmx.de>
Subject: [Xenomai] [PATCH 4/4] net/tcp: Allow choice of rttcp protocol in
 Kconfig
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
 kernel/drivers/net/stack/ipv4/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/ipv4/Kconfig b/kernel/drivers/net/stack/ipv4/Kconfig
index fef7e19..8fb3c1a 100644
--- a/kernel/drivers/net/stack/ipv4/Kconfig
+++ b/kernel/drivers/net/stack/ipv4/Kconfig
@@ -72,4 +72,4 @@ config XENO_DRIVERS_NET_RTIPV4_DEBUG
     may want to turn this on for tracing issues in packet delivery.
 
 source "drivers/xenomai/net/stack/ipv4/udp/Kconfig"
-# source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"
+source "drivers/xenomai/net/stack/ipv4/tcp/Kconfig"
-- 
2.7.4


