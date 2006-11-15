Message-ID: <455B97F9.7070706@domain.hid>
Date: Wed, 15 Nov 2006 23:43:05 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
References: <200611151121.51836.s.zimmermann@domain.hid>	
	<b647ffbd0611150519w1a510582n40782bdccaa7562d@domain.hid>	
	<200611151544.00429.s.zimmermann@domain.hid>
	<455B8016.2020605@domain.hid> <1163629342.4974.36.camel@domain.hid>
	<455B9666.8080604@domain.hid>
In-Reply-To: <455B9666.8080604@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDCF957CBB556C43B82D6D1B0"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDCF957CBB556C43B82D6D1B0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> On Wed, 2006-11-15 at 22:01 +0100, Jan Kiszka wrote:
>>
>>> /me unfortunately failed to reproduce your problem here. Instead, I
>>> found a regression in SVN head - different story for a different thre=
ad.
>>>
>> It's reproducible here. This bug triggers if you leave enough time
>> between queue creation and deletion for Linux to deal with its usual
>> business, like running workqueues... Additionally, this bug would not
>> trigger with different queue names passed to the creation routines. It=

>> seems to be caused by out-of-sequence create/delete requests of /proc
>> entries relayed to the proc_fs subsystem, which does not perform any
>> sanity checks on the data it is submitted.
>>
>=20
> Yes, that delay makes the difference. I just added a huge one (100
> ticks), and now I get tones of this:

No, the delay make no difference for me. This one is a new "property" of
#1838 (#1832 is fine), the other issue still doesn't pop up here.


--------------enigDCF957CBB556C43B82D6D1B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFW5f5niDOoMHTA+kRAhdhAJ47cjZO27EaQui5bJWs3RsZ4mZleQCffbre
yBSK3dTiX6NpjCToloKLNU8=
=jiLl
-----END PGP SIGNATURE-----

--------------enigDCF957CBB556C43B82D6D1B0--

