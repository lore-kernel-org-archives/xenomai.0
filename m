Message-ID: <512F120A.5060109@hilscher.com>
Date: Thu, 28 Feb 2013 09:15:06 +0100
From: Jerome Poncin <JPoncin@hilscher.com>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com> <512C9E78.1060208@siemens.com>
	<512CC5C6.8050204@hilscher.com> <512CC6A3.1010005@siemens.com>
In-Reply-To: <512CC6A3.1010005@siemens.com>
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I tried to put one IRQ only for my cifX board without success. I have =

not enough IRQ on my PC and the most of them are shared.
I modified Linux kernel to limit driver, I checked that all was correct =

in BIOS etc. I had the same problem for a driver on another system.
It's not really important for the moment because the normal use of the =

driver is polling.
Therefore for me, the part of Xenomai kernel driver for CifX is finished =

and can be integrated to next release of Xenomai.
I don't know how to integrate my source to Xenomai kernel, therefore I =

give you my last release of Xenomai kernel driver for cifX with the =

makefile for compilation option.

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



Le 26/02/2013 15:28, Jan Kiszka a =E9crit :
> On 2013-02-26 15:25, Jerome Poncin wrote:
>> Hello Jan,
>>
>> Thank you for your answer. I checked /proc/interrupts and lspci -v, and =
I saw that the IRQ is shared.
>>
>> "If yes, resolve that conflict."
>>
>> =3D> What must I do ? I'm not sure to have understood ?
> See
> http://xenomai.org/index.php/FAQs#What_can_I_do_if_Xenomai_and_Linux_devi=
ces_share_the_same_IRQ.3F
>
>>
>> /***********************************************************************=
******/
>> /*!
>> *   \brief  cifx_handler
>> *
>> *   \param  [in]    irq      Resource task pointer
>> *
>> *   \return RTDM_IRQ_NONE or RTDM_IRQ_HANDLED
>> *
>> *   \note   cifx interrupt handler
>> */
>> /***********************************************************************=
******/
>> static /*inline*/ int cifx_handler(rtdm_irq_t *irq)
>> {
>>      struct rtdm_device    *info             =3D (struct rtdm_device *)r=
tdm_irq_get_arg(irq, void);
>>      io_info_t             *device_data     =3D (io_info_t *) info->devi=
ce_data;
>>
>>      if ((device_data->priv !=3D NULL) || (device_data->irq_registered =
=3D=3D FALSE) || (device_data->irq_enable =3D=3D FALSE))
>>      {
>>          /* This is a PLX device and cannot produce an IRQ */
>>          return RTDM_IRQ_NONE;
>>      }
>>      else
>>      {
>>          void __iomem *int_enable_reg =3D device_data->mem[DPM_INDEX].in=
ternal_addr + DPM_HOST_INT_EN0;
>>          void __iomem *int_status_reg =3D device_data->mem[DPM_INDEX].in=
ternal_addr + DPM_HOST_INT_STAT0;
>>
>>          /* Is one of our interrupts enabled and active ? */
>>          if (!(ioread32(int_enable_reg) & ioread32(int_status_reg) & DPM=
_HOST_INT_MASK))
>>              return RTDM_IRQ_NONE;
>>
>>          /* Disable interrupt */
>>          iowrite32(ioread32(int_enable_reg) & ~DPM_HOST_INT_GLOBAL_EN, i=
nt_enable_reg);
>>
>>          return RTDM_IRQ_HANDLED;
>>      }
>> }
>>
>> If IRQ is not mine, I return RTDM_IRQ_NONE, it's not correct ?
> It is. The problem is the sharing between RT and Linux. That cannot work.
>
> Jan
>

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

#include <sys/mman.h>

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

#ifndef TRUE
#define TRUE						1		=

#endif /* TRUE */

#ifndef FALSE
#define FALSE						0		=

#endif /* TRUE */

#ifndef PCI_VENDOR_ID_HILSCHER
	#define PCI_VENDOR_ID_HILSCHER   			0x15CF
#endif /* PCI_VENDOR_ID_HILSCHER */

#ifndef PCI_DEVICE_ID_HILSCHER_NETX
	#define PCI_DEVICE_ID_HILSCHER_NETX  		0x0000
#endif /* PCI_DEVICE_ID_HILSCHER_NETX */

