Message-ID: <456D5871.6040401@domain.hid>
Date: Wed, 29 Nov 2006 10:52:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [RFC][PATCH 1/2] rework shadow CPU affinity
References: <456C3EF9.30102@domain.hid> <456C8961.7060906@domain.hid>
	<456C97B9.1000402@domain.hid> <456D4C7D.2040100@domain.hid>
	<456D4ED4.5040405@domain.hid> <456D5399.4040901@domain.hid>
In-Reply-To: <456D5399.4040901@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1774009F6AC66C77D3F9C7CF"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1774009F6AC66C77D3F9C7CF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> OK. So you are suggesting to read out the affinity mask from task_stru=
ct
>> instead of passing it as an additional argument?
>>
>=20
> Unless I am wrong, it is the way it currently works.
>=20

Yes, for the posix skin. But native is different due to the spilt-up
create/start and its own affinity API. And that caused problems when
applying nkaffinity.

Nevertheless, I should try to combine the cleanup of xnshadow_map with
passing the mask ALWAYS in task_struct. Let's see how this works out,
most likely with less patching.


--------------enig1774009F6AC66C77D3F9C7CF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbVhxniDOoMHTA+kRAkmDAJ470ks9VH9ZeRsKEofKo+HcLNn8swCfaBlE
BhyzXMaFRDDPMEHDZuI72oI=
=Pufl
-----END PGP SIGNATURE-----

--------------enig1774009F6AC66C77D3F9C7CF--

