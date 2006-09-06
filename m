From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17662.64074.295816.904245@domain.hid>
Date: Wed, 6 Sep 2006 18:41:46 +0200
Subject: Re: [Xenomai-help] Segfault inb
In-Reply-To: <44FEF99B.5000900@domain.hid>
References: <44FEF99B.5000900@domain.hid>
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
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
 > Hi,
 >=20
 > There must be something very obvious I'm missing, yet I don't know why=
=20
 > and I'm stuck.
 >=20
 > I've got a very simple program that starts a simple periodic task that=
=20
 > reads from port 0x281 at 2KHz. When the inb(0x281) is executed my=20
 > program segfaults. If I comment that code, everything works fine (the=20
 > periodic task executes as expected).
 >=20
 > In my initialization code, I've remembered to:
 >=20
 > iopl(3)
 > mlockall(MCL_CURRENT | MCL_FUTURE)
 > rt_misc_get_io_region
 >=20
 > Even tried to issue the iopl(3) again from the periodic task itself. N=
o way.
 >=20
 > I'm using kernel 2.6.17.11 and Xenomai v2.2.2.

Do you check the return values of iopl and mlockall ?

--=20


					    Gilles Chanteperdrix.

