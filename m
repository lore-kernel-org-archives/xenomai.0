Message-ID: <4A1E9004.9010901@domain.hid>
Date: Thu, 28 May 2009 15:22:12 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4A00848D.1090500@domain.hid> <4A1E550D.9090702@domain.hid>
	<1243513683.22173.0.camel@domain.hid>
In-Reply-To: <1243513683.22173.0.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig45C34CD9270AEFC524160515"
Subject: Re: [Xenomai-help] Debian package building fails with 2.5-rc1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig45C34CD9270AEFC524160515
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum schrieb:
> On Thu, 2009-05-28 at 11:10 +0200, Stefan Kisdaroczi wrote:
>> Hi Philippe,
>>
>> thx for commiting to xenomai-head.
>> Please merge to 2.4.x, you removed the Changelog file one week ago.
>>
>=20
> Should be ok now. Thanks,
> http://git.xenomai.org/?p=3Dxenomai-head.git;a=3Dcommit;h=3D3efa9d95abc=
65bef76546480bbd643de5a391a30

this is _xenomai-head.git_ , i dont see the change in _xenomai-2.4.git_

you removed the changelog in 2.4.x here:
http://git.xenomai.org/?p=3Dxenomai-2.4.git;a=3Dcommit;h=3D8a5e70f8067b6f=
8e8e1645a481a9ddcba8946581

thanks

>> Thank you
>> Stefan
>>
>> Stefan Kisdaroczi schrieb:
>>> Hi,
>>>
>>> there is no ChangeLog file in the project root anymore, so debian pac=
kage building fails.
>>> Following patch fixed it for me.
>>>
>>> kisda
>>>
>>> --- xenomai-2.5.orig/debian/rules
>>> +++ xenomai-2.5/debian/rules
>>> @@ -108,7 +108,7 @@
>>>  	dh_testdir -i
>>>  	dh_testroot -i
>>>  	dh_installdocs -i -A CREDITS README.INSTALL TROUBLESHOOTING
>>> -	dh_installchangelogs -i ChangeLog
>>> +	dh_installchangelogs -i
>>>  	dh_link -i
>>>  	dh_strip -i
>>>  	dh_compress -i -X.pdf
>>> @@ -131,7 +131,7 @@
>>>  	dh_testroot -s
>>>  	dh_installman -s
>>>  	dh_installdocs -s -A CREDITS README.INSTALL TROUBLESHOOTING
>>> -	dh_installchangelogs -s ChangeLog
>>> +	dh_installchangelogs -s
>>>  	dh_link -s
>>>  	dh_strip -s
>>>  	dh_compress -s
>>>
>>>
>>>
>>>
>>> ---------------------------------------------------------------------=
---
>>>
>>> _______________________________________________
>>> Xenomai-help mailing list
>>> Xenomai-help@domain.hid
>>> https://mail.gna.org/listinfo/xenomai-help
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help



--------------enig45C34CD9270AEFC524160515
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKHpALIPTw9rIdn6oRAnECAJ0Tfg7GILOaOgbu7sm1PFz1naHnNwCeMqd2
mzVOCM25QxUzgpEvqH+ancE=
=WWwr
-----END PGP SIGNATURE-----

--------------enig45C34CD9270AEFC524160515--

