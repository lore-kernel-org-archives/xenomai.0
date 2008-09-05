Message-ID: <48C1053E.4010507@domain.hid>
Date: Fri, 05 Sep 2008 12:09:02 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Oops with ifconfig on Sequioa AMCC 440EPX board
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

Hello,

I get the following Oops with a Xenomai patch kernel when configuring
the EEPRO100 on the PCI slot:

 -bash-3.2# ifconfig eth2 172.16.0.20
------------[ cut here ]------------
Badness at c0025db0 [verbose debug info unavailable]
NIP: c0025db0 LR: c01b5658 CTR: c0190738
REGS: cfaa9d20 TRAP: 0700   Not tainted  (2.6.26.3-dirty)
MSR: 00029000 <EE,ME>  CR: 44002044  XER: 00000004
TASK = cf82b5a0[1052] 'ifconfig' THREAD: cfaa8000
NIP [c0025db0] local_bh_enable+0x84/0x9c
LR [c01b5658] dev_set_rx_mode+0x34/0x48
Call Trace:
[cfaa9dd0] [c01b54bc] __dev_set_rx_mode+0x40/0xb8 (unreliable)
[cfaa9de0] [c01b5658] dev_set_rx_mode+0x34/0x48
[cfaa9e00] [c01b83f8] dev_open+0xd8/0x114
[cfaa9e10] [c01b7244] dev_change_flags+0x8c/0x1b8
[cfaa9e30] [c01f7f58] devinet_ioctl+0x63c/0x77c
[cfaa9ea0] [c01f86f8] inet_ioctl+0xcc/0xf8
[cfaa9eb0] [c01aa878] sock_ioctl+0x60/0x2ec
[cfaa9ed0] [c00ba598] vfs_ioctl+0x34/0x98
[cfaa9ee0] [c00ba8fc] do_vfs_ioctl+0x300/0x430
[cfaa9f10] [c00baa6c] sys_ioctl+0x40/0x74
[cfaa9f40] [c000e1ac] ret_from_syscall+0x0/0x3c
Instruction dump:
80010014 83e1000c 7c0803a6 38210010 4e800020 4bfdde81 4bffffdc 3d20c02f
39297ba0 80090154 7c000034 5400d97e <0f000000> 2f800000 419eff94 38000001
-bash-3.2#
Message from syslogd@ at Thu Jan  1 01:01:21 1970 ...
sequoia666 kernel: ------------[ cut here ]------------

-bash-3.2# uname -a
Linux sequoia666 2.6.26.3-dirty
-bash-3.2# cat /proc/ipipe/version
2.2-04
-bash-3.2# cat /proc/xenomai/version
2.4.5

The NIP is at:

(gdb) l *0xc0025db0
0xc0025db0 is in local_bh_enable (kernel/softirq.c:141).
136	#ifdef CONFIG_TRACE_IRQFLAGS
137		unsigned long flags;
138	
139		WARN_ON_ONCE(in_irq());
140	#endif
141		WARN_ON_ONCE(irqs_disabled());
142	
143	#ifdef CONFIG_TRACE_IRQFLAGS
144		local_irq_save(flags);
145	#endif

Any idea where the problem could be?

TIA.

Wolfgang.

