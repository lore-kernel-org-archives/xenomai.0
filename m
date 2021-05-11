From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 09/31] net/stack: rtskb: increase buffer size
Date: Tue, 11 May 2021 18:05:13 +0200
Message-Id: <20210511160535.26580-10-jean-baptiste.tredez@alstefgroup.com>
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

The largest packet size an IGB device can handle is 2k. Since we have
a fixed buffer size, we need to accomodate for this.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 kernel/drivers/net/stack/include/rtskb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/include/rtskb.h b/kernel/drivers/net/stack/include/rtskb.h
index 4920b3916..8f0294fe3 100644
--- a/kernel/drivers/net/stack/include/rtskb.h
+++ b/kernel/drivers/net/stack/include/rtskb.h
@@ -269,7 +269,7 @@ struct rtskb_prio_queue {
 #define DEFAULT_SOCKET_RTSKBS 16 /* default number of rtskb's in socket pools */
 
 #define ALIGN_RTSKB_STRUCT_LEN SKB_DATA_ALIGN(sizeof(struct rtskb))
-#define RTSKB_SIZE 1544 /* maximum needed by pcnet32-rt */
+#define RTSKB_SIZE                  (2048 + NET_IP_ALIGN)    /* maximum needed by igb */
 
 extern unsigned int rtskb_pools; /* current number of rtskb pools      */
 extern unsigned int rtskb_pools_max; /* maximum number of rtskb pools      */
-- 
2.17.1


