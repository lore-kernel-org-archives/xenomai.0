Message-ID: <4A48DADC.7090309@domain.hid>
Date: Mon, 29 Jun 2009 17:16:44 +0200
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig26F11AF2A06076266EFDCBDF"
Subject: [Xenomai-help] comedi rtdm_interface.c build fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig26F11AF2A06076266EFDCBDF
Content-Type: multipart/mixed;
 boundary="------------040301020404070806080306"

This is a multi-part message in MIME format.
--------------040301020404070806080306
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

comedi rtdm_interface.c build fails (typo), patch attached.

breaking commit:
  Fri, 12 Jun 2009 08:03:39 +0000 (10:03 +0200)
  e20bd3f2613a052b93c1a4ecada6623a5332f54c
  Made conditional inclusion of owner field in struct proc_dir_entry due =
to changes in 2.6.30.

Error:
  CC [M]  drivers/xenomai/comedi/rtdm_interface.o
drivers/xenomai/comedi/rtdm_interface.c: In function "comedi_init_proc":
drivers/xenomai/comedi/rtdm_interface.c:81: error: "enrty" undeclared (fi=
rst use in this function)
drivers/xenomai/comedi/rtdm_interface.c:81: error: (Each undeclared ident=
ifier is reported only once
drivers/xenomai/comedi/rtdm_interface.c:81: error: for each function it a=
ppears in.)


--------------040301020404070806080306
Content-Type: text/plain;
 name="xeno_comedi_rtdm.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="xeno_comedi_rtdm.patch"

ZGlmZiAtLWdpdCBhL2tzcmMvZHJpdmVycy9jb21lZGkvcnRkbV9pbnRlcmZhY2UuYyBiL2tz
cmMvZHJpdmVycy9jb21lZGkvcnRkbV9pbnRlcmZhY2UuYwppbmRleCBkNGVhNWFjLi43MzY4
N2I2IDEwMDY0NAotLS0gYS9rc3JjL2RyaXZlcnMvY29tZWRpL3J0ZG1faW50ZXJmYWNlLmMK
KysrIGIva3NyYy9kcml2ZXJzL2NvbWVkaS9ydGRtX2ludGVyZmFjZS5jCkBAIC03OCw3ICs3
OCw3IEBAIGludCBjb21lZGlfaW5pdF9wcm9jKHZvaWQpCiAJZW50cnktPmRhdGEgPSBOVUxM
OwogCWVudHJ5LT53cml0ZV9wcm9jID0gTlVMTDsKIAllbnRyeS0+cmVhZF9wcm9jID0gY29t
ZWRpX3JkcHJvY19kZXZzOwotCXdyYXBfcHJvY19kaXJfZW50cnlfb3duZXIoZW5ydHkpOwor
CXdyYXBfcHJvY19kaXJfZW50cnlfb3duZXIoZW50cnkpOwogCiAJLyogQ3JlYXRlcyB0aGUg
ZHJpdmVycyByZWxhdGVkIGZpbGUgKi8KIAllbnRyeSA9IGNyZWF0ZV9wcm9jX2VudHJ5KCJk
cml2ZXJzIiwgMDQ0NCwgY29tZWRpX3Byb2Nfcm9vdCk7CkBAIC05Myw3ICs5Myw3IEBAIGlu
dCBjb21lZGlfaW5pdF9wcm9jKHZvaWQpCiAJZW50cnktPmRhdGEgPSBOVUxMOwogCWVudHJ5
LT53cml0ZV9wcm9jID0gTlVMTDsKIAllbnRyeS0+cmVhZF9wcm9jID0gY29tZWRpX3JkcHJv
Y19kcnZzOwotCXdyYXBfcHJvY19kaXJfZW50cnlfb3duZXIoZW5ydHkpOworCXdyYXBfcHJv
Y19kaXJfZW50cnlfb3duZXIoZW50cnkpOwogCiAJcmV0dXJuIDA7CiAK
--------------040301020404070806080306--

--------------enig26F11AF2A06076266EFDCBDF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKSNriIPTw9rIdn6oRApFwAJ0QOtgqU9rescJjUy8aEi76m2SQcgCeIB9z
Gke8yrJEYzg/d1wUbzSVvmE=
=LFxP
-----END PGP SIGNATURE-----

--------------enig26F11AF2A06076266EFDCBDF--

