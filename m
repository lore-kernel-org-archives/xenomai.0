Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2112.outbound.protection.outlook.com [40.107.20.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DF26F461
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115687; cv=fail; b=HEZ02mBsPZUj6tZrtuObzaH8/PF/zMdvwZujFv5R9TGEuxGyalxzwQyDNqxKGQmLuXpZDbBq5JJTnAt5L0KPcgs2CrNyTnPWSxvnFPPLTK78MpwqPAlRt2c44aN0EWHs61b+OKlh5mt01tA8dulxYK8PVL+tBmi/i+oiFEqZEZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115687; c=relaxed/simple;
	bh=R/4DSU4S1kS1k25PNSKzWvmY3eOaQxMypTZ/vhVGbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BKmJGdsqmcr3bZ2ox2Ce2yexkSmXWY/8ypFmBhnkLfAZnBlbds7SgVmY6oXgdUmu8vTMr5NK6BuiFgBWXS6mNCQOOACV5dsQ/qewBBhDDMsfvsIVvM0n2K3IKt38cS2S+kdwAo/MLl0e+EIRrQyImQTjI8vsyH96yVXVBXaF/D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=cQ/8fc80; arc=fail smtp.client-ip=40.107.20.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="cQ/8fc80"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzoEkV3nBzaZZIahodvAIR2SL1gXIdok1fqYNXQq0ABw8DGZ8JFn+wKdi8nnOW/NAUA1qdCF+382Fdo6RcghjbNudrmLqRr2X3qV6ZvViR+73vaz2hpl2/lgfcS0u2uozHj4VinJseKF/uH+O/Tu7IEzNa8vzpmIBbI70anLkF0lPTDtPMcOtnXVUXkEeY8R0dBVnEgXRbOmkY48vWbC+vdZWF0tXxsdgGj0zBkoQ+7+qbIZ5rTYO29uJ7UgcPDHDFU00PZimab5EFomQ2pkFat4HxQwSgXi7peImJstlxE8rs2ufoEIFvNRWV8pdqVD6Dd8WG8KW9SnhOSKo7J/Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuU+kPkms0+4XuLAHf8bPYWuqzSAQApB7fAzVhkfv7I=;
 b=i2+c58q8r62mMGaAlsH1G2KeQ27VEtORXF9t7j688erZQ800SpeU4AJ+yQlu6M11HSz3HJWiwwT5bW+/eRIvjo2lO0oUxQ31gXedJGX+ySC3uuQwQRFGFPi2XANiO8tQCB5w1We1/QnLWUU1/G9S2KqkgmFi8f2KWlgGzzI0bWYTc0WP/TxVOAQ25MNYqJS1u1ogZ6lWf2m4WgajzkvhAEcAFfRy6JBXDzCsgxb4wNB5YC4lS+AeE37WeKfqfa2pNZE0o8ku9N9rXN3hjBKc/Js8+ESsaZKOrsfALlqwcIGZRETqO+OVmb6ioL3LJVHsFNhOVF15Jc8ApHWr7zImSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuU+kPkms0+4XuLAHf8bPYWuqzSAQApB7fAzVhkfv7I=;
 b=cQ/8fc80XRB6gumdlFQh6pWQtpa+U2L9ZZhjUY77xQQVXLtBpLdn8KBfM1bE9zH0iPXZQ+sssY/aKQFqSEc0VvQotqxqwYiil8eb3uuykIXNyYp6S3XNY7JCuxB0dB3/IURF5iFlPdn+oGyKYjMwZQpQR0q8Gs7g7yR3BxloKmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by DU0PR08MB9026.eurprd08.prod.outlook.com (2603:10a6:10:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Tue, 8 Apr
 2025 12:34:38 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:34:38 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Richard Weinberger <richard@nod.at>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Lorenz Kofler <lorenz@sigma-star.at>
Subject: [PATCH 4/5] arm64: dovetail: Helper functions for signal frame setup and restore
Date: Tue,  8 Apr 2025 14:34:22 +0200
Message-ID: <20250408123423.627477-5-nikolaus.funk@sigmatek.at>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
References: <20250408123423.627477-1-nikolaus.funk@sigmatek.at>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::15) To PAVPR08MB9037.eurprd08.prod.outlook.com
 (2603:10a6:102:325::13)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR08MB9037:EE_|DU0PR08MB9026:EE_
X-MS-Office365-Filtering-Correlation-Id: d3013eae-c7fd-4481-8817-08dd7699b9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bKPDeACdR73ZEHB8bKVKSS30f87QLqG7xDyVVe7usknAIssYQClcNbE9RHyJ?=
 =?us-ascii?Q?Wv+w2Ce4/gXLLlwuiTdMzyV3MgFaDViy3d8Xh5MWmyDgcuwGz3FEVRf0xYSb?=
 =?us-ascii?Q?aCYXDK69CeU5SV4Ip4Le1OUh2+v0r7YKmdNtD0lGJUF9eIhdh8eowTZVwyrj?=
 =?us-ascii?Q?VA2/dwy7u1AiqTieZxGDIZNjagR/vZV/t5CpYg6anNq5A2ZymsdV55fattol?=
 =?us-ascii?Q?cHk96LZygkFzr+jb2iMls0KZsM7wULmHk+NsijeXoHGM3Y+IsGGenj7YqOV0?=
 =?us-ascii?Q?lW0QRurrApQKTMfFAS2MT15KP5ZoC8FliHQKMKZ1MUawio6pYkbv4IslGY0E?=
 =?us-ascii?Q?eo5HWWIN6QsNIX/MimE9frKx0XtZPEZ7j5GDUn1qy3kvUr3GypCCNIZL9cTz?=
 =?us-ascii?Q?aklPtAiZKuakDLm88UTDj+nCXrnVxdlRm57o4NdYeOK6sVH8rH4vFgpkSAUq?=
 =?us-ascii?Q?o8GAeatH+hrfzWPGWEMzbryW0TqAchMt80ppHuWU8mLRukld4D1a/Ro+R/Um?=
 =?us-ascii?Q?1TCAPRjQyvzSlTGklr7azOUYAG7+OG05G77Fz9bQyN+q2ejuq06fP52nQYEe?=
 =?us-ascii?Q?VZ9nW0u2CuShoUDWM7732rYOFfQoPgjAF2djL2UGWm3TaqpN/Bme2tvc6rmT?=
 =?us-ascii?Q?zHFnXDxSKsZG5FF9wQrITjrs/sauOK8kqqNbl5z8A67+L1CEpkssgaq7/KMG?=
 =?us-ascii?Q?QB7Q+bnIqHXrg0B40hs4narmb+oCza9sPLrQLeBAh1GPWUMSuw6fprfPDoMM?=
 =?us-ascii?Q?QYAn7HhGaiY38bMHFgupkFdc4wRcCLNTAcL4yQR34zy1kayYXIwUilk0GJHn?=
 =?us-ascii?Q?8OI8xKof3RzXQox5Ttb3glvSn8HsNdlh9g0m1qGUxgAdorMcv3jlL232tl7e?=
 =?us-ascii?Q?XEWbKJS8KnA99M6mgQmy3GivrQ7XT8UhuXFEVQtjvFnDRdU/aQvNbyi7imSs?=
 =?us-ascii?Q?ZWMEMsXg7lyzbYDmZa9BE0Pk2PCaXSC79JJy+GpfcEuBPimmTKCNjRqiJg8h?=
 =?us-ascii?Q?wd3diWSmpUx3STuRikpLxv65yV3YDtpNBAHW8mzvqNzrFAsZ0pYPyoLskRHH?=
 =?us-ascii?Q?r8yM3iAhoveI+OK8AE9cUzn8aKBT2mtOzToWAqhmc4tXJn//2KpDL4JANc0e?=
 =?us-ascii?Q?i7HKXc61Pgg9CNuRqeOwkkecwaqcPwa4UfcV1eqCsAEKAvA/if9ZPGQqtjP9?=
 =?us-ascii?Q?WS2MJQh7NoCU1VeMAZv7n0Qff7QfLy/G4kGd2WoJ/lfP0GkSoQt5CNHmrcEf?=
 =?us-ascii?Q?/U3i1rYbbBCcUVno2IxJJM6SsV7wnlLNDor9GgLKHWIQ6kgbxW/0U3wu59Zk?=
 =?us-ascii?Q?WVXR5r7UVUqLMICYS0QiaE5OzZb1aEYv6npBoDQQFAiEJ81E6SOu8s24XYfj?=
 =?us-ascii?Q?1ctaqTzaefx6tISgd3oEWBEm9ikd0VqzlH/X9PXF2B7YtUrWHlbyECJMa+vZ?=
 =?us-ascii?Q?9Alm33X/lZD5hMF9Y50e+CqfwXFhx212?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EOJjieF68ekbm5Oug8+hKeSRL3d3wfx06F1WwPRCeoYBPBWNAwWdfZ2TP52b?=
 =?us-ascii?Q?2cy8o9v4D712QO/DwXEtecQ4XLCedjtE5Fl0qlcqP/IVUL06gJe8W+JxsX1n?=
 =?us-ascii?Q?Lue81olX7FWk8y/W2ro8/l+CCG4OlVsnv+ncHwGurB47HZbyZj7CoOCf/1J4?=
 =?us-ascii?Q?5Z0BvNf6d/CHu1p9OPmQTUS98AIQ0in0ADhg2K9ljfLNYMb+tCqQocdkPzAQ?=
 =?us-ascii?Q?RUzC5mNoCEtMZWYuVpQbaONXeQCNaiYn36v2gybubQITj57vNl7MAdMdC1SC?=
 =?us-ascii?Q?r63vKJUOWXidy/bwUltyDWq660bi+j1Wi9ZnpPCWAXkr16hBNuBqWkQFr87k?=
 =?us-ascii?Q?yPwIWtsSdcoU/G3ymzP4++yUToUEHryHJKSAWxoCsl+KFOMQzS3xrI8D74qR?=
 =?us-ascii?Q?Bb7Rd5uLHMhPP8a37Yuv8p63q92+eiAGReN0zEwF9GIKLzw9a/KnlZkXk3YO?=
 =?us-ascii?Q?pIEjoagGnP+BP+Bh+CZ+zDF3LDipNYKfgcR9dQ0Pm51qXwkVWSbSV3tz/6qW?=
 =?us-ascii?Q?FCr9rH++znkiHI4tZ5svO5Z3yWEoYN6tRFknWXcPbyuRqwDnJ1tWXshecqYf?=
 =?us-ascii?Q?6IvlywjhcMOZ/ud3f8TeJTI7CBhR4LWrG7wAqg10h3lNVINP9AO0vhT+EY7M?=
 =?us-ascii?Q?kP/okE5AmTF0uEz2MRQCJ40Ojh47s2EqjH6/tpZOwZzQriJzzFviQ7ntNMM+?=
 =?us-ascii?Q?vfBka7iKtAMpD44Jye52ZlMQItKQPZTWAWY4dIXXFSMqUKEfqAXqbloj8JSK?=
 =?us-ascii?Q?qRN856JW3ODXrlL1nHSXspjTd7AZFMzsrfIBMCDyYQqH0SCwP6vS1ce74BFZ?=
 =?us-ascii?Q?O3bOl2EabFs7myTAUbfdxqs2ccmrvpuKWPJQ5/QtABEmXxj+zYZPNxkdX4Nu?=
 =?us-ascii?Q?ooaICmX0471fqeZ4PBggKIbaks+G1MdKmVoi6qxBZenWi0zjDsIkho8ONM/c?=
 =?us-ascii?Q?IRGrQLOh9FeLAhWLuIPwBgeNd/TegTAYOaSRGc053fD2xfy3wPee3GnzhY9H?=
 =?us-ascii?Q?h59Pb4mNCd4U1Um0tPgYznVj1nowWjR5v1P2HePqSLefQfq8nXg0xbPL9lkt?=
 =?us-ascii?Q?1s/4FI+ZH+P1Kt8MeWJg997pdTlqwWlVzbxbqzFgeAv9zkngS7P24XRp8RdJ?=
 =?us-ascii?Q?uutdJYgraRaNun4fKT1P1xRuVeDGr/g4dHoHHt6MQt8SMNTzL31P3Ir5q25Y?=
 =?us-ascii?Q?Wn4gD5b3Gt6rDnAbA7NFLwGFPnQS0Hp6jqeX84XIiO+Ftf80VxAi/nHiaewv?=
 =?us-ascii?Q?wdBSDtrThrEHYe0Pn+tu+ywLri3fCvb49i6E/pax6MB/0HUiQmQdvk+UKQhF?=
 =?us-ascii?Q?ytKMKnIoNBMU3Z9n2950Qgl1+kBtmZyRe5UV4fOxICH6EZ+SJI4Tk/sAB/3o?=
 =?us-ascii?Q?JBgztv+cyP0orNZ3XfR6ueZF6fitm0gM4g2a0vVkpDG6ClwZoDayTNiXacYQ?=
 =?us-ascii?Q?y33IeLyhHsaFbfN7nO/4syX/HXX32ptfV5gDxE/aFhGf+02DjW7+uJG+e2y5?=
 =?us-ascii?Q?5uXX/W57ghl9kZ/h7uOeE5bSscYzuGwp/92RIQSJJbIdnlZ9pwHgpl+nGiRp?=
 =?us-ascii?Q?5MDjWTc8c8p33XAn2XHXEXhtOHXhwYbtNRU71xmFYvGlzFkWw2wgT0YlfbpS?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: d3013eae-c7fd-4481-8817-08dd7699b9e2
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:34:38.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Toc0/0A8VYJ4oTHZEaE7pnraGj1/FS+SnCcPMUvO3oGKgO2FbT4QbbBfjK3+0xvW27g4ORC0JdueQIcrdRNhVjl5ziH+ftrGsXIhz79BCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9026

From: Richard Weinberger <richard@nod.at>

This introduces an interface for handling signal frame setup and restoration,
enabling realtime aware signal support within Xenomai. The implementation uses
existing Linux signal setup functions to avoid code duplication.

Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Co-developed-by: Lorenz Kofler <lorenz@sigma-star.at>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm64/include/asm/signal32.h |  3 ++
 arch/arm64/kernel/signal.c        | 85 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal32.c      |  2 +-
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index 7e9f163d02ec..cfdd691aeecc 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -60,6 +60,9 @@ int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs);
 
 void compat_setup_restart_syscall(struct pt_regs *regs);
