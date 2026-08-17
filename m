Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108B3CCFD2
	for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961201; cv=pass; b=Mj+CYba6neailg/jJpvmM2ilG0tN4ylCNChfmJQXw1q86yDjMH4leU6pzq82aREWpru3U9auHzSwS+2bxDnJUzFnC8Zfz9CmyC9N4bE/bPJ90cZAn+uFptbj/g1dQ6KMpwi0RshjPPyATh0LMvhwEaSiZHxF/SnK8CmSrr3ZRHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961201; c=relaxed/simple;
	bh=7A9qL6cKu4CBLf3ZgwDaJ1JIqilUio+gdsN3IfJu1MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzjnYaMjG7p7NaRhekNvYWLKf8veE4yfJn92f0Do2nyTj7zVCCmVndo5FF0m/989aWsYkquCP1Pnu+3GED9ucFD/SmR0OKAB9bvx8JeVUpReH/q51uAfYfTdLAhOTIxN5mzcY3vWPF75Va/HqCgM5fMP4LkQfKQ3l3ilQqFrT14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=V1SVdyMi; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="V1SVdyMi"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so5474843a12.3
        for <xenomai@lists.linux.dev>; Mon, 17 Aug 2026 03:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786961196; cv=none;
        d=google.com; s=arc-20260327;
        b=FoIhCqfT5CTD8iqQ2v0OZUkUSpHk9DPXBP4lAvh/u6+Xevp1xKIRNNdcuO2RJhNop1
         4/+wtcB5WWVvPhbO+ZsMJJOoMyKeEgUE2+VOja58wpaWq4j9F/D1wjdrYP76dJbZZgVE
         RftS6kTRnvyMKNLpXKSpkhrjsHgeiRy/6jBVjnyIhFGx3dAEXgkTOkMTcQryP9JJKqnr
         8S6RqFUBRx9+/7U2uxPQFWyxAAZ5Wkwachi/zSeTNHCOtlc0KPTqnHNi2bVlX0Q1cCog
         cg+a1dEm/Eym5XKyL/0cwr0A6dIf62aPtD9aB6eouT42FU2wLSewkXLeiZ6Iv8CJ15s/
         G6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ltls6ZA/voD7AAfI9Co+BT7udcwtbdF/EKLMzTWZjj0=;
        fh=W/1liw0SRXDVuoV1SK3/Go8rjQ4tT3xz747FHOtjJ8g=;
        b=TjCYgZao09CVvG91bHnEJO4YcBMVMZZ3hZebcPlZv0ttSx4xUFIhPA8jUv/A/0UWok
         WaGMNzCQmzFJQyHZzJ64x7uGb3VafZ1XNV8gz1l6YFjDubwNTsklmeyoYiPvqYm8fWwN
         HtBvIlKV2prvYNGDdbi2QKKM374kxuoiU6astiqfJUnceX/p/ZybNWqw7TTwSsaexHZ5
         YcKpZklDsHXZBwg5ovNLoOp3+xeYT84RKV6+Q/J+U4FCE6CdgbwjfPDzb+Io4oPgL1Fm
         PlFDVxWza6boayCgqRPjPzjRGzI+VjV0GL99HBezv4kziEo9HOuxwA2/321j5CeFqBBh
         UNCg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1786961196; x=1787565996; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ltls6ZA/voD7AAfI9Co+BT7udcwtbdF/EKLMzTWZjj0=;
        b=V1SVdyMivhR2PPBb/tAE2l5FAbdw97lsaMiBut66kbvlZf92C7wtaMSBeRzhIC8WXF
         o50l7GseDdIx6SI08ps3UYGiAqAFOaaoRwXols1nIbDd9uuIQI0jXeoGFta2iadtaIqS
         WWiy34AO6cdzqNEvZ9mO+pvQGLY/5xMUEADVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786961196; x=1787565996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ltls6ZA/voD7AAfI9Co+BT7udcwtbdF/EKLMzTWZjj0=;
        b=ss05RIZXqIoQRn146vi3iYH9wjR2U7i4SJoEs/eKgbdrctyXJY3tOO6uxC9BX6j/hA
         uJZ78SvnRPORObGC6zQgz7m9Z+5CS+JakNyRik+IM+VffFgkSrzu5Abxg8gbyIJdtb6B
         mZPOZ07FlnniFQzKuIcyke/+xq/aEeMyKn8v1SUwmFIN7BQ366Pca9bcTGhZHLD6fVrw
         UG7bGy9FEsfLK9sVVjA2+0LzdQuBtLp4IZL4P7BhE/1dlG/u/Zx6zayrAdK9xSk5cHFb
         pirtXzHgOWlr/lp5gO9oZxmLdzRgdplo6EIWQaiphuja2/ynPJr0Ua9PtGiKwFNFPLWF
         eZtw==
