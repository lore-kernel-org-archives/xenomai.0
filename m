Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578E2C159D
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 09:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089951; cv=fail; b=bAf5ACNma6KtGT0IP3/GUIInaKIBJ9wz9EZNIbRUZT2O6GhVC5ZUy7Vjf6Y0yHx97Ogyzc7z27RFxKPRR+5YmZAZ5TxjBPY7rZhKvBuOpBCJEpL4c/ckHoqvVBl3pcQhh68dKCwR9+KF9sUYIgt+/G/eQOkQBn1E8AKJD2h5YdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089951; c=relaxed/simple;
	bh=30xq9Thsp2xa50nunc8ZXvwbv0FJ9PRr3nHLyNPBtek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iMG8D9rMQkE56rsGkIh8odJUI4J1Kebiooh4pDzU5fwGoOTMGu/nCbLvWuxNS1q1Ekx2vImEKzMNaaQdfea0wZpUK1f5LQzVyPvUGPmM1BZS6ylQFu9I+DSodhAOAIxqHbe6HEXtNaPkTaYtbUfiotOdGWhBxauDpADay6H1tqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=RglCmKzy; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="RglCmKzy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHCqgfvhfWdGVJhpzY29TCd6KJmOK9lj+kujMhDKbS6DHLPByxZjuhHhC/NMTVZn+Aj2nzmppSKHeG3T6teJPaUaMvH4tueaYSNbZtbdR9GfOEhtw5s3nDcam0R1q9nykRUpIuD6cMtTmKOcaY8HaBdMnzCai8msCJWEFSO4EFMwDnd3Q0VJYeREaPj9ikPimDvZ5F05dUT1B4QnMVgVTxcg5W8Tc0gTEWHymA7t5j/a9vsQuV9hsG4wT4RvzALW2zzIryiQ0gBtIUhw3dUupx1isFukyr6scQ6wzBUOYvJQfla1wBq6QYALV31WFU6AR0b5EHJrFa6fSCiG8L6J1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XD3bKBnLcTWu5PCfjUyWhjjRg0kmMJVKHgkeKTfJj78=;
 b=I61FD/z008n5SqfjUKLKwxVKAEdDSaCLZnfVw7x1v7bECoVfK/Is1NZEaRxRrJAiTuWeiOCxwCXqf7oLl0+Nyxr9yFqKOd3JEwfSbmEdcIgbWi/N4RhoTtPz6NWEn/y1HZ1vNd2Ug7fkadkyQg51aclczoOhcUJ6imceOaBnI1Iz+2+Ju1aYvmPqvLiF1n5Mn9D+s6EAdlKnJfjgBj2NRnDgqjtH13MgDRcWZNb31RStgk6NzOZvms/SqKy4pINDFJFnPoejJX9YMQvEtdBlLdTsKB7J23dITyg7TUVWgVl4m5KsgX1adNAK/qBgdzPszA4Rrcgxvg0a9p6nXqdVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XD3bKBnLcTWu5PCfjUyWhjjRg0kmMJVKHgkeKTfJj78=;
 b=RglCmKzyLKJ8TCwDsn1y09am86oYv+BIn6pv/Mg2K6PYSs/SRXVN2edaDMLz+tLxvcesOhAUiyB8StfETvNCMsbvkTHOgO7+goYZAXGf8Ko48KrtQdfSzG3Fa6KdB9e1tqn1EvR5cb6W9J3pXJZABh4W/aQZvAfvdsZIh3989YqWVN/1B+TkPm6fPmj35X0IXwq9l8hiQjzlHFaOka0RUVjBsZdwCHjgTFukhN9PQ7C+6djbzkf+a3LJM1GdVHS0HlNsadLxvAPfKoGUZ91PVDpfanhZYiTC43xZDUe48Pn9zWH8/gfiSVI+RYBpUaFK5JaoDWpJQRTpPG6V10lmgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:52:22 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 09:52:22 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	shannmu <shanmu1901@gmail.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 8/8] riscv: enable Dovetail support in KVM
