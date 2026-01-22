Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1211E3BB9EF
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077405; cv=fail; b=MzbR5GtHn6FaSnTMCCLBSyPh9wDaM9yezVfZD21/f1xpPw44gQYxyOdQE4XS2hGBAZ4+XDlV11FYzpBXkfjxhKXmuQVI/IvC2DAaAX0/qPC9FQzGbglhUiAUs2/xZ60DKzSHm6O+0Shl45nABqbMc4T2HI4wTYhTLvQwTfYEN08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077405; c=relaxed/simple;
	bh=Lc2tyBTIBn579wFFCn8TwmiylnOSe+znje04FpElUYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gYp5SwlbcbaoPyXfM2wj/ew36/QSe+Sxklw0abTFDQIStMDZ/Pow857A1JXxNA5nuZ/LuV1tGHMGJ7G0LtUWBE4al1/bwd4vEzVTAoP0c0sbdOZHfxQZDrv8VEQFm+EUd0l+uY+Yrld+khYnXptnHZN1DYtLDNwVQ4s2r/tPjNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XVYHpRn3; arc=fail smtp.client-ip=52.101.70.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XVYHpRn3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMU1n+JWsV1+8xQjp/oLjoxTd2qt4E9eOPqxE/AZmyjuKlp1qSeAsMXJIXFu//5C/SYUwhZoNPn7n/0vDXb5cLk0zP7APTeNebnjMgEd5jFeI6edyRuD5XLxXjWXdOhKxUfuMRxEcTS1WEYsMxXRCATZUwgIMXdxmZrZzYt+Umfv1pCwny1BXxgmhxAvQK//L2z/3+Kn7khMW0otdqBXx57yK6HD/RYszYZC3bP7gg5WLTMtRVl3WLcRUVe2EnWnYXbozagy7c1TYDdwf2BpMhxUWff/K0N8VK9ilRxzVKpaomKYA2VpkqY+TyEOP2VKlNgFZK/Cg/+sVR/SBHlVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYrz1jg4SzL5BzgStNy8IV2xJEQyLwtTviXegV5dgnA=;
 b=B83On5cuP0TlrsZefvfqFl1VqN+iENt1N3N02KEw6M7uAFj2ZEmFPN7jy7tFAq68n/DWXk2yVlnP4QIhV/Q2RgXOWuRsRIQwJNxi1mk7xE1xd32lInG3alff26ul7VTvTnTl7/OJNHMRIYwoJlAq1D6vP52n371H7uuzO0OJXkGVcfih0/QbLXXY0f7Kr3uutJqprD4DaCPp5ybkObInMSA6XcpvehbaS/idYXOwF2cny1UPSBPKg7V5sjTqt3TnFuLv6giejTwGrixgvZz/wfMNRruNr8P7sTnVz1vvGBQtnfsTKiWPL6vVU0so1fn4xu70TZiHf1TL20lq2z4tWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYrz1jg4SzL5BzgStNy8IV2xJEQyLwtTviXegV5dgnA=;
 b=XVYHpRn3Wy+RDWcAPSU2kgMpvQqP3Q7RHxSfwP7KoE4rQJjTqPv/CeHVX6Xx2niMwakw2Rfzq6/mleBjRJE0x3Yfy1YTAFq+6fno2bMc+0OresfieSsky9ecXf9hhh0Jnyl4VHymw6ZdeFoo4+MMl0KuXCnojzKKeUQ4TUt7lN+Y7U9r37LZ6VsbDZUYL1n8+VCMJY4aOK1Qa1mUB0nmWyAz+9kenSiTbQHaU0ISRvHYNIblUKnRQ6uBvqeuj+SEQlYqBZCCjXzvAbaQ49kD+Qp45L1u79C+RZ7+63102rk/tG2oAe1+V5nMvmfhSjPfXj1ZiByzgUHUE8C1mPfeoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB8115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:384::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:18 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:18 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 11/12] riscv: add out-of-band aware trap handling
