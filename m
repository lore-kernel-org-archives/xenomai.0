Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70E0481252
	for <xenomai@lists.linux.dev>; Tue, 21 Jul 2026 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630322; cv=fail; b=qhjJG4SwxtwH7w6gXaWri8lmmNMXiaHdPH9o9yQ2z9OJgb/p1OkhINgAbTwKY/N9hdAPAAuCzWFsIUdcH9TR8mOyZ2M7yPFDbwiuADDztAi0nVvXpcYP3z7yJNYXde0WJLh9mr0azpUaLB1ixflU5P2Wjr3DWUPSXG3jTRn6MtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630322; c=relaxed/simple;
	bh=P/d9iyCZfVUDWX3B7sKxZdqJF/E6Lstb5XU26TosrMc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kapTUEg5RruZe39cSxjVqnqGLGpHarP65tkg4CwHgkOTExELK3elHRmqLmVKROokijGvnjaGQ+6VpOnmgZznvQaP/bLHPB7ud2J9VuPTTp+Dl22VTAejz1dlMiKkMYGvxLYs318efThG/Rdn5zRzxxOpMuIdw6CBnmYfaNEdoJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JvSGRSSA; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JvSGRSSA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vx7mEYvDyCk3PfJWv5h6fznUD7NhRyLIFhUlBrz7Zk7Sv2kCOrJVveQBlzT7KleFTJlUM0rIsSRMVTVD/s7ZZ7vDpQQC0Cq00xgJp3PlKH0lLnzBO1u5H3/V313BneFILHGScc6XW7wJewSQVRRpqTUUZx3gzqkpPl3UUzHJOtZ9fBBL0SjgqDle2oxU+qifbQrp+bxyDeqXL7cmBCW4JziHbbTsMfO978hmu+knuqO8DkBSWWJgDicRVkivhoFVWWoHAzF0qBwT7qusfUHYckUCTiTJCaciPrdGpQn4PDnHJmQXBllL5QlcKHt6Z9hLsULTippnhpctyidO4k3rsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2ynqR9B6d+mpKu+guRxkhKdDSdPOVh4hNm98RtSq4o=;
 b=s87i0NWFBe4mrojz6xxqCVCaj4cmeFjsAKPY3DZ8kDx4uA1Gp+okLQd2YQj7McNtRl5ui0lfLF+yATWB83A1jbpc+/lPSLQp38tIi+PTeO/cIYULsRT9eOyiOrc8jL90KxCQgYd10wgsbFjMMnl7JlziUP2AKTqzutQpBgNhUXykGP10LvqR8E3adtYtYYeG7ZjYz2L+NmmqIb9TenFv6NMUx0plrYWWYJHwFx2/mz9NMfzR/2oQ7tM1f1WIwDiFjAn61ZvM52k4l6DdBF+Zl6KFgCp9pfERKm4eCaAJiy89yh8vKSTlfscAoVaL6qnbD9bxmoC+9oLWl+9RxKiQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2ynqR9B6d+mpKu+guRxkhKdDSdPOVh4hNm98RtSq4o=;
 b=JvSGRSSAwufMgimSInJEIvMI0In/wekpcWHrMKTgx6jM6MXz6UdH8oykf8beQMwi5rwgPaQLXPbVztTrvYruPhh6lSTJmsDqKbKXzbR1AhuiMHEmc8fjFYf5tFrM9/mV7VCl0JIfgAvIMUZRu1Dnu4VIU0wgY3OzYcij+/1bvc5F1xGnkCIXGhz6yPMzflWpz+J+ydQxiJp4yErOx0Rx19MjzA8OqGQEB+DoBLHeHwJ85gfmie0/Yu5O7LqFQE6bu4AqyIGtVXsAWepI3XHbKArT4uf4PKLccZ4Hf1W9HVeCc3KOGwzFVnXlRHbIKSoH3UaRSYaPAEFjYppLy/Dw4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3326.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 10:38:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 10:38:35 +0000
