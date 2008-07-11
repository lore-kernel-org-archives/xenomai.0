Date: Fri, 11 Jul 2008 15:18:50 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200807111518.16150@domain.hid>
References: 00807071745.31720@domain.hid> <48723D5D.6020008@domain.hid>
	<48732793.7090605@domain.hid> <487331AE.5070009@domain.hid>
	<48733483.2050204@domain.hid> <200807091719.17625@domain.hid>
	<4874E1D8.6020307@domain.hid>
In-Reply-To: <4874E1D8.6020307@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai-help] Kernel panic: not syncing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

I was able to capture the kernel panic through the serial line. This time, it took less time than I expected.
Petr

[ 2009.702873] Unable to handle kernel paging request at 0000000040090ff8 RIP: 
[ 2009.708187]  [<ffffffff802101a6>] profile_pc+0x46/0x80
[ 2009.716892] PGD 116fd067 PUD 116b5067 PMD 3d93d067 PTE 0
[ 2009.722998] Oops: 0000 [1] PREEMPT SMP 
[ 2009.727400] CPU 0 
[ 2009.729800] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat usb_storage libusual rt_e1000 rt_r8169 rtpacket rtnet ppdev pci171x_rtdm(P) container ac video output sbs sbshc dock battery parport_pc lp parport psmouse serio_raw pcspkr k8temp i2c_nforce2 i2c_core button af_packet ipv6 evdev ext3 jbd mbcache sg sd_mod ide_cd cdrom sata_nv floppy forcedeth ata_generic libata scsi_mod amd74xx ehci_hcd ohci_hcd ide_core usbcore fan fuse
[ 2009.774477] Pid: 0, comm: swapper Tainted: P        2.6.24-adeos #1
[ 2009.781682] RIP: 0010:[<ffffffff802101a6>]  [<ffffffff802101a6>] profile_pc+0x46/0x80
[ 2009.790682] RSP: 0018:ffffffff80664da0  EFLAGS: 00010202
[ 2009.796869] RAX: 0000000000000001 RBX: ffff8100010087a0 RCX: 0000000040090ff8
[ 2009.804953] RDX: ffff8100809b4000 RSI: 0000000000000906 RDI: ffffffff8048c6c8
[ 2009.813179] RBP: ffffffff8048c6c8 R08: 0000000000000004 R09: 0000000000000010
[ 2009.821383] R10: 0000000000000005 R11: ffffffff80258ee0 R12: ffff81000100a5c0
[ 2009.829667] R13: 000001d1bcf596b9 R14: 0000000000000000 R15: 0000000000000001
[ 2009.837867] FS:  0000000040091950(0000) GS:ffffffff805d6000(0000) knlGS:0000000000000000
[ 2009.847177] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[ 2009.853762] CR2: 0000000040090ff8 CR3: 0000000014cfd000 CR4: 00000000000006e0
[ 2009.862084] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2009.870373] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[ 2009.878572] Process swapper (pid: 0, threadinfo ffffffff80602000, task ffffffff805a03a0)
[ 2009.887786] Stack:  000001d1bcf596b9 ffff8100010087a0 0000000000000001 ffffffff8023fd3e
[ 2009.897090]  000001d1bcf596b9 ffff81000100a6c0 ffff8100010087a0 ffffffff8025e8a5
[ 2009.905760]  ffff81000100a618 ffff81000100a6c0 ffff81000100a618 000001d1bcf58f16
[ 2009.914068] Call Trace:
[ 2009.917071]  <IRQ>  [<ffffffff8023fd3e>] profile_tick+0x5e/0xa0
[ 2009.923847]  [<ffffffff8025e8a5>] tick_sched_timer+0x85/0x170
[ 2009.930374]  [<ffffffff8025900f>] hrtimer_interrupt+0x12f/0x1e0
[ 2009.937150]  [<ffffffff80220857>] smp_apic_timer_interrupt+0x37/0x60
[ 2009.944454]  [<ffffffff802777e0>] __ipipe_sync_stage+0x350/0x355
[ 2009.951351]  [<ffffffff80220820>] smp_apic_timer_interrupt+0x0/0x60
[ 2009.958555]  [<ffffffff802777e5>] __xirq_end+0x0/0x85
[ 2009.964349]  [<ffffffff80220820>] smp_apic_timer_interrupt+0x0/0x60
[ 2009.971558]  [<ffffffff80226b01>] __ipipe_handle_irq+0x91/0x250
[ 2009.978457]  [<ffffffff8020af50>] default_idle+0x0/0x40
[ 2009.984437]  [<ffffffff8020c9f1>] common_interrupt+0x61/0x7d
[ 2009.990940]  <EOI>  [<ffffffff8020af79>] default_idle+0x29/0x40
[ 2009.997762]  [<ffffffff8020b01b>] cpu_idle+0x8b/0x120
[ 2010.003541]  [<ffffffff8060cbba>] start_kernel+0x2ba/0x350
[ 2010.009741]  [<ffffffff8060c120>] _sinittext+0x120/0x130
[ 2010.015821] 
[ 2010.017549] 
[ 2010.017556] Code: 48 8b 11 48 89 d0 48 c1 e8 16 48 85 c0 75 1b 48 8b 51 08 48 
[ 2010.028006] RIP  [<ffffffff802101a6>] profile_pc+0x46/0x80
[ 2010.034335]  RSP <ffffffff80664da0>
[ 2010.038334] CR2: 0000000040090ff8
[ 2010.042166] ---[ end trace 95174c527ade95f0 ]---
[ 2010.047468] Kernel panic - not syncing: Aiee, killing interrupt handler! 

