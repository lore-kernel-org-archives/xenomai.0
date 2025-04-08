Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F369626156E
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115315; cv=fail; b=tce428/8xz9anIkZDJ2OnwEsDzH2+amW8jdviDopnSKHPU078Rs61yoXZx2z1vg+44STGmM9OaahHaeD8M98sMv0yOzrLSLj/FcHWE7J4AWXfzPgQPzhuoCsK0Rk+PvVTE77zUEqpl4sL1PRWPJqIslwzACZtYjnW+WzbS2FOrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115315; c=relaxed/simple;
	bh=IByier2J31lSpd3MwR2+OZZx2TxRB7ip90P61DXyUMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLUWnqAB77FKHIEw7D4doZEOTjrPJZIZMgaKzzXvSwAk7GsYZa9ZZoPCj/8DdFpQwqGq+YPXoJtWl/ki2T+itAmEO3EMRwsQedp4MMKTThVQxbPVvFkhlPB493zoodrUbEc9Zc9pLrIwFuyM0wnshImTvcXoOHYxYbpYiLi6gOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=v/TXDARX; arc=fail smtp.client-ip=40.107.21.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="v/TXDARX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWyBV5clAXC0h9On58hN9/5KNop5EWFIinDhVZEgPPTPLSx0Wc+EtaPfzJAh4IN6+bgIvgTiUs28K9nCQZ59nqG0UQgxYn+4wXecd0ICutb4DNSO8Mbgi6yaEKW0JV09Couk8zBElvzfFzeQBYLMR1P/eJ3tXrRG0IMwzSBPGmv6+wyNOLRAfmcv3TSy9BVFTWFVmCNYoynEeXOaviOylgoAboHX/UkpTLXhj7zQNX2j30D+h8t+ioEFDueM3NVxFVg2ZjB4U7oAwlZBI4B/NSZmS2LTuFRXQJAVuIVO0i5Mc6TNx6UJrYtkaKMa2nsx9+EBks6xHxV/Rn0h/vFEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7f4Nw+XgcFf3skwwfVZIwfhjzyo5qnZ/B4JSPzTSfc=;
 b=lWhEhbmWAOAI3qF02z5PUG+8Sd8jBjfj/cx1GUx6o5Wv2lxmyr6UjoxAWxYSYEcMTPFz/+JJV0HjTCswj6LjJKgsCZAdjFDSmDb0I4/XohUkECNhVA9aoutiOFum38DqfDItHkfVJNJzE3Gw8bpCYNu07k4EMMLOHMzWnkS7f9XD9lBrwF++koJCpi0l6+jOr7scxnWVrmmvflytE3QVmJsaoPHYObqeLpejou8itC6vBBjc7jGBxMxWpsxnI9zbAm1Uic2Sr7T1Ihx9tRmbA8XIsyUOmuCYpLvJsSTANaAQXD7o0vy6Mmw3J7vIOvTCAFjOvWSQgQ2X2X7y+dwbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7f4Nw+XgcFf3skwwfVZIwfhjzyo5qnZ/B4JSPzTSfc=;
 b=v/TXDARX7+ZmkIiTE50fNbKQDFPlBkZNm/l+zsZsuJ6lQcE7kFIDl69l6e1gwqL+4uUIGrv+XjdzLXKUvw3v9NBzSmVYOi5oUdYHtrZ+BD8zwMry8hRMBtr0Qm9qYVRFMTWoupnUxI+2LKUPHnZ7dxtkUm8Pg9vrnbtrhFJudMU=
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
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 3/6] cobalt/arm: Add architecture specific signal code
Date: Tue,  8 Apr 2025 14:28:14 +0200
Message-ID: <20250408122817.626897-4-nikolaus.funk@sigmatek.at>
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
X-MS-Office365-Filtering-Correlation-Id: bb654b7a-904b-48f3-a674-08dd7698dc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WKtBHfCrCIyFFmzar0uvdnSk5Pg72NsXOHcp9KHLbZpStCI5c0cqx4LKsGs8?=
 =?us-ascii?Q?UuR15uLDvCniSlLi3TzsDWLyo6j0l/D8JsBb/kHrZqIyPu6FWMlSWvVas4xq?=
 =?us-ascii?Q?+RPbikaRoOVCA5iBjOyi2aXiq1SWgulsJehgvJfl/2nTM3GyYkTmhjocOjmI?=
 =?us-ascii?Q?Xz0x2GLieLPtVbItfcw1mLvkMpl1nfZ0sxOyJgkTRpcul3azsRgNKfuCRDm5?=
 =?us-ascii?Q?gqUs0JAYdjD4Da5ZJqSp5ba78krYyEfN83R3Y8Jk+hAZVEfxQ5lenlj72qpa?=
 =?us-ascii?Q?Fzv+zbjdQv9Y/ZVGMinCW7gYWIeRzHZH0QurGqV95vCiqvcDofsyznGXmVAV?=
 =?us-ascii?Q?Sf0EJcRXzK3g0IG9Tyw+6pTN8aI5UZQKv1tNhJiy7y186kwq9z58lluqqqeG?=
 =?us-ascii?Q?T4/PaaNjBX7OQotDwNuV3ija/H7fc0So2Yyd8mA0is906+t76UvRSysDDFCY?=
 =?us-ascii?Q?IBcNlxjqLTLQ2zzhXKckEn6PpuGzRY+9l89C2OcrzbhIwnMVXLCjdxuG8DLG?=
 =?us-ascii?Q?8a4iE4VavdAM6eVo2bf41/vcx4AKJHhmTuLs4e7HYF54Gdomcp63RNJh29TU?=
 =?us-ascii?Q?ReobyK9L853xaEY0ulBSIvEw76r6sVglDlGRSTd5mCx7tjJAQqtW5NZVIpA+?=
 =?us-ascii?Q?P0Khwtmk3CFUUP22Y/3pW01rbhHt31jW2tOl6CQ+Wxr65nB0WyemWkFO/Rm4?=
 =?us-ascii?Q?49uBrA9SBvEalQ+FN7RMRrCSeeyPcJQAHzJIMeVCFU7LR0Pt1+GGJLTAb/Ru?=
 =?us-ascii?Q?yW/G4qUAFoY942FgHEriyqwEV2qcd7SSf4neLdWaeToXDYuvDiyIIyGtuEZl?=
 =?us-ascii?Q?z1bxVupmx1L1R2yFY07+Z9dxBknXj6+/vxBEgzJ8Tr0C5NneA4zi3FXsUyJa?=
 =?us-ascii?Q?9gInZHbeVX04ag+jfS0q8L88QRNrA5/J9MUzRSHcoX1uSkp1Yix68Kz8+p84?=
 =?us-ascii?Q?bKo2Gz4DWO7nuHTgPIhB3kM1vffksXIXTjMIjq1AgV88KBqxcIBink+hvt1t?=
 =?us-ascii?Q?jo8Qge6cNvizCXU5fx9jls9gAMj1X08+QrqSffWOo6O+42ye44CB2V3dewzS?=
 =?us-ascii?Q?P3ydbv03EUfY7HunjVSS99IUgddKFGfP4jnyDHM0HUiafrWhfV0hmsrua491?=
 =?us-ascii?Q?M/v7kJTqxlyYz0FPPmDElXiSxTfMluXW73upweXDWGAYrDztkyIBngVS7NvB?=
 =?us-ascii?Q?5BQJRgD8UlzIMiEksouYg24kUfBB2BablMOpL7ILqp2/ml5PN+7Bm1DjyO6w?=
 =?us-ascii?Q?vQFDWmc+h0p4Ezq2trppI5ZXvnhwY2dHK7CtDgo+J3dkAY7cFxeEEcageBZH?=
 =?us-ascii?Q?MAhgO1CjFTp/UeabqTZyXArgij+eee0+c170X+SbatWP/FjLSF99dkS+B+Rw?=
 =?us-ascii?Q?aEPyY+wcpF6nFNOyUa9apIzqUVlvcZ4D0mv4k/7qmUqJ1qZ4Pq11azBuOLtg?=
 =?us-ascii?Q?GuOMAHqU4Dms05z0FIFknVn7Q+LK9SoT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N36ILAy1d7m4wW2fnQz08TZiFLCHH8XDOew6xA+PqP0GP7XEZxbTPak3N/NL?=
 =?us-ascii?Q?RbqtqXS2rqjtd9lFWuYiBphQi5dmaS4xQVStOjVEvwWRx4l6YCCX+VU+SbU9?=
 =?us-ascii?Q?S9RzVOdhf/vqICebPx8HUzLJHxcn7pnbQ/Wl0OnD0ln9/XubTqSzKAbjB6NA?=
 =?us-ascii?Q?47k6nZCqIEdbdsD9jlaW+AZ91YJ/2wVPoLVIlhse9n4xt/Bx8rEAIkrIBM6e?=
 =?us-ascii?Q?p3pTjFI/udtyyAMM0LLzwtzHavSFMDbnvWH9X/gE6BmAs4DtW+VzfKpyGRu8?=
 =?us-ascii?Q?68sESI7qHHUspfx1RJituQTgriFNh498klBgdHXGZU37nERw2PtTpLyo3Qit?=
 =?us-ascii?Q?lvc5Wkgx/5Ph+5IkSEhFoBIAF6axpbFAX0L29rjPGAyrMEaHmcbpTdvGif7r?=
 =?us-ascii?Q?wBqvcGwTnQh7A9R3sR80/IHIyTfolqYKGVsIm/gclBkJRU3r5QdFpyL9kUcn?=
 =?us-ascii?Q?1fs9zPZbgZ5EC1xE8PBfS1E8URKhT4zGrCslEpYeTbkOTEXuEExIZLu/LWuL?=
 =?us-ascii?Q?VMwTtOsCryRXCQhy9yL+u+kQXBFa3bujMdL2ZG9f8kVITe9Xwna72LCECJD7?=
 =?us-ascii?Q?ki208rHq+VUeyJHvhsbk8e04Hy7lilY61m9fOOSYopy3sPPpwLR8eryLDuFV?=
 =?us-ascii?Q?P4cKtuGhYtPADno82T7efs+Kcj4bnI07OJAAueoiArMvDwBrQpJPfrVFDT1n?=
 =?us-ascii?Q?GfhFOqI2Mzezf9y7Z18qeIQ2gt+klFMKzzWYGiG8Al/lqxXT0r92filzBqg7?=
 =?us-ascii?Q?+ft1b5d0FyMu40x3nEgq/2zHnI/N7m5VUMpP+uLk5pj6B4CpoVHLC+T6NdyR?=
 =?us-ascii?Q?PSa8qFxHXyPH2bN1WaBs89jL7mkuRkJLbGA9qA8czVME/whbDJQx+flKhed1?=
 =?us-ascii?Q?5/yVurH7S+DeKuYIim4Id0ki7jb2eGo0CLxfgfpG9Y00F2jTH7596d5OqADK?=
 =?us-ascii?Q?TcULlWRUeH6Ip7piugxHhHqgEQp74+sdf/g21J8uhcKsOYaBW7aLtEDcFiTU?=
 =?us-ascii?Q?BB4lbc1EFGzA8lWoLNuGgj1rOBLeJ3BRGWIcTA9sV8zr+t/AzHOt3PHVHa1K?=
 =?us-ascii?Q?Da0uBpYzBkYj5oYWMSDGm/NaloTZ6Y06k7ZoOWxx5qaZ2JH9wx95F8BAz7Z+?=
 =?us-ascii?Q?hraETK3UF9x6yeJAq3A4uUR0n5XYw/KMbxy9uERpEaZXFZtr+u64SPTP2lL1?=
 =?us-ascii?Q?S/Vn64FP+FfvaIt4kBwjoimnllIEHOQqra4nJOwbB8Y6gJ8hI+xikbCn3S0d?=
 =?us-ascii?Q?XcxbV6RbExn6zKGpT8YpCgvFF+iSWTiHKMHtFxOxq2baQIf9QUJg+iLGHdE2?=
 =?us-ascii?Q?g9w1yJSK4eERWt3v47y6q79/Qxgw825ugLnNGmGZyhX6BaM1Zw23mbYjinbC?=
 =?us-ascii?Q?nT930dfYdmG6QRNSDr3ooZm4rCpvII4dU/MTQq2gI5Whpxe7k1mRtpcVMVK5?=
 =?us-ascii?Q?p0G0t0iZogMB2UeXFpMEddwHD1eTD8ypnWmV99JqQyg1/oiRn04QWevjVTBj?=
 =?us-ascii?Q?/6maqR9StDqyVgcoMdd8+k3++b3TMQ4+0bppBhc8yFfrQJ7/Qj2v/7uU5K5A?=
 =?us-ascii?Q?yaTxLfgrZs6Lijeoh3Itw2gW2ydt68A54Q6iPecm2uShmSflQ/bXid1xU8dJ?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: bb654b7a-904b-48f3-a674-08dd7698dc0f
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:28:25.7550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vjrMowzgg9jgFCnHXDGT+sUF+ZWvMZJ15gE4EPCCg9xVnfRfbi/Xd6vqRzdqtUVa9XJnd9vr69jFngabjJBLBtG00Zbs9N93+rL+AAMiLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6424