#ifndef PCI_DEVICE_ID_HILSCHER_NETPLC
	#define PCI_DEVICE_ID_HILSCHER_NETPLC  		0x0010
#endif /* PCI_DEVICE_ID_HILSCHER_NETPLC */

#ifndef PCI_DEVICE_ID_HILSCHER_NETJACK
	#define PCI_DEVICE_ID_HILSCHER_NETJACK  	0x0020
#endif /* PCI_DEVICE_ID_HILSCHER_NETJACK */

#ifndef PCI_SUBDEVICE_ID_NXSB_PCA
	#define PCI_SUBDEVICE_ID_NXSB_PCA  			0x3235
#endif /* PCI_SUBDEVICE_ID_NXSB_PCA */

#ifndef PCI_SUBDEVICE_ID_NXPCA
	#define PCI_SUBDEVICE_ID_NXPCA   			0x3335
#endif /* PCI_SUBDEVICE_ID_NXPCA */

#ifndef PCI_SUBDEVICE_ID_NETPLC_RAM
	#define PCI_SUBDEVICE_ID_NETPLC_RAM  		0x0000
#endif /* PCI_SUBDEVICE_ID_NETPLC_RAM */

#ifndef PCI_SUBDEVICE_ID_NETPLC_FLASH
	#define PCI_SUBDEVICE_ID_NETPLC_FLASH   	0x0001
#endif /* PCI_SUBDEVICE_ID_NETPLC_FLASH */

#ifndef PCI_SUBDEVICE_ID_NETJACK_RAM
	#define PCI_SUBDEVICE_ID_NETJACK_RAM   		0x0000
#endif /* PCI_SUBDEVICE_ID_NETJACK_RAM */

#ifndef PCI_SUBDEVICE_ID_NETJACK_FLASH
	#define PCI_SUBDEVICE_ID_NETJACK_FLASH   	0x0001
#endif /* PCI_SUBDEVICE_ID_NETJACK_FLASH */

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

/* Number of bar */
#define DPM_BAR    								0			/* points to the DPM -> netX, netPLC, netJAC=
K */
#define EXT_MEM_BAR 							1 			/* points to the optional extended memory  =
   */
#define PLX_DPM_BAR 							2 			/* points to the DPM -> netXPLX            =
   */ =

#define PXA_PLX_BAR 							0 			/* timing config register                  =
   */

/* Index of io_info structure's memory array */
#define DPM_INDEX     							0 			/* first mapping describes DPM           =
   */
#define EXT_MEM_INDEX 							1			/* second mapping describes extended memor=
y */

#define MAX_MAPS    							2

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

/**************************************************************************=
*/

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
	uint8_t 			irq_enable;
	uint8_t 			irq_registered;
	rtdm_irq_t  		irq_handle;
	void				*priv;
} io_info_t;

typedef struct {
	uint32_t			phys_addr;
	void **				virt_addr;
	uint32_t			length;
} io_map_mem;

/**************************************************************************=
*/

/* Prototypes */

static int 		cifx_handler(rtdm_irq_t *irq);
static int 		cifx_pxa_set_plx_timing(struct rtdm_device *info);
static int 		cifx_pxa_get_plx_timing(struct rtdm_device *info);
static int 		cifx_pxa_get_dpm_mode(struct rtdm_device *info);

static int 		cifx_pci_open(struct rtdm_dev_context *context, rtdm_user_info=
_t * user_info, int oflags);
static int 		cifx_pci_close(struct rtdm_dev_context *context, rtdm_user_inf=
o_t * user_info);
static ssize_t  cifx_pci_read(struct rtdm_dev_context *context, rtdm_user_i=
nfo_t *user_info, void *buf, size_t nbyte);
static ssize_t  cifx_pci_write(struct rtdm_dev_context *context, rtdm_user_=
info_t * user_info, const void *buf, size_t nbyte);

static int 		cifx_pci_probe(struct pci_dev *dev, const struct pci_device_id=
 *id);
static void 	cifx_pci_remove(struct pci_dev *dev);

/**************************************************************************=
*/

/* Local variables */

/** Number or cifx found and open */
static 	int32_t 	cifx_num	=3D	0;

