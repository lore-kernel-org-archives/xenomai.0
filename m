Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619E54BFF
	for <xenomai@lists.linux.dev>; Tue, 26 Mar 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711434683; cv=none; b=umRKdh/+szAKtejMyWYk1GxbAPf1nMowTTy90e1L0R40qWutiZHfBYawcorK8NEJidbiRwYW7LJAZQu4Yp/lBSW0eVIZveK8zoN9zCeMnE6/L1uzAdfsc1bGN6UE/k6rxm20gUakdM8eyOnBZ/+DRvzlhfh9y0rULqFZY+lCuzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711434683; c=relaxed/simple;
	bh=kSfWDyFAkgJxaVtb5ng1lrSKDks0JG9ewZiPml3A3gM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUQIUIlOZyvdqPPuJhGrl6iFg7SqHsVZ9SHRlVlekldP42pObNl7fRnq0MTwe2VxRdJefGtDt7qdpeQwzHTkbA/dd6A/bNFaWsqIqfU2T3no3eco0NBpZnaHgQLm5EmHk6iSVqGz0qEGZeHOytZbw82JJKv296Fwuupm+yjNUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=YpffNVtv; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="YpffNVtv"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240326063111fd194ef6ca0dd4833a
        for <xenomai@lists.linux.dev>;
        Tue, 26 Mar 2024 07:31:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=8X6/D/gVwsJVWVgnqDdbjo6/DfUq4E0x7AzOMXizKns=;
 b=YpffNVtvVh0m4VfiXJ6e/bjnVlfWWzMMNsPJxtrJDGkyz1Hov+ZO2zTjpEwc4WDsXPajjT
 +1q3EY63ayzbcQHEmi9Jtxfp1oiyC317B/aISI1ekitG/RzfxSjydveCmQtvZG+TQ5d/JfW3
 gGXYwaiJk1zO5xciSXmPSh/qF641U=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
Subject: [PATCH 22/25] drivers/net: Make private functions static
Date: Tue, 26 Mar 2024 07:31:01 +0100
Message-Id: <9e9637d1152f4600cb673b6d9a4afdd9623f8a6b.1711434664.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1711434664.git.jan.kiszka@siemens.com>
References: <cover.1711434664.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Addresses missing prototype warnings with kernel 6.8.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/addons/cap.c               | 15 +++++-----
 kernel/drivers/net/drivers/e1000e/netdev.c    |  4 +--
 .../drivers/experimental/rt2500/rt2500pci.c   | 17 ++++++-----
 kernel/drivers/net/drivers/igc/igc_main.c     |  8 ++---
 kernel/drivers/net/drivers/r8169.c            |  4 +--
 kernel/drivers/net/drivers/via-rhine.c        |  2 +-
 kernel/drivers/net/stack/ipv4/arp.c           |  2 +-
 kernel/drivers/net/stack/ipv4/icmp.c          |  8 ++---
 kernel/drivers/net/stack/ipv4/ip_output.c     | 12 ++++----
 kernel/drivers/net/stack/ipv4/ip_sock.c       | 20 ++++++++-----
 kernel/drivers/net/stack/ipv4/tcp/tcp.c       |  4 +--
 kernel/drivers/net/stack/ipv4/udp/udp.c       | 30 ++++++++++---------
 kernel/drivers/net/stack/rtcfg/rtcfg_frame.c  |  4 +--
 kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c  | 24 +++++++--------
 kernel/drivers/net/stack/rtcfg/rtcfg_module.c |  4 +--
 kernel/drivers/net/stack/rtcfg/rtcfg_proc.c   | 14 +++++----
 kernel/drivers/net/stack/rtcfg/rtcfg_timer.c  |  2 +-
 kernel/drivers/net/stack/rtdev.c              |  3 +-
 .../net/stack/rtmac/nomac/nomac_module.c      | 10 +++----
 .../net/stack/rtmac/nomac/nomac_proto.c       |  2 +-
 kernel/drivers/net/stack/rtmac/rtmac_module.c |  4 +--
 kernel/drivers/net/stack/rtmac/rtmac_proto.c  |  2 +-
 .../drivers/net/stack/rtmac/tdma/tdma_ioctl.c |  6 ++--
 .../net/stack/rtmac/tdma/tdma_module.c        | 12 ++++----
 kernel/drivers/net/stack/rtnet_module.c       |  4 +--
 kernel/drivers/net/stack/rtwlan.c             |  4 +--
 26 files changed, 116 insertions(+), 105 deletions(-)

diff --git a/kernel/drivers/net/addons/cap.c b/kernel/drivers/net/addons/cap.c
index 3784b65226..27d90f3cab 100644
--- a/kernel/drivers/net/addons/cap.c
+++ b/kernel/drivers/net/addons/cap.c
@@ -55,7 +55,7 @@ static struct tap_device_t {
 	int (*orig_xmit)(struct rtskb *skb, struct rtnet_device *dev);
 } tap_device[MAX_RT_DEVICES];
 
-void rtcap_rx_hook(struct rtskb *rtskb)
+static void rtcap_rx_hook(struct rtskb *rtskb)
 {
 	bool			trigger = false;
 
@@ -78,7 +78,7 @@ void rtcap_rx_hook(struct rtskb *rtskb)
 		rtdm_nrtsig_pend(&cap_signal);
 }
 
-int rtcap_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
+static int rtcap_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
 {
 	struct tap_device_t *tap_dev = &tap_device[rtskb->rtdev->ifindex];
 	rtdm_lockctx_t context;
@@ -113,7 +113,8 @@ int rtcap_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
 	return tap_dev->orig_xmit(rtskb, rtdev);
 }
 
