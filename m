Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9E4269AFB
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115321; cv=fail; b=DzgKzgoUIf2Uj1QWy6GhKxpSlr/8YOmN/HHGx4qig5Hj39BfZStecpkvuZWz481JDquaJ9doTjJG+/hEEKb41WD32HDlL+kdrnYhFUqJTdo44vj5X1y0PgUyG+HfcOGjnK4V63Cv30puhEOLUoHpZiDcEA1LhU/4tlgtiLNo7Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115321; c=relaxed/simple;
	bh=JNXaxCgU3WNDBi4+jgqUv7tIGIeiXO9qXEafdgXXJ6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r6CJjcwH5Rm+6gQWZCtaqZiNY6xIrPIngd8L7XN6teN0GHvD+NjObbjsbaoJ8xjlNbWh7Bw9o8gOda18miT1WM0oK50Frzbcj7B21MJ4LAt2YdUO1Xcb42q0+j13V4Dbwsh2tG5+MEP17TRpVL1R8ocuqIRc6tUzKUV5a+/KaGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=MPho0y9l; arc=fail smtp.client-ip=40.107.21.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="MPho0y9l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpVS8Viz+iumifeejIc5sG4T3teBg8M1y+RUrBIHkrMrJM80FAHa+KUEzq7FmrQL/BU2GnPzZa3SHZEfkH2mFBH7NtW8DME3aZJWu2oep3sb4rtiMhfZC8p4uXJCykex0YQSyl9Ok8T8c3XgsTCAfNrSgURXyPGsZee4syhnHTuCvEss6QnIOHaFmFSPbKF7PgrvKOHkJqyHcWVbvKWj9d7xDksZE0AsUwb1aLBFcas1Q4nNDRLC9439CjojkQBVD76EiyZ+NPrTYDo+4Y5y9jmm5lJUmnSXoNNpROc+T4AhTYCrGXdlPuQdWAgZxKDcexJSCh1Ev2N7Cm9Csm8aJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsYn9p8VdFIVp5MECQWe3A59fcJJYqc2YfCEu9L+u2o=;
 b=G4obw+WprLupsAtdvp2pXMtoytDFcYrFsCfrqKb3ibkHw1gTJXQfpAXDjilQIjiQ29xg2lvxF3kRjrd/m5E91ScTc3nde57aQfIPwUQcKRrJ6WaWhdSt9XL/xu/+K9YKhdylfmt4k4yGXKUCPVZSmNb/NsbI4D0ZTr1X2pih4+3lrfrvrr8he4ol2N6/GJTXGan4TkMAQKZb6wDZw2b0dfiJ7BQHKpCgNP83xkPeSHDL6Zu291sueL54NwQgahw1h+AIaR+Q28Cuh6DuHPrSeNHresYqcPe0LR+MQaHcuP6Vua1Xs55QMK46rNb+gW7gLVQ4nSQnwKRjeekY3AjMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsYn9p8VdFIVp5MECQWe3A59fcJJYqc2YfCEu9L+u2o=;
 b=MPho0y9lqZMME69wu3rJ2Hz297Jfk0W2BRVTJPxJ+oFMUDmQTp8tMqckbzO8HOrfJp52jmjcwHP+nXKWqTSiB3Kww3RCrajaKHBTt7xx+tjasaB53fow3Vn7tj+BYZcTjRZZUpIcLCqQiwg2XHKgWyLSfb+t/Fh9Ya+SG8KL4YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by AS8PR08MB6424.eurprd08.prod.outlook.com (2603:10a6:20b:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.28; Tue, 8 Apr
 2025 12:28:26 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:28:26 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Lorenz Kofler <lorenz@sigma-star.at>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 5/6] testsuite: smokey: Add testcases for signals
