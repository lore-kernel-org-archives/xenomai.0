Message-ID: <4BF29943.3010309@domain.hid>
Date: Tue, 18 May 2010 15:42:27 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4BF268DE.1080809@domain.hid> <4BF273ED.2070802@domain.hid>
In-Reply-To: <4BF273ED.2070802@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig03B02DDF3EEFE1AE4B94CC9E"
Subject: Re: [Xenomai-core] rtdm_dev_register oops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03B02DDF3EEFE1AE4B94CC9E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 18.05.2010 13:03, schrieb Jan Kiszka:
> Stefan Kisdaroczi wrote:
>> hi,
>>
>> i got a exception in rtdm_dev_register(). I didnt call rtdm_dev_unregi=
ster in my driver
>> and after insmodding the module again I got a oops.
>=20
> And that is surprising to you? :)

A bit.

> If you leave the previous device registered on rmmod, oopses are
> programmed to occur: You leave references to unallocated memory behind.=


If one device fails to unregister i can't register any other device anymo=
re,
the rtdm registry is broken (cat /proc/xenomai/rtdm/names_devices hangs).=

That was surprising. If I have one corrupt file on my disk i can still
create/access other files or list the filenames without exception.

Please don't get me wrong, but its not obvious for me that a registry
behaves like that, but i can life with it. Sorry for the noise.

Stefan

> Jan
>=20
>> xenomai 2.5.3, linux 2.6.32.11, x86 32bit, ubuntu 10.04.
>>
>> Attached is the dmesg-trace and a small rtdm-module foo.c for reproduc=
tion:
>> insmod ./xeno_foo.ko
>> rmmod xeno_foo
>> insmod ./xeno_foo.ko -> oops
>>
>> thanks
>> stefan
>=20



--------------enig03B02DDF3EEFE1AE4B94CC9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFL8plIIPTw9rIdn6oRAniMAJ9fNI9PlFIBsLy1m67WQfo8MLNajwCfaWOW
emc44XvCL5Q/V2logSZYgko=
=EFQC
-----END PGP SIGNATURE-----

--------------enig03B02DDF3EEFE1AE4B94CC9E--

