Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E043E51EF
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547483; cv=fail; b=iYvN49UTCfVXAgzOpKrR/FDV+0I7UsELzfadLC2xaoAfLYz8WErcur2HFVp0d+W1qR0+zBv/wh6xLRwDUe7msyqOHv2keNAyN47zGmGfxGLyMVBiUQc+nOf8LLvAiKewchJ1KI67oseX3xrCenjoHOb88g3O2OhcYiubK00WOVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547483; c=relaxed/simple;
	bh=9PG8eHOtKkWnhrwcvJxDfTqwvB+d9OYw1cvT7ehJXWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jxn0Ve+bMP43WUaOThGJWLhhguglUlYs0Ngzqyk5dZ8BGuK9R3k9bFrzYMUuoAFYHRNIdOdz/tSUWvXXoyFK+EsuyOPmzDqjo3faZDRCOIYZqK1J95V+zm/leolpfBsJuQFYIZpuwdxHMsNlzJnk+S/FJKoUI77hjLtvbaybY8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SaoVU4fK; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SaoVU4fK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bsd2bQdjLDWbLcrWqFOxHk9Cg53m6I6/TP/gSQYT21fStXp492RQIyr475zBl1CZ4UxFirugEwx9QWrFtt557nIZH/GBuhJNri8lsmYAtHOSAiy80o+cx5OL5LH29BnlQ0T3BzlS+XpfiFTmR3RjZvsxq0EMrI0j203zFA2big7BDfovkq4FCp/8Inno5s+EexyFnSqim6ghpL9bsT4xdAOO+qbQbF99tEQYa51M4mqCd07rD/sNf/fL2863FLkWy/AWXcnuX8Yto/A6qRbss4cqCBLrtzHxQZadUqjgR2NwwOMxAutFWB3OBSrbx5ee80KiRfCw4hlQDskfrOB9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lex+nMykCvQFe60U7/Hkw8WHnwslilNgk7rlnGUHvW8=;
 b=RdOZ/Z9HqN/qmx/jCtXrHwHdksAP53bfrq1tyUMjobjx/WXdCncVXiBZyoqNSs7/GjKs4VBQ6epmarJ+AtdH53AgjbYRjyTwD0m0/IoIyWj1nA0PHD2N2KiW+dMl65VaK/8kW12KNLz1TfO+d/Bei2K4bOSG2rdwChN57KwYqVLuciG/hNzhsOejo49rpoQqbA7fyXHFvHLflNh4HcdIVUnnaFGct/8hOzHaknl5c043vKZHtfgEOtpdieKvOBwCp5OhZGlHYqxy+N3dJizG0PQIJd6gD4hh/2S/cgDLmOfTHfB7UH1v8PNjBcQcsPGBATGCC8ePbC7pCXBfcYz+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lex+nMykCvQFe60U7/Hkw8WHnwslilNgk7rlnGUHvW8=;
 b=SaoVU4fKo2YwxAZHkGHRymgQVKeR7inEHbKH93EB0HZO3mXs3dwqFnZ+JE7U5HT4G+YY43RLFZ/k7WVyNvXFTkaHCHi0bGBSCLtnfAg64ZH/FQtDCWLNGJsDH5eA0lch0Ldi8xbNfKx8LAaKb2UiPfP77jSZXIAKQ7V5N2l6JSbbsgnBYPk4BFbqOdqGtikqRBkqiqDCLFgqrJuMBPn3J/bz1g7DKCV0yGA/F0Pb6AwPS9W3nXWNNoWKHUzQyZvcY8mrfq3nsmJFQlItLSQ4EqSlAnnZXDgsUMLXVsvXJPckXJQPDpGw0F/cuCPsOgzXZLXFOzSEB+bSw2aa+y0Tcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by FRZPR10MB9890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:11:15 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:15 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 08/11] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Thu, 30 Apr 2026 13:10:58 +0200
