Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76992E173B
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459738; cv=fail; b=R4lc74JNbaiAYkKlzWjoTqSBM4SHC7WcGqiLKCDtbn1THt2z6/Zo2ubBnJBmPJKuSiXR2/sESb5OVLhVOsZvKDCMM85u74ZyPPYS4CMQXNF0Fg0KWtKfl8MAQfkDK1jU5bF+E7HIO5TCAj0/Pgh9PcFgqlqobMZMWqobkelnunY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459738; c=relaxed/simple;
	bh=9PG8eHOtKkWnhrwcvJxDfTqwvB+d9OYw1cvT7ehJXWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UWOjsb6QGjIxq+Wk+5ctc6Jw4I79z/sDNydMt+/g3Elt6HWDKyB7e3HB8hVbZwEFa6BUw2y6iTYm8CMth2wAEN5fhTdTw4YAXiZYGVYDT0tiCS4+7186yG6a7K2iP7893gAS8lju43yjz/+dErxFNWQ91XixbTcPZqywipB3Q7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GaQni09e; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GaQni09e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h16+Di/xTyXAqwyuA2OMz4O1plZhg6808NaNEXh4LSHqE780yjjViPHlt+PTLdt+GWYH+C9G8qxJGOH1BJQWgIopCiCIYHA25ZjInI76YPw491k9nrNm23pIqES+RXwLFLcZ6zsN5o+1GyKbHkgCpU3BtjQpcgUbK3gPkJnmsKowYW70mOVDeKy44P2QfwVG+diZpijH1SCGXudliui5fx2IbTeVdaHu8axud+Y282fgT9nlSF0NuyCYZyeO1cFIQghBrKoCH0KFX1AcjcfQaCmJIt5xZkU0JtnkcoHJAAgw3iggjpjZZ/azHPfzxvDu3zssk1bvw43drGsp3lpsyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lex+nMykCvQFe60U7/Hkw8WHnwslilNgk7rlnGUHvW8=;
 b=h38DPeNSgKNCjwcad8AH3sqzf41+tqyJRjdmLub0WrWqPKadhQ3ajStkCICl9Q9nioLhBeQovPJ5O8byjtCYVu2laYvC6LjRU2RyUslxbFWb40RvktMU9Ff5rSQcIM+DzRdabYe3kU13lIQ2py8gXdh+lhJFrNx8PukwuncOfuce3Z2VZjFsiVxLGVR7KiaHVV4qn8E0klWppxfxpnJdPcmUbM0KH3DVxrc325GQb2Ftw//zAv/xRY5lRJ+LRqJhlAa1oAivTkGMFASHITRMBSbRSu0rtD0U4XjrotML0zE3HjSUzI9yiH9Y2QsO8RgFdsdLEuiGiTnN5pexeJd8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lex+nMykCvQFe60U7/Hkw8WHnwslilNgk7rlnGUHvW8=;
 b=GaQni09erXq7/F+Lr+rru0Ete9xUfKQyoyhpZXalIm4unNbv30iA4UIjeUgu8+hFpz1sWSEPBNQ2z+mLJUwYUrGUx5+v95zSjC2TCQqJRSjRPEWUqfTxlc/qMe1biatcF3MuGr07wW6IKUR599nMRDaVb88CYj12OIbsLU0LsFbZeVJhD8NzN3k23ZlNjmYm5DzfmHxNs9PcchS8Mw31Cv3BSQd83QT1YmD3ocO8GTpa4EeQl0Z/n/oLVcm+2FCD5k8Ev8dmkcImRXxWWocoex0WvzKO5znml66JplAtCAvv1PQQr82SyWXeqykhdDbauGlaKTyduyTItVkxFhWLWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB5981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 08/11] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Fri, 17 Apr 2026 23:01:51 +0200
