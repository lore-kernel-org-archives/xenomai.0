Message-ID: <45D1CAFA.6050408@domain.hid>
Date: Tue, 13 Feb 2007 15:28:10 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] fata: removing non-linked element...
References: <45CC651C.6060402@domain.hid> <45CC68F3.1000003@domain.hid>	
	<45D1C033.9010002@domain.hid> <45D1C61B.7030503@domain.hid>
	<1171376742.885.3.camel@domain.hid>
In-Reply-To: <1171376742.885.3.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig589F41EB6FC9BAD7E4019219"
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
--------------enig589F41EB6FC9BAD7E4019219
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2007-02-13 at 15:07 +0100, Jan Kiszka wrote:
>> Stephan Zimmermann wrote:
>>> I wasn't able to isolate the section of my code that causes the crash=
 by
>>> now. The only thing I figured out by now is that the particular crash=

>>> does not happen with 2.3.x rev 2077.
>>> So I guess some change from 2077 to the 2139 revision did break somet=
hing.
>> Could you track the issue a bit more down? There are not to many
>> "interesting" changes to 2.3.x. A few milestones I found in the Change=
Log:
>>
>> - 2092: Allow sleeping scheduler locks
>> - 2108: Before RPI rework
>>
>> Anything after 2108 only makes sense to dissect when you switch on
>=20
> s,on,off,

Nope. If this switch is off, RPI is enabled while known to be buggy, righ=
t?

[That's why I voted for positive logic in trunk -- it twists your brain. =
;)]

>=20
>> XENO_OPT_RPIDISABLE (RPI was buggy until 2139).
>>
>>> I'll go on trying to make it reproducible in a small demo program.
>>>
>>> By the way, I see a Pentium M crash reliable when I do the following,=

>>> don't know if it's related:
>>>
>>> - load nucleus and native module
>>> - start / stop my app
>>> - reload the modules
>>> - start my app --> crash
>>>
>>> I attached 'screenshots' of a total freeze with backtrace and some
>>> messages I extracted  from syslog (both on Pentium M).
>> Looks like some memory corruption. Your application is not messing
>> around on raw (kernel) memory and/or hardware? Keep in mind that chang=
es
>> to the kernel code also moves offsets, potentially unrevealing a
>> pre-existing corruption that so far just hit harmless regions.
>>
>> Jan
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help



--------------enig589F41EB6FC9BAD7E4019219
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0cr6niDOoMHTA+kRAvO5AJ9hdkU/QRX4DGeo6nf9QHDOydojUACfeHmV
9qSH+YdQm6ceq5GyxU4h6pk=
=w0do
-----END PGP SIGNATURE-----

--------------enig589F41EB6FC9BAD7E4019219--

