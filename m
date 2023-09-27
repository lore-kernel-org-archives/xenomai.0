Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2087.outbound.protection.outlook.com [40.107.128.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32F10E5
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 00:00:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLco0lhjulfOo/qH1etlcovzYg1/OQr8VRr8NKwMznRYKBA3ZzntD9nC/9oFfp0vw9GBwF+7DSAM6ZMOaZMRlGBqNChGIyeHDonk7QBzE4hiQ/fbywkC5EOaDRxAYM1CgVA7gyVgaZyBh4H+MQRD6qJUVeyT3ZlBOCEtPMxcQazGXmOrhBM/L18L7bijtzfhR79FBLbrFI3NDDMTGa3wbendImyUKvDeYXAooe1Jr8t0S8z23gRmXAEjojSmezHyoK9oCma+aVwCQViTwysG+SzDX7aTDZdTFMEf4SKLoDK/9imNqN7HgqlHYQnRD3eVbZWOZb/GHP4LpR5+IWR0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9zvsQk3Re+mrAFXIKXzoRDKh4vDVRoh2fOe1/C+Rn8=;
 b=RM6eBywUe36mu+wFN5gAMhCVAPn2b11r6sya0MJ4rchbMhppSR7bVsIFagrIU2WQGNdr8SDrSziwgFhzCLzbzX0oEElfjC+O0EcKL93+jnHcAW0DeXfKi3vhXUi2HjrQqFN50/D2qTjPnqWHDnnah9JcIA7TEReB8MbXSm0oiki2jcuZCxMluJVQMQ3NMSeoOnMFUy0EgKrwvLFVWQlNylAl2xk9qzr6syYS5vsE4H6Mwjjk0hsPWOLH+FevH3EUNitWZ2xBejS3U1h3VPaGylTdUQIK8CjlQR/gTfglBL2UlVJA9NMHrMT12Ko5HH45zHzJgolrOgnt/iEZzGcWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Doosan.onmicrosoft.com; s=selector1-Doosan-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9zvsQk3Re+mrAFXIKXzoRDKh4vDVRoh2fOe1/C+Rn8=;
 b=vwfHBo3XUQ/9surapcOYC0NHDbKL/Z9/JAI5+/hYS03C0oH6kKcldxoJkq5oYGJERKT4T/OE66P0j0xxRQAe81oLapy8639t5D0lXEXWqxlV3JQNtiLs0kVYTXpGfhlzafqF437jxyoc02pperEtlriFoc0/6pqKqZvmNJU8kH8=
Received: from PS2P216MB1330.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a0::13)
 by SE1P216MB1383.KORP216.PROD.OUTLOOK.COM (2603:1096:101:b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Wed, 27 Sep 2023 00:00:41 +0000
Received: from PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
 ([fe80::9fa6:9f51:bc2:66eb]) by PS2P216MB1330.KORP216.PROD.OUTLOOK.COM
 ([fe80::9fa6:9f51:bc2:66eb%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 00:00:41 +0000
From: =?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ0g65GQ7IKw66Gc67O0?=
 =?utf-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Xenomai <xenomai@lists.linux.dev>
Subject: RE: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Thread-Topic: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Thread-Index:
 AQHZ8Dvh6PD2J1eeWE61B2j5eRG+6bAsl5qAgAAOhXCAAAmgAIAAB1KwgAAEXACAAAs+MIAAGW8AgADpjoA=
Date: Wed, 27 Sep 2023 00:00:40 +0000
Message-ID:
 <PS2P216MB13302C5C07803246F00BC220D1C2A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
 <PS2P216MB13309086E38D6FFB0E59C2A2D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <41ce2ea0-5e13-4c4d-ada9-9c9f5c296e0a@siemens.com>
 <PS2P216MB13302E4AB022FA29FAC6E510D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <391a0665-1236-4ace-88bb-33e206ed4b18@siemens.com>
In-Reply-To: <391a0665-1236-4ace-88bb-33e206ed4b18@siemens.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doosan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2P216MB1330:EE_|SE1P216MB1383:EE_
x-ms-office365-filtering-correlation-id: 36a03e72-e75c-4943-056f-08dbbeecc994
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rG9pMe8QWB0CqfBarKnXqDSUiF+8GkRzwJcux+TqwFMnUrDOaccu1IDUqv0tX+F9+4+I0i7tHlDQKfbsPdhCov0WrmePSrzuL5XobLVIEGuJJHeUB12JSzzti3hGiab4n9qjI/rPDexM5OP6D/pimIV5ReHyPOdIRsxxlV7HXBhou6XeF1bhAh96tvAx9lb0BRHzuVhvQz0XB5oyV39tpcsOuBovIpRGUCSUFmTtI40aL7DhtjLLxQfBhS1OBQ3A/Jnp0+/stUDwYvVABjgZ9Oveqgfqe60s3oNtQbADYGNQe13RAVmOaC74qVVA16eHxGz/G4CcWkKAAsv5j7pWyvOhp9I6/UYJmYftAoRqf4h3mC2mNZcGXfpBmrKixLgibKNF5HQJzAGzxrTEut5YgT4Eo/ukF38nnOqKz3Qdb4Tl+z11Mca+ci+EEf2N+UZ3m5UJvssFIejNpZ529TKtutjxZ2qmgo/GKvsB/iEVcEhDO7gcjhkdFXgY37pvWqDXTdHh1hl2LejLtbTsi9xqDY1GCDEckGx+WmxqDnRHBkjfHRlk9SrZAJxMgZjF6qzwq8oSed0mQkA90EjGcoXp/HWb8a+by76pUGGGycIV+2ovv9iMXYyM8Y7DHvldM8OF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2P216MB1330.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(38100700002)(38070700005)(33656002)(86362001)(53546011)(55016003)(5660300002)(66476007)(2906002)(478600001)(66556008)(41300700001)(52536014)(76116006)(64756008)(66946007)(66446008)(6916009)(122000001)(71200400001)(7696005)(6506007)(9686003)(83380400001)(4326008)(8676002)(8936002)(316002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTJzK210M0xpMEtqNkl0Y0Q1T0ZnbkF1ZVRxcm44dUhzM04yVHAxelY3QjRS?=
 =?utf-8?B?MkhNejZ6ZUt3RTNmUjQyK0ZtODlGSlJEbVUvRHJ1MTJFYlhKU0xFSnVYblAv?=
 =?utf-8?B?cFRuM1BjQmVGaElkSnJwL3pxdk9pY0szVDZLektBMExSNlZGeWdDdUIrZGlM?=
 =?utf-8?B?clA4YlRtWThCTXJhcXB5cVdZRjBlK2lGQ1dqRVF6TkFxQlBLcURBZXlwZjFq?=
 =?utf-8?B?SVkzVWNadHViTDU0WEZhaEdUZ0tHbk5qU1R2TDg1aVFmYzhFRk9TblNVVGlm?=
 =?utf-8?B?QXdIemZuTWdNdmtXbndYWTM0aVV1WE9RbCtmc0JyS0ZETG9YSmFZSThMc2tL?=
 =?utf-8?B?YnFxbk5KZjYySk9RUi8wbWhicnlUM3lNMm9qdjd2NUxsanBLay9tSFhDOWxq?=
 =?utf-8?B?QTg5ajBENnRPY1Y1TFVNVDUvNUNjVDNvc2VMUHUyNHdTcnJZV1Bob2lWK3hl?=
 =?utf-8?B?S2VSR2dONXc4L053R0d1c2VHQmI5TFZtS1AyRXlsbVdTczkvSDBwekd5Vi8z?=
 =?utf-8?B?Q0syeGVkZHZOZnlTMXNQdHpVeVpnUVpSWTdiVDREWnVQcVVPbjdMNjZJZmd4?=
 =?utf-8?B?OUdQUzRiRDhLdFJNZ1RjelVoWjc0RW9FbG5uOHVMckh3SnJ4RGNiMTN5dC84?=
 =?utf-8?B?bytpWEFUWEJjcTZSOTFIdkNoSkhUbXhpR3ZZYWNSRXpFeE1qcUcwdWVScmY5?=
 =?utf-8?B?aUE0L1ZkZkVJNjg1dURaeDVaSFIxVHhKLzlxdGtyQ1RZakJPbXEvZVkyZ0pX?=
 =?utf-8?B?bTJFTjh6eEI2ZGdISUtwUXh3TTZPWUwrT1ZxUVBjeHN5VW5xaisrSVF6djRa?=
 =?utf-8?B?Ty96RXc3VytQekY1Z04xSWhZaDZnZGhDS28vTFd2VHJaSmZwdUl1QUhnMzdt?=
 =?utf-8?B?VW8xUEpEeWpka1Ntc1o3NmkwdWZTYWlobzFJVDJ4cStnOSswS0tZYlNtYUlE?=
 =?utf-8?B?dW5lc2tBSjh5ZVlYZldVYnlSeUlQQTJBaDhKNVJIenFGbFh6NUsvVElIZVll?=
 =?utf-8?B?bTZ5dnVaeENRZVJNVFdVV2ZwU0UvaDlxdDlHSnJHUlpDT0x2UFBZWEFCbHd2?=
 =?utf-8?B?T3VJdjM5ZE5WUlIrRU9hRlZFVGJ2NS9WMm5yR1FreVVOQ2hPOW5EVkVtOGQw?=
 =?utf-8?B?dUpURTZUakszb0VISFloM0FPdHhXS2k5NmF1eEtrQU1jblgxMXJ3Q3dDdHZr?=
 =?utf-8?B?VlpGc1Q1MHZLckF0TFVrazQxMGRBTFpyanpUM2R0TmswVnJnOTRIc1R0NWt2?=
 =?utf-8?B?WUc1bThRSTBLeDBkTjlBTTQvU2xkV1FHRStLVjlhN04vMHIvaUkvSVlXUjMr?=
 =?utf-8?B?RUhVY0Vab3JoaXZUbnEwUDYxcVNSRk5zRkdhZVErK2p0c2REZFkrTE5VVFNz?=
 =?utf-8?B?N2JSNjJteDdjWDRtdGVWQ3ZSQTZTOWcvamcrM3AvN25keUJDWkJBNkUySjNs?=
 =?utf-8?B?MloyRko1bVhSL0t2NERZQ2pmdnRCVG5UQWxjRTZFTC8vT2FNbUdRT3JZTk1B?=
 =?utf-8?B?emZSZVprb2tVdWhLdlpaV2F0ZUFkM2Z1R1o0NlFLSGowU1B2bnIwbjFTdkEv?=
 =?utf-8?B?NnlJSkx6TjJYMzZMMVphbTJjaWdVYkxiM0pJTWYzb1FjQmpvRHhaMmtiUTFS?=
 =?utf-8?B?Sm5hd3dVSTR4K0VNZm5qNnlyaXI5a3RGL01pZEJWYmNUbUh2UVNRMkRXQURa?=
 =?utf-8?B?dlZRRGIrVW1KbEhQTjVLa1I1dE04eUZNZHZjc1orajNwWWJVZVhZSlJSNUxV?=
 =?utf-8?B?MVpBaFNBNEV1SnJkR2FrTjQvZVcvRUpqRlllUFI1SEZQdWhXcEZ5NXNnUCsw?=
 =?utf-8?B?WDh3eWVseURTdFByRkE2eGxUaGREU0RIQlFrZnZKQUw3Mk1EcXFwTnZObjF3?=
 =?utf-8?B?RlFYTCtvc0dERk5VTTJlMzBvdEQwV240Vm4ydHNwbGpKTEQ3SkVaL2g5dDNr?=
 =?utf-8?B?U0UvdkJJMityb2FFdEJNUkV0dktyK0dxNXJ1M1pSbVhQMGJRMlEwZlB6dFRw?=
 =?utf-8?B?RTZYY1BaZTR6RFk5eDBpek5ZTGhOTUdON3ltN25xdHh0Nmhnb0dSbWM0R1Ix?=
 =?utf-8?B?clc4ODMxck0xMS9nL3JJaDdUY0QweFQ5RUNadXhwM3RqRml0QWJ1V2NLWXZq?=
 =?utf-8?B?NTFranhVTUt4UFl5Qi9GWVVHL1A2ZFkwaG9jM29CdGpEY3dIR2lSUkxTOFVW?=
 =?utf-8?B?bkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a03e72-e75c-4943-056f-08dbbeecc994
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 00:00:40.6038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TDmWx6xoPX6oTZEoAQTLDfiBOY5GJvpipb+CkITQ4UST/nNxgZ/WA5YyGAaPNaYJYUXy5wW4NZVZTp7VbqLRczpMhibEfYS6AsatAiMkJSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1383

VGhhbmsgeW91LCBidXQgdGhlcmUgaXMgbm8gZGV0YWlsZWQgbWFudWFsDQpJdCdzIHNvIGRpZmZl
cmVudCBmcm9tIGJlZm9yZSB0aGF0IGl0J3MgY29uZnVzaW5nDQoNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IA0K
U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI2LCAyMDIzIDc6MDEgUE0NClRvOiDrsJXqsr3tm4go
S3l1bmdob29uIFBhcmspIOyImOyEnSDrkZDsgrDroZzrs7Tti7HsiqQgPGt5dW5naG9vbjIucGFy
a0Bkb29zYW4uY29tPg0KQ2M6IFhlbm9tYWkgPHhlbm9tYWlAbGlzdHMubGludXguZGV2Pg0KU3Vi
amVjdDogUmU6IFNoZWxsIGNvbW1hbmQgc2VnZmF1bHQgb2NjdXJyZW5jZSBwaGVub21lbm9uIHdo
ZW4geGVub21haSB0YXNrIHN3aXRjaGluZyBydW5uaW5nDQoNCuyjvOydmDog7J20IOuplOydvOyd
gCDsmbjrtoDsl5DshJwg67Cc7IahIOuQmOyXiOyKteuLiOuLpC4g66eB7YGsIO2YueydgCDssqjr
toDtjIzsnbwg7Je0656MIOyLnCDso7zsnZjtlZjsi5zquLAg67CU656N64uI64ukLg0KDQpDQVVU
SU9OOiBUaGlzIGVtYWlsIGlzIHNlbnQgYnkgYW4gZXh0ZXJuYWwgYWNjb3VudC4gUGxlYXNlIHRh
a2UgZXh0cmEgY2F1dGlvbiB3aGVuIGNsaWNraW5nIHRoZSBsaW5rIG9yIG9wZW5pbmcgdGhlIGF0
dGFjaG1lbnQuDQoNCk9uIDI2LjA5LjIzIDEwOjM3LCDrsJXqsr3tm4goS3l1bmdob29uIFBhcmsp
IOyImOyEnSDrkZDsgrDroZzrs7Tti7HsiqQgd3JvdGU6DQo+IEkgbWV0IGEgYnVpbGQgZXJyb3Ig
YXMgYmVsb3cNCj4NCj4NCj4gYXJjaC94ODYva2VybmVsL3RzYy5jOiBJbiBmdW5jdGlvbiDigJh0
c2NfcmVmaW5lX2NhbGlicmF0aW9uX3dvcmvigJk6DQo+IGFyY2gveDg2L2tlcm5lbC90c2MuYzox
MzczOjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhfX2lwaXBl
X3JlcG9ydF9jbG9ja2YgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVxX3VwZGF0ZeKAmTsgZGlkIHlvdSBtZWFuIOKAmF9faXBpcGVf
cmVwb3J0X2NsZWFudXDigJk/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW8g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF0NCj4gIDEzNzMgfCAgX19pcGlwZV9yZXBvcnRfY2xvY2tmcmVxX3VwZGF0ZShpcGlwZV9m
cmVxKTsNCj4NCj4NCj4gVGhlIG1hY3JvICJfX2lwaXBlX3JlcG9ydF9jbG9ja2ZyZXFfdXBkYXRl
IiBpcyBkZWZpbmVkIGxpbnV4L2lwaXBlLmgNCj4NCj4gQ09ORklHX1g4Nl9UU0MgaXMgZW5hYmxl
ZC4NCj4NCj4gV2hhdCdzIHByb2JsZW0gPw0KDQpUaGVyZSBhcmUgdHdvDQoNCi0geW91IGFyZSBi
dWlsZGluZyB3aXRoIENPTkZJR19JUElQRSBkaXNhYmxlZA0KLSBvdXIgcGF0Y2ggZG9lcyBub3Qg
aGFuZGxlIHRoYXQgY2FzZQ0KDQpXZSB3aWxsIGFkZHJlc3MgdGhlIGxhdHRlciBpbiB0aGUgbmV4
dCBJLXBpcGUgdXBkYXRlLCBidXQgeW91IHNob3VsZCBsb29rIGFnYWluIGludG8gaG93IHlvdSBj
b25maWd1cmVkIHlvdXIga2VybmVsIGJ1aWxkLg0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIFRl
Y2hub2xvZ3kNCkxpbnV4IEV4cGVydCBDZW50ZXINCg0K
