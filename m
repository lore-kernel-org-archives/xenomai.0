Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339BF3BBA1C
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077405; cv=fail; b=UORHxTnQtsNh2MQUyufgFErK5DNg2wdZtDRnTWux77Oz9c/gnxhAcJfIFJfeV3QOfjSnxNPSVap8wz3mCdQ6kc4gAu4pev4HE/7olHZvpipBejC7VSQMy7SZe+fkEVCDochx3kYFIyu0zuPXvcUduXrmzgQmBoHYmz3g46PGb2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077405; c=relaxed/simple;
	bh=bHr3AHVkx5Q0SN2PK7L/udGJRe9nR94XPi/KUua7id0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RliQOfteifR/IY+3QtyKGIX1ecPRKDNvF7n2ZRkmVVbA8lpTpoO3hZ+QoJaaUahvYKUUmz9hKLFC/Tg9FTFJnYlrlBl6T2M6jHhNaUX2BGh+EOioseaHNRZoCozLsVx2EiZs8KuHSlWbBPbKl/UXZk2RR0C6oOtf+9jd9lAIe4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GBQsmfji; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GBQsmfji"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqeYeZZuwsLuiTLgclX0UD3Wq03D+vB+689CDDstLawz1VuWOyGGtCcUA/LFivNjM8qnvWu+YxDdNL+RDMXLuHu8wzH/bHpUHziLrMIa3ErrB0g48p+SDp8tml+TjTrIJoG1h5UAnI/n2zufWtfRpyvOqpawd46RLA2mvhsHpxhFKaASUAuhg1VeqNt1wfYByshtdAm2n0EFeR8Rk+5HLxVFpHG/2YwgvS+Tc2sinA/9hdgRvpGDoQ0TVSxgGM1fyeq5xBWjnp0heRG6PSWRwYf0aqav7GZ0UHvnuF27DGw+7cEBT1+tKJ3nkk71uT6VmpVgV0he4vUNecUW39EJoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0A/ln+9lJIxoFW9bmyfL+mM8vKteTSdBFl3i8g7cnQI=;
 b=VvZTfeYpuuG/SXIuJ9+48SOubyg6INpO3iaWCzYu5aQN4pbsFO9huvOZBfEyxVw13JOGcFBdgeFt3M//JJ81ddacDxjAw7jem7FSEajrSuobYlzn95qSL+CbQGOjYNwb6RraMeVJferWPSCsfQG0qoDrrs5R+U0RD2bVC9XKwGRRLp3KBTszhkJIhuo1GrooohLzgMXqIQ8OZ+2JvqAD6wy7ju42A0viSQh/CDYy28n1mASUKtSoLtbe6yF2o2SvDEoIXGLnmErjQPqM2oKxqwH1OX6VMMJgI8DBfEW127wE4qT7eRTAEu38ggnrmzOQGPt8Ru6g417LcfGafhuMMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0A/ln+9lJIxoFW9bmyfL+mM8vKteTSdBFl3i8g7cnQI=;
 b=GBQsmfjia5+mPIt+n39Q9iS4qk6zhfcbrhFO+WrShMkwEnvkkbWgrBuXbBc2cgTB0yQDqjWcHNm0QY6QHZ5OnEz3UJuj0vm+gNUlPOdNN8EpveC7o/YNA6PDPtdp203RCjLXmDu0PTEdgkt0Nf87IfyBq81k/OZvs1s8uvQV4mqmp/WWJ1k6zFFBxWy7/TsWSof/QcoksIzq/41xtxV9ihx7y7Hiano4ozmqWyiHVxr+Jfgua/1XUfEkxXcpLEDgh2qHUVAO+M1WihoaahGNVj9ynDv1LdQp1CO1H8DDsfa1gfwtkPTVC3tXZpB8gDt6kckK5Q1mGNnbbX3djCRmbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 03/12] riscv: irq_pipeline: synchronize IRQs on exit to user mode
