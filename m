Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387C7266EEA
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115318; cv=fail; b=eQfSEDYYm7D+bioE20iRv6b8q/T9FvRek9j5rqvKAvJSrBgfp9qRUDehgrN+hk7Cf+JEiiO9ldCgOGngbKQB6HbaRa2yg80bmQ1iykCtr06HZ6ssLx0PiDyShDJFpbZkC1bn2ie3DJScFizD2iOp2HNMtGDcdRjtZEmexRZCub0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115318; c=relaxed/simple;
	bh=ZfheLoR1XBHRLxyboNEf29MEwuaJ9mborqwGwSfSxME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j5d22mKQRgYpVLJJDMXicZi+7NekigEgaeZq31t5IxkLsJ3aP3FK1by6We/lQh4WHggcywtPmL3nTp859Gk4sPF+/tXQVuUgfvQtYVKQf+rcYK58vvQFZRF4IA0bdnJ4xIo4jOtuBlorqyMbRbK+ssB98n5vj5YYFopDcAqJvBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=eYj6g/Dn; arc=fail smtp.client-ip=40.107.21.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="eYj6g/Dn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT19S40gmmQL7h8jf/hdpFsVequm+p3YRNzrF26ZG5wfOvKFDa7lMdoBZBZjWNQgZnMTCEcugL/Shcv0Ghjohlkv3XF2ywAjdmfAz1LPwPpB5t34UL8RV1hAvEri/S4IvKQhJ8pitKQSqQ+CeY9W4aEP8U0xrl6DcoPCiNjGnTJTSwCJ64eDvSGKRjxPfALemnnVx/qo/voYtvVA36Osz2mcrnRUHC3LO2Lzm5rzw+2ZWBQcqa3gd2LS1KT04Hy58gcjUehS8RUvcYem7CKuFp6Ee8w5Du7Fpy8y/XzHtHYOg1Pvp2nKwC+YepBC5VxaHU0/d5eNSBvshaFWdrHjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=919sM+WI1LHfK3SR+Ur5vp0u8a+z3ZYDN2U6tSkZZMw=;
 b=KwG7tLLrkwZxyfMgSkK0/dKSAY42ZagbPB0qqOHWRmSMMOfBh6R3i7fN+UzGOpKvhk+KH13U+amPsdXZkMOFR+dsxI0p1D3uLFglNfDDXwIuIkF/4FmyU4e89Eur7V+T6L5JQ6R4zuSRN1FP+kZ5RZ7Rp+JrYOkvrsybVwv0k+7ms+aU52eoMqJSmtLRCDOWRfEE4BkriBmc/SrxhQDLAKIE/izkjCuGLctV/PpZ3asMQrcBiSLaBvgwAiQfEWfrUc0P0kpb7gux1uap00AEpkyur+tvRXpr5jTVR2PmHqVDc0Dw1V3iGG7aSb+oyaI17wsvsWKWb0uuS7QREw89WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=919sM+WI1LHfK3SR+Ur5vp0u8a+z3ZYDN2U6tSkZZMw=;
 b=eYj6g/DnrcXdJ12B3OS/GzI2xS7viet+cDZi3b48vEnb5cfIs0ORs6HyN5DFcwn6J2g/YHFnoKgOheWhTcUij/HJcwiuu6tzwdAQMuO0s87Xj2vKNNJzG76hdQj7Q/e9lb0xchS0rMqONal1SJHN3XoTtm4+AjB4xYars+rWZ0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by AS8PR08MB6424.eurprd08.prod.outlook.com (2603:10a6:20b:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.28; Tue, 8 Apr
 2025 12:28:25 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:28:25 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Lorenz Kofler <lorenz@sigma-star.at>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 1/6] cobalt/x86: Add architecture specific signal code
