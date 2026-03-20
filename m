Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9883BD23C
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042640; cv=fail; b=EgNMyCYqM41RyMTMio4uKmfsTGaB6tWKzH31l3uSNIzpFUT8T1XHlR9izjlfCop0qJRPl2IS9fCPZ0lwaaNDpUO/d11osLyZFa3HfoFlDiIZihTd5XOz/HifOvncZHEGW3wKBfBCdvcDJj+Hr9TSsANw4UGhP21/xQ2BFOiz9bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042640; c=relaxed/simple;
	bh=CqdJ1/tDR/GAgIBV9Rts001tLIVxnwUXj66Un2DH2lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNw8KwidI7wnn+X+5KDyfz75BufFVFlyVUuE9hMcpBEWJLX54mmy5hX1JIM9p0Jxkjuwsl4km07YRAHaGqY4PXYooKKmvcNw1MM99h2DFGHmGUqkeiThjqu/Y9hdBtpsOsV2zP9qcDR/Xzd9gzGt+PsKf9Plln8hMpzjOtUOQFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Zxkay53Z; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Zxkay53Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbdceqnCNBvR8XWE9cHYFfuSMR2J5O0pNutUB8d1fqCFAGYv4YWPGKOgBBkrTuA9O8a1bHv02C3rcbj6qU6StuQCWj5erHpbiX7ndywX/Ecsqp/MsvYH3sFBP4sJSKN27hFCJKu3yCsx/9ripvMud+vLA9ONOLcUxeJoxfRwOV4g71qo4zQf0rtSG5niONdmAKA7KKcCR1OuSV2sp9zjq0mIqzy/NHP1tj37leVAm7aOWPiZ+IKQ3W2s862t86we2gHD7CEuv5Kwypo4UBU8GpOh5wSDfa5ZC8u34q8wvvHgTW/weSfqtuNVj+RpS4W/sIHwL1XFuy3cb3VD0BF0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m+YrcMzTwWRhg3ijJKx7cOAQaBHZw0Anc6+w9QE9dQ=;
 b=IQEowgP88iPYEbrv4mgInxv2yxNL/nEiQsuq2nj8HBX0XI/lSyMtKiFT5YpoCbQXCGiW/b++b/62zUdG9virrPZIeJ2fS1Qf8QjuoiCeKNhTDRco+QrI1VN+DGuJqd5cBkL12SqWbm7ZLt6j8PxwbYyZ0WEVZSXsltTiVa+S8Db6xKGYHHNtC8DEJlgDg9bRXOMWpSQwy8JtwR7ANv3ejwKLi+JGzl32e/DXbx/lCzWsXeoKtSy2MYf4Yfdtiycao97UdFdOTYm4jckgrFthfHCzQHPS8Hf+26eGy3CX7EYNrHN4yU6Iq/cznMsuJRHpB2A2vI7h4nZZ3mMTl2JRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m+YrcMzTwWRhg3ijJKx7cOAQaBHZw0Anc6+w9QE9dQ=;
 b=Zxkay53ZI4CkREq4kQC4+uovvKZsmIUT+tZ8sCOR+lO4ZQwPCsVGtPzvkcv9b5oJBe0ujBJXo5fis0GtJ0Ih6/w247ZBorO+3fLlp9YeRANyPaBCAbpcdmxwOxYTb+dMzodbHMyYrITQLMmUIF+GNnAJg1eEh9nOiVyrzyBfs7lGCuDpJUaRbn5PlMNQyyOd+1YH6qpCsowewSBzeY+WE1sVTXs4AO+VgiYoJy02rLy55KhA5l9DRk0wNxEPnGbKwsWwSfYQZD95pP1FZRrsrDxsXQjtaNLcFHc2ubs0jvu82Bo+Vxt1bbM8PNyv/kGEG1NWsjAZgvOhf1yB60DGgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:12 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:12 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 09/12] clocksource/timer-riscv: irq_pipeline: enable pipelined clock events
