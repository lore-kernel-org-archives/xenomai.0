From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Mon, 9 Nov 2009 14:43:32 -0700
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03310B01E8@domain.hid>
References: <BB99A6BA28709744BF22A68E6D7EB51F03248BDB59@domain.hid>
	<4AA95F97.6010802@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03248BDBCD@midas.usurf.usu.edu>
	<4AA96689.3010502@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03248BDC03@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03310B0104@domain.hid>
	<4AF88CB1.6010700@domain.hid>
In-Reply-To: <4AF88CB1.6010700@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Installation and Makefile Help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> > else
> >
> > #	We are calling make from the kernel build system, therefore we
> simply define
> > #	what the modules are.
> >
> > 	obj-m :=3D fpgaDriver.o
>=20
> EXTRA_CFLAGS+=3D-Iinclude/xenomai
>=20
> >
> > endif
>=20
> You can put that in a file named "Kbuild" too, this avoids the big
> if.
>=20
> There are Makefile examples in xenomai sources "examples" sub-
> directory.

Thanks for pointing me to the examples.  They helped.



