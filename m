Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793063807;
	b=gDaveM7LvMyH4ESKci8h8jMWs02Vy82zwFFRGoGsVMjr1x619HQjaiDnybuI465J4pR9
	 y+pS3ar9rX9M3x1+bGvtEubpazNyWURxld62tPYlJhCAbEhiooWYk1GUEQAOqH5eU94SC
	 EFdvMjk/No6D5I1EST/789aKJc0x/RSAPHrUeFg+SQPut1KKw4DZxYUS/u21WOW/W1KH9
	 wLBRyAzvO7V9Wg/PdZKSU+JjIQQLwMXiCxaf4ZN9A5S9M2G726L2FMAejA162QBOcTptO
	 Rkv7egHuYxcLNtP/J5PO0xA3x3S4Tc600Rw/gbfvzcdvabaecPCdeU++EAI7feLKgjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063807;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=wh4dl+FCHjAMCOuC0ByatmPjp8WD1wggk1aAjTrZzS8=;
	b=VdECvoENWIJpaWsZ5insUgy8x62yB7VJk1FiMW4MggDwQqUN2syJSioKfGoLxj97NOfo
	 RKwV+DnOM2lnzpmTm7LlyyS7oh1YEoutRlCSyATv5W9/YL/ixUMQA7DRwvlPUYZEdw2RO
	 2/FThak8DCjUmKqM5DVE2XHVdBeLx9TZ+BOzBPIJs5alk6tg2geASw2f/wQs8wu+mb9Ab
	 U5KTjkndEAxu2PWbIPGjijPxTPF25s/sY4e68OfspK5q9G25NSEeIIUQTU09jJH/ScSMB
	 z+5p1F1Cdd6QV57KPVtzbnpmZAlKr01XNoa677FFKaEZKzHLrHbyQasY866sefWHiOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=HH2ftRHk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.65
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08B606A31A
	for <xenomai@lists.linux.dev>; Tue, 27 Oct 2026 01:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B08B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=HH2ftRHk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TyIFNiiDLHCj36wO6dLlCLVl7O+hg7dg07gDaq32dUM4Z4PMedkb3TpunYF3bs4RdiAylvIslCQEfe5zcz4nuMxnu88ElZY1+XIJ5bW9Trfj3FpErUSOyVZpW5BSPAF1pE7QDwYhaObXIft0ZVK8E+HMZrnr9e7qINDG7sUG0/A6trF9H+4y9gGevWN8cP2Bc7vPfcDmhUZ03nHpTkIqXZuKH4cp8xzO0EeLavXlUC8/f32yDGV6ZBCz1jHFH6xYm/oNDLdjs0qj3TRbUD9QJat/eguSLkuoXsGAJSRHivhRoVK5rJ9CuPMfDf5d6hDzhxjs2fnYSUsh8pREF2edVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wh4dl+FCHjAMCOuC0ByatmPjp8WD1wggk1aAjTrZzS8=;
 b=yNkMFpf/cDh/JIqHj0mrgjBg8lgL06p+1Xip6xGZXRyArT6eeKSJLYTJ5wHqHDzxtYxl0YlLbhDNtlhgVpSlba9c6E0pr7IUNU8amA3bictjlIo2wbLshV9DZbW/Q4ZQCzwVSIsVF5/TL0eEm/MoH/x6lvZfhi262LGvm0EwtVvEv/9ZDYtWjoe+r9aufG+hfILtzYuOmSzDKrEusqYvXpRg+cpFjaUP17/vzDV8uOYi1xsHMs6+XuNMH2Eaf/v4ItyJaDmFeQPZWYRdOI1LoWaExwiC5PuR04lLraVz6ywBKtsCOAE+6eO077nSAmi4aBOR9YUphquvx++Ujp0wDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wh4dl+FCHjAMCOuC0ByatmPjp8WD1wggk1aAjTrZzS8=;
 b=HH2ftRHknQ5IogjmPMfd2QXLz2LSq3b2djTu+anwoLTF1tBHSTQwFg+/XNwfFF81U4noPcPzOEMGMy9banicqT/8i12BYRlDfWccpPF7tuxW//BYGQu2SMT1l8kDSI/8HQ/69gcXAPnYGVn2AbJJc0lh9pFoIdACyHAtP7rNzc644tkpwmrvy/dqxsLhNQH9Mk3LgobQ0I9ZeCyeZY5/r6Fw2POm2u79Xuwvosf3KOFOrj17ceXi+cGT78zD/7bxcxj4UZ/ujM3WRULvS9oTIjxMrW3Khqr2JVLYkjhtt7STnLDgkdC9ifA0G57x6bhGBheINkrb17z/CtrhZx83Ng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by GVXPR10MB9405.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:2ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Tue, 27 Oct
 2026 01:16:43 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0569.006; Tue, 27 Oct 2026
 01:16:43 +0000