Date: Fri, 10 Oct 2025 11:51:56 +0200
Message-ID: <20251010095156.3756799-9-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
References: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::7) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: dd031488-726b-4e29-94f7-08de07e2b573
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?shE4laW05MZGOVIbyEZtcOK49fYRe21gj2WK27vNqiFnxO4pWwI8AmjZxuHy?=
 =?us-ascii?Q?JipWQWFwIQjeAcO8na7D3Eo+I+t9sHSOoc5omMwjlucvCUAqiEWGipwUSkiX?=
 =?us-ascii?Q?iAYxEdsR019QRP/BQ8AwNuHf9/7wOZo9yfdjgwoPD5FOwCvEVepxf9udEvbx?=
 =?us-ascii?Q?qUL3yPaSN3ntWSyrTQGW/lisW452oHQF5W8unTIs/VVrhq/zKoBMTbU8BYZv?=
 =?us-ascii?Q?13nJcSFfXS8opk9eiIh3fYqy4oCZ3Er3IfXfkx5fT+4EYEgxp2FhyeskRtlm?=
 =?us-ascii?Q?RA8/AluTfQ5oq2y5tEKVb7KdA9NxmO4bYQ6NfAEFPHlAjNjVqAA+OKFDgg0Q?=
 =?us-ascii?Q?XpxmxZD62sIt1oTzxenxT0PxDrHCcjQBsOFw+4BqQENhe+xXKmL7aZ+gZsZ1?=
 =?us-ascii?Q?fQgVGvQzWH6a4APoN5Tr+7LX8Xw7vHUxr9yMUUowRFf2y/IFKeYUUYoDrJyE?=
 =?us-ascii?Q?DUJk8k0lHZ0eM1oJQTszPfxS4LucNMA9FsUE4m1+uTPaEfolGTchudAM6EHU?=
 =?us-ascii?Q?dXiY4BVAhvi0Nu/RQYXkbnb8Gd8FOXL5y0zag2ksPmieaPG6VO+8CRCQHyVw?=
 =?us-ascii?Q?f3q6nmDjlKISQ3mmeFQXoQLr6Ajsv/sr9jyBxPxWwMHXkAYJ68od3lVne9HD?=
 =?us-ascii?Q?vqpOMjmYkdKVb/rjch9wxfmjRFaL8IYgQL4IAmFzvQoIQxdqanGx07pKCnqw?=
 =?us-ascii?Q?w/fDgJLQC45dyA3VT6RdyWvdgql7maafnwPukLuyQ6GLE9PzuNbSQazXbfd3?=
 =?us-ascii?Q?4gpSTaQwnZlJWwrndvmBm0SuTB7dRo0UqiA+Df+fUKmEzJ4lZjjpe2JErT3Z?=
 =?us-ascii?Q?yZefaPlYvuwqLNAggcyEEUuGJs/NmpWkQCTzMt4mmNHby65CHB32sdMeG0N2?=
 =?us-ascii?Q?+sF/hiqtdYGrhHRr/4OfVF1QWyl9CjIsW529XQb5ca9EGI4PQi31ve16XRJF?=
 =?us-ascii?Q?eLWp93K1SOoGObk+p08QDO63OKI6+2eBSg8I3NO8rLj8JdDymj9sYNjg28zl?=
 =?us-ascii?Q?zrhJwl1TW/NMme9FwYqJVEUoVU8EOpSs8xyvu2nLOhil5fzHoKnoHqRrk4va?=
 =?us-ascii?Q?X32CFbO6aNtOHZqysOs+tBf3ojpKsL5B60syeiOdO5R4wBr4YXLN2IGfO8JA?=
 =?us-ascii?Q?wwmgizWmwL/CX9v62WJp3mYmfsE7HEHzuCHWf7PtxvfnBjfiycUJPbIw1AYa?=
 =?us-ascii?Q?Nqco+mGZjpF7JoWXbJPfDTnSZjhdPIBRLcjX679fWGQ/3YhtJtG7kCxPzwKw?=
 =?us-ascii?Q?/IETOn8Y/fByGcHU2DVxF25QzOxf8dUV1sYrRg2me7jbfgCGhNHAweQ7v903?=
 =?us-ascii?Q?YVWXd46hOUvS2fSLVi7ljh5eP/xZN72+h313eDpKHvammgPDI6frwPpeAncw?=
 =?us-ascii?Q?fmWGOGrAbycpq7NqFtWNdCHz/UYufk7G5tHM4kw6sTRmycCshhN1FmV8fIRc?=
 =?us-ascii?Q?uNEZjYu3hSkN4CvrwXJYxLOzTcTxmkJY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qCs/rux5OrJ4LEYe+0QMbYaRReib4lq4+sxf6g3Kg6+x85BOXlQGqifPqDCu?=
 =?us-ascii?Q?jbiwrfHAJLvvgtktljZ1QQjESHBZdwad7Pco4OvGadbMbHXfhdUCYnM/ZfPl?=
 =?us-ascii?Q?RvDzXE1XvmmqfrC893cWqzaANQ76t0SZ6Eur7p6wyNRyHJBD9mDsHAmFkXet?=
 =?us-ascii?Q?6qXXF37BYEjl0hmMfE1+HhzjY7kP6VAkgGZLUbqBJxsSTAHgAQxn5utGQhBD?=
 =?us-ascii?Q?8O6p4D02RUC1zxdAaeDmXR2hUZ9zpcPhUyDa3V6zIfLhj7+58dCSgpdrPl47?=
 =?us-ascii?Q?H0uyXmKJA2FFmls5zZu1XEBhtBn60M25S7mOI2gg4XRGCZbi+QS4n9/Uco9y?=
 =?us-ascii?Q?wqioQ3rwZ4dkex14Mlj2XTKPUfwRvHT1koo5F3PAvPezOhr8CEHhK9d0V//G?=
 =?us-ascii?Q?cUO2+oNiJwnVnQ+7TqgayMwga2wNUA+VlFRWHb45gRuAnoZS3zt92NMwLfKf?=
 =?us-ascii?Q?7SJLBUJWmacmrhrrJH7ELvSibrJfRFA3qTNBoaP9WYDSHayhIFTGqMeOpGJR?=
 =?us-ascii?Q?ednhLEx4Gm3p24QHCqfuB7pPHm2Kf5/M/AYjKk2UodYlNvLZ5utZmj3FsMbV?=
 =?us-ascii?Q?RUfgTY7OrCQVx7FiUNa1aFuVUKGZKB4vHMvZzenDuWlpuio7UUo5nSWgpPUk?=
 =?us-ascii?Q?JKCVpgEmzXIkiaKudS/262kYnSzXkesAIkOLT8wSvhLq9OH2LbUZBv/GTyai?=
 =?us-ascii?Q?L3iUWQPfSNZ7s1v0IdXCaLPmGOjdUe79KxfYnKvdCuCoEwi7hTQ+y4V3ruUM?=
 =?us-ascii?Q?qVQCvzioH8YduYWEHoBbWuZStw3Zpqj02v4MSaxd/1MUPYxDUzilv9xmXL/c?=
 =?us-ascii?Q?bm9UhUPVhyWooAoiJwycPwu6PubLHJmHMrTcShyfea909V2rxNw+9uNokULp?=
 =?us-ascii?Q?XKRrQsJQwrEpYkrewdN/5TwLbMEN5rIL6FwRk7ZdvYCj0DBikTxpAQuPE2Tu?=
 =?us-ascii?Q?ioAmm3DtWdE/EnmQcDXGvfmTd9gJpVottAZy9qPB/7syO40yUahBhNxdWImb?=
 =?us-ascii?Q?1yh+z3qgPh6YVqJ7b9Vy2R+rdx9UkZbRtcRfbTN5MWcguRYz2rce45KX4CdN?=
 =?us-ascii?Q?rfOdcmLpG0o1ZmGVub4hJBJRBzZZS64P3wc/2T8KpNHxLyyDeQaMC/alqqvV?=
 =?us-ascii?Q?cWQFAU/DbTiCGkVz53FJ5Ix00PNfGxXLJyXT/1p9GF5Tf6j0UjWh4WqnyHGx?=
 =?us-ascii?Q?4i1gkYn3JtKhjSk6E+hiwLxoamD9V9LBceT3PqpKmPWYuSfiwhZQKMaMP3ie?=
 =?us-ascii?Q?wpZ9m7lsrq5UTRfXFdtlxbW1Fg37V0KIuGMZJY4Ftgrzi72wcwoBnibPzMx2?=
 =?us-ascii?Q?kS6NF7X7qP0m71r3XH0W7GghQwDmLnt5k5cVQF4U/tpQhoC37mQZvrN/OCnj?=
 =?us-ascii?Q?S1CJkTrhTZyEMJnDfn3Vj2Co/AG8lgHO37hGupVIeyJRjElH9tZA09M27h3a?=
 =?us-ascii?Q?IsjIc8slRHWk+KgBMEp+j+fhjquewda3fbDH+Fa+PbvfPgrwPWtBew4EfDtk?=
 =?us-ascii?Q?vzT/OCg0TS0Ws6q88abFuT0ezl05uvbdUnAg7UcjGfO6m5DBfnsl8XwExPNF?=
 =?us-ascii?Q?8JcS9bhP9KG3JyLWe8Olg7DJVn2AaI+LMX5Dgo9BhGXmXb/Zi1XhM8CJ6PP6?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd031488-726b-4e29-94f7-08de07e2b573
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:52:22.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdMrqT2qIeMkSB4GUSPv/Gv8xw5YMbQK/bSIBr6hs2eZkisDe9QubX29gbk5vrtmu4bn5cC5mFNqEBgaOM/MbHbXBLADWk6MN96tv/Fg3tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

