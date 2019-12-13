From: Lange Norbert <norbert.lange@andritz.com>
Subject: RE: stalled head domain with 3.1rc4
Date: Fri, 13 Dec 2019 10:58:00 +0000
Message-ID: <VI1PR05MB591751B6B23BA41FD3C3E85CF6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
References: <VI1PR05MB5917452476FF30146D701888F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <VI1PR05MB591740A31653FE8542171311F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
In-Reply-To: <VI1PR05MB591740A31653FE8542171311F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

Added the trace starting 1 second before the bug (might help you more).
(last one was the same trace cut at the time of the bug)

> -----Original Message-----
> From: Lange Norbert <norbert.lange@andritz.com>
> Sent: Freitag, 13. Dezember 2019 11:54
> To: Lange Norbert <norbert.lange@andritz.com>
> Cc: Philippe Gerum (rpm@xenomai.org) <rpm@xenomai.org>
> Subject: RE: stalled head domain with 3.1rc4
>
> I now removed calls to recv/send_mmsg and instead call the single *msg
> variant in a loop. This makes the bug appear less,
> but it now triggered once when stopping the trace, so there might be goods
> in there for you.
> (the last sendmsg/recvmsg pair at 1842.622889 -> 1842.622956  is the IDDP
> socket to wakeup the other process)
>
> [ 1842.420470] I-pipe: Detected stalled head domain, probably caused by a
> bug.
> [ 1842.420470]         A critical section may have been left unterminated.
> [ 1842.434053] CPU: 0 PID: 1353 Comm: trace-cmd Not tainted 4.19.84-xeno8-
> static #1
> [ 1842.441456] Hardware name: TQ-Group TQMxE39M/Type2 - Board
> Product Name, BIOS 5.12.30.21.20 08/05/2019
> [ 1842.450773] I-pipe domain: Linux
> [ 1842.454014] Call Trace:
> [ 1842.456472]  <IRQ>
> [ 1842.458502]  dump_stack+0x8c/0xc0
> [ 1842.461829]  ipipe_stall_root+0xc/0x30
> [ 1842.465591]  __ipipe_trap_prologue+0x100/0x210
> [ 1842.470045]  int3+0x45/0x70
> [ 1842.472854] RIP: 0010:xntimer_start+0x3a/0x330
> [ 1842.477308] Code: 55 49 89 d5 41 54 55 48 89 fd 53 48 83 ec 10 48 8b 4=
7 70 4c
> 8b 37 48 63 40 18 4d 8b a6 90 00 00 00 4c 03 24 c5 00 d3f
> [ 1842.496083] RSP: 0018:ffff8fe9fba03e80 EFLAGS: 00000082
> [ 1842.501324] RAX: 0000000000000000 RBX: 0000000000025090 RCX:
> 0000000000000000
> [ 1842.508468] RDX: 0000000000000000 RSI: 000000000003b55f RDI:
> ffff8fe9fba305c8
> [ 1842.515609] RBP: ffff8fe9fba305c8 R08: 0000000000000000 R09:
> 000001acc52f873d
> [ 1842.522754] R10: 000001acc52b974d R11: 000001acc52b974d R12:
> ffff8fe9fba3aee0
> [ 1842.529898] R13: 0000000000000000 R14: ffffffffb223bbe0 R15:
> 000000000003b55f
> [ 1842.537044]  ? xntimer_start+0x3a/0x330
> [ 1842.540889]  ? enqueue_hrtimer+0x36/0x90
> [ 1842.544823]  program_htick_shot+0x83/0x100
> [ 1842.548931]  clockevents_program_event+0x88/0xe0
> [ 1842.553561]  hrtimer_interrupt+0x140/0x230
> [ 1842.557669]  smp_apic_timer_interrupt+0x46/0x110
> [ 1842.562296]  __ipipe_do_sync_stage+0x130/0x180
> [ 1842.566751]  __ipipe_handle_irq+0x94/0x200
> [ 1842.570860]  apic_timer_interrupt+0x12/0x40
> [ 1842.575054]  </IRQ>
> [ 1842.577163] RIP: 0010:smp_call_function_many+0x1b6/0x250
> [ 1842.582485] Code: e8 6f a0 6b 00 3b 05 dd 60 01 01 89 c7 0f 83 c4 fe f=
f ff 48
> 63 c7 48 8b 0b 48 03 0c c5 00 d3 11 b2 8b 41 18 a8 01 745
> [ 1842.601264] RSP: 0018:ffff957380bbfba8 EFLAGS: 00000202 ORIG_RAX:
> ffffffffffffff13
> [ 1842.608846] RAX: 0000000000000003 RBX: ffff8fe9fba34ac0 RCX:
> ffff8fe9fbbb8680
> [ 1842.615989] RDX: 0000000000000001 RSI: 0000000000000000 RDI:
> 0000000000000003
> [ 1842.623133] RBP: ffffffffb12179a0 R08: ffff8fe9fba34ac8 R09:
> 0000000000000000
> [ 1842.630276] R10: 000000000000000a R11: f000000000000000 R12:
> 0000000000000000
> [ 1842.637417] R13: ffff8fe9fba34ac8 R14: 0000000000000004 R15:
> 0000000000000001
> [ 1842.644565]  ? optimize_nops.isra.0+0x90/0x90
> [ 1842.648934]  ? smp_call_function_many+0x191/0x250
> [ 1842.653650]  ? optimize_nops.isra.0+0x90/0x90
> [ 1842.658015]  ? xntimer_start+0x39/0x330
> [ 1842.661859]  ? xntimer_start+0x3a/0x330
> [ 1842.665705]  on_each_cpu+0x28/0x50
> [ 1842.669116]  ? xntimer_start+0x39/0x330
> [ 1842.672959]  text_poke_bp+0x91/0xde
> [ 1842.676460]  __jump_label_transform.isra.0+0x102/0x150
> [ 1842.681610]  arch_jump_label_transform+0x2e/0x40
> [ 1842.686239]  __jump_label_update+0x67/0xa0
> [ 1842.690348]  __static_key_slow_dec_cpuslocked+0x30/0x80
> [ 1842.695583]  static_key_slow_dec+0x23/0x50
> [ 1842.699689]  tracepoint_probe_unregister+0x176/0x1b0
> [ 1842.704661]  trace_event_reg+0x31/0xa0
> [ 1842.708421]  ? mutex_lock+0x13/0x30
> [ 1842.711921]  __ftrace_event_enable_disable+0x120/0x230
> [ 1842.717072]  __ftrace_set_clr_event_nolock+0xe6/0x130
> [ 1842.722133]  system_enable_write+0xaa/0xe0
> [ 1842.726240]  __vfs_write+0x34/0x190
> [ 1842.729739]  ? __check_heap_object+0x5/0x120
> [ 1842.734021]  ? __check_object_size+0x136/0x147
> [ 1842.738474]  ? rcu_all_qs+0x5/0x80
> [ 1842.741884]  vfs_write+0xb6/0x190
> [ 1842.745210]  ksys_write+0x57/0xd0
> [ 1842.748537]  do_syscall_64+0x78/0x3c0
> [ 1842.752212]  ? __do_page_fault+0x207/0x400
> [ 1842.756319]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 1842.761381] RIP: 0033:0x45f5d9
> [ 1842.764444] Code: 89 d6 0f 05 c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 4=
8 89 f8
> 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 4c 8b 4c 24 08 48 890
> [ 1842.783220] RSP: 002b:00007fff22863618 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000001
> [ 1842.790801] RAX: ffffffffffffffda RBX: 00000000004013b0 RCX:
> 000000000045f5d9
> [ 1842.797944] RDX: 0000000000000001 RSI: 00007fff2286365f RDI:
> 0000000000000005
> [ 1842.805086] RBP: 00007fff228636c0 R08: 0000000000000000 R09:
> 0000000000000000
> [ 1842.812230] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007fff22863848
> [ 1842.819372] R13: 00007fff22863870 R14: 0000000000000000 R15:
> 0000000000000000
>
>
> > -----Original Message-----
> > From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Lange
> > Norbert via Xenomai
> > Sent: Freitag, 13. Dezember 2019 11:16
> > To: Xenomai (xenomai@xenomai.org) <xenomai@xenomai.org>
> > Subject: stalled head domain with 3.1rc4
> >
> > NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
> > ATTACHMENTS.
> >
> >
> > Just had a bug msg pop up. Its triggered by enabling tracing, while we =
have
> 2
> > processes running, using IDDP, XDDP and RTNet (just packet sockets, no =
ip
> > stack).
> > Some points:
> >
> > -       trace-cmd stores in tmp, so shouldn't touch other filesystems t=
han
> > tmpfs, sysfs
> >
> > -       upon starting this, our process complains about a 150ms hole in=
 CPU
