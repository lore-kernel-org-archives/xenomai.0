From: "Rob Stocks" <rjs@domain.hid>
Date: Tue, 29 Sep 2009 11:30:59 +0100
Message-ID: <021401ca40ef$f0503470$d0f09d50$@biz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-gb
Subject: [Xenomai-help] Kernel panic on reboot (Xenomai 2.4.9.1,
	kernel 2.6.31, x86 SMP)
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

We have a problem with Xenomai v2.4.9.1, kernel 2.6.31, x86 SMP in that we
get a kernel panic on reboot:

	swapper[0]: segfault at 15aba ip 0000e6ba sp 00000189 error 4
	no vm86_info: BAD
	Kernel panic - not syncing: Attempted to kill the idle task!
	Pis: 0, comm.: swapper Not tainted 2.6.31-CROCUS #1
	Call Trace:
	 [<810280cb>] panic+0x49/0xed
	 [<8102a6f6>] do_exit+0x55/0xdc4
	 [<81028fec>] ? printk+0x9f/0x104
	 [<810031ec>] ? reboot_interrupt+0x0/0x38
	 [<81014af7>] save_v86_state+0xa6/0x168
	 [<810031ec>] ? reboot_interrupt+0x0/0x38
	 [<81002ac6>] work_notifysig_v86+0x06/0x18
	 [<810031ec>] ? reboot_interrupt+0x0/0x38
	reboot[1781]: segfault at 15aba ip 0000e6ba sp 00000189 error 4
	no vm86_info: BAD

Other than this, it seems to work fine.

We had previously been using v2.4.7, kernel 2.6.28.7 which does not have
this issue but for development, we would like to use X and we find that some
X applications (e.g. Netbeans & eclipse) hang the system (with no indication
of cause i.e. no console messages & nothing in the logs - the system just
stops). However, when we use v2.4.9.1 with kernel 2.6.31, we can use X apps
perfectly but we can't reboot!

Anyone have any ideas/suggestions?




