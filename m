Message-ID: <44F5FA7F.6020405@domain.hid>
Date: Wed, 30 Aug 2006 22:52:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1D3DED2CF5C936C25D73C85B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] add virtual CAN bus driver
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Wolfgang Grandegger <wg@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1D3DED2CF5C936C25D73C85B
Content-Type: multipart/mixed; boundary="------------020608020507030307060603"

This is a multi-part message in MIME format.
--------------020608020507030307060603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

For review:

Here comes a tiny but fairly useful new CAN driver: a virtual CAN bus
consisting of 2..n devices (see module parameter). Transmission takes
places from the sender to all other devices on the bus, just like in
real life.

This driver was already helpful for me while adapting CanFestival, a
LGPL CANopen library, to our CAN API -- inside qemu, i.e. without any
real hardware around.

Jan

--------------020608020507030307060603
Content-Type: text/x-patch;
 name="rtcan_virt.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="rtcan_virt.patch"

Index: scripts/Modules.frag
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- scripts/Modules.frag	(Revision 1527)
+++ scripts/Modules.frag	(Arbeitskopie)
@@ -12,6 +12,7 @@ DRIVERS-$(CONFIG_XENO_DRIVERS_TIMERBENCH
 DRIVERS-$(CONFIG_XENO_DRIVERS_IRQBENCH) +=3D drivers/xenomai/testing/xen=
o_irqbench.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_SWITCHTEST) +=3D drivers/xenomai/testing/x=
eno_switchtest.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN) +=3D drivers/xenomai/can/xeno_rtcan=
=2Eo
+DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_VIRT) +=3D drivers/xenomai/can/xeno_=
rtcan_virt.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_MSCAN) +=3D drivers/xenomai/can/msca=
n/xeno_rtcan_mscan.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000) +=3D drivers/xenomai/can/sj=
a1000/xeno_rtcan_sja1000.o
 DRIVERS-$(CONFIG_XENO_DRIVERS_RTCAN_SJA1000_PEAK_PCI) +=3D drivers/xenom=
ai/can/sja1000/xeno_rtcan_peak_pci.o
Index: ksrc/drivers/can/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/Kconfig	(Revision 1527)
+++ ksrc/drivers/can/Kconfig	(Arbeitskopie)
@@ -26,6 +26,10 @@ config XENO_DRIVERS_RTCAN_MAX_RECEIVERS
        int "Maximum number of receive filters per device"
        default 16
=20
+config XENO_DRIVERS_RTCAN_VIRT
+	depends on XENO_DRIVERS_RTCAN
+	tristate "Virtual tunnelling driver"
+
 source drivers/xenomai/can/mscan/Kconfig
 source drivers/xenomai/can/sja1000/Kconfig
