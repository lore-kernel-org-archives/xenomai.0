Message-ID: <43875AB0.6000706@domain.hid>
Date: Fri, 25 Nov 2005 19:40:48 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] private heaps for native pipes
References: <438756DA.9000808@domain.hid>
	<43875924.7070903@domain.hid>
In-Reply-To: <43875924.7070903@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6111E81DFECB43ACB0DAF05F"
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
--------------enig6111E81DFECB43ACB0DAF05F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> this is basically the last version of my rt_pipe_create-ext patch to a=
dd
>> private, user-resizeable heaps to native pipes. Joerg has tested this
>> patch successfully under the 2.1 trunk, and I added a ChangeLog snippe=
t.
>> Attached both 2.0.x and 2.1.x patches - please apply at least the 2.1
>> variant.
>>
>=20
> Applied to 2.1, thanks. We need to keep the 2.0 branch 100% compatible
> with the former RTAI/fusion API-wise, so I won't merge this in 2.0 thou=
gh.
>=20

No problem. The patch was first developed on 2.0, so I just attached
that version. Now, as I returned from my short travel, Joerg told me
that he is already happily working over 2.1-trunk and had adapted my
patch. :)

BTW, RTnet also compiles against trunk now, I just have to get the patch
into SVN.

Jan


--------------enig6111E81DFECB43ACB0DAF05F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDh1qwncNeS9Q0k+IRAhW6AJ9PP8ntwNq7aOpvDfe6UomSNWUUuwCeJ0S6
aLcPddII5Yf5ImKUS69isU4=
=DEJB
-----END PGP SIGNATURE-----

--------------enig6111E81DFECB43ACB0DAF05F--

