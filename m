From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/5] net/stack: increase maximum number of ethernet devices
Date: Fri, 22 Mar 2019 10:59:31 +0100
Message-Id: <20190322095935.8066-2-rpm@xenomai.org>
In-Reply-To: <20190322095935.8066-1-rpm@xenomai.org>
References: <20190322095935.8066-1-rpm@xenomai.org>
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

Each VLAN registers a (virtual) device.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/include/rtdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/include/rtdev.h b/kernel/drivers/net/stack/include/rtdev.h
index 65c7ed3dc..1814b307c 100644
--- a/kernel/drivers/net/stack/include/rtdev.h
+++ b/kernel/drivers/net/stack/include/rtdev.h
@@ -26,7 +26,7 @@
 #ifndef __RTDEV_H_
 #define __RTDEV_H_
 
-#define MAX_RT_DEVICES                  8
+#define MAX_RT_DEVICES                  32
 
 #ifdef __KERNEL__
 
-- 
2.20.1


