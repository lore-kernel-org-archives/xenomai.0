Subject: Re: unable to modprobe xeno_can_mem (rtcan_sja1000.c) device with
 certain IRQ numbers
References: <MN2PR19MB39675622AE295136F16F4366D5B40@MN2PR19MB3967.namprd19.prod.outlook.com>
From: Wolfgang Grandegger <wg@grandegger.com>
Message-ID: <a30dd164-b517-586e-5e6e-e5aba3fde2cd@grandegger.com>
Date: Sat, 23 May 2020 19:38:56 +0200
MIME-Version: 1.0
In-Reply-To: <MN2PR19MB39675622AE295136F16F4366D5B40@MN2PR19MB3967.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

Am 22.05.20 um 22:01 schrieb Josh Karch via Xenomai:
> Hello,
> 
> Outside of the GPIO issues that I am having loading the xeno-gpio-xilinx drivers, when trying to load the xeno_can_mem driver (which calls SJA1000) I get the following segfault.  When I use a fake low IRQ number like 10, the xeno_can_mem driver loads, but 89, which is the Xilinx Ultrascale+MPSoC interrupt number from the fabric to the processor side, connects to my SJA1000 compatible CAN core.  I verified the driver loads once modified for my memory map.
> The rtcan_sja1000.c segfaults on the following:
> 
> ret = rtdm_irq_request(&dev->irq_handle,
>   chip->irq_num, rtcan_sja_interrupt,
>   chip->irq_flags, sja_ctrl_name, dev);
>     if (ret) {
> 
> Note: rtcan_mem.c uses "RTDM_IRQTYPE_SHARED" as part of the IRQ request. Could this be an issue?
> 
> Best,
> Josh Karch
> 
> # modprobe xeno_can_mem mem=0xa0000000 irq=89
> [  615.391303] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development Team
> [  615.398993] RTCAN SJA1000 driver initialized
> [  615.403892] Trying to install index 0 IRQ 89
> [  615.408248] DDC CAN Core SJA1000 version 21
> [  615.408269] Unable to handle kernel NULL pointer dereference at virtual addre
> ss 0000000000000058
> [  615.421243] Mem abort info:
> [  615.424034]   ESR = 0x96000006
> [  615.427091]   Exception class = DABT (current EL), IL = 32 bits
> [  615.433013]   SET = 0, FnV = 0
> [  615.436070]   EA = 0, S1PTW = 0
> [  615.439209] Data abort info:
> [  615.442082]   ISV = 0, ISS = 0x00000006
> [  615.445920]   CM = 0, WnR = 0
> [  615.448891] user pgtable: 4k pages, 39-bit VAs, pgdp = 0000000032bc80a0
> [  615.455508] [0000000000000058] pgd=000000085d370003, pud=000000085d370003, pm
> d=0000000000000000
> [  615.464218] Internal error: Oops: 96000006 [#1] SMP
> [  615.469091] Modules linked in: xeno_can_mem(+) xeno_can_sja1000 xeno_can xili
> nx_can gpio_xilinx gpio_tonka(O)
> [  615.479010] Process modprobe (pid: 300, stack limit = 0x00000000141e3791)
> [  615.485797] CPU: 3 PID: 300 Comm: modprobe Tainted: G        W  O      4.19.5
> 5 #21
> [  615.493356] Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
> [  615.498309] I-pipe domain: Linux
> [  615.501531] pstate: 20000005 (nzCv daif -PAN -UAO)
> [  615.506320] pc : ipipe_set_irq_affinity+0x38/0xc0
> [  615.511019] lr : ipipe_set_irq_affinity+0x30/0xc0
> [  615.515714] sp : ffffff8009f63a20
> [  615.519021] x29: ffffff8009f63a20 x28: ffffff8009f75000
> [  615.524326] x27: 0000000000000100 x26: ffffff8000a66000
> [  615.529630] x25: ffffff8000a66308 x24: ffffffc85d3fafb8
> [  615.534934] x23: ffffff8008e07be0 x22: ffffffc85d3fac30
> [  615.540238] x21: ffffff8008eced40 x20: ffffff8008df9688
> [  615.545542] x19: 0000000000000059 x18: 0000000000000030
> [  615.550846] x17: 0000000000000000 x16: ffffffc85d93cec0
> [  615.556150] x15: ffffffffffffffff x14: 0000000000000000
> [  615.561454] x13: 00000000000002da x12: 0000000000000001
> [  615.566758] x11: 000000000000000a x10: 0000000000000040
> [  615.572062] x9 : ffffff8008e0c7a8 x8 : ffffffbebffe7840
> [  615.577366] x7 : 0000000000000000 x6 : ffffffc87b400240
> [  615.582670] x5 : 000000000000003f x4 : ffffffc87b400241
> [  615.587974] x3 : 0000000000000000 x2 : 0000000000000000
> [  615.593278] x1 : 0000000000000059 x0 : 0000000000000000
> [  615.598582] Call trace:
> [  615.601022]  ipipe_set_irq_affinity+0x38/0xc0
> [  615.605374]  xnintr_attach+0x7c/0x160
> [  615.609028]  rtdm_irq_request+0x64/0xb0
> [  615.612857]  rtcan_sja1000_register+0xdc/0x1d8 [xeno_can_sja1000]
> [  615.618945]  rtcan_mem_init_one+0x16c/0x1e8 [xeno_can_mem]
> [  615.624420]  rtcan_mem_init+0x3c/0xe18 [xeno_can_mem]
> [  615.629462]  do_one_initcall+0x74/0x178
> [  615.633290]  do_init_module+0x54/0x1d0
> [  615.637031]  load_module+0x1b90/0x2120
> [  615.640772]  __se_sys_finit_module+0xb8/0xd0
> [  615.645035]  __arm64_sys_finit_module+0x18/0x20
> [  615.649559]  el0_svc_common+0xbc/0x1a0
> [  615.653299]  el0_svc_handler+0x68/0x80
> [  615.657039]  el0_svc+0x8/0x18
> [  615.660002] Code: 2a0003f3 94015eb5 b40003c0 f9402000 (f9402c00)
> [  615.666088] ---[ end trace c7317888b13abfa7 ]---
> Segmentation fault

I think that "irq_get_chip(irq)" in "ipipe_set_irq_affinity()" returns
NULL. Are your sure, that the IRQ number is correct? Did you get the
SJA1000 from Linux already working?

Maybe you can find some useful information in:

  # mount -tdebugfs nope /sys/kernel/debug
  # cat /sys/kernel/debug/irq...

Or maybe some IRQ config is missing. A platform driver would be more
appropriate, using configs from the device tree.

Wolfgang

