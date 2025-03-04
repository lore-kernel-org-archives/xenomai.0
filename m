Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012060.outbound.protection.outlook.com [52.101.71.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B4253F17
	for <xenomai@lists.linux.dev>; Tue,  4 Mar 2025 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098793; cv=fail; b=qq+NquKam7VJdJewdpRD8h4srZUjmtIKFK9wQcPlXBt3oHULI1IJVn4F+CbJFSqd3d5HJWB/yZPtuQl0Uq+7hMSH0t5VN6SetxJCG2m7KOUi50on8Cy4cOX3uv0838MY7eYld1jd0tYvoSNDg7nN8sYVIdk3HS/4NQLG0wqPqnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098793; c=relaxed/simple;
	bh=slrvSTwaxE3w/MEH9CUITWgF2L4FD9Qgo+4HTQ57DKA=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=M0P5d0e9qWX+GeWIzaFCT9mmX3XOnbUnnK2LBsGk8WxRQ+y1JRKgfT2tFjdSbERu21h+T8H6s7ACyjK1vfkJZ6xbYEBCJFsjXzHnOO6cOx7oOA46b0bBRvgaEnroNMweVNxHEVzeltv1wN2ZryyOXOsECFAAZUPjwXn6EzL3e9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dqlH8Kcf; arc=fail smtp.client-ip=52.101.71.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dqlH8Kcf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6BvhDF9tgsLDnepSUKWK4IW5zOPdidC4TuSGPcbHfqG1IaYWz4dkKyjp/nQlxK480yxsJzpZ5MUihTtkAnw1dFMVqVEK+xzkAS3znFa7WN5crrQMPayMayJi0yXhBE4eG7UZKrLTgi4AMvQayMPqoQHAYuwCVjbhjf7sJkZp+TmlpdtIaf17esENkyN4pkCsUX4krAvlhnBWE1hvzuR83+VuRLMzYKIj17QSl7UgJ0Ye0P/7K591UxP7youe/QAWOtqmW4I5u14ikgAh9awJZG+CFZ65+GgScWnJFfZ1a7p1q+lxLEaVlTvYMjQbPCLnARJuYjQ+6Mv4r9I5sHXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c82hK/Xijrc4ay8IjKkAySR+s1LjCjaes9dsOzvT1JU=;
 b=BzB/qMu6YaG+ptZmugm79rphq/P/myKPAL08Z/6/KpoRuPpoIU55772w0OiBPJq0VWqT0WWgYtWTY7+L/V1HysQL0e/JsYSExEqKjNWJciuHy/safa2Qbn1HYGja6ZWlbb1SLN8iNun2Kz1hjsGC8AJbk3S4eW+SR3F5QwAsbkeuDbria14K3F4YD8WXAU6ZzePiuad5pYgEvvnQHav7rEWpkUOAuJX0eUOBBpA+EUADrLBtqN2UncR5L6oRLRvCW7kEQVd6hPz+c8yugWsZgSHCHVfDGiw6jsfrjNHHZBll0EpX5sC9msoUum4lQ0VjSZ1+Gv6WYLx/iRzQM6GA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c82hK/Xijrc4ay8IjKkAySR+s1LjCjaes9dsOzvT1JU=;
 b=dqlH8KcfRabICBTUHK7w9oYRiMkCu0SPCHNFRH/BzoBlkgyYgXzrgdBzl/z9va4alXyLqW9x+yzMviy01OadZK3cGriIn9F36cux8DaWcvFYPGCnMUwKdyOriStnQHBzPhHmDq89K8Ufjd4bYAK5dwClHFeR9L1RWI35SDru3CmmQmg6UFXrNwY5k8Sba57P0BPK+4uP1gLeV6A3xBaJPAVNAKzIRTUUKjRnAC0PHtRvk9La/kWCfs63FGFrmB0ZvL3iufkSkXHsUpp11L8J6ZdhlNG+F6ag44hUGiqMNp9eb1l9SDGz3SHzLdnpHOOqTsH+P0n7eA+XoWCvc3KM3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 14:33:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 14:33:07 +0000
Message-ID: <92300bd0-456f-4b11-93ef-5fb76be02edd@siemens.com>
Date: Tue, 4 Mar 2025 15:33:06 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] kernel/cobalt/posix: Stop supporting timeout parameter in
 recvmmsg
