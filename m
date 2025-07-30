Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B42727FF
	for <xenomai@lists.linux.dev>; Wed, 30 Jul 2025 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894031; cv=fail; b=KF5R3mC3G1O5A7t4z7cuw0MC/O/IWMldc39DbsOaKNbBAwyfQifQgRR4z3orMx62qsu1IYRmGp3/R12rSFautfT68lqwMuCHzyyYn0Uh6RaqWuJ/1ue8b8c8GxkhIKKLxy1AFaSi/BXx3bhml+U9NBUBBnvfYHyLdywy6OyomP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894031; c=relaxed/simple;
	bh=l3L8/ZPOxVyQOCtjPUgqjyPBV18GUtaM9gI2xXgPWJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ljsJx6NGjhoOrq7xgP/CeLZ7mECWDwXbjvglkg2Zyf9uwJSwtT4JAHMvPrcVdzSYrmZS5EwklUtEG7gF7KMWZqaH1NNh0Z493fCa/sIK8wPG6gc2vyiexlSS1lZCCXsDwexnyEkrAquX9JQZUfyb6WdwstoezhQrSZJHXXrfJwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZlqjZhEx; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZlqjZhEx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poBUisezrXlJHVDzF/UFYut/nBUusJBsYGFQqICTFVRETwFPhjj9n0ncIR3Nvqu78OAt3YyXymrFuMhSqrvYf3f6Fk51oxwNGb3GDaIuuKYSqMPDHDpOmud/wWYQVneWQZP6SZ4n43OovPHNXQloQDHqqYDJdP+vpFLTplRYBGZt+fF9GRN5WRsSLzmaavuyl94i2R0IuZIMkTDJiMTpp9LgqmKavF3LOYGsiRllXTIg/FwhAOHvI1Ki3OeciN+u4PAk+P8VfrW2quUoBHychKuwQmn2zQsK50Z7DrqXJ9FMdUrkHThxMuODCrnaSbg2IBgDhFsa0IUqgBL5Sq9m2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgAHYGKL4N34h494gfRjxL2aRhr19VwsuuQTcY98KOc=;
 b=cu3JPKGfI3WjoMDB7+l9naD8RVzZPl2uOBxLkdXl/W9sI7JJ9mUXP8P/Gg9/YwEWhEHJplW6eaSpgAZtpEGW0uFtYOtBIgxBTRCgtxGGE/qPKjVeo4xqPronphcJ/FVaO+LVmF6LFFKLZWqTnX8XodJfnSBfqjHUugwOMYlYpY7dzAdCtDPfrJpSOfcsdnfIxrkDXt9O1PO2ZJdmXLdK+xcnUVo4idvQt/dVMC2BTvZ2AQO7G1U/0TZx2F62HV988KH1exY7I26Av0Zxw0YsoY825vhIvVz6B6U5+sSPKP55DbbkF6oXQRUimo9jQPlcgARRDTXVbBpME62/dhsTAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgAHYGKL4N34h494gfRjxL2aRhr19VwsuuQTcY98KOc=;
 b=ZlqjZhEx9hxixLuYMIdECI7VTeHtzrKb8uq2DUfjNUIWWX0Joe22LmO1d4zpI1TEdD8jihuwPGzc5kxRsk0jbd97POChfuis1IH+umBqjFtDjI3hSZe4tJt09X4RY/2OR81rF8hxhFccnbtTJq42/b7vIvzWfSOjooKYeNiMdc+A8+YpiNC0uFrL3SQXnUNTuMP1fvAXa3OFc8vdkZInC635mxEFSOdl5M5B9JTpJfNaNv/Ftrktr0A5bRl6RH+QWG4wKgpakbpr0W1F9VdLmdsDhHhJDcXoEZvoTLHKonM58K/cEFLgOjuQS4Bvrec5r64RMt/6vAK0vMj/K8VFog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 16:47:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 16:47:05 +0000
