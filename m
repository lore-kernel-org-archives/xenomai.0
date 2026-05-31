Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A73233E8
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206806; cv=fail; b=WutZM5FJDHnJt+CJ9KK7lsMHLr+S3KGv6US1SR97QS0Dj/lB3nJivDDg5dJVjG5W6f2l4cp5LUyKUjQc+pRcGyM7iOS61qK/G0F86Y9/2OePBAJKBGfCpDEAVNkX3XtdbnEwO5ZYM5+vDN8IdHE9rPdbj7XarVS396w+9SgGaB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206806; c=relaxed/simple;
	bh=CqdJ1/tDR/GAgIBV9Rts001tLIVxnwUXj66Un2DH2lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HanGeQLGaPhqPGBwvcRBNwqQYF41X3yGStvFqdNU3hzPN5cOFV525sNsccn5UulDPFDUSr3ygsi4ibC3Cm80RikmpxUwRkix6Dc41mA+bD5xn+vn3Twf6s1jhvHERgZH+bixi/7gA+6AYLZaRh/tDgBv3iMbPYEE6RvUvvDF7iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fy4JQuXW; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fy4JQuXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kkxQX1VPB1kMMfYtIet3S6t8rvDaBm5T40oxNMxN8bMVzk0gEipvfRrrWOD8A8/26/vAXT5sYVCJoEml3LUkPQMalxQtNt5zl0SlDKKJQiDWPJUeM2aVwLMyTv2RFuYJm2Th5yNtdgf6TmW/0kPnp6WwifKloLr7a+8ZU4M3cTPMZDjo5mRH7JWjvrlOlcUiZHCB8Xy17aaAd/SECJZt8pD2mdPFqC3bbsp6lDsgvRQ/lGsIWpzLYhQCzyTP+FRR070eueUHrusSP4ZnQwMsyGXL+MrKZnv21qZo6/Y+UggopVAjnvNIDQHlRTqZU6bVVcOyMXN8FAHk4044NInaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m+YrcMzTwWRhg3ijJKx7cOAQaBHZw0Anc6+w9QE9dQ=;
 b=QcpAfUQqclv9t3j+fjFccRUExuG2ulSfGhN3KenOjlDGuPSVjZvjtJbqxnhbIoWKtAoWOsZ3NbY3qLhX+IV2hognLIDSvEa2sB57n+jKln1+0MlRzz6KVMHl1Jn6RbX+OsQV/jzcZdiKQCFPSotaQxWTQMA7bwHoM9mK8TDg7cCM1e6QeqlD35nab6YoC5/DoRRjB4YuidUHyMRZe8Z5VoeLa4rtCXHeG8Bl06VibMDUjAHUKYBdprAhP7bkjuZVgeDgTjtNn4vVRez5hKICO1XGlyNvuC88/MZmYwy39jmdobNyFaDFJJ30b0rZjgYe9ZD56Ngp6Hg0/Ey+shTtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m+YrcMzTwWRhg3ijJKx7cOAQaBHZw0Anc6+w9QE9dQ=;
 b=fy4JQuXWYT9d1eWNZtrzZ7FnSt2azaobWSZbTEyxCqj+gC6GCPTJxBdeJi293yM6w2AqV7sP/iJyRpywhcqJjVU7hQH36vWcfrGUDd95HsjDtOS/UpBGdPziXr5qV7gVp9h2exZU1qmomkuZ7ePZpacrqDD6lgKc7lg4rl3i/69IaZadDkX70KgcKAneRivtnlnS/Q3vEOe8nN2IAUHR+GkwAN/2sIizJhExRE0Jc6C2uFmaBjxSHkHX7cDlyx44Hq83HeGSrk5t0I0KF6WD+yx1nQTK8weYsbeRBigYgSBV4n61PTcph/MF5Zvi8iaO3HAr/zVqAxp0XGmFZ0TuQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:16 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:15 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v8 08/11] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Sun, 31 May 2026 07:53:01 +0200