Content-Language: en-US
Cc: Philippe Gerum <rpm@xenomai.org>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: c62b2e19-bff4-4d93-73dd-08dd5b297b17
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0Nmb3JBT0VKSHkva0hwdGRqT3BaTXF2Yy9zQWNHbFpVR2NSUVUzdWNxY2hl?=
 =?utf-8?B?OUM1MzlydlB6WmpGSnB4bFZGZTNueExGbUhWZW5FYTZxdmN0M0pzWWk5eVVY?=
 =?utf-8?B?TFNMRWNkbW1oZm1NTWZnbGx2Y1R0Ly9rTGhrWlRtWXlOSkU2TWhpOXhRTGNJ?=
 =?utf-8?B?a3RIUUdoTFNkbWZ6V0tKdkxybUthY0tFOEZDNGhkNzBGdHF6UFRmUnUzNWJU?=
 =?utf-8?B?VjN0ekdSMk9MQ2cycVl3STAxS2liL0RGdDJJdzdYUUZuVnl4ZXJvQmRNNFFQ?=
 =?utf-8?B?S2pHaXZyeGtsWHN0U3VhQjY4cmJZaWFFTyt2WVd2SFFWcEZuc1hlbXV0cTl2?=
 =?utf-8?B?am5HSE0wNk1MdEhvZXowYUVSaGN2UHBZQTVaVis3ajZWcEZJTVYwYWlvb1hp?=
 =?utf-8?B?OHUycHNzYzlnZU5LRjlieHpFajk4aTk1WE9UY2dtRkhnb1ZVSWM0dWdFMm5j?=
 =?utf-8?B?cXhxK0prdnJqQWYzbHlmWjAzVWJDUVRuN2dQTEVsM2xRaTNtMFRLaGFpOW9i?=
 =?utf-8?B?eFBCMWZhTFRtUGFBM1Y2dEhWdnJXV09NTzBPa1NYV0JwMjJsRlRUK1hRSUlz?=
 =?utf-8?B?b1VodVQ5Y3doZ1IyWXd0YWlhcTRBQUJ3dG43L0hmWHR6UHJBRGswdmluV0Jy?=
 =?utf-8?B?dkU4UlVWem5aK0RoeE8wQ29VSTNCM2ZZbjdHbllFYzc2d0VXSkhnYjNjbkI3?=
 =?utf-8?B?aGR5NlJjS3EwdjZVOFp4akJzTkNDVU1GbFBwNEpOWHZTcEJvU2VweUh5YTV0?=
 =?utf-8?B?dXJiNGdRaGE3RE5aYVBOQk5KYTN1L1ZyT2dsS05vV0xoZk9idWFBOS9ZOWhR?=
 =?utf-8?B?UVIxdGN0aUpnUDZ6bXgwRW9heWE1N2N3YklhUWdXUXcxYzZsc2JyOHkwVTBu?=
 =?utf-8?B?MU1FZEY3aEx0SGlOZEozTHR5S21BeVlFUmI1MTFPSzZZNTBEVnRkYUdYRjBr?=
 =?utf-8?B?SHJNMjNwZ3NzNEFNNTRnWDV2cENUZU1CbjBFZzQxcWx2bU1BOFdVbHU2a2F1?=
 =?utf-8?B?QU5Md1RNbHNob2lzNG0vQWdyNHhYcjlkaytDOEJuUUlTcGVGUmxrRmx4dFNq?=
 =?utf-8?B?MFlyajZCSk5wY09uQk1IcHNXcmsvWWd0WWQ2ZU50VDJBMExFbGZ1WElwdUVS?=
 =?utf-8?B?cFJ5eDljNGdmTjFiTlNuM1YzK0JZTFVFVjdjUEFMUzZ1Rkp4Q09uRitTSGg5?=
 =?utf-8?B?SEtnbmFMQVh3enR0MU40WWJ3VGk3dm13b3Z4S0NxYWNNQy9yZ0NBeXI5eEd0?=
 =?utf-8?B?Znk1cjZqQWlkRnF4bXA4ZEx4OG5KdHBiRktrYkZ0cllJY3RGY2xDR3BqcXNm?=
 =?utf-8?B?NG5TV2VFNloxUWphNTVtS00yelFSWHNrL0tibVEyelRpK1lMTHIvbXAwR3pU?=
 =?utf-8?B?MXEzeG9FMVc1eTU1aXlBVlpUbGU5dTVmNUcyVStkcno3c1RzMnlOQUJVVFJj?=
 =?utf-8?B?RXNpWUJ2MjhZMm1MUmxlRk1SaldmY3EzYWl2K3VTaVVHcTZSY0RrcC9XYTJ2?=
 =?utf-8?B?bzRXbjNxNS9ZTzFCZnlKa245a0FOcmxrU2Zqbk1wbngxTzJBSXQxTUZIU3Js?=
 =?utf-8?B?dVdWaTMrQWVCOFRwTjZqVG4rNnlmQVBMMm9tdzB0ckEzaFY4L0htb0cxMWtl?=
 =?utf-8?B?WlZJZitJWTM3b0JmcmZIQjEwMmhkWHUvN2t6VHcxNmVnRUZORG9jZFZtTm9o?=
 =?utf-8?B?eHZuaDJ4Y2lCNHVTWXNyN0xQdkh1ZVdZZi8vVWZrMk9vK0VIY092Z2JmbVRZ?=
 =?utf-8?B?czFBQWxQU3EzUjJNaWpJQktCaFRpTVkyZ1gyemJHQ0xLUXppNG93Z0xzMGx0?=
 =?utf-8?B?MnE3UWRLdlhPOTdybmdBdXNQYW9sMG5mRWtuTE1ubEhJcjNEcTBFdzBxZnZD?=
 =?utf-8?Q?nMBgGu9XlQJ/M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGM3QUFOSm14OEFVNFdjZThxakVxUS91VkRlNURmcVppRFNHS1RNdEtoS3lB?=
 =?utf-8?B?VUJGcFNvMFBBeWcwL0xtOTdWaElPdFZLMW5tUUJNTDNPbHpCdkJNRFZWQ3Y0?=
 =?utf-8?B?bjk1d0Y4VExCU0l4UndUVnZQTktQWHVVczg1VFI0WnpPaGZQZDlKVjZMSytN?=
 =?utf-8?B?VVpva01WVldLOXRPZHVSQ05rUGJPZTRsM2VqTHh5cVVzRXpBU29HUmdXbHpv?=
 =?utf-8?B?Qnc0RXFsNlNwbTBVWVFVelczVnFIMTFuRjdISjRIVEFkcEJoODMwdEdvTVFF?=
 =?utf-8?B?Z0pqN2U1YmxXSE44UDBidXp0Z0wvS3ZnYXdGLzZJSmdyS1JxWi9GQ3hPYWZW?=
 =?utf-8?B?RXl0QTdyYmQ4d3IrTlUwWEV3MzZpQzQ5R3JHRHJmRG85cldGMlNJQUI0TjBr?=
 =?utf-8?B?ZGZIU1FrTWZVazFwcTIyVWJ6a25ybS9nOG5pWGsyaGlvZ0NnQ3d4NEVTS010?=
 =?utf-8?B?TUlON0VUZS9Ha3FMZVlBcERlR092OHB2ZmFuNmliSU5RMTVXOHdHaGhZM2FE?=
 =?utf-8?B?WFhjc3A4eDdpb3lDNjN1R2JxM2hXcHp3cTVNKzBnSWMrdndJcHZmQ1BnMmNT?=
 =?utf-8?B?dTQ2ZXpZSWNncUkyZ0RkTWx1c1YweTZObHFyS1hzVkhaTjc2RVZEZEh2OE4y?=
 =?utf-8?B?Qkh5bk5aTHh3QnppRTdpQnJLeTJGN0Vkd2FLTzVjb3FMZ1JtYk1PeStzTFZY?=
 =?utf-8?B?ckZ3STdRSHhnM3Erc1E2cTFzMWgvL0kxM3VPaFdmclRRTk5GcjBVYzFyOUpG?=
 =?utf-8?B?TDROaTlLaitKZVNwdnZaMjNGeWovY3lhN2U0OHFQQ0MwSU5WaUR3TE5MZ2E3?=
 =?utf-8?B?bHU0RkV1UERKT2s0V1daZFlyTnQ5UDEyQ1JPQW5NRGNtcVZCL3UwajIvU0tv?=
 =?utf-8?B?RXhSTTFoRDRWcVU0NTRYcDMrUW10YXRFTE9lNFJoTXpxK3FXYzhKOHFIMlZZ?=
 =?utf-8?B?Vmc4TjJ3S29FOFlWME84WHdPQVBuQ3BRM0xDRGZtdDYxN0R3ZmhIYjcrUGNW?=
 =?utf-8?B?ZEdkanhteTNTKzIwWWdWYWN1TGxaYWd0WDBCcHRtVE5GREZ6UVNmMDVhTmEz?=
 =?utf-8?B?YlhtYUZHNjhncnhTZWlzdC90VzdYbUVKWmJJYktnRzJTU3hJdmZZRi9EY09v?=
 =?utf-8?B?eWxvNFEwc2liWmgrV2trVTMxaGFNcGNrQ2tLZDdZamw4OXY2SWlnT2d6Zk9V?=
 =?utf-8?B?UlhWYWhsOUJmcGxaaFBpNHFuaStDeVMxSDVIZFF6dUdzNlF5Yk1wb1lhZzlY?=
 =?utf-8?B?alkwWGNrcnZnaEpFNW1uQ3FXTm5tV1dMVFJNNXk0OFQ5ZHpxWDhYc3p0UTIr?=
 =?utf-8?B?Mm9kNHlFVkkrY25IemZSUkE3UUtzWXlJZVJrMC9Rck5tSFA5U0M1RVg3OHA3?=
 =?utf-8?B?TkFoTFhmbStqVERYbFROR2VQRk5Vb0kvSkZOVkQ2YStIUlZweURJZDkzMlh3?=
 =?utf-8?B?QlViTVprd0RjcE5sb1E0QkVvSG5PNTZ2VWlheXFXcUVYRittVk9GVmduT1dV?=
 =?utf-8?B?dnl0ZWtRT0VjcHVqUm1vRUcyb2g0MlF2MkZiYzM5ZlR4bkRNdlNXS0l2TUV4?=
 =?utf-8?B?ZEl2TkIvcnlxRkE5elVFUTJLazZwZkMvWFJsczludmkrc0lhblg2amJ4SlhT?=
 =?utf-8?B?RmRubHlxdVBGamZaSW1DRGhpMXdwWFBSNGlYVGRPckwxWXh0TjY1Ykk5TWRU?=
 =?utf-8?B?bytwN0gzdGc1KzBGRmVabWwzbWJjZ1lkSEVzM2hlc0dZZ3RhN1pSUWQvcHZr?=
 =?utf-8?B?M0lwQSszN0Y5dExoYVFFV0gyZnVtU2RGWkRvd21TYTVuTTlsZzlWRWNMbDVV?=
 =?utf-8?B?WGE3b09nWDBDOXFqSDY4ZTBCVjZoSEJIV2NQaHJ2MmYvT2FUODIxVWd2Rk9R?=
 =?utf-8?B?c3EvRHlkL25zdVlQaGxqT1JFRkJRSmxhOVVWWStSMG1uUHo0Rk93MnV5OGRh?=
 =?utf-8?B?eGJCb3hxUEo2M1g1cFlXdkxhdnJwL0krZmgwVnA2MXNYdDNRblRnR05hRUxZ?=
 =?utf-8?B?aTdkbjJRd3BzRGxTcGh0eCt2blozZG13NUNCVS94MlQxU3REdEtGKzZ2anRP?=
 =?utf-8?B?Rms1RkJsdWVPUkR6WkkyNHBQU0J6ZGhWYlZQMlBUK0dpdXVRUXJXSHlkdzFr?=
 =?utf-8?B?NUpIUGtBR1ExU3ZLSjV3Q0R0UkJXSko1Z3g3Q3gxcDJOWWhCV2ZkNDE3alZK?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62b2e19-bff4-4d93-73dd-08dd5b297b17
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 14:33:07.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzR/NWiKpzXJDcvlFYX4C1iZOlDLjZxxIll3l5+EV+Tzq/X14Ysh+anvLCPDmI4Lr19E8fCW0BwI/fD4j7/sGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5445

