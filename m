Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233C443785F
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362590; cv=fail; b=EQemVrO1Qpbayt3uqogniQj4W20qsbnVwAMrjwmcvudCz9saIbJoCts5/ZeMY/FKuDGx3mprUYUizzd6A0/IRS98dR+BuGLy6FfPi7C0xzX9Ra5knNbgXAqSnWSPACV2aLvwx1hTxa6+GrKoBOLDRQ0OtF888ntZ9BTNBsx+k1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362590; c=relaxed/simple;
	bh=958qHao0IQW7I/cn2cJLIBEMxiStEfEuEX9HJNZi7BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQJMMx3awY6OTJvHFkDNNf9a2G+YZVQdN0wyI58WKtOtughV1Xhu983u4sOJ6dJNqK8g0MmbbYbJq2or56Mm8KllxMkzl+ne4smXhHfFXpgu5+Y3D8x+n25PVFURQM4DEaxnrMElketNjfxF+/4VfTAP6XNYrucJK9VhfEw1OmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=v5EQzdwQ; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="v5EQzdwQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7F58aQzvfslbfDysUAHQ4ujXqheb7PBXi1dTxbhIWugjGIpRSymDsvMQPhLgYDll/UvuvTrCAt7aw4GyXF0UWKuP7DHUBI037xp6tZtE8bBIfX/SdYWYIDbNmvbo8tdsX4hPzp1Y6KNHQ+bvMTLwYjL4ZX09IMaphJV4Fssumqao1uFfwHflDa1tqGvjKWSSqHdI48krNIPS0K8SvkcFdcHkYHK+hELqmjj2MqO7Ck3UqGNccknxD1Gbo+ey7sQVu9oVdgSzokO19iDnCFxuw9W+X7HWlIgo8X5/qkpApLit9B0CLjcOFXKDon3KUGzRBM4GVg15tHV6X1BcUIFEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yl4QrzvGbesdA0kO1SgXVgUMQYoLbPGRB7+FobAzwg=;
 b=M43aowvNfna/Ucq3gs+TkmHO6FQ/qGmMBWv//G65+3J20nzUVWyuNQHwty6JX+D126pGDLFE6D3sITXeLigzU/nlz52Xw6RGx7mksppn6JLT7rElf16oilFacrUPNCE5W657oqNXm0KQ0vyp3d4Vlui6LpS5wzdlJm9pK+RzazBWOapTKCLn+wCAHZfGiz1HHqOaj79DJlJKPDpuOX0puNO48ItI4tNI7hjWTIblWR85P9yi5trL+Y9XrggMFcLtmU5MPkakmjpN0cUOJ1lJd+6T83kx8cdOC4PQynfNwXoISHD1LHFNxHowzzINDuufyVRTimL7JPR0XhdJCDx5Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yl4QrzvGbesdA0kO1SgXVgUMQYoLbPGRB7+FobAzwg=;
 b=v5EQzdwQkNHgF+hlQN98tfU6hy4Hgkj8oD7oyFdJ1qyRuKA4o918XIBe1/tbSwGlVvIYV5woU4LkQ7ra6xbhF2fLYokNmYPawjR0ef3+VD19OXDLT8bXc1cTbcISp9rOhZH47eGW/UPeW0pBEb2IN7/doOlMEc15JLzyFiSeubzo2Ydk1PmyeQ4c2ntwbuxT9L9tMFNzJ/mNyEFcZR1nGaIb8uoZklyvhORMISwObmv1bTSRGbGXqXY4z6xePWV3+75XCHvwRmm67kHjMftmhk/fdfQ4Vm0yZ5pr7s8RFrEq8PDmvkl9GnhWfqs4Y9qHuee9BuOPj70LJChxN1MjDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:39 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:39 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 08/11] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Mon,  6 Jul 2026 20:29:24 +0200