-int rtcap_loopback_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
+static int rtcap_loopback_xmit_hook(struct rtskb *rtskb,
+				    struct rtnet_device *rtdev)
 {
 	struct tap_device_t *tap_dev = &tap_device[rtskb->rtdev->ifindex];
 
@@ -122,7 +123,7 @@ int rtcap_loopback_xmit_hook(struct rtskb *rtskb, struct rtnet_device *rtdev)
 	return tap_dev->orig_xmit(rtskb, rtdev);
 }
 
-void rtcap_kfree_rtskb(struct rtskb *rtskb)
+static void rtcap_kfree_rtskb(struct rtskb *rtskb)
 {
 	rtdm_lockctx_t context;
 	struct rtskb *comp_skb;
@@ -310,7 +311,7 @@ static void tap_dev_setup(struct net_device *dev)
 	dev->flags &= ~IFF_MULTICAST;
 }
 
-void cleanup_tap_devices(void)
+static void cleanup_tap_devices(void)
 {
 	int i;
 	struct rtnet_device *rtdev;
@@ -342,7 +343,7 @@ void cleanup_tap_devices(void)
 		}
 }
 
-int __init rtcap_init(void)
+static int __init rtcap_init(void)
 {
 	struct rtnet_device *rtdev;
 	struct net_device *dev;
@@ -476,7 +477,7 @@ error2:
 	return ret;
 }
 
-void rtcap_cleanup(void)
+static void rtcap_cleanup(void)
 {
 	rtdm_lockctx_t context;
 
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index ea2f65d129..dab8e9b7f3 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -472,14 +472,14 @@ exit:
 	return;
 }
 
-void e1000e_mod_watchdog_timer(rtdm_nrtsig_t *nrt_sig, void *data)
+static void e1000e_mod_watchdog_timer(rtdm_nrtsig_t *nrt_sig, void *data)
 {
 	struct timer_list *timer = data;
 
 	mod_timer(timer, jiffies + 1);
 }
 
-void e1000e_trigger_downshift(rtdm_nrtsig_t *nrt_sig, void *data)
+static void e1000e_trigger_downshift(rtdm_nrtsig_t *nrt_sig, void *data)
 {
 	struct work_struct *downshift_task = data;
 
diff --git a/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c b/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
index 9bbdce7fde..c89837a031 100644
--- a/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
+++ b/kernel/drivers/net/drivers/experimental/rt2500/rt2500pci.c
@@ -166,7 +166,7 @@ static void rt2x00_interrupt_rxdone(struct _data_ring *ring,
 	}
 }
 
-int rt2x00_interrupt(rtdm_irq_t *irq_handle)
+static int rt2x00_interrupt(rtdm_irq_t *irq_handle)
 {
 	nanosecs_abs_t time_stamp = rtdm_clock_read();
 
@@ -215,8 +215,8 @@ int rt2x00_interrupt(rtdm_irq_t *irq_handle)
 	return RTDM_IRQ_HANDLED;
 }
 
-void rt2x00_init_eeprom(struct _rt2x00_pci *rt2x00pci,
-			struct _rt2x00_config *config)
+static void rt2x00_init_eeprom(struct _rt2x00_pci *rt2x00pci,
+			       struct _rt2x00_config *config)
 {
 	u32 reg = 0x00000000;
 	u16 eeprom = 0x0000;
@@ -256,8 +256,8 @@ void rt2x00_init_eeprom(struct _rt2x00_pci *rt2x00pci,
 			rt2x00pci, EEPROM_BBP_START + eeprom);
 }
 