Date: Tue,  8 Apr 2025 14:28:16 +0200
Message-ID: <20250408122817.626897-6-nikolaus.funk@sigmatek.at>
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
X-MS-Office365-Filtering-Correlation-Id: fb7bcadd-c8dd-4028-9364-08dd7698dc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f3QBuQy06png6m5xd+Perjnbe9NsleJBxdWOAGbZSzWq9KWX/ICzGRv1nM/u?=
 =?us-ascii?Q?1N7qMgFKtl37tT45FbtlkB/p4wVxr/SY4ZhZsMDOeU/9tvbolZZrkuyb2TtE?=
 =?us-ascii?Q?mT6HNnNzDkiFOc4ND7+Gw5A/8kjYZrbeaDmQyKSCzX26IFvR3bH8Wl5Rb0Zm?=
 =?us-ascii?Q?I9vcDs3zsQQJ2upmlcNXFTymULpiWPlHd4Vo2fJH8MxNQodOkgjTzA+VMOFV?=
 =?us-ascii?Q?hID5i/L904ZuUwBpjWAk5mlt0WDrwah4ARvMVByWo7vv3e01d4e/2Xhq0/9S?=
 =?us-ascii?Q?3uwecNu581qKxYt7FDNzJ66/OrWvWjT/OZmK4nmhf0UNNdjNQ82+1E4ck49d?=
 =?us-ascii?Q?C4E2OQrP1zMIJlvGnrs5yNgjPAmqbSPCTEAyYt2UsZwdhk3pJWuzZwvLsp+O?=
 =?us-ascii?Q?zBUKgmttecEzIKF8wkSMdQHpBOx0Us1659n6lEOQ+ioTc1ewD57wAYzq180o?=
 =?us-ascii?Q?xLJwkspKUJC0r/Q/SQvNzZjXzxCBPxN+JQG9T/LX3uGO9/OOJFF9fcv6u1Ay?=
 =?us-ascii?Q?IFRT6RMwXOfHDuCUvIZ9sHzXC2ZZ/1SItb+8owW+va48VtQcOpKhsB0fwGK2?=
 =?us-ascii?Q?gqOH7CvDISTE5ChCcKYtKzBw0Dzb/CrlMpQLpwSa0RjButwTSau/24K+jKwl?=
 =?us-ascii?Q?Em3V5p9oJb7qAFRYEoNLRSxb30EMfcyPCW4D6RQQdNT9k6AnHTWFT/h/r8X2?=
 =?us-ascii?Q?vsJelFmNdfIhA0yEnlRZs/Qm/PtFuVLwjPM7MqZdr22ooU5SfQdhP/igyK7z?=
 =?us-ascii?Q?o3e+PMFE2vKE7LQLRcjv2qP41hJRYbmkKQ4DXKJrQwEJUCe+TCkTZ1LvnYyK?=
 =?us-ascii?Q?zOFvNQsdvgKT56xF8P/AkI831zcAtZoeD+PbgF2YJ202h7pfjTwvq/GYFoNs?=
 =?us-ascii?Q?TMLrnzOIUegLY34miRl805hQSXQMtUY3ob0/tgQ3AXP8hN0rp3kRlr1klIe9?=
 =?us-ascii?Q?CNtuRT2yGY6WA2NSF3RsGJwNVXelgVS3BpS3IuR7SrTInK1//Jicb6uRh8M4?=
 =?us-ascii?Q?5j4kcydzcXpjqhAKPozl4J4Tui+ju0FEjVjk1OdpdwjVFwYNoC6NNhByVW8X?=
 =?us-ascii?Q?gJKaiYgHh0xFrASl0dYK+tSgEb7LonNfGS43M6URQ5xa3Tly79yRN3EmFpIB?=
 =?us-ascii?Q?Mcs+8wNcunmcyYXmmhNl0Q3uj/AAyxIJWcIVtWBqsBc7eQGFyezYN5ItCstY?=
 =?us-ascii?Q?SzQDhUHwQGa4Df8k+uKA+1yx5SymncKlE4fFvsze5PnzX/9RXAOYAfhdI1tu?=
 =?us-ascii?Q?BnMi4sSdxaSyFVwfrwfcsXTW1spEqs2Xx25klDjGCnW258hhcuJ+L2XcP8K5?=
 =?us-ascii?Q?vixMxnOwys1QeBKw75EF9w2ruXDn9U7h9RItRzE+pyDm5VxAIYE+fUZE8gs6?=
 =?us-ascii?Q?LQnADOjD5IzvFOSUH6gxY3unBQKy1aoZkReZCWCKV43TctdRVLVwb9ngtLxu?=
 =?us-ascii?Q?449lNOtWAtTjxTdoXgUj3PYAmZWD1qOf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z4eSwfHFAypC0BHiWBnj+KIxx8TlbcmZ/NjzB/IDtagcY7W/0UZX8V+o/CMd?=
 =?us-ascii?Q?rXj6ro7mV4jVcL+emVMv3j3E6LAJZojr9/upubkitTWCHks96EJMzfSflaNz?=
 =?us-ascii?Q?qO5KHxa8BvQvV3CaXvS0Y/Gj98+sz1LsAc7YXS+D8+s9+aEe60wWh4LxnUYz?=
 =?us-ascii?Q?KwGTUR3JTJLOjSI6PLMe9Zx5Wv4cwHHY7E+xwNbcK4bwwQAZnsdZSbBMMEC7?=
 =?us-ascii?Q?3aRC4SalHN7w4w0lnZuvuttxjSgmweNgY5IE/lbUHKwck5+WzLYxZ8XNJ6t2?=
 =?us-ascii?Q?oVpozPRfaieUKWbaF3MN+MyUAnS2LLh7ep/doMjwwAxNetDY4cGBHbnEQlQO?=
 =?us-ascii?Q?+hJ+JFQC69GcwN54l6kwhS7o9+Ry4DTsUrrmK00P8mEdTdqaRbcQPh5mpVb4?=
 =?us-ascii?Q?/cAzYE9UPAKmxze5sYjXKi/RRQnxgpiPYxGY0VBIMkE2wTu/ep26lIhEjIaG?=
 =?us-ascii?Q?l/vmXEfxCWaT5tLnI/VXasYhYy4Qli83vXdpHB/hj46B6H3yEh1wXPG1v1aG?=
 =?us-ascii?Q?FqYEqAe607AqYkAyxyTnGh/VipjOU8TOTkIc/gXB3bblHa3t0rVsoNKvBi0p?=
 =?us-ascii?Q?a3tTMYuqTNb2KD7a9uvPezoG9SZlZK9Nk5w3P2iBhkmb8uhFXSNxgFXn8AFK?=
 =?us-ascii?Q?wAFuFMLS7LkypRImgpPdvhqsIaeqHddlkFKYo2aEUdbEhzkCEcZYZfQ6AsU9?=
 =?us-ascii?Q?K8PoIKR36yD6O1QlGnrMwMdNylDKJdyW9cnG4h9XzUX7wUI+Bpp//w/7Q1Fp?=
 =?us-ascii?Q?w9Mf5rE0lMnbgmVqkdIi9fcpNDMji5iSqTG8sLdlD91MGuY8d/QdK0wnmsuG?=
 =?us-ascii?Q?nmRO/5H3QTMaq6AIfmfqYyRfIcTkAEHXwNP8gRQ78XWHLQ8fcC2IOftTMfiq?=
 =?us-ascii?Q?crcX+lUiW2xK+g6bRT++/JoHLYYHfIjmleMbez0qqtDqLncsU2mDjNryEfBU?=
 =?us-ascii?Q?gCXSdJRoWzoB1vSWSv6SmX3Ha/hfOKWr6D+klLnQLwyH7fsT1+x+81v5JqDN?=
 =?us-ascii?Q?UcOR90PabX0ZJx8jzLoRgkVfmCQczoXBg8NdfuVRTGdmkUwlo7IIL3iMpSko?=
 =?us-ascii?Q?Y7mEkiB+vru+UUmbKYXmVtABgchifGfsJL4hxiqG97cJZv4BuGgnYohOMDFJ?=
 =?us-ascii?Q?th7PBkxE0tTAErC++eO7GdI3ri2rYlfYkjF14NzRo4lIcLuto6uTuRsMyt/r?=
 =?us-ascii?Q?rA+kn0vjDeyM6UeyehTBHX9BULc5j5NNb0cNlRx4fqqSvR7DcBwkIlMJLEeN?=
 =?us-ascii?Q?x4ubJ7htMP01pK+atO4LGV8i858Vn4doyxdXNvmDKJE3qPjsMqB06Sud6/Uv?=
 =?us-ascii?Q?dHMoQNMtvniByKYnDODhznpS4u8+ovbpb409mGewVUDltnd/he1So/K3vuwI?=
 =?us-ascii?Q?stFJ6s0mT0ladrZG2/8Vi3BgscJjslRIerFAr2kbzhIlPXrRVQuPRN+sWY0s?=
 =?us-ascii?Q?v4xV5GsEDU1man9qkMpzsz0Wm4xwzIHIr/I9Z8b1K1s0EsPunWvG5CX2TEMB?=
 =?us-ascii?Q?rTi5xkNepIyfARhdQqJBIDXrgEUIN9fY/0PyFqfZNX4r5Pr7UvvhqDDOdq6a?=
 =?us-ascii?Q?lyv8kHxbaro4nk3v8SC4YncaB3T0YsXlO6U9y3o/ve65ycLB9YcvKQPQV1q2?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7bcadd-c8dd-4028-9364-08dd7698dc92
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:28:26.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMRjZt9tnxCXWDBEBsJNs9IyNAXjiREfIo3SLy/p5FFUiaij78eNs2qY+CjpRPBcYpovZtOQePZM0uPGNnJDZPB9dPsSM6n0Gy5svLtO6mg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6424

