Received: from redirect.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41A522B8BE
	for <xenomai@lists.linux.dev>; Fri, 16 May 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362599; cv=fail; b=AeDWLYQAV9ApRoNvCB+x6c9E6oghWcUA5DjpIGrGaM1X1zFhgXPZ8mgr4345yWhY7DxHzQ98M9tCD0l3CkCJxo13x15hUjH33mGVZenzNungZL4u4C/9zxDLoL75+KvBrJ+GTnM5p9ce4x9LwAM9Nw3o1qTN+mAXPNd8E0kOhP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362599; c=relaxed/simple;
	bh=pRkeyIkW7P6n5S7A95bRzmUU8YTgjHc/NG42HTN7G50=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HCAkVZCf3yzDTGPSX4CLpJV+EPZn4NtKFLh/P9XPSZ5Co/XWiJvB2uOzKx/CWC2HTkW67GQn76a9smzEpg5VBs633+V5roI2jcNdOPQoN36BSMfkf46LZ4S71eSlVmUgfGeinDODzdiBleulqYQHx1w9i1f31eIOfv/b9To3scg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b=P4sblHPZ; arc=fail smtp.client-ip=217.70.178.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doosan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=doosan.com header.i=@doosan.com header.b="P4sblHPZ"
Received: from spool.mail.gandi.net (spool4.mail.gandi.net [217.70.178.213])
	by relay12.mail.gandi.net (Postfix) with ESMTPS id D7B714372B
	for <xenomai@lists.linux.dev>; Fri, 16 May 2025 02:29:48 +0000 (UTC)
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::2])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 943CD78003C
	for <xenomai@xenomai.org>; Fri, 16 May 2025 02:29:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiinA4z3MltyUYpRpWN5h4bZG3zwlzDWmfT57ct1gASliKgu4UuA6NyYWeQEcxDREXs88O0T8vkTBzgQ7VhVnR0arfM2D0lgXSXb8dE6CsW5HT0EFagr+NgugVYkCdZGBbT/pf1+y5ivPe/yjUwf95WhP2gWYMFzKRrJz3bg3m7Szd13f+EojCEq7Ivf27lVCTqOUo5jopJHvmKG1c2tXy0eQFcB8EBzSo2KAYVfg6nRiCbl5MGpaAQm5jhWtNM6UVTYVDnB6RNEEIovnVmvx305Mw8qTaFRWjDw6in0mPVCi6nUPlO8iFWwSqagiZiUUyU917xp+792gcAKOPQIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRkeyIkW7P6n5S7A95bRzmUU8YTgjHc/NG42HTN7G50=;
 b=XvR3dfxWudvdZSIm+MitIxP57KzwVlksJq6HFM3KI+QebSFYdgBHszN8JEkQvMGBFme5PTkbIq3tLeCpsz0RwKPnZyHLYtbh606JE/fCCDqmBWofi4eEJTegSKsk9oYLBejzyqvZ6Q9do0cWZiDcBn7RlfyOyhW5UZ41dUjPqkusyRwSs/qlEDNuFX2d6uIsdxL/2hg3hGiXAy4nYS7kSVDbLepCbHeugGDiyJ/7oLhPgp4igRSkdL3tbOcq0Uap5JLB3NvKS8CaVWehGb9g0IisYuHOC9pCf32FVSeQYyrKfyw8DyF0c709zKNgUI0VHN+9o8v/nQwsjvILf6GjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=doosan.com; dmarc=pass action=none header.from=doosan.com;
 dkim=pass header.d=doosan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doosan.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRkeyIkW7P6n5S7A95bRzmUU8YTgjHc/NG42HTN7G50=;
 b=P4sblHPZdpjl8sSBgc0Lyl+yLhjB6GYaegmVrJtqoxY3XaP+q+2yFGltEsUCPl89nqMnE7AR/NlH4n3Z5Na3d/b2TLlUyerDZ4UxPbdo4aPTpzDzniDX+/oPHfyEn0DeGaKncKYtCMfd0id2+piUKSdRxYkSfc8UOTk+Fn+tl8E=
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM (2603:1096:101:151::13)
 by SE2P216MB1460.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 02:29:41 +0000
