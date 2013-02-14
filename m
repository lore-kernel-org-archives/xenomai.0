Message-ID: <511CE85D.6070704@hilscher.com>
Date: Thu, 14 Feb 2013 14:36:29 +0100
From: =?ISO-8859-1?Q?St=E9phane_LOS?= <slos@hilscher.com>
MIME-Version: 1.0
References: <511A2964.4080902@hilscher.com> <511A2CA4.1000408@siemens.com>
	<511B9E94.2030108@hilscher.com>
In-Reply-To: <511B9E94.2030108@hilscher.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

Le 13/02/2013 15:09, St=E9phane LOS a =E9crit :
> Le 12/02/2013 12:51, Jan Kiszka a =E9crit :
>> On 2013-02-12 12:37, St=E9phane LOS wrote:
>>> Hello there,
>>>
>>> It seems we have managed to build an RTDM module and we can insmod it
>>> and it shows up in the named devices list.
>>>
>>> If we forget to rmmod the module, the kernel crashes when stopping or
>>> rebooting.
>> So you have a bug in your driver that requires fixing. Is the device
>> opened while you shutdown? What does the backtrace tell you you about
>> the crash? If you share your code early, we could review it already.
>>
>> Jan
>>
> Yes, of course we have a bug. I think that we have plenty of them in =

> fact. ;-)
> I would like to share the code but it is a little early since we are =

> trying to figure out what we have to do.
> Something is written started from what we have found in the sources =

> but we still have to learn.
> The RTDM API documentation is good but we have very little knowledge =

> on how RTDM drivers should be used with Xenomai.
> We lack general information.
> Since the following links are broken now :
> http://www.xenomai.org/index.php/Weblinks#Installation_of_Xenomai_and_RTD=
M_Driver_Writing =

>
> I remember that there use to be here a documentation about the RTDM =

> driver for CIF boards, it was years ago.
> My colleague is actually working on the driver, I intervene here =

> because I like writing in English and I am the support guy. ;-)
>
> Best Regards,
> Cordialement,
>
> St=E9phane LOS
> slos@hilscher.com
> Support technique
>
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Hilscher France
> 12, rue du 35=E8me R=E9giment d'Aviation
> Miniparc du Ch=EAne
> 69500 BRON
> France
> T=E9l. : +33 (0) 4 72 37 98 40
> Fax  : +33 (0) 4 78 26 83 27
> http ://www.hilscher.fr
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
>

Hello,

Please find attached the faulty code being developed.

Thank you in advance for your comments and hints.

By the way, our Linux driver supports as many boards as needed.

Is it possible with a RTDM driver to drive several boards ?
I guess yes but we don't understand yet how things go to the =

/proc/xenomai file system.
What should we find there ?

Again thank you for your help.

Best Regards,
Cordialement,

St=E9phane LOS
slos@hilscher.com
Support technique

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Hilscher France
12, rue du 35=E8me R=E9giment d'Aviation
Miniparc du Ch=EAne
69500 BRON
France
T=E9l. : +33 (0) 4 72 37 98 40
Fax  : +33 (0) 4 78 26 83 27
http ://www.hilscher.fr
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-------------- next part --------------
/***************************************************************************
 *   Copyright (C) 2013 		                                   		   *
 *   Hilscher France (JP)                                                  *
 *   http://www.hilscher.fr/ 						   					   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 **************************************************************************=
*/

/**************************************************************************=
*/

/* Includes */

#include <linux/device.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/io.h>

#include <rtdm/rtdm_driver.h>

/**************************************************************************=
*/

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("RTDM board driver for CifX cards");
MODULE_AUTHOR("Hilscher France (JP) <www.hilscher.fr>");

/**************************************************************************=
*/
/*!
*   \addtogroup cifx_pci_Core
*   @{
*/
/**************************************************************************=
*/

/* #define */

/* Activate printk trace for debug */
#define DEBUG_PRINTK

#ifndef PCI_VENDOR_ID_HILSCHER
	#define PCI_VENDOR_ID_HILSCHER   			0x15CF
#endif

#ifndef PCI_DEVICE_ID_HILSCHER_NETX
	#define PCI_DEVICE_ID_HILSCHER_NETX  		0x0000
#endif

#ifndef PCI_DEVICE_ID_HILSCHER_NETPLC
	#define PCI_DEVICE_ID_HILSCHER_NETPLC  		0x0010