From: Lorenz Kofler <lorenz@sigma-star.at>

Adding multiple testcases to the smokey testsuite to ensure signal
handling works properly.

Test scenarios:
- Default: Ensure SIGILL handling works.
- TEST_FPE: Ensure SIGFPE handling works.
- TEST_NESTING_SAME_SIGNAL: Ensure nested signals of the same type are
  not allowed.
- TEST_NESTING_DIFFERENT SIGNALS: Ensure nested signals of different
  types are allowed and are handled successfully.
- TEST_MULTIPLE_ILLS: Ensure multiple SIGILLs after each other are
  handled successfully.
- TEST_UNSUPPORTED_SIGNAL: Ensure registering of an unsupported signal
  fails.

All test can be executed with: smokey --run=rtsignals.

Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 configure.ac                                |   2 +
 testsuite/smokey/Makefile.am                |   2 +
 testsuite/smokey/rtsignals/Makefile.am      |  57 +++
 testsuite/smokey/rtsignals/rtsignals.c      |  35 ++
 testsuite/smokey/rtsignals/rtsignals_test.c | 370 ++++++++++++++++++++
 5 files changed, 466 insertions(+)
 create mode 100644 testsuite/smokey/rtsignals/Makefile.am
 create mode 100644 testsuite/smokey/rtsignals/rtsignals.c
 create mode 100644 testsuite/smokey/rtsignals/rtsignals_test.c

