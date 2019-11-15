From: Lange Norbert <norbert.lange@andritz.com>
Subject: unable to handle kernel paging request 
Date: Fri, 15 Nov 2019 15:26:25 +0000
Message-ID: <VI1PR05MB5917F397C0E5FB7DAE50CF71F6700@VI1PR05MB5917.eurprd05.prod.outlook.com>
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

How can I get to the bottom of bugs that lockup the system completely?
I got that error now the 3rd time.

[ 1643.652566] BUG: unable to handle kernel paging request at 0000000000044=
540
[ 1643.659546] PGD 1750d1067 P4D 1750d1067 PUD 1775e7067 PMD 0
[ 1643.665237] Oops: 0010 [#1] SMP NOPTI
[ 1643.668911] CPU: 2 PID: 862 Comm: fup.medium Tainted: G        W        =
 4.19.75-xeno7-static #1
[ 1643.677703] Hardware name: TQ-Group TQMxE39M/Type2 - Board Product Name,=
 BIOS 5.12.30.21.16 01/31/2019
[ 1643.687013] I-pipe domain: Linux
[ 1643.690250] RIP: 0086:0x1c000
[ 1643.693231] Code: Bad RIP value.
[ 1643.696468] RSP: 3bb00000:0000000000000083 EFLAGS: ffff92103bb25090 ORIG=
_RAX: 0000000000000046
[ 1643.705092] RAX: ffff92103bb30400 RBX: ffff92103bb30400 RCX: ffff92103bb=
31bb0
[ 1643.712235] RDX: ffff92103bb31d58 RSI: ffffffff8ab85272 RDI: ffff921039f=
24cc0
[ 1643.719378] RBP: ffff92103bb305c8 R08: 0000000000000002 R09: ffff92103bb=
31d58
[ 1643.726517] R10: ffff92103bb31bb0 R11: 0000000000004000 R12: ffffffff8bc=
3f3c0
[ 1643.733657] R13: ffffffff8ab8284b R14: 000000000001c000 R15: 00000000000=
00086
[ 1643.740799] FS:  00007fffe81da700 GS:  0000000000000000
[ 1643.746033] Modules linked in: rt_igb plusb usbnet mii
[ 1643.751210] CR2: 0000000000044540
[ 1643.754542] ---[ end trace 7dda9c557e28b024 ]---
[ 1643.759167] RIP: 0086:0x1c000
[ 1643.762146] Code: Bad RIP value.
[ 1643.765379] RSP: 3bb00000:0000000000000083 EFLAGS: ffff92103bb25090 ORIG=
_RAX: 0000000000000046
[ 1643.774003] RAX: ffff92103bb30400 RBX: ffff92103bb30400 RCX: ffff92103bb=
31bb0
[ 1643.781147] RDX: ffff92103bb31d58 RSI: ffffffff8ab85272 RDI: ffff921039f=
24cc0
[ 1643.788289] RBP: ffff92103bb305c8 R08: 0000000000000002 R09: ffff92103bb=
31d58
[ 1643.795427] R10: ffff92103bb31bb0 R11: 0000000000004000 R12: ffffffff8bc=
3f3c0
[ 1643.802569] R13: ffffffff8ab8284b R14: 000000000001c000 R15: 00000000000=
00086
[ 1643.809712] FS:  00007fffe81da700(0000) GS:ffff92103bb00000(0000) knlGS:=
0000000000000000
[ 1643.817806] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1643.823558] CR2: 000000000001bfd6 CR3: 00000001750e4000 CR4: 00000000003=
406e0

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
