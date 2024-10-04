Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01851FAC2E
	for <xenomai@lists.linux.dev>; Fri,  4 Oct 2024 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068810; cv=fail; b=WtvuMtF9RKeAK+K8Ke9EgIUIdQrys8HsifBk5wMNenR4yDZBM+ZofUkMA4hSkO9UhQsgwgjpk2oo5Fr5g6flpRoCfsBKEuRJ+U4fALIgpSuoFe1LT/rG9p18t2/OrMrf5xVrkpeYR/dy/Z8DbnKZC3IvPMKF4mUIr5t9oBEGKmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068810; c=relaxed/simple;
	bh=lLlHUgz7HuHyQILHdeCKbvCZ9TM7gt1rMR2EQk4moR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fiAd+7wKj3Vbo/psZZEFKxvmiCqLpPE3LlymC2cqdpZ/nBOIUQVax8B0ABs5prUNkdls3xwMTLYnzgjUGvuBjRB6g96hw94VN7lgKaRRH9l3bWSxPHdbQn+MeU6gOj8/obtSrXATsjBP9LhJvjHD762LWry3u78jBkUEUiWwF38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Y0heSrCd; arc=fail smtp.client-ip=40.107.104.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Y0heSrCd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FYyxxJUvOC3Y6yhQKOinA+fft5IHv/giKoiH/dEr0lwITwzIq921ifZBt5bS0IRl2Z/5+bjUpbI1dzuTMQjPAJ4Up210GX+CQZg9Tgfo54TUIv2uSo1E31WZBAfFQgRqcqeP5Yajh6RFaUs6nADUE07IReaJUsRhwtdjh/nmPE0VSRq2+NhgNoK8dbHvvLvWmFgZ5bJzPN/GgOi4/ez4AmFTRW2+GPM+n7hkYbs3VEPwosRFhJAU2TQ4S9bI65rg4WccEjEPSeQwjyRGJkwcHtLAzpWfkE0v4Ao8h8AE69QwdbffTMllrzyZfHOaTJpO84TbM1ipHNi2bPaCGg5nWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTz+6t2eaMibzrtqkEPEU/X1dZMwPLO9InN+URg+0F8=;
 b=McNG8P30qDKpq5xUlOn207KD3rr8bq3IGAdzjbjNdzEbN92PfKXKznRs6vuBp0Ryio8pLnUSPy0sKRsViLfdabDnSU2oze7IeQK+X7ZfzCqMHF0hCxcewlsaOn5iZrBZe+U81STnBTYMGl9UF3UTQWXT6Cv73j2beFBVoZsNSfWFZWPnn20DjA5CGyGbho4toSFG2EfLaDUgK1fcph8J8oaM/+UBxhqjDu/aBbMLKlNxoOMCUckBxwcfL7TA5pEzfgXxW5kkI8N+fQFO3SPMXMCHiDmj1ZGkk9e6wtlmzFE4/8ApbcULkXQNe/brZWZgWF3pXw1lx9G70Iddr1zaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTz+6t2eaMibzrtqkEPEU/X1dZMwPLO9InN+URg+0F8=;
 b=Y0heSrCdjpUhXyJNRfbOk/yLNt2nDZM2GJ+zBO+zp0pK7ka1bTFWMS1dpAcjggW2lp12maV7/Hh+uMz/rmxeNBF4nHxvcN99uuosDysQdTOULlf8HRFXM/NLypchm9LfVPNKDDi2dJrOcREtkdcZYCRAeXHh4srkHYlLQFRL/4Rf6D79Au00BQVJXstkKi1Z+ZZr8zwM/Njex00LMznmI7vN/mM0xyn5rRiwz3urVSGXfc6buR7ej9Ew3omOXQnuYhnQvhYMw46NnODP/Gdak936ODX9SLe6v/NwrPP2K4oBqyzcA4kX3c1isSHeDJcHGudhHi46v5XnHZaTvvgoIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GVXPR10MB8343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Fri, 4 Oct
 2024 19:06:45 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.8048.007; Fri, 4 Oct 2024
 19:06:45 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 3/3] RISC-V: irq_pipeline: add IRQ pipelining core
