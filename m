Message-ID: <1470778428.18945.7.camel@henry-ThinkCentre-M93p>
From: Henry Bausley <hbausley@deltatau.com>
Date: Tue, 09 Aug 2016 14:33:48 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] LS1021ARM Occasional Crash on Startup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org


We are seeing an occasional kernel BUG error on startup.
We are using xenomai 2.6.4 with ipipe 3.14.28 on a freescale LS1021A
processor.  Any suggestions or known issues that we can check into.

r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
r8169 0000:01:00.0 eth2: RTL8168e/8111e at 0xc09de0003
r8169 0000:01:00.0 eth2: jumbo features [frames: 9200]
[....] Waiting for /dev to be fully populated...------
kernel BUG at arch/arm/mm/pgd.c:120!
Internal error: Oops - BUG: 0 [#1] SMP ARM
Modules linked in: r8169 mii firmware_class
CPU: 0 PID: 252 Comm: udevd Not tainted 3.14.28-ipipe1
task: bd126000 ti: bd156000 task.ti: bd156000
PC is at pgd_free+0x108/0x268
LR is at _raw_spin_unlock_irqrestore+0x20/0x24
pc : [<800186d4>]    lr : [<80567adc>]    psr: 6000003
sp : bd157db8  ip : bd157da0  fp : bd157dec
r10: 8074e880  r9 : 00000002  r8 : 00000000
r7 : be720680  r6 : 00000000  r5 : be770b80  r4 : be70
r3 : be7203c0  r2 : 3f88b000  r1 : bffd6860  r0 : 0000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  r
Control: 30c53c7d  Table: bd10c780  DAC: fffffffd
Process udevd (pid: 252, stack limit = 0xbd156240)
Stack: (0xbd157db8 to 0xbd158000)
7da0:                                                8
7dc0: 8003df98 8001a660 bd11d880 00000000 00000001 be4
7de0: bd157e04 bd157df0 8001cd48 800185d8 be00e800 bd8
7e00: 80040e90 8001cd28 00000000 8074e880 8075874c bd8
7e20: 80564d5c 80040e24 000000a8 76e64000 bd1468f0 be0
7e40: 00000002 00000000 bd156000 00000000 bd157e6c bdc
7e60: bd157e9c bd157e70 805672f8 80564ec8 bd0c9dd8 be0
7e80: be6fabd4 bd13edd0 00000000 00000000 bd157eac bd4
7ea0: bd157ec4 bd157eb0 80566df8 80567354 bd12fe70 bd8
7ec0: 801230a4 80566de8 bd157ee4 0000004b 0004b000 000
7ee0: 00000000 bd12fe70 bd11ca80 00062000 80785848 bd8
7f00: 00000000 00000000 bd156000 bd13ed00 bd157f4c bd4
7f20: bd0d0680 bd157f30 80122918 bd11ca80 00000000 008
7f40: bd157f7c bd157f50 80123df4 8012343c 8056735c 800
7f60: 00062000 00062000 bd11cac4 00000000 bd157fa4 bd8
7f80: 76eb8000 0006c000 ffff6000 76eb9b88 0000002d 808
7fa0: 8000e500 801246e0 0006c000 ffff6000 00062000 760
7fc0: 0006c000 ffff6000 76eb9b88 0000002d 76eb8964 00c
7fe0: 0000002d 7edccc28 76e64841 76dedf96 20000030 00f
Backtrace: 
[<800185cc>] (pgd_free) from [<8001cd48>] (__mmdrop+0)
 r9:8074dbf4 r8:bd11ca80 r7:be00e800 r6:00000001 r5:00
[<8001cd1c>] (__mmdrop) from [<80040e90>] (finish_tas)
 r5:bd11d880 r4:be00e800
[<80040e18>] (finish_task_switch) from [<80564d5c>] ()
 r6:bd156000 r5:8075874c r4:8074e880 r3:00000000
[<80564a50>] (__schedule) from [<80564f54>] (schedule)
 r10:00000000 r9:bd156000 r8:00000000 r7:00000002 r6:8
 r4:be6fabd4
[<80564ebc>] (schedule) from [<805672f8>] (__down_wri)
[<80567278>] (__down_write_nested) from [<8056735c>] )
 r7:00000000 r6:00000000 r5:bd13edd0 r4:be6fabd4
[<80567348>] (__down_write) from [<80566df8>] (down_w)
[<80566ddc>] (down_write) from [<801230a4>] (vma_adju)
 r4:bd13ed68 r3:bd12fe70
[<80122ed8>] (vma_adjust) from [<80123534>] (__split_)
 r10:bd13ed00 r9:bd156000 r8:00000000 r7:00000000 r6:0
 r4:bd0d0680
[<80123430>] (__split_vma.isra.21) from [<80123df4>] )
 r8:bd13ed68 r7:00062000 r6:0006c000 r5:00000000 r4:b0
[<80123d3c>] (do_munmap) from [<80124798>] (SyS_brk+0)
 r10:00000000 r8:bd11cac4 r7:00062000 r6:00062000 r5:0
[<801246d4>] (SyS_brk) from [<8000e500>] (ret_fast_sy)
 r8:8000e6e8 r7:0000002d r6:76eb9b88 r5:ffff6000 r4:00
Code: 1affffea e59f0154 e1a01006 eb153cf9 (e7f001f2) 
---[ end trace cfa666029e99279a ]---
done.




Outbound scan for Spam or Virus by Barracuda at Delta Tau


