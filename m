Message-ID: <5073C8C8.7000606@gmail.com>
Date: Tue, 09 Oct 2012 08:48:40 +0200
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <50729DAB.2080909@gmail.com> <50730FB7.3060604@xenomai.org>
In-Reply-To: <50730FB7.3060604@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Oops while running "cat /proc/xenomai/stat"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

On 10/08/2012 07:39 PM, Gilles Chanteperdrix wrote:
> On 10/08/2012 11:32 AM, Stefan Roese wrote:
> 
>> Hi,
>>
>> I'm currently developing an RTDM driver communicating with an FPGA
>> located on the LPB on an MPC5200 PowerPC. This driver already seems
>> to work quite well. But when I run my test application
>> communicating with the device driver, and I try to check the
>> Xenomai stat's, I get a kernel crash:
>>
>> root@generic-powerpc:~# cat /proc/xenomai/stat 
>> [   43.722984] Oops: Kernel access of bad area, sig: 11 [#1]
>> [   43.728503] mpc5200-simple-platform
>> [   43.732057] Modules linked in: rt_fpga(O) rt_mpc52xx_lpbfifo(O)
>> [   43.738107] NIP: c00646a8 LR: c0098b84 CTR: c0098b34
>> [   43.743173] REGS: c7025b40 TRAP: 0300   Tainted: G           O  (3.5.3-00253-g4699145-dirty)
>> [   43.751776] MSR: 00001032 <ME,IR,DR,RI>  CR: 24424488  XER: 20000000
>> [   43.758279] DAR: 00000000, DSISR: 22000000
>> [   43.762454] TASK = c7b75360[1430] 'cat' THREAD: c7024000
>> GPR00: 00000000 c7025bf0 c7b75360 c7b1ca0c 00000002 02000007 00000000 00000031 
>> GPR08: c7ab0000 c7b1cc00 00000000 00000000 c0098b34 100a5a74 10017830 10006834 
>> GPR16: 10006770 10006774 c7b1cc00 00000000 00000002 c033d385 c03264ac 00000025 
>> GPR24: c0320000 00000001 00000002 c03b3460 00000000 00000000 c7a6ccc4 c7a6ccb4 
>> [   43.796697] Call Trace:
>> [   43.799189] [c7025bf0] [c004c540] 0xc004c540 (unreliable)
>> [   43.804698] [c7025c20] [c0098b84] 0xc0098b84
>> [   43.809051] [c7025c40] [c90e4588] 0xc90e4588
>> [   43.813406] [c7025c50] [c90d8114] 0xc90d8114
>> [   43.817758] [c7025c60] [c005e85c] 0xc005e85c
>> [   43.822113] [c7025ca0] [c005aef0] 0xc005aef0
>> [   43.826465] [c7025cc0] [c000d664] 0xc000d664
>> [   43.830819] [c7025cd0] [c000f710] 0xc000f710
>> [   43.835175] --- Exception: 501 at 0xc01b2614
>>
>> This happens reproducible upon the "cat" command from the shell.
>>
>> Looking at the NIP (c00646a8), the PPC is currently executing
>> xnsynch_flush().
>>
>> Other proc files from the xenomai directory like "irq" don't cause
>> this crash. And accessing "stat" when this application is not
>> running also works fine:
>>
>> root@generic-powerpc:~# cat /proc/xenomai/stat 
>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>   0  0      0          0          0     00500080  100.0  ROOT
>>   0  0      0          0          0     00000000    0.0  IRQ145: rtcan_mscan
>>   0  0      0          0          0     00000000    0.0  IRQ151: mpc52xx-lpbfifo
>>   0  0      0          0          0     00000000    0.0  IRQ194: mpc52xx-lpbfifo-rx
>>   0  0      0          17619      0     00000000    0.0  IRQ512: [timer]
>>
>> Any idea what might go wrong here? 
> 
> 
> Please enable CONFIG_KALLSYMS so that the backtrace contains readable
> function names, otherwise, without a disassembly of your kernel, we have
> no idea what functions the backtrace is referring to.

Yes, sorry my bad. Here the new crash log:

root@generic-powerpc:~# cat /proc/xenomai/stat 
[   65.215600] Oops: Kernel access of bad area, sig: 11 [#1]
[   65.221118] mpc5200-simple-platform
[   65.224671] Modules linked in: rt_fpga(O) rt_mpc52xx_lpbfifo(O)
[   65.230718] NIP: c0066914 LR: c009adf0 CTR: c009ada0
[   65.235784] REGS: c716bac0 TRAP: 0300   Tainted: G           O  (3.5.3-00253-g4699145-dirty)
[   65.244386] MSR: 00001032 <ME,IR,DR,RI>  CR: 24000488  XER: 20000000
[   65.250888] DAR: 00000000, DSISR: 22000000
[   65.255064] TASK = c705cba0[1400] 'cat' THREAD: c716a000
GPR00: 00000000 c716bb70 c705cba0 c7b3060c 00000002 02000006 00000000 00000030 
GPR08: c70f0000 c7b30800 00000000 00000000 c009ada0 100a5a74 10017830 10006834 
GPR16: 10006770 10006774 100170f4 00010000 c00733d8 c75e4a60 00000000 c03ee068 
GPR24: 00000002 00000001 00000002 c03ec460 00000000 00000000 c7a6ccc4 c7a6ccb4 
[   65.289337] NIP [c0066914] xnsynch_flush+0x64/0x100
[   65.294328] LR [c009adf0] rtdm_event_signal+0x50/0xe4
[   65.299474] Call Trace:
[   65.301969] [c716bb70] [00000004] 0x4 (unreliable)
[   65.306864] [c716bba0] [c009adf0] rtdm_event_signal+0x50/0xe4
[   65.312735] [c716bbc0] [cb132588] fpga_dma_done_callback+0x18/0x28 [rt_fpga]
[   65.319934] [c716bbd0] [cb101114] mpc52xx_lpbfifo_bcom_irq+0x114/0x1c4 [rt_mpc52xx_lpbfifo]
[   65.328461] [c716bbe0] [c0060ac8] xnintr_irq_handler+0x70/0x234
[   65.334515] [c716bc20] [c005d15c] __ipipe_dispatch_irq+0x148/0x270
[   65.340832] [c716bc40] [c000d66c] __ipipe_grab_irq+0x38/0x6c
[   65.346615] [c716bc50] [c000f710] __ipipe_ret_from_except+0x0/0xc
[   65.352849] --- Exception: 501 at __ipipe_restore_head+0x84/0xfc
[   65.352849]     LR = __vfile_nklock_put+0x30/0x40
[   65.363775] [c716bd10] [c0069bcc] vfile_stat_next+0x1b0/0x23c (unreliable)
[   65.370795] [c716bd20] [c0072f14] __vfile_nklock_put+0x30/0x40
[   65.376751] [c716bd30] [c00738d0] vfile_snapshot_open+0x29c/0x31c
[   65.382975] [c716bd70] [c011b1c0] proc_reg_open+0x7c/0x11c
[   65.388576] [c716bd90] [c00d1a94] do_dentry_open.isra.18+0x1f4/0x29c
[   65.395064] [c716bdc0] [c00d2ad8] nameidata_to_filp+0x5c/0xa8
[   65.400932] [c716bde0] [c00e11c0] do_last.isra.49+0x260/0x78c
[   65.406796] [c716be30] [c00e17ec] path_openat+0xb4/0x3b0
[   65.412219] [c716be80] [c00e1bdc] do_filp_open+0x30/0x8c
[   65.417641] [c716bf10] [c00d2c20] do_sys_open+0xfc/0x1c8
[   65.423069] [c716bf40] [c000ee0c] ret_from_syscall+0x0/0x38
[   65.428757] --- Exception: c01 at 0xff0f47c
[   65.428757]     LR = 0xffabb94
[   65.436118] Instruction dump:
[   65.439139] 833b0918 63200001 573907fe 901b0918 853e0010 7f89f000 419e00ac 3ba00000 
[   65.447061] 48000044 419a0054 81690004 80090000 <900b0000> 81690000 80090004 900b0004 
[   65.455216] Oops: Kernel access of bad area, sig: 11 [#2]
[   65.460723] mpc5200-simple-platform
[   65.464272] Modules linked in: rt_fpga(O) rt_mpc52xx_lpbfifo(O)
[   65.470319] NIP: 00000000 LR: c0060ac8 CTR: 00000000
[   65.475385] REGS: c716b880 TRAP: 0400   Tainted: G      D    O  (3.5.3-00253-g4699145-dirty)
[   65.483985] MSR: 20001032 <ME,IR,DR,RI>  CR: 24000482  XER: 20000000
[   65.490489] TASK = c705cba0[1400] 'cat' THREAD: c716a000
GPR00: 00000000 c716b930 c705cba0 c7a6ccf0 c7a6ccf0 00000000 c0410c94 00000000 
GPR08: c03ecd78 00000000 00000002 00004000 00000000 100a5a74 10017830 10006834 
GPR16: 10006770 10006774 100170f4 00010000 c00733d8 c75e4a60 00000000 c03ee068 
GPR24: 00000002 c7a6ccf0 00000000 938c6ae2 c041fb40 00000010 c04244b8 c04240b8 
[   65.524729] NIP [00000000]   (null)
[   65.528297] LR [c0060ac8] xnintr_irq_handler+0x70/0x234
[   65.533621] Call Trace:
[   65.536115] [c716b930] [00000001] 0x1 (unreliable)
[   65.541023] [c716b970] [c005d15c] __ipipe_dispatch_irq+0x148/0x270
[   65.547337] [c716b990] [c000d66c] __ipipe_grab_irq+0x38/0x6c
[   65.553118] [c716b9a0] [c000f710] __ipipe_ret_from_except+0x0/0xc
[   65.559348] --- Exception: 501 at ipipe_unstall_root+0x48/0x5c
[   65.559348]     LR = ipipe_unstall_root+0x58/0x5c
[   65.570085] [c716ba70] [c000aa94] die+0x218/0x240
[   65.574892] [c716baa0] [c0010360] bad_page_fault+0xb4/0xfc
[   65.580492] [c716bab0] [c000f2c4] handle_page_fault+0x7c/0x80
[   65.586382] --- Exception: 300 at xnsynch_flush+0x64/0x100
[   65.586382]     LR = rtdm_event_signal+0x50/0xe4
[   65.596674] [c716bb70] [00000004] 0x4 (unreliable)
[   65.601569] [c716bba0] [c009adf0] rtdm_event_signal+0x50/0xe4
[   65.607440] [c716bbc0] [cb132588] fpga_dma_done_callback+0x18/0x28 [rt_fpga]
[   65.614641] [c716bbd0] [cb101114] mpc52xx_lpbfifo_bcom_irq+0x114/0x1c4 [rt_mpc52xx_lpbfifo]
[   65.623168] [c716bbe0] [c0060ac8] xnintr_irq_handler+0x70/0x234
[   65.629216] [c716bc20] [c005d15c] __ipipe_dispatch_irq+0x148/0x270
[   65.635526] [c716bc40] [c000d66c] __ipipe_grab_irq+0x38/0x6c
[   65.641305] [c716bc50] [c000f710] __ipipe_ret_from_except+0x0/0xc
[   65.647541] --- Exception: 501 at __ipipe_restore_head+0x84/0xfc
[   65.647541]     LR = __vfile_nklock_put+0x30/0x40
[   65.658467] [c716bd10] [c0069bcc] vfile_stat_next+0x1b0/0x23c (unreliable)
[   65.665488] [c716bd20] [c0072f14] __vfile_nklock_put+0x30/0x40
[   65.671443] [c716bd30] [c00738d0] vfile_snapshot_open+0x29c/0x31c
[   65.677667] [c716bd70] [c011b1c0] proc_reg_open+0x7c/0x11c
[   65.683272] [c716bd90] [c00d1a94] do_dentry_open.isra.18+0x1f4/0x29c
[   65.689758] [c716bdc0] [c00d2ad8] nameidata_to_filp+0x5c/0xa8
[   65.695627] [c716bde0] [c00e11c0] do_last.isra.49+0x260/0x78c
[   65.701493] [c716be30] [c00e17ec] path_openat+0xb4/0x3b0
[   65.706916] [c716be80] [c00e1bdc] do_filp_open+0x30/0x8c
[   65.712338] [c716bf10] [c00d2c20] do_sys_open+0xfc/0x1c8
[   65.717764] [c716bf40] [c000ee0c] ret_from_syscall+0x0/0x38
[   65.723452] --- Exception: c01 at 0xff0f47c
[   65.723452]     LR = 0xffabb94
[   65.730816] Instruction dump:
[   65.733838] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
[   65.741753] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 



