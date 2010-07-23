Message-ID: <4C496047.5070109@domain.hid>
Date: Fri, 23 Jul 2010 11:26:31 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTikROCnKiEBnl2W92zNQUNkScJ0reqaKVtS2iFcw@domain.hid>
In-Reply-To: <AANLkTikROCnKiEBnl2W92zNQUNkScJ0reqaKVtS2iFcw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] staging_dir install errors
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?R8O2cmtlbSBLYXJhZG/En2Fu?= <gkaradagan@domain.hid>
Cc: xenomai@xenomai.org

G=C3=B6rkem Karado=C4=9Fan wrote:
> libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I/opt/xenomai-2.5.3/src/rtd=
k
> -I../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> -march=3Darmv7-a -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes
> -I/opt/xenomai-2.5.3/include -MT librtdk_la-init.lo -MD -MP -MF
> .deps/librtdk_la-init.Tpo -c /opt/xenomai-2.5.3/src/rtdk/init.c  -fPIC
> -DPIC -o .libs/librtdk_la-init.o
> /opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for
> -march=3D switch
> /opt/xenomai-2.5.3/src/rtdk/init.c:1: error: bad value (armv7-a) for
> -mtune=3D switch

Your toolchain does not support the -march=3Darmv7-a flag. Either stop
using an old toolchain, or pass --enable-arm-mach=3Dimx31 to xenomai
configure script.


--=20
					    Gilles.


