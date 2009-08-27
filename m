From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0908271144200.1424@domain.hid>
References: <Pine.LNX.4.64.0908271144200.1424@domain.hid>
Content-Type: text/plain
Date: Thu, 27 Aug 2009 11:23:40 +0200
Message-Id: <1251365020.3052.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai-head and 2.6.30.5
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2009-08-27 at 11:53 +0300, Rus V. Brushkoff wrote:
> 	Hi,
> 
>   Have problems with this kernel :
> 
>   - adeos-ipipe-2.6.30-x86-2.4-05.patch fails on arch/x86/include/asm/irqflags.h

This hunk can be fixed manually; there seems to be annoying whitespace
changes in the way. 

>   - kernel compiled with stack protector panics in __schedule while trying
>  	to run any latency test. Backtrace is :
> 

Our task switch code does not support CC_STACKPROTECTOR yet; since we
don't update the switch canary word, the vanilla checks likely choke on
our switches. You may want to disable this option for running
Xenomai/x86.

> ....................................
> panic
> __stack_check_fail
> __schedule
> _spin_unlock_irqrestore
> try_to_wake_up
> __wake_up_common
> __ipipe_restore_root
> __wake_up_sync_key
> schedule
> xnshadow_harden
> xnshadow_wait_barrier
> xnshadow_sys_barrier
> iosyscall_event
> __ipipe_dispatch_event
> iosyscall_event
> __ipipe_syscall_root
> sysenter_past_esp
> ....................................
> 
> May I need to donwgrade the kernel ?
> 
> 
>  		Rus
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