> time
> > (likely the time of the bug)
> >
> > -       it seems to happen only the first time after a boot
> >
> > -       running trace-cmd "dry" (without our processes) doesn't trigger=
 the
> bug.
> > Neither when disabling active communication on our project (per
> millisecond
> > up to 15 eth packets in both directions via packet socket, using the new
> > send/recv_mmsg calls).
> >
> > -       system seems to continue stable afterwards
> >
> > -       a trace is attached, not after triggering the bug (then it woul=
d just
> > contain our project in error state) but showing or project with active
> > communication  (ie. trace-cmd started a second time after a bug)
> >
> >
> > # trace-cmd record -e 'cobalt*'
> > [  160.443596] I-pipe: Detected stalled head domain, probably caused by=
 a
> > bug.
> > [  160.443596]         A critical section may have been left unterminat=
ed.
> > [  160.457178] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.84-xeno8-
> > static #1
> > [  160.464323] Hardware name: TQ-Group TQMxE39M/Type2 - Board
> Product
> > Name, BIOS 5.12.30.21.20 08/05/2019
> > [  160.473640] I-pipe domain: Linux
> > [  160.476877] Call Trace:
> > [  160.479345]  dump_stack+0x8c/0xc0
> > [  160.482672]  ipipe_stall_root+0xc/0x30
> > [  160.486436]  __ipipe_trap_prologue+0x100/0x210
> > [  160.490894]  int3+0x45/0x70
> > [  160.493702] RIP: 0010:xnthread_resume+0x75/0x3a0
> > [  160.498329] Code: 0f eb 00 74 21 31 c0 ba 01 00 00 00 f0 0f b1 15 c5=
 0f eb 00