Message-ID: <06d7a9cc-db46-4c4e-bc62-a0c3b6d48c80@siemens.com>
Date: Wed, 30 Jul 2025 18:47:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Replace obsolete AC_CANONICAL_SYSTEM macro
To: guang_feng_wang@163.com, rpm@xenomai.org, florian.bezdeka@siemens.com
Cc: xenomai@lists.linux.dev, wang <guangfeng.wang@siemens.com>
References: <20250720142542.12859-1-guang_feng_wang@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250720142542.12859-1-guang_feng_wang@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0283.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ddafa3-2a16-4b40-24bf-08ddcf88b71d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXZjcjNwUTcxWVRoNjg4VWlHTG1mSi9KOE1PbGRpUzFtSmI2VVpCRk1KMStT?=
 =?utf-8?B?NnM2OVFwd0Q5Ny9qT2pQU1Q3UjZuSnVQZnNKdEp0YkdxU3VDc3lDVHdjendM?=
 =?utf-8?B?UHhIWkV3MDB4UG1WUlI1WG12RkZuU1dPY2ZPNkJ3N2pCdjRSSUFtc0NYYXZ6?=
 =?utf-8?B?ckVWcHpZWnQ4cGxHQkdiRTVCQTdoSEFBaXM4V2lKVnFSSXlzcGVSVzlWRVpJ?=
 =?utf-8?B?TzRQUHJJWVVmK0pZSk03Vk5Da2lLVXdDbXlqeWlxdURqVGhCV1FDeVhLL1ZP?=
 =?utf-8?B?MDU0aERYU2tSMzZoSjRjRVFwak9PeE5NUlBlaFBkZG14ZWpGMW1QWVhEVmNL?=
 =?utf-8?B?MVFrVDNZRVliM3diUUFPbXhIS1lhRzZwVE10S3F4c1dPYUwvejlMd2hTeHdK?=
 =?utf-8?B?MVZwRWZyKzJPdUhIdW13dERHY2N5WmxhYkZSUktiZUo2UG9Qc2RmMG8yYk4z?=
 =?utf-8?B?Q01uUmN2UUFaZFE2Ukl1RTJmcDhGL3kwUU1PeU9Xc1VldXE3ZnkrVUFNbEp1?=
 =?utf-8?B?WnBxdnYwN0ZsNUo0ZXUrbEt2UENTVnhKM0hSREwvNlBHb1d2bHZNQS9idGs1?=
 =?utf-8?B?WnFod1MvOTdlQ1hDTXhIV1F4SnVSSDhOQXQwRUkvamtNakhBdGxiYndLZ0VE?=
 =?utf-8?B?WUw5VE9MYXl2bXkwczN3VnM5eDVCZjdpTU5sRWtLcnZrN3BHcDk0TXFxREtr?=
 =?utf-8?B?akgrMjBnVkpFQkxTSElvYjdWSnM5b3l2VXFlN1gvM0txTzYyeU83YS81dHh3?=
 =?utf-8?B?WklmYXJFWkd3d0JIQUdwQjRaYllrSE1sZzZpdjVZYUtxY2s2cXFaQ1JIVDM1?=
 =?utf-8?B?V1cyWmlwRVFwMXFLNFJBVG02T3B3cEZrL3Zrc3FhNmRVY2pYUmF0QXhPdlIx?=
 =?utf-8?B?RVRRN2tLcnFRSXZnb056N3dtaDEyRk95Y1IxMi96bG9ZQTR5VjNna2hsOGxv?=
 =?utf-8?B?THd2cnl4N1VSbnNnMHhhVDlEWG0yN2lzbkpUdkxaVCtZaUlCa3llRHR0cG9Z?=
 =?utf-8?B?MUtsaGQ5MmxOc1dEQ0Z3dFNYMHNQQjk0QUJSNVNWL3hvaG5wNFFzbXlNeVZp?=
 =?utf-8?B?SmpSYWVmY05NWjhiYTFMN1gwd2F3Q2J4YkhVVXg1V1NlcXNncDhGZlMxUi9u?=
 =?utf-8?B?clAzNEs4QTZOYnZLeTlpd0orL1JUWVI0RTFnREwya2NacWtSb2pmNytYbDF4?=
 =?utf-8?B?NWttZmlPVVJXVUpMUURMODN3NHZXR1lGcFNjNG1RcVlpc2lEK3J2RDlPSEE2?=
 =?utf-8?B?M3k0Y2hZVU9tZDc3UC8xM2dvcVVJS0IrOHJqQXNkbUtNMmppOEFocXJQRndi?=
 =?utf-8?B?Q0RXeUdIUFcyR0k0MGpBNU4yMnNUUEZZTFUxcW82U2cvd0tXZE1aRnJtMk5a?=
 =?utf-8?B?RFJvcGhqRzZUc3ZTeVR0V1RzOXQ2WjcvTDR3ejJkN1JmL3RwOFNMaVFOa3ZU?=
 =?utf-8?B?bWFhM2VOUVN5YnhoRUt2WkhVK1lGbDE2SFdEMGZxRVJuNU0zNHdKVDFhNmYy?=
 =?utf-8?B?TWdsZEpqQmRuMjlzcTFZNy9PdjdjN3NzTnEranJ5c3N1MXB1MVJMd0ZQWmpx?=
 =?utf-8?B?SVIwa290aVJLQmJtQkErREFmN3pMcDBkeXN0RDFJcmx3b0VXOXZOWjNhSkVW?=
 =?utf-8?B?MHBZN2EvVE1ZM3JDK05iQS9OREFXMEVpanRKLzloWVFBRnNtZnY4eVNyOVFr?=
 =?utf-8?B?eWsrdnY3c1dwVElzRnRENU9OQm92Q3B0R1F3L1NVdENsQVhTUWtqL3B2cjln?=
 =?utf-8?B?MmdSOXhxMVVYUjJPWWUvc1J3UUNlOGwzMU5YZlZYaXN4VWxzSlFVeDV6OVhy?=
 =?utf-8?B?S2l6R2puR3Q0Uml2UkRzQjFoRjN0VUNGYUdLNmI0Wld3eTFFTktXQWRLR2Vr?=
 =?utf-8?B?TUVvK00yNTNTTlVOWXB0cnpIMER3NHB6QzB2U0tsZE02eUcrRWQ1WVdKdHdR?=
 =?utf-8?Q?j3F+3W3Dr6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE8rbHZnRFN1a2drdnM2WTd4RzhJcm11Q1Vsa0c1MTRaaXpwTnJLR2dQVEIv?=
 =?utf-8?B?eTMycGdmc1lzcjhjZS9jZENqaGRyZ3NBRGljRE1zTmVERm1LK2ptM045TXlT?=
 =?utf-8?B?eVFiKzJCZTg4eVJMYVQ5cGZUSjZVeTRmakxDbzZnNEdBUTY5NC9GNDZFZ3B2?=
 =?utf-8?B?MkJReU1ITjk0RVMvTC8vNjFINmRjeGlQYVc0cUhna1NodWN2dnMwZHdUUjBz?=
 =?utf-8?B?RTgvR3A5SFBtUkRjcVZUTzlvM0p2TEpzOVFVT0xwVVM4WlFGTVZ4SUk1Ujha?=
 =?utf-8?B?OGluQ0RGTWpYT2QrcnpqZzFXWmY1WmpOT01wRkJkOVZhdkppZ01hd1B1ZjdN?=
 =?utf-8?B?azVrMU12NG1STHpIUDVSZFYxbkprckdjWm8vQlZPaS9sNW1JbDI2R2JacjZS?=
 =?utf-8?B?Q3M2OXIxUk5OMHNIZlBaYzcrSXBsR1VGTXdHcm02NFQ2ZzlwVTRrcjkybHNk?=
 =?utf-8?B?MU9ubkMxaHNGWi9xOFBwaXFYSDBuQmt3NVlhUkxPbzRacU94aWlsS2w5RkFF?=
 =?utf-8?B?ZmwrT2pWQms0aGlVMXF5RkM4ZGpBNzRZSVJNaW1DT1NMb0NMYUJJY2laZUlD?=
 =?utf-8?B?Ymg5YWw5UXZJRW04c0VCQzR0THVXamlWYlVyRGlPQ3RWclE0L0k5RHdTT1pE?=
 =?utf-8?B?VmhEMzk2M2RWc3Zab1Y0L0RoN3huN2hHVVhSckhlYjRNc0xMYWFHa2R4OENq?=
 =?utf-8?B?c0E3cTFGS3VMRWZBSXQwM2xjdklOUGxHVzlEZHp5ZHdkUGVHbWRMeGZiMXFn?=
 =?utf-8?B?dDF6NE9hd1BtOC81M3hpenRoa2pKdGxaSDBESnBYa2U0VWRMbDdZRXNwT3lB?=
 =?utf-8?B?bEd4MUpYNFdTQm1xYnFpTXM4aXp1Zno3Zjl3NHFNU092WU1Oa3gzOXFUNWNq?=
 =?utf-8?B?cUtNMzdmR1N4L3BGTnp0STRrZS9reW9CdzB2R24wK0NkbHBlbVg2a3VhUU5N?=
 =?utf-8?B?MEJhSURQSHh6bmlLSzRpRTdWTEFocHlON0RzS3FLOXpSZ0poS01rWC9NWVN0?=
 =?utf-8?B?Mm5ONnJOeWdCRHNrU21FWVJKaW5CYllRUlQ2cTBPQ1RYb0dDZVd5ZVFBQjhR?=
 =?utf-8?B?cXRMcGNyelNEV2g3V2REcHp1NVp1dEt4M29IR3RVcEs5UTgvUDNHYUFPUTRW?=
 =?utf-8?B?cmQ5UGx0VzluSFZRVFM1akxjaTNIbVRKZlhKK29TV21qT2tuRDBSVE85YmRa?=
 =?utf-8?B?dDFGYnl3eDNaSFo3ZzdRaW9meXl6TUlFR2N2ZzljQ09iZW43bnRxaC9OMVBD?=
 =?utf-8?B?eG5RMGZQcXI5Qmplemx1VGtUS2VmaVkyamNSNlVPa3IxTldYVW9sK1NIZGRk?=
 =?utf-8?B?Y2wyRndlY1RLSjBPbUNCWGtYQWNZQnJNSnl6S2R3QWk0c1RVNVJzSHJlYWth?=
 =?utf-8?B?VXN6S29JWXJlSndIVk42ZTNicWs4MmRjcEZUbHdwZXlkQm9qRU5BV2R4N0dv?=
 =?utf-8?B?L3UvcHhMbnBHaGt2cDNvK3VWYUFBVitURG1wTzBtR1NCMW9qSDJqLzNFVFVN?=
 =?utf-8?B?U2xVNUUwbGlHaTNlcDV5bElMdEp2cjM5NDZZaTJCRnB1V2lPR2VocUhidWFW?=
 =?utf-8?B?RDRxOHBuYzlzU25KYis1V3F2UGYva292VXVoek95MmlyWUYxQm1Qd0gweXdH?=
 =?utf-8?B?amVCNEt4cXNRVDh3b1RjNnRtVjVGNCtWLzViV2c5SGVnb2RqcmRjd3pjcWNK?=
 =?utf-8?B?QUFNbEYvcnZJQ0dYcUhZQmY1UlRQS0pBcnlEd3VhRCtVVWtlUlpOMkhIK0R0?=
 =?utf-8?B?eXhhSFBxaSs4TVdjMk5NT2hCRDhrNHEyR1V3UldleXNXUVEvN01JbDI3a1ll?=
 =?utf-8?B?RGoyNnFVaFROVG9RNjhCeVpVU0IrV3J4cXMyTXdjRGhaUk45eXg1clFuVnZM?=
 =?utf-8?B?Z0c4T3RnUFZZTlVCbkdJZ0VERXJ0UWFMeHZlSnpmRXl0WENBbTROcFNXRUxY?=
 =?utf-8?B?UFhyRk8rMFp0NGpEWFcramdnSVdmd3UrcmlTOUxFRnJycHlveHhJVEVySVo5?=
 =?utf-8?B?RWlEREtEdlA4TXI5T2lkUkVsMnRJOGRqUXNWOFgxa3NiK2JMT2xtZGtrTEJ4?=
 =?utf-8?B?NmNaUVNsS3k2U1FiWXpyTDZKdGZEcmdpZUJzVlgvZ0YxVVVVU0NhcktmMldW?=
 =?utf-8?Q?eXpaxZgaPmLQlsoXil1qP9S9F?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ddafa3-2a16-4b40-24bf-08ddcf88b71d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 16:47:05.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/Y4SUDH7VlBfcIsQ+3XmVcuwW6Ixse+Kz3H88qpxBb7VZfjgEdtCLc1B8MQchSNbrJwAmYS6ea5/cjkStliUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5166

