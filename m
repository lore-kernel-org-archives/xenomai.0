Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A33A46BA
	for <xenomai@lists.linux.dev>; Wed,  3 Aug 2022 21:13:50 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id gk3so21422299ejb.8
        for <xenomai@lists.linux.dev>; Wed, 03 Aug 2022 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neuraldsp-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=tYIrkK7cxpw5gXqO3zh5mHePQyLJS4h1bhsGENLe9/w=;
        b=Q973EvRyjJoBZqffk8iP/oNlyo75oRfwgObCWsoausC/a3+ojKBOZIpNmtvpMr+jXp
         GUBHIYFFo5kiq9vElo+WbvlyZXzRY49vd4cdjl3nIKjpuojnr2VvNTQ1qRn+Q/zrZ/pL
         oUOF3dDpaBquTYMhMIX5HNxnYsAypmhALKlfi5L+oin29XIMtb3V5mDK1WgQwswPNEjC
         fFZWseGY2WkaEyxVOVmTLBS1gyLl91W8AR1ulWY5GvyejbZfsPb5PASROzfmhqETVhUY
         WlbyHnOikFsDzU3WFsK0cesBq9q09x7aZlufiMFV7zgiQRGBZvf925MaERZfkVvjRZ1t
         WFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tYIrkK7cxpw5gXqO3zh5mHePQyLJS4h1bhsGENLe9/w=;
        b=ful0T+7CkfROS7mzVVeKPJKB/rgcYm0ZDC6zzgr2ps3/k1ffeVwmZP/Xykg5bsq/6l
         H3ZklPEyz8jo8hRLEY+X3YSQQ5okmJIcEoarK42i4s7K3DEPyW3ahhACii1jWR1/wJgj
         myAAwzjuvKKSIsZkPAAhiOllq0pB1tJjroi8xzYcV3o1Efwvbt8cSWAcP7oepHthTluO
         RlBHbMHC8IjTKuP0JPu43qEGz7dfR4ILkgoQzommJdrnfknHwnEatbm1HsNOfeAXmBam
         Rcpvwljbn5o9h2IsmUjfNn9L/IRmBBALtb7R4iBsrrG41r6rascJ/ZnX6vxKNPxK6DBS
         ObLA==
X-Gm-Message-State: AJIora8lim6WUEnnh4NbWJlYI725DiKeKfYFKeunszFlWjvVHKJ7Z2hP
	iTvKHdtUxQ4hVG0JwGsfTYwC6M/LeJZ9UCuD/sQNslxaOTfP2A==
X-Google-Smtp-Source: AGRyM1sMODS97a3r2vQnjiZ/247rgwLK3fi1/NmwI3X5oPq2/TzfKo2iyjT2eLcPu62Gto3D/Y4HwRTC3l8tib7QZ3c=
X-Received: by 2002:a17:907:728f:b0:72f:1d6e:87e with SMTP id
 dt15-20020a170907728f00b0072f1d6e087emr22405029ejc.704.1659561228285; Wed, 03
 Aug 2022 14:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Gabriel Durante <gabriel@neuraldsp.com>
Date: Wed, 3 Aug 2022 18:13:37 -0300
Message-ID: <CAANaHT-rev__mHn3geXCSz0yM0VJBkZjidrNoZQfEi8s6e-T8w@mail.gmail.com>
Subject: Xenomai 4 IMX8MM
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm using linux-evl from v5.18-evl3-rebase
(e62dfc7884fc99bb3bfe5cdd0d69f99b5616d30e)

Everything works fine with evl check, evl test, hectic and latmus
except with sched-quota-accuracy test which kernel hangs (all other
tests are ok):

[ 2341.500412] edt_ft5x06 2-0038: Unable to fetch data, error: -110

Apart of that, I'm getting an irq chip not pipeline-safe, even the
driver setting it; gpio-mxc.c IRQCHIP_PIPELINE_SAFE:

[    1.742046] ------------[ cut here ]------------
[    1.742053] irqchip 1-0020 is not pipeline-safe!
[    1.742079] WARNING: CPU: 3 PID: 1 at kernel/irq/chip.c:52
irq_set_chip+0xc0/0xdc
[    1.742100] Modules linked in:
[    1.742111] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.18.0 #1
[    1.742117] Hardware name: Variscite VAR-SOM-MX8MM Symphony
evaluation board (DT)
[    1.742121] IRQ stage: Linux
[    1.742125] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.742133] pc : irq_set_chip+0xc0/0xdc
[    1.742141] lr : irq_set_chip+0xc0/0xdc
[    1.742147] sp : ffff8000096db950
[    1.742150] x29: ffff8000096db950 x28: ffff00007fc05168 x27: ffff0000023e50b0
[    1.742160] x26: 0000000000000000 x25: ffff0000023e5080 x24: ffff8000095727d0
[    1.742170] x23: 00000000000000dd x22: 0000000000000000 x21: ffff000002090000
[    1.742179] x20: ffff0000035f48f0 x19: ffff0000023e5200 x18: 0000000000000030
[    1.742188] x17: 00000000c03e3109 x16: 0000000067c91974 x15: fffffffffffe4120
[    1.742196] x14: ffffffffffffffff x13: 21656661732d656e x12: 696c657069702074
[    1.742205] x11: ffff8000095020b0 x10: 2d2d2d2d2d2d2d2d x9 : ffff8000096db950
[    1.742214] x8 : ffff800009502068 x7 : ffff8000096db800 x6 : ffff8000096db800
[    1.742223] x5 : ffff00007fba6a50 x4 : 0000000000000000 x3 : 0000000000000027
[    1.742232] x2 : 0000000000000023 x1 : 17f73e9a6bbe4000 x0 : 0000000000000000
[    1.742242] Call trace:
[    1.742245]  irq_set_chip+0xc0/0xdc
[    1.742253]  irq_set_chip_and_handler_name+0x34/0x9c
[    1.742262]  gpiochip_irq_map+0x54/0x110
[    1.742272]  irq_domain_associate+0x7c/0x1f0
[    1.742280]  irq_create_mapping_affinity+0xe8/0x140
[    1.742287]  gpiochip_to_irq+0xac/0xc4
[    1.742293]  gpiod_to_irq+0x54/0x90
[    1.742299]  gpio_keys_probe+0x544/0x984
[    1.742308]  platform_probe+0x68/0xe0
[    1.742316]  really_probe.part.0+0x9c/0x29c
[    1.742326]  __driver_probe_device+0x98/0x144
[    1.742333]  driver_probe_device+0xac/0x140
[    1.742340]  __driver_attach+0xf8/0x190
[    1.742347]  bus_for_each_dev+0x70/0xc0
[    1.742356]  driver_attach+0x24/0x30
[    1.742363]  bus_add_driver+0x14c/0x1f0
[    1.742369]  driver_register+0x78/0x130
[    1.742377]  __platform_driver_register+0x28/0x34
[    1.742386]  gpio_keys_init+0x1c/0x28
[    1.742397]  do_one_initcall+0x54/0x1bc
[    1.742404]  kernel_init_freeable+0x210/0x294
[    1.742414]  kernel_init+0x28/0x13c
[    1.742424]  ret_from_fork+0x10/0x20
[    1.742431] ---[ end trace 0000000000000000 ]---

cmdline isolcpus=1 evl.oob_cpus=1

Also tried with LTS version (v5.15.57-evl1-rebase
b693debdc082dcde2c0071c371f6e58e1702f360)
Same behavior

Any hints ?

Thanks
Regards
Gabriel
