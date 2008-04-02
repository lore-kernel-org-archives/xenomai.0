Message-ID: <2ff1a98a0804020142r55bab884x8896c8191f8580d5@domain.hid>
Date: Wed, 2 Apr 2008 10:42:29 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47F2A7CC.4050301@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5061_23674056.1207125749979"
References: <47ED5DE3.60202@domain.hid>
	<18417.18371.183857.809430@domain.hid>
	<18417.18921.588809.645062@domain.hid>
	<47F17B32.7070505@domain.hid>
	<18417.52630.8850.939898@domain.hid>
	<47F23E9E.7060801@domain.hid>
	<2ff1a98a0804010703v7090d7dbhbbff114a51badd6d@domain.hid>
	<47F258AD.3000103@domain.hid>
	<2ff1a98a0804010858kb009b37y764667cf1fa56c6@domain.hid>
	<47F2A7CC.4050301@domain.hid>
Subject: Re: [Xenomai-core] Kernel crash with Xenomai (caused by fork?)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Tomas Kalibera <kalibera@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

------=_Part_5061_23674056.1207125749979
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Apr 1, 2008 at 11:23 PM, Tomas Kalibera <kalibera@domain.hid> wrote:
> OK, I got rid of old patches and applied only this check (attached). Now,
> the kernel boots. When I run my Xenomai app, the kernel locks up, without
> writing anything to console.
>
>  I tried to get some info via SysRq keys, though the only working options
> were reboot and kill. If I did "kill", the kernel started repeating all the
> time the message below.

Ok. Get rid of old patches and try this new one. This should hopefully
be the final fix...

-- 
 Gilles

------=_Part_5061_23674056.1207125749979
Content-Type: application/octet-stream; name=ipipe-kmap_atomic-bug.5.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fejnhsln0
Content-Disposition: attachment; filename=ipipe-kmap_atomic-bug.5.diff

ZGlmZiAtLWdpdCBhL21tL21lbW9yeS5jIGIvbW0vbWVtb3J5LmMKaW5kZXggZTBlN2EzZC4uMzJk
NmNiNiAxMDA2NDQKLS0tIGEvbW0vbWVtb3J5LmMKKysrIGIvbW0vbWVtb3J5LmMKQEAgLTU4NCw4
ICs1ODQsMTQgQEAgYWdhaW46CiAJCQlpZiAoaXNfY293X21hcHBpbmcodm1hLT52bV9mbGFncykp
IHsKIAkJCQlpZiAoKCh2bWEtPnZtX2ZsYWdzfHNyY19tbS0+ZGVmX2ZsYWdzKSAmIChWTV9MT0NL
RUR8Vk1fUElOTkVEKSkKIAkJCQkgICAgPT0gKFZNX0xPQ0tFRHxWTV9QSU5ORUQpKSB7CisJCQkJ
ICAgIAlhcmNoX2xlYXZlX2xhenlfbW11X21vZGUoKTsKKwkJCQkgICAgCXNwaW5fdW5sb2NrKHNy
Y19wdGwpOworCQkJCSAgICAJcHRlX3VubWFwX25lc3RlZChzcmNfcHRlKTsKKwkJCQkgICAgCWFk
ZF9tbV9yc3MoZHN0X21tLCByc3NbMF0sIHJzc1sxXSk7CisJCQkJICAgIAlwdGVfdW5tYXBfdW5s
b2NrKGRzdF9wdGUsIGRzdF9wdGwpOworCQkJCSAgICAJY29uZF9yZXNjaGVkKCk7CiAJCQkJCWRv
X2Nvd19icmVhayA9IDE7Ci0JCQkJCWJyZWFrOworCQkJCQlnb3RvIGFnYWluOwogCQkJCX0KIAkJ
CX0KIAkJfQo=
------=_Part_5061_23674056.1207125749979--

