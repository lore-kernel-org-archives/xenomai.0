Received: from redirect.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176C35957
	for <xenomai@lists.linux.dev>; Thu, 17 Jul 2025 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.230
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740373; cv=fail; b=bzzbYmfkQ9ZMMAI/NmxopGLLuqD1opN0ygivAAsAvVIQ1zM6HAOwlpxHHVPPgjyHgdmepKTLidglg/Ue/zQuwZZX0ski79wM9hdqJzpVQ+W64xxoqG6w279pCs8FGAloVs/WLr31aFjtEUEeq4TyNzfSm+VFaawnfP5qfzxsGoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740373; c=relaxed/simple;
	bh=f3zRG1GIvimCzM2jL8kKkNlGttCh1BzYTHYMSORBxu4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jC3AofZflG24/aDKU5FUuM4P3s92JqhWu7+nQ/NHhDA1inYheHgxbU4CKfN4wZQKUcnAkfPpDgmEaLZkHpLrZ7s+3erxC/EWpxFGUgfcj8QmaPBMSZbcFWEqRat+OA9qYQ4up3SRtEceC7+A53OM/agJuxuu2vMUzBQZ3k8MxUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=nW1e1YXJ; arc=fail smtp.client-ip=217.70.178.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="nW1e1YXJ"
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay10.mail.gandi.net (Postfix) with ESMTPS id F142A42DD1
	for <xenomai@lists.linux.dev>; Thu, 17 Jul 2025 08:19:28 +0000 (UTC)
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::2])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 15D6C74003E
	for <xenomai@xenomai.org>; Thu, 17 Jul 2025 08:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvPWyqxCErW76nElEIGfrMgA6fTEmYniY7ffEdCwnLD8Mnocw8zvq6EPh6EKgYA1xYNBBW8LPhS1cT2NzMHHSXHUrUGDnOBShWRXPvGmCW4W4MTyzMnGX8Qvy+hA9lLFdH4wOlUn0EeURwpu1oBSAS/iZn23hSA3JUY1wOzFc1QR8XQ9YCD0WAhBVIlRP5beHXxbr12ccqe09dpK14XUb975q9Agw2lQGMAWXn7+Ht22iWMx17urs17Qb9K/5bFaJiY2j0qJYxerlAMSfw8F2KWEWSU8QOob0Kzb+NFprOOptNgxwxMAQgmNvipUNsI+IH3FFeSZC6mdA5oP1NIg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3zRG1GIvimCzM2jL8kKkNlGttCh1BzYTHYMSORBxu4=;
 b=MgbR909SZ0sEWJxxukTwO6d2civCyMn1Yzy4CGJu76t2iQPP/OGrZvC5B2YMbLwTqFWHq4JTbYD84MrRsZrIkn/HxoNUjF6+0CPTsx4ta7SP94OKOVaKN8o4op9TvvDZ8AbaBucheEJAWZGZHc189aHSScbuB06ncllbWP6penutveLMWvDkiHBk/o7p4hRp/KuzLnN9K4eAPHzo1oToPy3wsFmXSjAPG/7x3kIwUyTuWJAzhVtCw1on5pWRBA8DrIyZdCLh1XUn5UdvrBZmeInIZ4XEGvT9qQ0REK1nrBLoeUGvK0nwGMBLeAUMr6rg+YhJdpyjnBqdduumyvFKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3zRG1GIvimCzM2jL8kKkNlGttCh1BzYTHYMSORBxu4=;
 b=nW1e1YXJIWPeySsm5Qhjzi+Lmk2cQrGvik4gPoSt3uioFcaVT/qn+mNm/ej0vzLTSHDa5jlMY7NZIEMwdGS2StaBAH8hcPr19DIXE0JRa5SJG0uUDYkBSoUqcqesEgJ10v/riyoV4LeMnDKbMuqNrO9ZhrD2ilLYJ+Qpplbdv7g=
