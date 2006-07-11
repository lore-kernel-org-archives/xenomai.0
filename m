Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: AW: [Xenomai-help] memset of heap crashes Xenomai-Task
Date: Tue, 11 Jul 2006 08:25:29 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A3F9210@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: gilles.chanteperdrix@xenomai.org
Cc: xenomai@xenomai.org


>=20
> memset should work with Xenomai heaps, I suspect your problem=20
> is rather that the memory is not really allocated until you=20
> memset it, which fails when no memory is available. In this=20
> case, calling memset on memory allocated with malloc should=20
> segfault the same way when the system memory is exhausted.=20
> IIRC, this behaviour is documented in mlockall manual page.
>=20

Mr. Denk told me about this strange (for RTOSs) behaviour of the=20
Linux kernel. Therefore I used the Xenomai heap mechanism, expecting
allocated memory is allocated at once not some time later=20
(why do I allocate memory otherwise : to be shure memory is available).
Does Xenomai use the Linux allocation mechanism ??


> Be careful with sysconf(_SC_AVPHYS_PAGES), it may include the=20
> swap size, but when mlocking memory, your application can not=20
> use swap pages, so, you should substract the size of swap, if any.
> Also, what is the value of /proc/sys/vm/overcommit_memory on=20
> your system ?
>=20

Our System does not have a swap device\space.
/proc/sys/vm/overcommit_memory =3D 0
(whatever this means)


Thank you for your help
Roderik

