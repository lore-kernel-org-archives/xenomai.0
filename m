From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 02/31] net/stack: plan for merging private device flags with
 netdev_priv_flags
Date: Tue, 11 May 2021 18:05:06 +0200
Message-Id: <20210511160535.26580-3-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

We need to merge regular netdev_priv_flags with our own private device
flags for the upcoming VLAN, multicast support. Pick non-conflicting
bit positions.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/include/rtdev.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtdev.h b/kernel/drivers/net/stack/include/rtdev.h
index a4d963fcb..3a9f6f8ee 100644
--- a/kernel/drivers/net/stack/include/rtdev.h
+++ b/kernel/drivers/net/stack/include/rtdev.h
@@ -38,8 +38,13 @@
 
 #define RTDEV_VERS_2_0 0x0200
 
-#define PRIV_FLAG_UP 0
-#define PRIV_FLAG_ADDING_ROUTE 1
+/*
+ * We need to merge regular netdev_priv_flags with our own private
+ * device flags for VLAN, multicast support. Pick non-conflicting bit
+ * positions.
+ */
+#define PRIV_FLAG_UP                    30
+#define PRIV_FLAG_ADDING_ROUTE          31
 
 #ifndef NETIF_F_LLTX
 #define NETIF_F_LLTX 4096
-- 
2.17.1


