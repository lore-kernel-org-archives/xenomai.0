Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011057.outbound.protection.outlook.com [40.107.130.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35B199E9D
	for <xenomai@lists.linux.dev>; Mon, 19 May 2025 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641602; cv=fail; b=a8JDM8B34kbs47msjy2n3yz/rzYR85fvVzASsvsOAgE3YfgI8bx/jOtx+J4fv2e5ww5hf0feB5b0EFL1k9WQaTQIE6sRuzCjkvSNwLJAl876+tENsBWJtDouPqSZvQXeNpWxAUTKXoeBoWe4Zd+q1XQKuB59usl7+/KfPT8UlzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641602; c=relaxed/simple;
	bh=2xBzZeNm732vewAXqpgQYStcTHGDa2kiYIm09hvSQ9U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EuSCma2E/AxUeFJtIgPtmcIchk560iTFhMC1DjBqpbYNnjAT8B2wWC7pHAPb1JtzxJWW0swH9KlccJjfx3ScvuYQCn6WKBC6A0+XponKw2P45c1ycRt+JnNYDa5oBYlYZGtKQlqkRe1cCdC9BuHR8LOu/Ot9pfGGoB/sXr99WLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=m6jRbOzX; arc=fail smtp.client-ip=40.107.130.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="m6jRbOzX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xyb3YkmjyAVCeKtXHItA0peWBQ20W+yo1dWDtqRVWpiR82cqehIi4u0ZO54TiTGz/xCTQ/CWsou2vFuz675zj13f3jLBHPeFY+xMjF2OoAId5RGbJMsEDWaqXZLzgfQ0CRPI0YfgIrwSjAFNdziRjvh7n+XbEYf2M7yS++MFQXC7YmG5suvfTpGA6CbjdQVOBrRssr4Zg2L4ma752Ue+w6Hd+k3Dd+X9/kBue2P3cT5HeFgEvoKNmENJqK8+fkVQgCZkKeblMhPspr/bUO6K/+31/vSylELjH/oaag+BDnqmE0WT42Z/clDh62JTcE7CijSmFfj9T5pMhXQfMCO+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkYnMJ5SZNnSeOgkWLJABnfPksJNuZ1fuzdB0Yzg/xg=;
 b=kZxhBk0KM1N0zxTK3xxue0wxcj6YNAUnV/eCzn3nfX54mTR5174BYl8PxNVxAA0N+OyPPX11FvsVazb+khbaDD1VMYnDofEvF91a4woJwmcoEs/81Su15ohwQhEMs0VRgWSI4cMqwUZaRrcyLBV/Z8ctpUFmAhvlgvoZpeoSyyhliUnBJiyUZ3LNqHonXjTn2h3a6IJKwBHuU4eiSVzixwursWq1Z4lu0GUFaW8HptG6cphqYbPE6j/nZqG5djWyFeeiIsim+AqVT2cpOHv5iGWqesM/mEXft/CszXpBx689m4ZdO+Kq/+KH0buXTfPtFxOL979yRtqy6mNWnvZ59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkYnMJ5SZNnSeOgkWLJABnfPksJNuZ1fuzdB0Yzg/xg=;
 b=m6jRbOzXEkceojqE0HudQUhuD/KPcRR+sDfuxfZH97csT/XlmAdEuxSBVmFvfVPzEVKCUzqS6f9QmZNS5Ha51NSMJ0WOdfTkgFX/rcnGcjvV0cdRjZIIATTbbVHXL63C6zZp1eF09rF3vS7W6SvW/GbNqgSKOtITP6fZKR5P4Eo3jh+QzXusPSYmPgVzAfpZMAk0bhkmF6R72wstqdu58t7vLrA3Uia8QAVcCJlxC+2RHHonQuVpgDBMgfa6Cd2ZJ7ep3xfWFBuFMEX0ZHs58+cnAXZh+RNsHzbY0l5Rk4YvByKIeABjdTZkkw3H7CMBEo5khPFjMOBgRqwApTKgVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5435.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Mon, 19 May
 2025 07:59:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 07:59:52 +0000
Message-ID: <81e56772-583b-4da3-9b40-e5296b39e12f@siemens.com>
Date: Mon, 19 May 2025 09:59:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: How to use wrap-link.sh to build static app.
To: Haiyang He <aspirestro@163.com>, Xenomai <xenomai@lists.linux.dev>
References: <53a2c0bb.15f4.196e2a4043a.Coremail.aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <53a2c0bb.15f4.196e2a4043a.Coremail.aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d32b3de-21f4-46e8-3430-08dd96ab22f0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEZoVEM5ZHJvTDFYc2Y1L3ZtSDk4Skc0K1dFSnlQSFN2S1ZyU0swZllHU3FL?=
 =?utf-8?B?VkU3SWRremI2YkRrRWk3VzZvbXRxZnJJTUNrSVZxNUJTL2tsM2RCNlRhNnFT?=
 =?utf-8?B?QUJFbGxtMTRlL0wrUEJEWEdvVUViT3VVOFJ4RTViTnlCeE0xMTNYQ0JueG82?=
 =?utf-8?B?UFJPNWNHZXN3d1pNQ0R5dlMyemg2Mm1FL1BmVTczK3NQelZEYWxKRjFrUXJB?=
 =?utf-8?B?MFpuV3Z5ZlhyL2h0V0RxNEoybUc1MEZqdzZYY2ExL3Z0Vm9Rc2VtVFJ5NFB0?=
 =?utf-8?B?WEo0TWJ3S3luUkh0OEZYZ2Y3OWZIN0Jpc1MxaTErd1puL0VXUzh6OERJcUZu?=
 =?utf-8?B?QVVLZFJYNjA2QmduSDd5MndRQTZJQVRRamtKTFhyOTZVYk9EYXZwT3lnVzBV?=
 =?utf-8?B?d1g5d050aGs4VFJLc3lqc0NOZFp4aVJEaXIrTHQxVjdrb1NqT25rTTJZcmZs?=
 =?utf-8?B?Y3BMNXh0UmhiV3ZYRUVWQ21hWTN6QlJoZHMrcFg4bnA3VnExbWZTRGhPNXN0?=
 =?utf-8?B?eHlFVXc0Znk0RHdScmRsdDVYTGszcEVwOFpPTXRZQS9xNkZhSzZ4RXl2Sk1F?=
 =?utf-8?B?RTM3eDViWi93dC9McW1UOWRRNWUyZ3JOMWJCRnROQVJMQzUxL2tabzc5Z3lr?=
 =?utf-8?B?cWIyQ1JFaFM4U1JBUW5DbWVmeDJJY204U254S0JTbzFydkpwbFcrUFczMFFO?=
 =?utf-8?B?VURQaEl3L1RrVDA2bHg5TTNKODUvTnkybG1DZmdPOVNpTWpuS1JXUjVkMlVS?=
 =?utf-8?B?YTU4YXJNVzRIQURldEdGeUNteUN1Wm13Ri9wSkV4dS9JMXBBdTRpNkN6cC9a?=
 =?utf-8?B?UnNJREIrTGM4bW0vcVBjSGZjN0Vib29VSFdYRlRNVHdrUENhdU5IaVllbERk?=
 =?utf-8?B?d3BtT0tmYXBiejZyRzl4N2lwaEZyUXpBMjVBbnJQN0pWRGwvdjJGcm9Xb2xy?=
 =?utf-8?B?MXJiQTRVSFk4RXFNZTZtUDlra0F3cFlJcEluS1plSkpwZjl1NEUwbW1hK3lP?=
 =?utf-8?B?MmE4TUFZS2FObTMrOTRvWEZPMUZrKzBuRGRmTjd1QThDTjV2MlN1SThLNkI5?=
 =?utf-8?B?YWJWVkxVM1p1c28rekMxa0RLZFpDVXA1WEtac2Nodlc5dHp6VHc4MWxuaGM3?=
 =?utf-8?B?STR1SjRlUGQvV1l2TjI1WXUvdFBpTzdPd1JVaFNGeGYvcGticmx2akcvMVN6?=
 =?utf-8?B?YmxNeXNVbXh5dkF5RW5MU3RiOHpXMURSeGdIOVZPdU8rVzZrc2tnRVNvY3Iy?=
 =?utf-8?B?eGx1MTdVWHc1S1FYeDFXdWFWYjEvdm9YRXlFbW5FVkI0YmIybzNMOUhGR1ZP?=
 =?utf-8?B?cVI2VzY4cVl4MVdLV3BoMHBuYVV6YWZJLzFWTXRvU29yRGNwZzVmODBTRGYy?=
 =?utf-8?B?bUZwK0xuc05MTnY2anNhVFIzZVo4UVhBS2lkTFBPVzZDK2hLRWpSdTdWRjcx?=
 =?utf-8?B?OE5FMEUrK2Mwcnk0VU1yNVFEN1ZEbzc3T2RlaTBUakNXY0NmQWFwQVFrU251?=
 =?utf-8?B?ZUhtMkVCWkR3cGpPNHVPdnhuZlZyUmV3WGlqUVVrbGp5czUvWk53WHZSSnZw?=
 =?utf-8?B?YmNjTW1WazFpdnVmSDZYZ1plNkY5M3pWZkQxQWRhWm9HVzNhdDVHbG1WeFZa?=
 =?utf-8?B?K2oyaHBYV1VPREZYRzlrL0IzZ2ZDTFRwcENlOU9SNVB5QmJYK3R5d1BFRVdT?=
 =?utf-8?B?M1JUeHFyLzF3Y2JhaGNHK1VtMEhQZnVKK1hpZjN4OWdvM3hoSklBU05kVVlh?=
 =?utf-8?B?RXpOQ2RWbnFiWWRoSWo0ZHRYU08rOUFaK2g3SGs1MGY1OTR1c2NPNzEweGxG?=
 =?utf-8?B?ZWlBcmhpRndSUmI5RlBiRFYvZlVzZUYwS3BOVEJGS0xqZ3BoaXZKbjRic0RU?=
 =?utf-8?B?ejNBalNlQTNxVjByWjZEY0hOdlNwL01aeEFsdHQvbytnZ1R5RURZZmcyY0RZ?=
 =?utf-8?Q?ljUOrEG0zrc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU1YbWFtMEdxakxvSlFHNlBUamM1UW5hbjQ1QmtGS2Q5SzBNUFBFbGlxRFpZ?=
 =?utf-8?B?bVNBYk9WaUVabUwvU3JmR2FYTzgzeWRVc1JQSmNmM1FFYTVqZERYQ1lWNWZw?=
 =?utf-8?B?NW5EbkZpckMyUHQvRC9ieUVIQkU4VC9rNDhzWG13SFR3NHREUW9jWnR5SytE?=
 =?utf-8?B?bDJOVlI0c0xxWGhmeGNTTHBqeEZsNEZwRDB3ZHovODNPcWJWbUpkME5WeHdO?=
 =?utf-8?B?YU0zUndTV2tWeHhhNUJBNHVUSkZicWxjaHc3eVc5SWoyQ0tMRDVEaXIzTUVi?=
 =?utf-8?B?Vy94SHR5aW9zTnM2bitIWGNmZHM5bUR5YTNiYnFuRjVKTFJBRndTaGc2dGlK?=
 =?utf-8?B?N1MyMDllWmxQSlgvOEpLSnVhVUpvT3Ryby9Eb0hYdyt4THV3aUxQZmNTTFlD?=
 =?utf-8?B?cUY3NUw4N3g1bGxBMlJueFZEUEk0L3p1emxQSndnOER3QUNkZHlPUWQ3SGRa?=
 =?utf-8?B?VnpTSVJtYTkwRld5eFVsb1IxZ3lGSmUrTWdtTkQrd1k5bDJIT1IwMTVKV1Ey?=
 =?utf-8?B?ZzFPOGd1dWZlczYvZS9IdEQraFdnMTRtMEJUSXdJS21mdGF1NXQ5V1lxTkpj?=
 =?utf-8?B?MkloOEZ3djZXMFdJMjJlNm5rYmp2WTZMMnJiU0M1M3RoeEVxU1dvNEVJRUpB?=
 =?utf-8?B?UWdTaFBuWjF1YlowaEs4Y3oreGhWTmVRUm82K1VvbnhjMUc0dFJQdkpVZmd0?=
 =?utf-8?B?MmV3eklZWUNMRlhpc0QrYUtuKy9xNDRpaURUbTRmdXhqNnYweUl4V3hyUlNQ?=
 =?utf-8?B?YkI1VENjdWtnRmtSK1MvVVZvVUE3Ulo0YUpMZ05JaTVtUmI5WURaOG1RNmt2?=
 =?utf-8?B?U1k3aVNlVWpQMjB0RVIvNVpBY1IrTVZwcG1RQTgvT1VvVVlBd21oKzNZaGxP?=
 =?utf-8?B?SjdFdWF3UlJzaWt2NVRqbnR0aWFoOUxVb2V0dGhaNjNBWTNrWjZlNVM1OXc5?=
 =?utf-8?B?ZUhOOXJPeldSTmVwdU1vdTJadWpldWVQVzlwV016blRrYUplTVd1ekNiK3dy?=
 =?utf-8?B?aWNDRTh6bmx1NVNvVnRWSWdVZ1UxNndmRTNTbktyVEZvaFF1cWN1V3VobFRW?=
 =?utf-8?B?SXRyYVdOVzVYOXNPc1BNKzllL01zblJZNTBUZVFlUTBlbnM0TUx2TWtvQ2R1?=
 =?utf-8?B?S1RTVGlmdHV1SjJwZ04xc01TaE85SWNrUDgycFBsaWdVUU1mcDFaSzFlenNm?=
 =?utf-8?B?aWt2R3pPR2ZOR0xCT0VKL2Z3M2VnYW41WUM0TkNlM2o4aUQvSlJUNkE3eWlo?=
 =?utf-8?B?Zk8yMTlWVTJSaXJ1VkNHQlBkTkthQmxnQ29mKzY4eG9yeHZOTHJPSDl5Qk9K?=
 =?utf-8?B?bDRRTGYyQzJLVm1NekFUR2x3bjJlS3Jrc1gydE5XcEhYR0orTTFUMnJSZC9R?=
 =?utf-8?B?cTVUR1Z5dUFIdmxUZG9sVUZmU0lxR1RvVHFpS2h0RUZqVFo4YU1EcTZIcExt?=
 =?utf-8?B?N2ZMdGxXZm9XTXNQR01LdGRqOTJOZkhDNnpRYzN0dDJIOEtUWDVpaHJ3WXNn?=
 =?utf-8?B?YUdLUWhsdHZ5QzFCeENtdkpodVdsVFhnY3BSVzZkOURUbkVHWkxBTjZtbjRj?=
 =?utf-8?B?VFcwckhldWl6bThKbUtUMVpKenU0b3BKT3FZUlAzTURUR0pXS0RTU09FKzVN?=
 =?utf-8?B?b1BLTWQwTXYrd3FHNnZQdnRGSmlCMkxXMDV5QmlidmFFdDJPOGYzSGVkL3JJ?=
 =?utf-8?B?NHZadVN6SXFDYXRaMXFDMk5kWDFxY09OdXBMQ1BERFJ2TlE2WVNJZ1VNQ1FH?=
 =?utf-8?B?T0VyaXpDcHRsUENBMjYwTis1RmwzQzlPQWFzUzhQNGFxWlpGRTZoRThINGQ0?=
 =?utf-8?B?MnZlNFRLUTdXMnBzWGppUVMxeXVaZDYvaytDb0F3TlhzUUdvRDdmM1pPNWo5?=
 =?utf-8?B?Q3BScWdCN1BqeDFURXNWdU1sUWtNQnFSc0Z2dHEyUWFhVzFUYlArSmp3TnBi?=
 =?utf-8?B?c2ZpcnBGclp4WTJVeFRjTVAzRWRaUW12SnJSYWRYZXRaNld0M0hCNDBoTDJS?=
 =?utf-8?B?dStBWi9UL2FVQVA0OVp5U0dYOFh2anNESkV2TGRPQU9ZWGl5UVFLOFl4Vnhy?=
 =?utf-8?B?eWtObnZlb1g1NDVTbHN0RFAwM0ZYS0R3Z3FwWHkzbFlRUWhHc1FOQmtPa2Vs?=
 =?utf-8?Q?W8AWDAl79sKAkOOJyCW1Wozjx?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d32b3de-21f4-46e8-3430-08dd96ab22f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 07:59:52.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw7J6LYuHNn6xzW8eduVGF42ocqS+c51OOK7l24XxOBjsOsoLiDczQR4T1/q+FsNTRlbK/UGN7ClACMj9JUMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5435

On 18.05.25 11:05, Haiyang He wrote:
> Dear Xenomai Project Team,
> 
> I try to understand how wrap-link.sh works.
> 
> I use wrap-link.sh to build static app(a simaple hello.c), with following makefile. 
> 
> But ./hello always got aborted.  
> 
> makefile:
> 
> XENO_DESTDIR=/root/xenomai/xenomai-v3.2.4-install
> 
> CC = aarch64-linux-gnu-g++
> CCLD = $(XENO_DESTDIR)/usr/xenomai/bin/wrap-link.sh $(CC)
> 
> XENO_CONFIG =$(XENO_DESTDIR)/usr/xenomai/bin/xeno-config
> 
> XENO_POSIX_CFLAGS =$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --skin=posix --cflags)
> 
> XENO_POSIX_LDFLAGS =$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --skin=posix --ldflags)
> 
> PROJPATH = .
> 
> EXECUTABLE := hello
> 
> src = $(wildcard ./*.c)
> 
> obj = $(patsubst %.c, %.o, $(src))
> 
> all: $(EXECUTABLE)
> 
> $(EXECUTABLE): $(obj)
> 	$(CCLD) -g -static -o $@ $^ $(XENO_POSIX_LDFLAGS)
> 
> %.o:%.c
> 	$(CC) -g -o $@ -c $< $(XENO_POSIX_CFLAGS)
> 
> .PHONY: clean
> clean:
> 	rm -f $(EXECUTABLE) $(obj)
> 
> hello.c:
> 
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <signal.h>
> #include <sched.h>
> #include <string.h>
> #include <pthread.h>
> #include <errno.h>
> 
> #ifndef __STD
> #define __STD(x) x
> #endif
> 
> pthread_t svtid, cltid;
> 
> static void fail(const char *reason)
> {
> 	perror(reason);
> 	exit(EXIT_FAILURE);
> }
> 
> static void *client(void *arg)
> {
>     int print_loop=0;
> 
>     while(1) {
>         printf("Slave Hello World %d!\n", print_loop);
>         print_loop++;
>         usleep(1000000);
>     }
> }
> 
> static void *server(void *arg)
> {
>     int print_loop=0;
> 
>     while(1) {
>         printf("Main Hello World %d!\n", print_loop);
>         print_loop++;
>         usleep(1000000);
>     }
> }
> 
> int main()
> {
> 	struct sched_param svparam = {.sched_priority = 71 };
> 	struct sched_param clparam = {.sched_priority = 70 };
> 	pthread_attr_t svattr, clattr;
> 	sigset_t set;
> 	int sig;
> 
> 	sigemptyset(&set);
> 	sigaddset(&set, SIGINT);
> 	sigaddset(&set, SIGTERM);
> 	sigaddset(&set, SIGHUP);
> 	pthread_sigmask(SIG_BLOCK, &set, NULL);
> 
> 	pthread_attr_init(&svattr);
> 	pthread_attr_setdetachstate(&svattr, PTHREAD_CREATE_JOINABLE);
> 	pthread_attr_setinheritsched(&svattr, PTHREAD_EXPLICIT_SCHED);
> 	pthread_attr_setschedpolicy(&svattr, SCHED_FIFO);
> 	pthread_attr_setschedparam(&svattr, &svparam);
> 
> 	errno = pthread_create(&svtid, &svattr, &server, NULL);
> 	if (errno)
> 		fail("pthread_create");
> 
> 	pthread_attr_init(&clattr);
> 	pthread_attr_setdetachstate(&clattr, PTHREAD_CREATE_JOINABLE);
> 	pthread_attr_setinheritsched(&clattr, PTHREAD_EXPLICIT_SCHED);
> 	pthread_attr_setschedpolicy(&clattr, SCHED_FIFO);
> 	pthread_attr_setschedparam(&clattr, &clparam);
> 
> 	errno = pthread_create(&cltid, &clattr, &client, NULL);
> 	if (errno)
> 		fail("pthread_create");
> 
> 	__STD(sigwait(&set, &sig));
> 	pthread_cancel(svtid);
> 	pthread_cancel(cltid);
> 	pthread_join(svtid, NULL);
> 	pthread_join(cltid, NULL);
> }
> 
> 

Not sure why my reply made it, your original posting not - please always
use the "new" list address.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
