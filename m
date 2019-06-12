From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] rtnet: Fix leak on failing rtdev_map_rtskb in
 rtskb_pool_extend
Message-ID: <fb545582-df5a-f1d6-1ddb-51ad840fc32a@web.de>
Date: Wed, 12 Jun 2019 22:49:18 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

We need to free the previously allocated rtskb to the kmem-cache if
mapping fails. Otherwise, that resource leaks.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 kernel/drivers/net/stack/rtskb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/drivers/net/stack/rtskb.c b/kernel/drivers/net/stack/r=
tskb.c
index a19ef9f2dc..50611fba04 100644
=2D-- a/kernel/drivers/net/stack/rtskb.c
+++ b/kernel/drivers/net/stack/rtskb.c
@@ -397,8 +397,10 @@ unsigned int rtskb_pool_extend(struct rtskb_pool *poo=
l,
 	skb->buf_end =3D skb->buf_start + SKB_DATA_ALIGN(RTSKB_SIZE) - 1;
 #endif

-	if (rtdev_map_rtskb(skb) < 0)
+	if (rtdev_map_rtskb(skb) < 0) {
+	    kmem_cache_free(rtskb_slab_pool, skb);
 	    break;
+	}

 	rtskb_queue_tail(&pool->queue, skb);

=2D-
2.16.4

