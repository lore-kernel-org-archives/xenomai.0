Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363BD1B252C
	for <xenomai@lists.linux.dev>; Thu, 29 Aug 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946111; cv=fail; b=bwZnuda0S1ov670zdvJexTol9y1/3cJiNZnJzVf6k9ve7bJFIz9p+A5tt0EpRVPzvw0hn/5Oa0dWIkvUd6iHd89xSPpxP+e8DelYYe9qAs54V273biFhbsK/TV2vCOWAguaamPE569O0qNurjoETp5ZtG+nWmLWhMgjw5eLVGw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946111; c=relaxed/simple;
	bh=q+U6rQqoCCrevWWXRQQIWeK1kMT/uNh0eouCP6pL5a4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=flLbJMRCCLlAXZFSSs3X6qK/c43b/D4mx5GUuUZeLp2eWf8e7kVRVMHm27G/soemYHRdHF1OhO2Z645MkXJJDFYxkV5dOeYBkO8S/rIOqpKdJdlxSPwzPjp2Rll+bkpwhhLBFkpYB7JzrDOUJG825jembxo9M1WUSGikX1Q6QxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RCsCSsx1; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RCsCSsx1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIwcVSK8sCk1F9KYOkeJeo/bwZXfEaZ/vPlBTP/uxXzoZ2Rbjhd938hCMo+FRo0ah4e5f6ZmdPuYQLZPXnaqDEEN0wvEUivWe7FO39p8SOvd13LcWZuiOpVAsjR2jDry+P9ANvBTWzITtHOMZAaeXEC5xzHRY1xwk5+F7Kx/dR0eXLlDQS6HF6CCTVW5DvTEXY3RCF5evoA6x0Vk1nzhxIHgVTlB76r5X1etVgrmcQfY0ITgP1h6IoFerIZ8tfPfzWJsgm3qU06APCuL6RAnmqDheBbu/XDiI4MELZqRcl/LCEc8nQI9NFayYs6hNN8gm3UAtR7MG1eqI4dgcGIT6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFRt5J98Yu3Idy6ChNnau5O6ktEM6spDjxE3Xf3sXvY=;
 b=iuCdKmtQqsAmAKPdjBjH6dcSI9O5FajtHXv8iUqPYEko8lh3WPhucCeHgQONk4vYGUMimHY3TnVecUIgMqMDuvmKG+ZTdabPNASNambUdKnr/cZXQP5r6fUeM88ba4WK68Y+4Yt0s9aLE2Qzs9aPDQ2GQ/py9R5cggbadhr46mwK8gDpsn687wXuZ9JVVowv3tGrrh5Qc43xyU+vqSY5sVrv0dpWJvhj3/Uu0RSfYKr1FGgiGMUsIc8PmnLbv57kSRwWsS/OKHeSksR/JmDyt3Ab9ZNsceOkAlYPv3S+KEkoH2icNMYW8T6SxO3FIBWWFB1LgWAolB1RiqScI7MB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFRt5J98Yu3Idy6ChNnau5O6ktEM6spDjxE3Xf3sXvY=;
 b=RCsCSsx1q+4ZgEJR8sDxclX8aSoIKb95fJOrRayEVT+Jm4P8eZ8MJFyP+UAwZ/t7ocWXpaewnF4cK2nbeDQhoAmmpSsmToh+H9XWIh14uuyIrckUbshC+Jw4/i/GNg/TC7UgINMzoCpjYZAG/CbMEEwKgPwbFHpCbnJEdvSf4iArNvuqoNVjkLy5aX6F/sd7d7UdPPLuc7XcHkTU9tvIZAEk45LI9p978+mGQz46bj4HzBor9Ao/qAibtUwCTvh+hPNTWQG+CT9t5AQQVN4Cd4VFml6MZRSY0TcrYePSzmsKyio7E0r2tOpe+8IbNnUZLPSrovx29PwVEoGtrpQt2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB5815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 15:41:47 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 15:41:47 +0000
