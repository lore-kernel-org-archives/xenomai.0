Message-ID: <4BBAD880.5040603@domain.hid>
Date: Tue, 06 Apr 2010 08:45:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <20100401230843.GF3755@domain.hid>		<4BB53566.3010601@domain.hid>
	<4BB53643.2080604@domain.hid>		<j2yb88603c31004020058i3aae7947s1428f1b87f4b1097@domain.hid>		<4BB5B64B.6040803@domain.hid>
	<4BB5B7C1.4020301@domain.hid>		<4BB5B874.5090904@domain.hid>		<k2pb88603c31004020232z28e10d59vc546b1b8803113f2@domain.hid>		<4BB5BA2D.1080604@domain.hid>	<k2rb88603c31004020243k8d9681f8y453b25393bb5d3a0@domain.hid>,
	<4BB5C1D5.8030804@domain.hid>
	<245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
In-Reply-To: <245373446233674495BCA5CA2FC1EB17378D015932@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig347B36EA5A3AF3232D8F64DD"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] New scheduler class
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig347B36EA5A3AF3232D8F64DD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andreas Glatz wrote:
>>> Actually that is what I thought in the first place, however Jan's
>>> comment "That's not true, Xenomai threads can run in non-RT schedulin=
g
>>> classes as well. They may just gain RT priority while holding some
>>> lock that is requested by a RT thread as well." made me think I was
>>> wrong...
>>>
>>> So we would really need a SCHED_IDLE for Xenomai then to solve this p=
roblem?
>> I don't think so. But we do need to solve the issue that a non-RT thre=
ad
>> stays too long in primary mode and is thus scheduled by Xenomai with t=
he
>> wrong priority /wrt other Linux task at its level.
>>
>> For the time being, you can work around this by issuing a Linux syscal=
l
>> before entering long processing loops - unless your task doesn't do th=
is
>> anyway, e.g. to perform some Linux I/O.
>>
>=20
> I think that's need. Currently the statistics task takes a mutex and wa=
its on a message queue for messages. That's the only time it should poten=
tially run in primary mode. After it returns the Mutex it should continue=
 running with a policy similar to SCHED_IDLE to give other tasks a chance=
 to run. I see how switching back to secondary mode could be achieved by =
issuing a Linux syscall. Is there another way which doesn't involve chang=
ing the source code of our application? (The proper way?)

The proper way would be to not having to change the application code.
But this workaround (Linux syscall or *_set_mode()) is required until we
improve the nucleus.

Jan


--------------enig347B36EA5A3AF3232D8F64DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAku62IUACgkQitSsb3rl5xSO5gCfYRqB/c2flwkEzrglVJeJI4xG
D/YAoNVxY8F5OciT1yXr747H+98RgVl0
=aUew
-----END PGP SIGNATURE-----

--------------enig347B36EA5A3AF3232D8F64DD--

