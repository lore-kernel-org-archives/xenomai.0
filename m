Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE602904
	for <xenomai@lists.linux.dev>; Fri, 31 Mar 2023 12:53:35 +0000 (UTC)
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay.mail.gandi.net (Postfix) with ESMTPS id D10F11C0011
	for <xenomai@lists.linux.dev>; Fri, 31 Mar 2023 12:53:25 +0000 (UTC)
Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	by spool.mail.gandi.net (Postfix) with ESMTPS id B1935AC1A01
	for <Xenomai@xenomai.org>; Fri, 31 Mar 2023 12:53:24 +0000 (UTC)
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 31 Mar 2023 14:55:28 +0200
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.1118.026; Fri, 31 Mar 2023 14:55:28 +0200
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
Subject: Re: flexcan irq error on kernel >= 5.10
Thread-Topic: flexcan irq error on kernel >= 5.10
Thread-Index: AQHZY7NFdD44H6qk8EWTdeY1KHGnnK8UtqCA
Date: Fri, 31 Mar 2023 12:55:28 +0000
Message-ID: <80f2b734fc44667d2a6f7314d52b118516996958.camel@sprinte.eu>
References: <5ecc6e0045d7fb9e12096b2956b09595cb2f1af0.camel@sprinte.eu>
In-Reply-To: <5ecc6e0045d7fb9e12096b2956b09595cb2f1af0.camel@sprinte.eu>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [146.247.92.174]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC7E4352F7F6C649928A540C51EB0B4D@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received-SPF: pass (spool3: domain of sprinte.eu designates 141.95.128.206 as permitted sender) client-ip=141.95.128.206; envelope-from=julien.blanc@sprinte.eu; helo=mail.sprinte.eu;
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of julien.blanc@sprinte.eu designates 141.95.128.206 as permitted sender) smtp.mailfrom=julien.blanc@sprinte.eu

TGUgdmVuZHJlZGkgMzEgbWFycyAyMDIzIMOgIDA5OjI5ICswMDAwLCBKdWxpZW4gQmxhbmMgYSDD
qWNyaXTCoDoNCj4gSGkgYWxsLA0KPiANCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhlIGludGVycnVw
dCBpcyBub3QgZW5hYmxlZCBhdCB0aGUgaGFyZHdhcmUgbGV2ZWwsIGFuZA0KPiBmb3Igc29tZSBy
ZWFzb24gdGhlIGRyaXZlciBmYWlscyB0byBlbmFibGUgaXQuDQoNClJlcGx5aW5nIHRvIG15c2Vs
ZiwgaSBjb3VsZCBnZXQgaXQgdG8gd29yayB3aXRoIHRoZSBmb2xsb3dpbmcgY2hhbmdlOg0KDQot
LS0gYS9rZXJuZWwvY29iYWx0L2RvdmV0YWlsL2ludHIuYwkyMDIzLTAzLTMxIDE0OjQwOjE3LjY0
MDEyNzU4MA0KKzAyMDANCisrKyBiL2tlcm5lbC9jb2JhbHQvZG92ZXRhaWwvaW50ci5jCTIwMjMt
MDMtMzEgMTQ6Mzk6NTkuMDQ4MzQxODQyDQorMDIwMA0KQEAgLTEwMCw5ICsxMDAsMTEgQEANCiAJ
CWlmIChjcHVtYXNrX2VtcHR5KGVmZmVjdGl2ZV9tYXNrKSkNCiAJCQlyZXR1cm4gLUVJTlZBTDsN
CiAJfQ0KKyNpZmRlZiBDT05GSUdfU01QDQogCXJldCA9IGlycV9zZXRfYWZmaW5pdHlfaGludChp
bnRyLT5pcnEsIGVmZmVjdGl2ZV9tYXNrKTsNCiAJaWYgKHJldCkNCiAJCXJldHVybiByZXQ7DQor
I2VuZGlmDQoNCkkgYmVsaWV2ZSBpdCdzIHNhZmUgdG8gc2tpcCBpcnFfc2V0X2FmZmluaXR5X2hp
bnQgb24gbm9uLVNNUCBzeXN0ZW1zLA0KYXMgdGhlIGFmZmluaXR5IGlzIG5vbnNlbnNlIG9uIHN1
Y2ggc3lzdGVtcy4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCg0KSSBjb3VsZCBhbHNvIGdl
dCBpdCB0byB3b3JrIGJ5IGVuYWJsaW5nIFNNUCAoYWx0aG91Z2ggSSByYW4gaW50byBvdGhlcg0K
aXNzdWVzLCBhbmQgZG9uJ3Qgd2FudCB0byBkbyB0aGF0IGFzIG15IHRhcmdldCBpcyBzaW5nbGUg
Y29yZSkuDQoNClJlZ2FyZHMsDQoNCkp1bGllbg0K
