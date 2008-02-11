Message-ID: <47B0C7BD.3020609@domain.hid>
Date: Mon, 11 Feb 2008 23:10:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18350.7135.108901.491437@domain.hid>	<18350.7315.555644.171720@domain.hid>	<47AF057A.3070305@domain.hid>	<18351.28960.164520.295075@domain.hid>	<47AF781E.4070102@domain.hid>	<18351.31369.697255.825404@domain.hid>	<47AF7F3C.6080805@domain.hid>
	<18352.48401.264561.143362@domain.hid>
In-Reply-To: <18352.48401.264561.143362@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE6811B7988D2C1FED690CC4D"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [patch 2/4] RTDM support for select-like service.
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE6811B7988D2C1FED690CC4D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Would not it be simpler to put a pointer to the task_struct ? Afte=
r all,
>  > > it already has a pid, comm and mm, and a file descriptor will not
>  > > survive a task_struct thanks to automatic closing of file descript=
ors.
>  >=20
>  > Hmm, hmm, hmmmm... Sounds reasonable, should be safe.
>=20
> Actually no, we can not do that because a task_struct may well disappea=
r
> and the rtdm_process continue to exist as long as another thread uses t=
he
> same mm.

Because we cleanup on mm exit, not task exit, right? OK, looks like I=20
originally spent a few more thoughts than this time :-/.

>=20
>  >=20
>  > >=20
>  > >  Could you
>  > >  > live without the check until we have per-process fd tabled, or =
was it
>  > >  > essential for the select thing?
>  > >=20
>  > > An application which I ported to Xenomai (and which uses the selec=
t
>  > > call) closes all file descriptors in a for loop. The purpose of th=
is
>  > > loop is, I guess, to avoid leaving a file descriptor opened that w=
as
>  > > passed through exec.
>  >=20
>  > OK.
>  >=20
>  > So, will you change rtdm_process too? Thanks.
>=20
> I commited the select support, without any change to rtdm_context_get o=
r
> rtdm_process. So, now, how do you prefer this to be fixed, by adding an=

> mm struct to the rtdm_process struct ? By the way, after thinking about=

> it I can live without this fix: I just have to stop the loop closing
> file descriptors at 768, so that it will not try to close RTDM file
> descriptors.

If you can live with it, I would vote for fixing it by the intended=20
redesign via per-process fds.

>=20
> While commiting the support for select, I also had a dependency problem=

> in Kconfig: when support for posix select is enabled the posix module
> uses a function defined in the RTDM module. So, there is one invalid
> configuration: posix built-in with support for select and rtdm built as=

> a module. I could not find a way to express this condition in the
> Kconfig language, so I just made a comment depend on this condition, bu=
t
> would be happy if anyone found a better solution.

I would say:

config POSIX
	select RTDM if OPT_SELECT

Jan


--------------enigE6811B7988D2C1FED690CC4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHsMe/niDOoMHTA+kRAuGhAJ9oeG3P5XOFz5M1bysUlACE7JZxvgCaA4f1
8k/J9VkWt8pQQ0/IVHe2MZQ=
=279Z
-----END PGP SIGNATURE-----

--------------enigE6811B7988D2C1FED690CC4D--

