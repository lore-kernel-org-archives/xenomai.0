Message-ID: <ff1d78710809020250g57e6d871kf9284a46ae4685ec@domain.hid>
Date: Tue, 2 Sep 2008 11:50:03 +0200
From: "Steven Kauffmann" <steven.kauffmann@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Kernel Oops calling rt_dev_close
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

Hi all,

I'm getting Kernel oops when calling rt_dev_close in my application
[*]. The application creates a new real-time task and in this task
rt_dev_recvfrom is waiting for incoming CAN messages.

In the close function of the application I first call rt_dev_close and
after that I kill the thread with rt_task_delete. I also wait for the
termination of this thread with rt_task_join. But when rt_dev_close is
called, the kernel oops occurs.

I'm using the xenomai 2.4.x branch revision 4163 and Linux kernel 2.6.26.3.

Any ideas?

Regards

Steven

[*] Kernel Oops

Xenomai: watchdog triggered -- killing runaway thread 'Read can rtcan0'
Clocksource tsc unstable (delta = 3150076657 ns)
BUG: unable to handle kernel paging request at 00100104
IP: [<f89d159b>] :xeno_can:rtcan_socket_cleanup+0x8e/0xbb
*pde = 00000000
Oops: 0002 [#1] PREEMPT
Modules linked in: xeno_native ext2 dm_mod loop xeno_can_peak_pci
xeno_can_sja1000 xeno_can
intel_agp agpgart xeno_rtdm  ta_piix libata scsi_mod ehci_hcd uhci_hcd
usbcore e1000 ide_cd_mod cdrom

Pid: 3880, comm: unit_test_rtcan Not tainted (2.6.26.3-ipipe-2.0-09 #1)
EIP: 0060:[<f89d159b>] EFLAGS: 00010046 CPU: 0
EIP is at rtcan_socket_cleanup+0x8e/0xbb [xeno_can]
EAX: 00200200 EBX: f7720e28 ECX: 00000000 EDX: 00100100
ESI: 00000001 EDI: 00000000 EBP: 00000000 ESP: f6ecff2c
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process unit_test_rtcan (pid: 3880, ti=f6ece000 task=f78163a0
task.ti=f6ece000)<0>
I-pipe domain Linux
Stack: f7720e28 00000000 f7720e10 f89d214a f7720e10 00000001 00000000 f88fc1c3
       f78163a0 00000050 f6ecffb8 00000000 00000018 c0139cfc 00000001 00000000
       00000002 c02e6f04 c02e6f00 c012f638 f6ecffb8 00000021 c02e6f00 c0139c6b
Call Trace:
 [<f89d214a>] rtcan_raw_close+0x78/0x7e [xeno_can]
 [<f88fc1c3>] __rt_dev_close+0x8a/0x154 [xeno_rtdm]
 [<c0139cfc>] losyscall_event+0x91/0x13b
 [<c012f638>] __ipipe_dispatch_event+0x96/0x14e
 [<c0139c6b>] losyscall_event+0x0/0x13b
 [<c0109dc3>] __ipipe_syscall_root+0x6f/0xe7
 [<c0102a59>] system_call+0x29/0x4a
 =======================
Code: 75 c7 85 f6 74 9d 8d 83 24 04 00 00 ba 02 00 00 00 e8 92 c3 f2
ff fa 0f ba 2d c0 08 2a c0 00
19 c0 89 c1 83 e1 01 03 00 01 10 00 c7 43 04 00 02 20 00 a1 c0 08
EIP: [<f89d159b>] rtcan_socket_cleanup+0x8e/0xbb [xeno_can] SS:ESP 0068:f6ecff2c
---[ end trace 6b394a1e918d7480 ]---

