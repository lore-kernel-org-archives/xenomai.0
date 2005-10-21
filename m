Message-ID: <43591A62.1060701@domain.hid>
Date: Fri, 21 Oct 2005 18:42:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] timeout in native API calls (cond, sem, mutex,
	etc).
References: <4357C3E1.1040701@domain.hid>	<4357C9F7.2060808@domain.hid>	<4357CF67.8080601@domain.hid>	<4357DF0F.3060806@domain.hid>
	<435896AA.1060103@domain.hid> <4358C885.8010808@domain.hid>
In-Reply-To: <4358C885.8010808@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> In my previous (long) message I forgot something. I think that without
> support for abolute timeouts in the nucleus, the RTAI skin cannot be
> accurately implemented (*_until and *_timed calls).
>=20

There is no problem for any skin to enclose the timeout computation and t=
he=20
actual suspension call within an interrupt-free section, and as a matter =
of=20
fact, some skins already do this. What's not that handy, is for _user_ le=
vel=20
code to do the same, this is true. In that case, the issue is not with th=
e=20
nucleus, but with the skin.

> Nacho.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