Received: from PU4P216MB1353.KORP216.PROD.OUTLOOK.COM (2603:1096:301:ab::6) by
 PU4P216MB1290.KORP216.PROD.OUTLOOK.COM (2603:1096:301:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 08:19:23 +0000
Received: from PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
 ([fe80::36d7:72e0:f391:d57e]) by PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
 ([fe80::36d7:72e0:f391:d57e%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 08:19:22 +0000
From: =?utf-8?B?7Iug66+87LKgKE1pbmNoZW9sIFNoaW4pIOyEoOyehCDrkZDsgrDroZzrs7Q=?=
 =?utf-8?B?7Yux7Iqk?= <mincheol1.shin@doosan.com>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject: POSIX Socket API and RT IPC Connection
Thread-Topic: POSIX Socket API and RT IPC Connection
Thread-Index: Adv28qj5u0Pzfu1pT6ud35XBHNnM5A==
Date: Thu, 17 Jul 2025 08:19:22 +0000
Message-ID:
 <PU4P216MB1353E1FD6D6652A5884282F5A951A@PU4P216MB1353.KORP216.PROD.OUTLOOK.COM>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU4P216MB1353:EE_|PU4P216MB1290:EE_
x-ms-office365-filtering-correlation-id: 7ca47462-b957-44ad-9802-08ddc50aa2b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WkQrMTRNRSs4L1lUS1pwTCtaMElvY2FqQTROWTNPNHprYitnbWxDNEFweWdB?=
 =?utf-8?B?QVJ1dmlEeFE1ekhBWi9mK0FCZFFKNUhnU2xOamtqYVQ1dCthcWV0c2o2S0wz?=
 =?utf-8?B?Tm5OWEVKN25COHhjMnd1cFB2azhqYjV0ZTBIRXg0eDRJakM4VzZkR2lYbFVv?=
 =?utf-8?B?Tmw1NHRjdmM4YlZVR1RMMTA5Zjd6dmxodmtaTnRCUE56Qnp0MnFSdm9WQ0xX?=
 =?utf-8?B?NkVBQ0hNcU1vb20xSDdLNGordFdISW5mOTIvNThoaVdTdlNwUGlWRkExaGoy?=
 =?utf-8?B?ZGExYjMvVmZXME9uMDR6SUlSNVh5N1NSSGVBV0s3LysyY2hKSDhJdUlDNlU1?=
 =?utf-8?B?bVREVnZLaThSQ20zNFpjSy9UQXJxRDhXRFpHdFdnYjV0QXZKTGloQlZSVVJK?=
 =?utf-8?B?cDE1Mnkya2RXNzNxSldrbTFwNnVZYllqNVg1UGNUVHlhS3FldGtjeHd1RGh6?=
 =?utf-8?B?d0dnQkFUN1BJcVZwTG1EYmkrL1hBZFZ0Ri9OelVlWmlRNStBeDVjOFcwRVpF?=
 =?utf-8?B?NndOSWVjTFJ2SWdjOGV2VDdNdUhaNzBvb09rTmhQa0FVSkJaTUI0a3VzVXQy?=
 =?utf-8?B?d3VUeTJzR1g2NEg3b0VGVmFJb0RHdGtvZjR5T29EcUQ2VUZRMWthM0dCTG1u?=
 =?utf-8?B?Y1VXY1dlMVFxSjNQTGNobEF5eVdnQlVJK0IreDdrR2UwNWowTVU5TzcyZ0NK?=
 =?utf-8?B?a1FIajI5UWlBM1V5eTR6bVZyRm1iUy9HUHdYTEQxVXpGaTQwSEdweDNQbEFx?=
 =?utf-8?B?dW5XWHIxdWxWclBpVlRDanNIZ1JIaHk5RDd0bGJpYUYycXQ1RkhKV0ZVOHla?=
 =?utf-8?B?Z2JBMmRTNWFWakFmSENPSjJDNDdIV1ZXWjlhWExWK29uendNck9zeGk0MWlL?=
 =?utf-8?B?SVFqUDQyYmxQNEZvWUxDYU9MM2xWbU9hOXRLYXJJLzdsOU1jU1ZySUtucnhG?=
 =?utf-8?B?ZGo1SEVSY011SkJKSXlTZWlGRTdLeStrc1JKaEVENkxtYTVlN1loeDJ3LzhG?=
 =?utf-8?B?WEF6M1Qxa2pnQVducVFBUlp1U3ZpSE1sVDFTNWVqNWlRWWlSazZKSHNEbXpT?=
 =?utf-8?B?bXVKZTY2S1o2M2FUQVZUcXdOWjM2d2phUFNrTzE0TDRnMmo3TmU0TWJsQzU5?=
 =?utf-8?B?TGJIMkVIMVZxRGk5d0c1RVArYnE3N2JPWjF4U1pvTXpQRjBmdUhTWGNoU2xK?=
 =?utf-8?B?OHFrbEYyZ0hyc3lBRFI1b0R1RVRVbXJUNEx1NEtMcHF6anp6eG9Jb0tpdzRL?=
 =?utf-8?B?ZG03UUlGamo5bndIZ3Q0b08rR3VyM3VBcENRYURoUjR0cWUxUlZ5dzlBeDJY?=
 =?utf-8?B?TzE0T2RJaHRLT0lPRkZRNDdqek1aU1pVYnR3eFRDc09ER052cEpEUURLVDdM?=
 =?utf-8?B?YngvMURQWmh3R0xHSjBRVnZ5UXRsZjdHQ3hmMHErT29KZHNrOUU1UGVaTUdn?=
 =?utf-8?B?ZU9KUThib1BGTXFwVEFxRWU4Y0FVaU5YTWNvUkdoN3V2cVo5REdSZEtDUFhC?=
 =?utf-8?B?TExTd0ZrNDhyRlVnL1dWVnhITVZGejViQUQ0UDl1NkdGckkzWHVBc21lS2Rx?=
 =?utf-8?B?UEpTVFNmRFlabHk2MGlGeGttVk03aFdNRGUwTk8zYTdKM1ZBSG1sUlQvYTFy?=
 =?utf-8?B?eWNQa1FmVXZzakNhakFsOEptQVlyQjF3Q2Yvb3U2eFNvQURhNjJzOVFoYU5h?=
 =?utf-8?B?UGxLclFabmJ2NklFTTA0RG9ZTnNJYUlJZ3F1aVh6ZGJ5WjJnTGV5UnJPWjB5?=
 =?utf-8?B?OGdlMUR1UTk0dldFLzgvbUZYRkZIeWIra0tnaEdsUm55TmtSWEQ2b0pKTEhK?=
 =?utf-8?B?TWg1Z3IzSWZlU3QyR2g1QWpVWjNuQm5yZ2EyTUROR2dsZUJKZGMxNTlmNWVP?=
 =?utf-8?B?SW8yN3g5SmZJeXpjU1Y3U21EcG1ud1FvQ3oxS2FPMjVZVjBOVVhCZnZzUzJY?=
 =?utf-8?Q?+ZP0V+vj1RA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU4P216MB1353.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEtTNFVkU09TVC9zSE5yeVJKOUEyZCtzdEd2RkQrenJlR0ovUmxTaHMxQjRG?=
 =?utf-8?B?Kys5YUphVm0vQXNpeTk5ZFVjTXdxWmhxM3hIT2dXMUxWVEpnMllWQlRBbkZk?=
 =?utf-8?B?RllmdDZla3JmMGFKOWtjbmpZK3hhTVlzOGtYWWxaSHJObE8vaVdlTXBXeCtq?=
 =?utf-8?B?Vm5MRTdVVi96WGxlcDVyTUpUaXZKeVJ4bGJRUWQvc1hUa2VCR1FLZFcybzQy?=
 =?utf-8?B?d3ZjWkZuaHNuMWJkdldGL3doMGlvbFlPWTh5MW9Xamp1ZkR0cm9WSXFtMHJO?=
 =?utf-8?B?bTVTR0s3aEd4Z2s3aFlWNjBhM2RrdTc4bmdJSW5BU2NvbGlKVnUyc0ErcWh1?=
 =?utf-8?B?bUxkSWtzTTY2K21OUUQ0anBITCsyZnF3U1lEUEpBTzY3eDFHejZnOXR3bFVX?=
 =?utf-8?B?Y2o1b3V0M24xQ0lKcnhrWkJvcm5Yd0VtS2lzRzdRVmpQbFNkRFF3K3krK0p4?=
 =?utf-8?B?cTU2alByaWNtZmFUMEdpNllNQ01oRk4wQkdoL0ZKaENERnFESGxsa1Mrem1y?=
 =?utf-8?B?VVU3OHZJN2FmcGtaWXhkZ1dZM1h5ejJZYkt4VUZkbjFucXVMT3RrNHJkVUUx?=
 =?utf-8?B?eUx4SnVCd0U4NG9sUlMzZnpCZkl5YmFSVTdxcHdQb2haWUVyV1ErUzExdFlJ?=
 =?utf-8?B?dWhJR0pINnBkS0wxWnhpbDhaSllrUWRpUjg3Qlgwa1VqR3IzWHJleFdzOHl0?=
 =?utf-8?B?WmRpNk16NWlzMTRLYjZCenRLa2Z3WFRJUnJpOGNRSSs1MWJER1ZVTXRDZ1Zv?=
 =?utf-8?B?cXNSK0dRMHMwRzY2TEhyUzFQbnFpZHllQ2tvN2p6Qms1U1JUVHBjTkxyeEx0?=
 =?utf-8?B?dmFYSmc3VnFSWjNoa1E1VTF5dUpGK0lmeElvK1o2cjMyOWgvSURNcy9xZTQ4?=
 =?utf-8?B?VUNwajNBWTNIUExXMVNGMVJJRHVRRCszbzNFWFpvcGhpblEvLzlpWm4vekRY?=
 =?utf-8?B?c0FPSlRBeW1KMTFaT3huS0t1SFYxSzdpcGtwSldjUWVqOVFpK2FwaWxHRjJZ?=
 =?utf-8?B?RGVadkhnbHIwS2NtVU5IOUJrSmRwY1NPMnlZbmZRMjRwUFgySWhRT3QwMkVu?=
 =?utf-8?B?VmVyOXBEb3lQdEdXbjZWMjdlQ1d1NytleDc1SzFRS2lUS2V3UjRCWEVjOGRM?=
 =?utf-8?B?bUMwUlFLeHVSbHkxcW9Nd2lVa054S1kvK3FTTURRU3hVSW12U2tOYUNNUUFE?=
 =?utf-8?B?REx5b3luL1hINzNMbEFSbE8wVGZLTWVDdklvcWhOSnd5cytZVURDNmF4a1Rw?=
 =?utf-8?B?RUE3cE5OazBjdDY5ZnNNSzk5WjN2NnZndEUvRm9MR2JtNE1XQjBhd2dOYkYw?=
 =?utf-8?B?YnhEV3Y4bHlRUnFPTnNkaFZub2pQSVV2Ull4TFpXK1M1eW1IaEdkUHk5dmd3?=
 =?utf-8?B?WWZuS3lrMDA4UW12NWVyQ0tLTE9XVldwbzRjK3l4eGp3WHloSVBBVWh2a1RO?=
 =?utf-8?B?Zy9TTVJlcU93Y2NySUZVMHlhY2k4QitsQU9PWlBidm13UGtlVXMzbkEzZ1pX?=
 =?utf-8?B?TG9jVEl0ZSttNVIvMmkvYzF1dll6MzNya3FuZkdIWEVRMHRNUG1tcmFWWDhZ?=
 =?utf-8?B?TFN1dVluNUI0SnFwVzB0R21zRkE2R0htK21BYy9YQVN3UmdZdndQOUlWV1RU?=
 =?utf-8?B?WHdZbTN3c0Y4TjVlY05FOXhlOENQZ00wUElVTTcvbjNiTXAwem1pY3hHbUlm?=
 =?utf-8?B?aTBrbUN0L2pSMS8veXAyUnhueTF5NVRtRW1OYXlKaS9vZEpkK2NiakpaTUVL?=
 =?utf-8?B?NERZeHlSbVZoeU9SZ1lmZDZ0YVVxY0NhSCtzc3NMNjkyR2Y3UG85M09tOXBO?=
 =?utf-8?B?OEQ5UjVxQ00rR1o2czBTZVFVbTA3eElVUXhUSGlMT2l2R3JCNmhVWVMwRWI0?=
 =?utf-8?B?QkN4KzFqZUJJbXVOQUxiZDhsSXg5N20ySlpzOHJkS0tlakUwMnVPc1BvS2sx?=
 =?utf-8?B?WVA0RmNlLzcvdFducFdweW9ZWElrcGp6U0Z3MXhGdDV5czNuTy9Rd0lyczUz?=
 =?utf-8?B?SkpJZWZXRmNOVFl0WE1sc2t3bHh4VEpTejRJMUJ0Y3hweXQraXpBSThuY3Zq?=
 =?utf-8?B?MUdmaTVCdEptZFN0aWFONTZEaDRxeXhVakFzTVQzWXZTUDVtS0ZyYTRIMXZU?=
 =?utf-8?Q?YNYOtzq8PcTkZrk7ffD3KI6AI?=
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
X-MS-Exchange-CrossTenant-AuthSource: PU4P216MB1353.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca47462-b957-44ad-9802-08ddc50aa2b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 08:19:22.6309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nH1UZcH1HbRsDmoDwoV1bQjS5sfTRcIUovuy4D6U7Zx79SIpjCmRy8yY0te3ZwJIIoTpJP2kSutWi16DliqzXb9GF9rkVC/lBZdgpazrgLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU4P216MB1290
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=doosan.com header.s=selector1 header.b=nW1e1YXJ;
	spf=pass (spool.mail.gandi.net: domain of mincheol1.shin@doosan.com designates 2a01:111:f403:c40f::2 as permitted sender) smtp.mailfrom=mincheol1.shin@doosan.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=none) header.from=doosan.com
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffuthffkfgtgfggsehtsgdttddttdejnecuhfhrohhmpejmmjjmldfoihhntghhvgholhcuufhhihhnmdcumjjmucjmmjjmmjjmmjcuoehmihhntghhvgholhdurdhshhhinhesughoohhsrghnrdgtohhmqeenucggtffrrghtthgvrhhnpefhvefgteevhffhffevleduhedvieetvedtvdfhgeekjeettdegueeuveduleetieenucffohhmrghinhepughoohhsrghnrhhosghothhitghsrdgtohhmnecukfhppedvudejrdejtddrudejkedrvdduuddpvdeitdefmedutdelieemfedtudemrggsmeemieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvdduuddphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehmihhntghhvgholhdurdhshhhinhesughoohhsrghnrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

RGVhciBYZW5vbWFpIFRlYW0sDQoNCkkgaGF2ZSBhIGZldyBxdWVzdGlvbnMgcmVnYXJkaW5nIGlu
dGVyLXByb2Nlc3MgY29tbXVuaWNhdGlvbiBhbmQgc29ja2V0IHVzYWdlIGluIFhlbm9tYWkgcmVh
bC10aW1lIHRhc2tzOg0KDQpVc2luZyBVRFMgU29ja2V0cyBpbiBSVCBUYXNrcw0KSXMgaXQgYWNj
ZXB0YWJsZSB0byB1c2Ugc3RhbmRhcmQgVW5peCBEb21haW4gU29ja2V0cyAoVURTKSBmb3IgSVBD
IGJldHdlZW4gcmVhbC10aW1lIChSVCkgdGFza3MgaW4gWGVub21haT8gQXJlIHRoZXJlIGFueSBj
YXZlYXRzIG9yIHJlY29tbWVuZGF0aW9ucyB5b3UgY2FuIHNoYXJlIHJlZ2FyZGluZyB0aGlzIGFw
cHJvYWNoPw0KDQpTdGFuZGFyZCBTb2NrZXQgQVBJIGluIFJUIFByb2Nlc3Nlcw0KSWYgSSBpbXBs
ZW1lbnQgYW4gUlQgcHJvY2VzcyB0aGF0IGNvbW11bmljYXRlcyB3aXRoIGV4dGVybmFsIGRldmlj
ZXMsIGlzIGl0IHNhZmUgdG8gdXNlIHRoZSBzdGFuZGFyZCBzb2NrZXQgQVBJPyBPciBhcmUgdGhl
cmUgc3BlY2lmaWMgZ3VpZGVsaW5lcyBvciBiZXN0IHByYWN0aWNlcyBmb3Igc3VjaCBzY2VuYXJp
b3MgaW4gWGVub21haT8NCg0KSUREUCAmIFhERFAgQ29tbXVuaWNhdGlvbiBTcGVjaWZpY2F0aW9u
cw0KQ291bGQgeW91IHBsZWFzZSBwcm92aWRlIGRldGFpbHMgYWJvdXQgdGhlIGNvbW11bmljYXRp
b24gc3BlY2lmaWNhdGlvbnMgb2YgSUREUCBhbmQgWEREUD8NClNwZWNpZmljYWxseToNCg0KQXJl
IHRoZXNlIGludGVyZmFjZXMgbGltaXRlZCB0byAxOjEgY29tbXVuaWNhdGlvbiwgb3IgZG8gdGhl
eSBzdXBwb3J0IE46TiAobWFueS10by1tYW55KSBjb21tdW5pY2F0aW9uIG1vZGVscz8NCg0KQXJl
IHRoZXJlIGFueSB0ZWNobmljYWwgbGltaXRhdGlvbnMgb3IgcmVjb21tZW5kZWQgdXNhZ2UgcGF0
dGVybnMgZm9yIHRoZXNlIElQQyBtZWNoYW5pc21zPw0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZv
ciB5b3VyIHN1cHBvcnQgYW5kIGZvciBwcm92aWRpbmcgc3VjaCBhIHBvd2VyZnVsIHJlYWwtdGlt
ZSBmcmFtZXdvcmsuDQoNCkJlc3QgcmVnYXJkcywNClNoaW4gTWluIGNoZW9sDQpEZXZlbG9wZXIs
IENvbnRyb2wgQXJjaGl0ZWN0dXJlICYgRnJhbWV3b3JrIFRlYW0NCsKgDQogDQoxNTUsIEplb25n
amFpbC1ybywgQnVuZGFuZy1ndSwgU2VvbmduYW0tc2ksIEd5ZW9uZ2dpLWRvDQpFbWFpbCA6wqBt
aW5jaGVvbDEuc2hpbkBkb29zYW4uY29tDQpNb2JpbGUgOiAwMTAgNDY5OSAxNzUxDQpXZWIgOiB3
d3cuZG9vc2Fucm9ib3RpY3MuY29tDQrCoA0KIA0KICAgIA0KwqANCg0KwqANCg0KDQo=
