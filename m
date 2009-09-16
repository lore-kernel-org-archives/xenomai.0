Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2009 11:40:08 +0200
Message-ID: <EA8B423DB69FD24FA233008019A052AEE4CFBA@zue-s-15.zue.zwick.de>
In-Reply-To: <EA8B423DB69FD24FA233008019A052AEDB2084@domain.hid>
References: <EA8B423DB69FD24FA233008019A052AED867CB@zue-s-15.zue.zwick.de><1252436185.2693.93.camel@domain.hid>
	<EA8B423DB69FD24FA233008019A052AEDB2084@domain.hid>
From: "Meier, Hans" <Hans.Meier@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Hi Philippe,=20
hi Jan

Here we are with a full log of our oops on 2.6.28.7/2.4.7.
Config is identical with exception of "oops to serial".
As far as I can see this should be the same thing, even if there are =
some differences compared to the part of the log that came out on the =
screen last time.

Meanwhile we tested a lot with 2.6.30/2.4.9.1 on up to six targets =
without having seen any oops. So from our perspective this issue has =
been fixed on the way from 2.6.28.7/2.4.7 to 2.6.30/2.4.9.1.

Is the oops below what you expected?=20
Does it then still make sense to focus on the step from ipipe =
2.6.29.1-x86-2.3-01 to 2.6.29.4-x86-2.4-00 with 2.4.7 to see whether =
this step makes the oops disappear?

Best regards

Hans


---


