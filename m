Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC584218A5
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237162; cv=fail; b=cgR31+3AVXMH7o4e3AtrPeQYYKy/6r6sLG65m43X9lR1/mroQpwQcReZAL3gbnHNeSoUb9EnUN+tFa02F+OQntq3xU75v4JhardC44Om1JP+U3AYOc91NnEneJbFcnKvRkwycNAKhlUeOv6syronJcSrSTnhkQntK3lbFuDJ8cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237162; c=relaxed/simple;
	bh=CqdJ1/tDR/GAgIBV9Rts001tLIVxnwUXj66Un2DH2lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BERYj2/o1K24KVziqrksWcT6iiCXC8zRuRJS81G94OcvxbPjRopByt9hbCMZYQKuR8KU/UEXJm0EXN870wYFfPmZOCGLl+4YQ1IKq3SzYxId2mryqQ4lfiKyrmer6TsAIoMH5OrJM19hDtxwpxhd4V8ke3W/UB6UzWYV8fJ6BzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mzM6VyM5; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mzM6VyM5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3m3X6cKmPbw0Q4XQB24YWT1rCDvnnaEYIG3W/H2hwUDltIlC1bZwRAYVQcSbwiH46Tx50jqb1LVJts9fud8aDLE3Aiy3CSxX/6BYDD2Jee8Ds9atiiCkc799GhUIcSR0JrBLhLcZY84Nv6wiuVL1v2FDQHUOcUDojvmrIHL0jFvPjIXCaqEeZLerVvUvQaC+YzrceM2mF5g5bkx4ytEPjRDCxX+ry/A4i3zEQ7LxQig1CAORvTvW7wUadyJtQc9464JL1LVvJi0D3sajlzJAQHDXVFXyrf6M+Zx9PHjyteVH94TQ+CVyFq/MZsNKOXxEm0PAo9nh1ThRtcKmyHlUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m+YrcMzTwWRhg3ijJKx7cOAQaBHZw0Anc6+w9QE9dQ=;
 b=GXDHwsi2DB4YAGHkCxPAEoPggR+QLFOrk04ht4JMr3pMeEhG39Nk4ehhy0TWJudla566s4O/Czl4Szrj82dm7ytUkna5bAwcWQk2+1y7QM2Uw62BO0GBUpYd+8wARFEW23oNqqEfNbM6neInS5Rd63wpS3TMXxntuMcxs1bzRte9jE0P7HICwRTuM/OUfJXw1JMq13AE5OkRGjlUFD/RqP1vjjhy4N/et3GEs+9IOvhqtwZhhtvChZSE1rvFRD739a2T3q2InonI/+RWMsWx2A4FwIR3DRDuR5ZcWrXHcH1G2hB6qe0X/jyqIDwkY+7Np0VkQPPlkIocVS60v/jHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m+YrcMzTwWRhg3ijJKx7cOAQaBHZw0Anc6+w9QE9dQ=;
 b=mzM6VyM5LdNQUChjPbcm3Y/EPSzPJNXaIT4w1Nt3LtJoLM/ptVdfQ5goPizGsrq59tsDObpChpCwigrLEuNyzxyCW20UyK5kcdtPnBrUJ0ez9bsNexQhKrQDTdoIUtN4R0pb4nAYIu9frlJml3jh/R9Vw//761hlaf7e+jqbpqhoXOyBEiLR5AfzsVVf6FEjL2LQApJyJZxFGHfq3eZ10GgwssoASJFE72GQWOm2N/eIrUzihru+fWwhfMSBJkh82K4fG2K3+XrBOUxy3l6Ve7cv8gyKslD3nn050wcjsTlVDOCZ181JHNvD0VAIYbNo/OUyML79fk2O75FR78Jj6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7087.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:12:33 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:12:33 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v12 08/11] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Tue, 28 Jul 2026 13:12:19 +0200
