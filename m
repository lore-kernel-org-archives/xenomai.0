Sender: chensong_2000@189.cn
Subject: Re: I-pipe ARM64 on Armv8 NXP LS1028A
References: <CAJONJDuaHXswNMQrT9RsMioCMbr5GXbri=B8ZicNOeasc65VMw@mail.gmail.com>
From: "chensong_2000@189.cn" <chensong_2000@189.cn>
Message-ID: <8c7092e6-3e14-2797-2e4d-e8f13f330fbe@189.cn>
Date: Mon, 12 Jul 2021 11:50:13 +0800
MIME-Version: 1.0
In-Reply-To: <CAJONJDuaHXswNMQrT9RsMioCMbr5GXbri=B8ZicNOeasc65VMw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Joe Lee <joelee271828@gmail.com>, xenomai@xenomai.org

i had similar experience, below is my fix.

在 2021/7/12 上午12:37, Joe Lee via Xenomai 写道:
> Hi Pals,
> 
> I applied the ipipe-core-5.4.119-arm64-2.patch on an NXP LS1028A, a
> 64-bit Armv8 processor.
> 
> But then there are two problems, could anyone give me some advice ?
> 
> 1. Warning "not pipeline-safe" when booting like below:
> 
> [    0.053295] ASID allocator initialised with 32768 entries
> [    0.058807] rcu: Hierarchical SRCU implementation.
> [    0.063764] ------------[ cut here ]------------
> [    0.068435] MSI domain irqchip ITS-pMSI is not pipeline-safe!
> [    0.068459] WARNING: CPU: 0 PID: 1 at
> /home/joe/nxp/linux/kernel/irq/msi.c:273 msi_create_irq_dom0
> [    0.092331] Modules linked in:
> [    0.095409] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.119-dirty #1
> [    0.101994] Hardware name: LS1028A RDB Board (DT)
> [    0.106735] I-pipe domain: Linux
> [    0.109986] pstate: 60000005 (nZCv daif -PAN -UAO)
> [    0.114817] pc : msi_create_irq_domain+0x184/0x190
> [    0.119648] lr : msi_create_irq_domain+0x184/0x190
> [    0.124477] sp : ffff80001002bca0
> [    0.127815] x29: ffff80001002bca0 x28: 0000000000000000
> [    0.133173] x27: 0000000000000000 x26: ffff00007ba0cb90
> [    0.138530] x25: ffff80001132c928 x24: ffff000079014100
> [    0.143887] x23: ffff00007ba0cb08 x22: ffff800011749000
> [    0.149243] x21: ffff80001177e320 x20: ffff000079014100
> [    0.154600] x19: ffff80001177e2a0 x18: ffffffffffffffff
> [    0.159957] x17: 0000000068278711 x16: 000000009d48fe30
> [    0.165314] x15: ffff800011749908 x14: 0000000000000000
> [    0.170670] x13: 0000000000000001 x12: 0000000000000000
> [    0.176027] x11: 0000000000000001 x10: ffff80001183f090
> [    0.181384] x9 : ffff80001002bca0 x8 : 656661732d656e69
> [    0.186741] x7 : 6c6570697020746f x6 : ffff80001183f0d1
> [    0.192098] x5 : 0000000000000000 x4 : 0000000000000000
> [    0.197455] x3 : ffff000079bcee18 x2 : 0000000000000000
> [    0.202811] x1 : 741db99c0414c500 x0 : 0000000000000000
> [    0.208168] Call trace:
> [    0.210631]  msi_create_irq_domain+0x184/0x190
> [    0.215114]  platform_msi_create_irq_domain+0x1c/0x130
> [    0.220297]  its_pmsi_init+0xe0/0x154
> [    0.223988]  do_one_initcall+0x5c/0x1a8
> [    0.227855]  kernel_init_freeable+0xd0/0x240
> [    0.232161]  kernel_init+0x10/0x108
> [    0.235675]  ret_from_fork+0x10/0x1c
> [    0.239278] ---[ end trace d5b95d1adba5cfc9 ]---
> [    0.243957] Platform MSI: gic-its@6020000 domain created
> [    0.249368] PCI/MSI: /interrupt-controller@6000000/gic-its@6020000
> domain created
> [    0.256949] fsl-mc MSI:
> /interrupt-controller@6000000/gic-its@6020000 domain created

--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -914,6 +914,7 @@ static struct irq_chip brcm_msi_irq_chip = {
         .name = "Brcm_MSI",
         .irq_mask = pci_msi_mask_irq,
         .irq_unmask = pci_msi_unmask_irq,
+       .flags = IRQCHIP_PIPELINE_SAFE,
  };

i'm not sure if it's identical to yours, but "flags = 
IRQCHIP_PIPELINE_SAFE" would be applicable to your case.

