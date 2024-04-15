Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11010000.outbound.protection.outlook.com [52.101.154.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CFE535C2
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175674; cv=fail; b=G28i/Oww4wgWvZ4B5D6v6fIdhL9TCrODbDllJOYRuZURt9NIUKfkHaydoIL69pbz9URcqhfNcQcJA+WlHNtVINvMx1dU1OS+It+b/K4Cmv2eJVkTNV47sHhk/kwZrxD/DXqalFb/PxvVMu2Tu8MKdTmRBTz7uxkTfTm8PS7uOTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175674; c=relaxed/simple;
	bh=5T8F5fUON6mhu/y0Q63bfxkhdCt74YDIKaVCKCrcArg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o+oDS9NO5p/lI/8B4Uxm2xa5WPDoPb0hnk2+bQl9K+92mCbBtvPTql85csUY1OYA9Bmp/Kt5bRlnyT/B3EsDRcP0G5m/BoonqRpDDO0Dh3nCcG8GpINxHL4UmTuqg//BF2URI7royjg/qr5IWfq9h3SL2D1vYBycs5XQ9FGxexM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=doosan.com; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=MBDt/O+f; arc=fail smtp.client-ip=52.101.154.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doosan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="MBDt/O+f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB7zJcsHfwqNuRDN2rqUl+23ZT0yJA4U8uO7HEyH91NY8T+NoLnzfaOAyiC0RMfmir43OtiJK8OSAWQmaQIsOxJA4d3gvCrLexWdkhlUjv6AsEO+2pt2IXEFYJq0YJGHCz1a+FoibOQAy08C2yvgf8k0ifclaqlNXzxX924PlzXZvshHrCIbadiuvd2ZzNb440cleIdTBuxiKLf6ATbyU9gnQCkTRBDQbb9xLE6jxfOE8diGWmFro58fw42e6JpA0qtzgM7dz4kzwWYVRFKLB0IjXUc/8tEz7d0/p5bGa3OzEtFiMyLHngEMQcmfLw80H1S0kN5MdzEtPiUIuZ4mkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T8F5fUON6mhu/y0Q63bfxkhdCt74YDIKaVCKCrcArg=;
 b=kftsOB9ge2Rn5E3ZU/AkNiUFpmkFFNDHxumzsorm4G0BoISlX3vP6NwvOGmWMCNKfiauf2MGDl0oC6sq8P4ZBTsO6TO4l+VIX4HdgS8fhuE2RxALnKwGCaQFBMik6TyuUwUd/i3hmkewb27oS/xHdUCOqgnKM5TV7DblT4ltstXdJnmZRRkJ7hCJo6y+cCHbiZB7bjndsTHleKfLJHCkXlmmnXoJWlQDfNpB6FPGOfyBhX+qFyMVxsffVI80uegASbRr6t31O/1R+Ih9tWvVOdTDyj5ucwlbJXbGYHfQJzcC2IoD8PEX64+dz4voInlBKGU4+gsFnjTCZvSS2VttAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T8F5fUON6mhu/y0Q63bfxkhdCt74YDIKaVCKCrcArg=;
 b=MBDt/O+f3F4RAApwCHR2MWPwj4l6JEHiJ3s2+sg5ogV8PkPTXHPbFtHaMtrvgjgm4jg/lLA7hR0i2SKZiEAokNm0w8meHsmVsXiPGV1OmhiXmH3Jesxi7+8zkvoHN9CFgenNLCs/PGf2f3dCwBmIqsu7dCdsS4AKgLrwJrYCJxg=
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM (2603:1096:101:151::13)
 by SL2P216MB3001.KORP216.PROD.OUTLOOK.COM (2603:1096:101:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 10:07:43 +0000
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::1369:3712:b569:7e37]) by SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::1369:3712:b569:7e37%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 10:07:43 +0000
From: =?utf-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?utf-8?B?7Iqk?= <junesoo.im@doosan.com>
To: =?utf-8?B?RnJhbsOnb2lzIExlZ2Fs?= <devel@thom.fr.eu.org>
CC: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
	=?utf-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDtjIDsnqUg65GQ7IKw66Gc67O0?=
 =?utf-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>, Jan Kiszka
	<jan.kiszka@siemens.com>
Subject: RE: Linux system got freezing when "Xenomai App" started (or
  terminated).
Thread-Topic: Linux system got freezing when "Xenomai App" started (or
  terminated).
