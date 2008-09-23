Message-ID: <48D90034.1070602@domain.hid>
Date: Tue, 23 Sep 2008 16:41:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48D8FEE6.3090109@domain.hid>
In-Reply-To: <48D8FEE6.3090109@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] [BUG] vmalloc_sync_one complains about
	__ipipe_pin_range_globally
Reply-To: gilles.chanteperdrix@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> any thoughts on this BUG? Happens with ipipe-2.0-07 on 2.6.24.7,
> obviously during module loading.
> 
>  kernel BUG at arch/x86/mm/fault_64.c:258!
>  invalid opcode: 0000 [1] SMP
>  CPU 3
>  Modules linked in: ide_core ide_disk scsi_mod sd_mod serverworks libata
>  sata_svw scsi_transport_sas mptbase mptscsih mptsas sg fan edd
>  pata_serverworks jbd mbcache ext3 usbcore hwmon i2c_core k8temp
>  pci_hotplug i2c_piix4 shpchp ehci_hcd ohci_hcd rtc_lib rtc_core rtc_cmos
>  tg3
>  Pid: 1683, comm: modprobe Not tainted 2.6.24.7-xeno #1
>  RIP: 0010:[<ffffffff80224e8c>]  [<ffffffff80224e8c>]
>  vmalloc_sync_one+0x6f/0x197
>  RSP: 0018:ffff81023b0c1c98  EFLAGS: 00010287
>  RAX: 00003ffffffff000 RBX: ffff81023feeea88 RCX: ffff810000000000
>  RDX: ffff81023c423000 RSI: 000000023c423000 RDI: ffff81023b1e7c20
>  RBP: ffff81023b0c1cc8 R08: ffffffff80201c20 R09: 0000000000000800
>  R10: ffffffff8099a380 R11: 0000000000000002 R12: 0000000000000c20
>  R13: ffffc20001888000 R14: ffffc20001888000 R15: 0000000000000000
>  FS:  00002ac2367716d0(0000) GS:ffff81023c31d5c0(0000)
>  knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>  CR2: 00002ac236442000 CR3: 000000023b139000 CR4: 00000000000006e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
>  Process modprobe (pid: 1683, threadinfo ffff81023b0c0000, task
>  ffff81023c3ba7f0)
>  Stack:  ffffc2000188bfff ffff81023feeea88 0000000000000c20
>  ffffc20001888000
>   ffffc2000188c000 0000000000000000 ffff81023b0c1d08 ffffffff802252ac
>   ffffc2000188c000 0000000000000000 ffffc2000188c000 ffff81013a1cf468
>  Call Trace:
>   [<ffffffff802252ac>] __ipipe_pin_range_globally+0x9a/0xe4
>   [<ffffffff802dac08>] map_vm_area+0x29f/0x2b0
>   [<ffffffff802db28b>] __vmalloc_area_node+0x173/0x199
>   [<ffffffff802db30e>] __vmalloc_node+0x5d/0x6a
>   [<ffffffff802db34d>] __vmalloc+0x11/0x13
>   [<ffffffff802db40a>] vmalloc+0x1d/0x1f
>   [<ffffffff8025c73b>] sys_init_module+0x71/0x18ba
>   [<ffffffff8022453c>] mcount+0x4c/0x72
>   [<ffffffff8022453c>] mcount+0x4c/0x72
>   [<ffffffff80223f54>] __ipipe_syscall_root+0xc/0x197
>   [<ffffffff8047fb11>] __ipipe_syscall_root_thunk+0x35/0x6a
>   [<ffffffff8020c172>] system_call+0x92/0x97
> 
> 
>  Code: 0f 0b eb fe 49 8b 00 4c 89 f2 49 bf 00 f0 ff ff ff 3f 00 00
>  RIP  [<ffffffff80224e8c>] vmalloc_sync_one+0x6f/0x197
>   RSP <ffff81023b0c1c98>
> 
> 
> The relevant code in fault_64.c:
> 
> static int vmalloc_sync_one(pgd_t *pgd, unsigned long address)
> {
>         pgd_t *pgd_ref;
>         pud_t *pud, *pud_ref;
>         pmd_t *pmd, *pmd_ref;
>         pte_t *pte, *pte_ref;
> 
>         /* Copy kernel mappings over when needed. This can also
>            happen within a race in page table update. In the later
>            case just flush. */
> 
>         pgd_ref = pgd_offset_k(address);
>         if (pgd_none(*pgd_ref))
>                 return -1;
>         if (pgd_none(*pgd))
>                 set_pgd(pgd, *pgd_ref);
>         else
>                 BUG_ON(pgd_page_vaddr(*pgd) != pgd_page_vaddr(*pgd_ref));
> 
> This one triggers.

I think there is something missing in the I-pipe patch: when a vmalloc
occurs we update all page directories, but when a vfree occurs, we do
nothing. Is there any chance that the bug you observed is in fact a
vmalloc which reuses an address which has been vfreed recently ?

-- 
                                                 Gilles.

