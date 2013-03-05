Message-ID: <51361281.20307@hilscher.com>
Date: Tue, 05 Mar 2013 16:42:57 +0100
From: Jerome Poncin <JPoncin@hilscher.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>
	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>
	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>
	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>
	<5130B39C.70300@hilscher.com> <513465CF.4030807@hilscher.com>
	<51350D5B.6060309@xenomai.org> <5135CCDE.5090401@hilscher.com>
	<5135D667.8060309@siemens.com>
In-Reply-To: <5135D667.8060309@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Finally, I removed #define Debug  with a little code re factoring. I =

tested with all kernel compilation.
It run well, therefore I send you my last patch.

Thank you for your help,

Hilscher France
12, rue du 35=E8me R=E9giment d'Aviation
Miniparc du Ch=EAne
69500 BRON
France
T=E9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http://www.hilscher.fr
HILSCHER FRANCE 	J=E9r=F4me Poncin
jponcin@hilscher.com
Ing=E9nieur D=E9veloppement Logiciel
T=E9l. : +33 (0) 4 72 37 98 44


-------------- next part --------------
diff --git a/include/asm-generic/pci_ids.h b/include/asm-generic/pci_ids.h
index d298bf4..3f8d7cc 100644
--- a/include/asm-generic/pci_ids.h
+++ b/include/asm-generic/pci_ids.h
@@ -40,4 +40,45 @@
 #define PCI_DEVICE_ID_PLX_9056 0x9056
 #endif
 =

+/* cifx */
+#ifndef PCI_VENDOR_ID_HILSCHER
+#define PCI_VENDOR_ID_HILSCHER 0x15CF
+#endif
+
+#ifndef PCI_DEVICE_ID_HILSCHER_NETX
+#define PCI_DEVICE_ID_HILSCHER_NETX 0x0000
+#endif
+
+#ifndef PCI_DEVICE_ID_HILSCHER_NETPLC
+#define PCI_DEVICE_ID_HILSCHER_NETPLC 0x0010
+#endif
+
+#ifndef PCI_DEVICE_ID_HILSCHER_NETJACK
+#define PCI_DEVICE_ID_HILSCHER_NETJACK 0x0020
+#endif
+
+#ifndef PCI_SUBDEVICE_ID_NXSB_PCA
+#define PCI_SUBDEVICE_ID_NXSB_PCA 0x3235
+#endif
+
+#ifndef PCI_SUBDEVICE_ID_NXPCA
+#define PCI_SUBDEVICE_ID_NXPCA 0x3335
+#endif
+
+#ifndef PCI_SUBDEVICE_ID_NETPLC_RAM
+#define PCI_SUBDEVICE_ID_NETPLC_RAM 0x0000
+#endif
+
+#ifndef PCI_SUBDEVICE_ID_NETPLC_FLASH
+#define PCI_SUBDEVICE_ID_NETPLC_FLASH 0x0001
+#endif
+
+#ifndef PCI_SUBDEVICE_ID_NETJACK_RAM
+#define PCI_SUBDEVICE_ID_NETJACK_RAM 0x0000
+#endif
+
+#ifndef PCI_SUBDEVICE_ID_NETJACK_FLASH
+#define PCI_SUBDEVICE_ID_NETJACK_FLASH 0x0001
+#endif
+
 #endif /* _XENO_ASM_GENERIC_PCI_IDS_H */
diff --git a/ksrc/drivers/cifx/Kconfig b/ksrc/drivers/cifx/Kconfig
new file mode 100644
index 0000000..715a45e
--- /dev/null
+++ b/ksrc/drivers/cifx/Kconfig
@@ -0,0 +1,11 @@
+menu "Hilscher cifX driver"
+
+config XENO_DRIVERS_CIFX
+	depends on XENO_SKIN_RTDM
+	tristate "Hilscher cifX"
+	help
+
+	This driver provides Hilscher cifX =