Date: Thu, 22 Jan 2026 11:22:55 +0100
Message-ID: <20260122102304.421957-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: da62902f-5834-4f76-fef5-08de59a03fcf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8iKg33gs1D8w4XF44sdcSbZ5sLqIork05j5q0SLRWHw5tkbwSOFaD7TS2ffj?=
 =?us-ascii?Q?gbo98OJNaVvxTNN2z0+F2SLVhFvytK9t/yUzGa0lG/uGtp6WB7yhmeY4GNQm?=
 =?us-ascii?Q?5gDz0+xZN14otJC4e7nyZT+2/M/jnlvrLPEo9ehe+EFM4Cfo5BIGMuyWb09o?=
 =?us-ascii?Q?Dax4rxzHhjJZXcowula/w9k5O78+nV5MLjxA3G+90yR3exdRITUYPj/rXDpg?=
 =?us-ascii?Q?O43i+LWOFa+U66g+e81Mnn4HHdEdJMWpE/dhE/22Fb2SBv+01dLWOY1Hhvg3?=
 =?us-ascii?Q?dvO3wlYj34eGUbxGzzXfmGzIQoQZhhuqTYAJx099XACrc+UB7fW+P9v8+F1r?=
 =?us-ascii?Q?4JUwTTvuBKX7QBZepTuik9kXhPFj/VamKbiFy85ipqZ9y/hbju+u5/JUOhV0?=
 =?us-ascii?Q?CYQ2QIPFejb3/+v761/ONI6iin6MTz97khJp60qfHUhUr9qFmtJhlph/ioVw?=
 =?us-ascii?Q?UqS89tWeChKGy1wUh7sc3m4thOnqe5fJfbrd2Jz55r7fuyEkq5j3EMyso5xR?=
 =?us-ascii?Q?2uzpjCt/z2ZFC0rjN892Km38G9UPanZ8d86CkCQdDhkonKQu9nulqjeehRTW?=
 =?us-ascii?Q?z9w0Etkv9qo9QX39aG7YG0MnOKL80xffdPT/ZWdB8IZGw+6ITjfizrAOWVoq?=
 =?us-ascii?Q?5J/dZCMrnLcB7Sq0jwtkUjaxBf32Dvo8TkCWX4IK4UG0Vc9paeEqVDKoKylf?=
 =?us-ascii?Q?GBon0iV1Brp8gWnYzw4Lr5O/xDofrVnQLDipQ2pakVJTPf7RptOE8VUE+84b?=
 =?us-ascii?Q?f5Yo3IB52bwaZ7ED0nhdS39CB6wcJLj61YkyQedpX1+brHqeq5/PWGhVRilK?=
 =?us-ascii?Q?xvIDksj/MaJa8d312FZveRs7iVd4Yw93kOnvzXypAH3doIDXHfnYbpHXNqnS?=
 =?us-ascii?Q?EuvJVajy01jNcNA/SZ/MXbH9ooqm/4QTVYEzJUJk7vHa5YWtpLcrnnUJfQnR?=
 =?us-ascii?Q?KSsxyWCj5UNzjrvdBgCS5VUXntr0nzeVP8nNWIUEwJRKd+AvYOpTgWulWGYl?=
 =?us-ascii?Q?nbvbb69NYL2etS9yR8AtfWNUr5e5O7UGZlsw2S2BMimbH4PpUYhYiYxRIFNl?=
 =?us-ascii?Q?FP3B1BGKnzBpooSK16c2NOCS/VrIQExVJF5jainAGu/SHOcHgw6Ml8TfEGZp?=
 =?us-ascii?Q?b/yxJpriCJntXV69cvUzXCfDst/wRnMwf23ptsHhHDdpv+dzVIYm9ZWjC2fx?=
 =?us-ascii?Q?ByoQnlHarymv+2EF7l3LR8x03tUshRsayAvLqQhm/tInmDKAnekKtyToo+/m?=
 =?us-ascii?Q?pYAYaeYFRE7dWQLSB/oEVMGvgCvnbQ08xzKcd7kdJJRlpW52pqYwe6weayOy?=
 =?us-ascii?Q?aseRvWccqzTDaOkK9uKqi9WoxdJ1NcYWg07JLtNVichBMWCqVGH3+fmiVPAe?=
 =?us-ascii?Q?7OKYfGNORWTB5eJ4VAHHmmLQeLk6jkCL34XDB+Gl3tbIN4xODgp67AFeQ8KJ?=
 =?us-ascii?Q?5vjfXNy9gIukbZClBlvooMyfSfHGZx27lWWNnpCdIMlFkyD+kPexTmSMw/eA?=
 =?us-ascii?Q?ASM1IEEviayIvuSzy8XU+ssB61kpx+shlNIkKQAeW5ndNSLACVue1maNPOmz?=
 =?us-ascii?Q?29Y95zl8h++laivPgbc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPfIemLobFSZ3T4P4GIjaUdajGXLeWy4uSl0YJXLR7SL35P3189Pqtmf6TTT?=
 =?us-ascii?Q?YNNy+/a+vBto2DwyYaiAxXCyjNz8s31FvDFxdgq9WSJmTlxgZ8dTq3REZHMb?=
 =?us-ascii?Q?hY0bfMNemaiFtMk/AylMoZehdyp++iNewy0NhpxyDg97XB4dIAEwJQxHHUf0?=
 =?us-ascii?Q?EdMtDosQRehU4KUvvG0hVNOHHa7GIahDRat+mlyqXgwABv3aO6SfEkXGfNFm?=
 =?us-ascii?Q?+0/mtj1kbFWfpxzBOwc6dM1X2PmZGiH1tdhv1cHS3RTONTTCBeVPh+njbx11?=
 =?us-ascii?Q?ld1oXJegixIY5ubzJ7iucaH335oYOR8tSOX4tw1Vd7I/6E2GcMaW1nZDmbSQ?=
 =?us-ascii?Q?wmV+ZuFwcRqib+JGoLTbjkVi6gyIn931T/hrRYPd/ujugqwGDwB3fjHTvIt6?=
 =?us-ascii?Q?sNn9xER3uXJDLt+vWR4+9dSipPCjHDao2mUcB5Ai2vX7YcmlXMmbkhhf4d5u?=
 =?us-ascii?Q?oq8b/RWjgPobLrEIxN9Ihd87cXWwL+xNpo0+R5C3hlFD/XENmsa0RkZuQ4Hc?=
 =?us-ascii?Q?3sRbv9ZGTy37dytnH34VrgGpOeVt52xZDo5pTF1C8qTnN/FlkMmTM5M8xaue?=
 =?us-ascii?Q?C9aq8N5uJUZxozFlFA2XKYyAwlQ0amu3KZZQy73ZGlyBcOXu35miHMBBO4s7?=
 =?us-ascii?Q?11CjqU4WgX7XFRZo8CCFwMBc5QuBIw9WXeEpBKPqnoJ8d3/Tz8jqeRVDHqnn?=
 =?us-ascii?Q?gIvHW/Cm/HTKygEpbc1I3M5l0IIa+MiMJzDF8exQbE6Lk7yVGO9JlgrMivzl?=
 =?us-ascii?Q?aCiL/WJJzBr64lS5ZoAvRMG1H2K10w3j5J9cTHQOS7jjbXpZxm+3xfUx4LlB?=
 =?us-ascii?Q?BvQEhWIsu6Kzgj3ro05wSjtaEaIdIk13aGYUMy3fxWR8hxQHprckO3kE8Rd9?=
 =?us-ascii?Q?EMZpUVq2uUwplAOBpbVNGctn0mgZwyuJM3g1FY6+qJ6GQSQjV1pPqfvjAcmK?=
 =?us-ascii?Q?vbK19lYFmXvJwPDT5AC+YMdKfjHzg9BkCSBLwAyRLyH4bW//mAJJtUqxF8n2?=
 =?us-ascii?Q?cdj0HIWRXCihbOhaA9IAeCG17nsvJPZ5DuCM/PLqUbvKZsuCV3R2yreh/v/J?=
 =?us-ascii?Q?qOtXyigtNwxYLeqgJ/TOZbEJ/jAT4amaLgZ4OeTsbBtR/E0FZt3jIGClYOlz?=
 =?us-ascii?Q?4eqFYZvcY//4B7w1YLV0ph8geXoYL1ZHNPC9sFRKKEaGlTcEqoHzqJyB+G9M?=
 =?us-ascii?Q?PMi86YJEk5YLjt+3scqEEBEUz2PJ4Sm3kZWIoPTY7s9MOq/4p1fI/eLhgtZB?=
 =?us-ascii?Q?3duiclDlo7Uk+FV61GB2ikBg/Awf2wQQMo9n/ZXUNo9ttSN+5h4fA/pAa4lS?=
 =?us-ascii?Q?d9xCa/LAnJMl0MV/I+OwOPwwci5NclnweQ2zZlLh+qllaQr5ndJKZ3iD3OaR?=
 =?us-ascii?Q?B0I3qDZpbHvXRqCaWsuEmIRoPuofl+yvJBoVr1Jo5RualYizuXZmr4A8DKPF?=
 =?us-ascii?Q?p4dT6kZXHDzJHhS75RX49T36GMGN3kpD3s3G4E67CFLckOsZEQ9AL83+IZcm?=
 =?us-ascii?Q?8JTosn1kXqCEmngr4+Q0K9+R3s7H6se1meouMM7S8mQ+rKKOomo6x+AqjcmC?=
 =?us-ascii?Q?+R4b3I938D8St+ewv8BJjqW3nTCqoRnJx2S5zkEuO4QaMqZrg1ePJWOQoeAq?=
 =?us-ascii?Q?VW1ajwOPcoFA10JgcDbYeqGNMdo5kXnOcL928mJi3CsPE+q3kb1VM6Hr00jR?=
 =?us-ascii?Q?x8IlKreIA378mgDeqs4dFPj2jsjHyuE8+YXhWIj8O0h8774m7luoIy+MBo8j?=
 =?us-ascii?Q?xB9EYBqc8ALuzlzdaS8PHG8FdGuMejM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da62902f-5834-4f76-fef5-08de59a03fcf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:13.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ila0I8/5nCuXtGxFpb9m+FnkdGzi+NRUVVFywfvxiG8aHQ3vVoHlN8T44jmcAoYoTbcWTcjs96ZU6MT+p9GktoYmCQ1gO1cmIQEETXriWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

Ensure that any pending in-band IRQs are processed before returning
to user mode.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/entry-common.h | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index b28ccc6cdeea..c56e2597ea01 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -7,6 +7,10 @@
 #include <asm/thread_info.h>
 #include <asm/vector.h>
 
+#ifdef CONFIG_IRQ_PIPELINE
+#include <linux/irqstage.h>
+#endif
+
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
 {
@@ -22,6 +26,30 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+/*
+ * This is an ugly hack to fixup irqs sometimes getting lost in the log.
+ */
+static __always_inline void arch_exit_to_user_mode(void)
+{
+	struct irq_stage_data *p;
+	unsigned long flags;
+
+	if (!running_inband())
+		return;
+
+	p = this_inband_staged();
+	if (unlikely(stage_irqs_pending(p) && !in_pipeline())) {
+		flags = hard_local_irq_save();
+		sync_current_irq_stage();
+		hard_local_irq_restore(flags);
+	}
+}
+
+#define arch_exit_to_user_mode arch_exit_to_user_mode
+#endif
+
 void handle_page_fault(struct pt_regs *regs);
 void handle_break(struct pt_regs *regs);
 
-- 
2.43.0

