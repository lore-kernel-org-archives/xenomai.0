MIME-Version: 1.0
Date: Mon, 25 Jan 2016 08:50:39 +0100
Message-ID: <CACBbF4Xxk9YNn3rbyZArwj5Fmf0sRPT=SMGKWne_qh0GHuzAmg@mail.gmail.com>
From: "LOYAU, Florian" <florian.loyau@edu.esiee.fr>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] [PATCH] kernel/drivers/net/drivers/fec: fix compile-time
	errors
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

As requested by Gilles, here's a patch fixing minor build issues with the
FEC RTnet driver for i.MX platforms. This doesn't alter Kconfig, so doesn't
reenable building it, since I believe you guys will want to make sure
everything works right before then.

Be aware that as i mentionned in the earlier mail, it doesn't seem to fully
work, as the device rx rtskb pool seems to run out after some time. However
we observed the same issues with different drivers, and they might just
have been fixed since then.

---
 kernel/drivers/net/drivers/fec.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/net/drivers/fec.c
b/kernel/drivers/net/drivers/fec.c
index 290b765..753dab7 100644
--- a/kernel/drivers/net/drivers/fec.c
+++ b/kernel/drivers/net/drivers/fec.c
@@ -1047,7 +1047,7 @@ static int fec_enet_mii_probe(struct rtnet_device
*ndev)

        snprintf(phy_name, sizeof(phy_name), PHY_ID_FMT, mdio_bus_id,
phy_id);
        /* attach the mac to the phy using the dummy linux netdev */
-       phy_dev = phy_connect(fep->netdev, phy_name, &fec_enet_adjust_link,
0,
+       phy_dev = phy_connect(fep->netdev, phy_name, &fec_enet_adjust_link,
/* 0, */
                              fep->phy_interface);
        if (IS_ERR(phy_dev)) {
                printk(KERN_ERR "%s: could not attach to PHY\n",
ndev->name);
@@ -1266,7 +1266,7 @@ static int fec_enet_alloc_buffers(struct rtnet_device
*ndev)

        bdp = fep->rx_bd_base;
        for (i = 0; i < RX_RING_SIZE; i++) {
-               skb = rtnetdev_alloc_rtskb(netdev, FEC_ENET_RX_FRSIZE); /*
RTnet */
+               skb = rtnetdev_alloc_rtskb(ndev, FEC_ENET_RX_FRSIZE); /*
RTnet */
                if (!skb) {
                        fec_enet_free_buffers(ndev);
                        return -ENOMEM;
--
1.7.10.4