Message-ID: <20260417210154.2290819-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ae4f16-34f5-4796-85e5-08de9cc49497
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	nFXAgZuHypXwrPBj5nC0WfJaTtuFQHq3tibGjKCWr3Rw8Gx5OiZSITmMFpWqGCYEemlQVrwGI67H9tJ5v+R3u3Ldg6prxRDD9mdIA+UlBckptN6xlP9UyPShre7Hvv8QrB9JWKt3Zl41pyLf7AfHGM2QFXwZRcq/RuOMbIvCxO32eUwfR9VX0//YeGfEGHkVT8JTl03u79bXIKl9U0jdNGDwDYxIONXwP0yuXv3NJ4+mudGKhEYWv3DwQLWiIqIIeSQSmPwG8qifJx9gVUP/ObZnEJVSOPYBVxXvQcvbT39A78hh4V7tFiS3bdcclQswcCk2+wVjwjcyYA/ccF2hnXD12Qe8yTexk8/ey87J2FtqLLFSG83X6t22e03d371jJMZSVIzHP6ptXQJBsEd5ddudtxJLhDUY8cldGYbHKR8Rbqk7slYYZJq/yAH2DYdV2qBj8w5jObCtCMYUctBz5k9elpdki0a/GMQGH0aie4zwGwwDfa57e3+03XxPqYIbsNqf+xJj7KqnwVVIoLl4UlEV0sPJwXogqbDytgZEurBrIqRL0DO3wHe1qYh4+rcNVJmfBpYr31R5Y4ogM6ZXboqE0JGOIDT59Bs9Pj3JspS1LBPmQnX2vZqvFA+pzg8Pt0BrKR4CO8OaCWFMKrt+QilOSa9LuUS3EhLmH5z+eT+FyCWpw5b1yfVgQF6ufiWXabkiJzDkTy7jvA06/nWR9TpjQRlGY8AhZ+TdjN1tVRw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cxvEbYMPRh6TWHJ6YgmcorH2vH9eRc9U3mOtdVzNCXgUXUFjRZ6P6/6+O3HU?=
 =?us-ascii?Q?IyhARfdK37St9+EXu4cAJvmDSKLqwzbcXqsIxe8aMNQuCkEMag8n+QhvlN1W?=
 =?us-ascii?Q?El047xFbbha7wonbDqCbZRhLmxM03d967KFjsTrWsMMoH4PR+VoUA2sUTw6S?=
 =?us-ascii?Q?7dxV5KgwVxhosuVGd+m13t64e02M4DIdBfN/WsyQBj9hVU3zt1nha6mWyz03?=
 =?us-ascii?Q?PFN4lnLJDJA4X1momrmH3CnkdE1DlSxTaFoE+FOUMXL3Obw6F1ftJpQLvQox?=
 =?us-ascii?Q?ue/4iQ5PyUCf2GXoZWdqHFExrZwgpj/dEKoxX87YsqD9m+FEZfvotp0uPwk3?=
 =?us-ascii?Q?M58tYAEyG5rqR03OAMOgvCZUZpiylKEec8Fe46ef1QCpC2IUVFHLkUdmDMbK?=
 =?us-ascii?Q?AqPe1Oe51YMF1sEEHWub4jJxLoyVkFiR6RgSt//Lxxl1oJvcqIXQgSe+nTS9?=
 =?us-ascii?Q?+yn1y89k7mfH/JMiDe+k94qIzUXaGgaW9CCRVtOfnWxf1hEPt8uVSP5itYcC?=
 =?us-ascii?Q?9ZOVmoSAhEKlIqG4SSpTAKVbl0UfFXg3XMUhiJkya7h4yqp4GOeMSrtrVnfn?=
 =?us-ascii?Q?tkwPNBLtqY+zg4whuoizcKaFJsD4IoJr69k88JwmwClmggK3ZEGCR0Xwjjef?=
 =?us-ascii?Q?m1Z+FR30VYQE0GdL7XMnB0p+d5kNXUqGOP/QWoHRKJNX6t42GgfqVZN2cS/2?=
 =?us-ascii?Q?1dJXoUKMH/MJ/PhpRUnW5VR4wLlknIw7lTfobsUP93gr41/svG64iJQeJssm?=
 =?us-ascii?Q?/1A3r4BpT4NdNnA4V7K7U3tBp7bac1sn+tpJMpcetR0Hlu+VzffqM5QmMwCl?=
 =?us-ascii?Q?+rKNMB2oeJJ2K9eVfKh8Mwhu7Q6IZqnPs8U9vMHQ/4ztmWAfivRiEUYQOGxi?=
 =?us-ascii?Q?3u5YfapGtfQGqJNGHyJVefvfXpgPd4DgfIruP+BtJhb/WN1ZVo3IFRVd3JSh?=
 =?us-ascii?Q?9uw3KHP/EH3gylgnru7jU13Nh32aDQ3ZK5OBnP3P6pS1G2m5jl42B4MHnswn?=
 =?us-ascii?Q?8ziF5wmAjJ4DZvqA7lizg2V+ASg5sIX2jAqWbghCSPwPI3Nz26i5/qk/eIL2?=
 =?us-ascii?Q?PXs27SaZPkupGZwx7rgtIW4bBphDlvG72k0V0EgdHpwoooXubWXYbnOuVJOh?=
 =?us-ascii?Q?/nOoZjCyfZNOFEIibsVMW/n2vArFf1Fl4hQS5IhG8Coi11ekPnw8Tup7PYCE?=
 =?us-ascii?Q?BdxY0Y6wEZHTANXkAgRCoPjI8nqtxp2CsAVqHYe4lxjD+qBP8vsbKftLzdbC?=
 =?us-ascii?Q?+S1XV4utIwD5UHoj4XoZn6SHmIEuJ1Qqfj+nGDAG0xirwb6Flix/v4oOUhT3?=
 =?us-ascii?Q?BXU1AHWkTwpH8V2j59IX/DDtWtLuFtosvG/OGulenK9/eHy0QgVDrFS6XvA+?=
 =?us-ascii?Q?QiKOjrUFr5vZnKCTkr1ew9RxGS+KPAfdMQJ9dux+1yg1PZKugZ1EDB1vg+eQ?=
 =?us-ascii?Q?VmlDP1k/EOYupSLnhv37ebtfdfBTFmMOANH0HhstLeEumr57A2SfObNd9eA9?=
 =?us-ascii?Q?8uSt1WB6wmHf+SP3AdusSjzoBm46TweQr7iQlPpqdAxVH0BRYaJm+6R119uc?=
 =?us-ascii?Q?HE9zVflIzWqJcT3pDN9ZUbt6N+np78tEZAQWpB+nLEl9YZvwTIkW//KXNlVA?=
 =?us-ascii?Q?fCVPEtRlVk/lAgC0qoXKAqOefAtj03NSBzbD5B+as1fRrsExEjrhTYIrY93W?=
 =?us-ascii?Q?F3Iu5z+/9+kacu4trKz0JrLHUdk5qeEb0Q1Zh0SdAh0Mjr8u2h1xwNbtscBx?=
 =?us-ascii?Q?q0XHyoSNXliNYQmKxo8lxE6do4YduW4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ae4f16-34f5-4796-85e5-08de9cc49497
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:05.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwB/S6i4SfRx0gq79o7nfT4w4lW7Nl0rV9irIFPwd/410qhBlOe+KWNY1DRRyMbbdMA1I5yjS7juYm7E8RZO5aDf8YncGbBkzD4Z4x/ISxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/clocksource/timer-riscv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index cfc4d83c42c03..fceebef28978a 100644
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

