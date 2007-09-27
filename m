Message-ID: <46FB62F2.2010104@domain.hid>
Date: Thu, 27 Sep 2007 09:59:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46FA850A.8040201@domain.hid>
In-Reply-To: <46FA850A.8040201@domain.hid>
Content-Type: multipart/mixed; boundary="------------070701010607030209010609"
Subject: [Xenomai-core] [PATCH] fix SYSENTER_CS modificaton race (was: [BUG]
 sep-related oops on 2.6.20)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai-core@domain.hid
Cc: adeos-main@gna.org

This is a multi-part message in MIME format.
--------------070701010607030209010609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jan Kiszka wrote:
> Hi,
> 
> [  765.881682] general protection fault: 0000 [#2]
> [  765.881686] SMP 
> [  765.881692] Modules linked in: xeno_timerbench sky2 xeno_rtdm xeno_native xeno_nucleus ipv6 binfmt_misc rfcomm l2cap bluetooth i915 drm ppdev capability commoncap dock button video sbs battery i2c_ec i2c_core ac af_packet nls_utf8 ntfs sbp2 lp fuse usbhid hid snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy snd_seq_oss tsdev snd_seq_midi joydev snd_rawmidi snd_seq_midi_event snd_seq evdev snd_timer snd_seq_device pcmcia ehci_hcd irda iTCO_wdt iTCO_vendor_support ohci1394 sdhci uhci_hcd parport_pc parport ata_generic generic piix ieee1394 intel_agp agpgart mmc_core usbcore serio_raw yenta_socket rsrc_nonstatic pcmcia_core pcspkr psmouse shpchp pci_hotplug crc_ccitt snd soundcore snd_page_alloc ext3 jbd mbcache sr_mod cdrom sd_mod sg ata_piix ahci libata scsi_mod fan
> [  765.881825] CPU:    1
> [  765.881826] EIP:    0060:[<c01032eb>]    Not tainted VLI
> [  765.881827] EFLAGS: 00010246   (2.6.20 #10)
> [  765.881835] EIP is at sysenter_exit+0x13/0x18
> [  765.881839] eax: 00000000   ebx: b7dda374   ecx: b7dda2b0   edx: ffffe410
> [  765.881843] esi: 0000267f   edi: b7dda374   ebp: 00000000   esp: eada3fb8
> [  765.881846] ds: 007b   es: 007b   ss: 0068
> [  765.881851] Process sampling-14203 (pid: 14205, ti=eada2000 task=dfe52070 task.ti=eada2000)
> [  765.881854] Stack: b7dda374 b7f81f1c 00000000 0000267f b7dda374 b7dda2d8 00000000 0801007b 
> [  765.881869]        ffff007b c0100033 0801022b ffffe410 00000073 00000206 b7dda2b0 0000007b 
> [  765.881882]        5a5a5a5a a55a5a5a 
> [  765.881887] Call Trace:
> [  765.881890]  [<c010462f>] show_trace_log_lvl+0x1f/0x40
> [  765.881896]  [<c0104701>] show_stack_log_lvl+0xb1/0xe0
> [  765.881902]  [<c01048f4>] show_registers+0x1c4/0x340
> [  765.881907]  [<c0104b97>] die+0x127/0x280
> [  765.881912]  [<c0105d69>] do_general_protection+0x199/0x1d0
> [  765.881917]  [<c0113444>] __ipipe_handle_exception+0x84/0x1b0
> [  765.881925]  [<c02efccd>] error_code+0x81/0x90
> [  765.881931]  =======================
> [  765.881933] Code: 0c bc 04 00 fb 8b 4d 08 66 f7 c1 ff fe 0f 85 6d 01 00 00 e8 e8 fc 00 00 8b 44 24 18 8b 54 24 2c 8b 4c 24 38 31 ed 8e 6c 24 24 fb <0f> 35 8d 76 00 50 fc 0f a8 06 1e 50 55 57 56 52 51 53 ba 7b 00 
> [  765.882012] EIP: [<c01032eb>] sysenter_exit+0x13/0x18 SS:ESP 0068:eada3fb8
> 
> Any bells ringing for someone?
> 
> This happens only with --enable-x86-sep, not when going via int80 into the kernel. Setup is 2.6.20 with ipipe-1.8-08 (I switched back from 2.6.20.20 to exclude issues due to my adopted patch) and Xenomai trunk. To trigger this, I have to run "latency -c1" (-c0 doesn't cause this) and switch between X and text mode (which triggers some hw-related latencies, still meditating over this correlation...).

And here comes the solution:

The attached patch fixes a race related to changing MSR_IA32_SYSENTER_CS 
when user space requested vm86[old]() services (I assume my X-server 
does so in the scenario above, maybe to call into the BIOS). We have to 
make sure that current->thread is always in sync with the MSR because we 
consult both in __switch_to, thus we have to enforce atomicity of the 
related code.

The patch is for ipipe-1.8-08, but 1.10 is affected just as well.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------070701010607030209010609
Content-Type: text/x-patch;
 name="fix-wrmsr-race.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-wrmsr-race.patch"

---
 arch/i386/kernel/vm86.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.20.20/arch/i386/kernel/vm86.c
===================================================================
--- linux-2.6.20.20.orig/arch/i386/kernel/vm86.c
+++ linux-2.6.20.20/arch/i386/kernel/vm86.c
@@ -148,12 +148,14 @@ struct pt_regs * fastcall save_v86_state
 		do_exit(SIGSEGV);
 	}
 
+	local_irq_disable_hw_cond();
 	tss = &per_cpu(init_tss, get_cpu());
 	current->thread.esp0 = current->thread.saved_esp0;
 	current->thread.sysenter_cs = __KERNEL_CS;
 	load_esp0(tss, &current->thread);
 	current->thread.saved_esp0 = 0;
 	put_cpu();
+	local_irq_enable_hw_cond();
 
 	ret = KVM86->regs32;
 
@@ -324,12 +326,14 @@ static void do_sys_vm86(struct kernel_vm
 	savesegment(fs, tsk->thread.saved_fs);
 	tsk->thread.saved_gs = info->regs32->xgs;
 
+	local_irq_disable_hw_cond();
 	tss = &per_cpu(init_tss, get_cpu());
 	tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
 	if (cpu_has_sep)
 		tsk->thread.sysenter_cs = 0;
 	load_esp0(tss, &tsk->thread);
 	put_cpu();
+	local_irq_enable_hw_cond();
 
 	tsk->thread.screen_bitmap = info->screen_bitmap;
 	if (info->flags & VM86_SCREEN_BITMAP)

--------------070701010607030209010609--

