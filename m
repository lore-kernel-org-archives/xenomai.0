Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2CF1C0F
	for <xenomai@lists.linux.dev>; Wed, 27 Sep 2023 06:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZewUMZD30LDjbnz2cjNARW7G/9zMovPRMPAp58XZCppqywW9tssIFz5VkZKasjVOiTNd4almlv09ihdS9jsTV6mFCJ71IUSticKOmpIz5nF4NVz/o3c7ItybUH6E4PyiwdNHhx06PeRLD6+1ZRQzAMcEihzUDZiGh02NOwZtVSZOx/IhioPWdTklBuMBpyhYXbpKNFUjtc78ZtbwUfpZGz7lh/u5pAvfMaoHJvB0+PB8/ANXhjP1tAUrWishFPgTgv7HmHg16wi+5jPVu1k1c1xWGRtP2UhQ/SLrVCHF5xZyD1sKc6yor0hKDw7XLSYLrQUJkVbbisacGpgBXk9jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4KZTQsIjO6ujOmrWh59ktX1hqbFIYIw3c1DZsKjfj0=;
 b=JRzE4IttI6gYv2Z6HXhgIerKd7elkRLxa16n9n+5lmw2Z42iG0IschwzLyKbrl8XfC3iPzmnDLx58sE5dkBoSL8MVVFGev/IBnTVFDXw+VX1r3FsdJ/Zla7lQps3ARLS82Kr1HdTBL4HicNKx/0STFStwHcUfT+W4XwxplGtVxRbYrDpk+F3BGLlMvSonHzSkcXgj4mDc5668I9VpWuVyVBkKvf99w5D+YZiehfGkuEareBGZpR05YvPQHEdzuKHOXSUP5hVf3DMouub1iR6uFv04VbQLGcgAgeay6+z7Efajm4wpjWV54gGUXbdWPro5ram3/Jy9oBmSVQxjBUvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4KZTQsIjO6ujOmrWh59ktX1hqbFIYIw3c1DZsKjfj0=;
 b=rd8g1YOF/vUzGPaPEqV+aEKzQ9CbkPGEIMCzMKW2djJJAx9iS2txrURlxQJq5lDuipMyXJHW9FFlUwEiTOMTYaBpGBvO3FY9zsCmCfGpiRMusPAUPibBqAniisCGKOGSULh+2UIB8e31sVnI/CFDJjnvWewJawuTylMlvHWShNRYmHVFg7NQ7m6J0x2+ifuTCRbjtI6xwLNH6th0SvyWmGcWmXsiqXRFKK9186momKBPAEOX/mRS8/GGJ9o85Jjmx3fdT0vesqLICWRQMDhQ6ML6JYzrySdA0SUEnajWcAgfjJp6X1pLDjwM71hHKAvCXisilSYFRruyxnMbYBSbLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:383::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 06:15:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 06:15:20 +0000