From: Jan Kiszka <jan.kiszka@siemens.com>

It turned out that trying to put a timer-based timeout on top of the
loop that calls recvmsg_rt multiple times is broken in an almost
unfixable way.

First of all, timing out by setting XNTIMEO and resuming the waiter
(=caller of recvmmsg) races with entering and leaving the blocking
state inside the respective driver. When the timer fires while the
thread is not inside xnthread_suspend, the condition is lost, and we may
even enter infinite blocking later on. This was observed in qemu setups
with overloaded hosts, but it could also happen in proper deployment if
the caller of recvmmsg is interrupted before suspending.

Second, the driver has no idea about the outer timeout and will
therefore happily use its own per-socket timeout in addition when set.
That can lead to unexpected results for the caller. Unfortunately, there
is no standard way in RTDM to control the socket timeout, not to speak
of an efficient one.

Finally, it would need an interface change in RTDM to collaborate with
drivers for implementing the out timeout without races and without
interference by the socket timeout. This appears not worth the effort.

Given that the socket timeout can still be used in place of the recvmmsg
timeout, though not with identical semantics, we avoid complex
refactoring in favor of discontinuing the timeout feature. Programs that
continue to pass non-NULL timeout values will receive an error from now
on.

As this obsoletes (and breaks) functional testing of the timeout via
recvmmsg64, drop the related test case.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This is for next right now. I still haven't made up my mind how to deal 
best with stable (3.1..3.3). Removing the feature would break the ABI, 
but keeping it allows people to run into the race, even if only rarely. 
An option could be to disable the feature by default in Kconfig, 
allowing users to re-enable it while (hopefully) reading the related 
warning.

 include/cobalt/kernel/rtdm/fd.h        |   3 +-
 kernel/cobalt/posix/io.c               |   8 +-
 kernel/cobalt/posix/syscall32.c        |   9 +-
 kernel/cobalt/rtdm/fd.c                |  66 ++-----------
 testsuite/smokey/y2038/syscall-tests.c | 129 -------------------------
 5 files changed, 11 insertions(+), 204 deletions(-)

