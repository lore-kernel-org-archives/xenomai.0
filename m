Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F061EEC8
	for <xenomai@lists.linux.dev>; Tue, 20 May 2025 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=217.70.178.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725034; cv=fail; b=vAf67keJ9plGPnxUJu0oOns+Bwq+y3avYuIM9pmoceZEc/FQQ15PIgAN7xWp595pqqchkCg6dgV8vO7l6E2vOYukP07jIQoe+ElTokplRwYz5V57RiacXuMMCorlIZxwzQ0iohhaqNfgttBU/LeqoYlkjD+mvJAlYc/i9Q+p/z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725034; c=relaxed/simple;
	bh=LBO6vc7u0POmwr9pth6KyjTmps+L+6YLx+Xl9vbQFKQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lcDMs4WHceeOj0LfK8g4Rn/ej/TlR61gtTBSmwJwUvWKXUJEtYkUS+Jw1obg/LqmJIGIMciSNHjIa8ggr7xeIE6o0dp0vu678RGLvaBuLg0m0Mut5zwOcpLr4oWktrMHdSh9bm09qDHobs+eB8PLmrxWetBEUFv/j0aNvZT0jcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vgB4l2XA; arc=fail smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vgB4l2XA"
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 28C5B41C7A
	for <xenomai@lists.linux.dev>; Tue, 20 May 2025 07:10:24 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on20623.outbound.protection.outlook.com [IPv6:2a01:111:f403:2612::623])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 4A6A5D80122
	for <xenomai@xenomai.org>; Tue, 20 May 2025 07:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8udikdRmgI5QU4fz2MH19yhXQAM9qJduoFBBVuPacdbiIiw66RKeLSkjE+4Y5AqGhaXon1zOeUoj5rioyj8vqVWQDEjaxtAGFcl0U6fuSan3ySCGySrGP69mO7GR33ofixVeT2BS1AoYbAZI5Vh96nA6QIS5Hyq3QHYTkMX4kJuahde0z83cscAdgVz67H3+tFBmO6s9c15XywxqxPI0ljgKqat1vXwYqVQtsSEBtYHJCj+0wF90HgVnz5wFf7EYYQf7hlb09jGBnWKc+xCXQFll1fnQ2Mhgjt7lnzTySLyhy3VrGdH6ZmbUAJO146ALRo9TrbEGwdmNV0gObADzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPXYHHKvQAMoclDWU5njTbezSuOfMyNJhvA1UYjntq0=;
 b=Eb8tFUHbVVJnSPE5usJbxl8gqgcjfMLvybCzLpfjoxnwXSuxp/DceU+QfnCHOIZavdfZrQbimWyMO4wBcXpnj2Zw7y5atmDklRbQ5fikp9t1mogm0jUls9X88XoamIE7rFLovmcqqueHPhBjbih+M4oFeqeUIRnWVJZF0GLooJfO5TQVWyCKn1YEJpRRf/d8WqUnOxFS4lj3q+kcSW0rVHmDW9Bvxs8K4amfoVJkzLv4VdWSQkVAyIGeIX2LAWIb+IUib6CyCsP6nMRFjxLQKrcfIemD+N56LcanaJQ/fZws1+hcDwsoQo29rJ83rDsPi369hwHwsbQiYAmSrp16dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPXYHHKvQAMoclDWU5njTbezSuOfMyNJhvA1UYjntq0=;
 b=vgB4l2XAYpA3CzpDAo5X0grXI6Oys71qhxhrEt8c03tN/5DHMsoNp5SH8dFKczb/nEd64oN6xE2FpptHq0wnHCZ8CgRyr9Lm5DmQIHUe23GtBJTxGlf2uiojDpYGQIz6cUQg49tEg72iH0ggOYTpikXdVH6jWLRNsNxAiagTsy8lDbI57SSZvKNo9/+Wch2tENuTRJqZyiUVdhS3xNsodA646YKMZHqTIfZv8lcKONuCQD0U4uAb7W6cHb9zk+3BckY+lK9EilvbqxXGStm+cfIjfAcJs31NhEWvZgnW/h1lNds1ujljRCTnAlCcBlxYk8yUGsS0IwOHr4yR399rqg==
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16)
 by AS4PR10MB5845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:510::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Tue, 20 May
 2025 07:10:22 +0000
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3]) by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:10:21 +0000
Message-ID: <163d3a32-170e-4b40-aea5-7bb673160135@siemens.com>
Date: Tue, 20 May 2025 09:10:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Please recommend the appropriate Kernel and Xenomai version for
 my hardware.