#endif

#ifndef PCI_DEVICE_ID_HILSCHER_NETJACK
	#define PCI_DEVICE_ID_HILSCHER_NETJACK  	0x0020
#endif

#ifndef PCI_SUBDEVICE_ID_NXSB_PCA
	#define PCI_SUBDEVICE_ID_NXSB_PCA  			0x3235
#endif

#ifndef PCI_SUBDEVICE_ID_NXPCA
	#define PCI_SUBDEVICE_ID_NXPCA   			0x3335
#endif

#ifndef PCI_SUBDEVICE_ID_NETPLC_RAM
	#define PCI_SUBDEVICE_ID_NETPLC_RAM  		0x0000
#endif

#ifndef PCI_SUBDEVICE_ID_NETPLC_FLASH
	#define PCI_SUBDEVICE_ID_NETPLC_FLASH   	0x0001
#endif

#ifndef PCI_SUBDEVICE_ID_NETJACK_RAM
	#define PCI_SUBDEVICE_ID_NETJACK_RAM   		0x0000
#endif

#ifndef PCI_SUBDEVICE_ID_NETJACK_FLASH
	#define PCI_SUBDEVICE_ID_NETJACK_FLASH   	0x0001
#endif

#define DPM_HOST_INT_EN0						0xfff0
#define DPM_HOST_INT_STAT0						0xffe0
#define PLX_GPIO_OFFSET        					0x15
#define PLX_TIMING_OFFSET       				0x0a

#define DPM_HOST_INT_MASK						0xe600ffff
#define DPM_HOST_INT_GLOBAL_EN					0x80000000
#define PLX_GPIO_DATA0_MASK     				0x00000004
#define PLX_GPIO_DATA1_MASK     				0x00000020

#define NX_PCA_PCI_8_BIT_DPM_MODE  				0x5431F962
#define NX_PCA_PCI_16_BIT_DPM_MODE 				0x4073F8E2
#define NX_PCA_PCI_32_BIT_DPM_MODE 				0x40824122

/* number of bar */
#define DPM_BAR    								0			/* points to the DPM -> netX, netPLC, netJAC=
K */
#define EXT_MEM_BAR 							1 			/* points to the optional extended memory  =
   */
#define PLX_DPM_BAR 							2 			/* points to the DPM -> netXPLX            =
   */ =

#define PXA_PLX_BAR 							0 			/* timing config register                  =
   */

/* index of io_info structure's memory array */
#define DPM_INDEX     							0 			/* first mapping describes DPM           =
   */
#define EXT_MEM_INDEX 							1			/* second mapping describes extended memor=
y */

#define MAX_MAPS    							2

/* defines for memtype */
#define MEM_PHYS    							1

#define DRIVER_NAME								"rtdm_cifx"
#define PERIPHERAL_NAME							"cifx"
#define PROVIDER_NAME							"Hilscher"

#define CIFX_RTDM_PLX_CARD_NAME     			"netx_plx"  /* name of a NXSB-PCA or=
 NXPCA-PCI card */
#define CIFX_RTDM_CARD_NAME         			"netx"      /* name of a cifX PCI ca=
rd              */
#define CIFX_RTDM_NETPLC_CARD_NAME  			"netplc"    /* name of a netPLC PCI =
card            */
#define CIFX_RTDM_NETJACK_CARD_NAME 			"netjack"   /* name of a netJACK PCI=
 card           */

typedef struct {
	uint32_t __iomem 	*plx;
	uint8_t 			dpm_mode;
	uint32_t  			plx_timing;
} pxa_dev_info;

typedef struct {
	uint32_t			addr;
	uint32_t 			size;
	int32_t 			memtype;
	void __iomem 		*internal_addr;
} io_mem;  =


typedef struct {
	io_mem				mem[MAX_MAPS];
	int32_t				irq;
	uint32_t			irq_flags;
	void				*priv;
	rtdm_irq_handler_t	handler;
	void				*irq_handle;
} io_info_t;

/**************************************************************************=
*/

/* Prototypes */

static int 	cifx_handler(rtdm_irq_t *irq);
static int 	cifx_pxa_set_plx_timing(struct rtdm_device *info);
static int 	cifx_pxa_get_plx_timing(struct rtdm_device *info);
static int 	cifx_pxa_get_dpm_mode(struct rtdm_device *info);