Thread-Index: AQHajxpJjg7BThxnME20sPb0QKr6b7FpFyXg
Date: Mon, 15 Apr 2024 10:07:43 +0000
Message-ID:
 <SL2P216MB22742910CC9D0E914505D1D9E0092@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
References:
 <SE2P216MB22790C817B4227CF808B2121E0092@SE2P216MB2279.KORP216.PROD.OUTLOOK.COM>
 <11ed-661cf800-11-274d62c0@39899883>
In-Reply-To: <11ed-661cf800-11-274d62c0@39899883>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doosan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB2274:EE_|SL2P216MB3001:EE_
x-ms-office365-filtering-correlation-id: 58e4e0aa-f197-44c1-d488-08dc5d33e41b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 B6GvqorNuTIxnBYpbtZPApYJmemm6tOv/lnqvKsb58kZesQRamMau7SJNT12mKwIowYQnDCjZimnCoGDcE8q65OgkdttLAjZiFUkz9F4HcqE8sec42thajRDIyTen8iRGTvlKKYRwuDq4s5pGvkPyXfGu7FhY3z7gPJvqpQpyGrrCdxX2LM2LCwsOAm93T+j+v4Vl0uM1fCYNYKkNBH17IHJVP0eAWtWKGZN2L9x5IaTy8yuM6Y8V8A0YQI7akb3slYOGu8PtuHhruefe0CixPyLEV3tRXZpzyzy3OSOmVHnrdaaVieMb166n7qMIj9ItPJBl/5reKUoFFQclW0hm6/ZVWSBms2t8pWu0zDEoQa1HFM3qdmMb/YEDwD2rBP9WAROAONKZMP99YcoOYOCnb5ZYgg+IbVsfphhzUzoeZFBk9fPHtLXUJ0Z4ntCY8a9xtC6aKhWhAHSBKYGrLwUDC0cl3PjayJZL873zonVg3xmCbYFz4nvO7NKi8ga5oRDjIsw8rG6Hq7NvzuBjENlFCNevUwilrCibaCfR+XCISL/p+m3HkW9NUlKuOB6wUh8BeReihHYzsO1Qm87gJM7cSvofigKzfP7A8sueYYTW1D8G8z+YQRKYCI1ADQ2ysQ0EUIJm/rUuCjw1YrdSy/0VsIMSq3mkMq/mUo8AGcWScs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB2274.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1Z6ZHBxNXZibmVrazZFd0VDQlZFbGNPcmN0bWpnZkwxS0hsQ2hOdUgyeC9r?=
 =?utf-8?B?Umx6NXkvZTBhR29sUUJjUGtVaHQvZ0NIeE9kOEV4VFFsZWFNaWlTeGI2QTYy?=
 =?utf-8?B?a2pNRldvTDRKdGRyTTZqYzRYZm5sekNCWWNCaHBPWUl2MVAza2NBNXdzeEZ5?=
 =?utf-8?B?dmlSV04ydkNiY01hOGhBQTZ2dkVNZ2hPWjNwekxKd0U3dmE1anFyUkxzazRQ?=
 =?utf-8?B?T3d3L0V5MjVSQzUvRGtMUVN5M1Jyd2dSMUtBSGhSalFUalNxcUhFL1dYWHdP?=
 =?utf-8?B?c3B2RzVMcVJnenJQTlVtOHZhUmFqVnAwdXBNdzlCZnB1YktmTFprWERQbHox?=
 =?utf-8?B?QzFXYnd6bkE3SEl2R3dUaXNEMDM0RndNQjBad1p2cXVFa3RIdi91KzlUblZo?=
 =?utf-8?B?bEtMOXNHM2ZlY3o4OC92S2NpY3BjMVdUV1h3UEt0UFU2c2lOdkkwOTFQK3lo?=
 =?utf-8?B?dXFrNTNGSGV3dXFzWUNTL0x3bzZ0ZE9iSDdtd09nQTlaN0R4SDhMNUZDUk93?=
 =?utf-8?B?Rk9rcm1xQ0gyMjl6c1czZzYzbU84RzRyVGEwcGVnNFNyNEhIdnJvNms5OFJO?=
 =?utf-8?B?SUlUY3JmaEtIOUxTdjVSdWlTUFgvRVRnYVNzcG9vV0VuR3ZZTWMwYkpEYUNh?=
 =?utf-8?B?TUoxZm9HRUNMN3VYMmdsbFJ1ZFZvMUNCTjQ0N3phcEMrdkNXL21SRG1uem5w?=
 =?utf-8?B?MGUrK3pNb2xVYkFTS2d6dEJGVTJPZjhLZzhxeEdhNzNObTd6NlNsTEJINW9O?=
 =?utf-8?B?T1pxN3JkdEZMRG9uSlRSdHRzNU1rRG5hOVBqUkJLcEthOUoyaHo4bEFZNXBJ?=
 =?utf-8?B?czJFSkVEYXpPY1B0VUFqNnVGMGc5U1ZhdGljVXlKS3R3MTNjUkxSRDJCZHBz?=
 =?utf-8?B?YlR0WW1QZ3ZINC9JWHhUVzY2V3VhTzZTU2EvQ2FsQ2h3ZnNydjZyS1lTSlVW?=
 =?utf-8?B?UnQ3Y2NGY1JLVGtTNnNBZU9yNmQzb3dUYXhQeTVIQmI3T1k1TFNtNWFKZTRj?=
 =?utf-8?B?dm92ZlkrcmpocjNsekdxeGljRVZLS0dXTDJESkt0cmpKeERoWEZiRWl2aWF5?=
 =?utf-8?B?d0RhM2svajhUaVpoYUYzU0dCblpURnY0QnUvQ3FNRmUxQ1RTYjhRYlRKcTh0?=
 =?utf-8?B?N2pZZnVEdm5JK21aZ0lmVU44enE2dmVpMk9XMzdvcThPeFR5a2F2RXpqSnUv?=
 =?utf-8?B?OGRsK1h5WHhST3d0KzUwVHlYN1JqNHMzQWpKYlJtZkFXREx3aktBeXZRM01l?=
 =?utf-8?B?QUtmVFlQc08zbFBYYUw4c1pIVHpTTk4yODk5azdnT3Fhc2pLTEFZaHZ1dDFz?=
 =?utf-8?B?SWlUWncwalhkbHAreTJMUU16MVR5SksyYnhyNkVkdWhYdWdMbndRKzdzMy91?=
 =?utf-8?B?eVNHclphY0lsRjMzSGZzTERjKy9mclFreDQ3c2I1cVM3aGRWNEtiNHhBbG9q?=
 =?utf-8?B?QTkranpQeG92R2hDTCtIUDZzdXlsTEZWUUY4VC9kMkhtMkFDZjJmdTk2dkp6?=
 =?utf-8?B?cW1RL1lIQTdxQktkUzgydldXRDRiM2g3eURXLzNBVWtxdGJITzB1V3l2aW9L?=
 =?utf-8?B?eCswMjBmS0taYm5QenExK0FBYU53VktzR3JJSHQwaElDUkVBYncxNDhaazJN?=
 =?utf-8?B?NlZxWm8xdzJXUWNCaW14S21EOTIvYS96d1pYK2dZd1dub3lCTDN5b0JvRXJ5?=
 =?utf-8?B?cklpVnJmaVJNV0JkbEtOUFV1T0tYV1MzNVV6eHBLdDlldjgyRTJpRk5mdS9x?=
 =?utf-8?B?T3lvMUpOeEFXbFd4dTNSNkg4T3pVejJSTTB0Z09Td01vYmdQSEtlZit4TUE2?=
 =?utf-8?B?dTBUbjJMQy9SK1grRzNDeHUzTWtkWlp4NnZVTGVvNjVxaGN3K1hJUzQwaWJ3?=
 =?utf-8?B?TlFxSGZySEIxTUZYaFJnMU9NblJ6b1dIdkFISmpWeXhJRG5OSUFMK1JRbDk2?=
 =?utf-8?B?cXFhRXpOQmFHOHl4OFZNc3hSU1dQR01nNHVLdlBLRUdrWWE3NkVWNUp2SGxw?=
 =?utf-8?B?UHMrU3kvQ2pRRW9nTjRSSGY1bWpld2x2SEtqK3VvM3pjbWROZ3dlSFR1a0FS?=
 =?utf-8?B?VGtEd0w5Yno2aDlpTUw3WnMvTUc4MnpIWkJTaXE5U3ZzYUFVcHZERjJnY21O?=
 =?utf-8?Q?SCBnMBttixTltp4iX5TCC5dPu?=
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
X-MS-Exchange-CrossTenant-AuthSource: SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e4e0aa-f197-44c1-d488-08dc5d33e41b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 10:07:43.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prlqVmFZODHWl9VaU7gu9X/xCnwjLzzrfuTjxUDWxCN674hsMIDaGWkAh/BqBQxDenLa/Ff6m5HOEWodIMT+Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2P216MB3001

