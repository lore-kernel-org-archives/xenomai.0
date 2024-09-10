Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752613E02D
	for <xenomai@lists.linux.dev>; Tue, 10 Sep 2024 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944142; cv=fail; b=Jc7M4SnqdRR7BF1DuwoPN7l5Rd7lzn7Cd3OrztUnMe1PQSb8o/ubinmGZK6GXrsiTcEtC5o7uEA71SMAdcrV+FlLe3G6871ZXcEIZ/u+O7bie1hZkjg5dnZIQjEJ3fEQZCB+bzpr1ndOa1kmBbPMnTAWCqTo6le5a7oncxwy/0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944142; c=relaxed/simple;
	bh=G1253XAJOWqsi/BjPYQGaynYt2QXDDgZ9+zfYJC1rm4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IiQrH3X7g/LSbEFun1X+ZbIfxAE2i6NV2318F9HQMYWBANa7GgGEH02VcP3FuqeBLFgRScDSS28qeJwp3LlBSE0LGyXziXtflMnX0n5spQqI9Mu/EzyrZn0cYXftPotRkHy6AAfftezZx0gI78GwmS7JRMbHJ4BQSd8fuEH1Q3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ncIzFUe9; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ncIzFUe9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoZaKSb87J4b5/kuQ2+yPg3NkAHfg65Eks52okYExjztGc3nViNeDcAJxcZqUNMjDFJh7XpJI73XidpeRz26oE5JngI2vseXXR++1g9VMaBlEKQhpm39yN76Ta24V3ut0YFIUYlReWYDC8c1zBtlWew69PXVmMLcgKMqPi0nrLawlUvD1+FP7aENwQCH+s4Dot4NiN5NgzSbhL4E4TbukmHW7/8tICL3HZm3DAndm3YzSlZvqlKoskraa5cDpn6yjzjjWe0qbVws2IFVAegnsg5p9v+bl3co3WzMn1tu0FmWwp6CFdZH20S7M/S0yxvQ4ABY1rFyckmhk8QvvRhppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nleUjx8+UVNSf0J3sx9/E81NSvM+ViyHObwl2adN4pU=;
 b=hLKsubyv5t2Fscatk13+z0HxEzxgWKIUvzDQJV9cJTjStr0McY5m+dZXpDm0Jp2caeQ3giOMsImc4+EnNkRNlgUQVbh1P1s4cB29ARBZXPedEuES8URiYWrpbTUj4TYb9UOrrwbPXz+rRl5Zx2jK/sRc8rnS0LwA10xnqVzz7I8yXozaRvEzxlYl1D1qoHAOzTTpNvIqtUkw3odgkQZZIcIInAZggaiIpVD2a2b+u5gQFM9bfFp2T33YZiLMKt7TEOdVPZFIy4CA7dTxkVYdlNH6KQpa3alXdIG4QXBAO3gJGbV6lnwOKjOdpf09wW/kF1v7fETBUiV+bOoDqYGjTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nleUjx8+UVNSf0J3sx9/E81NSvM+ViyHObwl2adN4pU=;
 b=ncIzFUe913PFvkjNXyKBnzhyrQLK58NM7R6lVglXw+YD0g5KnJgZc7zh2WHqudWitVUHbxgtDsVWxFb/X4zV5546BIv1a0WiGgSZuudiiJMGU06Ps8O9yqoiUtfIXPaM4dCmTf4G0N83UdotOwcKzqovRh1rZyIa9TVDXqyJ6yA01YGDGZLQUUczPBCH2Ihv3RTz8Ouw2BN74LFngMUe5JQkUlnR6bPm1amnBte53kgkKhg/0M1wjIIqH9TZAMZmiwOSV/aIPKNIgb1wYgouLsC544SRGpfzk7NwhA/cnAOkk2ZGMiCCW1OF8/BF+9H3Spf8lf1vhk3jFcJjnC0SWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB8009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 04:55:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 04:55:35 +0000
