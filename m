Message-ID: <48299843.7090307@domain.hid>
Date: Tue, 13 May 2008 15:31:47 +0200
From: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] v2.4.3 bug with system() call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hi,
Using the v2.4.3 +kernel 2.6.24.7 I used the system("touch /tmp/xxx_ok") 
call   in a non realtime init context.

The task is only used to allocate some memory heaps.

I setted up some memory debugging features in the kernel :
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_VM=y
CONFIG_FORCED_INLINING=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_PAGEALLOC=y

 This was not happening with v2.4.2 although that the kernel debugging 
flags were not "on"

here is the bug trace :

------------[ cut here ]------------
kernel BUG at mm/rmap.c:602!
invalid opcode: 0000 [#1] PREEMPT DEBUG_PAGEALLOC
Modules linked in: usb_storage e100 mii

Pid: 1628, comm: creven Not tainted (2.6.24.7-ipipe #3)
EIP: 0060:[<c017fb49>] EFLAGS: 00010246 CPU: 0
EIP is at page_dup_rmap+0x19/0x20
EAX: c115e760 EBX: c115e760 ECX: 08048000 EDX: cc6b1200
ESI: 09cbb025 EDI: 00000025 EBP: 08048000 ESP: cc709ec4
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process creven (pid: 1628, ti=cc708000 task=cc6f6ac0 task.ti=cc708000)<0>
I-pipe domain Linux
Stack: 08003875 c017ae62 cc6b1200 cd5d9e70 cc6b4e70 cc6fa080 cc650080 
08057000
       08057000 c115e760 cd034120 c9cba120 00000000 00000000 08056fff 
00000000
       00000000 c9c6ec80 cc6b1200 00000000 cc6a6ac0 c0115b90 00000000 
00000000
Call Trace:
 [<c017ae62>] copy_page_range+0x2b2/0x580
 [<c0115b90>] copy_process+0x7a0/0x1000
 [<c01165a7>] do_fork+0x47/0x210
 [<c0100bb6>] sys_clone+0x36/0x40
 [<c0102b89>] syscall_call+0x7/0xb
 =======================
Code: 3b 4b 08 0f 93 c0 85 c0 75 ba 5b 89 c8 c3 8d 74 26 00 53 89 c3 83 
78 08 ff 74 10 f6 40 10 01 74 05 e8 3c f4 ff ff ff 43 08 5b c3 <0f> 0b 
eb fe 8d 76 00 83 ec 1c 89 5c 24 0c 89 c3 89 74 24 10 89
EIP: [<c017fb49>] page_dup_rmap+0x19/0x20 SS:ESP 0068:cc709ec4
---[ end trace b9f3cc48844f8a3b ]---
note: creven[1628] exited with preempt_count 2
BUG: scheduling while atomic: creven/1628/0x00000003
Pid: 1628, comm: creven Tainted: G      D 2.6.24.7-ipipe #3
 [<c036bed3>] schedule+0x283/0x390
 [<c036d525>] rwsem_down_failed_common+0x75/0x190
 [<c013cb10>] handle_edge_irq+0xc0/0x150
 [<c036d68d>] rwsem_down_read_failed+0x1d/0x24
 [<c036d6cb>] call_rwsem_down_read_failed+0x7/0xc
 [<c036cb89>] down_read+0x9/0x10
 [<c0118ed4>] exit_mm+0x24/0xd0
 [<c011a632>] do_exit+0x112/0x800
 [<c010410f>] die+0x21f/0x220
 [<c0104523>] do_invalid_op+0x83/0x90
 [<c017fb49>] page_dup_rmap+0x19/0x20
 [<c0111998>] change_page_attr+0x2c8/0x300
 [<c01119ed>] kernel_map_pages+0x1d/0x60
 [<c0170472>] get_page_from_freelist+0x2c2/0x520
 [<c010e78f>] __ipipe_handle_exception+0x7f/0x1c0
 [<c036db5b>] error_code+0x6f/0x7c
 [<c0170000>] setup_per_zone_pages_min+0x1b0/0x1f0
 [<c017fb49>] page_dup_rmap+0x19/0x20
 [<c017ae62>] copy_page_range+0x2b2/0x580
 [<c0115b90>] copy_process+0x7a0/0x1000
 [<c01165a7>] do_fork+0x47/0x210
 [<c0100bb6>] sys_clone+0x36/0x40
 [<c0102b89>] syscall_call+0x7/0xb
 =======================
Best Regards
Steph


