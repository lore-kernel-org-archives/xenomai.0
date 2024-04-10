Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2091.outbound.protection.outlook.com [40.107.249.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4124BEAD0
	for <xenomai@lists.linux.dev>; Wed, 10 Apr 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738128; cv=fail; b=QGdLxjrUISP+KoMPaFDoroXS21E+xPxM3jsW4Zf/U7tw4Q9ISXDq6y2pNnbHkezOFmNj+8whLJTKSi2HlbHbV68uQFKxvfMT26l+Mym6p6TloKWvBxuxKbu7SeAd8JKpN8oxF2b1M5eeXjgIzShSM+KpuGxuJpfIq/dMAqfQYds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738128; c=relaxed/simple;
	bh=ywLXVfDfEq92r0QRjH4FlU1V0gYjXZiy/JNcB8o/wI0=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d3SEDvoamNNvvJN9i+TEy/F5T3GTiST3Side2DeEvjB9/Zr1U8aC7Z1J76V8tDRMuppuDECylYhM4T4E6Y+UA2zEMfOT8X7n3j5mVzyW+IxZDGfSBY/QuDlKmZLmG5qs3vIqBJXYGNGTq/8+RHpX7SAIsOER+QHAyY92LgAywU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=AdDCcVpR; arc=fail smtp.client-ip=40.107.249.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="AdDCcVpR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ykfo6Szu6HDoYCFEUtYLs1tA0xNVyWzDmN0PRMzzNipRfouX74BRbWrGY1mR7U5UY1CjNx3fL9yc77g0EqlWoiOq+QYyOpQpWs4H/HLqOpAgdOsP1PJboE/rJGxlrtwJeicjZf911I1OEkgADrhSQaho95aZ5YikEfnCst2xSJQTEMZwocGbe7cygX5WjX/60f5v63HBU6LypltnQuLpAWordWMZ/NrEmII3ei72TvXyUVKzAKZ1knxNMgZeD2ffsG94zZOy6emoLTB8yuFxEdnwGEEZ3ehN5IOiVAK0xMTVYArj2EY/zpb6E40jZGrJicYEH1FANRI+IKqVLK313w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rTDDPG8u6yyU8kCbwqFtAXNx99v9SURsTtCV8RayDU=;
 b=H2A4Kpmyd/yiS5mo9C8MnZU/qnBkjmxpL7WkbkxjbbX6UW4vTJMVS4yo14gxDtcLEpNkLZ7nP0g+3V1B5o5RAVpjPricHURHL8FGFBVUgLWYF2ctQgZTQt2CLwo7AIqoCS9U4G5roM9nX294/t+J+OM3BNWO9ZE3k/2i9TkN+w3lWYbzEagwrjmtN4iujy8qFzXC48ZBdgTBTLHMbZijn0JAJvam1WgxaQ94OSB6pW2ZE16CfaYey8Xc4Qx/M1cdD8bbra+R4tdNM7sReSrmRkGVfc6Q9SsVwMBPZklcBSO5TaZY+ZxJkBC9EMYFx8hNbAJV7hwuDNgkF2yzb2Fr7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rTDDPG8u6yyU8kCbwqFtAXNx99v9SURsTtCV8RayDU=;
 b=AdDCcVpRbPm7rhaKxMZOBCIezQbnLIWstN4elER2hyJ966vhc6FsH49qA1eytKoIIVT2PfzT+FHuVPiUe4cAjossIb3di4XOmVt/tCyPdulxB0mOMjEYz4MtlVvR4D61HyHPP5pPNykYbj95olFQXn2MG+MBkPl2CEVZUTxaZkdi5x7gIXQTOGnL4nSWOtR3sKR37s+6oYSqejNffOPqN7sW4Pr4cpQKPPZXqPysq1lrmJPVgu0rK0j99G8Fnl4wB2koq0BXjiyasq5VunbUbdbFDFjpcsoykA9utsQaxl1jMKieZeYPlZRkJGCfdgJ+g/CzCn41fBcvpBcltJGUhg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7273.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 08:35:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 08:35:19 +0000
Message-ID: <a7a3f155-934e-433c-b89c-e181f0bdc914@siemens.com>
Date: Wed, 10 Apr 2024 10:35:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail 5.15-5.10 0/2] dovetail: x86: Backports for
 recent compat fixes
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev,
 Philippe Gerum <rpm@xenomai.org>
References: <20240304-v5-10-y-dovetail-rebase-v1-0-e8010867dbbe@siemens.com>
 <4518cde8-777f-40fb-8598-8b29400d8f51@siemens.com>
