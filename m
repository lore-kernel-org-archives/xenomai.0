Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011068.outbound.protection.outlook.com [52.101.65.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A73C1FDE
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077416; cv=fail; b=FRhlz/XwdhPRG0puHv/3r8OWsB9vlxacHj0NfYCz02T6yOx/+xxmJCrszrpFi2zVRBxN9GY5IVCoYJKplCreqhaxTqPJNVYIEnU9ts7/4x0Vu6AR/kYXVG1ZTI2pYHz+xqWqIpNRbiobkyV4ZWWsq0WqcRxQ+Y+H2gKZVwvGlqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077416; c=relaxed/simple;
	bh=3DbJKDJZWA+4Erq+ADjP0k33rMlNY7HfaWJC1plifZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jvdq6Coodla+7RF1uORWCvM2GTtYrCZkXr0HTzy07z+a3zYEL/sBNCLeLX5JBeDkf4eLgXDhuV0xQrtO0ZINTwtegMgEFY1XPGLl3cVk+JSf89djR/KNnBOWpFwGYs+rkzthcXWqqJUoBKbK/e8JjWLrRk/0JHp4qABLUVYPJek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cYHb8DvO; arc=fail smtp.client-ip=52.101.65.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cYHb8DvO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqnYI0/Kxql52LjM4icg9Zc8UlOVzIRcOswCXZmqQACmp+FUif8UmjAWg7ZyPeJWpY6mi/EEBm6duHnxXxsvTmtin6kAWeZwcm1GRZHikQEM8+T9UB6sk3RcmjBS5F1pk+CHpIZWjW9eD9rrG3GtL8PoqBU2n/Ab/o6f3jIcuC5zknRwxeXqESZIaaODoAOcLyoLpxORnRRWmr4N9sDTPo6EIrMe7D/Pdz41wMClM0N9wfoE+z8PWKCdQnBpj+ugSYp3IPAMTnhZxcvZmKBA8RSznC4DLf35NKRrxiePxO3A7bKNuDABOROXNQffEw6SQusTYxQiMOdbq5GyFifGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cysx2ntDlkvdcIqpCo2Ms8FlXXQdcjHADQU7cditIHY=;
 b=i5E+Q1qhSht+V03Y36Y5t28h3eX71sWBxJFxl52Ht0mm89YDmTa0jgAQJ2HRATbuSL06MM/nuc+0rM0MiuNS2k0bxWLU+7LOnB6FpNYX4bFkbQ6t+qXk7FhM3wWjiPeW+BC7g9duNAD3oPdZzV7kOKuy8RhALdpAhAPYJJPrfbVTZduBosN6wHxvV4a2y2WSC58FcCNmxufdzueaNHGO9v+Mm277bZSzHc2a/ac/Hr9ES6bYMxL/8BkxZ4E9tY+bXM2az22suv1IFydOnW50YPgMhvz6r/er7+dJq2wFuOi81oes/Y9hTUxlvh23+kJqicI28GMFeC1cra8wx2S//Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cysx2ntDlkvdcIqpCo2Ms8FlXXQdcjHADQU7cditIHY=;
 b=cYHb8DvOCwN3lfydMAq49HBBqQ52RusKp4wi5qwLdYT0Tl8QBPILSuNdHKBXPo1VkXEm7B1Nw4f7rLIhxRieC3UF5Q+5nqg1q85mrM6T9DbuK6ycdlKoqd1G5ylkyYHouoR51pKqnFpRUEAd9YLOT8ceTHqckqcKkrqXMqMwDofH1zUqVsrYg2CHDj1N7DV0e2P4Zegkt1MA+BPl2rMx4IIa/Mb94g4YbQ4FPtsKrGzwT9lRWn+FaeM9n/vvqJp4LRom7pnjusexsczImVSwe7sUaui179FSWecvuEB28pg+wHt3PQbg5NXTl5gAQ03XJWkj2jYXVO6BQiSxaAARdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:17 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:17 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 09/12] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Thu, 22 Jan 2026 11:23:01 +0100
