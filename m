Message-ID: <5076C491.7070007@gmail.com>
Date: Thu, 11 Oct 2012 15:07:29 +0200
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <50729DAB.2080909@gmail.com> <50730FB7.3060604@xenomai.org>
	<5073C8C8.7000606@gmail.com> <5074339F.8050601@xenomai.org>
	<50744677.2090103@gmail.com> <5076B407.30709@gmail.com>
	<5076BE30.50605@xenomai.org> <5076BED1.3020902@xenomai.org>
In-Reply-To: <5076BED1.3020902@xenomai.org>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On 10/11/2012 02:42 PM, Philippe Gerum wrote:
>>> I now strapped down my device driver to the absolute minimum. 
>>> "cat /proc/xenomai/stat" still does crash. But not all the time, and not
>>> always with the same output. Very strange is the "0x100100" in the
>>> output below. This is included in many of the crash reports. Does this
>>> ring a bell?
>>
>> #define LIST_POISON1  ((void *) 0x00100100 + POISON_POINTER_DELTA)
>>
>> Somebody might be doing bad things with memory it does not own anymore?
>>
> 
> Just to rule this out, could you try raising the kernel thread stack
> size this way?
> 
> diff --git a/include/asm-powerpc/system.h b/include/asm-powerpc/system.h
> index 53fd59d..e8dd57c 100644
> --- a/include/asm-powerpc/system.h
> +++ b/include/asm-powerpc/system.h
> @@ -31,7 +31,7 @@
>  #ifdef CONFIG_PPC64
>  #define XNARCH_THREAD_STACKSZ   8182
>  #else
> -#define XNARCH_THREAD_STACKSZ   4096
> +#define XNARCH_THREAD_STACKSZ   8192
>  #endif
> 
>  #define xnarch_stack_size(tcb)  ((tcb)->stacksize)

No, it doesn't fix the problem. But now the 0x100100 doesn't show
in the crash dump any more. 3 times without it. Here one log:

root@generic-powerpc:~# cat /proc/xenomai/stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1295       0     00500080   95.8  ROOT
  0  1402   1          1295       0     00300186    0.6  fpga-loop
  0  0      0          1293       0     00000000    3.4  IRQ16: rt_fpga
  0  0      0          0          0     00000000    0.0  IRQ151: mpc52xx-lpbfifo
  0  0      0          0          0     00000000    0.0  IRQ194: mpc52xx-lpbfifo-rx
  0  0      0          12684      0     00000000    0.2  IRQ512: [timer]
