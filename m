Message-ID: <498C4DB1.3010206@domain.hid>
Date: Fri, 06 Feb 2009 15:48:17 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <3FA3B82E3C8A4CAABABE6EBABF2FA4B5@domain.hid>
In-Reply-To: <3FA3B82E3C8A4CAABABE6EBABF2FA4B5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] How to check task activation ?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastien DI MERCURIO <sebastien.di-mercurio@domain.hid>
Cc: xenomai@xenomai.org

Sebastien DI MERCURIO wrote:
> Hello,
> =20
> Is there a way to get task scheduling log in xenomai ? Something like a
> log in /proc/xenomai, telling which task was activated at which time,
> and then which other task was activated .... would be fine?
>

No. You can do it yourself using the task callouts in kernel space (namel=
y
TSWITCH). If you are running on top of the VxWorks skin, then the taskHoo=
kLib is
available from kernel space. If you are running on top of the native API,
rt_task_add_hook() is an equivalent. The idea would be to create a small =
module
using the native API in kernel space as well, that registers a TSWITCH sc=
heduler
hook. The hook routine would emit a record via a message pipe (RT_PIPE) f=
or each
event, which a plain Linux process would collect by reading on the user-s=
pace
end of the pipe.

Note: this will obviously cause overhead.

The other option is to either use LTTng or the I-pipe tracer, but you wou=
ld
collect a lot of data, aside of the TSWITCH events. YMMV.

> Other point: is there some kind of monitoring tool (a bit like windrive=
r
> Windview) working on xenomai ?

No.

> =20
> Best regards
> =20
> -----------------------------------------------------------------------=
-
> *S=E9bastien DI MERCURIO*
> DGEI - Bureau 108 - 1er =E9tage
> Institut National des Sciences Appliqu=E9es
> 135 Avenue de Rangueil, 31077, Toulouse cedex 4
> Tel: 05 61 55 98 34
> =20
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.

