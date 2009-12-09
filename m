Message-ID: <4B1FED2B.6000607@domain.hid>
Date: Wed, 09 Dec 2009 19:32:11 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <OFD063D933.7A634F4F-ONC1257685.0047F2EE-C1257685.004B47A1@domain.hid>
In-Reply-To: <OFD063D933.7A634F4F-ONC1257685.0047F2EE-C1257685.004B47A1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Undefined reference to Posix shm_* with uClibc
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Hagen.Langbartels@domain.hid
Cc: xenomai@xenomai.org

Hagen.Langbartels@domain.hid wrote:
> Hi all,
>=20
> I tried to compile Xenomai 2.5rc4 with uClibc 0.9.30.1 and ran into som=
e=20
> problems with references to the=20
> posix functions shm_open and shm_unlink in /src/skins/posix/wrappers.c,=
=20
> which do not exist in uClibc.
>=20
> Unlinke in  /src/skins/posix/shm.c the existence of these functions is =
not=20
> verfied (via #ifdef HAVE_SHM_*)
> and the build fails.
>=20
> The following patch is a quick and dirty fix for this problem. I hope t=
his=20
> might be helpful.
>=20

Actually, it looks clean to me. Can you provide it with the formal
signed-off, proper title and short description (as recent commits look
like in Xenomai)?

Jan

>=20
> diff -Nur xenomai-2.4.93.orig/src/skins/posix/wrappers.c=20
> xenomai-2.4.93.work/src/skins/posix/wrappers.c
> --- xenomai-2.4.93.orig/src/skins/posix/wrappers.c      2009-03-30=20
> 12:24:50.000000000 +0200
> +++ xenomai-2.4.93.work/src/skins/posix/wrappers.c      2009-12-07=20
> 14:22:03.983876500 +0100
> @@ -245,17 +245,21 @@
>  }
> =20
>  /* shm */
> +#ifdef HAVE_SHM_OPEN
>  __attribute__ ((weak))
>  int __real_shm_open(const char *name, int oflag, mode_t mode)
>  {
>         return shm_open(name, oflag, mode);
>  }
> +#endif
> =20
> +#ifdef HAVE_SHM_UNLINK
>  __attribute__ ((weak))
>  int __real_shm_unlink(const char *name)
>  {
>         return shm_unlink(name);
>  }
> +#endif
> =20
>  __attribute__ ((weak))
>  int __real_ftruncate(int fildes, long length)
>=20
>=20
>=20
>=20
> Best regards,
> Hagen Langbartels
>=20
> SIEB & MEYER AG
> Dipl.-Inf. (FH) Hagen Langbartels
>=20
> Auf dem Schmaarkamp 21
> 21339 L=FCneburg
> Germany
> Tel.: +49-4131-203-1133
> Fax.: +49-4131-38562
> E-mail: development@domain.hid
> www.sieb-meyer.de
>=20
> Vorstand: Markus Meyer, Torsten Blankenburg
> Aufsichtsratsvorsitzender: Hans Reinen
> Amtsgericht L=FCneburg: HRB 1805
> Umsatzsteuer-ID.-Nr.: DE 116085664
>=20
>=20

--=20
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