Date: Tue,  8 Apr 2025 14:28:12 +0200
Message-ID: <20250408122817.626897-2-nikolaus.funk@sigmatek.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
References: <20250408122817.626897-1-nikolaus.funk@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To PAVPR08MB9037.eurprd08.prod.outlook.com
 (2603:10a6:102:325::13)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9037:EE_|AS8PR08MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: dc921926-da2b-4fdb-ac7d-08dd7698dba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+JXIwPjbdI2khJfdyRSKkFV+xwf+qA3V8IBFfr7OtBaqsWpHxZ0pcZVtc6uw?=
 =?us-ascii?Q?BZWled40xD+KSRan0ZBbCoYZH5YBkBhsOC4HhDLum8GAlPHckPeYOOnFZ0cF?=
 =?us-ascii?Q?Ek0w+dfvb/tY0rRo8idwngh+oxR7dT9vuD6kAxgiDq2/ZXBq1IYSrGchHXKd?=
 =?us-ascii?Q?yRzpFyScqfqRimchWU6PhFIXyUzRdYdJq1P9WHNOI6EGd6K5OIyMsm69jnMN?=
 =?us-ascii?Q?UV3IJvctN2DyHpSoh60VbLyMsDFteMfvAqyTUdiZFYh349bfBtg1FkcfH4R9?=
 =?us-ascii?Q?u+K+dVCGjsLCsnQdRZ2BlomswFN/8jygTpmQXgbOgaZy73MP03OFdsF5LgnA?=
 =?us-ascii?Q?OahttVAcGkLjB7t7tnzy0lilRWuLEmpqqCVeNETpdlJJcCcrz9ioC2WmHi7h?=
 =?us-ascii?Q?ePF5kOcxjW69ow29qEN50VXDhZN6oc7mWVNmqDH0R7Py0jGcXK+H6Ow7+9If?=
 =?us-ascii?Q?fe8YKal6LX15HF+sPaU/GUL8kyQ2NXa97F7gLsghHVNXVfIO4lUUVCLBZCp0?=
 =?us-ascii?Q?BLijrWWDEXGeE+9TA2xb/UpKE4lyXHRWJlyeFXIdU6fBBt8tneTRw7zKYQFf?=
 =?us-ascii?Q?9DDsvkLku1BZC7RlxRS72IUs77iBusOoZZsU7BwguHekJK3hjh+NbZoGYOnx?=
 =?us-ascii?Q?0U491Deu1pUD1DYUEDmolLFDlwhLNSae0etg4OWBbuDbD20O7jRevczHYG7p?=
 =?us-ascii?Q?3eq/ZQTi6jtrtPOBftUkAB1rjS9fuNEDVvKH/0D2x8G/XdJHPAU3FUwj2g/k?=
 =?us-ascii?Q?jOg98jg3qlKaXvc+BBO9jRc6A08EAtBCQJ3F8sj+u0qZ1GVJhC+7LGrT83vo?=
 =?us-ascii?Q?l6VGspkuzOGf9sUQZhR3avDvNKrTtWxXFWcxBdkU749Ls6gaJ6gN68jtJWfr?=
 =?us-ascii?Q?FS/orUy+JXq+qsd9drh46ah0bLiOVbylWzWNsTPYdwPbDVnFn3jhVpIm1gfs?=
 =?us-ascii?Q?NHtg1cAzyzLVpCv4iONXdfK5LV4LwTLCCvF606g5BUuKc6Us2b7qAA5A2EMK?=
 =?us-ascii?Q?DMOv8rB1sN91LP2TrlrtwKaLAwp5SFP9d7w/tOJ8crNc1vmrkYN0UJLd18HK?=
 =?us-ascii?Q?2j4VxCdoiabITAw7HEL5405jWMXIGeidRkFxZxtCPHamjMArQLZbEE6jxv9q?=
 =?us-ascii?Q?HC1vpBntfVZd7EsVZeCjiOrZZDxCifvy1L5QJqWtkEM6UTtahzMVHWsvbC7C?=
 =?us-ascii?Q?IHsHxUF+x+hT/W8LkZ78Y/YrtSizipCJJA8LKAE4JsjJFMYtts1bYjUrdDct?=
 =?us-ascii?Q?i6MsCoXD3gmr9EgU3CvCz8RkDoG7Pl1SH2qjs7fBVabk+psH31PdzddGJTps?=
 =?us-ascii?Q?aTWDqILW+W4rlyRsudIJwiMFeYPJxfABD6gUEHzKYoBjX7vw1pQKcrh+fjTc?=
 =?us-ascii?Q?Qf3ObOJBoMtidyTjeaVbK64jUEtLlEJZk0WpC2amBKSdSgKqTKg38VXkjoWY?=
 =?us-ascii?Q?37bBia17FEJS3UUXkkDxQgrMLuHi/KzX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SdgTCE594JQQJF6SY0eaee1yYyHfRMjFvnld4a0/uWHw7uiu1KE2r/veFOcR?=
 =?us-ascii?Q?/ytLO7LH+dHwGIIHv49xTThp5z/4D4To6w0Vooxl/On074gr05GQ1YcXdRpT?=
 =?us-ascii?Q?Nuaw221FnhhnqVvXU4T414TGg9RV8ub/RWE+RnWjI2QcFl++xDAVtPqZ8rmN?=
 =?us-ascii?Q?MHmwQxH9r/TvVL+XEApb9NtdwxcRW5Epg/yMNLWkvbD9OGSzs5voW7O1P2qQ?=
 =?us-ascii?Q?v0jiA31jR2JhfGZhrTlznBU5+O+Jgrl8qZOXtVrtH8erq0Pz5UWusrfUplqt?=
 =?us-ascii?Q?IU3lUi6I+FUaTSiqrjPt2ErwvIH+DA7YLweSvk2/6gpce+DJs/n7gOt+zB7r?=
 =?us-ascii?Q?sFBytm21F6D8lCPckAjfXbbMpofBfPQvBgE/IuKj7RUAcq5Xzumbg65ltMG6?=
 =?us-ascii?Q?XEQMZw0/4pyMfvf66fbDvyA7eYwusrfERTwBlw7gpCRo0pxXSxRDgAWzITij?=
 =?us-ascii?Q?8fdNnzbMBWKqzU19IDTKDU1lzLCgug2S3iZxlyKzUGZoFXOar88SJQW7OXq6?=
 =?us-ascii?Q?J6Y+bU9x16dlg/5SCNTnS5Sn4ZpCbsHMO85yqr/NmUbc7icEAfdDafY4L9HY?=
 =?us-ascii?Q?G4Wr0jBmOfCGHfVEjHqES2zWar1aUrlyzTCePpHI/DAgN1M1TRMkOujXxkA0?=
 =?us-ascii?Q?LKm/PMNK+4toxdLPM8nItnQ7IEn+wMFI8RIZ/tEvKywwjGz/6ZySAsBm/m0k?=
 =?us-ascii?Q?lbznKvH7pwkEQGYS7qlinErroLNnjyYf9WcBdqZP4rFmmNADskZ0nMKkaPhr?=
 =?us-ascii?Q?dKCwDlGn1lFVKyfv8y9+Q8xfhAo1lIFti+R17ZMrIQqNlxTl6e477nZs4r5l?=
 =?us-ascii?Q?wSPvdQDUuPznT19oCH6dbCgrGfVG2JtdLcYnWGpeON5CCO2vCcn1Cc5PpEQQ?=
 =?us-ascii?Q?g+dSzbukU34KvtPLHe/nxBMIEe9vP2jR1q4pe5Ovy79/KqO84n1I0DZro79E?=
 =?us-ascii?Q?GEgN60hLdYVWkYH8d1CDFDZ6AWjSi8sMrds/TZfVfn5Tr4DzjICaeectxQHB?=
 =?us-ascii?Q?qCEc75cbnXASCoZFngKRRLJFnTYD8RXqHlgArRKSzHrrVO86kz1FkUaPWH/h?=
 =?us-ascii?Q?EPbwcAKFaln6btVD4dzd7oj1GVlrT8KMr8THdtMfrWSQxF4Jj70/yashaswx?=
 =?us-ascii?Q?R6/I5xZvIWz6R+od3c5AskrCRmV1JwApkCumBGnb8UEFytvBKGOQ8VlViiSI?=
 =?us-ascii?Q?Zj4jD4N7TBZyy51lov58CXxUnPn/mg57e86aAYIGl+IOXtoA51UqkH/8M9Zb?=
 =?us-ascii?Q?pLh+6Gll+1vWZdtUK3CbMB64xYWVA0Eo+QlMFTNW2kMSUfPQdK0ZJ02X/j/P?=
 =?us-ascii?Q?y2ljLfARr1lnyBvfbx1qPG18bPtkLzdoQuljtPSiVh16P/veNNnwibaJFBkh?=
 =?us-ascii?Q?Iv1hLck5R1jDJfLeE+CvIuD0D0hTEWxImu82VRLEkn8tWaPVr7L5Jbiy3DaM?=
 =?us-ascii?Q?noqYMxFxldcu1hjkZ95Cao2IICFKW6KI87RfgVucMy1qiKVOqtrpEYY12ydq?=
 =?us-ascii?Q?dbliPJ/IWIdAHEjzaRSZgUKOTI3iMXnfPU+IpD4+BBqALy2+sk/+IgmUUZ6I?=
 =?us-ascii?Q?wt8taHdRqXJnV0fGbpghUAeZPWsxvrpvaG8LX0UHmem3lRNVxxN0fU33tTed?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: dc921926-da2b-4fdb-ac7d-08dd7698dba7
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:28:24.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocBHqWaJy7kFCiD3Z4g4D/FN+mnzX5r9TnPyRi6tmvU0YlfHWulEnXCNaVh8jX56r89TMCysXfqilJK0d5M+c6U+WSmpa3zhLE+SAUDR99U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6424

