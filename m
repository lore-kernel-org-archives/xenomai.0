Message-Id: <200711011114.lA1BEr0t027337@domain.hid>
From: "Patrick" <kpa_info@domain.hid>
Date: Thu, 1 Nov 2007 12:14:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <200711011004.lA1A40qV005239@domain.hid>
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
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org

I have tried to compile my QT application with --posix-cflags and
--posix-ldflags but without success. I have a compilation error in =
syscall.h
:

/usr/xenomai/include/asm/xenomai/syscall.h:235: error: expected
primary-expression before =91.=92 Token

I think it's because QT is C++ application so it uses g++ and not gcc. =
And
Xenomai is not intended to be compiled with C++ compiler.

Patrick


-----Message d'origine-----
De=A0: xenomai-help-bounces@domain.hid =
[mailto:xenomai-help-bounces@domain.hid] De
la part de Patrick
Envoy=E9=A0: jeudi, 1. novembre 2007 11:04
=C0=A0: 'Gilles Chanteperdrix'; xenomai@xenomai.org
Objet=A0: Re: [Xenomai-help] RT, nonRT communication

Hello,

Do I have to use --posix-cflags and --posix-ldflags together with the
--xeno-cflags and --xeno-ldflags or are they exclusive?

Patrick


-----Message d'origine-----
De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org
Envoy=E9=A0: mercredi, 31. octobre 2007 09:44
=C0=A0: ROSSIER Daniel
Cc=A0: Patrick; xenomai@xenomai.org
Objet=A0: RE: [Xenomai-help] RT, nonRT communication

[...]

As soon as you compile your application with the flags returned by
xeno-config --posix-cflags and xeno-config --posix-ldflags, it really
becomes an RT application where all threads are real-time threads. The
only way to create a non real-time thread in such an application is by
calling __real_pthread_create.

--=20


					    Gilles Chanteperdrix.


_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help


