Message-Id: <200711011233.lA1CX9wf032489@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Thu, 1 Nov 2007 13:33:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4729B715.9060706@domain.hid>
Subject: Re: [Xenomai-help] RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: xenomai@xenomai.org

Ok. I use Xenomai 2.4-rc4 with adeos 1.7-06 for arm with 2.6.20 kernel.
And the compiler output:

/usr/local/qtopiarm/bin/qmake -unix -o Makefile gui.pro
arm-linux-gnueabi-g++ -c -pipe -O2 -Wall -W -D_REENTRANT -D_GNU_SOURCE
-D_REENTRANT -D__XENO__ -DQT_NO_DEBUG -DQT_GUI_LIB -DQT_NETWORK_LIB
-DQT_CORE_LIB -DQT_SHARED =
-I/usr/local/qtopiarm/mkspecs/qws/linux-arm-g++
-I. -I/usr/local/qtopiarm/include/QtCore
-I/usr/local/qtopiarm/include/QtCore =
-I/usr/local/qtopiarm/include/QtNetwork
-I/usr/local/qtopiarm/include/QtNetwork =
-I/usr/local/qtopiarm/include/QtGui
-I/usr/local/qtopiarm/include/QtGui -I/usr/local/qtopiarm/include -I.
-I/usr/xenomai/include -I/usr/xenomai/include/posix -Iprotlib -I. -I. -o
main.o main.cpp
/usr/xenomai/include/asm/xenomai/syscall.h:235: error: expected
primary-expression before =91.=92 token
make: *** [main.o] Erreur 1


Thanks

Patrick

-----Message d'origine-----
De=A0: jan.kiszka@domain.hid [mailto:jan.kiszka@domain.hid
Envoy=E9=A0: jeudi, 1. novembre 2007 12:23
=C0=A0: Patrick
Cc=A0: 'Gilles Chanteperdrix'; xenomai@xenomai.org
Objet=A0: Re: [Xenomai-help] RT, nonRT communication

Patrick wrote:
> I have tried to compile my QT application with --posix-cflags and
> --posix-ldflags but without success. I have a compilation error in
syscall.h
> :
>=20
> /usr/xenomai/include/asm/xenomai/syscall.h:235: error: expected
> primary-expression before =91.=92 Token
>=20
> I think it's because QT is C++ application so it uses g++ and not gcc. =
And
> Xenomai is not intended to be compiled with C++ compiler.

It _is_ intended and _is_ being used with C++. This doesn't exclude
regressions or arch-specific bugs in the headers though. What version,
what arch are you using? Can you post the full (related) compiler =
output?

Jan