Message-ID: <20260728111222.2699158-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
References: <20260728111222.2699158-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d65a9e3-9954-4190-f126-08deec991f47
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fxan63onOGwH9u2T0EzgWzoyvM+47d8+TCyXNWRUsxmHWjeEHPauVPTvOYc/QwWB91JGCjXwt1aXP0/gTke4tjtM+5sRjgKoPfm0gv4WMEsJ2t7ecg9ueVYRKIT9lkrZSPkR/hQTicmXO9J9iGWoAm9YBElsZDBlBk5jalNbM5JVOvusXhK/zYtawXMx0X2InGJknBGS2ixX6k5ddGpBJA4C+u6edo/S8ztUFMUgTBX9+3Q1YGbJaqSA5DXexL5zwPc2YEFwQ7BA7x9qbVr/50/afyiwP+MZ1k0OFYAScREOck+nfdDetaiKENXz9AipcMQeWFUmXgFMACM7QxBt7MPTfDIRy9lPS/o5pe9zZuUw+nzLiTHq/uB0EsBHWw4Sgr7v2wbSwfXBDmbZwaUOokP0onluLQ6BFuTU0C4RAQQlKA9SQ7O1Vsk2rSLNi04wyP9KCvs0I/3eE9RwhLpDnCB8cHP02G/VcGBi/+HPw2CKr2CPOtmbv/k3DwY+eYNoaP0s6DMlFCHjdQjhIPsyHxqo0Yk3L6afP5wlGfxIKuMzAEv2z0Ct8ECN09HNm0b9dSsm1h6EygBhneoDC3VJoLzGHHDDTTwYHhLdv3q+S1H819mAWjuqeQ9E2puckKeY4nUQNppxu9MpU1XT5ubAXviFnP2hlAJt1/IuJ+hDvfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qjZxvvEeLz8FYKOx3iSQMRCGg85mSLXllFs2a37Rl1B2DmsGcf9oYlCsZkfm?=
 =?us-ascii?Q?eQVzvTiLfGyO+1QUFhCFeRX//YTyx5MdvmSXr9XHlttZdPOvQjwzgfHTXnfY?=
 =?us-ascii?Q?VcVXFnCuISe5j9nIJ001i9U/IzmdXvJp7pz2OmRNHJH7KYqu2tpQK/r1VUR3?=
 =?us-ascii?Q?iY7q8LSysd0UdXAKa6A1rSPKEPbmqQndtxAaY7Nl53JS8uXizNPZB6tU/Zt9?=
 =?us-ascii?Q?LJW7zvFSwd2DMvEqi7IgjA6B4+uZlxHS8yMCgxZghkfU0xNk/gRCUjn/3EKY?=
 =?us-ascii?Q?ZSsforRwOEDqWZ2F467xpjnmr8Dno7d+W2QAKvm6WbpeP55WMyq8f9kA2qx2?=
 =?us-ascii?Q?fAeXDEHY9DSukSwnh3oUd4ogF9L/jWzR/50MQOlBMG8S0W2jJrTlAHt0QzzG?=
 =?us-ascii?Q?IU8ekOcMzziuc1Mz1MncEQhWlwQ5gKb0qciRsKjTU7AB98FJAIHYXnpL2Ao/?=
 =?us-ascii?Q?umYv47/VgBoe1bsx6wCWsjM3XX4MfTEjDl/QEbOIzNPHIHkyii75oBqMUKLr?=
 =?us-ascii?Q?v6eb0tAyhqShulhKM1LbrV/O1vMY19VshuWi5V4VkiCPCSHgZQbMcy98cJYw?=
 =?us-ascii?Q?4qK0/Bhz342Fa+Y29mo7mbP58ZnrCRkQeUIxjdGTbP6RAClzl5sj68azqIXB?=
 =?us-ascii?Q?THh6dDN49e0XEAU1w+HULttSj2VXnZHTCrkzgPQVFrNrgZt6MK/b5dv0N+tf?=
 =?us-ascii?Q?6YDgI+ksMRuM6xTrGvWyTj419aeTkBrADsQ+sadeYn3LdOBt4MXWYBTBLlfZ?=
 =?us-ascii?Q?Di3raJ+1lBHkAImufqSdt2trgyJNSkDPgN4Dkbi7k7Tp+VTfgivIwUNuQNVD?=
 =?us-ascii?Q?qT6uh+CPi7eYTWctGo03oOaVTQOmVECv+0Qqi9XHn5Qf2I+WAA53O0FCDkkE?=
 =?us-ascii?Q?3TRiagFRLYSEc9wYvpuJzJ7b3bcCGKLnipQtEXFglX+Z9EA4Hg6Wee/snNBn?=
 =?us-ascii?Q?FADkuwU4+csUyLFmKUZfarAEJT4QsUYSzxTARIWcgjzAphGp10qbSqrqe7O3?=
 =?us-ascii?Q?G963lFzplsVeJKaJY6sBihPRV+myOGIrLjrkTM36LUizIgHnwCxOz4VCzChD?=
 =?us-ascii?Q?gih4BjCVIPLCSU/LdfpG3Df79gBIqb86t4NQhdr2Lpcdfg9Qn7xntMgEQE8i?=
 =?us-ascii?Q?eIu0f+gLVO48bSZdYNPEWnGmMkpcB+vItqKbOv9YCZo3EfCZhvt+l5iHoRhA?=
 =?us-ascii?Q?XuB+MRiFZayouO0i9xuZmXg1k5o9Stn3+8LOVSHZQKu9G/rpAzzegiE4gMQ+?=
 =?us-ascii?Q?+x4VIb5JBFAyQIHIFhbGJbzgoueLoIo12N6j/sASctbeOvqUwfPNe+Za/xfP?=
 =?us-ascii?Q?z4ZadBmfbW+zGxdtqbYW8Angnmh5NQbxkARtp2S8iqJJEjUK1okGiiIBl4Cz?=
 =?us-ascii?Q?U7POCu6cDIEZKX5wIfk0YpTW/U+7KPFUPRSobvsl5tfahqymvSOeuzc1zCK3?=
 =?us-ascii?Q?jkI9080xG6FGQXDZYzrXws+vL8u2V5dLzCy1ZbSIoD7EoceYXVVi1ZgbmDjF?=
 =?us-ascii?Q?Tn5pY79bopo6Dnlj2nAv1hWpEMsLQlWuFopT4KgHS8GhGT4zVSaJTH0dTBF6?=
 =?us-ascii?Q?TY9x1JYH9Vi64Vvv7e2LiEMnl3Iar6QBSg31SJHsHzN4/Ee0kFk+X0n2NVNA?=
 =?us-ascii?Q?u6YQyQ/LAetM4tsdnd0bhR2/QZdXwcoDOWNGv1FQebhNT13V0Xy+a/QH4/bX?=
 =?us-ascii?Q?ZzG3TKTSSp49hcqjDoSasxuU43g3OrBc/qt8Fnd5rJ1nw8lf082cF/t+SB7r?=
 =?us-ascii?Q?McTNpheguNfz9x2rAl/u4Xn7/iSGlL8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d65a9e3-9954-4190-f126-08deec991f47
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:12:33.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dH78Wwngj1YlZHmo9sHwl0jFBaDjTJJvYhAtItT9dxxV8oGvR4IvS0kYEo5RPwij05Vd+86jiCZ6ZFxGyAg34cL3QqTV/pIMjrapk0natXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7087

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/clocksource/timer-riscv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index cfc4d83c42c0..fceebef28978 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -71,7 +71,8 @@ static int riscv_clock_shutdown(struct clock_event_device *evt)
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PIPELINE,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
 	.set_state_shutdown	= riscv_clock_shutdown,
@@ -150,7 +151,7 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
 
 	riscv_clock_event_stop();
-	evdev->event_handler(evdev);
+	clockevents_handle_event(evdev);
 
 	return IRQ_HANDLED;
 }
@@ -182,9 +183,9 @@ static int __init riscv_timer_init_common(void)
 
 	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
-	error = request_percpu_irq(riscv_clock_event_irq,
-				    riscv_timer_interrupt,
-				    "riscv-timer", &riscv_clock_event);
+	error = request_percpu_irq_affinity_flags(riscv_clock_event_irq,
+				     riscv_timer_interrupt, IRQF_TIMER,
+				     "riscv-timer", NULL, &riscv_clock_event);
 	if (error) {
 		pr_err("registering percpu irq failed [%d]\n", error);
 		return error;
-- 
2.43.0

