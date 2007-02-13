Message-ID: <45D200C3.1030001@domain.hid>
Date: Tue, 13 Feb 2007 19:17:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] fata: removing non-linked element...
References: <45CC651C.6060402@domain.hid> <45CC68F3.1000003@domain.hid>	
	<45D1C033.9010002@domain.hid> <45D1C61B.7030503@domain.hid>	
	<1171376742.885.3.camel@domain.hid> <45D1CAFA.6050408@domain.hid>
	<1171385716.885.17.camel@domain.hid>
In-Reply-To: <1171385716.885.17.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig69A78125D36879C887B78FC3"
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
--------------enig69A78125D36879C887B78FC3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Tue, 2007-02-13 at 15:28 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Tue, 2007-02-13 at 15:07 +0100, Jan Kiszka wrote:
>>>> Stephan Zimmermann wrote:
>>>>> I wasn't able to isolate the section of my code that causes the cra=
sh by
>>>>> now. The only thing I figured out by now is that the particular cra=
sh
>>>>> does not happen with 2.3.x rev 2077.
>>>>> So I guess some change from 2077 to the 2139 revision did break som=
ething.
>>>> Could you track the issue a bit more down? There are not to many
>>>> "interesting" changes to 2.3.x. A few milestones I found in the Chan=
geLog:
>>>>
>>>> - 2092: Allow sleeping scheduler locks
>>>> - 2108: Before RPI rework
>>>>
>>>> Anything after 2108 only makes sense to dissect when you switch on
>>> s,on,off,
>> Nope. If this switch is off, RPI is enabled while known to be buggy, r=
ight?
>>
>=20
> Btw, RPI was not buggy so so that it could cause crashes; it was failin=
g
> to _always_ keep a thread's priority consistent across domain migration=
,
> which is quite different. IOW, do not start switching on RPIDISABLE
> blindly when your box goes south, it's most likely unrelated to what ha=
s
> been fixed recently.

Well, I recalled some temporary locking changes on RPI somewhere in this
period. My feeling was to better exclude their potential side-effects
from the testing rounds.


--------------enig69A78125D36879C887B78FC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF0gDDniDOoMHTA+kRAi67AJ9OvFvWg5i1EhqJgcuYTK9PimckFgCff7X6
YMcTw/3FsJZlgtMQaHBw8a0=
=to6f
-----END PGP SIGNATURE-----

--------------enig69A78125D36879C887B78FC3--

