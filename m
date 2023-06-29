Received: from redirect.mail.gandi.net (relay13.mail.gandi.net [217.70.178.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F814AB3
	for <xenomai@lists.linux.dev>; Thu, 29 Jun 2023 20:04:47 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay13.mail.gandi.net (Postfix) with ESMTPS id 68E0F80003
	for <xenomai@lists.linux.dev>; Thu, 29 Jun 2023 20:04:39 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 04875D800F5
	for <xenomai@xenomai.org>; Thu, 29 Jun 2023 20:04:37 +0000 (UTC)
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id C12CB60138
	for <xenomai@xenomai.org>; Thu, 29 Jun 2023 22:04:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 35TK4bLc2562840
	for <xenomai@xenomai.org>; Thu, 29 Jun 2023 22:04:37 +0200
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <francois.legal@thom.fr.eu.org>
To: xenomai@xenomai.org
User-Agent: SOGoMail 5.0.1
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Thu, 29 Jun 2023 22:04:37 +0200
Subject: [PATCH v2] Make macb/gem RT driver to be built against linux 
 =?utf-8?q?>=3D?= 5.0  kernels
Message-ID: <3b7514-649de400-33-28cbfc80@10273628>
X-Forward: 192.168.253.192
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at tls-srv-03
X-Virus-Status: Clean
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of francois.legal@thom.fr.eu.org designates 2a01:e0c:1:1599::14 as permitted sender) smtp.mailfrom=francois.legal@thom.fr.eu.org;
	dmarc=none

PHY layer in upstream has changed a little after 5.0 in the way autoneg=
ociation
capabilities are encoded.
MACB platform data tend to disappear after 5.2 upstream.
Plus, ioctl prototype has changed in xenomai. RTMACB driver does not bu=
ild
anymore.

Signed-off-by: Fran=C3=A7ois LEGAL <devel@thom.fr.eu.org>
---
 kernel/drivers/net/drivers/macb.c    | 60 ++++++++++++++++++----------=

 kernel/drivers/net/drivers/rt=5Fmacb.h |  2 +-
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/dri=
vers/macb.c
index 77957d906..0648afa3b 100644
--- a/kernel/drivers/net/drivers/macb.c
+++ b/kernel/drivers/net/drivers/macb.c
@@ -132,6 +132,7 @@ void rtmacb=5Fget=5Fhwaddr(struct macb *bp)
 		bottom =3D macb=5For=5Fgem=5Freadl(bp, SA1B + i * 8);
 		top =3D macb=5For=5Fgem=5Freadl(bp, SA1T + i * 8);
 
+#if LINUX=5FVERSION=5FCODE < KERNEL=5FVERSION(5, 2, 0)
 		if (pdata && pdata->rev=5Feth=5Faddr) {
 			addr[5] =3D bottom & 0xff;
 			addr[4] =3D (bottom >> 8) & 0xff;
@@ -139,7 +140,9 @@ void rtmacb=5Fget=5Fhwaddr(struct macb *bp)
 			addr[2] =3D (bottom >> 24) & 0xff;
 			addr[1] =3D top & 0xff;
 			addr[0] =3D (top & 0xff00) >> 8;
-		} else {
+		} else
+#endif
+		{
 			addr[0] =3D bottom & 0xff;
 			addr[1] =3D (bottom >> 8) & 0xff;
 			addr[2] =3D (bottom >> 16) & 0xff;
@@ -311,10 +314,14 @@ static int macb=5Fmii=5Fprobe(struct rtnet=5Fdevi=
ce *dev)
 {
 	struct macb *bp =3D rtnetdev=5Fpriv(dev);
 	struct macb=5Fdummy=5Fnetdev=5Fpriv *p;
+#if LINUX=5FVERSION=5FCODE < KERNEL=5FVERSION(5, 2, 0)
 	struct macb=5Fplatform=5Fdata *pdata;
+	int phy=5Firq;
+#endif
 	struct phy=5Fdevice *phydev;
 	struct net=5Fdevice *dummy;
-	int phy=5Firq;
+	struct ethtool=5Flink=5Fksettings bitmap;
+	struct ethtool=5Flink=5Fksettings bitmap=5Fphy;
 	int ret;
 
 	phydev =3D phy=5Ffind=5Ffirst(bp->mii=5Fbus);
@@ -323,6 +330,7 @@ static int macb=5Fmii=5Fprobe(struct rtnet=5Fdevice=
 *dev)
 		return -ENXIO;
 	}
 
+#if LINUX=5FVERSION=5FCODE < KERNEL=5FVERSION(5, 2, 0)
 	pdata =3D dev=5Fget=5Fplatdata(&bp->pdev->dev);
 	if (pdata && gpio=5Fis=5Fvalid(pdata->phy=5Firq=5Fpin)) {
 		ret =3D devm=5Fgpio=5Frequest(&bp->pdev->dev, pdata->phy=5Firq=5Fpin=
, "phy int");
@@ -331,6 +339,7 @@ static int macb=5Fmii=5Fprobe(struct rtnet=5Fdevice=
 *dev)
 			phydev->irq =3D (phy=5Firq < 0) ? PHY=5FPOLL : phy=5Firq;
 		}
 	}
+#endif
 
 	dummy =3D alloc=5Fetherdev(sizeof(*p));
 	p =3D netdev=5Fpriv(dummy);
@@ -346,12 +355,26 @@ static int macb=5Fmii=5Fprobe(struct rtnet=5Fdevi=
ce *dev)
 	}
 
 	/* mask with MAC supported features */
