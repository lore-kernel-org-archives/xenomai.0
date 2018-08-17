References: <004e01d43564$4970d4c0$dc527e40$@sepro-group.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f5ec79d7-be26-3d87-8d1b-8714d4f3a14a@xenomai.org>
Date: Fri, 17 Aug 2018 10:27:51 +0200
MIME-Version: 1.0
In-Reply-To: <004e01d43564$4970d4c0$dc527e40$@sepro-group.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] RTNet - how to setup rt_fec on IMX6Q (Xenomai 3.0.7)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Reichert?= <sreichert@sepro-group.com>, xenomai@xenomai.org

On 08/16/2018 03:23 PM, Stéphane Reichert wrote:
> Hello,
> 
> 
> 
> We are trying to use the rt_fec driver for RTNet on a iMX6Q board.
> 
> 
> 
> I have patched the KConfig to add this driver on buildroot and it compiles
> perfectly.
> 
> 
> 
> But now, I am not able to use it on our board (it works when I rtping
> the loopback,
> 
> but it doesnt work if I try to ping an external board).

The fec driver does not seem to tell the stack about the carrier enable
state. If so, you may want to try the following patch:

diff --git a/kernel/drivers/net/drivers/fec.c
b/kernel/drivers/net/drivers/fec.c
index 36870ba16..d94ec690f 100644
--- a/kernel/drivers/net/drivers/fec.c
+++ b/kernel/drivers/net/drivers/fec.c
@@ -1323,6 +1323,7 @@ fec_enet_open(struct rtnet_device *ndev)
 		return ret;
 	}
 	phy_start(fep->phy_dev);
+	rtnetif_carrier_on(ndev);
 	rtnetif_start_queue(ndev);
 	fep->opened = 1;
 	return 0;

-- 
Philippe.

