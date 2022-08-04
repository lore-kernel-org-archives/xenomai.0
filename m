Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28449256C
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 12:44:46 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id A819EE000C;
	Thu,  4 Aug 2022 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1659617084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvuSryDgsgTyT43vZnXL7oy4JuZxFFX9ZO2Lky9px48=;
	b=YP4GRuOnSjwwJhd9NWpZ78kO3SK2db4Fz5BJZ5Cgd8Sfcbg9W9WWRKJ0p5ofLBPWTnpF88
	Y8HXxKXxnU18Zb+yyURPO7ZgiqYvNBL/G+suzPd+65aehpzkemY4R5+HJZjCWH/dh7UKpd
	Lk47umWgIX3p0CTsijDmgZmvqtSMNO3X2isn8LXLSz/0iU5BiOzh/yOqfWG3LBwi6shTOa
	Yt1iWWx7Cr0NEUKUDI7y9nlT+gRLXOOZL/r++1c0P1SlVnPGhra54WC5B8R3JFP0HjRR8U
	um3W/OMTHsoCk+fEnbJ7quidLOFlN/GX1x/k5h6ZVe2DidW1pNNq2lwcF2bLNw==
References: <CAANaHT-rev__mHn3geXCSz0yM0VJBkZjidrNoZQfEi8s6e-T8w@mail.gmail.com>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Gabriel Durante <gabriel@neuraldsp.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Xenomai 4 IMX8MM
Date: Thu, 04 Aug 2022 14:44:09 +0200
In-reply-to: <CAANaHT-rev__mHn3geXCSz0yM0VJBkZjidrNoZQfEi8s6e-T8w@mail.gmail.com>
Message-ID: <87bkt0yy85.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Gabriel Durante <gabriel@neuraldsp.com> writes:

> Hi,
>
> I'm using linux-evl from v5.18-evl3-rebase
> (e62dfc7884fc99bb3bfe5cdd0d69f99b5616d30e)
>
> Everything works fine with evl check, evl test, hectic and latmus
> except with sched-quota-accuracy test which kernel hangs (all other
> tests are ok):
>
> [ 2341.500412] edt_ft5x06 2-0038: Unable to fetch data, error: -110
>
> Apart of that, I'm getting an irq chip not pipeline-safe, even the
> driver setting it; gpio-mxc.c IRQCHIP_PIPELINE_SAFE:
>
> [    1.742046] ------------[ cut here ]------------
> [    1.742053] irqchip 1-0020 is not pipeline-safe!
> [    1.742079] WARNING: CPU: 3 PID: 1 at kernel/irq/chip.c:52
> irq_set_chip+0xc0/0xdc
> [    1.742100] Modules linked in:
> [    1.742111] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.18.0 #1
> [    1.742117] Hardware name: Variscite VAR-SOM-MX8MM Symphony
> evaluation board (DT)
> [    1.742121] IRQ stage: Linux
> [    1.742125] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.742133] pc : irq_set_chip+0xc0/0xdc
> [    1.742141] lr : irq_set_chip+0xc0/0xdc
> [    1.742147] sp : ffff8000096db950
> [    1.742150] x29: ffff8000096db950 x28: ffff00007fc05168 x27: ffff0000023e50b0
> [    1.742160] x26: 0000000000000000 x25: ffff0000023e5080 x24: ffff8000095727d0
> [    1.742170] x23: 00000000000000dd x22: 0000000000000000 x21: ffff000002090000
> [    1.742179] x20: ffff0000035f48f0 x19: ffff0000023e5200 x18: 0000000000000030
> [    1.742188] x17: 00000000c03e3109 x16: 0000000067c91974 x15: fffffffffffe4120
> [    1.742196] x14: ffffffffffffffff x13: 21656661732d656e x12: 696c657069702074
> [    1.742205] x11: ffff8000095020b0 x10: 2d2d2d2d2d2d2d2d x9 : ffff8000096db950
> [    1.742214] x8 : ffff800009502068 x7 : ffff8000096db800 x6 : ffff8000096db800
> [    1.742223] x5 : ffff00007fba6a50 x4 : 0000000000000000 x3 : 0000000000000027
> [    1.742232] x2 : 0000000000000023 x1 : 17f73e9a6bbe4000 x0 : 0000000000000000
> [    1.742242] Call trace:
> [    1.742245]  irq_set_chip+0xc0/0xdc
> [    1.742253]  irq_set_chip_and_handler_name+0x34/0x9c
> [    1.742262]  gpiochip_irq_map+0x54/0x110
> [    1.742272]  irq_domain_associate+0x7c/0x1f0
> [    1.742280]  irq_create_mapping_affinity+0xe8/0x140
> [    1.742287]  gpiochip_to_irq+0xac/0xc4
> [    1.742293]  gpiod_to_irq+0x54/0x90
> [    1.742299]  gpio_keys_probe+0x544/0x984
> [    1.742308]  platform_probe+0x68/0xe0
> [    1.742316]  really_probe.part.0+0x9c/0x29c
> [    1.742326]  __driver_probe_device+0x98/0x144
> [    1.742333]  driver_probe_device+0xac/0x140
> [    1.742340]  __driver_attach+0xf8/0x190
> [    1.742347]  bus_for_each_dev+0x70/0xc0
> [    1.742356]  driver_attach+0x24/0x30
> [    1.742363]  bus_add_driver+0x14c/0x1f0
> [    1.742369]  driver_register+0x78/0x130
> [    1.742377]  __platform_driver_register+0x28/0x34
> [    1.742386]  gpio_keys_init+0x1c/0x28
> [    1.742397]  do_one_initcall+0x54/0x1bc
> [    1.742404]  kernel_init_freeable+0x210/0x294
> [    1.742414]  kernel_init+0x28/0x13c
> [    1.742424]  ret_from_fork+0x10/0x20
> [    1.742431] ---[ end trace 0000000000000000 ]---
>
> cmdline isolcpus=1 evl.oob_cpus=1
>
> Also tried with LTS version (v5.15.57-evl1-rebase
> b693debdc082dcde2c0071c371f6e58e1702f360)
> Same behavior
>
> Any hints ?
>
> Thanks
> Regards
> Gabriel


