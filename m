Message-ID: <5076B407.30709@gmail.com>
Date: Thu, 11 Oct 2012 13:56:55 +0200
From: Stefan Roese <stefan.roese@gmail.com>
MIME-Version: 1.0
References: <50729DAB.2080909@gmail.com> <50730FB7.3060604@xenomai.org>
	<5073C8C8.7000606@gmail.com> <5074339F.8050601@xenomai.org>
	<50744677.2090103@gmail.com>
In-Reply-To: <50744677.2090103@gmail.com>
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

On 10/09/2012 05:44 PM, Stefan Roese wrote:
> On 10/09/2012 04:24 PM, Philippe Gerum wrote:
>> On 10/09/2012 08:48 AM, Stefan Roese wrote:
>>
>>> [   65.601569] [c716bba0] [c009adf0] rtdm_event_signal+0x50/0xe4
>>> [   65.607440] [c716bbc0] [cb132588] fpga_dma_done_callback+0x18/0x28 [rt_fpga]
>>> [   65.614641] [c716bbd0] [cb101114] mpc52xx_lpbfifo_bcom_irq+0x114/0x1c4 [rt_mpc52xx_lpbfifo]
>>
>> Is any list corruption detected when CONFIG_XENO_OPT_DEBUG_QUEUES is
>> enabled?
> 
> No, I don't see any list corruptions with CONFIG_XENO_OPT_DEBUG_QUEUES
> enabled. But the crash log is different now. At least part of the
> "stat" is printed. And the crash happens now in xnintr_irq_handler().
> This different crash seems to result from a change of the kernel
> config (I enabled/disabled some other drivers as well in the meantime).
> I'm debugging now, how different kernel configurations result in different
> crash scenarios.

I now strapped down my device driver to the absolute minimum. 
"cat /proc/xenomai/stat" still does crash. But not all the time, and not
always with the same output. Very strange is the "0x100100" in the
output below. This is included in many of the crash reports. Does this
ring a bell?

(latest git xenomai-2.6 with latest core-3.5 ipipe on mpc5200)

root@generic-powerpc:~# cat /proc/xenomai/stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1458       0     00500080   99.2  ROOT
  0  1401   1          1458       0     00300186    0.1  fpga-loop
  0  0      0          1456       0     00000000    0.6  IRQ16: rt_fpga
  0  0      0          0          0     00000000    0.0  IRQ151: mpc52xx-lpbfifo
  0  0      0          0          0     00000000    0.0  IRQ194: mpc52xx-lpbfifo-rx
  0  0      0          10306      0     00000000    0.1  IRQ512: [timer]
root@generic-powerpc:~# cat /proc/xenomai/stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1546       0     00500080   95.9  ROOT
  0  1401   1          1546       0     00300186    0.5  fpga-loop
  0  0      0          1544       0     00000000    3.4  IRQ16: rt_fpga
  0  0      0          0          0     00000000    0.0  IRQ151: mpc52xx-lpbfifo
  0  0      0          0          0     00000000    0.0  IRQ194: mpc52xx-lpbfifo-rx
  0  0      0          10542      0     00000000    0.2  IRQ512: [timer]
root@generic-powerpc:~# cat /proc/xenomai/stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          1655       0     00500080   95.9  ROOT
  0  1401   1          1655       0     00300186    0.5  fpga-loop
  0  0      0          1653       0     00000000    3.4  IRQ16: rt_fpga
  0  0      0          0          0     00000000    0.0  IRQ151: mpc52xx-lpbfifo
  0  0      0          0          0     00000000    0.0  IRQ194: mpc52xx-lpbfifo-rx
  0  0      0          10833      0     00000000    0.2  IRQ512: [timer]
root@generic-powerpc:~# cat /proc/xenomai/stat 
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
[   45.161337] Unable to handle kernel paging request for data at address 0x7ffffff7
[   45.174889] Faulting instruction address: 0xc015ea7c
[   45.180048] Oops: Kernel access of bad area, sig: 11 [#1]
[   45.186022] mpc5200-simple-platform
[   45.189595] Modules linked in: rt_fpga(O) rt_mpc52xx_lpbfifo(O)
[   45.196088] NIP: c015ea7c LR: c00b42a0 CTR: c00b428c
[   45.201171] REGS: c709ddb0 TRAP: 0300   Tainted: G           O  (3.5.3-00254-g0a88116-dirty)
[   45.210190] MSR: 00009032 <EE,ME,IR,DR,RI>  CR: 48004424  XER: 00000000
[   45.217416] DAR: 7ffffff7, DSISR: 20000000
[   45.221608] TASK = c70c1740[1409] 'cat' THREAD: c709c000
GPR00: ffffffbf c709de60 c70c1740 aa883045 aa883045 c7b1f408 00000001 00000000 
GPR08: 000048dd 00008000 c734cec0 00000001 28004424 100a5a74 10017830 10006834 
GPR16: 10006770 10006774 100170f4 00000000 bfc331e0 100a1008 00000000 1007d050 
GPR24: bfc65f29 00000027 c7b1f408 00000000 c00b4318 7ffffff7 aa883045 c00b42a0 
[   45.257605] NIP [c015ea7c] kfree+0x40/0x150
[   45.261896] LR [c00b42a0] vfile_snapshot_free+0x14/0x24
[   45.267628] Call Trace:
[   45.270153] [c709de60] [00100100] 0x100100 (unreliable)
[   45.275506] [c709de90] [c00b42a0] vfile_snapshot_free+0x14/0x24
[   45.281965] [c709dea0] [c00b4378] vfile_snapshot_release+0x60/0x88
[   45.288294] [c709dec0] [c01aca10] proc_reg_release+0xd4/0x170
[   45.294591] [c709def0] [c0166548] fput+0xbc/0x238
[   45.299835] [c709df10] [c0162e10] filp_close+0x78/0xa4
[   45.305092] [c709df30] [c0162ed8] sys_close+0x9c/0xd8
[   45.310689] [c709df40] [c000ee0c] ret_from_syscall+0x0/0x38
[   45.316392] --- Exception: c01 at 0xff0fb20
[   45.316392]     LR = 0x1004dc44
[   45.324149] Instruction dump:
[   45.327195] 7fe802a6 7c7e1b78 90010034 409d00a8 3d20c04a 3fa34000 81294254 57bdc9f4 
[   45.335552] 7c09e82e 7fa9ea14 70098000 4082010c <801d0000> 700b0080 418200e0 3f60c048 
[   45.344089] ---[ end trace a562bf2537c91283 ]---
[   45.348807] 
Segmentation fault

Thanks,
Stefan



