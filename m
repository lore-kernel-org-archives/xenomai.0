Message-ID: <4444D810.1020002@domain.hid>
Date: Tue, 18 Apr 2006 14:14:08 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] let skins select nucleus features
References: <443E99C5.70202@domain.hid> <4442786B.40301@domain.hid>
	<444419E1.6040100@domain.hid> <4444C45A.7050308@domain.hid>
In-Reply-To: <4444C45A.7050308@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig88875A9B1798238BAAF80234"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig88875A9B1798238BAAF80234
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>
>>> Jan Kiszka wrote:
>>>
>>>> Hi,
>>>>
>>>> this patch aims at avoiding to select unneeded nucleus features if n=
o
>>>> user is requiring it in the skins. Particularly, it addresses the
>>>> nucleus registry and the pipes.
>>>>
>>>> I have spent no effort on 2.4 yet as I first want to wait for commen=
ts.
>>>> Furthermore, 2.4. is lacking "select", so the feature selection has =
to
>>>> remain manually there anyway.
>>>
>>> Looks good. Merged, thanks.
>>>
>>
>>
>> In the same sense, but not that comfortable, here is the a 2.4 variant=

>> of the patch.
>=20
> I don't agree with the logic of this patch. All user-space enabled skin=
s
> may also run in pure kernel-space in non pervasive mode. A core
> dependency exists from CONFIG_XENO_OPT_REGISTRY on
> CONFIG_XENO_OPT_PERVASIVE, and it should be defined explicitely. In any=

> case, maybe it's not worth trying to be too smart with the 2.4
> configuration system when it comes to dealing with features
> inter-dependencies, since we really miss the proper support to do that.=

>=20

Sorry, doesn't parse for me yet. You that when CONFIG_XENO_OPT_PERVASIVE
is enabled CONFIG_XENO_OPT_REGISTRY is required (which was not correct,
see POSIX skin)?

Jan


--------------enig88875A9B1798238BAAF80234
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFERNgQniDOoMHTA+kRAuocAJ9Ocez6HlhmSoiHaB1caYhg7rOBwACeNlqG
+Yv+hEUYmXWZ8ynKcDDfvDI=
=tD/d
-----END PGP SIGNATURE-----

--------------enig88875A9B1798238BAAF80234--