Message-ID: <01d5e55c-7fd8-4aa6-a9a7-efdf5bd3f740@siemens.com>
Date: Thu, 29 Aug 2024 17:41:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] alchemytests: Set cpu-affinity by env var
To: Simon Graber <simon.graber@sigma-star.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
References: <20240829083526.24536-1-simon.graber@sigma-star.at>
 <20240829083526.24536-4-simon.graber@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240829083526.24536-4-simon.graber@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0021.eurprd03.prod.outlook.com
 (2603:10a6:205:2::34) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: fb670e5f-7ff1-4af8-3dc8-08dcc84117a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkxuZ2ZabThJb2pjcGpSZGE4Um5xWnczcnZpQXBWZi9yNHE0ZytsTTluTWoy?=
 =?utf-8?B?SUJ1RGUxOU85cVR1N2xwVGwrR1Ezc3E0ZjZ0Vk9QeEZDeXUxbGtvZEw5L1NO?=
 =?utf-8?B?UThMUmxOY2VKbGxkeWdya1lnR0dudHk0ZzRhcmVlSW4rY0dnMVVQSDRKdGtU?=
 =?utf-8?B?WGR2S2NhVWlFL0VnU2NuZGo2TUpPL1lYNkZrVGN2dGVFSEZHOVB3ZEFyZ2JM?=
 =?utf-8?B?eCtrOFl0SkFaVW5FMjBIbCtMcGZiVVJPczlsZ2lzdndRY2NGOStkWTNpQmht?=
 =?utf-8?B?Q0hBWlM1RUw3QURDdUpoVExEQWtXQUo4Um0wVTkxdVFUN0RXdVpCSzc0ZXZ3?=
 =?utf-8?B?d2NQa0p5MU44UUFJcmhpd2wrVGtGbzcwZHcrMGdJUWluR3dyRUdmMmJHeGVl?=
 =?utf-8?B?ZWFXaVJRdjRsTW15UjdqbTk2d0ZzVHprL2FQRDMzTk91YlhtdjVxTGVXV2dW?=
 =?utf-8?B?RGVQeVNjQkZZaGpxTjZPTEViNVJGeVU0NTZ1YVFoYkY4S2hYL1BsVTczbVpo?=
 =?utf-8?B?enl6TmluL0FqRnFWL0J3M1RiNmlCL0J1dWplTDcvNkdqRVNaV1NzQzdGR0R6?=
 =?utf-8?B?ZUpsK09PYnFwVDJWUStuVmloRjZnMTc0T3ZzQVNnOFExNXNGMzZUOVY0U200?=
 =?utf-8?B?V2hTVGpKREdjcHl5MWRmeXBudTNaMHVWVTN4UXZ5YW9qUWFzOHRtd0o3eUVU?=
 =?utf-8?B?UjhyZG4zNDRSZ0IraTV0MjI2cmFlcHVyWTRiK08zeXJETmVHY0ptZEdGb0hQ?=
 =?utf-8?B?R0ZUYXhYQ0hvNys0Wmh0cUR3UTBEY2ZManc3UGo1OXpiRTh3aHdKTmM0a3JL?=
 =?utf-8?B?b0VXOWIwSkVucUhVUUJqR1Zob1FTcVVwY0xWdGdyZnNLVE1ON1haTnFqVWE3?=
 =?utf-8?B?Mm9mUDhZTElTRXNJcWR4VkxpWm1CVHhMeGkrUlZNUFBWZ0RuWjdTOXNzV0kx?=
 =?utf-8?B?UGZINitDZUhxSUluaEtDdVpTQS80T0Z6SE1uWE1jRlZyUTFDOU1taS96dDlT?=
 =?utf-8?B?RklCQUxrRkFkay8vZm84Qzg4eXAyYkxJVCtUckVuU0VBSzU2eDE2NUlKNVpx?=
 =?utf-8?B?L3BwUmsvenFwak02MkxUU3NjUDBDamhidU9IUk5MZU55NGdGZm9HdmxYK1Ew?=
 =?utf-8?B?eTBjVkxXd0oyanIwdXVmRnBxci9nUkdVZnNUOXFRcFdpcEtWVTAyckdIaHEy?=
 =?utf-8?B?RkRDaC9wRmdiL2RRNWtLcXUxeCs4N2xpVCtoRHJ1MUwxVW5zMHRKTW16ZU40?=
 =?utf-8?B?UThGbEt6UWJIQnNVY2hqRUovTHhxUjRkdEUxYmJ3SkF0YWZ0NkdaWllGMU4x?=
 =?utf-8?B?OUI2dHg4UnFHUG5IYUtxdlFJb1Y1RituWWQ2Tis0NmE5dFQvVWI4UlR4VjIw?=
 =?utf-8?B?aUF1amgwNit6RDdSOFlvYVpWbXJ4NUFRbXQyMnhuZjI3V3NndXlxUGRMdzZ0?=
 =?utf-8?B?eThPTjJxZlZZVFAybEQ0bkZzcW1tY1NmRGp5ckRZcjFZMTBqTm1YRjlwU3lW?=
 =?utf-8?B?SHJncVlKckdEOGJiT2lEZlZlUXNseGU5WFZ2eVQwOXFBOEVvRVI0d2dxdm1z?=
 =?utf-8?B?T2x3aDI2THJBNnUvYWtZYzNZWndjTEdzTFNWdzYwOU1vVTRhWHhXd0QzYnZk?=
 =?utf-8?B?Rkp5R0NGOWtTZkNrTXg0OXFkTUlRUjJ6UHVJa3RUMTBHZWtHWDE4TXBqR01h?=
 =?utf-8?B?VFNPL0Y0T01LWEFoSGF1V0V4TnVPcmZaYnpXQzJoeXZhcDl4ZU0vc1ArNEdK?=
 =?utf-8?B?dll5N3U4WGlMbkVCbmZScU5adVpWd0pEQ1FPY2h6TVFZMTg4K01saWVxdE9o?=
 =?utf-8?B?dzFJU29zU05vdUV2UVFyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkdwSE0vRlQ1cXJkaFN5TjNEVjhWbHRSTGVRUlpMSk1JTWR3WWtMZmo5bFdF?=
 =?utf-8?B?bHRhODJKT2lQbFZRUmY3MmpmMTg0bDhnMDJXL1pUMHRvZE1Ed0VZWGpyR1lH?=
 =?utf-8?B?eVVVMEYwV1RBVjRRbm5lYm9pM2NVVjZwUEtOSFRYaSs0aDBWWTNvMGEwemt5?=
 =?utf-8?B?UVZoSHA4bnRGdEN6VkNYbjl5Q1JpcE9KSS9zM0crVTVJOEhGRVFXRkUwZUVJ?=
 =?utf-8?B?bW0wL0V0K1RGN2pvZFZwalA3M2dJenVVZFdoRlMyYjJWV1RRRklXdGgvQlZG?=
 =?utf-8?B?RzZ5a2FQRkNMVmNaL3lmUzlYbUdVa1crbmtRM0ZjaklBaVVERWNxY0todzUz?=
 =?utf-8?B?Wm9JeUtObmF1ZUxBTkdJK3FZU1pNVnFmeG9RNkxsdUlMTzd1NTdQODhld3lK?=
 =?utf-8?B?UFJlUWZTQ3NoTkEzVmVQVS8wN2pQRWFRRU5KTExsZTlnb085bk84Qmp3cVR5?=
 =?utf-8?B?aldZcXdDNVhIY0kvUnU0ZENlVnVqeEgwbTlIMmZGZHRldEI3OWpKUlliOHF6?=
 =?utf-8?B?YnlRRVFVVU1aY3lCNFJKZ0NpbnY1UmJxalE0WTR4U3ZSMTJabUJ2WlN5VVdX?=
 =?utf-8?B?N1lhT0EvbTdNTUIzbXUvQVFQcGNvOWtuY3ptb2d0c1BaMDBpQyt5WENIaklP?=
 =?utf-8?B?WHRBNTI5TWtVdHV3ZFRXdHpIT0I3cmNBL0pvT3ZRYlpYa3UzdXZUdUNtRkpo?=
 =?utf-8?B?a2RPYk9OVm5OUHhHQWdsa2x3MUVxTWEwaXFMYkpXVnh6ZksrRmg1MFJ6TDZZ?=
 =?utf-8?B?QjFOaS9MN0FzaXBzSHBmQ2hhV0hJbmNZcCt2TUlkNURVd0E2bXBkcHFIWnFN?=
 =?utf-8?B?RnEraTI3bmFMaUxtbS83Y0F4RkE1VWtNVm5uUm9VVEsxTlFjSnNRWUFacDFw?=
 =?utf-8?B?QUZPOHo5N3BkRTNkblRqTno2bEhGdSthWkxUR25rck5NaGtEWHFrWEtpa3JS?=
 =?utf-8?B?eVd6dndHVnlhUS9SVVRHUHN3dkNTRHlvZ3pHRkRBWERUZ2lrTWcxckhPSGZ2?=
 =?utf-8?B?VEJacGIvUzFYTFMyaW54di9NR2toeEN0OVZUUU5aRnZYVmxZSy9DUGtVcCs5?=
 =?utf-8?B?UXRIaGZyR2xFTlRrdVprOUxyOUowK3pVeVRQdmdzcFRlVDFCWEgxcUpTM3VS?=
 =?utf-8?B?UmxIWnd2UmgzRi9ORExGT2Q4UWdFbnlFaFJlbERtY3VUbStVOFZINDZteHpw?=
 =?utf-8?B?RzVUS2lPalIwMEdTQmpsWFdIVllzZzZoS202YTJ6N0F6ZXZONHNyeU5HR1RM?=
 =?utf-8?B?bnlEN1orK2Vudy90YnVzS1pQMUZ5MFp2NERMZjc2M2JqUm1WSDFSQW93MVJZ?=
 =?utf-8?B?U01hejlQRXVrWUovODdnck5icm1TNWIyK0hqWG1obkYxWXdiQ1F5a3FlSW9a?=
 =?utf-8?B?RjVtandHaE95cXdTTDVaYmZZcUtaOXNVWTBDN3c1VzdxME8vK1F0YWQ0MTlK?=
 =?utf-8?B?bzhrU3ZBTlBKbDFDOTJqblZnT05YK3NHS2YwY1ZIWUowcm1yMk9EdURXaUMx?=
 =?utf-8?B?UEdjM1czL3JxYTNlZ3FCU3R3eDhLOVNUa0hiNHJ3cHhyRXppeEl4UTJWOFZl?=
 =?utf-8?B?REw4bFJPTGN2aXhRN2FCOWR3Y2ZnMVZaZkJQNThzbERiN283YnFRQ3FOYm13?=
 =?utf-8?B?czYzME5BdldTNU1kQ1BrRXBOdkhJTFZSUmIraHk5RzBURGV5emJpckljSXc3?=
 =?utf-8?B?ZkFFamJSaUdNanhrRmlac1UrRlRrSDVlNjl2OVN1c2VSY1djbmQwK3pSMWM2?=
 =?utf-8?B?ajBXYjVtb052REkxNGJiV0xON1hGWlF6L0l6eGNFTnJpM0xPYnRPU3U4UlF1?=
 =?utf-8?B?R3ZDVTl3OEhQNHgzMm9JSmowN3o3TlpjR1BRUXZCWTA2dEhmNVRhS3B1Mm1w?=
 =?utf-8?B?eHEzTDRla2ZWMmFXc1lVemJsK0phVXdyK2Z0TEJpenIySjhLSk8rZnhjeUhY?=
 =?utf-8?B?aXFKd2JrMTg2T2ZpZks3Q05DNjNNMmIxa3pPMWZLUWVvM3NRUUgwTVNzZkxz?=
 =?utf-8?B?dVB3a1FwTldiTGlEL1FSWThqRE9qRHJUNDRHSWR0Ny93R1ljVFVpNXhYLzA4?=
 =?utf-8?B?RldxOXNtQ1FoUVdCbldjTVpyWkJ4Zk1Wa0hkaHhxSE9haVJrdDljbnY2b1Rv?=
 =?utf-8?B?TEI0YVh5K2dMaGxjenRiQ1hsczM2dzJOSTdNZEFkMm5ZODBsRzR4RnpZSGFa?=
 =?utf-8?B?eEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb670e5f-7ff1-4af8-3dc8-08dcc84117a1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:41:47.5461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV1M64n9qmigwRtHjtE5zZgQ2o88U84GVV19lkFFMbxffnZThgBwGdwtGZJLL7t0oaHT32h3kxNZLANsS4HDCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5815

