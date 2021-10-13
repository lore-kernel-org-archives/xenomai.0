From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6/9] cobalt: Use fallthrough key word rather than comments
Date: Wed, 13 Oct 2021 13:55:50 +0200
Message-Id: <b7e4e5d0e40b4934c33dea9fcd3bad73b3ac41b5.1634126152.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634126152.git.jan.kiszka@siemens.com>
References: <cover.1634126152.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Kernel 5.14 requires this.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../include/asm-generic/xenomai/wrappers.h    |  8 ++++++++
 kernel/cobalt/posix/compat.c                  |  2 +-
 kernel/cobalt/posix/sched.c                   |  6 +++---
 kernel/cobalt/posix/signal.c                  |  2 +-
 kernel/cobalt/posix/signal.h                  |  2 +-
 kernel/cobalt/timer.c                         |  2 +-
 .../analogy/national_instruments/mio_common.c |  2 +-
 .../drivers/can/peak_canfd/rtcan_peak_canfd.c |  2 +-
 .../can/peak_canfd/rtcan_peak_pciefd.c        |  2 +-
 kernel/drivers/can/rtcan_flexcan.c            |  2 +-
 kernel/drivers/can/rtcan_raw_dev.c            |  2 +-
 kernel/drivers/can/sja1000/rtcan_peak_pci.c   | 10 +++++-----
 kernel/drivers/ipc/bufp.c                     |  2 +-
 kernel/drivers/ipc/iddp.c                     |  2 +-
 kernel/drivers/ipc/xddp.c                     |  2 +-
 kernel/drivers/net/drivers/e1000/e1000_hw.c   | 20 +++++++++----------
 kernel/drivers/net/drivers/e1000/e1000_main.c |  2 +-
 kernel/drivers/net/drivers/e1000e/82571.c     |  4 ++--
 kernel/drivers/net/drivers/e1000e/ich8lan.c   |  8 ++++----
 kernel/drivers/net/drivers/e1000e/netdev.c    |  4 ++--
 .../experimental/e1000/e1000_ethtool.c        |  4 ++--
 .../drivers/experimental/e1000/e1000_main.c   | 10 +++++-----
 .../drivers/experimental/e1000/e1000_param.c  |  2 +-
 kernel/drivers/net/drivers/igb/e1000_82575.c  |  4 ++--
 kernel/drivers/net/drivers/igb/e1000_nvm.c    |  2 +-
 kernel/drivers/net/drivers/igb/e1000_phy.c    |  4 ++--
 kernel/drivers/net/drivers/igb/igb_main.c     | 10 +++++-----
 kernel/drivers/net/stack/ipv4/udp/udp.c       |  2 +-
 kernel/drivers/net/stack/packet/af_packet.c   |  2 +-
 kernel/drivers/testing/switchtest.c           |  2 +-
 30 files changed, 68 insertions(+), 60 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index cb3f2b242f..f0f89f9ad2 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -231,6 +231,14 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
 	kernel_read_file(__file, 0, __buf, __buf_size, __file_size, __id)
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,4,0)
+#if __has_attribute(__fallthrough__)
+# define fallthrough			__attribute__((__fallthrough__))
+#else
+# define fallthrough			do {} while (0)  /* fallthrough */
+#endif
+#endif
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(5,11,0)
 #define IRQ_WORK_INIT(_func) (struct irq_work){	\
 	.node = { .u_flags = 0, },		\
