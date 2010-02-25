Message-ID: <4B86B0DB.4000600@domain.hid>
Date: Thu, 25 Feb 2010 18:18:19 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B6E8167.6010907@domain.hid>	<4B76B7F2.2050303@domain.hid>	<4B76C045.2070602@domain.hid>	<1266140329.27019.17.camel@domain.hid>	<4B867EB5.9090504@domain.hid>	<4B867FF9.2020709@domain.hid>
	<4B868228.10206@domain.hid> <4B868958.3000503@domain.hid>
In-Reply-To: <4B868958.3000503@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB0A499F71932D7CC335A3F34"
Subject: Re: [Xenomai-core] Xenomai in Debian
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB0A499F71932D7CC335A3F34
Content-Type: multipart/mixed;
 boundary="------------000609030908040807060400"

This is a multi-part message in MIME format.
--------------000609030908040807060400
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 25.02.2010 15:29, schrieb Stefan Kisdaroczi:
> Am 25.02.2010 14:59, schrieb Stefan Kisdaroczi:
>> Am 25.02.2010 14:49, schrieb Gilles Chanteperdrix:
>>> Stefan Kisdaroczi wrote:
>>>> Hi,
>>>>
>>>> Am 14.02.2010 10:38, schrieb Philippe Gerum:
>>>>> <snip>
>>>>> In any case, thanks for your work so far. We probably need to discu=
ss
>>>>> the packaging issues on this list, so that we get both consistency =
and
>>>>> usability in the future.
>>>>>
>>>>> Gilles and Roland, if this is fine with you, I'll handle the liaiso=
n
>>>>> role with upstream packagers, so please CC me explicitly on those m=
ails.
>>>>> We'll sort out this issue, it doesn't look that bad anyway.
>>>>
>>>> udev/xenomai.rules sets the group for realtime devices to "xenomai".=

>>>> Patch attached to create the group "xenomai" on installation.
>>>>
>>>> Additionally, it would be nice to set "xeno_nucleus.xenomai_gid" to
>>>> group "xenomai" too. Is this possible with a udev rule ?
>>>
>>> Well, no, xeno_nucleus.xenomai_gid is a kernel parameter, so it is bo=
ot
>>> loader stuff. However, if xeno_nucleus is compiled as a module, you c=
an
>>> add parameters in /etc/modprobe.d. Well, that would have been the pla=
ce
>>> to do it some time ago. I may not be completely up-to-date.
>>
>> Hi Gilles,
>>
>> can a init.d script with
>>   echo "<gid>" > /sys/module/xeno_nucleus/parameters/xenomai_gid
>> work in module and builtin case ?
>=20
> it seems that init.d will work for the builtin case and modprobe.d for =
the
> module case. So adding both should work "in all cases" :-)
> I'll give it a try ...

Attached a patch that adds a init-script /etc/init.d/xenomai to the packa=
ge libxenomai1.
If group xenomai and the file /sys/module/xeno_nucleus/parameters/xenomai=
_gid are found,
xenomai_gid is set on startup.

Now looking at modprobe.d ...

>>>>
>>>> regards
>>>> kisda
>>>>
>>>>
>>>> --------------------------------------------------------------------=
----
>>>>
>>>> _______________________________________________
>>>> Xenomai-core mailing list
>>>> Xenomai-core@domain.hid
>>>> https://mail.gna.org/listinfo/xenomai-core
>>>
>>>
>>
>>
>>
>>
>> _______________________________________________
>> Xenomai-core mailing list
>> Xenomai-core@domain.hid
>> https://mail.gna.org/listinfo/xenomai-core
>=20
>=20
>=20
>=20
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


--------------000609030908040807060400
Content-Type: text/plain;
 name="xenomai-init.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="xenomai-init.patch"

