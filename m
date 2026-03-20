Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05453359A7E
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042636; cv=fail; b=QrNKpq9mXCryS1RWeONPPr/fhMLHouvkgLvBu+4mdfidCRDkUGTSayKxfhw6ANjGsAQ4ekDm/uaccUkBky908goehDcggGKR0YkvguHFUUvwf1PhrCCSb9iixVgJpg/xunAZTeIGCs2Ah5ombW7w5xPP2c3q26nMAa5BN03cUoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042636; c=relaxed/simple;
	bh=DQYXKfJuxCULoyNlyxLjV7aV4yAKIAMLvbghDtRkjkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j9qQRkulapCgnaOlCS1fGnGXK9DpAznY1nHe1W1gj9P73twa4st4dF8hxSo8MieOjwwKtztBNCBWjzXvGazFaq+VX9klyHZmCN5VG5yWc1deorr4Cul4pDPhHGc1cgFm5aeb1TaHF8UgNveDydLthy2mXEhaVBS62fv6gSzwfDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=or31+Rqz; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="or31+Rqz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sluoq2Auge2DJG6fPgXwZ+TIaykmrgUei8T/0JTISt7LJG/z9pZ3PnQjfhYgXdnP4/5W5l91susdGYRsSpzUDNee59tbQ+2Pn1ofN8DNYngCm37Jiab1RYJsPs3Py74u+dtlW5xJLOwlCzrWLlTJeOI3ZH7pTpUxCFIiQGY7ucc/tpz375DzlAP/xAEwPZyfieroHwMeCUeoNI4zGEai12WVqw4R/TEAr37UAGj35IBYx1aSp2lltV61JFtTmqv6zp5+/Tqi4+on59s26nXGw4VDjJXLi0OQAQSMSNjmcny3mUFgCAocxK8zxUYoOLMhdgu+k235zu1Hwjsn3t6D1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFNhonKJOSGFcPN/69+ru0gv4xYL2AEei7IK372odrM=;
 b=hyeIC52AnEqB2J0pVxfC/COve12vfg9/0bDGG6XcvohITrIiw4nZ0/xDsmfBjfiPAb+gpdoloCIoNpw7a7goPc6mgtKeJX9F50aUaE3b6+PupO37EB5PKzJ5SvPn9YJRxvZ5SPh2AXwZLmmE/mU2GdvjN2pQ2RBO7cX0uYBcwv79hFlk7k8B/D0KwefEiELzEd6y3lmVzOE9nwew2n9ZTJgYdo3nRBq3S+uwPdTEhwVe1mTRjKLU+XXQgi9fgLdJ5QF+dKKqzz1gDmta5cuTlyu/bv12j3p7G0LTxuFCCI7MGsPpSxW9I4Zx15ay4gSbIvsgxyf+CcelBHVpImCGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFNhonKJOSGFcPN/69+ru0gv4xYL2AEei7IK372odrM=;
 b=or31+RqzIR51nhve2esYPhWiCiHou2OaIgyZksK8nkZ0BBm2TNnaZe2fKhy6yWG/U8RYu50ZVBGqeBBd/ljpvqc5U7c2NV6lcqETcuQqi0Es+PrsadBSza/DrVQQa0AA0JX3NjBLF8F+6kLDP3Ky3a1sadfpsT4oq+dfXB23SS9hGSfis9Ye+/JkaKhREuqIH79H4pIIAbOYkHDnFdGBkbV5LWodnQ4l1fZQ4wsR9wDuAHZEgUg7K56z/6sYAG0lLjt/BKZYAlGCklimZ65ySxdAqHUnxH2ys8dCTvirU5AoFYHadcv4011NaIfM/88mTe9IhyQ+s9oVCtlWdaQ+Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:628::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 21:37:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:37:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v5 03/12] riscv: irq_pipeline: enable hard IRQs during in-band trap handling
