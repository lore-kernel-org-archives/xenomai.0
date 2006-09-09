Message-ID: <45029732.8030008@domain.hid>
Date: Sat, 09 Sep 2006 12:28:02 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Sleep return value
References: <20060906134139.GA5852@domain.hid> <44FED2B7.8090408@domain.hid>
	<20060909010745.GD1192@domain.hid>
In-Reply-To: <20060909010745.GD1192@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig91DF9A0DD7B7823504DB82B1"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Bernhard Walle <bernhard.walle@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig91DF9A0DD7B7823504DB82B1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bernhard Walle wrote:
> Hello,
>=20
> sorry for the late reply.
>=20
> * Jan Kiszka <jan.kiszka@domain.hid> [2006-09-06 15:52]:
>> Bernhard Walle wrote:
>>> Hello,
>>>
>>> ,----
>>> | int rtdm_task_sleep (uint64_t delay);
>>> | int rtdm_task_sleep_until (uint64_t wakeup_time);
>>> `----
>>>
>>> wouldn't it make sense to return 0 on success and in error case the
>>> number of nanoseconds that are remaining to the originally requested
>>> sleep period just as the Linux sleeping function behave?
>> Do you have a use-case for this? Would you consider this as the normal=

>> scenario?
>=20
> I must confess that I don't have one. I just compared the Linux API
> with the RTDM API for that use case. I'll dig into sources of Linux
> drivers and see if there are reasonable use cases. But this may take
> some days as I'm a bit busy now.
>=20
>> Also note that changing the return type would take away to possibility=

>> to pass the error code.
>=20
> Not really. You can
>=20
>   < 0 : error code (in this case -EPERM)
>   =3D=3D 0 : success
>   > 0 : remaining time
>=20
> Or simple
>=20
>   int rtdm_task_sleep(uint64_t delay, uint64_t *time_left);
>=20
> That would make it more compatible with the current API since the user
> can simply replace
>=20
>   ret =3D rtdm_task_sleep(delay);
>=20
> with=20
>=20
>   ret =3D rtdm_task_sleep(delay, NULL);
>=20
>>> Of course that would introduce an incompatibility to current code.
>> Given a reasonably urging use-case or brokenness of the original
>> interface, API revisions may actually take place in RTDM (see the
>> history). But they will surely not happen without thorough
>> considerations of pros and cons. :)
>=20
> Because the missing information can be easily gathered from outside,
> it would be only worth changing if you plan some other changes in
> these functions so that this can be done in one in one step.
>=20

You exactly hit the point. :->

Jan


--------------enig91DF9A0DD7B7823504DB82B1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFApcyniDOoMHTA+kRAon2AJ9H2N79AszG3F5tYQOazNel2VZAZACeJG8/
1W+DlEH413ZC+JLT79Uh92Y=
=zdQT
-----END PGP SIGNATURE-----

--------------enig91DF9A0DD7B7823504DB82B1--

