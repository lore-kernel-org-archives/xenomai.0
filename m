Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4017EA
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 08:02:32 +0000 (UTC)
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 3 Apr 2023 10:04:40 +0200
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.1118.026; Mon, 3 Apr 2023 10:04:40 +0200
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH] Fix flexcan interrupt request not working on non SMP
 systems
Thread-Topic: [PATCH] Fix flexcan interrupt request not working on non SMP
 systems
Thread-Index: AQHZZfsjdDeOcYO99kOnMkF9kkGVRq8ZF8iA
Date: Mon, 3 Apr 2023 08:04:40 +0000
Message-ID: <15a8c3a71d9b2a75611d6d759980db592a60d197.camel@sprinte.eu>
References: <45c60fcea46516061189dbd840c5af889b94a44c.camel@sprinte.eu>
In-Reply-To: <45c60fcea46516061189dbd840c5af889b94a44c.camel@sprinte.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [146.247.92.174]
Content-Type: text/plain; charset="utf-8"
Content-ID: <42D8A9D1C736D64A8CBC4B3496BC54D9@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

TG9va3MgbGlrZSBzcGFjZS90YWJzIGhhdmUgYmVlbiBtZXNzZWQgdXAsIHNvcnJ5IGZvciB0aGlz
LCBpJ20gc2VuZGluZyBpdCBhZ2Fpbi4NCg0KTGUgbHVuZGkgMDMgYXZyaWwgMjAyMyDDoCAwNzow
OCArMDAwMCwgSnVsaWVuIEJsYW5jIGEgw6ljcml0wqA6DQo+IGlycV9zZXRfYWZmaW5pdHlfaGlu
dCByZXR1cm5zIC1FSU5WQUwgb24gbm9uLVNNUCBzeXN0ZW1zLiBPbiBzdWNoDQo+IHN5c3RlbXMs
IHNldHRpbmcgdGhlIGlycSBhZmZpbml0eSBpcyBub24tc2Vuc2UsIHNvIGp1c3QgcmVtb3ZlIHRo
ZQ0KPiBjYWxsIGluIHhuaW50cl9hdHRhY2ggKHJlc3AuIHhuaW50cl9kZXRhY2gpIGlmIENPTkZJ
R19TTVAgaXMgbm90IGRlZmluZWQNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBCbGFuYyA8
anVsaWVuLmJsYW5jQHNwcmludGUuZXU+DQo+IC0tLQ0KPiDCoGtlcm5lbC9jb2JhbHQvZG92ZXRh
aWwvaW50ci5jIHwgNCArKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9jb2JhbHQvZG92ZXRhaWwvaW50ci5jIGIva2VybmVs
L2NvYmFsdC9kb3ZldGFpbC9pbnRyLmMNCj4gaW5kZXggYTk0NTliN2E4Li44ODExNmM3YzggMTAw
NjQ0DQo+IC0tLSBhL2tlcm5lbC9jb2JhbHQvZG92ZXRhaWwvaW50ci5jDQo+ICsrKyBiL2tlcm5l
bC9jb2JhbHQvZG92ZXRhaWwvaW50ci5jDQo+IEBAIC0xMDAsOSArMTAwLDExIEBAIGludCB4bmlu
dHJfYXR0YWNoKHN0cnVjdCB4bmludHIgKmludHIsIHZvaWQgKmNvb2tpZSwgY29uc3QgY3B1bWFz
a190ICpjcHVtYXNrKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNwdW1h
c2tfZW1wdHkoZWZmZWN0aXZlX21hc2spKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPiDCoMKgwqDCoMKgwqDCoCB9DQo+
ICsjaWZkZWYgQ09ORklHX1NNUA0KPiDCoMKgwqDCoMKgwqDCoCByZXQgPSBpcnFfc2V0X2FmZmlu
aXR5X2hpbnQoaW50ci0+aXJxLCBlZmZlY3RpdmVfbWFzayk7DQo+IMKgwqDCoMKgwqDCoMKgIGlm
IChyZXQpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiAr
I2VuZGlmDQo+IA0KPiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmVxdWVzdF9pcnEoaW50ci0+aXJx
LCB4bmludHJfaXJxX2hhbmRsZXIsIElSUUZfT09CLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludHItPm5hbWUsIGludHIpOw0KPiBAQCAtMTEyLDcg
KzExNCw5IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHhuaW50cl9hdHRhY2gpOw0KPiDCoHZvaWQgeG5p
bnRyX2RldGFjaChzdHJ1Y3QgeG5pbnRyICppbnRyKQ0KPiDCoHsNCj4gwqDCoMKgwqDCoMKgwqAg
c2Vjb25kYXJ5X21vZGVfb25seSgpOw0KPiArI2lmZGVmIENPTkZJR19TTVANCj4gwqDCoMKgwqDC
oMKgwqAgaXJxX3NldF9hZmZpbml0eV9oaW50KGludHItPmlycSwgTlVMTCk7DQo+ICsjZW5kaWYN
Cj4gwqDCoMKgwqDCoMKgwqAgZnJlZV9pcnEoaW50ci0+aXJxLCBpbnRyKTsNCj4gwqB9DQo+IMKg
RVhQT1JUX1NZTUJPTF9HUEwoeG5pbnRyX2RldGFjaCk7DQo+IC0tIA0KPiAyLjM5LjINCj4gDQoN
Cg==