Date: Fri, 20 Mar 2026 22:36:48 +0100
Message-ID: <20260320213657.2210419-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: c09b914e-d300-4282-a129-08de86c8d648
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	GwSlnCSaqnwr5XOB5IJ9r1jiDpI3+b1TezBBMqrUkmNnH7eEYSy2bsRCx5WaUQH/EliiZcI3IhTHTmDRPIjwUUFYIBq7/m+NhsnZxDqjRxx9Xn9JFZKt/2sPE3jASYanXcdYhTM2qe9PVydbcU/lVUYBIBlkxTfYbnwDsjPr0fltIoBfwksNfZtOhOVISC7xGhSazNalKXEQqfM8wVw8oAJUznZtLT/Krp5yTBQAs2eOuaIyBaBhYVK5Asg4rgQ8NK/H+t3P1jXyYjZkLVYIQD+HuScYuNBxvfRoLiIEQEC3LRUut/MjFXaU4owcrkOEwg6Cov5Vd/DD4SYkLv/s1XSlJlt4phZ8QyP/iu0rsckZGnux2btQMr/rAy3fk4uQ8HOZzbYqEG7dXdXVkQ6QoqV91lENSmUf2C0fDnEv7zxTmUxix7o1nnDwfvs9VYuneRXtLgFKqzo4Z4xcJyVjNaed98tmwuVlFbC3ym7xCt2e/W89fX3jthuyn6kP7F0kb5M/Y0IT1oICM5dwJrBnno/OeWn278IhItH8a+oua9aTxPpooNbWXPTaUmqxbuywpEcgTng7Q1ZiVc8SRY/td1vAL5bVPmK8z1lieBG6NLThlY8QrUsr1x/5Hr2fie2+C3C3ClRyp/Q9zU4k8XPAxpezUk/RHVneR/quPIvDp9stAD1T5IJ1BdRy9bNlFBLRKGieXLVatQTioWA/usmyHIb5Q6q01YfUjxwcE0Gb9pI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T5dTfBVSN7W4kZ6Swj+Lgf/f/V4DribWOQRiuxGV/e55+4+wHq0HU+LybxGf?=
 =?us-ascii?Q?RBHUhvgR9FPuHq2ZSY15Prt/0whCdymFig7zOxrn3nFQ1YzS0vWrGOqMRMmS?=
 =?us-ascii?Q?l+Dsc/Bq6auZ0G8RolWSyvNIyj9V6zhY4ej+RealftQoVLC6dMCdyKcYebbA?=
 =?us-ascii?Q?Ad3jSckgRPD69+jD2T0hM8+SBkpgMtzSFKPFjmNH/gVCkfdZHbejjh0WyUoG?=
 =?us-ascii?Q?+fOq8zTxFLVsNmeAyfNsO2t+bNZhvrFQvM9ZiuSGvZFDMSZClGSKO6/HsOk8?=
 =?us-ascii?Q?PmHcyObHjViR+8nh7nQ6cH/R9uj8/wVUerJRVZm+2E2FixtxeGcaX7+aTz/5?=
 =?us-ascii?Q?5WssJfCUPQYd9Xviy/Hgp63KOFTYxOjulRqf1FYqvE+HlP3KRifAw6f2u7yb?=
 =?us-ascii?Q?TFKGwTwZ5KA/pikS96zmmecpbMJGDheG11rKB5GxKwNr+x3hwLcYYz8F8nwP?=
 =?us-ascii?Q?bHJfPlXuDqdl3Rcj+RqUijwcZ9McT7RYXKp/Lk/0J2k8Li+M3F06si3rmu53?=
 =?us-ascii?Q?dH2TyWDSOSGsXCgJIcY+7QSG0/rjZ/k1K8FUvBftADrOMgManV7qBczcW/ZU?=
 =?us-ascii?Q?3S6mXDMx7M1Mniq1HJup6DlEsfpV/TcKMfBZAAiYz06mMzbSubGt30sdy9SJ?=
 =?us-ascii?Q?DwaqP8LbVnJ0HtTXjyMfQqvsSnvxdgtx4DnjwCJ6Rhx8XDJJG6BLdoVxLzWd?=
 =?us-ascii?Q?mxvP9PyN2MZxdUhnYYBv6mYtubBSDV64/RN/tmLu9mj7B66rZAV/FLpnV8Q+?=
 =?us-ascii?Q?nOayXseeoHPVfr5dxr5A+af9oGnQkuRAwarCvJrqsy0itrXDulWvtvmKrPyS?=
 =?us-ascii?Q?8IGrapJz3R0mSLsliuLNqBgZ8/xe/Ngz9k6oo+osAxba36sgYKHs1jufxkOe?=
 =?us-ascii?Q?qjsaUMlPCKaRK15M0yB0lbh9hBve+4GeNmK3+PhfE/MXD/SQIjWenE8SKukf?=
 =?us-ascii?Q?ccZ4oWN/2oufLzXi87ALopNcpZzdxM4LbchBhzo2eHhlrclU0/xxcatMX3ei?=
 =?us-ascii?Q?dvpAAVnv78zhp/dLrsRl5kt5keHUM401X8cBqW86Di4gwe2shdgleDKu3CRw?=
 =?us-ascii?Q?BfxCSzWIzGAadleIJFEC2dGtXGat3QjsqdQpqabBVVBD12CNRDSpz9GPpah2?=
 =?us-ascii?Q?wxqejz6mwhpOHq0hY0ra1vE9m+nJ5L+qDg6vAS8j/XZUTNyTTjzjagpN/Zx0?=
 =?us-ascii?Q?M07Jfl8X3bDJNtzov/47oERraJmWB58OXVkmDHgTQ40CiF7Z54QxCgU9Crcg?=
 =?us-ascii?Q?AU9nZ3BWox7pTgil+ykQNRIO7tbhaa8XjW5PZU1A353hOscyPNhPn/BnXYPR?=
 =?us-ascii?Q?taOUdNcu1SOOpBHtTo/wD49mv42JXv+vFSZBf8MBfzV13co8TNmwZo+N5gsT?=
 =?us-ascii?Q?qVRncpK7TmXCBl9H2+U6tFYvsJOgDSwvETItJgvKcTJeJ7TV8gnXNrziNk/p?=
 =?us-ascii?Q?Q2cFrvvGCFyb/ASeYCio3TJIcN2gpmPD1KAh2fQH9EOxOoIub5z0tAXu/Jd2?=
 =?us-ascii?Q?fgJ++amZUZgaqXey2L2Ia7mn/Bdt1q5vDhgEsl3PXMVBp3+lxOyTvlLUP9Hh?=
 =?us-ascii?Q?K1RPTeaccvoamK3rPV1INgpVtVG1zFlMzkEXHdZBGzBVjaKIbD94b+izrpZB?=
 =?us-ascii?Q?Hd8hLVfH2uWGA5gLo+2xVjIr5Nx5WAT3uW3xfj7W2ODwmevlly0LUH0if4qi?=
 =?us-ascii?Q?d4I4Ah3120mtzDVGD+kYTIjDtzcOwMtOERgG2oOAJEstHD2hx5JH58DyEYrD?=
 =?us-ascii?Q?3hyNh0En1rW0MZrN5QgSo4dVhCYbt9A=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c09b914e-d300-4282-a129-08de86c8d648
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:37:08.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tf+7GGwWJZPbuZgMUNQkvJiIO1QQ1thkfn9cMDdxYOGbuzq0cmcMCdLQYHXBH4cEUVo9YNCWYDeyJmehMPAQIrKi00PJjc0PWOLOhkuQWzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7827

