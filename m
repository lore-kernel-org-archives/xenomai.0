Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A921BF33C
	for <xenomai@lists.linux.dev>; Fri, 28 Jun 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584782; cv=fail; b=rMiAf2HVUrRx7x8eCMQB6IunjJczSdQKVHGZQT1jcQMRbSyYyVsuqQzcUx28Ac3Ec7WDmLpNu1fOcC2uCZtk3v4ZoRLeyBdDfxU2Fg42AF/8QBmm2675FB+FofIjtscyECQMx9j8b+rMqIZW4LePIY6E6GxXEiQ6rF2VSN+9HlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584782; c=relaxed/simple;
	bh=6zLA+QsfTU4oWDbDcQr4xbgTNhbGsNbxOcp7v8fbxFw=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=N3ssnCwB/6Y5O/w7KdxUveKH7b/xGDBmeFExPEii4OfGkiwEnpdyqfJ3wDvE7w4i8SnVlcQsH2hiFnKkHWKf2HbdvwvU5jx5L00AYC8ikHGmbpX2HL6RoDDYTXZHpXJ0UrZ0LKZvKd56DtVk5AaEpbAhihleZtE3aL3/K8h5ecw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Gh21cYeS; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Gh21cYeS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe62h38mYLtLpKSamWK3E5R6WWnNMzgQTxshDgcoGGdVg+547kLFHaIUJvGvjQm8Nx6DWQxP2x6dNaGzVJcm97XVH5kkoc4pmXSDDaYoFDQzKOYiXPbRS1fzgOauTYVBgoraUppWdazqq+swas68d/JvPOPpRoNSBDUce3IcOtC7xcrknJTnAAYUVGVmv8WfPEy2o/KomqCjsltdZvIB29Kq698g7pP1dLav3XgZrh8CJmCermNIvSSOFe26H66sMxizzpV+i2EKroOOSPiJV7AgogTGX4A2l+8R3nsPVyWaU6d412+wG+rbhCT4vQhSyCSbKIN/ODlNTKUozuMS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIyDdAsf2JLTVfpb8UIIuyZZeNvjhgrBZqrGB8w2paI=;
 b=Oy1VdOhzw0gmS3LfPwUuMRjaGcHbjIr1eOMz03p6IbW+HcnLlBrlVGIo9yz4qKS6IgMY1y1cWfAqWRpkkNnCkwYgkzepA5r/p3hkhrIu91qeub4o8cac29/Q2tfGuQMdtyzfIpdz4Z/Jh9Nl6w1UcbR+EgQsEw6SzIArbPdTxvIW6seHacghLDqieHaL1GIlZr6GazbE1/+R4SjWer7QuPWufgzXpWqRFRCwiiyv6Q6dugRC47YQiACVpyxy14u+DhHsNGdjNMrUC/5bV96LR7L/iNzmQJ1a5jDC8TIKwz7wvG0KZVoXPlRUK74PVhf6fOIjar5wX8135gUdDhjuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIyDdAsf2JLTVfpb8UIIuyZZeNvjhgrBZqrGB8w2paI=;
 b=Gh21cYeSguvHIPM95vmepsC12mvQhDM+FmbB0YZUvJgc/cJExrC0yfcq/ySmMuVysKlTEFRf6xpLAYCIPUR4gDfKLqD87ucxjFY0Snrnk0m0Xmp4ShKfo79eho+0KEOARbqFaZ/K4854ptxkO/OG4fR9yGXSEi41YdwNI6TuVKZIWuAqf9fAtAmZfyN7CIWjGBSZr4AT++PnXV8doj/pH79H7idAZD+MIQEAZYQUj7uij6xs1XKDp2gO0bx6Q3kpDx4QZmYCb9+ZsQp0p20TRHzfeRI8txm+9BmuwBULduo3pF65CXaI1IUtjELRPMDhxeIYXTnn2ZKgGPvCgmUfyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:233::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 14:26:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 14:26:15 +0000
