Message-ID: <50F6C3EE.1020508@siemens.com>
Date: Wed, 16 Jan 2013 16:14:54 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: fix domain migration helper
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Philippe,

a first heads-up, maybe you have an idea before I start debugging: That
patch causes troubles when our application shuts down. The main thread
hangs like this, unkillable:

# cat /proc/xenomai/sched
CPU  PID    CLASS  PRI      TIMEOUT   TIMEBASE   STAT       NAME
  0  0      idle    -1      -         master     R          ROOT/0
  1  0      idle    -1      -         master     R          ROOT/1
  2  0      idle    -1      -         master     R          ROOT/2
  3  0      idle    -1      -         master     R          ROOT/3
  4  0      idle    -1      -         master     R          ROOT/4
  5  0      idle    -1      -         master     R          ROOT/5
  6  0      idle    -1      -         master     R          ROOT/6
  7  0      idle    -1      -         master     R          ROOT/7
  8  0      idle    -1      -         master     R          ROOT/8
  9  0      idle    -1      -         master     R          ROOT/9
 10  0      idle    -1      -         master     R          ROOT/10
 11  0      idle    -1      -         master     R          ROOT/11
  0  2435   rt       0      -         master     X          ShadowTask_2435
# cat /proc/2435/stack
[<ffffffff810b5b94>] xnpod_suspend_thread+0x434/0x570
[<ffffffff810beb30>] xnshadow_relax+0xe0/0x240
[<ffffffff810c08e3>] losyscall_event+0x1c3/0x280
[<ffffffff8109e73a>] ipipe_syscall_hook+0x5a/0x90
[<ffffffff8109c311>] __ipipe_notify_syscall+0x131/0x2e0
[<ffffffff8101e841>] __ipipe_syscall_root+0x41/0x160
[<ffffffff8126a41a>] __ipipe_syscall_root_thunk+0x35/0x67
[<ffffffffffffffff>] 0xffffffffffffffff

This was with your current core-3.5 branch.

I'm currently updating my virtual debug environment. The issue may also
be reproducible with standard Xenomai tests.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