Date: Fri,  4 Oct 2024 21:06:33 +0200
Message-ID: <20241004190633.1814057-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004190633.1814057-1-tobias.schaffner@siemens.com>
References: <20241004190633.1814057-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GVXPR10MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 7210ac29-a660-46de-087d-08dce4a7b0ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tkABxhN00ICuhXYZSSrpacw/uhWM9OJTbalpS1GFWkFGFhi6XEgDcwYZ94PU?=
 =?us-ascii?Q?lXe7k8pd15r6Vuk8q1tzzD8XwgowgjRJGoR5+bNYNkCJHej775pOsOcVjGSx?=
 =?us-ascii?Q?UB+XoNBHDIKyA9PK+LLnss/rwflScPuP56pdf1t5TXZ0b8fO+qVBRmsCDCRX?=
 =?us-ascii?Q?ZrVWOCXysUY3agP3WgNVFPqj8ZHL0gTIVTPkVYCvNTQ6/E0YybT3X/HCUecz?=
 =?us-ascii?Q?UsIWAuLQsg1PGueAsdrSifAJHlTEZPm87w1Aad+phP9D3NACkHLJNJ4a51B2?=
 =?us-ascii?Q?qiza7wsIYSBa5dOh2hQR82yonmX63GitHDTb4sO2XXZZ4qyzmlHviY6zfFeo?=
 =?us-ascii?Q?AQu9kDHGa3pDR567OUfvrSQTmfg1Bz/ZElK8E3Gk6k7yFkGq1Fo0TD6Zd6RH?=
 =?us-ascii?Q?oIueLC6eGcT5ExbHhwyZEnAEVWscJ6e8Rh1a0M97iTfH3b+/oX3ZkTbfxSAM?=
 =?us-ascii?Q?ajx3rgVitJadm7cTxhUFK1gfFoSKmxxjI4sPCmVBc1L95akCXezcH+XFIhCv?=
 =?us-ascii?Q?qGB9WDHNykyas+2h136SpOVcs4wWtCiMDv6oh0YcKxujWZGxWceM5wdy6JNe?=
 =?us-ascii?Q?843J9aN+DtS8bXo4fviaH0U8qQ11FR8mvrJfVV1LLD4wr27jmCX++Zsj/OBZ?=
 =?us-ascii?Q?EYZ0QEAw99ax+yt74334RiDQ7urervRZVcoT6J+GLWFaepFKpTKoGbppVReI?=
 =?us-ascii?Q?NiJi6z2gtpIl8bLdY63b0QCbcpvQ9mUbvle5iCzamwmyYxDzBiyidaeUraJf?=
 =?us-ascii?Q?HbsxeQe17bYFiv//7swGWUsORv7tLi4THVvAVQwGtebtOIvusk/ft0hly7N/?=
 =?us-ascii?Q?BvMQj17txDjH9SFI0CIggQ4k95Vk5wAzooE/3A+Fra3KaruPiNjPz+PrXk/+?=
 =?us-ascii?Q?upFYL8jDq3gSysp+7eRWRQuluXp2H5h+grEiwSUvSupV1fDdnds/JQiz6h4N?=
 =?us-ascii?Q?NU+DBPmdHYrNFSpsD8si7pkiYu4Hf5AJ0OX2e3vVnVjk6vwJu5KGAn+MivoE?=
 =?us-ascii?Q?kHIGYD1PsaAlQ4VSDmy8xRePbqDnoyFJyEm+bExySFlDK/Nk9050cn/Me0iD?=
 =?us-ascii?Q?TMJ4hEHCPpTBJ1k23hZqNqiJVfasgC+rQsQy7VFK2fsCBiJWqPMd/OQXsmNh?=
 =?us-ascii?Q?YWZtuQ+yBbjQ9BLhKL8bDrYwhlM6Bq1A+uUTf3ZXKae6wcDUFuCdjxPJdmwM?=
 =?us-ascii?Q?aJq8Pl/de8V6tsOfLHodUTm+UM9FLBpjCj/GZplK9r/oDV0RaWsOuXnqrzr9?=
 =?us-ascii?Q?EyRVw6PIKWzfKELOkCGruzBbL3UORxhLGz76ZrviDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BqeTst+QsiqX7mTtzWTqSi1FdWvDBVYPkk+CeyHzxZ9iUvwkDi1V4ZUDC6uU?=
 =?us-ascii?Q?cWSWgGm+z47yxsUm5UzpdmcWKuR+W509wJ9QMqMzGjymMsaDWyD4V9GHdnX7?=
 =?us-ascii?Q?IpGHO7vSglXb/6YrPmOyDOeRrAr1bfBZ4VvzxIakyDp3rbMaPqbuK8CncnCq?=
 =?us-ascii?Q?YTnb5mEFNiXbirhjXfR3HMXnbJut97FBO9dXTR+cifdT03tLMotBRbAaLdlJ?=
 =?us-ascii?Q?jzAh1bZ77AZ0F7WhO45rsUW2p0rDk9oRrS0oyCQl9ap2yzwvUYyK8HQPQQGm?=
 =?us-ascii?Q?jn038gcwFP/2A5J6MSJFD/aeWIW9DQNMtojNIuL9pKh+V7xFwIpK/kIhhKqh?=
 =?us-ascii?Q?Qi06/yfxfLhz+PIY+QlNHKbk0WhJKNr9hHq5cv5cnZBmX3JKkQ01Xs2L6fjF?=
 =?us-ascii?Q?uTDwl9TQznpug3HyfEFbvWbpP/ZJyN8fyABMcuAAcyBdYHOCH9B9Z0tULc/U?=
 =?us-ascii?Q?4rJSk0hEHLCqOmdchwD//KrE786UIikGxmIEh2uIoIy472SnG+xXQqSk7pT6?=
 =?us-ascii?Q?+v6SFUaIYPJBu4XHKqm1Qe/NoHBDsVWkxB8YAo7D4YgmTeIYavvn7/wQUaK7?=
 =?us-ascii?Q?5UyMi7kybGoQvYxCS/fmPEdLDNl+OfZKqOpbDAfT/2ixPwzFb2sKNVEm1MuP?=
 =?us-ascii?Q?eMbI2y9exAvHlMk21rPDHMbpTvIj2WyhZS8jAhpE6pfqt0RsM7Z8zqG0KGzk?=
 =?us-ascii?Q?k8V9fdOAF+ubDHETPtucFk2lrtCzHdnQvmSi2AX93Dfhn2m0yNyQcBeElsym?=
 =?us-ascii?Q?bVK+8K8qi51iDQ4fZj/eeVKKVat2casogT1B2YMESqPciZsuWiF2EmhJKs8v?=
 =?us-ascii?Q?parIE8+cWgyrV7oSSLzHnEKJHwG+8tqfnrY2lOiIatrjUyDEXR5bEPHcgeyF?=
 =?us-ascii?Q?8ua/ioElw8KwzNAYFrK0jWCK9eoG0ac65je8/VtAIo7S9rNfN9HyAFxLVm2+?=
 =?us-ascii?Q?mkiqv6xZw/BHtNgm4BIoiXsnMpdhyhiOTqP3KpXHiRGe36IC8LNBT1D88DC4?=
 =?us-ascii?Q?01lfTKZMp25/DhW+erTnrpnZ2bVUR5jhyLpBiAv3Wym+qnCF/CzkeSOA4cQo?=
 =?us-ascii?Q?CXEwUmAWedu8/up+zuA2OIfAKQgXyffbuDc8cnWc8hX6BOMSTI9iU+UaLefo?=
 =?us-ascii?Q?baeubOCbuPcvgs358c4+TBVyNDfGatMKjOvFPxLvQqdPbD87g/u2CgjZI7/W?=
 =?us-ascii?Q?LecOubOfTVtKvUhzwpRovja4vGp3AeefBFg/vPp9SYsbhWVzmo22fV/4W86c?=
 =?us-ascii?Q?ZVa7ws2oQpWOJ0rO4lBlGIpAKA+13lG38LbHUimG2V0tnwVC1F/YFR6A8L0q?=
 =?us-ascii?Q?mc+xsARvuhVUDdmPYHrtxGKcXcNh6RLF1VlFRr/hNZ5UOF5o+aBXXqu3bjew?=
 =?us-ascii?Q?av0VR24srDlOWrGYiX2k+GnRDNylms/L+f9Nxa7uaaSn6GFdGTyUxIhYoKKB?=
 =?us-ascii?Q?fRmtlVu6Sx76r1eHOnHsKE0tnmuTo97x0/SkJ+euBwJ/z4Qd15zLSsStlBwd?=
 =?us-ascii?Q?C6Kzw1Ghz+/yarGMpFg5B6UHkT43Nc8VLNqDLUNOl3oP+jr8te1FlUoPCL46?=
 =?us-ascii?Q?MtiEZSTHL5s5peuOMlrdpYGf1XkQOimSsquFLLFmgm7gHHYU2SuFdu1A9I16?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7210ac29-a660-46de-087d-08dce4a7b0ad
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:06:45.5624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWbZ2fHdJWubdVO1jMSTk6A57iR2zz+JyZmiv208osMbFeu1U22op8I8nSXVrrWWog4DL5f423Jr0FKBQGRYHtQ0AVBW2zuWCs8YjKmj+G0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8343

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig                         |   1 +
 arch/riscv/include/asm/irq_pipeline.h      | 143 +++++++++++++++++++++
 arch/riscv/include/asm/irqflags.h          |  25 ++--
 arch/riscv/include/asm/thread_info.h       |   8 ++
 arch/riscv/kernel/Makefile                 |   1 +
 arch/riscv/kernel/irq_pipeline.c           |  26 ++++
 arch/riscv/kernel/smp.c                    |  93 +++++++++++++-
 arch/riscv/kernel/smpboot.c                |   2 +-
 arch/riscv/kernel/traps.c                  |  51 +++++++-
 arch/riscv/mm/fault.c                      |  83 ++++++++++--
 drivers/irqchip/irq-riscv-aplic-direct.c   |   3 +-
 drivers/irqchip/irq-riscv-aplic-msi.c      |   3 +-
 drivers/irqchip/irq-riscv-imsic-platform.c |   3 +-
 drivers/irqchip/irq-riscv-intc.c           |   2 +
 drivers/irqchip/irq-sifive-plic.c          |   3 +-
 15 files changed, 411 insertions(+), 36 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_pipeline.h
 create mode 100644 arch/riscv/kernel/irq_pipeline.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0f3cd7c3a436..d9ae490e015a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -131,6 +131,7 @@ config RISCV
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
 	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
