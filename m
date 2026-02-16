Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041030DED5
	for <xenomai@lists.linux.dev>; Mon, 16 Feb 2026 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244781; cv=fail; b=AhRzFLnsB9J96srXzVbb/upvyFq8ytGXos24488ewku70UD3zjyD+SifBxHiN/bDpzqb8qw6dCnlEWdKch3ykaTlCo/klVIfdBb+s3SI/6VI+5BrzcU7hGKEhsWp9jm9FjiMwG+MnZ4v3tyfrWS4rdr5Ejc3O8oJ/REz7bfx4qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244781; c=relaxed/simple;
	bh=fmemuvbAQsLHYVkELbWc0bzEW+ao1CClen4hNnfw4Mg=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=h0yoevUl2fKqKe7AyGWYgrEUf+dSieYgFJDwhPenGkmJSR1IBxkZ0BY+X7+maZWoWkuFxnPl1Jv6qSa9fK3zkP4B6tnfMGLU2VTyKLVcy+JLM+GVqOQuadFb52rs0en6jKbMtUTzWRnkBqj8VVZP+u936J5tgox2mXKnMa/lcWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sG7E5nub; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sG7E5nub"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6O8YQrX/dXUUaoSvV6cr0AtzngBJispKaY7e8dorJnMNCMXgQWBI6wq70eKS2xQoWDDtkOq2er7tGu9WsFutX8LUQq7YWgdfMfQKh9+YcLwiczbixy+Yggdgf9oXkjpvSAJjJh113uLvnSWous/r+HqyFT6FhryLY6jV+xs+iG+WzhXShL2q74d/bccOn81HPUt3hW4xYO6saycMBA8TpD/ip0/u06mY1rtGD7rtxtF8gfyFxjRFEh9RNI5o9o3E1pYwrwx5tecRKZnea3U9WdJDf/TTwau0Ub0qMaNKkwBac6m/zFypXL78g0DYdI8WRr8Mmwtrb6hNmwotSs2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fyrCuFTyDBamNHMvF3lpIrDZ/ySWbQyYL3APxIfgrc=;
 b=jb/m3AAXmFjj41dgIVGJtjXTYpo2NMXZHHS8FIbndtx46EjaubU2Ce6DfyWDmX4OEGX8I1S27eJl4tFhvzBk2IkrJO6IjI5S6v9fxJP/AxKK2o5DY89OYg7IViXiawRWibrspkOVklJTSYyH0NDipBEbY1Kgbb3mky2XnvwYDLfGDi/dB92Zcd7jM4vyiIa2Kfhh4O8WnrzyBkOw0KnXgdpfGM6bpdCIp1+7ZxMApQ4h76zmSRtmBdZ5jEa19hPH3H3yUp5wVbp3MZ6Apwa5EX5QDnRnVcOQU6/u9ACSbTOTgzx1SQ7ZpcswrHLifdCf0bw80rgdRwgUrj0EA+n6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fyrCuFTyDBamNHMvF3lpIrDZ/ySWbQyYL3APxIfgrc=;
 b=sG7E5nubmO5r6rKs+NP74NM01F4Pk13LGGxJ4WtauGhhNFj3j0pWyO/sOj1n/LZXR/riXT9EynYYxr5wImQCQXhprnKTCIGFTF2Q8eW3y+0dhooYa5GTqXuvZD3Q99TYRZw1tFFWlbT0wJFxvj+vBl5YJoT6x1FqYRc7srurEMiBSr0DQEiVk2VA3K5tTn0EBB4v9nVnuE/EYcWC4BOyWcozpXUIL9Ro7wVpt5wCZBzL1LVMtUDPaOPt4n0hCJgT4LvxoGolLv/f0dIz85A8X5RTIKzJECjnoNTOF99bsCrPiEKueFOHMq9ZmZ6rYllLRDU133VjLP5VYILQHgC0aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB7191.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 12:26:12 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 12:26:12 +0000
