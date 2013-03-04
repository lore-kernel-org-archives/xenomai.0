Message-ID: <51350D5B.6060309@xenomai.org>
Date: Mon, 04 Mar 2013 22:08:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>
	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>
	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>
	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>
	<5130B39C.70300@hilscher.com> <513465CF.4030807@hilscher.com>
In-Reply-To: <513465CF.4030807@hilscher.com>
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
Cc: xenomai@xenomai.org

On 03/04/2013 10:13 AM, Jerome Poncin wrote:

> Hello,
> 
> I did two patch one for version head, and for 2.6 version in attached 
> files.  The result is identical.


xenomai-head is a symbolic link to xenomai-2.6. Well, if I did not
forget to put it again during the xenomai.org server migration.

> 
> Therefore, I let you
> 
> "perform a code review and merge
> the code if it is fine."


The coding style is a bit indigest, so I will criticize this first and
let you send a cleaned up version which I will really be able to read.
Maybe others will be able to really read the code, but I am afraid I can't.

> +#
> +# Xenomai configuration for Linux v2.4
> +#


Have you tested your driver on Linux 2.4?

> +++ b/ksrc/drivers/cifx/Config.in~

> +++ b/ksrc/drivers/cifx/Kconfig~
> +++ b/ksrc/drivers/cifx/Makefile~
> +++ b/ksrc/drivers/cifx/cifx_pci.c~

We do not want these file. A simple way to avoid it (besides using diff
-x option), is to work with git, and generate your patches with git
format-patch.


> +/***************************************************************************
> + *   Copyright (C) 2013                                                    *
> + *   Hilscher France (JP)                                                  *
> + *   http://www.hilscher.fr                                                *
> + *                                                                         *
> + *   This program is free software; you can redistribute it and/or modify  *
> + *   it under the terms of the GNU General Public License as published by  *
> + *   the Free Software Foundation; either version 2 of the License, or     *
> + *   (at your option) any later version.                                   *
> + *                                                                         *
> + *   This program is distributed in the hope that it will be useful,       *
> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
> + *   GNU General Public License for more details.                          *
> + *                                                                         *
> + *   You should have received a copy of the GNU General Public License     *
> + *   along with this program; if not, write to the                         *
> + *   Free Software Foundation, Inc.,                                       *
> + *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
> + ***************************************************************************/


Please don't do that. Look at the other files in Xenomai sources to see
how we put the GPL "cartouche". And the doxygen cartouches as well.

The standard multiline comment is:

/*
 *
 */

> +

> +/*****************************************************************************/


We do not want that either

> +
> +/* Includes */


Useless comment, everything which begins with #include is obviously an
include

> +#ifndef TRUE
> +#define TRUE                            1
> +#endif				/* TRUE */
> +
> +#ifndef FALSE
> +#define FALSE                           0
> +#endif				/* TRUE */


No, you do not want to do that. If you really want to use true and
false, use the "bool" type (but I agree, this will not work with 2.4,
but have you really tested your driver with Linux 2.4?).

Besides, tests like if (foo == TRUE) are a bit preposterous. If foo is a
boolean, then if (foo) already tests if foo is true. If we follow your
reasoning why not adding a few more == TRUE ?
If (((foo == TRUE) == TRUE) == TRUE) ?


> +
> +#ifndef PCI_VENDOR_ID_HILSCHER
> +#define PCI_VENDOR_ID_HILSCHER          0x15CF
> +#endif				/* PCI_VENDOR_ID_HILSCHER */
> +
> +#ifndef PCI_DEVICE_ID_HILSCHER_NETX
> +#define PCI_DEVICE_ID_HILSCHER_NETX     0x0000
> +#endif				/* PCI_DEVICE_ID_HILSCHER_NETX */
> +
> +#ifndef PCI_DEVICE_ID_HILSCHER_NETPLC
> +#define PCI_DEVICE_ID_HILSCHER_NETPLC   0x0010
> +#endif				/* PCI_DEVICE_ID_HILSCHER_NETPLC */
> +
> +#ifndef PCI_DEVICE_ID_HILSCHER_NETJACK
> +#define PCI_DEVICE_ID_HILSCHER_NETJACK  0x0020
> +#endif				/* PCI_DEVICE_ID_HILSCHER_NETJACK */
> +
> +#ifndef PCI_SUBDEVICE_ID_NXSB_PCA
> +#define PCI_SUBDEVICE_ID_NXSB_PCA       0x3235
> +#endif				/* PCI_SUBDEVICE_ID_NXSB_PCA */
> +
> +#ifndef PCI_SUBDEVICE_ID_NXPCA
> +#define PCI_SUBDEVICE_ID_NXPCA          0x3335
> +#endif				/* PCI_SUBDEVICE_ID_NXPCA */
> +
> +#ifndef PCI_SUBDEVICE_ID_NETPLC_RAM
> +#define PCI_SUBDEVICE_ID_NETPLC_RAM     0x0000
> +#endif				/* PCI_SUBDEVICE_ID_NETPLC_RAM */
> +
> +#ifndef PCI_SUBDEVICE_ID_NETPLC_FLASH
> +#define PCI_SUBDEVICE_ID_NETPLC_FLASH   0x0001
> +#endif				/* PCI_SUBDEVICE_ID_NETPLC_FLASH */
> +
> +#ifndef PCI_SUBDEVICE_ID_NETJACK_RAM
> +#define PCI_SUBDEVICE_ID_NETJACK_RAM    0x0000
> +#endif				/* PCI_SUBDEVICE_ID_NETJACK_RAM */
> +
> +#ifndef PCI_SUBDEVICE_ID_NETJACK_FLASH
> +#define PCI_SUBDEVICE_ID_NETJACK_FLASH  0x0001
> +#endif				/* PCI_SUBDEVICE_ID_NETJACK_FLASH */


