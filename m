Message-ID: <4C9209F4.7050900@domain.hid>
Date: Thu, 16 Sep 2010 14:13:40 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C91D29F.7020106@domain.hid>
In-Reply-To: <4C91D29F.7020106@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig35611B6C8B7146CA44BA5154"
Subject: Re: [Xenomai-help] (Not yet) Xenomai 2.5.5.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35611B6C8B7146CA44BA5154
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16.09.2010 10:17, Gilles Chanteperdrix wrote:
> Hi,
>
> I would like to make that next release of Xenomai,

Hi Gilles,

don't forget [1] Peter Soetens rtcan patch [2]:
[1] https://mail.gna.org/public/xenomai-help/2010-08/msg00085.html
[2] https://mail.gna.org/public/xenomai-help/2010-07/msg00112.html

Stefan

>  especially since the
> fix for the I-pipe on x86_32 with grub2 has been available for some tim=
e
> now, and has not yet been in a stable release.
>
> So, I have a few minor questions:
> - Wolfgang, Alexis, it seems we have a few warnings when compiling
> rtcan/analogy tools with recent versions of gcc (4.4.1 from
> codesourcery). You will find the logs here:
> http://sisyphus.hd.free.fr/~gilles/pastebin/KVSBtb
> we are not in a hurry to fix this, so simply tell me if the fix is easy=

> or not.
> - Alexis, from the mailing list discussions, you probably have some
> commits ready in the analoty branch, would it be possible to have a pul=
l
> request for these?
> - Jan, where are we with CLOCK_HOST_REALTIME, are the I-pipe ready?
> Should I merge Wolfgang's patches, or the I-pipe/Xenomai interface has
> changed following the discussions with Philippe?
>
> Thanks in advance.
>
>  =20



--------------enig35611B6C8B7146CA44BA5154
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkySCf8ACgkQIPTw9rIdn6rjwQCeOdnMTjr7J8nEsEA6w3m7dVbT
QSwAn2jKc6hqI0SJgx7QHRiLS+GqJHPv
=l4H8
-----END PGP SIGNATURE-----

--------------enig35611B6C8B7146CA44BA5154--

