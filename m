Message-ID: <46F8A7C0.3030405@domain.hid>
Date: Tue, 25 Sep 2007 08:16:32 +0200
From: Johan Borkhuis <j.borkhuis@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Badness in local_bh_enable at kernel/softirq.c
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

Hello,

I came across the following problem. I don't know if it is Xenomai 
related or not, but I did not see this problem when running is "normal" 
mode.

I have a program to test the interrupt generation of a specific card. 
The interrupts are received and processed correctly. However, when I 
execute this program on a SSH-login I get a number of Badness-reports. 
When I execute the same program on a serial port this does not happen. 
The program generates some output that is send to the shell where the 
program was executed.
Any idea what might be causing this?

This is (one of) the error reports that I saw:
Sep 25 06:07:40 MVME3100-197 kernel: Badness in local_bh_enable at 
kernel/softirq.c:140
Sep 25 06:07:40 MVME3100-197 kernel: Call trace:
Sep 25 06:07:40 MVME3100-197 kernel:  [a00031e8] check_bug_trap+0xa0/0x100
Sep 25 06:07:40 MVME3100-197 kernel:  [a0003ff8] 
ProgramCheckException+0x2d4/0x4e8
Sep 25 06:07:40 MVME3100-197 kernel:  [a0002ba0] 
ret_from_except_full+0x0/0x4c
Sep 25 06:07:40 MVME3100-197 kernel:  [a00281d8] local_bh_enable+0x10/0x60
Sep 25 06:07:40 MVME3100-197 kernel:  [a018add0] lock_sock+0xa4/0xb8
Sep 25 06:07:40 MVME3100-197 kernel:  [a01b5fa4] tcp_sendmsg+0x28/0xc14
Sep 25 06:07:40 MVME3100-197 kernel:  [a01d2c8c] inet_sendmsg+0x50/0x78
Sep 25 06:07:40 MVME3100-197 kernel:  [a018a398] sock_aio_write+0xdc/0x120
Sep 25 06:07:40 MVME3100-197 kernel:  [a0095050] do_sync_write+0xbc/0x12c
Sep 25 06:07:40 MVME3100-197 kernel:  [a009576c] vfs_write+0x198/0x1a0
Sep 25 06:07:40 MVME3100-197 kernel:  [a0096220] sys_write+0x4c/0x90
Sep 25 06:07:40 MVME3100-197 kernel:  [a00024b0] ret_from_syscall+0x0/0x48

One thing all error reports have in common is that the badness is always 
reported in kernel/softirq.c, line 140. Also all reports look like 
network related.

(Kernel version 2.6.14, Xenomai 2.3.2)

Kind regards,
    Johan Borkhuis