-void rt2x00_dev_read_mac(struct _rt2x00_pci *rt2x00pci,
-			 struct rtnet_device *rtnet_dev)
+static void rt2x00_dev_read_mac(struct _rt2x00_pci *rt2x00pci,
+				struct rtnet_device *rtnet_dev)
 {
 	u32 reg[2];
 
@@ -275,7 +275,7 @@ void rt2x00_dev_read_mac(struct _rt2x00_pci *rt2x00pci,
 	rtnet_dev->addr_len = 6;
 }
 
-int rt2x00_dev_probe(struct _rt2x00_core *core, void *priv)
+static int rt2x00_dev_probe(struct _rt2x00_core *core, void *priv)
 {
 	struct pci_dev *pci_dev = (struct pci_dev *)priv;
 	struct _rt2x00_pci *rt2x00pci = core->priv;
@@ -304,7 +304,7 @@ int rt2x00_dev_probe(struct _rt2x00_core *core, void *priv)
 	return 0;
 }
 
-int rt2x00_dev_remove(struct _rt2x00_core *core)
+static int rt2x00_dev_remove(struct _rt2x00_core *core)
 {
 	struct _rt2x00_pci *rt2x00pci = rt2x00_priv(core);
 
@@ -1163,7 +1163,8 @@ static struct _rt2x00_dev_handler rt2x00_pci_handler = {
 	.dev_xmit_packet = rt2x00_dev_xmit_packet,
 };
 
-int rt2x00_pci_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
+static int rt2x00_pci_probe(struct pci_dev *pci_dev,
+			    const struct pci_device_id *id)
 {
 	struct rtnet_device *rtnet_dev = NULL;
 	int status = 0x00000000;
diff --git a/kernel/drivers/net/drivers/igc/igc_main.c b/kernel/drivers/net/drivers/igc/igc_main.c
index 1373412287..fcd08335fa 100644
--- a/kernel/drivers/net/drivers/igc/igc_main.c
+++ b/kernel/drivers/net/drivers/igc/igc_main.c
@@ -229,8 +229,8 @@ static void igc_get_hw_control(struct igc_adapter *adapter)
 	     ctrl_ext | IGC_CTRL_EXT_DRV_LOAD);
 }
 
-void igc_unmap_and_free_tx_resource(struct igc_ring *ring,
-				    struct igc_tx_buffer *tx_buffer)
+static void igc_unmap_and_free_tx_resource(struct igc_ring *ring,
+					   struct igc_tx_buffer *tx_buffer)
 {
 	if (tx_buffer->skb) {
 		kfree_rtskb(tx_buffer->skb);
@@ -3434,7 +3434,7 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
  * @ifr: interface request data
  *
  **/
-int igc_ptp_set_ts_config(struct rtnet_device *netdev, struct ifreq *ifr)
+static int igc_ptp_set_ts_config(struct rtnet_device *netdev, struct ifreq *ifr)
 {
 	struct igc_adapter *adapter = rtnetdev_priv(netdev);
 	struct hwtstamp_config config;
@@ -3464,7 +3464,7 @@ int igc_ptp_set_ts_config(struct rtnet_device *netdev, struct ifreq *ifr)
  * to deconstruct the settings from the registers, just return a shadow copy
  * of the last known settings.
  **/
-int igc_ptp_get_ts_config(struct rtnet_device *netdev, struct ifreq *ifr)
+static int igc_ptp_get_ts_config(struct rtnet_device *netdev, struct ifreq *ifr)
 {
 	struct igc_adapter *adapter = rtnetdev_priv(netdev);
 	struct hwtstamp_config *config = &adapter->tstamp_config;
diff --git a/kernel/drivers/net/drivers/r8169.c b/kernel/drivers/net/drivers/r8169.c
index 7f280dd765..bbc5bc803a 100644
--- a/kernel/drivers/net/drivers/r8169.c
+++ b/kernel/drivers/net/drivers/r8169.c
@@ -510,7 +510,7 @@ unsigned alloc_rxskb_cnt = 0;
 //	20-16	5-bit GMII/MII register address
 //	15-0	16-bit GMII/MII register data
 //=================================================================
-void RTL8169_WRITE_GMII_REG( unsigned long ioaddr, int RegAddr, int value )
+static void RTL8169_WRITE_GMII_REG( unsigned long ioaddr, int RegAddr, int value )
 {
 	int	i;
 
@@ -528,7 +528,7 @@ void RTL8169_WRITE_GMII_REG( unsigned long ioaddr, int RegAddr, int value )
 	}// end of for() loop
 }
 //=================================================================
-int RTL8169_READ_GMII_REG( unsigned long ioaddr, int RegAddr )
+static int RTL8169_READ_GMII_REG( unsigned long ioaddr, int RegAddr )
 {
 	int i, value = -1;
 
diff --git a/kernel/drivers/net/drivers/via-rhine.c b/kernel/drivers/net/drivers/via-rhine.c
index 192f02eb6f..8407ab54af 100644
--- a/kernel/drivers/net/drivers/via-rhine.c
+++ b/kernel/drivers/net/drivers/via-rhine.c
@@ -937,7 +937,7 @@ static int alloc_ring(struct rtnet_device* dev) /*** RTnet ***/
 	return 0;
 }
 
-void free_ring(struct rtnet_device* dev) /*** RTnet ***/
+static void free_ring(struct rtnet_device* dev) /*** RTnet ***/
 {
 	struct netdev_private *np = dev->priv;
 
diff --git a/kernel/drivers/net/stack/ipv4/arp.c b/kernel/drivers/net/stack/ipv4/arp.c
index 91c151e900..45c1ddf120 100644
--- a/kernel/drivers/net/stack/ipv4/arp.c
+++ b/kernel/drivers/net/stack/ipv4/arp.c
@@ -106,7 +106,7 @@ out:
 /***
  *  arp_rcv:    Receive an arp request by the device layer.
  */
-int rt_arp_rcv(struct rtskb *skb, struct rtpacket_type *pt)
+static int rt_arp_rcv(struct rtskb *skb, struct rtpacket_type *pt)
 {
 	struct rtnet_device *rtdev = skb->rtdev;
 	struct arphdr *arp = skb->nh.arph;
diff --git a/kernel/drivers/net/stack/ipv4/icmp.c b/kernel/drivers/net/stack/ipv4/icmp.c
index cdd22beb3a..c3b80b18d0 100644
--- a/kernel/drivers/net/stack/ipv4/icmp.c
+++ b/kernel/drivers/net/stack/ipv4/icmp.c
@@ -362,7 +362,7 @@ int rt_icmp_send_echo(u32 daddr, u16 id, u16 sequence, size_t msg_size)
 /***
  *  rt_icmp_socket
  */
-int rt_icmp_socket(struct rtdm_fd *fd)
+static int rt_icmp_socket(struct rtdm_fd *fd)
 {
 	/* we don't support user-created ICMP sockets */
 	return -ENOPROTOOPT;
@@ -418,7 +418,7 @@ static struct rt_icmp_control rt_icmp_pointers[NR_ICMP_TYPES + 1] = {
 /***
  *  rt_icmp_dest_pool
  */
-struct rtsocket *rt_icmp_dest_socket(struct rtskb *skb)
+static struct rtsocket *rt_icmp_dest_socket(struct rtskb *skb)
 {
 	rt_socket_reference(icmp_socket);
 	skb->sk = icmp_socket;
@@ -428,7 +428,7 @@ struct rtsocket *rt_icmp_dest_socket(struct rtskb *skb)
 /***
  *  rt_icmp_rcv
  */
-void rt_icmp_rcv(struct rtskb *skb)
+static void rt_icmp_rcv(struct rtskb *skb)
 {
 	struct icmphdr *icmpHdr = skb->h.icmph;
 	unsigned int length = skb->len;
@@ -465,7 +465,7 @@ cleanup:
 /***
  *  rt_icmp_rcv_err
  */
-void rt_icmp_rcv_err(struct rtskb *skb)
+static void rt_icmp_rcv_err(struct rtskb *skb)
 {
 	rtdm_printk("RTnet: rt_icmp_rcv err\n");
 }
diff --git a/kernel/drivers/net/stack/ipv4/ip_output.c b/kernel/drivers/net/stack/ipv4/ip_output.c
index ccec6d5f11..91d592b5f0 100644
--- a/kernel/drivers/net/stack/ipv4/ip_output.c
+++ b/kernel/drivers/net/stack/ipv4/ip_output.c
@@ -38,12 +38,12 @@ static u16 rt_ip_id_count = 0;
 /***
  *  Slow path for fragmented packets
  */
-int rt_ip_build_xmit_slow(struct rtsocket *sk,
-			  int getfrag(const void *, unsigned char *,
-				      unsigned int, unsigned int),
-			  const void *frag, unsigned length,
-			  struct dest_route *rt, int msg_flags,
-			  unsigned int mtu, unsigned int prio)
+static int rt_ip_build_xmit_slow(struct rtsocket *sk,
+				 int getfrag(const void *, unsigned char *,
+					     unsigned int, unsigned int),
+				 const void *frag, unsigned length,
+				 struct dest_route *rt, int msg_flags,
+				 unsigned int mtu, unsigned int prio)
 {
 	int err, next_err;
 	struct rtskb *skb;
diff --git a/kernel/drivers/net/stack/ipv4/ip_sock.c b/kernel/drivers/net/stack/ipv4/ip_sock.c
index ea15d2f05a..87908ac2d0 100644
--- a/kernel/drivers/net/stack/ipv4/ip_sock.c
+++ b/kernel/drivers/net/stack/ipv4/ip_sock.c
@@ -29,8 +29,9 @@
 #include <rtnet_socket.h>
 #include <ipv4/ip_sock.h>
 
-int rt_ip_setsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
-		     int optname, const void __user *optval, socklen_t optlen)
+static int rt_ip_setsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
+			    int optname, const void __user *optval,
+			    socklen_t optlen)
 {
 	int err = 0;
 	unsigned int _tos, *tos;
@@ -58,8 +59,9 @@ int rt_ip_setsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
 	return err;
 }
 
-int rt_ip_getsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
-		     int optname, void __user *optval, socklen_t __user *optlen)
+static int rt_ip_getsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
+			    int optname, void __user *optval,
+			    socklen_t __user *optlen)
 {
 	int err = 0;
 	unsigned int tos;
@@ -90,8 +92,9 @@ int rt_ip_getsockopt(struct rtdm_fd *fd, struct rtsocket *s, int level,
 	return err;
 }
 
-int rt_ip_getsockname(struct rtdm_fd *fd, struct rtsocket *s,
-		      struct sockaddr __user *addr, socklen_t __user *addrlen)
+static int rt_ip_getsockname(struct rtdm_fd *fd, struct rtsocket *s,
+			     struct sockaddr __user *addr,
+			     socklen_t __user *addrlen)
 {
 	struct sockaddr_in _sin;
 	socklen_t *len, _len;
@@ -118,8 +121,9 @@ int rt_ip_getsockname(struct rtdm_fd *fd, struct rtsocket *s,
 	return ret;
 }
 
-int rt_ip_getpeername(struct rtdm_fd *fd, struct rtsocket *s,
-		      struct sockaddr __user *addr, socklen_t __user *addrlen)
+static int rt_ip_getpeername(struct rtdm_fd *fd, struct rtsocket *s,
+			     struct sockaddr __user *addr,
+			     socklen_t __user *addrlen)
 {
 	struct sockaddr_in _sin;
 	socklen_t *len, _len;
diff --git a/kernel/drivers/net/stack/ipv4/tcp/tcp.c b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
index 5bd1145301..8e174507cd 100644
--- a/kernel/drivers/net/stack/ipv4/tcp/tcp.c
+++ b/kernel/drivers/net/stack/ipv4/tcp/tcp.c
@@ -2395,7 +2395,7 @@ static void rt_tcp_proc_unregister(void)
 /***
  *  rt_tcp_init
  */
-int __init rt_tcp_init(void)
+static int __init rt_tcp_init(void)
 {
 	unsigned int skbs;
 	int i;
@@ -2465,7 +2465,7 @@ out_1:
 /***
  *  rt_tcp_release
  */
-void __exit rt_tcp_release(void)
+static void __exit rt_tcp_release(void)
 {
 	rt_inet_del_protocol(&tcp_protocol);
 
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index 777c8a27ac..8ace7af064 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -151,8 +151,8 @@ static inline struct rtsocket *rt_udp_v4_lookup(u32 daddr, u16 dport)
  *  @s:     socket
  *  @addr:  local address
  */
-int rt_udp_bind(struct rtdm_fd *fd, struct rtsocket *sock,
-		const struct sockaddr __user *addr, socklen_t addrlen)
+static int rt_udp_bind(struct rtdm_fd *fd, struct rtsocket *sock,
+		       const struct sockaddr __user *addr, socklen_t addrlen)
 {
 	struct sockaddr_in _sin, *sin;
 	rtdm_lockctx_t context;
@@ -206,8 +206,9 @@ unlock_out:
 /***
  *  rt_udp_connect
  */
-int rt_udp_connect(struct rtdm_fd *fd, struct rtsocket *sock,
-		   const struct sockaddr __user *serv_addr, socklen_t addrlen)
+static int rt_udp_connect(struct rtdm_fd *fd, struct rtsocket *sock,
+			  const struct sockaddr __user *serv_addr,
+			  socklen_t addrlen)
 {
 	struct sockaddr _sa, *sa;
 	struct sockaddr_in _sin, *sin;
@@ -271,7 +272,7 @@ int rt_udp_connect(struct rtdm_fd *fd, struct rtsocket *sock,
  *  rt_udp_socket - create a new UDP-Socket
  *  @s: socket
  */
-int rt_udp_socket(struct rtdm_fd *fd)
+static int rt_udp_socket(struct rtdm_fd *fd)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
 	int ret;
@@ -319,7 +320,7 @@ int rt_udp_socket(struct rtdm_fd *fd)
 /***
  *  rt_udp_close
  */
-void rt_udp_close(struct rtdm_fd *fd)
+static void rt_udp_close(struct rtdm_fd *fd)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
 	struct rtskb *del;
@@ -353,7 +354,8 @@ void rt_udp_close(struct rtdm_fd *fd)
 	rt_socket_cleanup(fd);
 }
 
-int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
+static int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request,
+			void __user *arg)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
 	struct _rtdm_setsockaddr_args args;
@@ -389,8 +391,8 @@ int rt_udp_ioctl(struct rtdm_fd *fd, unsigned int request, void __user *arg)
 /***
  *  rt_udp_recvmsg
  */
-ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
-		       int msg_flags)
+static ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
+			      int msg_flags)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
 	size_t len;
@@ -571,8 +573,8 @@ static int rt_udp_getfrag(const void *p, unsigned char *to, unsigned int offset,
 /***
  *  rt_udp_sendmsg
  */
-ssize_t rt_udp_sendmsg(struct rtdm_fd *fd, const struct user_msghdr *msg,
-		       int msg_flags)
+static ssize_t rt_udp_sendmsg(struct rtdm_fd *fd, const struct user_msghdr *msg,
+			      int msg_flags)
 {
 	struct rtsocket *sock = rtdm_fd_to_private(fd);
 	size_t len;
@@ -690,7 +692,7 @@ static inline unsigned short rt_udp_check(struct udphdr *uh, int len,
 	return (csum_tcpudp_magic(saddr, daddr, len, IPPROTO_UDP, base));
 }
 
-struct rtsocket *rt_udp_dest_socket(struct rtskb *skb)
+static struct rtsocket *rt_udp_dest_socket(struct rtskb *skb)
 {
 	struct udphdr *uh = skb->h.uh;
 	unsigned short ulen = ntohs(uh->len);
@@ -728,7 +730,7 @@ struct rtsocket *rt_udp_dest_socket(struct rtskb *skb)
 /***
  *  rt_udp_rcv
  */
-void rt_udp_rcv(struct rtskb *skb)
+static void rt_udp_rcv(struct rtskb *skb)
 {
 	struct rtsocket *sock = skb->sk;
 	void (*callback_func)(struct rtdm_fd *, void *);
@@ -750,7 +752,7 @@ void rt_udp_rcv(struct rtskb *skb)
 /***
  *  rt_udp_rcv_err
  */
-void rt_udp_rcv_err(struct rtskb *skb)
+static void rt_udp_rcv_err(struct rtskb *skb)
 {
 	rtdm_printk("RTnet: rt_udp_rcv err\n");
 }
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
index ef8f0e86ca..0c8eb7a878 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_frame.c
@@ -96,8 +96,8 @@ static void rtcfg_rx_task(void *arg)
 	}
 }
 
-int rtcfg_send_frame(struct rtskb *rtskb, struct rtnet_device *rtdev,
-		     u8 *dest_addr)
+static int rtcfg_send_frame(struct rtskb *rtskb, struct rtnet_device *rtdev,
+			    u8 *dest_addr)
 {
 	int ret;
 
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
index 34427e74fc..c280243572 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_ioctl.c
@@ -33,7 +33,7 @@
 #include <rtcfg/rtcfg_frame.h>
 #include <rtcfg/rtcfg_proc.h>
 
-int rtcfg_event_handler(struct rt_proc_call *call)
+static int rtcfg_event_handler(struct rt_proc_call *call)
 {
 	struct rtcfg_cmd *cmd_event;
 
@@ -42,7 +42,7 @@ int rtcfg_event_handler(struct rt_proc_call *call)
 				   cmd_event->internal.data.event_id, call);
 }
 
-void keep_cmd_add(struct rt_proc_call *call, void *priv_data)
+static void keep_cmd_add(struct rt_proc_call *call, void *priv_data)
 {
 	/* do nothing on error (<0), or if file already present (=0) */
 	if (rtpc_get_result(call) <= 0)
@@ -52,7 +52,7 @@ void keep_cmd_add(struct rt_proc_call *call, void *priv_data)
 	rtpc_set_cleanup_handler(call, NULL);
 }
 
-void cleanup_cmd_add(void *priv_data)
+static void cleanup_cmd_add(void *priv_data)
 {
 	struct rtcfg_cmd *cmd = (struct rtcfg_cmd *)priv_data;
 	void *buf;
@@ -76,7 +76,7 @@ void cleanup_cmd_add(void *priv_data)
 	}
 }
 
-void cleanup_cmd_del(void *priv_data)
+static void cleanup_cmd_del(void *priv_data)
 {
 	struct rtcfg_cmd *cmd = (struct rtcfg_cmd *)priv_data;
 	void *buf;
@@ -99,7 +99,7 @@ void cleanup_cmd_del(void *priv_data)
 	}
 }
 
-void copy_stage_1_data(struct rt_proc_call *call, void *priv_data)
+static void copy_stage_1_data(struct rt_proc_call *call, void *priv_data)
 {
 	struct rtcfg_cmd *cmd;
 	int result = rtpc_get_result(call);
@@ -116,7 +116,7 @@ void copy_stage_1_data(struct rt_proc_call *call, void *priv_data)
 		rtpc_set_result(call, -EFAULT);
 }
 
-void cleanup_cmd_client(void *priv_data)
+static void cleanup_cmd_client(void *priv_data)
 {
 	struct rtcfg_cmd *cmd = (struct rtcfg_cmd *)priv_data;
 	void *station_buf;
@@ -131,7 +131,7 @@ void cleanup_cmd_client(void *priv_data)
 		kfree_rtskb(rtskb);
 }
 
-void copy_stage_2_data(struct rt_proc_call *call, void *priv_data)
+static void copy_stage_2_data(struct rt_proc_call *call, void *priv_data)
 {
 	struct rtcfg_cmd *cmd;
 	int result = rtpc_get_result(call);
@@ -158,7 +158,7 @@ void copy_stage_2_data(struct rt_proc_call *call, void *priv_data)
 	}
 }
 
-void cleanup_cmd_announce(void *priv_data)
+static void cleanup_cmd_announce(void *priv_data)
 {
 	struct rtcfg_cmd *cmd = (struct rtcfg_cmd *)priv_data;
 	struct rtskb *rtskb;
@@ -168,7 +168,7 @@ void cleanup_cmd_announce(void *priv_data)
 		kfree_rtskb(rtskb);
 }
 
-void cleanup_cmd_detach(void *priv_data)
+static void cleanup_cmd_detach(void *priv_data)
 {
 	struct rtcfg_cmd *cmd = (struct rtcfg_cmd *)priv_data;
 	void *buf;
@@ -231,7 +231,7 @@ static int load_cfg_file(struct rtcfg_file *cfgfile, struct rtcfg_cmd *cmd)
 				sizeof(*cmd), NULL, cleanup_cmd_add);
 }
 
-int rtcfg_ioctl_add(struct rtnet_device *rtdev, struct rtcfg_cmd *cmd)
+static int rtcfg_ioctl_add(struct rtnet_device *rtdev, struct rtcfg_cmd *cmd)
 {
 	struct rtcfg_connection *conn_buf;
 	struct rtcfg_file *file = NULL;
@@ -320,8 +320,8 @@ err:
 	return ret;
 }
 
-int rtcfg_ioctl(struct rtnet_device *rtdev, unsigned int request,
-		unsigned long arg)
+static int rtcfg_ioctl(struct rtnet_device *rtdev, unsigned int request,
+		       unsigned long arg)
 {
 	struct rtcfg_cmd cmd;
 	struct rtcfg_station *station_buf;
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_module.c b/kernel/drivers/net/stack/rtcfg/rtcfg_module.c
index 39e96b9682..5e597e8189 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_module.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_module.c
@@ -33,7 +33,7 @@
 
 MODULE_LICENSE("GPL");
 
-int __init rtcfg_init(void)
+static int __init rtcfg_init(void)
 {
 	int ret;
 
@@ -67,7 +67,7 @@ error1:
 	return ret;
 }
 
-void rtcfg_cleanup(void)
+static void rtcfg_cleanup(void)
 {
 #ifdef CONFIG_XENO_OPT_VFILE
 	rtcfg_cleanup_proc();
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c b/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
index 2b7ad9e4be..2e138180f6 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_proc.c
@@ -49,7 +49,8 @@ static struct xnvfile_lock_ops rtnet_rtcfg_proc_lock_ops = {
 	.put = rtnet_rtcfg_proc_lock_put,
 };
 
-int rtnet_rtcfg_dev_state_show(struct xnvfile_regular_iterator *it, void *data)
+static int rtnet_rtcfg_dev_state_show(struct xnvfile_regular_iterator *it,
+				      void *data)
 {
 	struct rtcfg_device *rtcfg_dev = xnvfile_priv(it->vfile);
 	const char *state_name[] = { "OFF",
@@ -104,7 +105,8 @@ static struct xnvfile_regular_ops rtnet_rtcfg_dev_state_vfile_ops = {
 	.show = rtnet_rtcfg_dev_state_show,
 };
 
-int rtnet_rtcfg_dev_stations_show(struct xnvfile_regular_iterator *it, void *d)
+static int rtnet_rtcfg_dev_stations_show(struct xnvfile_regular_iterator *it,
+					 void *d)
 {
 	struct rtcfg_device *rtcfg_dev = xnvfile_priv(it->vfile);
 	struct rtcfg_connection *conn;
@@ -144,8 +146,8 @@ static struct xnvfile_regular_ops rtnet_rtcfg_dev_stations_vfile_ops = {
 	.show = rtnet_rtcfg_dev_stations_show,
 };
 
-int rtnet_rtcfg_dev_conn_state_show(struct xnvfile_regular_iterator *it,
-				    void *d)
+static int rtnet_rtcfg_dev_conn_state_show(struct xnvfile_regular_iterator *it,
+					   void *d)
 {
 	struct rtcfg_connection *conn = xnvfile_priv(it->vfile);
 	char *state_name[] = { "SEARCHING", "STAGE_1", "STAGE_2", "READY",
@@ -229,7 +231,7 @@ void rtcfg_remove_conn_proc_entries(int ifindex)
 		xnvfile_destroy_regular(&conn->proc_entry);
 }
 
-void rtcfg_new_rtdev(struct rtnet_device *rtdev)
+static void rtcfg_new_rtdev(struct rtnet_device *rtdev)
 {
 	struct rtcfg_device *dev = &device[rtdev->ifindex];
 	int err;
@@ -275,7 +277,7 @@ error1:
 	mutex_unlock(&nrt_proc_lock);
 }
 
-void rtcfg_remove_rtdev(struct rtnet_device *rtdev)
+static void rtcfg_remove_rtdev(struct rtnet_device *rtdev)
 {
 	struct rtcfg_device *dev = &device[rtdev->ifindex];
 
diff --git a/kernel/drivers/net/stack/rtcfg/rtcfg_timer.c b/kernel/drivers/net/stack/rtcfg/rtcfg_timer.c
index 99baf2cd71..07212c7ba5 100644
--- a/kernel/drivers/net/stack/rtcfg/rtcfg_timer.c
+++ b/kernel/drivers/net/stack/rtcfg/rtcfg_timer.c
@@ -41,7 +41,7 @@ void rtcfg_timer(rtdm_timer_t *t)
 	rtcfg_thread_signal();
 }
 
-void rtcfg_timer_run_one(int ifindex)
+static void rtcfg_timer_run_one(int ifindex)
 {
 	struct rtcfg_device *rtcfg_dev = &device[ifindex];
 	struct list_head *entry;
diff --git a/kernel/drivers/net/stack/rtdev.c b/kernel/drivers/net/stack/rtdev.c
index a5a854a563..7c50a9e9e7 100644
--- a/kernel/drivers/net/stack/rtdev.c
+++ b/kernel/drivers/net/stack/rtdev.c
@@ -275,7 +275,8 @@ EXPORT_SYMBOL_GPL(rtdev_destroy);
  *
  *  allocate memory for a new rt-network-adapter
  */
-struct rtnet_device *rtdev_alloc(unsigned sizeof_priv, unsigned dev_pool_size)
+static struct rtnet_device *rtdev_alloc(unsigned sizeof_priv,
+					unsigned dev_pool_size)
 {
 	struct rtnet_device *rtdev;
 	unsigned alloc_size;
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
index c26a6c4278..1a36e33636 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_module.c
@@ -36,7 +36,7 @@
 LIST_HEAD(nomac_devices);
 DEFINE_MUTEX(nomac_nrt_lock);
 
-int nomac_proc_read(struct xnvfile_regular_iterator *it, void *data)
+static int nomac_proc_read(struct xnvfile_regular_iterator *it, void *data)
 {
 	struct nomac_priv *entry;
 
@@ -54,7 +54,7 @@ int nomac_proc_read(struct xnvfile_regular_iterator *it, void *data)
 }
 #endif /* CONFIG_XENO_OPT_VFILE */
 
-int nomac_attach(struct rtnet_device *rtdev, void *priv)
+static int nomac_attach(struct rtnet_device *rtdev, void *priv)
 {
 	struct nomac_priv *nomac = (struct nomac_priv *)priv;
 	int ret;
@@ -77,7 +77,7 @@ int nomac_attach(struct rtnet_device *rtdev, void *priv)
 	return 0;
 }
 
-int nomac_detach(struct rtnet_device *rtdev, void *priv)
+static int nomac_detach(struct rtnet_device *rtdev, void *priv)
 {
 	struct nomac_priv *nomac = (struct nomac_priv *)priv;
 
@@ -127,7 +127,7 @@ struct rtmac_disc nomac_disc = {
 #endif /* CONFIG_XENO_OPT_VFILE */
 };
 
-int __init nomac_init(void)
+static int __init nomac_init(void)
 {
 	int ret;
 
@@ -146,7 +146,7 @@ int __init nomac_init(void)
 	return 0;
 }
 
-void nomac_release(void)
+static void nomac_release(void)
 {
 	rtmac_disc_deregister(&nomac_disc);
 	nomac_proto_cleanup();
diff --git a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
index c13c8ccf05..e9842ac5e8 100644
--- a/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
+++ b/kernel/drivers/net/stack/rtmac/nomac/nomac_proto.c
@@ -76,7 +76,7 @@ int nomac_nrt_packet_tx(struct rtskb *rtskb)
 	}
 }
 
-void nrt_xmit_task(void *arg)
+static void nrt_xmit_task(void *arg)
 {
 	struct rtskb *rtskb;
 	struct rtnet_device *rtdev;
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_module.c b/kernel/drivers/net/stack/rtmac/rtmac_module.c
index e4013e3679..0a4e1b7502 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_module.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_module.c
@@ -30,7 +30,7 @@
 #include <rtmac/rtmac_proto.h>
 #include <rtmac/rtmac_vnic.h>
 
-int __init rtmac_init(void)
+static int __init rtmac_init(void)
 {
 	int ret = 0;
 
@@ -62,7 +62,7 @@ error1:
 	return ret;
 }
 
-void rtmac_release(void)
+static void rtmac_release(void)
 {
 	rtmac_proto_release();
 	rtmac_vnic_module_cleanup();
diff --git a/kernel/drivers/net/stack/rtmac/rtmac_proto.c b/kernel/drivers/net/stack/rtmac/rtmac_proto.c
index 55e11650e6..5d9d834a13 100644
--- a/kernel/drivers/net/stack/rtmac/rtmac_proto.c
+++ b/kernel/drivers/net/stack/rtmac/rtmac_proto.c
@@ -28,7 +28,7 @@
 #include <rtmac/rtmac_proto.h>
 #include <rtmac/rtmac_vnic.h>
 
-int rtmac_proto_rx(struct rtskb *skb, struct rtpacket_type *pt)
+static int rtmac_proto_rx(struct rtskb *skb, struct rtpacket_type *pt)
 {
 	struct rtmac_disc *disc = skb->rtdev->mac_disc;
 	struct rtmac_hdr *hdr;
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
index f0fa353803..02230064d7 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_ioctl.c
@@ -202,7 +202,7 @@ static int tdma_ioctl_cal_result_size(struct rtnet_device *rtdev,
 		return 0;
 }
 
-int start_calibration(struct rt_proc_call *call)
+static int start_calibration(struct rt_proc_call *call)
 {
 	struct tdma_request_cal *req_cal;
 	struct tdma_priv *tdma;
@@ -221,7 +221,7 @@ int start_calibration(struct rt_proc_call *call)
 	return -CALL_PENDING;
 }
 
-void copyback_calibration(struct rt_proc_call *call, void *priv_data)
+static void copyback_calibration(struct rt_proc_call *call, void *priv_data)
 {
 	struct tdma_request_cal *req_cal;
 	struct tdma_priv *tdma;
@@ -260,7 +260,7 @@ void copyback_calibration(struct rt_proc_call *call, void *priv_data)
 	       (unsigned long)average, (unsigned long)min, (unsigned long)max);
 }
 
-void cleanup_calibration(void *priv_data)
+static void cleanup_calibration(void *priv_data)
 {
 	struct tdma_request_cal *req_cal;
 
diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
index e25ad532a2..2269fa2d9f 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
@@ -37,7 +37,7 @@
 #include <rtmac/tdma/tdma_worker.h>
 
 #ifdef CONFIG_XENO_OPT_VFILE
-int tdma_proc_read(struct xnvfile_regular_iterator *it, void *data)
+static int tdma_proc_read(struct xnvfile_regular_iterator *it, void *data)
 {
 	int d, err = 0;
 	struct rtnet_device *rtdev;
@@ -101,7 +101,7 @@ int tdma_proc_read(struct xnvfile_regular_iterator *it, void *data)
 	return err;
 }
 
-int tdma_slots_proc_read(struct xnvfile_regular_iterator *it, void *data)
+static int tdma_slots_proc_read(struct xnvfile_regular_iterator *it, void *data)
 {
 	int d, i, err = 0;
 	struct rtnet_device *rtdev;
@@ -183,7 +183,7 @@ int tdma_slots_proc_read(struct xnvfile_regular_iterator *it, void *data)
 }
 #endif /* CONFIG_XENO_OPT_VFILE */
 
-int tdma_attach(struct rtnet_device *rtdev, void *priv)
+static int tdma_attach(struct rtnet_device *rtdev, void *priv)
 {
 	struct tdma_priv *tdma = (struct tdma_priv *)priv;
 	int ret;
@@ -221,7 +221,7 @@ err_out1:
 	return ret;
 }
 
-int tdma_detach(struct rtnet_device *rtdev, void *priv)
+static int tdma_detach(struct rtnet_device *rtdev, void *priv)
 {
 	struct tdma_priv *tdma = (struct tdma_priv *)priv;
 	struct tdma_job *job, *tmp;
@@ -289,7 +289,7 @@ struct rtmac_disc tdma_disc = {
 #endif /* CONFIG_XENO_OPT_VFILE */
 };
 
-int __init tdma_init(void)
+static int __init tdma_init(void)
 {
 	int ret;
 
@@ -303,7 +303,7 @@ int __init tdma_init(void)
 	return 0;
 }
 
-void tdma_release(void)
+static void tdma_release(void)
 {
 	rtmac_disc_deregister(&tdma_disc);
 
diff --git a/kernel/drivers/net/stack/rtnet_module.c b/kernel/drivers/net/stack/rtnet_module.c
index f16becafef..c245502cd0 100644
--- a/kernel/drivers/net/stack/rtnet_module.c
+++ b/kernel/drivers/net/stack/rtnet_module.c
@@ -315,7 +315,7 @@ static void rtnet_proc_unregister(void)
 /**
  *  rtnet_init()
  */
-int __init rtnet_init(void)
+static int __init rtnet_init(void)
 {
 	int err = 0;
 
@@ -388,7 +388,7 @@ err_out1:
 /**
  *  rtnet_release()
  */
-void __exit rtnet_release(void)
+static void __exit rtnet_release(void)
 {
 	rtnet_corectl_unregister();
 
diff --git a/kernel/drivers/net/stack/rtwlan.c b/kernel/drivers/net/stack/rtwlan.c
index 26e9262090..6b2644825b 100644
--- a/kernel/drivers/net/stack/rtwlan.c
+++ b/kernel/drivers/net/stack/rtwlan.c
@@ -116,8 +116,8 @@ struct rtnet_device *rtwlan_alloc_dev(unsigned sizeof_priv,
 
 EXPORT_SYMBOL_GPL(rtwlan_alloc_dev);
 
-int rtwlan_ioctl(struct rtnet_device *rtdev, unsigned int request,
-		 unsigned long arg)
+static int rtwlan_ioctl(struct rtnet_device *rtdev, unsigned int request,
+			unsigned long arg)
 {
 	struct rtwlan_cmd cmd;
 	struct ifreq ifr;
-- 
2.35.3

