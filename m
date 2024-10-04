Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879B1FAC27
	for <xenomai@lists.linux.dev>; Fri,  4 Oct 2024 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068808; cv=fail; b=PGLYVfhbtpGwPy5ZfX+R87ZNmiuFHTBYgxPozNtB+Myql0cPXoNbXwOfanAPMfCvh1TgXAXtDqVwrdIQv44SIqdXc7J5zXpnULhFQQVKY3v9TFIzjanPSHFSilJ094xjySnv0wgzOFgo7zA5LAXRp+3q9JpJxEjVLXTg3ysW6l4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068808; c=relaxed/simple;
	bh=XDoGnu4Rz2E9pPNz2zAYB/oa8ae/eNWRRhZW30MSeyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQpOrj6onoFWDHyuj91k0V14bEUCyDMRvPgeeWEdWZ4Ydzf2BXu9L++f/bBw/NfiO4/wiUAKp6KIyRwcZHlsVmiiULgvlunx5DONwbKkYeG4gFTRj8WiLEm34uMEZjBiFaAc3cOocuMKvWbYY5YJu1H3MLty7v7fbWhVxC+TPX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ILjPL9GY; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ILjPL9GY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSwegisgFubVRA7Fl7R9+IiLsDY9BgqkAHtJlN+RoY9Jm86hrYqWCY0AzwHllaDUoI+rE0UaqS3+QEzd3nZBcJ9/trg1RNRUKLw+WRHkwBeJWjY/4zpDPCHoV3cY2BxuWIbeZGp/8/IRExraY2aF+3TtZ8ojdANhdF2H/9Ge5jCqG8MubwflUNKBo0ETM3vnkjaW+eXYbDGP8xGt4yeEi5U0588DwkNeGm4hxEeyHavvcJWzQ78E0bB4Y5bJnG7XQMNGeXEJJMxzLRL2Ka6jVTjj6cxic8ObxViYrGE0jN5sNvRFeUQyQgyxiKQwfNUMU4Aq6B8WFIQNaEeY+rqLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVFQIrbh/w5yBMU2wf1sFljOotSFnUVQ5la5yeA/ctg=;
 b=E2zwZmGhvu/VE1zcyQ74128ytaMcUIgOILWR8oiULsZXMOBwBff94y3Mpqm2476pTrOe8TCybMx0Lhbw7+sxLrF01f0pV3QrDoRGVzgjsp3pW0WGF1sNNBxxz0iB3lOq/AQ3XaMwepJidyTw8PfxVa3BCtdWJBPlQnj6LHZ7dr2m2SY36vd9e0FvNOzS3PhyrHFewt3+udF+GneANH88YIQ4s7SF/geIkZQehBORd6KFyKipMGRwf7K6Rb6IsTrOwWbckbcOpZ4pzlDH+8NVk/WbtKU/O/jpIsBHgZ0T9qp/f2oDDdpYUFDqy7v0KH0i8wSSSYIsNaQjGQmEM2XtQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVFQIrbh/w5yBMU2wf1sFljOotSFnUVQ5la5yeA/ctg=;
 b=ILjPL9GYdmxcDrb2iZy9aIoqi3WZ076upVuVQsiwH+jmyGGnSGO9M4ePUw179r+yBPxtTQ6yAZC6lzFl6ZoaHP90fzMa4Sfs8Jh5wCkIwTksdaHupYG8ABCH6HpA/Lr+OuxD6gKL89JsVFZxX5xZeMp8ts8TiYsGv+G7VQB+Vb9G3d71Zj6MEKj8dfjY5zPQm0qKONJxh9yJCuwNeipc1MD6hDPGXVJrA1+JNr2mmN4/K7xQMw/fk2sV83DbIxBZdv2sCeIngMUvTlFmxGRu/rL6GqG+hkylV780h+0ZaZ40SG8LHj7jeWdP4uSm29Cft7cxikYfqR8OyHN07cio5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GVXPR10MB8343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Fri, 4 Oct
 2024 19:06:44 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8048.007; Fri, 4 Oct 2024
 19:06:44 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 2/3] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Fri,  4 Oct 2024 21:06:32 +0200
