From: =?UTF-8?q?Jean-Baptiste=20Tr=C3=A9dez?=
 <jean-baptiste.tredez@alstefgroup.com>
Subject: [PATCH 31/31] net/drivers: fec: remove 1ms latency on frames reception
Date: Tue, 11 May 2021 18:05:35 +0200
Message-Id: <20210511160535.26580-32-jean-baptiste.tredez@alstefgroup.com>
In-Reply-To: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
References: <20210511160535.26580-1-jean-baptiste.tredez@alstefgroup.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: abouvet <arnaud.bouvet@alstefgroup.com>

Signed-off-by: Arnaud Bouvet <arnaud.bouvet@alstefgroup.com>
Signed-off-by: Jean-Baptiste Trédez <jean-baptiste.tredez@alstefgroup.com>
---
 kernel/drivers/net/drivers/freescale/fec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/drivers/freescale/fec.h b/kernel/drivers/net/drivers/freescale/fec.h
index 5ab51701d..ba177fcf9 100644
--- a/kernel/drivers/net/drivers/freescale/fec.h
+++ b/kernel/drivers/net/drivers/freescale/fec.h
@@ -392,7 +392,7 @@ struct bufdesc_ex {
 #define FEC_ITR_ICFT(X)		(((X) & 0xff) << 20)
 #define FEC_ITR_ICTT(X)		((X) & 0xffff)
 #define FEC_ITR_ICFT_DEFAULT	200  /* Set 200 frame count threshold */
-#define FEC_ITR_ICTT_DEFAULT	1000 /* Set 1000us timer threshold */
+#define FEC_ITR_ICTT_DEFAULT	10   /* Set 10 us timer threshold */
 
 #define FEC_VLAN_TAG_LEN	0x04
 #define FEC_ETHTYPE_LEN		0x02
-- 
2.17.1


