Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013061.outbound.protection.outlook.com [52.101.83.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155836404E
	for <xenomai@lists.linux.dev>; Fri, 24 Apr 2026 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777026509; cv=fail; b=ELHNUN4ZjAmvsz2r2kOhyaZTb/WmFcgnytJl7ZdpNj/W4VCoAG5JCzZYHYtWEFADII4eo1VcrRHXzqRDJkRB7biRTMUeBNCmhyAiYAYbCrAvg7gguY5yGPzo/LOXMhHL9HuRp1NfxHJC4rasznuXXK3ZjK1x6G8n/nFSvaz1OF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777026509; c=relaxed/simple;
	bh=1Hhrij7IaLtC6cT+wfer2XM0qt4v3BB9qGR5tAA+PLE=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=fEM9pQ/EC2AMmSgjqaq53pEzxx4h4F2JEtSfVWcjTPeOQx17DPmFdgQ9s/U56n5M/fG10rL7zkNsrXwLZElIvCzHFjIIkpAEXt/mAY6bflsVCvN7RvkLru5l9OoLfJaYnbdsjAgxkZ32dvnkOO7Y5hCDLI14M+JEXnG6GjxucGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aNU+uZbY; arc=fail smtp.client-ip=52.101.83.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aNU+uZbY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LD4NgOmpRqtJx8DjgOTQZ3t8iKz8G6q0P7P+qRKhM0qWNV7lwRrTbr49WmY9RpdomfJoNyW+bu+mk+dsJ83r8hqGBar/K9WgXdkocTSo1i8455+Xa8FgplNveGVu2VRcQl1NpTmNNaXBPSLDkxo49UxlSqKlQ+3VvxmIFxsgUM8YxqlHrS8XzrSPzn6ho9aYK1NuTTqFWvzc0wIXkNyez3sv6cMw7OA5ZFsuRyK/GIaUldvIlJHeTD6b24VxGLSjR7p4BjZjNiPvuP1mX3k5xvL+Hjecws8OdffmfGnFUhYa5GHQpfsbhxoLA9n/E6I6excXKG7GxVqmlOOSad6O3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW2C3dCchIe6VbrWq89fZGa9i/kpC+rQh2ezdgkH/Vg=;
 b=wJw/mJVmxQ1f++m7yDKU07trakiPFcW3+7LAodd9qv015aFvAFl5N8AhpvsO9fhKAJ+5pT17qQtgn2ClnFVocZ9li+M4bNQ04rhw7MWfQEH/oJaSkh4Q2Cmze83qDYWHz20JDukrp7LrttyBXH7lupK8t/s5yhQriAtao64i2Y8pL3yalBk7Yu9wdlzRJnpHGfFWg/A2WUlYWnNr+GbaurvioSXr7PnQNfw1LzTK4yF+ya0Av4bCdl4dwwwxNL3KhH+8HZOE/oUFH2BvD0RFetQiEkTSoTBJ/KNYbzC/hp2OV6eYGTlw0eywL7K7GRb0Qu1Nzh413NS4KGYnAQFGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FW2C3dCchIe6VbrWq89fZGa9i/kpC+rQh2ezdgkH/Vg=;
 b=aNU+uZbY8sz9qBUwUZw8IddgVpmOs4QHcXoyx5hcNtbi+c2gnhHd3FgyNMPkL/6+CkLLcP3KFkexFDbtrh1cXh8ZpaRpEdYMxFzajAXyNZ0we8jeRXECmiUd1LbJC0PTxHuE7eF8oLNxO7aE1qCURM9heQD793YRT3KZhASSmmz50xslBV5ID5+YR84/oydlzBUljFOrzhthL+V9/QdYN9w4z84R3XeYTooAPwFElLtjwO825CQUrpbsxUGRnOGQ4lh+qCV7i9oDqzOAe3ZYEsGWaUexnoqxrPDL3I8mDmh100nu2Zu0jSp3LUa8b+fzGQEisNNUk943Tkbc8tN2ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7294.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 10:28:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:28:24 +0000
Message-ID: <832b9a0f-f8b1-412c-81c0-c723edf536f3@siemens.com>
Date: Fri, 24 Apr 2026 12:28:24 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.2.9 released
To: Xenomai <xenomai@lists.linux.dev>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: bd091547-b2c6-4b0f-22c8-08dea1ec374a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	ZljdjKBciZqwHxTEIFMskk2VTGDc5u7EVXpnuoWlElR4Iks5JkahtrCYyb8igq+ljCBmNosoyynxtGKeTWIvn2kQ1ISidwESoywsU/MqQ2dzLnUG4peb7Pv7+Oz0GfXxzvjIpTQUyNTxc9rMwgAg8tCnZRMu16vFGh2nCQHVabfUknQFjAOA+xBsSK+6kkV8hj0LYUmKWCHaNZhQgNQeQ0LxlDcmFnQRXtz+XaHOvM6zg0pkK7dt1LSnUG2MHQB6YHSNGZxm9Q4Jdr9snAR/ycksLBTegke6hOpbkSzYGDITa24zLPvQNqmBjpry1IvohjomOsnvoaQThVIYA+ujNEQz2VJWKkIgLEYjB0DLONFsYbsG/yyJEv4nk1Y4NXk4BnuJELBX7d0CzZFNaKPYJr8TboqOLBPqplpWQ98imczJSt9FQktuliL6zDpjyEu4Ilr4HcUlwxliUVto3el4VD5C/YU4FJwMQJ7L65N3dUZrNnySKhF8ncoRSwaXZ2xF66gD/lTLIXPxN1Q7qV57JCL3x6h885FbNuQS2VLvCA/17E804GVMTJPgoNfRnEI2mlxL0LQil/7gRtv6qhvoNQrpynLf+JnQG6n539jAfbf8JJzol+0zGjKiAfsRfd7D38G9WwMsyWXRMmk3q8iaKWxTKoofuNv8NiC54ZghGT7aoxxHrZY7R32E8C56In7u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YSt2R2puc2RhOHJFQnEzQWp2RDljMEE2V2JqOWtIY3J2L1NJa1JVSkptMWc0?=
 =?utf-8?B?RjdnMytFZ3R4eGluWWoxUTc2dkJzMHU5ZFMvY01LNXpqL01SY0xwSHJ6a1hh?=
 =?utf-8?B?TVUzc1FFVW96WUlUOVZtemJKOEZ0T2oxTmN5SlpyeWpZNFpNc1Jlald2M2Jl?=
 =?utf-8?B?SEw2RHRkTnNsdmtnTmk1M01KVUd1bVpRdW1lNEpZRGRqZ1lOU1NMWC9HOGVj?=
 =?utf-8?B?TWR4ZXJralE5ZG81dHAyYjJwczZBM3RSdU1iYllXd3ViQjNNK1VKa2U3YjJ1?=
 =?utf-8?B?aVRyaXVXNkhBRmhRMDJkRm1GUmkzYTRNYlY5R2xZQmpRaElNU2hrR0lIeWxG?=
 =?utf-8?B?VmFNeUM0MHFMTVVjL2VYK242V2c4a1dzcGZKeG5XZnZTR3VFM2xQR2UyKzNh?=
 =?utf-8?B?S0ppSXEzZmFTOTN5Y1p1RFF5YlExbGczb05BN1h5RkV3N05sYmFrVHo2YkQv?=
 =?utf-8?B?SW84Ynp2NnRuVTR1YldrcitTNDY1OFpDR0FzalZvVTlKcHB4bW5EQTJFZ3h3?=
 =?utf-8?B?Q3pJYldKQi8ybjJpOE5oVjdKam4wWnJweWh1Y1VlS3pOQXVJS0ZjVE11bFhq?=
 =?utf-8?B?cHRLRS9tQkZOL0poUDVTZlJlc3J5RmwvUjdORm1kdGhoMHFIVC95ZnRJVVF4?=
 =?utf-8?B?UktoQTZOekRoVUZteVoxa0d0MUZXUnFYMGlybEFjRTVpWkFiRUQrSUs5TXRJ?=
 =?utf-8?B?eUJaY1RTY29NV2NvdnVDRklub3h5U2ozVGF4aGVBWDVTdkNnenJVc1Qyd08r?=
 =?utf-8?B?L1NqcGtEdDM0UjEybzFmZzZDVDZNVExyNXpVV1FHeERWY1FNUGtBdmtpUXU3?=
 =?utf-8?B?eGtDYjRtY0MvejZUQThmT0JHSE9pYjVEUmEzRU5HY3Uvd3B6VWpOMXBON0hE?=
 =?utf-8?B?U2kzankvdUNPSXJ0ZklWUkIxUk4reW4wMEhDbXBMVTI3VUU3ZEJ0NmJoNG5S?=
 =?utf-8?B?QjJJN1VGL2hLWDJFT2V5ak9wV1dkZFl6a3Bxd0FaRm9BK3JDSnk5UHpyQTla?=
 =?utf-8?B?R1A5ZVZRcGdWSDdNcGlnTkFZVXpsRmN0eVp2ejVYQlFrU0E3ZzEza2hyNnFn?=
 =?utf-8?B?Ukw0RGR2RGxJTHNnL3EyQldFNTZ1a2pXaW9KcDJtaXVIT3BpdlFvYVZTcWhC?=
 =?utf-8?B?K1liVld6RVloSEtPYlJnQXdDRytJQk9CS1RFVDRpeVVWdWJ6SjBubGVZeDh4?=
 =?utf-8?B?bDh0Zm1sc2RlNFZhTndqWXY1UmNlRHNsN1l2dy9mS205ODlzKzV4UWwvdDhD?=
 =?utf-8?B?V05FMCsvUUl4N3kvR2hDZDZoeVdySzhmT3ZPdHIrMENCVDJrSUtIeUI0a0lo?=
 =?utf-8?B?QUhKTFUvSU1zR1lSWWFKNE15L2pCbDdRQU03V1BhbExhTDEwczRneFREQThR?=
 =?utf-8?B?WW15SGVkUkJCT3V2bEFiQ1lQMXk5MDZ1VGpOcG43QjBLZ2E1NHlOaTVTdklI?=
 =?utf-8?B?QkV3RDdkTTJ1ZkNwZ3N6QTg2QkNSNjlXd094S1VTdmYyeDIrUDhDeXB3TmJ3?=
 =?utf-8?B?TkMrTVVwWHR0L0w5cEZwYVF2N2plTlVYRmlQZXp2M00rMDRWZUQvMVZSb1ZX?=
 =?utf-8?B?SGNZalpOWnhyeU9kWW5TM2N5aXM5RVFDV3NEczQwZVVkS1QwQ1ZGWE1MbkVX?=
 =?utf-8?B?Z01KSTRleDRqYjlwMHVWanpYSjRRdENPbWR0bU1WVEhSckVPMm55WWVwblha?=
 =?utf-8?B?SXVmRFh6VHk4TzZLY3c0NC90Z0ozc3BDNmxVZUNicUVNV0dCUFgyLzVzeXpI?=
 =?utf-8?B?TTJTQ2lHQ21IRTdiS1ZnNmhmaHpYeW0xdjM5T3FPTVBPQ25JUkIyWjIyOHFk?=
 =?utf-8?B?c054ajFtR3pPbnVpZk1kSDI1WVNSbkxCRDRRbzRsUlByV1J2YVV4R1pUbHEx?=
 =?utf-8?B?Rk04c2tFbjF1d2hDcGpDYUlKTEpoNUp4aUVRM3JrVzA4M0ZYR05ielZRTjdT?=
 =?utf-8?B?VDVLMUVHYzRLMkR5Z1J0aFVRV2doN2JMVWZUQmh6S0V4QlVldE9TU3NRSTh6?=
 =?utf-8?B?NVkrN1RIbFdiNjl4SVAwbHJDUkhHNUdVaCs5Rk9jVUFud0Mza0EzT3RpMy9L?=
 =?utf-8?B?eE1SOVQwZE1wazQ2dUM5TndMakpqZEhzTm9rUGFuZlZCRXFYTHljL2huMWN1?=
 =?utf-8?B?bmtVUEF1UkFEamIyNXVBcXVLdjZuQUlaaUIzRWlnb2tMN2FQb2s3LzJKK05q?=
 =?utf-8?B?M094SjdSelNUMVJUUk1CS0xZMGZYWVFBY2xCN05WbXNvRnQ0R3RZQUhRbkJL?=
 =?utf-8?B?MmM0Z2g5TThZOFRJL2NVSkpPWlF6QmVXOUM1dXpiTWRSakRCeVdneXViZGk3?=
 =?utf-8?B?VktmYmljTGdWRS9UbjRDV1FsYURjSEVoVFhzWGVFQlFTMXBxQTFndz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd091547-b2c6-4b0f-22c8-08dea1ec374a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:28:24.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O3u7qSH2JN/r/3P4DYx6our2AohSLgkr6oOen6mPML5om3AGRI//wQPNCyhfeUZMKI3DHVyr7xei1jlYAlLvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7294

At bit smaller than the 3.3.3 release but with a good overlap. This 
release also addresses build breakages against latest 6.1.x stable 
kernels due to refactoring backports of upstream.

Download: https://gitlab.com/Xenomai/xenomai3/xenomai/-/archive/v3.2.9/xenomai-v3.2.9.tar.bz2

Changes since 3.2.8:

Hannes Diethelm (1):
      drivers/net/stack: Migrate struct rt_proc_call to flexible array member

Jan Kiszka (14):
      arm: fptest: Ensure that fp_regs_set/check functions are truly inline
      lib/cobalt: arm: Skip SIGSHADOW_ACTION_BACKTRACE over asynchronous signals
      testsuite/smokey/sched-quota: Make workload more predictable
      alchemy/task: Initialize thread handle on rt_task_bind
      alchemy/task: Match thread handle on task lookup as well
      README: Drop reference to no longer existing arch READMEs
      cobalt/thread: Keep host task PID in xnthread struct as well
      ci: Define our trigger source for downstream
      net/drivers/igb: Avoid MIN as macro name
      lib/cobalt: powerpc: Fix build regression
      net: rtcfg: Account for MIN being provided by the kernel
      cobalt/ipipe: Perform host_pid initialization
      lib/cobalt: Update vdso parser to latest Linux version
      config: Bump version number


Jan

-- 
Siemens AG, Technology
Linux Expert Center