Message-ID: <ce7ec09c-1db8-4ee0-921b-34fde4c0f59c@siemens.com>
Date: Mon, 16 Feb 2026 13:26:12 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Subject: irq_pipeline: likely/unlikely macro usage
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 26637de7-7423-454d-0cf4-08de6d5692a0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qnh0Vjd5bm5DZWJucFZmY2YvRDlwak4wRHdseFpkczhYUDhYZW9mVXN0cjVU?=
 =?utf-8?B?MytWWkxDeWdrTTNFVU1keUJ6NWlJQTd5dzl3dkNUL004LzNGN1R3MXU4TExv?=
 =?utf-8?B?ZWVJOVlRS256N0hYZzU2c2xFKzNyS0pwSkRzblZCdEVzd3B0cmpsRUhzcy8y?=
 =?utf-8?B?a3VWRGJValBNeFdrV2gvemNGcWNQdnk3U1E0ZU51bVJZNnU0L2FRNWhvczIx?=
 =?utf-8?B?M2VqNS92NytEYnI4WTA0NitKWU8vdjN5T2hSRHgzZGFiWUQ1aTBZTC95Z1p3?=
 =?utf-8?B?eWpkNElxREpWd3h5cExpMVloRTgrTXdKcm1oU1AzbGNBbS9WNCtWcStxdmVv?=
 =?utf-8?B?RU83akdVT1dBWkt4TVZXTENBVVUzaGRiZVh5UkVWSVdvQnFTemhtbHFkTFN5?=
 =?utf-8?B?bk05b2QzQUs5ZVp3ZWlYSGI2VndENVFmMGRoVGlKd3o3UGFhU2JMWVZheWVY?=
 =?utf-8?B?aUlLSWdxZEYvNUNDOTJmMXhnR3VVMGQ0RjJETis2TE1ETHJsL0lOYnIyeDdQ?=
 =?utf-8?B?ZzBkYmhkSVBtYjhYU1ZTNjE3dzQyVXk5bStHWDI2TXdlcFRxZU1YZ25qSS9v?=
 =?utf-8?B?dU9lTzc3c2JEUDNvM3MrRTBpeFE5cWZ0d0tCM094bHJvVm90WVJyWEJEa0Qy?=
 =?utf-8?B?ZHpnZ2x1VWlhUVprYjc1QzVNelhVQXdRZy9xdGVlUi95ZEVKb1lNemJMMk1k?=
 =?utf-8?B?dndjdVRTb3RLVXBiM1p1bzdweDVRdDVWMVlkM251cW1EdlJLVEpBTWxNV1dP?=
 =?utf-8?B?bmU1blp3ZkE5c05SSVlSK25vLzJPTnNxZThaVnU1MjVGNnNDMlZsWHZTV2lu?=
 =?utf-8?B?aEdwaXpSaUZVOENSNFZXaHM1YlJ4S3hLam03NU1MU2lMWXU5eklJTXlyS3hH?=
 =?utf-8?B?ZW9ENUxYWnRRQy9vQ1oralcrRFFDSjdpK2JrMEYwS09IZHJOakVUOVc0UmFY?=
 =?utf-8?B?MWJ0TDMvMEhCeE9pdjZocUZQYVgxVXpPQU9oTUxTN3pva2JoaVBST3JCdDRh?=
 =?utf-8?B?QlhFOHVkckRpMTJhWDZMOEN5ZDhhREFGSlFyOEpWMzc0dDkzZGVGTUVZeWtO?=
 =?utf-8?B?YnFHbFhyZnlxY3M4d1psa2kwTzFoelFvWi8rY2ZGekpSOFg0b1RsSlF6QjEv?=
 =?utf-8?B?NEFBeHIyYUFkbEYrYjVmN2hNa2tGNDd4SStNQlNEYnZmR2xpMGNYRFV4bjg4?=
 =?utf-8?B?YVpDc0V4UEl2Z3hQSTdxYlRrcDY1RVJraFF6UnM0L3M1K3V2dUxrNHIvaFJ6?=
 =?utf-8?B?bHpMQWZIeGNkYndjVkIyWmxtaXk0c3lCWEZQbFZUb1ZWZnJpS1Bua1hBRW8z?=
 =?utf-8?B?akdJbFI0NFM0YmdkOExJRG5zVExDbUd2dDhRU09BK1RnbjljMUlGcncyb2Vi?=
 =?utf-8?B?TGlTRTlWeElqWndGVjc4cEh6cENnWnA1UWZza0hFWU1MS2g5TFlHUHh1R3Jy?=
 =?utf-8?B?VllGWFJrL2h0OHlRdEpkeW84TzZiTzlEOU9UdldoZmdKRE4vSGh5TW1uc1NC?=
 =?utf-8?B?NGdkd0RLSnh3czZRSjBpTWNWT0w1dnZaK3RvbXdBQS9XSHp1MTNhRjViNWJM?=
 =?utf-8?B?a010Wk9xM3BpOVg1QmY5MDRWaW5qRm4rNWNjUjB0Sm1xaGt3dXY4cC9NYWdz?=
 =?utf-8?B?NWkxZVJWMmx1SDFYdFVVZTV0andRQ0VjUStRdktSMmpOZ1NkSWFtV2RIZW9V?=
 =?utf-8?B?ZFp0M1prSDcwY3N3Qi9pdTduZE52bVY1UHBCa29sZEw0QVlYdUt6R2pTcGFX?=
 =?utf-8?B?Z2ZFNkFLckhwcHQwV2JweFJ4YkFTUzNEdEZ3YmVrM0ZHbThWOGk5R3B6SUl5?=
 =?utf-8?B?L21uaU1Gdi85NEkwK1R1NksrcGpWdzdsbkRyY0FUNkZMSkx3cjV1THdiNGcw?=
 =?utf-8?B?a2hNWVYvMHlIcTRTeFR6UGRJUVlaZ2hUQ3REaVlLcFpBNkpiWm5NNEJOVnVX?=
 =?utf-8?B?NG9PbXZUeWNvVXArYWlBWTZtL2E3bGJvZnZsMFFadHdGT0F5VmZpUjRVY2Rh?=
 =?utf-8?B?WVlpVDhqUXQ0Mzkvc2p4SGRoMUxjUWt2UmN4ODBLZWxsT1U4ZmFham9Pb1JX?=
 =?utf-8?B?bUpESWp6QTdJODZtbDgvaEhZV2pKSHZ3WXU5U3dJZkg1ZkZ2VjFaTGNid1Js?=
 =?utf-8?Q?3go4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1pzQkh3UmY1RVNEd29LSnFVN0FXblJyWkE3U3FzN2s2dGM4T1VMakQvaEJV?=
 =?utf-8?B?czJqVXJyK2hJQzdNSWVpcGxsQmJ5cG9JeFNibWljdXFHdUZXWUlEMFhFbXZE?=
 =?utf-8?B?U1hMNGZKb3hpYmlReUlvSnVIWlN3T0tYWDVzaFZqS0xZVHZQZUJLNzJwM2Ns?=
 =?utf-8?B?cnVQNXk0RUlBUDZmQzRsY1VyUVpyUUxGKzhKc2QwT3JvTjhoeXJJM0VOUnBu?=
 =?utf-8?B?ME1RQ2I3dFBrMWFteXc2djd6OTZBaUNQOFQrSGY1dTZrSVhTVEhVUWxFbFBN?=
 =?utf-8?B?K0kxbTBiNTRtNjd1MlRUeUdha29qa29OeStJSExVM2pXS3c5elRLMFFpTHho?=
 =?utf-8?B?ZENScW5LWHJQdmFZMXNCNVREUUF1UWxadzlqdUoxMDI3WWZDR0luN0xGOFFp?=
 =?utf-8?B?RzZiK1ZoZU80RDFsSjZKVlZndGQ5L3paQkVlUnpSbCtGOU5mZ0dBSCtISjI3?=
 =?utf-8?B?WXZLeTUzbXRSMzVTei96OFZrV3hhbEtQTXEwZ1FiM1pOaHpQWkZvMU4wTWg1?=
 =?utf-8?B?Q0x4L1diam54MjdyaDV0bStMWUFoWGVHSFVXN3laejRML0E5Y0NvcGFwUms2?=
 =?utf-8?B?RW1xUDNWR2ZTRm03V2xuWWpYempRWDRvazIrd3hEQWlJMEQzMnlLdSttYjg2?=
 =?utf-8?B?ZTN6czJjYVlCRGFhYXpqLzZXaFZzbWxHRUNjMlY5MzgxeklXbzhtTVNkdFlE?=
 =?utf-8?B?akpIcmhKOTJ5L0s0a0t0SDJFenB3d3BZVE50akRkdm5PRytvcC9iZm4zRGMx?=
 =?utf-8?B?QnZmeHRZN1lrNjI0a2MwNTV0bTJKR2diRmNqWkppYW9XV0h3cldFSXl1QXVH?=
 =?utf-8?B?eWZBMDRwajA2anZIQSszekd0eWdWeHdCYktoNlhnMjVwZGYzY0dDampnQzQy?=
 =?utf-8?B?RVUzVnF3VHdqc2VPMnBvOTczb0RWYmlkZFlLYUY0R1JlcmNJZFFNMjhvZnRI?=
 =?utf-8?B?S0swQXJ1NkV4elYyRG5PVE1Da2t3R2R3UUUyVnJPaUg1bGlLNnczNGF3MVIv?=
 =?utf-8?B?Z25ud2ZhQmFQL1Q1eTJTMkFpcms0dkxqK2thQ0UrWWhnaG01Ky8yc2ZEbXNs?=
 =?utf-8?B?U0kwYVJkNloyZ0hjbldUcjJpdkZoUHRJMUZib09aQytkTGdBanpnM3R1b3hK?=
 =?utf-8?B?VURYTXdsdk5sdGZMMDUyOEs2bTFieVkwbHFnVTljQjFHeDJnZC9DRDNtd2N6?=
 =?utf-8?B?RGloYzJTTkJpWHRPalB4U0F4NVFXem5KUkluR3R4WnJSQkdLWUtkcGdrN0tD?=
 =?utf-8?B?UVNJd0lhbEtBeEdLaGh1M2YxbTNDL0RYRUc0TExqOGFSMGwvYXdVU2lrbWk3?=
 =?utf-8?B?MEpZUjdRYjAzVjRPMTUyQXh0eW0rb2lxK24yaWdVLzdjWnF2Rks0R2ZqVUFP?=
 =?utf-8?B?elBnd3ZUeGc1SkUva0hFTFZSL1JrOWhCTC9TcGhJcEgzenIzL09MWlQ5Tk0r?=
 =?utf-8?B?SXRsOC9PcldWVGZ6OGhMTWhidkRObHVVdmgyMmNodGlUb2NYOVBoKzkrbndi?=
 =?utf-8?B?L2ZZK2R3dnFpbUt1QldlZ1Z2bHRQNVdvQTBXRUpqMkVzWDlsRXlHVXV5Z0J1?=
 =?utf-8?B?S1MyZmxEYzg1aXFWUWhhU0Z6b0hLeVV2N0pzZEZEY0RJUVR6b1R2TFd2TXp1?=
 =?utf-8?B?Q3NjYXJLQytiUC9PY0s2SWRBTHdTeEdmS3hKNmg2ZzFGYlZuTEt4UWNnQlNK?=
 =?utf-8?B?UldoTHFCSlVubzhhUzFJWVgyZkhhcnB0UUpILy92alVwc3VkZlZPeUFRcmtO?=
 =?utf-8?B?a2E4R2o2b29JMVFHc3ErQmd0WWlwZ0JWcUVIc3BjN2JHTUJDKzV3SSt3NERE?=
 =?utf-8?B?RUZhQ01CMjl5TmpBTE9IUm4yMzRQa01PRklnMktwQXBsNHBaWDFYVHkrMW9z?=
 =?utf-8?B?UXJyU0x2Vi9DQno3eHhBOW9RdGlnWFg4M0VQbmdud0xLTjJLZENpMFQ5Ky9L?=
 =?utf-8?B?Z2V2SVZGL1gxTkYrZjliYlNDNDhVWFJ1T0t6NVdrcmNmNXBYMzk2bTFuejVU?=
 =?utf-8?B?YUJuMU9PRnVmcTQ3WTZjWFdqWHpJYVExTGxJVkF0NjVBb3ZLS3o0VzY0WFNN?=
 =?utf-8?B?L0lpUnpKRFZPbm9MWW01aEJJTXR3V2lXTlBsNjRWT2dyY21YRVBPWnRQQkE4?=
 =?utf-8?B?M2RpNVN6Tm9XY0xkQ2hvUVdQc3dZS2xuV3QrSlBXRzhzSUJqTjNndmZjSEtq?=
 =?utf-8?B?dGQyTlM3aldyWDZnUE5TdVExQmE2Znd2bTR6MTJSVDBOendhZlBhcWF2QzF0?=
 =?utf-8?B?Uy9McDB2dmhyQkFiVXYzOXorL0Zhb0pUNjVubm40Y0FnTUFkcXByTFZlZ1J1?=
 =?utf-8?B?QnczWXFRcjhxVCs1QW9tNEE5MUtXM0lGMklrN01YY1dyZGw2ZzI2Zk9kZ24r?=
 =?utf-8?Q?2XESZcNttY6YzZt4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26637de7-7423-454d-0cf4-08de6d5692a0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 12:26:12.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHA/IC9oo5xpPGnxG1ahUbiWVw8U9AfuO/PKfAFPkMtkK0kF8Z1BfPN7FG1g3S5xZFo1FdDHHoPN8cAiDs4u5oiFPvtY/q7ys2Npw6OVrj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7191

Hi all,

while staring at the irq_pipelining implementation, I noticed that there
are some locations that use the unlikely macro for the OOB fast path,
e.g., [1].

Could someone explain why we are optimizing for the in-band path here?
Although the in-band path is indeed more likely, I would have expected
that we would want to optimize for the OOB path anyway, since this is
where the saved cycles really matter.

Best,
Tobias

[1] 
https://gitlab.com/Xenomai/linux-dovetail/-/blob/v5.10.y-dovetail/arch/x86/kernel/irq_pipeline.c?ref_type=heads#L260