+	select HAVE_IRQ_PIPELINE
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
new file mode 100644
index 000000000000..66f141ea23f8
--- /dev/null
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * IRQ Pipelining adapted from the ARM version.
+ *
+ * Copyright (C) 2024 Siemens AG
+ * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
+
+#ifndef _ASM_RISCV_IRQ_PIPELINE_H
+#define _ASM_RISCV_IRQ_PIPELINE_H
+
+/*
+ * Multiplex In-band IPI messages over software interrupt 0
+ * as we do in the arm implementation.
+ */
+#define OOB_NR_IPI		3
+#define OOB_IPI_OFFSET		1 /* Software interrupt 1 */
+#define TIMER_OOB_IPI		(ipi_virq_base + OOB_IPI_OFFSET)
+#define RESCHEDULE_OOB_IPI	(TIMER_OOB_IPI + 1)
+#define CALL_FUNCTION_OOB_IPI	(RESCHEDULE_OOB_IPI + 1)
+
+extern int ipi_virq_base;
+
+#ifdef CONFIG_IRQ_PIPELINE
+
+#include <asm/ptrace.h>
+
+/* NOTE: Any bit should be fine as long as we don't hit SR_SIE or SR_MIE. */
+#define IRQMASK_i_POS   31
+
+static inline notrace
+unsigned long arch_irqs_virtual_to_native_flags(int stalled)
+{
+	if (!stalled)
+		return SR_IE;
+	return 0;
+}
+
+static inline notrace
+unsigned long arch_irqs_native_to_virtual_flags(unsigned long flags)
+{
+	return (!!native_irqs_disabled_flags(flags)) << IRQMASK_i_POS;
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return native_irqs_disabled_flags(flags);
+}
+
+static inline notrace void arch_local_irq_enable(void)
+{
+	barrier();
+	inband_irq_enable();
+}
+
+static inline notrace void arch_local_irq_disable(void)
+{
+	inband_irq_disable();
+	barrier();
+}
+
+static inline notrace unsigned long arch_local_save_flags(void)
+{
+	int stalled = inband_irqs_disabled();
+
+	barrier();
+	return arch_irqs_virtual_to_native_flags(stalled);
+}
+
+/* test hardware interrupt enable bit */
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
+
+static inline notrace unsigned long arch_local_irq_save(void)
+{
+	int stalled = inband_irq_save();
+
+	barrier();
+	return arch_irqs_virtual_to_native_flags(stalled);
+}
+
+/* set interrupt enabled status */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	inband_irq_restore(arch_irqs_disabled_flags(flags));
+	barrier();
+}
+
+static inline
+void arch_save_timer_regs(struct pt_regs *dst, struct pt_regs *src)
+{
+	dst->status = src->status;
+}
+
+#else /* !CONFIG_IRQ_PIPELINE */
+
+static inline unsigned long arch_local_irq_save(void)
+{
+	return native_irq_save();
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	native_irq_enable();
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	native_irq_disable();
+}
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	return native_save_flags();
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	native_irq_restore(flags);
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return native_irqs_disabled_flags(flags);
+}
+
+#endif /* !CONFIG_IRQ_PIPELINE */
+
+extern void (*handle_arch_irq)(struct pt_regs *);
+
+static inline void arch_handle_irq_pipelined(struct pt_regs *regs)
+{
+	handle_arch_irq(regs);
+}
+
+static inline int arch_enable_oob_stage(void)
+{
+	return 0;
+}
+
+#endif /* _ASM_RISCV_IRQ_PIPELINE_H */
diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index 6fd8cbfcfcc7..839aaadfc036 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -10,45 +10,54 @@
 #include <asm/csr.h>
 
 /* read interrupt enabled status */
