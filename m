From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 09/11] cobalt/posix: Address -Wimplicit-fallthrough
Date: Mon, 26 Oct 2020 12:04:55 +0100
Message-Id: <d735b13fdf818419a3e4b0396dca642c184c481f.1603710297.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1603710297.git.jan.kiszka@siemens.com>
References: <cover.1603710297.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Fino Meng <fino.meng@linux.intel.com>, Mingliang Hu <mingliang.hu@intel.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

A compatible keyword is "fallthrough", use that and add it one missing
spot in cobalt_sched_policy_param. Doesn't make all gcc versions happy
yet, but that's a compiler issue. At least gcc-9 is fine.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/posix/compat.c                 | 2 +-
 kernel/cobalt/posix/sched.c                  | 5 +++--
 kernel/cobalt/posix/signal.c                 | 2 +-
 kernel/cobalt/posix/signal.h                 | 2 +-
 kernel/drivers/can/rtcan_raw_dev.c           | 2 +-
 kernel/drivers/can/sja1000/rtcan_peak_pci.c  | 5 +++++
 kernel/drivers/ipc/bufp.c                    | 1 +
 kernel/drivers/ipc/iddp.c                    | 1 +
 kernel/drivers/ipc/xddp.c                    | 1 +
 kernel/drivers/net/drivers/e1000/e1000_hw.c  | 4 +++-
 kernel/drivers/net/drivers/igb/e1000_82575.c | 4 +++-
 kernel/drivers/net/drivers/igb/e1000_phy.c   | 1 +
 kernel/drivers/net/drivers/igb/igb_main.c    | 1 +
 kernel/drivers/net/stack/ipv4/udp/udp.c      | 1 +
 kernel/drivers/net/stack/packet/af_packet.c  | 1 +
 15 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index a31ec04578..e53e72e0cd 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -392,7 +392,7 @@ int sys32_put_siginfo(void __user *u_si, const struct siginfo *si,
 	case SI_QUEUE:
 	case SI_MESGQ:
 		ret |= __xn_put_user(ptr_to_compat(si->si_ptr), &u_p->si_ptr);
-		/* falldown wanted. */
+		/* fallthrough */
 	case SI_USER:
 		ret |= __xn_put_user(si->si_pid, &u_p->si_pid);
 		ret |= __xn_put_user(si->si_uid, &u_p->si_uid);
diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 7e457a9a8c..798a172d7f 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -58,6 +58,7 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
 		 * levels. Otherwise, SCHED_NORMAL is scheduled by
 		 * xnsched_class_rt at priority level #0.
 		 */
+		/* fallthrough */
 	case SCHED_WEAK:
 #ifdef CONFIG_XENO_OPT_SCHED_WEAK
 		if (prio < XNSCHED_WEAK_MIN_PRIO ||
@@ -75,7 +76,7 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
 		tslice = ts2ns(&param_ex->sched_rr_quantum);
 		if (tslice == XN_INFINITE && tslice_r)
 			tslice = *tslice_r;
-		/* falldown wanted */
+		/* fallthrough */
 	case SCHED_FIFO:
 		if (prio < XNSCHED_FIFO_MIN_PRIO ||
 		    prio > XNSCHED_FIFO_MAX_PRIO)
@@ -248,7 +249,7 @@ int set_tp_config(int cpu, union sched_config *config, size_t len)
 	case sched_tp_install:
 		if (config->tp.nr_windows > 0)
 			break;
-		/* Fallback wanted. */
+		/* fallthrough */
 	case sched_tp_uninstall:
 		gps = NULL;
 		goto set_schedule;
diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index e75ce2b693..75514d84fd 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -234,7 +234,7 @@ static int signal_put_siginfo(void __user *u_si, const struct siginfo *si,
 	case SI_QUEUE:
 	case SI_MESGQ:
 		ret |= __xn_put_user(si->si_ptr, &u_p->si_ptr);
-		/* falldown wanted. */
+		/* fallthrough */
 	case SI_USER:
 		ret |= __xn_put_user(si->si_pid, &u_p->si_pid);
 		ret |= __xn_put_user(si->si_uid, &u_p->si_uid);
diff --git a/kernel/cobalt/posix/signal.h b/kernel/cobalt/posix/signal.h
index a4edc094f8..e506842e71 100644
--- a/kernel/cobalt/posix/signal.h
+++ b/kernel/cobalt/posix/signal.h
@@ -49,7 +49,7 @@ void cobalt_copy_siginfo(int code,
 	case SI_QUEUE:
 	case SI_MESGQ:
 		dst->si_value = src->si_value;
-		/* falldown wanted. */
+		/* fallthrough */
 	case SI_USER:
 		dst->si_pid = src->si_pid;
 		dst->si_uid = src->si_uid;
diff --git a/kernel/drivers/can/rtcan_raw_dev.c b/kernel/drivers/can/rtcan_raw_dev.c
index 0f4f52fa28..c72c3ced51 100644
--- a/kernel/drivers/can/rtcan_raw_dev.c
+++ b/kernel/drivers/can/rtcan_raw_dev.c
@@ -374,7 +374,7 @@ int rtcan_raw_ioctl_dev(struct rtdm_fd *fd, int request, void *arg)
     case SIOCGCANBAUDRATE:
     case SIOCGCANCUSTOMBITTIME:
 	    get = 1;
-	    /* Falldown wanted. */
+	    /* fallthrough */
     case SIOCSCANMODE:
     case SIOCSCANCTRLMODE:
     case SIOCSCANBAUDRATE:
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_pci.c b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
index 50f573ee6d..bc6439b8fe 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
@@ -142,6 +142,7 @@ static void rtcan_peak_pci_del_chan(struct rtcan_device *dev,
 	printk("Removing %s %s device %s\n",
 	       peak_pci_board_name, dev->ctrl_name, dev->name);
 	rtcan_sja1000_unregister(dev);
+	/* fallthrough */
     case 5:
 	pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
 	if (board->channel == CHANNEL_SLAVE) {
@@ -150,13 +151,17 @@ static void rtcan_peak_pci_del_chan(struct rtcan_device *dev,
 	    pita_icr_high &= ~0x0002;
 	}
 	writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
+	/* fallthrough */
     case 4:
 	iounmap((void *)board->base_addr);
+	/* fallthrough */
     case 3:
 	if (board->channel != CHANNEL_SLAVE)
 	    iounmap((void *)board->conf_addr);
+	/* fallthrough */
     case 2:
 	rtcan_dev_free(dev);
+	/* fallthrough */
     case 1:
 	break;
     }
diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index 9410973f2c..d45480f94d 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -1032,6 +1032,7 @@ static int bufp_ioctl(struct rtdm_fd *fd,
 	COMPAT_CASE(_RTIOC_BIND):
 		if (rtdm_in_rt_context())
 			return -ENOSYS;	/* Try downgrading to NRT */
+		/* fallthrough */
 	default:
 		ret = __bufp_ioctl(fd, request, arg);
 	}
diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
index 5bb2b85337..f31b9bb661 100644
--- a/kernel/drivers/ipc/iddp.c
+++ b/kernel/drivers/ipc/iddp.c
@@ -915,6 +915,7 @@ static int iddp_ioctl(struct rtdm_fd *fd,
 	COMPAT_CASE(_RTIOC_BIND):
 		if (rtdm_in_rt_context())
 			return -ENOSYS;	/* Try downgrading to NRT */
+		/* fallthrough */
 	default:
 		ret = __iddp_ioctl(fd, request, arg);
 	}
diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
index 2bf26fcaa8..c9236a229a 100644
--- a/kernel/drivers/ipc/xddp.c
+++ b/kernel/drivers/ipc/xddp.c
@@ -1078,6 +1078,7 @@ static int xddp_ioctl(struct rtdm_fd *fd,
 	COMPAT_CASE(_RTIOC_BIND):
 		if (rtdm_in_rt_context())
 			return -ENOSYS;	/* Try downgrading to NRT */
+		/* fallthrough */
 	default:
 		ret = __xddp_ioctl(fd, request, arg);
 	}
diff --git a/kernel/drivers/net/drivers/e1000/e1000_hw.c b/kernel/drivers/net/drivers/e1000/e1000_hw.c
index d97465336c..9c57215373 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_hw.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_hw.c
@@ -126,6 +126,7 @@ e1000_set_phy_type(struct e1000_hw *hw)
             hw->phy_type = e1000_phy_igp;
             break;
         }
+        /* fallthrough */
     case IGP03E1000_E_PHY_ID:
         hw->phy_type = e1000_phy_igp_3;
         break;
@@ -139,7 +140,7 @@ e1000_set_phy_type(struct e1000_hw *hw)
             hw->phy_type = e1000_phy_gg82563;
             break;
         }
-        /* Fall Through */
+        /* fallthrough */
     default:
         /* Should never have loaded on this device */
         hw->phy_type = e1000_phy_undefined;
@@ -5869,6 +5870,7 @@ e1000_rar_set(struct e1000_hw *hw,
     case e1000_80003es2lan:
         if (hw->leave_av_bit_off == TRUE)
             break;
+        /* fallthrough */
     default:
         /* Indicate to hardware the Address is Valid. */
         rar_high |= E1000_RAH_AV;
diff --git a/kernel/drivers/net/drivers/igb/e1000_82575.c b/kernel/drivers/net/drivers/igb/e1000_82575.c
index 3b3c01b47f..45bd52a9e2 100644
--- a/kernel/drivers/net/drivers/igb/e1000_82575.c
+++ b/kernel/drivers/net/drivers/igb/e1000_82575.c
@@ -607,7 +607,8 @@ static s32 igb_get_invariants_82575(struct e1000_hw *hw)
 			dev_spec->sgmii_active = true;
 			break;
 		}
-		/* fall through for I2C based SGMII */
+		/* for I2C based SGMII: */
+		/* fallthrough */
 	case E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES:
 		/* read media type from SFP EEPROM */
 		ret_val = igb_set_sfp_media_type_82575(hw);
@@ -1669,6 +1670,7 @@ static s32 igb_setup_serdes_link_82575(struct e1000_hw *hw)
 	case E1000_CTRL_EXT_LINK_MODE_1000BASE_KX:
 		/* disable PCS autoneg and support parallel detect only */
 		pcs_autoneg = false;
+		/* fallthrough */
 	default:
 		if (hw->mac.type == e1000_82575 ||
 		    hw->mac.type == e1000_82576) {
diff --git a/kernel/drivers/net/drivers/igb/e1000_phy.c b/kernel/drivers/net/drivers/igb/e1000_phy.c
index 4b0c432797..41f3afcd50 100644
--- a/kernel/drivers/net/drivers/igb/e1000_phy.c
+++ b/kernel/drivers/net/drivers/igb/e1000_phy.c
@@ -682,6 +682,7 @@ s32 igb_copper_link_setup_m88_gen2(struct e1000_hw *hw)
 			phy_data |= M88E1000_PSCR_AUTO_X_1000T;
 			break;
 		}
+		/* fallthrough */
 	case 0:
 	default:
 		phy_data |= M88E1000_PSCR_AUTO_X_MODE;
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 37d891a620..01960a6c26 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -3550,6 +3550,7 @@ bool igb_has_link(struct igb_adapter *adapter)
 	case e1000_media_type_copper:
 		if (!hw->mac.get_link_status)
 			return true;
+		/* fallthrough */
 	case e1000_media_type_internal_serdes:
 		hw->mac.ops.check_for_link(hw);
 		link_active = !hw->mac.get_link_status;
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index c26b4bd813..407354f4bf 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -427,6 +427,7 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *u_msg,
 		switch (ret) {
 		default:
 			ret = -EBADF; /* socket has been closed */
+			/* fallthrough */
 		case -EWOULDBLOCK:
 		case -ETIMEDOUT:
 		case -EINTR:
diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
index b8de8a0b6a..961b3e4019 100644
--- a/kernel/drivers/net/stack/packet/af_packet.c
+++ b/kernel/drivers/net/stack/packet/af_packet.c
@@ -331,6 +331,7 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *u_msg,
 		switch (ret) {
 		default:
 			ret = -EBADF; /* socket has been closed */
+			/* fallthrough */
 		case -EWOULDBLOCK:
 		case -ETIMEDOUT:
 		case -EINTR:
-- 
2.26.2


