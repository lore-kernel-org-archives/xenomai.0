Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFD3BD647
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492091; cv=fail; b=t17DNfW8bl/kmR/1/+PsXNhR8agkOctwZ1Leg+Xty6Al6UTyVsXU6M4agMWXqPVQC8wDTxsvo4tRzHEOpXNSkXpvDhZKyxiPumSXeAOy3yfbpGGQuNIS+7OwJIotiQqQtHhT9ZDF/l/6RW6fP03eA0pBk5t2xmQWr59AdkUzpBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492091; c=relaxed/simple;
	bh=958qHao0IQW7I/cn2cJLIBEMxiStEfEuEX9HJNZi7BY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o4zYJfl1wRStlQmWzW39EQ1FN+6mNe8/EsQxIAsaSEU+QRRikOp3TGLP7bNTLf6ynyD8rr4Xvb66OExTxSlE/FFZgy12g0wRwV8yvoG/wgvFj3Ds6HxoD6vGucTNwOmAvzwEfG0USsYc/wodi68osg5ptawz368zoRRaF60amN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=iGlWLvhh; arc=fail smtp.client-ip=52.101.72.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="iGlWLvhh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU0OtLOjOB4P6s841qohjRMdO3oMYIWOsk0aB+UiaGkICSEXKnaBDABqI1o6wkLHUKytlg2BZVNTJGjlNJEOQE1cvwfQOTVMRWiiRLvAvoTL9Vuk7BoNS77oabKrShieCj5U7sdZrEgjBNVneG/Baie5pu7EfZhQvlD0HlFCITRLL9CnGfeuKqyhsR7uQcSgXK3HQJujnrElZFfF63cGo/R41Dqs21U1mRRIiG0Ama4pvz/SJ0OflVvzmYBqS3B6Bfq+0hWMJERsxgC6Cj6ZVEHI1ddohMKvwlByoTeBMx2Tz41Ng3ed3idm7Yp575c4QZkdQgXU8CkVYlCmMuKyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yl4QrzvGbesdA0kO1SgXVgUMQYoLbPGRB7+FobAzwg=;
 b=d4H5io1v2qscp6QcLpFjPnww/c3MpbEvbOnMTNNACm7GCfrbrpDA0YgGW0Bcn1KmjMZx71/Z1OTfQluPUEGaXAPRcu0xboDh6c8peDwciQGS/323060ArssqNZ8pLqZTlWZWsN4CkSGt3pTUtsUxqyiwc7riczvhTd2Q7oOXknDXoHHTpUUMObsJLp8ZiO3NOtKVTj1KhlDnNbBPEdtRs0LhPt2Msc717NazIYGJg+Da7ItW7Ldydv1bz1ba64y6JTvjFxodAPOyrodOZQceiSSCPFmh4QGcWdMfBqB7wNPpeyzwbJv4kOXTWmIUN3B6yqKVssGK8fYQXBQJAA2P8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yl4QrzvGbesdA0kO1SgXVgUMQYoLbPGRB7+FobAzwg=;
 b=iGlWLvhhyvpvcZ5kMBXYrC7WiquBAm6dYDhvnp7w60A6eM+l/DnDV+Z2YmiI2QiUNjdlorTDHCbP+lPzcua4paRAUuRJrNRpAExfzp848qcPg3ZQJOTlXIFVRW/Ho4XvyfoDTHV/XUTjgCSqE8czkWki7rAhLRbjH2RMr4EUAA492YfrNekPUxCYAG+Z3seKFhOA43HLRWzu3uQuihDDW2xF3E0G73psPctYLHO48cJsfHM/AddVJ4CZjOozAI1TLwnoAGRkjw/5f6YrNYjwcFYeluEZIlq/QbYCd6BmblK7+QvKIs9ONIqrjWvbSgCIniwFdFevx8OrIpjwDwIQtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6263.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 06:27:59 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 06:27:59 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v11 08/11] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Wed,  8 Jul 2026 08:27:45 +0200