+	over RTDM.
+
+endmenu
diff --git a/ksrc/drivers/cifx/Makefile b/ksrc/drivers/cifx/Makefile
new file mode 100644
index 0000000..42550bd
--- /dev/null
+++ b/ksrc/drivers/cifx/Makefile
@@ -0,0 +1,13 @@
+ifneq ($(VERSION).$(PATCHLEVEL),2.4)
+
+# Makefile frag for Linux v2.6 and v3.x
+
+EXTRA_CFLAGS +=3D -D__IN_XENOMAI__ -Iinclude/xenomai -Idrivers/xenomai/cifx
+
+obj-$(CONFIG_XENO_DRIVERS_CIFX) +=3D xeno_cifx_pci.o
+
+xeno_cifx_pci-y :=3D cifx_pci.o
+
+xeno_cifx_pci-$(CONFIG_XENO_DRIVERS_RTIPC_CIFX) +=3D cifx_pci.o
+
+endif
diff --git a/ksrc/drivers/cifx/cifx_pci.c b/ksrc/drivers/cifx/cifx_pci.c
new file mode 100644
index 0000000..2cfe2c0
--- /dev/null
+++ b/ksrc/drivers/cifx/cifx_pci.c
@@ -0,0 +1,638 @@
+/*
+ * Copyright (C) 2013 Hilscher France (JP) <www.hilscher.fr>
+ *
+ * Xenomai is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/mman.h>
+
+#include <asm-generic/xenomai/pci_ids.h>
+
+#include <rtdm/rtdm_driver.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("RTDM board driver for CifX cards");
+MODULE_AUTHOR("Hilscher France (JP) <www.hilscher.fr>");
+
+#define DPM_HOST_INT_EN0                0xfff0
+#define DPM_HOST_INT_STAT0              0xffe0
+#define PLX_GPIO_OFFSET                 0x15
+#define PLX_TIMING_OFFSET               0x0a
+
+#define DPM_HOST_INT_MASK               0xe600ffff
+#define DPM_HOST_INT_GLOBAL_EN          0x80000000
+#define PLX_GPIO_DATA0_MASK             0x00000004
+#define PLX_GPIO_DATA1_MASK             0x00000020
+
+#define NX_PCA_PCI_8_BIT_DPM_MODE       0x5431F962
+#define NX_PCA_PCI_16_BIT_DPM_MODE      0x4073F8E2
+#define NX_PCA_PCI_32_BIT_DPM_MODE      0x40824122
+
+/* Number of bar */
+/* points to the DPM -> netX, netPLC, netJACK */
+#define DPM_BAR                         0
+/* points to the optional extended memory     */
+#define EXT_MEM_BAR                     1
+/* points to the DPM -> netXPLX               */
+#define PLX_DPM_BAR                     2
+/* timing config register                     */
+#define PXA_PLX_BAR                     0
+
+/* Index of io_info structure's memory array */
+/* first mapping describes DPM              */
+#define DPM_INDEX                       0
+/* second mapping describes extended memory */
+#define EXT_MEM_INDEX                   1
+
+#define MAX_MAPS                        2
+
+#define MEM_PHYS                        1
+
+#define DRIVER_NAME                     "rtdm_cifx"
+#define PERIPHERAL_NAME                 "cifx"
+#define PROVIDER_NAME                   "Hilscher"
+
+/* name of a NXSB-PCA or NXPCA-PCI card */
+#define CIFX_RTDM_PLX_CARD_NAME         "netx_plx"
+/* name of a cifX PCI card              */
+#define CIFX_RTDM_CARD_NAME             "netx"
+/* name of a netPLC PCI card            */
+#define CIFX_RTDM_NETPLC_CARD_NAME      "netplc"
+/* name of a netJACK PCI card           */
+#define CIFX_RTDM_NETJACK_CARD_NAME     "netjack"
+
+struct pxa_dev_info {
+	uint32_t __iomem *plx;
+	uint8_t dpm_mode;
+	uint32_t plx_timing;
+};
+
+struct io_mem {
+	uint32_t addr;
+	uint32_t size;
+	int32_t memtype;
+	void __iomem *internal_addr;
+};
+
+struct io_info {
+	struct io_mem mem[MAX_MAPS];
+	int32_t irq;
+	bool irq_enable;
+	bool irq_registered;
+	rtdm_irq_t irq_handle;
+	void *priv;
+};
+
+struct io_map_mem {
+	uint32_t phys_addr;
+	void **virt_addr;
+	uint32_t length;
+};
+
+static int cifx_pxa_set_plx_timing(struct rtdm_device *info);
+static int cifx_pxa_get_plx_timing(struct rtdm_device *info);
+static int cifx_pxa_get_dpm_mode(struct rtdm_device *info);
+
+static int cifx_pci_open(struct rtdm_dev_context *context,
+			 rtdm_user_info_t *user_info, int oflags);
+static int cifx_pci_close(struct rtdm_dev_context *context,
+			  rtdm_user_info_t *user_info);
+static ssize_t cifx_pci_read(struct rtdm_dev_context *context,
+			     rtdm_user_info_t *user_info, void *buf,
+			     size_t nbyte);
+static ssize_t cifx_pci_write(struct rtdm_dev_context *context,
+			      rtdm_user_info_t *user_info, const void *buf,
+			      size_t nbyte);
+
+static int cifx_pci_probe(struct pci_dev *dev, const struct pci_device_id =
*id);
+static void cifx_pci_remove(struct pci_dev *dev);
+
+/* Number or cifx found and open */
+static int32_t cifx_num;
+
+/* RTDM Device information structure */
+static const struct rtdm_device __initdata cifx_device_tmpl =3D {
+	.struct_version =3D RTDM_DEVICE_STRUCT_VER,
+
+	.device_flags =3D RTDM_NAMED_DEVICE,
+	.context_size =3D 0,
+	.device_name =3D "",
+
+	.open_nrt =3D cifx_pci_open,
+
+	.ops =3D {
+		.close_nrt =3D cifx_pci_close,
+
+		.read_nrt =3D cifx_pci_read,
+		.write_nrt =3D cifx_pci_write,
+
+		.ioctl_rt =3D NULL,
+		.ioctl_nrt =3D NULL,
+
+		.read_rt =3D NULL,
+		.write_rt =3D NULL,
+		},
+
+	.device_class =3D RTDM_CLASS_EXPERIMENTAL,
+	.device_sub_class =3D RTDM_SUBCLASS_GENERIC,
+	.profile_version =3D 1,
+	.driver_name =3D DRIVER_NAME,
+	.driver_version =3D RTDM_DRIVER_VER(1, 0, 0),
+	.provider_name =3D PROVIDER_NAME,
+};
+
+/* Device table */
+static DEFINE_PCI_DEVICE_TABLE(cifx_pci_tbl) =3D {
+	{PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETX,
+	0, 0},
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+	PCI_VENDOR_ID_PLX, PCI_SUBDEVICE_ID_NXSB_PCA},
+	{PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
+	PCI_VENDOR_ID_PLX, PCI_SUBDEVICE_ID_NXPCA},
+	{PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETPLC,
+	PCI_VENDOR_ID_HILSCHER, PCI_SUBDEVICE_ID_NETPLC_RAM},
+	{PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETPLC,
+	PCI_VENDOR_ID_HILSCHER, PCI_SUBDEVICE_ID_NETPLC_FLASH},
+	{PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETJACK,
+	PCI_VENDOR_ID_HILSCHER, PCI_SUBDEVICE_ID_NETJACK_RAM},
+	{PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETJACK,
+	PCI_VENDOR_ID_HILSCHER, PCI_SUBDEVICE_ID_NETJACK_FLASH},
+	{ 0,}
+};
+
+/* RTDM cifX Driver */
+static struct pci_driver cifx_pci_driver =3D {
+	.name =3D "cifx",
+	.id_table =3D cifx_pci_tbl,
+	.probe =3D cifx_pci_probe,
+	.remove =3D cifx_pci_remove,
+};
+
+/*
+ *	cifx_pxa_set_plx_timing
+ *	Set plx timing
+ */
+static int cifx_pxa_set_plx_timing(struct rtdm_device *info)
+{
+	struct pxa_dev_info *pxa_info =3D
+	    (struct pxa_dev_info *)((struct io_info *)info->device_data)->priv;
+	uint32_t __iomem *plx_timing;
+
+	if (pxa_info =3D=3D NULL)
+		return -ENODEV;
+
+	plx_timing =3D pxa_info->plx + PLX_TIMING_OFFSET;
+	*plx_timing =3D pxa_info->plx_timing;
+
+	return 0;
+}
+
+/*
+ * cifx_pxa_get_plx_timing
+ * Get plx timing
+ */
+static int cifx_pxa_get_plx_timing(struct rtdm_device *info)
+{
+	struct pxa_dev_info *pxa_info =3D
+	    (struct pxa_dev_info *)((struct io_info *)info->device_data)->priv;
+
+	if (pxa_info =3D=3D NULL)
+		return -ENODEV;
+
+	switch (pxa_info->dpm_mode) {
+	case 8:
+		pxa_info->plx_timing =3D NX_PCA_PCI_8_BIT_DPM_MODE;
+		break;
+	case 16:
+		pxa_info->plx_timing =3D NX_PCA_PCI_16_BIT_DPM_MODE;
+		break;
+	case 32:
+		pxa_info->plx_timing =3D NX_PCA_PCI_32_BIT_DPM_MODE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * cifx_pxa_get_dpm_mode
+ * Get dpm mode
+ */
+static int cifx_pxa_get_dpm_mode(struct rtdm_device *info)
+{
+	struct pxa_dev_info *pxa_info =3D
+	    (struct pxa_dev_info *)((struct io_info *)info->device_data)->priv;
+	uint32_t __iomem *plx_gpio;
+
+	if (pxa_info =3D=3D NULL)
+		return -ENODEV;
+
+	plx_gpio =3D pxa_info->plx + PLX_GPIO_OFFSET;
+
+	if ((*plx_gpio & PLX_GPIO_DATA0_MASK)
+	    && ~(*plx_gpio & PLX_GPIO_DATA1_MASK))
+		pxa_info->dpm_mode =3D 8;
+	else if (~(*plx_gpio & PLX_GPIO_DATA0_MASK)
+		 && (*plx_gpio & PLX_GPIO_DATA1_MASK))
+		pxa_info->dpm_mode =3D 32;
+	else if (~(*plx_gpio & PLX_GPIO_DATA0_MASK)
+		 && ~(*plx_gpio & PLX_GPIO_DATA1_MASK))
+		pxa_info->dpm_mode =3D 16;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * cifx_pci_open
+ * Open RTDM cifx pci driver
+ */
+static int cifx_pci_open(struct rtdm_dev_context *context,
+			 rtdm_user_info_t *user_info, int oflags)
+{
+	return 0;
+}
+
+/*
+ * cifx_pci_close
+ * Close RTDM cifx pci driver
+ */
+static int cifx_pci_close(struct rtdm_dev_context *context,
+			  rtdm_user_info_t *user_info)
+{
+	return 0;
+}
+
+/*
+ * cifx_pci_read
+ * Read
+ */
+static ssize_t cifx_pci_read(struct rtdm_dev_context *context,
+			     rtdm_user_info_t *user_info, void *buf,
+			     size_t nbyte)
+{
+	struct rtdm_device *info =3D (struct rtdm_device *)context->device;
+
+	if (nbyte > sizeof(struct io_info))
+		return 0;
+
+	/* Copy data information for userland */
+	if (rtdm_safe_copy_to_user(user_info, buf,
+				   ((struct io_info *)info->device_data),
+				   nbyte))
+		return 0;
+
+	return nbyte;
+}
+
+/*
+ * cifx_pci_write
+ * write
+ */
+static ssize_t cifx_pci_write(struct rtdm_dev_context *context,
+			      rtdm_user_info_t *user_info, const void *buf,
+			      size_t nbyte)
+{
+	struct io_map_mem map_mem;
+	int ret;
+
+	if (nbyte > sizeof(struct io_map_mem))
+		return 0;
+
+	if (nbyte =3D=3D sizeof(struct io_map_mem)) {
+		/* Copy data information for Kernel */
+		if (rtdm_safe_copy_from_user(user_info, &map_mem, buf, nbyte)) {
+			nbyte =3D 0;
+		} else {
+			if (*map_mem.virt_addr =3D=3D NULL) {
+				/* Map physical on virtual memory */
+				ret =3D rtdm_iomap_to_user(user_info,
+							 (phys_addr_t) map_mem.
+							 phys_addr,
+							 (size_t) map_mem.
+							 length,
+							 (PROT_READ |
+							  PROT_WRITE),
+							 map_mem.virt_addr,
+							 NULL, NULL);
+
+				if (ret !=3D 0)
+					nbyte =3D 0;
+			} else {
+				/* Unap virtual memory */
+				ret =3D rtdm_munmap(user_info, *map_mem.virt_addr,
+						  (size_t) map_mem.length);
+
+				if (ret !=3D 0)
+					nbyte =3D 0;
+			}
+		}
+	} else {
+		/* Error nothing to do */
+		nbyte =3D 0;
+	}
+
+	return nbyte;
+}
+
+static int cifx_pci_probe(struct pci_dev *dev, const struct pci_device_id =
*id)
+{
+	struct rtdm_device *info =3D NULL;
+	struct io_info_t *device_data =3D NULL;
+	int32_t bar;
+	int32_t ret;
+
+	/* Allocate device driver structure */
+	info =3D rtdm_malloc(sizeof(struct rtdm_device));
+
+	if (info =3D=3D NULL)
+		return -ENOMEM;
+
+	ret =3D pci_enable_device(dev);
+	if (ret !=3D 0)
+		goto out_free;
+
+	ret =3D pci_request_regions(dev, DRIVER_NAME);
+	if (ret !=3D 0)
+		goto out_disable;
+
+	/* Initialize structure with default values */
+	memcpy(info, &cifx_device_tmpl, sizeof(*info));
+
+	info->device_id =3D id->device;
+	snprintf((char *)info->device_name, RTDM_MAX_DEVNAME_LEN, "cifx%i",
+		 cifx_num);
+	info->proc_name =3D info->device_name;
+
+	switch (id->device) {
+	case PCI_DEVICE_ID_HILSCHER_NETX:
+		bar =3D DPM_BAR;
+		info->peripheral_name =3D CIFX_RTDM_CARD_NAME;
+		break;
+	case PCI_DEVICE_ID_HILSCHER_NETPLC:
+		bar =3D DPM_BAR;
+		info->peripheral_name =3D CIFX_RTDM_NETPLC_CARD_NAME;
+		break;
+	case PCI_DEVICE_ID_HILSCHER_NETJACK:
+		bar =3D DPM_BAR;
+		info->peripheral_name =3D CIFX_RTDM_NETJACK_CARD_NAME;
+		break;
+	default:
+		bar =3D PLX_DPM_BAR;
+		info->peripheral_name =3D CIFX_RTDM_PLX_CARD_NAME;
+		break;
+	}
+
+	info->device_data =3D NULL;
+
+	/* Allocate specific data strcuture for device */
+	device_data =3D rtdm_malloc(sizeof(struct io_info));
+
+	if (device_data =3D=3D NULL)
+		goto out_release;
+
+	memset(device_data, 0, sizeof(struct io_info));
+
+	/* BAR 0 or 2 points to the card's dual port memory */
+	((struct io_info *)device_data)->mem[DPM_INDEX].addr =3D
+	    pci_resource_start(dev, bar);
+
+	if (((struct io_info *)device_data)->mem[DPM_INDEX].addr =3D=3D 0)
+		goto out_release;
+
+	((struct io_info *)device_data)->mem[DPM_INDEX].internal_addr =3D
+	    ioremap_nocache(pci_resource_start(dev, bar),
+			    pci_resource_len(dev, bar));
+
+	if (((struct io_info *)device_data)->mem[DPM_INDEX].internal_addr
+									=3D=3D 0)
+		goto out_release;
+
+
+	dev_info(&dev->dev, "DPM at %08lX\n",
+		 (long unsigned int)((struct io_info *)device_data)->
+		 mem[DPM_INDEX].addr);
+	((struct io_info *)device_data)->mem[DPM_INDEX].size =3D
+	    pci_resource_len(dev, bar);
+	((struct io_info *)device_data)->mem[DPM_INDEX].memtype =3D MEM_PHYS;
+
+	/* map extended mem (BAR 1 points to the extended memory) */
+	((struct io_info *)device_data)->mem[EXT_MEM_INDEX].addr =3D
+	    pci_resource_start(dev, EXT_MEM_BAR);
+
+	/* extended memory is optional, so don't care if it is not present */
+	if (((struct io_info *)device_data)->mem[EXT_MEM_INDEX].addr !=3D 0) {
+		((struct io_info *)device_data)->mem[EXT_MEM_INDEX].
+		    internal_addr =3D
+		    ioremap_nocache(pci_resource_start(dev, EXT_MEM_BAR),
+				    pci_resource_len(dev, EXT_MEM_BAR));
+
+		if (((struct io_info *)device_data)->mem[EXT_MEM_INDEX].
+		    internal_addr =3D=3D 0)
+			goto out_unmap;
+
+		dev_info(&dev->dev, "extended memory at %08lX\n",
+			 (long unsigned int)((struct io_info *)device_data)->
+			 mem[EXT_MEM_INDEX].addr);
+		((struct io_info *)device_data)->mem[EXT_MEM_INDEX].size =3D
+		    pci_resource_len(dev, EXT_MEM_BAR);
+		((struct io_info *)device_data)->mem[EXT_MEM_INDEX].memtype =3D
+		    MEM_PHYS;
+	}
+
+	if ((id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETX)
+	    || (id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETPLC)
+	    || (id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETJACK)) {
+		/* make sure all interrupts are disabled */
+		iowrite32(0,
+			  ((struct io_info *)device_data)->mem[DPM_INDEX].
+			  internal_addr + DPM_HOST_INT_EN0);
+		((struct io_info *)device_data)->priv =3D NULL;
+	} else if (id->subdevice =3D=3D PCI_SUBDEVICE_ID_NXPCA) {
+		/* map PLX registers */
+		struct pxa_dev_info *pxa_info =3D
+		    (struct pxa_dev_info *)
+		    rtdm_malloc(sizeof(struct pxa_dev_info));
+
+		if (pxa_info =3D=3D NULL)
+			goto out_unmap;
+
+		((struct io_info *)device_data)->priv =3D pxa_info;
+
+		/* set PXA PLX Timings */
+		pxa_info->plx =3D
+		    ioremap_nocache(pci_resource_start(dev, PXA_PLX_BAR),
+				    pci_resource_len(dev, PXA_PLX_BAR));
+
+		if (pxa_info->plx =3D=3D NULL)
+			goto out_unmap;
+		if (cifx_pxa_get_dpm_mode(info))
+			goto out_unmap_plx;
+		if (cifx_pxa_get_plx_timing(info))
+			goto out_unmap_plx;
+		if (cifx_pxa_set_plx_timing(info))
+			goto out_unmap_plx;
+	} else {
+		struct pxa_dev_info *pxa_info =3D
+		    (struct pxa_dev_info *)
+		    rtdm_malloc(sizeof(struct pxa_dev_info));
+
+		if (pxa_info =3D=3D NULL)
+			goto out_free_pxa;
+
+		((struct pxa_dev_info *)pxa_info)->plx =3D NULL;
+		((struct pxa_dev_info *)pxa_info)->plx_timing =3D 0;
+		((struct pxa_dev_info *)pxa_info)->dpm_mode =3D 0;
+		((struct io_info *)device_data)->priv =3D pxa_info;
+	}
+
+	/* Initialize irq data */
+	((struct io_info *)device_data)->irq =3D dev->irq;
+	((struct io_info *)device_data)->irq_enable =3D 0;
+	((struct io_info *)device_data)->irq_registered =3D 0;
+
+	info->device_data =3D device_data;
+
+	/* Register RTDM device driver */
+	ret =3D rtdm_dev_register(info);
+	if (ret !=3D 0) {
+		if (id->subdevice !=3D PCI_SUBDEVICE_ID_NXPCA)
+			goto out_unmap;
+		else
+			goto out_unmap_plx;
+	}
+
+	pci_set_drvdata(dev, info);
+
+	if (id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETX)
+		dev_info(&dev->dev, "registered CifX card\n");
+	else if (id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETPLC)
+		dev_info(&dev->dev, "registered netPLC card\n");
+	else if (id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETJACK)
+		dev_info(&dev->dev, "registered netJACK card\n");
+	else if (id->subdevice =3D=3D PCI_SUBDEVICE_ID_NXSB_PCA)
+		dev_info(&dev->dev, "registered NXSB-PCA adapter card\n");
+	else {
+		struct pxa_dev_info *pxa_info =3D
+		    (struct pxa_dev_info *)((struct io_info *)info->
+					    device_data)->priv;
+		dev_info(&dev->dev,
+			 "registered NXPCA-PCI adapter card in %d bit mode\n",
+			 ((struct pxa_dev_info *)pxa_info)->dpm_mode);
+	}
+
+	cifx_num++;
+
+	return 0;
+
+ out_unmap_plx:
+	iounmap(((struct pxa_dev_info *)(((struct io_info *)info->device_data)->
+					 priv))->plx);
+
+ out_free_pxa:
+	rtdm_free(((struct io_info *)info->device_data)->priv);
+
+ out_unmap:
+	iounmap(((struct io_info *)info->device_data)->mem[DPM_INDEX].
+		internal_addr);
+	if (((struct io_info *)info->device_data)->mem[EXT_MEM_INDEX].
+	    internal_addr !=3D 0)
+		iounmap(((struct io_info *)info->device_data)->
+			mem[EXT_MEM_INDEX].internal_addr);
+
+ out_release:
+	pci_release_regions(dev);
+
+ out_disable:
+	pci_disable_device(dev);
+
+ out_free:
+	if (info->device_data !=3D NULL)
+		rtdm_free(info->device_data);
+
+	rtdm_free(info);
+
+	return -ENODEV;
+}
+
+static void cifx_pci_remove(struct pci_dev *dev)
+{
+	struct rtdm_device *info =3D pci_get_drvdata(dev);
+	struct io_info *device_data =3D (struct io_info *)info->device_data;
+	struct pxa_dev_info *pxa_info =3D
+	    (struct pxa_dev_info *)device_data->priv;
+	int32_t ret;
+
+	if (info->device_data =3D=3D NULL)
+		return;
+
+	if (pxa_info !=3D NULL) {
+		/* Disable all interrupts */
+		iowrite32(0,
+			  ((struct io_info *)device_data)->mem[DPM_INDEX].
+			  internal_addr + DPM_HOST_INT_EN0);
+
+		if (pxa_info->plx !=3D NULL)
+			iounmap((void *)pxa_info->plx);
+
+		rtdm_free((void *)pxa_info);
+	}
+
+	/* Unregister RTDM device driver */
+	ret =3D rtdm_dev_unregister(info, 1000);
+	if (ret !=3D 0)
+		return;
+
+	pci_release_regions(dev);
+	pci_disable_device(dev);
+	pci_set_drvdata(dev, NULL);
+
+	iounmap(((struct io_info *)device_data)->mem[DPM_INDEX].internal_addr);
+	if (((struct io_info *)device_data)->mem[EXT_MEM_INDEX].internal_addr !=
=3D
+	    0)
+		iounmap(((struct io_info *)device_data)->mem[EXT_MEM_INDEX].
+			internal_addr);
+
+	/* Release structure memory allocation */
+	rtdm_free(info->device_data);
+	rtdm_free(info);
+
+	if (cifx_num > 0)
+		cifx_num--;
+}
+
+static int __init cifx_pci_init(void)
+{
+	cifx_num =3D 0;
+
+	return pci_register_driver(&cifx_pci_driver);
+}
+
+static void __exit cifx_pci_exit(void)
+{
+	pci_unregister_driver(&cifx_pci_driver);
+}
+
+module_init(cifx_pci_init);
+module_exit(cifx_pci_exit);
+
+/* End of file : cifx_pci.c */