diff --git a/kernel/cobalt/posix/compat.c b/kernel/cobalt/posix/compat.c
index 029fe2582a..2ec46084c5 100644
--- a/kernel/cobalt/posix/compat.c
+++ b/kernel/cobalt/posix/compat.c
@@ -424,7 +424,7 @@ int sys32_put_siginfo(void __user *u_si, const struct siginfo *si,
 	case SI_QUEUE:
 	case SI_MESGQ:
 		ret |= __xn_put_user(ptr_to_compat(si->si_ptr), &u_p->si_ptr);
-		/* fallthrough */
+		fallthrough;
 	case SI_USER:
 		ret |= __xn_put_user(si->si_pid, &u_p->si_pid);
 		ret |= __xn_put_user(si->si_uid, &u_p->si_uid);
diff --git a/kernel/cobalt/posix/sched.c b/kernel/cobalt/posix/sched.c
index 4fd9c2b46e..994ee88d95 100644
--- a/kernel/cobalt/posix/sched.c
+++ b/kernel/cobalt/posix/sched.c
@@ -58,7 +58,7 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
 		 * levels. Otherwise, SCHED_NORMAL is scheduled by
 		 * xnsched_class_rt at priority level #0.
 		 */
-		/* fallthrough */
+		fallthrough;
 	case SCHED_WEAK:
 #ifdef CONFIG_XENO_OPT_SCHED_WEAK
 		if (prio < XNSCHED_WEAK_MIN_PRIO ||
@@ -76,7 +76,7 @@ cobalt_sched_policy_param(union xnsched_policy_param *param,
 		tslice = u_ts2ns(&param_ex->sched_rr_quantum);
 		if (tslice == XN_INFINITE && tslice_r)
 			tslice = *tslice_r;
-		/* fallthrough */
+		fallthrough;
 	case SCHED_FIFO:
 		if (prio < XNSCHED_FIFO_MIN_PRIO ||
 		    prio > XNSCHED_FIFO_MAX_PRIO)
@@ -249,7 +249,7 @@ int set_tp_config(int cpu, union sched_config *config, size_t len)
 	case sched_tp_install:
 		if (config->tp.nr_windows > 0)
 			break;
-		/* fallthrough */
+		fallthrough;
 	case sched_tp_uninstall:
 		gps = NULL;
 		goto set_schedule;
diff --git a/kernel/cobalt/posix/signal.c b/kernel/cobalt/posix/signal.c
index e3ba3abcfb..5f5cb85d19 100644
--- a/kernel/cobalt/posix/signal.c
+++ b/kernel/cobalt/posix/signal.c
@@ -235,7 +235,7 @@ static int signal_put_siginfo(void __user *u_si, const struct siginfo *si,
 	case SI_QUEUE:
 	case SI_MESGQ:
 		ret |= __xn_put_user(si->si_ptr, &u_p->si_ptr);
-		/* fallthrough */
+		fallthrough;
 	case SI_USER:
 		ret |= __xn_put_user(si->si_pid, &u_p->si_pid);
 		ret |= __xn_put_user(si->si_uid, &u_p->si_uid);
diff --git a/kernel/cobalt/posix/signal.h b/kernel/cobalt/posix/signal.h
index 121db8f9b5..0b5d11e813 100644
--- a/kernel/cobalt/posix/signal.h
+++ b/kernel/cobalt/posix/signal.h
@@ -49,7 +49,7 @@ void cobalt_copy_siginfo(int code,
 	case SI_QUEUE:
 	case SI_MESGQ:
 		dst->si_value = src->si_value;
-		/* fallthrough */
+		fallthrough;
 	case SI_USER:
 		dst->si_pid = src->si_pid;
 		dst->si_uid = src->si_uid;
diff --git a/kernel/cobalt/timer.c b/kernel/cobalt/timer.c
index 1ec7617915..4b9cea4a97 100644
--- a/kernel/cobalt/timer.c
+++ b/kernel/cobalt/timer.c
@@ -140,7 +140,7 @@ int xntimer_start(struct xntimer *timer,
 	case XN_REALTIME:
 		timer->status |= XNTIMER_REALTIME;
 		value -= xnclock_get_offset(clock);
-		/* fall through */
+		fallthrough;
 	default: /* XN_ABSOLUTE || XN_REALTIME */
 		date = xnclock_ns_to_ticks(clock, value);
 		if ((xnsticks_t)(date - now) <= 0) {
diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b/kernel/drivers/analogy/national_instruments/mio_common.c
index 6c5bba0568..b071adcfc9 100644
--- a/kernel/drivers/analogy/national_instruments/mio_common.c
+++ b/kernel/drivers/analogy/national_instruments/mio_common.c
@@ -4014,7 +4014,7 @@ static void ni_gpct_write_register(struct ni_gpct *counter,
 		break;
 	case NITIO_G01_Joint_Reset_Reg:
 		BUG_ON(bits & ~gpct_joint_reset_mask);
-		/* fall-through */
+		fallthrough;
 	default:
 		stc_register = ni_gpct_to_stc_register(reg);
 		devpriv->stc_writew(dev, bits, stc_register);
diff --git a/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
index e10ff8bbc5..4ecc1e965c 100644
--- a/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
+++ b/kernel/drivers/can/peak_canfd/rtcan_peak_canfd.c
@@ -493,7 +493,7 @@ static int peak_canfd_set_mode(struct rtcan_device *rdev, can_mode_t mode,
 		if (rdev->state == CAN_STATE_SLEEPING)
 			break;
 
-		/* fallthrough */
+		fallthrough;
 	default:
 		err = -EOPNOTSUPP;
 		break;
diff --git a/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c b/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
index 9ede5a2cc1..445c46e1c7 100644
--- a/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
+++ b/kernel/drivers/can/peak_canfd/rtcan_peak_pciefd.c
@@ -698,7 +698,7 @@ static int pciefd_can_probe(struct pciefd_board *pciefd)
 		pciefd_can_writereg(priv, CANFD_CLK_SEL_80MHZ,
 				    PCIEFD_REG_CAN_CLK_SEL);
 
-		/* fallthrough */
+		fallthrough;
 	case CANFD_CLK_SEL_80MHZ:
 		priv->ucan.rdev->can_sys_clock = 80 * 1000 * 1000;
 		break;
diff --git a/kernel/drivers/can/rtcan_flexcan.c b/kernel/drivers/can/rtcan_flexcan.c
index 601dd0ba42..7569d16f75 100644
--- a/kernel/drivers/can/rtcan_flexcan.c
+++ b/kernel/drivers/can/rtcan_flexcan.c
@@ -604,7 +604,7 @@ static void flexcan_change_state(struct rtcan_device *dev,
 				CAN_ERR_CRTL_TX_WARNING :
 				CAN_ERR_CRTL_RX_WARNING;
 		}
-		/* fallthrough */
+		fallthrough;
 	case CAN_STATE_ERROR_WARNING:
 		/*
 		 * from: ERROR_ACTIVE, ERROR_WARNING
diff --git a/kernel/drivers/can/rtcan_raw_dev.c b/kernel/drivers/can/rtcan_raw_dev.c
index c72c3ced51..d1ff640e33 100644
--- a/kernel/drivers/can/rtcan_raw_dev.c
+++ b/kernel/drivers/can/rtcan_raw_dev.c
@@ -374,7 +374,7 @@ int rtcan_raw_ioctl_dev(struct rtdm_fd *fd, int request, void *arg)
     case SIOCGCANBAUDRATE:
     case SIOCGCANCUSTOMBITTIME:
 	    get = 1;
-	    /* fallthrough */
+	    fallthrough;
     case SIOCSCANMODE:
     case SIOCSCANCTRLMODE:
     case SIOCSCANBAUDRATE:
diff --git a/kernel/drivers/can/sja1000/rtcan_peak_pci.c b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
index bc6439b8fe..42df49acdc 100644
--- a/kernel/drivers/can/sja1000/rtcan_peak_pci.c
+++ b/kernel/drivers/can/sja1000/rtcan_peak_pci.c
@@ -142,7 +142,7 @@ static void rtcan_peak_pci_del_chan(struct rtcan_device *dev,
 	printk("Removing %s %s device %s\n",
 	       peak_pci_board_name, dev->ctrl_name, dev->name);
 	rtcan_sja1000_unregister(dev);
-	/* fallthrough */
+	fallthrough;
     case 5:
 	pita_icr_high = readw(board->conf_addr + PITA_ICR + 2);
 	if (board->channel == CHANNEL_SLAVE) {
@@ -151,17 +151,17 @@ static void rtcan_peak_pci_del_chan(struct rtcan_device *dev,
 	    pita_icr_high &= ~0x0002;
 	}
 	writew(pita_icr_high, board->conf_addr + PITA_ICR + 2);
-	/* fallthrough */
+	fallthrough;
     case 4:
 	iounmap((void *)board->base_addr);
-	/* fallthrough */
+	fallthrough;
     case 3:
 	if (board->channel != CHANNEL_SLAVE)
 	    iounmap((void *)board->conf_addr);
-	/* fallthrough */
+	fallthrough;
     case 2:
 	rtcan_dev_free(dev);
-	/* fallthrough */
+	fallthrough;
     case 1:
 	break;
     }
diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index d673ee8f32..fd533dba27 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -1035,7 +1035,7 @@ static int bufp_ioctl(struct rtdm_fd *fd,
 	COMPAT_CASE(_RTIOC_BIND):
 		if (rtdm_in_rt_context())
 			return -ENOSYS;	/* Try downgrading to NRT */
-		/* fallthrough */
+		fallthrough;
 	default:
 		ret = __bufp_ioctl(fd, request, arg);
 	}
diff --git a/kernel/drivers/ipc/iddp.c b/kernel/drivers/ipc/iddp.c
index 3a9de845fc..a553902326 100644
--- a/kernel/drivers/ipc/iddp.c
+++ b/kernel/drivers/ipc/iddp.c
@@ -916,7 +916,7 @@ static int iddp_ioctl(struct rtdm_fd *fd,
 	COMPAT_CASE(_RTIOC_BIND):
 		if (rtdm_in_rt_context())
 			return -ENOSYS;	/* Try downgrading to NRT */
-		/* fallthrough */
+		fallthrough;
 	default:
 		ret = __iddp_ioctl(fd, request, arg);
 	}
diff --git a/kernel/drivers/ipc/xddp.c b/kernel/drivers/ipc/xddp.c
index 25dd68a9da..ae5b720c0c 100644
--- a/kernel/drivers/ipc/xddp.c
+++ b/kernel/drivers/ipc/xddp.c
@@ -1079,7 +1079,7 @@ static int xddp_ioctl(struct rtdm_fd *fd,
 	COMPAT_CASE(_RTIOC_BIND):
 		if (rtdm_in_rt_context())
 			return -ENOSYS;	/* Try downgrading to NRT */
-		/* fallthrough */
+		fallthrough;
 	default:
 		ret = __xddp_ioctl(fd, request, arg);
 	}
diff --git a/kernel/drivers/net/drivers/e1000/e1000_hw.c b/kernel/drivers/net/drivers/e1000/e1000_hw.c
index 9c57215373..59c55ffff1 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_hw.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_hw.c
@@ -126,7 +126,7 @@ e1000_set_phy_type(struct e1000_hw *hw)
             hw->phy_type = e1000_phy_igp;
             break;
         }
-        /* fallthrough */
+        fallthrough;
     case IGP03E1000_E_PHY_ID:
         hw->phy_type = e1000_phy_igp_3;
         break;
@@ -140,7 +140,7 @@ e1000_set_phy_type(struct e1000_hw *hw)
             hw->phy_type = e1000_phy_gg82563;
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         /* Should never have loaded on this device */
         hw->phy_type = e1000_phy_undefined;
@@ -373,12 +373,12 @@ e1000_set_mac_type(struct e1000_hw *hw)
         break;
     case e1000_80003es2lan:
         hw->swfw_sync_present = TRUE;
-        /* fall through */
+        fallthrough;
     case e1000_82571:
     case e1000_82572:
     case e1000_82573:
         hw->eeprom_semaphore_present = TRUE;
-        /* fall through */
+        fallthrough;
     case e1000_82541:
     case e1000_82547:
     case e1000_82541_rev_2:
@@ -611,7 +611,7 @@ e1000_reset_hw(struct e1000_hw *hw)
                 E1000_WRITE_REG(hw, CTRL_EXT, ctrl_ext);
                 E1000_WRITE_FLUSH(hw);
             }
-            /* fall through */
+            fallthrough;
         case e1000_82571:
         case e1000_82572:
         case e1000_ich8lan:
@@ -834,7 +834,7 @@ e1000_init_hw(struct e1000_hw *hw)
         reg_data = E1000_READ_REG_ARRAY(hw, FFLT, 0x0001);
         reg_data &= ~0x00100000;
         E1000_WRITE_REG_ARRAY(hw, FFLT, 0x0001, reg_data);
-        /* Fall through */
+        fallthrough;
     case e1000_82571:
     case e1000_82572:
     case e1000_ich8lan:
@@ -5870,7 +5870,7 @@ e1000_rar_set(struct e1000_hw *hw,
     case e1000_80003es2lan:
         if (hw->leave_av_bit_off == TRUE)
             break;
-        /* fallthrough */
+        fallthrough;
     default:
         /* Indicate to hardware the Address is Valid. */
         rar_high |= E1000_RAH_AV;
@@ -6062,7 +6062,7 @@ e1000_setup_led(struct e1000_hw *hw)
                                       ~IGP01E1000_GMII_SPD));
         if (ret_val)
             return ret_val;
-        /* Fall Through */
+        fallthrough;
     default:
         if (hw->media_type == e1000_media_type_fiber) {
             ledctl = E1000_READ_REG(hw, LEDCTL);
@@ -6150,7 +6150,7 @@ e1000_cleanup_led(struct e1000_hw *hw)
                                       hw->phy_spd_default);
         if (ret_val)
             return ret_val;
-        /* Fall Through */
+        fallthrough;
     default:
         if (hw->phy_type == e1000_phy_ife) {
             e1000_write_phy_reg(hw, IFE_PHY_SPECIAL_CONTROL_LED, 0);
@@ -8030,7 +8030,7 @@ e1000_get_phy_cfg_done(struct e1000_hw *hw)
         /* Separate *_CFG_DONE_* bit for each port */
         if (E1000_READ_REG(hw, STATUS) & E1000_STATUS_FUNC_1)
             cfg_mask = E1000_EEPROM_CFG_DONE_PORT_1;
-        /* Fall Through */
+        fallthrough;
     case e1000_82571:
     case e1000_82572:
         while (timeout) {
diff --git a/kernel/drivers/net/drivers/e1000/e1000_main.c b/kernel/drivers/net/drivers/e1000/e1000_main.c
index 3df35e033c..222709a48f 100644
--- a/kernel/drivers/net/drivers/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/e1000/e1000_main.c
@@ -893,7 +893,7 @@ static int e1000_probe(struct pci_dev *pdev,
 				EEPROM_INIT_CONTROL3_PORT_B, 1, &eeprom_data);
 			break;
 		}
-		/* Fall Through */
+		fallthrough;
 	default:
 		e1000_read_eeprom(&adapter->hw,
 			EEPROM_INIT_CONTROL3_PORT_A, 1, &eeprom_data);
diff --git a/kernel/drivers/net/drivers/e1000e/82571.c b/kernel/drivers/net/drivers/e1000e/82571.c
index a3e65fd26e..1a3fa39d4e 100644
--- a/kernel/drivers/net/drivers/e1000e/82571.c
+++ b/kernel/drivers/net/drivers/e1000e/82571.c
@@ -199,7 +199,7 @@ static s32 e1000_init_nvm_params_82571(struct e1000_hw *hw)
 			ew32(EECD, eecd);
 			break;
 		}
-		/* Fall Through */
+		fallthrough;
 	default:
 		nvm->type = e1000_nvm_eeprom_spi;
 		size = (u16)((eecd & E1000_EECD_SIZE_EX_MASK) >>
@@ -1172,7 +1172,7 @@ static s32 e1000_init_hw_82571(struct e1000_hw *hw)
 	switch (mac->type) {
 	case e1000_82573:
 		e1000e_enable_tx_pkt_filtering(hw);
-		/* fall through */
+		fallthrough;
 	case e1000_82574:
 	case e1000_82583:
 		reg_data = er32(GCR);
diff --git a/kernel/drivers/net/drivers/e1000e/ich8lan.c b/kernel/drivers/net/drivers/e1000e/ich8lan.c
index 4e2e5301e2..8bdcf3d1d4 100644
--- a/kernel/drivers/net/drivers/e1000e/ich8lan.c
+++ b/kernel/drivers/net/drivers/e1000e/ich8lan.c
@@ -397,7 +397,7 @@ static s32 e1000_init_phy_params_pchlan(struct e1000_hw *hw)
 			goto out;
 		if ((phy->id != 0) && (phy->id != PHY_REVISION_MASK))
 			break;
-		/* fall-through */
+		fallthrough;
 	case e1000_pch2lan:
 	case e1000_pch_lpt:
 		/*
@@ -770,7 +770,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 		ret_val = e1000_k1_workaround_lv(hw);
 		if (ret_val)
 			goto out;
-		/* fall-thru */
+		fallthrough;
 	case e1000_pchlan:
 		if (hw->phy.type == e1000_phy_82578) {
 			ret_val = e1000_link_stall_workaround_hv(hw);
@@ -1210,7 +1210,7 @@ static s32 e1000_sw_lcd_config_ich8lan(struct e1000_hw *hw)
 			sw_cfg_mask = E1000_FEXTNVM_SW_CONFIG;
 			break;
 		}
-		/* Fall-thru */
+		fallthrough;
 	case e1000_pchlan:
 	case e1000_pch2lan:
 	case e1000_pch_lpt:
@@ -2267,7 +2267,7 @@ static s32 e1000_valid_nvm_bank_detect_ich8lan(struct e1000_hw *hw, u32 *bank)
 		}
 		e_dbg("Unable to determine valid NVM bank via EEC - "
 		       "reading flash signature\n");
-		/* fall-thru */
+		fallthrough;
 	default:
 		/* set bank to 0 in case flash read fails */
 		*bank = 0;
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 5ce4679113..20073aa672 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -1239,7 +1239,7 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
 			e1000e_reset_interrupt_capability(adapter);
 		}
 		adapter->int_mode = E1000E_INT_MODE_MSI;
-		/* Fall through */
+		fallthrough;
 	case E1000E_INT_MODE_MSI:
 		if (!pci_enable_msi(adapter->pdev)) {
 			adapter->flags |= FLAG_MSI_ENABLED;
@@ -1248,7 +1248,7 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
 			e_err("Failed to initialize MSI interrupts.  Falling "
 			      "back to legacy interrupts.\n");
 		}
-		/* Fall through */
+		fallthrough;
 	case E1000E_INT_MODE_LEGACY:
 		/* Don't do anything; this is the system default */
 		break;
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
index 375aa7f41b..1911673af9 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_ethtool.c
@@ -1565,7 +1565,7 @@ static void e1000_loopback_cleanup(struct e1000_adapter *adapter)
 			E1000_WRITE_REG(hw, E1000_CTRL_EXT, adapter->tx_fifo_head);
 			adapter->tx_fifo_head = 0;
 		}
-		/* fall through */
+		fallthrough;
 	case e1000_82571:
 	case e1000_82572:
 		if (hw->phy.media_type == e1000_media_type_fiber ||
@@ -1575,7 +1575,7 @@ static void e1000_loopback_cleanup(struct e1000_adapter *adapter)
 			msleep(10);
 			break;
 		}
-		/* Fall Through */
+		fallthrough;
 	case e1000_82545:
 	case e1000_82546:
 	case e1000_82545_rev_3:
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
index c9751c1ddc..64b724c3cb 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_main.c
@@ -1314,7 +1314,7 @@ static int e1000_probe(struct pci_dev *pdev,
 				NVM_INIT_CONTROL3_PORT_B, 1, &eeprom_data);
 			break;
 		}
-		/* Fall Through */
+		fallthrough;
 	default:
 		e1000_read_nvm(&adapter->hw,
 			NVM_INIT_CONTROL3_PORT_A, 1, &eeprom_data);
@@ -1536,7 +1536,7 @@ static int e1000_sw_init(struct e1000_adapter *adapter)
 			adapter->num_rx_queues = 2;
 			break;
 		}
-		/* Fall through - remaining ICH SKUs do not support MQ */
+		fallthrough; /* remaining ICH SKUs do not support MQ */
 	default:
 		/* All hardware before 82571 only have 1 queue each for Rx/Tx.
 		 * However, the 82571 family does not have MSI-X, so multi-
@@ -2396,11 +2396,11 @@ static void e1000_setup_rctl(struct e1000_adapter *adapter)
 		case 3:
 			psrctl |= PAGE_SIZE <<
 				E1000_PSRCTL_BSIZE3_SHIFT;
-			/* fall through */
+			fallthrough;
 		case 2:
 			psrctl |= PAGE_SIZE <<
 				E1000_PSRCTL_BSIZE2_SHIFT;
-			/* fall through */
+			fallthrough;
 		case 1:
 			psrctl |= PAGE_SIZE >>
 				E1000_PSRCTL_BSIZE1_SHIFT;
@@ -3780,7 +3780,7 @@ static int e1000_xmit_frame_ring(struct sk_buff *skb,
 				 * into the next dword */
 				if ((unsigned long)(skb_tail_pointer(skb) - 1) & 4)
 					break;
-				/* fall through */
+				fallthrough;
 			case e1000_82571:
 			case e1000_82572:
 			case e1000_82573:
diff --git a/kernel/drivers/net/drivers/experimental/e1000/e1000_param.c b/kernel/drivers/net/drivers/experimental/e1000/e1000_param.c
index bfead4151e..c5db2cb5c5 100644
--- a/kernel/drivers/net/drivers/experimental/e1000/e1000_param.c
+++ b/kernel/drivers/net/drivers/experimental/e1000/e1000_param.c
@@ -872,7 +872,7 @@ static void e1000_check_copper_options(struct e1000_adapter *adapter)
 	case SPEED_1000 + HALF_DUPLEX:
 		DPRINTK(PROBE, INFO,
 			"Half Duplex is not supported at 1000 Mbps\n");
-		/* fall through */
+		fallthrough;
 	case SPEED_1000 + FULL_DUPLEX:
 full_duplex_only:
 		DPRINTK(PROBE, INFO,
diff --git a/kernel/drivers/net/drivers/igb/e1000_82575.c b/kernel/drivers/net/drivers/igb/e1000_82575.c
index 45bd52a9e2..fff9e85926 100644
--- a/kernel/drivers/net/drivers/igb/e1000_82575.c
+++ b/kernel/drivers/net/drivers/igb/e1000_82575.c
@@ -608,7 +608,7 @@ static s32 igb_get_invariants_82575(struct e1000_hw *hw)
 			break;
 		}
 		/* for I2C based SGMII: */
-		/* fallthrough */
+		fallthrough;
 	case E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES:
 		/* read media type from SFP EEPROM */
 		ret_val = igb_set_sfp_media_type_82575(hw);
@@ -1670,7 +1670,7 @@ static s32 igb_setup_serdes_link_82575(struct e1000_hw *hw)
 	case E1000_CTRL_EXT_LINK_MODE_1000BASE_KX:
 		/* disable PCS autoneg and support parallel detect only */
 		pcs_autoneg = false;
-		/* fallthrough */
+		fallthrough;
 	default:
 		if (hw->mac.type == e1000_82575 ||
 		    hw->mac.type == e1000_82576) {
diff --git a/kernel/drivers/net/drivers/igb/e1000_nvm.c b/kernel/drivers/net/drivers/igb/e1000_nvm.c
index 737fb256b4..a8d020747a 100644
--- a/kernel/drivers/net/drivers/igb/e1000_nvm.c
+++ b/kernel/drivers/net/drivers/igb/e1000_nvm.c
@@ -742,7 +742,7 @@ void igb_get_fw_version(struct e1000_hw *hw, struct e1000_fw_version *fw_vers)
 			igb_read_invm_version(hw, fw_vers);
 			return;
 		}
-		/* fall through */
+		fallthrough;
 	case e1000_i350:
 		/* find combo image version */
 		hw->nvm.ops.read(hw, NVM_COMB_VER_PTR, 1, &comb_offset);
diff --git a/kernel/drivers/net/drivers/igb/e1000_phy.c b/kernel/drivers/net/drivers/igb/e1000_phy.c
index 41f3afcd50..8d740899c3 100644
--- a/kernel/drivers/net/drivers/igb/e1000_phy.c
+++ b/kernel/drivers/net/drivers/igb/e1000_phy.c
@@ -682,7 +682,7 @@ s32 igb_copper_link_setup_m88_gen2(struct e1000_hw *hw)
 			phy_data |= M88E1000_PSCR_AUTO_X_1000T;
 			break;
 		}
-		/* fallthrough */
+		fallthrough;
 	case 0:
 	default:
 		phy_data |= M88E1000_PSCR_AUTO_X_MODE;
@@ -2504,7 +2504,7 @@ static s32 igb_set_master_slave_mode(struct e1000_hw *hw)
 		break;
 	case e1000_ms_auto:
 		phy_data &= ~CR_1000T_MS_ENABLE;
-		/* fall-through */
+		fallthrough;
 	default:
 		break;
 	}
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 1dc4732ee2..d47c0bb35c 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -638,14 +638,14 @@ static void igb_cache_ring_register(struct igb_adapter *adapter)
 		 * In order to avoid collision we start at the first free queue
 		 * and continue consuming queues in the same sequence
 		 */
-		/* Fall through */
+		fallthrough;
 	case e1000_82575:
 	case e1000_82580:
 	case e1000_i350:
 	case e1000_i354:
 	case e1000_i210:
 	case e1000_i211:
-		/* Fall through */
+		fallthrough;
 	default:
 		for (; i < adapter->num_rx_queues; i++)
 			adapter->rx_ring[i]->reg_idx = rbase_offset + i;
@@ -1876,7 +1876,7 @@ void igb_set_fw_version(struct igb_adapter *adapter)
 				 fw.invm_img_type);
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		/* if option is rom valid, display its version too */
 		if (fw.or_valid) {
@@ -2514,7 +2514,7 @@ static void igb_init_queue_configuration(struct igb_adapter *adapter)
 		 * should pair the queues in order to conserve interrupts due
 		 * to limited supply.
 		 */
-		/* fall through */
+		fallthrough;
 	case e1000_82580:
 	case e1000_i350:
 	case e1000_i354:
@@ -3550,7 +3550,7 @@ bool igb_has_link(struct igb_adapter *adapter)
 	case e1000_media_type_copper:
 		if (!hw->mac.get_link_status)
 			return true;
-		/* fallthrough */
+		fallthrough;
 	case e1000_media_type_internal_serdes:
 		hw->mac.ops.check_for_link(hw);
 		link_active = !hw->mac.get_link_status;
diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
index db7a902c35..5977a3bc23 100644
--- a/kernel/drivers/net/stack/ipv4/udp/udp.c
+++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
@@ -422,7 +422,7 @@ ssize_t rt_udp_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 		switch (ret) {
 		default:
 			ret = -EBADF; /* socket has been closed */
-			/* fallthrough */
+			fallthrough;
 		case -EWOULDBLOCK:
 		case -ETIMEDOUT:
 		case -EINTR:
diff --git a/kernel/drivers/net/stack/packet/af_packet.c b/kernel/drivers/net/stack/packet/af_packet.c
index b55235ec19..6013ff9e74 100644
--- a/kernel/drivers/net/stack/packet/af_packet.c
+++ b/kernel/drivers/net/stack/packet/af_packet.c
@@ -326,7 +326,7 @@ static ssize_t rt_packet_recvmsg(struct rtdm_fd *fd, struct user_msghdr *msg,
 		switch (ret) {
 		default:
 			ret = -EBADF; /* socket has been closed */
-			/* fallthrough */
+			fallthrough;
 		case -EWOULDBLOCK:
 		case -ETIMEDOUT:
 		case -EINTR:
diff --git a/kernel/drivers/testing/switchtest.c b/kernel/drivers/testing/switchtest.c
index 6f8a9fcaa3..b5bc256dfa 100644
--- a/kernel/drivers/testing/switchtest.c
+++ b/kernel/drivers/testing/switchtest.c
@@ -432,7 +432,7 @@ static void rtswitch_ktask(void *cookie)
 			if (to == task->base.index)
 				++to;
 
-			/* Fall through. */
+			fallthrough;
 		case 2:
 			rtswitch_to_rt(ctx, task->base.index, to);
 		}
-- 
2.31.1