Message-ID: <5379efca-76b3-4413-85ab-41db5a9e7524@siemens.com>
Date: Wed, 27 Sep 2023 08:15:18 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [stable/v3.2.x][PATCH] Fix detection of dev_addr_set availability on
 4.19 kernels
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbf83e0-ac56-4864-1af7-08dbbf212064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sk1a/4B9fROGkPy/avNgbWQcqbWCANvp9xRp1IAV8UQo/HS2tWCUrPQi+omQS7nqDn+Yz0z3DPzRmxzMwe837yDREQLobTQqAUVGLpwhDv1EvpbML7m0tE6BI0rsFSexKRRaw6091+IDTlMY6VEU5tUbZcBw3gc6Up62dHM3a4g44AACfMTWzHxkeEq2tFk/ii9jg0GwZTTXWBJNcKYi1kH2iBtc8UiL153/FOOrKFWg8UPHmHo+Mdnz5XvGk1LgNlvIm0VXdhB78N+r3Qakap3ntLyitlmGcHwtSV1BZQHb4bnbcx50xn/8G7JADYgdjy6X9yNzEz3vPU7m2w6qnC3/+Kzx6GaGzt6ZgtR8jJKO6xhRhdvfpbnc/Q/qRaTpLvp0EuBdwJ7xdgQBsBvDqbErENO0lAxSkyYFwSB2ymH62WOklm7HVFhmkfaRWbXROgLlxE96nALT55i5+WzFiFj6yglx9eaUEIL2O6SMc/UNR2kiNQhCN25yMEHbI5cKu9WzBGiONhxUciuRKydhi5L7YMmvUSEefU/0WRImpM8RabcdmSiTSdgA8uzDXKXODTRQWICIMjDj/eaj9FsuWJNUKvgqO8qY1wfMArr19G9N2lDMrwCjEy50tP/tIbH3Rv6/gybjnGEmzF6TTYnY4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(26005)(6512007)(6506007)(2616005)(82960400001)(6486002)(107886003)(31696002)(38100700002)(478600001)(44832011)(2906002)(83380400001)(66946007)(8676002)(86362001)(66476007)(66556008)(36756003)(8936002)(41300700001)(5660300002)(6916009)(4326008)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ym85WGx3UW41TGNDcFZPaTY1bVVKSm0vUEtHUmoxYmJweXVLa0lac3lLQTFD?=
 =?utf-8?B?VWFUbEhLWWZlNEx4d241ZDRpL1RnNDVUcGh5ajFuVkZaV1lValZnSHRKTEtF?=
 =?utf-8?B?bVFsU0YxV0ZiWWQ5Y1lOdEM4WENKVFdkUU1TSHhnWFU4em9VOWlGY3ZrUVZD?=
 =?utf-8?B?RDRaK0FONU9yUGs3RDFGMUR2WEdVeW9tR0IwSnM0ZStYZzJqR3R3VThQNTFm?=
 =?utf-8?B?SFd0eUZQYUpkQXM4M0hua2pjMiszYkZXWmR2cVhzWVBQOUpSOStnWG5Zczht?=
 =?utf-8?B?elJHVHhHVmFQQ3owV0VwZ2luRmVVbG83aVQ1LzByRXluQ3k0TFRPRnBaZEl6?=
 =?utf-8?B?bUhoQWgvR2VYTldsNklENW8vYnB3MkdwVUl1UEFldFpPUnY0OUtOWCs3NG1y?=
 =?utf-8?B?bVMxcXNKQmcxRnlEMGhhVExWOWFjM3VwMndSNWFiUDVQNzdzd3c4eWtUOU95?=
 =?utf-8?B?cTZsTkFodlhlUlFCblhQRWZOTm5hcVl2MmV2WHhTYVZjZXlXYnJzZzVsV0ZI?=
 =?utf-8?B?RU1Oc1NaNzZmSWlaNmF6NFNnMHNyYThJTmRGNFhWeGE2VFdNOGdUM0ZhbVNx?=
 =?utf-8?B?N2xDaFJQZm5hdEp6QlJZT0kyNERoT0NRTGVhaENmdFdxejNwVzltWFhaWGxo?=
 =?utf-8?B?QzlkSXBsSG9pblJiQVpOdngwQlFNcVd5NXczRzA3SW5Gai9QeDNPL05FaUZ6?=
 =?utf-8?B?bk1IRGczMk96WVYwRlVUTlRFSk5jWEFqdStZdWtFS3FMaDJlMzZsVkNaRGRL?=
 =?utf-8?B?amFkTHBqeFgrcHBkd3g0STU3ZXJXSytJZVlvQy9SVVl1bjFkV3JuN21HNDhT?=
 =?utf-8?B?R0FFQWw1Y3lrUEdiWXdYQUhPMUNJMW5aTkR0L2ZTcjBLQTFINW1US05LY3p0?=
 =?utf-8?B?SC9aanoyRzA3M1o3T0ZMV0RiTmpRdXFOSVppQWJCTDNGd0t3MzBGZzVnUUpB?=
 =?utf-8?B?eXFKUzJvM2thSkczN3h6c2pncXY5V25vcXFHZkxsTnhxSDF4dTkwOW82d2Fj?=
 =?utf-8?B?TGt1V3VKdUZsNWRiWDNJUGsxQ1NoWHRZMnpReVJXcGFZbzE3dFJqY0dFblp6?=
 =?utf-8?B?aUdiQzlyc1kwRWRvU0oyWDc0cGNyN1Vwcy9SWENxRVJxQzZpTzRZMk13emx1?=
 =?utf-8?B?NGRHdEFQVzRpUkRIZmw2Z2wvbnpRQXFWdUthTEVWSGtQSEg2SFFjMlJaWXBG?=
 =?utf-8?B?Wm5TRmpTNC9tRktJTU94T0pGdHhMZTJVVkNKRXpFNnpkUzRndktkL05pNndn?=
 =?utf-8?B?SG5oT1BBaVkrYTd6ZW1adkc2eVNLQUFjSG5mK21uS1p3Yml6MVUrSUVYd0c3?=
 =?utf-8?B?b3ZNcEJuM1p5aGNyTXAvMjQ3aWtISjArOUVxUEZ4ZDgxZ0VZWURMYzkrMmxx?=
 =?utf-8?B?Vjl1WVZCb2ovZHlmemw1QlpSZERUZEI0SGxDdXY4dC9kRTczaE9yVVBxTWFT?=
 =?utf-8?B?VjFDRWlYM1JLbHNYVDZqdEpPQk4vanBMTm56dGFwSVVpZDVFWk1SVFJPZ0xl?=
 =?utf-8?B?bWdUWk5OMjhmY2JYc1RQMEgweVhETk9CbHBGUkNKRkg0ckZybEY5NUVibUhB?=
 =?utf-8?B?YTNHMi94aC9PUzk3eENud1U0RzFsOGpJK3lteXR0MUZleUdWajkvRGxsajlU?=
 =?utf-8?B?bW1IYTY0Qm9FMndKbGVxV21Bd3Z5dDdCMkJHLzZZcHZ0YU5CckdUaWlXcy9z?=
 =?utf-8?B?dFpINnEwM2RGVnZ5NmE3QTdROG05SFE5NFZ6eDM0akx1M2s1UnlQbUllQlpp?=
 =?utf-8?B?cFhjM0FIOGNTNmJJWlhtNEEwV1A3SWJheUVidVk2OG8wb3VrNmRXQ0t4aDhy?=
 =?utf-8?B?NjlybFM3THRBTnJPb0loZWpGaEhCZnRDdGpla1FwUDZNMHp2eGZxNFlXUEhR?=
 =?utf-8?B?enJzTGc3OFpPMmJNQ2FNNit2TXlwYlZ1cGZyaG9PNjlIZFZyYjZOSVhCbXAx?=
 =?utf-8?B?SElCR3hGMFZHOTRPU3doSlBwQklXNGVlemJ3S0JlN2tqaUkzL21UUTlYUkpQ?=
 =?utf-8?B?Y3A4ZTdDS29JRXBiT1RjVTFBKzA5MERrUXE5eW5CV2JIZ2JxRnBJNmRhUk9w?=
 =?utf-8?B?UHJJVUU0ZTNUTHZQZkJRK3hFTksvenlPWHZidjl6RFJNSmZlNkdXUkxVcjla?=
 =?utf-8?B?WE4rWDdMSlVRZ0NuOHRpdkhsY1dOc1RxWm5GMjVwZS8zOG5rT3VjYWZmZk5r?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbf83e0-ac56-4864-1af7-08dbbf212064
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 06:15:20.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +YuAVrzDUaeRZ9lgEBSGycT3FKpuILpPXBU16xbsgkLeJ6sem2RRQ/lC9RCW/a9malLKz9MvmgDeG8xDQQu4xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8067

