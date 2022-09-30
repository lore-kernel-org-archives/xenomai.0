Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC15C85
	for <xenomai@lists.linux.dev>; Fri, 30 Sep 2022 22:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofg7Y0qSf8BQQA2Iy6iet7XcaPQic7+hqAEbSpqHA5HXh8VuTzNFeG2+N1A8MpP8S5KcVFLOv3Jh/uJJqjZafoTe3jjblGvn7HMeF8JVNnSOjX+8pShUS4OBjrfp3wo+Dv+bfE9VPFM6gTogyiEsrNfB5qlwnEmUYSeX1y9mAcpAMnlQRxCRd/NMfZn+Z9TJARflTf3W41Q2t0//m2Jp1W4ZMXd5c0hBrRiZW99PVIhnshUOeq05ZIXiWSmO/l5zIASF8YW6RwLO/S+pR7Lc5TDhW4ocKLEjnj18BhEohEk7J2jhNqtg9F9JCePM6MQZ/wB1vuQC3osGfqkOKNG9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86y1iIRqSPtjwB9LPB6FFWrIeg9KG3sZwn5IN+t7ewo=;
 b=E5SQoi6QcScSd4LRUcMSZXbpJfr/EjRVnCRQgyY2kHvOA5mfQ9PNz119jVq3Re3gyxu8CcamVHBeLnpFtPLpwt8yaTqLkTutBE8788oXrmNkxX6llwKx/C3BaaQPIljuGgM4Yod1XW1pDvQciDD+JJahc/RVyrwU1Ux+n056LBkfTl9vEOClj0wAgEYWfz7WEvvmaQ4rZl9qEJJBXzXjaurcvJGFQCsmcbseYilPMb0MNcuFBDT4WLobYynHO0Usl8MgwZuWz3Gi0RYIBFP1CrMptyQnS9jvpKTushgXsYYfQsDIy9xK7Aac0o0KapU4UVSATwmc9WXeAgwg7U2UzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86y1iIRqSPtjwB9LPB6FFWrIeg9KG3sZwn5IN+t7ewo=;
 b=LUH6k4aMeT6A8nX1lasj0isPy0KZhe5EdULbbCsoF3YleiPOyq0eNz62u+5xvO8tJ+sooAEgqX6h9tzU2KsUzFFAb3diIOqfcolut2olsHnOhbU/qFvT4qh8JAFDc8cMFuqhbjA7XF+IUJ39PUVBATFHhx06JIqEOk9qF6mTXV2hN/R9VOW6pEwckypQCynnY25xSZzaKPbhWVDxiJwpQj32rPmk3WdZ2wbphLrFXZDsKJ179nV8eozrflYQG0q8bD4M2FVXojvJye4jgJWL6N9lCEJCB4r3XJreguqeX+Gmja506wbuWcsrX6Jlqv18ALmHmmHY8Mpul1jCGOzRqQ==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by PAXPR10MB5757.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:247::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 22:48:09 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9a0:731a:c172:4a6e]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c9a0:731a:c172:4a6e%7]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 22:48:09 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: [PATCH v2 2/4] drivers/rtcan: Implement compat support for the
 rtcan driver
Thread-Topic: [PATCH v2 2/4] drivers/rtcan: Implement compat support for the
 rtcan driver
Thread-Index: AQHYzOwG0hT63RZ3KkKng313Mn2rw634o5MA
Date: Fri, 30 Sep 2022 22:48:09 +0000
Message-ID: <3ed01ad123d1ad28298d9ae4fca06046b24e3805.camel@siemens.com>
References: <20220920122503.115682-1-florian.bezdeka@siemens.com>
	 <20220920122503.115682-3-florian.bezdeka@siemens.com>