+
+int compat_restore_sigframe(struct pt_regs *regs,
+		struct compat_sigframe __user *sf);
 #else
 
 static inline int compat_setup_frame(int usid, struct ksignal *ksig,
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index ad388cb248b2..1c3682abc897 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1688,6 +1688,91 @@ void do_signal(struct pt_regs *regs)
 	restore_saved_sigmask();
 }
 
+#ifdef CONFIG_DOVETAIL
+int dovetail_setup_rt_signal_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset_t *oldset = sigmask_to_save();
+	int usig = ksig->sig;
+	int ret;
+
+	pagefault_disable();
+
+	if (!is_compat_task())
+		ret = setup_rt_frame(usig, ksig, oldset, regs);
+	else
+		ret = compat_setup_rt_frame(usig, ksig, oldset, regs);
+
+	ret |= !valid_user_regs(&regs->user_regs, current);
+
+	pagefault_enable();
+
+	return ret;
+}
+
+static int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
+{
+	struct user_access_state ua_state;
+	struct rt_sigframe __user *frame;
+	int ret = -EFAULT;
+
+	if (regs->sp & 15)
+		goto out;
+
+	frame = (struct rt_sigframe __user *)regs->sp;
+
+	pagefault_disable();
+
+	if (!access_ok(frame, sizeof (*frame)))
+		goto out_pfe;
+
+	if (restore_sigframe(regs, frame, &ua_state))
+		goto out_pfe;
+
+	restore_user_access_state(&ua_state);
+
+	ret = 0;
+
+out_pfe:
+	pagefault_enable();
+out:
+	return ret;
+}
+
+static int dovetail_restore_32_rt_signal_frame(struct pt_regs *regs)
+{
+	struct compat_rt_sigframe __user *frame;
+	int ret = 0;
+
+	if (regs->sp & 7)
+		goto out;
+
+	frame = (struct compat_rt_sigframe __user *)regs->compat_sp;
+
+	pagefault_disable();
+
+	if (!access_ok(frame, sizeof (*frame)))
+		goto out_pfe;
+
+	if (compat_restore_sigframe(regs, &frame->sig))
+		goto out_pfe;
+
+	ret = 0;
+
+out_pfe:
+	pagefault_enable();
+out:
+	return ret;
+}
+
+int dovetail_restore_rt_signal_frame(struct pt_regs *regs)
+{
+	if (is_compat_task())
+		return dovetail_restore_32_rt_signal_frame(regs);
+	else
+		return dovetail_restore_64_rt_signal_frame(regs);
+}
+#endif
+
 unsigned long __ro_after_init signal_minsigstksz;
 
 /*
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 81e798b6dada..4b4088eb49d1 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -179,7 +179,7 @@ static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
 	return err ? -EFAULT : 0;
 }
 
-static int compat_restore_sigframe(struct pt_regs *regs,
+int compat_restore_sigframe(struct pt_regs *regs,
 				   struct compat_sigframe __user *sf)
 {
 	int err;
-- 
2.48.1