From: Richard Weinberger <richard@nod.at>

Add code for the ARM32 side.

The only supported signal so far is SIGILL, it is built from
the UND exception.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 kernel/cobalt/arch/arm/Makefile |  2 +-
 kernel/cobalt/arch/arm/signal.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 kernel/cobalt/arch/arm/signal.c

diff --git a/kernel/cobalt/arch/arm/Makefile b/kernel/cobalt/arch/arm/Makefile
index 13cbf84a9..d06d3d425 100644
--- a/kernel/cobalt/arch/arm/Makefile
+++ b/kernel/cobalt/arch/arm/Makefile
@@ -1,5 +1,5 @@
 
 obj-$(CONFIG_XENOMAI) += xenomai.o
-xenomai-y := machine.o
+xenomai-y := machine.o signal.o
 
 ccflags-y := -I$(srctree)/arch/arm/xenomai/include -I$(srctree)/include/xenomai
diff --git a/kernel/cobalt/arch/arm/signal.c b/kernel/cobalt/arch/arm/signal.c
new file mode 100644
index 000000000..703230229
--- /dev/null
+++ b/kernel/cobalt/arch/arm/signal.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <cobalt/kernel/thread.h>
+
+int xnarch_setup_trap_info(unsigned int vector, struct pt_regs *regs,
+			   int *sig, struct kernel_siginfo *info)
+{
+	switch (vector) {
+	case ARM_TRAP_UNDEFINSTR:
+		*sig = SIGILL;
+		info->si_errno = 0;
+		info->si_code = ILL_ILLOPC;
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
+bool xnarch_is_supported_signal(int sig)
+{
+       return sig == SIGILL;
+}
-- 
2.48.1

