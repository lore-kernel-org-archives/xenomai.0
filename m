Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC22570
	for <xenomai@lists.linux.dev>; Thu,  4 Aug 2022 13:41:06 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id z2so14999647edc.1
        for <xenomai@lists.linux.dev>; Thu, 04 Aug 2022 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neuraldsp-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlIlgR4OvBueOoChMyR0FOcsCFC6zfMivFucNSFIevg=;
        b=GrTnLypm6n5wt4Y3M36gvCAIQ5cZHiGoBJ4i9brMSpaJ4a4TaOCXXo5blUJb+l7YPF
         eTs3L7kxpndWAKjihraVQ900dii4gs9EszOcPGOfhoonjbPLj8Nf0CzMV2EbL0NBHiQm
         u13bC4OFHUQU/SyEPXWi32WLEasygnvzMBRhjUf63PyCQdkRrZIz1+3bQGWUL3KwhQsC
         EhFYU8bQRsSCR6lvtwRVGCM+eDaWjqmTXs37khybVSyaxs/AoDa5Sm0G9bk6xNbxXI2i
         1aoDTHynijWDkJsFNc/ji4mey74gnpD26vIo5k9YycVZq2ZfC56Xug6xHIrQsf7qeqmC
         YgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlIlgR4OvBueOoChMyR0FOcsCFC6zfMivFucNSFIevg=;
        b=EURW26jEpzkNSJ1zHXxadeckh4+LVp80/suNQC32eHpRUEwSLUsl0rpMBIXMwalimk
         cU556j0cdx8AmjwULGVQDe96tt6fZ73qLe0tJBW+nHPUPsevFw/etzmQgXv3cnuWt+Da
         R197PNgqyDzl5jcZ2AQ/0J4L4j1z/zzeopHvYrJIPyR4v9TwOWCSThnn3BX3mxzBlPjH
         JnwBq6oqrqqi/o0XtPQQk+O/wPYBw5a5ETQw0Uq5GeNA+i+dnwqUISj6yWwp6+qRWM9g
         u5TVad4RTl/9/nNuP8KdTpts5ESlAHJTjOoK9GSYtpPaYMeJeSdY1tLnwhdv0+2aeiJZ
         wfrw==
X-Gm-Message-State: ACgBeo38wr7UE0pjLIi7GsbTeIi8BMuyloim968TPCOi6sdrE3s757sj
	MzTG1Cg0q1Gj0YGnpuCzB7kbh4OLhtIQhlFQc1Hjq5KA+qncoA==
X-Google-Smtp-Source: AA6agR6qTNCHYFaMciyHIQtUI5nj1NigykL3mHC2K8KRwALLW3TJAR8XLrCle0BsGOPzwNu4AoAUQyGqWsUp6WYARz4=
X-Received: by 2002:a05:6402:35d5:b0:43d:a02f:cbfb with SMTP id
 z21-20020a05640235d500b0043da02fcbfbmr1987872edc.275.1659620464959; Thu, 04
 Aug 2022 06:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAANaHT-rev__mHn3geXCSz0yM0VJBkZjidrNoZQfEi8s6e-T8w@mail.gmail.com>
 <87bkt0yy85.fsf@xenomai.org>
In-Reply-To: <87bkt0yy85.fsf@xenomai.org>
From: Gabriel Durante <gabriel@neuraldsp.com>
Date: Thu, 4 Aug 2022 10:40:54 -0300
Message-ID: <CAANaHT9E=73w7_sOugpw7JBToTzfRtDy+aTeW5HgPKZjB_rKQQ@mail.gmail.com>
Subject: Re: Xenomai 4 IMX8MM
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Thanks Philippe,

IRQCHIP_PIPELINE_SAFE flag on gpio-pca953x.c did the trick, no issues on dmesg.

Now only the issue (kernel hangs) with edt_ft5x06 loaded while running
sched-quota-accuracy.

[ 2341.500412] edt_ft5x06 2-0038: Unable to fetch data, error: -110

If rmmod edt_ft5x06, all tests work fine.