From: Jan Kiszka <jan.kiszka@siemens.com>

As the SUBLEVEL in LINUX_VERSION_CODE is 8-bits only and is clamped at
255, we cannot detect this way that 4.19.291 also gained support for
dev_addr_set and eth_hw_addr_set. Upstream does not care about
out-of-tree, so work around this limitation by extracting the true
SUBLEVEL in prepare-kernel.sh and exporting it via Kconfig.

This is expected to remain limited to 4.19, thus is stable/v3.2.x only.
And since 5.12, upstream has a KERNEL_VERSION_SUBLEVEL define in the
generated version.h.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 +++-
 scripts/Kconfig.frag                                 | 4 ++++
 scripts/prepare-kernel.sh                            | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index 7654047b4d..8ba95af27d 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -258,7 +258,9 @@ devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
     (LINUX_VERSION_CODE >= KERNEL_VERSION(5,5,0) || \
      LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251)) && \
     (LINUX_VERSION_CODE >= KERNEL_VERSION(4,20,0) || \
-     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
+     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,255) || \
+     (LINUX_VERSION_CODE == KERNEL_VERSION(4,19,255) && \
+      CONFIG_KVER_SUBLEVEL < 291))
 #define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
 #define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
 #endif
diff --git a/scripts/Kconfig.frag b/scripts/Kconfig.frag
index 7921286638..8eae9da693 100644
--- a/scripts/Kconfig.frag
+++ b/scripts/Kconfig.frag
@@ -47,3 +47,7 @@ config XENO_REVISION_LEVEL
 config XENO_VERSION_STRING
        string
        default "@VERSION_STRING@"
+
+config KVER_SUBLEVEL
+       int
+       default @KVER_SUBLEVEL@
diff --git a/scripts/prepare-kernel.sh b/scripts/prepare-kernel.sh
index 64e2484e16..a06a9f2308 100755
--- a/scripts/prepare-kernel.sh
+++ b/scripts/prepare-kernel.sh
@@ -399,6 +399,7 @@ case $linux_VERSION.$linux_PATCHLEVEL in
 	    -e "s,@VERSION_MINOR@,$version_minor,g" \
 	    -e "s,@REVISION_LEVEL@,$revision_level,g" \
 	    -e "s,@VERSION_STRING@,$version_string,g" \
+	    -e "s,@KVER_SUBLEVEL@,$linux_SUBLEVEL,g" \
 	    -e "s,@SRCARCH@,$linux_arch,g" \
 	    $xenomai_root/scripts/Kconfig.frag |
             patch_append init/Kconfig
-- 
2.35.3
