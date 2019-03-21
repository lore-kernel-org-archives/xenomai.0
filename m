From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 01/16] net/stack: plan for merging private device flags with
 netdev_priv_flags
Date: Thu, 21 Mar 2019 18:13:15 +0100
Message-Id: <20190321171330.2073-2-rpm@xenomai.org>
In-Reply-To: <20190321171330.2073-1-rpm@xenomai.org>
References: <20190321171330.2073-1-rpm@xenomai.org>
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
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

We need to merge regular netdev_priv_flags with our own private device
flags for the upcoming VLAN, multicast support. Pick non-conflicting
bit positions.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/include/rtdev.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/stack/include/rtdev.h b/kernel/drivers/net/stack/include/rtdev.h
index 8f8fa16b9..1102a839d 100644
--- a/kernel/drivers/net/stack/include/rtdev.h
+++ b/kernel/drivers/net/stack/include/rtdev.h
@@ -38,8 +38,13 @@
 
 #define RTDEV_VERS_2_0                  0x0200
 
-#define PRIV_FLAG_UP                    0
-#define PRIV_FLAG_ADDING_ROUTE          1
+/*
+ * We need to merge regular netdev_priv_flags with our own private
+ * device flags for VLAN, multicast support. Pick non-conflicting bit
+ * positions.
+ */
+#define PRIV_FLAG_UP                    30
+#define PRIV_FLAG_ADDING_ROUTE          31
 
 #ifndef NETIF_F_LLTX
 #define NETIF_F_LLTX                    4096
-- 
2.20.1


