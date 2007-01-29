Message-ID: <45BE02F3.9020701@domain.hid>
Date: Mon, 29 Jan 2007 15:21:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] BUG: unable to handle kernel paging request
References: <1169811995.462.13.camel@domain.hid>	<1169827668.3346.61.camel@domain.hid>	<b647ffbd0701261046m52172774lf5a7b4d08e090583@domain.hid>	<1169851606.3346.75.camel@domain.hid>
	<1169852516.3346.77.camel@domain.hid>
	<1170073409.26457.8.camel@domain.hid>
In-Reply-To: <1170073409.26457.8.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD79442B8487352C1BF92A402"
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
To: Victor Shulyak <V.I.Shulyak@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD79442B8487352C1BF92A402
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Victor Shulyak wrote:
>>> --- arch/i386/kernel/entry.S~	2006-12-16 13:32:29.000000000 +0100
>>> +++ arch/i386/kernel/entry.S	2007-01-26 23:44:59.000000000 +0100
>>> @@ -1032,7 +1032,7 @@
>>>  	RING0_INT_FRAME
>>>  	pushl $0			# no error code
>>>  	CFI_ADJUST_CFA_OFFSET 4
>>> -	pushl $do_divide_error
>>> +	PUSH_XVEC(do_divide_error)
>> s,PUSH_XVEC,PUSH_XCODE,
>>
>>>  	CFI_ADJUST_CFA_OFFSET 4
>>>  	jmp error_code
>>>  	CFI_ENDPROC
>=20
> I did so.
>=20

And did this fix your problem?

It seems that applying this change solved occasional early lockups of
2.6.19.2-1.6-0x on my laptop ("occasional" - so I'm still observing...).

Jan


--------------enigD79442B8487352C1BF92A402
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFvgLzniDOoMHTA+kRAk63AJwOLI3GnAvyEZmvn3rPd56PgUbOeQCfQgBT
Xcu9Gm3JdlJYdacPsJqcXus=
=m0ge
-----END PGP SIGNATURE-----

--------------enigD79442B8487352C1BF92A402--

