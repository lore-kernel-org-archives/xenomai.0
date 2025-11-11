Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011056.outbound.protection.outlook.com [52.101.70.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BBA393DC0
	for <xenomai@lists.linux.dev>; Tue, 11 Nov 2025 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880553; cv=fail; b=fQ41+chaROYvTiZaZtor4cs9rZHTfdSJmMjFsfjQQwPM0i1c5EDTV7d3XQU8yuT6J2ZHgOZ4h5mGPSoqxZ1aZMov5Tu9jwTLJC0mDXDKQpW33GDWfP8DwH6tTvxEBYIdK6tXYj+ohUs3jPEXnpuhxeXOdMlRuaBF9He2R8anX6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880553; c=relaxed/simple;
	bh=u4oX13x4SxZdZ3xKxmntmWXTgOs1Flbv172BSSaKzto=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=nCljzgikiilZp45p8740vmaoGAb6TmL1G7KTGG7TvmKHsMtJfTdjRI6BrZ9gRwLsZibTFD4Io2UIqmWFTjeewTcFL7tYvaIFr5YQkX8E4wEHJOO/MwHcAYCF42RmOcIU+prPc+8FNlDl3fPyxpWhfc1CubHqOZHukG6N9x5+BYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=tT57KEaw; arc=fail smtp.client-ip=52.101.70.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="tT57KEaw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrIA6wtTkelTp4CIpMMYvBZhU+WTgW3QisUb7eEFsj/6IICVEhUh31MtHuXlCsTQDt8Ie0i4nxdjWp8MMA9sSFFl+mwNsJDzxQu08BbvKwx6xj+L+AkmshE8it2KyFipUsXwInTVp0A8yxp6XLwXov8bEoDJBZ3wL2kQBbpUNluICcrMMMMSFzgSUZbmSu0cHz7HXr7vt/vCgCFoUOBgG3uQ13cg1jKNGKEQRle7tFXogFPIEbDd1H9aoY0rNJOxfpAxzI8uf05h6LJ2VUXYhKXUFCg2LflwztI53pu4dyPlIfY7xdL3CTE0lq/gqvwn3saYacmmTCcShgZVLYxadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z10Zh7y+J6Meujs6UI7g4HJ9GbU90MBt+ZNKZm11w2M=;
 b=mcg/oBruRecr657lX1pDqRl+DTG9QYgagDejRI/9zZukltcIXXxepp5IhFC/Kayard/o8CFy1pqeuHP2DTZho+L/4FOUsFPa2zf5ceBoQNisBfeuFAGl/GWL0waxckRA/2ROyEHA1WE4cTSVEbwBHfQ3Kr6BHjFJSEjVtqTCx9JyiOw4QcRXNFjTBP1ntS7z8JLODf6duFJHcxymDtIUGmJSH2mVhOaKxh2jJDbMKDoQsSPynBhHJMSAQ9qPQYyWiyUr0rT35VySmup+6N1GDhm8qmU89Bh/Svzo0L7fehFvPKytIw/bi2k1wfT58eAcjnGtvvFgle2ObG/kRWmuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z10Zh7y+J6Meujs6UI7g4HJ9GbU90MBt+ZNKZm11w2M=;
 b=tT57KEawBjtZNEJBAUEEQWqUWmbeYCBNEVhuIRV0Jz2ULAFURZjCfmWSKD5aCXRE/OBQuQ78vJV1OTNbV6j6yipQUbHq2xwT9XLUSspqANa+Nk0Kilp52kGQqTKrpZOg18j6xfvabpFk6oL/cem+yTo7d5w1fqrmCjRvsfvREK+JeIO/oTPldJbJAPkosbSJGa1PE50rZRf40dct1pyZyi/+Bh9bWYXlv1FvX5IRHBFbZZjBiVuA10KzULTzcsweQOTUBwgRXTnx7N3JsgNtZ0wqVmPBEmXf1Iokp68BUpK1y3bPtmuZS7i0LfjaUkFaaueRx4P9gvl6IFaBpDWbKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 17:02:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 17:02:27 +0000
Message-ID: <84e205ca-76fc-4a34-abef-f614867bdee4@siemens.com>
Date: Tue, 11 Nov 2025 18:02:26 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Xenomai community call on Wednesday, November 12, 2025, UTC 7:30 AM
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: 284e8a79-6312-497e-045f-08de214417bc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Und2T05SUUNmdkVCK0Jma3Fad09tZ2p5TkpUSGU2QndmNW4rZE5UaXl4aFVO?=
 =?utf-8?B?eTMybEZSUjZHMmpIUXh0TmxIck43RkdBVUVRdDVsWTdGQWN1V2lIWml5VWtt?=
 =?utf-8?B?RjQzK0h2cCtLSVhKYzB2V3dqVzAxSjk3bXIvWDhYQWQ2bUhHN2k2UFFiN3ZD?=
 =?utf-8?B?TjlXazNCelB4VDNYcG5xakh2ZlJxK1ZVdzcyVmNRU0xDQXZibVBLdjBOVXE1?=
 =?utf-8?B?OTBKNFRRTnV5SndDQ2VOeU1VbWtmejA0YTFUb1d5c2dKc3oxRU9OSVFKRFJB?=
 =?utf-8?B?b2RoSGFLLzlJQVEreTVzV2hCalFjYkpNUldCaml0RHhtaUFMeGZPUkJSdUVi?=
 =?utf-8?B?TlZlQjRUNzNNRlVKTE1pUVBDQWFtOEp3a3FOK21NVzJkOXR5Qjl5R3FxZXc1?=
 =?utf-8?B?d0pVcFFWRGdSWFB2b0dyaDNkMGM2OXRWd0l1K29nUksvMTlFY3lVY1pxTURq?=
 =?utf-8?B?dkxtRFVMb0tHL1V0dWQ1OUZIU2hPVFl2MjZBV1BibEhRMndVTERUekhCWDVX?=
 =?utf-8?B?Qnlvd1lvbmRuU1VQaDNqcTE3R2grOVpoNlRvZ09Vd0p5d0VhdTVXSFN1RTlh?=
 =?utf-8?B?eFdqS1RybU0zMVZpbllqemhSUlNXYTZtSk05Q08wTFFFR1g1dGR4QkcwWHRt?=
 =?utf-8?B?aFkrWFRXVGYrODh2bGtnMHZCZGI5MS81UUttUkFtbnJUT0VZYUpJV3VMaG1u?=
 =?utf-8?B?dTZSRDBrRXVxWm5OZ2I0N2krWUFrRDVpZWYvcWlPSWJvdlh4MEZzSGoyN2FG?=
 =?utf-8?B?TmFiRzRvMDZ4VmNOM1ZCVDI1Z3pmNENPZkhKVVFBeDF4UTlzM0ZMTlc1empm?=
 =?utf-8?B?Wk1uN2NlS1JWYmdia0h0ZVBKNjYwdkdKVml5eGpXd1BjNnowOUdGRzNjY0JF?=
 =?utf-8?B?TUl6bis3NWlpOFdwTFhIVHJWYnVhbjU0TENDaXZGK2FDVWJ2dGpRZjVlTmpE?=
 =?utf-8?B?YnViRlpadmdLZG52djEyTGk2WllkaDNpU0FnRU1qYXFWbDloUzBwUnFJUlVp?=
 =?utf-8?B?ak9zQzFyeFljOEJNWHUwc3Y4TlkyZTk2RXF4UHVBOHhUbWQ4U0xQYWZMTk54?=
 =?utf-8?B?VmNCY3VrK2hVb05nRFBmaXNacDh1Szd3L0p3L0h2UkNITU1VWHV4RU5YMUhK?=
 =?utf-8?B?SWZYRGFsaUEyZlRsSXRNaGx6dnhwR0puM1RCTXRwS3NYa1pUNzZqb3JDNThn?=
 =?utf-8?B?WGlQWm5seXVQL3UrRjdjWWQ2MWpnaXN5UFJZYkdQbkRQdDAvaUZmNzkxVnFS?=
 =?utf-8?B?RG9LRHBGaHFtR0pnd3F3Q1ZHWnhpWkxwL3M2K1VBemkzZTZJR2w2S2QybTlC?=
 =?utf-8?B?d2lob2c2UEVYM2YyMDRrMW1iM0MxRkMzNTUwbTFhVVJBUGlPUmZBc1ZwdExN?=
 =?utf-8?B?QVlwdFhGRUNOMlVxMTJyV2ZQQlo0ZHAvMmZGamlBN2dtUzNMZlUvSXIyZlpz?=
 =?utf-8?B?aXRVd0lpbGdyT25KYUNGVkxjTTlLSldVeGhpbi9RSk9Td2xxS3NpZ3NJWlVF?=
 =?utf-8?B?bzlaeFBCNlJuWng3MjM1Y3RGczBGRFhtYTN5bU9QQVVwdmFVRUt4Wi8vMmVa?=
 =?utf-8?B?Ym0yQzlPM0c0aEY2emJqd0VrOE9pQ21EemNuQnhKblZTOFBYU2ZUUTlZL3NW?=
 =?utf-8?B?RGRBTDY4NlpEbTZlZE5GLzBwaWpEYitkZmlteEpUdExTcmlLZTBxWU96Q0JE?=
 =?utf-8?B?MFJjY0xzVS8zTzBMNlA2VUdqeDRLZytzTnJ0UDdYWWVXVGowU3NSS1RzczlW?=
 =?utf-8?B?aE04K2gxa1c0OGllQVBScUR4RnJNanJGRVg3TzhJWjlFdHJyVk9zNjZDRW5S?=
 =?utf-8?B?ekJvZHRzcXFxcSt4cHZYQ3dUd1h1dm9OTHk0Q0lFbjk2T2dYYkZ0c0t2QzQ0?=
 =?utf-8?B?Tkc1L0tnb1V1RXZEbEp6aTFEZHI5eXJQSS9qdEZDNUpDTm4xMFNKUmNtaE42?=
 =?utf-8?Q?bA52JoTBIJ6/Ay3lqjFXXUwrkp+0Myiv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXZLZ3VzZ0NtYTZPbnR4Yk9vaUQrZ0lxYXp0QmxJK2wyMVUxUDh1ckV2aFdp?=
 =?utf-8?B?RWVoWlpNNXZGT2k2b0hGWEttWUwzSEJJazVZRG9PM2hCcExlb0NNdVd1WHB3?=
 =?utf-8?B?SHErejdNWUpDNDhTVUhHYVVJZmIwOFNCMVdqL0w5cVlUS2Jqam9xaldpTFNo?=
 =?utf-8?B?bWhLNDZYM1I5cjFxVlRaVVhwcmIzYkZEb3RSZm1QSWtaSCs2U1QxRGt0c1Z5?=
 =?utf-8?B?cVV4RURuTzdFK0liazNyZlRKUXY2K1I3ZHYyeFNvQ1VqMG5qZG9kdUpzSERn?=
 =?utf-8?B?UzFaQS9jYkl1QTFlTVBNV2N0WlkxbXl4U2FLaHpsUyt1Y2RjeHYxTGljVDYy?=
 =?utf-8?B?T0FnbTBVWVJPMzNlWkg4UGx2c2g3L0twNDNZNm9mLzhwaW1sYUtMYUMrMTgx?=
 =?utf-8?B?YlNBc0ZvV2R2WEwvRkNxbll3RDhnbnJ0TFR1R1JZOVpTdDRVcGpiMExTeUFK?=
 =?utf-8?B?S3huZm9OdUM4YTloa1lPcm02TGFqc1VTa0tKWndKdnZlVWtMZU1YNzZHaUhO?=
 =?utf-8?B?MUIybzVSeVdDelVXVFNYZGd0Y3dxNUhzeWJOZUgybE0wc3hvejNrM0tqZExI?=
 =?utf-8?B?aGQxMitxd3hTUU9DYkZaczNhQ0EzY1B3S0NLVjlFbVFqRnBmZmxoR2E0SHJw?=
 =?utf-8?B?K0tNRFZaeERkZkxCRHR4U3ROc0NQRHZYa0I5d1FtMEc2b1dLT2NpMkptb3VI?=
 =?utf-8?B?VXJlV01yeXV3bTBXdURyaUUzTkJBTjRHQVhYZjI0ZGpPM1E2MHhsRnA0Z3JT?=
 =?utf-8?B?eWpQbll0QTByNUk0YzIvZHJOT0J5YlpUUG8yQXFTTE1NWjJ3dG90c2lxMGtk?=
 =?utf-8?B?MDZTR1F5dnpzY3dMWmpOYUNpUnloNXVwbStYQmQ0d3FZREhqSEE2cjdGY0JO?=
 =?utf-8?B?UytWcUMxNkVJOGRMWTFHSmpscEw3N2ozWjZQclZDMjFWYWhaQUs4ckdiUk4z?=
 =?utf-8?B?SmVSbUVyRm5GV0M2Y2xidUNLN2ZrbEQ4YUFvNmpoZVFVQ05aZHF0clN1dDkr?=
 =?utf-8?B?VDVJMkZtY1c0ZlhMMWVhdm5DRTQrZVYxV2k2dlBqS0tuRFJycG1KSkRBcjZo?=
 =?utf-8?B?clN6VXpoUGZKSkVKWHlsUG5SdU84aS80UnA2emxmdmJaS1AyaUQrTG1rQ1JD?=
 =?utf-8?B?ZlJwVHNvT3JkYzU5Vllka08wVkJlWWRGRldIanpILzVpRkRKclJmVzg2MmVa?=
 =?utf-8?B?eGxNMDdPMis2bk1ZTWlNc2owQXN5RHhvWVp0WlNHT1R3TktTMTExSzBkdTlq?=
 =?utf-8?B?YlY1OXJSV3FuVXBVQlo0eWx1Z21MZSs3R21iOWI3UCtzSm5NNjVmcUZlTTl3?=
 =?utf-8?B?NUd2Y3pPM2V4UFZJVkpVU0EzTnkxMGsyUGgrMmF6YVpVNWVUK3k0aS8xQ21P?=
 =?utf-8?B?TmgzdWhTeDBwdzFDamd1TUpGVjY5aWZZUU9uZXNWRG0vZFBCR3hNTmVER25l?=
 =?utf-8?B?QVhVdWxBS2RaSjF5QnQyUjY4RmZoK1V4Um5GZVcwWWV2eW00UW5QODNDV0Zs?=
 =?utf-8?B?bVpFV1BwUFE5U0pkclJhdnJJYUR4Y0tmK1lDR0l3amVzQUFZQUhKSmsyN3Vt?=
 =?utf-8?B?aEJIUEM2YjVjOHByeUYrUXA2di9CL2hmVlVrV0pnYjNUcTRBSTZ4WmVWdUVy?=
 =?utf-8?B?M0hrREFDaUxKNUsxM0NnU0czcW5pVmJUVDhjb3hGVGZXRndJdjdQazRlcVB3?=
 =?utf-8?B?U05tMXRYQjhwbnMwRlp3VmQxRll1ZXRaaWpvdlEzS3dndDFGTjQwNWZjTEtJ?=
 =?utf-8?B?dDZpajVXSUNEM0hoT0dPcTQ0MlpMUVJMbjNxSUhJUmlXaWJya3F0N2FoaEd0?=
 =?utf-8?B?OXl0UElwTGZyM1MxZGFqVW0xbmFhMG5BZnZqSE1nNVVLWEFXWncraUxJV2h4?=
 =?utf-8?B?WW5WcWwyak8rS2pVckJRNnl4TVVaZXNkenBSMm5vWE9pUnVJcExxNnVzVFJW?=
 =?utf-8?B?d3I3NHEwY1VlbVFUYVN1Qi9PTXdDUmlLNE5ZOXhKU3RESG5iVVVrR0xaK1NO?=
 =?utf-8?B?d2hqODI2OG1NanRHUTBoR1dYTmxoWUtyRmloWGl5V29YbzdMWTNFYXlQcm9l?=
 =?utf-8?B?TkpCRGdTWnk2a3dpaDVyR0pMSGZwM0t0VUNQVEZTTDkxZFBqOHNrTVg2SWhB?=
 =?utf-8?B?a2pTbVVHbGRGN0h2VCtCbUFpcExyMURZbUIwZHJzaTkwVHlOUTBkQmt5ZGRN?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284e8a79-6312-497e-045f-08de214417bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 17:02:27.4425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlOx+VmDNz+bVKvh0kJlpxzhkRF3w6Y4zebAY563qrRGb7hx1+RHVNAHRpCXUC7UaAKEiCPo8yRfQlT+YKbwFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4057

Topics may include but are not limited to upstream/downstream project
plans, status updates, and technical discussions. It's an open online
meeting that anyone can join and ask questions (you may have to wait for
the organizer to let you in).

Time:
Wednesday, November 12, 2025, UTC 7:30 AM
Paris, France CET 8:30 AM
China CST 3:30 PM

Join Teams Meeting:
https://teams.microsoft.com/l/meetup-join/19%3ameeting_NmQ4NjFlZmItZmE1NS00MzZjLTk3OWMtNzc3N2Q0N2Y2MzM4%40thread.v2/0?context=%7b%22Tid%22%3a%2238ae3bcd-9579-4fd4-adda-b42e1495d55a%22%2c%22Oid%22%3a%22058073ef-2de1-450d-b434-70a67389dcfa%22%7d

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