-	if (macb=5Fis=5Fgem(bp))
-		phydev->supported &=3D PHY=5FGBIT=5FFEATURES;
-	else
-		phydev->supported &=3D PHY=5FBASIC=5FFEATURES;
+	if (macb=5Fis=5Fgem(bp)) {
+		ethtool=5Fconvert=5Flegacy=5Fu32=5Fto=5Flink=5Fmode(
+			bitmap.link=5Fmodes.supported, *PHY=5FGBIT=5FFEATURES);
+		memcpy(bitmap=5Fphy.link=5Fmodes.supported, phydev->supported,
+				sizeof(bitmap=5Fphy.link=5Fmodes.supported));
+		ethtool=5Fintersect=5Flink=5Fmasks(&bitmap=5Fphy, &bitmap);
+		memcpy(phydev->supported, bitmap=5Fphy.link=5Fmodes.supported,
+						sizeof(phydev->supported));
+	} else {
+		ethtool=5Fconvert=5Flegacy=5Fu32=5Fto=5Flink=5Fmode(
+			bitmap.link=5Fmodes.supported, *PHY=5FBASIC=5FFEATURES);
+		memcpy(bitmap=5Fphy.link=5Fmodes.supported, phydev->supported,
+				sizeof(bitmap=5Fphy.link=5Fmodes.supported));
+		ethtool=5Fintersect=5Flink=5Fmasks(&bitmap=5Fphy, &bitmap);
+		memcpy(phydev->supported, bitmap=5Fphy.link=5Fmodes.supported,
+						sizeof(phydev->supported));
+	}
 
-	phydev->advertising =3D phydev->supported;
+	memcpy(phydev->advertising, phydev->supported,
+				sizeof(phydev->supported));
 
 	bp->link =3D 0;
 	bp->speed =3D 0;
@@ -385,12 +408,6 @@ int rtmacb=5Fmii=5Finit(struct macb *bp)
 	bp->mii=5Fbus->parent =3D &bp->pdev->dev;
 	pdata =3D dev=5Fget=5Fplatdata(&bp->pdev->dev);
 
-	bp->mii=5Fbus->irq =3D kmalloc(sizeof(int)*PHY=5FMAX=5FADDR, GFP=5FKE=
RNEL);
-	if (!bp->mii=5Fbus->irq) {
-		err =3D -ENOMEM;
-		goto err=5Fout=5Ffree=5Fmdiobus;
-	}
-
 	np =3D bp->pdev->dev.of=5Fnode;
 	if (np) {
 		/* try dt phy registration */
@@ -434,8 +451,6 @@ int rtmacb=5Fmii=5Finit(struct macb *bp)
 err=5Fout=5Funregister=5Fbus:
 	mdiobus=5Funregister(bp->mii=5Fbus);
 err=5Fout=5Ffree=5Fmdio=5Firq:
-	kfree(bp->mii=5Fbus->irq);
-err=5Fout=5Ffree=5Fmdiobus:
 	mdiobus=5Ffree(bp->mii=5Fbus);
 err=5Fout:
 	return err;
@@ -1532,7 +1547,7 @@ struct net=5Fdevice=5Fstats *rtmacb=5Fget=5Fstats=
(struct rtnet=5Fdevice *dev)
 }
 EXPORT=5FSYMBOL=5FGPL(rtmacb=5Fget=5Fstats);
 
-int rtmacb=5Fioctl(struct rtnet=5Fdevice *dev, unsigned cmd, void *rq)=

