Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2138.outbound.protection.outlook.com [40.107.247.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3746217CA1
	for <xenomai@lists.linux.dev>; Wed,  9 Nov 2022 11:42:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9SPJevtAEvCQQrvESXCWkzv9rc8H0qBH7MhM3/oE+VJCxmei4dlMCckNVC59k7tJWjgvkZDyGnG+TBMZkgSJodk7UJRuw0Bhn61c+joewJ9mVf302fB7ik1KaBckbp+tV/oTSt5mIn0EEfYMQAUDmNbbAlPenGK4y7aJrPxay1PS8xLoJ5lja6QB1I07uz3AaIYkP061+OZYC4W5LixOGf004im6GCguxN7psW27gMneEdUIw6GwyMYsMQkaa17n0tRYt3dN+3o+3zuXkb4h8nbyW5kFuE19jGxkg6pZl4hkJwPh/fxzAXJ0LmpM+ynENxgz97wM/RySJaP79VjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7fgK5q4wWjFtrieZsK6sbtGl2CZk6qp+UnwXNUQJ4s=;
 b=luBeNUJJbwBHNYwmVpm3sqKN9+IUxuU/j7olekDPkLH3IidmZv/pngp7EBaWXJBk4Nk4HYnBhimey3opkDqMS88B/gDf2gEc6x0vfYi7Gnj/7wPAncGW2iSBBd1CXvbCqSmPP7BmQVtb2yH/lTQ3zaiLidSfct4OjG/6CaYp+6Hchw8fUDzQapd1uYQ2Lctna3+1fz6caQN+zanhh4n7cuXu++714OuzSp92QwzszVJe1s6/44qQh838Oz9hRHvlYp3nyQ5Z8h8UWeOoBd+fXEi7I8iUpLSXU5riblutKAdSoHlWOXBTEtw+n/hE4eRVx9aoyJU18YkkW5N7X3G2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7fgK5q4wWjFtrieZsK6sbtGl2CZk6qp+UnwXNUQJ4s=;
 b=VYJT0FPt9/h1Or/vBZPynEboHmViseBhGfbnESKjPle55IF9SjxCkdIqbh93XX+gvu7X1yqNR4wDzNz69JYeiylaaglYf6Z4Pa6tyT8rJfiaIXJGOgKyEg8N1Skxs2IdzNfMYdwm7VLgT4+Rgfk90CNfhyMs6OkrV4eqws94ZhI=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by DB5PR08MB9998.eurprd08.prod.outlook.com (2603:10a6:10:489::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 11:42:08 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::8ae5:ee34:abf2:12f6]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::8ae5:ee34:abf2:12f6%4]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 11:42:08 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>
CC: Xenomai <xenomai@lists.linux.dev>, Richard Weinberger <richard@nod.at>
Subject: RE: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Thread-Topic: [RFC][PATCH] x86: dovetail: Permit to declare a trap handled
Thread-Index:
 AQHYkpnmoysKxd93Y0qoFLI8cNHP4K10DwyAgMHVdACAATFugIAACuCAgAAI5gCAAAIW4A==
Date: Wed, 9 Nov 2022 11:42:08 +0000
Message-ID:
 <VE1PR08MB490963A18B8D61A5AF0B7AFA923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <006148b8-dfa1-1abb-b243-029db08ceb0a@siemens.com>
 <8929fce3-cbe6-79cf-d0a9-5e8399e3dec4@siemens.com>
 <VE1PR08MB4909620AE0E4EE0139B54276923E9@VE1PR08MB4909.eurprd08.prod.outlook.com>
 <f275bac0-492e-c8da-ea30-a48ebae505c4@siemens.com>
 <87iljoh1gd.fsf@xenomai.org>
 <d19b9dbf-9831-99ab-67bb-01d06b9b00f4@siemens.com>