Message-ID: <cfdd29d8-5304-400a-a471-a62270a27ee8@siemens.com>
Date: Tue, 27 Oct 2026 09:16:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt: Allow naming of inband synthetic IRQs
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20261026-wip-flo-implement-inband-sirq-naming-v1-1-f18ad0aaec7a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20261026-wip-flo-implement-inband-sirq-naming-v1-1-f18ad0aaec7a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0389.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::7) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|GVXPR10MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: b54e9afe-8dd1-4291-a8e8-08df33c7f62e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|55112099003|11063799006|56012099006|261026140227099003|261021121427099003|261026121527099003|261021123027099003|10067099003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	tj+bHPsU/2MNf1s6/hb3s3e3l9AfV8dsiINr7z7q0OL/LX6ROgZ2yGn5D2oHhYWwGU3Y874AU+HD8v/xP1YM7HbXPcBFRymKMhCPcaTk2eYT1WG41HvA/Wh49gM0KTszKWnHIcLw9nYSiTAyWzIX2olQk/oIgTt2u5mrPihOGL8AeCPYSgmb69p3Fvr+Otnu2WuH/y5ZXuDXR3NMC1xgasznZlM2ax3m++ohqd539IjibRo0E7y5smDR2je8gFGjAKrxC/BTBGpyIILRqvHrvnlxtvY/d44mB7y5O7w8TFQ60tSIOlE+ghC6d9lsZN9tl90I9Qqyp8/KS7CEM0pt3LphJ0HnhIrA7gTNmR6eWOtmwMedYUfP8WaMHiFzG+FIiep+V46aYvq13HQJ9vQ4ctzck2Oen//942Yw8FQeYwecpZ24e2m9fUnIPZgiNJTWDOkf+xC4MgqfW4/RuugiE6ktaXFgqWJDzggXeLlRiQJ+MMIqYyXC7mnpbi1ZfJuRN7ibUZzcBZn82JilyylaGpHMWA8fKgaQNBCY2NgAR2Ahl0VMop0Ysm4ADDnIi8WJpfY1KDS87YZIKG1pO8aHeCgDi1PPRE39RvRI/DmQ76CMQOGjbsxXnRwUwVwDz/ixQrd0dG3pB2f3Z6Kz0c6DyE4pweoWHq4MV8CQZ5b5Kzo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261026121527099003)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnB1bXc2OTRJNjdlVUlLL29kcEt6RDcxTkRGVWhBTVEwSTBQbWQ1emJDS2pM?=
 =?utf-8?B?SkR3SldpRHY4SkdoQnFUQTZvZ1g0QlVQQVlCTUU0T0VqNEVRY2RtZE54T0Vn?=
 =?utf-8?B?dURZOGZ0eEtWcmJtL3ZLY2xOOGlzOVpEMUZWeHY3bmVtMHpSMkVOdEFZcE9z?=
 =?utf-8?B?aWliSU9RRjI4dGFGdVMyMWRTbE1VRlFWZXJYVGlLRk5rYjVhUm4yMVM4emx1?=
 =?utf-8?B?SWJ1cUtPZkZlbXJid285WWd6UkxwK3VFQStDRXo0ZjYrOGk5U0ZaUEpGUjhs?=
 =?utf-8?B?dUt3WWlhbjVpVkkyMFdIV3UyeWtKam1Dam5DMEU2M3c0enh6dS96VC8yNnNw?=
 =?utf-8?B?MWVwQ3UxenNNZTNnTWRBV3kya3A3d2RFRzYwVGgwNlUwSFR0NFovSDZvUVlM?=
 =?utf-8?B?U0dVMGRTci8waExvUWUreXFwb3BRelg1VHkzVFd1M0ltV0ZWNVE2NCszck5L?=
 =?utf-8?B?a0F0VU5idk0zdlpvNXNwdnBpWFFWaHE2ZzJETzZjbDRmemZFTlVSbVVKK3dP?=
 =?utf-8?B?L2RXVWRNdVZvSVljVWZ4VTdMVGEwaG1QK21hOVZ2Z3MxcmFHaDFTd1JkT3lQ?=
 =?utf-8?B?MmJEbDNpeTlxcWE1REhmNlp6cFZ1d29lSGlzZUVjUEhsNStsT0hIczJ6NEEz?=
 =?utf-8?B?VVY1c3ZEbFlFbGVvM2ZLZVNBeW9wZ3FkNHZsNVNvcWo3bStrV09FVm9sbmN1?=
 =?utf-8?B?enJkL3RBYXRrMUU0aU5qQXdtZTZoRGM4RXowelJaNVVuczJHWjRGUUZ0VGda?=
 =?utf-8?B?ZUVVdzJjZ2x5QnNaQi9MeDFBN0ZBdyt0dEpqTFRyaXNtQWJ5Y1gyU3RyNFMv?=
 =?utf-8?B?a2wvbGNVdThzMmNkYkpMVUZvc3NYYTdOZDRVK2tBbWtvVjJXbmtPc0dKY1VE?=
 =?utf-8?B?TFZiekRkVnk2VjFrS0dCZVVUeEpUbzlVWHJtWmo4YUZaZE9jcndjWmUxN1Mv?=
 =?utf-8?B?bTdSWHphL0FGY0h0L3hvM3VOajZKQlJiTE1VRFM3MWdIS3ZLNyswSkdwTUhx?=
 =?utf-8?B?WmN3aTJydTRYQUFZcDA1alUzTmxWODdwekd6Y2hKT1lTcG1UOEJSR2ZXTXV6?=
 =?utf-8?B?N3pVRjJUL3dsVHdrWGRYdFM2NEhoWkwzdzRlUTc2MVoxb25IRVRKVjF6VVUx?=
 =?utf-8?B?QzhrY3pyQUJpbmE0QXZramtObTdBWGR1QjF0MC85LzhMYVFtMHpoaUFCYzZB?=
 =?utf-8?B?UDZIdzVTaUtycTVsQ3BudDY2K1Q0WHJWS0QyYStPc2tSaGJBVHg2Yk9lTjBK?=
 =?utf-8?B?VHFDaXdBMGxnUHRWTkFoR2tHbTJubWppVVd4a2hQT3BLaDN4MURwYjI1ZEVz?=
 =?utf-8?B?VTdKa2VHWlNLMm4vdjFhV1VrNFkyVTJpZ3RLZjVFWkdtWG1qcEpxYjAyZnpR?=
 =?utf-8?B?d09LUjlXOFlrOEVIVFladGc3NmR1RllVRVhhZDV1elRXcWFTc2s1eWgwVHFM?=
 =?utf-8?B?dENkMmE0Y1lkZXgzS254YTNoVWlXZEV0dWZEVzhQbVVNR3o0VmkwMWxSZU10?=
 =?utf-8?B?dmE5bkxDN3lTc0w3WFRwY040SiszRmgzTXlSeW1RZzF4a3ZoazdkUUUvbW1q?=
 =?utf-8?B?V2wwaEZDTUMreitEMHVkSWtHaTY3TU8rYnc0UzlhYWIxRTVPVSthZlFsNVNw?=
 =?utf-8?B?MW1nQjhkYjVacmlUcHVHVWEwT0tyRjVQdVJDNldpKzZHWDZ0ZzRNU1pNNlJB?=
 =?utf-8?B?aXY2a0FGajUrcWVnNkdMajEwZnM2TTd2bFUvZ2FlK3pHOEhEN1B2eFEzZlFL?=
 =?utf-8?B?Qi9wZkpURFVMMmdPZ2ZiRlI3UlNBdCsvYTQvdnFTa0dOZFdyOEo5UEd6N3BT?=
 =?utf-8?B?dTA2OG04RkRNejA1ZEt2NDJxd242bWhndHhkQXVOclhsSlRrL3d5R3BNWWcx?=
 =?utf-8?B?TWFvUDJmWkQ0N1BmNHJXZU5FVktDL2wyRkIrZmU1U1pjdndwNDZkUHdrdFU2?=
 =?utf-8?B?M3BINUJQdkoyNWN4QUpMdVRuTThwTmF4QnpTak5iMlg3VDlkUGYzK3JHREFy?=
 =?utf-8?B?OEdBUXR3NklvWkFiMG9oVE83RmpreW53Q1F0Z3Uzbm9xa1U5UitCOHN0Vkc0?=
 =?utf-8?B?dytCZUZ5NkNpOFNFY2d0eGRQZ0hPSGtpNXNnY0szU3ErK1N0Q3JNdFZxakE5?=
 =?utf-8?B?dFdQY2M0Mm9PdXhEQ04yNmMreVphNnIzZTRqYXlodElnempTWWhRNDROcWRU?=
 =?utf-8?B?M2hhbUxDLysxMTdKb3k5eEZLdFFrTnlnNldZZnJyMXlsNTN1amJFSkFtWTBC?=
 =?utf-8?B?bWFMKysxZEJoc2FlRWtCNU5FSGhicWxlTGJmdDkrVTI4MjBJUFhXY25jNm94?=
 =?utf-8?B?Q0VnNHFJWU4xMTZSR2xHcUNwei9KMHVIZ3kxcDd4RHF0TmYwS0JmZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54e9afe-8dd1-4291-a8e8-08df33c7f62e
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 01:16:43.2388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YlhMjNoM2ZpZSUFhmOja63TDa92LhjhwIWookC9sJ2YsR7WpquYr5nyLjWs2ARwy/RW5cEAxeUpUqMgRZ0Rrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9405

