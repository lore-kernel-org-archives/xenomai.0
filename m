Message-ID: <4E5A2AC4.8050904@domain.hid>
Date: Sun, 28 Aug 2011 13:47:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CAKvQZ_06JKNPsiGeXOC1PEnc1Je5zSDSnX9AdOHT4eraggv7Eg@domain.hid>
In-Reply-To: <CAKvQZ_06JKNPsiGeXOC1PEnc1Je5zSDSnX9AdOHT4eraggv7Eg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig845114546E8E3FDBE5C9417F"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] CPU frequency of 0 in a Vmware with Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Willy Lambert <lambert.willy@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig845114546E8E3FDBE5C9417F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-08-28 12:28, Willy Lambert wrote:
> Hi all,
>=20
> I am trying to make xenomai running into a Debian Squeeze 32b with a cu=
stom
> 2.6.38.8 kernel with xenomai among other things. I am running this into=
 a
> Vmware for testing this before going on my real target.
>=20
> I have a "CPU frequency of 0" Error at boot, which I think is "classic"=
 with
> Vmwares :
> http://comments.gmane.org/gmane.linux.real-time.xenomai.devel/6632
>=20
> ard@domain.hid:~$ dmesg | grep Xenomai
> [    0.559923] Xenomai has detected a CPU frequency of 0. Aborting.
> [    0.560923] Xenomai: system init failed, code -19.
> [    0.560923] Xenomai: native skin init failed, code -19.
> [    0.560923] Xenomai: starting POSIX services.
> [    0.561923] Xenomai: POSIX skin init failed, code -19.
> [    0.561923] Xenomai: RTDM skin init failed, code -19.

You may work around this by statically setting the CPU frequency via the
xeno_hal.cpufreq kernel parameter.

However, unless you are locked into VMware, use KVM on a Linux host. It
provides the better experience for testing Xenomai images.

Jan


--------------enig845114546E8E3FDBE5C9417F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5aKskACgkQitSsb3rl5xQRVQCgxzONxVXLIx4iJehnc1fSBb6M
mg8AoIC/+CC5m4Odv2aXxJYmGAItctno
=vhOJ
-----END PGP SIGNATURE-----

--------------enig845114546E8E3FDBE5C9417F--