static int 	cifx_pci_open(struct rtdm_dev_context *context, rtdm_user_info_=
t * user_info, int oflags);
static int 	cifx_pci_close(struct rtdm_dev_context *context, rtdm_user_info=
_t * user_info);

static int 	__devinit cifx_pci_probe(struct pci_dev *dev, const struct pci_=
device_id *id);
static void __devexit cifx_pci_remove(struct pci_dev *dev);

/**************************************************************************=
*/

/* Local variables */

static int cifx_num	=3D	0;

static const struct rtdm_device __initdata cifx_device_tmpl =3D {
	.struct_version		=3D RTDM_DEVICE_STRUCT_VER,

	.device_flags		=3D RTDM_NAMED_DEVICE,
	.device_name		=3D "",

	.open_nrt		=3D cifx_pci_open,

	.ops =3D {
		.close_nrt	=3D cifx_pci_close,

		.ioctl_rt	=3D NULL,
		.ioctl_nrt	=3D NULL,

		.read_rt	=3D NULL,

		.write_rt	=3D NULL,
	},

	.device_class		=3D RTDM_CLASS_EXPERIMENTAL,
	.device_sub_class	=3D RTDM_SUBCLASS_GENERIC,
	.profile_version	=3D 1,
	.driver_name		=3D DRIVER_NAME,
	.driver_version		=3D RTDM_DRIVER_VER(1, 0, 0),
	.provider_name		=3D PROVIDER_NAME,
	.proc_name		=3D PERIPHERAL_NAME,
};

static struct pci_device_id cifx_pci_tbl[] =3D {
	{
		.vendor =3D	PCI_VENDOR_ID_HILSCHER,
		.device =3D	PCI_DEVICE_ID_HILSCHER_NETX,
		.subvendor =3D	0,
		.subdevice =3D	0,
	},
	{
		.vendor =3D	PCI_VENDOR_ID_PLX,
		.device =3D	PCI_DEVICE_ID_PLX_9030,
		.subvendor =3D	PCI_VENDOR_ID_PLX,
		.subdevice =3D	PCI_SUBDEVICE_ID_NXSB_PCA,
	},
	{
		.vendor =3D	PCI_VENDOR_ID_PLX,
		.device =3D	PCI_DEVICE_ID_PLX_9030,
		.subvendor =3D	PCI_VENDOR_ID_PLX,
		.subdevice =3D	PCI_SUBDEVICE_ID_NXPCA,
	},
	{
		.vendor =3D	PCI_VENDOR_ID_HILSCHER,
		.device =3D	PCI_DEVICE_ID_HILSCHER_NETPLC,
		.subvendor =3D	PCI_VENDOR_ID_HILSCHER,
		.subdevice =3D	PCI_SUBDEVICE_ID_NETPLC_RAM,
	},
	{
		.vendor =3D	PCI_VENDOR_ID_HILSCHER,
		.device =3D	PCI_DEVICE_ID_HILSCHER_NETPLC,
		.subvendor =3D	PCI_VENDOR_ID_HILSCHER,
		.subdevice =3D	PCI_SUBDEVICE_ID_NETPLC_FLASH,
	},
	{
		.vendor =3D PCI_VENDOR_ID_HILSCHER,
		.device =3D PCI_DEVICE_ID_HILSCHER_NETJACK,
		.subvendor =3D  PCI_VENDOR_ID_HILSCHER,
		.subdevice =3D  PCI_SUBDEVICE_ID_NETJACK_RAM,
	},
	{
		.vendor =3D PCI_VENDOR_ID_HILSCHER,
		.device =3D PCI_DEVICE_ID_HILSCHER_NETJACK,
		.subvendor =3D  PCI_VENDOR_ID_HILSCHER,
		.subdevice =3D  PCI_SUBDEVICE_ID_NETJACK_FLASH,
	},
	{ 0, }
};

/* This structure describe the RTDM cifX Driver */
static struct pci_driver cifx_pci_driver =3D {
	.name		=3D "cifx",
	.id_table	=3D cifx_pci_tbl,
	.probe		=3D cifx_pci_probe,
	.remove		=3D __devexit_p(cifx_pci_remove),
};

/**************************************************************************=
*/

