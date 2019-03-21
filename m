From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 08/16] net/stack: rtskb: increase buffer size
Date: Thu, 21 Mar 2019 18:13:22 +0100
Message-Id: <20190321171330.2073-9-rpm@xenomai.org>
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

The largest packet size an IGB device can handle is 2k. Since we have
a fixed buffer size, we need to accomodate for this.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/include/rtskb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
index 36445ad08..55e3ded99 100644
--- a/kernel/drivers/net/stack/include/rtskb.h
+++ b/kernel/drivers/net/stack/include/rtskb.h
@@ -263,7 +263,7 @@ struct rtskb_prio_queue {
 #define DEFAULT_SOCKET_RTSKBS       16	/* default number of rtskb's in socket pools */
 
 #define ALIGN_RTSKB_STRUCT_LEN      SKB_DATA_ALIGN(sizeof(struct rtskb))
-#define RTSKB_SIZE                  1544	/* maximum needed by pcnet32-rt */
+#define RTSKB_SIZE                  (2048 + NET_IP_ALIGN)    /* maximum needed by igb */
 
 extern unsigned int rtskb_pools;	/* current number of rtskb pools      */
 extern unsigned int rtskb_pools_max;	/* maximum number of rtskb pools      */
-- 
2.20.1