=20
Index: ksrc/drivers/can/rtcan_virt.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/rtcan_virt.c	(Revision 0)
+++ ksrc/drivers/can/rtcan_virt.c	(Revision 0)
@@ -0,0 +1,195 @@
+/*
+ * Copyright (C) 2006 Jan Kiszka <jan.kiszka@domain.hid>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundatio=
n,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+
+#include <linux/module.h>
+#include <rtdm/rtdm_driver.h>
+#include <rtdm/rtcan.h>
+#include "rtcan_dev.h"
+#include "rtcan_raw.h"
+
+#define RTCAN_DEV_NAME          "rtcan%d"
+#define RTCAN_DRV_NAME          "VIRT"
+#define RTCAN_MAX_VIRT_DEVS     8
+
+#define VIRT_TX_BUFS            1
+
+static char *virt_ctlr_name  =3D "<virtual>";
+static char *virt_board_name =3D "<virtual>";
+
+MODULE_AUTHOR("Jan Kiszka <jan.kiszka@domain.hid>");
+MODULE_DESCRIPTION("Virtual RT-Socket-CAN driver");
+MODULE_LICENSE("GPL");
+
+static unsigned int devices =3D 2;
+
+module_param(devices, uint, 0400);
+MODULE_PARM_DESC(devices, "Number of devices on the virtual bus");
+
+static struct rtcan_device *rtcan_virt_devs[RTCAN_MAX_VIRT_DEVS];
+
+
+static int rtcan_virt_start_xmit(struct rtcan_device *tx_dev,
+                                 can_frame_t *tx_frame)
+{
+	int i;
+	struct rtcan_device *rx_dev;
+	struct rtcan_skb skb;
+	struct rtcan_rb_frame *rx_frame =3D &skb.rb_frame;
+	nanosecs_abs_t timestamp =3D rtdm_clock_read();
+	rtdm_lockctx_t lock_ctx;
+
+	/* we can transmit immediately again */
+	rtdm_sem_up(&tx_dev->tx_sem);
+
+	skb.rb_frame_size =3D EMPTY_RB_FRAME_SIZE;
+
+	rx_frame->can_dlc =3D tx_frame->can_dlc;
+	rx_frame->can_id  =3D tx_frame->can_id;
+
+	if (!(tx_frame->can_id & CAN_RTR_FLAG)) {
+		memcpy(rx_frame->data, tx_frame->data, tx_frame->can_dlc);
+		skb.rb_frame_size +=3D tx_frame->can_dlc;
+	}
+
+	/* Copy timestamp to skb */
+	memcpy((void *)&skb.rb_frame + skb.rb_frame_size,
+	       &timestamp, TIMESTAMP_SIZE);
+
+	rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
+	rtdm_lock_get(&rtcan_socket_lock);
+
+	/* Deliver to all other devices on the virtual bus */
+	for (i =3D 0; i < devices; i++) {
+		rx_dev =3D rtcan_virt_devs[i];
+		if (tx_dev !=3D rx_dev && rx_dev->state =3D=3D CAN_STATE_ACTIVE) {
+			rx_frame->can_ifindex =3D rx_dev->ifindex;
+			rtcan_rcv(rx_dev, &skb);
+		}
+	}
+
+	rtdm_lock_put(&rtcan_socket_lock);
+	rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);
+
+	return 0;
+}
+
+
+static int rtcan_virt_set_mode(struct rtcan_device *dev, can_mode_t mode=
,
+                               rtdm_lockctx_t *lock_ctx)
+{
+	int err =3D 0;
+
+	switch (mode) {
+	case CAN_MODE_STOP:
+		dev->state =3D CAN_STATE_STOPPED;
+		/* Wake up waiting senders */
+		rtdm_sem_destroy(&dev->tx_sem);
+		break;
+
+	case CAN_MODE_START:
+		if (dev->state =3D=3D CAN_STATE_STOPPED)
+			rtdm_sem_init(&dev->tx_sem, VIRT_TX_BUFS);
+		dev->state =3D CAN_STATE_ACTIVE;
+		break;
+
+	default:
+		err =3D -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+
+static int __init rtcan_virt_init_one(int idx)
+{
+	struct rtcan_device *dev;
+	int err;
+
+	if ((dev =3D rtcan_dev_alloc(0, 0)) =3D=3D NULL)
+		return -ENOMEM;
+
+	dev->ctrl_name =3D virt_ctlr_name;
+	dev->board_name =3D virt_board_name;
+
+	dev->state =3D CAN_STATE_STOPPED;
+
+	strncpy(dev->name, RTCAN_DEV_NAME, IFNAMSIZ);
+
+	dev->hard_start_xmit =3D rtcan_virt_start_xmit;
+	dev->do_set_mode =3D rtcan_virt_set_mode;
+
+	/* Register RTDM device */
+	err =3D rtcan_dev_register(dev);
+	if (err) {
+		printk(KERN_ERR "ERROR while trying to register RTCAN device!\n");
+		goto error_out;
+	}
+
+	/* Remember initialized devices */
+	rtcan_virt_devs[idx] =3D dev;
+
+	printk("%s: %s driver loaded\n", dev->name, RTCAN_DRV_NAME);
+
+	return 0;
+
+ error_out:
+	rtcan_dev_free(dev);
+	return err;
+}
+
+
+/** Init module */
+static int __init rtcan_virt_init(void)
+{
+	int i, err =3D 0;
+
+	for (i =3D 0; i < devices; i++) {
+		err =3D rtcan_virt_init_one(i);
+		if (err)
+			while (--i >=3D 0) {
+				struct rtcan_device *dev =3D rtcan_virt_devs[i];
+
+				rtcan_dev_unregister(dev);
+				rtcan_dev_free(dev);
+			}
+	}
+
+	return err;
+}
+
+
+/** Cleanup module */
+static void __exit rtcan_virt_exit(void)
+{
+	int i;
+	struct rtcan_device *dev;
+
+	for (i =3D 0; i < devices; i++) {
+		dev =3D rtcan_virt_devs[i];
+
+		printk("Unloading %s device %s\n", RTCAN_DRV_NAME, dev->name);
+
+		rtcan_dev_unregister(dev);
+		rtcan_dev_free(dev);
+	}
+}
+
+module_init(rtcan_virt_init);
+module_exit(rtcan_virt_exit);
Index: ksrc/drivers/can/Config.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/Config.in	(Revision 1527)
+++ ksrc/drivers/can/Config.in	(Arbeitskopie)
@@ -13,6 +13,8 @@ if [ "$CONFIG_XENO_DRIVERS_RTCAN" !=3D "n"
    int 'Maximum number of devices' CONFIG_XENO_DRIVERS_RTCAN_MAX_DEVICES=
 4
    int 'Maximum number of receive filters per device' CONFIG_XENO_DRIVER=
S_RTCAN_MAX_RECEIVERS 16
=20
+   dep_tristate 'Virtual tunnelling driver' CONFIG_XENO_DRIVERS_RTCAN_VI=
RT $CONFIG_XENO_DRIVERS_RTCAN
+
    source drivers/xenomai/can/mscan/Config.in
    source drivers/xenomai/can/sja1000/Config.in
=20
Index: ksrc/drivers/can/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ksrc/drivers/can/Makefile	(Revision 1527)
+++ ksrc/drivers/can/Makefile	(Arbeitskopie)
@@ -5,8 +5,10 @@ ifeq ($(PATCHLEVEL),6)
 EXTRA_CFLAGS +=3D -Iinclude/xenomai -Idrivers/xenomai/can
=20
 obj-$(CONFIG_XENO_DRIVERS_RTCAN) +=3D xeno_rtcan.o mscan/ sja1000/
+obj-$(CONFIG_XENO_DRIVERS_RTCAN_VIRT) +=3D xeno_rtcan_virt.o
=20
 xeno_rtcan-y :=3D rtcan_dev.o rtcan_socket.o rtcan_module.o rtcan_raw.o =
rtcan_raw_dev.o rtcan_raw_filter.o
+xeno_rtcan_virt-y :=3D rtcan_virt.o
=20
 else
=20
@@ -19,11 +21,13 @@ subdir-$(CONFIG_XENO_DRIVERS_RTCAN_SJA10
=20
 O_TARGET :=3D built-in.o
=20
-obj-$(CONFIG_XENO_DRIVERS_RTCAN) :=3D xeno_rtcan.o
+obj-$(CONFIG_XENO_DRIVERS_RTCAN) +=3D xeno_rtcan.o
+obj-$(CONFIG_XENO_DRIVERS_RTCAN_VIRT) +=3D xeno_rtcan_virt.o
=20
 list-multi :=3D xeno_rtcan.o
=20
 xeno_rtcan-objs :=3D rtcan_dev.o rtcan_socket.o rtcan_module.o rtcan_raw=
=2Eo rtcan_raw_dev.o rtcan_raw_filter.o
+xeno_rtcan_virt-objs :=3D rtcan_virt.o
=20
 export-objs :=3D $(xeno_rtcan-objs)
=20
@@ -34,4 +38,7 @@ include $(TOPDIR)/Rules.make
 xeno_rtcan.o: $(xeno_rtcan-objs)
 	$(LD) -r -o $@ $(xeno_rtcan-objs)
=20
+xeno_rtcan_virt.o: $(xeno_rtcan_virt-objs)
+	$(LD) -r -o $@ $(xeno_rtcan_virt-objs)
+
 endif

--------------020608020507030307060603--

--------------enig1D3DED2CF5C936C25D73C85B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE9fp/niDOoMHTA+kRAs60AJ9g3I/FELYRl61euaYf7V0/fcjpMQCfQgap
OVsQ7RbUGcePx0t0tlCh+vA=
=ynM0
-----END PGP SIGNATURE-----

--------------enig1D3DED2CF5C936C25D73C85B--

