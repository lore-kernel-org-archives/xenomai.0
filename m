Message-ID: <46543091.3040308@domain.hid>
Date: Wed, 23 May 2007 14:16:17 +0200
From: Rodolfo <rolfetas@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] loading module
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
I am totally new to Xenomai and have no experience with RTAI. I'm trying
to load a kernel module that uses the native API for testing, but I get
the following segmentation fault. Can anyone help me out??
Thanks


Running 2.6.20 Kernel and Xenomai is statically built into the Kernel,
on a VIA Eden

----------------------------------------------------------------------------------------------------------------------------
Jun 13 03:58:04 login[345]: root login on 'ttyS0'


BusyBox v1.5.0 (2007-05-16 14:24:12 CEST) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

# cd usr
# insmod hallo.ko
task start<1>BUG: unable to handle kernel NULL pointer dereference at
virtual address 00000068
 printing eip:
c0157cd9
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: hallo
CPU:    0
EIP:    0060:[<c0157cd9>]    Not tainted VLI
EFLAGS: 00010286   (2.6.20-default #4)
EIP is at rt_task_start+0x25/0x13e
eax: 00000060   ebx: 00000000   ecx: 00000000   edx: 00000286
esi: c8010780   edi: c118716c   ebp: 00000000   esp: c119de88
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 346, ti=c119c000 task=c77ccb10 task.ti=c119c000)
Stack: c011d8ea c800f088 c119deb0 c800f031 c118714c c1187000 c118716c
c800f580
       c800f021 c800f088 c0136cc4 c800f5c8 c033bda6 c800f58c 00000000
00001524
       00000230 c77fbba0 00000260 c0190271 00000000 00000000 00000000
00000000
Call Trace:
 [<c011d8ea>] printk+0x62/0xd6
 [<c800f031>] fun+0x0/0x57 [hallo]
 [<c800f021>] hello_init+0x20/0x30 [hallo]
 [<c0136cc4>] sys_init_module+0x1771/0x18b8
 [<c0190271>] do_sync_read+0xc7/0x10a
 [<c019f0bb>] dput+0x49/0x11f
 [<c0102dbf>] syscall_call+0x7/0xb
 =======================
Code: d8 5b 5e 5f 5d c3 55 57 56 53 83 ec 10 89 c6 8b 1d bc bc 46 c0 89
cd 89 54 24 0c ff 15 44 aa 37 c0 69 c0 c0 03 00 00 8d 44 18 60 <8b> 40
08 85
EIP: [<c0157cd9>] rt_task_start+0x25/0x13e SS:ESP 0068:c119de88
 Segmentation fault