diff --git a/configure.ac b/configure.ac
index aa3794a5f..678e8ef1e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -174,6 +174,7 @@ esac
 AC_MSG_RESULT([$target_cpu_arch])
 XENO_TARGET_ARCH=$target_cpu_arch
 AM_CONDITIONAL(XENO_X86,[test x$target_cpu_arch = xx86])
+AM_CONDITIONAL(XENO_ARM, [test x$target_cpu_arch = xarm64 || test x$target_cpu_arch = xarm])
 AC_ENABLE_SHARED
 AC_PROG_LIBTOOL
 
@@ -1102,6 +1103,7 @@ AC_CONFIG_FILES([ \
 	testsuite/smokey/alchemytests/Makefile \
 	testsuite/smokey/psostests/Makefile \
 	testsuite/smokey/vxworkstests/Makefile \
+	testsuite/smokey/rtsignals/Makefile \
 	testsuite/clocktest/Makefile \
 	testsuite/xeno-test/Makefile \
 	utils/Makefile \
diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
index c49a5d77f..5bfe10491 100644
--- a/testsuite/smokey/Makefile.am
+++ b/testsuite/smokey/Makefile.am
@@ -41,6 +41,7 @@ COBALT_SUBDIRS = 	\
 	xddp		\
 	y2038		\
 	alchemytests	\
+	rtsignals	\
 	vxworkstests	\
 	psostests
 
@@ -86,6 +87,7 @@ DIST_SUBDIRS = 		\
 	xddp		\
 	y2038		\
 	alchemytests	\
+	rtsignals	\
 	vxworkstests	\
 	psostests
 
diff --git a/testsuite/smokey/rtsignals/Makefile.am b/testsuite/smokey/rtsignals/Makefile.am
new file mode 100644
index 000000000..8d2d6908c
--- /dev/null
+++ b/testsuite/smokey/rtsignals/Makefile.am
@@ -0,0 +1,57 @@
+testdir = @XENO_TEST_DIR@
+noinst_LIBRARIES = librtsignals.a
+
+librtsignals_a_SOURCES = rtsignals.c
+librtsignals_a_CPPFLAGS = 		 		\
+		$(XENO_USER_CFLAGS)    			\
+		-I$(top_srcdir)/include			\
+		-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = rtsignals_signesting_same_signal rtsignals_multiple_ills rtsignals_unsupported_signal rtsignals_sigill
+if XENO_X86
+   test_PROGRAMS += rtsignals_sigfpe rtsignals_signesting_different_signals
+endif
+
+alchemycppflags =              			 \
+	$(XENO_USER_CFLAGS)    			 \
+	-I$(top_srcdir)/include
+
+alchemyldadd =						\
+	$(XENO_POSIX_WRAPPERS)				\
+	../../../lib/alchemy/libalchemy.la		\
+	../../../lib/copperplate/libcopperplate.la	\
+	@XENO_CORE_LDADD@				\
+	@XENO_USER_LDADD@				\
+	-lrt -lpthread -lm
+
+rtsignals_sigill_SOURCES = rtsignals_test.c
+rtsignals_sigill_CPPFLAGS = $(alchemycppflags)
+rtsignals_sigill_LDADD = $(alchemyldadd)
+rtsignals_sigill_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+rtsignals_sigfpe_SOURCES = rtsignals_test.c
+rtsignals_sigfpe_CPPFLAGS = $(alchemycppflags) -DTEST_FPE=1
+rtsignals_sigfpe_LDADD = $(alchemyldadd)
+rtsignals_sigfpe_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+rtsignals_signesting_same_signal_SOURCES = rtsignals_test.c
+rtsignals_signesting_same_signal_CPPFLAGS = $(alchemycppflags) -DTEST_NESTING_SAME_SIGNAL=1
+rtsignals_signesting_same_signal_LDADD = $(alchemyldadd)
+rtsignals_signesting_same_signal_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+rtsignals_signesting_different_signals_SOURCES = rtsignals_test.c
+rtsignals_signesting_different_signals_CPPFLAGS = $(alchemycppflags) -DTEST_NESTING_DIFFERENT_SIGNALS=1
+rtsignals_signesting_different_signals_LDADD = $(alchemyldadd)
+rtsignals_signesting_different_signals_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+rtsignals_multiple_ills_SOURCES = rtsignals_test.c
+rtsignals_multiple_ills_CPPFLAGS = $(alchemycppflags) -DTEST_MULTIPLE_ILLS=1
+rtsignals_multiple_ills_LDADD = $(alchemyldadd)
+rtsignals_multiple_ills_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+
+rtsignals_unsupported_signal_SOURCES = rtsignals_test.c
+rtsignals_unsupported_signal_CPPFLAGS = $(alchemycppflags) -DTEST_UNSUPPORTED_SIGNAL=1
+rtsignals_unsupported_signal_LDADD = $(alchemyldadd)
+rtsignals_unsupported_signal_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
diff --git a/testsuite/smokey/rtsignals/rtsignals.c b/testsuite/smokey/rtsignals/rtsignals.c
new file mode 100644
index 000000000..8d797861f
--- /dev/null
+++ b/testsuite/smokey/rtsignals/rtsignals.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <string.h>
+#include <smokey/smokey.h>
+
+static const char * const tests[] = {
+	"rtsignals_multiple_ills",
+	"rtsignals_unsupported_signal",
+	"rtsignals_sigill",
+	"rtsignals_signesting_same_signal",
+#if defined(__i386__) || defined(__x86_64__)
+	"rtsignals_signesting_different_signals",
+	"rtsignals_sigfpe",
+#elif defined(__arm__) || defined(__aarch64__)
+#endif
+};
+
+static int run_rtsignals(struct smokey_test *t, int argc, char *const argv[])
+{
+	int test_ret = 0;
+	int ret = 0;
+	int tmp;
+
+	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
+		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
+					 "--cpu-affinity=0", &test_ret);
+		if (test_ret)
+			ret = test_ret; /* Return the last failed test result */
+		if (tmp)
+			break;
+	}
+
+	return ret;
+}
+smokey_test_plugin(rtsignals, SMOKEY_NOARGS, "Run external rtsignalstest");
+
diff --git a/testsuite/smokey/rtsignals/rtsignals_test.c b/testsuite/smokey/rtsignals/rtsignals_test.c
new file mode 100644
index 000000000..1140ce8e3
--- /dev/null
+++ b/testsuite/smokey/rtsignals/rtsignals_test.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <ucontext.h>
+#include <copperplate/traceobj.h>
+#include <alchemy/task.h>
+#include <assert.h>
+#include <setjmp.h>
+#include <stdatomic.h>
+
+#include <execinfo.h>
+#include <signal.h>
+#include <pthread.h>
+
+static void sigdebug_handler(int sig, siginfo_t *info, void *context);
+static void linux_handler(int sig, siginfo_t *info, void *context);
+static void rt_test_handler(int sig, siginfo_t *info, void *context);
+static void basic_rt_handler(int sig, siginfo_t *info, void *context);
+
+//#define DEBUG
+#define MULTIPLE_SIGILL 100
+#define CHECK_BIT(bit) check_bit(bit, #bit)
+
+// expected status bits:
+#define BIT_RT_HANDLER_ENTERED		(1<<0)
+#define BIT_RT_HANDLER_FINISHED		(1<<1)
+#define BIT_RT_HANDLER_WRONG_TASK	(1<<2)
+#define BIT_RT_HANDLER_WRONG_SIGNAL	(1<<3)
+#define BIT_DOMAIN_SWITCH		(1<<4)
+#define BIT_LINUX_HANDLER_FINISHED	(1<<5)
+#define BIT_RT_TASK_FINSIHED		(1<<6)
+#define BIT_BASIC_RT_HANDLER_FINISHED	(1<<7)
+
+static RT_TASK task;
+static sig_atomic_t status;
+static sig_atomic_t cause;
+
+struct sig_handler {
+    int signal;
+    void (*handler)(int, siginfo_t *, void *);
+};
+
+/*
+ * Test scenarios:
+ * - Default:			Ensure SIGILL handling works.
+ * - TEST_FPE:			Ensure SIGFPE handling works.
+ * - TEST_NESTING_SAME_SIGNAL	Ensure nested signals of the same type are not
+ *				allowed.
+ * - TEST_NESTING_DIFFERENT SIGNALS:
+ *				Ensure nested signals of different types are allowed
+ *				and are handled successfully.
+ * - TEST_MULTIPLE_ILLS		Ensure multiple SIGILLs after each other are handled
+ *				successfully.
+ * - TEST_UNSUPPORTED_SIGNAL	Ensure registering of an unsupported signal fails.
+ */
+#if defined(TEST_NESTING_SAME_SIGNAL)
+#define TEST_SIGNAL SIGILL
+#define TEST_SIGNAL_NESTED SIGILL
+static const struct sig_handler linux_handlers[] = {
+    {SIGDEBUG, sigdebug_handler},
+    {SIGILL,   linux_handler},
+};
+static const struct sig_handler rt_handlers[] = {
+    {SIGILL,   rt_test_handler},
+};
+static int expected_status = BIT_RT_HANDLER_ENTERED
+				| BIT_RT_HANDLER_FINISHED
+				| BIT_DOMAIN_SWITCH
+				| BIT_LINUX_HANDLER_FINISHED
+				| BIT_RT_TASK_FINSIHED;
+
+#elif defined(TEST_UNSUPPORTED_SIGNAL)
+#define TEST_SIGNAL SIGSEGV
+static const struct sig_handler linux_handlers[] = {
+    {SIGDEBUG, sigdebug_handler},
+    {SIGILL,   linux_handler},
+};
+static const struct sig_handler rt_handlers[] = {
+    {SIGSEGV,   rt_test_handler},
+};
+static int expected_status = 0;
+
+#elif defined(TEST_NESTING_DIFFERENT_SIGNALS)
+#define TEST_SIGNAL SIGFPE
+#define TEST_SIGNAL_NESTED SIGILL
+static int expected_status = BIT_RT_HANDLER_ENTERED
+				| BIT_RT_HANDLER_FINISHED
+				| BIT_RT_TASK_FINSIHED
+				| BIT_BASIC_RT_HANDLER_FINISHED;
+static const struct sig_handler linux_handlers[] = {
+    {SIGDEBUG, sigdebug_handler},
+    {SIGILL,   linux_handler},
+    {SIGFPE,   linux_handler},
+};
+static const struct sig_handler rt_handlers[] = {
+    {SIGFPE,   rt_test_handler},
+    {SIGILL,   basic_rt_handler},
+};
+
+#elif defined(TEST_MULTIPLE_ILLS)
+#define TEST_SIGNAL SIGILL
+static const struct sig_handler linux_handlers[] = {
+    {SIGDEBUG, sigdebug_handler},
+    {SIGILL,   linux_handler},
+};
+static const struct sig_handler rt_handlers[] = {
+    {SIGILL,   rt_test_handler},
+};
+static int expected_status = BIT_RT_HANDLER_ENTERED 
+				| BIT_RT_HANDLER_FINISHED 
+				| BIT_RT_TASK_FINSIHED;
+
+#elif defined(TEST_FPE)
+#define TEST_SIGNAL SIGFPE
+static const struct sig_handler linux_handlers[] = {
+    {SIGDEBUG, sigdebug_handler},
+    {SIGFPE,   linux_handler},
+};
+static const struct sig_handler rt_handlers[] = {
+    {SIGFPE,   rt_test_handler},
+};
+static int expected_status = BIT_RT_HANDLER_ENTERED 
+				| BIT_RT_HANDLER_FINISHED 
+				| BIT_RT_TASK_FINSIHED;
+
+#else /* Default Test */
+#define TEST_SIGNAL SIGILL
+static const struct sig_handler linux_handlers[] = {
+    {SIGDEBUG, sigdebug_handler},
+    {SIGILL,   linux_handler},
+};
+static const struct sig_handler rt_handlers[] = {
+    {SIGILL,   rt_test_handler},
+};
+static int expected_status = BIT_RT_HANDLER_ENTERED 
+				| BIT_RT_HANDLER_FINISHED 
+				| BIT_RT_TASK_FINSIHED;
+
+#endif
+
+#define NUM_LINUX_HANDLERS (sizeof(linux_handlers) / sizeof(linux_handlers[0]))
+#define NUM_RT_HANDLERS (sizeof(rt_handlers) / sizeof(rt_handlers[0]))
+
+static void debug_log(const char *format, ...) {
+#ifdef DEBUG
+    va_list args;
+    va_start(args, format);
+    vfprintf(stderr, format, args);
+    va_end(args);
+#endif
+}
+
+static bool __maybe_unused check_bit(int bit, const char *bit_name){
+	if ((status & bit) == (expected_status & bit))
+		return true;
+
+	fprintf(stderr, "%s not as expected.\n", bit_name);
+	return false;
+}
+
+static int test_successful(void)
+{
+	if (status == expected_status) {
+		debug_log("Test passed\n", stderr);
+		return 1;
+	}
+	debug_log("Test not passed\n", stderr);
+#ifdef DEBUG
+	static const char * const sigdebug_msg[] = {
+		[SIGDEBUG_UNDEFINED] = "latency: received SIGXCPU for unknown reason",
+		[SIGDEBUG_MIGRATE_SIGNAL] = "received signal",
+		[SIGDEBUG_MIGRATE_SYSCALL] = "invoked syscall",
+		[SIGDEBUG_MIGRATE_FAULT] = "triggered fault",
+		[SIGDEBUG_MIGRATE_PRIOINV] = "affected by priority inversion",
+		[SIGDEBUG_NOMLOCK] = "Xenomai: process memory not locked (missing mlockall?)",
+		[SIGDEBUG_WATCHDOG] = "Xenomai: watchdog triggered (period too short?)",
+	};
+
+	CHECK_BIT(BIT_RT_HANDLER_ENTERED);
+	CHECK_BIT(BIT_RT_HANDLER_FINISHED);
+	CHECK_BIT(BIT_RT_HANDLER_WRONG_TASK);
+	CHECK_BIT(BIT_RT_HANDLER_WRONG_SIGNAL);
+	if (!CHECK_BIT(BIT_DOMAIN_SWITCH)){
+		if (expected_status & BIT_DOMAIN_SWITCH)
+			debug_log("- Cause: Domain switch should have happend.\n");
+		else
+			debug_log("- Caused by: %s\n", sigdebug_msg[cause]);
+	}
+	CHECK_BIT(BIT_LINUX_HANDLER_FINISHED);
+	CHECK_BIT(BIT_RT_TASK_FINSIHED);
+	CHECK_BIT(BIT_BASIC_RT_HANDLER_FINISHED);
+#endif
+
+	return 0;
+}
+
+static void register_signal_handler(int signal, void (*handler)(int, siginfo_t *, void *)) {
+    struct sigaction sa;
+
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = handler;
+    sa.sa_flags = SA_SIGINFO;
+    if (sigaction(signal, &sa, NULL) == -1) {
+        perror("Failed to register Linux handler");
+    }
+}
+
+inline static void do_ill(void)
+{
+#if defined(__i386__) || defined(__x86_64__)
+	__asm__("ud2");
+#else
+	__asm__("udf #0xdead");
+#endif
+}
+
+static void do_fpe(void)
+{
+#if defined(__i386__) || defined(__x86_64__)
+	__asm__("xorl %%eax, %%eax\n\t"
+		"movl %%eax, %%ecx\n\t"
+		"cltd\n\t"
+		"idivl %%ecx"
+		: : : "eax", "ecx");
+#endif
+}
+
+static void do_cleanup(void *context)
+{
+	int step = 0;
+	ucontext_t *uc = context;
+
+#if defined(__i386__) || defined(__x86_64__)
+	/*
+	* do_fpe(): idivl %ecx		2 bytes long
+	* do_ill(): ud2			2 bytes long
+	*/
+	step = 2;
+#else
+	// do_ill(): udf #0xdead	4 bytes long
+	step = 4;
+#endif
+
+#if defined(__i386__)
+	uc->uc_mcontext.gregs[REG_EIP] += step;
+#elif defined(__x86_64__)
+	uc->uc_mcontext.gregs[REG_RIP] += step;
+#elif defined(__aarch64__)
+	uc->uc_mcontext.pc += step;
+#elif defined(__arm__)
+	uc->uc_mcontext.arm_pc += step;
+#endif
+}
+
+static void __maybe_unused linux_handler(int sig, siginfo_t *info, void *context)
+{
+	do_cleanup(context);
+	status |= BIT_LINUX_HANDLER_FINISHED;
+}
+
+static void __maybe_unused basic_rt_handler(int sig, siginfo_t *info, void *context)
+{
+	do_cleanup(context);
+	status |= BIT_BASIC_RT_HANDLER_FINISHED;
+}
+
+static void __maybe_unused sigdebug_handler(int sig, siginfo_t *info, void *context)
+{
+	cause = sigdebug_reason(info);
+	if (cause > SIGDEBUG_WATCHDOG)
+		cause = SIGDEBUG_UNDEFINED;
+
+	status |= BIT_DOMAIN_SWITCH;
+}
+
+static void __maybe_unused rt_test_handler(int sig, siginfo_t *info, void *context)
+{
+	RT_TASK *self;
+	(void)context;
+
+	status |= BIT_RT_HANDLER_ENTERED;
+	if (sig != TEST_SIGNAL) {
+		status |= BIT_RT_HANDLER_WRONG_SIGNAL;
+		return;
+	}
+	atomic_signal_fence(memory_order_seq_cst);
+
+#ifdef TEST_SIGNAL_NESTED
+	switch (TEST_SIGNAL_NESTED) {
+		case SIGILL:
+			do_ill();
+			break;
+		default:
+			break;
+	}
+#endif
+
+	atomic_signal_fence(memory_order_seq_cst);
+
+	self = rt_task_self();
+	if (self == NULL || !rt_task_same(self, &task))
+		status |= BIT_RT_HANDLER_WRONG_TASK;
+	else
+		status |= BIT_RT_HANDLER_FINISHED;
+
+	do_cleanup(context);
+}
+
+
+static void task_proc(void *arg)
+{
+	int ret;
+
+	// Register rt-signal handlers
+	for (size_t i = 0; i < NUM_RT_HANDLERS; i++) {
+		ret = cobalt_rt_signal(rt_handlers[i].signal, rt_handlers[i].handler);
+		if (ret != 0)
+			return;
+	}
+
+	// trigger fault
+	switch(TEST_SIGNAL) {
+		case SIGILL:
+			do_ill();
+			break;
+		case MULTIPLE_SIGILL:
+			do_ill();
+			do_ill();
+			do_ill();
+			break;
+		case SIGFPE:
+			do_fpe();
+			break;
+		default:
+			break;
+	}
+
+	atomic_signal_fence(memory_order_seq_cst);
+
+	// clear T_WARNSW so that rt_task_delete() does not send SIGDEBUG
+	rt_task_set_mode(T_WARNSW, 0, 0);
+
+	status |= BIT_RT_TASK_FINSIHED;
+}
+
+int main(void)
+{
+	int ret;
+
+	// Setup Linux handlers
+	for (size_t i = 0; i < NUM_LINUX_HANDLERS; i++) {
+		register_signal_handler(linux_handlers[i].signal, linux_handlers[i].handler);
+	}
+
+	// Run RT Task
+	ret = rt_task_create(&task, "rt-task", 0, 20, T_JOINABLE | T_WARNSW);
+	assert(ret == 0);
+
+	ret = rt_task_start(&task, task_proc, NULL);
+	assert(ret == 0);
+
+	ret = rt_task_join(&task);
+	assert(ret == 0);
+
+	(void)ret;
+
+	return test_successful() ? EXIT_SUCCESS : EXIT_FAILURE;
+}
-- 
2.48.1

