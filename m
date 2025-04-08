Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2099.outbound.protection.outlook.com [40.107.21.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAD17332C
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120598; cv=fail; b=W4TN9d5u92xSHV3ufMdiqAGLBY3JqX0+mWar4lRFml1L1RS4Of53Q91sp8HsuT2RkfmJ0i/3tPkjZig2d8bM15SlOgwjxSlelyQkxdSjXzMZdyyMjsa7YEMLaoTnV/7L1Qeuou42hUPuccfLIHG6WHteB9BzKjrZ87vNpxuTGoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120598; c=relaxed/simple;
	bh=sRh1GftoZuSHU0tAbDZvcvscS/drVUdgSFS7cdPAyVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QpvL2gDnBzSwpZVJFu2zv5eTE674uCvr4K0blDA8F7YV84ZKuFKm7JQpidD01kTKwyPRBu8KVyvcNOGamcekz2lrbI3l7yfLyIKRw0W2yRaVEK9rnaawLAZM39yzhqPuCoR0oLlyuG0HiZpZmCYg5e0NxGYqGZXtfS4UeOJp3Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com; spf=pass smtp.mailfrom=fareco.fayat.com; dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b=dhLFY+kE; arc=fail smtp.client-ip=40.107.21.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fareco.fayat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fareco.fayat.com header.i=@fareco.fayat.com header.b="dhLFY+kE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDfNsWdo9eTNgMRQl2+w7x0TjmYA2Fx1D+ECq1oyD7KHG0ukcjCi7UWOZ1keebZYiG8kBOLneK7omDvMzc+z96mO0OeZsYRKC2KTzGpgCJ2a0MB4viVdueOAEle6PZjCsb5Qs3qUxqqsa3Gsw8DCg44RalAmanH6CeLjYOOcMUgUq1O3Gj1T4LCGGbfsiwnHNOvJZ2FcBVAE12X4IuNTKz1ITAjkon/XmosWsxZmKffqBsNXg8fFwnCQO541ptkayjdfkckSLuyv+XNq7oLK57UFrZyi1XXo6AKhRbjNP2dMi8JwUbZb7qNauZpHSJ00AlDySwQGbcWJloMalm/AfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRh1GftoZuSHU0tAbDZvcvscS/drVUdgSFS7cdPAyVI=;
 b=XBk4DidxCLynmmRG/bg6UzpnLqg1HLC8R163mJJzE2msdM+bGoCzzNJv7sV1h3puZ2MZwjrUD0fvL+wwyTCBIwGCVlgT9buarnSi9R1SfxO7IoD0qeqF3FaZpvAlRbVRSkTz1zinhyTw+9RcGWvUoa1Vp+t5ZCyR+8L/x/Pe6Qv72ecW4eB9xYRf7zsd2DCklhMfDGLTtAfLX4gq1eFprx/RargHimkZR2/5UrJbu0j6YFpklB8C/aWTYQnxqZ64+7uAmL3rveZpfvUD/Nfbx7Um7Aw9cF1yz3NR2A3yvOgfpkJZ6+jsBpo3USvHI3F7yUTtnwIB9glFbK01+Wk5+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fareco.fayat.com; dmarc=pass action=none
 header.from=fareco.fayat.com; dkim=pass header.d=fareco.fayat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fareco.fayat.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRh1GftoZuSHU0tAbDZvcvscS/drVUdgSFS7cdPAyVI=;
 b=dhLFY+kEsYrhgVLnuEll0JsBIey/e1fiot+Q1UC0M+Hw8UFAQ8EpKu4FHVaiQSjlXYlyhJrDnV2YfVC2cTu0dwV6wGLkrFyGW+hB/P99ePIIUVQWqLQKr0l0rBaCrvP7nXV5+gOfwLpeX1C0swm5Sinpt2Z54UJ7Srky2J5THfaWmvOn5OVHAUoTGA6YKhbPdo+yc9QdZBfIurI6XOvd+ZCDsJ95N9fR/Sl73PtMN8JD1ERY25vglpnTlnnrzO2EK+rN3spp2tKCL3H8jNx8DAnAxcI9p8O7nt5DSJNW1rtutLcwYc8VeLSue3ZiObstyuJ3jc2wmcKT8uZQm08WUA==
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com (2603:10a6:20b:a4::24)
 by DU0PR05MB10546.eurprd05.prod.outlook.com (2603:10a6:10:425::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.18; Tue, 8 Apr
 2025 13:56:32 +0000
Received: from AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e]) by AM6PR05MB6024.eurprd05.prod.outlook.com
 ([fe80::67ee:17dc:6f66:7f6e%6]) with mapi id 15.20.8632.017; Tue, 8 Apr 2025
 13:56:32 +0000
