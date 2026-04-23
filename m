Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010019.outbound.protection.outlook.com [52.101.84.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D636999F
	for <xenomai@lists.linux.dev>; Thu, 23 Apr 2026 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944383; cv=fail; b=FPR7a/saH59l72PWCA9YhDPWfuv5e9p89+XeWzuu5d1taCHZkSPjt5iEqrO+9K8spxOSyT3xfmT/JhpNa4pLAU1z9SPOu668Ntefip8w8qWevPk1TUaxb6TPiMZRId2drL8luwDa0yUqKb/ql97w0iHtvSdcMNT4XgeITRiwErA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944383; c=relaxed/simple;
	bh=bOfJpQX19CshsUcmEZyYfXh/6EHcuzDPUYzejBPG1hQ=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=srtbSlPjuDK420VWdbhZdrPhwit/D9LohgwRGYZ7OdZQxk+XgUFC1Tma59vl+3LYahv21l4MoG1lElmjL2vCsKoHt3i9SPosV6fEor76LcncJdE+W/IIhkyWK6DdhJcFj/Xd9rlG34Pg9qXUCWxD3vne/pHacYMS9AHsqr/AUy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=r8K6mC2E; arc=fail smtp.client-ip=52.101.84.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="r8K6mC2E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shJjackzwXCLp0Z5nYpFKswSYXRlrJHwIjl5Cc+02jDYdNUOipDkliWm8KQGdOLxYZ0H2NFuzIpYIruFdLY6HEdZEzobA0AdecWoDyCtgCkXz62gwJIOX7QiT1dK3wgOy5iG+Rpvzu5VxQHGLg2GnjtaANRDAlH1VyuEM0szwMi9/Hw1J7OCvOc+8babm3PQvRkf0WyMeEf4JZb4DxLSBgpdgrBQfuKbajU9YZdwh6vYieiMR7eU9oYKKyg/2oDi/G2WhbJpt73aGQhU/XD7erQGX5Ol80xv70zWlEEw9ST2AMBrG/co3w9rNd2/PD0IwqavnJCP5s04/R5M0A3kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkLQCoX0p82W8YYZunWlkFGJOpQW+fSSU4FobGw4/XQ=;
 b=fNayxim1Wq1ljVPAgn0gRR4tAoCwfvjjwPCGWmqOFSa1uBNc4PDNIbFFCv8WQD931WRXwHA0uttgXv/u6w96vlAL7cmiy/AOLTTztxMZu9IWOIepHnuaFrCKur+lx2aWA7pk6wxKb4PRQlsbSbYF6nFtD7g0qoc5XV9HKeDElFt2dOLBOQzjNvp6HezVcPrOI30sslq1zZb74OJGFfbF0xrEzdqIwp1eMWPoPPRkA4+OEct79iH8f/qFYi6+aJ/oQvTfjxEQtZXIisMJIlwY5Vq+AVfbe4fX76a7UgLbMbsAhI7PH+ZH6QyGRMa188LHvX7b/himf4PxFQQjqEmAHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkLQCoX0p82W8YYZunWlkFGJOpQW+fSSU4FobGw4/XQ=;
 b=r8K6mC2EGMo9Hr+J94mb763ymXKLZ9eaf+b7oiFLH3F8w/cdLMhpIL+wE+jTbZn+YCSIa2SQW//6+TpieZu5mn3MlMku5WLw7Mn6gNZdLKeTj4T4N+7ntiS0h0wDghdc3VSP5V0elxvICXjmhezFtJo5IZ1aJR27eQoI9+wdzK7pDtni1UN1lMS2Aq2LuhSMwumSDZgkMXDELnWE1ZTTFtJ3Lx+kRHbkNl/xLWkANkzXCFgI8Aa1k4DjzWyCn7L9yE0XsfRf6wkCMrww//HtGzNtSSO1q24d331b2+ofmoEMcH2n+TGFAw8nsOW0ERVTQ+6uaKHgJOp6rV0OpNaKLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3711.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:132::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:39:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 11:39:37 +0000
Message-ID: <92210d1f-5f24-4f57-ad24-5390d796a9db@siemens.com>
Date: Thu, 23 Apr 2026 13:39:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH 1/2] cobalt/posix: Fold pipeline_attach_current into caller
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3711:EE_
X-MS-Office365-Filtering-Correlation-Id: bc244eb8-3e82-4f05-2bdf-08dea12cff68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|55112099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FDT359ESmqsyjMKDfq0YnXzgaX8xxjdTZ3u4Pe+9jJUx2+Be6JzFYE+rC57GJA5wN3YYGbSQCqvklOA4lL892idcPFIMLDtRF6IEY71/f/mtc46YrYwvmTkouK5vgsUqufvQvL1RS9bK5m2Cm/0yFYplv0JVH1fKq8Al5o79vGn6UznYIjjpqVuHCjP+IpRpCTJWpWE90gPxvBYx3s6AihsixAN2+boaINTqusxszwzQyC9NfwrCnn5+0EuogKqwtU4p7xCYk7YBqKCMb5b4MfF16agEjhjiu0lhph9csonUJ6icrcJnaiHC9Qo4esDF+DnkMJJFum2zf/bokBy+LGdIrDHyjYF7dPq56HHMFVLxz0R5v8XrdS3hMk//58SSgVwHGTI+wEI4uYi8vLO/X5vgKXJ9jQJGKlyFGpjOBVJ1Vf3KY1+J1tIHLrE+HCm90AFS0m7mtnQl/P0rUFTQzlN2/TKSuyPcXjKSwhj2l3c4Ipi7wmH/JOg8S4SbW3yT35vTdF6RKYxpvYL7AeJ0V049DZgz4T9DjxSYzEFcDvi/jeq//2nIPKJevzwHSealkAC6s4IpU5amcnXFA/bkKc9aJQf6c1aIj6Coin6tK+H1NEWQ4UrJ+Z0LCpquojhq3QCoey/dIgn3puPcDGWxat0+iwWBCFhlDMRjd2XjbJrOIRZh3WfSgYht5W5ky2ZuDa4/oSXT9ZsUIO7D/AMepZDF19p2wAYDu7qt2UeDrjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(55112099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUlqVnBuN0pvQjdvY3R0MndocTQ0dWRmVEJHZW5SZ2xWd3JRV0JDVkhvUnlH?=
 =?utf-8?B?dGJabkJYVGdha0NjNGV4NS95OG1KQXJaTDcySGNXMkNnaUhtZHQrWVNRQ3pZ?=
 =?utf-8?B?T1pBUEQxZmlqblFTRW9wMTl2VWcvK0g2MFM5amE5OUxPYUt1Q3JDUCtwM3RB?=
 =?utf-8?B?VVVwM3RxdjJkN3ZrVUdpL3J6aENSTEhPbzRrS3lmbXd2bUFmRUZWYTV1SnhK?=
 =?utf-8?B?NSswekhlZjZaTmp2TkFsT29NZDhZYWxidU9iUEZFVVo0UjhLMnJuN0V3ajlN?=
 =?utf-8?B?WU1mTjlmaUxDdXVhSE10NmV3YktOK0dQZ01ldVFVNFZiQ2VTcnlkMVJ3dTVB?=
 =?utf-8?B?eFlNb2s3RGxoNzBBbVdRc0d0bXpNdU1Vbjh5Rm1uQklMcjRYRDA3dFIvNlVl?=
 =?utf-8?B?K01VV292VXRaVkhWZFhFNkVKQ1BncnltWDlBTEh6YldzY2hMVCsxaHF2VnZD?=
 =?utf-8?B?WVhxWnZMVmhINFpHLzNnSXJWZzF3bVlYRVdXR1ptcUxBVjd2cG1iUFJxd1ZM?=
 =?utf-8?B?ZXhMNlRvMTVYcS9xM3pQckJIMnFqdmlEbk1CZkttUUVLaEh3NDJnSTVUUkxU?=
 =?utf-8?B?dDdmNTNQR25WUW9tbDBaR1hnVytnS0lCMHkzT1U3blBqaWRYZTdHeFpEK0lW?=
 =?utf-8?B?VDFsMEhYeXBnbEg2U2R5Z3dqM24ycDhrVzdXVlBVaXJzN1pvcDhKOFBockkz?=
 =?utf-8?B?WVAxZkQ4SHRpemwvV3NOcXNCTytZTzhxN2t4Yk1sMUxEVlJrTDZ5N2RQdllS?=
 =?utf-8?B?K2tWRU5lVDNwYm9JYmg5N0pCdnFobFdzYXNtVEF5ZWZVbXU5aFFIa2RRY3Zl?=
 =?utf-8?B?cU5rQ0taeEYvRWlLT3MyYnJyck8wY2wyOStsK3d1TlJOdTBabWxuMUVWZUw0?=
 =?utf-8?B?QXR6WmVWL2ZFRG53bFAwdGVNUy9jV3lPMmk0NDNYUm1DSng1dXU5OXhNemdN?=
 =?utf-8?B?a2ZSekxJNk1yRzRCRTE0YjdLSE5UNVkxeEh6bk9jNk5FWUEzb1JMMnFFY3dO?=
 =?utf-8?B?NUJ1U0gvYUl6OG41T3BMRmV3UmVBRXAvVXpDbnZmbHVsaGIraDZNNHdEbHJi?=
 =?utf-8?B?RGlsdWFTdzFVRnBPdE9VUWlmZ3A2SFU0L3ErUHlwYUYwcE5BNFNUN292bUU5?=
 =?utf-8?B?YnNSN1dDMkt6UWJ2QmYzaDZDYytHdVZhVExnNG1rNmdValphOWs3MEVOUTJn?=
 =?utf-8?B?ZGgwYnNrRkt2R2xSeTY3ZFpyd2FQcGp0RlkxTXJDNTZJYmJrZW9oVXVoL1hy?=
 =?utf-8?B?UldaTnZRQjdMa1ZrR1EwOG9GRkg3bnEzY0VjajBJVTVRWUU5cmdXelEwVnho?=
 =?utf-8?B?YTNTVFpycFRkb2pXbGpsSUZ3Mk1rS3U1TldMUkRjSEFDMjl4NE5QSVlya2Z1?=
 =?utf-8?B?RXhzbUxoRWlCbjUwb25Sc3VwLzBDTmpNMENLR1d0L3NDeXNMSS9RNWxOeVE0?=
 =?utf-8?B?Z2UxWFJSM0owNVU3MHduMmlYLzZoRHdHYkE3cFVSYjZDSFM2cW5QanEyeTBK?=
 =?utf-8?B?N1I0MFk5aEl2b2lDLy82NVNmR0gzK2hwdWxWZlRVTVdFRmMyTmkyNGMzNFhy?=
 =?utf-8?B?RGhsTjBRdktuTTRIeEl4R1dra0R6M3dIajA3VWRwR1NSRjAwamN1K2RHeExB?=
 =?utf-8?B?eTJvVml3YklCT2RNU3JCM01wSDRDQ0wyRWQ3Sm00b2FUaXFoanhMT3RveUI3?=
 =?utf-8?B?bDBkNlNGc2U2VzZ0ZUUyK2R5YUVQT1lEemkyK1NmZ05od2haOGg5YUs1RWRh?=
 =?utf-8?B?OXhqNlVGRlhaVXMzM3A5aFowZFZtOXZJRU83ZFBibXZxazlPYU5uV0duOGg4?=
 =?utf-8?B?N0VlSVRlUlJXdHlIU1o2NFBJUXRRamNONkFWMzNkeW0vME03dmwraUppbmk4?=
 =?utf-8?B?a0tjd3dsdlAzbFJ1Wmx3LzlUdFdUQTliTENtK0dTMGRCWm8ycW9TNlpDQS9x?=
 =?utf-8?B?MVZSYTRucU9uc1VVcW0yanBPZlJjRnl3U2xQQ1RlTCtsZGtjVTR1NTVISFRZ?=
 =?utf-8?B?eUlkeGNMUnpCajM4dzVJQmdqRUFoV2M3WGQ1QmtWbXJ5RldWd1llVXJBTGRP?=
 =?utf-8?B?TlRrYTk3UVdVblN0K2pYL04vblQ0YXNLL3FybDZOWG95RWMzNXpVSHAzbjRN?=
 =?utf-8?B?OG53ZXhXYzB2SnJhaVdnSGg3ZkV2RDNmZ2dnK0l4RGd2Qkx0cWxOcExleWo1?=
 =?utf-8?B?dC9ZN2pHbVAyWE1jTnBxQzVnOUY4YmNIdnZTMmdOQTdjM3VsTDlTTm00WCs3?=
 =?utf-8?B?QWpQd00yOTU1NGhzSEs5d0hDa0tWNGV0SVhuU1pBL00rTisycEhxQXZ2Wk1Z?=
 =?utf-8?B?QWl4YTIxNEJsNC90dUtVNUk0ejJ1eVFnRWtIWFFGRVNOT2hjQzhRUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc244eb8-3e82-4f05-2bdf-08dea12cff68
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:39:37.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4LxblZYovcQG7IUecrMT+eMgYeSJkeixhXiClY4CNlpaJK/AWj8GsVcLQMv5xKDnfq1Ty32uGtwZBF7It9e3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3711

