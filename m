Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91F2032D
	for <xenomai@lists.linux.dev>; Sat, 13 Jun 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781331866; cv=fail; b=d52aWa0nXHezwj3fvIlss0c5dgIt3JbP+Htcki6eIICF5enxIZ1PJdf1mp9S9KqOmMEIezwq5DibLsF4zgHw2yQwKOm4FpTtqXaV2QTtYEcjEyX76+w2Z/CubQdfz5oeBAkvgqguyj7fbDnWlQ0Lsz7f0gmosBZcAovfBvfioeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781331866; c=relaxed/simple;
	bh=bTI4V3tdZ8U6vSVMFWJw3+/lEe2YVn8D26fhTSdsbOw=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=AHv3Ko4HLD9Nc7iZ4KJBr81fewb6LL/qgDCl3nkxXf58fe5OMOuHYzMm01RKJ9ISDSO+S0KhMeHNV+YZ6/TbuQ3OlamPqn4IVFONdOr12yUN/UdOKeBPtQswurvFRyNmQovDtMSKQelNMa2YuAWQsOFUbo6njVsxTGlcSml7bm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XeGaFUw4; arc=fail smtp.client-ip=52.101.83.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XeGaFUw4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1a+le8JKhTK6XSDVAsNqhd7T8Wxe9nAEVQj51EuyehsKyBu5cmnaXRisf7vrf37PdahIOPOAWRb1Nqo2vTSdYbpBmgbrSYs3V9qP+1HxeoIvtwQzLSF6eqFJEaOaNnqmm6o6JlLa1OvMEkD4avqPN42kwDOgc+6uzIJs7o9gZWDkgG/snNYrun6pBMCJIqGeR9xIe7atOXT833TylyjDCdC5Zhu/L/C/+mYZXEq6TrVqrfVg+N0odyVH4+HgWI2fXjs0W3CgI4ubdV8b10P04rEn8nz0rq6UhJeJainXmi6ueEjjOxO7QFVcDu/KPt5incwWUgMcEztgnntHrYEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGSA2S3zdwp6CqaBeGzCeDark0PlOoIZiIuI4GVIBio=;
 b=WrBUJV2s8D5Y6nrchaEhyju8isSjW4ebkUMUgFZVqfKNHzw87olOQIvf1mRgdznAkrHiA6K3APkzFR65fSUFj8aA8nlSEIUWjP7eMIanRWAVARKBJ6sHfonccN+DacEvzKFzgYc2qkWOoxdWFinLPcJrSdeLBMN24QSIfG5cyQNAr+6MvPEsmGPzKDJtFKL4HkVHpHQ4nOxeMOmKjOIQIRzxHLq5L2TY4GrXml4hYKjHkUOl3X1U11xCVcwyspL8d+LnSui8XThI+gRpH3DVz3sBpctEABckL04TA8uRknmH3xvjYqBC9VRiqcPlGligj2Y7MiNkXxW5uzf6oj8PXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGSA2S3zdwp6CqaBeGzCeDark0PlOoIZiIuI4GVIBio=;
 b=XeGaFUw4iKOYweDlCi1jxC48mgbIV+tMcGkUZCVbw5xM1S16om1U/roPxyD9R5BHs8YGmVVIGcOV0kqLff6jNXhZ7HmQYgi8Fb6pK3PuyX73c7snw8nHvmMTBDHqWiJa1qsxk07CO/hgh3tJ5MzHkX0hFcPVnSbvpWF2VoTrdGDRkMT8/UmzXO+HPYwuMOdtnJ+NT962LLksnXuyVS9X/vWl3ZybNJcBeNI8Ek0+AcYTGPzMJnXoAbzmv5PinX8x6tZ20N2H7EJDjSjfBBju5OikCQCxxDemnOo7j0nZX5r6kwGb/juQJMYH4LR2ZePS2Z0RbCjscPcuXVoSsflm1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8168.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sat, 13 Jun
 2026 06:24:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.014; Sat, 13 Jun 2026
 06:24:21 +0000
