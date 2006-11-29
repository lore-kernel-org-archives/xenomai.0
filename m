Message-ID: <456D60D7.4090202@domain.hid>
Date: Wed, 29 Nov 2006 11:28:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: [RFC][PATCH 1/2] rework shadow CPU affinity
References: <456C3EF9.30102@domain.hid>
	<456C8961.7060906@domain.hid>	<456C97B9.1000402@domain.hid>
	<456D4C7D.2040100@domain.hid>	<456D4ED4.5040405@domain.hid>
	<456D5399.4040901@domain.hid> <456D5871.6040401@domain.hid>
In-Reply-To: <456D5871.6040401@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1D455AE1AA284E6538680BF8"
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
--------------enig1D455AE1AA284E6538680BF8
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> OK. So you are suggesting to read out the affinity mask from task_str=
uct
>>> instead of passing it as an additional argument?
>>>
>> Unless I am wrong, it is the way it currently works.
>>
>=20
> Yes, for the posix skin. But native is different due to the spilt-up
> create/start and its own affinity API. And that caused problems when
> applying nkaffinity.
>=20
> Nevertheless, I should try to combine the cleanup of xnshadow_map with
> passing the mask ALWAYS in task_struct. Let's see how this works out,
> most likely with less patching.

sched_setaffinity is 2.6 only. So we would have to push the mask
application into kernel space for the native skin anyway. Hmm.

What are posix skin users supposed to do over 2.4? Upgrade to 2.6? BTW,
do you plan to support pthread_attr_setaffinity_np somehow?

Jan


--------------enig1D455AE1AA284E6538680BF8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbWDXniDOoMHTA+kRAk/aAJ90v365Q4QG9Rz2d4VNeMT2J7YkNgCfbUxB
eFZWHOnP46waYzJVcxPH0RE=
=I/D2
-----END PGP SIGNATURE-----

--------------enig1D455AE1AA284E6538680BF8--

