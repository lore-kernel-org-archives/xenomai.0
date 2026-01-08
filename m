Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FFF39E6C6
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881306; cv=fail; b=O8G47WujjMX3poN3UozVoqUIoUGv1JcKWDflgG6TYUyKDZtW+uy14cz7Tb1/jSgBCExaLhxwCVJXSoiYqXBt2MgoAmMUkNvqtD+ApmkdXTlYh3RatMprpZlKB16SnXSYzM+HW32U4uVDn+kzy0CXmg9umlaQXEEmL/aTRzBlres=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881306; c=relaxed/simple;
	bh=dijnQOGAYw4/neKFWMV43l5XI5sA+QdVIvaBIVnLNyI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7cN06ME9TX9Yy7sC2q3T+fky6xgcI0GEmTfksm2JY0Ptl427wCtRPJDfVckFLTGYKb2Oco4sRZYB24YTuxF+PYVhex6ldOOZLUWSlXv0gfal2i23Uoj0hD+JmPd3H1zfAG0XVkLibZ5ZpAUi4PgQwzt9FPOI8m/L3sIAskYGms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Haw3TQvn; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Haw3TQvn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCr/qH+JSsYMh+SXV04trOeXznZYGDAH/mCiKNt9+wbTmoOidD0ykBRLNi5BKfVAdn2Jan22C1dGsxv9gX5NSro/1xegtZ1Nt0rGb3K3tKV928LlHxPEaLjg0rukKu/ggmO7sd7ok6uZIe9HwCFPEMNVJTw2WCyCRpo0DAwWTAFI7UrTfEtmxJtCs2JvmpzsBm62lHAb6zNNRuzZTh2a1s8kI1qaq59RDgGIDyBm7clWyQUS95osQmgFTkT9g91jeH8YNUKjpV+uepOayMA3l1d9L5YLLycv+kZ4HbSxqDGVlLSLdbh0OR3MjRx+am2Ka3R/S7K8ZcQp7V2DqpEnbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hX8qgij40XRvvMqYD4k+Y5lcfHEr9y5H+Q7zOCEaW0=;
 b=Gt3A6+oyW2De0EZRcZ4CdRHJlO7taSy47StxyyiQiSiutyy/NAybDg6p0Em5IKERxPNc2S50zEneg04BBPPNj1dTVBTqXJlJxcfNVZqpL8dFqeOys3rbDyPfSb7KMncqdTuIVo94ihIiYkHQVNTCaUkNJKgooCoxtrNqezpVUD3vuOX7cfcmI52xoz1ICz2u5Kcwq4u1rSb0hr/e2bp/RiYzPM0K/ovklxFtF4vRR7s40gOHWyn9dynzQbW0q7AO2ktQ1xPs/5Whg+0kRRulifuBuahxSTvmt+kbFHgXZInURneCbYXpDzNWbzVQJ1fiAxrJtRyHh8SAoK8JUR21/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hX8qgij40XRvvMqYD4k+Y5lcfHEr9y5H+Q7zOCEaW0=;
 b=Haw3TQvnYGncMx+jFiv+iobBqrdpckjNr0plUQSr8bXDfRAD2zzvvrdRchMRcXtdg5FhPnG9EgeHyVcogrS+ZC32XFiiEtMQb9wWomdCMLyUDDkH8HJ1hJxdWpABBwiq3UHU1a4WazfBmuYzg1QeyJRVGu3cJ1Hr+r+8zcqpFaoZTLVE6eQ8ZV2jRowbRVUROXqj0LXZvRRVW7D1ypJEApmUpSNmtMFbQyI/YZXz/MiGUJZdyW7sfXvORuTK7JGG0bl8pyfu1B/Pa4kaNBf9dLxtD4BYD79jVpYPciKjixMsN4vqOQr4C9yCje/S63r50k3zpPTv3bZDMrYQ8bWeCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8662.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:08:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 14:08:19 +0000
