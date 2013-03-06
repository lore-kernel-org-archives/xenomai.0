Message-ID: <51376093.7060701@siemens.com>
Date: Wed, 06 Mar 2013 16:28:19 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>	<5130B39C.70300@hilscher.com>
	<513465CF.4030807@hilscher.com>	<51350D5B.6060309@xenomai.org>
	<5135CCDE.5090401@hilscher.com>	<5135D667.8060309@siemens.com>
	<51361281.20307@hilscher.com> <51364A61.3090002@xenomai.org>
	<5136F9E9.9030604@hilscher.com> <5136FC1E.6060608@xenomai.org>
	<51371B89.4020103@hilscher.com> <513730CE.2070102@xenomai.org>
	<51374B98.7030103@hilscher.com>
In-Reply-To: <51374B98.7030103@hilscher.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jerome Poncin <JPoncin@hilscher.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-03-06 14:58, Jerome Poncin wrote:
> diff --git a/ksrc/drivers/cifx/cifx_pci.c b/ksrc/drivers/cifx/cifx_pci.c
> new file mode 100644
> index 0000000..e04ddb7
> --- /dev/null
> +++ b/ksrc/drivers/cifx/cifx_pci.c
> @@ -0,0 +1,634 @@
> +/*
> + * Copyright (C) 2013 Hilscher France (JP) <www.hilscher.fr>
> + *
> + * Xenomai is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * Xenomai is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with Xenomai; if not, write to the Free Software Foundation,
> + * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +#include <linux/mman.h>
> +
> +#include <asm-generic/xenomai/pci_ids.h>
> +
> +#include <rtdm/rtdm_driver.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("RTDM board driver for CifX cards");
> +MODULE_AUTHOR("Hilscher France (JP) <www.hilscher.fr>");
> +
> +#define DPM_HOST_INT_EN0                0xfff0
> +#define DPM_HOST_INT_STAT0              0xffe0
> +#define PLX_GPIO_OFFSET                 0x15
> +#define PLX_TIMING_OFFSET               0x0a
> +
> +#define DPM_HOST_INT_MASK               0xe600ffff
> +#define DPM_HOST_INT_GLOBAL_EN          0x80000000
> +#define PLX_GPIO_DATA0_MASK             0x00000004
> +#define PLX_GPIO_DATA1_MASK             0x00000020
> +
> +#define NX_PCA_PCI_8_BIT_DPM_MODE       0x5431F962
> +#define NX_PCA_PCI_16_BIT_DPM_MODE      0x4073F8E2
> +#define NX_PCA_PCI_32_BIT_DPM_MODE      0x40824122
> +
> +/* Number of bar */
> +/* points to the DPM -> netX, netPLC, netJACK */
> +#define DPM_BAR                         0
> +/* points to the optional extended memory     */
> +#define EXT_MEM_BAR                     1
> +/* points to the DPM -> netXPLX               */
> +#define PLX_DPM_BAR                     2
> +/* timing config register                     */
> +#define PXA_PLX_BAR                     0
> +
> +/* Index of io_info structure's memory array */
> +/* first mapping describes DPM              */
> +#define DPM_INDEX                       0
> +/* second mapping describes extended memory */
> +#define EXT_MEM_INDEX                   1
> +
> +#define MAX_MAPS                        2
> +
> +#define MEM_PHYS                        1
> +
> +#define DRIVER_NAME                     "rtdm_cifx"
> +#define PERIPHERAL_NAME                 "cifx"
> +#define PROVIDER_NAME                   "Hilscher"
> +
> +/* name of a NXSB-PCA or NXPCA-PCI card */
> +#define CIFX_RTDM_PLX_CARD_NAME         "netx_plx"
> +/* name of a cifX PCI card              */
> +#define CIFX_RTDM_CARD_NAME             "netx"
> +/* name of a netPLC PCI card            */
> +#define CIFX_RTDM_NETPLC_CARD_NAME      "netplc"
> +/* name of a netJACK PCI card           */
> +#define CIFX_RTDM_NETJACK_CARD_NAME     "netjack"
> +
> +struct io_mem {
> +    uint32_t addr;

The kernel uses tabs, not 4 spaces. You can try linux/scripts/Lindent,
and then manually post-process the result so that it looks good without
violating checkpatch requirements.

> +    uint32_t size;
> +    int32_t memtype;
> +    void __iomem *internal_addr;
> +};
> +
> +struct io_info {
> +    struct io_mem mem[MAX_MAPS];
> +    int32_t irq;
> +    bool irq_enable;
> +    bool irq_registered;
> +    rtdm_irq_t irq_handle;
> +    struct ext_io_info *priv;
> +};
> +
> +struct ext_io_info {
> +    uint32_t __iomem *plx;
> +    uint8_t dpm_mode;
> +    uint32_t plx_timing;
> +};
> +
> +struct io_map_mem {
> +    uint32_t phys_addr;
> +    void **virt_addr;
> +    uint32_t length;
> +};
> +
> +static struct io_info *cifx_get_device_data(struct rtdm_device *info);
> +static struct ext_io_info *cifx_get_private(struct rtdm_device *info);
> +
> +static int cifx_set_plx_timing(struct rtdm_device *info);
> +static int cifx_get_plx_timing(struct rtdm_device *info);
> +static int cifx_get_dpm_mode(struct rtdm_device *info);
> +
> +static int cifx_pci_open(struct rtdm_dev_context *context,
> +             rtdm_user_info_t *user_info, int oflags);
> +static int cifx_pci_close(struct rtdm_dev_context *context,
> +              rtdm_user_info_t *user_info);
> +static ssize_t cifx_pci_read(struct rtdm_dev_context *context,
> +                 rtdm_user_info_t *user_info, void *buf,
> +                 size_t nbyte);
> +static ssize_t cifx_pci_write(struct rtdm_dev_context *context,
> +                  rtdm_user_info_t *user_info, const void *buf,
> +                  size_t nbyte);
> +
> +static int cifx_pci_probe(struct pci_dev *dev, const struct
> pci_device_id *id);
> +static void cifx_pci_remove(struct pci_dev *dev);
> +
> +/* Number or cifx found and open */
> +static int32_t cifx_num;
> +
> +/* RTDM Device information structure */
> +static const struct rtdm_device __initdata cifx_device_tmpl = {
> +    .struct_version = RTDM_DEVICE_STRUCT_VER,
> +
> +    .device_flags = RTDM_NAMED_DEVICE,
> +    .context_size = 0,
> +    .device_name = "",
> +
> +    .open_nrt = cifx_pci_open,
> +
> +    .ops = {
> +        .close_nrt = cifx_pci_close,
> +
> +        .read_nrt = cifx_pci_read,
> +        .write_nrt = cifx_pci_write,
> +
> +        .ioctl_rt = NULL,
> +        .ioctl_nrt = NULL,
> +
> +        .read_rt = NULL,
> +        .write_rt = NULL,

This is no RTDM driver. You provide zero real-time services, thus your
Xenomai user could simply work against the standard UIO driver.

I suppose you really want to find a box on which you can test and
finalize IRQ support now. Otherwise, this whole RTDM excercise is really
pointless.

I'm reviewing the rest nevertheless, just in case.

> +        },
> +
> +    .device_class = RTDM_CLASS_EXPERIMENTAL,
> +    .device_sub_class = RTDM_SUBCLASS_GENERIC,
> +    .profile_version = 1,
> +    .driver_name = DRIVER_NAME,
> +    .driver_version = RTDM_DRIVER_VER(1, 0, 0),
> +    .provider_name = PROVIDER_NAME,
> +};
> +
> +/* Device table */
> +static DEFINE_PCI_DEVICE_TABLE(cifx_pci_tbl) = {
> +    {PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETX,
> +    0, 0},
> +    {PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
> +    PCI_VENDOR_ID_PLX, PCI_SUBDEVICE_ID_NXSB_PCA},
> +    {PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9030,
> +    PCI_VENDOR_ID_PLX, PCI_SUBDEVICE_ID_NXPCA},
> +    {PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETPLC,
> +    PCI_VENDOR_ID_HILSCHER, PCI_SUBDEVICE_ID_NETPLC_RAM},
> +    {PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETPLC,
> +    PCI_VENDOR_ID_HILSCHER, PCI_SUBDEVICE_ID_NETPLC_FLASH},
> +    {PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETJACK,
> +    PCI_VENDOR_ID_HILSCHER, PCI_SUBDEVICE_ID_NETJACK_RAM},
> +    {PCI_VENDOR_ID_HILSCHER, PCI_DEVICE_ID_HILSCHER_NETJACK,
> +    PCI_VENDOR_ID_HILSCHER, PCI_SUBDEVICE_ID_NETJACK_FLASH},
> +    { 0,}
> +};
> +
> +/* RTDM cifX Driver */
> +static struct pci_driver cifx_pci_driver = {
> +    .name = "cifx",
> +    .id_table = cifx_pci_tbl,
> +    .probe = cifx_pci_probe,
> +    .remove = cifx_pci_remove,
> +};
> +
> +/*
> + *    cifx_rtdm_device_to_device_data
> + *    Get device_data structure
> + */
> +static struct io_info *cifx_get_device_data(struct rtdm_device *info)
> +{
> +    return info->device_data;
> +}
> +
> +/*
> + *    cifx_rtdm_device_to_private
> + *    Get ext_io_info structure
> + */
> +static struct ext_io_info *cifx_get_private(struct rtdm_device *info)
> +{
> +    return ((struct io_info *)info->device_data)->priv;
> +}
> +
> +/*
> + *    cifx_set_plx_timing
> + *    Set plx timing
> + */
> +static int cifx_set_plx_timing(struct rtdm_device *info)
> +{
> +    struct ext_io_info *ext_info = cifx_get_private(info);
> +    uint32_t __iomem *plx_timing;
> +
> +    if (ext_info == NULL)

Well... you set it to non-NULL only a few lines before calling this
function.

But why calling this function with an rtdm_device pointer when it needs
ext_io_info and the caller has this reference? Needless complication.

> +        return -ENODEV;
> +
> +    plx_timing = ext_info->plx + PLX_TIMING_OFFSET;
> +    *plx_timing = ext_info->plx_timing;
> +
> +    return 0;
> +}
> +
> +/*
> + * cifx_get_plx_timing
> + * Get plx timing
> + */
> +static int cifx_get_plx_timing(struct rtdm_device *info)
> +{
> +    struct ext_io_info *ext_info = cifx_get_private(info);
> +
> +    if (ext_info == NULL)

Same here.

> +        return -ENODEV;
> +
> +    switch (ext_info->dpm_mode) {
> +    case 8:
> +        ext_info->plx_timing = NX_PCA_PCI_8_BIT_DPM_MODE;
> +        break;
> +    case 16:
> +        ext_info->plx_timing = NX_PCA_PCI_16_BIT_DPM_MODE;
> +        break;
> +    case 32:
> +        ext_info->plx_timing = NX_PCA_PCI_32_BIT_DPM_MODE;
> +        break;
> +    default:
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * cifx_get_dpm_mode
> + * Get dpm mode
> + */
> +static int cifx_get_dpm_mode(struct rtdm_device *info)
> +{
> +    struct ext_io_info *ext_info = cifx_get_private(info);
> +    uint32_t __iomem *plx_gpio;
> +
> +    if (ext_info == NULL)
> +        return -ENODEV;

And here.

> +
> +    plx_gpio = ext_info->plx + PLX_GPIO_OFFSET;
> +
> +    if ((*plx_gpio & PLX_GPIO_DATA0_MASK)
> +        && ~(*plx_gpio & PLX_GPIO_DATA1_MASK))
> +        ext_info->dpm_mode = 8;
> +    else if (~(*plx_gpio & PLX_GPIO_DATA0_MASK)
> +         && (*plx_gpio & PLX_GPIO_DATA1_MASK))
> +        ext_info->dpm_mode = 32;
> +    else if (~(*plx_gpio & PLX_GPIO_DATA0_MASK)
> +         && ~(*plx_gpio & PLX_GPIO_DATA1_MASK))
> +        ext_info->dpm_mode = 16;
> +    else
> +        return -EINVAL;
> +
> +    return 0;
> +}
> +
> +/*
> + * cifx_pci_open
> + * Open RTDM cifx pci driver
> + */
> +static int cifx_pci_open(struct rtdm_dev_context *context,
> +             rtdm_user_info_t *user_info, int oflags)
> +{
> +    return 0;
> +}
> +
> +/*
> + * cifx_pci_close
> + * Close RTDM cifx pci driver
> + */
> +static int cifx_pci_close(struct rtdm_dev_context *context,
> +              rtdm_user_info_t *user_info)
> +{
> +    return 0;
> +}
> +
> +/*
> + * cifx_pci_read
> + * Read
> + */
> +static ssize_t cifx_pci_read(struct rtdm_dev_context *context,
> +                 rtdm_user_info_t *user_info, void *buf,
> +                 size_t nbyte)

read() is supposed to provide read access to *stream* like data sources.
You misuse it to deliver a static (after initialization) device
descripion. Better model this with a more descriptive IOCTL. And
document the API in the header you will need for the IOCTLs. Doxgen
format, please. There are several examples in include/rtdm.

> +{
> +    struct rtdm_device *info = (struct rtdm_device *)context->device;
> +
> +    if (nbyte > sizeof(struct io_info))
> +        return 0;

Still wrong.

> +
> +    /* Copy data information for userland */
> +    if (rtdm_safe_copy_to_user(user_info, buf, info->device_data, nbyte))
> +        return 0;

Also this.

> +
> +    return nbyte;
> +}
> +
> +/*
> + * cifx_pci_write
> + * write
> + */
> +static ssize_t cifx_pci_write(struct rtdm_dev_context *context,
> +                  rtdm_user_info_t *user_info, const void *buf,
> +                  size_t nbyte)

Also here: Do not misuse write(), define an IOCTL that contains
something like "MMAP" and another one with MUNMAP in its name - that's
the purpose of this service, no?

> +{
> +    struct io_map_mem map_mem;
> +    int ret;
> +
> +    switch (nbyte) {
> +    case sizeof(map_mem):
> +        /* Copy data information for Kernel */
> +        if (rtdm_safe_copy_from_user(user_info, &map_mem, buf, nbyte))
> +            return 0;

And this is another bogus error code.

> +
> +        if (*map_mem.virt_addr == NULL) {
> +            /* Map physical on virtual memory */
> +            ret = rtdm_iomap_to_user(user_info,
> +                        map_mem.
> +                        phys_addr,
> +                        map_mem.length,
> +                        (PROT_READ | PROT_WRITE),
> +                        map_mem.virt_addr,
> +                        NULL,
> +                        NULL);
> +
> +            if (ret != 0)
> +                return 0;

And this.

> +        } else {
> +            /* Unap virtual memory */
> +            ret = rtdm_munmap(user_info,
> +                    *map_mem.virt_addr,
> +                    map_mem.length);
> +
> +            if (ret != 0)
> +                return 0;

And another bug. You make it hard for userland to discover its own bugs
by hiding proper error codes systematically.

> +        }
> +        break;
> +
> +    default:
> +        /* Error */
> +        return 0;

Since when is 0 a valid error code?

> +    }
> +
> +    return nbyte;
> +}
> +
> +static int cifx_pci_probe(struct pci_dev *dev, const struct
> pci_device_id *id)
> +{
> +    struct rtdm_device *info = NULL;
> +    struct io_info *device_data = NULL;
> +    int32_t bar;
> +    int32_t ret;
> +
> +    /* Allocate device driver structure */
> +    info = rtdm_malloc(sizeof(struct rtdm_device));

As I already told you: You are in non-RT context here, thus normal
kmalloc is sufficient. Please fix,

> +
> +    if (info == NULL)
> +        return -ENOMEM;
> +
> +    ret = pci_enable_device(dev);
> +    if (ret != 0)
> +        goto out_free;
> +
> +    ret = pci_request_regions(dev, DRIVER_NAME);
> +    if (ret != 0)
> +        goto out_disable;
> +
> +    /* Initialize structure with default values */
> +    memcpy(info, &cifx_device_tmpl, sizeof(*info));
> +
> +    info->device_id = id->device;
> +    snprintf(info->device_name, RTDM_MAX_DEVNAME_LEN, "cifx%i", cifx_num);
> +    info->proc_name = info->device_name;
> +
> +    switch (id->device) {
> +    case PCI_DEVICE_ID_HILSCHER_NETX:
> +        bar = DPM_BAR;
> +        info->peripheral_name = CIFX_RTDM_CARD_NAME;
> +        break;
> +    case PCI_DEVICE_ID_HILSCHER_NETPLC:
> +        bar = DPM_BAR;
> +        info->peripheral_name = CIFX_RTDM_NETPLC_CARD_NAME;
> +        break;
> +    case PCI_DEVICE_ID_HILSCHER_NETJACK:
> +        bar = DPM_BAR;
> +        info->peripheral_name = CIFX_RTDM_NETJACK_CARD_NAME;
> +        break;
> +    default:
> +        bar = PLX_DPM_BAR;
> +        info->peripheral_name = CIFX_RTDM_PLX_CARD_NAME;
> +        break;
> +    }
> +
> +    info->device_data = NULL;
> +
> +    /* Allocate specific data strcuture for device */
> +    device_data = rtdm_malloc(sizeof(*device_data));
> +
> +    if (device_data == NULL)
> +        goto out_release;
> +
> +    memset(device_data, 0, sizeof(*device_data));
> +
> +    /* BAR 0 or 2 points to the card's dual port memory */
> +    device_data->mem[DPM_INDEX].addr = pci_resource_start(dev, bar);
> +
> +    if (device_data->mem[DPM_INDEX].addr == 0)
> +        goto out_release;
> +
> +    device_data->mem[DPM_INDEX].internal_addr =
> +        ioremap_nocache(pci_resource_start(dev, bar),
> +                        pci_resource_len(dev, bar));
> +
> +    if (device_data->mem[DPM_INDEX].internal_addr == 0)
> +        goto out_release;
> +
> +    dev_info(&dev->dev, "DPM at %08X\n",
> device_data->mem[DPM_INDEX].addr);
> +    device_data->mem[DPM_INDEX].size = pci_resource_len(dev, bar);
> +    device_data->mem[DPM_INDEX].memtype = MEM_PHYS;
> +
> +    /* map extended mem (BAR 1 points to the extended memory) */
> +    device_data->mem[EXT_MEM_INDEX].addr =
> +                    pci_resource_start(dev, EXT_MEM_BAR);
> +
> +    /* extended memory is optional, so don't care if it is not present */
> +    if (device_data->mem[EXT_MEM_INDEX].addr != 0) {
> +        device_data->mem[EXT_MEM_INDEX].internal_addr =
> +            ioremap_nocache(pci_resource_start(dev, EXT_MEM_BAR),
> +                    pci_resource_len(dev, EXT_MEM_BAR));
> +
> +        if (device_data->mem[EXT_MEM_INDEX].internal_addr == 0)
> +            goto out_unmap;
> +
> +        dev_info(&dev->dev,
> +                "extended memory at %08X\n",
> +                device_data->mem[EXT_MEM_INDEX].addr);
> +        device_data->mem[EXT_MEM_INDEX].size =
> +                    pci_resource_len(dev, EXT_MEM_BAR);
> +        device_data->mem[EXT_MEM_INDEX].memtype = MEM_PHYS;
> +    }
> +
> +    if ((id->device == PCI_DEVICE_ID_HILSCHER_NETX)
> +        || (id->device == PCI_DEVICE_ID_HILSCHER_NETPLC)
> +        || (id->device == PCI_DEVICE_ID_HILSCHER_NETJACK)) {
> +        /* make sure all interrupts are disabled */
> +        iowrite32(0, device_data->mem[DPM_INDEX].internal_addr
> +                            + DPM_HOST_INT_EN0);
> +        device_data->priv = NULL;
> +    } else if (id->subdevice == PCI_SUBDEVICE_ID_NXPCA) {
> +        /* map PLX registers */
> +        struct ext_io_info *ext_info;
> +
> +        ext_info = rtdm_malloc(sizeof(*ext_info));
> +
> +        if (ext_info == NULL)
> +            goto out_unmap;
> +
> +        device_data->priv = ext_info;
> +
> +        /* set PXA PLX Timings */
> +        ext_info->plx = ioremap_nocache(
> +                    pci_resource_start(dev, PXA_PLX_BAR),
> +                    pci_resource_len(dev, PXA_PLX_BAR));
> +
> +        if (ext_info->plx == NULL)
> +            goto out_unmap;
> +        if (cifx_get_dpm_mode(info))
> +            goto out_unmap_plx;
> +        if (cifx_get_plx_timing(info))
> +            goto out_unmap_plx;
> +        if (cifx_set_plx_timing(info))
> +            goto out_unmap_plx;
> +    } else {
> +        struct ext_io_info *ext_info;
> +
> +        ext_info = rtdm_malloc(sizeof(*ext_info));
> +
> +        if (ext_info == NULL)
> +            goto out_free_pxa;
> +
> +        ext_info->plx = NULL;
> +        ext_info->plx_timing = 0;
> +        ext_info->dpm_mode = 0;
> +        device_data->priv = ext_info;
> +    }
> +
> +    /* Initialize irq data */
> +    device_data->irq = dev->irq;
> +    device_data->irq_enable = 0;
> +    device_data->irq_registered = 0;
> +
> +    info->device_data = device_data;
> +
> +    /* Register RTDM device driver */
> +    ret = rtdm_dev_register(info);
> +    if (ret != 0) {
> +        if (id->subdevice != PCI_SUBDEVICE_ID_NXPCA)
> +            goto out_unmap;
> +        else
> +            goto out_unmap_plx;
> +    }
> +
> +    pci_set_drvdata(dev, info);
> +
> +    if (id->device == PCI_DEVICE_ID_HILSCHER_NETX)
> +        dev_info(&dev->dev, "registered CifX card\n");
> +    else if (id->device == PCI_DEVICE_ID_HILSCHER_NETPLC)
> +        dev_info(&dev->dev, "registered netPLC card\n");
> +    else if (id->device == PCI_DEVICE_ID_HILSCHER_NETJACK)
> +        dev_info(&dev->dev, "registered netJACK card\n");
> +    else if (id->subdevice == PCI_SUBDEVICE_ID_NXSB_PCA)
> +        dev_info(&dev->dev, "registered NXSB-PCA adapter card\n");
> +    else {
> +        struct ext_io_info *ext_info = device_data->priv;
> +        dev_info(&dev->dev,
> +            "registered NXPCA-PCI adapter card in %d bit mode\n",
> +            ((struct ext_io_info *)ext_info)->dpm_mode);
> +    }
> +
> +    cifx_num++;
> +
> +    return 0;
> +
> + out_unmap_plx:
> +    iounmap((device_data->priv)->plx);
> +
> + out_free_pxa:
> +    rtdm_free(device_data->priv);
> +
> + out_unmap:
> +    iounmap(device_data->mem[DPM_INDEX].internal_addr);
> +    if (device_data->mem[EXT_MEM_INDEX].internal_addr != 0)
> +        iounmap(device_data->mem[EXT_MEM_INDEX].internal_addr);
> +
> + out_release:
> +    pci_release_regions(dev);
> +
> + out_disable:
> +    pci_disable_device(dev);
> +
> + out_free:
> +    if (info->device_data != NULL)
> +        rtdm_free(info->device_data);
> +
> +    rtdm_free(info);
> +
> +    return -ENODEV;

You throw aways what ret may contain about the error. You just need to
initialize it when the reason was "allocated_memory == NULL" to -ENOMEM.

> +}
> +
> +static void cifx_pci_remove(struct pci_dev *dev)
> +{
> +    struct rtdm_device *info = pci_get_drvdata(dev);
> +    struct io_info *device_data = cifx_get_device_data(info);
> +    struct ext_io_info *ext_info = cifx_get_private(info);
> +    int32_t ret;
> +
> +    if (info->device_data == NULL)
> +        return;
> +
> +    if (ext_info != NULL) {
> +        /* Disable all interrupts */
> +        iowrite32(0, device_data->mem[DPM_INDEX].internal_addr
> +                            + DPM_HOST_INT_EN0);
> +
> +        if (ext_info->plx != NULL)
> +            iounmap((void *)ext_info->plx);
> +
> +        rtdm_free((void *)ext_info);
> +    }
> +
> +    /* Unregister RTDM device driver */
> +    ret = rtdm_dev_unregister(info, 1000);
> +    if (ret != 0)
> +        return;

Either WARN() or ignore this (practically) impossible error.

> +
> +    pci_release_regions(dev);
> +    pci_disable_device(dev);
> +    pci_set_drvdata(dev, NULL);
> +
> +    /* Unmap memory */
> +    iounmap(device_data->mem[DPM_INDEX].internal_addr);
> +    if (device_data->mem[EXT_MEM_INDEX].internal_addr != 0)
> +        iounmap(device_data->mem[EXT_MEM_INDEX].internal_addr);
> +
> +    /* Release structure memory allocation */
> +    rtdm_free(info->device_data);
> +    rtdm_free(info);
> +
> +    if (cifx_num > 0)

Impossible.

> +        cifx_num--;
> +}
> +
> +static int __init cifx_pci_init(void)
> +{
> +    cifx_num = 0;

Unneeded, cifx_num is a global static variable, thus implicitely
intialized to 0.

> +
> +    return pci_register_driver(&cifx_pci_driver);
> +}
> +
> +static void __exit cifx_pci_exit(void)
> +{
> +    pci_unregister_driver(&cifx_pci_driver);
> +}
> +
> +module_init(cifx_pci_init);
> +module_exit(cifx_pci_exit);
> +
> +/* End of file : cifx_pci.c */

Obviously.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

