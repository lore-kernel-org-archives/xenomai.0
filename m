Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F1149E1B
	for <xenomai@lists.linux.dev>; Wed,  7 Aug 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066160; cv=fail; b=A9E5IVjyVNs30u8mQRTatFZCLOCc1BQF9NKJ8RP0wPYhkkJA7wMHPEmy8f9SBXit/Bn3XWR5fRm1Aj8Ay+JS5EiI7sBm3helg+YKr9IT6gKsJi+CHb0GTGv2nQQLx3HVy2YAi4LonKBwrEjh0tGIHl84yBszercWJIrl2Gbt+Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066160; c=relaxed/simple;
	bh=WkY6XY1mFfWUzUEERDjK3RAICR+s97VSTyN4By9sJR0=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=NhD9fzT+OE+8U8DbBtIOwyFXsd6ribnhWc0bf6iL9cvm88YsisV6oVlfxCRah8DzemPZKXj06HCjSTze76/3PiUpxJSSHdH6Tz/3tiqHhjxkHsd1Zdnx6ls0enARCHGZYXwIj73frFW2zLYrWpmiPNT3R6ta1zXbva18hDNFVh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ajKBx6Vn; arc=fail smtp.client-ip=40.107.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ajKBx6Vn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODKy4bfrnJIMn0CT+F9iuOD3kxELf66B/6NAC9z8kigEFwKQMCf5xo0FS9ydvhQDK4iP/rHcGJvvtP5tTXrXF3Doc+5x3pkWjMAQtPqli69jn7L6LUBWhBR4SBTIQAfvclVnMAJIAhQQkwn0NLQOac5G7tha00g+T+tsZvXZARnXMyxT2jLJ9qz54pciIw6KrvdawLDhKIUJ5n6jmW1uXRL1HklSUSDS028b8voO5qsRKMbC9859raN8b8UFuJaDc/kxQ2jQtqd852Ruc0bg0UVAu4C2OfO2cIzUWo18NzdLwVASIMziN8DG3iQIYWglWBNRvPMNv20M4nsRQlNwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glc7c9W1PElnh7TcmJOCPvUjyRpAOVP34HD5eO6EZaY=;
 b=NVcIK/ynCk5MuC6j5Vc7cG7dYNIjGb/loC2qMDZl8IX/PaUO1psm+dM7pr/XZoAIJDZClzuCEVWgPeZEWrm1YoKYiGmH2xq/ZgdxpBZlpiRVSQenCUwHQJxaQOatKZUP78mlwLJi35cxiEhoataJEDximvZnq2fouHsCtJ6H7oxk8CbkDVvZvDo7vcYs43doZkr6sfFrw+KSEWdz/JRiQVvN+c/gxx8uwMegYSJ6PHidxYahslLA31f4X033J/az/BVd4vEEUHYQijBM+lr+S/dBEgUmT6rd8s77E3ltksn7+/zIEveAIKSjSs3fqPTWDB/s02WKLO0hPwSyOGW+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glc7c9W1PElnh7TcmJOCPvUjyRpAOVP34HD5eO6EZaY=;
 b=ajKBx6Vn1qzANA/uXoSgfXIcZkxpbIW9MyG2Rfs9j+gLU1SCME7aZ8puAMWj3yP+M4hkaR0+2FtnO0QoWwYAumNpi0H5QrjXbxE+aqtB5Wi+6QFEU3FTiv3BVrZdx/u8wOJrOd4SWjMJ33112TdZXeY0WQytCCsOzNJMTQjMUiEntdI6h+IACVF8kprWy1TjyvaegD1IBb7hzkcdwQjkGHNY+stOYZFuYI89LfH6EhBRAANIvMcZyuWR+HLgZah3OpzZ4pdUuV+YcavnBOlwiaKpJ8hRFv9z+vzkpr6WAvpCB0Wx/kEH7zTsCJoZw5wgdPI2Y37Z6beRGg8xMzvxqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:110::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 21:29:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 21:29:11 +0000