In-Reply-To: <d19b9dbf-9831-99ab-67bb-01d06b9b00f4@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|DB5PR08MB9998:EE_
x-ms-office365-filtering-correlation-id: beffb282-b224-474d-a7ce-08dac2476f13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rr/vB1QGk3YFOXs3/GREgRoKZ6ZELrrbCVldyVkqdvNZRhXIhAkSt6NgRGSLJbwu+sAssELuZV1/i+OSY831Ll3VscLZhGITS/Z/gWgJeHRFvtwohHGyHxLyZ45nn6Zm1ZEMNcT+pJGw6H5xn8xcDE1uctNNyP9W9zPvavv9yXVR8AZ+crXTB149GPvz6prkfB2bQQ9J/tRA6novHZjThePn9T+R3HQ9FX965bbo0yuCHg7dkj+GkBFWXIGpi7rlVzGGJHdoPSaW8T8SfbvnNExOsOIz1HoGM/GVoA8TplTnWRM6/rpOc0RaHfMwlTW7FmVAc81IQqA0Y8pJu5fFo/bIJ5Y2/O7mgbY7FuvmR7DYYL8DS/x/pNdLzRQgPA2FQEomgOmBfPFIADpxhm42dfLSOlA8TyLJoh46nYZ+zN71k3AoYx/CAdCFjQEd+Xcsv90jyc4AArXiRmDya9y7gZ6SAQuxDtcs5+5cCDtTb7SmV4CRLhZvg9IJsNFLauGxdHgI7o5oHjIsQGWMTTUvvK2aCndRHlDmkAUYdA466/s/F2C6bfUMej2ZMcvazpUd8vyHak6QfyBt3tZMWWnOL4St+LJ+kI3ofsYcgRd15IlUqbUhR22DKS5TA2s5WZgfVEMLHRBk8iLpC2qm0VMqk2oRRDPcn7m11ck3nioU0AmqkzCTSOHhXOpQsepROxMYQtIOmBSKwD1ZlDINIZ57qSclJG1OfO061Imsop8FLWR6QLiHh4meiBz7vH2R6c7becGVJn7QcgwydEmTkD9z7g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39840400004)(346002)(451199015)(38100700002)(122000001)(86362001)(44832011)(2906002)(76116006)(4326008)(33656002)(38070700005)(6506007)(53546011)(26005)(7696005)(9686003)(110136005)(316002)(8676002)(66476007)(71200400001)(66446008)(478600001)(64756008)(55016003)(54906003)(8936002)(66556008)(186003)(5660300002)(66946007)(83380400001)(52536014)(41300700001)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tms2cng5Sy9oRCtTd2swNk56cnRzNHp2M2dWT216VHYra1VxTWx6V2pqZU1X?=
 =?utf-8?B?R2Z2NHlTR2QzQlFLbDNCL3lPbDdQODNqdDV2eEtEa3JUQUNXam9LY21mcncr?=
 =?utf-8?B?TFNOeTJNclpMa1lnSnYwWDBDTHBicjVuWHQrZjEyNWNPT05oQk5BZmFxN09L?=
 =?utf-8?B?QlVxU2YwSmNxWFJVMGo2UW5LMG96Rm9WVGVqbjU0OThxa0xXUEhMSmFTUjJv?=
 =?utf-8?B?SUxmbFRGc2x6S3ZMeHk3R0FwdTZKeTBSSWRFekJaNzlianFEdWJqcXpWeWhC?=
 =?utf-8?B?N29qZG9iaVhnamxoWHZuTlhPOEtwVlhPSG5oSGlqQldHY08zVzRFVXBlaC93?=
 =?utf-8?B?Rm1wdUJuN29nTlpEV2tsT3ZsU2VNZjZyYzZIWWlFNHVhdFJ6SHNpL1JIcXlJ?=
 =?utf-8?B?amdwRDhsczVmU245SGJYZnFnV1BYdXczUkdRampmaDhGOS9zVFVYa2NtYWM4?=
 =?utf-8?B?cHptWm1VNW14TURRanhwUzhpRFk5VzNNcHdOTTVCUFo5Z2owT2V2ZVZTTEpQ?=
 =?utf-8?B?WDJxVjF5YW52ZUQ4Q0JidXVhT241L3RCT2xFczdjbEJqUUhvdVVLQ0hmKzkv?=
 =?utf-8?B?d1RkRHBJbjBRTWZZL1hoanNWVk9pampvUFhkZ0dJTWtSekxvWWwwMEg0Qlli?=
 =?utf-8?B?SjNNNFFaOWhDNWVZOWlFR3J3N21rcVQ3a1lBUk4vYW1vNlhSM2tCMDU5ZXh3?=
 =?utf-8?B?M0ZWdjlXL2NHZVNrdTk0SEkrMHVpb1hxRTR2NlFod2krdThEMXlqN0VuNFEy?=
 =?utf-8?B?OWEwREhjM2syNWFwazRud3Eyb2ZFSkg0VmdqRG5oSnZ3NnovODQ0Sm9namg4?=
 =?utf-8?B?ZWFkZXFxK0puTk5IdGpoQVdZdml3NTdCVFNsNjR1T3dmYVRhdmwxRmpmSVBl?=
 =?utf-8?B?K3pWdzUxRFJrUDZBbFljZEwxNm9sSnBPVEFPeCtiMXFKanN6MmxjMms2Q29S?=
 =?utf-8?B?OExPN1hRSlNpVnAxZGJ6cGdXbFBWdi9XOTltTFZtNUtBS2VtOVNrcEpKZXJ1?=
 =?utf-8?B?c3VlWU1ZZDFnaVc5OGNHNHJ3TUZlTGNvRTJSUlJPc0dUa1N5T1NHMnB2TzRM?=
 =?utf-8?B?MDJqSlJMY1NqcE5aNmJTTk5ZMm5GZkVCTkhoQ3dXNmZ0WG1xT1pMdkZpOFBR?=
 =?utf-8?B?TC9pbExuenpKYVhIU05uM2phQ2ZnaU02alpIaFJOYW13VDREUHpKMW81MHgr?=
 =?utf-8?B?STFVaERGa1kwbG5pNjF0Tzk1c1VGeWx1ZEIyMWR3dzc0cnRPTHpxZXI0NUpr?=
 =?utf-8?B?MUl3VkE2bTlhanNGdVFQY3ZJZnNsb1lueEg0NzI5dnpOZjVPaERadFZheCsv?=
 =?utf-8?B?YWgwbTYydHZtZkJWRDNMQ3NOcll0NVZIL3dWbXBNRk1aOXV4Sit2SHhIMG9t?=
 =?utf-8?B?MXEzMSt5QkdKY292UTc4RkNQQUhWNGE1TWtJamJIMzRtWmtwYXNYM3FPWVQy?=
 =?utf-8?B?akhEeWp1elBRZnVMejBDQ2tIN2RqZDFBQXJnS2JIVU5BcVdEMmZ2Y3VTZUhD?=
 =?utf-8?B?MkxEakhHdkdzdCtzK0h2K1NzeHlOMVZEWFBGTWpLcmUzK2Y0VDJPNitHVklU?=
 =?utf-8?B?Z2oySUpGc3g2dllDZW1MUWowamg3cGR4ekppNTdRRDh3a3FQQmFoOTVwUVY5?=
 =?utf-8?B?bHFjRlNwQVRaT0RZcGhqTDdIcFpLSFVTa2N4bXQ3MjZoT1hJZEpScDJYcUR5?=
 =?utf-8?B?QW5JVHpJYVJQdXMxbUU0RDNVeXpRNDN4SlhGS0JwZVZ1MDVqQlJVVUF1SEd1?=
 =?utf-8?B?VUN1ZTVRUnRYU25mbytKeW1WRitmczIwSHRCWEVka0xiUkNhL1R5Q21LS21x?=
 =?utf-8?B?ZHBxaG9KSDhqbmFMMVFPNFRmbHFPOGhGanZ3SWN5Vm9MSTR4YkpXdFVLWnFJ?=
 =?utf-8?B?WmYzczFvK3RyeUhPMWdWbDA4cFFDR051RVNaa2xQb1JjTFN3eEtuL1V2VWph?=
 =?utf-8?B?aEJpbGxPRFJRME9wVUFTeFo5NVU3YW5JUndYblhUTDBFSk5OZHFmQ1Y4SXRQ?=
 =?utf-8?B?YUhlSzg5YXNFbzJsdU1Ddkx2b09CRnNDVmdkbloyb0tJdWdLZHFydzhRTGRu?=
 =?utf-8?B?RVFKUDcveEYrM3JTQmFNSlVwVkpoQW5VVkNielNoZSthK0lmTnM3ZTdSTGpD?=
 =?utf-8?B?VFdod0xySVZ0ZzdOaW5IaituWVQzNlJtL2txRU5NOW9td2ZINC9SZDlaNFFO?=
 =?utf-8?B?dlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: beffb282-b224-474d-a7ce-08dac2476f13
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 11:42:08.7747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5scnPZ3NtO7FxiacTPcDvnK10YukW1RLRLEv2/6r/nPeEVpCA140YPTfHy+mJuDcrEStSVJCxHioSk0JN/i6WqSmPKIcIEjmwRqmEfB5x6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB9998

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3pr
YSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogTWl0dHdvY2gsIDkuIE5vdmVtYmVy
IDIwMjIgMTE6MzkNCj4gVG86IFBoaWxpcHBlIEdlcnVtIDxycG1AeGVub21haS5vcmc+DQo+IENj
OiBKb2hhbm5lcyBLaXJjaG1haXIgPGpvaGFubmVzLmtpcmNobWFpckBzaWdtYXRlay5hdD47IFhl
bm9tYWkNCj4gPHhlbm9tYWlAbGlzdHMubGludXguZGV2PjsgUmljaGFyZCBXZWluYmVyZ2VyIDxy
aWNoYXJkQG5vZC5hdD4NCj4gU3ViamVjdDogUmU6IFtSRkNdW1BBVENIXSB4ODY6IGRvdmV0YWls
OiBQZXJtaXQgdG8gZGVjbGFyZSBhIHRyYXAgaGFuZGxlZA0KPiANCj4gQ0FVVElPTjogRXh0ZXJu
YWwgRS1NYWlsICENCj4gDQo+IE9uIDA5LjExLjIyIDExOjA2LCBQaGlsaXBwZSBHZXJ1bSB3cm90
ZToNCj4gPg0KPiA+IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IHdyaXRlczoN
Cj4gPg0KPiA+PiBPbiAwOS4xMS4yMiAwODozMSwgSm9oYW5uZXMgS2lyY2htYWlyIHdyb3RlOg0K
PiA+Pj4gSGVsbG8gYWxsLA0KPiA+Pj4NCj4gPj4+IEkganVzdCByZWNlbnRseSBmb3VuZCB0aGUg
dGltZSB0byB0ZXN0IHRoaXMgcGF0Y2ggaW4gdGhlIGNvbnRleHQgb2Ygb3VyDQo+IHJ0X3NpZ25h
bHMuDQo+ID4+PiBBcyBhIG1hdHRlciBvZiBmYWN0IGl0IHdvcmtzIHF1aXRlIHdlbGwgZm9yIHVz
Lg0KPiA+Pj4NCj4gPj4+IFNvIGlzIHRoZXJlIGFueSBpbnRlbnQvcG9zc2liaWxpdHkgdG8gYnJp
bmcgdGhpcyB1cHN0cmVhbT8NCj4gPj4+DQo+ID4+PiBJIGFsc28gZGlkIHNvbWUgc2ltaWxhciBj
aGFuZ2VzIGZvciBhcm02NC4gQXMgd2UgYWxzbyB1c2UgaW14OCBib2FyZHMuDQo+ID4+PiBJZiB0
aGVyZSBpcyBpbnRlcmVzdCBpbiB0aG9zZSwgSSBjb3VsZCBwb3N0IHRoZW0uDQo+ID4+DQo+ID4+
IFllcywgcGxlYXNlIHNoYXJlLiBUaGVuIHdlIGNhbiBjb250aW51ZSB3aXRoIHByb3Bvc2luZyBp
dCBmb3IgdGhlIGxhdGVzdA0KPiA+PiBkb3ZldGFpbCBwb3J0ICg2LjEgbm93KS4NCj4gPj4NCj4g
Pg0KPiA+IFRoZXJlIGlzIGEgc2xpZ2h0bHkgZGlmZmVyZW50IGFwcHJvYWNoIHdoaWNoIGV4cHJl
c3NlcyB0aGUgaW50ZW50IG9mDQo+ID4gdGhhdCBub3RpZmljYXRpb24gaG9vayBEb3ZldGFpbC13
aXNlOg0KPiA+DQo+ID4gLSBpZiB0aGUgcmVhbC10aW1lIGNvcmUgc3dpdGNoZXMgaW4tYmFuZCB1
cG9uIG5vdGlmaWNhdGlvbiwgdGhlbiB0aGUNCj4gPiAgIGluLWJhbmQga2VybmVsIGNvZGUgbWF5
IGFzc3VtZSB0aGF0IGFsbCByZWd1bGFyIGZpeHVwcyBuZWVkIHRvIGJlDQo+ID4gICBhcHBsaWVk
IG5leHQuIFRoaXMgaXMgdGhlIGNvbW1vbiBjYXNlIGZvciBtb3N0IHRyYXBzLg0KPiA+DQo+ID4g
LSBpZiB0aGUgcmVhbC10aW1lIGNvcmUgc3RheXMgb24gdGhlIG91dC1vZi1iYW5kIHN0YWdlIHVw
b24NCj4gPiAgIG5vdGlmaWNhdGlvbiwgdGhlbiB0aGUgaW4tYmFuZCBrZXJuZWwgY29kZSBzaG91
bGQgYXNzdW1lIHRoYXQgYWxsDQo+ID4gICByZXF1aXJlZCBmaXh1cHMgd2VyZSBkb25lIGZyb20g
dGhhdCBzdGFnZSBhbHJlYWR5LCByZXR1cm5pbmcgYXNhcCBmcm9tDQo+ID4gICB0aGUgb3V0ZXIg
dHJhcCBoYW5kbGVyLg0KPiA+DQo+ID4gVGhpcyBnaXZlcyB0aGUgc2FtZSBmbGV4aWJpbGl0eSB0
aGFuIGJ5IGV4cGVjdGluZyB0aGUgaG9vayB0byByZXR1cm4gYQ0KPiA+IGNvbnRpbnVhdGlvbiBz
dGF0dXMsIGJ1dCBtYWtlcyBzdXJlIHRoYXQgcmVndWxhciBmaXh1cHMgY2Fubm90IGJlDQo+ID4g
YnlwYXNzZWQgd2hlbi9pZiBzd2l0Y2hpbmcgdG8gaW4tYmFuZCBtb2RlIGlzIHJlcXVpcmVkIHRv
IGhhbmRsZSB0aGUNCj4gPiB0cmFwLiBSYXRpb25hbGU6IHRoZSByZWd1bGFyIGluLWJhbmQgdHJh
cCBoYW5kbGVycyBrbm93IGJldHRlciBhYm91dCB0aGUNCj4gPiB3YXkgdG8gZGVhbCB3aXRoIHRo
b3NlIGV2ZW50cyBmcm9tIGluLWJhbmQgY29udGV4dC4NCj4gPg0KDQpJIGxpa2UgdGhhdCBpZGVh
IGJlY2F1c2UgYXMgSSB3YXMgbG9va2luZyBhdCB0aGUgYXJtIGNvZGUsIEkgd2FzIG5vdCBzdXJl
IHdoYXQgd291bGQgaGFwcGVuIGlmIHdlIGFyZSBvdXQgb2YgYmFuZCBidXQgDQppbmRpY2F0ZSB0
aGF0IHRoZSBrZXJuZWwgc2hvdWxkIGhhbmRsZSB0aGUgZXhjZXB0aW9uLiBXaXRoIHlvdXIgaWRl
YSB0aGF04oCZcyBub3QgcG9zc2libGUuDQoNCldpbGwgaGF2ZSBhIGxvb2sgYXQgbXkgYXJtNjQg
cGF0Y2ggYW5kIHRyeSB0byBhZGFwdCBpdC4NCg0KQmVzdCByZWdhcmRzIA0KSm9oYW5uZXMNCg0K
PiANCj4gU291bmRzIGludGVyZXN0aW5nLCBpbmRlZWQuIFdvdWxkIGFsc28gb2Jzb2xldGUgdGhl
IG5lZWQgdG8gYWRqdXN0IHVzZXJzDQo+IHRvIGEgbmV3IGNhbGxpbmcgY29udmVudGlvbi4NCj4g
DQo+IEphbg0KPiANCj4gLS0NCj4gU2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiBDb21wZXRlbmNl
IENlbnRlciBFbWJlZGRlZCBMaW51eA0KDQo=