Message-ID: <20260531055304.2890455-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: c77565af-d0e0-4c64-31af-08debed8e8a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	dmZZxyaJqOhUxeJsRhXFInBWy6RWbkCz4iI9XhqVkNJoyenAFUQyhEvTsA+YW+M4y4+REF7n7YbD7ar/B+7+k2UEiXZQV6ix3O2/NShIkx+bRCps15aIXr+avaTYD+PP6DlAK+7n+JhjAsHwwXocNXEeAU3hFvlzneP53qESqAX1+fUT5jobqg9vborBJMSh3E3FYAsfSKlBrgW4XC+HDNhzZd0+44f6RkTs282HpI60UIA9kktLjCM6t7kwbBw1f8v4jyX+PFJs6riESgdATgduMsrJGSvw+4vu29ggcheMoYQNZMLX4AfeMToedy8DzqOJ4BddKoUijGNmskJ+1RkTKcSxgRpDLPgGt/5stn8qTU/+OPDIIVdTb9zTslG67DYtf+lOBvKkAG86fWxHdXHT2kKZ6HsZdQL6ZZbO5B9QpwTGwbwfzqdvWJWL1z4BIoeSqNn55EzBPOeeGdlfAFuWPSY92dLxLZi1Ng1Hj0rL5gtKmB9iA7AX99KC7avTuL5YjB4xqaBHQcLnskf6Ww6sXkbpjzq0RI/Tf2/vQ+3sbjDDDFUGyCHce6D1FDu++NL7sHqwU+mvTY3LQIPddFA/sQNfBbadWdFfxIOI9AzWa9tL6rWaAgb59MgNXudzfPH73x6BeKt1xb6DuRnkZiV8dquY1k49fuYw9LwaAb0U98ZumHA4WBc4JpR86IsA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2SJbbw6izjeF4pigor/9xWXgpd5627Dx0uQmAAS9NM7rf3+xtqyUgkP78Tsd?=
 =?us-ascii?Q?KgibqQFPC0ZkWBqjjaQEGshXuc/CCD34YgMTZ0OqRcpizHz5nbDYi7WGIdA8?=
 =?us-ascii?Q?ln3cyoSbVrBJ/YfpGvJYvItd2HR1JepEOSwLku+EFH8RYaXwNC4da1NHgnZj?=
 =?us-ascii?Q?EziY4S5kNcbjQIMdfEI+OfOQ6cVd5YeV7M0UhOMabO//y9oUdkNuCxvNJ7pg?=
 =?us-ascii?Q?rq7rwKn0bBr5TM8Q2UYYJVxLK57L09S1yTCHjThhB8BlyBpOvyYwaw5nnMmR?=
 =?us-ascii?Q?+xFLdxgyaNRaWRHiZHcvBlkvITBleF8v4OfWlcvgf4d26SMLHkLwr2QxmxNJ?=
 =?us-ascii?Q?RFEKG1KqEtkZnaUWfJKJH7SpMK8N5bqxOuvpDhqEm0GD37DUs9hqaOzRG1eO?=
 =?us-ascii?Q?iN8sgPRjIRUpDtqatLNo9yOU0xaw0wynt1+l4DCn146+3QnmsWPNyIPAyDMk?=
 =?us-ascii?Q?sSLplQCYYlrNalGGdSxnPNuV+9UjbU2t08adxP+Qw6h12smbHSKljzm/OlKO?=
 =?us-ascii?Q?oy9OfbHRz6TZ02m1mlT3oklgGYGcG+lst8TwI/CRS94B3Ggtm4BTfB033SLC?=
 =?us-ascii?Q?MZh9bflmvQ8wqYupsRjgah5kF7ij18Wqyx1BtdWhbeePh35ijkT+D98I0nKa?=
 =?us-ascii?Q?uEqYrFRZyROGzGeOZK8/B6iCMT8LAutTG76ZEO6GilpO9INLcWBS/G8z/g0b?=
 =?us-ascii?Q?ONNL7NfbwRKldhQOVDIFxZcl2Nxe3B4uYI9z45riERyAk8pIq5WDo6L3FrP6?=
 =?us-ascii?Q?c6I4rgQ4RLrA3+AEshP+I+zau8UbYzLbmKjjrF/Mu3KNYfZymmlKYzA54WfP?=
 =?us-ascii?Q?IW1JO7NpuM68bFth8+Y+ttn/SrzJb1djyWaJdsTdvwVCIigNZF71Dki3l90o?=
 =?us-ascii?Q?0HzEVLFnlRBWEIEiT1aRd2DOI7XG/52EeFscnkZnc7N8IlMZ3rLMALXxDBKU?=
 =?us-ascii?Q?Y7YXo7ur0vCLUZT5jDXami5RxKe1cZxVShrOXE4GRL8jPjMysuRS7G9uWuiS?=
 =?us-ascii?Q?wVaA9KpoD0p4NXdPPBL2Yp6XspXwC1Cz+kDX4fJnhTuRkj87MqZqIXAYx+Fs?=
 =?us-ascii?Q?tDA6mBB0oMRqDjMq+fmD/KbUwe+ZqEe3N6LrC3tNBt7uKA824YQ2+XsYgNQv?=
 =?us-ascii?Q?86s1u0vFMy2Lwy2gvNv5fly6yzHmBYYHRqmwCpi3/D6HzogBHblToxOzmKbF?=
 =?us-ascii?Q?vbmxpNobBdY54JSz03+PexGUPr378xj99rN40nVDSZEjB3K+qagKfFXko5Ks?=
 =?us-ascii?Q?LJtM1pCmPLdx2UQeePiMI3biGC1pI/Ng4D1JK8yHWJcXw4uNk9G3sAsJu4en?=
 =?us-ascii?Q?WlGqo3BsRvnRxxdjNpsCf1R3dYJ8n/1//lhKjlnbvzUbf4CCo4vQLfM0g6LB?=
 =?us-ascii?Q?ZDhM7KLDwL96NWy4aSAVs0EYeTukrjDLRjkWfpn6qqRlb+iNmuOBN3r/nX6j?=
 =?us-ascii?Q?1zyCkbMKh7YcAPi6H5QhWEvU1kHCtMf33UdNzf9N1YQgKHQkKFWeG9u4cZgQ?=
 =?us-ascii?Q?ZxUIkkHeBPvACmkdX3wpkfeDyGmqaJL2YrIFxsZhdtVwjLmvrvIq2qsZVENx?=
 =?us-ascii?Q?jDgT+rrTmPZgLBRVy3TkOs1vqGwT6VFk82fhIsTOaS95dL0XZ0jCUrptplCJ?=
 =?us-ascii?Q?dde1Ln3ENDvNe8iSWvC/PTzouZyds65fysJWvUK6y3IWJun4TCbRsBjKnaTF?=
 =?us-ascii?Q?AJq1YtsHrE3R97d60W5dXgR+E1BNhsLRiLN2HLmryuPjOMOvaVQk6g1A1xMu?=
 =?us-ascii?Q?MQo0JvCVyc/+CfgXQCT76d97ppA6om4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77565af-d0e0-4c64-31af-08debed8e8a6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:15.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHSOOLycKXwzGi/3IvWufsoCf9ep69pd0Bhq/vve34FdLTPQOqgtW0K3485UuvbCFbYb/tQIkw3Q2vDRHkvTLr0vWlzVA9z19hJh20r4GZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

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

