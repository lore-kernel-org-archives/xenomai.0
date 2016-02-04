Sender: Michael Welling <mwelling79@gmail.com>
Date: Thu, 4 Feb 2016 13:58:05 -0600
From: Michael Welling <mwelling@ieee.org>
Message-ID: <20160204195805.GA31015@deathstar>
References: <20160203145146.GB25464@deathstar>
 <20160203150448.GF32138@hermes.click-hack.org>
 <20160203151802.GC25464@deathstar>
 <20160203153341.GG32138@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160203153341.GG32138@hermes.click-hack.org>
Subject: Re: [Xenomai] RT FEC net driver for IMX6Q
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Wed, Feb 03, 2016 at 04:33:41PM +0100, Gilles Chanteperdrix wrote:
> On Wed, Feb 03, 2016 at 09:18:02AM -0600, Michael Welling wrote:
> > On Wed, Feb 03, 2016 at 04:04:48PM +0100, Gilles Chanteperdrix wrote:
> > > On Wed, Feb 03, 2016 at 08:51:46AM -0600, Michael Welling wrote:
> > > > Is there any specific reason why the fec driver is restricted to the PPC
> > > > arcitecture?
> > > 
> > > In its current state, the driver does not compile for IMX6. A broken
> > > patch has been proposed, my idea is to work on RTnet core before
> > > tackling the drivers, but if a patch fixing the build for imx6 is
> > > proposed, it could be re-enabled.
> > >
> > 
> > What are the issues with the RTnet core?
> 
> The main issue is that it predates many factorizations in the Linux
> kernel code and so could be made simpler by relying on them. It open
> codes linked lists for instance, this is just a random example.
> Another issue is that keeping the drivers synchronized with their
> mainline counter-part requires a big maintenance effort.
> 
> > 
> > I just found out the hard way that the driver does not compile.
> > I will try my best to update the IMX drivers so that they build
> > with 3.18.20.
> 
> A patch has been posted here:
> https://xenomai.org/pipermail/xenomai/2016-January/035756.html
>

So I manually applied the changes posted here.

Here is what I did:

--
 
diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
index 267396c..c4a0abf 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -129,6 +129,10 @@ config XENO_DRIVERS_NET_DRV_MACB
     Driver for internal MAC-controller on AT91SAM926x microcontrollers.
     Porting by Cristiano Mantovani and Stefano Banzi (Marposs SpA).
 
+config XENO_DRIVERS_NET_DRV_FEC
+    depends on XENO_DRIVERS_NET
+    tristate "IMX FEC Ethernet"
+
 endif
 
 source "drivers/xenomai/net/drivers/experimental/Kconfig"
diff --git a/kernel/drivers/net/drivers/fec.c b/kernel/drivers/net/drivers/fec.c
index 290b765..fae9e59 100644
--- a/kernel/drivers/net/drivers/fec.c
+++ b/kernel/drivers/net/drivers/fec.c
@@ -331,7 +331,7 @@ fec_enet_start_xmit(struct rtskb *skb, struct rtnet_device *ndev)
 
 	if (!fep->link) {
 		/* Link is down or autonegotiation is in progress. */
-		printk("%s: tx link down!.\n", ndev->name);
+		pr_debug("%s: tx link down!.\n", ndev->name);
 		rtnetif_stop_queue(ndev);
 		return 1;	/* RTnet: will call kfree_rtskb() */
 	}
@@ -352,7 +352,7 @@ fec_enet_start_xmit(struct rtskb *skb, struct rtnet_device *ndev)
 		/* Ooops.  All transmit buffers are full.  Bail out.
 		 * This should not happen, since ndev->tbusy should be set.
 		 */
-		printk("%s: tx queue full!.\n", ndev->name);
+		pr_err("%s: tx queue full!.\n", ndev->name);
 		rtdm_lock_put_irqrestore(&fep->hw_lock, context);
 		return 1;	/* RTnet: will call kfree_rtskb() */
 	}
