Received: from SLXP216CU001.outbound.protection.outlook.com (mail-koreacentralazon11010001.outbound.protection.outlook.com [52.101.154.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FD3CF58
	for <xenomai@lists.linux.dev>; Mon, 15 Apr 2024 09:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.154.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173047; cv=fail; b=ocnORcf0VJksV/IxEeu8OE3xrRy+IihDjqx/3zaixsx6z25sZxviiDLSQJJO6BDQ8Kx0ttoRAlfqrE4rD+q7j2VhapYX/4FcIOQBTwRUajK2d/fY3pLzVUIYALLjapFBNlNUQEwSzZX3UHC9qtYIByMq8NlOjafvWDTaMiUXFu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173047; c=relaxed/simple;
	bh=ia8KY3C3ffICs3GHefLpK0YtgKJh1MgPjYUSLBUggJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=itQrZc+Pz+GlJS6pwQLWl7o0dGegq0TWj8FKQQX91ObBKfe4Eg9pUipgPqt+caiXfpuJp9C5hHcWApZwai4xULellQCMSYpIVzN7CpS8ZqPyJLpGrBWaoExtmetk3YtoTSfgBRe4g5gMm+PTkoJZWbBdMZ2cywaWk0zlcw6A4ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=doosan.com; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=P2PQyDqD; arc=fail smtp.client-ip=52.101.154.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doosan.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="P2PQyDqD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1jJxHVIcQuF1M90e8fUl5Qp0yEb79iG3s5BJX+UYKRb9NEBSRN0GiNdZdb+QP7X8F0g8HE9W6/4OoMmWk1k69VYR9klxWwfi00egU8u9XCfOS7jwlKyCTCbYvLNoAA3zPLldlPo9Sjo1trU31ymDbQcAspkAoHSB2eBG/zpHMDVfLUPZLHhIkzx+++f2bQ2R8rMxzaH46YifcDperMWRyCKphm5wZ1Vr36nRe7XAeOish6umeoPL09gY05wIBOdFirZhWP8HHg9h0/bsqQ9HfTrKmhmoa5Nw+hrndz5iFy5nKEY/bcZep5QeI8voRl9wnfwmnMGWDpBzG6DVgq+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia8KY3C3ffICs3GHefLpK0YtgKJh1MgPjYUSLBUggJI=;
 b=Ov1rHagiyw8jWMVI+jM3lUmWWqsMBkqR4QAg3LO2RYs7qsgtjUjmQxRD3chqeeFPC8VWyaNyvYuXIRfFKnYxMTixcZpvfMg7FqTF82f/1zngro3ymotRQX6T/NMFfgBc8Dq5dmGHpJ9r1Mgp0qmfrKKOwucE4SExS4H/mOy5iohbZTndAarqfaAyyooP3AtsMis708FTvj4sLuBkvsgFWn1OIG8LW9rv+8ihfk1EhKMBYXYZC1vxfJ0FChTSI8en7JDEpAHa1hUZMJ/skS0hD/ux5fJaI3PfYr6jF7X8FDP4gkMRzxsPPC09KZA549f90quJeui0sSqlpvCHwWxHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia8KY3C3ffICs3GHefLpK0YtgKJh1MgPjYUSLBUggJI=;
 b=P2PQyDqD5NgW0JdP4799ibBdlLh0zNYm9Egh2HIbFz/jk4xfVFbxpJIvWEQnzkjpxOrisCmG6+ccMMMxcdz1cyfY5gZn7piT849Ms6pav+Aqx8O9ES6RjD8HcG+qdSz9qI5G3C3NVnh4TD5lwec9cUFTSJGdbANe3+pp5o/IgfE=
Received: from SE2P216MB2279.KORP216.PROD.OUTLOOK.COM (2603:1096:101:121::6)
 by SE1P216MB1414.KORP216.PROD.OUTLOOK.COM (2603:1096:101:1d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 09:23:59 +0000
Received: from SE2P216MB2279.KORP216.PROD.OUTLOOK.COM
 ([fe80::6d7d:f66e:5130:4f4f]) by SE2P216MB2279.KORP216.PROD.OUTLOOK.COM
 ([fe80::6d7d:f66e:5130:4f4f%5]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 09:23:59 +0000
From: =?ks_c_5601-1987?B?wNPB2Lz2KEp1bmVzb28gSW0pILz2vK4gtc676rfOurjGvb26?=
	<junesoo.im@doosan.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
CC: Jan Kiszka <jan.kiszka@siemens.com>,
	=?ks_c_5601-1987?B?udqw5sjGKEt5dW5naG9vbiBQYXJrKSDGwMDlILXOu+q3zrq4xr0=?=
 =?ks_c_5601-1987?B?vbo=?= <kyunghoon2.park@doosan.com>
Subject: Linux system got freezing when "Xenomai App" started (or terminated).
Thread-Topic: Linux system got freezing when "Xenomai App" started (or
 terminated).
Thread-Index: AdqOzdGOjfgDTaMzTfG6jLUKGlG+/AASLKKg
Date: Mon, 15 Apr 2024 09:23:58 +0000
Message-ID:
 <SE2P216MB22790C817B4227CF808B2121E0092@SE2P216MB2279.KORP216.PROD.OUTLOOK.COM>
References:
 <SL2P216MB22740891EAD5CFE21E4A39E3E0092@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
In-Reply-To:
 <SL2P216MB22740891EAD5CFE21E4A39E3E0092@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=doosan.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE2P216MB2279:EE_|SE1P216MB1414:EE_
x-ms-office365-filtering-correlation-id: ca9d6cc0-4d60-4506-542f-08dc5d2dc7f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 I9CU1ieQ5KB03/sHAhBKpBgtbuubPGpId+7g6IICOHPhKUmC2lygcUv3ZhUpuF9VXldF80Ul7wufLINY3MGyHj1xw9VUx7vLd0CpKNqUVtfCJcu8O+QVxxfr/moVAH8wHR1XerGpt5uHvCYsIOuhmuji3DRhl1SNZ92K2uQR8q/eey0fjgHAUAZI86JuUf5tXHGjeQ97x2ap/zifiEGSVDoLq9qRCsMD4xuK8h5c/rzmfBk5sQVpnHVOyt+Lv0ng1rwuZb/V0Xx+5wdS3hUbh8+xAnWSOotxX3/p2qOU4FqPOZo064OVZ6gHVWtb4Gkef27UbjgGOUt12yYn7KtfREe4ejaXEw85pyFChilZczqHRGiykJ8m2SVB/994tg/42pC+Lk8/8VUzac1937CK9FTDiLfkccBfQKb+mEkD5+geL+YHCE3WOUJr2Jvc0F711vqFaI2b1sCk4aP9FAiLaSmkssF5wbQT9er6gTMlVaBAsS9cuUGovAu2wp5SrR90Dxt5VC3JlS8RDJk11dwZd0nr4Rot+iWYTq7mesWWwhJm+PKNny8kWE4Qg/4L8WS73djASdgjp5cxcThZQwUIHqgYhsyhOEa0PZuzV0MiBoyy3IeEuYHQi03Mykm5FlYGo35DHPgDenb6rrfdsbO1JtFQrBMtdwLRxgxWRfxXPO0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE2P216MB2279.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?ks_c_5601-1987?B?cGI2anZ0MEFzTUpWSDFjT0g1VGxoSjFhYVVMRmd2M2xCb1BUR3J2?=
 =?ks_c_5601-1987?B?azZmNG1zaG5ZTU1FM2ZjdjV5MElsZ1JtVjk5T3llbmRCbk83NzhT?=
 =?ks_c_5601-1987?B?SVFyWVFSS0lQWkF3Z3lqS1FHM0FUM1J0QVBPUUV1U0c2ZnQ0WWFh?=
 =?ks_c_5601-1987?B?eW1ha1EyMUtVZkhYQTgwbU9nTU1NWnI5OWRqVE9YU3M2OHdVZVNV?=
 =?ks_c_5601-1987?B?QUNPdVRTRkZHdXdJMEFiejN2M2xtVHRSVklwbGh3Z1ljZVFDc2xw?=
 =?ks_c_5601-1987?B?Nkp2bWQ0YkdkKzFNZi9ITFUyeUFlWkVwZHBCVm10bTY1QXpZalJS?=
 =?ks_c_5601-1987?B?MmhKenEwV2pqSk1YemNsOGNHZElXRjdKdzRpOEY0RjlsWmxKbksv?=
 =?ks_c_5601-1987?B?OVUwV29NTUQ5R3V4SThvV3kzeVhLL1A1R2RwRWUwOW00dlRWQ3dG?=
 =?ks_c_5601-1987?B?WkR5SkJ0U1hkdGFvU25jRDB5M0V6YWYxSzUxdmFCSW5uUjN1ZzFt?=
 =?ks_c_5601-1987?B?eFhIbXRsdzRIK1NVQ1gyTnRUaXM1VE4rNXVwSWRqTHpwU2NDai9j?=
 =?ks_c_5601-1987?B?NHhINzM0alpRRlArbHJ0dm9vblFVZU9sbWdWenV2aEIxNmswdEd0?=
 =?ks_c_5601-1987?B?OXpIRURva0ptTGpQcjVZQnplOWloVGhnYyszb3Z6N3JZMVNpUkRo?=
 =?ks_c_5601-1987?B?Smt5SWhnT0xUT3hkRDNheHVZVGJvTkord1BlWmpvZUdRbDZTZDBH?=
 =?ks_c_5601-1987?B?TlJobkZxSDhmZmRGM0x3MFhjVlVXeHo5Wkdya1dZUGw5SDBsSUhN?=
 =?ks_c_5601-1987?B?ZlZrTEc0Wk95dVl0cTFhSmkrWGIrZnROR0ZtMkZRS2J5NkwvanBx?=
 =?ks_c_5601-1987?B?L0hTNjlJbGxyOFNMMHl4cHRnMnI1NHl4R2dleWpsNm5wTjR6Q1RL?=
 =?ks_c_5601-1987?B?ZVBxTk9xRlRpNjVidWxoWWg1NGtsZCtjK0FKdkFSbUM4RWtRWGFH?=
 =?ks_c_5601-1987?B?NDEzYlhjY2lqM1dGeTV4d3AvVUFvLzE5Q2xXSm1XS1pMZ2RvRXVs?=
 =?ks_c_5601-1987?B?d0ZENGNXWUZHRDNtbzY2Tk1NemQxeFV2NExINTFhNjBCZ0NENzFF?=
 =?ks_c_5601-1987?B?YnJsNWovQW1EdVMvNFZ2cDI3VjU4Ukk4Q0NOckp1emY5aGExYlhw?=
 =?ks_c_5601-1987?B?bG8yWTdwbGxyQmxneG8wMDEvb2ZUNHM2NXFvbVQwSzI1T0NKRnpm?=
 =?ks_c_5601-1987?B?WEtHeER3MEU4bWNxMHJhdzFteVh0TFpCV3lIUUdneUdtbnVZaHM5?=
 =?ks_c_5601-1987?B?RVF5ek9vTWkyWDJQOHlhUHpqQitDUmIwNmkvY0lVZ1BMNG9rK2ZT?=
 =?ks_c_5601-1987?B?Mm1XYXFQL004YkhhYXNMWWl5RTZMVnA1OFh3QjljMkdvcTdhNG9P?=
 =?ks_c_5601-1987?B?TnFWS0VZRjBKRDhCRnVRd2ptTGpPRUxQVlRZaTAyZ1FLM2VTbGRW?=
 =?ks_c_5601-1987?B?VWd0YkJvT1pXWG5oc0ovSkJMMDQycFRmTXgzbG95aTRkamYzY2x4?=
 =?ks_c_5601-1987?B?cEgzRmxqd3R4ZVAra2IvWldocWxNS3FSV1RLQzkwdjJ3Vk5rOS9Z?=
 =?ks_c_5601-1987?B?RVlmWC9kNnNZVnNuNkdTNnhSZDgvNjFmaXNSS05Ya3VxRFltVEhz?=
 =?ks_c_5601-1987?B?WGh2RXhPVEthWGR2NVU4Zy8xNllXVldZU1F5YURqTWdrMEEyb1I0?=
 =?ks_c_5601-1987?B?WGszR3FyL0g2VDNwV091MWNNRUZoOGdyM1RFLzZROVMwQVhaVkto?=
 =?ks_c_5601-1987?B?WkpQbmRBZUFGYWdKTUQzUkxtL0JlOWU3RjR2c2xGMThCSWNPcWtY?=
 =?ks_c_5601-1987?B?ck1GTmhZbU5SUDZCVWZseC84aFoyeE5TSklvTFJLQk1HT2VxU2dy?=
 =?ks_c_5601-1987?B?RExNcWZZTW95UXgwVGxBSUNlTWcrTy9tNzE4RlJzeDhnNFlIdGpO?=
 =?ks_c_5601-1987?B?ckxjMi9vRG1JbjFUT3h6M1dmWTZjb3dneWt6bWdKKzNvekpyME9H?=
 =?ks_c_5601-1987?B?OFhSMVhyRmdvZjhIc1YrbWRhd2RwQ05JRW9QMnRjL1BDZmo4VDQv?=
 =?ks_c_5601-1987?B?amxqWmdHcFFGWDVXNCtCbWJyVUtJSk9GMWo4WHBhSDVlNkUwY2xQ?=
 =?ks_c_5601-1987?B?R0ZhaUNhMmVIeEc2RWpVWkRXaGJndFVpU0gwMHNodFdLbE1PSmw4?=
 =?ks_c_5601-1987?B?bnJ4cGlUVjF0QmxvT3ZKTTVXRFN4dXljWEdKSHJoV1dOcSt4VXZE?=
 =?ks_c_5601-1987?B?RVkwajBNQW1qRFNoZjR6YkRyNUlZQmsvYmE1djYzdDR6TGdCOEVW?=
 =?ks_c_5601-1987?B?aGJsU0pWY1BsRVJjVVd0YlVDMFM4aWN2NzJpdk1tVGpLVjFGNEl3?=
 =?ks_c_5601-1987?Q?+glmb/GUs8ksH4R/BClYwC6q2SG+TDJhKuBzXQKT?=
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: doosan.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE2P216MB2279.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9d6cc0-4d60-4506-542f-08dc5d2dc7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 09:23:58.9220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QA+2QG5ZN0pGHzp2eYwSr24GjRS6wFDK/RqQJ6zEVEM8FrXyE7v7+n+S7kG104Yuqt0qOhH2nAeS+WP7O2AfWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1414

SGVsbG8uIEkgYW0gYSBMaW51eCBBcHBsaWNhdGlvbiBEZXZlbG9wZXIuDQoNCg0KQXBwbGljYXRp
b24gdXNlcyBYZW5vbWFpIDMuMXguDQpUaGUgbWFjaGluZSBlbnZpcm9ubWVudCBpcyA2NGJpdCBh
bmQga2VybmVsIDUuNC4yNTUuDQoNClJlcGVhdCBtYWNoaW5lIHJlYm9vdCBhdCA1NSBzZWNvbmQg
aW50ZXJ2YWxzLg0KTW9zdCBvZiB0aGUgdGltZSBpdCB3b3JrcyBmaW5lLCBidXQgc29tZXRpbWVz
IHRoZSBzeXN0ZW0gZnJlZXplcy4NClRoZSBtb3VzZSBkb2Vzbid0IG1vdmUgYW5kIHRoZSBrZXli
b2FyZCBkb2Vzbid0IHdvcmsuDQpUaGUgc2NyZWVuIGFsc28gZnJlZXplcy4NClRoZXJlIGFyZSBu
byBzcGVjaWFsIG1lc3NhZ2VzIGluIHRoZSBrZXJuZWwgbG9nLg0KVGhlIHNhbWUgZ29lcyBmb3Ig
c3lzbG9nLg0KDQoNCg0KU28gSSdtIHJ1bm5pbmcgc29tZSB0ZXN0cy4NCklmIHlvdSB0ZXN0IHdp
dGhvdXQgcnVubmluZyB0aGUgYXBwbGljYXRpb24sIHRoZXJlIGlzIG5vIHByb2JsZW0gd2l0aCB0
aGUgc3lzdGVtLg0KUHJvYmxlbXMgb2NjdXIgd2hlbiB0aGUgYXBwbGljYXRpb24gcnVucy4NCkhv
d2V2ZXIsIEkgZG9uJ3Qgc2VlIGFueSBzcGVjaWFsIG1lc3NhZ2VzIGluIHRoZSBhcHBsaWNhdGlv
biBsb2cuDQoNCg0KSSBoYXZlbid0IGZvdW5kIHRoZSBjYXVzZSBvZiBGcmVlemluZyB5ZXQuDQpJ
IGFtIGN1cnJlbnRseSB2aWV3aW5nIHRoZSChsGh0dHBzOi8vdjMueGVub21haS5vcmcvdHJvdWJs
ZXNob290aW5nL6GxIHNpdGUuDQpJIHdvdWxkIGxpa2UgdG8gdGVzdCBzb21lIG9mIHRoZSB0aGlu
Z3MgbWVudGlvbmVkIG9uIHRoaXMgc2l0ZS4NCklmIHBvc3NpYmxlLCBJIHdvdWxkIGxpa2UgeW91
IHRvIGxvb2sgYXQgdGhpcyBzaXRlIHRvZ2V0aGVyLg0KDQoNClRoaXMgc2l0ZSBpcyB0YWxraW5n
IGFib3V0IEtlcm5lbCBjb25maWd1cmF0aW9uIHRoYXQgbmVlZHMgdG8gYmUgcmVtb3ZlZC4NCiJD
T05GSUdfS0dEQiINClRoaXMgb3B0aW9uIGlzIGN1cnJlbnRseSBlbmFibGVkLCBzbyBJIHJlbW92
ZWQgaXQgYW5kIHRlc3RlZCBpdC4NCkJ1dCBGcmVlemluZyBvY2N1cnJlZC4NCkEgcHJvYmxlbSBo
YXMgb2NjdXJyZWQsIGJ1dCBzaG91bGQgdGhpcyBvcHRpb24gYmUgcmVtb3ZlZD8NCg0KDQpUaGlz
IHNpdGUgdGFsa3MgYWJvdXQgIkZyZWV6ZSBvciBtYWNoaW5lIGxvY2t1cCIuDQoxLiChsFN0YWNr
IHNwYWNlIG92ZXJmbG93IGlzc3VlIG5vdyBiaXRpbmcgc2ltIHJlYWwtdGltZSBrZXJuZWwgdGhy
ZWFkP6GxDQoyLiChsFNwdXJpb3VzIGRlbGF5L3RpbWVvdXQgdmFsdWVzIGNvbXB1dGVkIGJ5IHRo
ZSBhcHBsaWNhdGlvbiAoc3BlY2lmaWNhbGx5OiB0b28gc2hvcnQpobENCjMuIKGwQSBjYXNlIG9m
IGZyZWV6ZSBpcyBhIHN5c3RlbSBjYWxsIGNhbGxlZCBpbiBhIGxvb3Agd2hpY2ggZmFpbHMgd2l0
aG91dCBpdHMgcmV0dXJuIHZhbHVlIGJlaW5nIHByb3Blcmx5IGNoZWNrZWQuobENCg0KDQpUaGVy
ZSBhcmUgdGhyZWUgZXhwbGFuYXRpb25zOiBJIGhhdmUgYSBxdWVzdGlvbiBhYm91dCB0aGUgZmly
c3Qgb25lLg0KSG93IG1hbnkgdGhyZWFkcyBjYW4gdGhlIHhlbm9tYWkgcHJvZ3JhbSBjcmVhdGU/
DQpXaGF0IGlzIHRoZSBtYXhpbXVtIHN0YWNrIHNpemUgcGVyIHRocmVhZCBpbiB0aGUgeGVub21h
aSBwcm9ncmFtPw0KT3VyIHByb2dyYW0gaGFzIGF0IGxlYXN0IDIyIHhlbm9tYWkgdGhyZWFkcy4N
ClRoZSBzdGFjayBzaXplIGlzIGRpZmZlcmVudCBmb3IgZWFjaCB0aHJlYWQuIEl0IG1heSBoYXZl
IGEgbWF4aW11bSBvZiA4IE1CIGFuZCBhIG1pbmltdW0gb2YgMiBNQi4NCg0KDQoNClRoZSBxdWVz
dGlvbiBpcyBjb21wbGljYXRlZCBhbmQgbG9uZywgYnV0IEkgZGVzcGVyYXRlbHkgbmVlZCBoZWxw
Lg0KUGxlYXNlLCByZXBseS4NClRoYW5rIHlvdS4NCg==
