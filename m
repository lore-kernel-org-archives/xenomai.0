Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.95.128.206
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795507100;
	b=MP5eR/aRjj/lQT8fhLDkDQmmzt4gnMdobkGzTGsf1uboFUJSoMctV9s2L6QxGiMK6tO7
	 R/LjeiJz4KU3I4aK4TF5WAyxDQ7agyB5beF2XNpRyvDnOnLwDFEi5A/0SBOyrZ6DAXi/a
	 sH9OQAklGLmSygGWE5I/AXHO8UTrnycayaFrnbnAQCEYCX92fPAKiqJmehu5f2Ft1mm7w
	 8vDGePp8QDpET1UXlv0MfeiihyvLWyheNj/lttEKiK8WWv8cNHjM1/Fh6cXqLT+J8XL+b
	 cvBu+ZstiZwcViXb6fifail7Vpd5Po3uzqqEdd7aHc2vFe+tRvdYY0Whp85rJHs5ROA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795507100;
	h=DMARC-Filter:Received:Received:From:To:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-originating-ip:Content-Type:Content-ID:Content-Transfer-Encoding:
	 MIME-Version:DKIM-Signature;
	bh=/hxpmF3s7YOcR3wt6ZP5/8CQuMSvJvGH1srpklZtSmo=;
	b=B2IRWaQANz+ZKT8Oo++Gny2/e/To8juZDCYQc1K1fBB7IYE0lXUSGaIKTnLE86yNtbF6
	 kpAabcDKVE40V0n6L1ddt3QyeEwZ58wPDfKwzLhdiJS85OwsF/PRr2Cdc2DaRN4ZmVweP
	 4HKADWDQOlZrWa1hJlSg3+ywRt1JfZcdSuKpFcaqBr5/YkAjUFM5Twj8gItWa45lT/Son
	 YncCCjceDcSagvl8PD0B2vdgJmXe9hgxNUJpJSrKLTc8dL9Rw/E1jmk/qVSlQ0GCtCOvb
	 aB1wf9xeoa0RraJ1LNzqzTmncORkHg9LuaRsKEfSHBSFEAbNgsgHb4D7esj+KlcOROA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sprinte.eu;
	spf=pass smtp.mailfrom=sprinte.eu;
	dkim=pass header.d=sprinte.eu header.i=@sprinte.eu header.a=rsa-sha256 header.s=ovhex803668-selector1 header.b=ZccRz4ui;
	arc=none smtp.remote-ip=141.95.128.206
Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCB606A31E
	for <xenomai@lists.linux.dev>; Tue, 24 Nov 2026 07:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DFCB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sprinte.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sprinte.eu header.i=@sprinte.eu header.a=rsa-sha256 header.s=ovhex803668-selector1 header.b=ZccRz4ui
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 08:58:11 +0100
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.2562.057; Tue, 24 Nov 2026 08:58:11 +0100
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "rpm@xenomai.org" <rpm@xenomai.org>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: Re: [RFC] symbol wrapping for libcobalt
Thread-Topic: [RFC] symbol wrapping for libcobalt
Thread-Index: AQHde4n+LItG+NsfR0yca7L/vWjUJrc8y4eA
Date: Tue, 24 Nov 2026 07:58:11 +0000
Message-ID: <bb6109e28cbd8d8d90a9638644041980e731a22b.camel@sprinte.eu>
References: <877bi3thhu.fsf@xenomai.org>
In-Reply-To: <877bi3thhu.fsf@xenomai.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <11379E65DD51104C90445589313FD025@EX793143.lan>
Content-Transfer-Encoding: base64
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=sprinte.eu; s=ovhex803668-selector1;
 c=relaxed/relaxed; t=1795507091; h=from:to:subject:date;
 bh=/hxpmF3s7YOcR3wt6ZP5/8CQuMSvJvGH1srpklZtSmo=;
 b=ZccRz4ui6OmMBQC4rhUUELCz1Pr2pWjvO8slCggXClbWVAtwxp5Te7W4qwXt3nFDQHPEnPlhcK5M0ITcHaItrD3Vc/570T6bvZBjM6QBdWGT7DC7T/WD0PdJKkr/5+jBFnG6AiWmWx5iCYUd12Z4sjjIvfzYfV41D6ShmoeKivo9b3YmhvwJv8vMncHV5+eMcRSh6Ho7xyAIyvRikFzKizRy9c+uuyhny6njg4baNDZkD/10w33kxO01f68L8lSAm0LiklNwAbIlzWGGpGfzLSxSlQYA+jeVx8d/e/mIGNCx8Q55j76dW4AsnCS7Fd3O974Nl5x/NjP6h3opRVey1Q==

