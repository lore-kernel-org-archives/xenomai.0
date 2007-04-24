Message-ID: <6fe1d5d0704240718t4d220b8dv4d6ddc3ae227f1c@domain.hid>
Date: Tue, 24 Apr 2007 16:18:34 +0200
From: "Sven Kjaergaard" <sven.kjaergaard@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Driver port to xenomai
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

Hi,

I have to port a driver mainly written for VxWorks to Xenomai. In this
way, I link it with the vxworks skin and it built successfully.

But when inserting the module in the kernel (with debug nucleus set)
the following  error occur meaning that the driver is in the linux
domain and not in the priority one. What did I missed ? Did I have to
convert some call to rthal_ ones for those where the corresponding
function exists ? I don't think rtdm is mandatory for driver writting
?

TIA for any tips,
Sven

Xenomai: fatal: attempt to suspend root thread ROOT
  CPU  PID    PRI      TIMEOUT  STAT      NAME
  0    0       -1      0        00400080  ROOT
Timer: periodic [tickval=1000000 ns, elapsed=10965]

[<c00223f0>] (show_stack+0x0/0x54) from [<c0060d34>] (xnpod_suspend_thread
+0x24c/0)[<c0060ae8>] (xnpod_suspend_thread+0x0/0x58c) from [<bf006418>]
(taskDelay+0x7c/0x)[<bf00639c>] (taskDelay+0x0/0x120 [xeno_vxworks]) from
[<bf011130>] (bus_init+) r6 = BF016304  r5 = C1CAF400  r4 = 000003E8
[<bf011090>] (bus_init+0x0/0x6a4 [rtconbus]) from [<bf01a0f8>]
(rtconbus_init+) r7 = BF015B00  r6 = C28633FC  r5 = C1CAF400  r4 = BF015C80
[<bf01a000>] (rtconbus_init+0x0/0x284 [rtconbus]) from [<c0051c6c>]
(sys_init_modu) r4 = BF015B00 [<c0051b34>] (sys_init_module+0x0/0x15b8)
from [<c001e3a4>] (ret_fast_syscall+0x0/)

