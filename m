Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB85EEEDE
	for <xenomai@lists.linux.dev>; Tue, 20 May 2025 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749803; cv=none; b=IZHAMLxO5iUs6+JJz05RRNWdN78CvzbPo+scTDmHKEbzxoF/bA1NykRxRPghmUCBdF+VsaPXOl6Wp4Kv08Gkc+1V5pf2L2BqCMJRF9OpWXOplsJTo7Gt7TNzQW2Lz15rU6HRUMBv9i+EmN8UTSxGw+755p9si70PajMYaBNupcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749803; c=relaxed/simple;
	bh=au0LFmWBqYwlOJFFkCO3M9LNs7hG/zHVg8D2qZF3Sqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=V6HbMzLd159NGb3VL/Zp5GpQYVB3pI8HzXbUpxsYvRDmj2z0d+7lTFg49UPP0CWRO5fnh2jeBIm3J6blU9XYH0yrbWg60e4/Oqimt+qH2oaL2XlY9821kwy30YwB+ldadnmpgf81IvM1kIZM69jqyCtCD/rOaB6WuvgglVAKelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=JsqAGja5 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="JsqAGja5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=F8eo4nI0TxW5Mo0CG1DH/X9eVntZQnbcynFunqpGOug=; b=J
	sqAGja5596Et2NJwkNACDTBcRRUXUGxCrzDwiu6GZAWIaGBcYAYBQ547TKobFztw
	CY4efgXk/i4jgKINhVy7lxzXVjXCoUJfLPuqlLJ+ytb96cXNkfIinLKxedgXFu65
	B7CNqB5JYOFE5ttB4kh6fAIMLOR0EWj7hMTHVALQ08=
Received: from aspirestro$163.com ( [120.244.221.195] ) by
 ajax-webmail-wmsvr-40-131 (Coremail) ; Tue, 20 May 2025 22:03:16 +0800
 (CST)
Date: Tue, 20 May 2025 22:03:16 +0800 (CST)
From: "Haiyang He" <aspirestro@163.com>
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>,
	"Florian Bezdeka" <florian.bezdeka@siemens.com>
Subject: Re:[PATCH v2] lib/cobalt: Unbreak sigshadow installation for
 statically linked applications
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <dbf7a323-f79b-4cdb-aa8d-7d86aaa5127f@siemens.com>
References: <dbf7a323-f79b-4cdb-aa8d-7d86aaa5127f@siemens.com>
X-NTES-SC: AL_Qu2fBfuftk8i4COcY+kfmU4Vgeo2UMCzu/gk34BUO5lwjA/o3CI7fmVSOkv1zca0EjCVmgmGWxdH9s9qRohzfKE6eRW7PUdDdcHl77iZc09SpA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1fd74c22.a656.196ee017a02.Coremail.aspirestro@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gygvCgD3PwGliyxoR+cIAA--.7057W
X-CM-SenderInfo: pdvsx2xhvw20i6rwjhhfrp/1tbiXQlTcWgsJWiLlgACsg
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