Date: Thu, 22 Jan 2026 11:23:03 +0100
Message-ID: <20260122102304.421957-12-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: dce91ad8-75f9-456d-cc20-08de59a042ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lYMI+1MTKFwObqq+tPQd1Mx3VCKmyu3n10o9d25rXJjw+Od2kmOmrXXlnuf?=
 =?us-ascii?Q?6+wrxO6HNbFpCoEaNX4lg5zDw4DUzoDgeeQ5kY6a6ll2FXHp2cQzDKtDwEYk?=
 =?us-ascii?Q?tjVbbdDi1k0jxG1Mf01qd7Z0vIcovuyJCQDME/Dz6+bx7jTXkpneFr/XcCvN?=
 =?us-ascii?Q?ojAzYXwwCE7W90IIeYFbrgZCK/Bc4+OIzYLvFJXwopSSYgV3JwZX8m71bn8I?=
 =?us-ascii?Q?4wMjLd5ilTPd3SiQdidym6Xh/vmjYeGix995UwMVgtflliBl8Io5Y3P9hFzQ?=
 =?us-ascii?Q?qifJfG2cU3phfI+TEXOBDgKhgRbfZMYAm3RWVv1jf8diR3QWvBEYYEHrYib7?=
 =?us-ascii?Q?dnJKHIsGorfUn7Exqv/R1z+QZhARPHiEHZ0mycL8Fb2XDEuchzHI1JtTbyOt?=
 =?us-ascii?Q?v34mA8Wv+TySYBecZcDxm4H9xN1r2kePjTHiFFqIdBswgAmK26WpcAU5c4tE?=
 =?us-ascii?Q?YcONiT/teXstGVhiBt793jtVLd4GlvhTF1NHXMQ0XdrLYHvSTiHmCJZlHEL8?=
 =?us-ascii?Q?razEXPNYD9EshqU6tGqODOjleBk2iDiuwYjsMnmB+pICXaoxQuYiH/5gBMw3?=
 =?us-ascii?Q?/H/SDPg/yCh9RoFmypL4iA4usoi5F+vN3z5jMedOL8AO8d4quamIM9AwvH3x?=
 =?us-ascii?Q?+YMEh+pjUqcJp0HQvQjPhD6sl+iUa3xRwVbMOiJFt2t0qBr7DalAQaqVGAv3?=
 =?us-ascii?Q?NsfevrLqzePNhp+CKeuCLX5WiT3bWwh4Fh7PpoLGlSx/J7bqv+Tj+EgJX8CM?=
 =?us-ascii?Q?SOR1VLHJoB31imIVpNhk6EjacpgfT5mhvW/EDlDSmE/CP37wvifbTL3MnZz2?=
 =?us-ascii?Q?WRMiuk7JuUoM5XdHDgFCM/tN2F2dljoFRtQJZ1KS9Tgc5QGkQ3Lxyx9tNGmt?=
 =?us-ascii?Q?uXCdDg3a46ZbxbozSXH9MtWastt2lBV3Bigq5DY+HCsMDvwBzWDf/5qbz+k6?=
 =?us-ascii?Q?DIiGSA07zihG0zLUyLjdvl9ZNgkZtaJ2WWiN8VTjTz2LDnw+cFY+Er2+JeTn?=
 =?us-ascii?Q?u/xQgWVc8AloZrMz1VYaFpUSE+2pg8eiHcaJWQYQN9yKGQODk8FeIrplzBHU?=
 =?us-ascii?Q?wqXqKxf1WqFY3/nIQtOcf5q3FPNwd80ziwP4UiMsJViHB8ubzxWDZYIV3twE?=
 =?us-ascii?Q?o+WXXvge+4sB/cw40dPW8ptvon/sP1oc0YdGKKJiv+iOYFJW0vQoFWC6tKAN?=
 =?us-ascii?Q?P4zxWUo6dEaDcuqFULR3dt/HzCAiBj5hSR5EZlMthYyMS6D2G01PyT2X5WPi?=
 =?us-ascii?Q?i9rhAeHff1wymQWPJ0p4vp7QDKq0XalJ4uPgZHRsyexuZmyqDnGGV5w13rOL?=
 =?us-ascii?Q?kz9yqVWit9UA5qVY7K6UKUGzxzz3d0yzc8dgmuWD4kfXh6DAzf+Rbu1N/hIx?=
 =?us-ascii?Q?0hSg+1AFB1EOQZuzV9/CXUCwXMW+328/etK1feximKhm9dJahq4Z42VnV1aF?=
 =?us-ascii?Q?b7+9FB2zjnbkvITPV/GIVgUcnCfH5gRzIb45fB5nQq8IQXLVfkV9+CyEsHFc?=
 =?us-ascii?Q?I53ca16t7+No0M2HnZ4qYCuLP/lBbLlk3wgtbaCWLs6TPRK6l+uxh6JzZQHj?=
 =?us-ascii?Q?cAT2ASaBzOFSPZt4JiE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p2h1LtFgXoZKYGJuIG9UfhURJNzd0YboRWq3G+y2orO64bkoMKn+Rp5etU1K?=
 =?us-ascii?Q?mCezYs908OnHUjRBcGN/Smu7QtdG9uveMYUCnWNUO33GgXEYT9q4yo2KcnRs?=
 =?us-ascii?Q?JREulXuW67qMwRnJZmuz3WN3l1eORv40wUzWNic6AVnEKaSOFrJbQZeFSq1B?=
 =?us-ascii?Q?xEmSy900wYzP+QJoBQkTKCnneHpgCs+uhVzkZynel+TxDWYC6ZjsrfFVts69?=
 =?us-ascii?Q?tPww92B/4+OqgYthtw8GSB80VCCZ51K1SUrSjQaRWA6QK4Uo5pKn110dFDk9?=
 =?us-ascii?Q?akgslFOjA+0rp0qWGAjZwLxb7oosXtyWxdye8vWja+6XmeblOSA8ZAeFrjtX?=
 =?us-ascii?Q?OvpMvhK91BozYAXwOwLl+fT2Fm6CFL48AHmRCTyq2eii+7s05GoaXjFrifth?=
 =?us-ascii?Q?h0a7cCqKgbzLYr7iIRNd2WvgDJjbKWvgHK0nQyPDQuvz22dwzmO6t7Nfipyy?=
 =?us-ascii?Q?tjZgpS1RlRE5cOsDOGTNJgXzLIxnHSEQkgzmXP35U8xSzcfS1Sn31cQRIhoT?=
 =?us-ascii?Q?tE9eGVa/2bNNdrTFTcbUlbEjmUk7FXkA0EBAQB0vxGKAQf3okbwYqYEj8Dpu?=
 =?us-ascii?Q?9ClzU7K4GxYC9Lh+dGQf3rZwe0ItItJNfgZZ3lBdOlkcjkJqnVueKnz/krh+?=
 =?us-ascii?Q?tncdH9q3VHB46qZoMAyc8yxV9tTLaTZZYPX6J3uaSYnke/bCi3A9XU2Uwz+u?=
 =?us-ascii?Q?uGr2AW3Ov3vbmHeufTZPbXPVOniu9pWAxKM9AfJKo/Bozu1ISlS4zBklsclL?=
 =?us-ascii?Q?caIZFrzWWskU7dVQRlu7MOpFv7bPUJLE7+np65A+l6ev6xmPLOV7iC7VmPN+?=
 =?us-ascii?Q?rATWCiBC+bR2bcvkD0ulDwb3Pb7BgLGzlzYiRdkiRh8nRt/J8KGwO4c7AaLi?=
 =?us-ascii?Q?XK71SwV3zJc1b+FdSXcPP/4kENYYjZKVSp0HmrKZziPz8lvxboV0Srbx8O8s?=
 =?us-ascii?Q?k90AMdcXSJzgNuIbmmiEgiYNqEVNspnaUmkUGFcicbiAriruHgyExhJDK8Xt?=
 =?us-ascii?Q?aSuKsQNQD7WIS94hq7eC/RrkUKGM9w/QPcxoeM3zXRqI6BRgMSSWwWE5YLLi?=
 =?us-ascii?Q?cw8fhozEa7EB101VDOwHFLm4gpDLiMs31EJRd+JsgFsX/4g7c2H1wdddYDJd?=
 =?us-ascii?Q?7aw5pYPALzsjHRBAvdEdsXuuUEHvodSz4Mlp6TRqsQU6fTEDjiRWuLSlDcui?=
 =?us-ascii?Q?vK5gVFurIX8b1CUwOX4KeYaZmeoJSxn/7q8VaFPOQLWHrHfiAOp3MCMjqUdF?=
 =?us-ascii?Q?Ms2M0bamix+UgyefHRsYUIP7vV9m+s61l4gxvSJcdu3O19N4IpKAH88nAN3j?=
 =?us-ascii?Q?/Np0zltF4dCANiEmVWkDvhdMHEN9oSU2Jzo0q8tN6tmj0LjP1UAFZ/BCewVS?=
 =?us-ascii?Q?3LU2Xa3iFD8BbiBcTdqhuz+EgvyNCx18NQEQ66w4GXMOCkddWX7/bI/aS09N?=
 =?us-ascii?Q?q4CjCbVUQN7WOyNGJR2rqI8J3xpoF1JQRXwk0UWxSUBL9dGM75zlMw9eDOju?=
 =?us-ascii?Q?w6sD4ZFXWOJP9pnv86+B4PjyvQbBN+nn5xUrr+dIwzle0r8sMalPwOhRXC28?=
 =?us-ascii?Q?HyRmgfBPrakUKH45gBNtWJVnPTjtTAPMMza1mu4Mq+Gw3moHbEbSesNsV/HH?=
 =?us-ascii?Q?HwtB52AzqLZpWNlfs+cGuvb2q2pxbbMogmLyEViwlwO3w1clBIHJ/ylF8oRN?=
 =?us-ascii?Q?+28o6sjOScyPcZfcrPuc8JTcJ+5GzsAcKOMZ9R0uSAFi9jDd7y6AngQSnqeH?=
 =?us-ascii?Q?ySHEdllxRMCRvVOOr0Qq33/arlvwyeo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce91ad8-75f9-456d-cc20-08de59a042ce
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:18.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G84pSXW57PTPcdRk4XZzD6Y+Gz8L5BTfcT2XfD/03UlFu41g8NIZ5cD2DkkPpHQDqtvKOR+nizdTA/RCQ2nXTpcSv4wzYtdcqM1oU8IDNGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8115