From: Jan Kiszka <jan.kiszka@siemens.com>

Single caller, no abstraction anymore. Furthermore, the caller already
invoked dovetail_init_altsched before, so we can drop the second call
while at it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/cobalt/kernel/dovetail/pipeline/kevents.h |  2 --
 kernel/cobalt/dovetail/kevents.c                  | 10 ----------
 kernel/cobalt/posix/process.c                     |  7 ++++++-
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/cobalt/kernel/dovetail/pipeline/kevents.h b/include/cobalt/kernel/dovetail/pipeline/kevents.h
index fa47f0375c..b7502accd9 100644
--- a/include/cobalt/kernel/dovetail/pipeline/kevents.h
+++ b/include/cobalt/kernel/dovetail/pipeline/kevents.h
@@ -25,8 +25,6 @@ void pipeline_detach_process(struct cobalt_process *process)
 
 int pipeline_prepare_current(void);
 
-void pipeline_attach_current(struct xnthread *thread);
-
 int pipeline_trap_kevents(void);
 
 void pipeline_enable_kevents(void);
diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
index f31f315d19..7402e2ef6a 100644
--- a/kernel/cobalt/dovetail/kevents.c
+++ b/kernel/cobalt/dovetail/kevents.c
@@ -330,16 +330,6 @@ void resume_oob_task(struct task_struct *p) /* inband, oob stage stalled */
 
 }
 
