Message-ID: <4376463C.7090908@domain.hid>
Date: Sat, 12 Nov 2005 20:45:00 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] printk
References: <FDBBB5CC70676540B3EF7CFE83FD94E004305A@EINT11.einet.ad.eivd.ch>
	<437464B2.6030204@domain.hid>
In-Reply-To: <437464B2.6030204@domain.hid>
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
> I'm porting an app from RTAI to Xenomai, and when it came to the
> rt_printk function, I had to replace it with plain printk (the
> xnarch_log* functions all use printk).
>=20
> What I want to know if:
>=20
> 1- Is totally safe to call the standard kernel printk function from a
> real time task?
>=20

Yes.

> 2- Even if it's safe, can it affect the performance of a real time task=
?
> (or can it block under *any* conceivable condition?)
>

No.

> Thanks.
>=20
> Nacho.
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20

Philippe.