Message-ID: <20260706182927.281078-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182927.281078-1-tobias.schaffner@siemens.com>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAVPR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: d128744c-449a-42a5-6097-08dedb8c8a52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6uCXyKeX0BOKNVA1baegK0ir7DHt0DIJ3rYdCWMU29lsxQ827ulfI9YIj+whZZglSmScr0BNKf2Jza67gx+i2VFEmjLM7lJCZ8EYLsqvo0S2tkC+Wo3EQVBz0ZICspZEoDlmyPI1sLIu7yBDtMYeiXkrZ1cztfmoXPXfOqsoCCmiFqT264+am/bi/95gKLGm5x0zKtvYCsFVqr2xaD66F01MyElMlU1ezjDmeKEHpi6lePInIfpWyr+IHn3AKvpngyoxeB0tB1IlscK2907ZK2MzzYhP8ngiI0NVod5gUnqx13BWaJd1bMwauIOST86hDOIVMgGSOGvdP7/nkYIQm0z1+O/g2UaeH47UmGBOSrIys2BkS4pTdKGIjKMuhF7ohgJDlv2Ly4VcpMU7uTFPN9Ct0TNIP0OFuwOxVr5D/11kEMAqWGpoLxaNJUV3JclW9r5NbIcscY5D/2Pn7aStRim7oVWCoIe90asPSiYWrc50y/KQQiV2v3EpwKSJVAQ/FauSvTB3RPqnYrzhPLOVGVwS2LUzIZux+T3e8ijJ1D4xhacDkfaosHRRSAssQ3auCi3joF8amya454UcytuUqyazKaWttFyO2IPHCYzLVe2nJYf47HzsoZ4r9HycbTby/CwvQxqWpw6GXJAxp1CHJxx7mXaLnE1K/xywIi9I3T8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OErRsKZzl7IeKdt6TsVF2pQD2Wlp9+vwrEKWFDfnW48VPXN0d+kUVIkLMcnL?=
 =?us-ascii?Q?qXq+WsQZNDbMj2aZ0MDNtNxjnjBdw3lUZdONmiWyZoHx8B3piAejpRc2dBI0?=
 =?us-ascii?Q?1ri19U2V9ZZ4NdxG/O7FkCXHVhbliSr+RDWSO0op2AVk36aodpSRuJfMgCeE?=
 =?us-ascii?Q?9GdHH538N+N+RYUdEkv1Qj1qF8S77IhLXUvfMWX6DlKLqCf2TYQS86ODS2/e?=
 =?us-ascii?Q?2VWhsnrqe+8DNq0wchIO/F/6K0qfk4Y0DCUwz0/BHHU8837STCAE1GhoQZ+N?=
 =?us-ascii?Q?ul2f6g35RiXI4qv5yVIec5TgElxl4/SR2ErbUuA4RTcptFpWsOQJYLBJnx3L?=
 =?us-ascii?Q?PdDRp2uuR+na9pxedh1oQoFxsdjJnoRrOh59bPrHsWZSZKLU1ip+njgvk9Q5?=
 =?us-ascii?Q?Jpx5zXXqcNQS+FAi/VoIPCAeGDBaAeoQ4oQz7vobXKSCArxDftMGn5PkCB45?=
 =?us-ascii?Q?lYWf6gY3ONkjYnr0c1farkr1y28Px1WZBn7aJCcYdqAPMLkDFvWeUPoyX2g3?=
 =?us-ascii?Q?C2GmA2IiD1MJkJjFGKTVkGsPGQcieyc2AWrGwEd0r0YYPEo/ZjdI+OI+mMqY?=
 =?us-ascii?Q?bhb7zWv58rpeY1io+x52GrAgvb+CHA/FISVlmbQC91XV9H//Sfzq50K/WGcZ?=
 =?us-ascii?Q?8QRw9e4Hz5eyPAw5cN0HrD5FgTyqI4yFq2oMBqtVrA9NU3rKo7M1m41t0uqM?=
 =?us-ascii?Q?kL/VoQqPxB3xpM3fsNp7oIPYA15J9wZ3SYaSYFiItHv9wfhbtkaJo6P9Rtaf?=
 =?us-ascii?Q?supStUqGkUdcumlPhUVkSQ0AMhcPhOAykQgzWyCUrjZfWrriYQe3WND1x8Uc?=
 =?us-ascii?Q?4u/h1/aoVQGlhkIsa/tyh75AZ+MqRQIT99zXnoJjCK3lXK2pqwpJQ6qCP3wm?=
 =?us-ascii?Q?gofySm6AD6Iig0oKl2ve9D4BWEVegy2VvXh8SjybwrglGuvEO0I3OUmL+ZJB?=
 =?us-ascii?Q?noeLw1rsM7ox2o+SpUFFgX5H6V9dQbnL3u0SqK830egb7e/c9pknObYBwS0q?=
 =?us-ascii?Q?ertF40Y194vaiR7Ywwl0qdhpxAqnWkA4xp6+Z3KgjbfjRWYP+7sLaYY2E5BY?=
 =?us-ascii?Q?JH+CHhJHdG32jnUDf0eijVxb57ShTMJ27UxHOgb1jTnLeBkXcmkiHv8Kupif?=
 =?us-ascii?Q?9VyGs/T7PgTgt0NV9aATPfs5FPlGaNOY+2NR1NGbYaQJ8OtsmXeEliUZ5lQA?=
 =?us-ascii?Q?r1FrxZkF2Y1N6u2C7Ow+6qlFmsa92gtQSAMJjaUg3iFtcrpx5/RY6rVqxiXP?=
 =?us-ascii?Q?2x5Pq6bJVIvHXqiI8pl4xh+5g+5JpBABB3J5e+gt9PlqPYxR8JweU2X4Z022?=
 =?us-ascii?Q?GAED/Dl3nzTCL5TxNtXs2WySmH+ajkSZv0lQ5E6EI0bV65Q/CvGRU3jcLt0e?=
 =?us-ascii?Q?7CnG5ong9ms89x/IVVqXA4e0wQxSTJdqCCwm9PR8lapiXuQ+OWu2Zb8tOHU6?=
 =?us-ascii?Q?YxYmeZ8mL/0+b79tVnUuJqkGfQT9irbDZ2dff7/w8KJRIaJJGeOKseHmQ11i?=
 =?us-ascii?Q?TX7l+yzwL9xdc7cp+vrp0WLpeNrwgRT1BtMlTRGLxMkT7fTZsBXWufPTy0BW?=
 =?us-ascii?Q?v9YYwCoKxOtxIsyAK9j9yg9uCFiN5QP2pMetDcMYf17wgQfJAe4sFi9anqvL?=
 =?us-ascii?Q?pUu0SzSD4ALonpgAVTDh66jMNTbcTCDWe+9vZU4JFaPe6kLiypS7MXACwXSn?=
 =?us-ascii?Q?kt/SVGXXSE4qgeOf+NOcNGTNxLvXELOTZTQie1ucS34Vu8xdkXTINnkADXVr?=
 =?us-ascii?Q?cbhgjt9LwIEP1w0c4ePZrNZ/onZIeiKjdbiqbnIfFm8IvxxNlnwYpYc5IT/G?=
X-MS-Exchange-AntiSpam-MessageData-1: 9XMNXVaonVZQWWtcLJ8Vhlmbrfm3SbU0ymc=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d128744c-449a-42a5-6097-08dedb8c8a52
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:39.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmsmSNGSD5JKm/U71EMtTXjuTb3/NZKbZnGG5fFhtvhFvwW5dBB6QrKIRm2I5+lJmXVFiSqcTkCt+YYKHsl8FwCSzGGA7ucruH3pNQjPHAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

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