-static inline unsigned long arch_local_save_flags(void)
+static inline unsigned long native_save_flags(void)
 {
 	return csr_read(CSR_STATUS);
 }
 
 /* unconditionally enable interrupts */
-static inline void arch_local_irq_enable(void)
+static inline void native_irq_enable(void)
 {
 	csr_set(CSR_STATUS, SR_IE);
 }
 
 /* unconditionally disable interrupts */
-static inline void arch_local_irq_disable(void)
+static inline void native_irq_disable(void)
 {
 	csr_clear(CSR_STATUS, SR_IE);
 }
 
 /* get status and disable interrupts */
-static inline unsigned long arch_local_irq_save(void)
+static inline unsigned long native_irq_save(void)
 {
 	return csr_read_clear(CSR_STATUS, SR_IE);
 }
 
 /* test flags */
-static inline int arch_irqs_disabled_flags(unsigned long flags)
+static inline int native_irqs_disabled_flags(unsigned long flags)
 {
 	return !(flags & SR_IE);
 }
 
 /* test hardware interrupt enable bit */
-static inline int arch_irqs_disabled(void)
+static inline bool native_irqs_disabled(void)
 {
-	return arch_irqs_disabled_flags(arch_local_save_flags());
+	return native_irqs_disabled_flags(native_save_flags());
 }
 
 /* set interrupt enabled status */
