From: belatronix@domain.hid
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1KBFpL-0002d2-CR@www3.emo.freenet-rz.de>
Date: Tue, 24 Jun 2008 23:13:23 +0200
Subject: Re: [Xenomai-help] compiling probs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: Xenomai-help@domain.hid


----- original Nachricht --------

Betreff: Re: [Xenomai-help] compiling probs
Gesendet: Di 24 Jun 2008 13:12:26 CEST
Von: "Wolfgang Grandegger"<wg@domain.hid>

> Axel Beierlein wrote:
> > Hello,
> >=20
> > when i try to compile the module examples from the xenomai source =20
> > directory i get many <in file included> like this
> >=20
> > In file included from =20
> > /home/xx/linuxppc_2_4_25/include/asm/xenomai/hal.h:50,
> >                   from =20
> > /home/xx/linuxppc_2_4_25/include/asm-generic/xenomai/system.h:39,
> >                   from =20
> > /home/xx/linuxppc_2_4_25/include/asm/xenomai/system.h:29,
> >                   from =20
> > /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/types.h:39,
> >                   from =20
> > /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/queue.h:24,
> >                   from =20
> > /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/timer.h:23,
> >                   from =20
> > /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/thread.h:23,
> >                   from =20
> > /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/pod.h:34,
> >                   from =20
> > /home/xx/linuxppc_2_4_25/include/xenomai/nucleus/xenomai.h:23,
> >                   from =20
> > /home/xx/linuxppc_2_4_25/include/xenomai/rtdm/rtdm_driver.h:36,
> >                   from heartbeat-x86.c:21:
> >=20
> > also a type qualifier warning.
> >=20
> > /home/xx/linuxppc_2_4_25/include/asm/time.h:60: warning: type qualifier=
s=20
>=20
> > ignored on function return type
> >=20
> > Did anyone know what i make wrong?
> >=20
> > I use xenomai 2.3.5 and the Kernelsource 2.4.25 from the Denx repositor=
y=20
>=20
> > with the ELDK4.1.
> >=20
> > my make to build the modules is like <make XENO=3D$DESTDIR/root/xenomai=
 =20
> > CC=3Dppc_6xx-gcc> where DESTDIR is set to the Path where the rootfs is.
>=20
> Is your kernel configured and built?
Yes, the kernel is configured and built
> Does adding ARCH=3Dppc help?
No, ARCH=3Dppc is already set by the eldk_init script
> Is module support enabled in the kernel?
Yes, it is enabled
> What ELDK version do you use?
>=20
As i said before, i use the ELDK4.1
> It works fine here.
>=20
Here not

> Wolfgang.
>=20
Any other Ideas?

>=20
>=20
>=20

--- original Nachricht Ende ----
=0A=0A=0A=0AUnbegrenzter Speicher, Top-Spamschutz, 120 SMS und eigene E-Mai=
lDomain inkl.=0Ahttp://office.freenet.de/dienste/emailoffice/produktuebersi=
cht/power/mail/index.html=0A

