Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BB3FB7DC
	for <xenomai@lists.linux.dev>; Thu,  7 May 2026 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778163376; cv=fail; b=Md/TAIfIbL+tVG37bLCzfkUj2wpTqh00WGTSV329DoRkVuVVEPBR1zTeAJcdJSxABsKi/ke+/AXJbMjhDzQux7+7X5QsIfS7qMEO32BEZpMt+lrQNACuyPECmYg3zyli9T+j2qk6/rgvqgWKP365Xcb49o8bEn1ayzV7UtskVxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778163376; c=relaxed/simple;
	bh=Xk7CzXNAXBubGqoV8Mor7skBNJY411dS4oXTK2OB2/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZJPxUjxS4/4V5EOXdyfKH/vhCpdY4fQByWQvYsd+JRAoqIOKscfA1NsvVa563LjJkW31486OyXfuJUAo5igAY+GYuCKA9kNISsSlHgdQk44A3V9MjiWZ7K7NxpTKJhjzz959Rx4ORKXb1xliDiSUP2IQlxjjhZMsgSCNroR001k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XAPyABrD; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XAPyABrD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXio0hnafCvHJOh5ZLqCIv85DHoonvmEiUrTL6BEaCs6/vUfra1akufch/V4359doyh05//7NwTpqRUavnn0Hu3yqurbMHY7cZxEB9pJFHx9UAx06rbz0tyS3WElniGWdgPxaYUEDXwnIt5OK18GxAlOlGEoxYF2P6vhtLATpAgUPA072P7L2k4IVlNShmvzHBjEQXASO5wy3jEQxYVly1tRTz6woF2cVvAed/kG7yx41/HRvK7TrEyYFnpTya+M4w2r9jzxhBG/6D7QIiR8Kmdy2lKfV/C0fZkaRPhq7X9rwd0E1Krh0B7SGB9KvOAcZe55mElf8qcQ21sP/gl1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNCBLHow8/Wb4T7GaQ7a7VHAhYBxlIbt4mzQ2Lbwflg=;
 b=WMwvw9JhHY2DiM+/J3/ffcLjfRggfg0JtAWvZ2ULHu0Hln7xGcmIy4boxe8ekaAYVdIeREJe2mlFVpTK1LTpPgSiVzlCSeDBQvvy/iIkvnFIvR5rVwv1lLZ621HbaluyY3MpwkLxPU0v8lrCMTs1oYyrOF14w+/+8pByHWD8wwyxY8CinZQabLhCtUMgI2HQMegb7t1xXRYPeiUDs+AWP/XzPutia440Ba/6TMVsUglXbrj85mIWJOfYHP5njnmWuPCc3CVbtAfy3ZOJR6dkGGCAE4pK9sPmWJYKXiOFiPh9RVQH979PoniS6mS5elYTPiiCnw405ayxR6thA2eIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNCBLHow8/Wb4T7GaQ7a7VHAhYBxlIbt4mzQ2Lbwflg=;
 b=XAPyABrDR+nFbNRcx/absvzCCzTip+CiPqRv6+JHsnOMOM/vIf1JncVTdk8jHJ+nY3/XtMhL0fjJkbapbpDpzjCB06sBitAnVF3tlTRIO+74rHoRnHgQtqorc1CEVhROuQATMzm/0bfIctS0qpuG8K0SQi6qtaPF7a2ysMxwi7gCifqn2sjwSans+YeH34C89OO3NOQpPDIU50f1H4yBU0+k3lSXmt7b3M9CqVmpuR6uWfwHt0f677FPfzuVJUd2a3ek8K4XL4kIX8DdUCDeagvex1Fwh6s4iEzBTjbgahFpA7tEZ+ivJpHUtIOc8DX+2/IcfaHpqJFAWSPJal5//A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3809.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:173::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 14:16:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 14:16:11 +0000