Gabriel Durante <gabriel@neuraldsp.com> writes:

> Hi,
>
> I'm using linux-evl from v5.18-evl3-rebase
> (e62dfc7884fc99bb3bfe5cdd0d69f99b5616d30e)
>
> Everything works fine with evl check, evl test, hectic and latmus
> except with sched-quota-accuracy test which kernel hangs (all other
> tests are ok):
>
> [ 2341.500412] edt_ft5x06 2-0038: Unable to fetch data, error: -110
>
> Apart of that, I'm getting an irq chip not pipeline-safe, even the
> driver setting it; gpio-mxc.c IRQCHIP_PIPELINE_SAFE:
>
> [    1.742046] ------------[ cut here ]------------
> [    1.742053] irqchip 1-0020 is not pipeline-safe!
> [    1.742079] WARNING: CPU: 3 PID: 1 at kernel/irq/chip.c:52
> irq_set_chip+0xc0/0xdc
> [    1.742100] Modules linked in:
> [    1.742111] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.18.0 #1
> [    1.742117] Hardware name: Variscite VAR-SOM-MX8MM Symphony
> evaluation board (DT)
> [    1.742121] IRQ stage: Linux
> [    1.742125] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    1.742133] pc : irq_set_chip+0xc0/0xdc
> [    1.742141] lr : irq_set_chip+0xc0/0xdc
> [    1.742147] sp : ffff8000096db950
> [    1.742150] x29: ffff8000096db950 x28: ffff00007fc05168 x27: ffff0000023e50b0
> [    1.742160] x26: 0000000000000000 x25: ffff0000023e5080 x24: ffff8000095727d0
> [    1.742170] x23: 00000000000000dd x22: 0000000000000000 x21: ffff000002090000
> [    1.742179] x20: ffff0000035f48f0 x19: ffff0000023e5200 x18: 0000000000000030
> [    1.742188] x17: 00000000c03e3109 x16: 0000000067c91974 x15: fffffffffffe4120
> [    1.742196] x14: ffffffffffffffff x13: 21656661732d656e x12: 696c657069702074
> [    1.742205] x11: ffff8000095020b0 x10: 2d2d2d2d2d2d2d2d x9 : ffff8000096db950
> [    1.742214] x8 : ffff800009502068 x7 : ffff8000096db800 x6 : ffff8000096db800
> [    1.742223] x5 : ffff00007fba6a50 x4 : 0000000000000000 x3 : 0000000000000027
> [    1.742232] x2 : 0000000000000023 x1 : 17f73e9a6bbe4000 x0 : 0000000000000000
> [    1.742242] Call trace:
> [    1.742245]  irq_set_chip+0xc0/0xdc
> [    1.742253]  irq_set_chip_and_handler_name+0x34/0x9c
> [    1.742262]  gpiochip_irq_map+0x54/0x110
> [    1.742272]  irq_domain_associate+0x7c/0x1f0
> [    1.742280]  irq_create_mapping_affinity+0xe8/0x140
> [    1.742287]  gpiochip_to_irq+0xac/0xc4
> [    1.742293]  gpiod_to_irq+0x54/0x90
> [    1.742299]  gpio_keys_probe+0x544/0x984
> [    1.742308]  platform_probe+0x68/0xe0
> [    1.742316]  really_probe.part.0+0x9c/0x29c
> [    1.742326]  __driver_probe_device+0x98/0x144
> [    1.742333]  driver_probe_device+0xac/0x140
> [    1.742340]  __driver_attach+0xf8/0x190
> [    1.742347]  bus_for_each_dev+0x70/0xc0
> [    1.742356]  driver_attach+0x24/0x30
> [    1.742363]  bus_add_driver+0x14c/0x1f0
> [    1.742369]  driver_register+0x78/0x130
> [    1.742377]  __platform_driver_register+0x28/0x34
> [    1.742386]  gpio_keys_init+0x1c/0x28
> [    1.742397]  do_one_initcall+0x54/0x1bc
> [    1.742404]  kernel_init_freeable+0x210/0x294
> [    1.742414]  kernel_init+0x28/0x13c
> [    1.742424]  ret_from_fork+0x10/0x20
> [    1.742431] ---[ end trace 0000000000000000 ]---
>
> cmdline isolcpus=1 evl.oob_cpus=1
>
> Also tried with LTS version (v5.15.57-evl1-rebase
> b693debdc082dcde2c0071c371f6e58e1702f360)
> Same behavior

This looks like the name of an i2c device (1-0020), which would be the
client of a GPIO key interface. dts says your evb has a pca9534 GPIO
expander on board. Welcome to the maze. This expander is a no-brainer
wrt IRQ pipelining though, so let's try this:

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 33683295a0bf..03ba6386b9bd 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -853,6 +853,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	irq_chip->irq_bus_sync_unlock = pca953x_irq_bus_sync_unlock;
 	irq_chip->irq_set_type = pca953x_irq_set_type;
 	irq_chip->irq_shutdown = pca953x_irq_shutdown;
+	irq_chip->flags = IRQCHIP_PIPELINE_SAFE;
 
 	girq = &chip->gpio_chip.irq;
 	girq->chip = irq_chip;

Please let me know if that helps.

Thanks,

-- 
Philippe.
