Message-ID: <4BD49468.8000301@domain.hid>
Date: Sun, 25 Apr 2010 21:13:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BD45469.5040006@domain.hid> <4BD4926D.2080908@domain.hid>
In-Reply-To: <4BD4926D.2080908@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig53C6C5158A8E30C9C94FB446"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [git pull] Fix bogus lock stealing case
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig53C6C5158A8E30C9C94FB446
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> The following changes since commit fbc3b858ee728c1a6b03996e3285198caa7=
053c6:
>>   Gilles Chanteperdrix (1):
>>         debug: fix CONFIG_XENO_OPT_DEBUG_* issues
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>=20
> Something wrong here, the logs on your branch appear as:
>=20
> 13ee2a1 nucleus: Fix bogus lock stealing case
> d0d95bf mutex-torture: Add test for disallowed lock stealing
> 9ef976e RTDM: Restrict use of rtdm_rt_capable
> 6b75977 uitron: Fix skin debug option
> bc3fefd Move schedule_delayed_work into wrapping header
> 41b1eca RTDM: Drop __exit from rtdm_dev_cleanup
> 4f3d3f2 bootstrap
> 78acd8c Merge commit 'jan'
> 700a9fd arm: add a generic-vfp architecture, which enables vfp and
> compiles for armv5
> 8337fc5 RTDM: Use non-atomic bitops for used_fildes
>=20
> Seems you forgot to rebase?
>=20

Oops, incomplete rebase. Fixed.

Jan


--------------enig53C6C5158A8E30C9C94FB446
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvUlHIACgkQitSsb3rl5xQjXwCeJPgyUmWo/2EHGNErKy6ogZkB
fKQAnA9ZOZT0oRQ4hW3dEl+WBoNol9vt
=y1LC
-----END PGP SIGNATURE-----

--------------enig53C6C5158A8E30C9C94FB446--

