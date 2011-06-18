From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <3FF315C710820E47A04E55C6F7D9B0AD7FEA2C@AREXCH02.mra.roland-man.biz>
References: <3FF315C710820E47A04E55C6F7D9B0AD7FE9FF@AREXCH02.mra.roland-man.biz>
	<1308044391.2699.2.camel@domain.hid>
	<3FF315C710820E47A04E55C6F7D9B0AD7FEA2C@AREXCH02.mra.roland-man.biz>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 18 Jun 2011 10:50:52 +0200
Message-ID: <1308387052.2122.14.camel@domain.hid>
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

On Tue, 2011-06-14 at 14:47 +0200, roderik.wildenburg@domain.hid
wrote:
> Perhaps this may help:
> I instrumented src/common/sem_heap.c   and ksrc/nucleus/heap.c with print=
f and printk (see appended files) and this is the output:
>=20
> 1:mrconfig:~ # latency
> 2:xeno_init_private_heap
> 3:map_sem_heap syscall 0
> 4:xeno_map_heap open 3
> 5:xnheap_ioctl private data: 00000000
> 6:xeno_map_heap ioctl 0 handle 0xc7dd9210
> 7:xnheap_mmap 00000000 00000000
> 8:xeno_map_heap 0xffffffff
> 9:Xenomai: mmap local sem heap: No such device or address
> 10:mrconfig:~ #
>=20
>=20
> It looks like (if I figured it out correctly) as if in function sem_heap.=
c->xeno_map_heap()  (which is called from xeno_init_privat_heap() via funct=
ion map_sem_heap())  the ioctl-Call fails.=20
> xeno_map_heap() passes correctly an argument unequal NULL as third parame=
ter to ioctl() (line6), but in kernel space function xnheap_ioctl() the 3. =
parameter arrives as NULL(line 5). This sets file->private_data to NULL whi=
ch in turn lets xnheap_mmap() fail, as this function expects file->private_=
data !=3D NULL (line7).
> Therefore xnheap_mmap() returns -ENIXIO to xeno_map_heap() which outputs =
the error message " Xenomai: mmap local sem heap: No such device or address=
".
> The one million dollar question is, why the 3. parameter of ioctl() mutat=
es to NULL. Any idea?
>=20
> If I can do anything else, let me know.
>=20

You will need these patches to run linux 2.4.25 over 2.5.6. The first
one fixes the ioctl() issue.
http://git.xenomai.org/?p=3Dxenomai-rpm.git;a=3Dcommit;h=3Dc2a24b90667e12d0=
614e5d8442dba74f137f9d4d
http://git.xenomai.org/?p=3Dxenomai-rpm.git;a=3Dcommit;h=3Dbebc2a8e6b430c99=
041800330dc6061665371d90

Note: the switch test does not seem to be running correctly on my
icecube (albeit the latency one does), somehow linux reschedule events
get lost. For this reason, I would not consider the current state as
being production-grade.

> Roderik
>=20
>=20
> > -----Urspr=C3=BCngliche Nachricht-----
> > Von: Philippe Gerum [mailto:rpm@xenomai.org]
> > Gesendet: Dienstag, 14. Juni 2011 11:40
> > An: Wildenburg, Roderik RAEK1 MRA
> > Cc: xenomai@xenomai.org
> > Betreff: Re: [Xenomai-help] Xenomai 2.5.6 with PPC-Kernel 2.4.25
> >=20
> > On Tue, 2011-06-14 at 10:52 +0200, roderik.wildenburg@domain.hid
> > wrote:
> > > Sorry for asking again, but my question form June 7. wasn=C2=B4t answ=
ered and I am
> > not able to work it out by my own:
> > > When I use a PPC-Kernel 2.4.25 with Xenomai 2.5.6 I get the message
> > > "Xenomai: mmap local sem heap: No such device or address" when I star=
t the
> > latency test (and other programs).
> > >
> > > But the rtheap-Device exists (see below). Can anybody give me a short=
 hint in
> > which direction to search.
> > > Is Xenomai 2.5.6 intend to work with Kernel 2.4. ?
> > >
> >=20
> > Yes. I don't have the bandwidth avail to have a look at this ATM. I'll
> > try to this week.
> >=20
> > > Thank you in advance
> > > Roderik
> > >
> > > -----------------------------------------
> > > mrconfig:/fat/sbin # ll /dev/rtheap
> > > crw-rw-rw-    1 root     root      10, 254 May 19 14:16 /dev/rtheap
> > >
> > > mrconfig:/fat/sbin # strace ./latency
> > > execve("./latency", ["./latency"], [/* 37 vars */]) =3D 0
> > > uname({sys=3D"Linux", node=3D"mrconfig", ...}) =3D 0
> > > :
> > > :
> > > :
> > > access("/dev/rtheap", F_OK)             =3D 0
> > > rt_sigaction(SIGILL, {0xff23cb8, [ILL], SA_RESTART}, {SIG_DFL}, 8) =
=3D 0
> > > rt_sigaction(SIGILL, {SIG_DFL}, {0xff23cb8, [ILL], SA_RESTART}, 8) =
=3D 0
> > > open("/dev/rtheap", O_RDWR)             =3D 3
> > > ioctl(3, 0, 0xc7dd9210)                 =3D 0
> > > mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =3D -1
> > ENXIO (No such device or address)
> > > close(3)                                =3D 0
> > > dup(2)                                  =3D 3
> > > fcntl64(3, F_GETFL)                     =3D 0x2 (flags O_RDWR)
> > > fstat64(3, {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(4, 64), ...}) =
=3D 0
> > > ioctl(3, TCGETS, {B38400 opost isig icanon echo ...}) =3D 0
> > > mmap(NULL, 4096, PROT_READ|PROT_WRITE,
> > MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x30016000
> > > _llseek(3, 0, 0x7fffeac8, SEEK_CUR)     =3D -1 ESPIPE (Illegal seek)
> > > write(3, "Xenomai: mmap local sem heap: No"..., 56Xenomai: mmap local=
 sem
> > heap: No such device or address
> > > ) =3D 56
> > > close(3)                                =3D 0
> > > munmap(0x30016000, 4096)                =3D 0
> > > exit(1)
> > >
> > > --------------------------------------------------------
> > > manroland AG
> > > Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> > > Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus R=
all, Paul
> > Steidle
> > > Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgerich=
t
> > Offenbach HRB-Nr. 42592
> > > USt-Ident-Nr. DE 250200933
> > >
> > >
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> >=20
> > --
> > Philippe.
> >=20
> >
>=20
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall,=
 Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Of=
fenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933

--=20
Philippe.



