Message-ID: <497A1AA0.9050905@domain.hid>
Date: Fri, 23 Jan 2009 20:29:36 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4979727E.6060304@domain.hid>
In-Reply-To: <4979727E.6060304@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] PowerPC irq unmask
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: federico.ridolfo@domain.hid
Cc: xenomai@xenomai.org

Federico Ridolfo wrote:
> Hi all,
> my platform is a mpc5200b based one. I wrote
> some rtdm driver for that platform on linux-2.6.18
> kernel. Some info:
> - ARCH=ppc
> - no fdt (so no dts)
> - u-boot
> - xenomai 2.3.2,
> - adeos-ipipe-2.6.18-ppc-1.5-01.patch
> All works fine.
> 
> Now i want to use:
> - ARCH = powerpc
> - linux kernel from denx: ipipe-2.6-26-powerpc-2.4-03
> - fdt (so i have a dts file)
> - xenomai-2.4.6.1
> - u-boot
> Ok. My board boots, all peripheral s work. Xenomai works, but
> my rtdm drivers don't work. The problem is that the rtdm_irq_request
> returns -ENODEV coming from line 166 in wrappers.h:

Just to be sure. Are you using OF functions to retrieve the IRQ number?
It's mandetory! Otherwise the interrupt is not known to the system. Just
using the IRQ number does not work any more. You can find various
examples in the kernel how to get and map OF resources, e.g.:

http://lxr.linux.no/linux+v2.6.28.1/drivers/net/fec_mpc52xx.c#L975

And of course, you need proper interrupt definitions in your DTS file.

Wolfgang.