From: Lorenz Kofler <lorenz@sigma-star.at>

On x86 SIGFPE and SIGILL are supported.
They are generated from #DE, #MF and #UD exceptions.
si_errno, si_code and si_addr are modelled to match what
Linux does.

Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Co-developed-by: Richard Weinberger <richard@sigma-star.at>
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 kernel/cobalt/arch/x86/Makefile               |  2 +-
 kernel/cobalt/arch/x86/signal.c               | 51 +++++++++++++++++++
 .../arch/x86/include/asm/xenomai/syscall.h    | 15 ++++++
 3 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 kernel/cobalt/arch/x86/signal.c

diff --git a/kernel/cobalt/arch/x86/Makefile b/kernel/cobalt/arch/x86/Makefile
index 93929b645..e3d8eb476 100644
--- a/kernel/cobalt/arch/x86/Makefile
+++ b/kernel/cobalt/arch/x86/Makefile
@@ -1,5 +1,5 @@
 
 obj-$(CONFIG_XENOMAI) += xenomai.o
-xenomai-y := machine.o smi.o c1e.o
+xenomai-y := machine.o smi.o c1e.o signal.o
 
 ccflags-y := -I$(srctree)/arch/x86/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/x86/signal.c b/kernel/cobalt/arch/x86/signal.c