TGUgbHVuZGkgMjMgbm92ZW1icmUgMjAyNiDDoCAyMTozMyArMDEwMCwgUGhpbGlwcGUgR2VydW0g
YSDDqWNyaXTCoDoNCj4gDQo+IFNpbmNlIGl0cyB2ZXJ5IGluY2VwdGlvbiwgdGhlIFBPU0lYIEFQ
SSBpbiB4ZW5vbWFpMyBlbmFibGVzIGF1dG9tYXRpYw0KPiB3cmFwcGluZyBvZiBQT1NJWCBjYWxs
cyB0byB0aGVpciBsaWJjb2JhbHQgY291bnRlcnBhcnQgdXNpbmcgYSBsaW5rZXINCj4gdHJpY2sg
KC1XbCwtLXdyYXApLCBzbyB0aGF0IGFwcGxpY2F0aW9ucyBjYW4gdXNlIHRoZSBwcmlzdGluZSBQ
T1NJWA0KPiByb3V0aW5lIG5hbWVzIHRvIGludm9rZSBYZW5vbWFpIHNlcnZpY2VzLiBGb3IgaW5z
dGFuY2UsIHRoZSBmb2xsb3dpbmcNCj4gc25pcHBldDoNCj4gDQo+IMKgwqDCoMKgwqAgcmV0ID0g
cHRocmVhZF9jcmVhdGUoJnRpZCwgJmF0dHIsIGZvb19yb3V0aW5lLCBOVUxMKTsNCj4gDQo+IHdv
dWxkIHRyYW5zbGF0ZSBpbnRlcm5hbGx5IHRvOg0KPiANCj4gwqDCoMKgwqDCoCByZXQgPSBfX3dy
YXBfcHRocmVhZF9jcmVhdGUoJnRpZCwgJmF0dHIsIGZvb19yb3V0aW5lLCBOVUxMKTsNCj4gDQo+
IHdoaWNoIGlzIGEgd2VhayBzeW1ib2wgYWxpYXMgdG86DQo+IA0KPiDCoMKgwqDCoMKgIHJldCA9
IF9fY29iYWx0X3B0aHJlYWRfY3JlYXRlKCZ0aWQsICZhdHRyLCBmb29fcm91dGluZSwgTlVMTCk7
DQo+IA0KPiBUaGUgc2lnbmlmaWNhbnQgcGFydCBvZiB0aGlzIHdyYXBwaW5nIGlzIHRoYXQgd2Ug
Z28gZnJvbSBzeW1ib2xfeCBpbiB0aGUNCj4gc291cmNlIGNvZGUgdG8gX19jb2JhbHRfc3ltYm9s
X3ggYXQgbGluayB0aW1lLCB3aXRoIGxpYmNvYmFsdA0KPiBpbXBsZW1lbnRpbmcgdGhlIGxhdHRl
ci4NCj4gDQo+IE92ZXIgdGhlIHllYXJzLCB3ZSBub3RpY2VkIHNldmVyYWwgaXNzdWVzIHdpdGgg
dGhpcyBzY2hlbWU6DQoNCj4gW1NuaXBdDQoNCkp1c3Qgc2F5aW5nIHRoYXQgYXMgYSB4ZW5vbWFp
IHVzZXIsIHdlIHNoYXJlIGFsbCBvZiB0aGVzZSBjb25jZXJucy4gQW5vdGhlcg0KaXNzdWUgaXMg
aW50ZXJvcCB3aXRoIGVnIHJ1c3QgY29kZSA6IGkgaGF2ZSBubyBpZGVhIHdoYXQgaGFwcGVucyB3
aGVuIGEgcnVzdA0Kc3RhdGljIGxpYiBpcyBsaW5rZWQgb250byB0aGUgZXhlY3V0YWJsZSByZWdh
cmRpbmcgdGhlIGNhbGxzIGl0IG1heSBkbyB0byB0aGUNCnB0aHJlYWQgYXBpICh0aGlzIG9uZSBp
cyBhY3R1YWxseSBhIGJpZyBjb25jZXJuIGZvciB1cyBmb3IgcnVzdCBjb2RlIGludGVncmF0aW9u
DQppbnRvIHRoZSBydCBkb21haW4sIGFuZCBldmVuIHRoZSBub24tcnQgZG9tYWluIGFzIGl0J3Mg
dW5zdXJlIGhvdyBpdCB3aWxsDQpiZWhhdmUpLg0KDQpXZSd2ZSBncmFkdWFsbHkgbWlncmF0ZWQg
dG8gZXhwbGljaXQgY2FsbHMgZXZlcnl3aGVyZSwgd2l0aCB0aGUgZ29hbCB0byBnZXQgcmlkDQpv
ZiB3cmFwcGluZyBlbnRpcmVseS4gSXQgbG9va3MgdG8gbWUgdGhhdCB0aGUgd3JhcHBpbmcgcHJv
Y2VzcyBpcyB0b28gZnJhZ2lsZQ0KaW5kZWVkLiBGb3IgdXMgY29tcGxldGVseSBkcm9wcGluZyB0
aGUgd3JhcHBpbmcgd291bGQgYmUgZmluZSwgYXMgaXQncyBvbiBvdXINCnJvYWRtYXAgYW55d2F5
Lg0KDQpBY3R1YWxseSwgdGhlcmUncyBvbmUgZmVhdHVyZSB0aGF0IHdlIHJlbHkgdXBvbiA6IGJl
aW5nIGFibGUgdG8gY29tcGlsZSBmb3IgYm90aA0KYW4gUlQgY29yZSBhbmQgYSBzdGFuZGFyZCBr
ZXJuZWwuIEJ1dCB0aGF0IGlzIHF1aXRlIGVhc3kgdG8gZG8gYnkganVzdA0KcmVkaWZpbmluZyB0
aGUgX19SVCBhbmQgX19TVEQgbWFjcm9zLCB3cmFwcGluZyBpcyBub3QgcmVhbGx5IHJlbGV2YW50
IGhlcmUuDQoNClJlZ2FyZHMsDQoNCkp1bGllbg0K
