From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] rtnet: Remove rtskbs also from mapwait list on destruction
Message-ID: <2dbbd04d-3332-5f77-9736-c21d226a64b9@web.de>
Date: Wed, 12 Jun 2019 22:48:38 +0200
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

An rtsbk that successfully went through rtdev_map_rtskb is either on
rtskb_mapped_list or rtskb_mapwait_list. On rtdev_unmap_rtskb, we
therefore have to remove the rtskb unconditionally from a list,
otherwise we corrupt its state.

This bug was easily triggerable via running smokey tests against the
loopback device.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 kernel/drivers/net/stack/rtdev.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/r=
tdev.c
index b2d0687daf..93a8e212bf 100644
=2D-- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -510,17 +510,16 @@ void rtdev_unmap_rtskb(struct rtskb *skb)
     struct rtnet_device *rtdev;
     int i;

-    if (skb->buf_dma_addr =3D=3D RTSKB_UNMAPPED)
-	return;
-
     mutex_lock(&rtnet_devices_nrt_lock);

     list_del(&skb->entry);

-    for (i =3D 0; i < MAX_RT_DEVICES; i++) {
-	rtdev =3D rtnet_devices[i];
-	if (rtdev && rtdev->unmap_rtskb) {
-	    rtdev->unmap_rtskb(rtdev, skb);
+    if (skb->buf_dma_addr !=3D RTSKB_UNMAPPED) {
+	for (i =3D 0; i < MAX_RT_DEVICES; i++) {
+	    rtdev =3D rtnet_devices[i];
+	    if (rtdev && rtdev->unmap_rtskb) {
+		rtdev->unmap_rtskb(rtdev, skb);
+	    }
 	}
     }

=2D-
2.16.4