diff --git a/include/cobalt/kernel/rtdm/fd.h b/include/cobalt/kernel/rtdm/fd.h
index 176c67e223..5226979286 100644
--- a/include/cobalt/kernel/rtdm/fd.h
+++ b/include/cobalt/kernel/rtdm/fd.h
@@ -381,8 +381,7 @@ ssize_t rtdm_fd_recvmsg(int ufd, struct user_msghdr *msg, int flags);
 int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		       unsigned int flags, void __user *u_timeout,
 		       int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
-		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg),
-		       int (*get_timespec)(struct timespec64 *ts, const void __user *u_ts));
+		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg));
 
 int __rtdm_fd_recvmmsg64(int ufd, void __user *u_msgvec, unsigned int vlen,
 			 unsigned int flags, void __user *u_timeout,
diff --git a/kernel/cobalt/posix/io.c b/kernel/cobalt/posix/io.c
index 4e20ca19d6..3a14575ad4 100644
--- a/kernel/cobalt/posix/io.c
+++ b/kernel/cobalt/posix/io.c
@@ -95,12 +95,6 @@ COBALT_SYSCALL(recvmsg, handover,
 	return cobalt_copy_to_user(umsg, &m, sizeof(*umsg)) ?: ret;
 }
 
-static int get_timespec(struct timespec64 *ts,
-			const void __user *u_ts)
-{
-	return cobalt_get_old_timespec(ts, u_ts);
-}
-
 static int get_mmsg(struct mmsghdr *mmsg, void __user *u_mmsg)
 {
 	return cobalt_copy_from_user(mmsg, u_mmsg, sizeof(*mmsg));
@@ -119,7 +113,7 @@ COBALT_SYSCALL(recvmmsg, primary,
 		unsigned int flags, struct __kernel_old_timespec __user *u_timeout))
 {
 	return __rtdm_fd_recvmmsg(fd, u_msgvec, vlen, flags, u_timeout,
-				  get_mmsg, put_mmsg, get_timespec);
+				  get_mmsg, put_mmsg);
 }
 
 COBALT_SYSCALL(recvmmsg64, primary,
diff --git a/kernel/cobalt/posix/syscall32.c b/kernel/cobalt/posix/syscall32.c
index 484f059844..bddc29e7c4 100644
--- a/kernel/cobalt/posix/syscall32.c
+++ b/kernel/cobalt/posix/syscall32.c
@@ -552,12 +552,6 @@ COBALT_SYSCALL32emu(recvmsg, handover,
 	return sys32_put_msghdr(umsg, &m) ?: ret;
 }
 
-static int get_timespec32(struct timespec64 *ts,
-			  const void __user *u_ts)
-{
-	return sys32_get_timespec(ts, u_ts);
-}
-
 static int get_mmsg32(struct mmsghdr *mmsg, void __user *u_mmsg)
 {
 	return sys32_get_mmsghdr(mmsg, u_mmsg);
@@ -576,8 +570,7 @@ COBALT_SYSCALL32emu(recvmmsg, primary,
 		unsigned int flags, struct old_timespec32 *u_timeout))
 {
 	return __rtdm_fd_recvmmsg(ufd, u_msgvec, vlen, flags, u_timeout,
-				  get_mmsg32, put_mmsg32,
-				  get_timespec32);
+				  get_mmsg32, put_mmsg32);
 }
 
 COBALT_SYSCALL32emu(recvmmsg64, primary,
diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index d5813a16c2..5a771cc455 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -641,36 +641,16 @@ out:
 }
 EXPORT_SYMBOL_GPL(rtdm_fd_recvmsg);
 
