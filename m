From: Lange Norbert <norbert.lange@andritz.com>
Subject: Still some lockups when enabling ftrace
Date: Mon, 17 Feb 2020 16:08:56 +0000
Message-ID: <VI1PR05MB5917457C869A655D0B4CEDD8F6160@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

Hello,

Enabling traces still can lockup Xenomai, apparently if any cobalt thread i=
s running.

trace-cmd record -e all

[11598.080137] I-pipe: Detected illicit call from head domain 'Xenomai'
[11598.080137]         into a regular Linux service
[11598.091070] CPU: 3 PID: 948 Comm: sshd Not tainted 4.19.98-cip19-xeno10-=
static #1
[11598.098531] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.18 04/12/2019
[11598.107813] I-pipe domain: Xenomai
[11598.111215] Call Trace:
[11598.113666]  <IRQ>
[11598.115690]  dump_stack+0x8c/0xc0
[11598.119011]  ipipe_stall_root+0xc/0x30
[11598.122768]  rcu_irq_enter_irqson+0x13/0x40
[11598.126947]  switch_mm_irqs_off+0x441/0x4e0
[11598.131132]  xnarch_switch_to+0x2b/0x70
[11598.134968]  ___xnsched_run+0x1b6/0x480
[11598.138806]  xnintr_core_clock_handler+0x224/0x2f0
[11598.143602]  dispatch_irq_head+0x95/0x130
[11598.147622]  __ipipe_handle_irq+0x94/0x200
[11598.151730]  apic_timer_interrupt+0x12/0x40
[11598.155914]  </IRQ>
[11598.158021] RIP: 0010:copy_user_generic_unrolled+0xb1/0xc0
[11598.163513] Code: 8b 06 4c 89 07 48 8d 76 08 48 8d 7f 08 ff c9 75 ee 21 =
d2 74 10 89 d1 8a 06 88 07 48 ff c6 48 ff c7 ff c9 75 f2 31 c0 0f 01 ca <c3=
> 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 2
[11598.182250] RSP: 0018:ffff95ffc0947c50 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[11598.189809] RAX: 0000000000000000 RBX: 000000000000001e RCX: 00000000000=
00000
[11598.196934] RDX: 0000000000000006 RSI: ffff95ffc006f2f0 RDI: 00007fff3aa=
91f7e
[11598.204055] RBP: ffff90d2f952a400 R08: 726f63657220706f R09: 00007fff3aa=
91f60
[11598.211179] R10: 000000000000095c R11: ffff90d2f3e1596c R12: ffff95ffc09=
47d40
[11598.218306] R13: ffff95ffc006f000 R14: ffff95ffc0947d48 R15: ffff95ffc00=
6f2d2
[11598.225447]  _copy_to_user+0x28/0x30
[11598.229027]  copy_from_read_buf+0x97/0x150
[11598.233127]  n_tty_read+0x202/0x920
[11598.236624]  ? set_fd_set.part.0+0x37/0x40
[11598.240720]  ? core_sys_select+0x278/0x2d0
[11598.244818]  ? rcu_all_qs+0x5/0x80
[11598.248229]  ? _cond_resched+0x15/0x30
[11598.251985]  ? ldsem_down_read+0x38/0x200
[11598.255997]  ? do_wait_intr_irq+0x90/0x90
[11598.260004]  tty_read+0x83/0xf0
[11598.263141]  __vfs_read+0x34/0x180
[11598.266540]  ? trace_buffer_unlock_commit_regs+0x37/0x90
[11598.271853]  ? trace_event_buffer_commit+0x66/0x1d0
[11598.276735]  vfs_read+0x9d/0x150
[11598.279968]  ksys_read+0x57/0xd0
[11598.283201]  do_syscall_64+0x78/0x3d0
[11598.286864]  ? __do_page_fault+0x206/0x400
[11598.290954]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[11598.296000] RIP: 0033:0x7effc6e2c441
[11598.299590] Code: Bad RIP value.
[11598.302820] RSP: 002b:00007fff3aa91f58 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[11598.310371] RAX: ffffffffffffffda RBX: 00007effc6d1b2c0 RCX: 00


Mit besten Gr=FC=DFen / Kind regards

NORBERT LANGE

AT-RD3

ANDRITZ HYDRO GmbH
Eibesbrunnergasse 20
1120 Vienna / AUSTRIA
p: +43 50805 56684
norbert.lange@andritz.com<mailto:norbert.lange@andritz.com>
andritz.com<http://www.andritz.com/>

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
Name: config-4.19.tar.xz
Type: application/octet-stream
Size: 20180 bytes
Desc: config-4.19.tar.xz
URL: <http://xenomai.org/pipermail/xenomai/attachments/20200217/bb047cbd/at=
tachment.obj>