Message-ID: <20241004190633.1814057-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004190633.1814057-1-tobias.schaffner@siemens.com>
References: <20241004190633.1814057-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GVXPR10MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdadc75-a4ea-4eb7-10a9-08dce4a7b025
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1hXqLfeakkaUIJcuD3w5N6YPvEbU0KetJP1e6G8VFkfaklCoYFAur6voR553?=
 =?us-ascii?Q?e8ZVk1liKFCPUuj1C1IAaAWtZphU2QNetK5PqCD4rWWOB3Gdi+Gmb/F1SG9H?=
 =?us-ascii?Q?8iGio07nFG2XMN3Ak806gOJOTljBtkOThE6zQO5+bw7YVxFdS1/K4OuwNZfn?=
 =?us-ascii?Q?mKH24eIoNN2Xh42w/SCtK+vZMtZgv+HlH4t+LnFy7OGvchJ/tmto3fD0ENr4?=
 =?us-ascii?Q?e5oRQ6eztg9jO/mVUkpYQESAxBAZq9pyJ7c82BNhoS9FqADD8j3m0bQ5IuDi?=
 =?us-ascii?Q?bHYXOFzoSSnPL18kBy8ivOupeyP3q2KjimS/srja1WUzARmm8ItGZ6xTC0Ge?=
 =?us-ascii?Q?A+iYFmUjXU6rkLsUlbwaxdXBgmIPtN6/f+nHfTdcpsBJHYGEcPXE2UM+hcqK?=
 =?us-ascii?Q?cNXQypml5yZ5fhmYojkaKEEL+urt2oHfXE/r1qvcBc1b4xwK7UBHiLZOeBJK?=
 =?us-ascii?Q?7ld6XiAAOgGC3UiD3St4cPKtwHoQf9kq7QyMbFOnVSDb8XgQG31gp3v8l2Vv?=
 =?us-ascii?Q?nLqHQm1RXVl/lZn+BwzTwCgbcNu6GO37IOZxIXeiDNneRdwjDEdSeBv1i6c6?=
 =?us-ascii?Q?EWxdw12JOoaZB8jehB8GE1cqq5InxN9zsykfoV1zvnaKaA5m15nZy1QxaCue?=
 =?us-ascii?Q?bhEOuk6I/wRAkxsFWQAzGkGC/+KHbADIJmw8nuskyIjiUsM9av9M/5SSnsUd?=
 =?us-ascii?Q?0oUDCGn8mxWMcsZJE4kVxTUWA6tByJ0Opv/Kc61V/MzyV7AlMXlD7ZLA4tDJ?=
 =?us-ascii?Q?Fu9zkAgcevLl/IjJG09hIPujFLgk6KJgrJNgf+s+tf0thP0OOx8e3D16u1C+?=
 =?us-ascii?Q?Dns51Gc2m3Hb3v1ekDqt0shcSq1yIaNb7VMy1rTYkUmrvfkC0PC4/p9xeVKx?=
 =?us-ascii?Q?mRrXnGx+O4fLZUCYn4a5mcx+SOnM1m0mrNQOE1US2zicU6J80C2DVOtCT890?=
 =?us-ascii?Q?XzBpeBzY/nZT9cZcD+o3H/3rGgD50RZ1Zc7riKehL6uafxN3r75pNA5FAHRM?=
 =?us-ascii?Q?3sv8vTHGz08NeID7NXeJHv+vRzPeYQhAI4FwwQOv6pxI3z2Sz1UvgnL7Gaa5?=
 =?us-ascii?Q?ul0Y8w2fYFpWtfyrrbgAIvA5INNGDwNBIK+kkX1uTidPjkHkLfAiOBLoPpsy?=
 =?us-ascii?Q?cf7j5S1PJlRigXbZjfO2cq0+W3HBzVZU1YjXxKbEhkVOL7eYaWJs6HWQ7RDR?=
 =?us-ascii?Q?iXPz9KTI8/ehopYzDthJOsFAW8iKyBO576EkSRbuBZ8C9yz5USgbTQ8cgsM0?=
 =?us-ascii?Q?YK0WV0nEwXfOhsxaBZ2y1il5grZnb6SL9Sf+LVWODw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HLwgKylZ9aUNSRJbnLIgtxJtKS6BKdjUc59/KNmCqojp0df4BSTc1pxpwMya?=
 =?us-ascii?Q?g7yksXBUyQsaMN6vO6H61/xz+AKfIfyPRty6FTWl6qq6E1jHxW8sY8cGBXNl?=
 =?us-ascii?Q?DdReMkaGE8hI/s3DES/D7Czmp39y5wamYlcWf6WDvuiDWT1rF9AbwwGyXAIL?=
 =?us-ascii?Q?ev72DmkTdpEtyEqH4wMCU7KlyqoG6dAV7IU+6vGKX/SHq0wsQQXdBzlZO3yV?=
 =?us-ascii?Q?DQyPJA98nDmRf4sa96QHrpQdfiIN0Nblm0JPGzTwbmhcmXP2g8FXUrJVWJO+?=
 =?us-ascii?Q?o6iWe/E6DoBp07LEG4/AprLxnusmUXKd1fBVUOUvVRqunIYz4EO2h//tENqR?=
 =?us-ascii?Q?q6Rftkh/dW7Uq+Mlk60egYoZhHC4FGXDYUXytXD+QOkTEZ42KHNEFXaSZNQy?=
 =?us-ascii?Q?FNl2/w1CaYB8G5f1ls8NWc1tJCS5g2exBgHb+VlRR9Gn5+KKZHoc6qSCBWWS?=
 =?us-ascii?Q?t4aZOy4k6l7K0UWnnWACIAhyUcRFb+uIN144wIT3Gmpys1KcptZk3f3e5bFx?=
 =?us-ascii?Q?tLMy+Ad4XTSk5Q2jB7IBlbi80blfG6ppwoF5+imJlQDcXcq4U82ERHsE+vUO?=
 =?us-ascii?Q?wXq46mciYAMAVBqxuj7A1wsADylHhkhNr4L+ofpOGfi9Efsbr7uLBYyQILX3?=
 =?us-ascii?Q?SydihMEQDOTFrDb1mUmr7+icGHSG51L0kTJQni5WquTtImlGI0NBRrcKol7z?=
 =?us-ascii?Q?dxeWw4w0SVMJK9UAgHwCt1gB+hfEW3WeMG//a13fbd8co38t5oaqcHazVN7d?=
 =?us-ascii?Q?OilsuR5LEULULa/2Wg3zHtiBvkGLvuHpaR8SNekKC/9sBfcZveH4FbK7vcKB?=
 =?us-ascii?Q?BCqQzW8vJsFjpooWbkrNR9AhZoFmxnPd5pmgNypbyxOjL9sdzRxbOB0A8oHK?=
 =?us-ascii?Q?M7BKSA7U18QVcb06OJZ7JOCQyrD9Y4V6QQ8ejZItHZyV0NffDHFrxaYYJxmZ?=
 =?us-ascii?Q?KxOyE4T5+WOVfxkfjKaAD6pMovFUNeyohmOUpF6cLNHhhoUXGmOKDXjbW9o7?=
 =?us-ascii?Q?uGoUeFR9zcKG5jefkwUeFKmGD4GRH3GszjgIoWuIVyLMlAoPsC/5/2+rhO+l?=
 =?us-ascii?Q?nJ3GFUt0SIOtbc84vS29SCLsq5ugOvN8mdslncf7zBoARKKXkQIIoIWcTkNQ?=
 =?us-ascii?Q?07truVdSelCBfqnIEZniEB/mh9Q45l1OaJFVD6sB+Fl1qILNyTXl3fn+y6Hm?=
 =?us-ascii?Q?UgmqcqoOEA9+gLmvXqqVGh2Vct1VU9qOdgLwDrXNLciAdLqk1q4IgnayJpuH?=
 =?us-ascii?Q?3uSuQBTog9kEUP3xRr4GkKicWceDmKso2LZwmhF3UWVgmy2IJXOghXAn+iJ9?=
 =?us-ascii?Q?Q8iES1Vcs49GRWaCdF1/dyf3HWt0VbueI+Il9+DmWmuhM7eNlnTBX7T8QrLT?=
 =?us-ascii?Q?bpscdByFtM0ag3rTUL/oaR/0yq30PWqkzz559xFY9Z2k3cKsqfpDMiq/CmiF?=
 =?us-ascii?Q?wdgKFz+AtuVHRfdiMp0spcoL0RRavRhk42dAppPZtalbw7rFg3XDo3q4h99e?=
 =?us-ascii?Q?5Sp7xDHh5Ah66Ysbvp9QOHjmBBEM6Ai0lrxXwpX2jHMYQ40MG16UdIIJpaMR?=
 =?us-ascii?Q?UIK0tVtH5iZVrSzYFUJKIM69OfNHu5XGfk7XZM3DJ101xAIAVRXRG0zCEErU?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdadc75-a4ea-4eb7-10a9-08dce4a7b025
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:06:44.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8z75EMAiCm/QDfrEd7UAdPoZl2kJQXAwE5NGwwGTLoQEBVigkSXpE6Hp4+CLU7puFGG0NvpoDhUeWGMNz3biejT5iGh7mWd2Ttfd2vr9dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8343

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/clocksource/timer-riscv.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 48ce50c5f5e6..2f014b1c745f 100644
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
@@ -143,7 +144,7 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evdev = this_cpu_ptr(&riscv_clock_event);
 
 	riscv_clock_event_stop();
-	evdev->event_handler(evdev);
+	clockevents_handle_event(evdev);
 
 	return IRQ_HANDLED;
 }
@@ -175,9 +176,9 @@ static int __init riscv_timer_init_common(void)
 
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

