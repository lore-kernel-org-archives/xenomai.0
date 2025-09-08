Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D5E1BC41
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 05:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309959; cv=fail; b=LAKH7lbpW4A6uLsNYs4o8hRFByUwuMWvY49X4mhzL6R2jL+EYubTh8+GxC3bObhRV6r/BOrRe0rlbTX1U7K32MHKE12Yc7wpMZlZW/ucdbKZairlslNYbLH4gpWYY+a6t20Fe4pKFM1b3mbXTeldZTLEibIPum5EHSB4RxmoxYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309959; c=relaxed/simple;
	bh=3eTD+TEiQT1PhqHVlXXW4WOuMByeZKS5Rs9Wxvo5jOs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hvo4xxRB/pfBw1g/UgJ0LUfPyWbvlsONQ52HDR5WX7iOeSYILzr+T1/kSQMFNqSoj2PuIXKxgrLopeLQ37rjyiTCuR/AiE8Io02c+1w327Sngp69EAICarzuJEwmBLKwHgqtnH2jz2GMYopkzZUxHtOWK8yYSAtPzHGiY1AXKhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bsHZSHuX; arc=fail smtp.client-ip=52.101.69.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bsHZSHuX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7EE6QVlp7pn9bbDS8bRhArLs61fWgeWM0yi89PcGfETl0hETJ52N8+a1WfLP4iNGCc5CbKMApzRC1XVr1x0J1bITsdt4KX4WYr/64dTgZu7wk5J3djS6bj5AENMRTA3kJ2SOTzjavjUuFwYvaYlhEcdkFeLkLOacTog/OK0jT/hi9hQr8xJN7XQ0YsyI77F1q1x04rMSIRO9ZGrRtBRcaXDURiXvQKPFZV6Q8oe3XRVMU2pnd29EKOFDGPPdcOx+FzBUTZ+1ggQ9sBL/r9h7VX3iXWjlXURWvPUOaA+pFqvN+39ol1fQmlyTuN6/HDdVmuIlLAP5u9WvnfD38llGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ygpqz7jtZTpvkq47rIfqbyThUVj2fBRZX0JdQGeG8sM=;
 b=JjfR1nFyXZjQ/54q5Mc2QFZlMDNO02W+LpQfSdWmj5S+1NEHMC+HcPalg7H+/xTSSpCuqosqCUTFddYLuZxXE/1CbSiIutHunYhJqX+tkgaZ4YBjaDKrreiiKSepJzBYHS2f+aN89mxtjrxkFHYmwytovALXkbNAtUhOGf1XP3ys+RjtbWeUsmzkAJO/Cv/SG3le/TG6nJmdDfXoR2QZnAllYfn0uJVqjQNBijSXQwhM5eXQIaqq+wHiO2Y8mg0U3OXJX4jcfK3NoJvlGtPeMH0Acor6rTBZGGAGUx/xr/dEopB/DSTvt31ZRyG9FLisRw9MBtz+fywbkPUPdQr+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ygpqz7jtZTpvkq47rIfqbyThUVj2fBRZX0JdQGeG8sM=;
 b=bsHZSHuXIkvyqRpaWldBwN/0HQVRK/L3ihLRMCL32tRWXCpBebt4h8jpDdbePzU26yE+gbepYiRvk2bEUD37SlgQoczGx6EgsTVJ8rxrY27bjObLXm2bMVZcx8BfSGll+0Nrzj4Sw/5WPYu79MrHA9b4FB3tBebPtHe8FW6AJ9vf9FXqrlRWF4quv9X2c3ohKMQZDZNXH15ThnSraqfgo1wU6qJhSTdbdyBy9m63E4nNveLWD5cJ567uhjMJjXpTBBz9s/C+OLk8yfpbbSHBwdST5ZPr/XHESebwozvNSEQQQo/EcVdzMEpfsSM5pPY7sLUOcRSausv8bh6VM0I90Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA1PR10MB9177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 05:39:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 05:39:13 +0000
