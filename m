Message-ID: <487CB3F3.8060907@domain.hid>
Date: Tue, 15 Jul 2008 16:28:03 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <487B8B3E.8020805@domain.hid>
	<487B91F6.3070909@domain.hid>	<487BA305.6040401@domain.hid>
	<487BB89B.6010604@domain.hid> <487BF171.2090902@domain.hid>
In-Reply-To: <487BF171.2090902@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5EBF7535FC84842510D9140E"
Subject: Re: [Xenomai-help] rt_task_bind() and timeout values
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
--------------enig5EBF7535FC84842510D9140E
Content-Type: multipart/mixed;
 boundary="------------010608060806000409000701"

This is a multi-part message in MIME format.
--------------010608060806000409000701
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Stefan Kisdaroczi schrieb:
> Hi Philippe,
>=20
> the attached patch fixed the problem for me.
> However, i think that in the "break case" still EACCES is returned.
> Can the break be replaced with a "return ETIMEDOUT" ?
> [...]

I have tried it. A new patch is attached. I tested it first without chang=
ing
the ">=3D" to "<=3D", and the call returned immediately as expected but n=
ow with
ETIMEDOUT instead of EACCESS. After changing the ">=3D" to "<=3D" it seem=
s to
work like it should.

best regards
kisda

--------------010608060806000409000701
Content-Type: text/plain;
 name="xnregistry_bind_timeout.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="xnregistry_bind_timeout.patch"

LS0tIHhlbm9tYWkvbnVjbGV1cy9yZWdpc3RyeS5jLm9sZAkyMDA4LTA3LTE1IDAwOjM2OjEw
LjAwMDAwMDAwMCArMDIwMAorKysgeGVub21haS9udWNsZXVzL3JlZ2lzdHJ5LmMJMjAwOC0w
Ny0xNSAxNToyODoyMy4wMDAwMDAwMDAgKzAyMDAKQEAgLTczMyw4ICs3MzMsMTAgQEAgaW50
IHhucmVnaXN0cnlfYmluZChjb25zdCBjaGFyICprZXksIHhudAogCQlpZiAodGltZW91dCAh
PSBYTl9JTkZJTklURSkgewogCQkJeG50aWNrc190IG5vdyA9IHhudGJhc2VfZ2V0X3RpbWUo
dGJhc2UpOwogCi0JCQlpZiAoc3RpbWUgKyB0aW1lb3V0ID49IG5vdykKLQkJCQlicmVhazsK
KwkJCWlmIChzdGltZSArIHRpbWVvdXQgPD0gbm93KSB7CisJCQkJZXJyID0gLUVUSU1FRE9V
VDsKKwkJCQlnb3RvIHVubG9ja19hbmRfZXhpdDsKKwkJCX0JCQogCiAJCQl0aW1lb3V0IC09
IChub3cgLSBzdGltZSk7CiAJCQlzdGltZSA9IG5vdzsK
--------------010608060806000409000701--

--------------enig5EBF7535FC84842510D9140E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIfLP4IPTw9rIdn6oRAvWrAKCDU//+ZMLBHbEIHI28VbBppZ7wIgCfdIyD
uAcrYUO9VuKE/2UKiUOA1RQ=
=toiq
-----END PGP SIGNATURE-----

--------------enig5EBF7535FC84842510D9140E--

