Message-ID: <48E12C7D.4050802@domain.hid>
Date: Mon, 29 Sep 2008 15:29:01 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Ipipe causes PCI / USB crash
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I have a Sequoia (PPC440EPx) evaluation board, with an Agere USB interface
plugged into the PCI bus.  The kernel is DENX 2.6.26.1 with Ipipe 2.2-04
from the xenomai-2.4.5 release.

If Ipipe is included in my .config, then when I plug in a Sandisk flash
device, I get the crash shown below.  If I remove Ipipe from the .config,
then the flash device works correctly.

Please let me know if additional information is needed to help diagnose this.

	Thanks,
	Steve


Badness at c012c190 [verbose debug info unavailable]
NIP: c012c190 LR: c012c250 CTR: 00000000
REGS: cec8fa80 TRAP: 0700   Not tainted  (2.6.26.1-00044-g93df51c-dirty)
MSR: 00029000 <EE,ME>  CR: 24082048  XER: 20000004
TASK = cf8c6d60[933] 'usb-stor-scan' THREAD: cec8e000
GPR00: 00000001 cec8fb30 cf8c6d60 cf3bc810 00000000 cf3c3708 00000001 c012c2a0
GPR08: 00000000 c0330000 ced0e060 cec8fb5c 44082042 00000000 00000000 cec8fe09
GPR16: 00000024 cec8fe00 c02d2ea8 c02d300c cec9ee00 c02d3050 cec8fc70 cecfb400
GPR24: cec9ea00 00001d4c ced0eb40 cf3bc810 00000001 cf3bc810 00000000 cf3c3708
NIP [c012c190] blk_execute_rq_nowait+0x40/0x90
LR [c012c250] blk_execute_rq+0x70/0xc0
Call Trace:
[cec8fb30] [00029000] 0x29000 (unreliable)
[cec8fb50] [c012c250] blk_execute_rq+0x70/0xc0
[cec8fbe0] [c01835e4] scsi_execute+0xdc/0x128
[cec8fc10] [c01836b4] scsi_execute_req+0x84/0xcc
[cec8fc50] [c018a258] sd_revalidate_disk+0x2a4/0x144c
[cec8fcd0] [c018bf90] sd_probe+0x20c/0x39c
[cec8fd10] [c01634dc] driver_probe_device+0xb8/0x1e8
[cec8fd30] [c0162680] bus_for_each_drv+0x70/0xac
[cec8fd60] [c016375c] device_attach+0x84/0xa8
[cec8fd80] [c0162474] bus_attach_device+0x6c/0x78
[cec8fd90] [c0160f1c] device_add+0x400/0x53c
[cec8fdd0] [c0187fa8] scsi_sysfs_add_sdev+0x4c/0x24c
[cec8fdf0] [c01859e8] scsi_probe_and_add_lun+0x9ec/0xa4c
[cec8fe80] [c0185d68] __scsi_scan_target+0xec/0x680
[cec8ff40] [c0186380] scsi_scan_channel+0x84/0xa4
[cec8ff60] [c01864b0] scsi_scan_host_selected+0x110/0x184
[cec8ff90] [c01dd100] usb_stor_scan_thread+0x5c/0x134
[cec8ffd0] [c0036e74] kthread+0x48/0x84
[cec8fff0] [c000df2c] kernel_thread+0x44/0x60
Instruction dump:
90850064 80050014 90e500bc 60000040 90050014 3d20c033 80096898 7cc60034
54c6d97e 540007fe 38c60001 7c7d1b78 <0f000000> 3d60c033 392b6898 38000001