@@ -1047,7 +1047,7 @@ static int fec_enet_mii_probe(struct rtnet_device *ndev)
 
 	snprintf(phy_name, sizeof(phy_name), PHY_ID_FMT, mdio_bus_id, phy_id);
 	/* attach the mac to the phy using the dummy linux netdev */
-	phy_dev = phy_connect(fep->netdev, phy_name, &fec_enet_adjust_link, 0,
+	phy_dev = phy_connect(fep->netdev, phy_name, &fec_enet_adjust_link,
 			      fep->phy_interface);
 	if (IS_ERR(phy_dev)) {
 		printk(KERN_ERR "%s: could not attach to PHY\n", ndev->name);
@@ -1266,7 +1266,7 @@ static int fec_enet_alloc_buffers(struct rtnet_device *ndev)
 
 	bdp = fep->rx_bd_base;
 	for (i = 0; i < RX_RING_SIZE; i++) {
-		skb = rtnetdev_alloc_rtskb(netdev, FEC_ENET_RX_FRSIZE); /* RTnet */
+		skb = rtnetdev_alloc_rtskb(ndev, FEC_ENET_RX_FRSIZE); /* RTnet */
 		if (!skb) {
 			fec_enet_free_buffers(ndev);
 			return -ENOMEM;

--

I tried following the instructions on the RTnet installation guide to test loopback:
https://xenomai.org/rtnet-installation/

--

root@somimx6:/usr/xenomai/sbin# ./rtnet start
[ 2913.814896] 
[ 2913.814896] *** RTnet for Xenomai v3.0.1 ***
[ 2913.814896] 
[ 2913.822171] RTnet: initialising real-time networking
[ 2913.882229] ------------[ cut here ]------------
[ 2913.886887] WARNING: CPU: 2 PID: 737 at /home/michael/projects/xenomai/imx_xeno/linux-3.18.20/arch/arm/kernel/ipipe.c:158 ipipe_set_irq_affinity+0xa8/0xe8()
[ 2913.900941] Modules linked in: rt_fec(+) rtipv4 rtnet
[ 2913.906108] CPU: 2 PID: 737 Comm: modprobe Not tainted 3.18.20 #4
[ 2913.912233] Backtrace: 
[ 2913.914724] [<80012a88>] (dump_backtrace) from [<80012c94>] (show_stack+0x18/0x1c)
[ 2913.922326]  r6:80a0a60c r5:00000000 r4:00000000 r3:00000000
[ 2913.928082] [<80012c7c>] (show_stack) from [<807061d4>] (dump_stack+0x8c/0xa4)
[ 2913.935353] [<80706148>] (dump_stack) from [<8002c148>] (warn_slowpath_common+0x70/0x94)
[ 2913.943470]  r6:8001ba5c r5:00000009 r4:00000000 r3:00000000
[ 2913.949212] [<8002c0d8>] (warn_slowpath_common) from [<8002c210>] (warn_slowpath_null+0x24/0x2c)
[ 2913.958028]  r8:bdae0ea8 r7:bdae0d60 r6:be189000 r5:bdae0ec8 r4:80a481e1
[ 2913.964852] [<8002c1ec>] (warn_slowpath_null) from [<8001ba5c>] (ipipe_set_irq_affinity+0xa8/0xe8)
[ 2913.973861] [<8001b9b4>] (ipipe_set_irq_affinity) from [<800a6dfc>] (xnintr_attach+0x34/0xdc)
[ 2913.982418]  r4:bdae0ea8
[ 2913.984985] [<800a6dc8>] (xnintr_attach) from [<800ba784>] (rtdm_irq_request+0x50/0x7c)
[ 2913.993020]  r7:bdae0d60 r6:be189000 r5:bdae0ea8 r4:bdae0ea8
[ 2913.998773] [<800ba734>] (rtdm_irq_request) from [<7f026d30>] (fec_probe+0x1dc/0x8d0 [rt_fec])
[ 2914.007419]  r5:bdae0c00 r4:bdae0ea8
[ 2914.011059] [<7f026b54>] (fec_probe [rt_fec]) from [<803a3edc>] (platform_drv_probe+0x4c/0xac)
[ 2914.019719]  r10:bd894008 r9:be04a580 r8:00000007 r7:fffffdfb r6:7f027b98 r5:be189010
[ 2914.027665]  r4:80b15b68
[ 2914.030231] [<803a3e90>] (platform_drv_probe) from [<803a2460>] (really_probe+0x80/0x214)
[ 2914.038438]  r7:7f027b98 r6:00000000 r5:be189010 r4:80b15b68
[ 2914.044206] [<803a23e0>] (really_probe) from [<803a26f0>] (__driver_attach+0xa0/0xa4)
[ 2914.052041]  r8:809f3fe0 r7:00000000 r6:be189044 r5:7f027b98 r4:be189010 r3:00000007
[ 2914.059916] [<803a2650>] (__driver_attach) from [<803a0934>] (bus_for_each_dev+0x74/0xa8)
[ 2914.068123]  r6:803a2650 r5:7f027b98 r4:00000000 r3:00001eed
[ 2914.073887] [<803a08c0>] (bus_for_each_dev) from [<803a2030>] (driver_attach+0x20/0x28)
[ 2914.081895]  r6:80a16f70 r5:bd116000 r4:7f027b98
[ 2914.086601] [<803a2010>] (driver_attach) from [<803a1ce4>] (bus_add_driver+0x148/0x1f4)
[ 2914.094644] [<803a1b9c>] (bus_add_driver) from [<803a2da8>] (driver_register+0x80/0x100)
[ 2914.102771]  r7:00000000 r6:7f02a000 r5:809f3fe0 r4:7f027b98
[ 2914.108513] [<803a2d28>] (driver_register) from [<803a3e14>] (__platform_driver_register+0x50/0x64)
[ 2914.117588]  r5:809f3fe0 r4:bd895f48
[ 2914.121229] [<803a3dc4>] (__platform_driver_register) from [<7f02a018>] (fec_driver_init+0x18/0x24 [rt_fec])
[ 2914.131104] [<7f02a000>] (fec_driver_init [rt_fec]) from [<80008c7c>] (do_one_initcall+0x88/0x1d0)
[ 2914.140111] [<80008bf4>] (do_one_initcall) from [<8008a374>] (load_module+0x1824/0x1f84)
[ 2914.148232]  r10:7f027c6c r9:bda44008 r8:7f027c78 r7:00000001 r6:bda44000 r5:00000001
[ 2914.156180]  r4:bd895f48
[ 2914.158743] [<80088b50>] (load_module) from [<8008ac3c>] (SyS_finit_module+0x70/0x80)
[ 2914.166602]  r10:00000000 r9:bd894000 r8:8000f228 r7:0000017b r6:00eb9200 r5:00000003
[ 2914.174544]  r4:00000000
[ 2914.177110] [<8008abcc>] (SyS_finit_module) from [<8000efc0>] (ret_fast_syscall+0x0/0x38)
[ 2914.185316]  r6:00000000 r5:00000000 r4:00eb9200
[ 2914.189995] ---[ end trace 9b70cb5c60d4bcca ]---
[ 2914.205019] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[ 2914.211649] [drm] No driver support for vblank timestamp query.
[ 2914.217993] imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
[ 2914.225511] imx-drm display-subsystem: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
[ 2914.233196] imx-drm display-subsystem: bound imx-ipuv3-crtc.4 (ops ipu_crtc_ops)
[ 2914.240718] imx-drm display-subsystem: bound imx-ipuv3-crtc.5 (ops ipu_crtc_ops)
[ 2914.248669] imx-hdmi 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
[ 2914.255991] imx-drm display-subsystem: bound 120000.hdmi (ops hdmi_ops)
[ 2914.262981] /soc/aips-bus@02000000/ldb@020e0008/lvds-channel@0: could not find display-timings node
[ 2914.272043] /soc/aips-bus@02000000/ldb@020e0008/lvds-channel@0: no timings specified
[ 2914.279922] imx-drm display-subsystem: failed to bind 2000000.aips-bus:ldb@020e0008 (ops imx_ldb_ops): -517
[ 2914.291233] libphy: fec_enet_mii_bus: probed
[ 2914.292327] imx-drm display-subsystem: master bind failed: -517
[ 2914.292355] platform 120000.hdmi: Driver imx-hdmi requests probe deferral
[ 2914.308282] RTnet: registered rteth0
[ 2914.314440] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[ 2914.321072] [drm] No driver support for vblank timestamp query.
[ 2914.327423] imx-drm display-subsystem: bound imx-ipuv3-crtc.0 (ops ipu_crtc_ops)
[ 2914.335989] imx-drm display-subsystem: bound imx-ipuv3-crtc.1 (ops ipu_crtc_ops)
[ 2914.343787] imx-drm display-subsystem: bound imx-ipuv3-crtc.4 (ops ipu_crtc_ops)
[ 2914.352408] imx-drm display-subsystem: bound imx-ipuv3-crtc.5 (ops ipu_crtc_ops)
[ 2914.359263] initializing loopback...
[ 2914.359313] RTnet: registered rtlo
[ 2914.367364] imx-hdmi 120000.hdmi: Detected HDMI controller 0x13:0xa:0xa0:0xc1
[ 2914.374764] imx-drm display-subsystem: bound 120000.hdmi (ops hdmi_ops)
[ 2914.380043] RTcfg: init real-time configuration distribution protocol
[ 2914.387992] /soc/aips-bus@02000000/ldb@020e0008/lvds-channel@0: could not find display-timings node
[ 2914.394963] RTmac: init realtime media access control
[ 2914.402225] /soc/aips-bus@02000000/ldb@020e0008/lvds-channel@0: no timings specified
[ 2914.408727] RTmac/TDMA: init time division multiple access control mechanism
[ 2914.417186] imx-drm display-subsystem: failed to bind 2000000.aips-bus:ldb@020e0008 (ops imx_ldb_ops): -517
[ 2914.427914] imx-drm display-subsystem: master bind failed: -517
[ 2914.433925] platform 120000.hdmi: Driver imx-hdmi requests probe deferral
[ 2914.492899] rteth0: Freescale FEC PHY driver [Micrel KSZ9031 Gigabit PHY] (mii_bus:phy_addr=2188000.ethernet:01, irq=-1)
Waiting for all slaves...[ 2918.492619] rt_fec 2188000.ethernet (unnamed net_device) (uninitialized): Link is Up - 1Gbps/Full - flow control rx/tx
^C
root@somimx6:/usr/xenomai/sbin# lsmod
Module                  Size  Used by
tdma                   29250  1 
rtmac                  10739  1 tdma
rtcfg                  36854  0 
rt_loopback             1110  1 
rtpacket                8028  0 
rtudp                  13866  0 
rt_fec                 14426  1 
rtipv4                 32385  2 rtcfg,rtudp
rtnet                  51285  8 tdma,rtcfg,rtmac,rtudp,rtpacket,rt_fec,rtipv4,rt_loopback
root@somimx6:/usr/xenomai/sbin# ./rtifconfig
rteth0    Medium: Ethernet  Hardware address: 00:14:2D:00:01:02
          IP address: 127.0.0.2  Broadcast address: 127.0.0.255
          UP BROADCAST RUNNING  MTU: 1500
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5501 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 
          RX bytes:0 (0.0 b)  TX bytes:232483 (227.0 Kb)

rtlo      Medium: Local Loopback
          IP address: 127.0.0.1  
          UP LOOPBACK RUNNING  MTU: 1500

root@somimx6:/usr/xenomai/sbin# ./rtping 127.0.0.1
Real-time PING 127.0.0.1 56(84) bytes of data.
ioctl: Resource temporarily unavailable

--

What is the reason for the stacktrace?

What would cause the ioctl to fail?

strace shows the it is an ioctl to /dev/rtnet
open("/dev/rtnet", O_RDWR)              = 3
...
ioctl(3, 0xc0500285, 0x11d60)           = -1 EAGAIN (Resource temporarily unavailable)
...

> -- 
> 					    Gilles.
> https://click-hack.org