+int rtmacb=5Fioctl(struct rtnet=5Fdevice *dev, struct ifreq *rq, int c=
md)
 {
 	struct macb *bp =3D rtnetdev=5Fpriv(dev);
 	struct phy=5Fdevice *phydev =3D bp->phy=5Fdev;
@@ -1551,7 +1566,7 @@ EXPORT=5FSYMBOL=5FGPL(rtmacb=5Fioctl);
 static const struct of=5Fdevice=5Fid macb=5Fdt=5Fids[] =3D {
 	{ .compatible =3D "cdns,at32ap7000-macb" },
 	{ .compatible =3D "cdns,at91sam9260-macb" },
-	{ .compatible =3D "cdns,macb" },
+	{ .compatible =3D "cdns,macb=5Frt" },
 	{ .compatible =3D "cdns,pc302-gem" },
 	{ .compatible =3D "cdns,gem" },
 	{ .compatible =3D "atmel,sama5d3-gem" },
@@ -1562,7 +1577,9 @@ MODULE=5FDEVICE=5FTABLE(of, macb=5Fdt=5Fids);
 
 static int =5F=5Finit macb=5Fprobe(struct platform=5Fdevice *pdev)
 {
+#if LINUX=5FVERSION=5FCODE < KERNEL=5FVERSION(5, 2, 0)
 	struct macb=5Fplatform=5Fdata *pdata;
+#endif
 	struct resource *regs;
 	struct rtnet=5Fdevice *dev;
 	struct macb *bp;
@@ -1695,12 +1712,13 @@ static int =5F=5Finit macb=5Fprobe(struct platf=
orm=5Fdevice *pdev)
 	if (err)
 #else
 	mac =3D of=5Fget=5Fmac=5Faddress(pdev->dev.of=5Fnode);
-	if (mac)
+	if (!IS=5FERR=5FOR=5FNULL(mac))
 		memcpy(bp->dev->dev=5Faddr, mac, ETH=5FALEN);
 	else
 #endif
 		rtmacb=5Fget=5Fhwaddr(bp);
 
+#if LINUX=5FVERSION=5FCODE < KERNEL=5FVERSION(5, 2, 0)
 	err =3D of=5Fget=5Fphy=5Fmode(pdev->dev.of=5Fnode);
 	if (err < 0) {
 		pdata =3D dev=5Fget=5Fplatdata(&pdev->dev);
@@ -1711,6 +1729,7 @@ static int =5F=5Finit macb=5Fprobe(struct platfor=
m=5Fdevice *pdev)
 	} else {
 		bp->phy=5Finterface =3D err;
 	}
+#endif
 
 	if (bp->phy=5Finterface =3D=3D PHY=5FINTERFACE=5FMODE=5FRGMII)
 		macb=5For=5Fgem=5Fwritel(bp, USRIO, GEM=5FBIT(RGMII));
@@ -1748,7 +1767,7 @@ static int =5F=5Finit macb=5Fprobe(struct platfor=
m=5Fdevice *pdev)
 
 	phydev =3D bp->phy=5Fdev;
 	rtdev=5Finfo(dev, "attached PHY driver [%s] (mii=5Fbus:phy=5Faddr=3D%=
s, irq=3D%d)\n",
-		    phydev->drv->name, dev=5Fname(&phydev->dev), phydev->irq);
+		phydev->drv->name, dev=5Fname(&phydev->mdio.dev), phydev->irq);
 
 	return 0;
 
@@ -1783,7 +1802,6 @@ static int =5F=5Fexit macb=5Fremove(struct platfo=
rm=5Fdevice *pdev)
 		mdiobus=5Funregister(bp->mii=5Fbus);
 		if (bp->phy=5Fphony=5Fnet=5Fdevice)
 			free=5Fnetdev(bp->phy=5Fphony=5Fnet=5Fdevice);
-		kfree(bp->mii=5Fbus->irq);
 		rt=5Frtdev=5Fdisconnect(dev);
 		rtdm=5Firq=5Ffree(&bp->irq=5Fhandle);
 		mdiobus=5Ffree(bp->mii=5Fbus);
@@ -1801,7 +1819,7 @@ static int =5F=5Fexit macb=5Fremove(struct platfo=
rm=5Fdevice *pdev)
 static struct platform=5Fdriver macb=5Fdriver =3D {
 	.remove		=3D =5F=5Fexit=5Fp(macb=5Fremove),
 	.driver		=3D {
-		.name		=3D "macb",
+		.name		=3D "rtmacb",
 		.owner	=3D THIS=5FMODULE,
 		.of=5Fmatch=5Ftable	=3D of=5Fmatch=5Fptr(macb=5Fdt=5Fids),
 	},
diff --git a/kernel/drivers/net/drivers/rt=5Fmacb.h b/kernel/drivers/ne=
t/drivers/rt=5Fmacb.h
index 53b9607ae..a16985941 100644
--- a/kernel/drivers/net/drivers/rt=5Fmacb.h
+++ b/kernel/drivers/net/drivers/rt=5Fmacb.h
@@ -611,7 +611,7 @@ struct macb {
 extern const struct ethtool=5Fops macb=5Fethtool=5Fops;
 
 int rtmacb=5Fmii=5Finit(struct macb *bp);
-int rtmacb=5Fioctl(struct rtnet=5Fdevice *dev, unsigned cmd, void *arg=
);
+int rtmacb=5Fioctl(struct rtnet=5Fdevice *dev, struct ifreq *rq, int c=
md);
 struct net=5Fdevice=5Fstats *rtmacb=5Fget=5Fstats(struct rtnet=5Fdevic=
e *dev);
 void rtmacb=5Fset=5Fhwaddr(struct macb *bp);
 void rtmacb=5Fget=5Fhwaddr(struct macb *bp);
-- 
2.20.1

