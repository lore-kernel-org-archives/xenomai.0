From: Chris Stone <chris.stone@optelian.com>
Date: Tue, 29 May 2012 14:51:46 +0000
Message-ID: <623784B6C75D274389918D358E89E8BB0B7FDF5C@OPTELIAN5.optelian.local>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] ARM MX35 MDIO read timeout.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I am trying to debug a problem with ipipe. I am using 3.0.13 kernel with ad=
eos-ipipe-3.0.13-arm-1.18-09.patch=20
applied. The CPU is a Freescale MX35, which is an ARM11 architecture. The i=
ssue is that I get an MDIO read timeout=20
from the FEC driver. I have tried using the ipipe trace, but when I turn it=
 on, the problem goes away. I have=20
managed to discover that if I put a 300 microsecond delay into the transmit=
 path of the FEC interrupt handler,=20
the problem goes away. Thus drivers/net/fec.c has a udelay(300) in the tran=
smit interrupt handling path as follows:

static irqreturn_t
fec_enet_interrupt(int irq, void *dev_id)
{
	struct net_device *ndev =3D dev_id;
	struct fec_enet_private *fep =3D netdev_priv(ndev);
	uint int_events;
	irqreturn_t ret =3D IRQ_NONE;

	do {
		int_events =3D readl(fep->hwp + FEC_IEVENT);
		writel(int_events, fep->hwp + FEC_IEVENT);

		if (int_events & FEC_ENET_RXF) {
			ret =3D IRQ_HANDLED;
			fec_enet_rx(ndev);
		}

		/* Transmit OK, or non-fatal error. Update the buffer
		 * descriptors. FEC handles all errors, we just discover
		 * them as part of the transmit process.
		 */
		if (int_events & FEC_ENET_TXF) {
			ret =3D IRQ_HANDLED;
			fec_enet_tx(ndev);
			udelay(300);
		}

		if (int_events & FEC_ENET_MII) {
			ret =3D IRQ_HANDLED;
			complete(&fep->mdio_done);
		}
	} while (int_events);

	return ret;
}

A diff would be as follows:

diff -r d5a7342d6e47 drivers/net/fec.c
--- a/drivers/net/fec.c Tue May 29 09:58:21 2012 -0400
+++ b/drivers/net/fec.c Tue May 29 10:49:24 2012 -0400
@@ -703,6 +703,7 @@
                if (int_events & FEC_ENET_TXF) {
                        ret =3D IRQ_HANDLED;
                        fec_enet_tx(ndev);
+                       udelay(300);
                }
=20
                if (int_events & FEC_ENET_MII) {

Smaller delays don't work. I know this isn't a fix. My question is, does th=
is information give the=20
experts any ideas on what the real problem might be?

Cheers,
    Chris.

Chris Stone
Embedded Linux Architect
Optelian
1 Brewer Hunt Way
Ottawa, Ontario K2K 2B5

Phone: 613-287-2000 x2106

www.optelian.com



