Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F993D5244
	for <xenomai@lists.linux.dev>; Thu,  8 Jan 2026 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865579; cv=fail; b=LFLpi02xJVk52xuYO+QRghTcz9X31xbKpBNhHN3/dE2EjyqsASY1cn/pE7hMaq2F1NCMvLP+ffWRWywtYUvn1lngi4l4I1pNAugSqViIhczc8zJXGVtrmHVw4j/3b5C7sz23jjPCf3fcuW4Y+IwM7Z7k30DLLcO9TnlQTuAeTTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865579; c=relaxed/simple;
	bh=YiWBb/ORCyMqKmZdgYUL5wfYgBhlRBbGLedf0tjjWFI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hnR1eESM2y8EQ1TVLICP4eeYDbNVIvKdOm9ZDdvF2YCqcf/ReTbgaDKDZeDiIpesjc1wlLv6ydOFIIRtZubx9o2Mn72eDyPJ4cVUZslQKY5mYdt94y8wNNcdit0UG6JEPxZQBJDdrp0kciLpWh5xTaypW/ruT6ywrbG/C6QqddQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=D3SMj5RJ; arc=fail smtp.client-ip=52.101.83.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="D3SMj5RJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wrd7m3AmWutKHQQUxhWOM0II2r1fYB43j7dVBe1e7l2f5eMZjH0b3Mpk3NZhRuk74/6srcYNTzleVzetMgsgAsaTYTu+cT7HVcfvJgUzdC6PrFpD7P+SFonTl3W2FZccyVLknvsfZYjCB3/uhyd+dj/GJKtvv6b3ecxF3T/hG9HNyaFH/cSW+8PPgQMNxPJ7sNpnNrRf75wNJiBpR+VQ/if3RomqLW7+Fa7HoSHiL8EbGcDZqPy6LsGFY4dvCVHxFN7lVMEu45n/M6t6rrUG268tHtHi3QfDKB2Tb+YcAZjsGiKmG2kxrAWHXYlC+jY+xP0NfpU7qgOcOo4yRQiIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqSPl5SVhb2AvW9bzVxccqk/7+7Rn/zlZ1qp+uy3pRA=;
 b=tUfwb1ZyPTz5YZcIA7pxfGyAL81QT9WgJyQtGM3OcAAlNkWMn0xdvSLZZWlcsEcS5OO/UPAx4S0uleJDgwUKx81VsQyB2Qvsqwg9acxGME8/bXNu7A1vJabO/739suucy6yA4dlr+M0CN4dQNooZQv0oi0C0qsDPCmuyMeOJf9xXaLimkPH9ojXVx4YIExO95ODeR1oLGUCNtQy2yOSmCZDNgpGlJmUwEuq7qr5HXh0/JE17PmaE0myHHVC+ZsqI0wKkOHFQE0mrFY1Vly4+6ABewAIneKJHUTYg9Slpds+A/vbs5fLwz5yQuTBlEvW4BhaAzZiN2DKpVzKrg/e61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqSPl5SVhb2AvW9bzVxccqk/7+7Rn/zlZ1qp+uy3pRA=;
 b=D3SMj5RJIrN+Tm6cC+f9wK4aIxgeJwigVhcZJ6EMbw1wiLFLe4SwemprkZVkPjybBqJVPRm+RQ1Bf+005Z0rzVE5rNODTQcHUIQvzcJ56EY7aeK/5dmqwafUBwE9YRdd0cgyfioFWuOFZWI+5i4TUL8y6X+Fr3QfpMQ68DN8H6ENpryx8s+Wc9T6iVsdSZA0qcO6JtgNrvsSY2A/8pZDrRdtZi0EBjW66xFHi45MnOxEJjUmHJw60kkJOIBohNvwqvvQipnmhAbSyzW3lmVYJjZxvnXiK/IXy+dQW//gQTXRq3IjSxeI8su5s9DY9+B4wMzezey+gUpj8OqEUrL+Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB9328.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:46:06 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 09:46:05 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH wip/dovetail-riscv] riscv: irq_pipeline: synchronize IRQs on exit to user mode
