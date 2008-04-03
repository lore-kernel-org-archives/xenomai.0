Message-ID: <2ff1a98a0804031019y2bed711dr483175b911bdcf68@domain.hid>
Date: Thu, 3 Apr 2008 19:19:24 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <f45855d10804031016o49cc21a2sf6d332870da725dc@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_2653_9024762.1207243164952"
References: <50566.74.57.109.247.1207002543.squirrel@domain.hid>
	<f45855d10803311731l1f511448wc7451eee7bbe6959@domain.hid>
	<18417.53680.5061.752392@domain.hid>
	<f45855d10804022023n5094eb41g477071cc3a280840@domain.hid>
	<2ff1a98a0804030207sa7a3c44s83fa08db7d0ab3db@domain.hid>
	<f45855d10804030904w28c5ea4bm1c4a71f7b37d5ca6@domain.hid>
	<2ff1a98a0804030908g55e907d9xefb2e5a502c6783d@domain.hid>
	<f45855d10804030931o76c0f07bn43dfe1df08a5c48b@domain.hid>
	<2ff1a98a0804030935i7fe88539s4e5d3e39be6cabb2@domain.hid>
	<f45855d10804031016o49cc21a2sf6d332870da725dc@domain.hid>
Subject: Re: [Xenomai-help] freeze on system() call
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Vincent Levesque <levesquev@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_2653_9024762.1207243164952
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Apr 3, 2008 at 7:16 PM, Vincent Levesque <levesquev@domain.hid> wrote:
> Yes. I just repeated the process with fresh sources to be sure. I'm
> attaching all the relevant files, including a log of
> scripts/prepare_kernel.sh. This time I used linux-2.6.24.4 (from kernel.org)
> and xenomai 2.4.2.

The patch you have got is whitespace damaged. Here comes the good one.

-- 
 Gilles

------=_Part_2653_9024762.1207243164952
Content-Type: application/octet-stream; name=ipipe-kmap_atomic-bug.6.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_felleb3a4
Content-Disposition: attachment; filename=ipipe-kmap_atomic-bug.6.diff

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0uaAppbmRl
eCA3ZjI3ZGI2Li5hMGM4MGM3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgKKysrIGIv
aW5jbHVkZS9saW51eC9tbS5oCkBAIC0xMDQsMTAgKzEwNCwxMSBAQCBleHRlcm4gdW5zaWduZWQg
aW50IGtvYmpzaXplKGNvbnN0IHZvaWQgKm9ianApOwogI2RlZmluZSBWTV9NQVBQRURfQ09QWQkw
eDAxMDAwMDAwCS8qIFQgaWYgbWFwcGVkIGNvcHkgb2YgZGF0YSAobm9tbXUgbW1hcCkgKi8KICNk
ZWZpbmUgVk1fSU5TRVJUUEFHRQkweDAyMDAwMDAwCS8qIFRoZSB2bWEgaGFzIGhhZCAidm1faW5z
ZXJ0X3BhZ2UoKSIgZG9uZSBvbiBpdCAqLwogI2RlZmluZSBWTV9BTFdBWVNEVU1QCTB4MDQwMDAw
MDAJLyogQWx3YXlzIGluY2x1ZGUgaW4gY29yZSBkdW1wcyAqLwotI2RlZmluZSBWTV9QSU5ORUQJ
MHgwODAwMDAwMAkvKiBEaXNhYmxlIGZhdWx0cyBmb3IgdGhlIHZtYSAqLwogCiAjZGVmaW5lIFZN
X0NBTl9OT05MSU5FQVIgMHgwODAwMDAwMAkvKiBIYXMgLT5mYXVsdCAmIGRvZXMgbm9ubGluZWFy
IHBhZ2VzICovCiAKKyNkZWZpbmUgVk1fUElOTkVECTB4MTAwMDAwMDAJLyogRGlzYWJsZSBmYXVs
dHMgZm9yIHRoZSB2bWEgKi8KKwogI2lmbmRlZiBWTV9TVEFDS19ERUZBVUxUX0ZMQUdTCQkvKiBh
cmNoIGNhbiBvdmVycmlkZSB0aGlzICovCiAjZGVmaW5lIFZNX1NUQUNLX0RFRkFVTFRfRkxBR1Mg
Vk1fREFUQV9ERUZBVUxUX0ZMQUdTCiAjZW5kaWYKZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIv
bW0vbWVtb3J5LmMKaW5kZXggZTBlN2EzZC4uMzJkNmNiNiAxMDA2NDQKLS0tIGEvbW0vbWVtb3J5
LmMKKysrIGIvbW0vbWVtb3J5LmMKQEAgLTU4NCw4ICs1ODQsMTQgQEAgYWdhaW46CiAJCQlpZiAo
aXNfY293X21hcHBpbmcodm1hLT52bV9mbGFncykpIHsKIAkJCQlpZiAoKCh2bWEtPnZtX2ZsYWdz
fHNyY19tbS0+ZGVmX2ZsYWdzKSAmIChWTV9MT0NLRUR8Vk1fUElOTkVEKSkKIAkJCQkgICAgPT0g
KFZNX0xPQ0tFRHxWTV9QSU5ORUQpKSB7CisJCQkJICAgIAlhcmNoX2xlYXZlX2xhenlfbW11X21v
ZGUoKTsKKwkJCQkgICAgCXNwaW5fdW5sb2NrKHNyY19wdGwpOworCQkJCSAgICAJcHRlX3VubWFw
X25lc3RlZChzcmNfcHRlKTsKKwkJCQkgICAgCWFkZF9tbV9yc3MoZHN0X21tLCByc3NbMF0sIHJz
c1sxXSk7CisJCQkJICAgIAlwdGVfdW5tYXBfdW5sb2NrKGRzdF9wdGUsIGRzdF9wdGwpOworCQkJ
CSAgICAJY29uZF9yZXNjaGVkKCk7CiAJCQkJCWRvX2Nvd19icmVhayA9IDE7Ci0JCQkJCWJyZWFr
OworCQkJCQlnb3RvIGFnYWluOwogCQkJCX0KIAkJCX0KIAkJfQo=
------=_Part_2653_9024762.1207243164952--

