Date: Sun, 21 Oct 2018 00:43:00 +0000 (UTC)
From: Alec Ari <neotheuser@ymail.com>
Message-ID: <1269128408.13364854.1540082580679@mail.yahoo.com>
In-Reply-To: <1051803715.13351499.1540072998520@mail.yahoo.com>
References: <1051803715.13351499.1540072998520.ref@mail.yahoo.com>
 <1051803715.13351499.1540072998520@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] 4.14 IPIPE kernel results - Interesting bug?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

I modified my kernel config some, this is what I have now:

[=C2=A0 348.421965] DEBUG_LOCKS_WARN_ON(preemptible())
[=C2=A0 348.421966] BUG: Unhandled exception over domain Xenomai at 0xfffff=
fff9340e9f2 - switching to ROOT
[=C2=A0 348.421968] CPU: 0 PID: 599 Comm: X Not tainted 4.14.77-IPIPE+ #7
[=C2=A0 348.421969] I-pipe domain: Linux
[=C2=A0 348.421970] Call Trace:
[=C2=A0 348.421970]=C2=A0 <IRQ>
[=C2=A0 348.421971]=C2=A0 ? dump_stack+0x8d/0xa7
[=C2=A0 348.421971]=C2=A0 ? __ipipe_trap_prologue+0x188/0x220
[=C2=A0 348.421972]=C2=A0 ? invalid_op+0x2a/0x55
[=C2=A0 348.421973]=C2=A0 ? __switch_to_xtra+0x352/0x370
[=C2=A0 348.421973]=C2=A0 ? __switch_to_xtra+0x352/0x370
[=C2=A0 348.421974]=C2=A0 ? __switch_to+0x306/0x340
[=C2=A0 348.421974]=C2=A0 ? ___xnsched_run+0x1c0/0x340
[=C2=A0 348.421975]=C2=A0 ? xnintr_core_clock_handler+0x1d9/0x1f0
[=C2=A0 348.421976]=C2=A0 ? dispatch_irq_head+0x6e/0xf0
[=C2=A0 348.421976]=C2=A0 ? __ipipe_handle_irq+0x7d/0x1c0
[=C2=A0 348.421977]=C2=A0 ? apic_timer_interrupt+0x77/0xa0
[=C2=A0 348.421978]=C2=A0 </IRQ>
[=C2=A0 348.421978] ------------[ cut here ]------------
[=C2=A0 348.421979] WARNING: CPU: 0 PID: 599 at ./arch/x86/include/asm/desc=
.h:312 __switch_to_xtra+0x352/0x370
[=C2=A0 348.421980] Modules linked in: mousedev evdev hid_generic usbhid hi=
d ohci_pci ehci_pci ohci_hcd xhci_pci xhci_hcd ehci_hcd usbcore r8169 usb_c=
ommon mii rtc_cmos
[=C2=A0 348.421987] CPU: 0 PID: 599 Comm: X Not tainted 4.14.77-IPIPE+ #7
[=C2=A0 348.421988] I-pipe domain: Linux
[=C2=A0 348.421988] task: ffff912b6a51cd40 task.stack: ffff912b6e1bc000
[=C2=A0 348.421989] RIP: 0010:__switch_to_xtra+0x352/0x370
[=C2=A0 348.421990] RSP: 0018:ffff912b7fc03eb8 EFLAGS: 00010046
[=C2=A0 348.421991] RAX: 0000000000000023 RBX: 0000000000400000 RCX: 000000=
0000000001
[=C2=A0 348.421991] RDX: ffff912b7fc00000 RSI: 0000000000001140 RDI: ffffff=
ff93f50200
[=C2=A0 348.421992] RBP: ffff912b7fc03ee0 R08: 0000000000000045 R09: ffffff=
ff93f2c594
[=C2=A0 348.421993] R10: 000000000000000d R11: 0000000000000000 R12: 000000=
0000000000
[=C2=A0 348.421994] R13: ffff912b7fc00000 R14: 0000000000000000 R15: 000000=
0000004000
[=C2=A0 348.421994] FS:=C2=A0 000073d4b64cea40(0000) GS:ffff912b7fc00000(00=
00) knlGS:0000000000000000
[=C2=A0 348.421995] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[=C2=A0 348.421996] CR2: 00007360a5117000 CR3: 000000042e01e000 CR4: 000000=
00000406b0
[=C2=A0 348.421996] Call Trace:
[=C2=A0 348.421997]=C2=A0 <IRQ>
[=C2=A0 348.421997]=C2=A0 ? __switch_to+0x306/0x340
[=C2=A0 348.421998]=C2=A0 ? ___xnsched_run+0x1c0/0x340
[=C2=A0 348.421999]=C2=A0 ? xnintr_core_clock_handler+0x1d9/0x1f0
[=C2=A0 348.421999]=C2=A0 ? dispatch_irq_head+0x6e/0xf0
[=C2=A0 348.422000]=C2=A0 ? __ipipe_handle_irq+0x7d/0x1c0
[=C2=A0 348.422001]=C2=A0 ? apic_timer_interrupt+0x77/0xa0
[=C2=A0 348.422001]=C2=A0 </IRQ>
[=C2=A0 348.422002] Code: 00 85 c0 0f 84 33 fd ff ff 83 3d 89 b5 c1 00 00 0=
f 85 26 fd ff ff 48 c7 c6 ed 57 c9 93 48 c7 c7 fb 57 c9 93 31 c0 e8 96 6e 0=
5 00 <0f> 0b e9 0a fd ff ff 44 89 ef e8 6f 40 00 00 ba 01 00 00 00 eb=20
[=C2=A0 348.422026] ---[ end trace 28752ae954ec2587 ]---
A shorter stack trace than the one I posted earlier, with this kernel being=
 trimmed down further (less debugging, etc.)
Also, I know this is irrelevant, but this shouldn't happen as HPET and PMTI=
MER are both enabled:
[=C2=A0=C2=A0=C2=A0 0.000000] tsc: Fast TSC calibration failed
[=C2=A0=C2=A0=C2=A0 0.000000] tsc: Unable to calibrate against PIT
[=C2=A0=C2=A0=C2=A0 0.000000] tsc: No reference (HPET/PMTIMER) available
TSC calibration works just fine on non-IPIPE kernel, I've never seen "No re=
ference (HPET/PMTIMER) available" before.
"tsc: Unable to calibrate against PIT" yeah that's pretty common, but TSC c=
alibration would always fallback to HPET. PMTIMER should also be seen as av=
ailable.

I'm just trying to help the team, if you need anything else, let me know. I=
'm from RTAI and I've never seen a trace which points to  __switch_to_xtra =
before either. Do you know anything about this?
Thanks everyone, this community is pretty awesome! Cheers!

Alec