X-Gm-Message-State: AOJu0Yw07WwO+9wf5Gf20pxfefE/9/2W5EXtW18H9FWb+GtVTLUn6VQn
	ME/E7ieGxs+GkOdSkFOxg/AgaO7CY9DvPIzOx69S0P6ejtoH5gyUxZmxWv+5Qrc63QvZ9pLHeWE
	wHnvXSiHNj1qpFA/zx7zAX0GnrnDsqI4HSCebEvVMBib6FhNWLH4TzIJJXNnOzeMSQaQBl02Lkx
	QgXZi2uF9ozIcXgKbhY6pJio0KNGVVgq5sovCocwMNkHVoZNCnqB/BCdLJTRpeVUcrg1NMH9d8x
	DTO87bEEaCqnNMy8c1s7Nka4jJeLyu8PROBEEEBT4Ge2nA4aQ==
X-Gm-Gg: AR+sD13qNa+E1FgZey/333oYZyZRuDPXLjgiCeCoLTOxqvCuaXQyjfKI/r7Eu48+6Oo
	AdAZMUED2DnulZKnWxYLYXQnAnVtAnYjvIWvi75x1iBf1JBXJR0ylqDzduKhApm6U/nQUDQg4+L
	E8kzfHiT376lDzy2BAg6NK0+Joq9figCQD0m/YbhZscZagJMRcOD+KHbYBh5fVVmjwXtDrX/mcj
	uCi/ZS3VAJU/yJZZ8JX31EdFSH7D6Szc+qWlEZgX1XKw7LHqDENNdmC9eAM02eAYJDeb4vQ15st
	LSP0OrBNkzGVvAZQQTD1fh0ZMrzoPNoMTTYxyduQzOG5NAJkUjyqHP5Ly6ai6ysSIFE0vdoxV+q
	7JsUX4XL4i5gq7iyulbBb/04eYFdrf2BPHvAErxNxGxwNj+55onF8XbJSr0gDq3zd
X-Received: by 2002:a05:6402:21c4:b0:6a0:dda3:83db with SMTP id
 4fb4d7f45d1cf-6a38a840dd6mr9065172a12.0.1786961195583; Mon, 17 Aug 2026
 03:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
 <87v799kt2q.fsf@xenomai.org>
In-Reply-To: <87v799kt2q.fsf@xenomai.org>
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Mon, 17 Aug 2026 12:11:18 +0200
X-Gm-Features: AcwNN1U0afKfA12xTv3vSMmoRPv0FzBGh9IRqnvttX_p5DB9mE085JbqEQ6PLYw
Message-ID: <CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Thanks for the reply.

I built and ran the kernel with said options.  It's probably not
conclusive, since the tests passed.  With these options, the kernel
booted all the way into userland (because CONFIG_EVL=3Dn).

See output below.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.18.29-01153-g1e9f8ec43dcd
(ghoogewerf@NLKRLTF0FQR04) (arm-none-linux-gnueabihf-gcc (LMI3D G++
11.4.1-p1) 11.4.1 20240321, GNU ld (LMI3D G++ 11.4.1-p1) 2.40) #4 SMP
PREEMPT EVL Mon Aug 17 11:49:17 CEST 2026
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=3D18c=
5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: Xilinx Zynq
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 750 MiB at 0x11000000
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000003ffff=
fff]
[    0.000000] OF: reserved mem: Reserved memory: No reserved-memory
node in the DT
[    0.000000] percpu: Embedded 12 pages/cpu s19468 r8192 d21492 u49152
[    0.000000] Kernel command line: console=3DttyPS0,115200 cma=3D750M
l2x0_write_through=3D1
[    0.000000] Unknown kernel command line parameters
"l2x0_write_through=3D1", will be passed to user space.
[    0.000000] printk: log buffer data + meta data: 16384 + 51200 =3D 67584=
 bytes
