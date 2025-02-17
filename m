Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2083.outbound.protection.outlook.com [40.107.103.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595881A3157
	for <xenomai@lists.linux.dev>; Mon, 17 Feb 2025 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784108; cv=fail; b=n0OZh3uZudMbUD1xv3scuGDI1Xo7i6iNtQc8yvzDTVWP4oxRVb/xLvIhpY2kRrK+OdwFH2yJk/dx1qkhCCEBqzxYuhh7qSm4enmlAIyvjpQzmfecUov3ew87k/e4K8Rs/pBg0lAKeee/lQJ8wR6IJlInoUSfp5kqpYEDMxnGYjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784108; c=relaxed/simple;
	bh=5HGljcjeKPd5CwXYeRzkiYRZs1XbXabgaJot2et0q3Q=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NIvW0yoTH34dxdMmOUEQn8+0yxlsrKhn2ts3VVkAyneC+aKSaqzFmf7H1JDKNmRfR6rml0EAXO+fL0h80lpTPWyzcYVGnMFukPTRMlU3g6J6jelnpxWK1N6F78XLCt8HHPk3qVjXjobKqIwWQIzJn5usK+E37qPrfit/Y6YO4YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yA6ZZMOd; arc=fail smtp.client-ip=40.107.103.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yA6ZZMOd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVtyThJOsESpU4bb9dgVi4GZWmYNqxJ1AbbE/MFSEbNs7vlt3oe/fYTX4HpMemXJHWfWhEX8nQrbPvcKhFvizZzppVSYiSlCoDQ+T9pMg55etjL4Ne4hlZQ488JE76VlvLNlM8NeebEzEgu3kobNZDNCGjJ/lS7XYtv3cbqK+RPi7bd+XNcbQUC8x8MsJ4Vl6u7AyTXQnJ1T+EFUJD5yD3v+0YhpKYIlj58HgCxOsaOeEvF3Op4YJ2DSyf+oDyu0glDcXOPXHsrDHAKBjb8be1ef7fg7KlkswTOucjC9Q5Oe+o8PcTvx8bueS/+gxCvulQWmVOC9z/NYMSUGCVok6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOZ3bHYBhs4ahSprokQu7UDNEEioKZl8ELpzZcOhi1Y=;
 b=YqHxwdE7lCz3OtRc02E6b7UYJk7mVgQbtpDxXbiP606EQJEKbG4hKJ69hp/ncthj+E4c+iIyVMhSpdveG11RjSH7ytAxjL9fD2T3cPECNQ6YgL437PBSUfBLGxhZBRAGIo0RjIimhdM4+BeFW5BL3EdxGogoSBJ06i3jHzby9E845QlR56L1kP/T4Rlxw5L1wpY6VXejlkIPenjpjhZnt9Njy9Hbith6BB5IAflPzYPeZ+2D+yF/3cEdmMC2eNsnVLSWyqV8tkw78tY31VgGDmxWH4pHTiyf9d/O0wr20ZyaRPaNQbFWCGGH/v2LNBRQ7P0rQPea7m0j04eMIJwjUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOZ3bHYBhs4ahSprokQu7UDNEEioKZl8ELpzZcOhi1Y=;
 b=yA6ZZMOdtNRXOgnHeJ1GODhR8kaboB9Ckv57i3VNULx7BvGwDkRopPBYpOtCbCY+xpSX6B4n4VWLAg6TuPAnUoS5UGMkayh9n+uFoe0xuoxgoMJz9MXkVUmlJKzWNgvdJOGUCyAI0Dpht8LGtVwZLzAeTwE4/qlQSgWLcRnExZzRNOHqddR6WydtYRzdbd57JMNyHB5b+fxBC8dWEL5fgWL9jlAZDR70BIwJzMgxInX/v+PxO5UFx7rQvI6rrdh4aryJdlIvqC/Zjro42fxRWoEN0fB8v2cA0Zap7CKidLU/pDJ2huD6tJDxmWxC+DIQ5alP0E+7CgwHn+B8ATroWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Mon, 17 Feb
 2025 09:21:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.009; Mon, 17 Feb 2025
 09:21:42 +0000
Message-ID: <67a95cb5-71d9-417a-93fd-62c9a4de60a3@siemens.com>
Date: Mon, 17 Feb 2025 10:21:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Problem with moving from Ipipe to dovetail
To: =?UTF-8?Q?Marc_Str=C3=A4mke?= <marc.straemke@eltropuls.de>,
 xenomai@lists.linux.dev
References: <34ff489c-a946-4fa5-a542-89aec2d1c8f9@eltropuls.de>
 <26540366296aa067a398520f3a9cfa94caa19fe8.camel@siemens.com>
 <108e740c-9919-4cec-afbc-0ae2f08922df@eltropuls.de>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <108e740c-9919-4cec-afbc-0ae2f08922df@eltropuls.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0300.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: dde60787-0af7-461c-ff6f-08dd4f347d6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2dRdnRzK1RHU0JuSzBuNU8zTzBZTDJQN09zYlRpTzBPckM3cm9VU09vczFa?=
 =?utf-8?B?WnlUS1pVOUo3T1ptZFowazgvMzNNbG1GaEc0YUtOSVpLR2Z4VzZVNUJmbHlF?=
 =?utf-8?B?b1JYYmg4d1ZQMUJFUUJOZXlwQ3lhQ3BtSDllVFo2ejJraWdjbWppaXBKQjls?=
 =?utf-8?B?VkJKckFsTzB4NnhJUXFrcWI1UmhRbWl6eHgxdDdaY3FmL2w0RWkrSS9PZi92?=
 =?utf-8?B?djYzdG5QVWRyMEtTMXFIdnRkWGRVdS9DUjNuYWQzaGhBMzFnOTFTREZpakpI?=
 =?utf-8?B?N2JVUVMrZS92VzdmR3pkUEFDYVlQYXRJUGw1MWF1MXAzM2hyTTlLWjBhRDZ2?=
 =?utf-8?B?UVhlUDBMSHdkaFZjaG83K0xDcFZzb0oydUNMMHpNdytrcGhPeXppRnZMS0VC?=
 =?utf-8?B?cFdrWTl2bGdmQ0R0ZVRibkwxMkQ5UmtvbjVDRVV0TVBnZVQ0Tk5MWWhVTTM3?=
 =?utf-8?B?S2ZhL0I4Z2s4MEM0Q3RObVprVWtra05UL3JYMHMrVUZ4djRpaVpkOENWZGRB?=
 =?utf-8?B?ZG0rem1ub09vVXNtYXA3czIrMGFDTisxN1Y2YVJMNFQxd09tcVh1TE1Dakln?=
 =?utf-8?B?aVV5ak5tUURuby83S0tsbWpRUkVwSSt6V1MxR0VRRDJpYlJiOXZCTkdzWGpK?=
 =?utf-8?B?eCt0RVB2YWRHVldrWVVJZU5QS2V1QUFwVVRCbVVEM25EUE5WWGJMNnVaaXc4?=
 =?utf-8?B?bWU5ZUZoeVJHeE9NZy8waGZXVXo4RFJHOTJJWjhQcXI4WlN2ekxaK2Z3Q2Zj?=
 =?utf-8?B?MDFLZ3ptL1pGSU9wQ2RiOEVQOTZxdTl2VWtTYzh6QnZ4NTVGOHIyWHRySGM1?=
 =?utf-8?B?YlNkaVhGdGo3VWVCVk5qYkl0ODF2cGhZZml3bWJNaWRoVDZpejViMFpGTDNr?=
 =?utf-8?B?UXdCMmJ2MmF4MVR4K2xzQ1owTkJyUHhSK3UyalJzWk95dEMwcUNtV3ZrQ1JD?=
 =?utf-8?B?YkQzb2pFM1pFaHZ6c1VMeFh3Q25GTTNzcm52NmdNdXFhWW51Rm9aVDFIRkdL?=
 =?utf-8?B?ZWorUVFJTTFSTEJZSk8wNC93aHZiZ01VUTBCYUZpY29IRFVNelg2cU9vMXY5?=
 =?utf-8?B?WTg2aWJUam1lOWc4UHJiaHRUNTdFSFZHeXkwQzRpMVYrZG10bldCWlU1Rkdy?=
 =?utf-8?B?SkZkYjlrWTIzYTZkQmJjNkM5c015aE41dzMzNks5cTZUSjVmaisvMzlYaHJK?=
 =?utf-8?B?WWd4b1RkYkxiQ1J2RWNCL3RENkNUbjBXOFdpc0M4VmhLNzdSNHgzc2VVWCty?=
 =?utf-8?B?dzZqb3lENWRSdmVha2hOSVBoWFhrcGtrUWFPZUhhVDRLTkJqNHBKZm8xWmNs?=
 =?utf-8?B?OW44eWFVdTl0djBwUWF6aDVrRnk3Q09TMUhhWER6M3A5NThkLzRhdElnbnJ1?=
 =?utf-8?B?amduRm9ON2x0amc0c1BVTkpCdmpIUGk0NHNmanpXdFQ1M3Q5VFlDbkdpVHNQ?=
 =?utf-8?B?alRYK2dNQ2FJNTZsbFdpRmNvYVRFNlA2d05pZWVodVJXNEgvN0w4cGRoeXdo?=
 =?utf-8?B?ZlFCQ0s3UXRTY1hCK3N4MW0rVW95K0hRRFBFaUVIK1J0YytVQ0hWN2JyeUJH?=
 =?utf-8?B?SSsvaWtjNFAyRXUrczFrOTVxeitRcmxVMW1VVXVJOVNqajcrMkdzVHNiZU5p?=
 =?utf-8?B?VTdSZW5oekU4eXZnbkxPS1VGVXhhOG1CMkxFVVhjdTZtc2cvcXR2YzN1bSsy?=
 =?utf-8?B?V0YvSkdFNXczQlcvbmlkYWE4MkFSQWZIQW1qRWc0WUtSY1BZMGU1SXVjdFcw?=
 =?utf-8?B?ZWE1MmhJUDFGSlEzNHI3T2Q4ZThLRGJ6WW8ydG9kWGxQOTJFd1ZkWi9kem13?=
 =?utf-8?B?LzRkdWtJYkRlVUI3MCs1ODlLS1dOcXBEc1ozMnJkSmR2NXZ0dnFwQXAxcFJ6?=
 =?utf-8?Q?fUXKiHreRey6o?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFZjeThWVFhTMGFGTlpoN2I0TWovTUlRZXdtQ0hvZ0ZGNHdHMzVCQm9QTVBJ?=
 =?utf-8?B?azB6elZoaXBRYkg3YmI1ZHc0SFU1bU9iaEtXVytDdElpUG9UcnlreTNqL0xO?=
 =?utf-8?B?cllBNmN0R1EwcTNsM1lna3N5aWtPdnBFeld4R2VaRjVrR1JuTGlqZCtnUVY0?=
 =?utf-8?B?b29mU00xRVBtcy9NQThDTFpYM1VNVEVUZzhWTmxFQWxqMWI4MFZpSkl5N0Ja?=
 =?utf-8?B?Wm1BVFpjOTM2TEEwU1VRMjFyMDlFY29ISDgvQU9nbE1IVHgvQUdtMEM5UUw4?=
 =?utf-8?B?cTkzTndveGJVTGFCcFBhY3V4NHlRSWY0YkdGR240c05wRk1wT1hzWjhad3cz?=
 =?utf-8?B?dWhqNUpRTGsrYmpQaXF2TlhhODNEL2U3VnlsOTRXbVNkL1FhWXlKaHl5dWty?=
 =?utf-8?B?VTZWekRMSmE1bU8yMThzeGlWOVliOTdaVnJ5cmd3Mm9VZnc1dEVsWEFOakdC?=
 =?utf-8?B?bmk4N1Z3N1pMNkRFaUJ6N0pPQlhVc04xOGtTZ3FLSnlJQmJZVVdjV0k0ejBN?=
 =?utf-8?B?YXFuWXR2VzUwckRERGlySjZiVS9rMk9OdEt4WFJRZ0ZwM0tTa05oUjJUR3dL?=
 =?utf-8?B?UThyTHNtQi9BV0FITU5iOEtSQlVWZ0h6bjFCL3NJOVMxOFNESWVoMjVTMUlr?=
 =?utf-8?B?N0V2YXhnMGU4dmwyNkVmVm9tWk94UDFka2tYa2lYT2NDMFVyeEV0Mk5tUTVz?=
 =?utf-8?B?cHFSZGp2bUh4OTZ0SXJoMmxHU0tKS0JhQUxNSUdlUTEvdkxaQWRWSkV6M1hO?=
 =?utf-8?B?aU9xSFdtK0tCMDloUk1PeDltTS9nOGtjRlZ3Y0ZvL3NOVEpiN1BRV2wyVG5K?=
 =?utf-8?B?TGord0g5KzVHMUlGQ2w4Y1VTRGIvSFltczl3QWlFWmJsU012dkk5Si9uRytB?=
 =?utf-8?B?TWFTNmtwY0pOWnlia2wveGxXNUlJNlE0MG85bUF2ekVadjkvNXdSeTJNK0pG?=
 =?utf-8?B?UlZ4VUNDaDRERm1FR2N3ZnhSUi9NS21hTjBLTFlkOVpGWUY5U3l6aVQ4em9s?=
 =?utf-8?B?L0hMa1ZQMzdrVXlIaFpUeXYzZTErNDdITjJCbFdWOXIzOGZYYi94SFBLeXdP?=
 =?utf-8?B?VGVSTldUaU9KRmZDN2JPMUVYeWlUcW0vbFFTTzkxN3ptSjBjem0vbTNlRCtV?=
 =?utf-8?B?b0ZGR2xOcnJiYVJSWnlzTVJNWW5VVU51Q2Z6RmhhaUtNTHhFZ2tST25McEdE?=
 =?utf-8?B?bnhldVNYL2Q0THJCVUY1QWs4ZHJUMFhVSTFCcHFIV2kxMTNQTEpHaHVYb0J1?=
 =?utf-8?B?eitiVDBpa3o0Um92VGxtaWt0ZDR5bzVFek95am1PNlpZZjhlamVKeFExUnNo?=
 =?utf-8?B?d3l2YTBrenNIQnVVWGozT3NnbTZ4WFYrblV4ZkJXZXZmTlhubnBIN2E4a1Bu?=
 =?utf-8?B?M3ErRHZ1VE9aV0JUWHRpK2phMjU0WDErb3JpYXVYVWdUNk5uUno3OE9uMnNV?=
 =?utf-8?B?T0RCOG5HNVlrMWdEMGp6dkJHYTdsK3hiaXZSanhJbVlPUEVZOUxWRTBHUEpK?=
 =?utf-8?B?K0tsOE1WMU9wR0d1L0FTay9yWWlSUWVlb1VXOXdSZm1GTFFvaVhPdnJhVG9J?=
 =?utf-8?B?ZC94bmRDeThSNzA4eTdJSUl2KythNTBkaEVwNHBTN0V2aHFjcUJhUnVpd25p?=
 =?utf-8?B?bDJkMDFWVWJXMFhqODdWcENMVDdiZjBTTzRDSlVVS0J5RG1NcEZFWnhRNG1o?=
 =?utf-8?B?RmNVaGtCYWNhMDlVTVFQaEh5QVB5RmZlR2xwdmtlVXVYSzM5VjZWYWlPalE0?=
 =?utf-8?B?a29seklzY1hiOXZIWlRGUWVpWU81cEp4V2d3RmJVNXdaMTE4ZklFM1dFYmwv?=
 =?utf-8?B?LzVFbkZhV1N0MDh3MkxGZTdYYXBTUlp4bDI1bnlObWxpMk1yUXdNWnhKTUtu?=
 =?utf-8?B?OCtEVHJOeVEwSFlQU1gzaGhxcHNJaG1vaWJRUkprbU1HT1RyYWdvbXZzVHkx?=
 =?utf-8?B?TXpVaGZLUmJEWVRhOEtGUDg5R21WVVoxbVVXOEVzVzZTNndxclhJazd2WG9O?=
 =?utf-8?B?NGczdjVKaXdJSEhCMGpNQjdJSHNLZ2c5eklXL2M1U1BYSlZqcTR3cEFTL2Fv?=
 =?utf-8?B?MW9GbEFUdUxLM2kzeDkySCtQUzBWWmQvdXZKU1dlaDV5N0kzRlpzazU5b25x?=
 =?utf-8?Q?ePyj9IqcMymiKMfxCpzM1C9pG?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde60787-0af7-461c-ff6f-08dd4f347d6f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 09:21:42.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/bmc+ZSlMjJsqNrmebT3w5siR3EVqh1jwemR1zMFCwLefBgZsexpkaZEBQEc3ZudtpRQpc1jkqj479GuNvxIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6057

On 17.02.25 09:50, Marc Strämke wrote:
> Hello Florian,
> 
> On 14.02.25 16:34, Florian Bezdeka wrote:
>> Does your problem also reproduce on qemu/kvm? That might help to
>> simplify the debugging process.
> 
> Sadly the issue is not reproducible in QEMU Both the "bad kernel" and
> the good kernel boot just fine.
> 
>>> How would I get more information from the frozen system? I turned up all
>>> debug settings and get basically no output. The IRQ Pipe torture tests
>>> run ok. The problem only appears if xenomai  is started during boot. The
>>> failing kernels do boot with xenomai.state=stopped as a parameter.
>> Might be a bug in the IRQ pipeline that shows up as soon as you enable
>> an oob stage. A boot log might help to get some more information about
>> your system.
>>
>> Is that a boot time failure or something that happens later?
>>
>> Florian
> 
> Is there any other idea to try for debugging? There is no way to get a
> serial port for logging on my hardware..
> 

Hardware debugger? More a rhetorical suggestion. I suppose some JTAG
interface is also missing.

If your development hardware even lacks a UART, someone tried to save
money on the wrong end.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
