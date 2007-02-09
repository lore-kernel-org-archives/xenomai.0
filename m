Message-ID: <45CC8621.3030709@domain.hid>
Date: Fri, 09 Feb 2007 15:33:05 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] system() question
References: <45C9F9CD.6000101@domain.hid>	<45C9F2F9.3020204@domain.hid>	<45CAE1C2.5040207@domain.hid>	<17866.56537.695811.3523@domain.hid>	<45CC8A19.6080109@domain.hid>
	<45CC7E33.3020707@domain.hid>
In-Reply-To: <45CC7E33.3020707@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: Quoted-Printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> St=E9phane ANCELOT wrote:
>=20
>>I tried it, but did not help, I manged to do the trick using=20
>>start-stop-daemon
>=20
>=20
> If I understand correctly the problem you have, it is not related at al=
l
> with Xenomai. What you want is to make your application a real daemon.
> The easy way to do this is to call the glibc function named "daemon" th=
e
> hard way is to call fork twice, call setsid and setpgrp.
> start-stop-daemon will not do the trick.
>=20

It is enough to fork only once, to call setsid in the child and call
_exit in the father. That is what the daemon function does. Anyway, this
is basic unix knowledge, for which you will get more acurate details at
other places.

--=20
                                                 Gilles Chanteperdrix

