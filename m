Message-ID: <4B45F5D5.1080001@domain.hid>
Date: Thu, 07 Jan 2010 15:55:17 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B45F088.9010603@domain.hid> <4B45F163.4000504@domain.hid>
In-Reply-To: <4B45F163.4000504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCAF3905C3F3621DF554D09DB"
Subject: Re: [Xenomai-help] native skin 2.5.0: rt_task_create() segfaults if
 stacksize parameter too small
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCAF3905C3F3621DF554D09DB
Content-Type: multipart/mixed;
 boundary="------------070505030906080604060201"

This is a multi-part message in MIME format.
--------------070505030906080604060201
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 07.01.2010 15:36, schrieb Gilles Chanteperdrix:
> Stefan Kisdaroczi wrote:
>> hi,
>>
>> i have upgraded xenomai to 2.5.0 (x86,32bit). My application segfaults=
 when I
>> try to create a task with stacksize 2048, this worked with 2.4.10.
>> Because my app is written in pascal i have reproduced the problem with=
 the
>> xenomai trivial-periodic.c example:
>>
>> -	rt_task_create(&demo_task, "trivial", 0, 99, 0);
>> +	rt_task_create(&demo_task, "trivial",16911, 99, 0);
>>
>> Stacksize 0 -> default stack size : ok
>> Stacksize > 0 and <=3D 16911 : Segmentation fault
>> Stacksize >=3D 16912 : ok
>>
>> Any hints ?
>=20
> What does the task do?

Nothing :-)

I have attached a patch for the trivial-periodic.c example to reproduce t=
he problem.

thx
kisda

--------------070505030906080604060201
Content-Type: text/plain;
 name="trivial-stacksize.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="trivial-stacksize.diff"

LS0tIHRyaXZpYWwtcGVyaW9kaWMub2xkCTIwMDktMDMtMzEgMTA6NTE6MTAuMDAwMDAwMDAw
ICswMjAwCisrKyB0cml2aWFsLXBlcmlvZGljLmMJMjAxMC0wMS0wNyAxNjoyNDoyOC4wMDAw
MDAwMDAgKzAxMDAKQEAgLTEyLDMwICsxMiw2IEBAIFJUX1RBU0sgZGVtb190YXNrOwogCiB2
b2lkIGRlbW8odm9pZCAqYXJnKQogewotCVJUSU1FIG5vdywgcHJldmlvdXM7Ci0KLQkvKgot
CSAqIEFyZ3VtZW50czogJnRhc2sgKE5VTEw9c2VsZiksCi0JICogICAgICAgICAgICBzdGFy
dCB0aW1lLAotCSAqICAgICAgICAgICAgcGVyaW9kIChoZXJlOiAxIHMpCi0JICovCi0JcnRf
dGFza19zZXRfcGVyaW9kaWMoTlVMTCwgVE1fTk9XLCAxMDAwMDAwMDAwKTsKLQlwcmV2aW91
cyA9IHJ0X3RpbWVyX3JlYWQoKTsKLQotCXdoaWxlICgxKSB7Ci0JCXJ0X3Rhc2tfd2FpdF9w
ZXJpb2QoTlVMTCk7Ci0JCW5vdyA9IHJ0X3RpbWVyX3JlYWQoKTsKLQotCQkvKgotCQkgKiBO
T1RFOiBwcmludGYgbWF5IGhhdmUgdW5leHBlY3RlZCBpbXBhY3Qgb24gdGhlIHRpbWluZyBv
ZgotCQkgKiAgICAgICB5b3VyIHByb2dyYW0uIEl0IGlzIHVzZWQgaGVyZSBpbiB0aGUgY3Jp
dGljYWwgbG9vcAotCQkgKiAgICAgICBvbmx5IGZvciBkZW1vbnN0cmF0aW9uIHB1cnBvc2Vz
LgotCQkgKi8KLQkJcHJpbnRmKCJUaW1lIHNpbmNlIGxhc3QgdHVybjogJWxkLiUwNmxkIG1z
XG4iLAotCQkgICAgICAgKGxvbmcpKG5vdyAtIHByZXZpb3VzKSAvIDEwMDAwMDAsCi0JCSAg
ICAgICAobG9uZykobm93IC0gcHJldmlvdXMpICUgMTAwMDAwMCk7Ci0JCSAgICAgICBwcmV2
aW91cyA9IG5vdzsKLQl9CiB9CiAKIHZvaWQgY2F0Y2hfc2lnbmFsKGludCBzaWcpCkBAIC01
Nyw3ICszMyw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyKiBhcmd2W10pCiAJICogICAg
ICAgICAgICBwcmlvcml0eSwKIAkgKiAgICAgICAgICAgIG1vZGUgKEZQVSwgc3RhcnQgc3Vz
cGVuZGVkLCAuLi4pCiAJICovCi0JcnRfdGFza19jcmVhdGUoJmRlbW9fdGFzaywgInRyaXZp
YWwiLCAwLCA5OSwgMCk7CisJcnRfdGFza19jcmVhdGUoJmRlbW9fdGFzaywgInRyaXZpYWwi
LDE2OTExLCA5OSwgMCk7CiAKIAkvKgogCSAqIEFyZ3VtZW50czogJnRhc2ssCg==
--------------070505030906080604060201--

--------------enigCAF3905C3F3621DF554D09DB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLRfXVIPTw9rIdn6oRAsy5AJ9d1okxvsnhFo8XST6SNB701Dk2nQCfc6sA
VU+Tj2+IaCtnilJmWqrmXWg=
=uIFN
-----END PGP SIGNATURE-----

--------------enigCAF3905C3F3621DF554D09DB--