[    0.000000] Dentry cache hash table entries: 32768 (order: 5,
131072 bytes, linear)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536
bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 26214=
4
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D2, N=
odes=3D1
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] slcr mapped to (ptrval)
[    0.000000] L2C: platform provided aux values match the hardware,
so have no effect.  Please remove them.
[    0.000000] L2C-310 erratum 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 D prefetch enabled, offset 9 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x56760001
[    0.000000] IRQ pipeline enabled
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contentio=
n.
[    0.000000] zynq_clock_init: clkc starts at (ptrval)
[    0.000000] Zynq clock init
[    0.000000] ps_clk frequency not specified, using 33 MHz.
[    0.000001] sched_clock: 64 bits at 500MHz, resolution 2ns, wraps
every 4398046511103ns
[    0.000018] clocksource: arm_global_timer: freq: 499999995 Hz,
mask: 0xffffffffffffffff max_cycles: 0xe6a171a037, max_idle_ns:
881590485102 ns
[    0.000043] Switching to timer-based delay loop, resolution 2ns
[    0.000325] Console: colour dummy device 80x30
[    0.000351] Calibrating delay loop (skipped), value calculated
using timer frequency.. 999.99 BogoMIPS (lpj=3D499999)
[    0.000361] CPU: Testing write buffer coherency: ok
[    0.000390] CPU0: Spectre v2: using BPIALL workaround
[    0.000395] pid_max: default: 32768 minimum: 301
[    0.000541] Mount-cache hash table entries: 1024 (order: 0, 4096
bytes, linear)
[    0.000552] Mountpoint-cache hash table entries: 1024 (order: 0,
4096 bytes, linear)
[    0.001231] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.001262] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.002306] Setting up static identity map for 0x100000 - 0x10003c
[    0.002473] rcu: Hierarchical SRCU implementation.
[    0.002478] rcu:     Max phase no-delay instances is 400.
[    0.002999] smp: Bringing up secondary CPUs ...
[    0.003680] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.003731] CPU1: Spectre v2: using BPIALL workaround
[    0.003844] smp: Brought up 1 node, 2 CPUs
[    0.003854] SMP: Total of 2 processors activated (1999.99 BogoMIPS).
[    0.003862] CPU: All CPU(s) started in SVC mode.
[    0.004053] Memory: 256456K/1048576K available (6144K kernel code,
224K rwdata, 1456K rodata, 1024K init, 84K bss, 20992K reserved,
770048K cma-reserved)
[    0.004557] devtmpfs: initialized
[    0.008386] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.008531] clocksource: jiffies: freq: 0 Hz, mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.008552] posixtimers hash table entries: 1024 (order: 1, 8192
bytes, linear)
[    0.008608] futex hash table entries: 512 (32768 bytes on 1 NUMA
nodes, total 32 KiB, linear).
[    0.019015] pinctrl core: initialized pinctrl subsystem
[    0.019919] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.021704] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.022681] thermal_sys: Registered thermal governor 'step_wise'
[    0.024823] /axi/etb@f8801000: Fixed dependency cycle(s) with /replicato=
r
[    0.024940] /axi/tpiu@f8803000: Fixed dependency cycle(s) with /replicat=
or
[    0.024967] /axi/funnel@f8804000: Fixed dependency cycle(s) with
/axi/ptm@f889d000
[    0.024987] /axi/funnel@f8804000: Fixed dependency cycle(s) with
/axi/ptm@f889c000
[    0.025008] /axi/funnel@f8804000: Fixed dependency cycle(s) with /replic=
ator
[    0.025047] /axi/ptm@f889c000: Fixed dependency cycle(s) with
/axi/funnel@f8804000
[    0.025079] /axi/ptm@f889d000: Fixed dependency cycle(s) with
/axi/funnel@f8804000
[    0.027727] /replicator: Fixed dependency cycle(s) with /axi/etb@f880100=
0
[    0.027820] /axi/etb@f8801000: Fixed dependency cycle(s) with /replicato=
r
[    0.028053] /replicator: Fixed dependency cycle(s) with /axi/tpiu@f88030=
00
[    0.028162] /axi/tpiu@f8803000: Fixed dependency cycle(s) with /replicat=
or
[    0.028391] /replicator: Fixed dependency cycle(s) with /axi/funnel@f880=
4000
[    0.028797] /axi/funnel@f8804000: Fixed dependency cycle(s) with
/axi/ptm@f889d000
[    0.028822] /axi/funnel@f8804000: Fixed dependency cycle(s) with
/axi/ptm@f889c000
[    0.028842] /axi/funnel@f8804000: Fixed dependency cycle(s) with /replic=
ator
[    0.029084] /axi/funnel@f8804000: Fixed dependency cycle(s) with
/axi/ptm@f889c000
[    0.029196] /axi/ptm@f889c000: Fixed dependency cycle(s) with
/axi/funnel@f8804000
[    0.029422] /axi/funnel@f8804000: Fixed dependency cycle(s) with
/axi/ptm@f889d000
[    0.029509] /axi/ptm@f889d000: Fixed dependency cycle(s) with
/axi/funnel@f8804000
[    0.030334] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.030345] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.030980] e0001000.serial: ttyPS0 at MMIO 0xe0001000 (irq =3D 27,
base_baud =3D 6249999) is a xuartps
[    0.031040] printk: legacy console [ttyPS0] enabled
[    0.656472] pps_core: LinuxPPS API ver. 1 registered
[    0.661475] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.670642] PTP clock support registered
[    0.674730] FPGA manager framework
[    0.678947] vgaarb: loaded
[    0.681809] clocksource: Switched to clocksource arm_global_timer
[    0.696109] NET: Registered PF_INET protocol family
[    0.701211] IP idents hash table entries: 4096 (order: 3, 32768
bytes, linear)
[    0.709073] tcp_listen_portaddr_hash hash table entries: 512
(order: 0, 4096 bytes, linear)
[    0.717504] Table-perturb hash table entries: 65536 (order: 6,
262144 bytes, linear)
[    0.725305] TCP established hash table entries: 2048 (order: 1,
8192 bytes, linear)
[    0.733001] TCP bind hash table entries: 2048 (order: 3, 32768 bytes, li=
near)
[    0.740209] TCP: Hash tables configured (established 2048 bind 2048)
[    0.746644] UDP hash table entries: 256 (order: 2, 14336 bytes, linear)
[    0.753308] UDP-Lite hash table entries: 256 (order: 2, 14336 bytes, lin=
ear)
[    0.760525] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.766234] PCI: CLS 0 bytes, default 64
[    0.770437] Trying to unpack rootfs image as initramfs...
[    0.773208] workingset: timestamp_bits=3D30 max_order=3D18 bucket_order=
=3D0
[    0.782489] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.790608] Key type cifs.idmap registered
[    0.794984] io scheduler mq-deadline registered
[    0.799550] io scheduler kyber registered
[    0.804360] zynq-pinctrl 700.pinctrl: zynq pinctrl initialized
[    0.815734] dma-pl330 f8003000.dma-controller: Loaded driver for
PL330 DMAC-241330
[    0.823414] dma-pl330 f8003000.dma-controller:
DBUFF-128x8bytes Num_Chans-8 Num_Peri-4 Num_Events-16
[    0.823926] Freeing initrd memory: 868K
[    0.844386] brd: module loaded
[    0.852204] loop: module loaded
[    1.875058] hwmon hwmon0: temp1_input not attached to any thermal zone
[    1.891204] macb e000b000.ethernet eth0: Cadence GEM rev 0x00020118
at 0xe000b000 irq 38 (88:20:12:f4:c1:e5)
[    1.901632] i2c_dev: i2c /dev entries driver
[    1.906095] cdns-i2c e0004000.i2c: can't get pinctrl, bus recovery
not supported
[    1.913947] cdns-i2c e0004000.i2c: 400 kHz mmio e0004000 irq 39
[    1.920565] clocksource: ttc_clocksource: freq: 81380 Hz, mask:
0xffff max_cycles: 0xffff, max_idle_ns: 358356783 ns
[    1.931176] timer #0 at (ptrval), irq=3D40
[    1.935478] armv7-pmu f8891000.pmu: hw perfevents: no
interrupt-affinity property, guessing.
[    1.944210] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 (8000003f) counters available
[    1.954162] NET: Registered PF_INET6 protocol family
[    1.960216] Segment Routing with IPv6
[    1.963951] In-situ OAM (IOAM) with IPv6
[    1.967951] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    1.974456] NET: Registered PF_PACKET protocol family
[    1.979561] Key type dns_resolver registered
[    1.983957] Registering SWP/SWPB emulation handler
[    1.995551] Starting IRQ pipeline tests...
[    1.995564] IRQ pipeline: high-priority torture stage added.
[    2.005421] irq_pipeline-torture: CPU1 initiates stop_machine()
[    2.011360] irq_pipeline-torture: CPU0 responds to stop_machine()
[    2.011375] irq_pipeline-torture: CPU1 calls function on remote(s)
[    2.023753] irq_pipeline-torture: CPU0 handles remote function call
[    2.023879] CPU1: proxy tick device registered (499.99MHz)
[    2.030068] CPU0: proxy tick device registered (499.99MHz)
[    2.041026] irq_pipeline-torture: CPU1: irq_work handled
[    2.046338] irq_pipeline-torture: CPU1: in-band->in-band irq_work
trigger works
[    2.053645] irq_pipeline-torture: CPU1: stage escalation request works
[    2.053651] irq_pipeline-torture: CPU1: irq_work handled
[    2.065475] irq_pipeline-torture: CPU1: oob->in-band irq_work trigger wo=
rks
[    3.121838] CPU1: proxy tick device unregistered
[    3.121841] CPU0: proxy tick device unregistered
[    3.131124] IRQ pipeline: torture stage removed.
[    3.135746] IRQ pipeline tests OK.
[    3.143513] clk: Disabling unused clocks
[    3.152057] Freeing unused kernel image (initmem) memory: 1024K
[    3.158189] Run /init as init process