Message-ID: <b8bb88f6-d412-4986-8a4a-c08d09e8b84c@siemens.com>
Date: Fri, 28 Jun 2024 16:26:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ci: add kernel support for rpi4
To: "Jiang, Yi (T CED OES-DE)" <yi.jiang@siemens.com>
References: <20240628122117.19059-1-yi.jiang@siemens.com>
 <20240628122117.19059-4-yi.jiang@siemens.com>
 <3565bbae-66df-40d5-b3e6-f70fa692378b@siemens.com>
 <ee8023806d83f942c37369187e34692d83f39ddd.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ee8023806d83f942c37369187e34692d83f39ddd.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 57709e07-5114-4a2d-7b7d-08dc977e44e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnVhVWlPMnlpQUtXT3hWMkZuNWNZa3ZZTkZqOW14V3lsRGhXWVZmTFdZeXdD?=
 =?utf-8?B?Q0l6Qk9CbFVJRnA2RmQxaVBneGZlem5wcEw2aXFWeTJzYUhXNEZOT2o4T0Iz?=
 =?utf-8?B?dXpTbDhHRFRnekZQdjhYN2J0SnVucmRKKzUwU2paWTRUblQ3NisxckN5aFZJ?=
 =?utf-8?B?WUJwNkhUS2VxZlRkSTl5TjFBSlRLOS9LMHJyZCtEM3NMbjRnUFVRazRveFYx?=
 =?utf-8?B?TWxYVTc2WGIwbzBqUXBBYndzd1JUeE5Wcjltd05nR2JFditINW5LdW5yME1v?=
 =?utf-8?B?ckxnQU9NdHFVN3JOd3NseWowd3RyMTBxd1dvWCs4eVc3eFkrbEFkMDdydUFi?=
 =?utf-8?B?VnNvUTZ5MjROMnl0dEZaOXFWek82UzBYZjNLZGhYVG1ldjVnclVRa1F6VnRr?=
 =?utf-8?B?T2lEMzhGcHZaSXZENGRVYlU3VHpZQXhTZG56aWxUdzZXRWJKL2JiU0VDR3h1?=
 =?utf-8?B?WXVKU0o2S0t5UFlqS29xT0c3bU9WMHVPM01JTE9rNGp4aVAxUlh1YklmZ3hY?=
 =?utf-8?B?WlJicFpLMmtXSllnVzZIRDNwYVVRTWswc3lPME9qKzI3SGxhblgrY1NPK28v?=
 =?utf-8?B?WUN5WjRXVVlFSENhVXV1QUEvNTFWMUNVU3NVdkJPUlFNZkRib042eDRpYi9S?=
 =?utf-8?B?Rnd3SWV6b0d1QUhER3NvNVZ1T2MrbVNONVJNTnlFZ2VZRThQakpDVURkTFV2?=
 =?utf-8?B?TS91a2NGd00wNVYvOVVaRW11Z3VtL0Zhaktsbmp0Y2wrRWVVQ1RoRnQyUjhr?=
 =?utf-8?B?dlZkQ2Nid0RyYVkwOFJsL1JvVjNpaHdqUEc3d0FRVTdIc21POTlHTUpCKzMx?=
 =?utf-8?B?V25CQ3E4WWptdE55OW9jdnd3YWJPS2dMRmM4Ti9RNllPaWRkb1pjSHBOMWZN?=
 =?utf-8?B?bXhyUjFNbDIyRXhTYkJydEZNL2o5U3RnbGExMlVRYWp2d2ROV1RXQmNpM21U?=
 =?utf-8?B?Q1VnWXFPRHlGd2F5dy9tTjBNR0I2cGVTdGg3UEU5T2hvcCtUYjd0aGdRZGZh?=
 =?utf-8?B?aGptV2dxN3JFaWgxcmZIVkV0Zk1Kc0l2andqYkJqRUc3K0E1cERYb3huZXdi?=
 =?utf-8?B?VmUwd1NXbUF6Q25VOFhNb2JSZEZ4TWc2R0EyMW1uQXJ5dEZzNDN0bDIzWUIr?=
 =?utf-8?B?cnZ2bHRPTkZFTmxxcjBOY1Z5eUF4bW5rWVhaSXRsQldVNXZBTWtSTUd3UHV2?=
 =?utf-8?B?ZXlQNEp5UndPR3IrdWdjdXNyWXh3MElwcW5rWGx0N3JtUmJPdGZmYVpkTmJk?=
 =?utf-8?B?L3FYOEtaYVFWem5yQkYwSEdaTlJRbTBCeWk2QWZ0cU1Cc3ZTZmhrTnlmdWpw?=
 =?utf-8?B?OFJPV3dWeTBXQXlNRWRHTWVHMGM1SGNvWnkyUWRzWitzVGZMR1lEeExnZXhi?=
 =?utf-8?B?Vzlza2NRUjhzSk1wd0ZBaWd2ZEF6Nk5kTFhCY2FvdVNaVW9hdmxXT29TcVNG?=
 =?utf-8?B?Qm1EckNZeEdXaEZvSldoampoRnl0c3FuR0JjNTZuVkVEYVJWZDdtY2JnbXB5?=
 =?utf-8?B?VW5meFAxK1dtTnhqM21nL1AxMVppYUplSFdrSmJIdWhIYm0zcmJlWVhtVGVL?=
 =?utf-8?B?c0JHaVVid1g2VXNMSFBWdFlZTlhMVGJRNnk5WkxpS2JJWHZXQ0prWFRSa3A2?=
 =?utf-8?B?N1kwMnplS0loVE9nRTVkQVdENU5PbUhnc05nZjhNTllTY1BCdFJUeWVvUm1C?=
 =?utf-8?B?dllDbXdlZE9pY3pZOFMrbGFsbHhoK1VBSVZWUGVZdnYwTHNMREVzWVVaNkRh?=
 =?utf-8?B?MTNwWEFITjNBdnBvM2hWUGplcS8zMWpCRHk5U2pzYTJvWkN0R0ZOZ2c1cmdR?=
 =?utf-8?B?TllHNXNCbnBEZHRldFdtdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUpDcDEzdTA5dElxNThGOGZHNG9DVnNEcUZjUi8xWVJMaXdyc29NQXAxcW8r?=
 =?utf-8?B?RGhxbUt6NFZoRGdqZHZMNlNTYUxUNzcwdkEzMjE0QTdpYko4eTk0RzVnRjhM?=
 =?utf-8?B?LzFQRUgrK00wRjc3UjRQcGhEamtlSitmVGh4QU43emRlNjZNSkVqZHlKRUFO?=
 =?utf-8?B?a0diOXF1SEdmaWxRdUFEOTNHVzJXT2U2QmdzaVlHUjZCelZIN0trR3JTeG9X?=
 =?utf-8?B?dnVUZlEzbU1MdVNwU1FwZEZCN1ViM2ViRWRUaFpQVGtqTTQ4WHNZWVcxVTFt?=
 =?utf-8?B?RmtXdmoyMnRnRU5YdWxQdUdITnR2QnljZHppYkJPSzVnbnNZcGN1eC9UcHpl?=
 =?utf-8?B?UUtvNzNNWnBhNTlxbDVTZTdmaVAyMjkzdmw4S2lrYmg2bUdEeWZIUTFXUHlF?=
 =?utf-8?B?Vi9HWHNPZlk3bjg0bklBVWhTSjVJL1RsVjRUQmZJT3I5UG9ZdHBLVlBxK2Jl?=
 =?utf-8?B?aFlDN2RRSVBqNDNpcldOYXk0VkFmS3ZJUzkyZURnTGV0bHlOTmFKK2xycXht?=
 =?utf-8?B?ZUdjd3VXZ0FUbXUvS3RuTnpCazk4bzJmTGdzTHV5ZUJxQ2FFK1h4YzJURE50?=
 =?utf-8?B?K0MrMHY0MUJPOGVpRFE2eUt6M2NJT1JLV0tBM3VGTkF5T3U3NDRXL0ErTVdq?=
 =?utf-8?B?aFdUa0VuRThhUXFtcnU0NHlxM0E2ZVQrNWNYb1l6d1dBQnBkZ1IwaU0vb1pU?=
 =?utf-8?B?U1BxQ0h3Tmh3MjRCNWtsY0w1dXVlYkVUNkhldlh1Y3E3dm5PQ2k4UENjUG9W?=
 =?utf-8?B?UWZlbDZmeVBzRjNUUFNCem1nZEIrVDU3YUNjRUNMbFB2RVlrQmtzMURnNE5i?=
 =?utf-8?B?SjZGNFhyeEN1WWk4bkxQdDkvYXZpTFI0Z1YxQXI5dnBxNnkrN2t2RFVsdDVJ?=
 =?utf-8?B?QmpBWll0S25GaUtuaWZTWFhRVmNJQTNkaWN4RVVhM29UTE1lenVESmczeVZh?=
 =?utf-8?B?MVQ4QmxKbzJzS0pRWUUxeGpMNnBTTUtqSy92Z25uemF6UWpLMVVHZ3RRckdv?=
 =?utf-8?B?M3ZpM0U1VTAvTGc1Ymdod1pnclFzVTZwWmpsVHFTcm1EbHZGNXJlZDI0cWJP?=
 =?utf-8?B?clhGQVF0bFN4bzBLMXNINmphOGNqMmhrMTVkSFBxeFlEMzFOaUZXbHFGdVRX?=
 =?utf-8?B?Wnp2OGZucEEyRkxpY0xlaDVDaURidnZLWXhpTjFZU1lWSEJpWG9RbVQyenR0?=
 =?utf-8?B?S3JLalVxNk12RjlIZzgyOG9pNlZUSzVJUGx3SWlTTmlvck9WdGZ2aTFYb2Vs?=
 =?utf-8?B?K3pYd0w3VHk1SWtBL1Y1RGNaOGJnZ1VScTdhM25qMmFMcjFHanBUMys3VDA0?=
 =?utf-8?B?b0E5bTRLQUpnS3FMZVVuenF6L0VvU3R5UWtXSXlGK3krZlVQaS82RGUvMVVR?=
 =?utf-8?B?Q1l5N3JLNTM0VFNxemQ1ZHF5UmIvZEhlUGpLL2dENHJGTm9Fc29mSXJKc2FR?=
 =?utf-8?B?OGRKcnR4REFaVC8wZXFIbGprQjB2VGYvQXpBUkFnT1d6ci9pdEVXSU9nRjlx?=
 =?utf-8?B?QmxuQXBOb0VscTB0U2V5a0VGOWZmLys3UTZiNDlGd3F3UmFyK1hyWnJOWE5w?=
 =?utf-8?B?djZHYmw5eitlSDl1Qk5OODJFeGl5ZUpvYnlaYnVlbmNpODdTTVJaQTJJb0U2?=
 =?utf-8?B?UGFKdjFnbitCN21lT0ZVU3dLUFNtZWZuL09yVTBhL1J0UURhOXhBN3Ftbnhh?=
 =?utf-8?B?VFFZRXhVcjRaaFRIdnEwWVFLRXk3dlNkZ0x3N053c2hlSDFkRlZFMVlmWEgx?=
 =?utf-8?B?UnhKUzlWVDVYbk9KVVpPdjZUdGowYzlsSWYvNUxYd2xJME1ETzVzQ3lEV2NE?=
 =?utf-8?B?d1h5aDV1SGdWdTlrb05yRVVuU1d2NVNwWjhkdHlGaWs4elNWNDNaTzVOQmVw?=
 =?utf-8?B?aVB3M1ZuWjZkQm84a01FdEo0bG1TT0lseDJUbFdURjJMTGl4V1B0eHNzdzdF?=
 =?utf-8?B?SFpSWW91N3ViZisyR2Z6TnlkMGcyL2tVT1NiN0lrUUNlcDJWT3l1eXdkbHJu?=
 =?utf-8?B?K25pM05jQ0VRQjZvRmw1blp1TVovYzkvRU1XOWpTc1lPZllKWjRBRUtxL0k1?=
 =?utf-8?B?a1JLS1FFOVVvZm1EQXp1b0lYaUhCQzQ1cUcrNXhwZ0hLUndpbitTQVBiMVh6?=
 =?utf-8?B?NkJuR3JRenVwaUNNVi9SUVM5Y0ZkVXJoRTBNRVUyQ21jZEw0ekYraGpWaE85?=
 =?utf-8?B?bmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57709e07-5114-4a2d-7b7d-08dc977e44e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:26:15.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R87ZL6ngBQLjpL7F9oQE976n2s/+wbZxc/zKfOj1XGrddTCmDqr8TWG4HXdJPA+R535gnaAG57yCxnGLDzGKsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8748

