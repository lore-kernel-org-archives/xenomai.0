Message-ID: <4AF17932.5080000@domain.hid>
Date: Wed, 04 Nov 2009 13:53:06 +0100
From: Alexandre Coffignal <alexandre.coffignal@domain.hid>
MIME-Version: 1.0
References: <4AEEA9AF.5030302@domain.hid> <4AF15548.5010308@domain.hid>
In-Reply-To: <4AF15548.5010308@domain.hid>
Content-Type: multipart/mixed; boundary="------------060303030809020803000507"
Subject: Re: [Xenomai-core] [PATCH] bug found in psos queue
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

This is a multi-part message in MIME format.
--------------060303030809020803000507
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix a =E9crit :
> Alexandre Coffignal wrote:
>  =20
>> Hello all,
>>
>> I found a bug in xenomai-2.4/src/skins/psos+/queue.c,
>> in function q_vreceive, struct modifier is not corectly fill with
>> argument data.
>>
>> Here the patch to fix this bug
>>    =20
>
> Thanks for the patch. But we can not accept a patch of the CREDITS file:
> appear in this file people which do contribute regularly. However, if
> you send a patch in the usual git format (as produced by
> git-format-patch), the patch will be credited to you in the git logs.
>
> So, please resend.
> Regard.
>
>  =20
No problem,

Here patch as produced by git-format-patch.

Thank you for your interest,

Regard.

Alexandre


--=20
Alexandre COFFIGNAL, Chef de Projet
Email: alexandre.coffignal@domain.hid
<mailto:alexandre.coffignal@domain.hid>
------------------------------------
C=E9noSYS <http://www.cenosys.com>
10, Rue Xavier Bichat
F-72000 Le MANS
Tel: +33(0) 243 511 797
web : http://www.cenosys.com
------------------------------------
CONFIDENTIALITE : Ce message =E9lectronique et tous les fichiers attach=E9s
qu'il contient sont confidentiels et destin=E9s exclusivement =E0 l'usage de
la personne =E0 laquelle ils sont adress=E9s. Si vous avez re=E7u ce message
par erreur, merci de le retourner imm=E9diatement a son =E9metteur sans en
conserver de copie.

CONFIDENTIALITY : This e-mail and any attachments are confidential and
may also be privileged. If you are not the named recipient, please
notify the sender immediately and do not disclose the contents to an
other person, use it for any purpose, or store or copy the information
in any medium.

--------------060303030809020803000507
Content-Type: text/x-patch;
 name="0001-psos-in-function-q_vreceive-struct-modifier-is-not.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename*0="0001-psos-in-function-q_vreceive-struct-modifier-is-not.patc";
 filename*1="h"

RnJvbSBmZWQ2Y2VmOTAwMDkwNDMxMmY4ODZkYjhiODk4NmY4N2M0NDQyNzVmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4YW5kcmUgQ29mZmlnbmFsIDxhbGV4YW5kcmUu
Y29mZmlnbmFsQGNlbm9zeXMuY29tPgpEYXRlOiBXZWQsIDQgTm92IDIwMDkgMTM6NDc6NDQg
KzAxMDAKU3ViamVjdDogW1BBVENIXSBwc29zOiBpbiBmdW5jdGlvbiBxX3ZyZWNlaXZlLCBz
dHJ1Y3QgbW9kaWZpZXIgaXMgbm90IGNvcmVjdGx5IGZpbGwgd2l0aAogYXJndW1lbnQgZGF0
YS4KCi0tLQogc3JjL3NraW5zL3Bzb3MrL3F1ZXVlLmMgfCAgICA0ICsrKysKIDEgZmlsZXMg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3NyYy9za2lucy9wc29zKy9xdWV1ZS5jIGIvc3JjL3NraW5zL3Bzb3MrL3F1ZXVlLmMKaW5k
ZXggMjI4ZjViZC4uYWE1NzRjMyAxMDA2NDQKLS0tIGEvc3JjL3NraW5zL3Bzb3MrL3F1ZXVl
LmMKKysrIGIvc3JjL3NraW5zL3Bzb3MrL3F1ZXVlLmMKQEAgLTgyLDYgKzgyLDEwIEBAIHVf
bG9uZyBxX3ZyZWNlaXZlKHVfbG9uZyBxaWQsIHVfbG9uZyBmbGFncywgdV9sb25nIHRpbWVv
dXQsCiAJCXVfbG9uZyBmbGFnczsKIAkJdV9sb25nIHRpbWVvdXQ7CiAJfSBtb2RpZmllcnM7
CS8qIENvbWJpbmUgdG8gZml0IGludG8gYXZhaWxhYmxlIGFyZyBzcGFjZSAoaS5lLiA1KSAq
LworCisJbW9kaWZpZXJzLmZsYWdzPWZsYWdzOw0KKwltb2RpZmllcnMudGltZW91dD10aW1l
b3V0Ow0KKwogCXJldHVybiBYRU5PTUFJX1NLSU5DQUxMNShfX3Bzb3NfbXV4aWQsIF9fcHNv
c19xX3ZyZWNlaXZlLAogCQkJCSBxaWQsICZtb2RpZmllcnMsIG1zZ2J1Zl9yLCBidWZsZW4s
IG1zZ2xlbl9yKTsKIH0KLS0gCjEuNi4wLjQKCg==
--------------060303030809020803000507--

