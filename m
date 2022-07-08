Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2134.outbound.protection.outlook.com [40.107.22.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BECF7EB
	for <xenomai@lists.linux.dev>; Fri,  8 Jul 2022 07:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byib5HUnRpEMIYr56vTmFhpr8MGrZRvLQO1CwGzxEm1HqGVtf3bYhtdZW4dRNdArriPJ+FBdXy7Ztc0R+e6xlCdWFAUHvJIHoMQCCEPTJIYPpFUgKaWvg8xxKCKkPx6msBYPSy6VFXGSOVnjsXWIjRDJXO8bevHR8UfOWdEhCbS/ZfU5O9bU8q3xX3Xh8L6Wg+W4VOdmwxtnBLO1SIJAZM5tijU0P/3K4WH89Bwtid+KIK/b/JYihasLS4yoQJKUmXFK6LboNiUGNiRnsn3+1bkClRX14HqCk5wzdv79baqUTcYOCubB6PrORokjMJZHGcv/LnKt49qMUscF5Ihxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33/XvcTBVZ9E23OCwL75lj2KhsexlVuJ1/Z/AhIddtI=;
 b=NPulnLwBmZMXD8C6uvNT1UJeB4x5VpNGKwaFMqXZL8y9y1ESQMm91OOfIAa8WYBCPgnGpBCCPNB/Qg120vzfhyH+H/R5jgrVPKDrK4YNKtfuzc6aIcfIax8GPJK5RlTGAut+JYeEhylDV3eyrihZEGjvluPN3FPj94HHbpoNiYnEWK4t9wE99KQENNM+STESmTIR9Ai22HNHTsj3VfkUF3lnTF2vdeyMkqE0HX+8aDJ4uLGgT9rXRy8uvMsM2EnHEE/LRgSI4ME4TO4b3svM/XQzU24sUMI5RwvG2yFOnHcgWOD7zcqKemB9vUnpzKEtMJi1PmGg90vIfyYPeSS4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33/XvcTBVZ9E23OCwL75lj2KhsexlVuJ1/Z/AhIddtI=;
 b=sopcK5EGFD7PlPGU6eQBdqLhxOPaUtIhOXsya9uL2Ph2aw+8TCNkaI4Iy8t5FgsjMkK1JeJb38rRQ2qs6mX0+2gKTE8chOqiujOCw5UxPp8q43/MBdE+37kEkUtz4TlS2j+g4e9wx5oQhGlyaWOYYQBS53jTrMrfIRq9mrow2sg=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by DU2PR08MB7285.eurprd08.prod.outlook.com (2603:10a6:10:2d4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 07:24:22 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::9978:7089:d0f:b288%5]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 07:24:22 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [PATCH 0/3] prove of concept
Thread-Topic: [PATCH 0/3] prove of concept
Thread-Index: AQHYkgnbkB/UFS5bDU2Bm0KbKVBupq1zBboAgAELeKA=
Date: Fri, 8 Jul 2022 07:24:21 +0000
Message-ID:
 <VE1PR08MB4909D9304E1F605F4E70A42F92829@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20220707135952.5171-1-johannes.kirchmair@sigmatek.at>
 <ca02628e-3cb5-727e-0ecf-40046963bc83@siemens.com>
In-Reply-To: <ca02628e-3cb5-727e-0ecf-40046963bc83@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 588544e4-e656-41d8-88dc-08da60b2e0e4
x-ms-traffictypediagnostic: DU2PR08MB7285:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kWZ8ZfS3XCy7ETHqpmhMYXMVa1Yyo0LsgTIvQG8YJbD0xO0opBtq06fGDjL8npd9/93oiJbstg2z5c7hTC86ONh83ia6B5Fy4G4LE0WFCeqThNVCeX88UO4YubnO3A5vr9MzfzeQl4rratsa6eE3jlCFbwQJwvR0mVm0CKXCQzIBXBAfzJYnyarWiLqe/V5tVbgAkm4JgUdZc/NLCJ34XbaIrqNbYMJNprPjuvUJoQq7RqttsX4JgE1RatjhagDRYOX0KmlHGoMR+9xdNGSphd5R/OEgUri7B2Rhe2fxPF5e5QA4cAulduuWAX8NZdZFkhHNzAb16XUCNkyNSav4rsv3LyiZIZaveRNnA1jORW1kAgP1XIcKRTM7XKxS8Q+N3LJT3Nr32RMwuprDUnamlECJm9xBeqtS2oJ88mMwBTz0oqwEhVTMrQ7YKRY/s/bdy0Jq1Vj0EnJqbOyA+wQxk/sYvzfihpyYz3bC4tS+3fqHAe2Y1XiYb1gRN7Rk4iPXxmoyYmLHqNdowa3/1GxeVNh7OUPiILf9UHbi2uO7XsM3vCdcWaZFOGEQmFexcwT7ryDamgf5IIE0Zd3Zda/6QAS/z3rEWHhKl9alioZJssT+wtQ0ek/Tei9ty/Ryko3js3On5DJzmMo2My5INI2TUfSErB0VUHJSVMJfwiKd8czDEyGXxNtA1c6DO6nFT5j5kDjScBYQOlWzVP5FAl6M2Z1TQuHfCgPV0+BPZ2+L1QI3zSOSt8nDw54/5S/lumr0/wZx7n+cPgWfr5Fq+z1Rrz8yKp+SiicdLjw83TgWQqADeYDszpiPiREjCO/3zhmk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39840400004)(366004)(33656002)(38070700005)(86362001)(38100700002)(44832011)(122000001)(8936002)(52536014)(5660300002)(316002)(41300700001)(2906002)(478600001)(71200400001)(110136005)(76116006)(8676002)(66446008)(66556008)(66476007)(64756008)(66946007)(186003)(55016003)(83380400001)(9686003)(26005)(53546011)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXJiVUJ0SmQ1ZjNHcExNNktjUWdjeVdKNDlrWXNmd0RZWEhHaVM4WlpnZWlH?=
 =?utf-8?B?bFdQbGZQMWoxNmlLeU5OQys1TGNaQk95NW9OSVh1OVVvNEwrR2dkeHdGMm56?=
 =?utf-8?B?bTlRKzhzanI0QWtBd0xaZ1dIQXphWGJDZlRRNlB4R2ZxUGh5TWVRQnZoajVI?=
 =?utf-8?B?azJ2bzU1Tkk5cWFpVnpFWXFkVkdGeDBTWGU1cVpXVUlXRXJ4eGd0R1BTN1VO?=
 =?utf-8?B?aUVFV09veHgrQlMxb1dONzBnM1hBbFVKYnpQVXZEei9HTGhzZ1c4ZVk4bDJs?=
 =?utf-8?B?NHN6dVg4Unk5N2FJRWd5OG1uQWUyci8zWGFyVm5YN3BML2xBejlJK2JBZUE4?=
 =?utf-8?B?YnlIQzZZUDNSNDZselcvd3hkV2pNU0RrTkMxMHJKSjNYRmtHbU5sdlc1Y245?=
 =?utf-8?B?dlJmRXE0byt3VUxWZVd4bHptdk5MKzkvR0doc3lKMWN6ZWpqZUpJbjZkeFA5?=
 =?utf-8?B?bmNnNk5oa0RudUsvd1lOTTQwWXNNKzJVVVoxRXVhSk5jRHljTmU5NEQrT05x?=
 =?utf-8?B?eUx6TWVMb243UW9lM1hLVFd1SElZdDhobG5MWWFPNWlpVlZOd1c3bkxKQ3BX?=
 =?utf-8?B?YWtaTElmMFBzcWdGZ2N0RmppNGkwYW12dGp2U0NMK3Y0NENreW1jbkZtWmd1?=
 =?utf-8?B?ay9CajhVWXdZYnFqSVFKNHJ4b3Avbkc4T3pQcnNhcjZhN2J3SXdiZFA2Q3Vm?=
 =?utf-8?B?WGFVMjdTMFVWZlQ1eWZnclhRUlNxVlNNMWZMaFNDNDBVand5ZHRwMUc3akl0?=
 =?utf-8?B?aysyaGxQSnV0LzBZMnZqYjZYNEUwOU1oZzNsZVdSQXYyR0JzVk1kVzBXS1dS?=
 =?utf-8?B?UHg2M3d2QmZtWXZBRlB3NVZ4RVdMWVVZbzNDcm0wNlAram9TaENlTUNjdjAz?=
 =?utf-8?B?dkNaUGFmRHdUTG9rUDgvWXNEOXZRTlpJb2JQYURid1cvc2N3RWRwU3hBRVRn?=
 =?utf-8?B?c3ZjZEJMZHBrYWtVWjkwQk55ZFNXNE5QRDFPa1EydmVELytSQ2FtK1JMbEZT?=
 =?utf-8?B?aGhqeEZOT29PYjBCaFVZWDRwUjVIb295SmtoMWUzYmRhSG5PQkpQd1d5bHRD?=
 =?utf-8?B?UUNSUURoYXNXZktqSEh6a1RwZHlTZVNBTFNteG9uZU1rZnNYeG9yS3NKekNm?=
 =?utf-8?B?M2hZaXAxNHEvajZWZ21NdU1KeHRIQWhKQUtiWE9YMGVFODZ5V3JZVzBYZEhW?=
 =?utf-8?B?eDRicElmcUZzLzhWaVNSRWw1Zjk2MVlSOEQ2cFdHcEcyQVkzQm1IQUYwSENC?=
 =?utf-8?B?cENvZjZzeTZOTFRkbllLU3ZBdHFKK3dIZFlBcFlVS1NGVUNYYXZrY1I5LzYz?=
 =?utf-8?B?Rnh0MnlaS3Q1NWVtcjRZMVk5dlIvZUVxYmNRVXJtZWJuc0tXUXh4S3hRazBv?=
 =?utf-8?B?U09yK0NqamhMa0haSDI1RE9oMWQzK0x2eHNzcCtuY0NMNUpJcHdGaEpXY1hE?=
 =?utf-8?B?eUJOUVNKeFgzYVAyT2E0YUJQV3Y0a3RYbVp0QXViN1JjU0xBZUlyR1ZRTW1s?=
 =?utf-8?B?SFRnRXBOZjBZR0hoR0g3YnJ3S3laU0RFNlBhMzQzdjVkQnllT1FIL0h4aVBt?=
 =?utf-8?B?R3JqOExGU29PdUxKZ1ZDTHJpcEJ0YWZFOEZRV1diakZuam5objVvcWxYQ201?=
 =?utf-8?B?ZXUwTmMwcVpFNGk1Lzc2RTIweWNSdEZyeS9EeEZvell4VkpBeTdpelBzUVZC?=
 =?utf-8?B?Rno3Mnh4SjJ2U3hRWTQyUGVyenNQdng1QURVb09CWUxmZlNvbTRldGNSbHI3?=
 =?utf-8?B?QVB1S2oyZlI4dEdZUmR3bnlwNkNHcGE2S1ZlclZFejNIcXkwU01IOHNVVThz?=
 =?utf-8?B?cEV6bHV1WVkzSlhFTS9jQkRHcVhkUnF0OGR3OFFVTXFpWGpIZ0FoUGR1WjQy?=
 =?utf-8?B?KytSeWZMOUdnQXVwaC9ldTR1TlEyTnc5TzR5cDFxeUlPR1l2N1c4Qlc3dFJQ?=
 =?utf-8?B?NHlyYXVFbjV1dGJHTnROcHhxbTd0eDRLOWlKZ2ozQjBZR3UvYWdoN2lTME9N?=
 =?utf-8?B?TUVtR3Raa0dkM3pqeUQyaG1QdUV3eUNvYVFyUzhBaXBxcFB3ZlpDZC9XVEVj?=
 =?utf-8?B?STUwam5NZnRtUm5GQ2U2ZndoYkt4QW9KaGRlajBsSlJ6eVdUUTJweDZZWTZo?=
 =?utf-8?B?eFNucnNMSUhUWVg5OWFSY05lRmh1RjlLdnVxbS9IeEQ3Mmt1WUhTdVNMTk1h?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4909.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588544e4-e656-41d8-88dc-08da60b2e0e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 07:24:21.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTRVfXewsKKMKxZJ1gOx1ZOv/ZCvfsbVZtzUkM8DfqlGYdfQT528v1TppL7Sew5SbjRKXyRHVcm3S0/v4r9KXKnNR1onPZgwI6uWt/kzqow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7285