In-Reply-To: <20220920122503.115682-3-florian.bezdeka@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|PAXPR10MB5757:EE_
x-ms-office365-filtering-correlation-id: 1c06a670-466e-483d-6e1f-08daa335d8b9
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6FWzP8ioS9w7xHIUfntvriEuRvNAZ0JyVkMRgx8EK1oZkMq7CEfED92fGNo0vbtK0NmpkKeBz4ITfg1aUffecxMW3rt1F5WRPjBeT7ABWHi5YyDo0LxkoF3+LUpp7T2ADYXhSKOqzW8yLb3k7oSXQAlkguO1Zk658auSdy5wSRToa8cz2QtWQEClgaRkC/qycn4e2DTYJA+dtFaW7CUtSVunN/yWBO+gkQl+8kgWNkyMyrZZLQlK3mRFJQjHPuQ4yAK+Bb5Fxry0pgYyRaPACtOmsBxaYwmF0aLsd9gX/BgD4slQOSMgiDhs57uuYl5YzYYq1zq0+28A9g+IpIfNsedQnCPxOUuLJ1YAZao7BjvcLsN4EqaZ8sCRHvugeLzW8Wm/3YievgCxJAEo76/f/xDEuBh/ljspVdqOWaGQKDX4QpUZo35i8YCgvlEJONri9JPcOrRI1LfvuokqGYzbQP18SYDAHW0Q0w2TTatQwcZjDCsUnOAWlEfBPZACe1DtS/aHsyXl0/Z1T01r8oFABZKipWVEHjZ4TiKK66JaH1lIgRhKUjcRCUMX8lXz1Xhqj4g8LIvkXnLVUipjXzRBwNxUftq2r3owuipOka1x4EosMrRPjkjf8EAQy3ZWsnmMhdd7dkYN2Bv0AloqMgGF5pOkbPx1AwNHmf7KsfEezraBIFVMSHyJawifrd+uy1jHk/ff+Er2lLIz2Crqdl94WSBxRYx4VyIu7UZH+PZc8UU3geNjMgbe9hBPxVF9YWdDD25VUMMgPyfukUuJmK03lA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(66476007)(6512007)(2616005)(186003)(316002)(36756003)(6506007)(38070700005)(66446008)(82960400001)(38100700002)(6486002)(71200400001)(478600001)(5660300002)(2906002)(110136005)(83380400001)(8936002)(86362001)(76116006)(91956017)(122000001)(8676002)(66946007)(41300700001)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEY2WXVJUzU0TzdjNlp3L0tzYWhKejRpNm4rL05LTzVCSmRzYStiY0FMeHAz?=
 =?utf-8?B?c0hGeGJILzkxemJTZ2xLcWxMSW04QTd1NDNCandiOHphMWZ5RDhWMWNBcGpk?=
 =?utf-8?B?alRUVzBhL3p0NTc1VnZYYmV4SE9Gbkd4bW0rQmxxdTk0MnpCWFRXYk9Hd3Yw?=
 =?utf-8?B?aENaOUcyUE14dVN2VVc5eWZoWGhLTTJUVFE3WEF0aWlUMStoVDk1Nkd4azVT?=
 =?utf-8?B?Z1crcy96Z2lTRmtkZms2U1E2eFdUNmJJNFo5MmdacGRVV0xrbStRUXBlcHBD?=
 =?utf-8?B?dmw0RnJBL0pVWXl5VzYraE04TEszZkR1ZEdWUTRWUmREM1ZyWlVGRUVvOElB?=
 =?utf-8?B?dkJkOFVhbTVUM1FFYktGR3JCN2RIVjY0S1p4VEhPdzJ3di8xdzBFbzJ2ZnM2?=
 =?utf-8?B?cXlBaWJZeWxEZ2RvS0dOck5CZjh3cFhOcUFKRE1mNHIwUnhtalhoZkNyR3Qy?=
 =?utf-8?B?UWNhRGdjbWY5UGEwaWM4M1ZSMlE2LzlMSkpqM09BVGNZdTdudDNJOGtvRlJI?=
 =?utf-8?B?TjNtVjlDc1A4QlNiZGFERlEwWGE0aFNuQ2lhZStkZGZXTGZqeG9DZ3JDdE9l?=
 =?utf-8?B?VTUwKy9GbFNyN09saVE5NkpiVUNDbjEvK0xCci9lWWhML2I4ZWhtblliUnY0?=
 =?utf-8?B?V05rVHA1YUpiZUE3d21YcFFKV0VSeFgvZloyVkJIRHZlbm9xTjR5L2dSVHlU?=
 =?utf-8?B?eFluaDVSa2p0YStReFk5WXdDdUxrQUQzaXV3czE5c012NkY4cGlTVWhVSVF0?=
 =?utf-8?B?d3h1TFFHTmx2Yk1UNVhRK3FjeExTbHd6N1R2QlY1QUJBMUxiUnZwQmNqTmZH?=
 =?utf-8?B?dFpqRnVsektwSzUxUDRQYmxVUkIrd1lDRmJ6OVVLcHN2d3B5VGVDWGN3NC9N?=
 =?utf-8?B?Q3JES25ZMmtsaTMxa2ZUTWZGUGh0S3ZvYUIyVU03V3BWcGFIOWF2RUJwbGpx?=
 =?utf-8?B?Qjg2QjN2SkZPT284NmVaTFIyaEFlSHQrZjAxRDhvS1RvUXJiL3BRTjV1c1Yv?=
 =?utf-8?B?Zkltekx1YThpRk5zWUErd1E1ZS9DMHBMVmdkem5TdEZySjFPckZhWFgzaGNZ?=
 =?utf-8?B?MTVWUlVpT1JTeUU0cXJaZGVycEdVQ2RENUM2R2hIZWtjUHhodG5oUmFSakti?=
 =?utf-8?B?c0ZIYmthS2Z0NzRHeHl2Vzl4WHp4TWdBQnVLRE9PRGNTL1UycTI3T1doZVFM?=
 =?utf-8?B?Y054NkZWQ0lubXhEYXRCSzdVWW1tcVM5ZS9IRlg0Mkx4dGxYQmdUM2tKcktB?=
 =?utf-8?B?VmFrVGZnajRMdldpUG1nZm92RmxHNi9RYmVpYkFsNGQvMVZVemFDNVlNQ21Z?=
 =?utf-8?B?ZVhIWVk4amJnVHF3MmdFZXFHM3Y5L3VyNi9KUk5GeGFjbDA1eEJDNW52Y3hG?=
 =?utf-8?B?Q0tKYWQ2ckNDaUQrZ3NVejhweXRWTEtudFhYeGR5THZSR3RZMHhCTXZwV2pE?=
 =?utf-8?B?QkhYcURrdkJWTUc2WTBxWnpRN3VQM1UzMEtsRmFRQ1NuZjZNY3hseWtObGJH?=
 =?utf-8?B?RjdRcGwxRmFiK2xveTlyMG1JYUI5cGFqa0xiNzF5MFRQTEM3a0QrV1g5REtv?=
 =?utf-8?B?WG9JOVpRYlJzcm1CKzgvVkI5MzVSQXdCZXNsUFZtRUZYWXNEaTlDTFZDWjNT?=
 =?utf-8?B?Q1dGclFqZzJSMXhYZVg4MkluNHdscEl0T1R3S2tnU21qY2doZnpCczVOdDNM?=
 =?utf-8?B?RHpyVXN1MVBiQzVNR0ZFVnRmVW9HaGtNTU1jNEE2YmpTNmpKZHFQYVVXc0Nw?=
 =?utf-8?B?OUlQalV2ZUFFdjBHeXNPNENiT0pqQ2J3ZVBnTnJBQ1ZvMjFNN0xOKytLVFVS?=
 =?utf-8?B?eVpGSmVQUUwvQ1dQM1RvRVJGZ3c3eHg1aUJUQmNWYURkemRKa285N0JYQi82?=
 =?utf-8?B?aWtkS1dONU5HUVdHZE9zb0x6YXJzT2JpV2JYc1IwaU9BYWtlMjZkZ09XVXI2?=
 =?utf-8?B?WHB3N2ZnRE5ZZXpYYVVvWWVPRHhwS1NoN3JiZG9WdytuNTNNWXdXU21xT25L?=
 =?utf-8?B?WTlDK1Exa2wyWHQ2QXU4Mlo1TTRybVBIejBYZzU1NG0xT3B2SzlBbGtmNmtW?=
 =?utf-8?B?elBZVFhIcHI3ODJYRGhsVno3RHpJR1IwQkdxanJnYXRXVzRLaGE1NHV1Z3Jp?=
 =?utf-8?B?VGVjajltNUJMT0ZXUXVPU1MvaU5Bb0hqL09meFRXakxGSW9nN29WbmNJeWx0?=
 =?utf-8?B?bGZKNlFocmhvT2RPc2luMEpmdkpMdlNmYVFYbkhJM1NubWNab2t4WnA4Y25m?=
 =?utf-8?B?OVVWMk1MSmFPS1RwWmxzbURkOVdnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <245B63159ABDF1499AEA79D657424FAE@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c06a670-466e-483d-6e1f-08daa335d8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 22:48:09.0659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JsyIffB9sQnts9Fju3h82fH0p4/HhpC5CuRnfXwagZAFXlzx2e9M1/WipWoiKh0tA2VwyWdwB7mZx0Q1pmWQo2BQudWehtNP4BcMX8+v0Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5757