Message-ID: <5efa453b-d7e1-4323-af77-dc6ff697356b@siemens.com>
Date: Tue, 21 Jul 2026 12:38:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Add support for gcc 16
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20260720-wip-flo-gcc-16-v4-0-f281a1f0cbd4@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260720-wip-flo-gcc-16-v4-0-f281a1f0cbd4@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0370.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3326:EE_
X-MS-Office365-Filtering-Correlation-Id: b99e9069-e765-4a1a-8467-08dee7143797
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|55112099003|18002099003|3023799007|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	+2MP7XXjzjHQbV/Dq8Kg+1bsHWlErM6x0DdorOicgZaReNOjl52ey6qmFZ8ZPm1LciyuqN3j/WN0PS09stE1XhO0fJa9xs3GsDh4TvxoiOqFRkCexaNerVJDZkeuROkf2S4WTYuBR4EOD76iqplF5UBehQ7MNPWX7G5w7lcZBOFZIHIlOQahxZVlwC3jdIIaoMXIVytc8/WSKiTngOL5L8B2tGEtfLOMGPcb6LUBvABGBWMMAi2uE2LO5eaEL5veQrOqmRqudFUXPrjW+cOL3NzFgVoaBbgoga9laxlLROdTSOnOEmrEM8oX6tXXtV5VZEppKdykt0mLm1KeRqbCPMCMOTFTN5e+rQVDPJCQ3k/p8PNWBntNopMQtKv5e+f38iJe265SGgUFufazF7lVP3AyIN/y7LwAPwlJSiiidQ9QE95LapB/E9sLzmlIenLJymzL8pJ6lDJPKZKaZV0XXGGbVMpv62BEEA+MZ2BuXuWbk3oi/jr//9NLusFVNQg0kefVfgn6bgGBeYp4xecp0Izxi17J2t16Xa4xFMuoeLBiKVSVMtoJmKzKEF8sOqYQgv3k0kGw2ep5SD+Gi81rTOmZ6DgEAAV5vwLWblk7kHQqODkpJT5F/tEvbEO6O4F4XXCpQoaRtfAt2MBf5RYAELsjaz26Fy/OmgykeWvPRAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(55112099003)(18002099003)(3023799007)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmZORlVUa21mZzdJdHZRZnpBM21ZUld3Mzh6dnpENmYzQUg5Z1U0UDYrby9m?=
 =?utf-8?B?SEVZeDBWNHBPVDcvYjdQbkpPTU1OQWVPUENraGI4U1RDOGhLc3dJSk01Q3Rh?=
 =?utf-8?B?N2ZtWDZpVndyeUZSVVFNNEFxWUY0NGNYcGo4dWpEMk44QWpkaEtzMHVXNXRr?=
 =?utf-8?B?dlIzVTcvbTAwVDE5SW56MTFSay8rZzh5VjZHT083b21BcmpFUDBkajRRVkJ4?=
 =?utf-8?B?SmlKUUJ5Z0M3V3ZiQXpKR21WTFZrK0tJTUxJQUZyVlNrYWtyK3g2cGRWNjY4?=
 =?utf-8?B?Ymt5L05pb1RnMEhnVE9WNWtWZ3pSTDhLb0JxdHZzZ2VKVS9pQkx1ZWk2blRF?=
 =?utf-8?B?K1ZzZEdwUWFlbTMwdXdrSWhpWmd0QWM0Z3FSVU9UMERyekJkMFdaUklHWFNv?=
 =?utf-8?B?UVVsN1dMRTRyYXliSWFFUTZsUUFGaytGZUxoRWxvVDEwaEk0ajNVNlN4cUFk?=
 =?utf-8?B?TFhMaHdWOHpFbWhoNDA5RDVoMyt2ekVSbzVrcHo2TjVtZWFGMVh0VkhDeTRq?=
 =?utf-8?B?RGxEeEpGT210SDh2Qi9tNXkvN3B1cmlSWGg3SGhHWlVQdDJiS29Kd3U5eGJp?=
 =?utf-8?B?OHRyVkE2dk5RRVBYSnNqZmFjQTU1YkdoS1hLZzBxZFFLa01ERUQvY3pwdlVU?=
 =?utf-8?B?d01UbTVDb1hjOTAwcUd2am9ZbjJUZENzOVJSa3J4SUVsblU4NVV0b1VRTkpL?=
 =?utf-8?B?V2NIVVVSdEdKZEJMV2lLMzhBRTRZTVVkKzVkdFFuQU9LdU9pLzJ0S1k5V0Jw?=
 =?utf-8?B?bitaV3IrbjBjWXF2SDFEYjBSdksxL0JKeXRPbWJybVNkLzhnVEZhdHhwV0VF?=
 =?utf-8?B?M0p1MXNWQ01DVnNhcjhBMWNKSXU2ejNsdnp4NlVscWRTbllscllBRXBXT3gr?=
 =?utf-8?B?bEZRMGgvMzh6QUI1ZWZxZWwyM2RYVGF4Q3h2YkZkK1Y4ZTc4MmEwbFRQa09W?=
 =?utf-8?B?L0Z0RlR2bEdhZTRFS0Q2Tlp3cEJGYU1CQkYvSDhtV3Nmc0hhdXMrRldsV3Zw?=
 =?utf-8?B?T0JXbnlXaFMzRGQyYnpqWVJkTXliMk1xVm1VTG5sT1k5ZjlQd21hbkNJUW9K?=
 =?utf-8?B?ZkZLUXNxdUF1ck1ReXFMVXorY0FzMjcxTVdCczJlTEI4eXRTc082MDE4bmFY?=
 =?utf-8?B?NmZmYWZBWWdNWE1WYTE2TEJ0elB5SitGOURramtFTjBHMzJmbzNTQW9ZSElT?=
 =?utf-8?B?bCs3SW8xM3ZnK0ZHVDEwbTdINTAyNTdIM3E5ZE10eklLNnl0OFEzOFVlbFFr?=
 =?utf-8?B?ZjVGQXdSejVZV1B6c1ZUcmkxZlBhekVmUnJXdGdoR2hOVGdjNmxXOHIyZkVK?=
 =?utf-8?B?SEFaNmtZeDY1Z2c5dGljaVlrRnR0SVBWMDl2SVptbE01NzZTUEE3SEZTTVJ4?=
 =?utf-8?B?KzRsdXVYSzBrN2J0WHpCMThDeklGandBNlNiV1p5UXRZR2VucTMrN0xBRW5h?=
 =?utf-8?B?LzlXclJpc0tBa2JtZXE4VG10TGQ0cE4wbkZ2Q3BmM2xacEhNb3RuY2thY0xx?=
 =?utf-8?B?TjF0QXM0UFlPK1lSZjdWdVIxd05lU2Vla0I2eHg5Y3UxY2M0cG9lMWROTHF0?=
 =?utf-8?B?ZEpKWjYrWTljVHFJRnlvMmlYSXVIMU1RQTVJM3BoQmZtMEVZNmh0eFZEL0hN?=
 =?utf-8?B?cEpabDM4S3pNRFVZaVMvajdUbzFFd1VUWk1NdjYrU2hZUk9IK1lqKy9HOFQw?=
 =?utf-8?B?bHN2TFQ5NGhiQ2pPdGY4K3orS3RFNnNKSTZ0Q3ZuckU2Vk9IYzBaUkJ2RGpQ?=
 =?utf-8?B?dHdQbnhMQlhUQkZiaUJ1VWJVQlgxVGFCZ1drL2tZUHlYN29pUmdyMXdoR1BF?=
 =?utf-8?B?OFNtV0d0R1FQU2dXUnNGaU1jS0QwUkZhN0ViaFJFOGw4N0V1S25Scjdpajc3?=
 =?utf-8?B?RDQvSTJaRTFzanlYZGpyREF4UmJ6MDlYSXhKWUFnc1kzSmYzVGIxVkdzWlRE?=
 =?utf-8?B?MEVyblVqMUIyUEJ1UVF1a28xTXg4MmQzamNDdzk0WXFueEdEOWxxdnBTbG9H?=
 =?utf-8?B?a0dGR1NaWUJtd1NnTVpVOU5OcEpHM0FCN2tCQU4xNCtzRWkwM3FsTG1ucnlo?=
 =?utf-8?B?UE9HMXhhL29VbzBWRTRSZk1wdm0rVWV5eEJqY1BWMHBFWEh3QU5VVGxBWnly?=
 =?utf-8?B?UXlUUDRQR2N1bVpJamlDR2FaR0U3bndJdXdwMEhkaU1ySDBIMXczajhQdUNZ?=
 =?utf-8?B?UXhjcG5wT2ZlazgzT0p2ZlQvdnRZSCtpZFlWSmlDRC9pdnF1cFlXS1dOaHd5?=
 =?utf-8?B?Q2tza1lIdWx1NEJLY1ZNNEdRZDJscDB4cHVRZWc3N3ZWb296THl1d0hhOFAv?=
 =?utf-8?B?a3g0SDRvRzdIQ2xwb1MrQ01IOFFRZ2pZMkVZL0dDMUpBNG5GZHVPZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99e9069-e765-4a1a-8467-08dee7143797
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 10:38:35.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trlrfiiAOYT+XZGdcvoykQfLuGSgLJiYFtj2FXDRJGgJXIae4XWT8SNAdCjIvpDD546zjg3zbqHrdwYlM3GgPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3326