To: =?UTF-8?B?7J6E7KSA7IiYKEp1bmVzb28gSW0pIOyImOyEnSDrkZDsgrDroZzrs7Tti7E=?=
 =?UTF-8?B?7Iqk?= <junesoo.im@doosan.com>,
 "xenomai@xenomai.org" <xenomai@xenomai.org>
References: <SL2P216MB227453A028F3203C05B5A8B3E091A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
 <14e0c75f-9f4f-4035-8bed-5f798bc164f4@siemens.com>
 <SL2P216MB2274E85F2E9ABB2A869F54B7E093A@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
 <149e9ecb-4b46-499a-9205-ca7641e4bf7b@siemens.com>
 <SL2P216MB22743BCEFFE944092372BE8BE09FA@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <SL2P216MB22743BCEFFE944092372BE8BE09FA@SL2P216MB2274.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6190:EE_|AS4PR10MB5845:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0171a7-c05d-446f-6573-08dd976d6214
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUQ3aG9NaEV6a2ptSkg2VnZyL2RxR01Zb3JnRytLZzcyMldLQWNQRXZqNk42?=
 =?utf-8?B?ZjBQNHF3dHZUci9Fb2FRdERoN1lJVHVobEk2ZWl4UzhEaUxHLzhSSitkVjJ2?=
 =?utf-8?B?MkdZM2VQaUlpSFl2alg5d3BqRTJ6WTM3eU9xN1g3SllZZXdjVW1lMnZpeVJ2?=
 =?utf-8?B?ekJlSnZCeXFSc0s1RStGWGE5VG9YTlp1aFZxMWtIV3h3K2kvRTZIUEtSdDVK?=
 =?utf-8?B?dEwrR1VhMG5xZmZ0RkVxSkwwWFdUUnJQdmZYa0ZxTWNSUE5PeHdUMFdFWmk4?=
 =?utf-8?B?MlJkc2IreWFwdDFkMGp0UU05bzZhazZPTThtMFg5ZXdzaSs1Qkt6ZlJhdnVF?=
 =?utf-8?B?aExnMy85WFBRckx1VUNWREUvWFBmaFdyU2p4bVBOd0F1LzY3WnVJQUwxb2Nz?=
 =?utf-8?B?emloeEhSWjdtVERtaGRNR2lLQ1A5bEpJUWNjeFM2MmY4ZWJ5Z0FqMkNFU2ZM?=
 =?utf-8?B?YWZSSEpJajZZRWc0Ui95L3NxTlJUcFYva21OR0svcUkxMlZKOWNmVTV6ZnBC?=
 =?utf-8?B?eWc5Ylc1MVlwVXBtdFdvWmhXQm5Cb2dONk9ITkEvL3FRcHFZTGJZanlVS25O?=
 =?utf-8?B?UkZmOG9UWVdvWkNQc3hJcC9pLzRlMGkrZDlJbnh3Z0htL2h4SWxOR2JVSGww?=
 =?utf-8?B?NmNsbG96S2V2Z1Y5ZjRXekk5L0RVZmdSYUhJUGJ5dndadlRVRlFWZzk3QWxm?=
 =?utf-8?B?aHJMRG9MRTBzMDAzUmZoMnZHV3U3eTBOY1FpcThBWTdBeUJxQ1VxL0YrS0VT?=
 =?utf-8?B?WFV2UE55cXR3MlV5YmRjYk10cVd5UW82aXhnSVNkaERCTW1VZ2kvblQwOXpE?=
 =?utf-8?B?akp4TlJ6M25KM1ZIK01TWW1HU0tkQjV1WGhFdFNhSUZZT0tYcUJXNm5xd3d5?=
 =?utf-8?B?OThNeEI5ZzA4MC9rL2hqRjFyQUZUNDBkRUJJVi9YczNVbEdrRkk4bzM4ZHRz?=
 =?utf-8?B?WVFQZWdZYW9rWXhxSTN2TkRvdWZCUWVQb0U1Zy9TQnF2aURWUnFaZHhQQTVS?=
 =?utf-8?B?UzZia0pyckhHanV2aHhmZ3lzYWdUeHhYTjFuZWRXQ2E3UzNXNEt3TForN3pH?=
 =?utf-8?B?K0NqM3Y2T1ZteGNDY2lnV0dGc2xPU3c4Ym04eFR6QzFvUFByYm0xZjFZNy9q?=
 =?utf-8?B?ckpqcWZ0d29PSExzN3ZNUmpoRWZPcHN5ZTZmNFdXRDFDU1pIakdjay9CMmgz?=
 =?utf-8?B?eWJObks4a1FMOXhVVnljbGlUaTg1T01XeS9tYzhhMEVmcmdZZUxlL1g1djVr?=
 =?utf-8?B?SE5FazlSUVFWMWo1bmZoeHhHcGJRQks4Q0M2eGt4TC8vZm1NdmpJeHQreThU?=
 =?utf-8?B?c1dYRHdyYTFCNWVCV0JJcm9aQUVzeitmelJUR1BNREJCSm91R1hkQW8xUFhl?=
 =?utf-8?B?WE9WenVoUjVucUNHRmN1UXQrRytLekJnTHAxc2pxRTJTdlVJZGVRV2pmZDV1?=
 =?utf-8?B?RWdHbFpRZ1RaUFplemtpNFJ3ZlFDSUpyWThhNHdKWmtkcjhZdUYwWDM0TFZn?=
 =?utf-8?B?S1dHclQ0RklTME5WeDBGOTQ1SmdwaG5LNldlWmlEVVp2M1poUGZXbEF1S2FT?=
 =?utf-8?B?YkFQUUdEQ3BqRUdjTzY2KzNtTWhHZjdTSGhpeEZnSEFESEZ6WVgra1Voc3Nq?=
 =?utf-8?B?NGdNU0FWZWhLS3hPVFhGK0tCbEhsYnBic1dmeitCWXRGaC8zVThaWEhRcVBX?=
 =?utf-8?B?V0tmalkvdjN6QXo5NHMzN0NyeUdPNWJQZm5kV2dKeGVETi9paWZwWEZ3T1ZF?=
 =?utf-8?B?OC8wbkRtQmFla09CN2Y3MHA0Q2N3cWNwVDFkU245UXE4bFRvbTQ3bXNQK2FH?=
 =?utf-8?Q?iaJZGkLpou1WAwem+5vCdRZomL6ksWkWArPkA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vzl2NkMvYTRIbW1pb0pvamdONkZ4WFRkNDZzdmQ3Sm56YjBjT1hGWDNVNmNZ?=
 =?utf-8?B?QTRTUGJROHl1Vzl6Qmd3U0htaDBkSDFUNy9OQ1JXZ3QxazlzQXdsUzN0L1pr?=
 =?utf-8?B?M29wUEtXdzhKMXdhOEJHenNyMkNUSFhFSFVyQVJiY2sxT1EzdVBVYzlNZ1Vm?=
 =?utf-8?B?S25kQ3l3MWhhZTdmMG9EdFd0MWlsM0hIc2RmMEJNMGp3OW9GbTRXZjNXbW5I?=
 =?utf-8?B?T3o0dkRBMFkrWUt4citZeHYxL1k0dE5maW04YUVmN1U2NlBmdEhNU09nQlRn?=
 =?utf-8?B?SnY0U2trcCtHMGRLL05WUUwrd2VzaElEOHpzOXNkZG02bWJPQVdQaVl6OXpr?=
 =?utf-8?B?WXhxZHdLOS9qaFlqRnF1cEZnQ2FYTDhwcmF5NHB6Wnp4bFR5UXhSQ0NuSHFH?=
 =?utf-8?B?Zkw1dlBVSng1V2pLQ2pYdFdtT0RYc2pmQnhNSjgxTU5aSXlwSlpmbnV3dDQr?=
 =?utf-8?B?MDVBTCtNYU00UWRqWnZ3a04zYzZiMS93RHRSQXgvODFuODE5VG5lTXdRcUM4?=
 =?utf-8?B?MmVKNTQ4c3Ryb2VKbDNYdzRDeDVWbXJBRjhUcFA3T0MxM2VrbWgzODR0Y1FG?=
 =?utf-8?B?RExxTU5LTnBnamZCNTR5elBHN2RxOVhFVUdXcXFkVE1VWEd6dlpQQzlDYStj?=
 =?utf-8?B?Y1RoWVQ3RW1qMms5MkluNnhhZkNXU2ZKdmo3S1ZHZVU4VC82dDF6T09GREVU?=
 =?utf-8?B?eXZKRWp1SVVLa2ZwOXhXMzVXM1RuOXBDUzRIZjhicEM1N2ZmWlFzMytjaDRn?=
 =?utf-8?B?VmtzSUpab21aVVdibXhPTUVIQ1U1VTBINU9McGt5Y1RVNlVFbDFhcm1XQXZu?=
 =?utf-8?B?bk5iU3NVMWxlc2xtK1l4eFlOTkVQNzNWa21ySkxlRUxkT2dYcng1QnBoZnZT?=
 =?utf-8?B?dkduRVQydTRwald3UU9KbzdrNnVyY2IwTGRGd2RIU09HUjdSNWpZenJEZEtH?=
 =?utf-8?B?d2YzeGcxWXVORzlqMHZ3MHJSYmFITk55VTU4a2MwYUFOWUk3QVZpRVV1Uzdm?=
 =?utf-8?B?b05zcWllUjZySVBVRjg2c3FlZG5vMlhSc3E4VTRYelp1SU1naWt0SXNyUE4w?=
 =?utf-8?B?QWIxRnRDcHI1Uko4SXUvSjdiZnlEdVdyTFgrRThJL040c2JmbHdjNE9FbG5m?=
 =?utf-8?B?VTA0UmJ5elBGOTZlTVZjYUEvR0ZJTFkyUEpVZ0pSaEQ5Ukhmb3czZjlnVjVE?=
 =?utf-8?B?Wnc3REE4VUtQOWNVSFppZldaWTJsWHk2N0hWMU1wUGx5SjJWZ2ppY2o4NnRp?=
 =?utf-8?B?MWtqTTdXWUREeGJGZUxialdzVXBwWUFiWlpCdlRLdW5DclQwZ3dDQlhNRmxz?=
 =?utf-8?B?UFBaM1NCcFd2V1lyc3Fxb1VIUFlyNStzTVVHdnJVbW1DWVU3bDR1MEdLa3pR?=
 =?utf-8?B?eDVydHpCNXpTdUVuWU5Rb09nU0s2a2VEVXc1ZjNnQThoenZ0aU9yMEh5MzZv?=
 =?utf-8?B?OEpDcXpadTNtTmNOM1MxQmFMOW1XclpQRUErRDJsT3dLajE4V1lwenFIQjQ1?=
 =?utf-8?B?UjlYRDRaMmswR3NBdzZ0Wnkxckdvb3F4K3RVK21uSmhHOVM5a0pPZ2VNQ1dZ?=
 =?utf-8?B?WGh5alVRbE9SQ3N3bzVSZkpXQzRSS0RncWQwYkp0VHNhcVJPOUpCcDduUUNa?=
 =?utf-8?B?dStTWnNjMmVkTGZZVmU2dFRNT0ZZN1hKemF2SU5DbGYwZDNzdXFtTjk2bm9O?=
 =?utf-8?B?T09nUG9pYlF6SEdPM1BxbEF6WHBvUHQvTkg4R0lGZFZwQllkcml3WVAxYzZJ?=
 =?utf-8?B?bk9IdjNRYmtQdE1LZ0locGRDTjBJT3lFb2N0TS9NUzNQck1HTjJKcnVtd0p5?=
 =?utf-8?B?ZWFWaE9tSDBCR3Q1WWE5Z1dUb2JEVEV4bnA0c1JiL040UVBDL1o4SVVnaC9u?=
 =?utf-8?B?TjVSTFdJbWwzS3pEblVucWs3a0ppcXJ5VS8vbkQ2N01qWUxvaC9hM29wemdi?=
 =?utf-8?B?NUl4TnN1WTg5YWZLMXAybDNKbEFMdEtJWkV5VmNjVlUyU1JiNWxHTXpPemU5?=
 =?utf-8?B?enBiYktMa29IMnVHTjhXRjFsRmlUU2pJZzdabHJGZUw3UXZSWVR0djU1bjJC?=
 =?utf-8?B?azBsUnpmT04xN0FrelZaZnV0UTdhN2hBSXlUbEtxbFJkRTdJNTc5dUdpMWNX?=
 =?utf-8?B?OHVCbDBnN1Bka0VmSTJ6OVBJWTlYVmNMS3hIbjBCbFdZK1Y3emF1blpTazV1?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0171a7-c05d-446f-6573-08dd976d6214
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 07:10:21.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNKmMCvpRgRNPKzhGxDtLHAZM1fz38E6/b/taNWy9OiPdGFVqxFLoBRD8z2Wmo8up88UdTkw1fHXilzBILSmzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5845
X-GND-Status: LEGIT
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=vgB4l2XA;
	spf=none (spool.mail.gandi.net: domain of jan.kiszka@siemens.com has no SPF policy when checking 2a01:111:f403:2612::623) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdefieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffgfuffvfhfhjggtgfggsehtkeertddtvdejnecuhfhrohhmpeflrghnucfmihhsiihkrgcuoehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomheqnecuggftrfgrthhtvghrnhepueehueevtefhheeghfeguedvvdfhhfetvdelhfejkeekheevfeekueekgeejkeetnecuffhomhgrihhnpeguvghngidruggvnecukfhppedvudejrdejtddrudejkedrvddugedpvdeitdefmedutdgrieemuddtmeefkeeimeemudeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedrjedtrddujeekrddvudegpdhhvghlohepshhpohholhdrmhgrihhlrdhgrghnughirdhnvghtpdhmrghilhhfrhhomhepjhgrnhdrkhhishiikhgrsehsihgvmhgvnhhsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvh

On 20.05.25 03:10, 임준수(Junesoo Im) 수석 두산로보틱스 wrote:
> Hello, Mr.Kiszka.
> 
> 
> I am setting up the latest kernel (6.1.128-cip37-dovetail1) corresponding to your recommendation for Xenomai 3, along with Xenomai 3.2.3. Currently, I am configuring the kernel menuconfig.
> 

Ok, the kernel is - at least in the 6.1 series - latest now, but there
is 3.2.7 as latest version of that stable line.

> I understand that I have to configure the "RTnet" to use TCP or UDP in real-time.
> 
> However, when I move to the following path (see. below [Menuconfig path]), I can't see options for TCP or UDP (I can't see anything at all).
> 
> Am I misunderstanding something? Or is there an issue? Can you help me?
> 
> [Menuconfig path]
> Xenomai/Cobalt ---->
> ....Drivers ---->
> ........RTnet ----

You likely turned off CONFIG_MODULES which is a precondition for RTnet.
I don't recall anymore what was breaking when you built RTnet into the
kernel, and the related commit [1] also does not tell this.

Jan

[1]
https://source.denx.de/Xenomai/xenomai/-/commit/c95cb13c5d3eef2b5daafb0f4cd4c86a79a67d0c

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