When running with interrupt pipelining, re-enable hard interrupts
while handling traps on the in-band stage so that out-of-band events
can be delivered promptly.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 267b8ec5a1bf..5b84e1ff0eeb 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -112,10 +112,30 @@ void die(struct pt_regs *regs, const char *str)
 		make_task_dead(SIGSEGV);
 }
 
+static __always_inline
+bool mark_trap_entry(int signo, struct pt_regs *regs)
+{
+	if (likely(running_inband())) {
+		hard_cond_local_irq_enable();
+		return true;
+	}
+
+	return false;
+}
+
+static __always_inline
+void mark_trap_exit(int signo, struct pt_regs *regs)
+{
+	hard_cond_local_irq_disable();
+}
+
 void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
+	if (!mark_trap_entry(signo, regs))
+		return;
+
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
@@ -127,6 +147,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+
+	mark_trap_exit(signo, regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -137,6 +159,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	if (user_mode(regs)) {
 		do_trap(regs, signo, code, addr);
 	} else {
+		/*
+		 * Dovetail: If we trapped from kernel space, either
+		 * we can fix up the situation, or we can't and we may
+		 * happily crash with hard irqs off. Either way, don't
+		 * bother.
+		 */
 		if (!fixup_exception(regs))
 			die(regs, str);
 	}
-- 
2.43.0

