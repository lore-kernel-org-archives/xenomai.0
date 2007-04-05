Message-ID: <4614F821.9080105@domain.hid>
Date: Thu, 05 Apr 2007 15:22:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Error at compilation of examples
References: <1175778504.26947.19.camel@domain.hid>
In-Reply-To: <1175778504.26947.19.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Beno=EEt_CAMUS?= <benoit.camus@domain.hid>
Cc: xenomai@xenomai.org

Beno=EEt CAMUS wrote:
> Hi all,
>=20
> I got errors in headers while trying to compile basical programs
> (sigcpu.c and a posix thread one). I use ELDK 4.1 cross-compiler for AR=
M
> architecture and 2.6.19 kernel. So here is error i got:
>=20
>=20
> $> arm-linux-gcc -I/opt/eldk/arm/usr/include/ -I/opt/eldk/arm/include/
> -D_GNU_SOURCE -D_REENTRANT -L/opt/eldk/arm/lib/ -lpthread -lnative
> -Xlinker -rpath -Xlinker /opt/eldk/arm/lib/ -o t_posix ./test_thread.c

The most simple way to compile an example for Xenomai posix skin is to
use the xeno-config script as installed by Xenomai. If you have run
Xenomai installation with DESTDIR set, pass the same DESTDIR in
xeno-config environment. Examples usually come with Makefiles that do so.

What version of Xenomai are you using ?


--=20
                                                 Gilles Chanteperdrix

