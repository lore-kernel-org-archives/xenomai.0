Message-ID: <50AC8FAA.8000703@web.de>
Date: Wed, 21 Nov 2012 09:24:10 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1353481805-28850-1-git-send-email-stefan.roese@gmail.com>
In-Reply-To: <1353481805-28850-1-git-send-email-stefan.roese@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] [PATCH v2] mpc5200: Add RTDM LPBFIFO driver and demo
 RTDM FPGA device driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: stefan.roese@gmail.com
Cc: Stefan Roese <sr@denx.de>, xenomai@xenomai.org

On 2012-11-21 08:10, stefan.roese@gmail.com wrote:
> From: Stefan Roese <sr@denx.de>
> =

> This patch adds support for the RTDM LPB (LocalPlusBus) FIFO driver
> for the MPC5200. It will be used for DMA support in an RTDM FPGA
> device driver. This rt-fpga.c driver is a custom device driver,
> but might be useful for other developers as well. Thats why I
> included it here too.
> =

> The lpb-fifo driver is ported from the Linux kernel lpb-fifo
> driver:
> =

> arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> =

> With all locking etc changed from Linux call to Xenomai/RTDM
> calls.

How do the two interact? Also, I think separate patches are be better.

I'm only looking at the interface so far, but as they are undocumented,
it's a bit tricky to analyze them. Can you add some documentation to
generic interfaces at least?

...

> diff --git a/ksrc/drivers/mpc5200_dma/rt-fpga.c b/ksrc/drivers/mpc5200_dm=
a/rt-fpga.c
> new file mode 100644
> index 0000000..70f1827
> --- /dev/null
> +++ b/ksrc/drivers/mpc5200_dma/rt-fpga.c
> @@ -0,0 +1,694 @@
> +/*
> + *  Xenomai RTDM device driver for A3M071 FPGA with interrupt support
> + *
> + *  Copyright (C) 2012 Stefan Roese <sr@denx.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/uaccess.h>
> +#include <linux/dma-mapping.h>
> +#include <asm/mpc52xx.h>
> +
> +/* Xenomai headers */
> +#include <native/timer.h>
> +#include <rtdm/rtdm_driver.h>
> +
> +#include "rt-fpga.h"
> +
> +extern int rt_mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *req=
);
> +extern void rt_mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *req=
);

Err, no. These two functions define the interface of the lpbfifo? Then
they belong into a header file.

...

> diff --git a/ksrc/drivers/mpc5200_dma/rt-fpga.h b/ksrc/drivers/mpc5200_dm=
a/rt-fpga.h
> new file mode 100644
> index 0000000..f25cf2e
> --- /dev/null
> +++ b/ksrc/drivers/mpc5200_dma/rt-fpga.h

Wrong place for a user header -> include/rtdm.

> @@ -0,0 +1,35 @@
> +/*
> + *  Xenomai RTDM device driver for A3M071 FPGA with interrupt support

Does this driver depend on a specific programming of that FPGA?

> + *
> + *  Copyright (C) 2012 Stefan Roese <sr@denx.de>
> + */
> +
> +#ifndef _RT_FPGA_H
> +#define _RT_FPGA_H
> +
> +/*
> + * IOCTL's for this FPGA driver
> + */
> +#define RTIOC_TYPE_TESTING		RTDM_CLASS_TESTING

RTIOC_CLASS_TESTING is for devices that support unit tests etc. Is this
a unit test? Where is the user space counter part?

If it's not a test case, we should probably define RTDM_CLASS_CUSTOM and
use that instead.

> +#define FPGA_CONFIG	\
> +	_IOW(RTIOC_TYPE_TESTING, 0x00, struct fpga_rw_data)
> +#define FPGA_READ_WORD	\
> +	_IOR(RTIOC_TYPE_TESTING, 0x01, struct fpga_rw_data)
> +#define FPGA_WRITE_WORD	\
> +	_IOW(RTIOC_TYPE_TESTING, 0x02, struct fpga_rw_data)
> +#define FPGA_SET_TIMEOUT	\
> +	_IOW(RTIOC_TYPE_TESTING, 0x03, struct fpga_rw_data)
> +#define FPGA_GET_CYCLES_MISSED	\
> +	_IOR(RTIOC_TYPE_TESTING, 0x04, struct fpga_rw_data)
> +
> +struct fpga_rw_data {
> +	unsigned int offset;
> +	unsigned short value;
> +	unsigned int count;
> +	unsigned int write_offset;
> +	unsigned int write_count;
> +	unsigned int timeout;
> +	int cycles_missed;
> +};

BTW, using a single data structure for all IOCTLs is a bit ugly. I doubt
all fields have a meaning in all calls, do they?

Jan


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121121/68017a3=
2/attachment.pgp>