T24gVHVlLCAyMDIyLTA5LTIwIGF0IDE0OjI1ICswMjAwLCBGbG9yaWFuIEJlemRla2Egd3JvdGU6
DQo+IE9uY2UgWGVub21haSB3YXMgcnVubmluZyBhcyBjb21wYXQgYXBwbGljYXRpb24gKD0zMmJp
dCBhcHBsaWNhaXRvbiBvdmVyDQo+IDY0Yml0IGtlcm5lbCkgdGhlIGNhbiBzbW9rZXkgdGVzdCBm
YWlsZWQuIFRoaXMgcGF0Y2ggZml4ZXMgdGhlIHRlc3QgYnkNCj4gaW1wbGVtZW50aW5nIHRoZSBu
ZWNlc3NhcnkgY29tcGF0IGJpdHMuDQo+IA0KPiBBZmZlY3RlZCBpb2N0bHM6DQo+ICAgLSBfUlRJ
T0NfQklORA0KPiAgIC0gX1JUSU9DX1NFVFNPQ0tPUFQNCj4gDQo+IEFmZmVjdGVkIHN5c2NhbGxz
Og0KPiAgIC0gcmVjdm1zZw0KPiAgIC0gc2VuZG1zZw0KPiANCj4gU2lnbmVkLW9mZi1ieTogRmxv
cmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+DQo+IC0tLQ0KPiAga2Vy
bmVsL2RyaXZlcnMvY2FuL3J0Y2FuX3Jhdy5jIHwgNDIgKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDI1IGRlbGV0
aW9ucygtKQ0KPiANCg0KPHNuaXA+DQoNCg0KPiBAQCAtOTIyLDEwICs5MTcsNyBAQCBzc2l6ZV90
IHJ0Y2FuX3Jhd19zZW5kbXNnKHN0cnVjdCBydGRtX2ZkICpmZCwNCj4gICAgICBpZiAocnRkbV9m
ZF9pc191c2VyKGZkKSkgew0KPiAgDQo+ICAJLyogQ29weSBJTyB2ZWN0b3IgZnJvbSB1c2Vyc3Bh
Y2UgKi8NCj4gLQlpZiAoIXJ0ZG1fcndfdXNlcl9vayhmZCwgbXNnLT5tc2dfaW92LA0KPiAtCQkJ
ICAgICBzaXplb2Yoc3RydWN0IGlvdmVjKSkgfHwNCj4gLQkgICAgcnRkbV9jb3B5X2Zyb21fdXNl
cihmZCwgJmlvdl9idWYsIG1zZy0+bXNnX2lvdiwNCj4gLQkJCQlzaXplb2Yoc3RydWN0IGlvdmVj
KSkpIHsNCj4gKwlpZiAocnRkbV9mZF9nZXRfaW92ZWMoZmQsICZpb3ZfYnVmLCBtc2csIGZhbHNl
KSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5e
DQpUbyBnZXQgdGhlIHJ3IGNoZWNrIHRoZSBsYXN0IHBhcmFtZXRlciBzaG91bGQgaGF2ZSBiZWVu
IHRydWUgaGVyZS4NCk5vdGljZWQgd2hpbGUgZ29pbmcgdGhyb3VnaCBhbGwgdGhhdCBhZ2FpbiB0
byBtYWtlIHN1cmUgdGhlIEFQSSBpcw0KY29ycmVjdC4NCg0KSmFuLCB0aGlzIGlzIGFscmVhZHkg
cGFydCBvZiBuZXh0LCBkbyB5b3Ugd2FudCBtZSB0byBzZW5kIHYzIG9yIGNvdWxkDQp5b3UgZGly
ZWN0bHkgZml4IHRoYXQgdXA/DQoNCkJlc3QgcmVnYXJkcywNCkZsb3JpYW4NCg0KPiAgCSAgICBy
ZXQgPSAtRUZBVUxUOw0KPiAgCSAgICBnb3RvIGZpbmFsbHk7DQo+ICAJfQ0KDQo=