Message-ID: <49aaf291-83f8-4943-970f-8d4699970bc0@siemens.com>
Date: Sat, 13 Jun 2026 08:24:20 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH linux-evl] evl/trace: Fix crash of evl_sleep_on tracepoint
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@lists.linux.dev>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2a58d6-5211-4537-537d-08dec91467bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	R26SgPCSxV/cZJyq94yA+AimdFi3ARxlN96cR+HLOzZ2N8alyAfJRwMbqMJBqkj2CJQefyrG6QQdlU4Z+c9qPnk98ECgpqyznC+oroGzovUw46oBuJvxXRYrdPJEUI3aydyB7m3BYuu92Pcs71lFcmcyRAoCfW1MxrXAnay0QNKW4/JEJ9oBeOq9tLY9y4Kt/WnPYvIaWc58G+R0W29puE8eJqfpGFTxyEPJUfEvMqqf1b3oSCadkTDQG1dcBPDi0CBrKLJyZkgb/nao+d1XTxsXy6qEpkeVaxXttgHiZHsEUUq+/Z+jYuFFiZLfa5+kYQzHwCUzM+3JGZGegfMylq3s74cqtDDuALwsg6WJnS5pt7LaPDfnt+7ccoJNCNDgyw9PwtWM+bfY5oUb9ZW8VzYqgvEf+NJI3iG2y2VwkPpiU1TX6T25jkALA+WcInwSD1OvOilIlqcOP37uWgrIT1l90qYOZkayg5idLav5vAmiRgEs9INc53SYyZuRe5gKXAH/N+8biNmTYzRnRP0/5I3Rb9+wqWT3Fgn76lnmcKoCypMSQ3MUay1DHWPgvWOtzhAqUB6Gs7HeFgXV9lipA57vUuZLsGzYTLgkk/ojhb1AhRLc6aOHQKfWRyQeSDWA4aAwLRyY8aHBjI0kkjht0i2PMPrDw7M2CZLXU+pUEsEy5kKC2JxgocMGeZgdRtYy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mzl6S2VReWlMeEJlQXNjOWx3azA2TllFOE9yUllqOHg0UDNFdmVDWHJWdDBr?=
 =?utf-8?B?dE11cWRBQTQ1Z21Nand1Zndmc3NCbVBFSHVNbUV1RWhHa09VMW5zT3I0Zjll?=
 =?utf-8?B?ZDltYjBabDRXaWZIMnA5ZkgrM0psT2hCTysya0JOeTJGQ3QxRFFFNWhxd2lt?=
 =?utf-8?B?dGM3UG9YR0R1dFpRS1M0S2hKNnVGWG1vcHo5blprSnovaG5EVTZiSkVQVlh3?=
 =?utf-8?B?SElGcm54bHJCczM3SWMxbUtBQWRDMEo1UUd1VVpSVTZHeWJONGRlTEZFeWRw?=
 =?utf-8?B?eWFHZStRODc0SVpxWHFlVnpDNmdIRVJuNnppOTZTZHNIUTBGandtQS9OL01I?=
 =?utf-8?B?Y1hJM1A2WUwyVWR4eXpRZHRTa1VYMUtENUh4ZCtWeENVTnFPWjJ3NTliWWVi?=
 =?utf-8?B?YnRtdGFxYXBXbVV4ZTBuaUphTlN4SE81K1llNmFrcHVXSFpjZTl1SkpOQVBX?=
 =?utf-8?B?VlF1eG44QkhJRGFFaW1sd2x1TVlTRHJ6VkhHNnJPWXMyQ2NBVGl2R0xmOGo2?=
 =?utf-8?B?bFZRVkw0NDV0ZmNza1prSFhmRERkQmtOckkzSWJkd043d2ppcEsxYXFTWFlK?=
 =?utf-8?B?bXQ2VnRzL0sxamJuMnBQMksrOFlLUHNpNjByNVZpdGFaOUszSUIxVWpuaW5K?=
 =?utf-8?B?K3JycFVkS0MvM3hGbjZ0YTVlTmJkek1SMndmTzZrenYzN3E0TVNGcSs2Q09N?=
 =?utf-8?B?c2V4Y3NqWVJZLy94M1I3YjFURUNxUVd3YUFFTjVRVGg3TDFKQWRwT0VxclBP?=
 =?utf-8?B?VEdwNEhiZFVhYTVvdk5CWjlNeGNXemdiR2pLYjdFUFpUOTVrMzkvakZZOEhY?=
 =?utf-8?B?eHQ2S2o2OVl0VUVWd1F4VEM5aWNsM0lSeDJENXVoL0FoU25pWTNlT0JYT1hU?=
 =?utf-8?B?TUloc0NiTEVhcldQeXZLV2ROMjZsaEd1WjNPTHhxd083MUlEU2JPRmlLRitZ?=
 =?utf-8?B?UDU0aU9FM1VOTzJVdXNlZ0VxVUVYYTFqTGRPVFpQaG02SGUxTEpmRTZjdFVP?=
 =?utf-8?B?RzF1eWN6bjNjb1ZXV0NzNE1XU3ZpcVlzTnBlb2JEeEFKTVYwUFp5UXRCTkUy?=
 =?utf-8?B?REwrTjdGc2N4MFgwS0p3UjBOK0hFdS8zTExvMjZwdnQyQjVFR0p4YVNpU2NV?=
 =?utf-8?B?bUk5czc0SVZ2cnRYdU1LcFBUUEVvUkprVmk1MHRXaHpWbk5RbHVCN3RTY0FH?=
 =?utf-8?B?QllNdXB2ZWp3cHRHbk5NbHNHclB0QVZTaTFmL2hKTGtlVWhkMkE5MDVoNWZr?=
 =?utf-8?B?b0s3aE1yWGNMSUhFSlRoaUF2VzRuYUpOcG9QUnZ5ejhWWDNINEFQQTRGS091?=
 =?utf-8?B?WEF4WXQwNTNpVmh2K1ExTkFHNmJSejROcWRIRXR5TmxUdGh4ZW1XNjJmUy8x?=
 =?utf-8?B?QW1CV1JucHpzRndHMDdIYmFPN3paRVhsSEl0bVNNVThMN1QzdkZyV1lOcUxr?=
 =?utf-8?B?SGFhVW1CWE1CMjN2YVVvTEc3V3ZTVld6amdOMFhOa3hTUk1MY25yQXJlYS9r?=
 =?utf-8?B?MkZFRjBLY3p0bE9RanZiOFZpZEpBdmlJOU5KVS8wMVNybWk1ZHdtWG5GQjZL?=
 =?utf-8?B?Q0hBbmZWSWw5OTQwazJiaGMva1BUQ0x2Zkw2Mk5MRXoxYmE0c0pySExJSU9i?=
 =?utf-8?B?NWJwb0xWSGRUMVdOSVdyS204aWwxOTU0UFc0Kzg0NGlBTHZJSUsrek43aytL?=
 =?utf-8?B?alU5VWlNL2hIM2xGdENmKzZMRkRyYWlBYmdXanJIc2ZEZUpYamxRWFN0YzEw?=
 =?utf-8?B?SEpmZ3RUL1JXc2RNOHl5OUV6YkE0d1Q1K3ZRS0lucHNNdm1xcklGL2lVN09l?=
 =?utf-8?B?QVh4TkovcWszRDAvQ0ZBTW5RRTRqdGN5RjVkZU9nQzdLdWUrQlRnVGF2eWRi?=
 =?utf-8?B?eVUrRTlLQ2M1MW5yaHlVWFN4ZktnQnJCVUpwRldDYjhVdFFab3V4aCtpMEpY?=
 =?utf-8?B?VElKQTd3OGlrY1g4SGZ3ZDdnSnRuaTlnNHhQM2diYXRsWkdBOTd3VlZvMjBz?=
 =?utf-8?B?QjFjL2FINGxRR1hoQWZkQ0duWWVzcGh0MWlKdVJCYXY2L3ZYdkFGekk1V2Q5?=
 =?utf-8?B?cGl2aXlDWDZkZFN4TlhnVWQ5MGRyNWJMK2p1dGN4QjlvWmtxNjBUTzljSFlZ?=
 =?utf-8?B?R0FnZGlQWTRHTGR4bnFUbG9aQTNWZjlUMXRNMmNRYTNEQVFXcHowcThqWGc5?=
 =?utf-8?B?WkRYUnVWSEozUXdlTXc4Vk9VZTczQ0w0eHU0d2I4dEZYMkFKeHMzRkhnNWdo?=
 =?utf-8?B?RHA4YW83dmJCbk1TbXdlb3orV0tLd0FQU2FmRXE2SzBSV0ZTcFJxazdUR1J5?=
 =?utf-8?B?RmpsTGhmd2hpU1E1eGJTT3d0STUwd0s3cE44NExiQVYwcm1JbSsyZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2a58d6-5211-4537-537d-08dec91467bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2026 06:24:21.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fsz/8/3C/V84OTBoCYTHLc9CZft5wW8HVvydmp25I6LbhmZ8mFrTFc3+BygzLcqf5ihBLs/wMxPaDZBL1Wtn1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8168

From: Jan Kiszka <jan.kiszka@siemens.com>

wchan can be NULL, and that will crash with tracing enabled.

In contrast, clock cannot be NULL, thus does not need this guard.

Fixes: 35d7f895d5d6 ("evl/trace: prefer object name over address", v6.18.y-evl-rebase)
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/trace/events/evl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/evl.h b/include/trace/events/evl.h
index 035a279fd86b8..88265c1eae136 100644
--- a/include/trace/events/evl.h
+++ b/include/trace/events/evl.h
@@ -347,7 +347,7 @@ TRACE_EVENT(evl_sleep_on,
 		__field(pid_t, pid)
 		__field(ktime_t, timeout)
 		__field(enum evl_tmode, timeout_mode)
-		__string(wchan_name, wchan->name)
+		__string(wchan_name, wchan ? wchan->name : "none")
 		__string(clock_name, clock->name)
 	),
 
-- 
2.47.3
