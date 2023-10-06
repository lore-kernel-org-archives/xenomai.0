Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2053.outbound.protection.outlook.com [40.107.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB6525B
	for <xenomai@lists.linux.dev>; Fri,  6 Oct 2023 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doosan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Doosan.onmicrosoft.com header.i=@Doosan.onmicrosoft.com header.b="qWhGJBST"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIJWKXa9jy84y6fkuqNn0nBIRp0le5Lh8TirDIS9I7pcC9g5h4s9LEL3nrKmXf5it0e7IbG6S3G4nmmonI0IznTLhp6eg5cxuxm6y3uwoo2SvC4YXlPCLR3nJwfiYN8Jf8/LFYvSajdAEonUeXrVaWI1DdiZ+V3o1cpoh9UNzTSAyzNLsCKiOwAqOekwijEagsb/9rGsk5eH2ojgy6wUwm3kdYHaznXzKEsJUPgbTsBxJP6BQOn6zzp6qU3mJWa2NfAoG70BzEFfMQqP7VGV3/58GyK5lgEoSj7lIdu2zS18Sg/voL/24nBLD8TQqBrElkGWxo8H4AvVRMDINGxEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWSTOVSf52ju44HD3JzWRmvlN98PANNR6h8dSTSUc+Q=;
 b=PRWHostQmgLNLO41G8txGyEGYP2VRsMkiH6VW3lN6orp60w5S6QeTdTPeIRVwU2AS9hQSLAlmU02uVv8EWe2XLwuS0PR9HovDdM4V0aZLzanQI1CPWMmvwDbETbc4TZQn5Z+DWkx6EfUYCQFiY3o2zXdPnt9DrVxXWUyvtXoq8RsRE+KbgAR9vbr2b00wHlNKrol9iBA8MhnelYVu0YSTxy2OUbs2sUrA+NK1UNS7F4pGaNm6z/Su2uyr2peVioF0LbjFSQyj3BtHkwJ6vN+yKRIaGqekpy3Bs0UteNRqP6ErQ81j6EHRY6Do0XR1x4Ym1ewYjpEEKCUhmMW82a4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Doosan.onmicrosoft.com; s=selector1-Doosan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWSTOVSf52ju44HD3JzWRmvlN98PANNR6h8dSTSUc+Q=;
 b=qWhGJBSTio0pkwHMZ1/gVcjErOa92CCyiKqWwX82gW6LzFNlF2wCkGjrQB5TuHCHOsx0NkJSYzcJaWXwVtXsPMnyS0CiCKhR56+xX9IHxPuIgQbpZqhhDnKf+iIgJDW7v332tneevefeibBx/+f8VSnvtV31LHxvJrVJYRXa1lQ=
Received: from PS2P216MB1330.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a0::13)
 by PU4P216MB1372.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 06:54:09 +0000