> 
> 2. When the ethernet link up, kernel will crash like below.
> 
> [ 4625.779805] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [ 4625.788622] Mem abort info:
> [ 4625.791418]   ESR = 0x86000004
> [ 4625.794476]   EC = 0x21: IABT (current EL), IL = 32 bits
> [ 4625.799801]   SET = 0, FnV = 0
> [ 4625.802857]   EA = 0, S1PTW = 0
> [ 4625.806003] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000f693a000
> [ 4625.812461] [0000000000000000] pgd=0000000000000000
> [ 4625.817352] Internal error: Oops: 86000004 [#1] PREEMPT SMP
> [ 4625.822938] Modules linked in: xt_addrtype xt_conntrack
> crct10dif_ce galcore(O)
> [ 4625.830277] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O
>    5.4.119-dirty #1
> [ 4625.838218] Hardware name: LS1028A RDB Board (DT)
> [ 4625.842932] I-pipe domain: Linux
> [ 4625.846164] pstate: 40000085 (nZcv daIf -PAN -UAO)
> [ 4625.850967] pc : 0x0
> [ 4625.853157] lr : __ipipe_ack_fasteoi_irq+0x1c/0x28
> [ 4625.857957] sp : ffff800010003f60
> [ 4625.861277] x29: ffff800010003f60 x28: ffff8000117521c0
> [ 4625.866603] x27: 0000000000000000 x26: ffff800010004000
> [ 4625.871929] x25: ffff800010000000 x24: ffff80001183a000
> [ 4625.877255] x23: 0000000000000000 x22: ffff800011767000
> [ 4625.882581] x21: 000000000000006d x20: 0000000000000000
> [ 4625.887906] x19: 000000000000006d x18: 0000000000000000
> [ 4625.893232] x17: 0000000000000000 x16: 0000000000000000
> [ 4625.898557] x15: 0000000000000000 x14: 0000000000000000
> [ 4625.903883] x13: 0000000000000001 x12: 0000000000000000
> [ 4625.909208] x11: 0000000000000000 x10: 0000000000000040
> [ 4625.914534] x9 : ffff800011760b50 x8 : ffff800011760b48
> [ 4625.919859] x7 : ffff000078c0f190 x6 : 0000000000000000
> [ 4625.925185] x5 : ffff000078c0f000 x4 : 0000000000000000
> [ 4625.930510] x3 : ffff800011885580 x2 : 0000000000001b80
> [ 4625.935835] x1 : 0000000000000000 x0 : ffff000078275e28
> [ 4625.941161] Call trace:
> [ 4625.943610]  0x0
> [ 4625.945450]  __ipipe_dispatch_irq+0x174/0x1c0
> [ 4625.949816]  __ipipe_grab_irq+0x5c/0x98
> [ 4625.953660]  gic_handle_irq+0x5c/0xe4
> [ 4625.957329]  handle_arch_irq_pipelined+0x14/0x60
> [ 4625.961957]  el1_irq+0xc8/0x174
> [ 4625.965103]  ipipe_unstall_root+0x34/0x50
> [ 4625.969122]  arch_cpu_idle+0x14/0x20
> [ 4625.972704]  default_idle_call+0x3c/0x44
> [ 4625.976635]  do_idle+0xc0/0x150
> [ 4625.979781]  cpu_startup_entry+0x20/0x48
> [ 4625.983712]  rest_init+0xd4/0xe0
> [ 4625.986946]  arch_call_rest_init+0xc/0x14
> [ 4625.990963]  start_kernel+0x404/0x438
> [ 4625.994634] Code: bad PC value
> [ 4625.997697] ---[ end trace d5b95d1adba5cfcc ]---
> [ 4626.002326] Kernel panic - not syncing: Attempted to kill the idle task!
> [ 4626.009046] SMP: stopping secondary CPUs
> [ 4626.012979] Kernel Offset: disabled
> [ 4626.016474] CPU features: 0x0002,21006008
> [ 4626.020489] Memory Limit: none
> [ 4626.023552] ---[ end Kernel panic - not syncing: Attempted to kill
> the idle task! ]---
> 

+++ b/kernel/irq/chip.c
@@ -986,7 +986,8 @@ void __ipipe_end_level_irq(struct irq_desc *desc)

  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
  {
-       desc->irq_data.chip->irq_hold(&desc->irq_data);
+       if(desc && desc->irq_data.chip && desc->irq_data.chip->irq_hold)
+               desc->irq_data.chip->irq_hold(&desc->irq_data);
  }

from the oops info, x0 : ffff000078275e28 should be desc, 
desc->irq_data.chip->irq_hold should be NULL.

> Attached my kernel config.
> 

