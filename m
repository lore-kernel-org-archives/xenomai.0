Message-ID: <4B744CA8.6090201@domain.hid>
Date: Thu, 11 Feb 2010 19:30:00 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
	<4B729B04.9010909@domain.hid>
	<8b216e9e1002100349y71f40d9ct9cbf496846f33f2e@domain.hid>
	<8b216e9e1002100358u71d73d36xb851e59e23e069d1@domain.hid>
	<4B72C18F.20903@domain.hid>
	<8b216e9e1002101128t1246a5deh28ca13229f1d688d@domain.hid>
	<8b216e9e1002111005h6b432bcby17d4127d3b9d385a@domain.hid>
In-Reply-To: <8b216e9e1002111005h6b432bcby17d4127d3b9d385a@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Felipe Brand=C3=A3o Cavalcanti wrote:
> OK, so I did test it - the programs seem to run, but Xenomai doesn't se=
em to
> be working.
>=20
> When I run the latency test, I get the following output:
>=20
> =3D=3D Sampling period: 1000 us
> =3D=3D Test mode: periodic user-mode task
> =3D=3D All results in microseconds
> warming up...
> latency: failed to set periodic, code -110
>=20
> Anyone has a clue on what's going on? I am tweaking the kernel options
> hoping to make it work.

Very likely, the current linux clockevent is not the one supported by
Xenomai. cat /proc/timer_list will tell you which driver is used for
clock events.

The one supoprted by Xenomai is the one called:
"gp timer"

If it is not the one you have, then you have to disabled the
configuration option corresponding to the timer used.

--=20
Gilles Chanteperdrix, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com


