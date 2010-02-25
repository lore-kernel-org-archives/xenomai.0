Message-ID: <4B868228.10206@domain.hid>
Date: Thu, 25 Feb 2010 14:59:04 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>	<4B76B7F2.2050303@domain.hid>	<4B76C045.2070602@domain.hid>	<1266140329.27019.17.camel@domain.hid>
	<4B867EB5.9090504@domain.hid> <4B867FF9.2020709@domain.hid>
In-Reply-To: <4B867FF9.2020709@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig29D9BD68CE19B59646F3A1A4"
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig29D9BD68CE19B59646F3A1A4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 25.02.2010 14:49, schrieb Gilles Chanteperdrix:
> Stefan Kisdaroczi wrote:
>> Hi,
>>
>> Am 14.02.2010 10:38, schrieb Philippe Gerum:
>>> <snip>
>>> In any case, thanks for your work so far. We probably need to discuss=

>>> the packaging issues on this list, so that we get both consistency an=
d
>>> usability in the future.
>>>
>>> Gilles and Roland, if this is fine with you, I'll handle the liaison
>>> role with upstream packagers, so please CC me explicitly on those mai=
ls.
>>> We'll sort out this issue, it doesn't look that bad anyway.
>>
>> udev/xenomai.rules sets the group for realtime devices to "xenomai".
>> Patch attached to create the group "xenomai" on installation.
>>
>> Additionally, it would be nice to set "xeno_nucleus.xenomai_gid" to
>> group "xenomai" too. Is this possible with a udev rule ?
>=20
> Well, no, xeno_nucleus.xenomai_gid is a kernel parameter, so it is boot=

> loader stuff. However, if xeno_nucleus is compiled as a module, you can=

> add parameters in /etc/modprobe.d. Well, that would have been the place=

> to do it some time ago. I may not be completely up-to-date.

Hi Gilles,

can a init.d script with
  echo "<gid>" > /sys/module/xeno_nucleus/parameters/xenomai_gid
work in module and builtin case ?

>>
>> regards
>> kisda
>>
>>
>> ----------------------------------------------------------------------=
--
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
>=20
>=20



--------------enig29D9BD68CE19B59646F3A1A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLhoIoIPTw9rIdn6oRAgkGAJ0clrGuth39HEspY9gMDVfauqNjJwCfVRa7
cZ+jvmsjj2g4wRJW1aUEg6Y=
=HcEx
-----END PGP SIGNATURE-----

--------------enig29D9BD68CE19B59646F3A1A4--