Introduce trap handling hooks for the Dovetail co-kernel, integrating
out-of-band (OOB) notification and unwind support.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/kernel/traps.c | 110 ++++++++++++++++++++++++++++++++------
 arch/riscv/mm/fault.c     |  21 +++++---
 2 files changed, 108 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index d0400086a075..51e1407ee066 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <asm-generic/signal.h>
+#include <linux/compiler_attributes.h>
 #include <linux/cpu.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -115,6 +117,8 @@ void die(struct pt_regs *regs, const char *str)
 static __always_inline
 bool mark_trap_entry(int signo, struct pt_regs *regs)
 {
+	oob_trap_notify(signo, regs);
+
 	/*
 	 * Dovetail: irqentry_enter*() already synchronized the
 	 * virtual and real interrupt states for us. If running
@@ -126,21 +130,40 @@ bool mark_trap_entry(int signo, struct pt_regs *regs)
 		return true;
 	}
 
+	oob_trap_unwind(signo, regs);
+
 	return false;
 }
 
 static __always_inline
 void mark_trap_exit(int signo, struct pt_regs *regs)
 {
+	oob_trap_unwind(signo, regs);
 	hard_cond_local_irq_disable();
 }
 
-void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
+static __always_inline
+bool mark_trap_entry_raw(int trapnr, struct pt_regs *regs)
 {
-	struct task_struct *tsk = current;
+	oob_trap_notify(trapnr, regs);
 
-	if (!mark_trap_entry(signo, regs))
-		return;
+	if (running_oob()) {
+		oob_trap_unwind(trapnr, regs);
+		return false;
+	}
+
+	return true;
+}
+
+static __always_inline
+void mark_trap_exit_raw(int trapnr, struct pt_regs *regs)
+{
+	oob_trap_unwind(trapnr, regs);
+}
+
+static void do_trap_raw(struct pt_regs *regs, int signo, int code, unsigned long addr)
+{
+	struct task_struct *tsk = current;
 
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
@@ -153,6 +176,14 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
+}
+
+void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
+{
+	if(!mark_trap_entry(signo, regs))
+		return;
+
+	do_trap_raw(regs, signo, code, addr);
 
 	mark_trap_exit(signo, regs);
 }
@@ -163,7 +194,7 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs)) {
-		do_trap(regs, signo, code, addr);
+		do_trap_raw(regs, signo, code, addr);
 	} else {
 		/*
 		 * Dovetail: If we trapped from kernel space, either
@@ -181,9 +212,12 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 #else
 #define __trap_section noinstr
 #endif
-#define DO_ERROR_INFO(name, signo, code, str)					\
+#define DO_ERROR_INFO(name, signo, code, str, trapnr)				\
 asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 {										\
+	if(!mark_trap_entry(trapnr, regs))					\
+		return;								\
+										\
 	if (user_mode(regs)) {							\
 		irqentry_enter_from_user_mode(regs);				\
 		local_irq_enable();						\
@@ -195,19 +229,24 @@ asmlinkage __visible __trap_section void name(struct pt_regs *regs)		\
 		do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 		irqentry_nmi_exit(regs, state);					\
 	}									\
+										\
+	mark_trap_exit(trapnr, regs);						\
 }
 
 DO_ERROR_INFO(do_trap_unknown,
-	SIGILL, ILL_ILLTRP, "unknown exception");
+	SIGILL, ILL_ILLTRP, "unknown exception", EXC_INST_ILLEGAL);
 DO_ERROR_INFO(do_trap_insn_misaligned,
-	SIGBUS, BUS_ADRALN, "instruction address misaligned");
+	SIGBUS, BUS_ADRALN, "instruction address misaligned", EXC_INST_MISALIGNED);
 DO_ERROR_INFO(do_trap_insn_fault,
-	SIGSEGV, SEGV_ACCERR, "instruction access fault");
+	SIGSEGV, SEGV_ACCERR, "instruction access fault", EXC_INST_ACCESS);
 
 asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *regs)
 {
 	bool handled;
 
+	if(!mark_trap_entry(EXC_INST_ILLEGAL, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 
@@ -237,10 +276,11 @@ asmlinkage __visible __trap_section void do_trap_insn_illegal(struct pt_regs *re
 
 		irqentry_nmi_exit(regs, state);
 	}
+	mark_trap_exit(EXC_INST_ILLEGAL, regs);
 }
 
 DO_ERROR_INFO(do_trap_load_fault,
-	SIGSEGV, SEGV_ACCERR, "load access fault");
+	SIGSEGV, SEGV_ACCERR, "load access fault", EXC_LOAD_ACCESS);
 
 enum misaligned_access_type {
 	MISALIGNED_STORE,
@@ -264,6 +304,9 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 {
 	irqentry_state_t state;
 
+	if(!mark_trap_entry(EXC_LOAD_MISALIGNED, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		local_irq_enable();
@@ -281,6 +324,8 @@ static void do_trap_misaligned(struct pt_regs *regs, enum misaligned_access_type
 	} else {
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit(EXC_LOAD_MISALIGNED, regs);
 }
 
 asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs *regs)
@@ -290,15 +335,36 @@ asmlinkage __visible __trap_section void do_trap_load_misaligned(struct pt_regs
 
 asmlinkage __visible __trap_section void do_trap_store_misaligned(struct pt_regs *regs)
 {
-	do_trap_misaligned(regs, MISALIGNED_STORE);
+	if(!mark_trap_entry(EXC_STORE_MISALIGNED, regs))
+		return;
+
+	if (user_mode(regs)) {
+		irqentry_enter_from_user_mode(regs);
+
+		if (handle_misaligned_store(regs))
+			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+				"Oops - store (or AMO) address misaligned");
+
+		irqentry_exit_to_user_mode(regs);
+	} else {
+		irqentry_state_t state = irqentry_nmi_enter(regs);
+
+		if (handle_misaligned_store(regs))
+			do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
+				"Oops - store (or AMO) address misaligned");
+
+		irqentry_nmi_exit(regs, state);
+	}
+
+	mark_trap_exit(EXC_STORE_MISALIGNED, regs);
 }
 
 DO_ERROR_INFO(do_trap_store_fault,
-	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault");
+	SIGSEGV, SEGV_ACCERR, "store (or AMO) access fault", EXC_STORE_ACCESS);
 DO_ERROR_INFO(do_trap_ecall_s,
-	SIGILL, ILL_ILLTRP, "environment call from S-mode");
+	SIGILL, ILL_ILLTRP, "environment call from S-mode", EXC_SYSCALL);
 DO_ERROR_INFO(do_trap_ecall_m,
-	SIGILL, ILL_ILLTRP, "environment call from M-mode");
+	SIGILL, ILL_ILLTRP, "environment call from M-mode", EXC_SUPERVISOR_SYSCALL);
 
 static inline unsigned long get_break_insn_length(unsigned long pc)
 {
@@ -350,6 +416,9 @@ void handle_break(struct pt_regs *regs)
 
 asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
+	if(!mark_trap_entry_raw(EXC_BREAKPOINT, regs))
+		return;
+
 	if (user_mode(regs)) {
 		irqentry_enter_from_user_mode(regs);
 		local_irq_enable();
@@ -365,6 +434,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
+
+	mark_trap_exit_raw(EXC_BREAKPOINT, regs);
 }
 
 asmlinkage __visible __trap_section  __no_stack_protector
@@ -381,6 +452,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		syscall = syscall_enter_from_user_mode(regs, syscall);
 
+		if(dovetailing()) {
+			if (syscall == EXIT_SYSCALL_OOB) {
+				hard_local_irq_disable();
+				return;
+			}
+			if (syscall == EXIT_SYSCALL_TAIL)
+				goto done_inband;
+		}
+
 		add_random_kstack_offset();
 
 		if (syscall >= 0 && syscall < NR_syscalls)
@@ -398,6 +478,7 @@ void do_trap_ecall_u(struct pt_regs *regs)
 		 */
 		choose_random_kstack_offset(get_random_u16());
 
+done_inband:
 		syscall_exit_to_user_mode(regs);
 	} else {
 		irqentry_state_t state = irqentry_nmi_enter(regs);
@@ -407,7 +488,6 @@ void do_trap_ecall_u(struct pt_regs *regs)
 
 		irqentry_nmi_exit(regs, state);
 	}