From: LE-DOUARAIN Marc <m.ledouarain@fareco.fayat.com>
To: C Smith <csmithquestions@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>
CC: Florian Bezdeka <florian.bezdeka@siemens.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
Subject: RE: Compilation error kernel Xenomai3 for x86 32 bits
Thread-Topic: Compilation error kernel Xenomai3 for x86 32 bits
Thread-Index:
 AdsCu/A5CIPDzd4nRhuPtAIfDI6JiQABM2kAAAGsaqAACs3ygAAiOqJwAAKPgIAAVprXgCjqR5cQ
Date: Tue, 8 Apr 2025 13:56:32 +0000
Message-ID:
 <AM6PR05MB6024095533E40C15846BC4D5ADB52@AM6PR05MB6024.eurprd05.prod.outlook.com>
References:
 <AM6PR05MB6024420AB2F1754C19B5612EAD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <fc38f3af6fa7b993fdbc81deecd7134ad6a39af4.camel@siemens.com>
 <AM6PR05MB60248E3F1360E8FDFFFADCD4AD992@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <f8bdb69f-b500-4a5d-9739-90cb1a1a88d8@siemens.com>
 <AM6PR05MB60248187776E0975A0D64FBBAD9A2@AM6PR05MB6024.eurprd05.prod.outlook.com>
 <e45dc61e-bcae-4d45-aeb8-d195528428f7@siemens.com>
 <CA+K1mPEmN1_GEJY9QQ=yJ1fiCT6MfozAQBJJmUnUVWyc+6Ud6A@mail.gmail.com>
In-Reply-To:
 <CA+K1mPEmN1_GEJY9QQ=yJ1fiCT6MfozAQBJJmUnUVWyc+6Ud6A@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fareco.fayat.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR05MB6024:EE_|DU0PR05MB10546:EE_
