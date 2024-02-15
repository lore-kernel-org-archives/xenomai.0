Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2178.outbound.protection.outlook.com [40.92.62.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4D219E2
	for <xenomai@lists.linux.dev>; Thu, 15 Feb 2024 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998514; cv=fail; b=D2dU+g7OPGbLYfoaKqokU33PWjF/YVnvGFQaQZXCqZDWy7S1TT1++ZfVSHMKok7mO65k9KdAUSLmcLKQKZlymieJhCNOZpPKH5Sf7h2GWucF/wppUxuEVqwn08t2cp9LPT//VQa7HRtmEr990icmOBTq8WbCLRYPRtsWYkup2yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998514; c=relaxed/simple;
	bh=12ORlK800ACGwwzPcj0U7Liek83z2t+avyb9B/IfvNg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KAevdGkb6OroG+FxGq1/NmcNQEedJEuhKl4JJQrozhO8QajjxB+m844ALZjlAc12DDlIBgIXCAm74KyaZ6tqNmSItKqVEkVGSKjOSm3PzTpDb9p9Ix7Og+bZjw1xDbJt4d2xKMz7cz2dTFJ30SA1jntt5N4KViOfnXoQ9g972PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vQdfciOc; arc=fail smtp.client-ip=40.92.62.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vQdfciOc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/vWJmYSPUnUpUN5fpiXTELDdxcWvykAANooLfSmijbNG24Q9NYYBhX/Fo9g2wcKn/dektJZD1oGMqUtC0O90vVjT8xqZp6+UjYH67jRO2MZNeDiwNxQU3DtFhH5q969kfmJeFWfCSXMWtFaMONxTel7XFvagkAW2wLSkQdu4/cfhGlSKwFLQK8TWj/QsZRmLh7tIOKJ2xTxhiZvf2V8fpM2G9YwdgCjAHuhbsWSdVAYuvrX9e4kvQ35515nWwEy3TJJRDC9qv7OhW6s9IedT3kS0P/8+SC4l7mxl9cJPTGlBc5vXNYHmlvu+lEjooNTJ2RoD+CfPjpQOn0Tg/o4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12ORlK800ACGwwzPcj0U7Liek83z2t+avyb9B/IfvNg=;
 b=hxJ0Y8XQ3sHgHxrSYHmXQbZ+bl7QmQQ8yCDZBd2UXoLyGI0XJ4Y8Bb68uyTSXn6KB0SbBBGPvUhE6dkO2z6IIUTc6o7r9HglYzfi0lNADVYFA84YwVhnJQrwXNdXJQOVhCwMP9ig85TBaVH/KbKUX9jRvghbe/MaMRUwSYTe0T3Bi4VXaxsItd2n8J76hmROk1Y0NbOe3zEoufqqdze6Y0ZJWnOOcnmWfiP4Xm4VwjEzkAFKu5xkgiy6e6gdYDybz7mCffLmyktQy2DWXP202/T5u8UhPJ8fsy1P0GQLj8Cc27RbwmywaKFR88tqBn4Ue+KHzAyt3kJlpnaMTn799w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12ORlK800ACGwwzPcj0U7Liek83z2t+avyb9B/IfvNg=;
 b=vQdfciOcJ+8Jm5D7Bmnmrh4DthZlHwVB5whpWLe06f6TUBK7yoAH/pe9S0MI2QyGrybqP7yAxMRjyL8M6QfXW9weFauu4N//rS/ApYTrzEMCgEYFEuyBql0m3btzwTGtZCkjHe7Tum6g4Ov4kJdHu0IBHgtWlyd6zl8wHQ7TkC8HNb48EZAJ+B2FveJoC/sZeGajtzxJC5kxYzuS2Td8iI9/SOF+WMEgiMyF0YTplDylGQjb4YbbkXs//oPkgoB0za5LQrfSS/8fO9c9XTlMrG+5Ws91Jho8HgzWfrl/lxRmhHdRl2Eo61oBXWv3kRzG3wTfX8cyZ6RphE846SZEUw==
Received: from SY6P282MB3909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1d4::9) by
 ME4P282MB1270.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:92::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.29; Thu, 15 Feb 2024 12:01:49 +0000
