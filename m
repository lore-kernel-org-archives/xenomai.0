Date: Fri, 26 Sep 2008 12:01:02 +0200
From: "stephane ancelot" <sancelot@domain.hid>
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-ID: <op.uh2130rinuwxn3@domain.hid>
Subject: [Xenomai-core] rt_sem_create bug when registring in proc
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,
I have the following kernel bug, when using a string name in  
rt_sem_create. using NULL as name do not report this problem.

BUG: unable to handle kernel paging request at virtual address de82a268
printing eip: c025d51a *pde = 1dd3e067 *pte = 00000000
Oops: 0000 [#1] PREEMPT
Modules linked in: xxxxxx(P) elok_s(P) e100 mii

Pid: 4, comm: events/0 Tainted: P        (2.6.24.2-ipipe #3)
EIP: 0060:[<c025d51a>] EFLAGS: 00010246 CPU: 0
EIP is at strlen+0xa/0x20
EAX: 00000000 EBX: 00008124 ECX: ffffffff EDX: de82a268
ESI: de82a268 EDI: de82a268 EBP: 00000001 ESP: ddc27e8c
  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Process events/0 (pid: 4, ti=ddc26000 task=ddc19ab0 task.ti=ddc26000)<0>
I-pipe domain Linux
Stack: ddc27ebc c01e445b dde783c0 c0257d2a dde78140 de82a268 de82a268  
c016e7a0
        c048aebc 00000000 c01e46d4 00000001 dde78140 c04fbac4 c016338c  
00000200
        00000000 ffffffff ffffffff 0000007b 00000002 00000000 dde783c0  
dde78140
Call Trace:
  [<c01e445b>] proc_create+0x4b/0x110
  [<c0257d2a>] idr_get_new+0xa/0x30
  [<c016e7a0>] __sem_read_proc+0x0/0x130
  [<c01e46d4>] create_proc_entry+0x44/0x90
  [<c016338c>] registry_proc_callback+0xa1c/0xb00
  [<c01130c1>] update_curr+0x71/0x100
  [<c0113148>] update_curr+0xf8/0x100
  [<c01132ef>] set_next_entity+0x1f/0x50
  [<c0162970>] registry_proc_callback+0x0/0xb00
  [<c0129516>] run_workqueue+0xb6/0x1a0
  [<c039ff8f>] schedule+0x1df/0x3d0
  [<c0129e9d>] worker_thread+0x6d/0xa0
  [<c012d670>] autoremove_wake_function+0x0/0x50
  [<c0129e30>] worker_thread+0x0/0xa0
  [<c012d302>] kthread+0x42/0x70
  [<c012d2c0>] kthread+0x0/0x70
  [<c010398b>] kernel_thread_helper+0x7/0x1c
  =======================
Code: 00 56 89 c6 89 d0 88 c4 ac 38 e0 74 09 84 c0 75 f7 be 01 00 00 00 89  
f0 48 5e c3 8d b6 00 00 00 00 57 b9 ff ff ff ff 89 c7 31 c0 <f2> ae f7 d1  
49 5f 89 c8 c3 8d b6 00 00 00 00 8d bc 27 00 00 00
EIP: [<c025d51a>] strlen+0xa/0x20 SS:ESP 0068:ddc27e8c
---[ end trace 614a6309c2874abe ]---

Best regards
S.Ancelot