-struct cobalt_recvmmsg_timer {
-	struct xntimer timer;
-	struct xnthread *waiter;
-};
-
-static void recvmmsg_timeout_handler(struct xntimer *timer)
-{
-	struct cobalt_recvmmsg_timer *rq;
-
-	rq = container_of(timer, struct cobalt_recvmmsg_timer, timer);
-	xnthread_set_info(rq->waiter, XNTIMEO);
-	xnthread_resume(rq->waiter, XNDELAY);
-}
-
 int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		       unsigned int flags, void __user *u_timeout,
 		       int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
-		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg),
-		       int (*get_timespec)(struct timespec64 *ts, const void __user *u_ts))
+		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg))
 {
-	struct cobalt_recvmmsg_timer rq;
-	xntmode_t tmode = XN_RELATIVE;
-	struct timespec64 ts = { 0 };
 	int ret = 0, datagrams = 0;
-	xnticks_t timeout = 0;
 	struct mmsghdr mmsg;
 	struct rtdm_fd *fd;
 	void __user *u_p;
 	ssize_t len;
-	spl_t s;
 
 	fd = rtdm_fd_get(ufd, 0);
 	if (IS_ERR(fd)) {
@@ -683,30 +663,12 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 	trace_cobalt_fd_recvmmsg(current, fd, ufd, flags);
 
 	if (u_timeout) {
-		ret = get_timespec(&ts, u_timeout);
-		if (ret)
-			goto fail;
-
-		if (!timespec64_valid(&ts)) {
-			ret = -EINVAL;
-			goto fail;
-		}
-
-		tmode = XN_ABSOLUTE;
-		timeout = ts2ns(&ts);
-		if (timeout == 0)
-			flags |= MSG_DONTWAIT;
-		else {
-			timeout += xnclock_read_monotonic(&nkclock);
-			rq.waiter = xnthread_current();
-			xntimer_init(&rq.timer, &nkclock,
-				     recvmmsg_timeout_handler,
-				     NULL, XNTIMER_IGRAVITY);
-			xnlock_get_irqsave(&nklock, s);
-			ret = xntimer_start(&rq.timer, timeout,
-					    XN_INFINITE, tmode);
-			xnlock_put_irqrestore(&nklock, s);
-		}
+		/*
+		 * The timeout parameter is not supported.
+		 * Use recvmsg timeouts instead.
+		 */
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	if (fd->oflags & O_NONBLOCK)
@@ -733,12 +695,6 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 			flags |= MSG_DONTWAIT;
 	}
 
-	if (timeout) {
-		xnlock_get_irqsave(&nklock, s);
-		xntimer_destroy(&rq.timer);
-		xnlock_put_irqrestore(&nklock, s);
-	}
-
 fail:
 	rtdm_fd_put(fd);
 
@@ -751,12 +707,6 @@ out:
 	return ret;
 }
 
-static inline int __rtdm_fetch_timeout64(struct timespec64 *ts,
-					 const void __user *u_ts)
-{
-	return u_ts == NULL ? -EFAULT : cobalt_get_timespec64(ts, u_ts);
-}
-
 int __rtdm_fd_recvmmsg64(int ufd, void __user *u_msgvec, unsigned int vlen,
 			 unsigned int flags, void __user *u_timeout,
 			 int (*get_mmsg)(struct mmsghdr *mmsg,
@@ -765,7 +715,7 @@ int __rtdm_fd_recvmmsg64(int ufd, void __user *u_msgvec, unsigned int vlen,
 					 const struct mmsghdr *mmsg))
 {
 	return __rtdm_fd_recvmmsg(ufd, u_msgvec, vlen, flags, u_timeout,
-				  get_mmsg, put_mmsg, __rtdm_fetch_timeout64);
+				  get_mmsg, put_mmsg);
 }
 
 
diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index b614d3ba07..237549b7aa 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -970,131 +970,6 @@ static int test_sc_cobalt_event_wait64(void)
 	return 0;
 }
 