Message-ID: <20260708062748.1029852-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
References: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: f73bb8cb-b702-4ca6-cb5c-08dedcba0e3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|23010399003|376014|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	2kigB3qC5schiodBO+YDXoYEJl7eSl9FCLkqvklMPU5oRG5GKuV96ffMavaOi2/0DjqX3WF9wSL+KAglBb6zSV1RDS/tAWHeemmHHolSvHbw/vEwnmCG8DoQv6G5FQyg4cHAWF5Sq1DLt+vTGasQBDJcXPvvwQpKqVG1zmngmQegeDrYE5tlBpfipEXzZQfqvuffPm94WZIwM1KbKNDyWIknC1/9x35Bcfj8d78k/Q9EnTqEBXxHsR0zrXqh/B9PbY/dJM36tzt4J7/10qO11GMv1EmW80LCpbwGjbw9k8Z0N+lNNTuqcwcX1mRJ6s1uqTjjCPMSenjlIWWzx72+cOIs18AqtwSHb6/kIlw/cH+kLj4YP3ztU3wa4DavoB3p9fm15kz1UfZ/YxVe61ydVunHl956x//WY4Dw5KZerClF6TP7geJZvIO2Qrrt3QxvuvYS4Gt4NlOM5S/glxHKPJnWNrBWHrUe5kOIJZtfM5pVrbLEKhUbrf2MldYgh8jMJSFjL+PMp8HvGxmWmqFxBgwICvTFbZAU0jSafeBnvF/vKo2IYP0zu3tL5uWn1R2RDJucedhFZ3+cwDDlX3FVXxoMJB2Kh7ArfyL3crOS04GRTA0dgLuQ57HjB0mEZikhHe7k6XsvTt0TUKKU+dtMxocl0nZOROsC0HCrvF+wi0E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZhpFN/N1K0OG+pphZnyGIpfmJ9RCzqkJQ+yMm76wPGRRXz8lfDb/SAZe+6JK?=
 =?us-ascii?Q?kxNccOiUf2jT4+W6jV4TBexUvg/P0Al9pC2z/Lsy7gOjuxKVOMMS10xeOpj4?=
 =?us-ascii?Q?WIHR7BZfjVMWFMzd7tAj4FEsXU+xFT/b2d6Krge6oHy/VyfVy9ax36Htreea?=
 =?us-ascii?Q?kUlGTNm0mxiVvRjzK3B04ukpAHzGE57ceEIbBmkglMHQscxoodmNC19b8EM+?=
 =?us-ascii?Q?21KdMTo0KkcWZ6oTBxrp4qLrRjDamugrFULWPz2ljMOB88BQN5QLxreDqfSP?=
 =?us-ascii?Q?cB4W1cDNoSSSK6Le/B5CtmWWrJpgNuvKcn3Uw5K1ByahG4tuvsMo94k4+wyc?=
 =?us-ascii?Q?jeOP9Rt7WLzuf1RpK6Te8xJgoKQoiet2k/Awm8FhWxaY37U/Fx1YnDHcOuUM?=
 =?us-ascii?Q?iu4lK4bePvYXfEvNyoOP4WwukglP2u6kHcW5dOuT6M29GWC7OYGDVwGV2dN9?=
 =?us-ascii?Q?65JgnXbVUvyBFLZNCjC0PNkGdALiwnoFwqU6tChnBpZ8VzAB5aR0t7SpmT5Y?=
 =?us-ascii?Q?SS7tCZZoEH3q/cFAMzO1YGzuFM45oRacgTQyUxEgw5LBvsNNnlFTm2JF55nN?=
 =?us-ascii?Q?PQkGSsg8ndCIjo9raziXwTkhBGJf1i0manKqq5HlNrVlJbhKI86x2OtDzhyY?=
 =?us-ascii?Q?/KPqjO4YmT8ZkN2vh7qcnv6uhy1eKVDw1h99poONqiINlF6Hc8s3D6apLlUN?=
 =?us-ascii?Q?rtb9ovg1pJyNl0vTeQz6bqOGSxxP/ujhbPJsZt6GS7vJ8LOXGug6TE3ThA6v?=
 =?us-ascii?Q?HWWSk4zfrZEQABAlLr2sh0zDoHHa/1Jj1wDsTysDQ1bUw7x92K3n+ZxnfXJH?=
 =?us-ascii?Q?gVpg/7RwRhZwU/oelcs0kKYUUI/jtmZhl+hWn1d2F82S9EDhgsMr1DwHP5Or?=
 =?us-ascii?Q?KP5tw5ylneU6H4a1LGne1euzO80hskJfKNla+ys85JAU2b3P/DiUYv5Zc+Hu?=
 =?us-ascii?Q?1ODG3cjDD+nAlyLLWQVBPETzGXaQLOFGAmM1mq/Ix6hO7ZmNbp86swf7sT7y?=
 =?us-ascii?Q?oHn6nJYImJiMUnGLy9CEUjw7FTSVR0fOJ1eKUqGRj4rknQ/ps09lGGDAGQKc?=
 =?us-ascii?Q?Ozbj3y2S3MsH2pDcAtNa3v5B/pIXtIqlihsU07r0a5ZsPmG4cnFfDYa6FvTY?=
 =?us-ascii?Q?7pKMbOzEj4kDiJoCQLikjAYWj6m/nY5/wRqg90RDoN0Jo3FVrQkTYXBhqeI8?=
 =?us-ascii?Q?A5lbhM5Zzw7vYPheXsavnUrx8xuuyeJ9iuwraPoJXUbQfOv6AaZZj7Y+FRo/?=
 =?us-ascii?Q?LjXi3SryzKFgSJqO8My436GL0bmuCv9hx/NRy0dis63q5a28S+wOfCWtBOCX?=
 =?us-ascii?Q?Fspe66Wg99ub0MAAv1qBtCCenVg4JFboE5gDJ3f2Y7GQg7r28TRX0txOyFas?=
 =?us-ascii?Q?ggSfHzAlLGfpfzUxkZqZO6a+AY3qKTBNmuCCKh9ahpnixp62uimCKbw1nRS7?=
 =?us-ascii?Q?A6Lacn93DUgNY0hXYn1Ki2JO10uPquQMI/ltfTs8wRd68LOuu+4y2vjO3pNv?=
 =?us-ascii?Q?OPMEU/ve+pYyszDD7WBAFY4+k90DbuGzdPOD7kkBTaYsNrM3sAFxrZNdNtRr?=
 =?us-ascii?Q?IF42YSZ5AGM2kGN8UuIdD0xNE22n3y5hbMqM0T6oOSpiap9nhi5i/l2KjII0?=
 =?us-ascii?Q?J/QSbR5TnaZDribbCoJ6M3Zc9EttWSYvPFtY8A8xTQlHd0qKop51i590G/Lk?=
 =?us-ascii?Q?AMer/iSm9d+Ku5ITAH7wbVhkk8judDxt3fJViQvFMMnvdBUEZD2o/1gy/PQX?=
 =?us-ascii?Q?GTQokUCvVE6mFHaHGep50q09/njKBLb5c7guyL5FBe/j4DMyHJwfBhKsGo9q?=
X-MS-Exchange-AntiSpam-MessageData-1: mICD3fPT3CMSPyKwnbYGHmy3FYGjQ1h9rIo=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73bb8cb-b702-4ca6-cb5c-08dedcba0e3f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 06:27:59.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +U2nBU5kNZoj80spjpgrx7G+goP3UKTfzEiXOiSmdMnKesKDMFm5TdfmVT7dIA8TLTjIUOz5s0W+/zKhyrsGjpjKSkH6xl9YuM9SXjBp3nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6263

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