RGVhciBGcmFuw6dvaXMgTGVnYWwuDQoNCg0KVGhhbmsgeW91IHNvIG11Y2ggZm9yIHlvdXIgcXVp
Y2sgcmVwbHkhIQ0KDQoNCkkgY2hlY2tlZCAiQ09ORklHX1hFTk9fT1BUX1dBVENIRE9HIiBpbiB5
b3VyIG1lc3NhZ2UuDQoNCg0KKFRoaXMgZS1tYWlsIHR5cGUgaXMgbm90IEhUTUwuIFNvLCBJIHdy
aXRlIGRvd24gc29tZSBpbmZvcm1hdGlvbnMuKQ0KSSBzZWFyY2ggIkNPTkZJR19YRU5PX09QVF9X
QVRDSERPRyIgb3B0aW9uIGluIGtlcm5lbCdzICIuY29uZmlnIiBmaWxlDQogICAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICAkS0VSTkVMX1JPT1Qp
IGdyZXAgQ09ORklHX1hFTk9fT1BUX1dBVENIRE9HIC5jb25maWcNCiAgIE91dHB1dD4gQ09ORklH
X1hFTk9fT1BUX1dBVENIRE9HPXkNCiAgIE91dHB1dD4gQ09ORklHX1hFTk9fT1BUX1dBVENIRE9H
X1RJTUVPVVQ9NA0KDQpBbHNvLCBYZW5vbWFpJ3Mgd2F0Y2hkb2cgd29ya3Mgd2VsbC4NCkJlY2F1
c2UgUm9ib3QgcHJvZ3JhbSBpcyBzb21ldGltZXMgdGVybWluYXRlZCBieSB0aGUgd2F0Y2hkb2cu
DQoNClhlbm9tYWkgd2F0Y2hkb2cgaXMgYWxzbyBhIHByb2JsZW0sIGJ1dCByaWdodCBub3cgd2Ug
YXJlIGZvY3VzaW5nIG9uIHN5c3RlbSBmcmVlemluZy4NCg0KDQpJcyB0aGVyZSBhbnl0aGluZyBl
bHNlIHlvdSBjYW4gdGVsbCBtZT8NCg0KVGhhbmtzLg0KQmVzdCBSZWdhcmRzLg0KDQoNCi0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBGcmFuw6dvaXMgTGVnYWwgPGRldmVsQHRob20u
ZnIuZXUub3JnPiANClNlbnQ6IE1vbmRheSwgQXByaWwgMTUsIDIwMjQgNjo0OSBQTQ0KVG86IOye
hOykgOyImChKdW5lc29vIEltKSDsiJjshJ0g65GQ7IKw66Gc67O07Yux7IqkIDxqdW5lc29vLmlt
QGRvb3Nhbi5jb20+DQpDYzogeGVub21haUBsaXN0cy5saW51eC5kZXY7IOuwleqyve2biChLeXVu
Z2hvb24gUGFyaykg7YyA7J6lIOuRkOyCsOuhnOuztO2LseyKpCA8a3l1bmdob29uMi5wYXJrQGRv
b3Nhbi5jb20+DQpTdWJqZWN0OiBSZTogTGludXggc3lzdGVtIGdvdCBmcmVlemluZyB3aGVuICJY
ZW5vbWFpIEFwcCIgc3RhcnRlZCAob3IgdGVybWluYXRlZCkuDQoNCuyjvOydmDog7J20IOuplOyd
vOydgCDsmbjrtoDsl5DshJwg67Cc7IahIOuQmOyXiOyKteuLiOuLpC4g66eB7YGsIO2YueydgCDs
sqjrtoDtjIzsnbwg7Je0656MIOyLnCDso7zsnZjtlZjsi5zquLAg67CU656N64uI64ukLg0KDQpD
QVVUSU9OOiBUaGlzIGVtYWlsIGlzIHNlbnQgYnkgYW4gZXh0ZXJuYWwgYWNjb3VudC4gUGxlYXNl
IHRha2UgZXh0cmEgY2F1dGlvbiB3aGVuIGNsaWNraW5nIHRoZSBsaW5rIG9yIG9wZW5pbmcgdGhl
IGF0dGFjaG1lbnQuDQoNCkxlIEx1bmRpLCBBdnJpbCAxNSwgMjAyNCAxMToyMyBDRVNULCDDgMOT
w4HDmMK8w7YoSnVuZXNvbyBJbSkgwrzDtsK8wq4gwrXDjsK7w6rCt8OOwrrCuMOGwr3CvcK6ICAg
ICAgIDxqdW5lc29vLmltQGRvb3Nhbi5jb20+IGEgw6ljcml0Og0KDQo+IEhlbGxvLiBJIGFtIGEg
TGludXggQXBwbGljYXRpb24gRGV2ZWxvcGVyLg0KPg0KPg0KPiBBcHBsaWNhdGlvbiB1c2VzIFhl
bm9tYWkgMy4xeC4NCj4gVGhlIG1hY2hpbmUgZW52aXJvbm1lbnQgaXMgNjRiaXQgYW5kIGtlcm5l
bCA1LjQuMjU1Lg0KPg0KPiBSZXBlYXQgbWFjaGluZSByZWJvb3QgYXQgNTUgc2Vjb25kIGludGVy
dmFscy4NCj4gTW9zdCBvZiB0aGUgdGltZSBpdCB3b3JrcyBmaW5lLCBidXQgc29tZXRpbWVzIHRo
ZSBzeXN0ZW0gZnJlZXplcy4NCj4gVGhlIG1vdXNlIGRvZXNuJ3QgbW92ZSBhbmQgdGhlIGtleWJv
YXJkIGRvZXNuJ3Qgd29yay4NCj4gVGhlIHNjcmVlbiBhbHNvIGZyZWV6ZXMuDQo+IFRoZXJlIGFy
ZSBubyBzcGVjaWFsIG1lc3NhZ2VzIGluIHRoZSBrZXJuZWwgbG9nLg0KPiBUaGUgc2FtZSBnb2Vz
IGZvciBzeXNsb2cuDQo+DQo+DQo+DQo+IFNvIEknbSBydW5uaW5nIHNvbWUgdGVzdHMuDQo+IElm
IHlvdSB0ZXN0IHdpdGhvdXQgcnVubmluZyB0aGUgYXBwbGljYXRpb24sIHRoZXJlIGlzIG5vIHBy
b2JsZW0gd2l0aCB0aGUgc3lzdGVtLg0KPiBQcm9ibGVtcyBvY2N1ciB3aGVuIHRoZSBhcHBsaWNh
dGlvbiBydW5zLg0KPiBIb3dldmVyLCBJIGRvbid0IHNlZSBhbnkgc3BlY2lhbCBtZXNzYWdlcyBp
biB0aGUgYXBwbGljYXRpb24gbG9nLg0KPg0KPg0KPiBJIGhhdmVuJ3QgZm91bmQgdGhlIGNhdXNl
IG9mIEZyZWV6aW5nIHlldC4NCj4gSSBhbSBjdXJyZW50bHkgdmlld2luZyB0aGUgwqHCsGh0dHBz
Oi8vc2VjdXJlLXdlYi5jaXNjby5jb20vMVhMdlZ6LThNRVpEZFlaZkRnYkRENllFYU5PakplYVE2
YTQ3S2pIZmZ2MEtRYlR5cHhvb0FJRGJMejh1clNYRUk2dlJsdHRsTDI3S1NXX21mRjBFTnVldW1t
U1ozOHVjTkV2anR5NS1aVkJ5NjB0bGpMYlh6Qk5sQjVjZ25JemhUOG1vU1lsemtVcGhGQWNzRGot
Z2hjQ1ExUW5LbjF4SWNFSmhvNnhNRXhaMndBcnZaYUJ2T0owZmN1eERybzFxNEM2UHdTaW5faXlO
QnQwM2lYVUp1aEhsdFdiR3Y5Sy1vdGg5bUktUVRJaU5EdTN3RzdYZWo4cmRCRk5pakNodHJnYU9s
VUJ6VUJBeGFpcEVtekRIZEJwUkExSEVIdkltNTIzaU5IZzdYc2RqZ0tmdEswT2QxZnBabUVaUnRT
bjFOL2h0dHBzJTNBJTJGJTJGdjMueGVub21haS5vcmclMkZ0cm91Ymxlc2hvb3RpbmclMkbCocKx
IHNpdGUuDQo+IEkgd291bGQgbGlrZSB0byB0ZXN0IHNvbWUgb2YgdGhlIHRoaW5ncyBtZW50aW9u
ZWQgb24gdGhpcyBzaXRlLg0KPiBJZiBwb3NzaWJsZSwgSSB3b3VsZCBsaWtlIHlvdSB0byBsb29r
IGF0IHRoaXMgc2l0ZSB0b2dldGhlci4NCj4NCj4NCj4gVGhpcyBzaXRlIGlzIHRhbGtpbmcgYWJv
dXQgS2VybmVsIGNvbmZpZ3VyYXRpb24gdGhhdCBuZWVkcyB0byBiZSByZW1vdmVkLg0KPiAiQ09O
RklHX0tHREIiDQo+IFRoaXMgb3B0aW9uIGlzIGN1cnJlbnRseSBlbmFibGVkLCBzbyBJIHJlbW92
ZWQgaXQgYW5kIHRlc3RlZCBpdC4NCj4gQnV0IEZyZWV6aW5nIG9jY3VycmVkLg0KPiBBIHByb2Js
ZW0gaGFzIG9jY3VycmVkLCBidXQgc2hvdWxkIHRoaXMgb3B0aW9uIGJlIHJlbW92ZWQ/DQo+DQo+
DQo+IFRoaXMgc2l0ZSB0YWxrcyBhYm91dCAiRnJlZXplIG9yIG1hY2hpbmUgbG9ja3VwIi4NCj4g
MS4gwqHCsFN0YWNrIHNwYWNlIG92ZXJmbG93IGlzc3VlIG5vdyBiaXRpbmcgc2ltIHJlYWwtdGlt
ZSBrZXJuZWwgDQo+IHRocmVhZD/CocKxIDIuIMKhwrBTcHVyaW91cyBkZWxheS90aW1lb3V0IHZh
bHVlcyBjb21wdXRlZCBieSB0aGUgDQo+IGFwcGxpY2F0aW9uIChzcGVjaWZpY2FsbHk6IHRvbyBz
aG9ydCnCocKxIDMuIMKhwrBBIGNhc2Ugb2YgZnJlZXplIGlzIGEgDQo+IHN5c3RlbSBjYWxsIGNh
bGxlZCBpbiBhIGxvb3Agd2hpY2ggZmFpbHMgd2l0aG91dCBpdHMgcmV0dXJuIHZhbHVlIA0KPiBi
ZWluZyBwcm9wZXJseSBjaGVja2VkLsKhwrENCj4NCj4NCj4gVGhlcmUgYXJlIHRocmVlIGV4cGxh
bmF0aW9uczogSSBoYXZlIGEgcXVlc3Rpb24gYWJvdXQgdGhlIGZpcnN0IG9uZS4NCj4gSG93IG1h
bnkgdGhyZWFkcyBjYW4gdGhlIHhlbm9tYWkgcHJvZ3JhbSBjcmVhdGU/DQo+IFdoYXQgaXMgdGhl
IG1heGltdW0gc3RhY2sgc2l6ZSBwZXIgdGhyZWFkIGluIHRoZSB4ZW5vbWFpIHByb2dyYW0/DQo+
IE91ciBwcm9ncmFtIGhhcyBhdCBsZWFzdCAyMiB4ZW5vbWFpIHRocmVhZHMuDQo+IFRoZSBzdGFj
ayBzaXplIGlzIGRpZmZlcmVudCBmb3IgZWFjaCB0aHJlYWQuIEl0IG1heSBoYXZlIGEgbWF4aW11
bSBvZiA4IE1CIGFuZCBhIG1pbmltdW0gb2YgMiBNQi4NCj4NCj4NCj4NCj4gVGhlIHF1ZXN0aW9u
IGlzIGNvbXBsaWNhdGVkIGFuZCBsb25nLCBidXQgSSBkZXNwZXJhdGVseSBuZWVkIGhlbHAuDQo+
IFBsZWFzZSwgcmVwbHkuDQo+IFRoYW5rIHlvdS4NCg0KDQogSGkNCg0KaGF2ZSB5b3UgdHJpZWQg
ZW5hYmxpbmcgQ09ORklHX1hFTk9fT1BUX1dBVENIRE9HIHRvIGVuYWJsZSBkZXRlY3Rpb24gb2Yg
cnVuYXdheSBSVCB0aHJlYWRzLg0KVGhpcyBtaWdodCBoZWxwIHlvdSBkaWFnbm9zaW5nIHRoZSBw
cm9ibGVtLg0KDQpGcmFuw6dvaXMNCg0KDQo=
