From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 4/4] drivers/net/r8169: Remove duplicate and usused ether_crc
 definition
Date: Sun, 11 Apr 2021 09:54:21 +0200
Message-Id: <1633db1b88bc0261b9919ea63481a23489921904.1618127660.git.jan.kiszka@web.de>
In-Reply-To: <cover.1618127660.git.jan.kiszka@web.de>
References: <cover.1618127660.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Provided by linux/crc32.h as well, now causing build errors. But it was
unused anyway.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 kernel/drivers/net/drivers/r8169.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drive=
rs/r8169.c
index 6255fcb3f2..b49a15e305 100644
=2D-- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -466,7 +466,6 @@ static int rtl8169_interrupt(rtdm_irq_t *irq_handle);
 static void rtl8169_init_ring (struct rtnet_device *rtdev);
 static void rtl8169_hw_start (struct rtnet_device *rtdev);
 static int rtl8169_close (struct rtnet_device *rtdev);
-static inline u32 ether_crc (int length, unsigned char *data);
 static void rtl8169_set_rx_mode (struct rtnet_device *rtdev);
 /* static void rtl8169_tx_timeout (struct net_device *dev); */	/*** RTnet=
 ***/
 static struct net_device_stats *rtl8169_get_stats(struct rtnet_device *ne=
tdev);
@@ -1826,29 +1825,6 @@ static int rtl8169_close (struct rtnet_device *rtde=
v)



-//=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
-static unsigned const ethernet_polynomial =3D 0x04c11db7U;
-static inline u32 ether_crc (int length, unsigned char *data)
-{
-	int crc =3D -1;
-
-	while (--length >=3D 0) {
-		unsigned char current_octet =3D *data++;
-		int bit;
-		for (bit =3D 0; bit < 8; bit++, current_octet >>=3D 1)
-			crc =3D (crc << 1) ^ ((crc < 0) ^ (current_octet & 1) ? ethernet_polyn=
omial : 0);
-	}
-
-	return crc;
-}
-
-
-
-
-
-
-
-
 //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
 static void rtl8169_set_rx_mode (struct rtnet_device *rtdev)
 {
=2D-
2.26.2