---

/bin/sh: can't access tty; job control turned off
/ # uname -a
Linux (none) 6.18.29-01153-g1e9f8ec43dcd #4 SMP PREEMPT EVL Mon Aug 17
11:49:17 CEST 2026 armv7l armv7l armv7l GNU/Linux
/ # zcat /proc/config.gz 2>/dev/null | grep -E "^#? ?CONFIG_(DEBUG_IRQ_PIPE=
LINE|
IRQ_PIPELINE_TORTURE_TEST|DEBUG_DOVETAIL|EVL|SMP)(=3D| is not set)"
CONFIG_SMP=3Dy
# CONFIG_EVL is not set
CONFIG_DEBUG_IRQ_PIPELINE=3Dy
CONFIG_IRQ_PIPELINE_TORTURE_TEST=3Dy
CONFIG_DEBUG_DOVETAIL=3Dy
/ #

---

On Mon, Aug 17, 2026 at 11:13=E2=80=AFAM Philippe Gerum <rpm@xenomai.org> w=
rote:
> Regarding the issue you are observing, it suspect this is
> Dovetail-related. If so, xenomai 3.3 which is using Dovetail won't boot
> on the Zynq either.

I can actually confirm that.  We had been curious to try running the
Xenomai 3 stack on Dovetail by itself, and made the same observation:
it hangs during boot, and disabling CONFIG_SMP works around it.

I hope that helps.  Is there anything else you'd want me to try?
Regards,

--=20
Gerte Hoogewerf
Senior Software Team Lead
LMI Technologies
Wiebachstraat 25b, Kerkrade 6466 NG, The Netherlands

--=20


This
email and any attachment(s) it may contain is confidential and is=20
intended
solely for the use of the individual(s) to whom it is addressed.=20
If you are not
the intended recipient of this email, you must not take=20
action based on the
contents, nor distribute, nor expose any part of the=20
content(s) to entities or
person(s) beyond the original distribution list.=20
Please contact the sender and
delete the email if you have received it in=20
error. Thank you.
