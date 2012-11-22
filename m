Message-ID: <50AE83D1.8000402@web.de>
Date: Thu, 22 Nov 2012 20:58:09 +0100
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
References: <1353481805-28850-1-git-send-email-stefan.roese@gmail.com>
	<50AC8FAA.8000703@web.de> <50AC9E6D.3060203@gmail.com>
In-Reply-To: <50AC9E6D.3060203@gmail.com>
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
To: Stefan Roese <stefan.roese@gmail.com>
Cc: xenomai@xenomai.org

Hi Stefan,

On 2012-11-21 10:27, Stefan Roese wrote:
> Hi Jan,
> =

> On 11/21/2012 09:24 AM, Jan Kiszka wrote:
>> On 2012-11-21 08:10, stefan.roese@gmail.com wrote:
>>> From: Stefan Roese <sr@denx.de>
>>>
>>> This patch adds support for the RTDM LPB (LocalPlusBus) FIFO driver
>>> for the MPC5200. It will be used for DMA support in an RTDM FPGA
>>> device driver. This rt-fpga.c driver is a custom device driver,
>>> but might be useful for other developers as well. Thats why I
>>> included it here too.
>>>
>>> The lpb-fifo driver is ported from the Linux kernel lpb-fifo
>>> driver:
>>>
>>> arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
>>>
>>> With all locking etc changed from Linux call to Xenomai/RTDM
>>> calls.
>>
>> How do the two interact? Also, I think separate patches are be better.
> =

> The FPGA RTDM driver calls the lpbfifo driver via the
> rt_mpc52xx_lpbfifo_submit() function.
> =

> Okay, I can split this into 2 patches in the next version.
> =

>> I'm only looking at the interface so far, but as they are undocumented,
>> it's a bit tricky to analyze them. Can you add some documentation to
>> generic interfaces at least?
> =

> I can add the API for the userspace as well. This would make things
> clearer. Where should I put such a userspace application in the tree?

I'm unsure about putting it into tree at all, see below.

> =

>> ...
>>
>>> diff --git a/ksrc/drivers/mpc5200_dma/rt-fpga.c b/ksrc/drivers/mpc5200_=
dma/rt-fpga.c
>>> new file mode 100644
>>> index 0000000..70f1827
>>> --- /dev/null
>>> +++ b/ksrc/drivers/mpc5200_dma/rt-fpga.c
>>> @@ -0,0 +1,694 @@
>>> +/*
>>> + *  Xenomai RTDM device driver for A3M071 FPGA with interrupt support
>>> + *
>>> + *  Copyright (C) 2012 Stefan Roese <sr@denx.de>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + */
>>> +
>>> +#include <linux/device.h>
>>> +#include <linux/errno.h>
>>> +#include <linux/init.h>
>>> +#include <linux/interrupt.h>
>>> +#include <linux/io.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/types.h>
>>> +#include <linux/uaccess.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include <asm/mpc52xx.h>
>>> +
>>> +/* Xenomai headers */
>>> +#include <native/timer.h>
>>> +#include <rtdm/rtdm_driver.h>
>>> +
>>> +#include "rt-fpga.h"
>>> +
>>> +extern int rt_mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_request *r=
eq);
>>> +extern void rt_mpc52xx_lpbfifo_abort(struct mpc52xx_lpbfifo_request *r=
eq);
>>
>> Err, no. These two functions define the interface of the lpbfifo? Then
>> they belong into a header file.
> =

> Right. Will move those declarations.
> =

>> ...
>>
>>> diff --git a/ksrc/drivers/mpc5200_dma/rt-fpga.h b/ksrc/drivers/mpc5200_=
dma/rt-fpga.h
>>> new file mode 100644
>>> index 0000000..f25cf2e
>>> --- /dev/null
>>> +++ b/ksrc/drivers/mpc5200_dma/rt-fpga.h
>>
>> Wrong place for a user header -> include/rtdm.
> =

> Okay.
> =

>>> @@ -0,0 +1,35 @@
>>> +/*
>>> + *  Xenomai RTDM device driver for A3M071 FPGA with interrupt support
>>
>> Does this driver depend on a specific programming of that FPGA?
> =

> Yes. As mentioned in the commit text, this is a specific custom design
> with a "specific" FPGA image. Not really usable for most Xenomai
> developers/users as is. But I think it might be a good example on how to
> implement such a thing. And implementing the RT DMA framework for the
> MPC5200.

So, basically no one will be able to run your special test case. Is
there any other use case, even an artificial one, for DMA on the MPC5200
that can be run without the special FPGA setup? Otherwise, it might be
more helpful to provide a very basic example for the RT DMA API usage as
pseudo code.

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20121122/0d487dc=
d/attachment.pgp>
