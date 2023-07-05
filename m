Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA7C8F8
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 13:49:48 +0000 (UTC)
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id A3C84240003
	for <xenomai@lists.linux.dev>; Wed,  5 Jul 2023 13:49:39 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on20618.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe16::618])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 7C9187803E4
	for <xenomai@xenomai.org>; Wed,  5 Jul 2023 13:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+kry9/8XOT6AAjfnE9KzkN7+4TqXlx0Iz0RBeO20wCprK62j/bew74ta4q90SST1OWsJtCUky8PDWEP5UzpntCiSMHmbYuqmvayCDD4tMxcPjoCUGqeOKNIUBlDi6rFKb/7H4tNfXrXCLhLChcj4PT1ae3ahqPZ3nGdD48ebfCBkmjdeNXQPH/VJ2WewRVbxWUpxjGnDDyR72NPtB8UWauvUfjnFhXS7TrKmWSqqGmlGZEC+5fXbCkZNr6/7bsmqsIWLnCbYdiuPfC4rhyy3xugQDLFZgaf4/Fk/33KXbzmvCKkyuI5yyHQhzqgUKoK1+nr2zvqJHV7gYA5j+EuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UbDERreuc4rGhMAoqtPd3dqFfelMudY6t/SdTA7zJ8=;
 b=fgwsNjVIeCczGJI2VamSYSOchTHSin762UgCd5Z4QQq9r3IDQQ9ucRGqHoZSAxOnNGZB/X8awhxyW3WzR43Ton05UY5Hrho1KFwE2lZ/YS2C8DrPFzoGt4zsGmcog8uh9a00vHFxiM3n6o2lbuw/TVbGaFdMwcaAJaOa/8rpKVuLxWBrop60s7FH3cuoqaTAWxHslJOIADTa1RaNVnUK+xl26SmhBYqjxkeKsv/UxQBQB2iBAx6RoHm9YSjjEndI5s7EjMvOZpwN5F/u7EKrqfrJVz8HxQDkEP2893x7mkiMlxFowa0UeWnx4b7aW7I5vYb/YLZmX6LJIxPpGKEw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UbDERreuc4rGhMAoqtPd3dqFfelMudY6t/SdTA7zJ8=;
 b=HlPCPbkT2bsPO//cArcu4d3T/rlCk6oik4ou6zA6gewggFaepYgzkewuf7tD2JCGb7sRjFgYo/PIQehlWfyH1YC+jSquuE/dhcGAANskyp0xJRVxP64M4TraFPoEMVLe/Wbx8pQBHibNI2WzRp8v8za67HAjVw1ELdoIpvnuSRjrLkF1WARW0whiSF5G4hdJMD5LsZToXzEe4KkzyL6fp7DUTUwML3nJ5KxF9z5p72IZ1W/dLo0v8+hdZhK2Ssn6tWX8gMBXUkV4H4iEA1OIiTsynBqNKljKuJg4uZQZv3qgnypY7DyDPbpftaFDKkV9VRqdKP16TnL5DhOWhUK0Cg==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by AS2PR10MB7549.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:592::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:49:37 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::340:b481:b8d8:81e8]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::340:b481:b8d8:81e8%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 13:49:37 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>, "johnho26@gmail.com" <johnho26@gmail.com>
Subject: Re: Invalid Opcode
Thread-Topic: Invalid Opcode
Thread-Index: AQHZrpf94T6t8Ry+XUy3Cnt1+V/ZHK+p090AgAFeA4A=
Date: Wed, 5 Jul 2023 13:49:36 +0000
Message-ID: <8c6a3f89253f59cc1ee4e1fe8c6add4708d78697.camel@siemens.com>
References:
 <CAMjL99Lk-QT=vev=3QeeUAjHzfP7X-fCRwJM18OkvTR1V5SRYQ@mail.gmail.com>
	 <d7f6cbe1-ab60-8a85-08bb-0555feacadd9@siemens.com>