>> 
>> 0000000000000210 <profile_pc>:
>>  210:	48 83 ec 18          	sub    $0x18,%rsp
>>  214:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
>>  219:	48 89 6c 24 10       	mov    %rbp,0x10(%rsp)
>>  21e:	48 89 fb             	mov    %rdi,%rbx
>>  221:	f6 87 88 00 00 00 03 	testb  $0x3,0x88(%rdi)
>>  228:	48 8b af 80 00 00 00 	mov    0x80(%rdi),%rbp
>>  22f:	74 12                	je     243 <profile_pc+0x33>
>>  231:	48 89 e8             	mov    %rbp,%rax
>>  234:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
>>  239:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
>>  23e:	48 83 c4 18          	add    $0x18,%rsp
>>  242:	c3                   	retq   
>>  243:	48 89 ef             	mov    %rbp,%rdi
>>  246:	e8 00 00 00 00       	callq  24b <profile_pc+0x3b>
>>  24b:	85 c0                	test   %eax,%eax
>>  24d:	74 e2                	je     231 <profile_pc+0x21>
>>  24f:	48 8b 8b 98 00 00 00 	mov    0x98(%rbx),%rcx
>>  256:	48 8b 11             	mov    (%rcx),%rdx
>>  259:	48 89 d0             	mov    %rdx,%rax
>>  25c:	48 c1 e8 16          	shr    $0x16,%rax
>>  260:	48 85 c0             	test   %rax,%rax
>>  263:	75 1b                	jne    280 <profile_pc+0x70>
>>  265:	48 8b 51 08          	mov    0x8(%rcx),%rdx
>>  269:	48 89 d0             	mov    %rdx,%rax
>>  26c:	48 c1 e8 16          	shr    $0x16,%rax
>>  270:	48 85 c0             	test   %rax,%rax
>>  273:	48 0f 45 ea          	cmovne %rdx,%rbp
>>  277:	eb b8                	jmp    231 <profile_pc+0x21>
>>  279:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
>>  280:	48 89 d5             	mov    %rdx,%rbp
>>  283:	eb ac                	jmp    231 <profile_pc+0x21>
>>  285:	66 66 2e 0f 1f 84 00 	nopw   %cs:0x0(%rax,%rax,1)
>>  28c:	00 00 00 00  
>> 