Message-ID: <a099c4e8-0352-4a83-8428-6cd3021d2175@siemens.com>
Date: Thu, 8 Jan 2026 15:08:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wip/dovetail-riscv] riscv: irq_pipeline: synchronize IRQs
 on exit to user mode
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org
References: <20260108094551.92100-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260108094551.92100-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8662:EE_
X-MS-Office365-Filtering-Correlation-Id: d3ef96da-bd81-4009-32a1-08de4ebf6053
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b3pjMmt1MG8rZFl4V1N4YWNyZ3lxYmtqc09rZmlLODFvUFJVVjJrUjVtajNN?=
 =?utf-8?B?YnlBZHM1WDBKcEpMRnJxcy9qV05LWUxwak1yS0Ftc1lIQndjU2VDQWlLREhL?=
 =?utf-8?B?eTFNdWxqQ1dmazVSOXBYY2FzelFBakhiN3Q5WWhpcnJRc3RjaUFWNGl4T2Uw?=
 =?utf-8?B?YTIva2grazdMZ3d3ZUN0ZExacWFMM3E0OTdEYjZIV29sSlVZYjF0U2k5UVkz?=
 =?utf-8?B?aFN4TkROUS9BZCt0KzdFaUZtY3pYSS9udUFiMzYwVnAwQithQUF3NE1vZXJL?=
 =?utf-8?B?VUZ5YnJLazlLdnZoRFhBR2twNUUwb0ZubU5ucXQzY0tFUnl5UlVxcnNhcGlB?=
 =?utf-8?B?YUhMZjZtUDlBTEdXV2ZXenJpU3dnRFRhLzJYdlgzQmRsZmJrQW03d0RqMTZu?=
 =?utf-8?B?U2ZJdXNKd0tRZVZQdXZBREFuTDY5cWttSlM2ckRBM2FDRGdPQWNtOEtNZU41?=
 =?utf-8?B?bm5FVnloQys3MDVkYmpqclNiaU01NnJkZ0l4cXFvZWMyL0Q1bWxoNUpDc1kr?=
 =?utf-8?B?WDB1WVRreHM2SDA3blEyeUZ2elU4NnhxaVBqSTZaQlZtU2g0ZURiVGFXcTRi?=
 =?utf-8?B?ZGQrb3gwOTh2ZzdCL1c5VDNrR0puMU1BVXZjR1pzblFYYTk3M3FvWmdubFY5?=
 =?utf-8?B?OVBXb3RPbmo4dWZzNjRWSGJYbTBtNVJQaTVkdHJFMkN3K3BHV3FLeDc1YXVG?=
 =?utf-8?B?a2FaUE14M01tbXBhdVJvMmUwakRCNUoveXBnajNUT3lGcVVwRW41MWNRNnQr?=
 =?utf-8?B?QkNPVGxnZkVMbmpUVFhHT2w2TU5raEtCZ0pQR3lVQksyM3RBcW9zclhsTmZn?=
 =?utf-8?B?RWZYcXBvb1pVd3hKQllNQm45MVFLcWlYT0lvN1E1N3FSd2FSUCttZWRJUWc4?=
 =?utf-8?B?WWs0K3pqMnR2eFBvYWNTUHYyUGZkM0tGbFlGeXhUOW9paThERVJLT1dtR09l?=
 =?utf-8?B?Y21TeHMrUEo3Y2tXZm1VY0pJTENQTkxXVlVzbTFhV2d3a0tRNUpISXp5alhi?=
 =?utf-8?B?aG1tazBhZU1VZ0RRTG1GZnFYRDQ2ZUpFSHE2TmlEZGs0cHRrQ3p2NnN3WDBQ?=
 =?utf-8?B?RlJsYzVkbEhKZmxOc3lPZVJpU2lSL0FZYk1tblczZDIzbG1EV1BqWjIrUlg3?=
 =?utf-8?B?ZTRhTHFzUjZSenloaXgxQStkanUwZDhuMGpLQnlqVE9vY0dHdUpaVi8wMXgw?=
 =?utf-8?B?ZVFmbTNSVGQreXBLYjB4ZEQwS0RTZTdHdUhWYWsvVms0YkNPTGZpREI4Z204?=
 =?utf-8?B?czRuWHdjcCtYbFd4Unp5SEZudVlrWHorcWR2U3NXNDRxMHduRmpZdlpIK0VL?=
 =?utf-8?B?TTMxeERyVWlLaFEyTEViQUJ6K1FJbFpsZTd3SmRHZXFHUWFuMUU0b2NENnJK?=
 =?utf-8?B?cW11dUs0Tit1MWR6RUZPV3p4dWxLOENKRU1NYSs1WjA4UVJ0WGRPRG4vWFRJ?=
 =?utf-8?B?OHBpMzIvQzBmck5PbUhhdmJkL3liQ3NJWUV2VStXYVZkN0QxZDBSS3g1eEht?=
 =?utf-8?B?eWY3WUhzVGJXOUs4SkRaVVpuSHU1WnRCQTVGSDgzT0RNM09PVDZxWWtIbUxE?=
 =?utf-8?B?ZmlSbEN6bVJlRWdOelhCcHhtMDMyOEY5dXFGT25pU2U5QlRTTzZHWnk2ajhK?=
 =?utf-8?B?cXdINkQvL3dydklLdmhZbzU1dHEvS1AvWFZVbDgyV09RTk5zTHlvYW1CRSs5?=
 =?utf-8?B?M2lCRzlUZ293ZDgyTVJJODJjeXRudlVmU1k5aHgvcWlQcUJoNTcrdnlSK0pt?=
 =?utf-8?B?U3JXUzRUcFljV2hycFdyakNaSEl0ejVodzk5SkpnQllRbEQvem91dzBCTkVh?=
 =?utf-8?B?Q29ZdnpiSWtDS28zbENFRTE4blQzVkFVU2Z4ZERCS2JEMjB0bGNOQktMcGE0?=
 =?utf-8?B?N1MwU3UwbnBTTEVKQ0dDMEZ4a2dSQy9DVjZ3emlzdE45LzcvQUlKR2xjS0NH?=
 =?utf-8?Q?2I6x1dPBKNyrdnhlZ8GHfmtzXZmG6vSQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlBaTHFtQlZMUkNSdlRwM3NSbnNteEZJdCtKcENCRFc2dXFJNktpYnUzYzBl?=
 =?utf-8?B?RTEvdWREVHRNNWorUW5ZRXNyZnBXZmtZVjVndVVFMWNXY1NrMjVySmtaWHFl?=
 =?utf-8?B?QUVlSW5GU1c1OE1MK1BmNWdZc1kxNVRhMnhpUTZUTUlyM0pUZk9wbXdEY0c2?=
 =?utf-8?B?dUJrRFpvSjN1Q1Q4R0RUYTdhUEpneTYxZmhWTHZ1Y1VxWmxaZE9sQlFEUHBO?=
 =?utf-8?B?ZVUrbUdQREU1cEJkb3pRbUU2Q01ZQ3pJdkFFWElCYjVraWhNTThGZmNpVFJp?=
 =?utf-8?B?VFpDT0FiOElaL0dvb1ZSclMwRTFER1RBYmFtNVZaaTkvV3ErQWdNNWlqYzBD?=
 =?utf-8?B?enZWZWJZWmU2RmFWN1NOMXB0L0pPc2xydjV2Kzd1OXc1VWpMdDJKM0ZoZEdi?=
 =?utf-8?B?bmhmUDFYNGpzS3RnYUd4V0FpcDRuSVUzWEJlRUlIMWNjOHErSVNYQ3g3QmJv?=
 =?utf-8?B?NjRhUmxUZXJvR0N4WEZIRm54YTI3dEtXWDNIYW9YejFFWWNNcDNPZEx4bG1Q?=
 =?utf-8?B?Mm5zOStodFJrd2o1K2xkUVFxTHord3Bzd0xZWWg1dFRpVW1oWXkxZ3JiL1cz?=
 =?utf-8?B?cWJkaGJtMVFnRi9ISWZNb0RlSnk0K2haYkFyc0pRVXI3R2FPQnVIdFU1OU55?=
 =?utf-8?B?SFB0eTRlOVg5VUMzNEUrbk52REdUdHY4QWwwSktwMlNwSm94QW9jQXNza3JD?=
 =?utf-8?B?ejlEWW9jREU0VEh2ZHJKVXI3LzhxVFFoUE8zU3llOXJqTGpJK2JKdDd0T1h1?=
 =?utf-8?B?aGFGd0pnajlrcTdtZTJndE56bEdjbmZiOFppbE82cUt2Z29NTTJNRCs4bGdN?=
 =?utf-8?B?d3JNaGQ0b0FZVWFZdEtycXkxNERpREZ3VWRoYzdHYkg3eHViUVFBN3l6R2d5?=
 =?utf-8?B?WjVNWE0yUTJGbTJ4aFhLR1dKTVZWZ1FWMm00YnBDMXVId0hxeWhNOC8zWTlt?=
 =?utf-8?B?b2tlTUYwSUt3RTdlMkVUYnlDRWxaZ2RwdEtGYnRKTTZHcUxwSnU5d3p4VElR?=
 =?utf-8?B?RTJkRSt6VHR4Z01KeGpIUHAzbW84VG1qUitHdENNQUdZRTIyZFIvTmdqenNa?=
 =?utf-8?B?QmhVN04xQVd1UzBWQUs0UldsM052R1NSUkZ6UVMxU3BhZE94dFpHd2hiNjl6?=
 =?utf-8?B?b3F4THdSQjRMakh4eWFTbWl1U3o2YnFzRFExbjR5Mzdxa0RsYmhvVXNZd1o3?=
 =?utf-8?B?WVNxOVA3VlpHdm5sUkd5QU5pN0E1S2xkWXNSMXh5RzEvQ2ZZLytPRllkbmNG?=
 =?utf-8?B?Z2hxSyt2RzgzNHNJa2g0U2wrV1pDWEIvNVJOck5xcGV6SFJmRWU0VWpacVNH?=
 =?utf-8?B?Z1ZZai9yRVZ5RXEvRmlpWkJYTDkwenBYcGQ1em5mcml4TlB3VzR5T3poL240?=
 =?utf-8?B?SWtzblFtdzhvSStDRGJVMlZ4VDVBWjlDdTVJVlJyODQvblJZanlSYmhlZFdK?=
 =?utf-8?B?aUQ2L2tPS29namQ3M25PTGo4ZzVMTXJxYllFbE91ak50WXgxN0J0VlFabkhw?=
 =?utf-8?B?eDh2ZFdScFRLWktLaWZxRjM0clN3eXppa2lnNlBRR2lsdUpheU9GSU9NSWpD?=
 =?utf-8?B?aGVCRDJhbFRTa3NxdEFTOEw3a0g1OERPM3ZQS1F6RVpINlB1YmlVeExqVFJX?=
 =?utf-8?B?Zk40L3NISjVVL0RMLzhRWjVOUXljeWsyYnIweW5aekVSUndIRm5RWTArZEE0?=
 =?utf-8?B?SkVDYXlxMDkrNjRvR1J0bGtmWkl3QjE1SGFJY1MzZmlINno2R0dza0pnbXJP?=
 =?utf-8?B?SDVDb0puTVZNbU1ZLyt6cU1PMmNNY0tGeXZZekNnMjNVMU5nZzNyaVBPeng5?=
 =?utf-8?B?MTJXYk8yaVpuWEhmM1ZacVlGM2xGU0FWcUNFV2IrY1cyMkdzYW1UUDZOWENH?=
 =?utf-8?B?dlg3cWF3ZTYrd3Z6Sm50RG82eHZFQ1FpSHdKbVJhREQ3U3E3Qk1TL09jVkNP?=
 =?utf-8?B?cGR5YitkOTFOei9KV0tneGU3NitiN2hwbWxGblgvVEFQM0dpZzl4cGFQR0lI?=
 =?utf-8?B?N0VHTjM4VzBrR2JCaThucm5NZkNuakRsaytrZVk5c0tQSWRSTEl0SGkwQ25m?=
 =?utf-8?B?TjNOR25wRFNDZ0pzeGlNMlhkSDczS1ZYVnFLc0hNSytzZEQxeUx0Q3lzTE4y?=
 =?utf-8?B?V3lYMjVpNk9VMUt1dHlkdHNlK0FLbmpJa08xcitCcFFiVlV0SXU3K2p0S01G?=
 =?utf-8?B?RlZGUTk1VkFjVFVrbGo3UzlzUlM0N3RZTWFTTVNKL2QzLzFWNEd0YnFCUHV3?=
 =?utf-8?B?RzR1N3NEendnWjZmbE1LNk9QdmI4ZWd1aHYxQi83ZjNBL0FBc3dCUnFIMUNa?=
 =?utf-8?B?WmNobkZ6VFRGOG9WRjBnU1VnckFmdU5NN3ArV1N6eEhQMHdCZllZaWpDY0x1?=
 =?utf-8?Q?pObaO5wR5FVzf36I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ef96da-bd81-4009-32a1-08de4ebf6053
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:08:19.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CTtNILAd59S5koeaFhkr22BXtjpAaY15FOyFw/ZRI54OuD4Lf3z8coxTIdlOpwGugOzP1zVHLSQlDhXHvMFRmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8662