Received: from PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
 ([fe80::6640:c09:44b8:e506]) by PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
 ([fe80::6640:c09:44b8:e506%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 06:54:09 +0000
From: =?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?utf-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Thread-Topic: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Thread-Index: AQHZ8Dvh6PD2J1eeWE61B2j5eRG+6bAsl5qAgAAOhXCAAAmgAIAPsMlw
Date: Fri, 6 Oct 2023 06:54:09 +0000
Message-ID:
 <PS2P216MB1330EB1FD1896D2A239CBF25D1C9A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
In-Reply-To: <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doosan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2P216MB1330:EE_|PU4P216MB1372:EE_
x-ms-office365-filtering-correlation-id: 3c8468bd-7480-4de8-e932-08dbc6390a8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PkZa2qiaxG+pMbQpzPlWe0wUDa9+ULBq5gq0mIcQ1YH4d+PDxHisAO0Lu4zvbUEi1D8hs9J17CYtzkXDAPGkMWVvtmNvguD1yI75y1IbNElXQpq6Ei/iFuK+vHVxrJWheWagt+Gt2Q8hHLHDr9S4fd5lR3JW/y5xtk9mlFbWD9HGipbZ4Pzsrjpe+1UdDTBMPj3+nI8b2y7zOOnEE0eWW212tk0q23uFlLLZZCNM1XxMGMNKigRyMZptmniubzZk0PSC1UW0EXAbBMfS7fRUYuglPZWI+FqRFAlWnaTzNYNGMBNLJJHDs49HogdO4uNCrbIO0iaaQxEcnZYF0fbmTkH0TnU8j7YxXL3uymhw8hUJ5MsIBTsQXusDo1GYNOStvDR79duicTrOKulcw3gwivPqJ9w3y2VEgPNOYnuQy7+lGJ8xzjn95tDZinCD56YnOkOK/vbZ46bh1tyBmT7kaNr1CsgO9g1v2hFbSaZ75jefjBWUuZMR87zb9zjRpaktw9K3cSPDgiPllz5/o22g2X9E0SKDjnBVagmkwSGUG1rhr8Ubd0tMFA4BerGNuf8I8Vfej2C+QWOkaulmYH0SDFMkMyfE6Lv9S52uqABk2xM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2P216MB1330.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(84040400005)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(71200400001)(7696005)(6506007)(53546011)(478600001)(38100700002)(966005)(9686003)(41300700001)(2906002)(26005)(8676002)(66446008)(8936002)(6916009)(4326008)(52536014)(66556008)(64756008)(76116006)(5660300002)(66476007)(316002)(33656002)(83380400001)(66946007)(86362001)(38070700005)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2RlVHh6YWo5V2tPTzc3S253SjZodUZ5bUxIL2dETzJrK2xFaXZQNjZtc1VB?=
 =?utf-8?B?aE00dFAwVXV6N1VFdE9PbnJWblhidGtuR2Q1ZUQ3bGhiTzZuc0Noc2dicXZ0?=
 =?utf-8?B?dDNvL3B4UG1NN1I5ZjExQ21pMGY2aFZMNC82VHlNaWRadUlrUG5JeE9RdEsz?=
 =?utf-8?B?RzJ5c1pyZDJpSGx3MXVKc1FHUmtYUk1GVmdFaFo2a2lVZUNCZEI2NWg5SEpD?=
 =?utf-8?B?QzlSRFNsbDhwZlhSTE15d1p2dS9QcHV0YmJEampLeHNBbzJzSFpQc0k1UStO?=
 =?utf-8?B?RTI4R0JJc0FUUjI1MEJ1RFlUT3VsS0NqeFFnSTRjcjdybGI1M0tEUUkrTmx6?=
 =?utf-8?B?SmhnS2VKU0ZqTjhkT3lLUE9FN0lQclFXWUxEQ2twVk5VTmhBTVhLUzJUNlBT?=
 =?utf-8?B?R1FCbGMya1M1MmRsL0dPdjUwQTBScWNoL0dUbW12NXIzTnhqK3RPczlPYnVx?=
 =?utf-8?B?WE91ZDA5QzdSQncxdFN5SGpTRmVnS3BDL3ptWlVOemlxUXhCeTIwQ1RSL0Vx?=
 =?utf-8?B?ckNxZjlaejluYXIzVFFvY1VuVE1La0lCQzcvbzZadjd3QjVNWVZtMTI1K045?=
 =?utf-8?B?c29QbkNoSnNFc2tKVzBQYlJoK3cxS3pHdTdaSTVaZ3JKRlA4VEF0K2xoeGhl?=
 =?utf-8?B?UFVwYUl3TEpsK3E3WmNoS1hFMXpjUDQ4eEhNN1FGd1BGU3N0RUNleVZEUTZ2?=
 =?utf-8?B?Ny9PK1BxTmhLZ1hxZUtqSVBHVUhMaGFsQ0Vsc0NCWkZ4WVBmWSszMEJFRk10?=
 =?utf-8?B?a3BsRjFpN0xBYjhzSnJrMnJTM3k4QUVzNkJET1daWFBNU2Z5OFhYVDduVDBL?=
 =?utf-8?B?Z0Jkc1BUZDdLTmhLU0t2ZkgzTS8vSnVMOXRrWEplUEdEVWFBZHhyUTFvZjBX?=
 =?utf-8?B?ZU1hRkxVbkF5eWU1M0hQVVBCZ2g5K0tmaDk4bVBLd2NRYjBQNTJRSVlHVkIr?=
 =?utf-8?B?Y3B3TERzOElKeE11dEJFWFFlUHptcmN0eHlwNC9IMmE3MmhRTkFRWjlqbGJL?=
 =?utf-8?B?ZWVHb1FrRmc1UkNpSzJtT1MweDJ3ZHkvc2ppZVJiREYxY2RVVmE4ZXpiVS9l?=
 =?utf-8?B?YUxRMEx5cWV5MU5MUHJVbm85THl4OGVZOUtLcUgxSEZqb1M2MlJvcTVPMjZw?=
 =?utf-8?B?TDQ3UUovbFRTbXl6U3d4bWdxZEZQd0V5ZWZQWXpZbTVSRkxKZ3hQQlJFeENI?=
 =?utf-8?B?bkgwVCtMNXpYbEN4REVZYlZJWENZRElBZm5LOWxTUC92azd0Rmd6VS82bHZB?=
 =?utf-8?B?aFhNMkhtRnB5Z0xsZ254Ums2REJqOWJSVHF1RjRCeS9HclNkNHlTQkdlWVgr?=
 =?utf-8?B?NUUySC9zWkE2UVlCRnd4WE9TcWZJRnl4aFI0UkNiUXJYd0xTeWJVV0FIVHVo?=
 =?utf-8?B?OXc1a1l2VkpiWWw1Z3ZXa0gwNkZ0d1U2UFRlcjZrUGdZOGdoL1ZBSjN3cVlq?=
 =?utf-8?B?VXorR3RKSTBRaEozQW9BSlY4N2YwcHlNbTBKOGtOQW1IYXM3b284RUNDVnMx?=
 =?utf-8?B?UkJJSkFpNnJ0a0Yzc0ZGenQzNVc4d1c2QmpvVEtjazZyNHdwK05VNU9razBx?=
 =?utf-8?B?U0FGQUZENFhiYXZTRzBRY3FUaTV3andhRDc3UERBRnVwSTRBbGIzeE1ISTQv?=
 =?utf-8?B?czZHbzY5UHlTWXFLaGR1Rm1BUFZYNFRjTlV1NldJdFVsamlPZERiTzdZNVVJ?=
 =?utf-8?B?RGR3NTUxVnFMZHVIUVBwRTg1NWtRTFdvUDRFU2VQbTl5NzlYWmsrdGsxSno2?=
 =?utf-8?B?N3hHZXYwS3hBUVFwQ2hnRWpYQng1d3RTU214VHdPQzArOW9LM0xsY25mYVBl?=
 =?utf-8?B?S25ZcTVldko0cmtnZkJ0QkJ6MFlHeHpjWFQ0L3dRRVVIOUVWZmVrU0FoRS9V?=
 =?utf-8?B?eWkwVi9iWW1DdG5mTUhLY05MVjZZV2puem1PS1NxeHplMUdKRVRrbCtMYXBy?=
 =?utf-8?B?dTJIOFYzaU5vMEpxczVzRklPVldaandUdENKaGV4RWw2OXd3aTZLbFlPaDZJ?=
 =?utf-8?B?UkZMK01ONUpySHdNS01JNW9ldGVZc3pEVUMvdUhOeWtXdmNjb003WllMZFN5?=
 =?utf-8?B?K244czNOWUZCVXNrOXZrczJJREJTcjV0T3FYSEc5QkxNVVdWa29JVWRuY0ZT?=
 =?utf-8?B?VnU3VXN5ZC9VUHZsb0VnLzZaRWtVMmUyYVUwa1diS2Nsd2VCTjdwb3ZDSWN5?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: doosan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8468bd-7480-4de8-e932-08dbc6390a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 06:54:09.5268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SAzLPy6wla0bVa0A3goLthQ1TwYAOkJBo/WhG34QfDS7CIZWWDyPgM8SRMlrt13JXyYuw9rh5ooTbbY1w6NDkDE2vLIyLm86YzUzhJaNQgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1372

SGVsbG8NCg0KSSBzb2x2ZWQgc2VnZmF1bHQgaXNzdWUgd2l0aCB5b3VyIGhlbHANCg0KQXMgeW91
IHNhaWQsIEkgcG9ydGVkIHhlbm9tYWktc3RhYmxlIDMuMS54IHRvIGlwaXBlLWNvcmUtNS40LjI1
NS14ODYtMTUNCmFuZCBubyBzZWdmYXVsdCBvY2N1cnJlZCB3aGVuIGV4ZWN1dGluZyB0aGUgc2hl
bGwgY29tbWFuZA0KDQpCdXQgSSBtZXQgYSBuZXcgcHJvYmxlbSB0aGF0IHhlbm9tYWkgdGFzayB3
YXMga2lsbGVkIGJ5IHhlbm9tYWkgd2F0Y2hkb2cuDQpUaGlzIGlzc3VlZCBvY2N1cnJlZCBhYm91
dCAyMCBob3VycyBydW5uaW5nIGFmdGVyLg0KDQpJIGNoYW5nZWQgd2F0Y2hkb2cgdGltZXMoNHNl
YyAtPiA5c2VjKWluIHRoZSBrZXJuZWwgY29uZmlndXJhdGlvbih4ZW5vbWFpIGRlYnVnIG1lbnUp
IGFuZCByZS10ZXN0ZWQgaXQuDQpCdXQgdGhlIHNhbWUgcGhlbm9tZW5vbiBvY2N1cnJlZC4NCg0K
SGF2ZSB0aGVyZSBiZWVuIGFueSByZXBvcnRzIG9mIGEgc2ltaWxhciBwaGVub21lbm9uPw0KDQpQ
bGVhc2UgYWR2aXNlIHRvIG1lDQoNClRoYW5rIHlvdQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4gDQpTZW50OiBU
dWVzZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjMgNDowNyBQTQ0KVG86IOuwleqyve2biChLeXVuZ2hv
b24gUGFyaykg7IiY7ISdIOuRkOyCsOuhnOuztO2LseyKpCA8a3l1bmdob29uMi5wYXJrQGRvb3Nh
bi5jb20+OyB4ZW5vbWFpQGxpc3RzLmxpbnV4LmRldg0KU3ViamVjdDogUmU6IFNoZWxsIGNvbW1h
bmQgc2VnZmF1bHQgb2NjdXJyZW5jZSBwaGVub21lbm9uIHdoZW4geGVub21haSB0YXNrIHN3aXRj
aGluZyBydW5uaW5nDQoNCuyjvOydmDog7J20IOuplOydvOydgCDsmbjrtoDsl5DshJwg67Cc7Iah
IOuQmOyXiOyKteuLiOuLpC4g66eB7YGsIO2YueydgCDssqjrtoDtjIzsnbwg7Je0656MIOyLnCDs
o7zsnZjtlZjsi5zquLAg67CU656N64uI64ukLg0KDQpDQVVUSU9OOiBUaGlzIGVtYWlsIGlzIHNl
bnQgYnkgYW4gZXh0ZXJuYWwgYWNjb3VudC4gUGxlYXNlIHRha2UgZXh0cmEgY2F1dGlvbiB3aGVu
IGNsaWNraW5nIHRoZSBsaW5rIG9yIG9wZW5pbmcgdGhlIGF0dGFjaG1lbnQuDQoNCk9uIDI2LjA5
LjIzIDA4OjM1LCDrsJXqsr3tm4goS3l1bmdob29uIFBhcmspIOyImOyEnSDrkZDsgrDroZzrs7Tt
i7HsiqQgd3JvdGU6DQo+IEhlbGxvICENCj4NCj4NCj4gSSBhbSBoYXZpbmcgZGlmZmljdWx0eSBk
ZXZlbG9waW5nIGEgeGVub21haSBhcHBsaWNhdGlvbnMgaW4gdGhlIGxpbnV4IHN5c3RlbS4NCj4N
Cj4gVGhlIHhlbm9tYWkgYXBwbGljYXRpb24gaXMgaW1wbGVtZW50ZWQgdG8gY3JlYXRlIG11bHRp
cGxlIFJUIHRhc2tzIGFuZCBwZXJmb3JtIHRoZWlyIHJlc3BlY3RpdmUgZnVuY3Rpb25zIGJ5IHN3
aXRjaGluZyBiZXR3ZWVuIHRoZW0uDQo+DQo+IEhvd2V2ZXIsIGEgcGhlbm9tZW5vbiB3YXMgZGlz
Y292ZXJlZCB3aGVyZSB0aGUgbGludXggc2hlbGwgY29tbWFuZCANCj4gY3Jhc2hlZCB3aXRoIGEg
c2VnZmF1bHQgd2hlbiB0aGUgeGVub21haSBhcHBsaWNhdGlvbiBydW5uaW5nIChlcnJvciANCj4g
bWVzc2FnZSBpbiB0aGUgL3Zhci9sb2cva2Vybi5sb2cgOiBwc1sxNDkzNDQ1XTogc2VnZmF1bHQg
YXQgMjggaXAgDQo+IDAwMDA3ZjE4ZmI5NTUzMDQgc3AgMDAwMDdmZmU2YTc2ZmI1MCBlcnJvciA2
IGluIA0KPiBsZC0yLjMxLnNvWzdmMThmYjk1MjAwMCsyMzAwMF0pDQo+DQo+IEl0IG9jY3VycyBp
biBzZXZlcmFsIHNoZWxsIGNvbW1hbmRzKHBzLCBzbGVlcCwgYXdrLCBncmVwIC4uLikgYW5kIHRo
ZSBzeW1wdG9tcyBvZiBzZWdmYXVsdHMgYXJlIGFsbCB0aGUgc2FtZS4NCj4gKG9jY3VycmVuY2Ug
bG9jYXRpb24sIG9jY3VycmVuY2UgbGlicmFyeTogbGQtMi4zMS5zbykNCj4NCj4gSWYgdGhpcyB4
ZW5vbWFpIGFwcGxpY2F0aW9uIGRvZXNuJ3QgcnVuLCBpdCB3b24ndCBoYXBwZW4gYXQgYWxsDQo+
DQo+IFdoZW4gSSBjaGVja2VkIHdpdGggR0RCLCBpdCBvY2N1cnJlZCBhdCAiVEhSRUFEX1NFVF9T
VEFDS19HVUFSRCANCj4gKHN0YWNrX2Noa19ndWFyZCkiIGluIHRoZSBnbGliYydzIHNlY3VyaXR5
X2luaXQoKSBmdW5jdGlvbihlbGYvcnRsZC5jKQ0KPg0KPiBJIHRlc3RlZCB3aXRoIHRoZSB4ZW5v
bWFpIGRlbW8gcHJvZ3JhbSgvdXNyL3hlbm9tYWkvZGVtby9hbHRlbmN5KSBpbnN0ZWFkIG9mIHRo
ZSB4ZW5vbWFpIGFwcGxpY2F0aW9uLCBidXQgdGhlIHNhbWUgc3ltcHRvbXMgb2NjdXJyZWQuDQo+
DQo+IEkgZG9uJ3Qga25vdyB3aGF0IHRoZSBwcm9ibGVtIGlzKHhlbm9tYWkgcG9ydGluZywgeGVu
b21haSBhbmQgbGludXggDQo+IGtlcm5lbCB2ZXJzaW9uIGNvbmZsaWN0LCAuLi4uKQ0KPg0KPiBJ
IHJlYWxseSBuZWVkIHlvdXIgaGVscC4NCj4NCj4NCj4gIyMgTm90ZSAoZW52aXJvbWVudCkNCj4g
eGVub21haSA6IHhlbm9tYWktc3RhYmxlLjMuMS54DQo+IGtlcm5lbCA6IDUuNC4yMDgNCg0KWW91
IHdhbnQgdG8gdXBkYXRlLCBzcGVjaWZpY2FsbHkgdG8gaW5jbHVkZSBpcGlwZS1jb3JlLTUuNC4y
NTUteDg2LTE1IGJlY2F1c2Ugb2YgWzFdLg0KDQpKYW4NCg0KWzFdDQpodHRwczovL3NlY3VyZS13
ZWIuY2lzY28uY29tLzFBSW1weE01MHNuUW1aOFl6WlF6MlhsVjRXZTFPTnVkUldROVBvUWE3WF9h
RzRkUmhYaDAwSEREQkpBcGpkLUN2YUFtbWF4cmxLNHdzbHJBdFNfRHU5X09OeEdmUGtFaVR3a092
T1Iyb1pLRmR0SEpNT0p1V1JJQnNRQktBSzEyN05PbUVoYkY0d0loQ1Q0M21tMGpXdlFGUWhlTjlB
dDdEd1pDSHRWLU8ydF9TOU9qendLTThPQnRXR0JhQ3JhdHZSQnU0emFoQmkzYmV5dV9QVnJlZ0g2
R1RqdmtDallQMjRqQ1dfTmJ0VF96SXd5RXRVeXBhZGJpN3NQYmxudXp0OTRxMDctMTUwUUxoNVU1
QlBOQ3dpbnN5eTdYOGxWeVBNVkh2R1VFZW9HeHgzR0ROMlFHcEpwcFg4enlPaHVHeDk5MFVkQzJj
a29mUG04TUZQUDlybWcvaHR0cHMlM0ElMkYlMkZzb3VyY2UuZGVueC5kZSUyRlhlbm9tYWklMkZp
cGlwZS14ODYlMkYtJTJGY29tbWl0JTJGMmM3YTUyY2EwNDU2NmM2YTI3ZGQ5OWJiOWVhODExMDdi
OTg2YzQ5ZQ0KDQotLQ0KU2llbWVucyBBRywgVGVjaG5vbG9neQ0KTGludXggRXhwZXJ0IENlbnRl
cg0KDQoNCg==