ZGlmZiAtdU5ycCB4ZW5vbWFpLTIuNS4xL2RlYmlhbi9saWJ4ZW5vbWFpMS54ZW5vbWFpLmlu
aXQgeGVub21haS0yLjUuMS5uZXcvZGViaWFuL2xpYnhlbm9tYWkxLnhlbm9tYWkuaW5pdAot
LS0geGVub21haS0yLjUuMS9kZWJpYW4vbGlieGVub21haTEueGVub21haS5pbml0CTE5NzAt
MDEtMDEgMDE6MDA6MDAuMDAwMDAwMDAwICswMTAwCisrKyB4ZW5vbWFpLTIuNS4xLm5ldy9k
ZWJpYW4vbGlieGVub21haTEueGVub21haS5pbml0CTIwMTAtMDItMjUgMTc6MTM6NTEuMDAw
MDAwMDAwICswMTAwCkBAIC0wLDAgKzEsMzcgQEAKKyMhL2Jpbi9zaCAtZQorIyMjIEJFR0lO
IElOSVQgSU5GTworIyBQcm92aWRlczogICAgICAgICAgeGVub21haQorIyBSZXF1aXJlZC1T
dGFydDogICAgbW91bnRrZXJuZnMKKyMgUmVxdWlyZWQtU3RvcDoKKyMgRGVmYXVsdC1TdGFy
dDogICAgIFMKKyMgRGVmYXVsdC1TdG9wOgorIyBTaG9ydC1EZXNjcmlwdGlvbjogU2V0IHhl
bm9fbnVjbGV1cyBncm91cAorIyMjIEVORCBJTklUIElORk8KKworR1JPVVA9eGVub21haQor
SU5JVE5BTUU9L2V0Yy9pbml0LmQveGVub21haQorRklMRU5BTUU9L3N5cy9tb2R1bGUveGVu
b19udWNsZXVzL3BhcmFtZXRlcnMveGVub21haV9naWQKK0dJRD0kKGdldGVudCBncm91cCAk
R1JPVVAgfCBjdXQgLWQ6IC1mMykKKwordGVzdCAtZSAkRklMRU5BTUUgfHwgZXhpdCAwCit0
ZXN0IC1uICIkR0lEIiB8fCBleGl0IDAKKworY2FzZSAiJDEiIGluCisgIHN0YXJ0KQorICAg
ICAgICBlY2hvICIkR0lEIiA+ICRGSUxFTkFNRQorICAgICAgICA7OworICBzdG9wKQorICAg
ICAgICBlY2hvICItMSIgPiAkRklMRU5BTUUKKyAgICAgICAgOzsKKyAgcmVzdGFydHxmb3Jj
ZS1yZWxvYWQpCisgICAgICAgICQwIHN0b3AKKyAgICAgICAgJDAgc3RhcnQKKyAgICAgICAg
OzsKKyAgKikKKyAgICAgICAgZWNobyAiVXNhZ2U6ICRJTklUTkFNRSB7c3RhcnR8c3RvcHxy
ZXN0YXJ0fGZvcmNlLXJlbG9hZH0iCisgICAgICAgIGV4aXQgMQorICAgICAgICA7OworZXNh
YworCitleGl0IDAKKwpkaWZmIC11TnJwIHhlbm9tYWktMi41LjEvZGViaWFuL3J1bGVzIHhl
bm9tYWktMi41LjEubmV3L2RlYmlhbi9ydWxlcwotLS0geGVub21haS0yLjUuMS9kZWJpYW4v
cnVsZXMJMjAxMC0wMi0yNSAxNjo1NjowNS4wMDAwMDAwMDAgKzAxMDAKKysrIHhlbm9tYWkt
Mi41LjEubmV3L2RlYmlhbi9ydWxlcwkyMDEwLTAyLTI1IDE3OjMzOjIwLjAwMDAwMDAwMCAr
MDEwMApAQCAtMTMyLDYgKzEzMiw3IEBAIGJpbmFyeS1pbmRlcDogYnVpbGQgaW5zdGFsbAog
YmluYXJ5LWFyY2g6IGJ1aWxkIGluc3RhbGwKIAlkaF90ZXN0ZGlyIC1zCiAJZGhfdGVzdHJv
b3QgLXMKKwlkaF9pbnN0YWxsaW5pdCAtcyAtLW5hbWU9eGVub21haQogCWRoX2luc3RhbGxt
YW4gLXMKIAlkaF9pbnN0YWxsZG9jcyAtcyAtQSBDUkVESVRTIFJFQURNRS5JTlNUQUxMIFRS
T1VCTEVTSE9PVElORwogCWRoX2xpbmsgLXMK
--------------000609030908040807060400--

--------------enigB0A499F71932D7CC335A3F34
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLhrDgIPTw9rIdn6oRAlnAAJ9lPyoFMk0Ti+JGwbG4tThr5y8ZFwCfSY6i
ZDu5TvhL0VumjHofyaa7gTU=
=gkyv
-----END PGP SIGNATURE-----

--------------enigB0A499F71932D7CC335A3F34--