Message-ID: <f293b971-906c-41e2-a966-a39b65e1e587@siemens.com>
Date: Mon, 8 Sep 2025 07:39:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Regarding the issue of rt_timer_read
To: Yao Yongxian <yxianyao@126.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <5990240f.1ddd.18c8f7bf237.Coremail.yxianyao@126.com>
 <c8491c64-f8d7-4136-8552-8ac1fb111170@siemens.com>
 <6e6d5f0a.3f41.18ce78d31f5.Coremail.yxianyao@126.com>
 <5a675ae.2fa0.19927496712.Coremail.yxianyao@126.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5a675ae.2fa0.19927496712.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA1PR10MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e3e5fd-2931-4d71-d7ce-08ddee9a0a7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWxrcmd6YVNGQTlmdlN5TmZnNmFsRi9tRTMwSndxQm5qdG1vdjFIYUVRbkpY?=
 =?utf-8?B?MGErcGtJZGZWMnIvU0xhQXZ4SVArMmt6Sk41WjVuMU9CQmhrNVlWMm1BT3E1?=
 =?utf-8?B?ejQyQzFPR3pNeWYvck11SUdRNk5kNzRaNk1vYkR3Vm1tVnByQVMwcHkvRFgy?=
 =?utf-8?B?V0RISnl4TEo4Z1dNQ2xyVjRGU3poL2R0ZXE5NW9mVkRDb091M3dXV0Z4a3FU?=
 =?utf-8?B?NVBvTjIyUU8xcDRwTkpNQmowNytERE55YWVxKzhDWEtGMDJCM0JLN1F0dTJS?=
 =?utf-8?B?bWlieXF5ZnAvNFZwZnpxUWdaYWJKdFRuY3FwVzVyZC9seTNvV1FEZ2FaSUlR?=
 =?utf-8?B?RnhRTElxaXlHajN3K1JuK2ppaDhLZmhiVjg2TWdQSzZwaEFNZzN2U0JrNjB1?=
 =?utf-8?B?Qnp6MnFudjUzZlJxUVF1VWV3enBHQS9XTG44UWxUcnZqazZZTm93R2NKTC9p?=
 =?utf-8?B?ZkNudVd2Z0FhdDBJSHBaa1F2a2FZM2ErYWJnK1pDbzRWM2pNMUJsQm41VkYx?=
 =?utf-8?B?OGgxK1FtUnZ1QThaY3l3NUVjVkRoR2xBR3dpMHY1R1RORjZxanBaaE42S1N0?=
 =?utf-8?B?MjhUTjUvSlgxeEtKZnR0TDdMMUlMeVFRWHVKcTJlSStwZzE5NThmRUFSbi9F?=
 =?utf-8?B?UWlMc1c4WXJzbFVuNE1wTnBYY0RGZS9naUdybnNHOVlwQ0c3TmRWeXh2UkFQ?=
 =?utf-8?B?S0UwRmg0NzJsdlJORVdWY3dWMnNVcWJWdjNaaE1xZ0lVNzFBK3N6TVRMRndI?=
 =?utf-8?B?NDVxTmFkUEpZdTBEODRRZFdKWFRFUXhNTmp6My90aUlQNE9QamVDSGFjZjBw?=
 =?utf-8?B?SUJKTm1uTGQzWFNueEVpazMrRGN3NnFlVGJGT0RwUVFnTHFxSVdNMWd4YWhR?=
 =?utf-8?B?NFZRdlAwSjZRR0toQVpROUwyVlRiRENEdW1aYkpnTTI1eEtBOFhzcDdPek8z?=
 =?utf-8?B?SjVabjUvM3J2MjV5VGYrb1gyRGNUeThDR2VYMWJZb1E2amp4RnNScms5cTFT?=
 =?utf-8?B?OU1QMlk4RFhTanphZGxFZGxxVWJzMHRSM1F6THBpMjIwNEUrd25qY3dQcW9s?=
 =?utf-8?B?U3hFOHB3MUdjRFRKL3RyTERORlprcGxlWFVoeVArYjIxRUFCNGxZQTdmeWI2?=
 =?utf-8?B?MjdZVy82ZEQzbjh0cStaTkhsVHlqbVRmSWxjL3ZNSU9uQk02aWl1dFlJZEla?=
 =?utf-8?B?UFZoQ3Joc2tHZ1BNdFg0YndVbCtLUWRCeTNFaXkvTzkvREViVFpYVmJ3Y1N3?=
 =?utf-8?B?NUljR25HYlNPczFBTGlzNG9VOUN2azN4WEl4Z2dhT2NONnUyZ3lIVk56YVNH?=
 =?utf-8?B?K2V3czJQUG1CTlhMckFtVHpZOHBSUGFOSDcxZHN0UE9zYytnMmc5SUpZUld6?=
 =?utf-8?B?UWw5VFUwR3prdE1xZVFGRjhvVDNqZ3BuckcwRlhLUXZlck9hNXh3UUxzV2Za?=
 =?utf-8?B?NHVLZ25WazdmTXNUNGJsRW5pc0V2dEFyaVVYTHNyOTJEOHZyTzlrNkN5a2w5?=
 =?utf-8?B?cUJUc09WUk1FQ1B3TWlxMzN6clEyNTlhNERsQXNzaW5TeFk0R0FYYVRjanJw?=
 =?utf-8?B?R1VLRUN0U1F5OEpGZ3JVL0xCeE5CRFVpdVNEeDQxTUo0cWo3bzhHSHhIVVlW?=
 =?utf-8?B?bjNYc1dpZVB6L3o0eDNqRVk0Rjd0SlkzRWdUSnVjMzJ1WlFGNkJXeEtUUzc3?=
 =?utf-8?B?aVM1Ujc2K1gwSUhST2hzQUxLVTdqN1BnOHoxay9Wc1ZGUU9zOGQxQW5DTTh5?=
 =?utf-8?B?eE5lNUNsVVY5eEI0UE9wV3QyaE9JbDh0cXJuM2RHYzVGbEdxaTNmZXlxMUxZ?=
 =?utf-8?B?RDJLWEViNTNuaEpuby9aaDlQMzBUTlBDekhGNk1iNmEzQVRhajg1Rk1mcUMv?=
 =?utf-8?B?RmdiTkFiU1RIaDM3ZklvRzZGOEM1czNqenB6cXNZK2RrSkhhb1hjR3NzWTdY?=
 =?utf-8?Q?GqSL0B5ZvAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmlwVWFuVGpUc2lYWW9DRExkYVJQRjNmeHgyQkxOc05mNUNvZUs1anVVTDJX?=
 =?utf-8?B?RjNkdTlwR213ZjJpdWVCU1hmWGZDeFRYTEJoSEt0a2d0WE9lOE5IRVpXaWhF?=
 =?utf-8?B?bFQ0NEtzSUx0SzJKS0h0Z0tPL1RDU0ZtZGZZS01nZ0hoYjJGdWdGSDBLMys0?=
 =?utf-8?B?ZGNyZUp2SFQxaHZQUUtPTGRpdHZrSXpSY3RGVk5VcmtLWWxvN1lBeFNCK2t1?=
 =?utf-8?B?WmZTRmJiemd4Y1c4anlSR2xNdU53MXcrTzdTbkRyMlg5Y2Fnam1pbnJZZ01m?=
 =?utf-8?B?b3RQRi9SYmdjaVNYVEFZamJEeHV2V3ZoNG9VZzg5T2RlbC9HNWhuUmZKaWZG?=
 =?utf-8?B?QVJuL05aMnhTUVJjais2UndjM2pjY3MyNjlvZkg5a21EOUZaWnVWMTZVZUt6?=
 =?utf-8?B?alZBUWM2TkpwOG1rbzBWdnRHTzZScDBYUlViQ2xReHI0UWxlY1l3Q2dKUS81?=
 =?utf-8?B?ZHo0S1JkclNCTVNSQ2huWEhXNmJnNnI3S2JVNmc5T2t0Z09USkR2VlRqWGps?=
 =?utf-8?B?QjV6dkxHWVROck44UitpN2thdEJRQTdHNEswUXd2Qm1LU21TSFRPOThwS1RT?=
 =?utf-8?B?NUpubDAzdHIvU3ZsRnZMeTdOM1JCeWViQU53TDBhdk9mNFJabFZiWWRVeWtW?=
 =?utf-8?B?YTFDZ2RFSWx5S05vdDY4bVlCalpITzUrY00vbDFEcFFwdVNsT0QxbnBUU1ly?=
 =?utf-8?B?NnNkSGxLVzl0cloyTS91M0daWC9DeWtra1N2ZUFGMmJieXJld0lSL09NLzIx?=
 =?utf-8?B?ajRjVFNETWMxUmdtYjkyd2hZUFJkWEZuZVlPMmllZTNUZDIwQ0VZSm1aS3pC?=
 =?utf-8?B?K3BnWnpxZEMzK0JTMDh3cUkrRGN3U0ZGUHZQbFNmVTI5eTBJRnIwQnJoaGpW?=
 =?utf-8?B?alVkQWpURytzeFZIZnZabDJPbVBPNDZOMm1rbTJ4UFZNd0RnN0xqc1IrTUxH?=
 =?utf-8?B?L0NLaXhudWQydkpxcWt5MlhhdnJFcGtrMGR5U1JScCtzQnJxaVZVbWI2SUZw?=
 =?utf-8?B?MjVXRUtvTUFpWGpyWmUvNE9qeHdwOU54cy9XNjdZUFd4amVSNUZRY0R5U2ph?=
 =?utf-8?B?S3hmeE9YUi8vR09taXNuN2tsOEhXclUrZGtRbVBqSm1pY2lsZWxkTVVKVUNt?=
 =?utf-8?B?TmFLdTBFd0tRTmFMQ2hPQlRkQW9SS25uN24rRWsxU0lpamdPVFpFTGlzMVdU?=
 =?utf-8?B?eEFkeXVORDg1czZFZE5mbk9qemVKL0dlTVFBOXJlVWFaQ3ZtWHRtQUhWaGxh?=
 =?utf-8?B?Tm9vWVN6L2twVnBaR3Y1OVpBUU0rVDFzNSt3WHY1ZVdpdnBHMXhnK3NkNi9t?=
 =?utf-8?B?azFOQTFzNkNQblRUSFVuaVJiT2V4SWhZWXhta0xXUmtuUGZybSs3NTFlTHF1?=
 =?utf-8?B?dWVvandTc2xCcTBDL3dPUjQzdmxJaHRvUnpnY2lDakMvQWZSY05XcVR3OXgw?=
 =?utf-8?B?UjZuVnFTMDBSWEVEMFlVUUl0TnEzR2t1Y2Z3VkV6WnlrUFkyeEt6L1VXdGk5?=
 =?utf-8?B?RjVxWjRDNDZiNW02Mms4RThEbnhpaHo3eDVrZlJFMlJzRWwxOGVZdExSSTR2?=
 =?utf-8?B?QmVIbGVBWFYxWGFIR1Z5djI2VVl3cy8rQWRVS2xVWTl0STZaSnQvNFR4ZUl5?=
 =?utf-8?B?WVpzaUllUUN4NnYyTEcraTROc2MraDF4aWlRT0F1dVN3QVJRTEVVbXUwWThJ?=
 =?utf-8?B?ZTJ2QXNvd1FSMDVGZXNYdU1PLzhHWjRhNEE4UC9WNjRrZ3NrZlZkVGtPZjIv?=
 =?utf-8?B?UDRvaUdZK0NPZXVFcEZXTVUzNjZZRVNPbE4xdWJJRDFOakF5TWYya0VJMldI?=
 =?utf-8?B?WW9zVFRLeGYzcnRjOWRvL09IUkxENitaWERFaGhWQ2E1eXQxcy9lQWNIUlFr?=
 =?utf-8?B?L2JreVR3TFJaWmRlVytUNjlCZWpEMHZVei9TNk1MNkdZM0tyY2piejd3WXlK?=
 =?utf-8?B?dEN3bEFWY2JBSUtublE3S3hhT3doRUN0Q1lMUlU5LzhqS2wzbXcrdUpHd1dD?=
 =?utf-8?B?VnhHTUdYaWo1ZU4wdENVaTk0aXluUVB5U2ZRVUNpeFV2ZTdyYXZ1YUhnRWdX?=
 =?utf-8?B?ckNDRUFPbi8yZEVpdDdqaTlwVjFwTTNaRmkzWWVNME80ek9kSUtvNWExQkJ3?=
 =?utf-8?Q?CHDNvCDy3VbEwufiS2laZWobS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e3e5fd-2931-4d71-d7ce-08ddee9a0a7a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 05:39:12.9472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7M1t+wD9uoJAPrYa18DIMgou57EXJOZ8ky7mE/0CrzOJGmnx29aTKgIsN6qM3IuJ//XRWRwzyNItbvSOJMSyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9177

On 08.09.25 05:05, Yao Yongxian wrote:
> 
> Hi,
> 
> On the same computer, immediately execute rt_timer_read() after rebooting the machine to obtain the time:
> 
> a) When running Linux 4.19.89   + ipipe      + Xenomai3.1,     rt_timer_read() return 8715069990ns
> b) When running Linux 5.10.199 + dovetail + Xenomai 3.2.4, rt_timer_read() return     50879028ns
> 
> The time read by rt_timer_read is the relative time since the system startup. Why does scenario a read time as long as over two hours, while scenario b is normal?
> 

I-pipe used it's own timebase that was sync'ed by Xenomai to Linux once
during boot-up, IIRC against CLOCK_REALTIME which might not have been
set yet at this point. With dovetail, we can use the Linux clocks
directly so that you are reading CLOCK_MONOTONIC here.

That means that old code which used to run over i-pipe should not have
relied on the clock being sync'ed anything (we had CLOCK_HOST_REALTIME
under posix for that).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