x-ms-office365-filtering-correlation-id: 4e090c76-73f8-4966-91f0-08dd76a52b20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZGJoK3FtUHhTZzg2d1VNUXZ4aVFHb0tLUnhXUlI5V2VaOXVZRFora2gydUlY?=
 =?utf-8?B?K2FoWWNoMlNpUUhneFNoeWlTd1I2LzNoODU4K1JiUUZHVWNaWTB4WlJBUDBX?=
 =?utf-8?B?MnM4ZThiYVVvN0tobVpuc1ZKeUtKS1Z6bVBaTHBobS9JUmlxY0lpUi9MTEVh?=
 =?utf-8?B?MUFrTUhOdndsWEREL2RFRFUyUG8xR05ocDlGVWZlTG1RQ1RkODJNQlJvYUsz?=
 =?utf-8?B?RFhFTkUySWNQRTZyQTNwbmpCaWIwN0dxYVRTRHM2TXVPYy9XV0kzUlJkOTdz?=
 =?utf-8?B?MUVYV3pxN3gwdm9hMjBmT20rZTBHYVRwWjM4VXpVTy85TGEwNCtDRXVXL1p1?=
 =?utf-8?B?TjJYR29RcW4xQ084aWwyK21qZXhaMTkvWGVTWkxvSjRoZnNDWGl3RFI0TDFK?=
 =?utf-8?B?eUFlNXM2T3RVaERjam85VTN3QzdHSTgwNFVFcmV5cWxoNms1Q3I5bU9QVU80?=
 =?utf-8?B?QTVqRDZnM1kzUjBOclpjMjR4TUt4UmdZTG9FLzYxOURrZUtzK2NINXBtRjdt?=
 =?utf-8?B?TkVTVmRKa1V0bjF5aTl3ZEswK3hUZEptc0Y0YnQxejcwY0dEb0E5YnFaODM3?=
 =?utf-8?B?NHdJRnhGY01XbkI0bmpNR201MHdCdVZMMFM3cCs0VmgvYWttODFrYkN5c0p0?=
 =?utf-8?B?NjRZQ2lyMmM0cVYzeFlDelZDODdHN2o4b0NjTWN1bU92eC9vVktxVEdVOGk3?=
 =?utf-8?B?ekVMbEZkSHZpTWpDRXRoZlZoNHhnWmpueEJwME4ycG9iYmwxWUQ1bTdqYmt2?=
 =?utf-8?B?K2NkUzUrc3JXVWV1cFV0L01yZS9sVUlmeXhNbnV6ZXJEUWtIKzZ6a0xCTERz?=
 =?utf-8?B?c2JkT2FLSjhDMzZ0cjlyMFgyWGxKNXZadnl0TE9QbzE5cWZsZUM0ZHVZMFNu?=
 =?utf-8?B?YUZ2T3hna1pOMy82MVVHRFlSbFRZdEtZYis0MXBweC9qZ2FlTW80MU00U2VM?=
 =?utf-8?B?UHpBYUsvanZjSGI1VWlreW1FRE9ubU9Wb3hqQXlseVUyLzEwRWhNWjk3a0NG?=
 =?utf-8?B?WDVmNDNzS0Z1Q3VydEFVU0dQeVJXNmIvcDgyRWZHVU9uRUtRdTRVV3NBdjg0?=
 =?utf-8?B?Q3FlaStwQjJhNi9yUWpvd2tvMGJWK21HMkJRcUN0WkZiNzMwU2ZtQWpPbHJq?=
 =?utf-8?B?c2tDNWl1cHFxWHMvNlhEN2JTRHhpOC95MkFQUEJDNjYrQlJrdXlPdHJpcWQ4?=
 =?utf-8?B?SXkramU0VEJDSngyRzNvNmhlRFFiOHZTWmhaRnJZK0lrVUhuLzJQNHowQ3Qr?=
 =?utf-8?B?VS9vU3RKajZldGpYdXcrbjFoVXI0RnV5RlIweVFCekxnM3ZMWDFib09hV0NL?=
 =?utf-8?B?aUo3ZzJzbWhEbXpEa2xUVWxPYTdVV0dRTTFteDhEQ0RJRk8rcDF5TzZlWFpX?=
 =?utf-8?B?Z3B6SVZtMmEyM2JEaW96T2JpU1FpRDI1OXNJU1dPUWZ3cUFtMEhXeTlZQ2dU?=
 =?utf-8?B?Q200YzAzMThzOU12Skhaa1BMaUZ2VCtHRnZaajRvTG0wamlEYTZWbmVLd25R?=
 =?utf-8?B?RlByRkFvL2JUV0dCenNxbFZUSVJmRXF1andtOEZ2cU9tenhlV093UnltVW9M?=
 =?utf-8?B?WUdXUGFWMnlUUTZBZ0p6OFBqNFdhbCsyOU5pcDdQSk02STRmYld4d2Q4bU5T?=
 =?utf-8?B?NFdPQmFxMTdHcXBkNW8rckJNSDluRDJXWS94dEFobFdXYkI5RTBhUUsrUTdO?=
 =?utf-8?B?aGtxWkNrM0hUaDhHK250ZloyYTNFNUhYc1JnSUgyTi9HcW9jTFNpeEp4MjBW?=
 =?utf-8?B?MXRhbFhHa0hwaERqbnl1VVBEU2g0WU1rdTdYdzNzRWMzU3J6Q2dOUXdZWHMw?=
 =?utf-8?B?dW4zU1pUcjRlN2NqRzYrUGhRNG5QTkhKMGo2dTRYZ1VDTFB0Z05wdEhhbzAv?=
 =?utf-8?Q?/fXdQ7qUzBDTm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6024.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnVaMEM1Q1ZQQnFzMEh2OWZPb0ZFdW5MbFM3TXVCbnNnc0kxNnF2M0pKZUl0?=
 =?utf-8?B?RGFUS2QzUExVdW51OXlnWFYrQVhsdXNwRFFDa0VsV29uR3lEajVYNGdadi9F?=
 =?utf-8?B?a0IwTjF6WHhQa2ZVOCtMTUlaMUtzajR4VFdYd1JhemZKM2NPZWtGR2JBN0wr?=
 =?utf-8?B?dGFWYjlJSlM4aFAzRFIrSjNIQU5mdGFlNDc4alM4L2pJREd5M0dzcTFEby95?=
 =?utf-8?B?Tyt3ZnhWUnlZWTVNMGlvbFlNbmJDMEt5VUpiMmEzMU1OWjNzUFl2RnhoK0RC?=
 =?utf-8?B?RG1MRVZ0eG5xaU0wcWowWERxR2tLbmxDN3FDajNzbDdzU2VOdnhsdy9YbzJp?=
 =?utf-8?B?VGRKR2drWGN2TDM1YktQNmxLcFNEdTZ4Y2pDaGwvdGdmWFVhR2ZwcmpDaDhh?=
 =?utf-8?B?dzIwcVpyTDhtbDJQR29sSExOZk9pM0RHUjJMWHFvNUhMQ1N0b0VpclYzZ0JG?=
 =?utf-8?B?cUVtYi82am1yNEM4UWx5aUlSMk43aUYyUGFFcUpVWkg4M0ZGOXNkVlJJaDNr?=
 =?utf-8?B?R1JPZ1B3OVY3K0ZvemNqeUdpTlV2QlByY0VuYlFlbkRmMXZxQitDcEVqQ2h0?=
 =?utf-8?B?dlRRcWdxNC9jRmxtMlFoK3JLeUgvSFRFRGNTcWxaZHFNeWdHMlN1SnNxdDlB?=
 =?utf-8?B?bWFBZHErdW1qVU84ZVNlWDRRY0RwSm1SOHU4WVhxNktmWUl6dU5TZVRtOEEv?=
 =?utf-8?B?L0IrMm1IRm9kTko5Rk5BNDkzL2xLQkc4WnEyMVZiZ2puWHJlbUhSSE9VcXl0?=
 =?utf-8?B?bEN6aUhlU0Jlcm5TK1VETnN0aUNtdC9PM3l2ajJ5MHJuK00vZUZLMGpOUTZr?=
 =?utf-8?B?Q1lPazJHQVFlOTZrRXF6K283aUY3NWt1SmNLY0FhT3h3NGZvMEkwS2xLZ2dw?=
 =?utf-8?B?YStCRitpRHZ2Njk0M3l3TXhvOGxZUUprVkpDa3FFVEtyMEJRTDBMVjFoVDRt?=
 =?utf-8?B?ZlFLVkUzaHJaQjBXRy94ZGFtTlNQVmFZa2c5ZlIzd21maFg0dU1hcjdxamFC?=
 =?utf-8?B?dFZxV20ycjJUUHlmR0dFMnVSZWFMZm5KVFp2MHZJZ1ZDczlDbXpuU0lkOVh1?=
 =?utf-8?B?bHJhbCtxMmhrM3E0a1pKb3hYYm0yU081MllvaXhZQmo4a08wbGJHQWRUejFE?=
 =?utf-8?B?UXpVZnkwcWVSZjdycDVpVFZDMlhvOFB2ZFFaOUNuNGxkaUM3RStIRGR2Z1JQ?=
 =?utf-8?B?L1VkNkF4aWNRUnM4bXkrMVlRMUxYZ2JQZDd1THBvc2pLc3Y0UGgyVWVOSkNU?=
 =?utf-8?B?RmwrYnlIdkUyeDg4T3pCYktBNW15SVZWSWdnT09GQ08yMGF2VXoxMVpUWkYy?=
 =?utf-8?B?SFZyTHdWRExJdC9CMExvMlZjVlRma1JyeE1HVm9iSlVhdE4ycHB2S3A4M0lH?=
 =?utf-8?B?WU5DVUd6a1FHR1ZQQzZjL0Y3UzFldnZmS3NIU3ZWUHZtNi9Jd3djWm1QaDhB?=
 =?utf-8?B?THhmNWVzNy9WSFpIY2lTRElFSDkyZmF0bjVGT1dIQitzZDgzT2l5TTVSeldD?=
 =?utf-8?B?bkJhY3lLcE5qc2lMc0tUcGQrcEd3MFlDN2lmbzJKdlppWVVES1d4MWFRV0J4?=
 =?utf-8?B?WXp3MUZ6TEptdElCYTBGYytxMURkcDVXSC9sNkZKM3pvL1RodmMxU2V2Z0x4?=
 =?utf-8?B?eUtmRzFnSDZEaUtESkFDTll1NTFhQ290ZXZscUlRQS8vVklYY20zcGk3Vk9l?=
 =?utf-8?B?V1g5NHQ3QUxSY0xHQWtLUnhuOTlnRmRYdEswSFIxWEVIZmZUQ3RwbW5wT3g5?=
 =?utf-8?B?SW91VFZpYWRVaXdwanJZU0tmZEtwUmRiN0RtMU5tdEJ4RjNLNFNIeW54eWdO?=
 =?utf-8?B?UDFMOHVTT2dDcTE4U1ZQRlZma1oxcGxLREdXdHFuR24vTXBETVBsOFFOYkRp?=
 =?utf-8?B?c0hISm9FWnRZamRLNENpcDJ6S05nWmRVZytwM0tyT3pGUTRXN0Y3c3ZSc3dk?=
 =?utf-8?B?OEJpeW5ScWt0NFZVdm1KcC9QL1RHcHJqcFFHV1NXRHdhRTlLKzhlNTVTeUFE?=
 =?utf-8?B?RnJiZEMxbncySFc0ZWpSeVkrTXhjYitEK0ZSalpCWkZnZXdBOWJHOHhiRGtW?=
 =?utf-8?B?OEVFVlFzYnl2dzBSNmY1SmlHbGltcFdHamZtcExPazltd2ZoenNDMlJPZE8y?=
 =?utf-8?B?ejV2a1gyTDAvbndmbjhCemo4S1FoQ1lqRm03K0xTaHNEd3V3SnRsL2tISW9S?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: fareco.fayat.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6024.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e090c76-73f8-4966-91f0-08dd76a52b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 13:56:32.1500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75428ef7-843d-4df6-9a8e-20c93eb7b405
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAYB+u8dnN99SF1X0AKkrCInB3SXzJzxEwC6OFwYwy3ZGPEr5/4JOEeKRmL0LNih7asS7gcM6dSl04aguDWl6DTihWE3zd6F+ddlZZ9Okac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB10546