On 20.07.25 16:25, guang_feng_wang@163.com wrote:
> From: wang <guangfeng.wang@siemens.com>
> 
> The macro `AC_CANONICAL_SYSTEM` is obsolete and triggers warnings
> in modern autoconf.

Can we define which version of autoconf started to trigger this? And
where it is printed? I have 2.69 here e.g., and it remained silent
during scripts/bootstrap.

> This patch replaces it with the recommended macros to silence
> these warnings.
> 
> Signed-off-by: wang <guangfeng.wang@siemens.com>
> ---
>  config/ac_prog_cc_for_build.m4 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/config/ac_prog_cc_for_build.m4 b/config/ac_prog_cc_for_build.m4
> index 8cba24927..2c78c3f6b 100644
> --- a/config/ac_prog_cc_for_build.m4
> +++ b/config/ac_prog_cc_for_build.m4
> @@ -5,7 +5,9 @@ AC_DEFUN([AC_PROG_CC_FOR_BUILD], [dnl
>  AC_REQUIRE([AC_PROG_CC])dnl
>  AC_REQUIRE([AC_PROG_CPP])dnl
>  AC_REQUIRE([AC_EXEEXT])dnl
> -AC_REQUIRE([AC_CANONICAL_SYSTEM])dnl
> +AC_REQUIRE([AC_CANONICAL_BUILD])dnl
> +AC_REQUIRE([AC_CANONICAL_HOST])dnl
> +AC_REQUIRE([AC_CANONICAL_TARGET])dnl

Do we need to list them all?

"The user is encouraged to use either AC_CANONICAL_BUILD, or
AC_CANONICAL_HOST, or AC_CANONICAL_TARGET, depending on the needs. Using
AC_CANONICAL_TARGET is enough to run the two other macros [...]".

But we actually use AC_CANONICAL_BUILD and AC_CANONICAL_HOST in
configure.ac.

Jan

>  dnl
>  pushdef([AC_TRY_COMPILER], [
>  cat > conftest.$ac_ext << EOF

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