From: shannmu <shanmu1901@gmail.com>

Add the necessary modifications to support the Dovetail co-kernel
in the RISC-V KVM backend.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/kvm_host.h |  6 ++++++
 arch/riscv/kvm/vcpu.c             | 13 +++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 2e2254fd2a2a..f24c31e179a9 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -9,6 +9,7 @@
 #ifndef __RISCV_KVM_HOST_H__
 #define __RISCV_KVM_HOST_H__
 
+#include "linux/spinlock_types.h"
 #include <linux/types.h>
 #include <linux/kvm.h>
 #include <linux/kvm_types.h>
@@ -246,7 +247,12 @@ struct kvm_vcpu_arch {
 	struct kvm_vcpu_timer timer;
 
 	/* HFENCE request queue */
+#ifdef CONFIG_IRQ_PIPELINE
+	hard_spinlock_t hfence_lock;
+#else
 	spinlock_t hfence_lock;
+#endif
+
 	unsigned long hfence_head;
 	unsigned long hfence_tail;
 	struct kvm_riscv_hfence hfence_queue[KVM_RISCV_VCPU_MAX_HFENCE];
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 8d7d381737ee..7d0096c3c3d7 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -733,6 +733,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	int ret;
 	struct kvm_cpu_trap trap;
 	struct kvm_run *run = vcpu->run;
+	unsigned long flags;
 
 	if (!vcpu->arch.ran_atleast_once)
 		kvm_riscv_vcpu_setup_config(vcpu);
@@ -786,7 +787,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 
 		kvm_riscv_check_vcpu_requests(vcpu);
 
-		preempt_disable();
+		flags = hard_preempt_disable();
 
 		/* Update AIA HW state before entering guest */
 		ret = kvm_riscv_vcpu_aia_update(vcpu);
@@ -795,7 +796,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			continue;
 		}
 
-		local_irq_disable();
+		hard_local_irq_disable();
 
 		/*
 		 * Ensure we set mode to IN_GUEST_MODE after we disable
@@ -868,16 +869,16 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		 * recognised, so we just hope that the CPU takes any pending
 		 * interrupts between the enable and disable.
 		 */
-		local_irq_enable();
-		local_irq_disable();
+		hard_local_irq_enable();
+		hard_local_irq_disable();
 
 		guest_timing_exit_irqoff();
 
-		local_irq_enable();
+		hard_local_irq_enable();
 
 		trace_kvm_exit(&trap);
 
-		preempt_enable();
+		hard_preempt_enable(flags);
 
 		kvm_vcpu_srcu_read_lock(vcpu);
 
-- 
2.43.0

