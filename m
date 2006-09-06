Date: Wed, 6 Sep 2006 15:41:39 +0200
From: Bernhard Walle <bernhard.walle@domain.hid>
Message-ID: <20060906134139.GA5852@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
Subject: [Xenomai-core] Sleep return value
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


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

,----
| int rtdm_task_sleep (uint64_t delay);
| int rtdm_task_sleep_until (uint64_t wakeup_time);
`----

wouldn't it make sense to return 0 on success and in error case the
number of nanoseconds that are remaining to the originally requested
sleep period just as the Linux sleeping function behave?

Of course that would introduce an incompatibility to current code.

Regards,
  Bernhard
--=20
Ich denke, es gibt weltweit einen Markt f=FCr vielleicht f=FCnf Computer.
	-- Thomas Watson, Vorsitzender von IBM (1943)

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBRP7QDuiVHo+2lFT9AQIQ9QP/W1b7r2QBNvUL3B1p6qThoUaeIEYzer8o
mvAPmuzUwvAPdp9F4r3pECX6UfoTSd3PWfeOhTHTNczxam4rh1rVculOdrn/bt3b
TqT/KJTq4Va5vT8qpBfqPmOkf+09RJGRCM4aEoIjXPnJqk68M8xhWzsrmwwsHKOT
yPSCIYLY/10=
=NBm3
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