basic-xbuf: OK
clock-timer-periodic: OK
clone-fork-exec: OK
detach-self: OK
duplicate-element: OK
element-visibility: OK
fault: OK
fpu-preload: OK
fpu-stress: OK
heap-torture: OK
mapfd: OK
monitor-deadlock: OK
monitor-event: OK
monitor-flags: OK
monitor-pi: OK
monitor-pi-deadlock: OK
monitor-pp-dynamic: OK
monitor-pp-lower: OK
monitor-pp-nested: OK
monitor-pp-pi: OK
monitor-pp-raise: OK
monitor-pp-tryenter: OK
monitor-pp-weak: OK
monitor-steal: OK
monitor-wait-multiple: OK
observable-hm: OK
observable-inband: OK
observable-master: OK
observable-onchange: OK
observable-oob: OK
observable-race: OK
observable-thread: OK
poll-close: OK
poll-flags: OK
poll-many: OK
poll-multiple: OK
poll-nested: OK
poll-observable-inband: OK
poll-observable-oob: OK
poll-sem: OK
poll-xbuf: OK
proxy-echo: OK
proxy-eventfd: OK
proxy-pipe: OK
proxy-poll: OK
sched-quota-accuracy: OK
sched-tp-accuracy: OK
sem-close-unblock: OK
sem-timedwait: OK
sem-wait: OK
simple-clone: OK
stax-lock: OK
stax-warn: OK
thread-mode-bits: OK
clock-timer-periodic.eshi: OK
detach-self.eshi: OK
heap-torture.eshi: OK
monitor-event.eshi: OK
monitor-flags.eshi: OK
monitor-wait-multiple.eshi: OK
poll-nested.eshi: OK
poll-sem.eshi: OK
proxy-eventfd.eshi: OK
proxy-pipe.eshi: OK
sem-timedwait.eshi: OK
sem-wait.eshi: OK

Thanks
Regards
Gabriel