Date: Fri, 20 Mar 2026 22:36:54 +0100
Message-ID: <20260320213657.2210419-10-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
References: <20260320213657.2210419-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 1257d521-a622-4116-e942-08de86c8d886
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	TSeNDFdezvVLYdDpSYq/UfGUWwi9Z6CrDZbZCRukCTPCBiljhBSk0SPyWzCyQb8Pow17mweoO1fPcQhFUT6KFOj/0SidaAly7wKy0XVZI1skrlWOf0Z0sJ1d7tdSy61RaDRezZWV6tjTSz/lUlU7YWkcAAn8ZGj+Jc9g0CMk6DzkqRX2JXL9zX95AyGilfXDhFrNkQk0cYXv+UZ2ps2bBmy5sL4w4Ru1mpyzOB2FmeMnhQ1E3B5LeqNvXd0MiCaLBCiZchZwsEL4KMMwrZRcyOPUq0wW4NPETU+1nRimeFMT2DTj20wrgCPiPXCvqTAy2kaIeDy+qplAkns+ro4hX16Gg0vTL9JWcNGNdyniPLBc/hxRlRqgJmScJRo0VIJPWICu8EshQSfCzi0+JCjUaxOXnWLUuVkuLpgOaLFG8gMYtwBCjnUCImzA2fmGZ5j0/RuYautfiPszE5nV2CPr9FMOWFkt+8iRw1LWtCel7+xrlBTSX6MFyYNyzH5b6XV933ulH3d9AUJzN7yuNpnHeaMM/f7lrn/maUSv2xGQvYvHTTzttJNY1poKtW1tWX0kFLYOrMZwpQuCSsLXyym/Qr748cAdKtaWYsCOr/2k68RJDkj1ioQEULfh9NyszfYKmM0sjcx53nBpKF3GvDkBxRDS7UkvAGxAYaIyYIBn+SMaMzxyL/3YBAN1r7oK1Z/Mj0ls5F+OKonh2nC3byxewPjM/nNhkLNDLAAt23etwvM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CyDtqD5Q0Z489N7ofjq7PspH6maXKPhuS/tsLYd0eMF3G6PXnRpLiCw62GWf?=
 =?us-ascii?Q?TfkCHfXuBXLIIHXSL4E1MH2r4BX+RzFAj2va9Sra3AZfMm4wzOB1VY/0H0YX?=
 =?us-ascii?Q?pmgPdNS5FAfM2GJ8ss6MzkR1IFGwdRvlVIJ54zewJda6+GRo4XWDPCBpTx9+?=
 =?us-ascii?Q?iCr9HLwF7hmsjN+kC8TP6eGt4lRnH6kh5xWHL1ritbF59rnuNqs6A1rIGN+W?=
 =?us-ascii?Q?HfuGyWdHyah1rb9vxiq4jz5YtOfG7UaeDsCVu8qG7XBeS18lue0jN/xnylXi?=
 =?us-ascii?Q?NTHafcPpfvzdbkixrOFRyjvMAwrIk7LRjMRA05vtgjMVXVz2PKvC9mMjqgZK?=
 =?us-ascii?Q?ka5C5mT/yinzwn0qoNW30XjSEPTyxRlU4FFX+q7SUVliZJAcK94WqcWr+6KT?=
 =?us-ascii?Q?JgbjAomSO++5Sqa3DxAtJy6/fA8z1Cb3ya1pOuRl4NvOwcgxr8Fn7KEjR2Kh?=
 =?us-ascii?Q?YgrtPitCSuPzld13TkDT700yLnU2DsVDLN+Dm2ZeH0d8WbRGUh/cGarDXMet?=
 =?us-ascii?Q?+Hd1UgLjzpKkx26Uoudzz5gMkz5yF5HEL4L3GAlZW10JH4RsFRtkv0hX6AJC?=
 =?us-ascii?Q?ER/2bYMG7qhP3KzHVa8BV/Qr/gX3Ooj1UKiifQks07HI01MmbuehZquDTjNK?=
 =?us-ascii?Q?8Z5HRpJn/ByKxRwYMo45z0HqBhx71A6nVyShQwhGBEvf7QaalY67VHC3tm+3?=
 =?us-ascii?Q?wBxBFbXldyjHf8Qzn1IbgNKhAK/ii685VGSLaXr5poHNohZjRixDzx7olxVl?=
 =?us-ascii?Q?41M1GFvj7jcWsc7XBqFC/LiCbCkKaMqxMNvKSysDthe0CK+BndxDoSv1UwKi?=
 =?us-ascii?Q?irEt0HnkC/zOlzeZzD0bbqjyUNMaEeAb8D+5kpoL2Cko4bjMhYh+FUw3tCa1?=
 =?us-ascii?Q?ubVzdqcYEkgpggCIew8bLIhCCWldfGIRl6she+HKCrmDWQV4KsWvC+ROBfN5?=
 =?us-ascii?Q?bACDCJkPMk2DlPGhPYtU0sh3v6CeT1r8gSZSujSTshkqLvSVWLlkT6IhgVjR?=
 =?us-ascii?Q?fu0LDYumJ7RKz3A2ZHPU52PUyxVBOsRH9nZY6WwjnxKrclFdMhkfc91M2jVE?=
 =?us-ascii?Q?nh2rKkSKtd4tJXKGAJWxvzNMe14fI+6SPANnMWXY3muZ4NC3qDQ2gP7FibKs?=
 =?us-ascii?Q?+VL/9diec1X8ntYanZXUp5jU5tAqJEsx1yzFT61eisH+ulinG5aMQvjFYaZO?=
 =?us-ascii?Q?YZW3PcKtUBIulhDUgBFhRIqxNlri82O6tjNhpOu+x8xonsWHJmOqRhvsushK?=
 =?us-ascii?Q?m1kustlipNn94OAvsWHSJjd2fKlUi8eFs6/b55KoMYA92EAfvQP7YCCvvn+f?=
 =?us-ascii?Q?dDtzWtwvNr6gzhWXSyxHf1LOOorLb3+ktIpEWGMIq+WNKTVA85TZ/dKadB6l?=
 =?us-ascii?Q?oAKr/LCb211a/unhdhbWcFR5InpyStlvu+LrBJJ8nATIvnc71RUVvWvxRYLK?=
 =?us-ascii?Q?qEz7HQNjH+LVjS4h6gIzaPhEde8+D6jzS9U0PoL0kbeTFdvvK+QjL6WxYYbT?=
 =?us-ascii?Q?HfOno419uOLgbomXHt+PJGEPQkDlm6mDB7DTl/d5952Dp9AwiW7X/cPoahFS?=
 =?us-ascii?Q?O2nQj6Zxu7tZ+6Ln31QI1wwiFv4Ue9o58PkrB+IEk+3Ccs2utEpbmbeyBD05?=
 =?us-ascii?Q?wE++nhXiedwDaJ5IGroPoUuFoZpU5iwhfPKsF8o8Qlay8ih0rk1LKgSBBuVC?=
 =?us-ascii?Q?1/D2H4LSmyG5dRyJAZKvvabighUlv4scV+vvvkMJD1rwzAY3s+/wEN+n7dgZ?=
 =?us-ascii?Q?GWEsT3iXkvuoTHpXPGKdmRK0ssvmz6I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1257d521-a622-4116-e942-08de86c8d886
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:11.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6rqeSr+8vLYeYp9dxpKk7h/vXm89W/rx9/Elk4gIK+sPI2kI3NHYgbCuNBACnpmITGHe3KriDbFgiGa5AWXInYhBsE7CHD2euYs1F9EeyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

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