> > 85 c0 0f 85 db 02 00 00 4c 8b 2c 24 89 1d af 0f eb 00 4d0
> > [  160.517108] RSP: 0018:ffff9934400a7dd8 EFLAGS: 00000046
> > [  160.522349] RAX: 0000000000000001 RBX: 0000000000000001 RCX:
> > 00007f37aa603700
> > [  160.529490] RDX: 0000000000000001 RSI: 0000000000000080 RDI:
> > ffff9934405dc240
> > [  160.536631] RBP: ffff9934405dc240 R08: 00000000000f7df7 R09:
> > ffff9140f8cb2800
> > [  160.543774] R10: 00000000000003b3 R11: 00000000000b8c4a R12:
> > 0000000000025090
> > [  160.550918] R13: 0000000000000003 R14: 0000000000000080 R15:
> > 0000000000000080
> > [  160.558064]  ? xnthread_resume+0x75/0x3a0
> > [  160.562083]  ? xnthread_resume+0x1f/0x3a0
> > [  160.566104]  ipipe_migration_hook+0xda/0x1d0
> > [  160.570385]  complete_domain_migration+0x79/0xe0
> > [  160.575011]  __ipipe_switch_tail+0x39/0x50
> > [  160.579118]  __schedule+0x2d0/0x890
> > [  160.582615]  schedule_idle+0x28/0x40
> > [  160.586203]  do_idle+0x101/0x130
> > [  160.589440]  cpu_startup_entry+0x6f/0x80
> > [  160.593373]  start_secondary+0x169/0x1b0
> > [  160.597312]  secondary_startup_64+0xa4/0xb0
> >
> >
> >
> > Mit besten Gr=FC=DFen / Kind regards
> >
> > NORBERT LANGE
> >
> > AT-RD3
> >
> > ANDRITZ HYDRO GmbH
> > Eibesbrunnergasse 20
> > 1120 Vienna / AUSTRIA
> > p: +43 50805 56684
> > norbert.lange@andritz.com<mailto:norbert.lange@andritz.com>
> > andritz.com<http://www.andritz.com/>
> >
> > ________________________________
> >
> > This message and any attachments are solely for the use of the intended
> > recipients. They may contain privileged and/or confidential information=
 or
> > other information protected from disclosure. If you are not an intended
> > recipient, you are hereby notified that you received this email in erro=
r and
> > that any review, dissemination, distribution or copying of this email a=
nd any
> > attachment is strictly prohibited. If you have received this email in e=
rror,
> > please contact the sender and delete the message and any attachment
> from
> > your system.
> >
> > ANDRITZ HYDRO GmbH
> >
> >
> > Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung /
> Corporation
> >
> > Firmensitz/ Registered seat: Wien
> >
> > Firmenbuchgericht/ Court of registry: Handelsgericht Wien
> >
> > Firmenbuchnummer/ Company registration: FN 61833 g
> >
> > DVR: 0605077
> >
> > UID-Nr.: ATU14756806
> >
> >
> > Thank You
> > ________________________________
> > -------------- next part --------------
> > A non-text attachment was scrubbed...
> > Name: trace.dat.xz
> > Type: application/octet-stream
> > Size: 2775472 bytes
> > Desc: trace.dat.xz
> > URL:
> >
> <http://xenomai.org/pipermail/xenomai/attachments/20191213/0e1c8638/a
> > ttachment.obj>
________________________________

This message and any attachments are solely for the use of the intended rec=
ipients. They may contain privileged and/or confidential information or oth=
er information protected from disclosure. If you are not an intended recipi=
ent, you are hereby notified that you received this email in error and that=
 any review, dissemination, distribution or copying of this email and any a=
ttachment is strictly prohibited. If you have received this email in error,=
 please contact the sender and delete the message and any attachment from y=
our system.

ANDRITZ HYDRO GmbH


Rechtsform/ Legal form: Gesellschaft mit beschr=E4nkter Haftung / Corporati=
on

Firmensitz/ Registered seat: Wien

Firmenbuchgericht/ Court of registry: Handelsgericht Wien

Firmenbuchnummer/ Company registration: FN 61833 g

DVR: 0605077

UID-Nr.: ATU14756806


Thank You
________________________________
-------------- next part --------------
A non-text attachment was scrubbed...
Name: bug.trace.xz
Type: application/octet-stream
Size: 1946192 bytes
Desc: bug.trace.xz
URL: <http://xenomai.org/pipermail/xenomai/attachments/20191213/718f9327/at=
tachment.obj>