On 08.01.26 10:45, Tobias Schaffner wrote:
> Ensure that any pending in-band IRQs are processed before returning
> to user mode.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  arch/riscv/include/asm/entry-common.h | 36 +++++++++++++++++++++++++++
>  include/linux/entry-common.h          |  2 ++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
> index 2293e535f865..1f6189413a19 100644
> --- a/arch/riscv/include/asm/entry-common.h
> +++ b/arch/riscv/include/asm/entry-common.h
> @@ -7,6 +7,12 @@
>  #include <asm/thread_info.h>
>  #include <asm/vector.h>
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +#include <linux/context_tracking.h>
> +#include <linux/irqstage.h>
> +#include <linux/irq_pipeline.h>
> +#endif
> +
>  static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  						  unsigned long ti_work)
>  {
> @@ -22,6 +28,36 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  
>  #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
>  
> +#ifdef CONFIG_IRQ_PIPELINE
> +
> +#define arch_exit_to_user_mode_defined
> +static __always_inline void exit_to_user_mode(void)
> +{
> +	instrumentation_begin();
> +	trace_hardirqs_on_prepare();
> +	lockdep_hardirqs_on_prepare();
> +	instrumentation_end();
> +
> +	user_enter_irqoff();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
> +
> +	if (running_inband()) {
> +		struct irq_stage_data *p;
> +		unsigned long flags;
> +
> +		unstall_inband();
> +

All these lines are generic (in wip/dovetail-riscv, not yet in upstream
dovetail branches) if we ignore p and flags for now. Those should stay
in the generic code and not be duplicated here.

> +		/* Check for pending IRQs after unstalling and sync them if needed. */
> +		p = this_inband_staged();
> +		if (unlikely(stage_irqs_pending(p) && !in_pipeline())) {
> +			flags = hard_local_irq_save();
> +			sync_current_irq_stage();
> +			hard_local_irq_restore(flags);
> +		}

And for this here, you just need some arch-specific hook, right? Then
better model is this way.

Jan

> +	}
> +}
> +#endif /* CONFIG_IRQ_PIPELINE */
> +
>  void handle_page_fault(struct pt_regs *regs);
>  void handle_break(struct pt_regs *regs);
>  
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 1d15bc4ebeee..2cf32471f784 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -419,6 +419,7 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
>   * non-instrumentable.
>   * The caller has to invoke syscall_exit_to_user_mode_work() before this.
>   */
> +#ifndef arch_exit_to_user_mode_defined
>  static __always_inline void exit_to_user_mode(void)
>  {
>  	instrumentation_begin();
> @@ -432,6 +433,7 @@ static __always_inline void exit_to_user_mode(void)
>  	if (running_inband())
>  		unstall_inband();
>  }
> +#endif
>  
>  /**
>   * syscall_exit_to_user_mode_work - Handle work before returning to user mode

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