Date: Thu,  8 Jan 2026 10:45:51 +0100
Message-ID: <20260108094551.92100-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNXP275CA0005.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::17)
 To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 7968a4c2-6823-4286-f964-08de4e9abe03
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1OoKtGlqewySDDoyfSoJMfxOxqiIa2SoxTWpQNK4u6NfOuDUaFeC3q0RRCEF?=
 =?us-ascii?Q?70ctc6TBgQvss/O9gNIGYwp690sO1M7UIYbb6zvc5KfSd35JO/wHccbEx/G8?=
 =?us-ascii?Q?L4pUksVWAGlD7KKGpnjONcbeXUyLsTVKK118Kr5BOkm+RRDE43YMPgp/G+FH?=
 =?us-ascii?Q?hz82r7bm98JVS3Hn6+fLjKX4BqgXZt+ch5OSwqd0iCMHFd4kYmXYRJhuxh89?=
 =?us-ascii?Q?ozAtqX9uWlOa0WEApX1eodrUgEjLqyNegApP4Efz7Pudu/RCG+Xdn8zh3N7Y?=
 =?us-ascii?Q?sfsAr8f+KO+z2XG4WnzjazKRcsr5dWVPjoicAwmHI147hL5XfkNv5AQXUMPm?=
 =?us-ascii?Q?8hH6OnuoTzOadgD8qoBYk90dVRZ+swwzqwjMGdE0ihyrIH0L0X1CFi//nkDL?=
 =?us-ascii?Q?ZUC6WZIOvyw1h6WEO8KD6Vho/VjHELwID/vt1Is5GfxVe3QlpL443AM5wg5G?=
 =?us-ascii?Q?0AP8d8MGOYNwUcuzSgWF+QHrLjzvfx7Yw0X05tbitOQJZArKBJHJGcA2p0aq?=
 =?us-ascii?Q?B479QC81ZNpavBdmOMcNMGyfCQxxzbVpW/xT8SWOogo8+QTqh4TPYS6u2dY8?=
 =?us-ascii?Q?qwyX/SV0x+2190oenP+vynD9exE/L7zvm6EHzNFGgW68AnizWwv3mJzeUQn0?=
 =?us-ascii?Q?j5vqtTdPCu5/JNqG7ieFQxPnkHa2lYERVzd0seqaaD7JBJiHvBEmKcwGXffV?=
 =?us-ascii?Q?UCMrMtAEgGaEWLrrTzIizimEDyO6nbmpS3xCx2Ph+Wyvm3mqvjc0O4nSJhDV?=
 =?us-ascii?Q?Gy4o1oDlj61xW/dj8+aNSKgTpbH+Jbh3arp8ckWzzmcaSjCnEOSPKM0PC0IF?=
 =?us-ascii?Q?rO3zvnxsTtSIKbCFNf8grzcAb+nh8vUlzvh0no9SE8znxy6/0n7m4Ymfto7+?=
 =?us-ascii?Q?bLTNKjEMaabtW/tY4gCjSNtWa6sEZP0sxx7GckqtsHMNATzDgbrJjeDFHbR7?=
 =?us-ascii?Q?j4cSe2VthqcxLWrJQ9mOCggckxnb275B2/1mfze1qCwc158A+fO4jFcweGln?=
 =?us-ascii?Q?cn/VAFpx2y0yfo8OrhczjuNH6NSPq4OMl7MkLGu3x+XXn5FMFcUerxkV1zDa?=
 =?us-ascii?Q?XCWuGsPj2xe/twtPqmx7WcQ4va1Z3FZXx4mb7EBE5otf+x5RqH1xDdY/U1ME?=
 =?us-ascii?Q?DkstCNXZ6jGlV8aRyrfwBhGq1/JXFgj7IN+L2FzbS/lfUMLXjoTKxCnaJaV7?=
 =?us-ascii?Q?jLvdDDS9PJk6QIFYxWB6cuvIab/fLNzw9+54cwcIjcLaSyrYhktYxfwStVd3?=
 =?us-ascii?Q?NZFuA522GfYxshtlA8E3UWiGwrlXbWqm6wpBWuaFJQ18TS+78m4fLB2MK9ex?=
 =?us-ascii?Q?Weexar2F+GAkuzHoDpKBHnSjIJ1xkdLwHTU+ss//cUW4nRv1i79sDCgQEe1O?=
 =?us-ascii?Q?Np0wTLhJ7hklLXkktYTxd0IWG24yDcJ/k9AOThDUUcwvikZRM70FbGSbwm0b?=
 =?us-ascii?Q?Af8GxYXMqUw7zEDjeDgCe7tyoObgKbBz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OsSEFmjpO9mh10eqB7a2URcrrJ8y5QlZTo+DADH04k8ZFyI0c8VCWFiVuWcg?=
 =?us-ascii?Q?m2fAJNMSbzlSzNLfX/o6ViaeiO2bPG01P+zpZjKlb6k5O6IiQ7rsS8dGaLSB?=
 =?us-ascii?Q?CiSkZxEz7wnuMbOPTODcua6f8blktf6MdLbn5IrSMzbtzBmA1i+BpwO56e75?=
 =?us-ascii?Q?ejmJh9DNn8W4nfBpLox7wsLi8thm61K991BxonLP0+1W87s9Vskxi7B6duqb?=
 =?us-ascii?Q?ULx8gvX0FDTLvX9M9tRTgyIyUwuvUWr2no60Z62HmvPtC9aJ7RAMJLxDQG7l?=
 =?us-ascii?Q?er2T4I1PYkPdHOwNF5009Ixli3TDYXUcMcg+bwDCY0stZNWq9NGehHHIyZcz?=
 =?us-ascii?Q?blUjtH68y4IagG2OakRSDsUhDM+yXoUSRXr4okDb5rkcANIM8WZ02uwegM/l?=
 =?us-ascii?Q?1szCL2OhfO7s2A0M09D59BdbtqW6gZg8pIvgLZxKDmsUUkz5RGatAsO64aoa?=
 =?us-ascii?Q?yoz7LngknJnTWq/eVVTlO3fyzMTOZWwScnRF9wi7eSrsPFnG51pZARFfBhWt?=
 =?us-ascii?Q?n9DjahkywJ40EVbVjifDFyQJITShQAK4wevJbK3r77UujUTTrx8YZE699g4a?=
 =?us-ascii?Q?foLCf6EmfS5CZ/T2zSINcWhtrgPkZZ9j7ci9Aru/2yZuU4yuUr1clnlVVte7?=
 =?us-ascii?Q?u2OQw4aZIJqwni41Cqboa2LRgXJXVnNw6j0fvk7DaeRwtlW4R887/onsGlh8?=
 =?us-ascii?Q?V9nzBFIXhYbdyVnovsf8UiwhsXg/cUIBAdufiX10FPAa+SwwrirRygL85cEU?=
 =?us-ascii?Q?TxfOn7hNi4KSabdBmJiq0xuXYbr4NcLqrPK6g9+9wt9MK3b6g8JuN4b3FMsr?=
 =?us-ascii?Q?tQB884vH1Zoa+NcTSCnHZ+vst1AKN2beITCvHkdhykU5WDy/hGjOsjtnZDQ4?=
 =?us-ascii?Q?M33z9++rku4PD3rxkJLhqsgeOxaB0IPYgCvLLG9Olt9FJkUfXUuFRMiE8YnO?=
 =?us-ascii?Q?ubq7Pf8WJbD2ffS2lKATLdZn0yy8Uf9WVd0G5wncONCJdbuJmk8edzYfb1Ys?=
 =?us-ascii?Q?OHu4Qn0O6iAZQaTOEiR/8euNen270lwU/dqA2Jxjg8dBb+8L4vkdxGHzdAhy?=
 =?us-ascii?Q?YQq4gRTaGGOG0Z/FLRKmUUp7XJUg4Bl7BzQLC5xfLc0jYfKGIxFWLkZp0XR5?=
 =?us-ascii?Q?kOlHYlLQH8C5KitaT0KilNkAQcrIKYkg8R+rbif7BlitN4xPE0I8o7Mqh9ZJ?=
 =?us-ascii?Q?AUxhw3ueAqTADeGA6TTZFlrEgw/BoeprFi2UQ3sIhhtvDX1iD7tQh0viKTig?=
 =?us-ascii?Q?nW76t0Y8WxeNknh954l1IIFPZ/J20YtLHUs9yn9RsG3dBMSBQJE2P+qrKvNm?=
 =?us-ascii?Q?L10tualy7yWiuMSeGZZeJcEXfzNuJv+2i4qYRetKl7juts66UjMVezvSOYio?=
 =?us-ascii?Q?AXW7SVOiFvBJGnO3LUZTLjRDtKwQkRA2pHlMl/58z0y59Vofbf5F26Di4cpt?=
 =?us-ascii?Q?eRJeUeY6DGOGWzaYp86TV2Ti9ALhHiPvzWLDQg22gi/hiC/o8WvvYt7/BJcj?=
 =?us-ascii?Q?aZsLAAZLwYujAFqpTWwxYfj56CvtNW982kRpZT2X8IKEjGgfNdvxqnKQFKBV?=
 =?us-ascii?Q?gYHfLiFqkQuXoaERTnevFhjCWk/eMSnNV3K2xScq0miW2Vjb0AFVM+dAbLdN?=
 =?us-ascii?Q?dwMwv3dK6Dfs1iMr+ilhzqhsJ8y0geo4ZMpjdkfxrHxnr9kk/FjBLqZgn5wA?=
 =?us-ascii?Q?UkqXxKvifdnBiyJq6AK7aNT+OjhZbh6IOre0Tz9GNoZaqLg7AwCS8gYuJuUh?=
 =?us-ascii?Q?fv2RtbIZ32fp/tfUndZKhbe72wmXQ6I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7968a4c2-6823-4286-f964-08de4e9abe03
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:46:05.6288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiF8Njs9AinfL5BzBStM/hL9JSHUUystIVHS2Fxm2IoGccqM3twn+wDgiG/tkJsu2oB9Rr7LBvIRGqC+BzeazWCCwt8iTifZFKqLDArCas4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9328