Message-ID: <8fce9aaf-e3e5-4e0b-93d4-aab1fee181b6@siemens.com>
Date: Tue, 10 Sep 2024 06:55:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] prepare-kernel.sh: Mark i*86 as unsupported architecture
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240909202416.4079348-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240909202416.4079348-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: efa47dde-47e8-4bc9-6f20-08dcd154ce81
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2dLQ1NnU3lEODYrWEFEZjhOdkpVVGpxOVB3T2pEN2Y1REI0K05xa0NtSGxD?=
 =?utf-8?B?Y1pyLzNsZ3BhYVYzZTVQK1BpTnlUOUh4NlI5OUtrZ0tyVUY1K3Zobi9yMndE?=
 =?utf-8?B?MzZhbG1Cc2p4cVhrdHRYV2xVYXNDRWF3elRyNkJxYzY3T2gvMFdDMUZZcVlD?=
 =?utf-8?B?YjFQZlB2WXd3S0JzdGd0d1d0RklXUDdQWWhrUkJSMkJtUG4vdzFjeldBNTdU?=
 =?utf-8?B?V08xQkpGNk5MU2Q5NDhmeHpWWUcwTnk0NS9HMDFtbFFwSDVhUzdEY0pnZXRH?=
 =?utf-8?B?SW5VSHNYRVFsdGxDcEN3WDJlMUVmZHROMW1tbVplU1VhRlpYM1ZjVU82V25J?=
 =?utf-8?B?Mmw5RllTWjB4cERpQ3BDaW5hOXQ3YktnV3ZkL2NNQlJDaGQwT1hGZGxlcTFJ?=
 =?utf-8?B?TTBTdFZ0dWs3bVljTjF6TE9JQkExYndHYkRhUmp4YmpwTjQxOWtXWnFibHpE?=
 =?utf-8?B?SHJzZFNTdWRiUGtNdXM3VVRKRzJWRVp5WkFtZjNnZURxeWZTdG0rT3NBK2N0?=
 =?utf-8?B?TFdBVFRDcCtOdHU0QVZXTktZd3FMb2pwWXoxQlFDbUU0aEZGTHVOVU8vcVNt?=
 =?utf-8?B?YW9XbE5VMWtuMFFPL3FPd1c3K1VvaHQyL2tLMzBUNkJ2UTJRaEtrb0hnWGJL?=
 =?utf-8?B?aGdWdUlSMVcrZ2pwOWhWQnhvWVp5YWs0dUU0ZkZSNVNKVmFFOHhBQU5qQ0k0?=
 =?utf-8?B?dnBtd05MTklrb2tZcm9jNWJHWjNJa3hiMWNkWXVudWJhYUdYa1VQaXk5VjF2?=
 =?utf-8?B?M1ZKaHhEaWJnRjJBS20zSHQ5bTB6Vm9NRkdpdGFFOUtFREFqWWZiQWZ6dHY2?=
 =?utf-8?B?QUVnYytUN1Rnd2krSWFMNjRZenN5TGtqWXFpZDJpUFlkKzhva3Zibms1UDFO?=
 =?utf-8?B?WFlTcFJHMGJVNk81ZUpnOEM5VkNqL2RJZTZmRFhPQnNXSHF0aGM0Yno0ck4w?=
 =?utf-8?B?aXFDbzIwUnNXOWwyWGhxaTR2MHd2NEUzSUNMSkRyU2FvUU9rL2I3WGRwUmZU?=
 =?utf-8?B?SkRlN0VseVh2TGU0alV0QSszcS9iMVZUOC9Ea2NGVUZtWVZ0Q1ZCbUNCTnJP?=
 =?utf-8?B?bFowdDlnWFNUT2ZFdlRTMnNXRFBqeGRSOFMzSU1Qdms3MnhNQSswdkdxajVR?=
 =?utf-8?B?WEx2OWxLalhvc1dIVkNxWlJqOTZ0VWxPU2VGVUtnN1J3VkFEZ3ZIVGZTS1Vl?=
 =?utf-8?B?VHZqWnJ3cnFYVitybnptM09rRUx0ZFlLdTdSM3oxU29JSmdiT2U1MlpQakNI?=
 =?utf-8?B?c3RlbU9aNFo3YVFMU2ZVV3FOOVYrMzZkUTFjVFFUS0NvL1FmakFabzh2OFBO?=
 =?utf-8?B?RDdiZmFBT3Y5aG0vN2NnTis4Y0hEUGdiRWxaOVdzWVFQVGZOUmw4bjNQL3BH?=
 =?utf-8?B?eEtLUWJwVmgwQi9KbUJFVmw2WWp4alVpL2kzTjhZZ2p6WXM2emdHbGhTb2Rp?=
 =?utf-8?B?Ny9vOVk4NHpFV0FURll1VWZmZk01a1ZDamZ4Mk02U1NCVUt6TlkwM0Q5RGFB?=
 =?utf-8?B?RTRaMjdTaFhDckpMRlVneVBwYjZ1aytTc0lPZFVzb0FMVVluNTY3Sk51ek1L?=
 =?utf-8?B?ZFRtSGpwVllsR2oxOTBNTXZub0JWVzRmc0JWa2VGa2V0a0p1bHVVUFhoL1BL?=
 =?utf-8?B?bkVmUHlWY3FLckF5YWdWWEtTVW5xUHZBVEVGS1M1cjR5MkttVGVaMFB0MGg5?=
 =?utf-8?B?UlRyNHcyM293YXB3UGwzbzMrRXZYdXF0TFJacUtyZkRTSHlSYk9kZGY0ZEp4?=
 =?utf-8?B?V2ZrSmkxYnZ4WjdkckxUaXI5UHlnM052L2VqMDRrelEreXk1b0xTVFV3ckFL?=
 =?utf-8?B?TE9ibkZ3YldBWGZpY1RCdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUoyS1pDQ2VGNXpSa1EyZ0dweTBqM2FIMXo5Y2hXc0FZdlpjelNBM2NVOHdt?=
 =?utf-8?B?SFdjWVlKRDdKellZNC9tNEtiZ3V4Lytkdm5vSkNyOWhYR3JOOGNhcURNdWh4?=
 =?utf-8?B?ZWlRWmY5Z0FpL2JZczJDaW1MN0R1MDQwMG9yUWdQbjh2Z3pZMVpMak0vN0o5?=
 =?utf-8?B?OFExV1FOZUVieHFJN0VIeTZMSjZDakpZYlJldm1YTzFsS2hycmVUYXlKK2l4?=
 =?utf-8?B?RlBoOFcrMmNZZ1UrOEJvekhYaE1kdTlMeFhQcWlPeUJ6bHJNYlplUkF6eTJG?=
 =?utf-8?B?NHRXK1QxUWpRa25lZTFyUUk3Mi9MaGp4b2toc3RHRlQrRlhsNkd5WFZtQ3lQ?=
 =?utf-8?B?ajdGTm5EK29hR2JQUHpncUJvMjhVRExWZWVRRGxVS0hHb1M0ZWdVdTAvNWJl?=
 =?utf-8?B?bDNvNnJzenFBcnJFUm5jdk9vRDZSaGE0UC9vMXYwdVZFcUZkTDFCSzU3YjBD?=
 =?utf-8?B?bUF4QjVRYmNYczlRNHFldk9uQ2l4N21mWU9pOWlHV3ZjM2FQdzVRUEJFK2xO?=
 =?utf-8?B?YWMvQ25XYm9odVJraTJuNmdoWjlhMW1zQ1l1RXFKSVdzU1RzUDFYemFucmR3?=
 =?utf-8?B?YjAwV3BmcFBVUmorQmVFQk1US3h4cnF5UHpRaldKRldWVk1ZRGJCNlNSMUxq?=
 =?utf-8?B?dUlsamxEOXZRV1Z4YTNTNEdvb2Y4ZUJXNk5yMCtJVlNLWXEzMHFqWXRkZUVs?=
 =?utf-8?B?RVRZUHdadTNrbDR4bFVUVXhwMSsxYUtpdCswVFd6enZ1eUU1eURJbWJjUHpN?=
 =?utf-8?B?dm5wRFJTLy9YdXFIWDZZamRBclE0VmMyR1VLeDE3U2p0aUtjS0dRZmsvTVJR?=
 =?utf-8?B?SUYybEM2ajl2RXJNVVdqZ2dnMkRsRVVmamx0dTBFY3BuTW1OYngwM3JPVVJ1?=
 =?utf-8?B?NUZhY0p5SlY1SnNydE51U1JLdXdOUXhMQWt6SlpLdC92ZHBLbWdGNHFTVnBh?=
 =?utf-8?B?bVVHdzh4Y3BJb3BzZWhObWFKTzFOMXVsbHBjb0dCRnZSSUwwZGpOcUtPWm5v?=
 =?utf-8?B?eVBqUkFya0FYd2xNYmtGdnVCNVpoK3dOMk9NWXpKN0JCT0lsRHphS2plYnZo?=
 =?utf-8?B?U2RBZEgwMTIvODJtY2NnMVNCWlZ3UTJqTmdzcVhBT2ZHd1cwdnZmUS9qL1Ev?=
 =?utf-8?B?dnlla1lMSmZLNzE4Y3p4QjlrZU1DUk1idC9VUmRmU1dEcTNPbzJTZjdDQXVx?=
 =?utf-8?B?ZW9pR3ZmRDZyTzUwVVVqV25vSDhhcmRFeTkrdkRoZmhNbGVUV3VvOEN5R3Q0?=
 =?utf-8?B?Z2FBNFpReElvelVxT2J6Tk5mYVVKSXpHVDN3cjk2dXVYSjUxTGgza3p4L3gx?=
 =?utf-8?B?aVd0czRwYVVld2xCd0pCWWZuV0V2WjU5Vk1LQXA3QWdOMDIrV1hUa2FBemkz?=
 =?utf-8?B?ejNTWEV6dVlDWGRFZkhxOEdrWXkzN2htZ2tUR29kOERBb3lmWWc3YjRIZGp4?=
 =?utf-8?B?M2ZlSFhzWnRCc01MTXJ1aUsrdTZNbXQwOXN0SU1OTndqTlk2UzRzVWRYZXNS?=
 =?utf-8?B?dmNnLy9KV2dRa0RDVmZDRGprZDZsU0VHaHpXdWYwUGpwazVUMDZza0FaZURN?=
 =?utf-8?B?UjdMbzUyaXlsMDBxdFBFbUhJNmMzWmxmVzhjZVF1bmlkUUdSUlUrTjZSTUJq?=
 =?utf-8?B?K0h2NU9xNitXREdRaTlobnhRVDZ2MmVKTkVpK3lTTGs0S05MV3JkNGhLekc3?=
 =?utf-8?B?cEU5ZzZnemhzLy9SNG9saitsdXc3WVRHQ1hTSzVhUWJPTlVqRU9YWWxUMkFG?=
 =?utf-8?B?cklwWFpFZWo2Q2VRdWJLOUR6WmxPNUw2V2dNVG1UVGtnVTAyNDdBNkF0R0RJ?=
 =?utf-8?B?UUM3bGJvaTBKdStBYVV0dFNvRGlZOG1UYUorWWd0ejNWMW9mMEFzeXFmQ0xS?=
 =?utf-8?B?bXh3K0lFY0lyM2dINXZ5M1hmZS8vU25XZmhqampVM1F3QlU4bW0xYSt4NGpv?=
 =?utf-8?B?NHBkMkdpNzRoZHVPVlFnLzl6c2R5ZDR6bGpyb0NVd3RFQWVIb1o5bGI2NTE1?=
 =?utf-8?B?QWI4V1RBVzI3eTAzZ1pBK1hld21BcFJkVUo4LzVHNmdHQ3B3U1cxSkQwalhv?=
 =?utf-8?B?WElDYUlhNllMS0d3clJWaHBoQWlQeXl5Rjd6aUZFSmo2aENnYkxWRzVibDRo?=
 =?utf-8?Q?DSgV1zZ3Z/L94NjaH5xcCWHiP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa47dde-47e8-4bc9-6f20-08dcd154ce81
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:55:35.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnkOpSbM31zOFM9sBi6XrUuW5OL97ELGkhfa4trDHFsf1QmOre7XrsEJnu+l9yBM17ayIVzA9Y8/8bTyrLTWQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB8009

On 09.09.24 22:24, Florian Bezdeka wrote:
> We do not support i*86 kernels for some years now. The prepare-kernel
> script should bail out if someone tries to prepare such a kernel.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  scripts/prepare-kernel.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
> index 0afb812a4..ecc830fd2 100755
> --- a/scripts/prepare-kernel.sh
> +++ b/scripts/prepare-kernel.sh
> @@ -217,7 +217,7 @@ if test x$linux_arch = x; then
>  	target_linux_archs="x86 arm arm64"
>  else
>  	case "$linux_arch" in
> -		x86*|i*86|amd*)
> +		x86*|amd*)
>  		target_linux_archs="x86"
>  		;;
>  	arm)

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

