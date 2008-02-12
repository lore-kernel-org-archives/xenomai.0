Message-ID: <47B14C92.204@domain.hid>
Date: Tue, 12 Feb 2008 08:36:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <18350.7135.108901.491437@domain.hid>	<18350.7315.555644.171720@domain.hid>	<47AF057A.3070305@domain.hid>	<18351.28960.164520.295075@domain.hid>	<47AF781E.4070102@domain.hid>	<18351.31369.697255.825404@domain.hid>	<47AF7F3C.6080805@domain.hid>	<18352.48401.264561.143362@domain.hid>	<47B0C7BD.3020609@domain.hid>	<18352.51397.803115.798009@domain.hid>	<47B0C9B6.7080207@domain.hid>
	<18352.52347.906633.550225@domain.hid>
In-Reply-To: <18352.52347.906633.550225@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0E27ADBEB16B0FB849E5B77"
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
--------------enigF0E27ADBEB16B0FB849E5B77
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Jan Kiszka wrote:
>  > >  > Gilles Chanteperdrix wrote:
>  > >  > > Jan Kiszka wrote:
>  > >  > >  > Gilles Chanteperdrix wrote:
>  > >  > >  > > Would not it be simpler to put a pointer to the task_str=
uct ? After all,
>  > >  > >  > > it already has a pid, comm and mm, and a file descriptor=
 will not
>  > >  > >  > > survive a task_struct thanks to automatic closing of fil=
e descriptors.
>  > >  > >  >=20
>  > >  > >  > Hmm, hmm, hmmmm... Sounds reasonable, should be safe.
>  > >  > >=20
>  > >  > > Actually no, we can not do that because a task_struct may wel=
l disappear
>  > >  > > and the rtdm_process continue to exist as long as another thr=
ead uses the
>  > >  > > same mm.
>  > >  >=20
>  > >  > Because we cleanup on mm exit, not task exit, right? OK, looks =
like I=20
>  > >  > originally spent a few more thoughts than this time :-/.
>  > >  >=20
>  > >  > >=20
>  > >  > >  >=20
>  > >  > >  > >=20
>  > >  > >  > >  Could you
>  > >  > >  > >  > live without the check until we have per-process fd t=
abled, or was it
>  > >  > >  > >  > essential for the select thing?
>  > >  > >  > >=20
>  > >  > >  > > An application which I ported to Xenomai (and which uses=
 the select
>  > >  > >  > > call) closes all file descriptors in a for loop. The pur=
pose of this
>  > >  > >  > > loop is, I guess, to avoid leaving a file descriptor ope=
ned that was
>  > >  > >  > > passed through exec.
>  > >  > >  >=20
>  > >  > >  > OK.
>  > >  > >  >=20
>  > >  > >  > So, will you change rtdm_process too? Thanks.
>  > >  > >=20
>  > >  > > I commited the select support, without any change to rtdm_con=
text_get or
>  > >  > > rtdm_process. So, now, how do you prefer this to be fixed, by=
 adding an
>  > >  > > mm struct to the rtdm_process struct ? By the way, after thin=
king about
>  > >  > > it I can live without this fix: I just have to stop the loop =
closing
>  > >  > > file descriptors at 768, so that it will not try to close RTD=
M file
>  > >  > > descriptors.
>  > >  >=20
>  > >  > If you can live with it, I would vote for fixing it by the inte=
nded=20
>  > >  > redesign via per-process fds.
>  > >=20
>  > > Ok.
>  > >=20
>  > >  >=20
>  > >  > >=20
>  > >  > > While commiting the support for select, I also had a dependen=
cy problem
>  > >  > > in Kconfig: when support for posix select is enabled the posi=
x module
>  > >  > > uses a function defined in the RTDM module. So, there is one =
invalid
>  > >  > > configuration: posix built-in with support for select and rtd=
m built as
>  > >  > > a module. I could not find a way to express this condition in=
 the
>  > >  > > Kconfig language, so I just made a comment depend on this con=
dition, but
>  > >  > > would be happy if anyone found a better solution.
>  > >  >=20
>  > >  > I would say:
>  > >  >=20
>  > >  > config POSIX
>  > >  > 	select RTDM if OPT_SELECT
>  > >=20
>  > > But in this case, I can not have posix with select and without rtd=
m.
>  >=20
>  > Then you need to isolate those services that POSIX needs from RTDM. =
The=20
>  > above just expresses the dependency you described.=20
>=20
> Then I was wrong in what I described: the problem is that if posix is
> built-in and RTDM is enabled, then RTDM must be built-in.

That should be covered by the kconfig rule automatically.

>=20
> In the end this just=20
>  > shows that we have to define the common fd-ground for both skins in =
the=20
>  > core.
>=20
> I also have the choice of defining the service needed
> (rt_dev_select_bind) as a callback in the posix module, the RTDM module=

> setting this callback when loaded (like what the rtcap module does with=

> rtnet). But I wanted something simple, so I aimed at Kconfig stuff.
>=20

If you can live with the callback being NULL, you could also perfectly=20
wrap some ifdef CONFIG_...RTDM[_MODULE] around the current invocations.=20
Then you don't need the dependency above. I think I have to look at the=20
code...

Jan


--------------enigF0E27ADBEB16B0FB849E5B77
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHsUySniDOoMHTA+kRAjn7AJ9q1YKbU8L1LmXKCUou178kkB1GbQCeO/UJ
WlPYqoMTJs1Ww5dqg5sIu+Y=
=lXDt
-----END PGP SIGNATURE-----

--------------enigF0E27ADBEB16B0FB849E5B77--

