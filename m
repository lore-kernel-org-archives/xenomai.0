Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151F417362
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092482; cv=fail; b=J+StrgFX+UomM5ZPeoiNTQJu6sDwDg1GlHIXTd3anh8/rhBjx93ft/ZKD3Qaf8YmVk4djjDq4/YveHr6Xl14VUuxC/lmBV+4bAddML9FClwU1fKOVlOSscIJRBZB0RYM7gDXHxNvO9+ucMEPjbrq6T0BLriOEJhul+Tf5cxq3ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092482; c=relaxed/simple;
	bh=958qHao0IQW7I/cn2cJLIBEMxiStEfEuEX9HJNZi7BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SqycmduukwxQ1fR2gWJinK3prD1nGD7coZVGHFKjhgIAIb/WImIZyd0x6atdhpbtTP8YUklJIcEz4RLcviwOmxyFE4TTZnpQeGC8WAaVJj4b/hvOfMSrGn1xPG0++FXo3FJXoIlr0ZCCzteLUUzztCymj4bnK3dkiz6HIGHnnhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=LYGeKc6Q; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="LYGeKc6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMTNR7sQQ3ifS5uQeNkMi6aJg/ZYeuxASjDNTiB2X/77I4b7h8CDazgl0bwg05K7Ui9HmMBDNaMCzZ3Y7X1zUUAnfcrJ1CtYEor37W0aI9OymQbVteSjqs5vuTe1sdnkZRHI8VJO79UDmDzIWwpohFW3lVhw3Rmn1s9prmNLWn43dCqvfhZOOi+m1k2GISD/KMfbkbyZrT6QhVQGDh88VtjkgWE1e7Gf4sIyekxoKLR5kW6zicFPpiDVU4TJj5/gxU//ToIBnvuDdl2KbQri+AJhCBgOFNKWkIZ8s8rCOtTUPs4yzpIcS8y5nax0xCErh75a6Z2HLvu/WQk+Q2y84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yl4QrzvGbesdA0kO1SgXVgUMQYoLbPGRB7+FobAzwg=;
 b=JNYRkNLznv1u93Yb2jnAr5uOmcjG4qEkYGNvF28wEI68Xcs6tgN1avOFZhf0ioKpvCsk1DE2IdUBx7wkjxrnxE1MZgd4BHfGzO9wbb7TvJtKBUfgAdqFI6aDnAxgbEf+Q74VSkBBmVabVo/2EPMBo0obEcqgs6plNscTypEKNYc1sEzu7fcjQP+IPLhsSYDWDfIborCngcRax1BP0ag6uxVk2qmK9/FalZloaxFtGmPbzkY7MaRO6cQskL1CeBgB1QPfg0iNo8geTauUYEUo/HdQdflwmY9n7HGJ1K+eTdIad14qO5RIvUQA0IYB72DyzkH5KNrenpyeCwm73yp/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yl4QrzvGbesdA0kO1SgXVgUMQYoLbPGRB7+FobAzwg=;
 b=LYGeKc6QBwXi2uvpeouwFphLNGHG9MQ/lppYu1vZXF1le31pN2qt2nmqnI/W/gyF5e86nTj/Znp+nG2wrd5gIrl0twAbtuN4gWmM7W8jJyIu+21XZNYnrHydgjTVdLmGEJXcrs2D9xHdMPhKoX5xuNdQ3cTzmFADj9AM4/s0ga7syVcVHHBiPG/58gGRW5qD5C0rK1lHYCpDuNlufTSRyaqQgvmOyxCvxuEKY+1C9vhKtPVwlpRU3nbYEUMy+cnex2Q1dwdJYyrYuPkn4jjXNpJFy8l6vxEm9O6co3kwdA4gw2HVXvMw4uNeRnRRPjOU9YfJVwfO7w+C/LuurWic2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:52 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:52 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 08/11] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Fri,  3 Jul 2026 17:27:35 +0200
