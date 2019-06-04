MIME-Version: 1.0
Message-ID: <trinity-8b4a1a24-36bf-48e6-8b5e-ae45645c70ab-1559636643478@3c-app-gmx-bs58>
From: "Sebastian Smolorz" <Sebastian.Smolorz@gmx.de>
Subject: Re: RTnet bind failed socket again
Content-Type: text/plain; charset=UTF-8
Date: Tue, 4 Jun 2019 10:24:03 +0200
In-Reply-To: <1132257520.2299169.1559634353991.JavaMail.zimbra@wolfram.com>
References: <ea8b5153-3530-4b7b-3a73-586cda346cbe@compador.de>
 <1523560934.2012965.1559553044281.JavaMail.zimbra@wolfram.com>
 <ebc7a250-dbaa-c898-f04c-2822199d2f3a@siemens.com>
 <1132257520.2299169.1559634353991.JavaMail.zimbra@wolfram.com>
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: pero@wolfram.com
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai <xenomai@xenomai.org>

Hi,

on 04=2E06=2E2019 09:45, Per Oberg wrote:
> ----- Den 3 jun 2019, p=C3=A5 kl 17:33, Jan Kiszka jan=2Ekiszka@siemens=
=2Ecom skrev:
>=20
> > On 03=2E06=2E19 11:10, Per Oberg via Xenomai wrote:
>=20
>=20
>=20
> > > ----- Den 3 jun 2019, p=C3=A5 kl 11:06, xenomai xenomai@xenomai=2Eor=
g skrev:
>=20
> > >> Hi,
>=20
> > >> My program opens a RTnet socket successfully but the program gets k=
illed
> > >> by a different issue that has nothing to do with this=2E However, t=
he
> > >> RTnet socket is still bound=2E If I try to start the program again =
i get
> > >> the error "Address already in use"=2E If it would be a normal unix =
socket
> > >> I would simply call it with SO_REUSEADDR but this is not possible w=
ith
> > >> RTnet from what I understand=2E
>=20
> >> I tried this and failed miserably=2E That said, I'm also interested i=
n the answer
> > > to this question=2E
>=20
> > >> My question is why the socket is not unbound after the binding proc=
ess
> > >> is killed and if there is a way to reclaim this socket=2E By the wa=
y, it
> > >> has to be this socket since the communication partner expects the s=
erver
> > >> to listen on this exact port=2E
>=20
> > >> Cheers,
>=20
> > >> Johannes
>=20
> > > Per =C3=96berg
>=20
>=20
> > Are we talking about UDP in both cases?
>=20
> I use UDP, yes=2E But I had no problems with the UDP part=2E=20
>=20
> The problem I had was regarding the use of setsockopt=2E Because I test =
the code on a regular linux machine the lingering of the sockets after kill=
ing the application can be annoying=2E From what you describe below, SO_REU=
SEADDR should not be necessary for this case (did I get that correctly? )=
=2E=20
>=20
> Because I use the posix skin, and because it was necessary in regular li=
nux, i started out using it in the common code base but I never managed to =
get it working in RT so I removed it again=2E=20
>=20
> I used something like:
>=20
> > int reuseSetting =3D 1;
> > setsockopt(datagramSocket, SOL_SOCKET, SO_REUSEADDR, &reuseSetting, si=
zeof(int);
>=20
> Or even (because I use both rt and not rt sockets in the same code and I=
 got the feeling that the automatic handling of this didn't quite work out=
=2E)
> > __cobalt_setsockopt(datagramSocket, SOL_SOCKET, SO_REUSEADDR, &reuseSe=
tting, sizeof(int);
>=20
>=20
> This gave me:=20
> ------------------------------------------------------------------------=
----------------------------------------------
> 70642=2E666691] [Xenomai] switching App Thread to secondary mode after e=
xception #14 in kernel-space at 0xffffffffa0281787 (pid 633)
> [70642=2E667326] BUG: unable to handle kernel paging request at 00007fe0=
6ff84d20
> [70642=2E667948] IP: [<ffffffffa0281787>] rt_ip_ioctl+0x27/0x120 [rtipv4=
]
> [70642=2E668566] PGD 80000002631e7067=20
> [70642=2E668575] PUD 24a07d067=20
> [70642=2E669184] PMD 260cab067=20
> [70642=2E669189] PTE 800000023b6cc067
> [70642=2E669805]=20
> [70642=2E670403] Oops: 0001 [#5] PREEMPT SMP
> [70642=2E670989] Modules linked in: rtudp rtipv4 intel_powerclamp intel_=
rapl coretemp rt_igb e1000e i915 rtnet pcan(O) video fan thermal_sys
> [70642=2E671629] CPU: 3 PID: 633 Comm: App Thread Tainted: G      D W  O=
    4=2E9=2E90-xeno-cobolt #1
> [70642=2E672239] Hardware name: Default string Default string/SKYBAY, BI=
OS 5=2E0=2E1=2E1 04/18/2016
> [70642=2E672854] I-pipe domain: Linux
> [70642=2E673459] task: ffff880263231b00 task=2Estack: ffffc90001798000
> [70642=2E674066] RIP: 0010:[<ffffffffa0281787>]  [<ffffffffa0281787>] rt=
_ip_ioctl+0x27/0x120 [rtipv4]
> [70642=2E674683] RSP: 0018:ffffc9000179bda8  EFLAGS: 00010246
> [70642=2E675300] RAX: 000000000007ffff RBX: 0000000040180021 RCX: ffff88=
026dd80000
> [70642=2E675923] RDX: 00007fe06ff84d20 RSI: 0000000040180021 RDI: ffff88=
0262a86800
> [70642=2E676544] RBP: ffffc9000179bdd0 R08: 0000000000000050 R09: ffff88=
0263231b00
> [70642=2E677166] R10: 00000000000000e6 R11: 0000000000000000 R12: ffff88=
0262a86800
> [70642=2E677783] R13: 0000000040180021 R14: 00007fe06ff84d20 R15: 000000=
0062a86800
> [70642=2E678394] FS:  00007fe06ff85700(0000) GS:ffff88026dd80000(0000) k=
nlGS:0000000000000000
> [70642=2E679009] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [70642=2E679621] CR2: 00007fe06ff84d20 CR3: 0000000261678000 CR4: 000000=
0000360630
> [70642=2E680233] Stack:
> [70642=2E680838]  ffffffffa028c6f7 0000000000000001 ffffffff81178cd0 fff=
f880262a86800
> [70642=2E681464]  0000000000000003 ffffc9000179be60 ffffffff811725be 000=
0000000000202
> [70642=2E682086]  ffff880263231b00 ffff880200000010 ffffc9000179be70 fff=
fc9000179be08
> [70642=2E682711] Call Trace:
> [70642=2E683325]  [<ffffffffa028c6f7>] ? rt_udp_ioctl+0x67/0x8c [rtudp]
> [70642=2E683949]  [<ffffffff81178cd0>] ? CoBaLt_fcntl+0x20/0x20
> [70642=2E684573]  [<ffffffff811725be>] rtdm_fd_ioctl+0xee/0x280
> [70642=2E685199]  [<ffffffff81178cd0>] ? CoBaLt_fcntl+0x20/0x20
> [70642=2E685825]  [<ffffffff81178cd0>] ? CoBaLt_fcntl+0x20/0x20
> [70642=2E686445]  [<ffffffff81178cde>] CoBaLt_ioctl+0xe/0x20
> [70642=2E687064]  [<ffffffff81188472>] ipipe_syscall_hook+0x112/0x350
> [70642=2E687686]  [<ffffffff8110acb8>] __ipipe_notify_syscall+0xc8/0x190
> [70642=2E688306]  [<ffffffff8110adaa>] ipipe_handle_syscall+0x2a/0xb0
> [70642=2E688925]  [<ffffffff81001c3d>] do_syscall_64+0x2d/0xf0
> [70642=2E689514]  [<ffffffff818dffbe>] entry_SYSCALL_64_after_swapgs+0x5=
8/0xc6
> [70642=2E690073] Code: 68 b8 eb b0 e8 ab 04 66 e1 81 fe 27 00 10 40 0f 8=
4 c1 00 00 00 7e 73 81 fe 20 00 18 40 74 3c 81 fe 21 00 18 40 0f 85 a0 00 0=
0 00 <8b> 02 8b 4a 10 4c 8b 42 08 8b 72 04 85 c0 0f 85 d6 00 00 00 83=20
> [70642=2E691405] RIP  [<ffffffffa0281787>] rt_ip_ioctl+0x27/0x120 [rtipv=
4]
> [70642=2E692026]  RSP <ffffc9000179bda8>
> [70642=2E692642] CR2: 00007fe06ff84d20
> [70642=2E693250] ---[ end trace 53b7ee62f61c9cca ]---
> ------------------------------------------------------------------------=
----------------------------------------------

This is the same error we faced several times already in RTnet:
Unsafe direct access to userspace memory=2E I could prepare a patch
as I did it just for rttcp=2E

>=20
> > What should happen: When a process dies, its open rt fds gets closed=
=2E RTDM will
> > call down to the driver to do the necessary work, in case of UDP to rt=
_udp_close
> > which also removes the entries from the port registry and bitmap=2E Yo=
u can
> > confirm that by tracing that part - or send a simple test case that re=
produces
> > the issue=2E
>=20
> > Jan
>=20
> > --
> > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > Corporate Competence Center Embedded Linux
>=20
> Per =C3=96berg=20
>=20
>=20

--=20
Sebastian