/**************************************************************************=
***/
/*!
*   \brief  cifx_handler
*
*   \param  [in]	irq  	Resource task pointer
*
*   \return RTDM_IRQ_NONE or RTDM_IRQ_HANDLED
*
*   \note   cifx interrupt handler
*/
/**************************************************************************=
***/
static int cifx_handler(rtdm_irq_t *irq)
{
	struct rtdm_device	*info 			=3D (struct rtdm_device *)rtdm_irq_get_arg(irq=
, void);
	io_info_t 			*device_data 	=3D (io_info_t *) info->device_data;
	=

	if (device_data->priv !=3D NULL)
	{
		/* This is a PLX device and cannot produce an IRQ */
		return RTDM_IRQ_NONE;
	} =

	else
	{	=

		void __iomem *int_enable_reg =3D device_data->mem[DPM_INDEX].internal_add=
r + DPM_HOST_INT_EN0;
		void __iomem *int_status_reg =3D device_data->mem[DPM_INDEX].internal_add=
r + DPM_HOST_INT_STAT0;
	=

		/* Is one of our interrupts enabled and active ? */
		if (!(ioread32(int_enable_reg) & ioread32(int_status_reg) & DPM_HOST_INT_=
MASK))
			return IRQ_NONE;
	=

		/* Disable interrupt */
		iowrite32(ioread32(int_enable_reg) & ~DPM_HOST_INT_GLOBAL_EN, int_enable_=
reg);

		return RTDM_IRQ_HANDLED;
	}
}

/**************************************************************************=
***/
/*!
*   \brief  cifx_pxa_set_plx_timing
*
*   \param  [in]	info  	cifx rtdm device information
*
*   \return 0 (OK) or Error
*
*   \note   Set plx timing
*/
/**************************************************************************=
***/
static int cifx_pxa_set_plx_timing(struct rtdm_device *info)
{
	pxa_dev_info 	 *pxa_info 	=3D (pxa_dev_info *) ((io_info_t *)info->device_=
data)->priv;
	uint32_t __iomem *plx_timing;
	=

	if (!pxa_info)
		return -ENODEV;
		=

	plx_timing =3D pxa_info->plx + PLX_TIMING_OFFSET;
	*plx_timing =3D pxa_info->plx_timing;
	=

	return 0;
}

/**************************************************************************=
***/
/*!
*   \brief  cifx_pxa_get_plx_timing
*
*   \param  [in]	info  	cifx rtdm device information
*
*   \return 0 (OK) or Error
*
*   \note   Get plx timing
*/
/**************************************************************************=
***/
static int cifx_pxa_get_plx_timing(struct rtdm_device *info)
{
	pxa_dev_info *pxa_info =3D (pxa_dev_info *) ((io_info_t *)info->device_dat=
a)->priv;
	=

	if (!pxa_info)
		return -ENODEV;
		=

	switch (pxa_info->dpm_mode) =

	{
		case 8:
			pxa_info->plx_timing =3D NX_PCA_PCI_8_BIT_DPM_MODE;
			break;
		case 16:
			pxa_info->plx_timing =3D NX_PCA_PCI_16_BIT_DPM_MODE;
			break;
		case 32:
			pxa_info->plx_timing =3D NX_PCA_PCI_32_BIT_DPM_MODE;
			break;
		default:
			return -EINVAL;
	}
	=

	return 0;
}

/**************************************************************************=
***/
/*!
*   \brief  cifx_pxa_get_dpm_mode
*
*   \param  [in]	info  	cifx rtdm device information
*
*   \return 0 (OK) or Error
*
*   \note   Get dpm mode
*/
/**************************************************************************=
***/
static int cifx_pxa_get_dpm_mode(struct rtdm_device *info)
{
	pxa_dev_info 		*pxa_info =3D (pxa_dev_info *) ((io_info_t *)info->device_d=
ata)->priv;
	uint32_t __iomem 	*plx_gpio;
	=

	if (!pxa_info)
		return -ENODEV;
		=

	plx_gpio =3D pxa_info->plx + PLX_GPIO_OFFSET;
	=

	if ((*plx_gpio & PLX_GPIO_DATA0_MASK) && ~(*plx_gpio & PLX_GPIO_DATA1_MASK=
))
		pxa_info->dpm_mode =3D 8;
	else if (~(*plx_gpio & PLX_GPIO_DATA0_MASK) && (*plx_gpio & PLX_GPIO_DATA1=
_MASK))
		pxa_info->dpm_mode =3D 32;
	else if (~(*plx_gpio & PLX_GPIO_DATA0_MASK) && ~(*plx_gpio & PLX_GPIO_DATA=
1_MASK))
		pxa_info->dpm_mode =3D 16;
	else
		return -EINVAL;
		=

	return 0;
}

