Message-ID: <4378B956.6020807@domain.hid>
Date: Mon, 14 Nov 2005 17:20:38 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG] rt_pipe_flush declaration missing
	in	skins/native/pipe.h
References: <4370641D.7010906@domain.hid>	<4370C966.3030903@domain.hid>	<4370D2B8.8070608@domain.hid>	<4370E49F.3070305@domain.hid>
	<437886EF.6070001@domain.hid> <4378A718.80105@domain.hid>
	<4378B67B.7090200@domain.hid>
In-Reply-To: <4378B67B.7090200@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Ignacio Garc=EDa P=E9rez wrote:
> Philippe Gerum wrote:
>=20
>=20
>>Ignacio Garc=EDa P=E9rez wrote:
>>
>>
>>>Hi,
>>>
>>>The subject says it all.
>>>
>>
>>Fixed, thanks.
>>
>>PS: please send patches when possible, it's faster to handle for me
>>and less likely to be forgotten in my job queue. TIA,
>>
>=20
> I updated my source from the repository, and the
> EXPORT_SYMBOL(rt_pipe_flush) in pipe.c is missing, so rt_pipe_flush is
> not usable yet. Patch attached.
>=20

Applied, thanks.

> Nacho.
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> Index: skins/native/pipe.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- skins/native/pipe.c	(revision 143)
> +++ skins/native/pipe.c	(working copy)
> @@ -1050,5 +1050,6 @@
>  EXPORT_SYMBOL(rt_pipe_read);
>  EXPORT_SYMBOL(rt_pipe_write);
>  EXPORT_SYMBOL(rt_pipe_stream);
> +EXPORT_SYMBOL(rt_pipe_flush);
>  EXPORT_SYMBOL(rt_pipe_alloc);
>  EXPORT_SYMBOL(rt_pipe_free);


--=20

Philippe.