On 20.07.26 23:28, Florian Bezdeka wrote:
> Hi all,
> 
> Trying to compile the codebase with gcc 16 revealed some minor issues /
> compile failures. Fixing them up was quite easy, so here we go.
> 
> gcc 16 is the default compiler on Fefora 44 and available as package
> for Debian 14 (forky).
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Changes in v4:
> - Patch 1: Removed. Already applied
> - Patch 2: Removed. Already applied 
> - Patch 1: Previously Patch 3: taskDelay() -> threadobj_spin()
> - Patch 2: Previously Patch 4: Update changelog, factor out test
>            activation
> - Patch 3: New. Test activation as separate patch
> - Link to v3: https://lore.kernel.org/r/20260717-wip-flo-gcc-16-v3-0-5429c866bcca@siemens.com
> 
> Changes in v3:
> - Rebased on current next
> - Patch 4: Enable psos test at smokey level
> - Patch 4: Increase busy waiting interval to 2ms
> - Link to v2: https://lore.kernel.org/r/20260518-wip-flo-gcc-16-v2-0-f93562624fb4@siemens.com
> 
> Changes in v2:
>   - Reworked patches 3 and 4, removed / migrated busy loops
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> Florian Bezdeka (3):
>       testsuite/smokey/vxworktests: Fix compile error seen with gcc 16
>       testsuite/smokey/psostests: Fix compile error seen with gcc 16
>       testsuite/smokey/psostests: Enable psostests_task2 test
> 
>  testsuite/smokey/psostests/psostests.c | 4 +---
>  testsuite/smokey/psostests/rn-1.c      | 7 +++----
>  testsuite/smokey/psostests/task-2.c    | 5 ++---
>  testsuite/smokey/vxworkstests/task-2.c | 5 ++---
>  4 files changed, 8 insertions(+), 13 deletions(-)
> ---
> base-commit: 8109051556b438cd4c280e75c2a45ae3b43d7f7e
> change-id: 20260508-wip-flo-gcc-16-6291fb97b9a1
> 
> Best regards,

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
