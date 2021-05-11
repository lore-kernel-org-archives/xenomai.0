From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 18/31] net/stack: increase maximum number of ethernet devices
Date: Tue, 11 May 2021 18:05:22 +0200
Message-Id: <20210511160535.26580-19-jean-baptiste.tredez@alstefgroup.com>
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

Each VLAN registers a (virtual) device.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/include/rtdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/include/rtdev.h b/kernel/drivers/net/stack/include/rtdev.h
index 27c390df5..77f142174 100644
--- a/kernel/drivers/net/stack/include/rtdev.h
+++ b/kernel/drivers/net/stack/include/rtdev.h
@@ -26,7 +26,7 @@
 #ifndef __RTDEV_H_
 #define __RTDEV_H_
 
-#define MAX_RT_DEVICES 8
+#define MAX_RT_DEVICES                  32
 
 #ifdef __KERNEL__
 
-- 
2.17.1


