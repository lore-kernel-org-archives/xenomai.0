Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130120.outbound.protection.outlook.com [40.107.13.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EC3201
	for <xenomai@lists.linux.dev>; Thu, 11 Aug 2022 13:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efg0WU/0Hg0zwj9OW0z7tXPJh5qPP0znOK4xZ+KWzXEbOMUz0UKJ4Xdj+UvZlHrf5wEZJ0EFS8gz5p3AthOnjMOah7+j/dN3/3Gy0Cbf4DV0YyVp17RtNjw8Xz5dqe84vJYLwMF63/fiZxmPEQmfJLal0snNF9dkZtwergUts/uxZ5ef/s9xWDus2uiwa4407/1oddiSy8xp1CEmiZI0pb8l/3gtIIiqA0glgxJcD0B8PG97iqQSvS6isbZOGBAIclHjubSF5yiXnONw72A0ZDAbadIcUdNPBUs+na0OsPpPOucuv/D2iq0mV1QXKaUc/FKZO8tV1QxaBlUuFwsE8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VXF6mGldrnHCrvcxMAn5BrgqGVywBEEM1fMAa+LHYAg=;
 b=YfwLzMIBeODm18qAP5zA+rcTlvlObsyx9eNdComE7fA7EbSctnDTI1XJjz2otDKwH1PbSkZXWNDXQwLjZnr/eoj3E6IP5XWPIRF3m+VUOERJMSWLE3wbtFGQmryH9pJhSIMSpO4QDZ3raDi+8rKTCfIOqI4fN7DE9+C35lAmLP2PMm5yB/EcoyGlz7Uk8FPqhCUc9IO88WORjn67cpZ2GXdwqqWG0XOJ/z+19w/LepwqmJng4e/b9SluLdJ60R5pgNWOSUjKuPjtQA0WDAsKOsZY3Hrkcao5rC1AuUnwuVfrgcjDULtWV0LOGm+jPQ1LVQlRiyiDDbH2zCV+tuWQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=philips.com; dmarc=pass action=none header.from=philips.com;
 dkim=pass header.d=philips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VXF6mGldrnHCrvcxMAn5BrgqGVywBEEM1fMAa+LHYAg=;
 b=fYePuAK+Itd22bxlqJahWcdNPxr0CqygFOD0pydVaJ5dqFRvX+wLr3bfSP4C3x/HvLEO/tGXeMqRohznzQZtN1j+f8tsdR0X7wl6rd75dFre7d+WEN8i3uGfwZKjfro7VQckZ+2MCrJ/7PJnAVVUWmhuqK0idv6bTKjfOeZjS4A=
Received: from AM7P122MB0229.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:183::19)
 by AM6P122MB0117.EURP122.PROD.OUTLOOK.COM (2603:10a6:209:71::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 11 Aug
 2022 13:05:16 +0000
Received: from AM7P122MB0229.EURP122.PROD.OUTLOOK.COM
 ([fe80::f9db:3a15:889:d347]) by AM7P122MB0229.EURP122.PROD.OUTLOOK.COM
 ([fe80::f9db:3a15:889:d347%8]) with mapi id 15.20.5504.023; Thu, 11 Aug 2022
 13:05:16 +0000
From: "Grau, Gunter" <gunter.grau@philips.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RE: [PATCH] ipipe: Fix ipipe level irq end
Thread-Topic: [PATCH] ipipe: Fix ipipe level irq end
Thread-Index:
 AQHYHpOub37/2+PVHkidVJ9ThPpzLayWtB4AgADFAACAAAemAIAAUqwAgAARFQCAAAAvAIES4W7w
Date: Thu, 11 Aug 2022 13:05:16 +0000
Message-ID:
 <AM7P122MB022912B3CD5B49D168974AD7F2649@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
References: <94f8dc12-d019-4736-2423-bfacc6b3b0b2@siemens.com>
 <20220217084830.712756-1-gunter.grau@philips.com>
 <dddc8d33-0379-eb0c-f994-264a20bef4e6@siemens.com>
 <CALLqZ8QTq+g7pLx_L68K76ez1XJum8-OkjbC9RJP7tW-VaxdEA@mail.gmail.com>
 <e24f9de7-7170-5c5e-cb8f-07c778b67c21@siemens.com>
 <CALLqZ8THxAWDYMLOCUTKoGjzNt4V-PZtz_hTf2++FLF1QeCytg@mail.gmail.com>
In-Reply-To:
 <CALLqZ8THxAWDYMLOCUTKoGjzNt4V-PZtz_hTf2++FLF1QeCytg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=philips.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cf32168-7cf8-49ed-a8d6-08da7b9a22b9
x-ms-traffictypediagnostic: AM6P122MB0117:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LO2fDMC55n32U2ndtp8HaqsNLOc+erSczRnFrsG0TsYXA4q7aw6dHuQNIee9reLgUaNHyAvUDtWGr8g6bPSxvLj2E/h3Up+E5VKY1/X3VsboOyMBanAD8Q1iMGZ0uicTM0Ou/cmaGJLEZRtIvTRLbJIzQTzA/iKNFr/TKAntfxOs2RBZ1Kj1dB55RjH5xWAfydNDrIG5fvBMh+7u4NWBN934H2cgMnTTrDuZIxl86nERgoNwyOpJUq7WjEFWjMFTbsPEsf1igdSCFJieYeE72reDwZpyOapJcvVOZMYgN8lhsYThA/OySXQowv62OTmgiA48pVxvMA+IZZc3zyHTR/w0ml9y8wOu4RwZ/Sys2bqzADrQoEdqEOr3/tlwa+hg1wlbWYt63YiRiw9Ex5KneCo1DaaDX3GJcc+KmYm3AElvy99V5f50iTYOAmbOyQD/YcF1U3GllXzJZ+v1lrJlg77wRPxmrO1TPcaBp7XnUXlpvE48AbNuY8u6WjrP0Vnww0fQPLGMLg0Q4XEHY3EXZ+QctkEjfFoGm4XXCFQMm9uqhH6k9n4qMlgdYGQDHfPYLV50WhtyOZjh9BV0KKEuuuLaT/oCGU8badilxiGbzCx9fomRFIQtmL4czJK/D9gAi7soVllYaNSTdyXVHcYpC+VHsTqrkQbdq0hcXlpvHwLCZJ57TxV5bkb9fwXn8amrot/MWyE/WGR+oJSN15R/U+WN8kT4Y8EzwxxYcZBVbcBPTqT+Ffvd6RsK/qUHZPdssKYhIugf2dcpunT8CqVSM0H3bo6vulRSaKAMpUYWealRLSnfx3ZDTaJPhv/maR6k
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P122MB0229.EURP122.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(26005)(53546011)(6506007)(9686003)(7696005)(55236004)(71200400001)(86362001)(316002)(6916009)(55016003)(41300700001)(478600001)(122000001)(38070700005)(38100700002)(82960400001)(186003)(8936002)(33656002)(5660300002)(76116006)(52536014)(66446008)(2906002)(64756008)(66476007)(8676002)(66946007)(83380400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlQ3TFJWWWNmOFZpYXpmcS9sVXBOSEhVNnVwYVZDS3RrMmx3R2JycFpub05F?=
 =?utf-8?B?bmM3RXpiNWNwSnEvVFVVNVlUNVF1TmZEOUtqSlVQRm1weXB1c1ZnUHB5WWhZ?=
 =?utf-8?B?ZDRMQldHemh3Q2lscXZRU0JIOXRzMEtPQ0FlbCtXMnRNNXhzeTM0T1NyampX?=
 =?utf-8?B?Ui9xb25lMGZVYWdwNVc0bjFGZVdiKzRUUEZPOGpCMG56NkkyODZEWWwzUFpV?=
 =?utf-8?B?cUNVeTFZanRNNXZZd1QydG9CUEZnamowaEppM2t2SlBxV3lOSS82NStpV3d6?=
 =?utf-8?B?YnlpT0xBZDErK2dSZ0I1cmNRQVpXc09oMmlDZ0xNNEJxNW15UlhKSTM1VmZh?=
 =?utf-8?B?ZkZxY3I0Q0Vta3RtVkNPV29ickl5ZFE2Y1BveG95TnU1VFVBclRvMTgzTVln?=
 =?utf-8?B?ckRtTFVER2pKRXVnYVNJQU1jYkZiemJjRzQraHhyeTJxVlVtaFBUajhmWXFY?=
 =?utf-8?B?Y0UwQm9jZFpaemJCYkIzcU5oVFVBcW8yMnNIT0VRLzVobkw2UGlFUk83UGxy?=
 =?utf-8?B?NTdUUVRjcndTUkovTmlsUjAzMmNFWTZqSmpSZXBtblFQN0R4bzJjOHNWdkkv?=
 =?utf-8?B?TlJSR3Zmcm1Oc3o4SXdOSE5ZbGdJYk5GbEplUGExNjh5QU5mZUttYUFNRGFv?=
 =?utf-8?B?eEMzUHZieG43TjVaQTIrbFI1SlpjbXhkNDAwRTZzeWVJaHdzVDNHOEhwR0pL?=
 =?utf-8?B?eG84K3dIanhud3NsMVhSZzBxeXJwSE5mVDFRdTE3a1ZrMWY4b3lDd2NCYmRD?=
 =?utf-8?B?eDl4SXVFdlh5aHA1V0R3NUhncFEyZ2JxZ3plNHZTQTZUYzlwMnNnTitnajZD?=
 =?utf-8?B?QjFYTXNGZm1RaG4xQ21Dd09qVzlYQVhka0Y3NVJURGlwbmRNRjdwekV2NGVa?=
 =?utf-8?B?T2FCZVNKU01XQUdSOWlmd2JlWlowMDJKNmZFeXVVUm1VUG5ITy9MSkZtdlV2?=
 =?utf-8?B?ZXdCQVhpSGxhWTkzMnFWRUFMb2lqNkprZUdLMlY1eldkSEdzN0VVWGZGTVM0?=
 =?utf-8?B?Q2gwc0RnV1A3STZ5eTU0TVF5MHBxa3Nrd3hBajFwYldxN3JyT3lYNDNzbHdh?=
 =?utf-8?B?UDRna21ZYitVOGVKdW1pN0FIQ1JJZlBzWlNiUHRrQnpEY1JXUXZjcVlaWVdP?=
 =?utf-8?B?Y2pvdEU0czBndkcySlRXY25aSFdqY0NwTGJUOGZPc1VPbjV2TUdBM1gwcjda?=
 =?utf-8?B?QlVoQlBDdm9ZV1Z5cUdaa1ZqdzFyVUVhOEVxMG5SMWFsT1pobUFkR3Zmck56?=
 =?utf-8?B?MXhPR2I3R3lGV0w4VDA1YTZ0c3M1aVNob2xHN051Yy9peEdWaWh5RWhGUXVt?=
 =?utf-8?B?RGpvS3NJTjJEbVQzNHVJOUJoL0tuUW9TQXE1WktJbW5kSVl2K29sWjFQM1Yy?=
 =?utf-8?B?V2ZlR1RFc0VmOGw2UVVHMStJZTJCbFB4Q3FZQXZhYkNsVXVyd1hSQ0Y4ems0?=
 =?utf-8?B?WnZCdnp3YjJoM1JwNG9rVUtSN3lkMGNWWWF6R0ZrRjJIazZmR1F3cEJDeGZl?=
 =?utf-8?B?WGtrbXJ2QmRwb1F3cjJINVZTbkdBSUZLNjFrK3I1NDhpUk9UOFdLT3pobmRo?=
 =?utf-8?B?dkR2WXVDblQrdXZVYnJrWTgxaEYrQ0s3MjJPR09KSEcvTGRnam5ud3hDMHJr?=
 =?utf-8?B?OFFhSnBwcmJDU0JTT3hkNHR3UFJ3SnpEWisvYXpRQ0d3Q3BhMmhWVkVCWDRt?=
 =?utf-8?B?RFJlbDNDN1lkeG5iQVIrd1VMU3JoWmEwWVpiUUFrQUN0TWduKzJ1UzhtZklm?=
 =?utf-8?B?QjB1ODFHdzQ4aTF4eHNMaEw3bkNSRUc2aDZKbXppRFJYcEV5czh4TkE3T2Zo?=
 =?utf-8?B?eUdDMzdUb1NSVFdiYlF6d2VHZk5SM3F3aVJIVXY2YS9nQ2RLd2Y4bWhUK1lw?=
 =?utf-8?B?ajJSRUsyL0hHTzNMaGxKSUNSQWJ4ZE1DczA5MEtPSnk0eHhwM3B3MDFwRVd1?=
 =?utf-8?B?WlFkaXBHS0FSVmdXNDF3UDZ2MlJ4NUVvMFNkYmlIaUYyb3VWSE8zaFhzQnNh?=
 =?utf-8?B?SFpoR0ZxcmFHdGZ5WTIraGQ0MWVpNWVIN1BxdWxTakxrcGZMcU16Q2w0L1VP?=
 =?utf-8?B?ZGN6Wm1DTVl6bGZtbXlhZ0RPN0dXY3N2eVNON0xLcmxHV1JkR2RaME96SUFW?=
 =?utf-8?Q?X6mZ7TDHV+J720cT1/neVVWj5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: philips.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P122MB0229.EURP122.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf32168-7cf8-49ed-a8d6-08da7b9a22b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2022 13:05:16.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xF1uR8hmNKtoiH+XNsOp50bZdWA15WT1QgqL4Jt0FxShBF32mZrIzPnhUMYSrXADvipL++ko5qnCQO067E8ooQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P122MB0117

DQpIaSwNCg0KVW5mb3J0dW5hdGVseSBJIGhhdmUgdG8gY29tZSBiYWNrIHRvIHRoaXMuDQoNCk9u
IFRodSwgRmViIDE3LCAyMDIyIGF0IDEwOjEyIEFNIEphbiBLaXN6a2EgPG1haWx0bzpqYW4ua2lz
emthQHNpZW1lbnMuY29tPiB3cm90ZToNCk9uIDE3LjAyLjIyIDE1OjExLCBHcmVnIEdhbGxhZ2hl
ciB3cm90ZToNCj4NCj4NCj4gT24gVGh1LCBGZWIgMTcsIDIwMjIgYXQgNDoxNSBBTSBKYW4gS2lz
emthIDxtYWlsdG86amFuLmtpc3prYUBzaWVtZW5zLmNvbQ0KPiA8bWFpbHRvOm1haWx0bzpqYW4u
a2lzemthQHNpZW1lbnMuY29tPj4gd3JvdGU6DQo+DQo+ICAgICBPbiAxNy4wMi4yMiAwOTo0OCwg
R3VudGVyIEdyYXUgdmlhIFhlbm9tYWkgd3JvdGU6DQo+ICAgICA+IFRoZSBmb2xsb3dpbmcgY29t
bWl0IGluIHRoZSB2YW5pbGxhIGtlcm5lbCBpbnRyb2R1Y2VkDQo+ICAgICA+IGEgY2hlY2sgZm9y
IHRoZSBjYWNoZWQgaW50ZXJydXB0IG1hc2sgZmxhZyBpbiBtYXNrX2lycSgpOg0KPiAgICAgPg0K
PiAgICAgPiBiZjIyZmY0NWJlZDYgKCJnZW5pcnE6IEF2b2lkIHVubmVjZXNzYXJ5IGxvdyBsZXZl
bCBpcnEgZnVuY3Rpb24NCj4gICAgIGNhbGxzIikNCj4gICAgID4NCj4gICAgID4gVGhpcyBtZWFu
cyBpZiB0aGUgZmxhZyBpcyBub3Qgc2VydmljZWQgY29ycmVjdGx5DQo+ICAgICA+IHRoZSByZWFs
IGJpdCBpbiB0aGUgaGFyZHdhcmUgaW50ZXJydXB0IGNvbnRyb2xsZXIgbWF5IG5vdCBiZQ0KPiAg
ICAgPiBjbGVhcmVkIG9yIHNldC4NCj4gICAgID4gVGhlIF9faXBpcGVfZW5kX2xldmVsX2lycSgp
IGZ1bmN0aW9uIGRvZXMgbm90IGZvbGxvdyB0aGlzIHJ1bGUuDQo+ICAgICA+IEl0IHVubWFza3Mg
dGhlIGJpdCBpbiB0aGUgaGFyZHdhcmUgd2l0aG91dCBzZXR0aW5nIHRoZSBjYWNoZWQgZmxhZ3MN
Cj4gICAgID4gYWNjb3JkaW5nbHkuIFNvIGFmdGVyIHRoZSBmaXJzdCBsZXZlbCBpbnRlcnJ1cHQg
aXMgZmluaXNoZWQgdGhlDQo+ICAgICA+IG1hc2sgY2FjaGUgaGFzIGEgd3Jvbmcgc3RhdGUuIElm
IG5vdyB0aGUgbmV4dCBpbnRlcnJ1cHQgZmlyZXMsDQo+ICAgICA+IHRoZSBtYXNrX2lycSgpIGZ1
bmN0aW9uIHdpbGwgbm90IHJlYWxseSBtYXNrIHRoZSBpbnRlcnJ1cHQgaW4NCj4gICAgID4gdGhl
IGhhcmR3YXJlIHdoaWNoIGNhdXNlcyBhIGludGVycnVwdCBzdG9ybSBhZnRlciByZWVuYWJlbGlu
Zw0KPiAgICAgPiB0aGUgaGFyZCBpcnFzLg0KPiAgICAgPiBUaGUgZml4IG5vdyBhbHNvIHVwZGF0
ZXMgdGhlIHNoYWRvdyBmbGFnIGNvcnJlY3RseS4NCj4gICAgID4gLS0tDQo+ICAgICA+ICBrZXJu
ZWwvaXJxL2NoaXAuYyB8IDEgKw0KPiAgICAgPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+ICAgICA+DQo+ICAgICA+IGRpZmYgLS1naXQgYS9rZXJuZWwvaXJxL2NoaXAuYyBiL2tl
cm5lbC9pcnEvY2hpcC5jDQo+ICAgICA+IGluZGV4IDdjMDNlMjkzMTE4OS4uZmY5YThiM2YzM2Ri
IDEwMDY0NA0KPiAgICAgPiAtLS0gYS9rZXJuZWwvaXJxL2NoaXAuYw0KPiAgICAgPiArKysgYi9r
ZXJuZWwvaXJxL2NoaXAuYw0KPiAgICAgPiBAQCAtOTg4LDYgKzk4OCw3IEBAIHZvaWQgX19pcGlw
ZV9hY2tfbGV2ZWxfaXJxKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4gICAgID4gIHZvaWQgX19p
cGlwZV9lbmRfbGV2ZWxfaXJxKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4gICAgID4gIHsNCj4g
ICAgID4gICAgICAgICBkZXNjLT5pcnFfZGF0YS5jaGlwLT5pcnFfdW5tYXNrKCZkZXNjLT5pcnFf
ZGF0YSk7DQo+ICAgICA+ICsgICAgICAgaXJxX3N0YXRlX2Nscl9tYXNrZWQoZGVzYyk7DQo+ICAg
ICA+ICB9DQo+ICAgICA+DQo+ICAgICA+ICB2b2lkIF9faXBpcGVfYWNrX2Zhc3Rlb2lfaXJxKHN0
cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4gICAgID4gLS0NCj4gICAgID4gMi4yNS4xDQo+ICAgICA+
DQoNCldlIGRpc2NvdmVyZWQgc29tZSBzaXR1YXRpb25zICh3aXRoIGlpbyBkcml2ZXJzKSB3aGVy
ZSB0aGlzIGZpeCBzZWVtIG5vdCB0byB3b3JrLg0KT2J2aW91c2x5IGluIHRoZSBtb21lbnQgd2hl
cmUgdGhlIGlycSBpcyB1bm1hc2tlZCwgdGhlIG5ldyBpbnRlcnJ1cHQgc2VlbXMgdG8gZmlyZSBh
Z2FpbiBhbmQgdGhlIGlycV9hY2soKSBjb2RlIG9mIHRoZSBuZXcgaW50ZXJydXB0IHJ1bnMgYmVm
b3JlIHRoZSBpcnFfc3RhdHNfY2xyX21hc2tlZCgpIGlzIGNhbGxlZC4NCldoZW4gSSB3cm90ZSB0
aGUgcGF0Y2ggSSB0aG91Z2h0IHRoZSBpcnFzIGFyZSBkaXNhYmxlZCBhdCB0aGlzIG1vbWVudC4g
TG9va3MgbGlrZSB0aGlzIGlzIG5vdCB0aGUgY2FzZS4gQXQgbGVhc3Qgd2hlbiBJIGNoYW5nZSB0
aGUgb3JkZXIgdG86DQoNCmlycV9zdGF0ZV9jbHJfbWFza2VkKGRlc2MpOw0KZGVzYy0+aXJxX2Rh
dGEuY2hpcC0+aXJxX3VubWFzaygmZGVzYy0+aXJxX2RhdGEpOw0KDQpNeSB1c2UgY2FzZSB3b3Jr
cyBhZ2Fpbi4NCk5vdyBJIGFtIHVuc3VyZSBpZiB0aGUgYWJvdmUgcmVvcmRlcmluZyBpcyB0aGUg
Y29ycmVjdCBzb2x1dGlvbiBvciBtYXliZSBqdXN0IGNhbGxpbmcgdW5tYXNrX2lycSgpOyB3aGlj
aCB3YXMgdGhlIGZpcnN0IHByb3Bvc2FsIGlzIGJldHRlcj8NCldlIGRyb3BwZWQgdW5tYXNrX2ly
cSgpIHByb3Bvc2FsIGJlY2F1c2UgaXQgZG9lcyBhZGRpdGlvbmFsbHkgc29tZSBsb2NraW5nLCBi
dXQgbWF5YmUgdGhpcyBpcyBuZWVkZWQuIEkgYW0gdW5zdXJlLg0KDQpEbyB5b3UgaGF2ZSBzb21l
IGFkdmljZT8NCg0KVGhhbmtzIGluIGFkdmFuY2UsDQpHdW50ZXINCg0KPg0KPiAgICAgVGhhbmtz
LCBhcHBsaWVkIHRvIGlwaXBlLW5vYXJjaC4gSSBoYWQgdG8gZG8gdGhhdCBtYW51YWxseSBhcyB5
b3UgZW1haWwNCj4gICAgIGNsaWVudCBtYW5hZ2VkIHRoZSBwYXRjaCAodGFicy0+c3BhY2VzLCB0
cmFpbGluZyBzcGFjZXMgcmVtb3ZlZCkuIFVzZQ0KPiAgICAgZ2l0LXNlbmQtZW1haWwgb3IgYSBj
bGllbnQgdGhhdCBhdm9pZHMgdGhpcyBtYW5nbGluZy4NCj4NCj4gICAgIEdyZWcsIEkgd2lsbCBh
cHBseSB0aGlzIHRvIGlwaXBlLXg4NiAoNC4xOS1jaXAgYW5kIDUuNCksIGNvdWxkIHlvdSBkbw0K
PiAgICAgdGhlIHNhbWUgZm9yIGFybSBhbmQgYXJtNjQ/DQo+DQo+ICAgICBUaGFua3MsDQo+ICAg
ICBKYW4NCj4NCj4gICAgIC0tDQo+ICAgICBTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+DQo+DQo+
ICAgICBDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0KPg0KPg0KPiBZZXAsIEnigJl2
ZSBhcHBsaWVkIHRoZSBwYXRjaCBsb2NhbGx5LCBJ4oCZbGwgdXBkYXRlIGFybSBhbmQgYXJtNjQg
c2hvcnRseS4NCj4NCg0KDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpUaGUg
aW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgbWVzc2FnZSBtYXkgYmUgY29uZmlkZW50aWFs
IGFuZCBsZWdhbGx5IHByb3RlY3RlZCB1bmRlciBhcHBsaWNhYmxlIGxhdy4gVGhlIG1lc3NhZ2Ug
aXMgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgYWRkcmVzc2VlKHMpLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJlIGhlcmVieSBub3RpZmllZCB0aGF0IGFueSB1
c2UsIGZvcndhcmRpbmcsIGRpc3NlbWluYXRpb24sIG9yIHJlcHJvZHVjdGlvbiBvZiB0aGlzIG1l
c3NhZ2UgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVy
IGJ5IHJldHVybiBlLW1haWwgYW5kIGRlc3Ryb3kgYWxsIGNvcGllcyBvZiB0aGUgb3JpZ2luYWwg
bWVzc2FnZS4NCg==