-static int test_sc_cobalt_recvmmsg64(void)
-{
-	int sc_nr = sc_cobalt_recvmmsg64;
-	struct rtipc_port_label plabel;
-	struct xn_timespec64 t1, t2;
-	struct sockaddr_ipc saddr;
-	struct timespec ts_nat;
-	int ret = 0;
-	long data;
-	int sock;
-
-	struct iovec iov = {
-		.iov_base = &data,
-		.iov_len = sizeof(data),
-	};
-	struct msghdr msg = {
-		.msg_name = NULL,
-		.msg_namelen = 0,
-		.msg_iov = &iov,
-		.msg_iovlen = 1,
-		.msg_control = NULL,
-		.msg_controllen = 0,
-	};
-
-	sock = smokey_check_errno(socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP));
-	if (sock == -EAFNOSUPPORT) {
-		smokey_note("recvmmsg64: skipped. (no kernel support)");
-		return 0;
-	}
-	if (sock < 0)
-		return sock;
-
-	strcpy(plabel.label, "y2038:recvmmsg64");
-	ret = smokey_check_errno(setsockopt(sock, SOL_XDDP, XDDP_LABEL, &plabel,
-					    sizeof(plabel)));
-	if (ret)
-		goto out;
-
-	memset(&saddr, 0, sizeof(saddr));
-	saddr.sipc_family = AF_RTIPC;
-	saddr.sipc_port = -1;
-	ret = smokey_check_errno(bind(sock, (struct sockaddr *)&saddr,
-				      sizeof(saddr)));
-	if (ret)
-		goto out;
-
-	/* Make sure we don't crash because of NULL pointers */
-	ret = XENOMAI_SYSCALL5(sc_nr, NULL, NULL, NULL, NULL, NULL);
-	if (ret == -ENOSYS) {
-		smokey_note("recvmmsg64: skipped. (no kernel support)");
-		goto out; // Not implemented, nothing to test, success
-	}
-	if (!smokey_assert(ret == -EADV)) {
-		ret = ret ? ret : -EINVAL;
-		goto out;
-	}
-
-	/* Providing an invalid address has to deliver EFAULT */
-	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0,
-			       (void *)0xdeadbeefUL);
-	if (!smokey_assert(ret == -EFAULT)) {
-		ret = ret ? ret : -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * providing an invalid timeout has to deliver EINVAL
-	 */
-	t1.tv_sec = -1;
-	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
-	if (!smokey_assert(ret == -EINVAL)) {
-		ret = ret ? ret : -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * providing a zero timeout,
-	 * should come back immediately with EWOULDBLOCK
-	 */
-	t1.tv_sec = 0;
-	t1.tv_nsec = 0;
-	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
-	if (!smokey_assert(ret == -EWOULDBLOCK)) {
-		ret = ret ? ret : -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * Providing a valid timeout, waiting for it to time out and check
-	 * that we didn't come back to early.
-	 */
-	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
-	if (ret)
-		goto out;
-
-	t1.tv_sec = 0;
-	t1.tv_nsec = 500000;
-
-	ret = XENOMAI_SYSCALL5(sc_nr, sock, &msg, sizeof(msg), 0, &t1);
-	if (!smokey_assert(ret == -ETIMEDOUT)) {
-		ret = ret ? ret : -EINVAL;
-		goto out;
-	}
-
-	t1.tv_sec = ts_nat.tv_sec;
-	t1.tv_nsec = ts_nat.tv_nsec;
-
-	ret = smokey_check_errno(clock_gettime(CLOCK_MONOTONIC, &ts_nat));
-	if (ret)
-		goto out;
-
-	t2.tv_sec = ts_nat.tv_sec;
-	t2.tv_nsec = ts_nat.tv_nsec;
-
-	if (ts_less(&t2, &t1))
-		smokey_warning("recvmmsg64 returned to early!\n"
-			       "Expected wakeup at: %lld sec %lld nsec\n"
-			       "Back at           : %lld sec %lld nsec\n",
-			       t1.tv_sec, t1.tv_nsec, t2.tv_sec, t2.tv_nsec);
-
-out:
-	close(sock);
-	return ret;
-}
-
 static int test_sc_cobalt_cond_wait_prologue64(void)
 {
 	int sc_nr = sc_cobalt_cond_wait_prologue64;
@@ -1724,10 +1599,6 @@ static int run_y2038(struct smokey_test *t, int argc, char *const argv[])
 	if (ret)
 		return ret;
 
-	ret = test_sc_cobalt_recvmmsg64();
-	if (ret)
-		return ret;
-
 	ret = test_sc_cobalt_cond_wait_prologue64();
 	if (ret)
 		return ret;
-- 
2.43.0
