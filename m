Message-ID: <4378776C.2080405@domain.hid>
Date: Mon, 14 Nov 2005 12:39:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Invalid characters in task's names
References: <FDBBB5CC70676540B3EF7CFE83FD94E004305A@EINT11.einet.ad.eivd.ch>	<437464B2.6030204@domain.hid>
	<43786B29.7000601@domain.hid>
In-Reply-To: <43786B29.7000601@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> I just noticed "/" is not a valid character for a task's name. Probably
> something to do with the clever use that xeno makes of the /proc
> filesystem.:
>

It's strictly /procfs related, yes.

> 1- Are there any other "forbidden" characters?

No.

>=20
> 2- Does this limitation apply to the other named objects?
>=20

Yes. Everything that goes through the registry support.

> 3- Shouldn't those characters be internally escaped somehow to overcome
> this limitation?
>=20

At some point in time, especially the day we add distributed computing=20
facilities, we could find an interesting use of this single reserved char=
acter=20
to express object hierarchies too.

> 4- If (2) is not possible, shouldn't this limitation be mentioned in th=
e
> API documentation.
>=20

It is actually. Excerpt from rt_registry_enter()'s documentation:

  * - -EINVAL is returned if @a key or @a objaddr are NULL, or if @a
  * key constains an invalid '/' character.

The connection between any object creation routine and the registry is cl=
early=20
stated throughout the documentation, but the indirect use of rt_registry_=
enter=20
might not be explicitely mentioned though.

> Thanks.
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

