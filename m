Message-ID: <12369029.1206527800712.JavaMail.ngmail@domain.hid>
Date: Wed, 26 Mar 2008 11:36:40 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
In-Reply-To: <47E9B406.8030407@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
References: <47E9B406.8030407@domain.hid>
Subject: Re: [Xenomai-help] Direct access to I/O ports and physical memory
 from	user-space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: kalibera@domain.hid, xenomai@xenomai.org

Hello Tomas,

outb() and inb() are actually realized by the correspondend x86 CPU command=
s
(Please see the Intel/AMD references for details).
Thus, there is no mode switch as this not a system call.
The same is with memory mapped IO. I use this regularly to access (propriet=
ary) PCI hardware
directly from user space. This works perfectly.

Regards

Mathias
> Hello,
>=20
> is it possible to access I/O port on x86 solely from Xenomai user-space=
=20
> primary domain ? I assume that iopl() and then outb(), inb() should=20
> work. But, how to avoid switches to secondary domain ?
>=20
> Similarly, for physical memory, there is an example in Xenomai=20
> distribution that mmaps /dev/mem. Is there a way to avoid switches here ?
>=20
> Thanks,
> Tomas
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20

--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Jetzt komfortabel bei Arcor-Digital TV einsteigen: Mehr Happy Ends, mehr He=
rzschmerz, mehr Fernsehen! Erleben Sie 50 digitale TV Programme und optiona=
l 60 Pay TV Sender, einen elektronischen Programmf=FChrer mit Movie Star Be=
wertungen von TV Movie. Au=DFerdem, aktuelle Filmhits und prickelnde Erotik=
 in der Arcor-Videothek. Infos unter www.arcor.de/tv

