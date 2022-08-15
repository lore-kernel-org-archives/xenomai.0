Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20112.outbound.protection.outlook.com [40.107.2.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD34EBC
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 12:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmQogq6CZIzusCUWCqGBZPwYXLqtmhND1vV5+ckCj+l713mz9F9lyh5HPb5N15MKJwPBQJpBFJbWirc+kUJP3/n7UbKmzMPBO338mBJ0DVQhrWuGi+9eKmGRz1hjg9rqlDV/URuAzF/vK9aLPgPBTo4VZGyyiSQNjwkGLS2xxG4iUZ3Wdxq/Y6D6oNYoZgLHmukd2mH52AzI5xCe0QkeVAcqdyWaeLSyjlcaMtSgOccSVShwtsaS7UkhlV173Gny7F8HB8mJpdBIanmvPT4PTElr0wL7mgFKEsVGsDFuy89eoDmgu9TxH6nTNEJ8uN6nPyBS+fDx04Xu7OBw7ILo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhoHR5XnHDRdJfel1iUQXJT3id58CYXl57rEZulqjbA=;
 b=N+3oQWcQZcaEyN5GuvhBQwbO3RpO3z7hzgisPiptuSl/jkDWV/yJaq8j8arDt8e8wbm7RqpO9tdMH6bLVf2Bolhu0uN0crdYBf0tocxf81aJOB5mu9MV+xb0OW7EQHp6lOpPOqCseIMt0usEmXZH6djVAcejpqO1yRiKlg2UOXdN8iJ5Yk4wWMTI6VC9nt8wKrvTTu3Ij87SZiLiJXNLHiJeF5hT/mA6JIN7gChUE+9w7UwVwYpDuYs3qzriVSyvArLiS42mmyvWpSvjuaujsWJE8eU+YrDlxiUpNjLov0YnBP2MtpXrp8KIML5W5yfnBZTFZOsz9EXpRcnoubzT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=philips.com; dmarc=pass action=none header.from=philips.com;
 dkim=pass header.d=philips.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philips.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhoHR5XnHDRdJfel1iUQXJT3id58CYXl57rEZulqjbA=;
 b=CFcviHB1rH8EHuUFAw+UEvCg+dQFkMzN2mRyfX/QH6+y+a82fJKgKtiw7swKINnCGpKtxf3ySbvBqO5IcNBWIyTkzwGme2EShK9CV/IigXNtIjKZFM1tfgTmjjiwL/NWLv/0o3hC9yBOShdipX4vzKoRQpBkj9d13y7epN0RDig=
Received: from AM7P122MB0229.EURP122.PROD.OUTLOOK.COM (2603:10a6:20b:183::19)
 by DB9P122MB0285.EURP122.PROD.OUTLOOK.COM (2603:10a6:10:1dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 12:31:54 +0000
Received: from AM7P122MB0229.EURP122.PROD.OUTLOOK.COM
 ([fe80::f9db:3a15:889:d347]) by AM7P122MB0229.EURP122.PROD.OUTLOOK.COM
 ([fe80::f9db:3a15:889:d347%6]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 12:31:54 +0000
From: "Grau, Gunter" <gunter.grau@philips.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: [[I-PIPE PATCH]] ipipe: noarch: Fix ipipe level end interrupt
Thread-Topic: [[I-PIPE PATCH]] ipipe: noarch: Fix ipipe level end interrupt
Thread-Index: AQHYsJGW38T91i6BmkaW69FgQbD/x62v2t8AgAAIiPA=
Date: Mon, 15 Aug 2022 12:31:54 +0000
Message-ID:
 <AM7P122MB022912FC857E9E50CE2B1063F2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
References:
 <AM7P122MB022949A2E0ADC59FCC8809BBF2689@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
 <20220815102704.1825151-1-guntgrau@bbl.ms.philips.com>
 <72810e59-33db-821a-64c1-8e2c41bdacd4@siemens.com>
In-Reply-To: <72810e59-33db-821a-64c1-8e2c41bdacd4@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=philips.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b904736-fc0d-4b85-2590-08da7eba2341
x-ms-traffictypediagnostic: DB9P122MB0285:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5ab+2SzSZa/K6c1pCQzIkloF+EycRFRDFIJLd668HxgD8j0UtS69uMgxAjFZSHF3b3/fjIvfPS/DMxC/UT2yNlYCFQR1GkZo3CTN/qvfqID84+ZhW7PsE8zO508A3dgcJOXS+v7jQD6Ftkl7gYR6XQhhoiQgFh+RPny5Iblaji/K66V7I/CON2A65gKNQnWVbLxl81XzpQGvUGJuDRPQui/sJBblqQL02/9/T5WVk/RJ6WNwC7xZ/tJF593g33lsByAt5uPOygaY/SabnTWc5P6cI3mZbM5yVtN6px7FVl7VYuPXOfdRGwLlFH4fyZnRVE5z7AfdMoRhhXXIy9lM+7U8uLXYwcwW6G2ZwfscN41lfdihStzvZR1pIMDuh6zp77BZHWmI5KooqTzDc7rLuSLZGb/6YHHp1aqRO64ZzCwQNdJujbczDVOCaec/4rOBmwsS0QUEODUhWW4JvLFsg2Tby381XaH9Ie48o6miIUB0/kH5rchGs+RqVY0kOJAOBJub3FX8YVs45nOdx7WwyNQqbT3S77ZCZG6VqivgcNaMZmVxGrH27n0w16QyThiPMTlsETYn25ENVeRUty3FOlBmQRpHVKzDlcKd+t0TZmLKdLyGKhbRyBDO9ipW1iUPTfLevuFMwn6iuDepFQNhUb1JOOodgATjJ0oRYEwGURdm+SaftKxRnc94BtCZSlk3p7G8hGWnCESu3w66eHamCamh2ZTCxZzBVZ2+3cMy4Y+Z2ZkE4UxWzSJ163hFw49RGctq2VyGlz0rE+d4Uwo203D+ay6sBvHH/Z5syyRfbX75Xq0bNXj8ZHT/kL92r2YkiqoPkQW1+RxHBPB8y+2Ehw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P122MB0229.EURP122.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(55016003)(110136005)(316002)(83380400001)(71200400001)(8676002)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(9686003)(26005)(5660300002)(8936002)(52536014)(33656002)(86362001)(186003)(478600001)(38070700005)(82960400001)(7696005)(6506007)(53546011)(41300700001)(55236004)(122000001)(2906002)(38100700002)(87944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWgvSUE0NG4wQURNVFFGRWpQWllVeDNvc0orZmVJMUx4VldWYlFZWG43dWJl?=
 =?utf-8?B?WWNGQk9STWttN3VoTVhJemlVTTNxRzBpQXFSR2I5U1FUTmJQNFB4blV6TXJv?=
 =?utf-8?B?THA1UisveFJQSlBLRXpMa0Ywekt0Smxvb0RZSjdqWW8xZEp5WDVibjc4ekRo?=
 =?utf-8?B?WUhOMTZKTUhGU1Y3NU9sVG1JcG9ZTHZkWTdBTGdhT0VNRll1SnVSdThkN3lX?=
 =?utf-8?B?ZGd6ejJncWtHQ0hVZWlNb2JVNkRrU01TdDc3QU5vNTlzWVFRSVFrb2VzcTZO?=
 =?utf-8?B?T09MYkVoWDhBN21WNTl0WjNQUDZJY3hWSjRCZFczM2JCQzEyaUtpbVNVbVZH?=
 =?utf-8?B?NmVmaUZLS3l4VVQzY3NMUS9FTisxeTVoc2FVSmFFN2xZKytPYTU0b1NNeFFK?=
 =?utf-8?B?YlBhWHFSS3V5clVQR1hYQ0o1THhOUjhmRE9BL1dLcjNyc08rWUt5ZERTOFVG?=
 =?utf-8?B?MzZ6ZE52OTZ6WlBZeXVXVmRGNXZqT2cvV0tJNUZJNjN5QlJMZXluczkxcUlJ?=
 =?utf-8?B?N2tIQ0FiSnpBME80aVlLZHVzOUlYdjNVckFiZ3hCVWRVbCt3cm5TMFgvVHBE?=
 =?utf-8?B?TmYwK3NMWkxxZFUyWm12enhUSmdnNDUzc1ZvbyszOThHRTJuclowRnNJZVlR?=
 =?utf-8?B?RGVEc2ZlNVgxWHIycFRoM2FQams2a2NId3paUzVUYWUzL0ZHd0syVkd6V2xo?=
 =?utf-8?B?VEtjUnlTUDlFTVZaOGJkc1dSZk1JRTArN2FWYTlCMU9yZm5UdUxQc2xXekU5?=
 =?utf-8?B?TCtKaE00TG1uQnJ4Sk9XZlJVOHhud25ZNkk1YWh5b1h5b2ZBZHlBenZLa0oy?=
 =?utf-8?B?MDFzemVhcC9GVVVKcGFtR2hPbEltajZ3REtTY2NxbjN5ZzNpNy9UOFhGL1hH?=
 =?utf-8?B?Z0VycmpmKytod3gvYko2MnMyMHQvVUVJVFlNSUdTUmkxaTc3QVB4S0h2dVZa?=
 =?utf-8?B?c085NGlUVDNHMldNL0Jwbk1JM3VKWFhHaTFWdThueEQrQ3Z3QkhuUnlMcENj?=
 =?utf-8?B?UlU5ODNIak1SZ3ltU3RJaGViaTFSVVlpTG4wZHAycEI5RzM3UVlmWkMrTTJO?=
 =?utf-8?B?NFdxSWk2SzBKYTIvWEtaT3cwQmhHRThWTmNiN1NJb3VlNlNac3NZV3ZSRksx?=
 =?utf-8?B?Z1B6eWlmSXlzM1JPMzJtdXpiQ3o2UVdOU1hRdk5wUTVHdERTZzBETWRSemlZ?=
 =?utf-8?B?RG1CY3NGeUNTUzlKNU5PVkgyb2FwYndxQW95OXNmYjNTdkRDNFpqck05WnFa?=
 =?utf-8?B?RWthUVZRaEhXY0hrcUwwTWlEZWlJbUExNG9seW5Wd3Zqc05yOXp2a2kvamg2?=
 =?utf-8?B?RmZPeEFKTWFpZmlybGJ6RlhpOXVnTWFYdnZTM0FBZ1R6TDlTcENkTytkNmhL?=
 =?utf-8?B?TVhrM0ZRaFVmNThBRU4yRU0vN2hMV2JoUlJlM29SRDBwOEJZUmZZUUZUYjY0?=
 =?utf-8?B?dUh6Q2hOU1RZZlZJNnhqREcybTJKTmhiOGVHdDg4d28zZ2liZDNyNGhZdkRt?=
 =?utf-8?B?K1JQVGhKZ012UGpZSy9ZcFcvZE1YT25HdkNIQ1lqSm5TYXIxWEgxVzhDbWNa?=
 =?utf-8?B?N0tUdTBiQVZ3QUtNSzJ0V2lST1N6S0dIaExsTncxeGVYbU5uYnlmMnU4TlNh?=
 =?utf-8?B?OWsxb296R3l5OGVVYkNJTWFSQnE1dkJxVkNUNm5ZS1JwSmhpdERDUUhLLzNC?=
 =?utf-8?B?M21uSTdQN2VTVXlOK2R1MFBNdUdRRkplbXUveHVUYTdDZkcxT01jenhFclQw?=
 =?utf-8?B?TGdqNzBwYnlvRG1pSUhET2x5a0tnRm04cGFoRlFNdWN6bk5OWm5Db05ySnZL?=
 =?utf-8?B?UFBLU2pHZTVYQXJTWnltVWtiSWJCSGJFVllpdWZXZVdxVkhFeEg2M1l6OWJq?=
 =?utf-8?B?cWllWjFlQmh2M2pLa0FZd25hSThLS0xISUdobkNJaHFuRGNaRGM3Y0Vlb3U1?=
 =?utf-8?B?YWZzSzZMd3JLaHlvSnBtblhJZXdnaUc2RVQ2LzZBb3dxdDBSMDlDY29rV1c4?=
 =?utf-8?B?ZW8rSkRoRVJWN0N2M21ZODhFNWpxa3BFcjVwVDlYejY4NG1KMllmVitzZndP?=
 =?utf-8?B?ZlozK0xGN1RVTnZaTThYMmNqR0trUXRVdXhHT0dNVUdiTk1xV0h4QjZsTkh0?=
 =?utf-8?Q?3UeZBri/la9jUmA/f8SMCeqx+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b904736-fc0d-4b85-2590-08da7eba2341
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2022 12:31:54.6366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C64wwU2f8r78BDXreakgeYg+QTd7VE7F9fuA+cWh9I/anJS0RWvp5X4B5lNy0MsZYlWpsRbzffW+uut3r9Uivg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P122MB0285

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFuIEtpc3prYSA8
amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCj4gU2VudDogTW9udGFnLCAxNS4gQXVndXN0IDIwMjIg
MTM6NTYNCj4gVG86IEdyYXUsIEd1bnRlciA8Z3VudGVyLmdyYXVAcGhpbGlwcy5jb20+OyB4ZW5v
bWFpQGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1tJLVBJUEUgUEFUQ0hdXSBpcGlw
ZTogbm9hcmNoOiBGaXggaXBpcGUgbGV2ZWwgZW5kIGludGVycnVwdA0KPg0KPiBDYXV0aW9uOiBU
aGlzIGUtbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBQaGlsaXBzLCBiZSBjYXJlZnVs
IGZvcg0KPiBwaGlzaGluZy4NCj4NCj4NCj4gT24gMTUuMDguMjIgMTM6MjcsIEd1bnRlciBHcmF1
IHdyb3RlOg0KPiA+IEZyb206IEd1bnRlciBHcmF1IDxndW50ZXIuZ3JhdUBwaGlsaXBzLmNvbT4N
Cj4gPg0KPiA+IFRoZXJlIGlzIHRoZSBwb3NzaWJpbGl0eSB0aGF0IGEgbmV3IGxldmVsIHRyaWdn
ZXJlZCBpbnRlcnJ1cHQgaXMNCj4gPiBhbHJlYWR5IHdhaXRpbmcgd2hlbiBfX2lwaXBlX2VuZF9s
ZXZlbF9pcnEoKSBpcyBjYWxsZWQuDQo+ID4gSW4gdGhpcyBjYXNlIGF0IHRoZSBtb21lbnQgd2hl
biB0aGUgaXJxIGlzIHVubWFza2VkIGl0IG1heSBhbHJlYWR5DQo+ID4gZmlyZSBhbmQgY2FsbCBf
X2lwaXBlX2Fja19sZXZlbF9pcnEoKSBiZWZvcmUgdGhlIG1hc2tlZCBzdGF0ZSBpcw0KPiA+IGNs
ZWFyZWQgaW4gdGhlIGlycSBkZXNjcmlwdGlvbi4gSWYgdGhpcyBoYXBwZW5zIG1hc2tfaXJxKCkg
Y2FsbGVkIGJ5DQo+ID4gX19pcGlwZV9hY2tfbGV2ZWxfaXJxKCkgd2lsbCBub3QgbWFzayB0aGUg
aW50ZXJydXB0IGFuZCB0aGUgc3lzdGVtIG15DQo+ID4gc3RhbGwuDQo+ID4gVG8gcHJldmVudCB0
aGlzLCB0aGUgbWFza2VkIHN0YXRlIHdpbGwgbm93IGJlIGNsZWFyZWQgYmVmb3JlIHVubWFza2lu
Zw0KPiA+IHRoZSBpbnRlcnJ1cHQuIEEgZm9sbG93aW5nIGRpcmVjdCBpbnRlcnJ1cHQgaGFuZGxl
ciBjYWxsIHdpbGwgdGhlbg0KPiA+IGNvcnJlY3RseSBtYXNrIHRoZSBoYXJkd2FyZSBpbnRlcnJ1
cHQgYXMgbmVlZGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogR3VudGVyIEdyYXUgPGd1bnRl
ci5ncmF1QHBoaWxpcHMuY29tPg0KPiA+IC0tLQ0KPiA+ICBrZXJuZWwvaXJxL2NoaXAuYyB8IDIg
Ky0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2lycS9jaGlwLmMgYi9rZXJuZWwvaXJxL2NoaXAu
YyBpbmRleA0KPiA+IDZhODgzYTRjZWU4Ny4uMjVkMDk0MmI1OTJhIDEwMDY0NA0KPiA+IC0tLSBh
L2tlcm5lbC9pcnEvY2hpcC5jDQo+ID4gKysrIGIva2VybmVsL2lycS9jaGlwLmMNCj4gPiBAQCAt
MTA0OCw4ICsxMDQ4LDggQEAgdm9pZCBfX2lwaXBlX2Fja19sZXZlbF9pcnEoc3RydWN0IGlycV9k
ZXNjDQo+ID4gKmRlc2MpDQo+ID4NCj4gPiAgdm9pZCBfX2lwaXBlX2VuZF9sZXZlbF9pcnEoc3Ry
dWN0IGlycV9kZXNjICpkZXNjKSAgew0KPiA+IC0gICAgIGRlc2MtPmlycV9kYXRhLmNoaXAtPmly
cV91bm1hc2soJmRlc2MtPmlycV9kYXRhKTsNCj4gPiAgICAgICBpcnFfc3RhdGVfY2xyX21hc2tl
ZChkZXNjKTsNCj4gPiArICAgICBkZXNjLT5pcnFfZGF0YS5jaGlwLT5pcnFfdW5tYXNrKCZkZXNj
LT5pcnFfZGF0YSk7DQo+ID4gIH0NCj4gPg0KPiA+ICB2b2lkIF9faXBpcGVfYWNrX2Zhc3Rlb2lf
aXJxKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykNCj4NCj4gT0ssIGJ1dCBpZiB3ZSBuZWVkIHRoaXMg
b3JkZXJpbmcgaGVyZSwgd2h5IGRpZG4ndCB3ZSBuZWVkIGl0IGJlZm9yZSBmb3INCj4gdW5tYXNr
X2lycSgpPyBUaGVyZSwgaXQgd2FzIHN1ZmZpY2llbnQgc28gZmFyIHRvIGRpc2FibGUgbG9jYWwg
aXJxcyBhcm91bmQNCj4gdW5tYXNrICsgY2xyLg0KPg0KPiBKYW4NCg0KSW50ZXJlc3RpbmcsIEkg
dGhvdWdodCB0aGUgZGlzYWJsaW5nIG9mIHRoZSBsb2NhbCBpcnFzIGlzIGV4YWN0IHRoZSByZWFz
b24gd2h5IGl0IHdvcmtzIGluIGNvbnRyYXN0IHRvIF9faXBpcGVfZW5kX2xldmVsX2lycSgpIHdp
dGhvdXQgZGlzYWJsaW5nLg0KU28gZGlkIEkgbWlzcyBzb21ldGhpbmc/IFNob3VsZCBJIGFkZCBh
IGxvY2FsIGRpc2FibGUgaGVyZSwgdG9vPw0KDQpUaGFua3MsDQpHdW50ZXINCg0KPg0KPiAtLQ0K
PiBTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+IENvbXBldGVuY2UgQ2VudGVyIEVtYmVkZGVkIExp
bnV4DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQpUaGUgaW5mb3JtYXRpb24g
Y29udGFpbmVkIGluIHRoaXMgbWVzc2FnZSBtYXkgYmUgY29uZmlkZW50aWFsIGFuZCBsZWdhbGx5
IHByb3RlY3RlZCB1bmRlciBhcHBsaWNhYmxlIGxhdy4gVGhlIG1lc3NhZ2UgaXMgaW50ZW5kZWQg
c29sZWx5IGZvciB0aGUgYWRkcmVzc2VlKHMpLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LCB5b3UgYXJlIGhlcmVieSBub3RpZmllZCB0aGF0IGFueSB1c2UsIGZvcndhcmRp
bmcsIGRpc3NlbWluYXRpb24sIG9yIHJlcHJvZHVjdGlvbiBvZiB0aGlzIG1lc3NhZ2UgaXMgc3Ry
aWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGJ5IHJldHVybiBl
LW1haWwgYW5kIGRlc3Ryb3kgYWxsIGNvcGllcyBvZiB0aGUgb3JpZ2luYWwgbWVzc2FnZS4NCg==