On Thu, Aug 4, 2022 at 9:44 AM Philippe Gerum <rpm@xenomai.org> wrote:
>
>
> Gabriel Durante <gabriel@neuraldsp.com> writes:
>
> > Hi,
> >
> > I'm using linux-evl from v5.18-evl3-rebase
> > (e62dfc7884fc99bb3bfe5cdd0d69f99b5616d30e)
> >
> > Everything works fine with evl check, evl test, hectic and latmus
> > except with sched-quota-accuracy test which kernel hangs (all other
> > tests are ok):
> >
> > [ 2341.500412] edt_ft5x06 2-0038: Unable to fetch data, error: -110
> >
> > Apart of that, I'm getting an irq chip not pipeline-safe, even the
> > driver setting it; gpio-mxc.c IRQCHIP_PIPELINE_SAFE:
> >
> > [    1.742046] ------------[ cut here ]------------
> > [    1.742053] irqchip 1-0020 is not pipeline-safe!
> > [    1.742079] WARNING: CPU: 3 PID: 1 at kernel/irq/chip.c:52
> > irq_set_chip+0xc0/0xdc
> > [    1.742100] Modules linked in:
> > [    1.742111] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.18.0 #1
> > [    1.742117] Hardware name: Variscite VAR-SOM-MX8MM Symphony
> > evaluation board (DT)
> > [    1.742121] IRQ stage: Linux
> > [    1.742125] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    1.742133] pc : irq_set_chip+0xc0/0xdc
> > [    1.742141] lr : irq_set_chip+0xc0/0xdc
> > [    1.742147] sp : ffff8000096db950
> > [    1.742150] x29: ffff8000096db950 x28: ffff00007fc05168 x27: ffff0000023e50b0
> > [    1.742160] x26: 0000000000000000 x25: ffff0000023e5080 x24: ffff8000095727d0
> > [    1.742170] x23: 00000000000000dd x22: 0000000000000000 x21: ffff000002090000
> > [    1.742179] x20: ffff0000035f48f0 x19: ffff0000023e5200 x18: 0000000000000030
> > [    1.742188] x17: 00000000c03e3109 x16: 0000000067c91974 x15: fffffffffffe4120
> > [    1.742196] x14: ffffffffffffffff x13: 21656661732d656e x12: 696c657069702074
> > [    1.742205] x11: ffff8000095020b0 x10: 2d2d2d2d2d2d2d2d x9 : ffff8000096db950
> > [    1.742214] x8 : ffff800009502068 x7 : ffff8000096db800 x6 : ffff8000096db800
> > [    1.742223] x5 : ffff00007fba6a50 x4 : 0000000000000000 x3 : 0000000000000027
> > [    1.742232] x2 : 0000000000000023 x1 : 17f73e9a6bbe4000 x0 : 0000000000000000
> > [    1.742242] Call trace:
> > [    1.742245]  irq_set_chip+0xc0/0xdc
> > [    1.742253]  irq_set_chip_and_handler_name+0x34/0x9c
> > [    1.742262]  gpiochip_irq_map+0x54/0x110
> > [    1.742272]  irq_domain_associate+0x7c/0x1f0
> > [    1.742280]  irq_create_mapping_affinity+0xe8/0x140
> > [    1.742287]  gpiochip_to_irq+0xac/0xc4
> > [    1.742293]  gpiod_to_irq+0x54/0x90
> > [    1.742299]  gpio_keys_probe+0x544/0x984
> > [    1.742308]  platform_probe+0x68/0xe0
> > [    1.742316]  really_probe.part.0+0x9c/0x29c
> > [    1.742326]  __driver_probe_device+0x98/0x144
> > [    1.742333]  driver_probe_device+0xac/0x140
> > [    1.742340]  __driver_attach+0xf8/0x190
> > [    1.742347]  bus_for_each_dev+0x70/0xc0
> > [    1.742356]  driver_attach+0x24/0x30
> > [    1.742363]  bus_add_driver+0x14c/0x1f0
> > [    1.742369]  driver_register+0x78/0x130
> > [    1.742377]  __platform_driver_register+0x28/0x34
> > [    1.742386]  gpio_keys_init+0x1c/0x28
> > [    1.742397]  do_one_initcall+0x54/0x1bc
> > [    1.742404]  kernel_init_freeable+0x210/0x294
> > [    1.742414]  kernel_init+0x28/0x13c
> > [    1.742424]  ret_from_fork+0x10/0x20
> > [    1.742431] ---[ end trace 0000000000000000 ]---
> >
> > cmdline isolcpus=1 evl.oob_cpus=1
> >
> > Also tried with LTS version (v5.15.57-evl1-rebase
> > b693debdc082dcde2c0071c371f6e58e1702f360)
> > Same behavior
> >
> > Any hints ?
> >
> > Thanks
> > Regards
> > Gabriel
>
>
> Gabriel Durante <gabriel@neuraldsp.com> writes:
>
> > Hi,
> >
> > I'm using linux-evl from v5.18-evl3-rebase
> > (e62dfc7884fc99bb3bfe5cdd0d69f99b5616d30e)
> >
> > Everything works fine with evl check, evl test, hectic and latmus
> > except with sched-quota-accuracy test which kernel hangs (all other
> > tests are ok):
> >
> > [ 2341.500412] edt_ft5x06 2-0038: Unable to fetch data, error: -110
> >
> > Apart of that, I'm getting an irq chip not pipeline-safe, even the
> > driver setting it; gpio-mxc.c IRQCHIP_PIPELINE_SAFE:
> >
> > [    1.742046] ------------[ cut here ]------------
> > [    1.742053] irqchip 1-0020 is not pipeline-safe!
> > [    1.742079] WARNING: CPU: 3 PID: 1 at kernel/irq/chip.c:52
> > irq_set_chip+0xc0/0xdc
> > [    1.742100] Modules linked in:
> > [    1.742111] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.18.0 #1
> > [    1.742117] Hardware name: Variscite VAR-SOM-MX8MM Symphony
> > evaluation board (DT)
> > [    1.742121] IRQ stage: Linux
> > [    1.742125] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    1.742133] pc : irq_set_chip+0xc0/0xdc
> > [    1.742141] lr : irq_set_chip+0xc0/0xdc
> > [    1.742147] sp : ffff8000096db950
> > [    1.742150] x29: ffff8000096db950 x28: ffff00007fc05168 x27: ffff0000023e50b0
> > [    1.742160] x26: 0000000000000000 x25: ffff0000023e5080 x24: ffff8000095727d0
> > [    1.742170] x23: 00000000000000dd x22: 0000000000000000 x21: ffff000002090000
> > [    1.742179] x20: ffff0000035f48f0 x19: ffff0000023e5200 x18: 0000000000000030
> > [    1.742188] x17: 00000000c03e3109 x16: 0000000067c91974 x15: fffffffffffe4120
> > [    1.742196] x14: ffffffffffffffff x13: 21656661732d656e x12: 696c657069702074
> > [    1.742205] x11: ffff8000095020b0 x10: 2d2d2d2d2d2d2d2d x9 : ffff8000096db950
> > [    1.742214] x8 : ffff800009502068 x7 : ffff8000096db800 x6 : ffff8000096db800
> > [    1.742223] x5 : ffff00007fba6a50 x4 : 0000000000000000 x3 : 0000000000000027
> > [    1.742232] x2 : 0000000000000023 x1 : 17f73e9a6bbe4000 x0 : 0000000000000000
> > [    1.742242] Call trace:
> > [    1.742245]  irq_set_chip+0xc0/0xdc
> > [    1.742253]  irq_set_chip_and_handler_name+0x34/0x9c
> > [    1.742262]  gpiochip_irq_map+0x54/0x110
> > [    1.742272]  irq_domain_associate+0x7c/0x1f0
> > [    1.742280]  irq_create_mapping_affinity+0xe8/0x140
> > [    1.742287]  gpiochip_to_irq+0xac/0xc4
> > [    1.742293]  gpiod_to_irq+0x54/0x90
> > [    1.742299]  gpio_keys_probe+0x544/0x984
> > [    1.742308]  platform_probe+0x68/0xe0
> > [    1.742316]  really_probe.part.0+0x9c/0x29c
> > [    1.742326]  __driver_probe_device+0x98/0x144
> > [    1.742333]  driver_probe_device+0xac/0x140
> > [    1.742340]  __driver_attach+0xf8/0x190
> > [    1.742347]  bus_for_each_dev+0x70/0xc0
> > [    1.742356]  driver_attach+0x24/0x30
> > [    1.742363]  bus_add_driver+0x14c/0x1f0
> > [    1.742369]  driver_register+0x78/0x130
> > [    1.742377]  __platform_driver_register+0x28/0x34
> > [    1.742386]  gpio_keys_init+0x1c/0x28
> > [    1.742397]  do_one_initcall+0x54/0x1bc
> > [    1.742404]  kernel_init_freeable+0x210/0x294
> > [    1.742414]  kernel_init+0x28/0x13c
> > [    1.742424]  ret_from_fork+0x10/0x20
> > [    1.742431] ---[ end trace 0000000000000000 ]---
> >
> > cmdline isolcpus=1 evl.oob_cpus=1
> >
> > Also tried with LTS version (v5.15.57-evl1-rebase
> > b693debdc082dcde2c0071c371f6e58e1702f360)
> > Same behavior
>
> This looks like the name of an i2c device (1-0020), which would be the
> client of a GPIO key interface. dts says your evb has a pca9534 GPIO
> expander on board. Welcome to the maze. This expander is a no-brainer
> wrt IRQ pipelining though, so let's try this:
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 33683295a0bf..03ba6386b9bd 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -853,6 +853,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
>         irq_chip->irq_bus_sync_unlock = pca953x_irq_bus_sync_unlock;
>         irq_chip->irq_set_type = pca953x_irq_set_type;
>         irq_chip->irq_shutdown = pca953x_irq_shutdown;
> +       irq_chip->flags = IRQCHIP_PIPELINE_SAFE;
>
>         girq = &chip->gpio_chip.irq;
>         girq->chip = irq_chip;
>
> Please let me know if that helps.
>
> Thanks,
>
> --
> Philippe.
