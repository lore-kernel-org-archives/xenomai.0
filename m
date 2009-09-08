From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <EA8B423DB69FD24FA233008019A052AED867CB@zue-s-15.zue.zwick.de>
References: <EA8B423DB69FD24FA233008019A052AED867CB@zue-s-15.zue.zwick.de>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 20:56:25 +0200
Message-Id: <1252436185.2693.93.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Kernel panic with xenomai 2.4.7
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Meier, Hans" <Hans.Meier@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-09-08 at 19:48 +0200, Meier, Hans wrote:
> Hi,
> 
> we have been using xenomai for a long time and now for the first time we
> have a kernel panic we would like you to have a look at (see below).
> 
> The panic (if all is the same thing) up to now has only occurred after
> >5h and <48h up time of our application on a core duo with linux
> 2.6.28.7 patched with xenomai 2.4.7. Other, very recent tests with linux
> 2.6.30 and xenomai 2.4.9 and xenomai 2.4.9.1 haven't shown any trouble
> up to now, and reached >60h with the first trial. Other versions we
> haven't tested yet.
> 
> So could you please take a look at the panic output (the only one we
> could see on the screen up to now, originally just a screen photographed
> with a mobile ...)? Might this be anything known and maybe fixed in
> xenomai 2.4.9? If not, can you guess what that might be from those few
> lines? This would help a lot! .config is attached, if you need more
> info, we will certainly provide it.

Regarding this particular issue, I would suspect a CPU migration bug we
had until I-pipe 2.6.29.4-x86-2.4-00. You may want to try this patch
with 2.4.7 to see if I'm right. Aside of this, 2.4.7 -> 2.4.9 closed
quite a few bugs as well, but I would rather think of a pipeline issue
in the case below.

> 
> Thanks in advance 
> 
> Hans
> 
> --
>   
> [<c010f288>] ? stop_this_cpu+0x0/0x48
> [<c013e959>] smp_call_function+0x2a/0x53
> [<c010f3c2>] native_smp_send_stop+0x20/0x65
> [<c01234b4>] panic+0x5d/0xf4
> [<c036fe43>] oops_end+0x81/0x95
> [<c01060e8>] die+0x5c/0x64
> [<c03714e8>] do_page_fault+0x5aa/0x660
> [<c0115207>] __ipipe_handle_exception+0x1c6/0x209
> [<c036f095>] ? _spin_unlock_irq+0x19/0x2d
> [<c036f433>] error_code+0x77/0x84
> [<c036f095>] ? _spin_unlock_irq+0x19/0x2d
> [<c03600d8>] ? krb5_encrypt+0xd8/0xde
> [<c010628f>] ? profile_pc+0x32/0x3b
> [<c0138a1b>] profile_tick+0x4a/0x63
> [<c013bb12>] tick_periodic+0x66/0x68
> [<c013bb31>] tick_handle_periodic+0x1d/0x60
> [<c011093a>] smp_apic_timer_interrupt+0x61/0x74
> [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
> [<c0151c5e>] __ipipe_sync_stage+0x139/0x13e
> [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
> [<c0151c63>] ? __xirq_end+0x0/0x45
> [<c0151e05>] ipipe_suspend_domain+0x98/0xdb
> [<c0151ecf>] __ipipe_walk_pipeline+0x87/0xc8
> [<c0151f9b>] __ipipe_dispatch_wired_nocheck+0x8b/0x92
> [<c015285f>] __ipipe_dispatch_wired+0x64/0x67
> [<c0114b9e>] __ipipe_handle_irq+0xb2/0x1d7
> [<c0104821>] ipipe_ipi3+0x35/0x58
> [<c02f9261>] dev_hard_start_xmit+0x261/0x268
> [<c03062a1>] ? __qdisc_run+0xcc/0x1af
> [<c02fb8ae>] dev_queue_xmit+0x311/0x42b
> [<c0311aa9>] ? ip_finish_output+0x21f/0x259
> [<c0151451>] ? ipipe_check_context+0xa/0xec
> [<c03126d8>] ? ip_output+0x71/0x76
> [<c03106a8>] ? ip_local_out+0x1d/0x20
> [<c031298d>] ? ip_queue_xmit+0x2b0/0x317
> [<c011c54a>] ? default_wake_function+0x0/0x12
> [<c0114ec4>] ? __ipipe_unstall_iret_root+0x64/0x68
> [<c0103be3>] ? restore_nocheck_notrace+0x0/0xe
> [<c02f2659>] ? __copy_skb_header+0xe/0xe0
> [<c031f703>] ? __tcp_select_window+0xe/0x126
> [<c0151451>] ? ipipe_check_context+0xa/0xec
> [<c0320102>] ? tcp_transmit_skb+0x564/0x59e
> [<c0110955>] ? native_apic_mem_write+0x8/0x1a
> [<c0321747>] ? __tcp_push_pending_frames+0x626/0x6c4
> [<c031f98b>] ? tcp_current_mss+0xa2/0xc3
> [<c024be8e>] ? __copy_from_user_ll+0xa/0xd8
> [<c024c1be>] ? copy_from_user+0x3b/0x5e
> [<c031813b>] ? tcp_sendmsg+0x7d3/0x8b4
> [<c0111802>] ? unmask_IO_APIC_irq+0xab/0xb2
> [<c02ee6a5>] ? sock_aio_write+0xe5/0xee
> [<c01b1c41>] ? do_sync_readv_writev+0xae/0xec
> [<c01342e5>] ? autoremove_wake_funtion+0x0/0x35
> [<c024be8e>] ? __copy_from_user_ll+0xa/0xd8
> [<c024c1be>] ? copy_from_user+0x3b/0x5e
> [<c022dbe5>] ? cap_file_permission+0x8/0xc
> [<c022cb78>] ? security_file_permission+0x14/0x16
> [<c01b227a>] ? do_readv_writev+0x86/0x141
> [<c02ee5c0>] ? sock_aio_write+0x0/0xee
> [<c0162ed7>] ? Iosyscall_event+0xe/0x168
> [<c01b2373>] ? vfs_writev+0x3e/0x4e
> [<c01b2715>] ? sys_writev+0x40/0x65
> [<c0103aaa>] ? sysenter_do_call+0x12/0x16
> ---[ end trace a1134258cad770fd ]---
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