Message-ID: <93361bab-ab03-4fe0-8159-74ec81721e07@siemens.com>
Date: Wed, 7 Aug 2024 23:29:11 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] net/drivers/igb: Avoid MIN as macro name
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a24028d-ef89-488d-c150-08dcb727fa7e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXZ0Q1RVMnRnNU9tVjVoNVFpWkVIYTJ5N3RWa2ozb28rbVpYUFRHSjcvRWRx?=
 =?utf-8?B?TDY3Nnpndm5vUnBoTWw0aDhNL2hJYTA5bFcycHpiT1VBUkhSRjFxNllkTkRU?=
 =?utf-8?B?VFl1eW1SUkZqR1pxUnlUVE41YWh2eHpia2J4Y1RXaHBzN1lpQVJGVGNYcDhi?=
 =?utf-8?B?ZERQNWYveUxIbzlxcXJHd2JNc24weEtpYjMva3JBdm9vQmFsWlNiM0lwcDlC?=
 =?utf-8?B?Wm5Gc0VEUFlCUDViQkh6cE1rZVRMU2hveCtUVzlVdnhndVI5c0JQb1dHRkh4?=
 =?utf-8?B?MnB2dXlQdElzUnFwckRqZDEyc2NPdVJGcmRJOVpCdXY4N2lVSGNFL2hQMlBy?=
 =?utf-8?B?bWxvWFcrdHVpeEVpQ1ZmN1JudG9aTUlyRFd4cTM5aUxyOTl6ZUZQTGhsSmtS?=
 =?utf-8?B?MklYZElTQ3I2Z1hQQkQ5cG4vdnBVMVp3bURoM1hqR0tyT0RrQUhYNkl5dDQz?=
 =?utf-8?B?KzZxSk1NY1NoYnB5bFdBMmhVL25mRzYxY2pBWUZVQ0hWbUUwMG8rck1xMW5G?=
 =?utf-8?B?TURwaTUrTzloaGxUdzVpMnVlSmcxaGZTWGI2RjVCcURBUFpqOHNCRGNnMXp0?=
 =?utf-8?B?UEYrZVlyeE5IQndVMVVyWHg1bC92emlxM3IzOVkwV0dpajcwdkFSQlkzMUM1?=
 =?utf-8?B?eTFrMnpYQS9NSXF2M0pGR0dWY1g5U3J3WmYzcnFwb010Ykd1ZHh3b1RwcGE5?=
 =?utf-8?B?V2lCM1lnYUo2YmlDeWhwOGUrTDNZY0J3TVdXZTRGQUUvYU5uaWNQWGF1NzNx?=
 =?utf-8?B?ektQZzVaSi9UTWd5ZkQ4UDVrd1VYZ05iSVQ1cDhZUSt3dkpRdW9oY2ZWcElZ?=
 =?utf-8?B?Q3duZWE2SS9scmh4QUdxZVhXOENTcXVQeWlhMzdkeDU5RzhRQ2Nkb1BrK1Bq?=
 =?utf-8?B?U1B1UWxDNk1yT1djWjlUS2lLajJoOFo5VGlVZFhObkVrVjZucWNMSHdsVU1X?=
 =?utf-8?B?MXZmSkpob0RqZFVsRElMVVkzMkJVQzlHUW10ZDNXUktDUFNzTW5pMG8zbisy?=
 =?utf-8?B?UzV3dXBxM3BTaDM3My8zeFc3bGVLK2NyQ0ttMU5nN2FYd3hQd1p6L2x4cDlL?=
 =?utf-8?B?ZVgybVFaWWdPMUJXQWtaL2JLcmdZSFViM3hDUk9DUnNKWEZoNjJYbUY4L3Q4?=
 =?utf-8?B?TWhZVXRjZkNkb0xxVU1DZWowUnMrUHhlM1M4RXZpUzlIYjNaTmVZY1p3V0tp?=
 =?utf-8?B?VWpoYXI1aTBaaEkwZ1ViQUREd1I2UG5BbW9ReEREMk9NQU1iSjhQYUJkWDc4?=
 =?utf-8?B?aWJTSXlTaFM2dVIvTEtOK2JnekJzYUFodC9PVEtPUnlJYmt4T29uTGdJWGdT?=
 =?utf-8?B?ZDhlT21iZlF2Tm91bjdXOXlpNzlxLzFsa1JEbk16U0JZMnhsckZSaXdkUTNG?=
 =?utf-8?B?RnVqMjArWDdaQjhGV2gwMXdwQTFqcUkxMS9BSWgxbGs2THhPdjY2blVmc1Zu?=
 =?utf-8?B?Vy9CbjJxcUtUZnpLbmlUY05MYUFWdUxDWTJLb0xCS3lYNFJIN3ErMStlcGlV?=
 =?utf-8?B?WU1MUmp6eGpoVll1Q1JaZ3lkV1NhRk1kaWxuVDFZUUJzaTA3WG40Zm1Pb2tY?=
 =?utf-8?B?cUtRalBOWWx3VUtRWmRISTBBV0Y0M1JLMXNYSDBTK0RzQVFhV2owbDZuQmZK?=
 =?utf-8?B?aitSQllON2RyK0cxZVVMOHptdHVOZlVWZlZtTFhUcmtyODZyRHhIODUwZUJn?=
 =?utf-8?B?YVpvT21haUxSNEJmRzZlMnI3Q0EvR0psZWNNZ0ZWZllKM1Z5OW1nYk5oMWlw?=
 =?utf-8?B?cW1hVGJ6R0VEcWpmaHJzancxanh1Z01LLzM4aTBNSzJtbWp1cGQyMm44UXBR?=
 =?utf-8?B?RW5EZ3FLYW9aQ0dYd0dIUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3FYVENtbVZCVVNvNllZak9SN1FHenFIQWVTWG53NDVqSUZCVGgxcXErQzdv?=
 =?utf-8?B?U2o1ZmhFU0xRRjMxN3Zac2Y2OTBscS8zSHZ6WGltV1BTUVR3VGxhVVUxZFIy?=
 =?utf-8?B?M3RGMUNoYjlYbnF2ZzEvamxXZ01TZmZXNVpmR3U4OU1PL0dsdXZqbENyM2lC?=
 =?utf-8?B?anRBbFhyK1ZxQnk5RVRVQ1grTXloOW1MQUN3aDhRVGUwb0tPQ0ZSbXVlNTZK?=
 =?utf-8?B?UWI0dms0UlZpRnJYbVEwc2R2YnQrenpqcjAvOXJnbkpEeDJaczJDQUdaa3d5?=
 =?utf-8?B?alBJWkNwZFBmOXpqSVVwTVJjdHAzWnZCT0E3ZUk2L0paY3ZMWDlBSjR0dExQ?=
 =?utf-8?B?eTgvU0p4VStJSVRxV0FxUnhxUzdCU2VJcVpMU1kxbXhFWDNtRWtSN1p4VnUv?=
 =?utf-8?B?NGhzcFJqU280THVtaFNpeVQvT29BRWFudjhFWk42TjRHbUZab01zUTJKaFdk?=
 =?utf-8?B?WUNMSENhbDFPRWhlSjFwOUM3MkljMzJIbzhoRG16NVNJVXVpMk5sVStZTFBx?=
 =?utf-8?B?VWcxbU1DSWkzNHhwL28zM2Y2YldVNFZZdW94VHhzcHc4aVFHKzZtOEg2YlBo?=
 =?utf-8?B?WmRKdzh0Ym5pQmNYOCtHb0hVUURoK0ZWc1k0UUh2bEFYWDRUaGt2eDkyTmJa?=
 =?utf-8?B?RW5jNVExNk9Yc1ZnY3IwMlZVSSthZzlSTWc5TjNpaGdaWHQ5NXppUkI3Zjc0?=
 =?utf-8?B?M3kwQ1dTU0pjc2kxNDNaMEh2a1J0eHNzV1dYdEllQlJoRVVIV1oxNmxpdEJm?=
 =?utf-8?B?akg4eEpUSTlON2RmNnZCQ2grMTBLKzhMR1VlSVNETFdBeG9OK2FFbDU2VEU1?=
 =?utf-8?B?T045OVZGVDh4YWhOVXhVMCtyL0FQay9jSGJLempkby80TzQ4ajMweE5mQWNP?=
 =?utf-8?B?Q2J1ajVaNERrd01RdnE4WGxVc1F2RHI1ckpscFdzakpuL2RPK1ZkbjdPbGZ4?=
 =?utf-8?B?WVY0NEw5MzNxN1cxMHE0c3lXRlRHWjNhaWcrS3ArSEtHWTJBM0s1NEgveG5l?=
 =?utf-8?B?SXRiWFU4TVk5YkhRUHBQTG5SQU5RcHlwNXMxcVV5eE41YjV2YXBJeFFyeERM?=
 =?utf-8?B?VUNZUjhVbHhEdFo0c0ZzMTBXMnVVM3ZWRDBiRHlSUTFJNERwRWIxOGlHSkI0?=
 =?utf-8?B?dW5UYlc4WjkxNkVJYWFkQXNlYVJSTFM3VkZnT0FCTmxaaVFRZ280UU0veXpo?=
 =?utf-8?B?YnYwQTFEVTltN2xrUFZkQS9RaUhEQktYOW5qcDh5bjk4ZGpBMFNhdGZoeDZD?=
 =?utf-8?B?bjFsbEQvaUVZYkxweWNWNEx3VnlGYm13QXgzRGNRYS9QRjM1cnl1RS9IVjVJ?=
 =?utf-8?B?TW1LZ2xDa2QzSFR2SVQrZkx4YkpuaE1uMHNkbkxPM0tkY0graTcwSGsydHc3?=
 =?utf-8?B?SXU3bDJmRWQreDRMclMwZWdac0trWVI1SHJJcjBSY0FHWlF0QlJyZlNKWE1C?=
 =?utf-8?B?UUVVcWlKdzlvQWlFN1JRMyttZ2NlRW4rNGM4TmgyMS85UjJFaUxZNG1MV3Nx?=
 =?utf-8?B?TlJiZHQ3M3BtZ3NCUkNYUDJscSsrT01SUHVTRWVWazZ4WlFKUndJcU43dVNv?=
 =?utf-8?B?RVA1R1hGVXl0U3NCdUx3cVJKVEZ1dm5RRnlSMzJmU1JsMkJUK3FITy93ODNs?=
 =?utf-8?B?M0NGMzY1WUQwSExvSnhQN3RKWkwwZ0xrU3hWSFpqTXhFVE43QWdIZUVxd3dy?=
 =?utf-8?B?ZzJzU2RpWEQ2V0QwMGxpOGZHUEFreWtNY0JlQTdEc1J4dWJRanJlbzVBMnZw?=
 =?utf-8?B?V2xHaitDQVZzaUZISzNETTdsQVdMdWpMWXNteWRFWVlVNzUvTXRKZExxZXVy?=
 =?utf-8?B?by9yQ0dsNFJQaCtmTjBiT1NxWlpNK3FJRzBRTFNBS0dEZHU0NWovY3NYNDVi?=
 =?utf-8?B?NWFZU0I5eXlBbFNKWkd2Q0ZoRmo4enFsTVlaTm9NS2pNTHNGL2JIcThOMGhF?=
 =?utf-8?B?MXFXbWNGcUpHNVpLTnU0NUo1ajYzUzFReWJWdXRzaGFzR29rYWNDOGhqUFd4?=
 =?utf-8?B?OXZPMUFDNklDRUd4NE5PM2Jtd0NhN1Y5TzR4aU8wNmIxNW9iVGpuakx6OFFz?=
 =?utf-8?B?WEMzOFpqMUo3eGVSd0NmZHY0SkhqZTEyLzZiVUllSFkyVXNkNVpJOWtlM3gz?=
 =?utf-8?Q?LVAuMX92g7YeoIBnG4AvB8jl8?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a24028d-ef89-488d-c150-08dcb727fa7e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 21:29:11.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpGI+dsNUaCh+tr/IVKTXnG2z049bdVb2+2VNeSccJDK3SarOCRsIa3bOd9/RGKoaMH5/IaLMVRKt9Xf6tnALw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8084

From: Jan Kiszka <jan.kiszka@siemens.com>

Used by the kernel since 6.11.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/igb/igb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 15a4e9591f..4474700bd3 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -121,10 +121,10 @@
 #undef IGB_FRAMES_SUPPORT
 #endif
 
-#define MAJ 5
-#define MIN 2
+#define MAJ_VER 5
+#define MIN_VER 2
 #define BUILD 18
-#define DRV_VERSION __stringify(MAJ) "." __stringify(MIN) "." \
+#define DRV_VERSION __stringify(MAJ_VER) "." __stringify(MIN_VER) "." \
 __stringify(BUILD) "-k"
 char igb_driver_name[] = "rt_igb";
 char igb_driver_version[] = DRV_VERSION;
-- 
2.43.0
