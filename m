From: =?utf-8?B?TWF0w7rFoSBPbGVrxaHDoWs=?= <oleksak.matus@gmail.com>
Subject: [PATCH] Fix undefined __bad_udelay() in e1000e driver
Date: Tue, 16 Mar 2021 14:51:14 +0100
Message-ID: <9737180.GSAqmONy18@mako-notebook>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

udelay() should not be used with values over 20 000. But the first calling =
of udelay() in e1000e_phy_has_link_generic(), does not check delay value. I=
t causes compile-time trap __bad_udelay() to occur. Bug is present on all X=
enomai versions since commit 106ffba7b55d506143966ff16158ee79b0007336.

Signed-off-by: Mat=C3=BA=C5=A1 Olek=C5=A1=C3=A1k <oleksak.matus@gmail.com>
=2D--
 kernel/drivers/net/drivers/e1000e/phy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000e/phy.c b/kernel/drivers/net/d=
rivers/e1000e/phy.c
index 66ae3891a..9ec7835bc 100644
=2D-- a/kernel/drivers/net/drivers/e1000e/phy.c
+++ b/kernel/drivers/net/drivers/e1000e/phy.c
@@ -1787,13 +1787,17 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw=
, u32 iterations,
 		 * it across the board.
 		 */
 		ret_val =3D e1e_rphy(hw, PHY_STATUS, &phy_status);
=2D		if (ret_val)
+		if (ret_val) {
 			/*
 			 * If the first read fails, another entity may have
 			 * ownership of the resources, wait and try again to
 			 * see if they have relinquished the resources yet.
 			 */
=2D			udelay(usec_interval);
+			if (usec_interval >=3D 1000)
+				mdelay(usec_interval/1000);
+			else
+				udelay(usec_interval);
+		}
 		ret_val =3D e1e_rphy(hw, PHY_STATUS, &phy_status);
 		if (ret_val)
 			break;
=2D-=20
2.30.2