Message-ID: <20260430111101.1539377-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|FRZPR10MB9890:EE_
X-MS-Office365-Filtering-Correlation-Id: d9118941-8b19-4970-2b29-08dea6a93142
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	AmqUD7qnlw9v8fv/sGPR9sGBa2PZfTy+/2I+S2LbaFnne4v+0G+d7BcLOZjPRsD+rjXzm/m8eopzqdqhpXZKmKUXXjnbgvLeVei1l+veS4AbuITeTH0kHidhVhlLBa41GU4CZ3ZTwjTgs6ToLO3Wi/+2Wjpx17gSNChtqqyTA+yaW7krFzNilTjQZKM8qn0PsiANDe6WfFouhDp5UBFO1kVxNgXLsICkE3vq9S+zGDnba8+GzKLF6uDUGO84aIqFObXoT6qAOJoIkVEtucP3W1B1ReMSnOTQxb8rL/YL1o8wjTgDQK7Lk48bMT1XK8s9L1JGs7onKQWXOyItyc9lbpUvCcedVCtBMG5VGYraLy6u/hLOsMPGego+VaBzZ9Jx12yliLXcRcRxozoTugh5q4zm/CaY1M8v6JOWNlDw+FYd6guuhgDf2DtuvE4iiVsbL0H49Dnnn72acHObGj+hxUr84rv3VWat7tvVpgwtkSH/no/pgUjR7dzEd4qyfom/zR7rzO+jgVfGjKRCU/lza2gTiGQwbeaJv5zJua4AvKW9izANRJBQ+N5Os19PsA8mQwHD3Mm0NV0xwDuo0hzXdYBrT76wwOciVVdnIVJ/9GUGC2dqr6sWV6yUnScJBs3QwaQNDpwijcsWd+L7TdzkSM5CQ1vRg5rouGUEr60J2lEb3MeCvWwrD9+WDvL4BqHqVdsHsXX7rHT1CBGwgnuvlVr7MB+uB9ufXk/07dFnlr8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLR/Mn50QboibOIKbOsPXKHFSv56eRGj/RiLf37eC/jnv6tO6ZjVTE7gIQ7R?=
 =?us-ascii?Q?Y2y5i4LBl5r6A/mRWN4pPJBNBqYUxyauyq4uUPMJ02jtmPQvX28mtlxBVgmi?=
 =?us-ascii?Q?ol42Iq7f/AXGzN9gjWU8rpXe+z9oHUTLyVe76dNOVR7aWVy+igavQQgs7qXs?=
 =?us-ascii?Q?TWlhbAyC2mfFmf76VgJx0JMlCxxeC/ACdmPtK1xDE89BIpCoKYbc1CMYzjpZ?=
 =?us-ascii?Q?eFppGKcBfZsrDsA2fGHxXLvdLafE6LdqidZz4mFkcjMPTlYvXriH/ZRe6u3J?=
 =?us-ascii?Q?4CH8E2m7sqyRoCj1avlYeXw1QILdv4PKSSgvf2CAfnNXNtFe8xOlOVhyS+LM?=
 =?us-ascii?Q?WybrXMn5q/o7jslHuTTb7XVRZBzhTOqhwUaaiEYlQEln4eBHMnEHQYst8DHD?=
 =?us-ascii?Q?IRy0lB/XAcjRw+iNszKYZlGhx9vLNmSAClkRR8AoJH2OHtJWyNA/jrVBnyW7?=
 =?us-ascii?Q?hdjVeW/yTD+9Offebg/tAk84BA2t6M18koAoctDpKHfPrsjcdebEGRIJ4NsH?=
 =?us-ascii?Q?85iuNdK6f5UjNB/lJ6vMPSxorwuugO7eo87q0gzDQC3ugtqGpb88MVVQuP7X?=
 =?us-ascii?Q?pTV66TWe90EA3SpotwHnBvCcKKGdHHaTJsZNxCltu7f/qa3XxRgJEQnEwGHL?=
 =?us-ascii?Q?TxyT8PKa+mUiHeYxmqCpp9w31ucA3HyZIcSnsRDXMCBwk1J9fa/piKS44zHW?=
 =?us-ascii?Q?Igt8gypTTNYGRoEfiNQdtjTzRG00K/7PgpdcDVE7Zp/52RxV6RZYi/HACuQg?=
 =?us-ascii?Q?YOCL6OlaT4W71CV+4w6pem39Z4ceIJPA0dBvOmklz2TnJmxarJVWBx4t9vV0?=
 =?us-ascii?Q?r6oOHPmKfkQQ4vuIzTXXIBeGdkpi8qHAaCIymcC5bDWsb25n5eIogk+hqaKq?=
 =?us-ascii?Q?rBDbfig209SFhnL97g+tDdRvgOiFhqAjLastuceLWJ6KZrU0cDvyJQp6JHpZ?=
 =?us-ascii?Q?CpF4HSRepCN+gpoBIkE1h4aMMi0ZYsDyWtLbYBvKOOIPpmlQvu2hMqtFuMnb?=
 =?us-ascii?Q?rLzB5y2T5ADshd8IsYwJjCnU8O6j2TU/7iQ3FiS0omwNTMlB7Ni0ao8gxCWC?=
 =?us-ascii?Q?lRkBIOEWyffYRymf9V+lO3dbTByCeTUXyJGkiZIRZmLEZCfX0eORTmILBdkC?=
 =?us-ascii?Q?e86QAnNUwVoakw+eYYuM9eOFr+SGeE+i0L0qkSqkoYsTCFuPFENZc7pXvYit?=
 =?us-ascii?Q?qfwTbTJL+hdoEe+Do5Zxg79lqvZb5If0WN/O3cp+7LQ2JJ1EQQ+tC4XkNVNZ?=
 =?us-ascii?Q?XCVXalD2Vq8D9C/kJWtZ+TqrdmJgoTavab5wcId6g256fbaveNTHjqQTIeGY?=
 =?us-ascii?Q?JmFOFiLo+3ClmjNFvPJukoRgN5gM0so4I5QVzNozg1S9k96rG2CY1vC77SF8?=
 =?us-ascii?Q?p84MCYqoOHcoxhOh24HIMr5Dyqs0yP+W+x5OT550tOl9KmQ17zuwSgu/FDSQ?=
 =?us-ascii?Q?mBz5fIUAgfL55psrBBIpXefdFdjt8X658wrN+XNqoOUKFqzm/GuBnBi2YyhP?=
 =?us-ascii?Q?VEFcb/BxFJyln5HB41I05SfsEkWRKOqIfH6v8NspvbUQ2KfkGUuf1H1kOXku?=
 =?us-ascii?Q?ihnzhlkRGsx6Yq1Pn9m8+Z9n2e9nPKledUCcTIYgK4cXZwYdo4J0GfrHOPts?=
 =?us-ascii?Q?a2N+8GN/aJ4DMW8QsSvf0Ucq33MXBrE58oYg5DVD7KTVKrb3CbhegeXoYZG9?=
 =?us-ascii?Q?GwkKPs2pybX1/t/6f0ux/aqRU3E1Z8HhB4/cPqaGBTJuen1+bn986vdot/0K?=
 =?us-ascii?Q?VIGTnaYUeK1L/Q/f/Spwk/QvT8Mv5Zg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9118941-8b19-4970-2b29-08dea6a93142
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:14.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54eB+x1MQWDBZwoXRNH0116C4YaSF89Z7zlsO6XFsvPNFXt7f/5TT5Ork9RPqfcBKzUdUmpBxtmRFImWxWu0gCWne7Cv5SWSOcnJtqg31oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9890

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

