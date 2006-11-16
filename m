Message-ID: <455C874E.5050901@domain.hid>
Date: Thu, 16 Nov 2006 16:44:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Kernel crash during queue create/destroy
References: <200611151121.51836.s.zimmermann@domain.hid>	<200611151544.00429.s.zimmermann@domain.hid>	<1163678246.4962.53.camel@domain.hid>
	<200611161635.38075.s.zimmermann@domain.hid>
In-Reply-To: <200611161635.38075.s.zimmermann@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD3537CF4DE9F94FD17373BF7"
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD3537CF4DE9F94FD17373BF7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stephan Zimmermann wrote:
> Am Donnerstag, 16. November 2006 12:57 schrieb Philippe Gerum:
>> On Wed, 2006-11-15 at 15:44 +0100, Stephan Zimmermann wrote:
>>> Am Mittwoch, 15. November 2006 14:19 schrieb Dmitry Adamushko:
>>>> Hello,
>>>>
>>>> I got some trouble with the native skin and queues, when creating /
>>>> deleting
>>>>
>>>>> queues, my Kernel sometimes (actually very often...) crashes, leadi=
ng
>>>>> to a frozen system, with my Xenomai program continuing until it
>>>>> returns. I tried
>>>>> to isolate / reproduce the problem, which lead me to the following
>>>>> demo-code.
>> [...]
>>
>> Cannot test it yet, but could you try out this patch? TIA,
>=20
> So, finally I managed to apply your patch, thanks for the hint :). Afte=
r=20
> recompiling everything it seems to work an the first view. But I guess =
your=20
> patch is not the final solution (or we discover another problem here...=
). =20
> When I run the testprogram, everything looks fine, until I start to wor=
k with=20
> the X-Server. Starting X, logging into KDE or shutting down X sometimes=
 leads=20
> to a syslog full of 'bad page' messages, as seen below. The system keep=
s=20
> responding to commands, I can exit my testprogram by pressing CTRL-C, X=
 works=20
> as usual (just using it for typing this mail...).

See last night's thread: this issue was due to my patch fixing too much
of an regression in SVN trunk. You should upgrade to head (#1842 by now)
and try again. "svn up" should work fine for this, merging all changes
together.

Jan


--------------enigD3537CF4DE9F94FD17373BF7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXIdOniDOoMHTA+kRAjVsAJ9OsSZqzBX6fZlgzioGknDVmlHjdQCfYns3
tQHpi1py1/5zbMxf+uXutO8=
=+ZJ2
-----END PGP SIGNATURE-----

--------------enigD3537CF4DE9F94FD17373BF7--