Received: from SY6P282MB3909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::586c:434e:eea3:ce95]) by SY6P282MB3909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::586c:434e:eea3:ce95%4]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 12:01:49 +0000
From: =?gb2312?B?wt4g29q6ow==?= <ericvic@163.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: xenomai user space application static link
Thread-Topic: xenomai user space application static link
Thread-Index: AQHaYAayJysfC4OyKUCzlTnhND+jew==
Sender: =?gb2312?B?wt4g29q6ow==?= <outlook_EC99C92DE884C393@outlook.com>
Date: Thu, 15 Feb 2024 12:01:49 +0000
Message-ID:
 <SY6P282MB3909502DB24D7E09607571FCEB4D2@SY6P282MB3909.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 2
x-tmn: [D+1wXcrc9+foGEPw3tUgcd5DPVwt58Oa]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY6P282MB3909:EE_|ME4P282MB1270:EE_
x-ms-office365-filtering-correlation-id: 44b941ba-e763-4523-819e-08dc2e1de403
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kzloQBpaVcaF563jeKu/5xAuksRrUD2mCY+h9AQC4JXkiQ69s5rVcXEnAxPp2GQsvULFndjyAhbRJ71djCYyVrRBzE5+ReEa7sWW3AxYh6i1hEaNonTwTCzQuMM+8WSWdXLPhlvxJvLaLEhRNYUCu89/iuwJ13yps0DTsPjtxDI+YYklPvAZo2/TAuMrfD8tBQB60R65FoVxnw1Mkl/s4O4GXUBvl/doblPfvROZyXnUyDuf03+jullf5CrCvypP+SxBRyfkj93i/a2G2Bn60W5IPyM7Zff+2iE+7kxf9QTIXqUoAJkSzCPyymr82ioKV18Rl0f4qMDOK1D3DU39+GuK9B/bKXkrbhj7qBvEQpSANMZqWZIjPF6DfpFsGb5CtXUVzEITn6Am6lEU6M09I5Suv0Vv49dwbRBAkY/okjBGTjw2YOij1xWwKXJMJ0F1+mcSrXZTqVc5T3nl4inSphSXHZ5YAS03wpuyjuK4oUsqmKM48nvxU1WIKNhxxyHm32iZSXMEq6OAEouD6mkdC2paMwtHN/zXlxgeqVFI0jULAMJCxSewptaiFzxC3YVI
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZS9FcmJybUd1QjJKTVZOSEFkcGJpaG5OOXBiN2ZpZitTYkRUR2lWakhhOGRq?=
 =?gb2312?B?MTNETGRrY3dsdWlDQ3BVZU1oK1k1SGQ0dFFUN2grNklRa01nRGtxaDVheUlG?=
 =?gb2312?B?VktMMnhrbUJhSFoxMFRMOERwZEN5eGZ6akV4U0lLMnJzRnJJWU0zRjJ3NCtv?=
 =?gb2312?B?bTRBMjQ2dkdIbFZBTnFvbHczMlBYdGxsSUdOYzdSWU5qOFN0d3B0cG9iMHY0?=
 =?gb2312?B?UjJSL2FLaFRwbDFpbFFJNFI2TVo1T0ZPTWFXd2xQSlpkRXdlUFVWbUxaNU5C?=
 =?gb2312?B?S2NuNVp4RDJGN1laa0RNOE5Pemh1VHpHbExmcW9OeWdBMFMyWGE4UEdoQUpn?=
 =?gb2312?B?ZXV3RFFwY2Z4VW5kOEtaZW1WaFVrejFreEJsVTg5bjlFWXQrMFp4Q3FuUCtV?=
 =?gb2312?B?RlI3aGNERU1RV25KeXdjcHdzejhBbFFWbFNWSnJYN0taTkZYR29Zdk81cFBF?=
 =?gb2312?B?eGpXYzkybUN6TUdJdWJRTFZDWkl3Um9NcW9ramc1bWdlUXF1Y2FsdmRUbG1G?=
 =?gb2312?B?ckFxVGZQekttak4zckVsWGx4TW1OY3FBNkEyRS9yM0owaldtRFplNmZGVXRu?=
 =?gb2312?B?cWFJcmF1N08zMlFSU2VkZU94MExpQU1Lc1JGbWtNQStrTHNDWHA2VW9UUEc5?=
 =?gb2312?B?a21ReTh2VjQ2enBESkhxVjJHMStpL3dDNEg3RkYraXRoalArVEdTb1B2N1ZB?=
 =?gb2312?B?bVpIQXBUQ1JIdnRLM05EbkNuUjhrZ1AzN0lURWF5SUxuZnpBT0N2bmprUlZD?=
 =?gb2312?B?aXI3dm9jN2JGdVBCRGpXV2VqdmxsRHlKT3FzbGM0eXA4d0tpNnkwUlhMQ1kx?=
 =?gb2312?B?Rkp5M1NHd0tqdmtxT0ZJZ0hVUkt2VmwyZXRsaDVGNU1TNWx1dnRydEFjbXM1?=
 =?gb2312?B?U3VudnJhYm5NK3E5eU1JWWY4MVdrcXdhdFRXOUJ0a3hqSW0vN1VVNHV5L1pG?=
 =?gb2312?B?SlpvUEhxb2EwODErVVlGclduajl6STBlYUM5OXNnVVhBVjJSOVJSM2tPaE5L?=
 =?gb2312?B?Uk1vbS9pTlhpU0hYM2tNMXJ3OXVUY1Nld1J5b00yK2dJYjdqM0duZVMwRjZh?=
 =?gb2312?B?cWRtSFhsT2I1cStpblBJYVlQaU81dG5mUUJOUnM5SkVBV3hmazhaUHpCS3VR?=
 =?gb2312?B?eWRWNEZuci9wVFBOck5JR0wxVlRUNkhxMEZuWlAyWkNtY0hNODVvbXZOR1Nw?=
 =?gb2312?B?QVNsNS9ldlkxMTEydmFsQ2FVOGN1NG9ORm14bmxmNGdkc0lwWEtUc29TVGlv?=
 =?gb2312?B?a2Z6VDNaMWkwWmVZSFJ1RGpJMTlpK0tWVFZBbGRUa2hybTRNN3lQYTBDcVZv?=
 =?gb2312?B?Z2tYaTY4dkFDcnVnVEhmenc0K1ZyUDVuVEh1MWcvRE5tVU9MRms3QldBbU5T?=
 =?gb2312?B?SmFjWHNPak4zQWVVTnlES3VlQ21CYWEzZ3pzVjNFUGZGSXZTcERudnduQkQ4?=
 =?gb2312?B?ZXk4Yk9SOGQ1YWptV0JtaDJSN1E5cTkrb3g3SjFEZWJmd3lJTWgvejZEYUlD?=
 =?gb2312?B?RnVEMGhWUGVBTDNqMmZWSjF5ZEM0aHIwSy82Z0ViaFU3TmNIU3ppbjVpQ0w4?=
 =?gb2312?B?WmliZmhObnlUWFI2WjMxdmQ2azJKTFIwRzlPOGRHbVpSWFJCUlFhejBlL1RE?=
 =?gb2312?B?QUorOTJSZGo3WlRtMGxrMHFWVkRMc2E4RG9ValNNa3hLY0VhN0VXcUp3MEQ3?=
 =?gb2312?B?ZjZoa0t0VlZsTXozcVBVNzdyaGpkZUZqM0Jkb2wxcHZtVVNLYjZuV3d3PT0=?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY6P282MB3909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b941ba-e763-4523-819e-08dc2e1de403
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 12:01:49.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1270

