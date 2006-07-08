Message-ID: <44AF78FB.9010304@domain.hid>
Date: Sat, 08 Jul 2006 11:20:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH 2/2] /proc output - add CPU usage stats
References: <44AECB5F.1080100@domain.hid> <1152348554.5065.5.camel@domain.hid>	
	<44AF7644.40506@domain.hid> <1152350185.5065.10.camel@domain.hid>
In-Reply-To: <1152350185.5065.10.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEDB73F4EA0302EC31C146EA9"
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
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEDB73F4EA0302EC31C146EA9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2006-07-08 at 11:09 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Fri, 2006-07-07 at 23:00 +0200, Jan Kiszka wrote:
>>>> Yet another (hopefully the final) version of my attempt to add simpl=
e per-thread CPU
>>>> usage statistics. This variant now prints the usage in percent direc=
tly via
>>>> /proc/xenomai/stat.
>>> Merged, thanks.
>>>
>> Tabs seems to got lost on merge (I think my posted patches where ok).
>=20
> Looking at the mail archive on GNA, it seems they were not. I've planne=
d
> to rerun Lindent over the sources anyway.

Hmm, strange. Checking the versions received via my own subscription
(PATCH 1/2 and 2/2), there are tabs at lines where there are non in
trunk now.

It's indeed a minor issue, but I wonder if I should continue to post
patches inlined or fall back to attachments again.

Jan


--------------enigEDB73F4EA0302EC31C146EA9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEr3j7niDOoMHTA+kRAjdlAJ0fMrjJVGbCO2oT3zKkrsljxQgTEQCePowf
9dh/9M3H45fE/jx7W16hsJo=
=ZWIX
-----END PGP SIGNATURE-----

--------------enigEDB73F4EA0302EC31C146EA9--