On 27.10.26 00:51, Florian Bezdeka wrote:
> Cobalt registers two synthetic inband IRQs, both by calling
> pipeline_create_inband_sirq(). As a result both IRQs were assigned the
> same "name", which made it hard to tell which IRQ in /proc/interrupts
> got assigned to the different callers.
> 
> Extending pipeline_create_inband_sirq() allows both callers to assign
> a name to be shown in /proc/interrupts.
> 
> /proc/interrupts shows the names as below (example from x86/qemu):
> 
>   25:    <cpu stats> SIRQC          25      in-band sirq: select
>   26:    <cpu stats> SIRQC          26      in-band sirq: registry
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> To: xenomai@lists.linux.dev
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  include/cobalt/kernel/dovetail/pipeline/sirq.h | 7 ++++---
>  kernel/cobalt/registry.c                       | 3 ++-
>  kernel/cobalt/select.c                         | 3 ++-
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/cobalt/kernel/dovetail/pipeline/sirq.h b/include/cobalt/kernel/dovetail/pipeline/sirq.h
> index 13eb020ac7c17ec06c52b43406cc68aa7f3e52a1..a533aad390492f61d4b786032ec35d92ee5bea0e 100644
> --- a/include/cobalt/kernel/dovetail/pipeline/sirq.h
> +++ b/include/cobalt/kernel/dovetail/pipeline/sirq.h
> @@ -16,8 +16,9 @@
>   * a handler on the in-band execution stage.
>   */
>  
> -static inline
> -int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
> +static inline int
> +pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id),
> +			    const char *name)
>  {
>  	/*
>  	 * Allocate an IRQ from the synthetic interrupt domain then
> @@ -30,7 +31,7 @@ int pipeline_create_inband_sirq(irqreturn_t (*handler)(int irq, void *dev_id))
>  		return -EAGAIN;
>  
>  	ret = request_percpu_irq_affinity_flags(sirq, handler, IRQF_NO_THREAD,
> -						"Inband sirq", NULL,
> +						name, NULL,
>  						&cobalt_machine_cpudata);
>  
>  	if (ret) {
> diff --git a/kernel/cobalt/registry.c b/kernel/cobalt/registry.c
> index 3e4bfc46051c0f8348f391beebf13c6051bfc859..2a10a19f36351e84a9582af9c03773624130fec4 100644
> --- a/kernel/cobalt/registry.c
> +++ b/kernel/cobalt/registry.c
> @@ -126,7 +126,8 @@ int xnregistry_init(void)
>  		return ret;
>  	}
>  
> -	proc_virq = pipeline_create_inband_sirq(registry_proc_schedule);
> +	proc_virq = pipeline_create_inband_sirq(registry_proc_schedule,
> +						"in-band sirq: registry");
>  	if (proc_virq < 0) {
>  		xnvfile_destroy_regular(&usage_vfile);
>  		xnvfile_destroy_dir(&registry_vfroot);
> diff --git a/kernel/cobalt/select.c b/kernel/cobalt/select.c
> index 70ae9a07d52680a6d56b6811d15b26025482342a..544fbf7da90ebe796c2e1ddb07c5bd9c793b677f 100644
> --- a/kernel/cobalt/select.c
> +++ b/kernel/cobalt/select.c
> @@ -441,7 +441,8 @@ out:
>  
>  int xnselect_mount(void)
>  {
> -	deletion_virq = pipeline_create_inband_sirq(xnselector_destroy_loop);
> +	deletion_virq = pipeline_create_inband_sirq(xnselector_destroy_loop,
> +						    "in-band sirq: select");
>  	if (deletion_virq < 0)
>  		return deletion_virq;
>  
> 
> ---
> base-commit: cfffefd3dc4c44cdd5376e9e0b03eba7c95f2d6f
> change-id: 20261026-wip-flo-implement-inband-sirq-naming-a81db7da7b9e
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