QXQgMjAyNS0wNS0xOSAxNjozNDo1NCwgIkphbiBLaXN6a2EiIDxqYW4ua2lzemthQHNpZW1lbnMu
Y29tPiB3cm90ZToKPkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+Cj4K
PldoZW4gc3RhdGljYWxseSBsaW5raW5nLCB3ZSBkbyBub3QgaGF2ZSBhIC5laF9mcmFtZV9oZHIg
c2VjdGlvbi4gSWYgd2UKPnRoZW4gY2FsbCBiYWNrdHJhY2UgYmVmb3JlIGZyYW1lX2R1bW15IHdh
cyBpbnZva2VkIGR1cmluZyBsYXRlCj5jb25zdHJ1Y3Rpb25zLCB3ZSBhYm9ydC4gQWRkcmVzcyB0
aGF0IGJ5IG1vdmluZyB0aGUgYmFja3RyYWNlIHdhcm0tdXAKPmNhbGwgaW50byBhIHNlcGFyYXRl
IGNvbnN0cnVjdG9yIHRoYXQgaXMgYXJtZWQgZWFybGllciBieQo+aW5zdGFsbF9zaWdzaGFkb3cs
IG9yIGNhbGwgaXQgbGF0ZXIgZGlyZWN0bHkgaWYgaW5zdGFsbF9zaWdzaGFkb3cgaXMKPnJ1bm5p
bmcgYWZ0ZXIgdGhlIGNvbnN0cnVjdGlvbiBwaGFzZS4KPgo+UmVwb3J0ZWQtYnk6IEhhaXlhbmcg
SGUgPGFzcGlyZXN0cm9AMTYzLmNvbT4KPlNpZ25lZC1vZmYtYnk6IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+Cj4tLS0KPgo+Q2hhbmdlcyBpbiB2MjoKPiAtIHVzZSBleHBsaWNp
dCBsb3dlc3QgY29uc3RydWN0b3IgcHJpbyB0byBtYWtlIGl0IGNsZWFyZXIgdGhhdCB3ZSBuZWVk
Cj4gICB0byBiZSBsYXN0Cj4KPiBsaWIvY29iYWx0L3NpZ3NoYWRvdy5jIHwgMzMgKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0tCj4gMSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pCj4KPmRpZmYgLS1naXQgYS9saWIvY29iYWx0L3NpZ3NoYWRvdy5j
IGIvbGliL2NvYmFsdC9zaWdzaGFkb3cuYwo+aW5kZXggMDkyY2FkYjA4YS4uMTA3MzZiMTEzZiAx
MDA2NDQKPi0tLSBhL2xpYi9jb2JhbHQvc2lnc2hhZG93LmMKPisrKyBiL2xpYi9jb2JhbHQvc2ln
c2hhZG93LmMKPkBAIC0zMyw2ICszMyw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IGJhY2t0cmFjZSh2
b2lkICoqYnVmZmVyLCBpbnQgc2l6ZSkKPiAKPiBzdGF0aWMgc3RydWN0IHNpZ2FjdGlvbiBzaWdz
aGFkb3dfYWN0aW9uX29yaWc7Cj4gCj4rc3RhdGljIGJvb2wgcmVxdWVzdF9iYWNrdHJhY2VfaW5p
dDsKPitzdGF0aWMgYm9vbCBwYXN0X2NvbnN0cnVjdG9yczsKPisKPiAvKgo+ICAqIFRoZSBmb2xs
b3dpbmcgaGFuZGxlciBpcyBwYXJ0IG9mIHRoZSBpbm5lciB1c2VyLWludGVyZmFjZTogc2hvdWxk
Cj4gICogcmVtYWluIGV4dGVybi4KPkBAIC05NiwxOSArOTksMzUgQEAgc3RhdGljIHZvaWQgc2ln
c2hhZG93X2hhbmRsZXIoaW50IHNpZywgc2lnaW5mb190ICpzaSwgdm9pZCAqY3R4dCkKPiAJcHRo
cmVhZF9zaWdtYXNrKFNJR19TRVRNQVNLLCAmc2F2ZWRfc2lnc2V0LCBOVUxMKTsKPiB9Cj4gCj4t
c3RhdGljIHZvaWQgaW5zdGFsbF9zaWdzaGFkb3codm9pZCkKPisvKgo+KyAqIEtpY2tzdGFydCBi
YWNrdHJhY2UoKSBzbyB0aGF0IGl0IG1heSBjYWxsIG1hbGxvYygpIGZyb20gYSBzYWZlIGNvbnRl
eHQgcmlnaHQKPisgKiBub3csIG5vdCBsYXRlciBvbiBmcm9tIHRoZSBzaWdzaGFkb3cgaGFuZGxl
ci4KPisgKgo+KyAqIFdlIGNhbiBvbmx5IHRyaWdnZXIgdGhpcyBhZnRlciBtYWluKCkgc3RhcnRl
ZCBvciB2ZXJ5IGxhdGUgZHVyaW5nCj4rICogY29uc3RydWN0aW9uIGJlY2F1c2UsIHdoZW4gc3Rh
dGljYWxseSBsaW5rZWQsIGZyYW1lX2R1bW15IGluIGN0cnN0dWZmIG11c3QKPisgKiBoYXZlIHJ1
biBhbHJlYWR5Lgo+KyAqLwo+K3N0YXRpYyB2b2lkIF9fYXR0cmlidXRlX18oKGNvbnN0cnVjdG9y
KDY1NTM1KSkpIHRyaWdnZXJfYmFja3RyYWNlKHZvaWQpCj4gewo+IAl2b2lkICpkdW1teVtTSUdT
SEFET1dfQkFDS1RSQUNFX0RFUFRIXTsKPisKPisJaWYgKHJlcXVlc3RfYmFja3RyYWNlX2luaXQp
Cj4rCQliYWNrdHJhY2UoZHVtbXksIFNJR1NIQURPV19CQUNLVFJBQ0VfREVQVEgpOwo+Kwo+Kwlw
YXN0X2NvbnN0cnVjdG9ycyA9IHRydWU7Cj4rCS8qIGVuc3VyZSB2aXNpYmlsaXR5IG9mIHBhc3Rf
Y29uc3RydWN0b3JzIGFmdGVyIGluaXQgcGhhc2UgKi8KPisJc21wX21iKCk7Cj4rfQo+Kwo+K3N0
YXRpYyB2b2lkIGluc3RhbGxfc2lnc2hhZG93KHZvaWQpCj4rewo+IAlzdHJ1Y3Qgc2lnYWN0aW9u
IG5ld19zaWdzaGFkb3dfYWN0aW9uOwo+IAlzaWdzZXRfdCBzYXZlZF9zaWdzZXQ7Cj4gCXNpZ3Nl
dF90IG1hc2tfc2lnc2V0Owo+IAo+LQkvKgo+LQkgKiBLaWNrc3RhcnQgYmFja3RyYWNlKCkgc28g
dGhhdCBpdCBtYXkgY2FsbCBtYWxsb2MoKSBmcm9tIGEKPi0JICogc2FmZSBjb250ZXh0IHJpZ2h0
IG5vdywgbm90IGxhdGVyIG9uIGZyb20gdGhlIHNpZ3NoYWRvdwo+LQkgKiBoYW5kbGVyLgo+LQkg
Ki8KPi0JYmFja3RyYWNlKGR1bW15LCBTSUdTSEFET1dfQkFDS1RSQUNFX0RFUFRIKTsKPisJcmVx
dWVzdF9iYWNrdHJhY2VfaW5pdCA9IHRydWU7Cj4rCWlmIChwYXN0X2NvbnN0cnVjdG9ycykKPisJ
CXRyaWdnZXJfYmFja3RyYWNlKCk7Cj4gCj4gCXNpZ2VtcHR5c2V0KCZtYXNrX3NpZ3NldCk7Cj4g
CXNpZ2FkZHNldCgmbWFza19zaWdzZXQsIFNJR1NIQURPVyk7Cj4tLSAKPjIuNDMuMAoKV2l0aCB0
aGlzIHBhdGNoIGFwcGxpZWQgdG8geGVub21haSwgcmVidWlsZCB0aGUgc3RhdGljIGFwcCB0aGVu
IGl0IHJ1bnMgbm9ybWFsbHkuIFRoYW5rcyEKCkhhaXlhbmcuCg==