Content-Language: en-US
In-Reply-To: <4518cde8-777f-40fb-8598-8b29400d8f51@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7273:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PenSa3Plt1iMvmU/HqQlbkp1jfZ/1+mFUjArxglUQOLsD+ZJN3gz0DVLX2zSGzOlttl3pvOsT4lt/PS8rUFrOW2XOlojOoeZJzNwJU2moUEToS1RKQHWShgJKc9FNU1r6GwsPPfXOBZkYxb3kHbs0YC/LGcRvD+7UfF9fTW0vncXaTgezehwKKtNJLItzWa51gZtdca0hT8W111zv8a74BEwSBpVcgooD7C9RgKiwfRGdfzKiMigCZZxBrwQpKB9KREDmJSG1lr6iSrgfVn+YT+N6U+G8A9o3/RFS+zMgeD8R4kw45JAnTgBXGq2uZsIlbMsfy2LGaL6rmiWOgSxUb4/Aeh+rYT6LfbMR/+BUiXxDqdgkIYaBo95l0wa3iGFr57Yr+Rggg+3uzgDqFMP9QUa2UERlFyUlxX3Py6SN7FMkgerOwM8cp661zKsecvM+spBQgtdaobRHO+t9ERiN6EMjTNOpYOmlxO4APzdV9YBYHbBkz/vwO7EFnMIKhQrCEFBi4oP9vDp7VGemVx0jdf8viKi+rqDTGsl1EC4LnBTIRXXCbHBIqqbtgzv6vvV9jW23kGS8DSAXt3puqmnRhkzpycoOFQJN41Bla4wCuVBTKeNNE7V+MpOufRTVqT1rZAPWT7ave4EDohFB3oBrlmGPfCRPrXfxVFUv+z17UY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alFsYm1DbWRnNmloajBqb3cwNzlHMGRHZytxWjNGS2FzVXgwbFdxTHRyaTE5?=
 =?utf-8?B?d0xDL2xoS3UwQTdxNHJSZ3hmaGhYNktZNVFHakY5emVVT2Q2SVBmcVdneXpF?=
 =?utf-8?B?c1o5OEE3SjFva2RsSlhOSmlpTUF5ZkRnZkNnN3Q5a3JWNUNnVXZpV3RLKzJX?=
 =?utf-8?B?V3RiRWk3ZWdEUWxXNTh5cTR5L1R2dmNYd1FGQVBScGdaZndHaW1uMjl0cnVm?=
 =?utf-8?B?WjV0QzAvbkY1TnFnemhBMjV6MGZSUWxVNVMzZGxWdUlrLzBxRXJiOGVvZkVr?=
 =?utf-8?B?N2pTR0N3MUhZRThBN1pjNWpCN0RmaDRlVURkYUQ0MTBZSEZ4TlBjdEVJVXNj?=
 =?utf-8?B?UnorRkRrdDZ0NFBteUdDWWViVE5RVnRFa1RIZGErQVRlTkl3MDVkYVhXZ01q?=
 =?utf-8?B?MjA5L25lSlhTMlNkZzlkMWRKem1HcVdESm52Ry9JMnhNUW1nZDVQWkRHa0No?=
 =?utf-8?B?NVp1enpIK2hYMkMvTjRHeWwzV0c3NlR4MmIxNmhyQkpoc0RYTjZ6SHRXcHQx?=
 =?utf-8?B?bmRTZnd1QnllK1E4Y0JVS00rbXRPcFphRnVISWUvQVFWV2NMZlJrVFpsb0E1?=
 =?utf-8?B?WVhHZlJJemhRUVBjeG42WTNBNEJTYTVVYTA5Tk1VRy9lU1QyclJxNEI0T3Bw?=
 =?utf-8?B?RFhhTXJkRVdQNUY5Qm15UlVFYzlnbFFHQm9LWkhFb3VlUDBVeWJ0SXJtQ0ZJ?=
 =?utf-8?B?NkN0Yk15ZmZwblJDVG1mSTFBM1UzYnBTS1JLdmV1SVJVVm9YZnczd2lFdWk2?=
 =?utf-8?B?TG1oSTlmTzByZGJIU1JoSmhWQVp6K0VaQlNOTXJkcU8xVmxZdjNuN29WNGN6?=
 =?utf-8?B?REgvRVUzWXdHaWVYWW5Cd3RhNTZrQ3VsZmViaERFelBOT0hpQ2w4SU9EUUVl?=
 =?utf-8?B?cU1hOThXb2pCVDJmSW9ZelhGZHcvVElMVHhibUVJd0tMNXNFU2pjT0hzWWN5?=
 =?utf-8?B?eStJa1lnNlRDdmF0VUU0UzlVRjJHMGUzamordVM5bFljL0RUSjMwRk5vWnhz?=
 =?utf-8?B?L2lkbkNNMEdDTVBSc2JqL3lJMHpqQUdoaGhsYit3NXgxL1BXT0t6K0FkWE5X?=
 =?utf-8?B?Y0hoV1B2d0d6cjVDK0NGYjhWZXc1UTNyQTVnWVVmR1pKazZzblJ5YXg3L0hh?=
 =?utf-8?B?alJDYStEQndJVkVHNVJQY1BwTzV4RUhyUHlMbnhVbjJ6VXpLcGQydlZGbTJD?=
 =?utf-8?B?R2pSSXdkVUFXcEI3YXFFV3VPejJtb2tWbkpBVDg5QU5ZdGt5dHFyYlpoVk1z?=
 =?utf-8?B?QjBrdEgzeDZnZ2VRak1iWWlVWTNnNklrZXIzRGQ3bUphekM5bTBMSXFOZy9I?=
 =?utf-8?B?a3o2RFIvWUgwc2lwMFdEcDY3c0xiVjhab1U4SWFJeTNpZWsvRnVvaXFmWXB3?=
 =?utf-8?B?a0doTVUxZVdXN093QnZTU3J0QVg0bEwzVmY3eW41amUzdlJ0NXVKcVJ1bXkv?=
 =?utf-8?B?bWFVNWZHanZ2T3NjQjN5YTlmd2ZSSFdCbWRxWTlTWkJ4eHl5WGduQ1IyOVhX?=
 =?utf-8?B?SkE0WFpWZHlPNW9XQmdXSC9zQ3B3YWpLV2gveitIaVdwU2hHTGhNWENaNk9Z?=
 =?utf-8?B?N05VTm14aitHVi9pdjFHSmxzU0N2YUJFcEszeGJJblNLUkpVYU9SZUh2Y0Fz?=
 =?utf-8?B?OHpPdXI2K01PUGNJM2lQeCtLN1pHZDdYaHFHYUVhNmpHbjhhakRBMW5HWEky?=
 =?utf-8?B?TlY0SWNiQ2htTFJFZzBVNU9LOTdXUGhuNERmQ0I3THJ5V2NheTU4amZPR0FJ?=
 =?utf-8?B?aXVKcExhWHlBM0tta29WWmxEaWJoOCtrdTBiTFJod3VwMTBZZmJuT28rWGpR?=
 =?utf-8?B?SldMQTlaME5vM0V3TGQ1YXlWRURmR2FSSDB0dlZTVEpiWjArVGxzOWxFVUZx?=
 =?utf-8?B?Ulorc1d6NzBHbkZ0Q0FSWVVodjlmT1pBSUVDa1cxaXJzWVk3NEZCVTNjS3NX?=
 =?utf-8?B?Y1dqSDlYcHJJdXIzYUNFbGRuN2c1WUNUUjBWRDVWL1VaNm5vaFMwQUVOZnBz?=
 =?utf-8?B?cGRLZ1VyYVFzdnlETUZPZ2NIaUY2bjRCdFdDSVRUTStQYUFGZnJGbnZWWGVa?=
 =?utf-8?B?TkxMTlZ0d3V0dFloTWErd29DYlZRSnFPb3Bjd212LzhBVjhtSEROMW1CeTRr?=
 =?utf-8?Q?BKBW1RXop1u6Gh9no+1ieVqiw?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcff225-2e22-45a0-bbda-08dc593927d0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 08:35:19.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEL5bw1j24IjYga7cVqv1WENLBz8EmuVYzxSs2a9h5Osac3ZLH9EvlLDqfV+6KVOp4/REpIDWdXbZq3K7oP4MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7273

