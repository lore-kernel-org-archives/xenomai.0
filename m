Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013017.outbound.protection.outlook.com [52.101.72.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9733806AB
	for <xenomai@lists.linux.dev>; Wed, 29 Jul 2026 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318141; cv=fail; b=p+SpK+rLCBefOyzNNWDQb4FBGAUB0m71OLrWmdcg6QlWf7s467cKUQ65Siw24XcFarL9C+YOLv2LmIxVOIf1rY7n2bg0S2l15jI3HTwUjZSVESrnVJXiiGmIilU49v2W+DeuQ3hrV8/K/IHCs4yV/8yY4uFLnJLY+ghp7yyA4sA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318141; c=relaxed/simple;
	bh=Pk1QPlxlng3JNbtZZIKWUcfa1B4fP1Ep6ufh5p20mQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hIedg9vRQGJuNUMlPgIcYpqL7RPflNbjU5u5+Xsl7Aa7Q1Xtpr9LU62osTuyLhWVtZi6oYRhsCoDs75RqYAFdvouH9i2KyZpFjVsXVR6759h2HXIFHc95BD8DytenN5gv5/Mx7LpiU04uXaruvKA8/3HUlWBPNVKjLh+5W0PGJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yEqG/JvO; arc=fail smtp.client-ip=52.101.72.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yEqG/JvO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWJQd0NzIREocYB1KjE4Zz2SqHrHsDPFRX+O26MPgD3/mEQAr2aOWnEWhCyKjOVXF/dl0eJAZBuhrY/V8N7YAkoClj5hxYeoFarmMDaqHKWO2WRyALoswsSXw9JFqp/o4kHRzr5DJJQNkZrEooY9qqqo+DpvaJ8Rp21f32NvsmA6eqrfqLqzMtPReU4Sag1+dpbXQ2cSaIImJVEAATKhYK+pw34ptz0LeX27bHHdWCsseeFioflG4bm892ae0qInLqROMK4P97C5sxxF1MVApfSTv6esLSs6AiaPa6jt0kEoHRlxEMeFTAx8/w37i35qnMfvCaVEyi2m5lUt8yur0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pF7kms8XtAdNQ2oDHblZjAb5dXinVhVF9NqGKWSe9Y=;
 b=zS9Gx+7hLDagXrgVTA5lzoT0ZONi8HQw2Jgx1KQ3uXMb7OKZWPY3bKhdjwecdtZblQ5ZwEZM7LVzSHBSTuQj7NBXazMcXBxnr2ek5sD7DT1Y7keGctXefXyHCmKxEFDNmpwevPdSlmgzoSoU66sBdPMaQU01YFqtrLu5+D06vh4OepFqf9BrBzE6PgEQqan8tlidQEgd3e81dD7NeNuhjxEzm16k/SXBrOYtMryg4mN4nNKoE9NXFCKJY3EXwRLXwRYOXcVgrSstyp7DSLZic74htzoyuXeNHjV9bWSYgn+SYKHM+h7W2uYUQE0zU/HHuSTy0yQmycCVwX6/H+hE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pF7kms8XtAdNQ2oDHblZjAb5dXinVhVF9NqGKWSe9Y=;
 b=yEqG/JvOdYA8fodrUhT23BRmzHWvtLH0HuF3On9vS+vPzpW+SlCrTdCc49fGpUuXDaYPJOvyFLiRr+zO6vvZ5s7fzhvNTto2REqawlEtPfiuy+V9e0jmd+ky8YxaEzPigYvAvk3rrWsjRllRp7X+ZyNp6jmketkJy2lMuwoN0vaWeaKzjwJy3X4H+KHcSq5Uhp1muuJfl4QHHfugPh8zAvqMB1aHBLSwMCKmFSYXHSVgVTn2w4ZJ1+xihukvSVBtLEPiLIRu7Bx6O8samRLuD6rv9MuaY1K+BSTjKTc/OyZQlKkwJUzfUA+1GURT6zM6E+UwaycyHVHS/12a2KoDlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6454.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:42:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:42:14 +0000
Message-ID: <21de2d63-f569-4370-9778-ab8f7dfafdcb@siemens.com>
Date: Wed, 29 Jul 2026 11:42:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v2 0/3] longterm EVL testing under load
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
Cc: florian.bezdeka@siemens.com
References: <20260728143932.2747505-1-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260728143932.2747505-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVAP278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 821665cb-1936-495d-c300-08deed55ab96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|55112099003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	r6Pi94YynY+3oWYUGYdugPOYAKXxyBzfyHQ1k5lwVuEt9XSW4ZNexU9fm9yoUVhtfyz9UHSX6G2/ev2Ex+atmS7JVypyQQWWebCFCJYmk6BOOz/baDgSKt1KeDK1Uj7/9iA9ouKebDzztQbcerLkIUyrd9atv37Ahk+jPS65/ur+rfjL2Bqotf/tiaka+IYrZHI3xJKl8QBKIkJGsDVcvbFUIECRpPp7MCOzH0vemtnTtONVa4x0qNhh2XSHMAc2sTuz3d4dY68z9MI18hyFH0pQxUTxAHuO7sLuUkvwr7G6THgHoMnM4f9ZP/VZBmp73vrXbqvlSSoncvUAuhG/RkOv6VOYbgO4y2+5QFwqjujERPndqgTDYlvj3Th6zVvswncyPZ0CiL4bLZTejMWY5/rOtENgR3fo61ipVdfHkS8l8HwM0pnj35KAGn1xdw5FqVzMnh2QRaz6ZxL0sPOBqyDcPjsgm6VAnlWk1vgRK+M/iaC7AxDRRdC3d4gzeNNEjCDGt1tOm59hS4iD081Psgu+wesecjuHO6GW+WAikyWXmu46Pu2C9n4UXXwK02Vgg79Bja1Xb29oZistuQ516QZpepc7aCWWSbu6YIEhPOZIMHr4Z49riLFcEx3dX5ksEyKkdrhAgSUqnKQKMlUO9N+k4U4HYOb5r5kYOr5d0A4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(55112099003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TERtTFczTnJVeVBjOWJWTi9mNHJJVFJSTEFiV2gvbU85VHdRck0rdWFXeVdW?=
 =?utf-8?B?a0VxeHVmay9uRmJtV3hsdEZRRnBmUWc3Z21qL2VDOGs0dUZmVXlsK1doUTFU?=
 =?utf-8?B?WUFuelFnUHlJVUlCakhLMkQ1UVZzWkVPTGRPZ3J3RXUzZDdETklUZlkwOXN0?=
 =?utf-8?B?T0VoTFYwK0xrK1NMYVB4Y1hJTjNHa01uV2F6Vm5GY3NQK1F5bVNqaEFwNnpL?=
 =?utf-8?B?VW5ORCtBQi9HeTQyUWVWUStXeGFNd20wVmVtWXpYVkcvQ3ZMd0s3QkI1OHJW?=
 =?utf-8?B?WXhKWWtxaXVhbmphOHQ3K2hkQklnOWlPSlJhZng3ZSs4RXl5aTVMUVVpS1Yw?=
 =?utf-8?B?a2pjeDdYUGpzZHpwSXV6OFdCdDRzRDJVTlAzYkJhRWlwY0VoQjRxMmNJd09u?=
 =?utf-8?B?Q0JGQkQvWW1sUlV4R0MxNWpjZUlPWCtLOVBuY0tZZWplM3JLMVhUbjdZeDhD?=
 =?utf-8?B?eXc1YTh5T0pmVXdXMTRWWmluNHBoU1F4Rjd2cENBQ09zbzA4T29DSm05U2N6?=
 =?utf-8?B?TzJPUmpwYjdJRmx0a0tSVnIvbjhYRFVWd2xsQ09KTXFKQ0lrOUEreUN1NTVx?=
 =?utf-8?B?bDRBbFdSMDJzYWhsTHRkY0dIQXBpY0h5QzB6a3BqYXJNVXVBNWNxak1GU1Bs?=
 =?utf-8?B?emNMZ3lHOXhBRkZWV1dqY1JpMDEyaWVQYUhabVJsMEtHS3Y5V0ZRVksvbkdC?=
 =?utf-8?B?NnBqOFNkc09oOXl0aFF0d0I2TEhaQkhxcSs1WVlYWDVhQTZzSXVuUnZUL2Vp?=
 =?utf-8?B?dHBFMUFIeXRXTSt4VGQwZTZhUERUa2V3YWFHTytzNFZkaTNyQ081S1p2L2Fs?=
 =?utf-8?B?UlkybndxSXhURUtwNjZlNURnVVN2NnFLVkVXbUpIRlhPdjM2TXI5V0ZGUkx3?=
 =?utf-8?B?VmIvZXlFcWNTSHZWT2dEWm9pVnNtckp4aVZPSkZiOEhXL25tN0N6SExVblhZ?=
 =?utf-8?B?djBWekxQT0hMV3NGQ3AwSHY0T1o3TmZyWHkzNHBXOXFGRllQSE4zZFlzdHdR?=
 =?utf-8?B?eml5eEZxYjFGaXY3K1U0NFpqN3N3V0sxWStoWDRVL29oNWlqdzJLQXVMV05O?=
 =?utf-8?B?YkorWVJSVjhQSkd4cDlqMG01K0RDYWJyOW9FV1RCOFZXYUZWWFRqTC9jMzB1?=
 =?utf-8?B?a0k0Zkk2aU9XNWo1a3ZYbFR5QVNJMVd5YjNHQlh0YmlpVmJYQUI3aGRhK3Zt?=
 =?utf-8?B?Z0RhQ2Voa3VITmlmanNDN3JxWmVUWEZsOG44T1BvR2N4cm1QZjNSL1Z3S3pK?=
 =?utf-8?B?QXd6dENXbWpzTWw4bzZLNTVQZ0J6UmNBdVBmdEJTNnRtTDhHMFpnN1ZNaXR1?=
 =?utf-8?B?YytGNjB3eTh0bnQ3S1NXV1hkeDhjeStYOGRKajV6SENEQWEwc29Lai84MUox?=
 =?utf-8?B?elJsMXRjVk1MZk40a3ZpOEN5cVdtejhhUkJrNjRRVUFaUER1VjhlZlppQnM1?=
 =?utf-8?B?TU12SEgxV05YOXdyTWVObERkTEFaTldOc2hobForZlZ3S09lSDNMK21pQkht?=
 =?utf-8?B?YTAxc2RxZzYwVTY4TUZyM0ZYVzJEeklVU3VqdEwyTHNPNytETHdoajlpNlU0?=
 =?utf-8?B?aFN3dFh0a29nRWltaExQVWtNamJ4VEZhMmNVL2lkTjBCa2FEVEd0T2htektH?=
 =?utf-8?B?c2VhbkZXQnFGT2tDbkNoSEFWUHovWElYQm03SEJxTHd0VWtqNG52QjczbGRw?=
 =?utf-8?B?Q2JlNWUzZEIraGJOb3c3SWhkb1NSWXdGQ0ZCeGpGOGpabk1hZ2NzVnBSUC9a?=
 =?utf-8?B?Um1zZDBLMUxrb3UyemVHbngrcmRVdHFsMFFHbllhU2xDemM4eEtPdG85cXNG?=
 =?utf-8?B?QXZzSkIyZGt5dVhIamFCL3NhdmdrYWhpTDJYYUgzY0hGRWh1dDFFTS94NWlF?=
 =?utf-8?B?akhmWUtLKzVQbU95cGkvOE9DSkJyVFpDdEpONDJ2aFVkZXJYYkY4bDZ4a2Va?=
 =?utf-8?B?aWpVZ21xRzR3dVNLMUV2TjF0dStkZXNJU05NYVJBNVNkcVg4TUNRZ2ZQRVNr?=
 =?utf-8?B?SnNhVStoZG9wYldEZmJRdWsxdjcvbTFjQzZvYUU1bHgxRlFKeUZsVmlkbGRI?=
 =?utf-8?B?RCtnZVEwd1o0bG9qbVErT3ppTkpVUWU2c216Ty9uZVhWL2kyL1pBN1hXS0Uv?=
 =?utf-8?B?WGxrQ2ZsVkliTWhULzJESHBadzVzS21RZjh1WGhRV2JRWWoycWNINnF2UHJK?=
 =?utf-8?B?c0t5Zy9BMVV2alExTlJQQjYrOHpVQS9iRUcwLzZIMmFkQkt1R0RQdjJXZjM5?=
 =?utf-8?B?S0N0S0ZZMFlsSkd0R2JENTBQeFBXYXg3MUxVQUR4ZFJLSXdEUWJBV2RwWkZh?=
 =?utf-8?B?NG44V2tmK1JWc3Q1bXo5TXY0Y0o1Q0FpQk9zc2ZmL3FGWk1KaXhJUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 821665cb-1936-495d-c300-08deed55ab96
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:42:14.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCg1Ho+F91K1u2U4akw25nGLSC3qR+idAXDIq/YdG4a4l0ZjKM39iGz4D0bt6PlTrqfBn+9kl3BsppaoaaGDyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6454

On 28.07.26 16:39, Tobias Schaffner wrote:
> Hi all,
> 
> This series introduces EVL test runs with additional stress applied via
> stress-ng, as well as long-term testing. Along the way, I also updated the
> long-term kernel under test from 6.12 to 6.18.
> 
> Please note:
>  * The clock-timer-periodic test currently fails as soon as stress is
>    applied. I proposed "tests: skip clock-timer-periodic on virtual targets"
>    to address this.
>  * On the Raspberry Pi 4, even the 3-minute test exceeds the latency
>    threshold with debugging disabled:
>    latency threshold is exceeded (150000 >= 163.951), aborting.
>    https://gitlab.com/Xenomai/xenomai-images/-/jobs/15353275174

This second issue is basically a "regression" of adding stress-ng,
right? I thought there were some improvements on the kernel side
Philippe recently talked about to address this? Aren't those merged yet,
at least not to 6.18? Do you see similar issues with latest 7.1?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
