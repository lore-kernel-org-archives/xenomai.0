Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Date: Wed, 02 Oct 2019 15:44:33 +0200
Subject: =?utf-8?q?=5BPATCH=5D?= MABC RTNet driver to work with GEM hardware
Message-ID: <b7f-5d94aa00-4f-344a2840@235460769>
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
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

From: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>

Make MACB driver compliant with GEM hardware (as mainline linux
driver does). Main fix is about interrupt flag that is never
cleared (write 1 to clear)

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>

Subject: [PATCH] Make MACB driver compliant with GEM hardware

---
 kernel/drivers/net/drivers/Kconfig  |  7 +++++++
 kernel/drivers/net/drivers/Makefile |  1 +
 kernel/drivers/net/drivers/macb.c   | 23 ++++++++++++++++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/dr=
ivers/Kconfig
index 65f0855..39c976f 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -131,6 +131,13 @@ config XENO=5FDRIVERS=5FNET=5FDRV=5FMACB
     Driver for internal MAC-controller on AT91SAM926x microcontrollers=
.
     Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
 
+config XENO=5FDRIVERS=5FNET=5FDRV=5FGEM
+    depends on XENO=5FDRIVERS=5FNET
+    tristate "GEM devices"
+    ---help---
+    Driver for internal MAC-controller on Zynq 7000 SoCs.
+    Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
+
 endif
 
 source "drivers/xenomai/net/drivers/experimental/Kconfig"
diff --git a/kernel/drivers/net/drivers/Makefile b/kernel/drivers/net/d=
rivers/Makefile
index d95c5a8..9da1a56 100644
--- a/kernel/drivers/net/drivers/Makefile
+++ b/kernel/drivers/net/drivers/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FDRV=5FSMC91111)=
 +=3D rt=5Fsmc91111.o
 rt=5Fsmc91111-y :=3D smc91111.o
 
 obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FDRV=5FMACB) +=3D rt=5Fmacb.o
+obj-$(CONFIG=5FXENO=5FDRIVERS=5FNET=5FDRV=5FGEM) +=3D rt=5Fmacb.o
 
 rt=5Fmacb-y :=3D macb.o
 
diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/dri=
vers/macb.c
index fc5b667..ccda6ae 100644
--- a/kernel/drivers/net/drivers/macb.c
+++ b/kernel/drivers/net/drivers/macb.c
@@ -679,7 +679,13 @@ static int gem=5Frx(struct macb *bp, int budget, n=
anosecs=5Fabs=5Ft *time=5Fstamp)
 	unsigned int		entry;
 	struct rtskb		*skb;
 	struct macb=5Fdma=5Fdesc	*desc;
-	int			count =3D 0;
+	int			count =3D 0, status;
+
+	status =3D macb=5Freadl(bp, RSR);
+	macb=5Fwritel(bp, RSR, status);
+
+	if (bp->caps & MACB=5FCAPS=5FISR=5FCLEAR=5FON=5FWRITE)
+		macb=5Fwritel(bp, ISR, MACB=5FBIT(RCOMP));
 
 	while (count < budget) {
 		u32 addr, ctrl;
@@ -877,7 +883,7 @@ static int macb=5Finterrupt(rtdm=5Firq=5Ft *irq=5Fh=
andle)
 	struct rtnet=5Fdevice *dev =3D dev=5Fid;
 	struct macb *bp =3D rtnetdev=5Fpriv(dev);
 	unsigned received =3D 0;
-	u32 status;
+	u32 status, ctrl;
 
 	status =3D macb=5Freadl(bp, ISR);
 
@@ -895,9 +901,10 @@ static int macb=5Finterrupt(rtdm=5Firq=5Ft *irq=5F=
handle)
 
 		rtdev=5Fvdbg(bp->dev, "isr =3D 0x%08lx\n", (unsigned long)status);
 
-		if (status & MACB=5FRX=5FINT=5FFLAGS)
+		if (status & MACB=5FBIT(RCOMP)) {
 			received +=3D bp->macbgem=5Fops.mog=5Frx(bp, 100 - received,
 							&time=5Fstamp);
+		}
 
 		if (unlikely(status & (MACB=5FTX=5FERR=5FFLAGS))) {
 			macb=5Fwritel(bp, IDR, MACB=5FTX=5FINT=5FFLAGS);
@@ -917,6 +924,15 @@ static int macb=5Finterrupt(rtdm=5Firq=5Ft *irq=5F=
handle)
 		 * add that if/when we get our hands on a full-blown MII PHY.
 		 */
 
+		if (status & MACB=5FBIT(RXUBR)) {
+			ctrl =3D macb=5Freadl(bp, NCR);
+			macb=5Fwritel(bp, NCR, ctrl & ~MACB=5FBIT(RE));
+			macb=5Fwritel(bp, NCR, ctrl | MACB=5FBIT(RE));
+
+			if (bp->caps & MACB=5FCAPS=5FISR=5FCLEAR=5FON=5FWRITE)
+				macb=5Fwritel(bp, ISR, MACB=5FBIT(RXUBR));
+		}
+
 		if (status & MACB=5FBIT(ISR=5FROVR)) {
 			/* We missed at least one packet */
 			if (macb=5Fis=5Fgem(bp))
@@ -1320,6 +1336,7 @@ static void macb=5Fconfigure=5Fcaps(struct macb *=
bp)
 		if (GEM=5FBFEXT(IRQCOR, gem=5Freadl(bp, DCFG1)) =3D=3D 0)
 			bp->caps |=3D MACB=5FCAPS=5FISR=5FCLEAR=5FON=5FWRITE;
 	}
+	rtdev=5Fvdbg(bp->dev, "Capabilities : %X\n", bp->caps);
 }
 
 static void macb=5Finit=5Fhw(struct macb *bp)
-- 
2.1.4