These defines should go to asm-generic/pci_ids.h


> +/* Prototypes */


Just as useless as "includes".

> +/* Local variables */


Again.

> +/** RTDM Device information structure */


Again


> +/** Device table */


Again.

> +static DEFINE_PCI_DEVICE_TABLE(cifx_pci_tbl) = {
> +	{
> +		.vendor = PCI_VENDOR_ID_HILSCHER,
> +		.device = PCI_DEVICE_ID_HILSCHER_NETX,
> +		.subvendor = 0,
> +		.subdevice = 0,
> +	},


There are convenient standard macro to put these declarations on a
single line.

> +#ifdef IRQ_SUPPORT


If IRQ support is not tested, and is never compiled, then this is dead
code, remove it.

The code with #ifdef DEBUG is also questionable, it will tend to bitrot
since nobody will think to enable it.


> +	/* Test if (oflags) IRQ are use */
> +	if (oflags == TRUE) {
> +		if (((struct io_info_t *)info->device_data)->irq_registered
> +		    == FALSE) {
> +			/* Register IRQ */
> +			ret =
> +			    rtdm_irq_request(&
> +					     (((struct io_info_t *)info->
> +					       device_data)->irq_handle),
> +					     ((struct io_info_t *)info->
> +					      device_data)->irq, cifx_handler,
> +					     RTDM_IRQTYPE_SHARED,
> +					     info->device_name, (void *)info);


Your code is drifting a lot to the right.

That is because instead of:

if (ok)
	if (still_ok)
		if (still_ok2)
			if (still_ok3)
				action;

you should do

if (!ok)
	return;

if (!still_ok)
	return;

if (!still_ok2)
	return;

if (!still_ok3)
	return;

This is much more readable.
And if you want to please Philippe, you should replace:

if (!ok)

with

if (ok == 0)

He finds this more readable (it is easy to miss the '!' character when
reading fast, and read the test inverted).


> +/*****************************************************************************/
> +/*!
> + *   \brief  cifx_pci_probe
> + *
> + *   \param  [in]   dev
> + *   \param  [in]   id
> + *
> + *   \return 0 (OK) or Error
> + *
> + *   \note  Open the device.
> + *			This function is called when the device shall be opened.
> + */
> +/*****************************************************************************/
> +static int cifx_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)


I am not sure this function needs to be documented. What should be
documented in an RTDM driver is the driver "profile", meaning the
behaviour of the externally usable interface, the behaviour of open,
read, write, and most of all the various ioctls it supports.

The comment is misleading: the probe function is not called when the
device is opened, but when the device is enumerated by a device
enumeration technique (be it a bus like PCI or USB with enumeration, or
platform devices or device tree), and matched with a driver. The suffix
_probe suffices to indicate this situation, no further comment is needed.

> +	/* Initialize structure with default values */
> +	memcpy(info, &cifx_device_tmpl, sizeof(struct rtdm_device));


I would use sizeof(*info) here, if the type of the info pointer changes,
the memcpy will not have unintended effects.

> +


> +/*****************************************************************************/
> +/*!
> + *   \brief  cifx_pci_init
> + *
> + *   \return None
> + *
> + *   \note   It simply registers the RTDM device.
> + *   This function is called when the module is loaded.
> + */
> +/*****************************************************************************/
> +static int __init cifx_pci_init(void)
> +{
> +	cifx_num = 0;
> +
> +	return pci_register_driver(&cifx_pci_driver);
> +}


Useless comment again. The following line:

> +module_init(cifx_pci_init);

Is sufficient to indicate that the function is called when the module is
loaded. So, if you want to make that obvious, put the declaration close
to the function definition, and avoid the comment.

I think  you are not convinced yet that "code is the best
documentation". Imagine a moment that we remove the "module_init" macro
call, the function will no longer be called when the module is loaded,
yet the comment will still claim that it is, and can puzzle someone
debugging your code and wondering why the pci driver does not get
registered.

-- 
                                                                Gilles.