new file mode 100644
index 000000000..6da31aa4c
--- /dev/null
+++ b/kernel/cobalt/arch/x86/signal.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+#include <cobalt/kernel/thread.h>
+
+#include <asm/sigframe.h>
+#include <asm/sighandling.h>
+#include <asm/fpu/signal.h>
+#include <asm/trapnr.h>
+
+int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+			   int *sig, struct kernel_siginfo *info)
+{
+	switch (vector) {
+	case X86_TRAP_DE: /* divide_error */
+		*sig = SIGFPE;
+		info->si_errno = 0;
+		info->si_code = FPE_INTDIV;
+		info->si_addr = (void __user *)xnarch_fault_pc(regs);
+		break;
+	case X86_TRAP_MF:
+		*sig = SIGFPE;
+		info->si_errno = 0;
+		info->si_code = 0;
+		info->si_addr = (void __user *)xnarch_fault_pc(regs);
+		break;
+	case X86_TRAP_UD: /* invalid_op */
+		*sig = SIGILL;
+		info->si_errno = 0;
+		info->si_code = ILL_ILLOPN;
+		info->si_addr = (void __user *)xnarch_fault_pc(regs);
+		break;
+	default:
+		return -ENOSYS;
+	}
+
+	info->si_signo = *sig;
+
+	return 0;
+}
+
+void xnarch_fixup_trap_regs(struct pt_regs *regs)
+{
+	regs->flags &= ~(X86_EFLAGS_DF|X86_EFLAGS_RF|X86_EFLAGS_TF);
+}
+
+bool xnarch_is_supported_signal(int sig)
+{
+	return sig == SIGILL || sig == SIGFPE;
+}
diff --git a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h b/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
index 79bf17ee7..f317419b3 100644
--- a/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
+++ b/lib/cobalt/arch/x86/include/asm/xenomai/syscall.h
@@ -20,6 +20,7 @@
 
 #include <xeno_config.h>
 #include <cobalt/uapi/syscall.h>
+#include <boilerplate/compiler.h>
 
 /* Some code pulled from glibc's inline syscalls. */
 
@@ -135,6 +136,13 @@ asm (".L__X'%ebx = 1\n\t"
 #define XENOMAI_SYSBIND(breq) \
 	XENOMAI_DO_SYSCALL_SAFE(1, sc_cobalt_bind, breq)
 
+#define XENOMAI_BUILD_SIGRETURN()		\
+	__asm__ (				\
+		".text\n\t"			\
+		"__cobalt_sigreturn:\n\t"	\
+		"movl $" __stringify(__xn_syscode(sc_cobalt_sigreturn)) ",%eax\n\t" \
+		DOSYSCALLSAFE);
+
 #else /* x86_64 */
 
 #if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 3)
@@ -204,6 +212,13 @@ asm (".L__X'%ebx = 1\n\t"
 #define XENOMAI_SYSBIND(breq) \
 	XENOMAI_DO_SYSCALL(1, sc_cobalt_bind, breq)
 
+#define XENOMAI_BUILD_SIGRETURN()		\
+	__asm__ (				\
+		".text\n\t"			\
+		"__cobalt_sigreturn:\n\t"	\
+		"movq $" __stringify(__xn_syscode(sc_cobalt_sigreturn)) ",%rax\n\t" \
+		"syscall\n\t");
+
 #endif /* x86_64 */
 
 #define XENOMAI_SYSCALL0(op)			XENOMAI_DO_SYSCALL(0,op)
-- 
2.48.1

