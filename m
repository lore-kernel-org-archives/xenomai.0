From: Lange Norbert <norbert.lange@andritz.com>
Subject: stalled head domain with 3.1rc4
Date: Fri, 13 Dec 2019 10:15:51 +0000
Message-ID: <VI1PR05MB5917452476FF30146D701888F6540@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

Just had a bug msg pop up. Its triggered by enabling tracing, while we have=
 2 processes running, using IDDP, XDDP and RTNet (just packet sockets, no i=
p stack).
Some points:

-       trace-cmd stores in tmp, so shouldn't touch other filesystems than =
tmpfs, sysfs

-       upon starting this, our process complains about a 150ms hole in CPU=
 time (likely the time of the bug)

-       it seems to happen only the first time after a boot

-       running trace-cmd "dry" (without our processes) doesn't trigger the=
 bug. Neither when disabling active communication on our project (per milli=
second up to 15 eth packets in both directions via packet socket, using the=
 new send/recv_mmsg calls).

-       system seems to continue stable afterwards

-       a trace is attached, not after triggering the bug (then it would ju=
st contain our project in error state) but showing or project with active c=
ommunication  (ie. trace-cmd started a second time after a bug)


# trace-cmd record -e 'cobalt*'
[  160.443596] I-pipe: Detected stalled head domain, probably caused by a b=
ug.
[  160.443596]         A critical section may have been left unterminated.
[  160.457178] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.84-xeno8-stat=
ic #1
[  160.464323] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.20 08/05/2019
[  160.473640] I-pipe domain: Linux
[  160.476877] Call Trace:
[  160.479345]  dump_stack+0x8c/0xc0
[  160.482672]  ipipe_stall_root+0xc/0x30
[  160.486436]  __ipipe_trap_prologue+0x100/0x210
[  160.490894]  int3+0x45/0x70
[  160.493702] RIP: 0010:xnthread_resume+0x75/0x3a0
[  160.498329] Code: 0f eb 00 74 21 31 c0 ba 01 00 00 00 f0 0f b1 15 c5 0f =
eb 00 85 c0 0f 85 db 02 00 00 4c 8b 2c 24 89 1d af 0f eb 00 4d0
[  160.517108] RSP: 0018:ffff9934400a7dd8 EFLAGS: 00000046
[  160.522349] RAX: 0000000000000001 RBX: 0000000000000001 RCX: 00007f37aa6=
03700
[  160.529490] RDX: 0000000000000001 RSI: 0000000000000080 RDI: ffff9934405=
dc240
[  160.536631] RBP: ffff9934405dc240 R08: 00000000000f7df7 R09: ffff9140f8c=
b2800
[  160.543774] R10: 00000000000003b3 R11: 00000000000b8c4a R12: 00000000000=
25090
[  160.550918] R13: 0000000000000003 R14: 0000000000000080 R15: 00000000000=
00080
[  160.558064]  ? xnthread_resume+0x75/0x3a0
[  160.562083]  ? xnthread_resume+0x1f/0x3a0
[  160.566104]  ipipe_migration_hook+0xda/0x1d0
[  160.570385]  complete_domain_migration+0x79/0xe0
[  160.575011]  __ipipe_switch_tail+0x39/0x50
[  160.579118]  __schedule+0x2d0/0x890
[  160.582615]  schedule_idle+0x28/0x40
[  160.586203]  do_idle+0x101/0x130
[  160.589440]  cpu_startup_entry+0x6f/0x80
[  160.593373]  start_secondary+0x169/0x1b0
[  160.597312]  secondary_startup_64+0xa4/0xb0



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
Name: trace.dat.xz
Type: application/octet-stream
Size: 2775472 bytes
Desc: trace.dat.xz
URL: <http://xenomai.org/pipermail/xenomai/attachments/20191213/0e1c8638/at=
tachment.obj>