Oops: 0000 [#1] PREEMPT SMP
last sysfs file: /sys/firmware/edd/int13_dev80/extensions
Modules linked in: zirqack zmodule zbaseboard zwatchdog z7segdisplay =
zbaseboarddetect ziomemmap loop i2c_i801 i2c_core intel_agp agpgart =
nls_cp437 nls_iso8859_1 vfat fat ide_core ohci_hcd edd dm_mod =
usb_storage reiserfs sg sd_mod mptspi mptscsih mptbase =
scsi_transport_spi ata_piix ahci libata scsi_mod [last unloaded: =
zbaseboarddetect]

Pid: 3463, comm: ZwickAppConsole Not tainted =
(2.6.28.7-xenomai-2.4.7-modcom.420 #1) CX-945 CPU Board
EIP: 0060:[<c010628f>] EFLAGS: 00010002 CPU: 0
EIP is at profile_pc+0x32/0x3b
EAX: ffffffff EBX: c1f0b680 ECX: 00010000 EDX: 00000001
ESI: c0375070 EDI: c1f0b584 EBP: edf97c98 ESP: edf97c90
 DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
Process ZwickAppConsole (pid: 3463, ti=3Dedf96000 task=3Decdf3030 =
task.ti=3Dedf96000)
I-pipe domain Linux
Stack:
 c1f0b680 00000001 edf97ca8 c0138a1b c1f0b584 00000000 edf97cb0 c013bb12
 edf97cc8 c013bb31 00000000 c1f0b584 00000000 fffffe7f edf97cd8 c011093a
 c1f0b680 c01108d9 edf97d38 c0151c5e c1f0b680 c1f0c780 00000180 c01108d9
Call Trace:
 [<c0138a1b>] ? profile_tick+0x4a/0x63
 [<c013bb12>] ? tick_periodic+0x66/0x68
 [<c013bb31>] ? tick_handle_periodic+0x1d/0x60
 [<c011093a>] ? smp_apic_timer_interrupt+0x61/0x74
 [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
 [<c0151c5e>] ? __ipipe_sync_stage+0x139/0x13e
 [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
 [<c0151c63>] ? __xirq_end+0x0/0x45
 [<c0151e05>] ? ipipe_suspend_domain+0x98/0xdb
 [<c0151ecf>] ? __ipipe_walk_pipeline+0x87/0xc8
 [<c0151f9b>] ? __ipipe_dispatch_wired_nocheck+0x8b/0x92
 [<c015285f>] ? __ipipe_dispatch_wired+0x64/0x67
 [<c0114b9e>] ? __ipipe_handle_irq+0xb2/0x1d7
 [<c015c0ed>] ? xnpod_schedule+0xb33/0xe7a
 [<c0104821>] ? ipipe_ipi3+0x35/0x58
 [<c03700d8>] ? init_centaur+0xd3/0x260
 [<c0115564>] ? mcount+0x0/0x23
 [<c022d203>] ? security_socket_sendmsg+0x9/0x18
 [<c02f4305>] ? sock_aio_write+0xd1/0xee
 [<c015c5bd>] ? xnpod_suspend_thread+0x189/0x1ff
 [<c01b1c41>] ? do_sync_readv_writev+0xae/0xec
 [<c01342e5>] ? autoremove_wake_function+0x0/0x35
 [<c024be8e>] ? __copy_from_user_ll+0xa/0xd8
 [<c024c1be>] ? copy_from_user+0x3b/0x5e
 [<c022dbe5>] ? cap_file_permission+0x8/0xc
 [<c022cb78>] ? security_file_permission+0x14/0x16
 [<c01b227a>] ? do_readv_writev+0x86/0x141
 [<c02f4234>] ? sock_aio_write+0x0/0xee
 [<c0162ed7>] ? losyscall_event+0xe/0x168
 [<c01b2373>] ? vfs_writev+0x3e/0x4e
 [<c01b2715>] ? sys_writev+0x40/0x65
 [<c0103aaa>] ? sysenter_do_call+0x12/0x16
Code: f2 00 00 89 c3 8b 70 2c 8b 53 30 8b 40 34 83 e2 03 25 00 00 02 00 =
09 d0 83 f8 02 77 11 89 f0 e8 d4 88 03 00 85 c0 74 06 8b 43 14 <8b> 70 =
04 89 f0 5b 5e 5d c3 55 89 e5 57 56 53 e8 c1 f2 00 00 8b
EIP: [<c010628f>] profile_pc+0x32/0x3b SS:ESP 0068:edf97c90
Kernel panic - not syncing: Fatal exception in interrupt
------------[ cut here ]------------
WARNING: at =
/work/meierh/kernel/linux-2.6.28.7/xenomai-2.4.7/i386/linux/kernel/smp.c:=
333 smp_call_function_mask+0x4c/0x196()
Modules linked in: zirqack zmodule zbaseboard zwatchdog z7segdisplay =
zbaseboarddetect ziomemmap loop i2c_i801 i2c_core intel_agp agpgart =
nls_cp437 nls_iso8859_1 vfat fat ide_core ohci_hcd edd dm_mod =
usb_storage reiserfs sg sd_mod mptspi mptscsih mptbase =
scsi_transport_spi ata_piix ahci libata scsi_mod [last unloaded: =
zbaseboarddetect]
Pid: 3463, comm: ZwickAppConsole Tainted: G      D    =
2.6.28.7-xenomai-2.4.7-modcom.420 #1
Call Trace:
 [<c012342a>] warn_on_slowpath+0x46/0x60
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c03778d6>] ? sub_preempt_count+0x10/0x6f
 [<c024baa7>] ? delay_tsc+0x8b/0xa4
 [<c024b978>] ? __delay+0xe/0x10
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c03778d6>] ? sub_preempt_count+0x10/0x6f
 [<c02abe6e>] ? serial8250_console_write+0x106/0x110
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c03778d6>] ? sub_preempt_count+0x10/0x6f
 [<c012366f>] ? wake_up_klogd+0x8/0x29
 [<c0123a9c>] ? release_console_sem+0x199/0x1a1
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c013e7e5>] smp_call_function_mask+0x4c/0x196
 [<c010f288>] ? stop_this_cpu+0x0/0x48
 [<c0373f26>] ? mutex_trylock+0x9/0x25
 [<c0373f11>] ? mutex_unlock+0x8/0x14
 [<c01442f3>] ? crash_kexec+0xa4/0xac
 [<c0153994>] ? ipipe_trace_panic_dump+0xe/0x20f
 [<c01062a3>] ? sys_iopl+0xb/0x6b
 [<c0373f26>] ? mutex_trylock+0x9/0x25
 [<c0373f11>] ? mutex_unlock+0x8/0x14
 [<c010f288>] ? stop_this_cpu+0x0/0x48
 [<c013e959>] smp_call_function+0x2a/0x53
 [<c010f3c2>] native_smp_send_stop+0x20/0x65
 [<c01234b4>] panic+0x5d/0xf4
 [<c037616b>] oops_end+0x81/0x95
 [<c01060e8>] die+0x5c/0x64
 [<c0377810>] do_page_fault+0x5aa/0x660
 [<c0115207>] __ipipe_handle_exception+0x1c6/0x209
 [<c0375070>] ? _spin_lock_irqsave+0x41/0x5b
 [<c037575b>] error_code+0x77/0x84
 [<c0375070>] ? _spin_lock_irqsave+0x41/0x5b
 [<c03700d8>] ? init_centaur+0xd3/0x260
 [<c010628f>] ? profile_pc+0x32/0x3b
 [<c0138a1b>] profile_tick+0x4a/0x63
 [<c013bb12>] tick_periodic+0x66/0x68
 [<c013bb31>] tick_handle_periodic+0x1d/0x60
 [<c011093a>] smp_apic_timer_interrupt+0x61/0x74
 [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
 [<c0151c5e>] __ipipe_sync_stage+0x139/0x13e
 [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
 [<c0151c63>] ? __xirq_end+0x0/0x45
 [<c0151e05>] ipipe_suspend_domain+0x98/0xdb
 [<c0151ecf>] __ipipe_walk_pipeline+0x87/0xc8
 [<c0151f9b>] __ipipe_dispatch_wired_nocheck+0x8b/0x92
 [<c015285f>] __ipipe_dispatch_wired+0x64/0x67
 [<c0114b9e>] __ipipe_handle_irq+0xb2/0x1d7
 [<c015c0ed>] ? xnpod_schedule+0xb33/0xe7a
 [<c0104821>] ipipe_ipi3+0x35/0x58
 [<c03700d8>] ? init_centaur+0xd3/0x260
 [<c0115564>] mcount+0x0/0x23
 [<c022d203>] ? security_socket_sendmsg+0x9/0x18
 [<c02f4305>] ? sock_aio_write+0xd1/0xee
 [<c015c5bd>] ? xnpod_suspend_thread+0x189/0x1ff
 [<c01b1c41>] ? do_sync_readv_writev+0xae/0xec
 [<c01342e5>] ? autoremove_wake_function+0x0/0x35
 [<c024be8e>] ? __copy_from_user_ll+0xa/0xd8
 [<c024c1be>] ? copy_from_user+0x3b/0x5e
 [<c022dbe5>] ? cap_file_permission+0x8/0xc
 [<c022cb78>] ? security_file_permission+0x14/0x16
 [<c01b227a>] ? do_readv_writev+0x86/0x141
 [<c02f4234>] ? sock_aio_write+0x0/0xee
 [<c0162ed7>] ? losyscall_event+0xe/0x168
 [<c01b2373>] ? vfs_writev+0x3e/0x4e
 [<c01b2715>] ? sys_writev+0x40/0x65
 [<c0103aaa>] ? sysenter_do_call+0x12/0x16
---[ end trace aa2d38baea368ab1 ]---
------------[ cut here ]------------
WARNING: at =
/work/meierh/kernel/linux-2.6.28.7/xenomai-2.4.7/i386/linux/kernel/smp.c:=
220 smp_call_function_single+0x58/0x122()
Modules linked in: zirqack zmodule zbaseboard zwatchdog z7segdisplay =
zbaseboarddetect ziomemmap loop i2c_i801 i2c_core intel_agp agpgart =
nls_cp437 nls_iso8859_1 vfat fat ide_core ohci_hcd edd dm_mod =
usb_storage reiserfs sg sd_mod mptspi mptscsih mptbase =
scsi_transport_spi ata_piix ahci libata scsi_mod [last unloaded: =
zbaseboarddetect]
Pid: 3463, comm: ZwickAppConsole Tainted: G      D W  =
2.6.28.7-xenomai-2.4.7-modcom.420 #1
Call Trace:
 [<c012342a>] warn_on_slowpath+0x46/0x60
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c03778d6>] ? sub_preempt_count+0x10/0x6f
 [<c024baa7>] ? delay_tsc+0x8b/0xa4
 [<c024b978>] ? __delay+0xe/0x10
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c03778d6>] ? sub_preempt_count+0x10/0x6f
 [<c02abe6e>] ? serial8250_console_write+0x106/0x110
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c013e6cf>] smp_call_function_single+0x58/0x122
 [<c010f288>] ? stop_this_cpu+0x0/0x48
 [<c012366f>] ? wake_up_klogd+0x8/0x29
 [<c0123a9c>] ? release_console_sem+0x199/0x1a1
 [<c0151451>] ? ipipe_check_context+0xa/0xec
 [<c024676e>] ? find_first_bit+0xa/0x4a
 [<c013e82c>] smp_call_function_mask+0x93/0x196
 [<c010f288>] ? stop_this_cpu+0x0/0x48
 [<c0373f26>] ? mutex_trylock+0x9/0x25
 [<c0373f11>] ? mutex_unlock+0x8/0x14
 [<c01442f3>] ? crash_kexec+0xa4/0xac
 [<c0153994>] ? ipipe_trace_panic_dump+0xe/0x20f
 [<c01062a3>] ? sys_iopl+0xb/0x6b
 [<c0373f26>] ? mutex_trylock+0x9/0x25
 [<c0373f11>] ? mutex_unlock+0x8/0x14
 [<c010f288>] ? stop_this_cpu+0x0/0x48
 [<c013e959>] smp_call_function+0x2a/0x53
 [<c010f3c2>] native_smp_send_stop+0x20/0x65
 [<c01234b4>] panic+0x5d/0xf4
 [<c037616b>] oops_end+0x81/0x95
 [<c01060e8>] die+0x5c/0x64
 [<c0377810>] do_page_fault+0x5aa/0x660
 [<c0115207>] __ipipe_handle_exception+0x1c6/0x209
 [<c0375070>] ? _spin_lock_irqsave+0x41/0x5b
 [<c037575b>] error_code+0x77/0x84
 [<c0375070>] ? _spin_lock_irqsave+0x41/0x5b
 [<c03700d8>] ? init_centaur+0xd3/0x260
 [<c010628f>] ? profile_pc+0x32/0x3b
 [<c0138a1b>] profile_tick+0x4a/0x63
 [<c013bb12>] tick_periodic+0x66/0x68
 [<c013bb31>] tick_handle_periodic+0x1d/0x60
 [<c011093a>] smp_apic_timer_interrupt+0x61/0x74
 [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
 [<c0151c5e>] __ipipe_sync_stage+0x139/0x13e
 [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
 [<c0151c63>] ? __xirq_end+0x0/0x45
 [<c0151e05>] ipipe_suspend_domain+0x98/0xdb
 [<c0151ecf>] __ipipe_walk_pipeline+0x87/0xc8
 [<c0151f9b>] __ipipe_dispatch_wired_nocheck+0x8b/0x92
 [<c015285f>] __ipipe_dispatch_wired+0x64/0x67
 [<c0114b9e>] __ipipe_handle_irq+0xb2/0x1d7
 [<c015c0ed>] ? xnpod_schedule+0xb33/0xe7a
 [<c0104821>] ipipe_ipi3+0x35/0x58
 [<c03700d8>] ? init_centaur+0xd3/0x260
 [<c0115564>] mcount+0x0/0x23
 [<c022d203>] ? security_socket_sendmsg+0x9/0x18
 [<c02f4305>] ? sock_aio_write+0xd1/0xee
 [<c015c5bd>] ? xnpod_suspend_thread+0x189/0x1ff
 [<c01b1c41>] ? do_sync_readv_writev+0xae/0xec
 [<c01342e5>] ? autoremove_wake_function+0x0/0x35
 [<c024be8e>] ? __copy_from_user_ll+0xa/0xd8
 [<c024c1be>] ? copy_from_user+0x3b/0x5e
 [<c022dbe5>] ? cap_file_permission+0x8/0xc
 [<c022cb78>] ? security_file_permission+0x14/0x16
 [<c01b227a>] ? do_readv_writev+0x86/0x141
 [<c02f4234>] ? sock_aio_write+0x0/0xee
 [<c0162ed7>] ? losyscall_event+0xe/0x168
 [<c01b2373>] ? vfs_writev+0x3e/0x4e
 [<c01b2715>] ? sys_writev+0x40/0x65
 [<c0103aaa>] ? sysenter_do_call+0x12/0x16
---[ end trace aa2d38baea368ab1 ]---


---

> -----Urspr=FCngliche Nachricht-----
> Von: xenomai-help-bounces@domain.hid =
[mailto:xenomai-help-bounces@domain.hid] Im
> Auftrag von Meier, Hans
> Gesendet: Mittwoch, 9. September 2009 11:35
> An: Philippe Gerum
> Cc: xenomai@xenomai.org; Jan Kiszka
> Betreff: Re: [Xenomai-help] Kernel panic with xenomai 2.4.7
>=20
> Hi Phillipe,
> Hi Jan,
>=20
> Thanks for the fast responses!
> We now decided to do the following:
>=20
> - we will continue to run our (up to now) single target with serial =
card
> on 2.6.28.7/2.4.7 to get a full log of the oops. If we get a log we =
will
> post it.
>=20
> - on some other targets we will run 2.6.30/2.4.9.1 to prove the =
assumption
> that we got rid of the problem (we are a little bit under time =
pressure
> and need to have something stable)
>=20
> - after the step above we will build two kernels that do only differ =
in
> this I-pipe version Phillipe mentioned, one before, one after, and run
> both on targets with serial cards we already ordered, until oops or at
> least let's say 5 days. If we get an oops on one of the targets, we =
will
> post the log.
>=20
> So, we will be back in one or two weeks.
>=20
> Best regards
>=20
> Hans
>=20
>=20
> > -----Urspr=FCngliche Nachricht-----
> > Von: Philippe Gerum [mailto:rpm@xenomai.org]
> > Gesendet: Dienstag, 8. September 2009 20:56
> > An: Meier, Hans
> > Cc: xenomai@xenomai.org
> > Betreff: Re: [Xenomai-help] Kernel panic with xenomai 2.4.7
> >
> > On Tue, 2009-09-08 at 19:48 +0200, Meier, Hans wrote:
> > > Hi,
> > >
> > > we have been using xenomai for a long time and now for the first =
time
> we
> > > have a kernel panic we would like you to have a look at (see =
below).
> > >
> > > The panic (if all is the same thing) up to now has only occurred =
after
> > > >5h and <48h up time of our application on a core duo with linux
> > > 2.6.28.7 patched with xenomai 2.4.7. Other, very recent tests with
> linux
> > > 2.6.30 and xenomai 2.4.9 and xenomai 2.4.9.1 haven't shown any =
trouble
> > > up to now, and reached >60h with the first trial. Other versions =
we
> > > haven't tested yet.
> > >
> > > So could you please take a look at the panic output (the only one =
we
> > > could see on the screen up to now, originally just a screen
> photographed
> > > with a mobile ...)? Might this be anything known and maybe fixed =
in
> > > xenomai 2.4.9? If not, can you guess what that might be from those =
few
> > > lines? This would help a lot! .config is attached, if you need =
more
> > > info, we will certainly provide it.
> >
> > Regarding this particular issue, I would suspect a CPU migration bug =
we
> > had until I-pipe 2.6.29.4-x86-2.4-00. You may want to try this patch
> > with 2.4.7 to see if I'm right. Aside of this, 2.4.7 -> 2.4.9 closed
> > quite a few bugs as well, but I would rather think of a pipeline =
issue
> > in the case below.
> >
> > >
> > > Thanks in advance
> > >
> > > Hans
> > >
> > > --
> > >
> > > [<c010f288>] ? stop_this_cpu+0x0/0x48
> > > [<c013e959>] smp_call_function+0x2a/0x53
> > > [<c010f3c2>] native_smp_send_stop+0x20/0x65
> > > [<c01234b4>] panic+0x5d/0xf4
> > > [<c036fe43>] oops_end+0x81/0x95
> > > [<c01060e8>] die+0x5c/0x64
> > > [<c03714e8>] do_page_fault+0x5aa/0x660
> > > [<c0115207>] __ipipe_handle_exception+0x1c6/0x209
> > > [<c036f095>] ? _spin_unlock_irq+0x19/0x2d
> > > [<c036f433>] error_code+0x77/0x84
> > > [<c036f095>] ? _spin_unlock_irq+0x19/0x2d
> > > [<c03600d8>] ? krb5_encrypt+0xd8/0xde
> > > [<c010628f>] ? profile_pc+0x32/0x3b
> > > [<c0138a1b>] profile_tick+0x4a/0x63
> > > [<c013bb12>] tick_periodic+0x66/0x68
> > > [<c013bb31>] tick_handle_periodic+0x1d/0x60
> > > [<c011093a>] smp_apic_timer_interrupt+0x61/0x74
> > > [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
> > > [<c0151c5e>] __ipipe_sync_stage+0x139/0x13e
> > > [<c01108d9>] ? smp_apic_timer_interrupt+0x0/0x74
> > > [<c0151c63>] ? __xirq_end+0x0/0x45
> > > [<c0151e05>] ipipe_suspend_domain+0x98/0xdb
> > > [<c0151ecf>] __ipipe_walk_pipeline+0x87/0xc8
> > > [<c0151f9b>] __ipipe_dispatch_wired_nocheck+0x8b/0x92
> > > [<c015285f>] __ipipe_dispatch_wired+0x64/0x67
> > > [<c0114b9e>] __ipipe_handle_irq+0xb2/0x1d7
> > > [<c0104821>] ipipe_ipi3+0x35/0x58
> > > [<c02f9261>] dev_hard_start_xmit+0x261/0x268
> > > [<c03062a1>] ? __qdisc_run+0xcc/0x1af
> > > [<c02fb8ae>] dev_queue_xmit+0x311/0x42b
> > > [<c0311aa9>] ? ip_finish_output+0x21f/0x259
> > > [<c0151451>] ? ipipe_check_context+0xa/0xec
> > > [<c03126d8>] ? ip_output+0x71/0x76
> > > [<c03106a8>] ? ip_local_out+0x1d/0x20
> > > [<c031298d>] ? ip_queue_xmit+0x2b0/0x317
> > > [<c011c54a>] ? default_wake_function+0x0/0x12
> > > [<c0114ec4>] ? __ipipe_unstall_iret_root+0x64/0x68
> > > [<c0103be3>] ? restore_nocheck_notrace+0x0/0xe
> > > [<c02f2659>] ? __copy_skb_header+0xe/0xe0
> > > [<c031f703>] ? __tcp_select_window+0xe/0x126
> > > [<c0151451>] ? ipipe_check_context+0xa/0xec
> > > [<c0320102>] ? tcp_transmit_skb+0x564/0x59e
> > > [<c0110955>] ? native_apic_mem_write+0x8/0x1a
> > > [<c0321747>] ? __tcp_push_pending_frames+0x626/0x6c4
> > > [<c031f98b>] ? tcp_current_mss+0xa2/0xc3
> > > [<c024be8e>] ? __copy_from_user_ll+0xa/0xd8
> > > [<c024c1be>] ? copy_from_user+0x3b/0x5e
> > > [<c031813b>] ? tcp_sendmsg+0x7d3/0x8b4
> > > [<c0111802>] ? unmask_IO_APIC_irq+0xab/0xb2
> > > [<c02ee6a5>] ? sock_aio_write+0xe5/0xee
> > > [<c01b1c41>] ? do_sync_readv_writev+0xae/0xec
> > > [<c01342e5>] ? autoremove_wake_funtion+0x0/0x35
> > > [<c024be8e>] ? __copy_from_user_ll+0xa/0xd8
> > > [<c024c1be>] ? copy_from_user+0x3b/0x5e
> > > [<c022dbe5>] ? cap_file_permission+0x8/0xc
> > > [<c022cb78>] ? security_file_permission+0x14/0x16
> > > [<c01b227a>] ? do_readv_writev+0x86/0x141
> > > [<c02ee5c0>] ? sock_aio_write+0x0/0xee
> > > [<c0162ed7>] ? Iosyscall_event+0xe/0x168
> > > [<c01b2373>] ? vfs_writev+0x3e/0x4e
> > > [<c01b2715>] ? sys_writev+0x40/0x65
> > > [<c0103aaa>] ? sysenter_do_call+0x12/0x16
> > > ---[ end trace a1134258cad770fd ]---
> > >
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> > --
> > Philippe.
> >
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

