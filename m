Date: Sat, 9 Sep 2006 03:07:45 +0200
From: Bernhard Walle <bernhard.walle@domain.hid>
Subject: Re: [Xenomai-core] Sleep return value
Message-ID: <20060909010745.GD1192@domain.hid>
References: <20060906134139.GA5852@domain.hid> <44FED2B7.8090408@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <44FED2B7.8090408@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

sorry for the late reply.

* Jan Kiszka <jan.kiszka@domain.hid> [2006-09-06 15:52]:
> Bernhard Walle wrote:
> > Hello,
> >=20
> > ,----
> > | int rtdm_task_sleep (uint64_t delay);
> > | int rtdm_task_sleep_until (uint64_t wakeup_time);
> > `----
> >=20
> > wouldn't it make sense to return 0 on success and in error case the
> > number of nanoseconds that are remaining to the originally requested
> > sleep period just as the Linux sleeping function behave?
>=20
> Do you have a use-case for this? Would you consider this as the normal
> scenario?

I must confess that I don't have one. I just compared the Linux API
with the RTDM API for that use case. I'll dig into sources of Linux
drivers and see if there are reasonable use cases. But this may take
some days as I'm a bit busy now.

> Also note that changing the return type would take away to possibility
> to pass the error code.

Not really. You can

  < 0 : error code (in this case -EPERM)
  =3D=3D 0 : success
  > 0 : remaining time

Or simple

  int rtdm_task_sleep(uint64_t delay, uint64_t *time_left);

That would make it more compatible with the current API since the user
can simply replace

  ret =3D rtdm_task_sleep(delay);

with=20

  ret =3D rtdm_task_sleep(delay, NULL);

> > Of course that would introduce an incompatibility to current code.
>=20
> Given a reasonably urging use-case or brokenness of the original
> interface, API revisions may actually take place in RTDM (see the
> history). But they will surely not happen without thorough
> considerations of pros and cons. :)

Because the missing information can be easily gathered from outside,
it would be only worth changing if you plan some other changes in
these functions so that this can be done in one in one step.


Regards,
  Bernhard
--=20
Bei der Eroberung des Weltraums sind zwei Probleme zu l=F6sen: die Schwerkr=
aft
und der Papierkrieg. Mit der Schwerkraft w=E4ren wir fertig geworden.
	-- Wernher von Braun

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBRQIT3OiVHo+2lFT9AQJn/wP+IqqvhwnMKuYB60IQqiLxPugDOPuIyljG
RiU9QZ3BmU3+d/CNarzOGAIpbXQK3y11GLPxGKsYiC/ips8n7u5F4zC9E+X62xeq
4gSQ7i+bp16m+mh/gtVDm13wHJkCyb4YDIcOFHuS8YrgSyWPXS5frggnm8b8PxlF
XcyW3GsOQxA=
=8czk
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--

