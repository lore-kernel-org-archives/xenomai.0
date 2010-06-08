From: Sebastian Smolorz <smolorz@domain.hid>
Date: Tue, 8 Jun 2010 16:14:54 +0200
References: <20100608135425.99830@domain.hid>
In-Reply-To: <20100608135425.99830@domain.hid>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201006081614.54946.smolorz@domain.hid>
Subject: Re: [Xenomai-help] xeno_can_mem driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nils Armbruster <nils-a@domain.hid>
Cc: xenomai@xenomai.org

Nils Armbruster wrote:
> I'm currently trying to get the can-interfaces of an Samsung S3C2440
>  based board working (NetDCU10). The used Linux kernel version is 2.6.19,
>  because this was deliverd in the BSP. I patched this kernel with Xenomai
>  2.4.0., as this was the newest Version I managed the Kernel to compile
>  with.
> 
> The standard driver delivered with the board (lincan 0.3.3) mappes the
>  can devices to 10000000-10000007 : onboard-can
> 10000008-1000000f :
> onboard-can

Hmm, the SJA1000 has 32 registers, not just 8.

> So I tried to use the driver xeno_can_mem.
> 
> I use
> modprobe xen_can_mem mem=0x10000000 irq=17 clock=48000000

Are you sure you give the right clock frequency? Seems to be too high.

> to install the module but it complains that there is no such device...
> 
> As far as I know, this board uses the an sja1000p chip for can. Do you
>  know if there are any differences to the sja1000 chip? Are there any
>  changes necessary in the driver sources?
> 
> I figured out, that the installation of the driver stops in the function
>  int rtcan_sja1000_register(struct rtcan_device *dev) And there in that
>  part:
> 
>     printk("chip->read_reg(dev, SJA_SR) = %d \n",chip->read_reg(dev,
>  SJA_SR)); if ((chip->read_reg(dev, SJA_SR) &
> 	 (SJA_SR_RBS | SJA_SR_DOS | SJA_SR_TBS)) != SJA_SR_TBS) {
> 	printk("ERROR! No SJA1000 device found!\n");
> 	return -ENODEV;
>     }
> 
> When I comment this out the installation works and in /proc/iomem
>  sja1000-mem is visible. But I'm not able to send Can-messages with
>  rtcansen.
> The program seems to work, but no messages are send as I checked it with
>  a scope.

There is no point in commenting out the driver's check for the existence of 
the SJA1000 and complain that it does not work. This check is there for a 
good reason.

> 
> Does anybody have an hint for me, how to get the can driver working?

First find out where the 32 registers of the SJA1000 are mapped and also 
check the clock frequency.

-- 
Sebastian