-
 }
 
 #ifdef CONFIG_MMU
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index d64d01874a79..42450c47ee12 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -385,6 +385,10 @@ void handle_page_fault(struct pt_regs *regs)
 		die_kernel_fault("access to user memory without uaccess routines", addr, regs);
 	}
 
+	oob_trap_notify(EXC_INST_PAGE_FAULT, regs);
+	if (!running_inband())
+		goto out;
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
 	if (cause == EXC_STORE_PAGE_FAULT)
@@ -403,7 +407,7 @@ void handle_page_fault(struct pt_regs *regs)
 		count_vm_vma_lock_event(VMA_LOCK_SUCCESS);
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, SEGV_ACCERR, addr);
-		return;
+		goto out;
 	}
 
 	fault = handle_mm_fault(vma, addr, flags | FAULT_FLAG_VMA_LOCK, regs);
@@ -421,7 +425,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (fault_signal_pending(fault, regs)) {
 		if (!user_mode(regs))
 			no_context(regs, addr);
-		return;
+		goto out;
 	}
 lock_mmap:
 
@@ -430,7 +434,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(!vma)) {
 		tsk->thread.bad_cause = cause;
 		bad_area_nosemaphore(regs, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -442,7 +446,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(access_error(cause, vma))) {
 		tsk->thread.bad_cause = cause;
 		bad_area(regs, mm, code, addr);
-		return;
+		goto out;
 	}
 
 	/*
@@ -460,12 +464,12 @@ void handle_page_fault(struct pt_regs *regs)
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
@@ -484,7 +488,8 @@ void handle_page_fault(struct pt_regs *regs)
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		tsk->thread.bad_cause = cause;
 		mm_fault_error(regs, addr, fault);
-		return;
 	}
-	return;
+
+out:
+	oob_trap_unwind(EXC_INST_PAGE_FAULT, regs);
 }
-- 
2.43.0