-static inline void arch_local_irq_restore(unsigned long flags)
+static inline void native_irq_restore(unsigned long flags)
 {
 	csr_set(CSR_STATUS, flags & SR_IE);
 }
 
+#include <asm/irq_pipeline.h>
+
+static inline void native_irq_sync(void)
+{
+	native_irq_disable();
+	asm volatile("nop" : : : "memory");
+	native_irq_enable();
+}
+
 #endif /* _ASM_RISCV_IRQFLAGS_H */
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index fca5c6be2b81..1ed22edef1fc 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -47,6 +47,7 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
+	__u32			local_flags;	/* local (synchronous) flags */
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
 	/*
 	 * These stack pointers are overwritten on every system call or
@@ -83,6 +84,8 @@ struct thread_info {
 	INIT_SCS				\
 }
 
+#define ti_local_flags(__ti)    ((__ti)->local_flags)
+
 void arch_release_task_struct(struct task_struct *tsk);
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
@@ -116,4 +119,9 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
 
+/*
+ * Local (synchronous) thread flags.
+ */
+#define _TLF_OOB		0x0001
+
 #endif /* _ASM_RISCV_THREAD_INFO_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 06d407f1b30b..f6827b2432d1 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 
 obj-$(CONFIG_CPU_PM)		+= suspend_entry.o suspend.o
+obj-$(CONFIG_IRQ_PIPELINE)	+= irq_pipeline.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o hibernate-asm.o
 
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
diff --git a/arch/riscv/kernel/irq_pipeline.c b/arch/riscv/kernel/irq_pipeline.c
new file mode 100644
index 000000000000..4eeb4394434f
--- /dev/null
+++ b/arch/riscv/kernel/irq_pipeline.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IRQ Pipelining implementation adapted from the ARM version.
+ *
+ * Copyright (C) 2024 Siemens AG
+ * Author:       Tobias Schaffner <tobias.schaffner@siemens.com>.
+ */
+#include <linux/irq.h>
+#include <linux/irq_pipeline.h>
+
+void arch_do_IRQ_pipelined(struct irq_desc *desc)
+{
+	struct pt_regs *regs = raw_cpu_ptr(&irq_pipeline.tick_regs);
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irq_enter();
+	handle_irq_desc(desc);
+	irq_exit();
+
+	set_irq_regs(old_regs);
+}
+
+void __init arch_irq_pipeline_init(void)
+{
+	/* no per-arch init. */
+}
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 8e6eb64459af..61ce611aa4a2 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -20,12 +20,15 @@
 #include <linux/seq_file.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/irq_pipeline.h>
 #include <linux/irq_work.h>
 
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 
+#include <trace/events/ipi.h>
+
 enum ipi_message_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
@@ -45,8 +48,8 @@ void __init smp_setup_processor_id(void)
 	cpuid_to_hartid_map(0) = boot_cpu_hartid;
 }
 
-static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
-static int ipi_virq_base __ro_after_init;
+//static DEFINE_PER_CPU_READ_MOSTLY(int, ipi_dummy_dev);
+int ipi_virq_base __ro_after_init;
 static int nr_ipi __ro_after_init = IPI_MAX;
 static struct irq_desc *ipi_desc[IPI_MAX] __read_mostly;
 