On 08.04.24 15:12, Jan Kiszka wrote:
> On 04.03.24 14:00, Florian Bezdeka wrote:
>> Hi Philippe, Hi Jan, Hi all,
>>
>> here are the backports of recent compat fixes targeting the 5.15 and 5.10 
>> branches.
>>
>> The original series that made it into recent development branches was
>> published here:
>>
>> Link: https://lore.kernel.org/xenomai/878r2yfi2j.fsf@xenomai.org/T/
>>
>> @Philippe: I think Jan is still waiting for some clarifications about
>> maintenance topics. Would be nice if we could sort that out. The
>> maintenance state of some branches is currently unclear - at least to
>> me.
>>
>> CC: Jan Kiszka <jan.kiszka@siemens.com>
>> CC: Philippe Gerum <rpm@xenomai.org>
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>> Florian Bezdeka (2):
>>       dovetail: x86: Fix detection of prctl based compat syscalls
>>       dovetail: arch: Fix fetching of the first syscall argument from compat tasks
>>
>>  arch/arm/include/asm/syscall.h   | 3 ++-
>>  arch/arm64/include/asm/syscall.h | 3 ++-
>>  arch/x86/include/asm/dovetail.h  | 9 +++++++++
>>  arch/x86/include/asm/syscall.h   | 7 ++++++-
>>  kernel/dovetail.c                | 5 ++++-
>>  5 files changed, 23 insertions(+), 4 deletions(-)
>> ---
>> base-commit: d7226e2eecda5b73a4c8fea85226ea4444038b00
>> change-id: 20240304-v5-10-y-dovetail-rebase-43caf7d6a2e2
>>
>> Best regards,
> 
> Those reached 5.15 via my last update from newer kernels but didn't make
> it into 5.10 yet. Philippe, I would now take over and refresh
> v5.10.y-dovetail[-rebase]. Or do you have anything pending for that
> version on your side? Please let me know.
> 

OK, I moved forward and updated v5.10.y-dovetail-rebase - under test now.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