SGV5IEphbiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW4gS2lz
emthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTZW50OiBEb25uZXJzdGFnLCA3LiBKdWxp
IDIwMjIgMTc6MTkNCj4gVG86IEpvaGFubmVzIEtpcmNobWFpciA8am9oYW5uZXMua2lyY2htYWly
QHNpZ21hdGVrLmF0PjsNCj4geGVub21haUBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwLzNdIHByb3ZlIG9mIGNvbmNlcHQNCj4gDQo+IE9uIDA3LjA3LjIyIDE1OjU5LCBK
b2hhbm5lcyBLaXJjaG1haXIgd3JvdGU6DQo+ID4gVGhpcyBpcyBhIHByb3ZlIG9mIGNvbmNlcHQg
aW1wbGVtZW50YXRpb24gb2YgZXhjZXB0aW9uIGhhbmRsaW5nIGluIFhlbm9tYWkNCj4gcmVhbA0K
PiA+IHRpbWUuDQo+ID4NCj4gPiBJdCBpbXBsZW1lbnRzIGFuIGludGVyZmFjZSBzaW1pbGFyIHRv
IHRoZSBwb3NpeCBzaWduYWxzIGJ1dCB3aXRoIGEgbXVjaCBzbWFsbGVyDQo+ID4gZmVhdHVyZSBz
ZXQuDQo+ID4NCj4gPiBGb3Igbm93LCB0aGlzIGZlYXR1cmUgY2FuIGJlIHVzZWQgZm9yIGhhbmRs
aW5nIGZsb2F0aW5nIHBvaW50IGV4Y2VwdGlvbiAoZnBlKQ0KPiA+IGFuZCBpbGxlZ2FsIG9wY29k
ZSBleGNlcHRpb24gaW4gdXNlciBzcGFjZSB3aXRob3V0IGxvc2luZyByZWFsIHRpbWUuDQo+ID4N
Cj4gPiBUaGUgZnBlIGV4Y2VwdGlvbiBoYW5kbGluZyBjYW4gYmUgdXNlZCBmb3IgZml4aW5nIGRp
dmlzaW9uIGJ5IHplcm8gZXJyb3JzIGluDQo+ID4gdXNlciBzcGFjZSBjb2RlIHdpdGhvdXQgZHJv
cHBpbmcgb3V0IG9mIHRoZSByZWFsIHRpbWUgZG9tYWluLg0KPiA+DQo+ID4gVGhlIGlsbGVnYWwg
b3Bjb2RlIGV4Y2VwdGlvbnMgY2FuIGJlIHVzZWQgZm9yIGltcGxlbWVudGluZyBicmVha3BvaW50
cy4gVGhpcw0KPiA+IGNhbiBiZSBkb25lIGJ5IHJlcGxhY2luZyB0aGUgYnJlYWtwb2ludHMgb3Jp
Z2luYWwgaW5zdHJ1Y3Rpb24gYnkgYW4gaWxsZWdhbA0KPiA+IG9wY29kZS4gQXQgdGhlIHRpbWUg
YSB0YXNrIHRyaWVzIHRvIGV4ZWN1dGUgdGhlIGluc3RydWN0aW9uIGFuIGlsbGVnYWwgb3Bjb2Rl
DQo+ID4gZXhjZXB0aW9uIHdpbGwgYmUgdHJpZ2dlcmVkLiBUaGUgdGhyZWFkIGNhbiBiZSAgc3Vz
cGVuZGVkIGluIHRoZSBzaWduYWwgaGFuZGxlcg0KPiA+IGluIHVzZXIgc3BhY2UuIFRoZXJlIGFy
ZSB0d28gbWFpbiBhZHZhbnRhZ2VzIG9mIGhhdmluZyBpdCBkb25lIGluIHJlYWwgdGltZS4NCj4g
Pg0KPiA+IFRoZSBmaXJzdCBpcyBpZiBhIHRhc2sgZG9lcyBzb21lIHRpbWUgY3JpdGljYWwgSU8g
b3IgaGFzIHRvIG1lZXQgc29tZSB3YXRjaGRvZw0KPiA+IGNvbnN0cmFpbnMsIHRoZSBzaWduYWwg
aGFuZGxlciBjYW4gYmUgdXNlZCB0byBicmluZyB0aGUgSU8gaW50byBhIHNhbmUgc3RhdGUNCj4g
PiBiZWZvcmUgdGhlIHRhc2sgaXMgc3RvcHBlZC4gU2FtZSBmb3IgdGhlIHdhdGNoZG9nLCBpdCBj
YW4gYmUgc3RvcHBlZCBiZWZvcmUgaXQNCj4gPiBzZW5kcyB0aGUgd2hvbGUgcHJvY2VzcyBpbnRv
IGFuIGVycm9yIHN0YXRlLg0KPiA+DQo+ID4gVGhlIHNlY29uZCBhZHZhbnRhZ2UgaXMgZm9yIHBy
b2Nlc3NlcyB0aGF0IGhhdmUgc2V2ZXJhbCByZWFsIHRpbWUgdGFza3MuIEZvcg0KPiA+IGV4YW1w
bGUgY29uc2lkZXIgYSBwcm9jZXNzIHdpdGggcnQgdGFza3MgdGFzazEgYW5kIHRhc2syLCB3aGVy
ZSB0YXNrMSBpcyBvZiBhDQo+ID4gaGlnaGVyIHByaW9yaXR5IHRoYW4gdGFzazIuIElmIHRhc2sx
IHRyaWdnZXJzIGFuIGV4Y2VwdGlvbiBhbmQgaXMgcmVsYXhlZCB0bw0KPiA+IHRoZSBMaW51eCBk
b21haW4sIHRhc2syIG9mIGEgbGVzc2VyIHByaW9yaXR5IHdvdWxkIHRha2Ugb3ZlciBhbmQgY291
bGQgYmxvY2sNCj4gPiB0aGUgaGFuZGxpbmcgb2YgdGhlIG1heWJlIG1vcmUgaW1wb3J0ZWQgd29y
ay9leGNlcHRpb24gaGFuZGxpbmcgaW4gdGFzazEuDQo+ID4NCj4gPiBEaXNjbGFpbWVyOg0KPiA+
IFRoaXMgaW1wbGVtZW50YXRpb24gaXMgZmFyIGZyb20gYmVpbmcgcmVhZHkgdG8gbWVyZ2UuIEl0
IGlzIG1haW5seSBpbnRlbmRlZCB0bw0KPiA+IGJlIGEgc3RhcnRpbmcgcG9pbnQgZm9yIGRpc2N1
c3Npb25zIGFib3V0IHJhdGhlciB3ZSAodGhlIGNvbW11bml0eSkgd2FudCBzb21lDQo+ID4ga2lu
ZCBvZiBleGNlcHRpb24gaGFuZGxpbmcgaW50ZXJmYWNlIGluIFhlbm9tYWkgYW5kIHdoYXQgYSBt
YWludGFpbmFibGUNCj4gPiBpbnRlcmZhY2UgZm9yIHRoaXMgY291bGQgbG9vayBsaWtlLg0KPiA+
DQo+IA0KPiBUaGFua3MgZm9yIHB1Ymxpc2hpbmcgdGhpcywgd2lsbCBiZSB2ZXJ5IGhlbHBmdWwg
dG8gc3RhcnQgdGhlIGRpc2N1c3Npb24hDQo+IA0KPiBJIHRoaW5rIHlvdSBmb3Jnb3QgdG8gbWVu
dGlvbiB0aGF0IGl0IGRlcGVuZHMgb24gSS1waXBlIGZvciBub3cgYmVjYXVzZQ0KPiBvZiAicmV0
dXJuIEtFVkVOVF9TVE9QIiBmcm9tIGhhbmRsZV9leGNlcHRpb24uIEFuZCBJIHN0aWxsIG93ZSB5
b3UgdGhlDQo+IGRvdmV0YWlsIHBhdGNoIHdlIGhhdmUgZm9yIDUuMTAgYW5kIHRoYXQgSSBqdXN0
IHN0YXJ0ZWQgdG8gcG9ydCB0bw0KPiA1LjE5LXJlYmFzZSB0b2RheS4gV2lsbCBzaGFyZSBzb29u
Lg0KU2VlIHRoYXQgeW91IHB1Ymxpc2hlZCBpdCBqdXN0IG5vdywgd2lsbCBoYXZlIGEgcXVpY2sg
bG9vayBsYXRlci4NCg0KWWVzIGZvcmdvdCB0byBhZGQgdGhlIGluZm9ybWF0aW9uIGFib3V0IHRo
ZSB2ZXJzaW9uLiBIYXZlIGJyYW5jaGVkIGZyb20gc3RhYmxlLzMuMS54IGFuZCB0ZXN0ZWQgaXQg
d2l0aCB0aGUgNS40IGtlcm5lbC4NCg0KQmVzdCByZWdhcmQNCkpvaGFubmVzDQoNCg0KPiANCj4g
SmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+IENvbXBldGVuY2UgQ2Vu
dGVyIEVtYmVkZGVkIExpbnV4DQo=