@@ -77,7 +80,7 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	atomic_dec(&waiting_for_crash_ipi);
 
-	local_irq_disable();
+	hard_local_irq_disable();
 
 #ifdef CONFIG_HOTPLUG_CPU
 	if (cpu_has_hotplug(cpu))
@@ -94,6 +97,47 @@ static inline void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 }
 #endif
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+static DEFINE_PER_CPU(unsigned long, ipi_messages);
+
+static DEFINE_PER_CPU(unsigned int [IPI_MAX], ipi_counts);
+
+void irq_send_oob_ipi(unsigned int irq,
+		const struct cpumask *cpumask)
+{
+	unsigned int sgi = irq - ipi_virq_base;
+
+	if (WARN_ON(irq_pipeline_debug() &&
+		    (sgi < OOB_IPI_OFFSET ||
+		     sgi >= OOB_IPI_OFFSET + OOB_NR_IPI)))
+		return;
+
+	__ipi_send_mask(ipi_desc[sgi], cpumask);
+}
+EXPORT_SYMBOL_GPL(irq_send_oob_ipi);
+
+static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask)
+		set_bit(op, &per_cpu(ipi_messages, cpu));
+
+	wmb();
+	__ipi_send_mask(ipi_desc[0], mask);
+}
+
+static void send_ipi_single(int cpu, enum ipi_message_type op)
+{
+	set_bit(op, &per_cpu(ipi_messages, cpu));
+
+	wmb();
+	__ipi_send_mask(ipi_desc[0], cpumask_of(cpu));
+}
+
+#else /* !CONFIG_IRQ_PIPELINE */
+
 static void send_ipi_mask(const struct cpumask *mask, enum ipi_message_type op)
 {
 	__ipi_send_mask(ipi_desc[op], mask);
@@ -104,6 +148,8 @@ static void send_ipi_single(int cpu, enum ipi_message_type op)
 	__ipi_send_mask(ipi_desc[op], cpumask_of(cpu));
 }
 
