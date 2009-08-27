Date: Thu, 27 Aug 2009 11:53:13 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
Message-ID: <Pine.LNX.4.64.0908271144200.1424@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
ReSent-To: xenomai@xenomai.org
ReSent-Message-ID: <Pine.LNX.4.64.0908271158270.4210@domain.hid>
Subject: [Xenomai-help] Xenomai-head and 2.6.30.5
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

  Have problems with this kernel :

  - adeos-ipipe-2.6.30-x86-2.4-05.patch fails on arch/x86/include/asm/irqflags.h
  - kernel compiled with stack protector panics in __schedule while trying
 	to run any latency test. Backtrace is :

....................................
panic
__stack_check_fail
__schedule
_spin_unlock_irqrestore
try_to_wake_up
__wake_up_common
__ipipe_restore_root
__wake_up_sync_key
schedule
xnshadow_harden
xnshadow_wait_barrier
xnshadow_sys_barrier
iosyscall_event
__ipipe_dispatch_event
iosyscall_event
__ipipe_syscall_root
sysenter_past_esp
....................................

May I need to donwgrade the kernel ?


 		Rus

