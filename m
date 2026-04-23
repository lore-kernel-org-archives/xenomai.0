Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D158E3D47C7
	for <xenomai@lists.linux.dev>; Thu, 23 Apr 2026 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944404; cv=fail; b=TnwR2/yLLFt1Qv9pvOIsRDx8A1+FrYNrYWlYWhcqeVFLlNGBGJSOejbIRTATCf9oWSYhr7AZogXafn0YtDhiGYxs87FpFo0hKHhg6eeBtawa/OAbHu2e1xfxmyyUOIZqimlkkNqCr925rj35ojFJ3b+Muse0rJfnL83SG6GbdpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944404; c=relaxed/simple;
	bh=BCVt3s9WBTQsnUyehm2F5ysqJtBZz8X2SyFeZe0slnM=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MBq8XZtGzhSrBpJYJDfT6oihXWK/bDP/jrd/d6IXOXF3noxiEIi9aMJWuAo7k/sa5IS6Nf5WOMeFbpGy3SQIFcqGagffmquGYm8s6woinh+1GO2DuYphYiVtfJj1PJNOVYdlLf2oVkbAlzvYW34erUlzldmHL/jmwj0ppvs9nGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=g09/NRcr; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="g09/NRcr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pn9xM+GgZVtNVddEg1ce2jvCpkQabxvLBqmAbT6O1FF7RPChGQSZTpeFrLsFpKZMJ8OpvHc9mT4wm9eAn9Ag2vW8HKJ9Rp9Kybcgpy/oesHAjLlz8iH6b3n3JjSwc0FpqtT4wT/iYX2C0NCEhZVG0KgNFwsi6N8WU8pvbl1iJdMJ5muCt9d/RQiTHpIS11h4eiGkS1D5CgcuLkDl7baz1IgEEvYUgbM5fwGo+7HxU7Q7ipL+8/bbp2JpIN+t4mPPVxgCM7MHOyS+G9BFOFUblVmkEwA38VD7qOUZfT3Q8lVn6WTdXspOK7cPo9bH2U1HLKAC6aHPTEjZRx1cEwfSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2gPUCZj289QUHsh7SeNONHInaybS6DgRgMtnTHWI6U=;
 b=hbG5LNYyUoxqH+mpBx7GPf5xU6nPMq5FeRs2aqLekJptE0n8y6Tb7aspZW/uBurKevsgu4ZpUlKnX+2q3EL53w5I0s0NKqKow/Gm6NAl5DShwq40E2gOrdU75TmUz6b6rxPCcFzsncgffVUEgm1ErD45EGdPWtKR23kR0zJtdJuZ7AwGD46MaZYFvO+Hi0hIpUxCnpuL3vaDYWacfZg1bvLTHVlJ+X8Z9ffPrZX0UBSrHf2N8dSl4Cb/3zV8w1jXdPV8WDnnWYEZFppQvFF52dg3+SDsNKROjQjKateAL+/8S6huk8Jdn1uDx1ccbv30SZLYgerQGUt0aRtbSWDuJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2gPUCZj289QUHsh7SeNONHInaybS6DgRgMtnTHWI6U=;
 b=g09/NRcrZaZVw2n9iOq4C1e1Jg6PkZxq4bUmufAJyLvr1uV6EmAOiWZoc9EfNz1DhuXFDNEGy+bi7GhHNrfnDHzF2grhh0P56ue1qMHevrA8NIfOozfGtXQiRB47fy7sWGlFjOyzeyp2yVuwdCRfMlnn2TBp+10XV0KhjLJlK/bFIqFOA/c6ELddJGXHU1oWFCRDdeJiq9sYKwSFa12oaG+Kp8q+k6+IqzlsX+i4DUC3L1luaDKb6XbEwYt13V3OmN0kBJ8PyfbTplTI7PnIF7LnuPvNsecT/WEMWEAfWyICyqeMcBLhkMSYNcI/pH/FRnOXftirNkgBUQV2MyQq/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:40:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 11:40:00 +0000