DQo+ID4gT24gMTAuMDkuMjQgMTQ6NDYsIExFLURPVUFSQUlOIE1hcmMgd3JvdGU6DQo+ID4gPg0K
PiA+ID4+Pg0KPiA+ID4+Pj4+IEnigJl2ZSB0cmllZCB0byBjb21waWxlIGxpbnV4LWRvdmV0YWls
LXY1LjEwLjIxNC1kb3ZldGFpbDEgZ2l0aHViIA0KPiA+ID4+Pj4+IHJlcG9zaXRvcnkgZm9yIFhl
bm9tYWkgMy4yLjUgKGZyb20gYSBEZWJpYW4xMi42IGkzODYpLCBhbmQgaXQgZmFpbGVkIG9uIHRo
ZXNlcyBlcnJvcnMgOg0KPiA+ID4+Pj4+ICh0aGUgc2FtZSB3aXRoIFhlbm9tYWkgMy4yLjQpDQo+
ID4gPj4+DQo+ID4gPj4+PiBJIHRoaW5rIHRoZSBtYWluIHBvaW50IGhlcmUgaXMgdGhhdCB3ZSBk
byBubyBsb25nZXIgc3VwcG9ydCAzMiBiaXQga2VybmVscy4gV2Ugc3RpbGwgc3VwcG9ydCB0aGUg
Y29tcGF0IGNhc2UsIHNvIDMyIGJpdCBhcHBsaWNhdGlvbnMgcnVubmluZyBvbiBhIDY0IGJpdCBr
ZXJuZWwuIE1pZ2h0IHRoYXQgYmUgYW4gb3B0aW9uIGZvciB5b3U/DQo+ID4gPj4+PiBTaG91bGQg
d29yayBhcyBsb25nIGFzIHlvdXIgYm9hcmQgc3VwcG9ydHMgaXMgNjQgYml0Lg0KPiA+ID4+Pg0K
PiA+ID4+PiBXZSBhcmUgd29ya2luZyBzdGVwIGJ5IHN0ZXAgdG8gdXBkYXRlIE9TIHdpdGggYW4g
b2xkIGJhc2UgaGFyZHdhcmUgKElTQSBidXMpIGFzIHRyYW5zaXRpb25hbCBmb3Igbm93LCBhbmQg
d2lsbCB1c2UgYSAzMiBiaXRzIENQVSAiVm9ydGV4ODZEWDMiLg0KPiA+ID4+Pg0KPiA+ID4+Pj4+
DQo+ID4gPj4+Pj4gSeKAmXZlIHVzZWQgdGhlIGNvbW1hbmQgwqsgL3ByZXBhcmUta2VybmVsLnNo
IC0tbGludXg9IyMjIyMjIyMvbGludXgtZG92ZXRhaWwtdjUuMTAuMjE0LWRvdmV0YWlsMSAtLWFy
Y2g9aTM4NiDCuyBiZWZvcmUgY29uZmlndXJpbmcga2VybmVsLg0KPiA+ID4+Pj4+IE5vdCBiZXR0
ZXIgd2l0aCBsaW51eC1kb3ZldGFpbC12Ni42LjIzLWRvdmV0YWlsMi4NCj4gPiA+Pj4NCj4gPiA+
Pj4+IEhhdmVuJ3QgdG91Y2hlZCB0aGUgcHJlcGFyZS1rZXJuZWwgc2NyaXB0IGZvciBhIHdoaWxl
LiBTZWVtcyB3ZSBzaG91bGQgYmFpbCBvdXQgYW5kIGNvbXBsYWluIGxvdWRseSB3aGVuIHRyeWlu
ZyB0byB1c2UgLS1hcmNoPWkzODYuDQo+ID4gPj4+DQo+ID4gPj4+IElmIEkgY2FuIHVuZGVyc3Rh
bmQgdGhhdCBmb3IgdGhlIOKAnG5ld+KAnSBYZW5vbWFpIDQsIDMyIGJpdHMgaXMgDQo+ID4gPj4+
IGV4Y2x1ZGVkLCBpdCdzIHBlcmhhcHMgYSBwaXR5IHRoYXQgWGVub21haSAzIGNhbid0IGNvbnRp
bnVlIHRvIGJlIHVzZWQsIGVzcGVjaWFsbHkgaWYgdGhlcmUncyBub3QgbXVjaCB0byBiZSBkb25l
IHRvIGZpeCBpdCBhbmQgbWFrZSBpdCB3b3JrIG9uIDMyIGJpdHMuDQo+ID4gPj4NCj4gPiA+PiAz
Mi1iaXQgeDg2IGtlcm5lbHMgYXJlIHByYWN0aWNhbGx5IGhpc3Rvcnkgc2luY2UgYWxtb3N0IGEg
ZGVjYWRlLCBpbmRlcGVuZGVudCBvZiBYZW5vbWFpLiAzMi1iaXQgYXBwbGljYXRpb25zIG9uIDY0
LWJpdCBrZXJuZWxzIGFyZSBzdGlsbCBzdXBwb3J0ZWQgKGV2ZW4gd2l0aCBJbnRlbCB1cGNvbWlu
ZyBjdXRzKSwgYnV0IG9ubHkgZmV3IHBlb3BsZSB3ZXJlIHRlc3RpbmcgMzItYml0LW9ubHkgeDg2
IGtlcm5lbHMgdGhhdCBsb25nIGFnby4gUHJvYmFibHkgYWxtb3N0IG5vIG9uZSBpcyBkb2luZyBp
dCBpbiB0aGlzIGRlY2FkZSBhbnltb3JlLiBEaXN0cm9zIGhhdmUgZHJvcHBlZCAzMi1iaXQsIGFu
ZCBDUFVzIHRoYXQgbGFjayA2NC1iaXQgc3VwcG9ydCBjYW4gYmUgY291bnRlZCB3aXRoIG9uZSBo
YW5kIC0gaWYgbm90IGV2ZW4gYSBzaW5nbGUgZmluZ2VyLg0KPiA+ID4gQWx0aG91Z2ggcmFyZSB0
aGVzZSBkYXlzLCBzb21lIGRpc3Ryb3MgMzIgYml0cyBhcmUgc3RpbGwgYXZhaWxhYmxlLCANCj4g
PiA+IGxpa2UgdGhlIGNsYXNzaWMgRGViaWFuICEg8J+YiQ0KPiA+ID4NCj4gPg0KPiA+IFJpZ2h0
LCBidXQgbm90aGluZyBJIHdvdWxkIGRhcmUgdG8gZGVwbG95IGludG8gYW55dGhpbmcgbWlzc2lv
biBjcml0aWNhbC4NCj4gPg0KPiA+ID4+PiBJcyB0aGUgZXJyb3IsIG9uIFhlbm9tYWkgc2lkZSwg
b3IgbW9yZW92ZXIga2VybmVsIHBhdGNoZWQgPw0KPiA+ID4+PiBXaGljaCBrZXJuZWwgLyBYZW5v
bWFpIGxhdGVzdCB2ZXJzaW9ucyB3ZXJlIHJ1bm5pbmcgb24gMzIgYml0cyBmb3Igc3VyZSwgb3Ig
YXQgd2hhdCB0aW1lID8NCj4gPiA+DQo+ID4gPj4gSSB3b3VsZCBub3Qgc2F5IHRoYXQgWGVub21h
aSAzIGlzIGRlZmluaXRlbHkgZGVhZCBvbiBpMzg2IGJ1dCBubyBvbmUgbG9va2VkIGF0IGl0IGlu
IGEgdmVyeSBsb25nIHdoaWxlLiBJdCBjb3VsZCB0aGVvcmV0aWNhbGx5IHN0aWxsIHdvcmsgd2l0
aCBpcGlwZS00LjQueS1jaXAsIGJ1dCBhbnl0aGluZyBuZXdlciBkcm9wcGVkIGl0LiBXaGlsZSB3
ZSBhcmUgc3RpbGwgY2FycnlpbmcgaTM4NiBpbiB0aGF0IGtlcm5lbCwgd2UgZGlkbid0IHRlc3Qg
aXQgZm9yIG1hbnkgeWVhcnMgbm93LiBBbHNvIG5vdGUgdGhhdCB0aGlzIGtlcm5lbCBpcyBub3cg
Z2V0dGluZyBjbG9zZXIgdG8gaXRzIEVPTC4NCj4gPiA+DQo+ID4gPiBJIGNvdWxkIGVmZmVjdGl2
ZWx5IGdvIGJhY2sgdG8gaXBpcGUgZm9yIHRoaXMgdHJhbnNpdGlvbiBzdGFnZSBvbiBvdXIgY3Vy
cmVudCBoYXJkd2FyZS4NCj4gPiA+IFRoZSBsYXRlc3QgaXBpcGUga2VybmVscyBzZWVtcyB0byBi
ZSBhdmFpbGFibGUgaGVyZSA6IA0KPiA+ID4gaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS9YZW5vbWFp
LyBidXQgd2hhdCBpcyB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHJlcG9zaXRvcmllcyBpcGlwZSBh
bmQgaXBpcGUteDg2ID8NCj4gPiA+IFdoYXQgd2FzIHRoZSBsYXN0IGtub3duIFhlbm9tYWkgdmVy
c2lvbiAzLnggcmVhbGx5IHVzZWQgYW5kIHRlc3RlZCB3aXRoIGlwaXBlPw0KPiA+DQo+ID4gSGVy
ZSBpcyBvdXIgZnVsbCB0ZXN0IHBpcGVsaW5lOg0KPiA+DQo+ID4gaHR0cHM6Ly9zb3VyY2UuZGVu
eC5kZS9YZW5vbWFpL3hlbm9tYWktaW1hZ2VzLy0vcGlwZWxpbmVzLzIyMTc0DQo+ID4NCj4gPiAz
LjIgYW5kIG9sZGVyIGFyZSBzdGlsbCAob3Igb25seSkgc3VwcG9ydGluZyBJLXBpcGUuDQo+ID4N
Cj4gPiBKYW4NCj4gPg0KPiA+IC0tDQo+ID4gU2llbWVucyBBRywgVGVjaG5vbG9neQ0KPiA+IExp
bnV4IEV4cGVydCBDZW50ZXINCj4NCj4gSGkgTWFyYywNCg0KPiBJIHN0aWxsIHVzZSAzMiBiaXQg
WGVub21haSAyLjYuNSB3aXRoIGlwaXBlIHBhdGNoIG9uIGtlcm5lbCAzLjE4LjIwLCBvbiBhIEZl
ZG9yYSAyMSBkaXN0cm8uIEl0IGlzIHZlcnkgc3RhYmxlLiAgSSBoYXZlIHRvIHVzZSB0aGlzIHZl
cnNpb24gYmVjYXVzZSB3ZSBoYXZlIGEgbGVnYWN5IDMyLWJpdCBBTUQgR2VvZGUgTFg4MDAgQ1BV
IChYODYpIG9uIG9uZSBvZiBvdXIgZW1iZWRkZWQgUENzLiBJIGRvbid0IGtub3cgaG93IHdlbGwg
eW91ciBWb3J0ZXggQ1BVIHdvdWxkIHdvcmsuDQo+IFRoZSBYZW5vbWFpIHByb2plY3QgaXMgbm90
IGFjdGl2ZWx5IHN1cHBvcnRpbmcgWGVub21haSAyLnggYnV0IGl0IGlzIHdlbGwgZG9jdW1lbnRl
ZCwgYW5kIHlvdSBjYW4gc2VhcmNoIHRoZSBtYWlsaW5nIGxpc3QgZm9yIHByaW9yIG1lc3NhZ2Vz
Lg0KDQo+IC1DIFNtaXRoDQoNCkhlbGxvIEMgU21pdGgsDQoNClZlcnkgbG9uZyB0aW1lIHRvIHJl
cGx5LCBidXQgdGhhbmsgeW91LCB5b3UncmUgcmlnaHQsIHdlIGNhbiBzdGlsbCB1c2UgdGhpcyBv
bGQgdmVyc2lvbiBpZiB3ZSBoYXZlIG5vIGNob2ljZSB3aXRoIGFuIHg4NiBoYXJkd2FyZSBsaW1p
dGVkIHRvIDMyIGJpdHMuDQpGb3IgaW5mbywgd2hlbiB1c2luZyBhIHJlY2VudCBEZWJpYW4gMTIg
KGkzODYpLCB0byBiZSBhYmxlIHRvIGNvbXBpbGUgdGhlIDMuMTguMjAgaXBpcGUgcGF0Y2ggaW5j
bHVkZWQsIHRoZSAiL2luY2x1ZGUvbGludXgvY29tcGlsZXJfZ2NjLmgiIGZpbGUgbXVzdCBiZSB1
cGRhdGVkIHdpdGggYSBtb3JlIHJlY2VudCBvbmUgdGFrZW4gZnJvbSBhIHJlY2VudCB2ZXJzaW9u
IG9mIGlwaXBlIChiZWNhdXNlIG9mIGEgbXVjaCBtb3JlIHJlY2VudCB2ZXJzaW9uIG9mIGdjYyBv
ZiBjb3Vyc2UuLi4gZWxzZSBmYXRhbCBlcnJvcjogbGludXgvY29tcGlsZXItZ2NjMTIuaDogbm90
IGZvdW5kKQ0KQnkgdGhlIHdheSwgc29tZSBhcHBsaWNhdGlvbnMgaW4gdGhlICJ0ZXN0c3VpdGUi
IGZhaWxlZCB0byBjb21waWxlIChwcm9ibGVtIHdpdGggZ2NjJ3MgbGlua2VyKSwgYnV0ICdsYXRl
bmN5JyBvbmUgaXMgb2ssIHNvIGl0J3MgdGhlIG1haW4gdGhpbmcgKEkndmUgY29tbWVudGVkIG91
dCB0aGUgb3RoZXJzIGluIHRoZSBNYWtlZmlsZSBmb3Igbm93KS4NCg0KQWJvdXQgdGhlIFZvcnRl
eDg2RFgzLCBJJ3ZlIHN1Y2Nlc3NmdWxseSBlbmFibGVkIHRoZSBvcHRpbWl6ZWQgb3B0aW9ucyB4
ODYtdHNjIGFuZCB4ODYtc2VwLg0KDQpUaGFua3MgYWdhaW4sDQpNYXJjLg0KDQo=
