Message-ID: <4C9874C9.30108@domain.hid>
Date: Tue, 21 Sep 2010 11:03:05 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=HdW-g6KWHYbKiK5UiLb_SNOQrarfwj53ra4cd@domain.hid>
	<1285054174.4114.30.camel@domain.hid>
In-Reply-To: <1285054174.4114.30.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig55B0A456743CF27A0E91CC8D"
Subject: Re: [Xenomai-help] t_getreg / t_setreg undefined references in
 pSOS+ skin
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
--------------enig55B0A456743CF27A0E91CC8D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21.09.2010 09:29, Philippe Gerum wrote:
> On Mon, 2010-09-20 at 22:42 +0200, ronny meeus wrote:
>  =20
>> Hello
>>
>> I see in the psos.h file the function declaration for both the
>> t_getreg and the t_setreg functions.
>> Also in the psos kernel module I see functionality available.
>> What I miss it the references for both service calls in the syscall.c
>> file.
>>
>> This results in undefined references if I try to use the service call
>> in my application.
>>
>> Is there any patch available that solves my problem?
>>    =20
> Untested:
> http://git.xenomai.org/?p=3Dxenomai-rpm.git;a=3Dcommit;h=3D740e3b9e5f77=
588f3df010752c255ecd24adea4e
>  =20

Untested too, but the function t_getreg() in task.c uses
__psos_t_setreg: s/setreg/getreg/ ?

>> Thanks
>> Ronny
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>>    =20
>  =20



--------------enig55B0A456743CF27A0E91CC8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkyYdNEACgkQIPTw9rIdn6oFMACfb4Mx88rOPYUszXOQv4Cs4URu
gugAn23KGbYAr3oxtkNwjdcL4y0Ais2P
=lVx+
-----END PGP SIGNATURE-----

--------------enig55B0A456743CF27A0E91CC8D--

