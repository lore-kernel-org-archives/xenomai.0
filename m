Message-ID: <46C0A332.2040701@domain.hid>
Date: Mon, 13 Aug 2007 20:30:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid> <46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid> <46C07EDC.4040305@domain.hid>
	<46C08D64.4050903@domain.hid> <46C09773.5070607@domain.hid>
	<46C09B86.3030709@domain.hid> <46C0A02A.1010706@domain.hid>
In-Reply-To: <46C0A02A.1010706@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3BEC5FE36C845405428CDBDC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input	framebuilding failed.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>, rtnet-users <rtnet-users@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3BEC5FE36C845405428CDBDC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
>>> The 64 is a value I got from the mailing list. How large can I make t=
his
>>> and what am I compromising?
>>
>> Each buffer is slightly more than 1.5 KB heavy. Do your maths :). How
>> many buffers you need depend on how many incoming and outgoing frames
>> might be queued into they are processed. And that depends on the frame=


s/into/until/ (my brain-based dictionary must be broken)

>> rate and the time your EML stack has to handle it in the worst case. I=

>> can't give you numbers on this, that depends on _your_ setup.
>=20
> That much is clear. Will make it big out of shear inability to
> calculate. The lost memory is of almost no concern.

Just make sure that picking an arbitrary large pool size doesn't paper
over some real system design issue that may manifests in huge latencies.
Again, I don't know your numbers, so I cannot tell what is reasonable
and what an indication of a problem. A system-level analysis of the
event flows would be a good job for LTTng now - if it only worked already=
=2E..

Jan


--------------enig3BEC5FE36C845405428CDBDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwKMyniDOoMHTA+kRAiYfAJsFQDZ6TDyQqqgCKl4BwkGNsEGTfQCffIpq
4mxrTsUzM3zhii5zSgm24Eo=
=0WFf
-----END PGP SIGNATURE-----

--------------enig3BEC5FE36C845405428CDBDC--