Message-ID: <20260122102304.421957-10-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122102304.421957-1-tobias.schaffner@siemens.com>
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS5PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d33b45-79bf-47c7-2c41-08de59a041db
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E+BFd6D7foR/JdyA4yruIXAgfTMhsIgN08LUTveVcnViev4RTB6vdDuiBq9+?=
 =?us-ascii?Q?fo6zTzRAIZEgfQOldNW19IkH2lw4MXco4yfO3maQUtxllzvVgTNHyncPC56G?=
 =?us-ascii?Q?hGqUwdmM/uRgYJlHLRWrz9SbOwPHB7WMfTbWt9//j/+CLz2vxn4jo+Jay5Gc?=
 =?us-ascii?Q?2rTXVnnmItcdugQ/ffDM+Z0RVRXwg6xvh+++zeF4wYf+2Of/ABSTxD8iBjS4?=
 =?us-ascii?Q?+ooPJ9Bq72TYxStq6OtWNNGBr0cU6wvjtnw3QpAKfQjrBF6Vdim39rZ50WOv?=
 =?us-ascii?Q?ZQYRLiC78mrZK2JBr70ORCiWSmt6+JN2+qmp4gMhY4Kffq/Bik0IfOHXWf3S?=
 =?us-ascii?Q?KnqV/kbMQY01HOGh7aedqUN1dj2Y6bM+4BSPKk3y43K5hu/NoAtvZ+fF3ax7?=
 =?us-ascii?Q?FZ/A7Z/nP0HFT0T0crx+UrMNuAjOGulDiFGNyrsPyYUu+gCm7ZzK33Ks6Xed?=
 =?us-ascii?Q?ox4bgrKYk2BFA22BzVFDfTKqAx+VLnl7HcSIuJgdmx7DO7jpLIPyuCeQVSbL?=
 =?us-ascii?Q?UCJiRfBrrrTRAhjxiC8VqgOKNy9oSEIrl2YK4MXkw+1cmAKNjcGEzgUK1aFj?=
 =?us-ascii?Q?GxVBPqh6zFxLo0qpfST93w9/hh/FRiTAIEq/paIJLxdKomNM+CEyLmzXTZxl?=
 =?us-ascii?Q?NntYVZuLs3eYOGWFSZORtR1GeghtoSARxazUjyjeU6yboAdDDlcHjsBvepde?=
 =?us-ascii?Q?sbVxB5uA16DVI1b0v1ilTAhYzs8ggRRx7fWouECC3s5bHQJgDHJivnvz7Rkt?=
 =?us-ascii?Q?aYL0P7PyTcZ2Afpo03GJAT/nYw/2dzSmP41GCRz85m4z4bHb1oAWma0TNAYw?=
 =?us-ascii?Q?0UUCHzgqzDSXtqp63YV3WIMkG3sh/lBXSrjVrzeANNd/8IYnCwTPpkq9Q64t?=
 =?us-ascii?Q?PyOnrQQQOsATqE26Ur29QdBr1fZXR+a3Yc10gW73ZDB4OZCC6ZR07ET7tyxa?=
 =?us-ascii?Q?fvTdTpo+mIURQpOZ1PtVYWt/ZJ1y+LC1u6eitTSoMhLQdEimpJs1Pohe7U+d?=
 =?us-ascii?Q?AKd9aNo5WN7e/ltR9jFrimAx9opElS1rMPgGRLvhaG3ePdV4GPINB1j0qHMD?=
 =?us-ascii?Q?rG/I8y3Bd5XKvp52xyyqsR6jezJP3SycmdhR4Jg3uABBgSN4/mUaXXhjEcSn?=
 =?us-ascii?Q?rji610XZHOfigFwt4U/gLGhQlJSQb4pXrgTnAMtG3BlZSaKHkfaZqPqe7ZMJ?=
 =?us-ascii?Q?3H6GDPIDLPMu9Iz9CDQlWznKppW7ABAWlvqB/mlQloxQpaYSegZwMdpD3Otz?=
 =?us-ascii?Q?6odGY+tWdP0sx+nm36Tr9ZDXTIiIWkG6ayk8bG2VizqnYETVBfWcImSDXmjS?=
 =?us-ascii?Q?pqyQBAHj9kBA/oIG5BqNCLkAn17lG0EUeyWkftMXOyTx+H4W7egXu33xKzan?=
 =?us-ascii?Q?BTujtHjgxcBIW9XiPBZ9oq0ox9pOSiOXRM9eLzSDyH33TfcWEB2u3dgIpMlE?=
 =?us-ascii?Q?e/p9TKFV2q9Vn0BjPhe6V3Ad8ryBPOFZbH+YtvwKUJF8F08VOQLBz1a7SDm4?=
 =?us-ascii?Q?keGY7JGmoMIBntVnWYg6POKsvrwyV3LBI/Y6qebG1VXWVCb8WbOOE8gMARqp?=
 =?us-ascii?Q?Rt/vBlb2VPL+HDawWGo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SPaqZeroR4GPdMkKnWwWRn9I0zGdq+Um9sJlm9UJOLngV18AijqYjl8CEfHU?=
 =?us-ascii?Q?1/3yn609prvs7VIu572CStY9yE+H1R6qbhC02VBFXb5t+imdG4PK9ddtKh2m?=
 =?us-ascii?Q?V5u3ySPJYaffGNOU5qHanMAbeIBpCgCJqwXYXBft0KYtNKxYuKGd6ZVn2F8V?=
 =?us-ascii?Q?PIEoFBIhci9hUrh+ALslIsRzMIQu/ASJU0uSbXPwYkiC2i52XuFFhL4wlDFK?=
 =?us-ascii?Q?EZWrEUUWAtYtun7LmZL1Jt39t+p4T3/kCSLtaTSwllV1JBd6cosodOEWs6Yg?=
 =?us-ascii?Q?Lkj7RoPtkw8dt6apAMmPYNyr/HpTTsr0CWf4LchL1etC3QlaKuXTbvAMohQN?=
 =?us-ascii?Q?Uq5enpLxsTHPaa46IhcT47jj+yqnvU489WH5xJjGi4V1T4To0qV0RPtPnJq5?=
 =?us-ascii?Q?19fqr13KpRabIp4niYWUCFXqnAqT0I/XDM/wHsz0o0uA2+bc1bKmtIK5mwRI?=
 =?us-ascii?Q?t3agXHJbKaQIvphvwqGu6RNjCGrnE0weAtTWXtZenv1WgpYeEf3UPfkxBMTN?=
 =?us-ascii?Q?z1+tE7WHq171d8lQ+aeC87QlG9wJaCEmj/l6OmAhp7tYgNrIIBxq7Gl62l8t?=
 =?us-ascii?Q?D8HTrwBXTqS+QlP5qH3wEK2imdKBefV7/+y2fRJ/QI4mPi5TU78qkZu9B4n9?=
 =?us-ascii?Q?dJTd2lfp5KCpzjOXJV5yu+eyHBiGpv0bXP+6KjIVXqvjZ97kiBAfG0LrZ6DM?=
 =?us-ascii?Q?xLYPhgPbF0InvpLwHuMTrczSGMIQ0dZw89leyntm+t60qhNCatiTb+u1lFMR?=
 =?us-ascii?Q?Dj+B5hUgTN+8suy4g+h/SZajlI7VgbcADIzdFsr0NognyQJFQlVEadBFdXck?=
 =?us-ascii?Q?Act/EJdUA+NpjsIqTqH9vTpGv7u3s0b8knLtw2Ia2Nfuu2XhhYF3R8nVPB3G?=
 =?us-ascii?Q?vSFy9u+sW7w2AuGmLQQeTRKrWDXbzy6bbe5cpwTTVFUW+OEF3/gQ56aH0fce?=
 =?us-ascii?Q?4GYlMIcbk5v9Wu2ZbAYlqT53HmgFJ5q6NiCWDX2SnrZj/pBkBL6bfYXzDsoU?=
 =?us-ascii?Q?e17fgdreJBe2QTqHSq2Slal+/nNl3v05amEhNflbxm9bi1/DkejqvxUfW+om?=
 =?us-ascii?Q?53MYmNeRsq+Hp2F0uQv0EroT6E0le/SPJ+wVlCFrWmezTz7sJf5NRHB5j0Mz?=
 =?us-ascii?Q?yemHyqQc8c7BXxCihtDdOm+yDIF/IyFXr0+XuOfADEMNGA9EAS7h8mre/8MJ?=
 =?us-ascii?Q?bSg5TWjMiQGqj3/9WL3TGx2wQnh0OqOxkv6a7vDWXAEQqZ1reY8har3tBfCv?=
 =?us-ascii?Q?FhivjN3klMsdRTDt6nwWC0sxtroluNQmKJZvPi7BFu4R47f4MeFY6rmqLrnC?=
 =?us-ascii?Q?ZGTLNgDUAQ5iN9DIVsf5RPjuUVLCVMYSMdBl5PQEFZMVRYMQxxzk4btOtAHd?=
 =?us-ascii?Q?tWFI4BYxC7JmYehsN7ArQrJxBArGRK+Iw0sLIkC37zr6DdncmH+XR7P9OacL?=
 =?us-ascii?Q?su1VE9x7Wclcxpr4OYTvetZTW4h/4DpJaj601+U2SJ8ishwzMKLmEjdWBHzR?=
 =?us-ascii?Q?qT1AzbFtjf3ub5Ze9Jnw66lDbkK+wGdp0UVTeqqtr+mjdZ9MrHW7n9R+o0cF?=
 =?us-ascii?Q?FOkurPSzEtOTG+SOq+CSIxlPhBiQXXoovqEF5zg99PP36i7m+1LWiIIA0wSB?=
 =?us-ascii?Q?mnwOJVzkkE5g38SbQMBhpdTbdvWuOG2uZZccJNqCxadVq1OTz3+pkhZ18D3u?=
 =?us-ascii?Q?iaNx6G35GF4459/qiqrxsjDoxEDLyMec+nWOL1I+0wuz6WkpEv/ncXF7VeQQ?=
 =?us-ascii?Q?CZDjVhb87dRYlwET+GDHTIRHkMR082s=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d33b45-79bf-47c7-2c41-08de59a041db
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:16.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O0SfSNEFtZli3hAyhHN6lmMcP4kHESMBCKBJl7wQjOK/aJRajI46yDIAZUj19WGT8dPzbUixNNUYhvmETlXMvJDNO2hY5BnQscQukSLUsW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/clocksource/timer-riscv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 4d7cf338824a..8d215ad82e77 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -70,7 +70,8 @@ static int riscv_clock_shutdown(struct clock_event_device *evt)
 static unsigned int riscv_clock_event_irq;
 static DEFINE_PER_CPU(struct clock_event_device, riscv_clock_event) = {
 	.name			= "riscv_timer_clockevent",
-	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.features		= CLOCK_EVT_FEAT_ONESHOT |
+				  CLOCK_EVT_FEAT_PIPELINE,
 	.rating			= 100,
 	.set_next_event		= riscv_clock_next_event,
 	.set_state_shutdown	= riscv_clock_shutdown,
@@ -149,7 +150,7 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
 
 	riscv_clock_event_stop();
-	evdev->event_handler(evdev);
+	clockevents_handle_event(evdev);
 
 	return IRQ_HANDLED;
 }
@@ -181,9 +182,9 @@ static int __init riscv_timer_init_common(void)
 
 	sched_clock_register(riscv_sched_clock, 64, riscv_timebase);
 
-	error = request_percpu_irq(riscv_clock_event_irq,
-				    riscv_timer_interrupt,
-				    "riscv-timer", &riscv_clock_event);
+	error = __request_percpu_irq(riscv_clock_event_irq,
+				     riscv_timer_interrupt, IRQF_TIMER,
+				     "riscv-timer", &riscv_clock_event);
 	if (error) {
 		pr_err("registering percpu irq failed [%d]\n", error);
 		return error;
-- 
2.43.0

