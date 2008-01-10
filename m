Message-ID: <2ff1a98a0801100605l1639190eve13def369901f28b@domain.hid>
Date: Thu, 10 Jan 2008 15:05:19 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AEF9AF4@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_1182_256661.1199973919817"
References: <4784BCDD.9000404@domain.hid>
	<5D63919D95F87E4D9D34FF7748CE2C2AEF9AF4@domain.hid>
Subject: Re: [Xenomai-help] Shared Memory mmap fails
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

------=_Part_1182_256661.1199973919817
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

 Jan 10, 2008 9:54 AM,  <Roderik.Wildenburg@domain.hid> wrote:
> Dear Xenomai Pros,
>
> executing the attached code snippet(a very much striped down satch.c exam=
ple) results in the following error message.
>
> # ./satch
> mmap(producer_shm): 6
>
> This means : "ENXIO, the range [off;off+len) is invalid for the shared me=
mory region specified by fd;"
>
> This problem does not only occur in this small example but also in my app=
lication.
> Therefore and as I can=B4t see any obvious  mistake in this example, I th=
ink this could be a problem of Xenomai.
> Could somedbody try to execute this example and validate if there is a ge=
neral problem ?
> I use Xenomai 2.3.5 on a 2.4.25 PPC-kernel.
>
> Thank you very much in advance
> Roderik

Could you try the attached patch ?

--=20
                                               Gilles Chanteperdrix

------=_Part_1182_256661.1199973919817
Content-Type: application/octet-stream;
 name=xeno-posix-revert-commit-3245.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fb9dgzpq2
Content-Disposition: attachment;
 filename=xeno-posix-revert-commit-3245.diff

SW5kZXg6IGtzcmMvc2tpbnMvcG9zaXgvc2htLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0ga3NyYy9za2lucy9w
b3NpeC9zaG0uYwkocsOpdmlzaW9uIDMyNDUpCisrKyBrc3JjL3NraW5zL3Bvc2l4L3NobS5jCShy
w6l2aXNpb24gMzI0NCkKQEAgLTQ5NCw2ICs0OTQsMTEgQEAKIAkJZ290byBlcnJfc2htX3B1dDsK
IAl9CiAKKwkvKiBBbGxvY2F0ZSBvbmUgbW9yZSBwYWdlIGZvciBhbGlnbm1lbnQgKHRoZSBhZGRy
ZXNzIHJldHVybmVkIGJ5IG1tYXAKKwkgICBtdXN0IGJlIGFsaWduZWQpLiAqLworCWlmIChsZW4p
CisJCWxlbiA9IHhuaGVhcF9yb3VuZGVkX3NpemUobGVuICsgUEFHRV9TSVpFLCBQQUdFX1NJWkUp
OworCiAJZXJyID0gMDsKIAlpZiAoZW1wdHlxX3AoJnNobS0+bWFwcGluZ3MpKSB7CiAJCS8qIFRl
bXBvcmFyeSBzdG9yYWdlLCBpbiBvcmRlciB0byBwcmVzZXJ2ZSB0aGUgbWVtb3J5IGNvbnRlbnRz
IHVwb24KQEAgLTUyNSwxOCArNTMwLDEyIEBACiAKIAkJaWYgKGxlbikgewogI2lmZGVmIENPTkZJ
R19YRU5PX09QVF9QRVJWQVNJVkUKLQkJCWludCBmbGFnczsKLQkJCWxlbiA9IHhuaGVhcF9yb3Vu
ZGVkX3NpemUobGVuLCBQQUdFX1NJWkUpOwotCQkJZmxhZ3MgPSBsZW4gPD0gMTI4ICogMTAyNCA/
IEdGUF9VU0VSIDogMDsKKwkJCWludCBmbGFncyA9IGxlbiA8PSAxMjggKiAxMDI0ID8gR0ZQX1VT
RVIgOiAwOwogCQkJZXJyID0gLXhuaGVhcF9pbml0X21hcHBlZCgmc2htLT5oZWFwYmFzZSwgbGVu
LCBmbGFncyk7CiAjZWxzZSAvKiAhQ09ORklHX1hFTk9fT1BUX1BFUlZBU0lWRS4gKi8KIAkJCXsK
LQkJCQl2b2lkICpoZWFwYWRkcjsKKwkJCQl2b2lkICpoZWFwYWRkciA9IHhuYXJjaF9zeXNhbGxv
YyhsZW4pOwogCi0JCQkJbGVuID0geG5oZWFwX3JvdW5kZWRfc2l6ZShsZW4sIFBBR0VfU0laRSk7
Ci0KLQkJCQloZWFwYWRkciA9IHhuYXJjaF9zeXNhbGxvYyhsZW4pOwotCiAJCQkJaWYgKGhlYXBh
ZGRyKQogCQkJCQllcnIgPQogCQkJCQkgICAgLXhuaGVhcF9pbml0KCZzaG0tPmhlYXBiYXNlLAo=

------=_Part_1182_256661.1199973919817--

