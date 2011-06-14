From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>
References: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Jun 2011 11:39:51 +0200
Message-ID: <1308044391.2699.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

On Tue, 2011-06-14 at 10:52 +0200, roderik.wildenburg@domain.hid
wrote:
> Sorry for asking again, but my question form June 7. wasn=C2=B4t answered=
 and I am not able to work it out by my own:
> When I use a PPC-Kernel 2.4.25 with Xenomai 2.5.6 I get the message=20
> "Xenomai: mmap local sem heap: No such device or address" when I start th=
e latency test (and other programs).
>=20
> But the rtheap-Device exists (see below). Can anybody give me a short hin=
t in which direction to search.
> Is Xenomai 2.5.6 intend to work with Kernel 2.4. ?
>=20

Yes. I don't have the bandwidth avail to have a look at this ATM. I'll
try to this week.

> Thank you in advance
> Roderik=20
>=20
> -----------------------------------------
> mrconfig:/fat/sbin # ll /dev/rtheap
> crw-rw-rw-    1 root     root      10, 254 May 19 14:16 /dev/rtheap
>=20
> mrconfig:/fat/sbin # strace ./latency
> execve("./latency", ["./latency"], [/* 37 vars */]) =3D 0
> uname({sys=3D"Linux", node=3D"mrconfig", ...}) =3D 0
> :
> :
> :
> access("/dev/rtheap", F_OK)             =3D 0
> rt_sigaction(SIGILL, {0xff23cb8, [ILL], SA_RESTART}, {SIG_DFL}, 8) =3D 0
> rt_sigaction(SIGILL, {SIG_DFL}, {0xff23cb8, [ILL], SA_RESTART}, 8) =3D 0
> open("/dev/rtheap", O_RDWR)             =3D 3
> ioctl(3, 0, 0xc7dd9210)                 =3D 0
> mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =3D -1 ENXIO (N=
o such device or address)
> close(3)                                =3D 0
> dup(2)                                  =3D 3
> fcntl64(3, F_GETFL)                     =3D 0x2 (flags O_RDWR)
> fstat64(3, {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(4, 64), ...}) =3D 0
> ioctl(3, TCGETS, {B38400 opost isig icanon echo ...}) =3D 0
> mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x30016000
> _llseek(3, 0, 0x7fffeac8, SEEK_CUR)     =3D -1 ESPIPE (Illegal seek)
> write(3, "Xenomai: mmap local sem heap: No"..., 56Xenomai: mmap local sem=
 heap: No such device or address
> ) =3D 56
> close(3)                                =3D 0
> munmap(0x30016000, 4096)                =3D 0
> exit(1)
>=20
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall,=
 Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Of=
fenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