Message-ID: <d7b38c4e-b6e9-4888-8d87-ce69879aa388@siemens.com>
Date: Thu, 23 Apr 2026 13:39:58 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] cobalt/posix: Drop empty pipeline_attach/detach_process
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
References: <92210d1f-5f24-4f57-ad24-5390d796a9db@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <92210d1f-5f24-4f57-ad24-5390d796a9db@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 225a375c-697c-4563-8454-08dea12d0d20
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|55112099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ZX+ETRLdW0e5vv15AOvAXJo77rIyqAiBA+rUaFty1HWjzOGh99zZ4QRcQXyx9yReSSgoPIZiaQAPE2qRb4s1ZUuNGYqZBreAMi5MIQbynxmQw+TNFHzEOOG0cdKi7re/NlOCZyZrS0J8N3x7T5YCdYOMzDhg6si3Vt4WikGaN7q2o378BCni4v5wcXInhT2WMr14hfLcOhF7zFuHUjnmo2q9C1gZPnlIqwp2N8PTAmwiAnlteb0OLV/xU6Qglpz5X6y78IVbahvvVvcemipsjpSs1ZOmbb/dcK1ORdoc8o5Btzp8VNmIrYZyKaBY8aH8BHaZBjP/cuJP+3XVR6LJYtw7IxC0lUeuifU9vVMvv+b4Lvx6errUK/DR9v1MrNWUKKeGwcuUnYdgFuZ19XJtRRkoShRtFKVgkbsbHhb7Rcpd5xZsLplLrl7dlui+yiXhtJAz8O7gqC5LhZ11FtMyJE0Cak1zmEvR25BV0gIxLszRsC3dY/wvETLqPf/5mQhXM/JU+Leg1RJvM1UP5GlHCU+nz9FFx4u6OJaRr0e3Rq8r0+ROkQPDk/p/2f3wo8QGfCdM84ZDvfoTgoKMLYt54UdA5mXqv4R4ypmVlG+SVXcTWKNP02oc0edr+cCHI8PXd3j5B+Yu/Yszx0nVBGjS8g8ArqTB8Jq753FM1ZjGIieLwk2Jm3WaK41+WumXToOd/swHXUogcphrG4qvq3TEpkbUftKZSIQ5juFd57o7OIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(55112099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0NTZGQ0cXV1V2d0WVJ4clkwWmdKU3ZocFZDWnpxOWtFbWhBVVNCRG9WVE1P?=
 =?utf-8?B?OWsxc1RFQ3I1QjJlTlhML3RiQVV6bGtCTXlkLzdweEQxZjd4ZThJenJZMW4z?=
 =?utf-8?B?NU9jaUZzNngxUW1wTzRVanMvWVRDdTV2a2FJc1ExZTkzbXZBcjc0Q1BFcVFE?=
 =?utf-8?B?YndyMTNHNEhSZXFXZEFGckVkdU4xbjBLZTM1K3JVT2pKeWVseGhKeDg0UkR3?=
 =?utf-8?B?MktCMHREbllBVEtmRVE1VmJhcVF1VHJUQVQxS3lna3pTOUs0MWVLcU9QM1FT?=
 =?utf-8?B?QXRHM2VncFk4WmJQWU44S3BrV2I0LzFPVkx6a2xJckE5UzhVWVpLbW82VUFn?=
 =?utf-8?B?dGV6R3RZN3RVQXZSbGhJMWg5d2VheHFENHlLSys2U1FSdVhFSVBNSUtCU2U5?=
 =?utf-8?B?WUw0UXhSZkZnWmVYR0tmNDFabFM1RllyYVR4bmcraXA0YXBhbW5xdFN1Yjlo?=
 =?utf-8?B?bUpZOEdmV1ZraFRSdmpyQzZtNmlVbzVaYjJZZmkrV2RRaFR5WjE5ZXh0VlhP?=
 =?utf-8?B?Yng2RHVGQTBhZTNQRWtRRk9NSGNHUExVSWdBam0wbW4vbTFSSTl1aVVYd0tm?=
 =?utf-8?B?Y09CK0pRalJnQ05mSUovTU5yM3E5cUppNlR5dngvTWNpZkY0aVhyaFhKem9y?=
 =?utf-8?B?elFyNGl5VGRQdUtkUnloQWZhb3pzTFFDSjhLc0hBclJvWVpQREdSUXhYSjRa?=
 =?utf-8?B?RFgzYWJNSUI4K01xb3paWVpDZzNiMXA4U2dveldzUWhMTm13ajkzZXZDeGJE?=
 =?utf-8?B?RnMyTjZhU2tFREJuM0FUblBta1pUSlJJeHVNNHUxZ1piZjZ2V3ZmNnJzM0V0?=
 =?utf-8?B?dE5Ydy9FbytaSDdyVlc3YStMbGFIVk0xZzhhK0JRUkN2QkgyNm0vaDRiREpi?=
 =?utf-8?B?VXlNODA0MnRCQkZsMmxkeXRMSm5nSDlUenRLckQ2L25HVzFrRDQ4UnlINHF5?=
 =?utf-8?B?d3hKS2gzeE4zampmNkRybk1PYU0vLytQTWJIbEMraDc1U2orL3UvVEx5NVFX?=
 =?utf-8?B?cFNEV3ZXTVBBOERoTjQ3VDNDeDJrTkZSRW9GTFhuUUM3SVdTTDNGbVVhNUl4?=
 =?utf-8?B?WlVHbjVOQzM2WDFUVXpWbjhYaVJOaEdIWU53QnZreExPWWtJOE1jcFV1VGMr?=
 =?utf-8?B?TkdsRlBPOGJyTEdodVIzZ3h3QktHUVdJS1lPTUxBSlB2dkthUmhuVUF0dVN6?=
 =?utf-8?B?bld6RjNobzhBM3pkT3JIbFkvdEduVXhQWDFLRHo1ZllqUGNOZzhjNUZJSEVC?=
 =?utf-8?B?Y3hXb0JrTDhoQTFJVXdKYUM4dDZxTmZtUjMxdFJ1dW03TFAraFlDeTlFNXZB?=
 =?utf-8?B?cVlScVhtRHMzK2RNZTZQTjQ3VGxrdjdWViszWG1DTFlraU9Ldnd3WVhXMTRi?=
 =?utf-8?B?NmZCRWhHeW02WFV2SElrMzA4TWFCSUtzbXZISS90d25rVXFUZTR6RWdDUGtZ?=
 =?utf-8?B?V0ppcHVDc0tHT2piNzArSWJ0RFQ4MXU3L2ZDL2RuOGRJV014dTRkalVyVGZV?=
 =?utf-8?B?UkMvSmhlTW1vdUJVNENUQW5oNHhDdytBRG9NWll3a2xCMkpVQXVHcFNRcHZr?=
 =?utf-8?B?anE1bmlTZjVBZ1czM08rZE1UcC9ZQTd0ZTBjem1QeUhvWm1vVzdNTHdGNzBD?=
 =?utf-8?B?SXNyQ0tYUmJEMVpXLzdUMDZJYytwYXcrMWt2cUpEYjF3dzBxWEEwa04xc1Rh?=
 =?utf-8?B?UTlmRVFUVkh1OHBDZGdUSm9hc2s2ZHZUek9MM0xnZ2lKUXk0L2FiNUczMWhR?=
 =?utf-8?B?VFFVSG9sRUNQMm5VTjRsUHV3VFBJNW45WkhTdGJuMGEyQ2pFaHpQWUNUWEJs?=
 =?utf-8?B?K0FjWW4zS3JCSi9BbDE0SjdKOEdIZ3FtZzEzaVV6Wk56VHArNWI4bUZJYTIz?=
 =?utf-8?B?M0FTaStNa0RpNTVKTmZYb0hqZjhxcFE1Tnc4NllCMTlzZDUreXF2OUxuem9x?=
 =?utf-8?B?Y3NLaVBEbkNnR1BRMitMYlBKZURiZG5neCtIazRiVUhZTytyNmxJWG8vbnJl?=
 =?utf-8?B?LzEvVFI0eW9BRWxpT0xiZ3VmUW90dHlNQ1ozTmlJVnZOQlM3UEE0cFhrYUJI?=
 =?utf-8?B?T1VnT1pqcEpsblNHOTR6dHNEMjFVWTd4d0FkbEt5bUJ1bFpkaXdZZlI5elFu?=
 =?utf-8?B?b01vR0h1SXYvbzI0dmtOR3E0QmEwU00zb3RjTWR2cjVGajdLeVpOeVZlZlNX?=
 =?utf-8?B?SDNqajd5TUhwT1Foc3B2bGN1YW52eUZlSnplYXRteWNHRXI2bHhPNWRzR09B?=
 =?utf-8?B?L2JaWWdIWWJuUzZOemtPelhKZzk1YVlFQUpEYVVTVWR4dXE1c3ZpdndNaElJ?=
 =?utf-8?B?OVFmNmpYbkJyaURrWnBpYWo1d1JWZmROenNjSUpBdzZFbjJzSXUwQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225a375c-697c-4563-8454-08dea12d0d20
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:40:00.0334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJ4F1lDGxs6lP/KgOf6IrrUJaSYWkaSewKahZEfCrZBXb8bK+z1x3N+PTRWs7IYsYlnW7r4pyUUB3391W7VcXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6252

From: Jan Kiszka <jan.kiszka@siemens.com>

Never served any purpose, time to drop it finally.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/kevents.h | 10 ----------
 kernel/cobalt/posix/process.c                     |  7 +------
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/kevents.h b/include/cobalt/kernel/dovetail/pipeline/kevents.h
index b7502accd9..1fbc8f5167 100644
--- a/include/cobalt/kernel/dovetail/pipeline/kevents.h
+++ b/include/cobalt/kernel/dovetail/pipeline/kevents.h
@@ -13,16 +13,6 @@
 struct cobalt_process;
 struct cobalt_thread;
 
-static inline
-int pipeline_attach_process(struct cobalt_process *process)
-{
-	return 0;
-}
-
-static inline
-void pipeline_detach_process(struct cobalt_process *process)
-{ }
-
 int pipeline_prepare_current(void);
 
 int pipeline_trap_kevents(void);
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 2161ff5584..7f76bbabcf 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -1002,10 +1002,6 @@ static int attach_process(struct cobalt_process *process)
 
 	cobalt_umm_set_name(&p->umm, "private heap[%d]", task_pid_nr(current));
 
-	ret = pipeline_attach_process(process);
-	if (ret)
-		goto fail_pipeline;
-
 	exe_path = get_exe_path(current);
 	if (IS_ERR(exe_path)) {
 		printk(XENO_WARNING
@@ -1022,11 +1018,10 @@ static int attach_process(struct cobalt_process *process)
 		goto fail_hash;
 
 	return 0;
+
 fail_hash:
-	pipeline_detach_process(process);
 	if (p->exe_path)
 		kfree(p->exe_path);
-fail_pipeline:
 	cobalt_umm_destroy(&p->umm);
 
 	return ret;
-- 
2.47.3