In-Reply-To: <d7f6cbe1-ab60-8a85-08bb-0555feacadd9@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|AS2PR10MB7549:EE_
x-ms-office365-filtering-correlation-id: 8595a07d-9101-4d8e-d7a4-08db7d5eac18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 X4WQxAciNK61OfvdH+PQGkkjYdRcIW4kLlh9dXmVoLgDAqd1Wxybj0cmcQJaMnxzWixMrabCPk4poEH45pbmVGHULFCMlSIgkBWUSNmj7i8tpy+VhszQ2OGRvRKZkn7FwrN7U7rVBdJFkAHIS8CIelnMLRwqqphIV61UeMdyDJ737yq76/McmbR1jkXt/QzuQgh6lpULWVGQxie5k9J1m6Dgg8BnqiLceY1mRonqAVFmzEnfCNpLMI4frmvXmjCIpBJCN41SvsiEeVtEu5iB41VjyHYZOrNBd53Zq5Hor+3aWsJM1BdkGD8XhvUaCCWJ6BtDCL0t4w6GODdYREiSxOwRTDVcw18F7caUIEr6rK6slbzCm69HaZmyjKyUTYsgfHIsMYfSmrQFidX8JqUeCGzErkQ8dn3T2aNVIxTaOSv0mj1VemLqxwWTC0pSCLp6zeKDDzyXuRpNYf/Y8dONrEfPPCXjqPmyXwYf8VDTnGGiNuW4vKoCW1TbjylDcrE147mb6EZaakj8Mzdnm+qNiJadpRZXk3sIEu6Ls+EcKN3KwKUYPizKjhKamM5gtJuubyTPsNgQw0+eNnKP8M+FXrBKECNLUyUM5EYrtpJhCXLmGv3Yl3601zGayAiGsKui
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(2906002)(7116003)(8676002)(86362001)(2616005)(3480700007)(66556008)(64756008)(8936002)(5660300002)(53546011)(110136005)(478600001)(6486002)(71200400001)(26005)(91956017)(6512007)(186003)(4744005)(82960400001)(38070700005)(38100700002)(6506007)(122000001)(316002)(66476007)(66946007)(66446008)(76116006)(36756003)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXMzWnRuU2V3RVhCVGttWnBBYTVvbEJ1RFM4QUhCdFFsRUlHL0tKWnlRVlc4?=
 =?utf-8?B?OEJvV21HdDhpOStjb3RjRklqNVRnc3orWUFwUGQyUWFXMFQxZnhjWUhrNCs4?=
 =?utf-8?B?SmIyYWpSZWRheUhaazlJSHlWZmtJckZVRWdFc1pSdDJXem5ITDlRTHk4N2hq?=
 =?utf-8?B?RHBoRXhnUXhzbithbFEvRi9GT2tJdGpOOU96cmJjVUcrdDk0bGNXRCt5QkpT?=
 =?utf-8?B?ejlBcU1ReVd5ak5tT0lySXlxdG9OU3ZnZzRyZ1QzbkNkNXZKN2FBVkd1U1ZE?=
 =?utf-8?B?a3pzNWZwN3VWcE9JcGxaek1mRTZpdEpQdjV3Yk9JeENLaUI4ajlHNng2bWp6?=
 =?utf-8?B?WDZFb1dtUUV4czZ2UGV5MFVZL0I0UE1JK1VHN2RiTU5YSFVRUVBXTGkxWTdq?=
 =?utf-8?B?eXZhejNGaWJrUGFoSENqQ3RGRlpNM0FuVmdGbXhxakIwNlBCakRYMlJBWTNW?=
 =?utf-8?B?UjlBOEpIVTNlYVJXTVo4OE1PMUhlR0hmd0JJdWtQbDk0dFFRb0NpbXpYYXZ4?=
 =?utf-8?B?bkdlNC9XYlVINGI2TWVTVEVHNGIrWkRqUnJxeEdhdWd3MGN3UVoreDRrQ2Zi?=
 =?utf-8?B?aXcwMytoQURnbVhTNklYcnFJcmYwcXZKL29CODdhV28zWFlERUc5YnVPenpD?=
 =?utf-8?B?TTNsTERVeTZIaG10ZHBBSzlWTzZaZmNiMmtNY1cwZ0lwaUsyVXF6U28wNi85?=
 =?utf-8?B?ekI5KzZiZlJJdi94dFY1a1FTb2Y4NmpnR1EvVUxaRzQ4ZlJUbTM4V2ZubHNF?=
 =?utf-8?B?L09UcUV0ZzcyN0tQcG55a1Nwb1dSNmdFdTI5SzV6aTIyUDc3WWpVWStFYjlX?=
 =?utf-8?B?N3VNamZQdWFJZlJuKzkyb0Q2R0dCWm1rMk1UOEZrVFBBeTBIVksrZnMxcjJv?=
 =?utf-8?B?NW1Ub0YzWUdmR09VVnVwUmt2Rm9DbW5hclZ5ZTlmdmxpcWFxS0dMc0wrak9y?=
 =?utf-8?B?UWRYYmpqRFRQTnR0U3ZVL0U3NmtIUm9CUmcxY0RST21xU1I3eklEU2RSYjVq?=
 =?utf-8?B?ejF5T0paWUZMeVlXbHFRLzZwdjNWN3Q3Yk5sdXI3OEl0OWt0MFh1RkJONms0?=
 =?utf-8?B?TFhuL2E1YVYyYzZBODZGZ1hHZURkbDVIVHJtZHRNenowZWM5SzJ3djFGMytI?=
 =?utf-8?B?aWx0d3lLQmI2blRpZldDTmE4S2RhbldzOUNxMitOZWVnQjh6cW84am9NMmJ2?=
 =?utf-8?B?L3RSR2M5MDdqeDFZa1psSHowOE11OENxOEExWHM5blBUNUNOZzFQQlJKQ0Js?=
 =?utf-8?B?MW5NSFhsVDlVbkVLTGlkaGhwVlM3U28wSTlNZ3NQQTVXWmNIb2tuOVF0VG9D?=
 =?utf-8?B?T0kyMkNyT1JYL21XT254UTcyUXp3bnZuWU8vZVpaUTVFZ2JYdGU2aFhDaklV?=
 =?utf-8?B?YkJiNjBtcTM3MGQ4TVVNdTJJZkZZcjJtT0tGV2hrdkJLOWhzelRXMVFpbWZa?=
 =?utf-8?B?RGRnM2VVaDRvT3MvTlZkOFpjQ2lmVHoxTmZHZ0tEaFRwU01SbVdJUEpNRm9H?=
 =?utf-8?B?WkpQRnhSNnNEZWFJMXpFOEJWRUcwaUNrbTBSamJPRXJ6Tjl3T0tUMzA4Nmxl?=
 =?utf-8?B?bUxhTnFhVHZuRkNYaDFvNm1VdHpQcWplOWZKTzJmWXVtaGhEdTlIQUc1MEZX?=
 =?utf-8?B?cTk5bHFKOWdhc01xNnQ4ckp1c1VmNkRzQk1RSDZjM0svRkxTZ2FrS1k5aHlP?=
 =?utf-8?B?OXNPaG1wQTZhSjdhc0hlT3ExcjNoMDRsaE9aN3R4N09TVkxiVmd6akNRSi82?=
 =?utf-8?B?bUJwR3dYNzYzM1FFWk8rdnBDbFU3OHRFOXhKb1YzdjZwUDFDNHNBaURrQzFv?=
 =?utf-8?B?TnlVemdUUkR3SnB5U1ByL2g4T2x5VEZmdjJTWWdiVzhwa3BZWXBNNWpuNXJZ?=
 =?utf-8?B?YTdaZ2VxWTQ3bjRlc1NkZ2JnQXlpOEptWDJ5TENibE5zeEZWTEhHenZwcm9W?=
 =?utf-8?B?ZGxBQ0NxT3luZTduTEp5Nk9XWGw2RWROVHVaNkR3N3ZjOFRiRDFUVUQ5NXQ5?=
 =?utf-8?B?YjZ5Y2JlUHRnSlMvNGFNQ1RwamV2RmMyYk5JMUZTbm5NUVJsZUFlNStFWFlB?=
 =?utf-8?B?K1drcFJIRndaNWQzZVhUVndyWDF3M2gweVpWQXlLK0Jvc0FManNKdXl3Y0w3?=
 =?utf-8?B?d3NZZFhNSFVoMStQYWlPUks5dlhwekpuNkFteENqckVEOU8wa3hFWUU4MStj?=
 =?utf-8?Q?TCLvkhhUi0v8+1fwvFj2tRE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <458A47E4CC6ABB42BE8807D50C3A64FF@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8595a07d-9101-4d8e-d7a4-08db7d5eac18
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 13:49:37.0644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MleaqtU6HJkFFIiziwVr4wlAkLeayL5jGMNmNvCfIr7MH0i0XSOui3KrEWzxs/N9bTMTelzWPriQu2S6S21iyJIHKzEEmN2tPBDil27LTFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7549
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=HlPCPbkT;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of florian.bezdeka@siemens.com designates 2a01:111:f400:fe16::618 as permitted sender) smtp.mailfrom=florian.bezdeka@siemens.com

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDE4OjU2ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAwNC4wNy4yMyAxODo1MiwgSm9obiBIbyB3cm90ZToNCj4gPiBIaSBhbGwsDQo+ID4gSSBoYXZl
IGVuY291bnRlcmVkIGFuIGludmFsaWQgT3Bjb2RlIHdoaWxlIHJ1bm5pbmcgc29tZSBvZiBteSBz
dHVmZiwNCj4gPiBhbmQgSSBoYXZlIG5vIGlkZWEgd2hlcmUgdGhpcyBpcyBjb21pbmcgZnJvbSwg
YW5kIEkgd291bGQgbGlrZSB0byBhc2sNCj4gPiBmb3Igc29tZSBoZWxwLg0KPiA+IA0KPiA+IEkg
aGF2ZSBhc3N1bWVkIHRoYXQgYWRkaW5nIE5vcHRpIHdvdWxkIGhlbHAgZWxpbWluYXRlIHRoaXMg
aW52YWxpZA0KPiA+IG9wY29kZSwgYnV0IGl0IGhhcyBub3QgaGVscGVkLg0KPiA+IA0KPiA+IFsg
IDEwMC40NTYxNzNdIGtlcm5lbCBCVUcgYXQga2VybmVsL3hlbm9tYWkvc3luY2guYzo5NjghDQo+
IA0KPiBUaGlzIGlzDQo+IA0KPiBYRU5PX0JVR19PTihDT0JBTFQsICEoc3luY2gtPnN0YXR1cyAm
IFhOU1lOQ0hfUFJJTykpOw0KDQpKdXN0IHRvIGJlIGNsZWFyOiBZb3UncmUgbm90IHNlYXJjaGlu
ZyBmb3IgYW4gaW52YWxpZCBpbnN0cnVjdGlvbi4gVGhlDQppbnZhbGlkIGluc3RydWN0aW9uIGlz
IGluamVjdGVkIGJ5IHRoZSBCVUcoKSBpbmZyYXN0cnVjdHVyZSB0byB0cmlnZ2VyDQp0aGUgSFcg
ZXhjZXB0aW9uIGZvciB0aGUgcHVycG9zZSBvZiBwcm9wZXIgZXJyb3IgcmVwb3J0aW5nLg0KDQpZ
b3UncmUgc2VhcmNoaW5nIGZvciB0aGUgcm9vdCBjYXVzZSB0aGF0IHRoZSBlcnJvciBjb25kaXRp
b24gbWVudGlvbmVkDQphYm92ZSBpcyBnZXR0aW5nIHRydWUuDQoNCj4gDQo+IGluIHhuc3luY2hf
cmVxdWV1ZV9zbGVlcGVyLiBTb21ldGhpbmcgdmVyeSBzdHJhbmdlIGhhcHBlbnMgaGVyZS4NCj4g
DQo+IENhbiB5b3UgZXh0cmFjdCBhIHNpbXBsZSB0ZXN0IGNhc2UgdGhhdCB0cmlnZ2VycyB0aGUg
aXNzdWUgYW5kIHRoYXQgeW91DQo+IGNhbiBzaGFyZT8NCj4gDQo+IEphbg0KPiANCg0K
