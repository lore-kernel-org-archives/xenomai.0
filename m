Message-ID: <4C6C2D41.7040400@domain.hid>
Date: Wed, 18 Aug 2010 20:58:09 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid>	<4C6932E8.7050701@domain.hid>	<4C694AB3.8050407@domain.hid>	<4C698E16.5050806@domain.hid>,
	<1282040830.1730.232.camel@domain.hid>	<E2CAE7F7B064EA49B5CE7EE9A4BB167D14FD065794@domain.hid>	<4C6AA99D.3010907@domain.hid>
	<4C6C2A4D.70503@domain.hid>
In-Reply-To: <4C6C2A4D.70503@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig87C5C0598ADAEE50D862182F"
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system [PATCH]
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
--------------enig87C5C0598ADAEE50D862182F
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 18.08.2010 20:45, Stefan Kisdaroczi wrote:
> On 17.08.2010 17:24, Stefan Kisdaroczi wrote:
>  =20
>> On 17.08.2010 15:51, Hemal C.Bavishi wrote:
>>  =20
>>    =20
>>> When I tried to compile it with the latest version of kernel with xen=
omai 2.5.4, I am getting following errors in Xenomai (disable CONFIG_SMP,=
 enable CONFIG_X86_UP_APIC and
>>> CONFIG_X86_UP_IOAPIC (*).)
>>>  =20
>>>    =20
>>>      =20
>> Just tested, got the same build error with 2.6.34.
>> If I patch 2.6.34 with prepare-kernel [1] it compiles,
>> if I use the debian packaged patch generated with prepare-patch [2] it=

>> fails.
>>
>> I guess a fix is needed in prepare-patch for 2.6.34, but no time to lo=
ok
>> closer now.
>>  =20
>>    =20
> patch for prepare-patch.sh attached.
> prepare-kernel.sh try's to find ipipe.h and uses the old or new tree
> structure. Is it ok to change this unconditionally in prepare-patch.sh?=

> All adeos-patches in xenomai-2.5.git have ipipe.h in
> arch/$linux_arch/include/asm/, so i think yes.
>
>  =20

prepare-patch.sh worked with the wrong path until this commit for linux
2.6.33:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmitdiff;h=3Dc95fa08a3e17c3f2983c4cbf409f5c9ae47b7dec

> Stefan
>
>  =20
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>  =20



--------------enig87C5C0598ADAEE50D862182F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkxsLUcACgkQIPTw9rIdn6qB7ACeJMOb1gqAknybjw7W7TB42u8A
x3oAnjMzSB8hczCUBsw9LFDsuUacpnn+
=Dsqf
-----END PGP SIGNATURE-----

--------------enig87C5C0598ADAEE50D862182F--

