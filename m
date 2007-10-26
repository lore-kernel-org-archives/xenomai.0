Message-ID: <47220255.4040309@domain.hid>
Date: Fri, 26 Oct 2007 11:05:57 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] clocktest and cyclictest work but irqloop crashes
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I am testing kernel 2.6.23 ARCH=powerpc with Xenomai 2.4-rc4.  The 
clocktest and cyclictest work perfectly with the uic/spinlock patches.  
However, the irqloop test fails with the Oops shown below.

    Steve

# modprobe xeno_irqbench
# lsmod
Module                  Size  Used by    Not tainted
xeno_irqbench           9668  0
# /usr/xenomai/bin/irqloop
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#1]
Netdec
Modules linked in: xeno_irqbench
NIP: 00000000 LR: c016d368 CTR: 00000000
REGS: c0f3dd20 TRAP: 0400   Not tainted  (2.6.23)
MSR: 00029030 <EE,ME,IR,DR>  CR: 24000488  XER: 00000000
TASK = c032dc00[665] 'irqloop' THREAD: c0f3c000
GPR00: 00000000 c0f3ddd0 c032dc00 00000004 00000000 c0049e50 c02b0000 
00000000
GPR08: c0296868 00000000 c028e0cc 00000000 000003ff 1001a8d8 00ff9900 
00000001
GPR16: c02c0000 c0f3df50 c02ba360 c02a0000 00000040 fffffff0 00000010 
c0296868
GPR24: c02a0000 c02b0000 c0d54898 00000018 c0f3de2c 00000000 00000000 
c0d50040
NIP [00000000] 0x0
LR [c016d368] rthal_irq_enable+0x4c/0x64
Call Trace:
[c0f3ddd0] [c0049ad8] xnintr_attach+0xd8/0xf0 (unreliable)
[c0f3dde0] [c0049860] xnintr_enable+0x14/0x24
[c0f3ddf0] [c007cf90] rtdm_irq_request+0x6c/0x94
[c0f3de10] [c201acbc] rt_irqbench_ioctl_nrt+0x5c0/0x654 [xeno_irqbench]
[c0f3de60] [c007bef8] __rt_dev_ioctl+0x80/0x138
[c0f3dea0] [c007de4c] sys_rtdm_ioctl+0x20/0x30
[c0f3deb0] [c0054a80] losyscall_event+0xc8/0x1d0
[c0f3dee0] [c0046d7c] __ipipe_dispatch_event+0xa4/0x208
[c0f3df30] [c0007cc8] __ipipe_syscall_root+0x40/0xf0
[c0f3df40] [c000d92c] DoSyscall+0x20/0x5c
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
Segmentation fault


