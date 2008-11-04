Message-ID: <4910C9B7.9060102@domain.hid>
Date: Tue, 04 Nov 2008 23:16:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081104220935.659ED1642C3@domain.hid>
In-Reply-To: <20081104220935.659ED1642C3@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problems with image building Icecube
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Marco_Ant=F4nio_Possamai?= <marco.possamai@domain.hid>
Cc: XENOMAI <Xenomai-help@domain.hid>

Marco Ant=F4nio Possamai wrote:
> Here's what I've done so far:
>=20
> $ export CROSS_COMPILE=3Dppc_6xx-
> (...)
> $ cd $XDIR
> $ ./configure --host=3Dppc-linux --prefix=3D/root/xenomai

You should read configure output, it is probably instructive. Notably,
it should tell you that there is no such compiler as ppc-linux-gcc,
since your compiler is called ppc_6xx-gcc, you should pass
--host=3Dppc_6xx to xenomai configure script.

alternatively, you can pass CC=3Dppc_6xx-gcc on configure command line.

This is all documented in README.INSTALL

> $ make
> (...)
> /bin/bash ../../libtool --tag=3DCC   --mode=3Dcompile gcc -DHAVE_CONFIG_H=
 -I.

And here you see that xenomai makefiles are using gcc, which is wrong.


--=20
					    Gilles.