Received: from SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4]) by SL2P216MB2274.KORP216.PROD.OUTLOOK.COM
 ([fe80::a9ab:83f9:e987:37d4%5]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 02:29:41 +0000
From: =?utf-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?utf-8?B?7Iqk?= <junesoo.im@doosan.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org"
	<xenomai@xenomai.org>
Subject: RE: Please recommend the appropriate Kernel and Xenomai version for
 my hardware.
Thread-Topic: Please recommend the appropriate Kernel and Xenomai version for
 my hardware.
Thread-Index: AdvE1hezpDCCPZ86SYGuLq6OIRavHwAGVLEAAEWrX1A=
Date: Fri, 16 May 2025 02:29:41 +0000
Message-ID:
 <SL2P216MB2274E85F2E9ABB2A869F54B7E093A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
References:
 <SL2P216MB227453A028F3203C05B5A8B3E091A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
 <14e0c75f-9f4f-4035-8bed-5f798bc164f4@siemens.com>
In-Reply-To: <14e0c75f-9f4f-4035-8bed-5f798bc164f4@siemens.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2P216MB2274:EE_|SE2P216MB1460:EE_
x-ms-office365-filtering-correlation-id: 0e4bfce6-0721-43b4-17af-08dd94218374
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OXVKdURHM0NEVTVwZ0laU21xbkpoQk9qTFU0eVBQc1hTbTRhelRDWFJKTnF2?=
 =?utf-8?B?U0ZybWhGbWd3QXpLalNUL2Nwc0xuYk93VXpGUzZMbUxrQWptV281bXlYeW53?=
 =?utf-8?B?MExrVWdrVnpDKzNyVzNSdjhObk9Fclo4bWJ6RWVGczhSUGI1YTlqYmROQmdV?=
 =?utf-8?B?VHQ2MHlGYXVURVJJYlljTE5uRzNyR092aHBSWHBNazh3dzJjQVRVdXZNVXdr?=
 =?utf-8?B?SHlmcHNPbmZwQVZPaFc0ZTRYcUc1MmI5bVJGc1pHT1BDVm5MQjd0OXcxUnNZ?=
 =?utf-8?B?ZENZeUoza0Rmd3lFeDRncnhHcm5QL3pwRU00MU81dmlsVmFQcCs2NDAya1k2?=
 =?utf-8?B?TDg1ZlZWM2ZjVlRIUStnRzNEUEY2K1BkSTdrYmpBSkNqMGNMeFhxQmJXaVgv?=
 =?utf-8?B?Z3RkczFVUUtxRTZvMGJCRkp5WkZ6bmhGMXQrd2xoSmwwdGw5QnhwRzZkTmRh?=
 =?utf-8?B?OFM0Yml6d1Jkem1YRVBCaDFUbTZxUGN1cWJGbW5hL05xWjVjOXhQQkE3TFlo?=
 =?utf-8?B?UytYZ29nTUhKVmpkaGd1U2xaUmcrelF4aEQ3dXI1cUhpdk96UjBQWEU3TGRv?=
 =?utf-8?B?QmtSQlNuV2djaXpQcE0wbTNpcWFhUlJyS2xGbnF1OGtZeDgwVjF3Nk0xMksy?=
 =?utf-8?B?c0QxL3M3N3VlUHVpZVdBKzdaR3hrbU8xTTc2R3Jtbkh0aTVSRExobXJVMEpY?=
 =?utf-8?B?Skh4RjZvL3lHZVlWOXE0YW5PcDNNQ0pxTTFaSkIxRExiVncxN3h5Y1FUeGJZ?=
 =?utf-8?B?VzFiTVJIZ2FnTHN0UEVzWW54Mk0vZXdsRklBaElaaTBVSTNuWDlIazBxOWRv?=
 =?utf-8?B?Q1FHaDlVTjNJajEzS0tucmRNbXRNV0xmWXBwbnNGcXdpNWozUFNTbGNkYTZT?=
 =?utf-8?B?cUsyYmRGcFZUYUFGcEcweVNUSVhxY3UyUElNMm12L2dSclBhdndQUTBOdXhl?=
 =?utf-8?B?bGZ5NU0wV1gyeTI4VVJaR1Zkd0RyNUplREpVTExMb0dNSWpoalI0VGk5ZDhK?=
 =?utf-8?B?U2IwU3hVZDFScE9ZOWp3L3JtaEp4Y3MyU21lZHZ3MHdadWgzbU0xQncyUkc0?=
 =?utf-8?B?NTI4K3FianZyazhnVG9tMXgvekdINjBBUis4SFF1Qm1UWGJyeHphZy9HT1JP?=
 =?utf-8?B?bXFpQ005d3NSeWUwcUQ3SVRqTk5tMFlYM0ZBKy8yQXJFWFZOamdtendxNmQ4?=
 =?utf-8?B?RVFWbWF2S3oxYlB0b1ZRZ1pZTFY3OWlDTC9qVXV6b2s3NkxjRFJpZ0p6bHBv?=
 =?utf-8?B?b2pndENBdW1iQkRPZlJkWEhsdlRLdjM3aEZlaFJRRVFXSVRlNXIzcTZuL2Vw?=
 =?utf-8?B?bU5tekJYdGpmMTF5MGZZQnJ2aUdxWVRqOWp3MU5kQy85Q2J0TEgxNi9Sb3JQ?=
 =?utf-8?B?K3dCalcyYUtNSkJTZ0IyNkRHK2k3Wk9Ga1VMenhnenNlMnQ5SnN1S2pIYyty?=
 =?utf-8?B?WkRrQmJwWFAxTXpDdzlieWJjb2VPZkdRcjNNaVFTTThoSFV2M3JHUU12MmxZ?=
 =?utf-8?B?L1hWaExtNzhRajV1SUJaMGp4ZDhjQ1R4MlNPUFo3OGZpenNyWHVyclNmUUFi?=
 =?utf-8?B?L2lQZU00QzZzMjFvVmRGS0Z3MmZaa1JoYkJ6K0ttWFUyT2tKMWpSaDBsaURw?=
 =?utf-8?B?RGp6bjFtaU9qZ0RlZTlOTlcyM1RyMTZFN3loeVJIVko4RzNxeEVNQm95WU14?=
 =?utf-8?B?cEZJdlBZOGViaEdKNG1PQ0tERm9zZWRWekdSaFI1WFRIOGpuQk9neFFFNWtm?=
 =?utf-8?B?Z2lFdllkbnh3VjNoYnhrWGE5aGgxc0R5K2xGQlJ2RW5HUDFBazdZWllmMk9B?=
 =?utf-8?B?T1JQOHc4TXdpbmlNcFprbExZS2NmeWFuME5RMUc2UU5PRmtIdUFvRFM3V01O?=
 =?utf-8?B?VmFuVlQ2TWhBcXNUOXdmblZOVjdhb2Z1QWozcUpzaEs0dkoxVk81TFhUY1lj?=
 =?utf-8?Q?3KZocuXOwGw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2P216MB2274.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTZPdTVPQUtTWXVET3ZPSjVxeXQ4azkwVXF0cy9zQUpFUm9teFhMREVyenVz?=
 =?utf-8?B?UjdvK1NtbEhtaHVSZm1oc3k2Zm5uT1lnMnZBN0RjdTJZYUI0eGNTWEgvYkox?=
 =?utf-8?B?OEFNNmJldXUwNHVQTXpvV2tUd0NoRHM3Qm9Rc0F4MWszMnpjNHd3OEJyUXpk?=
 =?utf-8?B?RUFsUS9qbGM1c0V3WkxPR3RDTEt0TWU5YUxvQjBjcjUxWGtHRXNXQ3lKQVUw?=
 =?utf-8?B?RFEyODVMM3dYakQyZWRtc2NQL1pCUlFRdHJOVVoyWG84eTliYXJuaXgzZFhK?=
 =?utf-8?B?Z1BpMGk3UURGY1hzc0ZiTiszRHdOaXJlZ3hsNk5aeSs0bU1rVVd3WUVSckdR?=
 =?utf-8?B?K2c3c0NIMmw4SHhuM2c2NWl0aVZ4Zy9WK0VEMzdrcEx0YVhSa1gxYTNEaWdS?=
 =?utf-8?B?ZW1uK096NDFnTVpmbzlrQmNBNlhYMFJFQzl4MlZKOTUxQ1BsTU9vazRxNTNX?=
 =?utf-8?B?R2xnR2hud3dsQ2I5Sm9SamlFTEFnWXFPWVp3Q2dMM1R0TUV2aEJCUEtNRzBV?=
 =?utf-8?B?ckl3TlJoZzJ2aE84K1V5QlZBV3NyWGIzeWliK3Q3RThrQlpFa2prNWJFbGdX?=
 =?utf-8?B?MXZ3THNuSHpYMmk0SDRheDFEZU9jZUE5dFVaZkpiZ3NYODBldjBzb00wK0Qx?=
 =?utf-8?B?SS9MTHlyN2IySlhyZ2FlUlRSL20xc0VVVEM1RjR5aXRGRzFnWVc3enphNXQz?=
 =?utf-8?B?bkFpMW5kbFNDSFhJVllKc3dNVThiL0IzczRvQWJqVzRPYVVlbFh2SnduZGRB?=
 =?utf-8?B?bElid3p0TVBoZDN4K2twdE8zVlpzK0dlZEJRWkx0YWpjenc5cDdaU1ZTeThK?=
 =?utf-8?B?ZEFNaDk1ci80ZU1BemRxSkZJUkdVeEdNbVp4SEN1dVUrUUJHZFJiT3NIblpo?=
 =?utf-8?B?VjlPZU5FNXN6dUZ1OUYzSlNPci80Mk5ndzVsT1dSUU8za2lwUm11Wk4yVFJW?=
 =?utf-8?B?cjlQb25LL09hTFI5WTU5bE9xMG9MbFg3Q1BYVzVDSG1sbkRHRlpMMTAyVG80?=
 =?utf-8?B?TmJ5ZVMxbUtBNUp5NFVaaTFSeW53SlJmVjkxcE42b3hNb0V5RkNQMTFEZHJZ?=
 =?utf-8?B?TExjNzVvYkpWWE04Vk14SkQvNzdQZFVUc2doQjQ4V0lPaUpJUjVHekNJU1RW?=
 =?utf-8?B?WE5FNHVyTEpGUGpVdmd1bFFJUlVlTUorSEt1akpoOGdsdnJaNHdxNXNFUGlH?=
 =?utf-8?B?RXhuL244bkdZT2J3OTI3eG9lZUZKMnVDSXF3QzR3R0c0Z2VHdHVJZktKU2dr?=
 =?utf-8?B?d2l2UXBLSDYwY0tYdFJETnRZTUR0Y2pSMTZ6NlNzWXp5b05nQnphaWh4QmF3?=
 =?utf-8?B?TndhRVFQbjBOM3BYZTk0SWJoODdwR1BOMkI5NnJOS2xoMEh1ZkNSTmN0dkt5?=
 =?utf-8?B?Uk9FdjVrek5HL1VBRnNmQnNpSno3WnV4d293TUNHWXhQSjNiVExJQzJVL015?=
 =?utf-8?B?Y1JXTTZOY0dka1ladTdJWUs2YnJ5RDE0eVpUMllJNFAzOVlZQTc2ZVVUSGlW?=
 =?utf-8?B?ajVaMzkrek9HQ1YxY1lmNkpoQnE5ekorSVlpMXBlRFlyejFXblF0TGN0RWk2?=
 =?utf-8?B?SGlNNlRFN3NBems0YnJEMG9nQS9ZdjF5WktHeVBzbzZncW9xMndIcUowZmJ5?=
 =?utf-8?B?U1phem8wVEVrQjZ0ZzVQQnBuSFZMU2QrVVluZmhkb2gzek5xNFM0NDhiZUxH?=
 =?utf-8?B?VFNkdXVCRG1iWUFRNXYzT0NYa0VyeFJ2dmhJcVFWK0JSK1lvZXllOU5WVnBI?=
 =?utf-8?B?by9Ob3lJdjkvYzdWSlhtTTlSa0NkbHdWbG1aUDFlcDVVamdtVlVsR1pJQ3lI?=
 =?utf-8?B?YUczdElwQmQxTzZSMU80ejZ3Nkx4S2huc0FVbktsb1BjZFRMQVZRVUljaWY0?=
 =?utf-8?B?WjNMU3pGNDdVUmd6d3JkMlZaUUV2MUpQTUpvV1FQMXljWTlqTFNYQlpIbXBK?=
 =?utf-8?B?MUM3RUJlMzBOMU1PTmtoNE1LQ3BBZlZiR0RFODRkQTROZnRLWmhFdjg1MFB2?=
 =?utf-8?B?V0J4N3Evc0VIL2drWHV2RW4valJBUGNlZWNJaG9MTDhsR2gwMjFNOWtLdDE2?=
 =?utf-8?B?QTVXc0hOd0gwZVZTTFlrU2ZobXNERzBXckRUd3c2Qm5Yd2xFanFiMkZSRGtC?=
 =?utf-8?Q?pMqaaNfN0cjbG2t4WQIMCDDaH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4bfce6-0721-43b4-17af-08dd94218374
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 02:29:41.4665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1b3610-9ab0-42d5-93aa-46150d723d87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /WCGIEqmJjwK/3+E5bTKMuivJ2wk6VLddFrqdsQ4Q/wkxzjoKFMoJYVvyEozXv+wNwHxsYVOGKCQuNbUhN27ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2P216MB1460
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=doosan.com header.s=selector1 header.b=P4sblHPZ;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	dmarc=pass (policy=none) header.from=doosan.com;
	spf=pass (spool.mail.gandi.net: domain of junesoo.im@doosan.com designates 2a01:111:f403:c40f::2 as permitted sender) smtp.mailfrom=junesoo.im@doosan.com
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudduheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjggtgfggsehtsgdttddttdejnecuhfhrohhmpejnnjjnldfluhhnvghsohhoucfkmhdmucjnnjcunjjnnjjnnjjnuceojhhunhgvshhoohdrihhmseguohhoshgrnhdrtghomheqnecuggftrfgrthhtvghrnhepueeigeduuedtgeelheejveeiiedvfefhkeehvdehtddvvdettdduteefudegffdvnecuffhomhgrihhnpeguvghngidruggvpdhlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgnecukfhppedvudejrdejtddrudejkedrvddufedpvdeitdefmedutdelieemuddtudemudehudemmedufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdejtddrudejkedrvddufedphhgvlhhopehsphhoohhlrdhmrghilhdrghgrnhguihdrnhgvthdpmhgrihhlfhhrohhmpehjuhhnvghsohhordhimhesughoohhsrghnrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

VGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlLg0KDQoNClRoYW5rcyB0byB5b3VyIGV4cGxhbmF0
aW9uLCBJIGhhdmUgZGVjaWRlZCB0byB1c2UgNCBjb3JlcyBmb3IgWGVub21haSBhbmQgdGhlIHJl
bWFpbmluZyA0IGNvcmVzIGZvciBQb3NpeC4NCg0KDQpJdCBzZWVtcyB0aGF0IEkgbmVlZCB0byBh
cHBseSB0aGUgRG92ZXRhaWwgcGF0Y2ggdG8gdGhlIGtlcm5lbC4NCkNvdWxkIHlvdSBwbGVhc2Ug
bGV0IG1lIGtub3cgdGhlIG1vc3QgdGVzdGVkIGFuZCBzdGFibGUga2VybmVsIHZlcnNpb24gYW5k
IFhlbm9tYWkgdmVyc2lvbj8NCg0KDQpBbHNvLCBwbGVhc2UgcHJvdmlkZSB0aGUgVVJMIHdoZXJl
IEkgY2FuIGRvd25sb2FkIHRoZSBEb3ZldGFpbCBwYXRjaC4NClRoZSBVUkwgaHR0cHM6Ly9mdHAu
ZGVueC5kZS9wdWIgZG9lcyBub3QgaGF2ZSB0aGUgRG92ZXRhaWwgcGF0Y2guDQoNCg0KQmVzdCBy
ZWdhcmRzLg0KSnVuZXNvby5JbQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IFRodXJzZGF5LCBN
YXkgMTUsIDIwMjUgMTo0NCBBTQ0KVG86IOyehOykgOyImChKdW5lc29vIEltKSDsiJjshJ0g65GQ
7IKw66Gc67O07Yux7IqkIDxqdW5lc29vLmltQGRvb3Nhbi5jb20+OyB4ZW5vbWFpQHhlbm9tYWku
b3JnDQpTdWJqZWN0OiBSZTogUGxlYXNlIHJlY29tbWVuZCB0aGUgYXBwcm9wcmlhdGUgS2VybmVs
IGFuZCBYZW5vbWFpIHZlcnNpb24gZm9yIG15IGhhcmR3YXJlLg0KDQrso7zsnZg6IOydtCDrqZTs
nbzsnYAg7Jm467aA7JeQ7IScIOuwnOyGoSDrkJjsl4jsirXri4jri6QuIOunge2BrCDtmLnsnYAg
7LKo67aA7YyM7J28IOyXtOuejCDsi5wg7KO87J2Y7ZWY7Iuc6riwIOuwlOuejeuLiOuLpC4NCg0K
Q0FVVElPTjogVGhpcyBlbWFpbCBpcyBzZW50IGJ5IGFuIGV4dGVybmFsIGFjY291bnQuIFBsZWFz
ZSB0YWtlIGV4dHJhIGNhdXRpb24gd2hlbiBjbGlja2luZyB0aGUgbGluayBvciBvcGVuaW5nIHRo
ZSBhdHRhY2htZW50Lg0KDQpPbiAxNC4wNS4yNSAxNTo1Nywg7J6E7KSA7IiYKEp1bmVzb28gSW0p
IOyImOyEnSDrkZDsgrDroZzrs7Tti7HsiqQgd3JvdGU6DQo+IEhlbGxvLCBJJ20gSnVuZXNvby5J
bS4NCj4NCj4NCj4gSSBhbSB3cml0aW5nIHRvIHlvdSBiZWNhdXNlIEkgaGF2ZSBhIGZldyBxdWVz
dGlvbnMgYWJvdXQgWGVub21haS4NCj4NCj4NCj4gSSBoYXZlIGFuIEFkdmFudGVjaCBQQyB3aXRo
IGFuIEludGVsIGkzLU4zMDUgQ1BVLiBUaGUgQ1BVIGhhcyA4IGNvcmVzLg0KPg0KPiBRMS4gQ291
bGQgeW91IHJlY29tbWVuZCB0aGUgYXBwcm9wcmlhdGUgS2VybmVsIGFuZCBYZW5vbWFpIHZlcnNp
b24gZm9yIG15IGhhcmR3YXJlPw0KPiAgICAgKklmIHBvc3NpYmxlLCBJIHdvdWxkIHByZWZlciBJ
LVBJUEUgb3IgRG92ZXRhaWwuIEkgdW5kZXJzdGFuZCB0aGF0IEktUElQRSBvciBEb3ZldGFpbCBh
cmUgbW9yZSB0ZXN0ZWQgYW5kIGhhdmUgc3RhYmxlIHZlcnNpb25zIGNvbXBhcmVkIHRvIEVWTC4g
SSBtaWdodCBiZSB3cm9uZyBhYm91dCB0aGlzLg0KPg0KDQpJLXBpcGUgaXMgaW4gZGVlcCBtYWlu
dGVuYW5jZSBhbmQgb25seSBhdmFpbGFibGUgZm9yIHZlcnkgb2xkIGtlcm5lbHMgKDQuNC1jaXAs
IDQuMTktY2lwLCA1LjQpIG9uIHdoaWNoIHlvdSBzdXJlbHkgZG9uJ3Qgd2FudCB0byBzdGFydCBu
ZXcgZGV2ZWxvcG1lbnRzLiBBIHJlYXNvbmFibGUgYmFzZWxpbmUgbm93IGlzIDYuMTIsIGFuZCB0
aGF0IG1hbmRhdGVzIGRvdmV0YWlsLg0KDQpXaGV0aGVyIHlvdSBjaG9vc2UgWGVub21haSAzIG9y
IDQgKEVWTCkgaXMgdGhhdCBhbm90aGVyIHBvaW50LCBzZWUgYmVsb3cuDQoNCj4NCj4gUTIuIEFk
ZGl0aW9uYWxseSwgZnJvbSB3aGF0IEkgZm91bmQgb3V0IG9uIHRoZSBYZW5vbWFpIHNpdGUsDQo+
ICAgICBkdWFsIGtlcm5lbCAoQ29iYWx0KSBpcyBiZXR0ZXIgZm9yIDQgY29yZXMgb3IgZmV3ZXIs
IGFuZCBzaW5nbGUga2VybmVsIGlzIGJldHRlciBmb3IgbW9yZSB0aGFuIDQgY29yZXMuDQo+ICAg
ICBJcyB0aGlzIHRydWU/DQo+DQoNClRoZSBzY2FsYWJpbGl0eSBsaW1pdGF0aW9uIG9mIFhlbm9t
YWkgMyBoYXMgYmVlbiBhZGRyZXNzZWQgaW4gRVZMLiBTbywgaWYgeW91IGhhdmUgUlQgd29ya2xv
YWQgdGhhdCBhY3R1YWxseSBuZWVkcyB0byBtYWtlIHVzZSBvZiBhbGwgOCBjb3JlcywgeW91IGJl
dHRlciBoYXZlIGEgbG9vayBhdCBYZW5vbWFpIDQuDQoNClJlZ2FyZGluZyAic2luZ2xlIGtlcm5l
bCI6IERvIHlvdXIgbWVhc3VyZW1lbnQgd2l0aCBQUkVFTVBULVJUIGFuZCBjb21wYXJlIHlvdXJz
ZWxmIGlmIGxhdGVuY2llcyBhbmQgbWFyZ2lucyBhcmUgc3VmZmljaWVudCBmb3IgeW91ciB3b3Jr
bG9hZC4gVGhlcmUgaXMgYWxzbyB0aGUgYXNwZWN0IG9mIGNsZWFyIHNlcGFyYXRpb24gYmV0d2Vl
biBSVCBhbmQgbm9uLVJUIHRoYXQgY29tZXMgd2l0aCBhIGR1YWwga2VybmVsIGJ1dCBub3Qgd2l0
aCBhIHNpbmdsZSBvbmUuIEhvd2V2ZXIsIGlmIHlvdSBzdWZmaWNpZW50bHkgdW5kZXJzdGFuZCB3
aGF0IHlvdSBhcmUgY2FsbGluZywgd2hhdCB0aGVuIGhhcHBlbnMgaW5zaWRlIHRoZSBrZXJuZWwg
YW5kIGhvdyB0byB0dW5lIHRoYXQgcHJvcGVybHkgc28gdGhhdCBSVCBwYXRocyBhcmUgcHJpb3Jp
dGl6ZWQsIFBSRUVNUFQtUlQgaXMgYSB2YWxpZCBvcHRpb24uDQoNCj4NCj4gUTMuIEkgd291bGQg
bGlrZSB0byBsZWFybiBtb3JlIGFib3V0IHNpbmdsZSBrZXJuZWwuIENvdWxkIHlvdSByZWNvbW1l
bmQgYW55IHJlc291cmNlcz8NCj4NCg0KU3RhcnQgZnJvbSBoZXJlOiBodHRwczovL3dpa2kubGlu
dXhmb3VuZGF0aW9uLm9yZy9yZWFsdGltZS9zdGFydA0KDQpCZXN0IHJlZ2FyZHMsDQpKYW4NCg0K
LS0NClNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCkxpbnV4IEV4cGVydCBD
ZW50ZXINCg==
