Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2128.outbound.protection.outlook.com [40.107.249.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0881E
	for <xenomai@lists.linux.dev>; Mon,  4 Sep 2023 07:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzG+vBgw4YkN4Ts3FIMv0aT2sVJ7JUIN6ri/mQy1mFam/T3AwzefgXBHoDrdIOLClAOMlAX5W/AvVmpSNMdv8XXM86zmOIjpv66GENWO/S/n88th8elwFV+hSEobddKV76sC4IheLXnTTm/LNCyIyuVoDn7YM7wCZzQzUJckYElzVKkdiuMHl8US0E83cqb4gnjjDH48dLxtTsHyoi9d64QOGj8ungRMH4xLQh9SxzQB7/yRgrQ7vZytt7vYX1pCynqg1VCO279UP+qNu+j6XSeREw3LGK8YMZQXzpMOUUK7OTQ2UOiH3x8LTGfBwYNJBWxyonwQho8SOOnYSpaCwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/EF+QLmeezumqQ1JnNFjR1TV6URkDqqCJcZnfclzbU=;
 b=ngOReVOnC4WO5muqg1VNEblcAGPZGXhqExR7jjeM07RVxkVrUn4ALUB+iUURmWoNV3WjBUg9ParQdfvdwxca2GDDK6TOF0/GtVxT3CJ16FeIs3mWa0mfjC2dC/uyfwrKfKAsFtohZgJYfsnTjafCxok6EhL1wo0zh1bvzQGHbP9YudP2o1f7cL/HV5mTr8up2g4pGGUZ3FMAdJsDBEta27RvyyXthG+C/uHXHJTE5lwKtjZTltsiN56fUhCdwgMR/HWChel+W0ud0AxQkDzwlt6iqYBYeM565ac5ZcQen0hhirTgQ9THsQ5mvaXHCdSbTEBEJr51XCHZyBQQRJyMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/EF+QLmeezumqQ1JnNFjR1TV6URkDqqCJcZnfclzbU=;
 b=RBfpLt36VaXCtURUNkeG63oIOwk9KSEUmF5q66CR9qxSKpSS0xI7hDLJfr/Wga+f5JABoKTbCm9NOz9uLjndTfoy0pglTrWg+giCx6+Dvl187PvycSCX/8Meh/ul/PObbzgXPEzIKFevJc3+5TCLjzudLecZIr4Dwbck8N4C5cE=
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com (2603:10a6:802:a8::22)
 by DBAPR08MB5655.eurprd08.prod.outlook.com (2603:10a6:10:1ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 07:04:08 +0000
Received: from VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b]) by VE1PR08MB4909.eurprd08.prod.outlook.com
 ([fe80::1c00:64f3:d6fd:832b%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 07:04:08 +0000
From: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [PATCH 1/3] [POC] test implementaion of rt-signals
Thread-Topic: [PATCH 1/3] [POC] test implementaion of rt-signals
Thread-Index: AQHZ0Csq/ZWExxuArEijlXU/s8xHfbAGFo2AgAAFooCABD7JcA==
Date: Mon, 4 Sep 2023 07:04:08 +0000
Message-ID:
 <VE1PR08MB49095F6F1842984BC7BD68AC92E9A@VE1PR08MB4909.eurprd08.prod.outlook.com>
References: <20230816101842.3377643-1-johannes.kirchmair@sigmatek.at>
 <4c8551a6-8c70-4605-8ebc-76b2e3a558d5@siemens.com>
 <9a52921d-2a1e-4203-80bd-8783c852a549@siemens.com>
In-Reply-To: <9a52921d-2a1e-4203-80bd-8783c852a549@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR08MB4909:EE_|DBAPR08MB5655:EE_
x-ms-office365-filtering-correlation-id: d2c8e677-6863-46b9-4e08-08dbad15228f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8aN01/w+4712tzE9DJ83EO1lO91eZ6x9dZF9QGTl80imQFjs7w0xgsITblivVbhQwKvhRCzlu6EqOMK08eyKfkyT+T9K56ZkxOJ/UoF9Eb6nFf0BrgjhWB8HTMFuwc1LRQ/CzX+uVNWG9Dsv184HnMLwDk/XFcORn6BVTAaZZRsUcNSjpx6aokRi2LisWyEUIyXeJtCOqmx+abcqEN1O/3DHowm8wV+bQZv0FeKyyNU+ZaeyTSReKMamWPcQuMoOsDLZ5jG8alGK1l2wFS1mKYMrHwsx8/+uisVgWdoUIUSAHUi9Wz6qXbkbgzyb9dKs7YE4S9kc0nAaL0mnf/Husp3rPwAFyFwT+Ts4DK3oElW/XZMFJJxhWPm+8DezY+45ng0vKs0rdfE+DMZ/2LHmQBAJorzcRMhSZwhqZCEVQdXHDv78i8eWIMHA6rtSKVtb5XTifHliEUc4Lq2zuu/0jX9j88x9BiKA+Yy/ObRO/QZ+ELl5uK/9G12BfDnXW8M0Vq+DRRevf3F55x0INtp0Lb4D8pnDTxJBTCRVqhfKOS9T+huFKr6CYe5e1ygCrbOQ7xEcGEnfgjLavgamAnvQr7nNPIh5ENOhFFG1r0kV/4bM4dSRScERV0CvkrTKrN1i
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4909.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(396003)(366004)(136003)(376002)(346002)(186009)(1800799009)(451199024)(41300700001)(71200400001)(7696005)(6506007)(53546011)(478600001)(122000001)(38070700005)(38100700002)(83380400001)(26005)(9686003)(55016003)(76116006)(66946007)(110136005)(2906002)(66556008)(66476007)(66446008)(64756008)(316002)(33656002)(86362001)(5660300002)(52536014)(44832011)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUttVlpYL2FlbEFWWGFMVG5TbVVySUxIaGc5aStFbGs1TVMrZEJCSjRQV0Zz?=
 =?utf-8?B?ZTVtQVU4VkRSL2pVTEJjZEVuc3gwNVFWZ014MVdKVndtWDhYZklkN3ZYTUly?=
 =?utf-8?B?TGp6QTZTNjFzQjhMTFR4VHRmaFRsRVdvNUNZVjFxcXZwL1M5TDQvUFFuRFFU?=
 =?utf-8?B?Tmowd3l2Tk4vZDdHMVFuN1pYc1NkRXRBd0ZxelM0WlR3THFqZHRERVBvQXU2?=
 =?utf-8?B?eVkxK0RZRGtvRE43OE9lOXhwUXdGOVI5eUJ4dDlCendvYUV3bEkrNG4wWWVE?=
 =?utf-8?B?R25TdytvSHJvSTFsUitBRDVoYkNTNkJmYTcwVnp2b2dWbFBpNitVa3B4SS9T?=
 =?utf-8?B?cC9TL1RvS2RkSnh6ZE1NUzFBaEpuSXFwNUFaVGtBN2pPRkQvYllWQmdhQ0VE?=
 =?utf-8?B?V3dkR28xRkw0Wk5XQlhETFpLelFleVV1ZHFtN3l0cVNkZ3V4Zi8rY0hmaVpZ?=
 =?utf-8?B?NVYrSzBRYVRrNS9wZEFqSXYxVnk4ZXdiOS8yMUNyY1pjODZMRmJnM2lsQ3hR?=
 =?utf-8?B?UzBoRWpTVG1LSkRSMDd0VG5lc0JXZzJHeUNabWVFL2JvcC8vV1c0V3RQdFpB?=
 =?utf-8?B?Z0ZXdEp1WFN2Z3BtWk5HRGszUlRaRU02dHk1TTYveitqSUswN3lVd1JHVVRD?=
 =?utf-8?B?dUswTTVLQWVGN3JoSTZvQWwzN2hBTFVqU0JabklxV203VExjay9JVFF2OThy?=
 =?utf-8?B?Y0QzbWR5L0l0T204YnQ3UTgreUlXb01uQVZsb3RvUGRRT0EzOStyMkZ6NDZN?=
 =?utf-8?B?Q3ZsQXprWm5idG8rd1ZLOUhjZWRza1FJc3d0dStpdnExN3R0S3llTlRHRFlE?=
 =?utf-8?B?cG9VNG5uek0vbjRQRjBYWW54V0lGL1Zmck92YTVNNnRqQXZIZGd0S2FHZ0Rm?=
 =?utf-8?B?NkdlcmliTWlwZWh4VjZpRjk4RzNqRWxmNGtPbXkvdENvNkZwY1R3UG1GaSti?=
 =?utf-8?B?VEdsaURsQTFTU1RGRTRsWWZtTmVGb3IxYzlUYXFNdTZSN2xtMCtkYzhwdm1P?=
 =?utf-8?B?NlhOdExzYzdDSDVSOENiQmRIL2NFclNYNjFCMlhoSXI4bEZVZW5uMC9vbWlh?=
 =?utf-8?B?UHZDZ2p4NFdqcGZtU0IyVG9VWnBGc0RUSWRRODhScE16amdLTCtvZ0h3OG9C?=
 =?utf-8?B?T1FZOWQ0a1FQYndRTmdXSHhROWRmdndGSUJvc3VmRVpjRDZOMjF2Q3JhQlJj?=
 =?utf-8?B?UDhhQmNXWFdOT2p0VVdrbjJMcVo1SjUxaXVEYkpFM1hNc282SXhzd2cwL3Vp?=
 =?utf-8?B?cnMzaUNtV1ZrUDJ0RHlLcGZIM3l1QTNkUVhpd2FaMGlQbktyaldCMkNGeHNH?=
 =?utf-8?B?eVBqbU4yeWREcWtsUDdxd21OU2FsNmpXdFdkaytXNjFxZFdiMGQxN1hFa2NZ?=
 =?utf-8?B?cFdxSlVtTzI1VDhJNy8rU0VjcFFGamZDL3dSNms3S2FrWDFJUWc5dHh3cmdZ?=
 =?utf-8?B?OHNiQWgxWjZrK0paZ2VMelNFcEZabk1oVVVDb0liWFZlNnBSenRIQmdGVlZy?=
 =?utf-8?B?alpjYkdxT3FBM3A0cFEreG9JZ1luTlFEaDFwNDJmUmVvVUZpeGZrSkVMMTBx?=
 =?utf-8?B?ZVlqS0JLYkFHVzk1OGR5eE56ckxjcGJONUw4Mm0vSjZJTlpDd0NQMTVxbm91?=
 =?utf-8?B?LzJxc0F4QmMyM1FFdXNDc2RaWDh3dE9PNWlrVHIzZ3pjZktsL1lodTNkMFZp?=
 =?utf-8?B?eENqdjJGM1QwMkllZ2U5SnJUMDc2WUpkTGhXT2x0OU5weUttTmo1QTVqT1J0?=
 =?utf-8?B?OGRXaVhZekdqeUxIYzZWTWNMbGFSWHdzZkdZMDRJTXAxMGtRcjc2UGdob2o4?=
 =?utf-8?B?b1lNN2J5YXByK2lyWnRFK3VLUGVOY0RZNDRnVG9xUEsxVEpDQm9KNnM0SFBL?=
 =?utf-8?B?L2FScHZlN0NsNWQzbmVSVEdMY2xLTjIwSktzaGtHRFdCM0ovZ2xESHpYMk1C?=
 =?utf-8?B?Y1ZHWkZ5QjQweW9QVjQ0U2VRN0FQSU5pRnZ4V3ZOVlBWUnZZeFRoTnBOaUtD?=
 =?utf-8?B?c1p3R1Y3bU02RCt5NktyZFk4NDhhZ3JlY1BYVkYyVjlrOXZCdGljUFkyTTBr?=
 =?utf-8?B?TEt1a21ibnZNdjZ4UGVDV1FSbS9CVERsaFFDb3NEdEs2U0lnbVlpRmtSRGVw?=
 =?utf-8?B?Y1phMTZaMkVpM1FCN2RKTGt5TDRUclYzS2I4bUo5dU9BdnExRHhuR3VWc3hW?=
 =?utf-8?B?YkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2c8e677-6863-46b9-4e08-08dbad15228f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 07:04:08.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ejpHPlXeG1ssE0jTjnsqNQb26AxNIwB6iEzSznlNxNl0TyRkJ/rSlMpmBzVhE6vfDdyJl8uuqhcYM4Zip/wUeSPmsvsFTBxXM8tHNu4Mnqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5655

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5r
aXN6a2FAc2llbWVucy5jb20+DQo+IFNlbnQ6IEZyZWl0YWcsIDEuIFNlcHRlbWJlciAyMDIzIDE2
OjEyDQo+IFRvOiBKb2hhbm5lcyBLaXJjaG1haXIgPGpvaGFubmVzLmtpcmNobWFpckBzaWdtYXRl
ay5hdD47DQo+IHhlbm9tYWlAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
MS8zXSBbUE9DXSB0ZXN0IGltcGxlbWVudGFpb24gb2YgcnQtc2lnbmFscw0KPiANCj4gQ0FVVElP
TjogRXh0ZXJuYWwgRS1NYWlsICENCj4gDQo+IE9uIDAxLjA5LjIzIDE1OjUxLCBKYW4gS2lzemth
IHdyb3RlOg0KPiA+IE9uIDE2LjA4LjIzIDEyOjE4LCBKb2hhbm5lcyBLaXJjaG1haXIgd3JvdGU6
DQo+ID4+ICtpbnQgeG5hcmNoX3NldHVwX3RyYXBfaW5mbyh1bnNpZ25lZCBpbnQgdmVjdG9yLCBz
dHJ1Y3QgcHRfcmVncyAqcmVncywNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgbG9uZyBl
cnJjb2RlLCBpbnQgKnNpZywgc3RydWN0IGtlcm5lbF9zaWdpbmZvICppbmZvKQ0KPiA+PiArew0K
PiA+PiArICAgIHN3aXRjaCAodmVjdG9yKSB7DQo+ID4+ICsgICAgY2FzZSAwOiAvKiBkaXZpZGVf
ZXJyb3IgKi8NCj4gPj4gKyAgICAgICAgICAgICpzaWcgPSBTSUdGUEU7DQo+ID4+ICsgICAgICAg
ICAgICBpbmZvLT5zaV9zaWdubyA9ICpzaWc7DQo+ID4+ICsgICAgICAgICAgICBpbmZvLT5zaV9l
cnJubyA9IDA7DQo+ID4+ICsgICAgICAgICAgICBpbmZvLT5zaV9jb2RlID0gRlBFX0lOVERJVjsN
Cj4gPj4gKyAgICAgICAgICAgIGluZm8tPnNpX2FkZHIgPSAodm9pZCBfX3VzZXIgKilyZWdzLT5p
cDsNCj4gPj4gKyAgICAgICAgICAgIHJldHVybiAwOw0KPiA+PiArICAgIGNhc2UgMTogLyogdHJh
cF9lcnJvciAqLyB7DQo+ID4+ICsgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGNvbmRpdGlvbjsN
Cj4gPj4gKyAgICAgICAgICAgIGdldF9kZWJ1Z3JlZyhjb25kaXRpb24sIDYpOw0KPiA+PiArICAg
ICAgICAgICAgc2V0X2RlYnVncmVnKDAsIDcpOw0KPiA+DQo+ID4gVGhpcyBsb29rcyBzdXNwaWNp
b3VzOiBXZSBtb2RpZnkgRFI3IHVuY29uZGl0aW9uYWxseSwgZXZlbiBpZiB3ZSBkbyBub3QNCj4g
PiBoYW5kbGUgdGhlIHNpZ25hbD8gSXMgdGhhdCBPSyBmb3IgdGhlIGtlcm5lbCBjb2RlIHRoYXQg
dGFrZXMgb3ZlciB0aGVuDQo+ID4gYmVjYXVzZSBpdCB3aWxsIHNpbXBseSBkbyB0aGUgc2FtZT8N
Cj4gPg0KPiANCj4gSSBmYWN0LCBJJ20gbm90IHN1cmUgaWYgd2UgY2FuIHNvbHZlIGFueSByZWFs
IHByb2JsZW0gYnkgcGVybWl0dGluZyB0aGUNCj4gYXBwbGljYXRpb24gdG8gY2F0Y2ggYnJlYWtw
b2ludCBvciBzaW5nbGUtc3RlcCBldmVudHMgb3ZlciBSVCB0aHJlYWRzLg0KPiANCj4gV2UgZG8g
aGF2ZSB0aGUgdXNlIGNhc2Ugb2YgaG9va2luZyBpbiB3aXRoIGEgaGlnaC1wcmlvIFJUIGhhbmRs
ZXIgcHJpb3INCj4gdG8gYSBkZWJ1ZyBzdG9wIG9mIGFuIFJUIHByb2Nlc3MsIGFuZCB3ZSBoYXZl
IGEgZG93bnN0cmVhbSBhcHByb2FjaCBmb3INCj4gdGhhdC4gQnV0IHRoYXQgaXMgdXNpbmcgYSBz
cGVjaWFsIG1vbml0b3IgdGhyZWF0IGFuZCBjYW5ub3QgYmUNCj4gcmUtbW9kZWxlZCB2aWEgc3lu
Y2hyb25vdXMgc2lnbmFscyB0aGlzIHdheS4NCj4gDQo+IEZvciBub3csIEkgd291bGQgbGVhdmUg
b3V0IERCIGFuZCBCUCB0cmFwcy4NClJlbW92ZWQgaXQgZm9yIG5vdyBhbmQgYWRkZWQgdGhlIGNv
ZGUgZm9yIFNFR1YgZnJvbSBvbmUgb2YgdGhlIHByZXZpb3VzIG1haWxzLg0KDQpKb2hhbm5lcw0K
DQo+IA0KPiBKYW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCj4gTGludXgg
RXhwZXJ0IENlbnRlcg0KDQo=