[always use reply-to-all on mailing lists]

On 28.06.24 15:06, Jiang, Yi (T CED OES-DE) wrote:
> On Fri, 2024-06-28 at 14:33 +0200, Jan Kiszka wrote:
>> On 28.06.24 14:21, Yi Jiang wrote:
>>> Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
>>> ---
>>>  ci/kernel_5_10.yml | 15 ++++++++++++++-
>>>  ci/kernel_5_15.yml | 15 ++++++++++++++-
>>>  ci/kernel_6_1.yml  | 15 ++++++++++++++-
>>>  ci/kernel_6_6.yml  | 13 +++++++++++++
>>>  4 files changed, 55 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/ci/kernel_5_10.yml b/ci/kernel_5_10.yml
>>> index 44cd6d6..36c2e06 100644
>>> --- a/ci/kernel_5_10.yml
>>> +++ b/ci/kernel_5_10.yml
>>> @@ -1,7 +1,7 @@
>>>  #
>>>  # Xenomai Real-Time System
>>>  #
>>> -# Copyright (c) Siemens AG, 2019 - 2022
>>> +# Copyright (c) Siemens AG, 2019 - 2024
>>>  #
>>>  # Authors:
>>>  #  Jan Kiszka <jan.kiszka@siemens.com>
>>> @@ -61,6 +61,19 @@ lava-test-5.10:hikey:
>>>    variables:
>>>      KERNEL_VERSION: "5.10"
>>>  
>>> +build-5.10:rpi4:
>>> +  extends: .build:rpi4
>>> +  variables:
>>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.10.yml"
>>> +    KERNEL_VERSION: "5.10"
>>> +    CACHE_KERNEL: dovetail
>>> +
>>> +lava-test-5.10:rpi4:
>>> +  needs: [ "build-5.10:rpi4" ]
>>> +  extends: .lava-test:rpi4
>>> +  variables:
>>> +    KERNEL_VERSION: "5.10"
>>> +
>>>  build-5.10:beagle-bone-black:
>>>    extends: .build:beagle-bone-black
>>>    variables:
>>> diff --git a/ci/kernel_5_15.yml b/ci/kernel_5_15.yml
>>> index 52710fd..e17275a 100644
>>> --- a/ci/kernel_5_15.yml
>>> +++ b/ci/kernel_5_15.yml
>>> @@ -1,7 +1,7 @@
>>>  #
>>>  # Xenomai Real-Time System
>>>  #
>>> -# Copyright (c) Siemens AG, 2022
>>> +# Copyright (c) Siemens AG, 2022 - 2024
>>>  #
>>>  # Authors:
>>>  #  Jan Kiszka <jan.kiszka@siemens.com>
>>> @@ -61,6 +61,19 @@ lava-test-5.15:hikey:
>>>    variables:
>>>      KERNEL_VERSION: "5.15"
>>>  
>>> +build-5.15:rpi4:
>>> +  extends: .build:rpi4
>>> +  variables:
>>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>>> +    KERNEL_VERSION: "5.15"
>>> +    CACHE_KERNEL: dovetail
>>> +
>>> +lava-test-5.15:rpi4:
>>> +  needs: [ "build-5.15:rpi4" ]
>>> +  extends: .lava-test:rpi4
>>> +  variables:
>>> +    KERNEL_VERSION: "5.15"
>>> +
>>>  build-5.15:beagle-bone-black:
>>>    extends: .build:beagle-bone-black
>>>    variables:
>>> diff --git a/ci/kernel_6_1.yml b/ci/kernel_6_1.yml
>>> index 1c6a6d7..cd7906d 100644
>>> --- a/ci/kernel_6_1.yml
>>> +++ b/ci/kernel_6_1.yml
>>> @@ -1,7 +1,7 @@
>>>  #
>>>  # Xenomai Real-Time System
>>>  #
>>> -# Copyright (c) Siemens AG, 2022-2023
>>> +# Copyright (c) Siemens AG, 2022-2024
>>>  #
>>>  # Authors:
>>>  #  Jan Kiszka <jan.kiszka@siemens.com>
>>> @@ -61,6 +61,19 @@ lava-test-6.1:hikey:
>>>    variables:
>>>      KERNEL_VERSION: "6.1"
>>>  
>>> +build-6.1:rpi4:
>>> +  extends: .build:rpi4
>>> +  variables:
>>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
>>> +    KERNEL_VERSION: "6.1"
>>> +    CACHE_KERNEL: dovetail
>>> +
>>> +lava-test-6.1:rpi4:
>>> +  needs: [ "build-6.1:rpi4" ]
>>> +  extends: .lava-test:rpi4
>>> +  variables:
>>> +    KERNEL_VERSION: "6.1"
>>> +
>>>  build-6.1:beagle-bone-black:
>>>    extends: .build:beagle-bone-black
>>>    variables:
>>> diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
>>> index f13d28d..d840d26 100644
>>> --- a/ci/kernel_6_6.yml
>>> +++ b/ci/kernel_6_6.yml
>>> @@ -61,6 +61,19 @@ lava-test-6.6:hikey:
>>>    variables:
>>>      KERNEL_VERSION: "6.6"
>>>  
>>> +build-6.6:rpi4:
>>> +  extends: .build:rpi4
>>> +  variables:
>>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
>>> +    KERNEL_VERSION: "6.6"
>>> +    CACHE_KERNEL: dovetail
>>> +
>>> +lava-test-6.6:rpi4:
>>> +  needs: [ "build-6.6:rpi4" ]
>>> +  extends: .lava-test:rpi4
>>> +  variables:
>>> +    KERNEL_VERSION: "6.6"
>>> +
>>>  build-6.6:beagle-bone-black:
>>>    extends: .build:beagle-bone-black
>>>    variables:
>>
>> Two things:
>>
>>  - I strongly suspect that patch 4 needs to come first, or this patch
>>    will break CI
>>
> 
> Does it mean that ci/gitlab-ci-base.yml depends on tests/jobs/xenomai-
> rpi4.yml, so that ci/gitlab-ci-base.yml will crash if it did not detect
> tests/jobs/xenomai-rpi4.yml?

Well, you extend the pipeline in this patch to run RPi4 jobs, including
their lava tests, no? Then that part of the pipeline implicitly expects
the job descriptions that you only add in patch 4 to be available
already. If I'm right, you should simply flip the ordering of patch 3
and 4 in your next version of this series.

> 
>>  - I would prefer to switch some existing hikey jobs to rpi4, rather
>>    than adding theses 4 extra ones. How about only switching 6.6 to
>> rpi
>>    for now?
>>
>> Jan
>>
> 
> Yes, I can do that.
> 

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