Message-ID: <2961c9be-b80f-438e-95b6-a2339f14d738@siemens.com>
Date: Thu, 7 May 2026 16:16:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add build time guard to detect off_t mismatch
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@lists.linux.dev>
References: <20260507122357.2463483-1-richard@nod.at>
 <945cb32c-88ea-41fa-8223-f3d1e639e9d9@siemens.com>
 <1863085876.2350.1778157171370.JavaMail.zimbra@nod.at>
 <3997a44b-0ce4-46b1-a0a2-9ddbed951b5c@siemens.com>
 <955375516.2805.1778158548523.JavaMail.zimbra@nod.at>
 <84f6c3a9-b764-4774-b048-eb8e0c7fdc99@siemens.com>
 <472857942.3063.1778163004494.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <472857942.3063.1778163004494.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3809:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b1cc5e-db18-4934-5909-08deac4330d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4eCMCQnLM+R35+DlPSHe6IVL2Qeaarty5Gib9WIYKTIu1TAquAWM3kFD59H1MSLgsCTpucn9ahYy5mpziEkj6w2Y82Wtrvl3wVU/2s+rhvPglZRwXpCP4zQ6IY93rg94WbfJtwIK2yuW4fZi4ndpMZz3JRhNOHrgVeQJ+Vf1cbMP0LKmB0wm+9bxWC5+4kxDHq7vI2lL6ZaknDR0Ki63paulg1KaM97DmjHFwYp2KdPK03u41qgAuLBZyGX3/F8wz1qah/8kVoMF9aGMmMS5iPd+xj6PUdL58muqG6C9Omz+fRjScen8h/NFwUgNdlEYIo4GEBya49v7n0PPlsdV0+kiF8geiqunRLkbY8Ee4CcvwWQLVuOSR1K5FSRucKrtftAVzaaKBJwKP42HOhchzm4wlxDqZcrgdjVRR6cuH/XSYhPllMPZrHA1Mg1BbUg5Sw4v5HF4sckxyTeXIiz0JU+X+0IMAs8dPbOOIX3g6vKCKneMysck1txk9/3OyOkRlu2Qrvbw/5HIiCLb3yIvI1Q+CAgfZnaX/VuOdcnZNngGLTOtbXTwOcCQXHNqrsIPruEH9D6h+dwoXeroBca4FbERx1/lZgCA4bK0opAaVSFFoUnAy0PSJmIu+6Uo0sPeqk5TOztJmxhUrZmKZOHg6ISXMO80OKhQatif50fFwloM3dFUbyVUZzODpeqQvNoR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clRKTmo3bUNUWE13MjEzZFhrMUN4MHlTeUFGaUZwT0RtMXRDb1NJck9SMTVn?=
 =?utf-8?B?anpNWTlNQU13Y2JsRW1CY041R1pYMlF4VU5uZ0ZtdGpZeGQya0hBcnNBWS9k?=
 =?utf-8?B?bjcwdXpiTU0yMndWenZpVWw0Ym5CRXpYL2MxSi9oV3JMd3NVMkZpbFF4REZK?=
 =?utf-8?B?b2tOdTlxUzF2SWN1RWFpUlJtemRCT2xuWDI4VzZ1eENMdVRQb1JXR0JIbTh6?=
 =?utf-8?B?ZFYxTlhoa3JTRDNPejM2YjNITW5zMFpVcGlnM3hja2lDRHoyWC9jVWpyYXZN?=
 =?utf-8?B?STVrT0Zhcmw3QWx4Tk1uMkI0TmtMVFB1YUVBa1BBeW5EM0NYUzlBNDAyYVR3?=
 =?utf-8?B?MzdqZ0gzeEZLc3h1ZDRIRlVhNlFSc1BiRU1tSVY4TVZEQ1ROeUZWNWpUVGlp?=
 =?utf-8?B?U2F6WUpwMTBOM05TS1hDUE96TnM0SkJLL28xemRsOWRUbVg0VkdueHBZR1du?=
 =?utf-8?B?MThydVVQNDFzRGlLd0pwbGtERlRsUHk4bHB0bVYyWVB3SkUxOXdjQVdUaDFl?=
 =?utf-8?B?OGRFZEU2aVBtTUN0Y056ZWZPS3JvUUZUYWVoMVhZOFlVVUJ4Z1ppcjdMYUwz?=
 =?utf-8?B?MFA3U2FDVy9LMnlROGVFZXJFRHV2Z3lNWnhRVUo0Z20xQ3p6Y1RtRUQxRFZj?=
 =?utf-8?B?U0RSc2VmcTJ3bWRCSDI3K0tDQ1hRREovWFVjSzA2N1hXV1FzUDRNeStzT3l3?=
 =?utf-8?B?Nzdsb2dMNlJkbzhRSVpFODNLVkNNOWVPdmZzSzBwMkxuZTM5WFVSeU1lTm4r?=
 =?utf-8?B?dE9Fb0NhK2RyZUt3VFlZZ1V4TzlsdGFZSzhjQlpodGd1dCs4NkZkTDcyY1ZP?=
 =?utf-8?B?U3pWNFFoM0dkby9acGlIYWRXQ0Q1T2VmVmJnc25leEFmRXVHVUhnb2tVYW1D?=
 =?utf-8?B?UXplcHFwcFVRRkZ4MkU5bEtmUWFRMVlMeHVOU3BHczZWaW4wZVVkcEJ4bmM3?=
 =?utf-8?B?Mk91Wk42WnVxekJwMXliMjM0WU1FelBaT1RVOXdxSFhHYWlRRm05UkFtRWIv?=
 =?utf-8?B?MGNRNXRMenk0Ym1VWkdzM1NBYWVzRDZLZURObEtudXdKNFlWNjZHVDVrYUxp?=
 =?utf-8?B?MloyZWMvWlpqTy9wcmZ0SFVQRTF1RENhTUVmalpBKzgyUjlRTU5yc2NIQ2x3?=
 =?utf-8?B?TXRweUN4dFBCb1RIdGc0bTcwc05RS1dJZGk4NkNyVDJySjc0bVo5STYwUUJO?=
 =?utf-8?B?c1NCbkJpQzd4dWc0ZWRhWXUxRElTUUF3UTVxYmhIaWFXclkzYy8yTnkxTnFI?=
 =?utf-8?B?bUpZQjE2dDR2VXFCTnlmaFkxQkhKUmVUU2xEZEZMMm9vdHRrMjdwTFBFdWJs?=
 =?utf-8?B?eXdteHJvWUhzaXFCYVBxVlU0cWhzNnF6K3J5NFpoNVlTaVVyeGdBWGNoZWRI?=
 =?utf-8?B?TXpDM2Z6TFNsNnZUZUVaUG0wdmVMVnhDbkE2QjNsYjNWVEFCRm8xUVNnMEdi?=
 =?utf-8?B?RGVPWEdwNkllNU9QamdXYy9nM0oyMERERExaL1grOElqUHA4ZDA4TE05azRX?=
 =?utf-8?B?eDBwdmJiVzlnUlhUTW02WHQxVExXRkdOaC9MT3c1dDdhaVhmdTBnUUxOSVhP?=
 =?utf-8?B?UFg5ODh3M2VoOUxOcXNEcldVUXFHdjJhOTBqZEFzL1FBVGhIV0x3WEpMNU5X?=
 =?utf-8?B?emRWaUdydG9ieVQwM3BwOVpuR04wMnZGRDRBbFN1a2JMSUEvTDdBNkFZYUta?=
 =?utf-8?B?UUdOK0dUaW9KbjJSTzc0alpjS24vcTl1eVgzdHVMZEhxRU1JR0txbUkxWVNl?=
 =?utf-8?B?NmFXR25OVGR1ZXBmKzdvOVg3bkV2dkd1aFlBY1pwN0RYRmtBMTR6L2gxMGt2?=
 =?utf-8?B?NXVyWis3U29QZ0lyMTJsa1NzM2hjb2k3VGE1b1UvTzJ0ZkE0NW0zKzBLdUdq?=
 =?utf-8?B?QWRnNmUweldDRkRNSThQb0txVDZLdmZhNVgrSkdzV1V2emU5UzB4endSd0t5?=
 =?utf-8?B?SGkrOWYzNlFtQ21zeFFqbzJsWlY3YzdtdktqWCtuR2RxNTVIV001Ui9HR0JB?=
 =?utf-8?B?SHlFN3VGQlQ4UXhmUnZLbzBnR2JDSEVzeXJ0a2JQNzFwMnI4ZWNkbkh6bDJP?=
 =?utf-8?B?cnFNNkVabVVPZmNqRmtkb2xpQVhxdTF3VzhQbDVBN1lMTmJ3b3pFSU5ZR3Qx?=
 =?utf-8?B?aEY4RXJRY0JnZUJBMFJMRFBzVnBOenlvOGdCczQrOFJtZVpvcHVHSjY3azFm?=
 =?utf-8?B?RXd3Y3YycWZJejdidHQwQWY2SDUvQ2YwZVY4VzdzUnNPMkp2Rmx0bEhhTjFq?=
 =?utf-8?B?dnRtRElVWmgycmsxaTZCaE9qdlk0MWYrRFNqVmszMFZydXBlclFJZkdhOEtY?=
 =?utf-8?B?bUdoR0Z1RjNXamlWcWkrNHZtcEN2eTM1dGNqcW0vNE96U3ZtRmFCdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b1cc5e-db18-4934-5909-08deac4330d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:16:11.7048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXd2R/mM0kXWsLCieF+XbTIu0l+WffiupLbc9GErQtP4wXTMd9m3TBWNy6oaGxv3rTUAZfoOnGk1yIXWbSJorA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3809

On 07.05.26 16:10, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>> Ah, sorry for not being clear.
>>> Your fix is in next and not part of a release, and the application in
>>> question uses Xenomai 3.2.6...
>>
>> But 3.2.x is not affected by the mmap off_t issue?! Still confused.
> 
> Well, the issue I'm talking about was a build issue.
> Xenomai was configured without _FILE_OFFSET_BITS=64, but the application was with.
> Not Xenomai's fault, of course.
> 
> But when the application started to use mmap() the off_t used in the application
> had 8 bytes, but Xenomai expected 4. So, the mmap() offset parameter was wrong.

OK, given that Xenomai intercepts the mmap path, we could argue that
this is also stable relevant.

Can you confirm that this issue is truly gone in next, whatever mode you
choose on both sides?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
