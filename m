Message-ID: <45D89B66.6050907@domain.hid>
Date: Sun, 18 Feb 2007 19:31:02 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: RT-CAN tx_sem
References: <45D35545.20100@domain.hid>
	<45D45F63.5050009@domain.hid>	<45D461DC.20303@domain.hid>
	<45D4661D.7010506@domain.hid>	<45D46E55.7020907@domain.hid>
	<45D48E27.1090200@domain.hid> <45D6D6CB.4030602@domain.hid>
In-Reply-To: <45D6D6CB.4030602@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD2E2B863B723AD153C14E1FA"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD2E2B863B723AD153C14E1FA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> I thought about this issue again and found the reason for my vague bad
> feeling: re-init is not atomic, thus racy. But also the test+sem_init
> pattern I suggested is not save.
>=20
> I guess we need to enhance rtdm_XXX_init in this regard to make the
> RT-CAN use case an officially allowed one. /me is planning to spend mor=
e
> thoughts on this the next days.

OK, done, rtdm_{event,sem,mutex}_init are now protected by the nklock in
trunk. This should make the in-place re-initialisation of RTDM IPC
objects race-free and allow to use them in RT-CAN as originally
intended. I think I will back-port that pieces also to v2.3.x later.

What patch should now go in to avoid double init/destroy and fix rtcan_vi=
rt?

Jan


--------------enigD2E2B863B723AD153C14E1FA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF2JtmniDOoMHTA+kRAswOAJ9miCirurweAhTWNWnxxfOjB6GoFACfUXnD
t9Bl/plgaj/6+EgSvefPf2k=
=hg+P
-----END PGP SIGNATURE-----

--------------enigD2E2B863B723AD153C14E1FA--