Message-ID: <20260703152738.129122-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152738.129122-1-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 0718a6a3-7a41-4cc5-58d8-08ded917a58b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fGLQuO8UethCUB0MrWVXXT1pUNi7EzusU31kgmfGdkkzRRo12Tfn6rCfcD/ILhQOo/w6uDzlmfpD8o5QefiIZfXFcv2rLv9tudZQSkNLwNwG6eeCDMceTJgw3jOOF3uaQL0LnuCbyDdRrqHSZoWsysfp+Q4brRxDjjd32xA3R3ZPXZYA9rvG74EpjDLX4vBaSsMzzuI6UfVY+DxhwmulJEZW2qt8Die+PEWvlTw299ojr76W5OBEl57UKtwdFoMOpxJsJSyMjwsHMzPLZbV/H41RdtpPArqSrwWyusrhexMiSKV0+dXKEyGrs58ptHLJqrcC9/EUTH5OsCa+xqYkrkcDX+ScO+ULRYS2tfmLRwoN1oeFriB+DFTGGDH4hrQ5l5ouMO4AVpw0uWXdE0kPZGEhLL0/sXXnPK10lghMq+gEIXYBwZGrmwhZKG5CGVjlj3DnBiI1U4vqlOypeP9dRKLPKxqvlHostT6Q7NjYaXb3SPbw/dlrq2Wl7cqOoj05Xqtl3dJoRbQcEdiuGswLutDiaqtrETSXYtI6X+jA0zDViUqgw4zYH9UGY4jQFD2gMl+BShiOwJFMsyLuvbymJ840SvoDKwJd20jlkuiMpDQx2CMO8KQnqEBvdJPPUpJfj/VnSQ1LperdPtwfUzdleGYqJ9J4w5ubF2osg/2PsTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ViWhQdTtfTFg4i0+eRjGtbEAEssI4PQJYswJHC9UU8G36o+yo3g1bR0Ct6N/?=
 =?us-ascii?Q?yOEPVOFcRyY84KFqetfhkhQ6Qp4OrxtxOtp23OPRTO2lEoikmfESJAoEAuuP?=
 =?us-ascii?Q?ape5M5H7B2qRPnZkCCemDNvQeaqvGnkfAX8boXkQyiwU3fDTuxamCuLHGBLB?=
 =?us-ascii?Q?O8Rj/sS2cFUUFT7as22xxDzx7F23HdDgOkqD7Uo9heVAgCUnXpQ8W92eJjKR?=
 =?us-ascii?Q?SG3C73gbUNjoxzeVcOnT6iIA1OebZnZWNDVSNNKb/qaDpiyWjdV0YTOdP64E?=
 =?us-ascii?Q?XmwYo88Ox+f9ObmxfE3Kr1F+eMxWz0OGq6NCkhsDGFr9ZIg9aXWZhpEnbdkv?=
 =?us-ascii?Q?ZbIffxQFrx9KIy4XHHm+u+dFINXnNx3tQ+K1yD7V0cdLFGFpnJxsLniJc1uK?=
 =?us-ascii?Q?dVvhmKa4HF450VOCmGdsg3vZ0QlhRrflfjvR3/kUdE40EQuP8qsNKCq9N7nQ?=
 =?us-ascii?Q?GV8cN/aiVd+H2Pjgvp0U0y8nsufwEtwG56BTIn8wCnHJinGmPIi3pMKpTba8?=
 =?us-ascii?Q?5+MRSKiycg74ZT8cPUzv6/yIvE8jSuWxnztEmQoD5MBmY6kx4LW6m6BcbnST?=
 =?us-ascii?Q?a1AjtNpBHxfsYiGvNx/+qlt1jeB2ssBLQITj64GLFWzaLqGACkv52BqSJ0+/?=
 =?us-ascii?Q?QdCMujYk5JcuoBpF4UlOxvWqF9OQmAsyV+x5bblaaH81ENCLNjr3Ft0dZMg/?=
 =?us-ascii?Q?Cb2ODiQXIs27CR2Pc2k1pVt8ObvF4SuljPG1THD2tTt1ZM6Riiu++2Pvyoza?=
 =?us-ascii?Q?Y8GP3iNTJBRqoxVeHsT6HmS2bUC4blQALvmuN5tuaWZpoqw3KhCN1u1jf9TT?=
 =?us-ascii?Q?nsWLA12wmiz2R0aAplZQtEZbn+urp4KhEBoLpdGWc4aBHgMbb9qBfVWnQP2A?=
 =?us-ascii?Q?n7gWREPYpAhN3I7e3pHnb7jHWojZ1WNndsiPTN9GdLpf//txG+17zYlZRze1?=
 =?us-ascii?Q?BCBVXm0BIrdIH2cg//skcVTxm0DW5fNW4XvPb6ocdCfN6pYpP9dhS4gQcqj9?=
 =?us-ascii?Q?LjftiViksjTtHdk4ot4NqWCJM1WyLJRuP3wfkfFxZij/EqFePYrJ+tnvr0Zg?=
 =?us-ascii?Q?DpN83LxPj94X+6iWEm78Hyk9MxFLR7UuwR4yasfz0ZJSSOJAo3LyRFhlZjUD?=
 =?us-ascii?Q?Q0dfR0WX2VEO2T4XXrPoaqVXPX1zQHDOocADiOTnDwnS91AEB5Rw9sqEoJbJ?=
 =?us-ascii?Q?HYF3mEqHaRg9CEO6GjkEYTERhqBUI/kyYue+11Q4+JO/iM/XNR/gcDHPYrtZ?=
 =?us-ascii?Q?PeFvTXO6PD5lE7b5GEJHruvvyBVy1+6+jETALFRsDD4Hnca/BVlEhTc7jBUY?=
 =?us-ascii?Q?n5YxGMD/RPnz/4TV3zFselELeqHle6iqcJBI1h1AJFqLQV8vupmN0CZG2jgy?=
 =?us-ascii?Q?5fq7VUUe1X7WLJCZOg2VAvExsqekeGxPcn8ZLhgQEGnaQH6VjE6UzRX3uh/g?=
 =?us-ascii?Q?ooQaP3dm+LBDFpNsUY2Z7+SdvSYYI1+VRFQiQn67T7uTlRpXETzvvphNFYcJ?=
 =?us-ascii?Q?CWC1gJO2tpWhbn+nXWJMQsdTL+m84drhXv2au3U1mVwdMKuziy/mQThi80xs?=
 =?us-ascii?Q?ZI5QTUblz7I8TKplwmLTqrE9SO/WKNHB6WnKrQ4RT31hOuneFbzDQzaf8a2n?=
 =?us-ascii?Q?L0s1DuU9lZD/MbewmwrjFa09RliiCqAX8LGB1md/3XxZ+DQ4AFb7pZXnwqKr?=
 =?us-ascii?Q?kOxvfq7g07/5w7V5ESh292T3kq3+LAn6I5HzESQdxMeBPW4NLDJkmlJjcV9I?=
 =?us-ascii?Q?uFHBkNj9OlXK54mXNbm32ERL3ZI9fR9hAK2Y6BdbZvcEbZfctQDuAzKvrctn?=
X-MS-Exchange-AntiSpam-MessageData-1: 2/0JIKHj1xkiCUV80+m+6WCawPI3R9TlZi8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0718a6a3-7a41-4cc5-58d8-08ded917a58b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:51.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Da79v1rH1ZxlbQZRxOriWEjfkP1HoAwTbkNfjzd5ahqTA9ZHsDLHMxF6bTNyoo9JYOK2LshYohV0lbzBP7j9qucMM+RSJEtSGsFO6r0a5f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

