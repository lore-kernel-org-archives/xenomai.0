Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2124.outbound.protection.outlook.com [40.107.247.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10B13D279
	for <xenomai@lists.linux.dev>; Wed,  2 Apr 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611629; cv=fail; b=F6DoKm1GHlpIKJ2UU+Dw6jqZYj9d6yR6f9baFX6mM2B1vOVG7lJML/MTpoLmAFjIsY7exJrLW77z9uFqgizpC9Mpsqur25y7RkkmzQGDQpFRvmddNbObpz6c9Bci9JHE5cTOKvukFla+hrQJxd/g26fN3YYeZ8O4hMvdWooaAwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611629; c=relaxed/simple;
	bh=cdCcB2H8XxAw2ieunU0nJHYVC5cETImavt8bwokJVP8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iaitnDguSwm3THo2QUyNO0IL3afGs3q5yEOUVsqnXv3go2+JWSjQrFLhLrE4cwjEOWfdSSdFV+cd0zkXBQfMRF0qT1wzXryDgSMzGMihixgHdFkC0JC+NpypFWjBdl/HlLT1BMP6xFBSfnqwYeoi4cOsQdW6MRRPFCXhtC7mA2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aradex.com; spf=none smtp.mailfrom=aradex.com; dkim=pass (1024-bit key) header.d=xedara.onmicrosoft.com header.i=@xedara.onmicrosoft.com header.b=lwIcOroE; arc=fail smtp.client-ip=40.107.247.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aradex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=aradex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xedara.onmicrosoft.com header.i=@xedara.onmicrosoft.com header.b="lwIcOroE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPYR912Hs3ppu5MMwUY4wU+mlN0y4mujxWf3fvYl8o6SgUQsJXM1PHmVnQxIaREPobKMngSMNcwEywrx4GabslIVGfKgqoI3nk/5hbwj0cpB8zG1u7TBr4rcfCqw5Ttdnix3WlsgFkdmYem7UmmPQJgWUDXmRA5TDdAXRjY50yiKM9Nj9pdbjYvBHlWtvppI25M+DpIk9LOSNgJ5nDVK78hsXB/cASUSfSP3+hrj/OC+ra0ykoZAWHuj08gfu48q4sTnFXnAChoFP2RaeslNj8AtK/rN+OyQoaXhg9E2GDS6FMryUhJa3KQ9KpzFf3Vg3zN5o/KcTRPDmhFug9dyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdCcB2H8XxAw2ieunU0nJHYVC5cETImavt8bwokJVP8=;
 b=x7qQsQ0BR3S8CJOf8EynpzcC5lR2PYKkkJeMvdZX1QEimksZM/ozGLFgbMPbFkA1+ADuJqPNORuVvEzKUXjLA4l41Oj46fO4SpCL5vGmXy/fTSxVxh37pIF/J2P6bj50KiiGBuE6VTDTC9f9zi1ej2W+66cBEKjT+UiQzYoPsz8wBLYq4vnHtB591VHtjKcXNBTzN5g8xgA4ruAqW8Gudz1XaMmzLOeKnkR7FFPVcRfFlxnhJt3oq7aZIeTe0rz3pLYTD4Jfk3N0vWBWoPEEhwAbU5UDn7mD5Tg1/nPg7gLGodB7g242l8+L8bPJawiIEP3XPVTjVO29Ouek29fqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aradex.com; dmarc=pass action=none header.from=aradex.com;
 dkim=pass header.d=aradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xedara.onmicrosoft.com; s=selector1-xedara-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdCcB2H8XxAw2ieunU0nJHYVC5cETImavt8bwokJVP8=;
 b=lwIcOroEx0h1w2IrozuDh4zVyZwK4gRswCwczF4rrSazyskBwgSg+Svn02eQRQF6zW/CMhHVx0Nk0dvSal8EAqUCny4Yr5bDjg3+cBrxZVkfJkjij2s0jgmltB2IqAmfPP3UrHySdeqpJsBbTiKO81yibOyiSSxCMqq7OLThmAI=
Received: from PAVPR02MB9722.eurprd02.prod.outlook.com (2603:10a6:102:318::19)
 by DB9PR02MB10017.eurprd02.prod.outlook.com (2603:10a6:10:45c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Wed, 2 Apr
 2025 16:33:42 +0000
Received: from PAVPR02MB9722.eurprd02.prod.outlook.com
 ([fe80::8add:536:c66a:ff46]) by PAVPR02MB9722.eurprd02.prod.outlook.com
 ([fe80::8add:536:c66a:ff46%5]) with mapi id 15.20.8534.043; Wed, 2 Apr 2025
 16:33:42 +0000
From: =?utf-8?B?TWFya3VzIFdlacOf?= <mweiss@aradex.com>
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: RTAI -> Xenomai4
Thread-Topic: RTAI -> Xenomai4
Thread-Index: Aduj4fkW/83WlgpyTgeAqOze8Iw+PQ==
Date: Wed, 2 Apr 2025 16:33:42 +0000
Message-ID:
 <PAVPR02MB9722E8F8B700A3E97C5C45D9A8AF2@PAVPR02MB9722.eurprd02.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aradex.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR02MB9722:EE_|DB9PR02MB10017:EE_
x-ms-office365-filtering-correlation-id: 2c06e09b-2e43-4c1a-c2bf-08dd72042164
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WCtQVnJ3MHRrZUxHdjNUb2YwMGh5MHo5MDZ1NjJPSzlHUmpxUkNnMFVuaTEx?=
 =?utf-8?B?TnlHTEJqMzc5NituaVB6OTA1djRHQjB5ZUYrN3JaV0dwMkEvaXRsdHh5Yjhm?=
 =?utf-8?B?WjhGWkZEeTBRQzdxQ29kaDhMQXIyaytuM2szVXRmSE1UWFQ5bWJKU0E5VWtu?=
 =?utf-8?B?RDZJNGp1dWxhSjFkVzM2bTZVMWNKSGtRNmJUZzRxYXNMMDg1cmhET1hmSTNF?=
 =?utf-8?B?RGR2aDJJTVg1eCtSZWtoY284K29SQUhaZ1NiaWlOc3hzR0pva1AxUVFoc0pN?=
 =?utf-8?B?NW1BYzhtUHlOUUpsc3JnRTJMZklCY3k2OG4zcFlCb202Skl0OERDbXdpSlVP?=
 =?utf-8?B?ZndaODhwcGJPRDhxamlzVStpL2tXcG1vcWFSYWZrZGthS0JiSFpaeG84STNX?=
 =?utf-8?B?TmxJMlIvcUFCRjdwRnNTemdaR0JlbW13Ky9XdWJnMWwxaCtGSDlRWDdERnlw?=
 =?utf-8?B?T1ovU2JxMFBlZHpuQmdsL2pKbzdYQ1VwV1JaWXdTMGhRM3NwQXBjU2FHYmc1?=
 =?utf-8?B?MTBadWhIQXk5dzN3Q1dyRUVHN05HaHE0ZWJQMWRHRHdYWllyczJlS1pOWlJt?=
 =?utf-8?B?cDIwL3BvYkcvcTd2SHZGUit0YVdueUJjUHVrZHJlSmRZQ0pKTHZ4T24yUjEw?=
 =?utf-8?B?VmplOWRaZ0VKQk9OVFBhQlRCK3k2Tkc0SmlyU0ZZV0o1eTZid1RvUHMzZjN6?=
 =?utf-8?B?T0U2VW5pMXVucFhST1N3bThuditvak9HWFJLcEpyTmp6dy9oUFU3ZXJYWFU3?=
 =?utf-8?B?NnBmS1NOa1VQc2xuWTh1enFGdmRiMHVaMjdIbTlVYVBVSTB1UmhldEp3eUxn?=
 =?utf-8?B?dEFVZ21PVEt2MHpWNmd4Ym80d1BjdDF2N2J1TWRKNWw2NjRVcTNBNUxCTjI1?=
 =?utf-8?B?SmMrSUM5bmc3YVozb3J3Z2hNcjJnTW5MdXR4UnRBSWVQRjMrQWRWY2F6eGg2?=
 =?utf-8?B?MVpDcnB2ZG5tY1oxaHZKU3ZaYU4weDlPRnRtTHBnRi95MXlaSnNndi90ZTlG?=
 =?utf-8?B?YjByRU9BeVNvd2lTRXFoWFlIenFyNGNSc0M0Q09VTWs3b1JQUmxjdFNSaEtp?=
 =?utf-8?B?V0ZKNVpqUkJUWnQ3SVlQajA2UWNIWWNCTTJIZGZWcWFLNG9LN3JsUjVKVXg0?=
 =?utf-8?B?NzNHVGJkKzlBeDJTWVo1MXlhQjVrMW5ZTnJNT09uK3A3bTVwWmJoWkwwelpU?=
 =?utf-8?B?enZVMGVadmtyZ2d3cjNCck50bWJ3OGQ4NW5VbEFTeGV6RFhXOXh5TnN6QWs4?=
 =?utf-8?B?OUFUR1krTVd2UmRyeEM1VmxwUGkvR2wyWmY1bHdtazRIemJxTTlKc2pYMmIy?=
 =?utf-8?B?K01FSFVwbThDdGsyWGtIb3l6a2JwcGRVaEFETFZHWUw5TzZUUlZUZFJCUlU1?=
 =?utf-8?B?dk5WUndvV2NDUUozWWMrM0RoRjdDaHJtbmhHYVBockFQYnppSkZiY3JwSit3?=
 =?utf-8?B?OEROcDNFMStjd3RZVVc5cFVSaEs3ZllEcDdGR0NHL3ExcmxiL2RtSjU4OXpY?=
 =?utf-8?B?L2UySktneUZ5cVJadEtZekJQcWFLTlZteDROeTBmeW5HUzBvb2s2Y0JtMTBi?=
 =?utf-8?B?anlFaVNyOFhLMUg1REJtNzUwc3hSb09GQXFodE9Ga1kzYnpzMVVEVzhlWlV6?=
 =?utf-8?B?V21sY0NUTy9PTkFxK2RjMVhPSTIwNTdFY3NuY0drNEdDNzlaaVVRTTI1QU5L?=
 =?utf-8?B?eHkzaFB1WGZEZXdYdW43bnNaWHJ1M0pVZlFITU52d1RqZWlFQzlqbng0WEJs?=
 =?utf-8?B?ZDZPTjdrY2xXWTNnbEFUZzBKUkQ1VTF6K0svZmpKRWFoYmY4YlFpTmUweW5L?=
 =?utf-8?B?U1k2RGVzZEM5V1BUZ3o2RnoxNWFhQnlzUkc2NUUwNnphZFRlVGprY1lENFAv?=
 =?utf-8?B?bmZpWnRkeEx5ZkVLWldwWkF1SjdneU1TbXBGV0VnMnRkQ0YrZnBscGNORUZl?=
 =?utf-8?Q?nxLTvCJLVHE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9722.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sm9PbWVaY0VIRXd6eFdyTjZUaGxlWXlJd1pET2h6dGhzdmU2TlkvSzl3VjZs?=
 =?utf-8?B?YzZVWUlCeGNyWnd0QWYzb0E0enRJMU5OWTdwRHNOWk1yK0gzbmkzOW9PVklw?=
 =?utf-8?B?YTRIenhBSzBob1RGb0U5ZWRXenF2R29qVGNXMWFiYlZRMUFrUVpBK21LZmNj?=
 =?utf-8?B?RUs0YzNpMVFUMUxGUU1Za01zdlJXTDk1ckYrbzEyRzg4MHdCNzZzVkJVNHRQ?=
 =?utf-8?B?c2dzZHRCSk9oRFJud2Y0by8yTWxRbU5KbjMzM2s3ZldHWXREdWV0OStpT1Fx?=
 =?utf-8?B?dkgvZGF6L3R5ZjNDVnhKOG4zS0dua210TGhseTN2NzV5SS9DUS92Mng1YlNO?=
 =?utf-8?B?SlZNRldlZWdXM0l0UEZkK2N6aWZoL29YbWgvbnVvUzkwL0loV0NkR1dnVjI0?=
 =?utf-8?B?ZDNrcEZHMkZNUnBRR3VHcDVXZm12NUJiVlNJT2I3Qy9KZk90ejhTUVRIUnE4?=
 =?utf-8?B?Ym1ZZlRocXp0RVpXOXRLalpzK2p4TnlicGZwMllMaEhXLzJhaVVLTkU5VlhV?=
 =?utf-8?B?MjFSYjNObnBpam5uQkFBNTFZTk5RVmtvNld1Q1Nuc2dHSnJYWVZoc3dzcWxZ?=
 =?utf-8?B?aGRpcWcyMEVLR0x4RTBHc0dNdG5LRmpLWVlvS3NZZFExbnNCcXVOWGUxelZ3?=
 =?utf-8?B?T3RsdWIzWnNSVFZsQ3IxcHA0eDdMRDhzUzFlN2lQeWJkQmdYY2EvVVpXN1dp?=
 =?utf-8?B?OFYzNlRISFZ6SllhVEFsMU5vZWpUNnZzYlhidWhXZEJGV1pnY3Y0NzVtNE1I?=
 =?utf-8?B?ZXdoeG0zT1Z0aGx3cmpzY1p5cUg5TkhvY1Q5S1UvTDZwclU5eURVem53Y253?=
 =?utf-8?B?RkQ5b0Z5dlBKNlRqcklQRmxVNTRTMVBDc0FtSDNCL1FNRElUNk95U0djaWt1?=
 =?utf-8?B?amxsaU5aU0xUSHZUWlJ4QjVSNkwraVN2R2prdTM4TUtTbmlHaURVQXh1TUZm?=
 =?utf-8?B?T09qcWVXSVEwRVNqSzBoMzdhd1dxRDE3cnV0a0JQRm5uUGJJM0pPZzFzUzJP?=
 =?utf-8?B?YTlVQ1FmdzdCK0c4bGhCRWwxNlU0M2lOaU9KMG5ucU5SM3lJRjRtUmh1QUdU?=
 =?utf-8?B?R1J2YW9HMGFHeC82WG5aMzk4eVo1Y2ZFelBiWTgvdmhrT1MxZmhaQTNQVG5u?=
 =?utf-8?B?TTgyNFJVM3poMXdOc3lnMlFCZkU1TG4vbEFkTXlnSG1ieTNCeXJGSVRZeUdj?=
 =?utf-8?B?M2hUN1lQaUFaRlQ4ekZOL1QycmdLb3pnRWNtV2tWZWxNOFUvVGV6a0xuVG5r?=
 =?utf-8?B?OTBydGpmVFVaMmRDc1ptdExJQzBsM01GOXRlSE5tOGZtVktBSnRmNGtmUjM2?=
 =?utf-8?B?VDJMYUx1QW4zMmh1bmVVR2pUZ0MwK3FMZUZ5bmFUNnZiWnBuSWtKbFd0ek5K?=
 =?utf-8?B?REN1NUhrVzFPUUdiT0pLQmEvYVYyc0dOdlFUU3AxOXBBOXFSd1BlRmp6K1lL?=
 =?utf-8?B?T09UUkpsVm03bXBPc0hQWjFURnl2cnRtR0Q4RGNzbWM5YWFza2RKVjhhQ1pZ?=
 =?utf-8?B?SHhzYURYaXBGSTgyeHFhZFNRNkR1dEc3cHFXcXg2TlNzL0VqSDZrQmNTdXZP?=
 =?utf-8?B?aTYrb3RoMFA5bTA0ZkVjb3hjeXhVYTRHOVdqbGxWdHNNZ1M1bE1FdG9rUFJ1?=
 =?utf-8?B?MnFOcHg3Uk9xMkhmaDdKZzEyUXdMQ2NxVWc0SFgxcEJtd0tXYUgrd2JCZjZw?=
 =?utf-8?B?NTdJWk1mbUlPMjVDd2hPQVJuUktCQ1g3OHlIMDdhU0pRN1E0NU1hOVpRRUxm?=
 =?utf-8?B?Sldtd3F4YWtYRXJCclgycVcyYnNoVlFMYytNTnRZdlozUWRQNUF2MGh1UmVZ?=
 =?utf-8?B?U3BEdytGUWdodWI2aWN2R1AzOVNZeUdsc1dIdGlnOHpTS1pMTW9Pb1V3ZSs3?=
 =?utf-8?B?V0V4N3JsODhPc3JpRTVkQk1aZ01EaHFiQWtCZWZ0bGdVUEpLR3RZSWhnWW9m?=
 =?utf-8?B?RzBQcVdzRnpHUHBZZE5HYlNlaVJSVXkzMjRLMDNrR0FXUlBnRmVCUkNxTmdm?=
 =?utf-8?B?R0FqZEFvYnRndTNvVTFZeWZJK2NzQ1JPQlZtNU01K0RNMUc5dC85NlJvcnNy?=
 =?utf-8?B?bUlIYWNnSVVSTEQrejhXQXVTaUMzTjN6ZkpzdjRCZUcvM0RDQVhxVnpLT3JW?=
 =?utf-8?B?VzhIWHdrTFk3UmkzMEdoTzIrc2tOU1oweUFsZXJIcUl1U052M0RhR0s3T3BM?=
 =?utf-8?Q?uN3sZ0RhGUFKEYJTnfEM1JI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: aradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB9722.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c06e09b-2e43-4c1a-c2bf-08dd72042164
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2025 16:33:42.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e76e219-d340-4c18-a5f1-2dacf99e6e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y31WUzwYIKPMAW21dS8cDzbTaAAmbCDbPy9elhTm1XcXo35W0OrTsyhDKkWu8+Umi4Ch3mNKBvPX3SfM9HnoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB10017

SGVsbG8gWGVub21haSBMaXN0LA0KDQpzb3JyeSBpZiB0aGlzIGlzIG5vdCB0aGUgcmlnaHQgcGxh
Y2UgdG8gYXNrIHRoZXNlIGtpbmQgb2YgcXVlc3Rpb25zLiBNYXliZSBzb21lYm9keSBjb3VsZCBw
b2ludCBtZSBpbiB0aGUgcmlnaHQgZGlyZWN0aW9uIHRoZW4uDQoNCldlIGFyZSBjdXJyZW50bHkg
Y29uc2lkZXJpbmcgWGVub21haTQgYXMgYSByZXBsYWNlbWVudCBmb3IgYW4gb2xkZXIgUlRBSSBy
ZWFsIHRpbWUgcHJvamVjdCB0aGF0IHdlIGhhdmUgdG8gcmV2aXZlIGZvciBhIGNsaWVudC4NClNv
bWUgYWR2aXNvcnkgY29tbWVudHMgdG8gdGhlIGZvbGxvd2luZyBzZWN0aW9ucyB3aWxsIGJlIGdy
ZWF0bHkgYXBwcmVjaWF0ZWQuDQoNCk9uZSBvZiB0aGUgbWFqb3IgcmVxdWlyZW1lbnRzIGlzIHRv
IHN3aXRjaCBmcm9tIGhhcmQgcmVhbCB0aW1lIGluIGtlcm5lbCBtb2RlLCB3ZSBoYWQgYSBrZXJu
ZWwgbW9kdWxlIGZvciB0aGF0LCB0byBoYXJkIHJlYWwgdGltZQ0KaW4gdXNlciBtb2RlLiBXZSB3
aWxsIG5vdyBoYXZlIGEgdXNlciBtb2RlIHByb2Nlc3MgdGhhdCBzaGFsbCBkbyBtb3N0IG9mIHRo
ZSB3b3JrIG9mIHRoZSBmb3JtZXIga2VybmVsIG1vZHVsZS4gV2UgZGlkIHNvbWUNCnByb3RvdHlw
aW5nIG9uIGN1cnJlbnQgUlRBSSB2ZXJzaW9ucyBmb3IgWDg2XzY0IGFuZCB0aGluZ3MgbG9va2Vk
IG5pY2Ugd2hlbiB3ZSBmb3VuZCB0aGF0IG91ciBSVEFJIHN5c3RlbSBjYW4gYmVjb21lIHVuc3Rh
YmxlDQp3aGVuIHB1dCB1bmRlciBzdHJlc3MgZXZlbiB3aXRob3V0IG91ciBwcm90b3R5cGUgc29m
dHdhcmUgcnVubmluZyBhdCBhbGwgb24gdG9wIG9mIGl0LiBCdXQgb25seSB3aXRoIFJUQUlzIG93
biB0ZXN0IHByb2dyYW1zLg0KDQpJJ20gY3VycmVudGx5IGNoZWNraW5nIHRoZSBYZW5vbWFpNCBB
UEkgYW5kIGZvdW5kIHRoYXQgdGhyZWFkIGNyZWF0aW9uIGFuZCBhdHRhY2hpbmcgdG8gdGhlIEVW
TCBjb3JlIGlzIHByZXR0eSBzaW1pbGFyIHRvIFJUQUkuDQoNClVzaW5nIHRoZSBjbG9jayBhbmQg
dGltZXIgQVBJIGl0IHNob3VsZCBiZSBwb3NzaWJsZSB0byBzZXR1cCBhIG9uZSBzaG90IHRpbWVy
IHdoaWNoIHdlIHdpbGwgYWxzbyBuZWVkLg0KDQpXZSBhbHNvIHVzZWQgUlRBSXMgc2hhcmVkIG1l
bW9yeSBmZWF0dXJlIGZvciBzb21lIGtpbmQgb2YgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIGtlcm5l
bCBtb2RlIGFuZCB1c2VyIG1vZGUuIEl0IHNlZW1zIGFzIGlmDQp0aGUgRmlsZSBwcm94eSBBUEkg
dG9nZXRoZXIgd2l0aCBtbWFwKCkgY2FuIGJlIHVzZWQgdG8gYWNoaWV2ZSB3aGF0IHdlIG5lZWQu
DQoNCkFkZGl0aW9uYWxseSB3ZSB1c2VkIGxpbnV4IGlvdGNsKCkgdG8gbWFrZSBjYWxscyB0byBv
dXIga2VybmVsIG1vZHVsZSB0byBjb25maWd1cmUgYW5kIHJ1biB0aGUgYXBwbGljYXRpb24sIGRv
IG1vbml0b3JpbmcgYW5kIHdoYXQgbm90Lg0KDQpUaGUgcHJvdG90eXBlIHVzZWQgUlRBSXMgcnRf
cnBjeCgpLCBydF9ldmRycHgoKSwgcnRfcmVjZWl2ZXgoKSwgcnRfcmV0dXJueCgpIGFuZCBhbHNv
IFJUQUlzIGdsb2JhbCBoZWFwIGZvciBkeW5hbWljYWxseSBjcmVhdGVkDQpuYW1lZCBzaGFyZWQg
bWVtb3J5IHRvIGltcGxlbWVudCBhbiBpb2N0bCgpLWxpa2UgY29tbXVuaWNhdGlvbiBiZXR3ZWVu
IHNldmVyYWwgcHJvY2Vzc2VzIGFuZCBvdXIga2VybmVsIG1vZHVsZSByZXBsYWNlbWVudA0KaW4g
dXNlciBtb2RlLiBXaGVyZSBuZWVkZWQgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIGlvY3RsKCkgdGhy
ZWFkcyBpbiBrZXJuZWwgc3BhY2Ugd2hlcmUgc3luY2hyb25pemVkIHdpdGggdGhlIHJlYWwgdGlt
ZSB0aHJlYWQuDQpTbyBmcm9tIGEgY2xpZW50IHBlcnNwZWN0aXZlIG91ciBpb2N0bCgpIHJlcGxh
Y2VtZW50IGRvZXMgbm90IG5lZWQgdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgcmVhbCB0aW1lIHRo
cmVhZCBkaXJlY3RseS4NClRoaXMgd29ya3MgbmljZWx5IGV4Y2VwdCBmb3IgdGhlIG1pc3Npbmcg
cmUtZW50cmFuY3kgb2YgaW9jdGwoKSBjYWxscyBpbnRvIGEgZHJpdmVyIHdoaWNoIGNvdWxkIGJl
IHNvbHZlZCBieSB1c2luZyB0aHJlYWRzIGF0IHRoZSByaWdodA0KcGxhY2UuIEkgbG9va2VkIGF0
IHRoZSBDcm9zcy1idWZmZXIgQVBJIGJ1dCBvdXIgaW9jdGwoKSBpbnRlcmZhY2UgaXMgcXVpdGUg
c29waGlzdGljYXRlZCBhbmQgSSBhbSB2ZXJ5IHVuc3VyZSBpZiB0aGUgQ3Jvc3MtYnVmZmVyIEFQ
SXMNCmludGVuZGVkIHVzZSBjYXNlcyBtYXRjaCB0aGUgcmVxdWlyZW1lbnRzIHdlIGhhdmUgaW4g
dGhpcyBhcmVhLiBBcmUgdGhlcmUgcGFydHMgaW4gdGhlIFhlbm9tYWk0IEFQSSB3aGljaCBjb3Vs
ZCBiZSBvZiBoZWxwIGhlcmU/DQpNYXliZSBzdGFuZGFyZCBJUEMgbWVjaGFuaXNtcyBhcmUgYmV0
dGVyIHN1aXRlZCBoZXJlLCBzb21ldGhpbmcgbGlrZSBhIGxvY2FsIHNvY2tldCBpbnRlcmZhY2Vz
LiBUaG91Z2gsIEkgZG8gbm90IGhhdmUgbXVjaA0KZXhwZXJpZW5jZSBpbiB0aGUgbmV0d29ya2lu
ZyBkb21haW4uDQoNCk1pdCBmcmV1bmRsaWNoZW4gR3LDvMOfZW4gSSBXaXRoIGJlc3QgcmVnYXJk
cyBJIOelneWlvSENCg0KTWFya3VzIFdlacOfDQoNClNvZnR3YXJlZW50d2lja2x1bmcg4oCTIFNv
ZnR3YXJlIERldmVsb3BtZW50DQoNCkFSQURFWCBBRw0KWmllZ2Vsd2FsZHN0cmFzc2UgMw0KNzM1
NDcgTG9yY2gsIEdlcm1hbnkNClBob25lICs0OSA3MTcyIDkxIDgxIDANCkZheCArNDkgNzE3MiA5
MSA4MSA5MQ0KDQpSZWdpc3RlcmdlcmljaHQgLyBDb21wYW55IHJlZ2lzdGVyOiBVbG0gSFJCIDcw
MTgyOA0KVm9yc3TDpG5kZSAvIGV4ZWN1dGl2ZSBtYW5hZ2VtZW50OiBEci4gU3RlZmFuIEhlbGxm
ZWxkIChWb3JzaXR6ZW5kZXIgLyBDaGFpcm1hbiksIEppIFpoYW5nDQpBdWZzaWNodHNyYXRzdm9y
c2l0eiAvIENoYWlybWFuIG9mIHRoZSBTdXBlcnZpc29yeSBCb2FyZDogWWluZ2JvIFdhbg0Kd3d3
LmFyYWRleC5kZcKgIHzCoCBpbmZvQGFyYWRleC5jb23CoCB8wqAgaHR0cHM6Ly93d3cubGlua2Vk
aW4uY29tL2NvbXBhbnkvYXJhZGV4LWFnwqAgfCBodHRwczovL3d3dy5hcmFkZXguZGUvZGF0ZW5z
Y2h1dHplcmtsYWVydW5nLw0KDQo=
