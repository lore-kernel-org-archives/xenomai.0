Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B35120E1
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 08:03:57 +0000 (UTC)
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 3 Apr 2023 10:06:05 +0200
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.1118.026; Mon, 3 Apr 2023 10:06:05 +0200
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: [PATCH v2] Fix flexcan interrupt request not working on non SMP
 systems
Thread-Topic: [PATCH v2] Fix flexcan interrupt request not working on non SMP
 systems
Thread-Index: AQHZZgMjqinla2hdBkuvBQlkhCETkg==
Date: Mon, 3 Apr 2023 08:06:05 +0000
Message-ID: <2739dd577fde7853b94b9d062033a3f8324ec1b7.camel@sprinte.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [146.247.92.174]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CD3BC6E0056484381A1854D39DB7F5F@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

aXJxX3NldF9hZmZpbml0eV9oaW50IHJldHVybnMgLUVJTlZBTCBvbiBub24tU01QIHN5c3RlbXMu
IE9uIHN1Y2gNCnN5c3RlbXMsIHNldHRpbmcgdGhlIGlycSBhZmZpbml0eSBpcyBub24tc2Vuc2Us
IHNvIGp1c3QgcmVtb3RlIHRoZQ0KY2FsbCBpbiB4bmludHJfYXR0YWNoIGlmIENPTkZJR19TTVAg
aXMgbm90IGRlZmluZWQNCg0KU2lnbmVkLW9mZi1ieTogSnVsaWVuIEJsYW5jIDxqdWxpZW4uYmxh
bmNAc3ByaW50ZS5ldT4NCi0tLQ0KIGtlcm5lbC9jb2JhbHQvZG92ZXRhaWwvaW50ci5jIHwgNCAr
KysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEva2Vy
bmVsL2NvYmFsdC9kb3ZldGFpbC9pbnRyLmMgYi9rZXJuZWwvY29iYWx0L2RvdmV0YWlsL2ludHIu
Yw0KaW5kZXggYTk0NTliN2E4Li44ODExNmM3YzggMTAwNjQ0DQotLS0gYS9rZXJuZWwvY29iYWx0
L2RvdmV0YWlsL2ludHIuYw0KKysrIGIva2VybmVsL2NvYmFsdC9kb3ZldGFpbC9pbnRyLmMNCkBA
IC0xMDAsOSArMTAwLDExIEBAIGludCB4bmludHJfYXR0YWNoKHN0cnVjdCB4bmludHIgKmludHIs
IHZvaWQgKmNvb2tpZSwgY29uc3QgY3B1bWFza190ICpjcHVtYXNrKQ0KIAkJaWYgKGNwdW1hc2tf
ZW1wdHkoZWZmZWN0aXZlX21hc2spKQ0KIAkJCXJldHVybiAtRUlOVkFMOw0KIAl9DQorI2lmZGVm
IENPTkZJR19TTVANCiAJcmV0ID0gaXJxX3NldF9hZmZpbml0eV9oaW50KGludHItPmlycSwgZWZm
ZWN0aXZlX21hc2spOw0KIAlpZiAocmV0KQ0KIAkJcmV0dXJuIHJldDsNCisjZW5kaWYNCiANCiAJ
cmV0dXJuIHJlcXVlc3RfaXJxKGludHItPmlycSwgeG5pbnRyX2lycV9oYW5kbGVyLCBJUlFGX09P
QiwNCiAJCQlpbnRyLT5uYW1lLCBpbnRyKTsNCkBAIC0xMTIsNyArMTE0LDkgQEAgRVhQT1JUX1NZ
TUJPTF9HUEwoeG5pbnRyX2F0dGFjaCk7DQogdm9pZCB4bmludHJfZGV0YWNoKHN0cnVjdCB4bmlu
dHIgKmludHIpDQogew0KIAlzZWNvbmRhcnlfbW9kZV9vbmx5KCk7DQorI2lmZGVmIENPTkZJR19T
TVANCiAJaXJxX3NldF9hZmZpbml0eV9oaW50KGludHItPmlycSwgTlVMTCk7DQorI2VuZGlmDQog
CWZyZWVfaXJxKGludHItPmlycSwgaW50cik7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKHhuaW50
cl9kZXRhY2gpOw0KLS0gDQoyLjM5LjINCg==