Ensure that any pending in-band IRQs are processed before returning
to user mode.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/entry-common.h | 36 +++++++++++++++++++++++++++
 include/linux/entry-common.h          |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/arch/riscv/include/asm/entry-common.h b/arch/riscv/include/asm/entry-common.h
index 2293e535f865..1f6189413a19 100644
--- a/arch/riscv/include/asm/entry-common.h
+++ b/arch/riscv/include/asm/entry-common.h
@@ -7,6 +7,12 @@
 #include <asm/thread_info.h>
 #include <asm/vector.h>
 
+#ifdef CONFIG_IRQ_PIPELINE
+#include <linux/context_tracking.h>
+#include <linux/irqstage.h>
+#include <linux/irq_pipeline.h>
+#endif
+
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
 {
@@ -22,6 +28,36 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 
 #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+#define arch_exit_to_user_mode_defined
+static __always_inline void exit_to_user_mode(void)
+{
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare();
+	instrumentation_end();
+
+	user_enter_irqoff();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+
+	if (running_inband()) {
+		struct irq_stage_data *p;
+		unsigned long flags;
+
+		unstall_inband();
+
+		/* Check for pending IRQs after unstalling and sync them if needed. */
+		p = this_inband_staged();
+		if (unlikely(stage_irqs_pending(p) && !in_pipeline())) {
+			flags = hard_local_irq_save();
+			sync_current_irq_stage();
+			hard_local_irq_restore(flags);
+		}
+	}
+}
+#endif /* CONFIG_IRQ_PIPELINE */
+
 void handle_page_fault(struct pt_regs *regs);
 void handle_break(struct pt_regs *regs);
 
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 1d15bc4ebeee..2cf32471f784 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -419,6 +419,7 @@ static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
  * non-instrumentable.
  * The caller has to invoke syscall_exit_to_user_mode_work() before this.
  */
+#ifndef arch_exit_to_user_mode_defined
 static __always_inline void exit_to_user_mode(void)
 {
 	instrumentation_begin();
@@ -432,6 +433,7 @@ static __always_inline void exit_to_user_mode(void)
 	if (running_inband())
 		unstall_inband();
 }
+#endif
 
 /**
  * syscall_exit_to_user_mode_work - Handle work before returning to user mode
-- 
2.43.0