+#endif /* !CONFIG_IRQ_PIPELINE */
+
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
@@ -144,6 +190,26 @@ static irqreturn_t handle_IPI(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_IRQ_PIPELINE
+
+static irqreturn_t ipi_handler(int irq, void *data)
+{
+	unsigned long *pmsg;
+	unsigned int ipinr;
+
+	pmsg = raw_cpu_ptr(&ipi_messages);
+	while (*pmsg) {
+		ipinr = ffs(*pmsg) - 1;
+		clear_bit(ipinr, pmsg);
+		__this_cpu_inc(ipi_counts[ipinr]);
+		handle_IPI(ipinr + ipi_virq_base, data);
+	}
+
+	return IRQ_HANDLED;
+}
+
+#endif /* !CONFIG_IRQ_PIPELINE */
+
 void riscv_ipi_enable(void)
 {
 	int i;
@@ -173,20 +239,33 @@ bool riscv_ipi_have_virq_range(void)
 
 void riscv_ipi_set_virq_range(int virq, int nr)
 {
-	int i, err;
+	int i, inband_nr_ipi;
 
 	if (WARN_ON(ipi_virq_base))
 		return;
 
 	WARN_ON(nr < IPI_MAX);
+
 	nr_ipi = min(nr, IPI_MAX);
+
+	/*
+	 * irq_pipeline: the in-band stage traps SGI0 only,
+	 * over which IPI messages are mutiplexed. Other SGIs
+	 * are available for exchanging out-of-band IPIs.
+	 */
+	inband_nr_ipi = irqs_pipelined() ? 1 : nr_ipi;
+
 	ipi_virq_base = virq;
 
 	/* Request IPIs */
 	for (i = 0; i < nr_ipi; i++) {
-		err = request_percpu_irq(ipi_virq_base + i, handle_IPI,
-					 "IPI", &ipi_dummy_dev);
-		WARN_ON(err);
+		if (i < inband_nr_ipi) {
+			int err;
+
+			err = request_percpu_irq(ipi_virq_base + i, ipi_handler,
+						 "IPI", &irq_stat);
+			WARN_ON(err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_virq_base + i);
 		irq_set_status_flags(ipi_virq_base + i, IRQ_HIDDEN);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 0f8f1c95ac38..c80673c6e8cf 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -246,6 +246,6 @@ asmlinkage __visible void smp_callin(void)
 	 * Disable preemption before enabling interrupts, so we don't try to
 	 * schedule a CPU that hasn't actually started yet.
 	 */
-	local_irq_enable();
+	local_irq_enable_full();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 05a16b1f0aee..75bd020d231e 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -111,10 +111,30 @@ void die(struct pt_regs *regs, const char *str)
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
@@ -126,6 +146,8 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+
+	mark_trap_exit(signo, regs);
 }
 
 static void do_trap_error(struct pt_regs *regs, int signo, int code,
@@ -174,11 +196,17 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
-		local_irq_enable();
+		if (running_inband())
+			local_irq_enable_full();
+		else
+			hard_local_irq_enable();
 
 		handled = riscv_v_first_use_handler(regs);
 
-		local_irq_disable();
+		if (running_inband())
+			local_irq_disable_full();
+		else
+			hard_local_irq_disable();
 
 		if (!handled)
 			do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->epc,
@@ -341,7 +369,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		 * The resulting 6 bits of entropy is seen in SP[9:4].
 		 */
 		choose_random_kstack_offset(get_random_u16());
-
+done:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -361,12 +389,24 @@ asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
 
 	handle_page_fault(regs);
 
-	local_irq_disable();
+	if (running_inband())
+		local_irq_disable_full();
+	else
+		hard_local_irq_disable();
 
 	irqentry_exit(regs, state);
 }
 #endif
 
+#ifdef CONFIG_IRQ_PIPELINE
+static void noinstr handle_riscv_irq(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	handle_irq_pipelined(regs);
+	set_irq_regs(old_regs);
+}
+#else
 static void noinstr handle_riscv_irq(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs;
@@ -377,6 +417,9 @@ static void noinstr handle_riscv_irq(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 	irq_exit_rcu();
 }
+#endif
+
+extern void (*handle_arch_irq)(struct pt_regs *);
 
 asmlinkage void noinstr do_irq(struct pt_regs *regs)
 {
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index a9f2b4af8f3f..7a09fcfb534c 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -22,9 +22,60 @@
 
 #include "../kernel/head.h"
 
+#ifdef CONFIG_IRQ_PIPELINE
+/*
+ * We need to synchronize the virtual interrupt state with the hard
+ * interrupt state we received on entry, then turn hardirqs back on to
+ * allow code which does not require strict serialization to be
+ * preempted by an out-of-band activity.
+ */
+static inline
+unsigned long fault_entry(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	flags = hard_local_save_flags();
+
+	if (raw_irqs_disabled_flags(flags)) {
+		stall_inband();
+		trace_hardirqs_off();
+	}
+
+	hard_local_irq_enable();
+
+	if (running_inband())
+		local_irq_enable();
+
+	return flags;
+}
+
+static inline void fault_exit(unsigned long flags)
+{
+	WARN_ON_ONCE(irq_pipeline_debug() && hard_irqs_disabled());
+
+	/*
+	 * We expect kentry_exit_pipelined() to clear the stall bit if
+	 * kentry_enter_pipelined() observed it that way.
+	 */
+	hard_local_irq_restore(flags);
+}
+
+#else	/* !CONFIG_IRQ_PIPELINE */
+
+static inline
+unsigned long fault_entry(struct pt_regs *regs)
+{
+	return 0;
+}
+
+static inline void fault_exit(unsigned long x) { }
+
+#endif	/* !CONFIG_IRQ_PIPELINE */
+
 static void die_kernel_fault(const char *msg, unsigned long addr,
 		struct pt_regs *regs)
 {
+	irq_pipeline_oops();
 	bust_spinlocks(1);
 
 	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
@@ -61,6 +112,8 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 
 static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
 {
+	unsigned long irqflags;
+
 	if (!user_mode(regs)) {
 		no_context(regs, addr);
 		return;
@@ -71,7 +124,9 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
 		 * We ran out of memory, call the OOM killer, and return the userspace
 		 * (which will retry the fault, or kill us if we got oom-killed).
 		 */
+		irqflags = fault_entry(regs);
 		pagefault_out_of_memory();
+		fault_exit(irqflags);
 		return;
 	} else if (fault & (VM_FAULT_SIGBUS | VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
 		/* Kernel mode? Handle exceptions or die */
@@ -229,6 +284,9 @@ void handle_page_fault(struct pt_regs *regs)
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 	int code = SEGV_MAPERR;
 	vm_fault_t fault;
+	unsigned long irqflags;
+
+	irqflags = fault_entry(regs);
 
 	cause = regs->cause;
 	addr = regs->badaddr;
@@ -237,7 +295,7 @@ void handle_page_fault(struct pt_regs *regs)
 	mm = tsk->mm;
 
 	if (kprobe_page_fault(regs, cause))
-		return;
+		goto out;
 
 	/*
 	 * Fault-in kernel-space virtual memory on-demand.
@@ -251,12 +309,12 @@ void handle_page_fault(struct pt_regs *regs)
 	if ((!IS_ENABLED(CONFIG_MMU) || !IS_ENABLED(CONFIG_64BIT)) &&
 	    unlikely(addr >= VMALLOC_START && addr < VMALLOC_END)) {
 		vmalloc_fault(regs, code, addr);
-		return;
+		goto out;
 	}
 
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (!regs_irqs_disabled(regs))
-		local_irq_enable();
+		hard_local_irq_enable();
 
 	/*
 	 * If we're in an interrupt, have no user context, or are running
@@ -265,7 +323,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(faulthandler_disabled() || !mm)) {
 		tsk->thread.bad_cause = cause;
 		no_context(regs, addr);
-		return;
+		goto out;
 	}
 
 	if (user_mode(regs))
@@ -273,7 +331,7 @@ void handle_page_fault(struct pt_regs *regs)
 
 	if (!user_mode(regs) && addr < TASK_SIZE && unlikely(!(regs->status & SR_SUM))) {
 		if (fixup_exception(regs))
-			return;
+			goto out;
 
 		die_kernel_fault("access to user memory without uaccess routines", addr, regs);
 	}
@@ -296,7 +354,7 @@ void handle_page_fault(struct pt_regs *regs)
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
-		return;
+		goto out;
 	}
 
 	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
@@ -314,7 +372,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, addr);
-		return;
+		goto out;
 	}
 lock_mmap:
 
@@ -323,7 +381,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(!vma)) {
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -335,7 +393,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(access_error(cause, vma))) {
 		tsk->thread.bad_cause = cause;
 		bad_area(regs, mm, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -353,12 +411,12 @@ void handle_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, addr);
-		return;
+		goto out;
 	}
 
 	/* The fault is fully completed (including releasing mmap lock) */
 	if (fault & VM_FAULT_COMPLETED)
-		return;
+		goto out;
 
 	if (unlikely(fault & VM_FAULT_RETRY)) {
 		flags |= FAULT_FLAG_TRIED;
@@ -377,7 +435,8 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		tsk->thread.bad_cause = cause;
 		mm_fault_error(regs, addr, fault);
-		return;
 	}
+out:
+	fault_exit(irqflags);
 	return;
 }
diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 4a3ffe856d6c..ae0d31f2d32c 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -87,7 +87,8 @@ static struct irq_chip aplic_direct_chip = {
 #endif
 	.flags		= IRQCHIP_SET_TYPE_MASKED |
 			  IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_MASK_ON_SUSPEND,
+			  IRQCHIP_MASK_ON_SUSPEND |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int aplic_direct_irqdomain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
index 028444af48bd..213679771828 100644
--- a/drivers/irqchip/irq-riscv-aplic-msi.c
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -138,7 +138,8 @@ static const struct msi_domain_template aplic_msi_template = {
 		.irq_write_msi_msg	= aplic_msi_write_msg,
 		.flags			= IRQCHIP_SET_TYPE_MASKED |
 					  IRQCHIP_SKIP_SET_WAKE |
-					  IRQCHIP_MASK_ON_SUSPEND,
+					  IRQCHIP_MASK_ON_SUSPEND |
+					  IRQCHIP_PIPELINE_SAFE,
 	},
 
 	.ops = {
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 11723a763c10..1bfb7cc94f82 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -137,7 +137,8 @@ static struct irq_chip imsic_irq_base_chip = {
 	.irq_retrigger		= imsic_irq_retrigger,
 	.irq_compose_msi_msg	= imsic_irq_compose_msg,
 	.flags			= IRQCHIP_SKIP_SET_WAKE |
-				  IRQCHIP_MASK_ON_SUSPEND,
+				  IRQCHIP_MASK_ON_SUSPEND |
+				  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 47f3200476da..2df18b7d36a1 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -111,6 +111,7 @@ static struct irq_chip riscv_intc_chip = {
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
 	.irq_eoi = riscv_intc_irq_eoi,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip andes_intc_chip = {
@@ -118,6 +119,7 @@ static struct irq_chip andes_intc_chip = {
 	.irq_mask	= andes_intc_irq_mask,
 	.irq_unmask	= andes_intc_irq_unmask,
 	.irq_eoi	= riscv_intc_irq_eoi,
+	.flags		= IRQCHIP_PIPELINE_SAFE,
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 9e22f7e378f5..f61db2ae0ca4 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -197,7 +197,8 @@ static struct irq_chip plic_edge_chip = {
 #endif
 	.irq_set_type	= plic_irq_set_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_AFFINITY_PRE_STARTUP,
+			  IRQCHIP_AFFINITY_PRE_STARTUP |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip plic_chip = {
-- 
2.43.0

