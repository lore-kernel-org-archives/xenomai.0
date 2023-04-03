Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6917EA
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 07:11:50 +0000 (UTC)
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 3 Apr 2023 09:08:49 +0200
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.1118.026; Mon, 3 Apr 2023 09:08:49 +0200
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: [PATCH] Fix flexcan interrupt request not working on non SMP systems
Thread-Topic: [PATCH] Fix flexcan interrupt request not working on non SMP
 systems
Thread-Index: AQHZZfsjdDeOcYO99kOnMkF9kkGVRg==
Date: Mon, 3 Apr 2023 07:08:49 +0000
Message-ID: <45c60fcea46516061189dbd840c5af889b94a44c.camel@sprinte.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [146.247.92.174]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8663BD5F8410A544B3B60092014CBB4F@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

aXJxX3NldF9hZmZpbml0eV9oaW50IHJldHVybnMgLUVJTlZBTCBvbiBub24tU01QIHN5c3RlbXMu
IE9uIHN1Y2gNCnN5c3RlbXMsIHNldHRpbmcgdGhlIGlycSBhZmZpbml0eSBpcyBub24tc2Vuc2Us
IHNvIGp1c3QgcmVtb3ZlIHRoZQ0KY2FsbCBpbiB4bmludHJfYXR0YWNoIChyZXNwLiB4bmludHJf
ZGV0YWNoKSBpZiBDT05GSUdfU01QIGlzIG5vdCBkZWZpbmVkDQoNClNpZ25lZC1vZmYtYnk6IEp1
bGllbiBCbGFuYyA8anVsaWVuLmJsYW5jQHNwcmludGUuZXU+DQotLS0NCiBrZXJuZWwvY29iYWx0
L2RvdmV0YWlsL2ludHIuYyB8IDQgKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9jb2JhbHQvZG92ZXRhaWwvaW50ci5jIGIva2VybmVs
L2NvYmFsdC9kb3ZldGFpbC9pbnRyLmMNCmluZGV4IGE5NDU5YjdhOC4uODgxMTZjN2M4IDEwMDY0
NA0KLS0tIGEva2VybmVsL2NvYmFsdC9kb3ZldGFpbC9pbnRyLmMNCisrKyBiL2tlcm5lbC9jb2Jh
bHQvZG92ZXRhaWwvaW50ci5jDQpAQCAtMTAwLDkgKzEwMCwxMSBAQCBpbnQgeG5pbnRyX2F0dGFj
aChzdHJ1Y3QgeG5pbnRyICppbnRyLCB2b2lkICpjb29raWUsIGNvbnN0IGNwdW1hc2tfdCAqY3B1
bWFzaykNCiAgICAgICAgICAgICAgICBpZiAoY3B1bWFza19lbXB0eShlZmZlY3RpdmVfbWFzaykp
DQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCiAgICAgICAgfQ0KKyNp
ZmRlZiBDT05GSUdfU01QDQogICAgICAgIHJldCA9IGlycV9zZXRfYWZmaW5pdHlfaGludChpbnRy
LT5pcnEsIGVmZmVjdGl2ZV9tYXNrKTsNCiAgICAgICAgaWYgKHJldCkNCiAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KKyNlbmRpZg0KDQogICAgICAgIHJldHVybiByZXF1ZXN0X2lycShpbnRy
LT5pcnEsIHhuaW50cl9pcnFfaGFuZGxlciwgSVJRRl9PT0IsDQogICAgICAgICAgICAgICAgICAg
ICAgICBpbnRyLT5uYW1lLCBpbnRyKTsNCkBAIC0xMTIsNyArMTE0LDkgQEAgRVhQT1JUX1NZTUJP
TF9HUEwoeG5pbnRyX2F0dGFjaCk7DQogdm9pZCB4bmludHJfZGV0YWNoKHN0cnVjdCB4bmludHIg
KmludHIpDQogew0KICAgICAgICBzZWNvbmRhcnlfbW9kZV9vbmx5KCk7DQorI2lmZGVmIENPTkZJ
R19TTVANCiAgICAgICAgaXJxX3NldF9hZmZpbml0eV9oaW50KGludHItPmlycSwgTlVMTCk7DQor
I2VuZGlmDQogICAgICAgIGZyZWVfaXJxKGludHItPmlycSwgaW50cik7DQogfQ0KIEVYUE9SVF9T
WU1CT0xfR1BMKHhuaW50cl9kZXRhY2gpOw0KLS0gDQoyLjM5LjINCg0K