root@generic-powerpc:~# cat /proc/xenomai/stat 
[   51.448640] Unable to handle kernel paging request for data at address 0x81d11f92
[   51.456435] Faulting instruction address: 0xc008ae48
[   51.462066] Oops: Kernel access of bad area, sig: 11 [#1]
[   51.467600] mpc5200-simple-platform
[   51.471543] Modules linked in: rt_fpga(O) rt_mpc52xx_lpbfifo(O)
[   51.477621] NIP: c008ae48 LR: c00b37ac CTR: c008ae2c
[   51.483104] REGS: c7081d90 TRAP: 0300   Tainted: G           O  (3.5.3-00254-g0a88116-dirty)
[   51.492161] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 88422488  XER: 00000000
[   51.498958] DAR: 81d11f92, DSISR: 20000000
[   51.503550] TASK = c724f360[1412] 'cat' THREAD: c7080000
GPR00: c00b37ac c7081e40 c724f360 c7a7cb40 81d11f52 c7081e98 00000000 00000001 
GPR08: 00000000 c0484e38 c0484dd0 00000000 81d11f52 100a5a74 10017830 10006834 
GPR16: 10006770 10006774 81d11f52 00000000 fffff000 0000003e fffff000 00000000 
GPR24: 00000000 c726ada8 00000000 c7afae00 bfb66808 00001000 c7081f20 c7a7cb40 
[   51.539159] NIP [c008ae48] vfile_stat_show+0x1c/0x1a8
[   51.544728] LR [c00b37ac] vfile_snapshot_show+0x2c/0x60
[   51.550070] Call Trace:
[   51.552576] [c7081e40] [c008afb8] vfile_stat_show+0x18c/0x1a8 (unreliable)
[   51.560020] [c7081e80] [c00b37ac] vfile_snapshot_show+0x2c/0x60
[   51.566520] [c7081e90] [c01838e0] seq_read+0x3b0/0x5a0
[   51.571784] [c7081ee0] [c01accb8] proc_reg_read+0x4c/0x70
[   51.577718] [c7081ef0] [c0165148] vfs_read+0xa8/0x184
[   51.582888] [c7081f10] [c0165270] sys_read+0x4c/0x8c
[   51.588383] [c7081f40] [c000ee0c] ret_from_syscall+0x0/0x38
[   51.594086] --- Exception: c01 at 0xff0fb94
[   51.594086]     LR = 0x100064f4
[   51.601934] Instruction dump:
[   51.604989] 807f05b8 7c0803a6 bbc10008 38210010 4e800020 7c8c2379 9421ffc0 7c0802a6 
[   51.613342] 93e1003c 7c7f1b78 90010044 4182011c <812c0040> 39600000 808c0044 7d202379 
[   51.621877] ---[ end trace b1a0c2afe6b0e729 ]---
[   51.631010] ------------[ cut here ]------------
[   51.635846] kernel BUG at mm/slub.c:3474!
[   51.640470] Oops: Exception in kernel mode, sig: 5 [#2]
[   51.645817] mpc5200-simple-platform
[   51.649376] Modules linked in: rt_fpga(O) rt_mpc52xx_lpbfifo(O)
[   51.655441] NIP: c015eb74 LR: c00b42a0 CTR: c00b428c
[   51.660517] REGS: c7081b50 TRAP: 0700   Tainted: G      D    O  (3.5.3-00254-g0a88116-dirty)
[   51.669134] MSR: 00029032 <EE,ME,IR,DR,RI>  CR: 24424424  XER: 00000000
[   51.675921] TASK = c724f360[1412] 'cat' THREAD: c7080000
GPR00: 00000001 c7081c00 c724f360 822c6d2e 822c6d2e c7afae08 00000001 00000000 
GPR08: 00004962 00000000 c700fee0 00000000 24424424 100a5a74 10017830 10006834 
GPR16: 10006770 10006774 81d11f52 00000000 fffff000 0000003e fffff000 00000000 
GPR24: 00000000 c726ada8 c7afae08 00000000 c00b4318 c1d2b8c0 822c6d2e c00b42a0 
[   51.710239] NIP [c015eb74] kfree+0x138/0x150
[   51.714613] LR [c00b42a0] vfile_snapshot_free+0x14/0x24
[   51.719944] Call Trace:
[   51.722443] [c7081c00] [c70b9040] 0xc70b9040 (unreliable)
[   51.727966] [c7081c30] [c00b42a0] vfile_snapshot_free+0x14/0x24
[   51.734018] [c7081c40] [c00b4378] vfile_snapshot_release+0x60/0x88
[   51.740341] [c7081c60] [c01aca10] proc_reg_release+0xd4/0x170
[   51.746224] [c7081c90] [c0166548] fput+0xbc/0x238
[   51.751034] [c7081cb0] [c0162e10] filp_close+0x78/0xa4
[   51.756290] [c7081cd0] [c001e3c0] put_files_struct+0xdc/0xf8
[   51.762075] [c7081cf0] [c001e508] do_exit+0x100/0x6c0
[   51.767240] [c7081d40] [c000aa14] die+0x198/0x240
[   51.772063] [c7081d70] [c0010360] bad_page_fault+0xb4/0xfc
[   51.777674] [c7081d80] [c000f2c4] handle_page_fault+0x7c/0x80
[   51.783574] --- Exception: 300 at vfile_stat_show+0x1c/0x1a8
[   51.783574]     LR = vfile_snapshot_show+0x2c/0x60
[   51.794245] [c7081e40] [c008afb8] vfile_stat_show+0x18c/0x1a8 (unreliable)
[   51.801276] [c7081e80] [c00b37ac] vfile_snapshot_show+0x2c/0x60
[   51.807336] [c7081e90] [c01838e0] seq_read+0x3b0/0x5a0
[   51.812592] [c7081ee0] [c01accb8] proc_reg_read+0x4c/0x70
[   51.818116] [c7081ef0] [c0165148] vfs_read+0xa8/0x184
[   51.823281] [c7081f10] [c0165270] sys_read+0x4c/0x8c
[   51.828360] [c7081f40] [c000ee0c] ret_from_syscall+0x0/0x38
[   51.834057] --- Exception: c01 at 0xff0fb94
[   51.834057]     LR = 0x100064f4
[   51.841519] Instruction dump:
[   51.844547] 7f83e378 7fa4eb78 7fc5f378 7fe6fb78 bb210014 7c0803a6 38210030 4824bc70 
[   51.852483] 801d0000 7009c000 7c000026 54001ffe <0f000000> 7fa3eb78 4bfdb9e5 4bffff80 
[   51.861125] ---[ end trace b1a0c2afe6b0e72a ]---
[   51.866292] 
[   51.868206] Fixing recursive fault but reboot is needed!

Any further ideas?

Thanks,
Stefan




