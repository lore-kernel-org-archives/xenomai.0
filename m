Date: Wed, 30 Sep 2015 00:39:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150929223931.GF18188@hermes.click-hack.org>
References: <1740903282.3953811.1430731145805.JavaMail.root@openwide.fr>
 <727852337.3956926.1430732646012.JavaMail.root@openwide.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727852337.3956926.1430732646012.JavaMail.root@openwide.fr>
Subject: Re: [Xenomai] Problem with the promiscuous mode of RTnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Damien Lagneux <damien.lagneux@openwide.fr>
Cc: xenomai@xenomai.org

On Mon, May 04, 2015 at 11:44:06AM +0200, Damien Lagneux wrote:
> Hi all,
> 
> I'm trying to adapt openPOWERLINK to RTnet. I'm using Xenomai 3.0-rc4,
> linux kernel 3.16.7, and the board I'm working with is an Armadeus apf6.
> 
> I have a problem with the promiscuous mode of the fec driver. It seems I 
> can only receive packets which are addressed to the board.
> 
> I'm using the raw-ethernet and eth_p_all programs to test the promiscuous
> mode. If the destination MAC address used in the raw-ethernet program 
> is the the broadcast address or the board's address, the eth_p_all program
> prints the messages. Otherwise, it doesn't print them.
> 
> I did set the interface rteth0 in promiscuous mode.
> 
> Does anyone have an idea what could the problem?

Ok, I had a closer look, and in fact, if you are really talking
about kernel/drivers/net/drivers/fec.c, setting up the hardware
filtering is done in the function set_multicast_list, but this
function is not even compiled. What you can try is to uncomment the
part of that function you are interested in, and forcibly call it at
the end of fec_enet_open, as in the following patch:

diff --git a/kernel/drivers/net/drivers/fec.c b/kernel/drivers/net/drivers/fec.c
index 8577c89..3c275ec 100644
--- a/kernel/drivers/net/drivers/fec.c
+++ b/kernel/drivers/net/drivers/fec.c
@@ -1299,6 +1299,8 @@ static int fec_enet_alloc_buffers(struct rtnet_device *ndev)
 	return 0;
 }
 
+static void set_multicast_list(struct rtnet_device *ndev)
+
 static int
 fec_enet_open(struct rtnet_device *ndev)
 {
@@ -1325,6 +1327,7 @@ fec_enet_open(struct rtnet_device *ndev)
 	phy_start(fep->phy_dev);
 	rtnetif_start_queue(ndev);
 	fep->opened = 1;
+	set_multicast_list(ndev);
 	return 0;
 }
 
@@ -1351,7 +1354,6 @@ fec_enet_close(struct rtnet_device *ndev)
 	return 0;
 }
 
-#ifdef CONFIG_XENO_DRIVERS_NET_MULTICAST
 /* Set or clear the multicast filter for this adaptor.
  * Skeleton taken from sunlance driver.
  * The CPM Ethernet implementation allows Multicast as well as individual
@@ -1383,6 +1385,7 @@ static void set_multicast_list(struct rtnet_device *ndev)
 	tmp &= ~0x8;
 	writel(tmp, fep->hwp + FEC_R_CNTRL);
 
+#ifdef CONFIG_XENO_DRIVERS_NET_MULTICAST
 	if (ndev->flags & IFF_ALLMULTI) {
 		/* Catch all multicast addresses, so set the
 		 * filter to all 1's
@@ -1425,8 +1428,8 @@ static void set_multicast_list(struct rtnet_device *ndev)
 			writel(tmp, fep->hwp + FEC_GRP_HASH_TABLE_LOW);
 		}
 	}
-}
 #endif /* CONFIG_XENO_DRIVERS_NET_MULTICAST */
+}
 
 #ifdef ORIGINAL_CODE
 /* Set a MAC change in hardware. */


Note however that I could not get that driver to compile in my build
environment. So, this patch is untested and is all I can do for now.
If you have some patches to submit to get the driver building and
working, I am interested. I will come back on this issue later.

Regards.

-- 
					    Gilles.
https://click-hack.org