/**************************************************************************=
***/
/*!
*   \brief  cifx_pci_open
*
*   \param  [in]	context  	context
*	\param	[in]	user_info	user information
*	\param	[in]	oflags		flags
*
*   \return 0 (OK) or Error
*
*   \note   Open
*/
/**************************************************************************=
***/
static int cifx_pci_open(struct rtdm_dev_context *context, rtdm_user_info_t=
 * user_info, int oflags)
{
	return 0;
}

/**************************************************************************=
***/
/*!
*   \brief  cifx_pci_close
*
*   \param  [in]	context  	context
*	\param	[in]	user_info	user information
*
*   \return 0 (OK) or Error
*
*   \note   Close
*/
/**************************************************************************=
***/
static int cifx_pci_close(struct rtdm_dev_context *context, rtdm_user_info_=
t * user_info)
{
	return 0;
}
	=

/**************************************************************************=
***/
/*!
*   \brief  cifx_pci_probe
*
*   \param  [in]	dev  		=

*	\param	[in]	id			=

*
*   \return 0 (OK) or Error
*
*   \note   Open the device. =

*			This function is called when the device shall be opened.
*/
/**************************************************************************=
***/	=

static int __devinit cifx_pci_probe(struct pci_dev *dev, const struct pci_d=
evice_id *id)
{
	struct rtdm_device 	*info			=3D	NULL;
	rtdm_irq_t  		*irq_handle 	=3D 	NULL;
	io_info_t			*device_data	=3D	NULL;	=

	int32_t 			bar;
	int32_t				ret;
		=

	info =3D rtdm_malloc(sizeof(struct rtdm_device));
				=

	if (info =3D=3D NULL)
	{
#ifdef DEBUG_PRINTK
		rtdm_printk("cifx rtdm driver error : rtdm_malloc error\n");
#endif /* DEBUG_PRINTK */

		return -ENOMEM;
	}
	=

	if ((ret =3D pci_enable_device(dev)) !=3D 0)
	{
#ifdef DEBUG_PRINTK
		rtdm_printk("cifx rtdm driver error : pci_enable_device error : %i\n", re=
t);
#endif /* DEBUG_PRINTK */
 =

		goto out_free;
	}
	=

	if ((ret =3D pci_request_regions(dev, DRIVER_NAME)) !=3D 0)
	{
#ifdef DEBUG_PRINTK
		rtdm_printk("cifx rtdm driver error : pci_request_regions error : %i\n", =
ret);
#endif /* DEBUG_PRINTK */
	=

		goto out_disable;
	}
	=

	memcpy(info, &cifx_device_tmpl, sizeof(struct rtdm_device));
	=

	info->device_id	=3D id->device;
	snprintf((char *)info->device_name, RTDM_MAX_DEVNAME_LEN, "cifx%i", cifx_n=
um);
	info->proc_name	=3D info->device_name;

	switch (id->device) =

	{
		case PCI_DEVICE_ID_HILSCHER_NETX:
			bar =3D DPM_BAR;
			info->peripheral_name =3D CIFX_RTDM_CARD_NAME;
			break;
		case PCI_DEVICE_ID_HILSCHER_NETPLC:
			bar =3D DPM_BAR;
			info->peripheral_name =3D CIFX_RTDM_NETPLC_CARD_NAME;
			break;
		case PCI_DEVICE_ID_HILSCHER_NETJACK:
			bar =3D DPM_BAR;
			info->peripheral_name =3D CIFX_RTDM_NETJACK_CARD_NAME;
			break;
		default:
			bar =3D PLX_DPM_BAR;
			info->peripheral_name =3D CIFX_RTDM_PLX_CARD_NAME;
			break;
	}
	=

	info->device_data =3D NULL;
	device_data =3D rtdm_malloc(sizeof(io_info_t));
	=

	if (device_data =3D=3D NULL)
	{
#ifdef DEBUG_PRINTK
		rtdm_printk("cifx rtdm driver error : rtdm_malloc error\n");
#endif /* DEBUG_PRINTK */

		return -ENOMEM;
	}
	=

	memset(device_data, 0, sizeof(io_info_t));
	=

	/* BAR 0 or 2 points to the card's dual port memory */
	device_data->mem[DPM_INDEX].addr =3D pci_resource_start(dev, bar);
  =

	if (device_data->mem[DPM_INDEX].addr =3D=3D 0)
	{
#ifdef DEBUG_PRINTK
		rtdm_printk("cifx rtdm driver error : pci_resource_start error\n");
#endif /* DEBUG_PRINTK */

		goto out_release;
	}
	=

	device_data->mem[DPM_INDEX].internal_addr =3D ioremap_nocache(pci_resource=
_start(dev, bar), pci_resource_len(dev, bar));
    =

	if (device_data->mem[DPM_INDEX].internal_addr =3D=3D 0)
	{
#ifdef DEBUG_PRINTK
		rtdm_printk("cifx rtdm driver error : ioremap_nocache error\n");
#endif /* DEBUG_PRINTK */
	=

		goto out_release;
	}
	=

  	dev_info(&dev->dev, "DPM at %08lX\n", (long unsigned int)device_data->me=
m[DPM_INDEX].addr);
  	device_data->mem[DPM_INDEX].size =3D pci_resource_len(dev, bar);
  	device_data->mem[DPM_INDEX].memtype =3D MEM_PHYS;
  =

	/* map extended mem (BAR 1 points to the extended memory) */
 	device_data->mem[EXT_MEM_INDEX].addr =3D pci_resource_start(dev, EXT_MEM_=
BAR);
 =

	/* extended memory is optional, so don't care if it is not present */
	if (device_data->mem[EXT_MEM_INDEX].addr !=3D 0)
	{
		device_data->mem[EXT_MEM_INDEX].internal_addr =3D ioremap_nocache(pci_res=
ource_start(dev, EXT_MEM_BAR), pci_resource_len(dev, EXT_MEM_BAR));  =

		=

		if (device_data->mem[EXT_MEM_INDEX].internal_addr =3D=3D 0)
		{
#ifdef DEBUG_PRINTK
			rtdm_printk("cifx rtdm driver error : ioremap_nocache error\n");
#endif /* DEBUG_PRINTK */			=

		=

			goto out_unmap;
		}
		=

		dev_info(&dev->dev, "extended memory at %08lX\n", (long unsigned int)devi=
ce_data->mem[EXT_MEM_INDEX].addr);
		device_data->mem[EXT_MEM_INDEX].size    =3D pci_resource_len(dev, EXT_MEM=
_BAR);
		device_data->mem[EXT_MEM_INDEX].memtype =3D MEM_PHYS;
	}
  	=

	if ((id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETX) =

	||	(id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETPLC) =

	||	(id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETJACK)) =

	{
		/* make sure all interrupts are disabled */
		iowrite32(0, device_data->mem[DPM_INDEX].internal_addr + DPM_HOST_INT_EN0=
);
		device_data->priv =3D NULL;
	} =

	else if (id->subdevice =3D=3D PCI_SUBDEVICE_ID_NXPCA) =

	{
		/* map PLX registers */
		pxa_dev_info *pxa_info =3D (pxa_dev_info *)rtdm_malloc(sizeof(pxa_dev_inf=
o));
		=

		if (pxa_info =3D=3D NULL)
		{
#ifdef DEBUG_PRINTK
			rtdm_printk("cifx rtdm driver error : rtdm_malloc error\n");
#endif /* DEBUG_PRINTK */	=


			goto out_unmap;
		}
		=

		device_data->priv =3D pxa_info;
		=

		/* set PXA PLX Timings */
		pxa_info->plx =3D ioremap_nocache(pci_resource_start(dev, PXA_PLX_BAR), p=
ci_resource_len(dev, PXA_PLX_BAR));
		=

		if (!pxa_info->plx)
			goto out_unmap;
		if (cifx_pxa_get_dpm_mode(info))
			goto out_unmap_plx;
		if (cifx_pxa_get_plx_timing(info))
			goto out_unmap_plx;
		if (cifx_pxa_set_plx_timing(info))
			goto out_unmap_plx;
	} =

	else =

	{
		pxa_dev_info *pxa_info =3D (pxa_dev_info *)rtdm_malloc(sizeof(pxa_dev_inf=
o));
		=

		if (pxa_info =3D=3D NULL)
		{
#ifdef DEBUG_PRINTK
			rtdm_printk("cifx rtdm driver error : rtdm_malloc error\n");
#endif /* DEBUG_PRINTK */

			goto out_free_pxa;
		}
		=

		pxa_info->plx =3D NULL;
		pxa_info->plx_timing =3D 0;
		pxa_info->dpm_mode =3D 0;
		device_data->priv =3D pxa_info;
	}

	info->device_data =3D device_data;

	if ((ret =3D rtdm_dev_register(info)) !=3D 0)
	{
#ifdef DEBUG_PRINTK
		switch(ret)
		{
			case -EINVAL :

				rtdm_printk("cifx rtdm driver error : rtdm_dev_register error : the dev=
ice structure contains invalid entries. Check kernel log in this case\n");
				break;
				=

			case -ENOMEM :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_dev_register error : the con=
text for an exclusive device cannot be allocated\n");
				break;
				=

			case -EEXIST :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_dev_register error : the spe=
cified device name of protocol ID is already in use\n");
				break;
				=

			case -EAGAIN :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_dev_register error : some /p=
roc entry cannot be created\n");
				break;	=

		=

			default :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_dev_register error\n");
				break;
		}
#endif /* DEBUG_PRINTK */
	=

		if (id->subdevice !=3D PCI_SUBDEVICE_ID_NXPCA)
			goto out_unmap;
		else
			goto out_unmap_plx;
	}

	device_data->irq =3D dev->irq;
	device_data->irq_flags =3D RTDM_IRQTYPE_SHARED;
	device_data->handler =3D cifx_handler;
	device_data->irq_handle =3D NULL;

	irq_handle =3D rtdm_malloc(sizeof(rtdm_irq_t));
	=

	if (irq_handle =3D=3D NULL)
	{
#ifdef DEBUG_PRINTK
		rtdm_printk("cifx rtdm driver error : rtdm_malloc error\n");
#endif /* DEBUG_PRINTK */

		goto out_free_irq;
	}

	memset(irq_handle, 0, sizeof(rtdm_irq_t));
	=

	if ((ret =3D rtdm_irq_request(irq_handle, device_data->irq, device_data->h=
andler, device_data->irq_flags, info->device_name, (void *)info)) !=3D 0)
	{
#ifdef DEBUG_PRINTK
		switch (ret)
		{
			case -EINVAL :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_irq_request error : an inval=
id parameter was passed\n");
				break;
				=

			case -EBUSY :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_irq_request error : the spec=
ified IRQ line is already in use\n");
				break;
		=

			default :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_irq_request error\n");
				break;
		}				=

#endif /* DEBUG_PRINTK */

		goto out_release_irq;
	}
		=

	device_data->irq_handle =3D irq_handle;

	pci_set_drvdata(dev, info);
	=

	if (id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETX)
		dev_info(&dev->dev, "registered CifX card\n");
	else if (id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETPLC)
		dev_info(&dev->dev, "registered netPLC card\n");
	else if (id->device =3D=3D PCI_DEVICE_ID_HILSCHER_NETJACK)
		dev_info(&dev->dev, "registered netJACK card\n");
	else if (id->subdevice =3D=3D PCI_SUBDEVICE_ID_NXSB_PCA)
		dev_info(&dev->dev,	"registered NXSB-PCA adapter card\n");
	else =

	{
		pxa_dev_info *pxa_info =3D (pxa_dev_info *)((io_info_t *)info->device_dat=
a)->priv;
		dev_info(&dev->dev, "registered NXPCA-PCI adapter card in %d bit mode\n",=
 pxa_info->dpm_mode);
	}
		=

	cifx_num++;
		=

	return 0;
	=

out_release_irq :
	rtdm_irq_free(irq_handle);

out_free_irq:
	rtdm_free(((io_info_t *)info->device_data)->irq_handle);

out_unmap_plx:
	iounmap(((pxa_dev_info *)(((io_info_t *)info->device_data)->priv))->plx);
	=

out_free_pxa:
	rtdm_free(((io_info_t *)info->device_data)->priv);
	=

out_unmap:
	iounmap(((io_info_t *)info->device_data)->mem[DPM_INDEX].internal_addr);
	if (((io_info_t *)info->device_data)->mem[EXT_MEM_INDEX].internal_addr !=
=3D 0)
		iounmap(((io_info_t *)info->device_data)->mem[EXT_MEM_INDEX].internal_add=
r);
out_release:
	pci_release_regions(dev);
	=

out_disable:
	pci_disable_device(dev);
	=

out_free:
	if (irq_handle !=3D NULL)
	{
		rtdm_free(irq_handle);
	}
	if (info->device_data !=3D NULL)
	{
		rtdm_free(info->device_data);
	}
	rtdm_free(info);
	=

	return -ENODEV;
}

/**************************************************************************=
***/
/*!
*   \brief  cifx_pci_remove
*
*   \param  [in]	dev  			=

*
*   \return None
*
*   \note   Close the device. =

*			This function is called when the device shall be closed.
*/
/**************************************************************************=
***/	=

static void __devexit cifx_pci_remove(struct pci_dev *dev)
{
	struct rtdm_device 	*info 			=3D pci_get_drvdata(dev);
	io_info_t			*device_data 	=3D (io_info_t *)info->device_data;	=

	pxa_dev_info 		*pxa_info 		=3D (pxa_dev_info *)device_data->priv;
	int32_t				ret;

	if (info->device_data =3D=3D NULL)
	{
#ifdef DEBUG_PRINTK
		rtdm_printk("cifx rtdm driver error : device_data NULL pointer\n");
#endif /* DEBUG_PRINTK */
		return;
	}
	=

	if (pxa_info !=3D NULL) =

	{
		/* Disable all interrupts */
		iowrite32(0, device_data->mem[DPM_INDEX].internal_addr + DPM_HOST_INT_EN0=
);
	=

		if (pxa_info && pxa_info->plx)
			iounmap((void *)pxa_info->plx);

		rtdm_free((void *)pxa_info);		=

	}
	=

	if (device_data->irq_handle !=3D NULL)
	{
		if ((ret =3D rtdm_irq_free(device_data->irq_handle)) !=3D 0)
		{
#ifdef DEBUG_PRINTK
			rtdm_printk("cifx rtdm driver error : rtdm_irq_free error\n");
#endif /* DEBUG_PRINTK */

			return;
		}
		else
		{
			rtdm_free(device_data->irq_handle);
		}
	}

	if ((ret =3D rtdm_dev_unregister(info, 1000)) !=3D 0)
	{
#ifdef DEBUG_PRINTK
		switch(ret)
		{
			case -ENODEV :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_dev_unregister error : the d=
evice was not registered\n");
				break;
				=

			case -EAGAIN :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_dev_unregister error : the d=
evice is busy with open instances and 0 has been passed for poll_delay\n");
				break;			=

			=

			default :
			=

				rtdm_printk("cifx rtdm driver error : rtdm_dev_unregister error\n");
				break;	=

		}
#endif /* DEBUG_PRINTK */

		return;
	}

	pci_release_regions(dev);
	pci_disable_device(dev);
	pci_set_drvdata(dev, NULL);
	=

	iounmap(device_data->mem[DPM_INDEX].internal_addr);
	if (device_data->mem[EXT_MEM_INDEX].internal_addr !=3D 0)
		iounmap(device_data->mem[EXT_MEM_INDEX].internal_addr);

	rtdm_free(info->device_data);
	rtdm_free(info);
	=

	if (cifx_num > 0)
		cifx_num--;
}

/**************************************************************************=
***/
/*!
*   \brief  cifx_pci_init			=

*
*   \return None
*
*   \note   It simply registers the RTDM device. =

*			This function is called when the module is loaded.
*/
/**************************************************************************=
***/	=

static int __init cifx_pci_init(void)
{
	return pci_register_driver(&cifx_pci_driver);
}

/**************************************************************************=
***/
/*!
*   \brief  cifx_pci_exit			=

*
*   \return None
*
*   \note   It unregister the RTDM device. =

*			This function is called when the module is unloaded.
*/
/**************************************************************************=
***/	=

static void __exit cifx_pci_exit(void)
{
	pci_unregister_driver(&cifx_pci_driver);
}

/**************************************************************************=
***/
/*! \}     cifx_pci_Core	                   				     			 */
/**************************************************************************=
***/

module_init(cifx_pci_init);
module_exit(cifx_pci_exit);

/* End of file : cifx_pci.c */