-void pipeline_attach_current(struct xnthread *thread)
-{
-	struct cobalt_threadinfo *p;
-
-	p = pipeline_current();
-	p->thread = thread;
-	p->process = cobalt_search_process(current->mm);
-	dovetail_init_altsched(&xnthread_archtcb(thread)->altsched);
-}
-
 int pipeline_trap_kevents(void)
 {
 	dovetail_start();
diff --git a/kernel/cobalt/posix/process.c b/kernel/cobalt/posix/process.c
index 854e3a6657..2161ff5584 100644
--- a/kernel/cobalt/posix/process.c
+++ b/kernel/cobalt/posix/process.c
@@ -595,6 +595,7 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 {
 	struct xnthread_user_window *u_window;
 	struct xnthread_start_attr attr;
+	struct cobalt_threadinfo *p;
 	struct cobalt_ppd *sys_ppd;
 	struct cobalt_umm *umm;
 	int ret;
@@ -632,7 +633,11 @@ int cobalt_map_user(struct xnthread *thread, __u32 __user *u_winoff)
 	 */
 	pipeline_init_shadow_tcb(thread);
 	xnthread_suspend(thread, XNRELAX, XN_INFINITE, XN_RELATIVE, NULL);
-	pipeline_attach_current(thread);
+
+	p = pipeline_current();
+	p->thread = thread;
+	p->process = cobalt_search_process(current->mm);
+
 	xnthread_set_state(thread, XNMAPPED);
 	xndebug_shadow_init(thread);
 	sys_ppd = cobalt_ppd_get(0);
-- 
2.47.3