/** RTDM Device information structure */
static const struct rtdm_device __initdata cifx_device_tmpl =3D {
	.struct_version		=3D RTDM_DEVICE_STRUCT_VER,
	=

	.device_flags		=3D RTDM_NAMED_DEVICE,
	.context_size   	=3D 0,
	.device_name		=3D "",

	.open_nrt		=3D cifx_pci_open,

	.ops =3D {
		.close_nrt	=3D cifx_pci_close,

		.read_nrt   =3D cifx_pci_read,
		.write_nrt  =3D cifx_pci_write,
		=

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
};

/** Device table */
static struct pci_device_id cifx_pci_tbl[] =3D {
	{
		.vendor =3D		PCI_VENDOR_ID_HILSCHER,
		.device =3D		PCI_DEVICE_ID_HILSCHER_NETX,
		.subvendor =3D	0,
		.subdevice =3D	0,
	},
	{
		.vendor =3D		PCI_VENDOR_ID_PLX,
		.device =3D		PCI_DEVICE_ID_PLX_9030,
		.subvendor =3D	PCI_VENDOR_ID_PLX,
		.subdevice =3D	PCI_SUBDEVICE_ID_NXSB_PCA,
	},
	{
		.vendor =3D		PCI_VENDOR_ID_PLX,
		.device =3D		PCI_DEVICE_ID_PLX_9030,
		.subvendor =3D	PCI_VENDOR_ID_PLX,
		.subdevice =3D	PCI_SUBDEVICE_ID_NXPCA,
	},
	{
		.vendor =3D		PCI_VENDOR_ID_HILSCHER,
		.device =3D		PCI_DEVICE_ID_HILSCHER_NETPLC,
		.subvendor =3D	PCI_VENDOR_ID_HILSCHER,
		.subdevice =3D	PCI_SUBDEVICE_ID_NETPLC_RAM,
	},
	{
		.vendor =3D		PCI_VENDOR_ID_HILSCHER,
		.device =3D		PCI_DEVICE_ID_HILSCHER_NETPLC,
		.subvendor =3D	PCI_VENDOR_ID_HILSCHER,
		.subdevice =3D	PCI_SUBDEVICE_ID_NETPLC_FLASH,
	},
	{
		.vendor =3D 		PCI_VENDOR_ID_HILSCHER,
		.device =3D 		PCI_DEVICE_ID_HILSCHER_NETJACK,
		.subvendor =3D  	PCI_VENDOR_ID_HILSCHER,
		.subdevice =3D  	PCI_SUBDEVICE_ID_NETJACK_RAM,
	},
	{
		.vendor =3D 		PCI_VENDOR_ID_HILSCHER,
		.device =3D 		PCI_DEVICE_ID_HILSCHER_NETJACK,
		.subvendor =3D  	PCI_VENDOR_ID_HILSCHER,
		.subdevice =3D  	PCI_SUBDEVICE_ID_NETJACK_FLASH,
	},
	{ 0, }
};

/** RTDM cifX Driver */
static struct pci_driver cifx_pci_driver =3D {
	.name		=3D "cifx",
	.id_table	=3D cifx_pci_tbl,
	.probe		=3D cifx_pci_probe,
	.remove		=3D cifx_pci_remove,
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
static inline int cifx_handler(rtdm_irq_t *irq)
{
	struct rtdm_device	*info 			=3D (struct rtdm_device *)rtdm_irq_get_arg(irq=
, void);
	io_info_t 			*device_data 	=3D (io_info_t *) info->device_data;
	=

	/* Test if request is for this driver */
	if ((device_data->priv !=3D NULL) || (device_data->irq_registered =3D=3D F=
ALSE) || (device_data->irq_enable =3D=3D FALSE))
	{
		/* This is a PLX device and cannot produce an IRQ, IRQ not registred or n=
ot enable (cannot produce an IRQ) */
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
			return RTDM_IRQ_NONE;
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
*	\param	[in]	oflags		flags (flag IRQ used)
*
*   \return 0 (OK) or Error
*
*   \note   Open RTDM cifx pci driver
*/
/**************************************************************************=
***/
static int cifx_pci_open(struct rtdm_dev_context *context, rtdm_user_info_t=
 * user_info, int oflags)
{
	struct rtdm_device 		*info =3D (struct rtdm_device *)context->device;
	int32_t					ret;

	/* Test if (oflags) IRQ are use */
	if (oflags =3D=3D TRUE)
	{
		if (((io_info_t *)info->device_data)->irq_registered =3D=3D FALSE)
		{	=

			/* Register IRQ */
			if ((ret =3D rtdm_irq_request(&(((io_info_t *)info->device_data)->irq_ha=
ndle), ((io_info_t *)info->device_data)->irq, cifx_handler, RTDM_IRQTYPE_SH=
ARED, info->device_name, (void *)info)) !=3D 0)
			{
#ifdef DEBUG
				switch (ret)
				{
					case -EINVAL :
			=

						rtdm_printk("cifx rtdm driver error : rtdm_irq_request error : an inv=
alid parameter was passed\n");
						break;
				=

					case -EBUSY :
			=

						rtdm_printk("cifx rtdm driver error : rtdm_irq_request error : the sp=
ecified IRQ line is already in use\n");
						break;
		=

					default :
			=

						rtdm_printk("cifx rtdm driver error : rtdm_irq_request error\n");
						break;
				}				=

#endif /* DEBUG */

				return -ENODEV;
			}
			else
			{
				((io_info_t *)info->device_data)->irq_registered =3D TRUE;
			}
		}
	}

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
*   \note   Close RTDM cifx pci driver
*/
/**************************************************************************=
***/
static int cifx_pci_close(struct rtdm_dev_context *context, rtdm_user_info_=
t * user_info)
{
	struct rtdm_device 		*info =3D (struct rtdm_device *)context->device;
			=

	if (((io_info_t *)info->device_data)->irq_registered =3D=3D TRUE)
	{
		if (((io_info_t *)info->device_data)->irq_enable =3D=3D TRUE)
		{
			/* Disable IRQ */
			if (rtdm_irq_disable(&(((io_info_t *)info->device_data)->irq_handle)) !=
=3D 0)
			{
#ifdef DEBUG
				rtdm_printk("cifx rtdm driver error : rtdm_irq_disable error\n");				=

#endif /* DEBUG */
		=

				return -ENODEV;
			}
		}

		/* Unregister IRQ */
		if (rtdm_irq_free(&(((io_info_t *)info->device_data)->irq_handle)) !=3D 0)
		{
#ifdef DEBUG
				rtdm_printk("cifx rtdm driver error : rtdm_irq_free error\n");				=

#endif /* DEBUG */
		=

				return -ENODEV;	=

		}
	}

	return 0;
}
	=

/**************************************************************************=
***/
/*!
*   \brief  cifx_pci_read
*
*   \param  [in]	context  	context
*	\param	[in]	user_info	user information
*	\param	[in]	buf	user 	buffer
*	\param	[in]	nbyte		number of byte to read
*
*   \return size read
*
*   \note   Read
*/
/**************************************************************************=
***/
static ssize_t cifx_pci_read(struct rtdm_dev_context *context, rtdm_user_in=
fo_t *user_info, void *buf, size_t nbyte)
{
	struct rtdm_device 		*info =3D (struct rtdm_device *)context->device;
	=

	if (nbyte > sizeof(io_info_t))
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : data user size too big\n");
#endif /* DEBUG */
	=

		return 0;
	}
	=

	/* Copy data information for userland */
	if (rtdm_safe_copy_to_user(user_info, buf, ((io_info_t *)info->device_data=
), nbyte))
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : can't copy data from driver\n");
#endif /* DEBUG */
	}

	return nbyte;
}

/**************************************************************************=
***/
/*!
*   \brief  cifx_pci_write
*
*   \param  [in]	context  	context
*	\param	[in]	user_info	user information
*	\param	[in]	buf	user 	buffer
*	\param	[in]	nbyte		number of byte to read
*
*   \return size read
*
*   \note   Read
*/
/**************************************************************************=
***/
static ssize_t cifx_pci_write(struct rtdm_dev_context *context, rtdm_user_i=
nfo_t * user_info, const void *buf, size_t nbyte)
{
	struct rtdm_device 	*info =3D (struct rtdm_device *)context->device;
	uint8_t				irq_enable;
	io_map_mem			map_mem;
	int					ret;
	=

	if (nbyte > sizeof(io_map_mem))
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : data user size too big\n");
#endif /* DEBUG */
	=

		return 0;
	}

	if (nbyte =3D=3D sizeof(uint8_t))
	{
		/* Copy data for Kernel */
		if (rtdm_safe_copy_from_user(user_info, &irq_enable, buf, nbyte))
		{
			nbyte =3D 0;
							=

#ifdef DEBUG
			rtdm_printk("cifx rtdm driver error : can't copy data from driver\n");
#endif /* DEBUG */
		}
		else
		{
			if ((((io_info_t *)info->device_data)->irq_enable) !=3D irq_enable)
			{
				if (((io_info_t *)info->device_data)->irq_registered =3D=3D TRUE)
				{
					if (irq_enable =3D=3D TRUE)
					{
						/* Enable IRQ */
						if (rtdm_irq_enable(&(((io_info_t *)info->device_data)->irq_handle)) =
!=3D 0)
						{
#ifdef DEBUG
							rtdm_printk("cifx rtdm driver error : rtdm_irq_enable error\n");				=

#endif /* DEBUG */
					=

							return -ENODEV;
						}
					}
					else
					{
						/* Disable IRQ */
						if (rtdm_irq_disable(&(((io_info_t *)info->device_data)->irq_handle))=
 !=3D 0)
						{
#ifdef DEBUG
							rtdm_printk("cifx rtdm driver error : rtdm_irq_disable error\n");				=

#endif /* DEBUG */
					=

							return -ENODEV;
						}
					}				=

				=

					((io_info_t *)info->device_data)->irq_enable =3D irq_enable;
				}
				else
				{
#ifdef DEBUG
					rtdm_printk("cifx rtdm driver error : try to enable or diable IRQ but =
not registered\n");				=

#endif /* DEBUG */
				}
			}
		}
	}
	else if (nbyte =3D=3D sizeof(io_map_mem))
	{
		/* Copy data information for Kernel */
		if (rtdm_safe_copy_from_user(user_info, &map_mem, buf, nbyte))
		{
			nbyte =3D 0;
							=

#ifdef DEBUG
			rtdm_printk("cifx rtdm driver error : can't copy data from driver\n");
#endif /* DEBUG */
		}
		else
		{
			if (*map_mem.virt_addr =3D=3D NULL)
			{
				/* Map physical on virtual memory */
				ret =3D rtdm_iomap_to_user(user_info, (phys_addr_t)map_mem.phys_addr, (=
size_t)map_mem.length, (PROT_READ | PROT_WRITE), map_mem.virt_addr, NULL, N=
ULL);
				=

				if (ret !=3D 0)
				{
					nbyte =3D 0;

#ifdef DEBUG					=

					switch (ret)
					{
						case -EINVAL :				=


								rtdm_printk("cifx rtdm driver error : an invalid start address, siz=
e, or destination address was passed\n");				=


							break;
							=

						case -ENOMEM :				=


								rtdm_printk("cifx rtdm driver error : there is insufficient free me=
mory or the limit of memory mapping for the user process was reached\n");		=
		=


							break;
							=

						case -EAGAIN:		=


								rtdm_printk("cifx rtdm driver error : too much memory has been alre=
ady locked by the user process\n");				=

		=

							break;
							=

						case -EPERM :	=


								rtdm_printk("cifx rtdm driver error : an illegal invocation environ=
ment is detected\n");				=

	=

							break;
							=

						default :

								rtdm_printk("cifx rtdm driver error : rtdm_safe_copy_from_user erro=
r\n");				=

			=

							break;
					}
#endif /* DEBUG */	=

				}
			}	=

			else
			{
				/* Unap virtual memory */
				ret =3D rtdm_munmap(user_info, *map_mem.virt_addr, (size_t)map_mem.leng=
th);
				=

				if (ret !=3D 0)
				{
					nbyte =3D 0;

#ifdef DEBUG				=

					switch (ret)
					{
						case -EINVAL :
					=

							rtdm_printk("cifx rtdm driver error : an invalid address or size was=
 passed\n");				=

					=

							break;
				=

						case -EPERM :
					=

							rtdm_printk("cifx rtdm driver error : an illegal invocation environm=
ent is detected\n");	=

					=

							break;			=

				=

						default :
					=

							rtdm_printk("cifx rtdm driver error : rtdm_safe_copy_from_user error=
\n");				=

			=

							break;
					}
#endif /* DEBUG */
				}
			}
		}	=

	}
	else
	{
		/* Error nothing to do */
		nbyte =3D 0;
	}
	=

	return nbyte;
}

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

static int cifx_pci_probe(struct pci_dev *dev, const struct pci_device_id *=
id)
{
	struct rtdm_device 	*info			=3D	NULL;
	io_info_t			*device_data	=3D	NULL;	=

	int32_t 			bar;
	int32_t				ret;
		=

	/* Allocate device driver structure */
	info =3D rtdm_malloc(sizeof(struct rtdm_device));
				=

	if (info =3D=3D NULL)
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : rtdm_malloc error\n");
#endif /* DEBUG */

		return -ENOMEM;
	}
	=

	if ((ret =3D pci_enable_device(dev)) !=3D 0)
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : pci_enable_device error : %i\n", re=
t);
#endif /* DEBUG */
 =

		goto out_free;
	}
	=

	if ((ret =3D pci_request_regions(dev, DRIVER_NAME)) !=3D 0)
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : pci_request_regions error : %i\n", =
ret);
#endif /* DEBUG */
	=

		goto out_disable;
	}
	=

	/* Initialize structure with default values */
	memcpy(info, &cifx_device_tmpl, sizeof(struct rtdm_device));
	=

	info->device_id	=3D id->device;
	snprintf((char *)info->device_name, RTDM_MAX_DEVNAME_LEN, "cifx%i", cifx_n=
um);
	info->proc_name	=3D info->device_name;
	=

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
	=

	/* Allocate specific data strcuture for device */
	device_data =3D rtdm_malloc(sizeof(io_info_t));
	=

	if (device_data =3D=3D NULL)
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : rtdm_malloc error\n");
#endif /* DEBUG */

		goto out_release;
	}
	=

	memset(device_data, 0, sizeof(io_info_t));
	=

	/* BAR 0 or 2 points to the card's dual port memory */
	device_data->mem[DPM_INDEX].addr =3D pci_resource_start(dev, bar);
  =

	if (device_data->mem[DPM_INDEX].addr =3D=3D 0)
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : pci_resource_start error\n");
#endif /* DEBUG */

		goto out_release;
	}
	=

	device_data->mem[DPM_INDEX].internal_addr =3D ioremap_nocache(pci_resource=
_start(dev, bar), pci_resource_len(dev, bar));
    =

	if (device_data->mem[DPM_INDEX].internal_addr =3D=3D 0)
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : ioremap_nocache error\n");
#endif /* DEBUG */
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
#ifdef DEBUG
			rtdm_printk("cifx rtdm driver error : ioremap_nocache error\n");
#endif /* DEBUG */			=

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
#ifdef DEBUG
			rtdm_printk("cifx rtdm driver error : rtdm_malloc error\n");
#endif /* DEBUG */	=


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
#ifdef DEBUG
			rtdm_printk("cifx rtdm driver error : rtdm_malloc error\n");
#endif /* DEBUG */

			goto out_free_pxa;
		}
		=

		pxa_info->plx =3D NULL;
		pxa_info->plx_timing =3D 0;
		pxa_info->dpm_mode =3D 0;
		device_data->priv =3D pxa_info;
	}
	=

	/* Initialize irq data */
	device_data->irq =3D dev->irq;
	device_data->irq_enable =3D FALSE;
	device_data->irq_registered =3D FALSE;
	=

	info->device_data =3D device_data;

	/* Register RTDM device driver */
	if ((ret =3D rtdm_dev_register(info)) !=3D 0)
	{
#ifdef DEBUG
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
#endif /* DEBUG */
	=

		if (id->subdevice !=3D PCI_SUBDEVICE_ID_NXPCA)
			goto out_unmap;
		else
			goto out_unmap_plx;
	}
	=

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

static void cifx_pci_remove(struct pci_dev *dev)
{
	struct rtdm_device 	*info 			=3D pci_get_drvdata(dev);
	io_info_t			*device_data 	=3D (io_info_t *)info->device_data;	=

	pxa_dev_info 		*pxa_info 		=3D (pxa_dev_info *)device_data->priv;
	int32_t				ret;

	if (info->device_data =3D=3D NULL)
	{
#ifdef DEBUG
		rtdm_printk("cifx rtdm driver error : device_data NULL pointer\n");
#endif /* DEBUG */
		return;
	}
	=

	if (pxa_info !=3D NULL) =

	{
		/* Disable all interrupts */
		iowrite32(0, device_data->mem[DPM_INDEX].internal_addr + DPM_HOST_INT_EN0=
);
	=

		if (pxa_info->plx !=3D NULL)
			iounmap((void *)pxa_info->plx);

		rtdm_free((void *)pxa_info);		=

	}
	=

	/* Unregister RTDM device driver */
	if ((ret =3D rtdm_dev_unregister(info, 1000)) !=3D 0)
	{
#ifdef DEBUG
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
#endif /* DEBUG */

		return;
	}

	pci_release_regions(dev);
	pci_disable_device(dev);
	pci_set_drvdata(dev, NULL);
	=

	iounmap(device_data->mem[DPM_INDEX].internal_addr);
	if (device_data->mem[EXT_MEM_INDEX].internal_addr !=3D 0)
		iounmap(device_data->mem[EXT_MEM_INDEX].internal_addr);

	/* Release structure memory allocation */
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
-------------- next part --------------
###### CONFIGURATION ######

### List of applications to be build
APPLICATIONS =3D cifx_xenomai_sample

### Note: to override the search path for the xeno-config script, use "make=
 XENO=3D..."


### List of modules to be build
MODULES =3D cifx_pci =


### Note: to override the kernel source path, use "make KSRC=3D..."

MY_CFLAGS =3D -I/media/Doc/rtdm/libcifx -I/media/Doc/rtdm/libcifx/Toolkit -=
O2 #-DDEBUG

MY_LDFLAGS =3D  -L/usr/xenomai/lib -L/usr/lib/i386-linux-gnu/ -lpthread -lr=
t -lpciaccess -lcifx

###### USER SPACE BUILD (no change required normally) ######
ifeq ($(KERNELRELEASE),)
ifneq ($(APPLICATIONS),)

### Default Xenomai installation path
XENO ?=3D /usr/xenomai

XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin:$(PATH) which xeno-config 2=
>/dev/null)

### Sanity check
ifeq ($(XENOCONFIG),)
all::
	@echo ">>> Invoke make like this: \"make XENO=3D/path/to/xeno-config\" <<<"
	@echo
endif


CC=3D$(shell $(XENOCONFIG) --cc)

CFLAGS=3D$(shell $(XENOCONFIG) --skin=3Dposix --cflags) \
	$(shell $(XENOCONFIG) --skin=3Drtdm --cflags) $(MY_CFLAGS)

LDFLAGS=3D$(MY_LDFLAGS)
LDLIBS=3D$(shell $(XENOCONFIG) --skin=3Dposix --ldflags) \
	$(shell $(XENOCONFIG) --skin=3Drtdm --ldflags) $(MY_LDFLAGS)

# This includes the library path of given Xenomai into the binary to make l=
ive
# easier for beginners if Xenomai's libs are not in any default search path.
LDFLAGS+=3D-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir) $(MY_LD=
FLAGS)

all:: $(APPLICATIONS)

clean::
	$(RM) $(APPLICATIONS) *.o

endif
endif



###### KERNEL MODULE BUILD (no change required normally) ######
ifneq ($(MODULES),)

### Default to sources of currently running kernel
KSRC ?=3D /lib/modules/$(shell uname -r)/build

OBJS     :=3D ${patsubst %, %.o, $(MODULES)}
CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}
PWD      :=3D $(shell if [ "$$PWD" !=3D "" ]; then echo $$PWD; else pwd; fi)

### Kernel 2.6 or 3.0
PATCHLEVEL:=3D$(shell sed 's/PATCHLEVEL =3D \(.*\)/\1/;t;d' $(KSRC)/Makefil=
e)
VERSION:=3D$(shell sed 's/VERSION =3D \(.*\)/\1/;t;d' $(KSRC)/Makefile)
ifneq ($(VERSION).$(PATCHLEVEL),2.4)

obj-m        :=3D $(OBJS)
EXTRA_CFLAGS :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/posix=
 $(ADD_CFLAGS)

all::
	$(MAKE) -C $(KSRC) SUBDIRS=3D$(PWD) modules

### Kernel 2.4
else

ARCH    ?=3D $(shell uname -i)
INCLUDE :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$=
(KSRC)/include/xenomai/posix
CFLAGS  +=3D $(shell $(MAKE) -s -C $(KSRC) CC=3D$(CC) ARCH=3D$(ARCH) SUBDIR=
S=3D$(PWD) modules) $(INCLUDE)

all:: $(OBJS)

endif

## Target for capturing 2.4 module CFLAGS
modules:
	@echo "$(CFLAGS)"

clean::
	$(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers Module.markers modules.=
order
	$(RM) -R .tmp*

endif
