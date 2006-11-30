Message-ID: <456E8F94.8050600@domain.hid>
Date: Thu, 30 Nov 2006 09:00:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] structure alignement problem in RTDM?
References: <20061130073522.3BBF9EE753@domain.hid>
In-Reply-To: <20061130073522.3BBF9EE753@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAA068260013EE1F2250F9DF9"
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
To: Marc Brown <marc.brown@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAA068260013EE1F2250F9DF9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Marc Brown wrote:
> Hi,
>=20
> It seems that there are still structure alignment problems in RTDM (whi=
le running xenotest), as already=20
> talked about with Philippe. Compiled with a GCC 4.0.3-2 (on x86), here =
is the=20
> problem (output trace and xenomai /proc are provided herewith):

I rather suspect that you built all testing devices into the kernel or
loaded xeno_switchtest before xeno_timerbench so that the latency test
happens to open the switchtest device. Try "-D1" with latency, or check
/proc/xenomai/rtdm/rttestX/information for the actual mapping.
[We need to resolve this more gracefully...]

Jan


--------------enigAA068260013EE1F2250F9DF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFbo+UniDOoMHTA+kRArdcAJ0fUaRC+nlRoNbdtLkhokjNvZrBGACfW/G6
EotXpi5hi2vuihNyFaQ0IgM=
=doGo
-----END PGP SIGNATURE-----

--------------enigAA068260013EE1F2250F9DF9--