CkhlbGxvLgpJIGNvbWxpbGUgYSB1c2VyIHNwYWNlICBhcHBsaWNhdGlvbiB3aXRoIGdjYyBwYXJh
bWV0ZXIgLXN0YXRpYyCho3RoZSBhcHBsaWNhdGlvbiBjYW4gbm90IHJ1biCjrGJ1dCB3aXRoIGR5
bmFtaWMgbGluayAgaXRzIG9roaNJIGRvIG5vdCBubyB3aHmhowpwbGVhc2UgaGVscCBXaHkgd291
bGQgdGhpcyBoYXBwZW6jv1RoYW5rcwp0aGUgYyBmaWxlIAojaW5jbHVkZSA8c3RkaW8uaD4KI2lu
Y2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CgojaW5jbHVkZSA8YWxjaGVteS90
YXNrLmg+CiNpbmNsdWRlIDxhbGNoZW15L3RpbWVyLmg+CiNpbmNsdWRlIDxhbGNoZW15L3NlbS5o
PgoKI2RlZmluZSBJVEVSIDEwCgpzdGF0aWMgUlRfVEFTSyAgdDE7CnN0YXRpYyBSVF9UQVNLICB0
MjsKCmludCBnbG9iYWwgPSAwOwoKdm9pZCB0YXNrT25lKHZvaWQgKmFyZykKewogICAgaW50IGk7
CiAgICBmb3IgKGk9MDsgaSA8IElURVI7IGkrKykgewogICAgICAgIHByaW50ZigiSSBhbSB0YXNr
T25lIGFuZCBnbG9iYWwgPSAlZC4uLi4uLi4uLi4uLi4uLi5cbiIsICsrZ2xvYmFsKTsKICAgIH0K
fQoKdm9pZCB0YXNrVHdvKHZvaWQgKmFyZykKewogICAgaW50IGk7CiAgICBmb3IgKGk9MDsgaSA8
IElURVI7IGkrKykgewogICAgICAgIHByaW50ZigiSSBhbSB0YXNrVHdvIGFuZCBnbG9iYWwgPSAl
ZC0tLS0tLS0tLS0tLS0tLS1cbiIsIC0tZ2xvYmFsKTsKICAgIH0KfQoKaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIqIGFyZ3ZbXSkgewogICAgcnRfdGFza19jcmVhdGUoJnQxLCAidGFzazEiLCAwLCAx
LCAwKTsKICAgIHJ0X3Rhc2tfY3JlYXRlKCZ0MiwgInRhc2syIiwgMCwgMSwgMCk7CiAgICBydF90
YXNrX3N0YXJ0KCZ0MSwgJnRhc2tPbmUsIDApOwogICAgcnRfdGFza19zdGFydCgmdDIsICZ0YXNr
VHdvLCAwKTsKICAgIHJldHVybiAwOwp9IAoKTWFrZWZpbGUgOgpYRU5PX0NPTkZJRyA6PSAvdXNy
L3hlbm9tYWkvYmluL3hlbm8tY29uZmlnCgpDRkxBR1MgOj0gJChzaGVsbCAkKFhFTk9fQ09ORklH
KSAgIC0tcG9zaXggLS1hbGNoZW15IC0tY2ZsYWdzKQpMREZMQUdTIDo9ICQoc2hlbGwgJChYRU5P
X0NPTkZJRykgIC0tcG9zaXggLS1hbGNoZW15IC0tbGRmbGFncykKCkNDIDo9IGdjYyAgIApFWEVD
VVRBQkxFIDo9IG1haW4KCmFsbDogJChFWEVDVVRBQkxFKQoKJTogJS5jCiQoQ0MpIC1vICRAICQ8
ICQoQ0ZMQUdTKSAkKExERkxBR1MpIC1zdGF0aWMgCgpjbGVhbjogCnJtIC1mICQoRVhFQ1VUQUJM
RSk=
