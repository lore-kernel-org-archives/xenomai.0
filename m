Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E217EA
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 07:12:05 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay.mail.gandi.net (Postfix) with ESMTPS id 9B933240013
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 07:12:03 +0000 (UTC)
Received: from mail.sprinte.eu (mail.sprinte.eu [141.95.128.206])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 810247803E8
	for <Xenomai@xenomai.org>; Mon,  3 Apr 2023 07:12:02 +0000 (UTC)
Received: from S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) by
 S1044812.EX793143.lan (2001:41d0:11b:2f00::8d5f:80ce) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 3 Apr 2023 09:14:12 +0200
Received: from S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0]) by
 S1044812.EX793143.lan ([fe80::90d1:6ba3:6aa1:fae0%6]) with mapi id
 15.02.1118.026; Mon, 3 Apr 2023 09:14:12 +0200
From: Julien Blanc <julien.blanc@sprinte.eu>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Subject: Re: flexcan irq error on kernel >= 5.10
Thread-Topic: flexcan irq error on kernel >= 5.10
Thread-Index: AQHZY7NFdD44H6qk8EWTdeY1KHGnnK8UtqCAgAQ7DYCAAByRgA==
Date: Mon, 3 Apr 2023 07:14:12 +0000
Message-ID: <29c222b4f59a8cff033198a0f9c215b52bafbfcb.camel@sprinte.eu>
References: <5ecc6e0045d7fb9e12096b2956b09595cb2f1af0.camel@sprinte.eu>
	 <80f2b734fc44667d2a6f7314d52b118516996958.camel@sprinte.eu>
	 <cd7f3ef0-d8a8-012b-f755-d4fe1d3d13e6@siemens.com>
In-Reply-To: <cd7f3ef0-d8a8-012b-f755-d4fe1d3d13e6@siemens.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [146.247.92.174]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7856D49276ABEC4288B8EE8F5958F2BF@EX793143.lan>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received-SPF: pass (spool4: domain of sprinte.eu designates 141.95.128.206 as permitted sender) client-ip=141.95.128.206; envelope-from=julien.blanc@sprinte.eu; helo=mail.sprinte.eu;
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	spf=pass (spool.mail.gandi.net: domain of julien.blanc@sprinte.eu designates 141.95.128.206 as permitted sender) smtp.mailfrom=julien.blanc@sprinte.eu;
	dmarc=none

TGUgbHVuZGkgMDMgYXZyaWwgMjAyMyDDoCAwNzoyOSArMDIwMCwgSmFuIEtpc3prYSBhIMOpY3Jp
dMKgOg0KPiBPbiAzMS4wMy4yMyAxNDo1NSwgSnVsaWVuIEJsYW5jIHdyb3RlOg0KPiA+IA0KPiAN
Cj4gTm9wZSwgdGhpcyBpcyBjb3JyZWN0OiBpcnFfc2V0X2FmZmluaXR5X2hpbnQgcmV0dXJucyAt
RUlOVkFMIGluIGNhc2Ugb2YNCj4gIVNNUC4gUGxlYXNlIHNlbmQgYSBwYXRjaCwgbWF5YmUgYWxz
byBpbmNsdWRpbmcgdGhlIGludm9jYXRpb24gaW4NCj4geG5pbnRyX2RldGFjaCwgZm9yIGNvbnNp
c3RlbmN5IHJlYXNvbnMuDQoNClNob3VsZCBiZSBva2F5LCB1bmxlc3MgbXkgbWFpbCBjbGllbnQg
bWVzc2VkIHVwIHRoZSBmb3JtYXQgZm9yIHNvbWUgcmVhc29uLg0KDQo+IA0KPiA+IEkgY291bGQg
YWxzbyBnZXQgaXQgdG8gd29yayBieSBlbmFibGluZyBTTVAgKGFsdGhvdWdoIEkgcmFuIGludG8g
b3RoZXINCj4gPiBpc3N1ZXMsIGFuZCBkb24ndCB3YW50IHRvIGRvIHRoYXQgYXMgbXkgdGFyZ2V0
IGlzIHNpbmdsZSBjb3JlKS4NCj4gPiANCj4gDQo+IENhbiB5b3UgZ2l2ZSBhdCBsZWFzdCBzb21l
IGhpbnRzIGFib3V0IHRoYXQgb3RoZXIgaXNzdWU/DQoNCkkgY2FuIHByb3ZpZGUgYSBiYWNrdHJh
Y2UuIEkgdGhvdWdodCBpIHNhdmVkIGl0LCBidXQgYXBwYXJlbnRseSBub3QuIEkgcHV0IHRoYXQg
aW4gbXkgdG9kbywgaSBzaG91bGQgaGF2ZSB0aGUgdGltZSBsYXRlciB0aGlzDQp3ZWVrLg0KDQpS
ZWdhcmRzLA0KDQpKdWxpZW4NCg==