On 29.08.24 10:35, Simon Graber wrote:
> The alchemy test runner can now make use of
> the XENO_CPU_AFFINITY environment variable by setting it before
> dispatching to the inidvidual test programs.

individual

> 
> In a later patch, the --vm argument will be passed via an env var too.
> 

Not really happening yet, is it?

In any case, the advantage of the alternative passing method should be
rather mentioned here. Just looking at the code, one may think it only
complicates the task.

> Signed-off-by: Simon Graber <simon.graber@sigma-star.at>
> ---
>  testsuite/smokey/alchemytests/alchemytests.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> index cf9f970f1..edbafe6e7 100644
> --- a/testsuite/smokey/alchemytests/alchemytests.c
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <string.h>
> +#include <stdlib.h>
>  #include <smokey/smokey.h>
>  
>  static const char * const tests[] = {
> @@ -31,12 +32,19 @@ static const char * const tests[] = {
>  
>  static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
>  {
> -	const char *args = "--vm --cpu-affinity=0";
>  	const char *const mod = "xeno_rtipc";
> +	const char *args = "--vm";
>  	int test_ret = 0;
>  	int ret = 0;
>  	int tmp;
>  
> +	ret = setenv("XENO_CPU_AFFINITY", "0", 0);
> +	if (ret != 0) {
> +		fprintf(stderr, "%s failed to set XENO_CPU_AFFINITY: %m\n",
> +			__func__);
> +		return ret;
> +	}
> +
>  	/* Try loading the xeno_rtipc module as the pipe test depends on it */
>  	tmp = smokey_modprobe(mod, true);
>  	if (tmp)

Jan

-- 
Siemens AG, Technology
Linux Expert Center

