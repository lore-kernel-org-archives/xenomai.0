Message-ID: <001f01c6e491$c384f7e0$1501a8c0@domain.hid>
From: "Kiichi Kameda" <k-kameda@domain.hid>
Date: Sat, 30 Sep 2006 22:10:12 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] SH4 port
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


After long break, I started testing SH4 port of Xenomai based on Xenomai
2.2.0

My realtime test program is a user space program using POSIX skin , and
runs periodically (1ms interval)

It works well when the load is light.
But with very heavy load such as continuous FTP, the system hangs in several
minutes,
due to panic.

the stack trace shows as follows

======================================================
Unable to handle kernel NULL pointer dereference. at virtual address
00000000
pc = 8c0104a6 <-- dequeue_task
*pde = 00000000
Oops: 0000 [#1]

Pid : 944, Comm:              in.ftpd
PC  : 8c0104a6 SP  : 8d631c00 SR  : 40008101 .TEA : c0198044    .Not
tainted
R0  : 8c19a928 R1  : 8c0104a0 R2  : 00000000 R3  : 8d5db680
R4  : 8d5db680 R5  : 00000000 R6  : 00000000 R7  : 8d5db788
R8  : 8d5db680 R9  : fffffffb R10 : 8d631c9c R11 : 8d5db680
R12 : e9bbfd00 R13 : 000f422e R14 : 8d631c08
MACH: 0000027f MACL: 5c28f7f2 GBR : 29568be0 PR  : 8c0107b6.
Call trace:
===top of stack(8d631c00)
[<8c0107b6>] deactivate_task
[<8c14d616>] schedule
[<8c14e38c>] io_schedule
[<8c035106>] sync_page
[<8c14e776>] __wait_on_bit_lock
[<8c035a64>] __lock_page
[<8c036d10>] filemap_nopage
[<8c04306a>] __handle_mm_fault
[<8c0d98ee>] ide_set_handler
[<8c00e750>] do_page_fault
[<8c0ac7dc>] csum_partial_copy_generic
[<8c122d04>] tcp_sendmsg
[<8c0d79f2>] ide_do_request
[<8c13ed74>] inet_sendmsg
[<8c0f69f6>] do_sock_write
[<8c04cc00>] wait_on_retry_sync_kiocb
[<8c0f6aec>] sock_aio_write
[<8c04cf1a>] do_sync_write
[<8c033024>] __ipipe_sync_stage
[<8c02a320>] autoremove_wake_function
[<8c033136>] __ipipe_dispatch_event
[<8c04cfea>] vfs_write
[<8c04d134>] sys_write
[<8c0062bc>] syscall_call
[<8c04d100>] sys_write
===bottom of stack
======================================================

After tough investigation, I think I found some clues such as:
While in.ftpd runs hard, a "write" system call was issued and Linux
kernel was processing its request.
 But weird __ipipe_dispatch_event and __ipipe_sync_stage was recorded.

I think the problem originates from a Xenomai context switch(which
overwrites "current"), while Linux is processing  system call.
and I am sure that some tricks (preventing such case) must be included
on other platforms.

Any suggestions on preventing such panic?

thank you,
Kiichi Kameda


