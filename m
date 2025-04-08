Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E06D269D17
	for <xenomai@lists.linux.dev>; Tue,  8 Apr 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115323; cv=fail; b=o5ONz0jPezbZwTHFvvbOfQo20e2FHlOZzJ13SRM9GMUCBO82F6UNtljO+nubVzXSZU57119HKgDCYR1b2yIyhC+2K4Mf8GUTilQ88L+9a7hgBClcK8JDUiMPDzOZMyvNZ/iDy95HOU9CoYoFgJV7wLgIt2/de9h/uFw+PUy6/+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115323; c=relaxed/simple;
	bh=O3ocLOYD8uXLWMfBxYQhWPF874ia4hX2k1pLeFS0J1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VXaF3rxlePa7kYqhfjqnN3TenzLPt34CgBB5MJc/D+D40xZK41GwRxcDxCRJoHiMdn0nfFXUS+kFR+tZ6C6cG6EyltB3BKqk7Fx0yRsmB6aREeb1sKR/0H6kyOgZbb0xV8YNvzPdAWSL47zAIsDAsLTWJT1rvIjQbCbIm0KAJfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at; spf=pass smtp.mailfrom=sigmatek.at; dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b=dgsdn8YB; arc=fail smtp.client-ip=40.107.21.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigmatek.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sigmatek.at header.i=@sigmatek.at header.b="dgsdn8YB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwiLLbxvqiKVS/PKH0zbFlHTstty6allcQ76ficBn8lrZCQczKuwjlLZ1nwRtXRMYTKGYdVpzyF9v7lM2hKHOYKvVq/NRUThBQy2wxiExTVSzGnSsm51LOF4Tmoo8ThU6UIDp7S35FuzsRD97aq8DrqHUfIFnGuxYLgXOlrH36NJKnugBMPxv5z7ccWFig6e60do2nz7TXLXHsnGOMc7mGvG8dcphlhWqo2PYvR1UySsAs61Lnty6Lec5FBbqBHQixV6qh1D+HiqFn2+gfAtxehoDiwX/DbZ7ctLRpe1DqKmqR1QNCSwf9LpmbQXYSPOsGd+VoISRSrVaw5S3v2eIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EgFTrwZgmOpTZ2e8vy1CdMJD9OB+HN5T2fGMyPe8Uc=;
 b=ku16D8RDWtWBbDPoifYG5rL2x6HnZoTrgjidHPWCISvwDrUJ93VaL+v08u9nU324YSAHR35MkAE8BbLAKmMIai6evy3jDKnQeU7fHYUFSl1HY0BRl/ITBR+1kq//6tSRo5IcgipK9xgw2GYKmEeID9kxnlW3WNrnwz3ME+djJlCaVQqIwqile4qEeNtFd7XPG+hqsBR+PJUuFQ0umqXDFp7Q5P7e8Rc2Cs9l72+Bshv4/QiKBXWdg/4IDI7o8KP5k63umumN574kyIiA2HOlH0EtOEX7zW0CSt8Png2rKRJVLNGYBhcbhqKGzwA3vVwAqC2qDIGYi/l8XIBV6Ck2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sigmatek.at; dmarc=pass action=none header.from=sigmatek.at;
 dkim=pass header.d=sigmatek.at; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sigmatek.at;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EgFTrwZgmOpTZ2e8vy1CdMJD9OB+HN5T2fGMyPe8Uc=;
 b=dgsdn8YBKWfx0ihRLMDH4aJ8IRbC0z2RHedDKXG5nh/50GMUnelsfD1Rq3gMY6+w00sAh8fnpzGCMc1E1hCpnbEc71BGALEJcqma9aV97AWcIaNV/MxytyH/eNseyJ8ZjEXomiaPg/ihiotmx61BEn+aKm8y8wgO903dd81FkI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sigmatek.at;
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com (2603:10a6:102:325::13)
 by AS8PR08MB6424.eurprd08.prod.outlook.com (2603:10a6:20b:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.28; Tue, 8 Apr
 2025 12:28:27 +0000
Received: from PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8]) by PAVPR08MB9037.eurprd08.prod.outlook.com
 ([fe80::3d5f:e34f:e1a7:59d8%6]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 12:28:26 +0000
From: Nikolaus Funk <nikolaus.funk@sigmatek.at>
To: xenomai@lists.linux.dev
Cc: richard@sigma-star.at,
	Lorenz Kofler <lorenz@sigma-star.at>,
	Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Subject: [PATCH 6/6] utils: Add rt_signal_hist
Date: Tue,  8 Apr 2025 14:28:17 +0200
Message-ID: <20250408122817.626897-7-nikolaus.funk@sigmatek.at>
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
X-MS-Office365-Filtering-Correlation-Id: fe74a891-ac73-4e86-fe31-08dd7698dccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?edG34Hj+dcgoG+C3ChbQN6VOi+cbrtkaLPZI/ZNKQhfs9s8Q8YRjN7hAhvDk?=
 =?us-ascii?Q?owW1EX3K+Yvqf58LxbL1eklD89FsfM2e4ewq2F5wxKTpUdKgJg5LhlRzgr8R?=
 =?us-ascii?Q?fIZlEurKfGzWLRY6o2OWegECxDwC0hqq/Li0lDh+C0hEZSkOy4zCH6qRRdHz?=
 =?us-ascii?Q?48BSPRhx56331Sjrp42SzqxlYkIFvC+4nbPSeKd8IUhhUdDylYNZw5kuhkmL?=
 =?us-ascii?Q?3m41QGZ8v5968Ey0o/1d7d1oEaJDad1t02Myhm+yA/qt3juyk0nWvF0FM6mG?=
 =?us-ascii?Q?ts3lvSvLsz6gO8nVi+QUKLSB6qh+3NJA2eV2bAtVYGaZrNKEZfQZDnIPFsRW?=
 =?us-ascii?Q?mtHUeTgJOF1eCnXqwKnz7tBZjHvTPn0yNy2AXivdIjS4UU+2X77Y7OfWfvMI?=
 =?us-ascii?Q?xnmckDcHeHI74D7JYHKEO8G4WZRiK63ZFJHDYNjy0YtdpZChCD0phNcuLw8v?=
 =?us-ascii?Q?9Wqzn2T/Z3qxDU4ZMSD7BDfZolS3eQfh1bNUQmHHsXESRj/MD4KuTrDIS7du?=
 =?us-ascii?Q?EiwNGELvhsV+0jlF0FawDW0JNEMab7eqAMwPX/26Bgu79Oj0N/YrmH2pWm5s?=
 =?us-ascii?Q?DgI3brOk9h/wXmZL+kHCChFY3dURVssd6koDzAzRpgmzJWMrsdeW3wpqtgNe?=
 =?us-ascii?Q?3cmvEELRdDwz/6e/8yifORfqJFZASTDL7noY1rIWjaQnDq82jGpJQAjaQT6H?=
 =?us-ascii?Q?88HpNMgnvA65aJOJLEVY6ZbQtzHDsfBtOOhI/A+iogBD9T6i2xL1BmrMpUuW?=
 =?us-ascii?Q?v9/GEY+J7HIgGkY1xT6vfHMjw9IeAUzKXdhILE7fGISvb5lV1QJzAxNtb3Xt?=
 =?us-ascii?Q?XxnSHB3v3qZir/JrMTqBHk0xm0crj9ZkdAQyyNaqZGwGPHNixC+kFQgVgcRT?=
 =?us-ascii?Q?nSa+eNKKB1YMFqZKObHwmiMYcv+hdnoh7eraFEJodoEyL/MlS2zlp1AXKzoL?=
 =?us-ascii?Q?DNFoPticql39yuktgvS5dA4GThzFdPJ/bq0arv0cwKugLsJ0t4/oM+MFBEJm?=
 =?us-ascii?Q?L5T+cu/6ldeCvR0XqXG38yYXYHop3EHHhrav+C77ifi0olxkH/vgBS2PHRLf?=
 =?us-ascii?Q?mFUNnKrjy752fA/4vUUefroGcdSTxcO9Wyb+mRehCGpJcq2/WhHVqAVRZzNZ?=
 =?us-ascii?Q?zMss927JkGNXNnbvXHpOZSG6mfWK8KtI/ZDF75wVosazSV6J5LkdjIlqfjmh?=
 =?us-ascii?Q?zNBe5aIhv6em8bm4S1DAZRmCoJsR0/YAwHvo+23bDMVsIs7MQw9tHWkZEhKX?=
 =?us-ascii?Q?7jopycMAJecRz0+H8jAV3ZOZWw6xuHWkLiFr/HHbYy6jFyp4Z5ka2OFSp32r?=
 =?us-ascii?Q?DD/3raB8B5JvDntNlbn+BX7m3c9YfRHt2ujKwbhn1OWiOkW6Mt1lNBbghZbs?=
 =?us-ascii?Q?WCVtchv+ObDXznXGZD5t6XpqzpWr03UwSQ5TTZVN/hSKMVVb8zTiOGlHaDaM?=
 =?us-ascii?Q?SyirvCSwtOwafd6DkZ9zDKxAkN2nA25f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR08MB9037.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g8mY2wAu3Rx6mtvDHPSjwuZxuKlxwdPBewT1qA3Zt2Xf39M5GhqoScorT8bK?=
 =?us-ascii?Q?A677htQgI00iQtC4zwvRKArICMlvI5007bTIvsL/k04t7Hek5d9zQD+N4t6h?=
 =?us-ascii?Q?/OxGBXOUg1+2cBYdR766QifR+1L6YdJJ5zl5l385QTFq8pxBrMFP6q+fICH4?=
 =?us-ascii?Q?Jww1USeLqCnoBoo/dBGXAXb9yxPjA0e+in24K68SDF6XZJcRU7xVW11zuY8T?=
 =?us-ascii?Q?KqzzyzMEyk11uqRlIC46kTlQvw1ZBzMwke/YNUVLuJ9LyzvTWtBnFEJsCKN2?=
 =?us-ascii?Q?9u7Vo96I9F27bUNA2PnHMnZsAaAXXC16eQM5OkVp4IBZ94A/NjgchXJGJ07q?=
 =?us-ascii?Q?OX/FxXAI4ObyBoynNfDi1+nBH19RgZ/k9bWXhCen8XixRgPllLtXBV89t0Gg?=
 =?us-ascii?Q?NFU2yX4jV956TurNs7vz7ytSVAUiMJ4af+BDsSP6HM3VFcgBNXi3YuaDpG/O?=
 =?us-ascii?Q?dEUPGvuGgLlhr7OPp+n2+IFCoYEktx7tz3UdQPA69Vvwbnr2nRZ+r+WAEEwr?=
 =?us-ascii?Q?uXDzxQD3psTTWJNZy7hylhLcEM+gvV9rwhT2kJ4WMc+RFP51JEQ4MJW9/dvd?=
 =?us-ascii?Q?lxu90zT89zn0WMXrqS+AhaVLfwfu/9qXFIaZFl82m8f7a5qoThVEBtC+JSyJ?=
 =?us-ascii?Q?lM6UdcH6N75grPBbxSC/YhSz6urG3UR/hc364GTsV0O78qtwVDbDKS0wTjqf?=
 =?us-ascii?Q?1/R1zMJ/b6qcNNsYsMdAvM8XvzM0t75r972VozXCpwlyw+S3wqhz/P2D5tj8?=
 =?us-ascii?Q?N4pnGZrEVjEMAv7zharMn2qSQkN5y+uwGhdzK5dzEnOV1tBjGzvOO2vl8mPs?=
 =?us-ascii?Q?poBG7/UKZG4mlXYKDDXylJrlQXOIR3f9QS052FhHJK/9jfxctxsnTBkeRdI3?=
 =?us-ascii?Q?yfC2WTE3uriH9YAX32Aw54Wj9Y9rCmcv9oDuvEgCpSnE0Jdx6E/DctrO0D39?=
 =?us-ascii?Q?3E3HMlQqe2LpgJScsqLmSowwivHmUnJz7qlblJ9fVgWwbnrGxmhhXDhlNX2l?=
 =?us-ascii?Q?mkH8iiFNSZko/ng/8vtxKaPnOFhxe5zM8GoQzqsj1oSCTuQz1c8o9c+1zDzq?=
 =?us-ascii?Q?qDOdPVn3KgmFda39XLrxKFEslRa/3UNkC9GD/8oXq7wuu7Tk/wMnAwrqUXf9?=
 =?us-ascii?Q?oU0+XB0tPPzK7xWA4rB3AO+5FNptgPH3TmoSKUoTXk4tjYAwI57PVFO2/6/c?=
 =?us-ascii?Q?Px/pz+zrJQVMh+l/0E9wx9Uib5f2pZoJNhNrL0hqrWJeyjvgLm9NKU/7J6LH?=
 =?us-ascii?Q?mpAj3BgL7Q6t0uqdNTiA1DV2EqTwPd1Q/nYJyP19yWgKeQub9jjLVuwjSZHV?=
 =?us-ascii?Q?ha9cEhdZE8KmzgkUq221gOJgQNNbFN1kkAH7HWBaNHekZ0sORgpJr8HGCgb3?=
 =?us-ascii?Q?BO9JGKRbQYCY2tgDjNnxGwqUWfmPm9Og/CUWINsjz5PeAE/dk3LmrOexNXHs?=
 =?us-ascii?Q?BtStqws0vcxIbxbkwZXn2VVEeqy3Qu5djoeTFb1Umt6ZrKfUvqOWkUaFh57d?=
 =?us-ascii?Q?A6aBg6R/xsyVWGr6tTtLevjto9Kwt/UaIowyeZqpn+uXpjejckGysSTARoJh?=
 =?us-ascii?Q?9M8Kty8QSXQyHB0inhbtNRo2O81h65D0SpPji5a5DqZ+uIFD7Ja/xZm0l8Uk?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: sigmatek.at
X-MS-Exchange-CrossTenant-Network-Message-Id: fe74a891-ac73-4e86-fe31-08dd7698dccb
X-MS-Exchange-CrossTenant-AuthSource: PAVPR08MB9037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 12:28:26.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bcb1d87a-d2bc-486e-a62b-9ac9c746bc1b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLV9FJbltWgh3ubYpe59EeBBWlHAWw5rbz9WPvfI57Lfz7XPI/lbK4lpgg5XJZbKvuYpxAkgDZaAXyQnyU7VC60PAfzzLVAn60laIglb4XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6424

From: Lorenz Kofler <lorenz@sigma-star.at>

Useful to create a histogram to evaluate RT signal handling performance.
The program will output a file called hist.txt in the format:

	TIME in Nanoseconds, Frequency

Co-developed-by: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>
Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
---
 configure.ac                          |   1 +
 utils/Makefile.am                     |   2 +-
 utils/rt_signal_hist/Makefile.am      |  22 +++
 utils/rt_signal_hist/error.h          |  15 ++
 utils/rt_signal_hist/histo.c          |  47 +++++
 utils/rt_signal_hist/histo.h          |  14 ++
 utils/rt_signal_hist/result.c         |  17 ++
 utils/rt_signal_hist/result.h         |  13 ++
 utils/rt_signal_hist/rt_signal_hist.c | 237 ++++++++++++++++++++++++++
 9 files changed, 367 insertions(+), 1 deletion(-)
 create mode 100644 utils/rt_signal_hist/Makefile.am
 create mode 100644 utils/rt_signal_hist/error.h
 create mode 100644 utils/rt_signal_hist/histo.c
 create mode 100644 utils/rt_signal_hist/histo.h
 create mode 100644 utils/rt_signal_hist/result.c
 create mode 100644 utils/rt_signal_hist/result.h
 create mode 100644 utils/rt_signal_hist/rt_signal_hist.c

diff --git a/configure.ac b/configure.ac
index 678e8ef1e..325946a2c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1114,6 +1114,7 @@ AC_CONFIG_FILES([ \
 	utils/slackspot/Makefile \
 	utils/corectl/Makefile \
 	utils/autotune/Makefile \
+	utils/rt_signal_hist/Makefile \
 	utils/net/rtnet \
 	utils/net/rtnet.conf \
 	utils/net/Makefile \
diff --git a/utils/Makefile.am b/utils/Makefile.am
index 4de6434a9..79c39ac90 100644
--- a/utils/Makefile.am
+++ b/utils/Makefile.am
@@ -1,5 +1,5 @@
 SUBDIRS = hdb
 if XENO_COBALT
-SUBDIRS += analogy autotune can net ps slackspot corectl
+SUBDIRS += analogy autotune can net ps slackspot corectl rt_signal_hist
 endif
 SUBDIRS += chkkconf
diff --git a/utils/rt_signal_hist/Makefile.am b/utils/rt_signal_hist/Makefile.am
new file mode 100644
index 000000000..810a63bba
--- /dev/null
+++ b/utils/rt_signal_hist/Makefile.am
@@ -0,0 +1,22 @@
+testdir = @XENO_TEST_DIR@
+
+CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
+
+test_PROGRAMS = rt_signal_hist
+
+alchemycppflags =              			 \
+	$(XENO_USER_CFLAGS)    			 \
+	-I$(top_srcdir)/include
+
+alchemyldadd =					\
+	@XENO_AUTOINIT_LDFLAGS@			\
+	$(XENO_POSIX_WRAPPERS)			\
+	../../lib/alchemy/libalchemy.la		\
+	../../lib/copperplate/libcopperplate.la	\
+	@XENO_CORE_LDADD@			\
+	@XENO_USER_LDADD@			\
+	-lrt -lpthread -lm
+
+rt_signal_hist_SOURCES = rt_signal_hist.c histo.c result.c
+rt_signal_hist_CPPFLAGS = $(alchemycppflags)
+rt_signal_hist_LDADD = $(alchemyldadd)
diff --git a/utils/rt_signal_hist/error.h b/utils/rt_signal_hist/error.h
new file mode 100644
index 000000000..811ee642c
--- /dev/null
+++ b/utils/rt_signal_hist/error.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ERROR_EXIT_H
+#define ERROR_EXIT_H
+
+#include <stdio.h>
+#include <stdlib.h>
+
+static int error(char *reason, int ret)
+{
+	printf("%s: err= %d\n", reason, ret);
+	exit(1);
+}
+
+#endif
+
diff --git a/utils/rt_signal_hist/histo.c b/utils/rt_signal_hist/histo.c
new file mode 100644
index 000000000..5667e62f3
--- /dev/null
+++ b/utils/rt_signal_hist/histo.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "histo.h"
+#include "error.h"
+
+void initHisto(struct histo **histo, unsigned long max_entry)
+{
+	unsigned long i = 0;
+	*histo = malloc(sizeof(struct histo) + max_entry * sizeof(unsigned long));
+	if (!histo)
+		return;
+
+	for (i = 0; i < max_entry; ++i)
+		(*histo)->data[i] = 0;
+
+	(*histo)->max_index = 0;
+	(*histo)->max_entry = max_entry;
+}
+
+void writeHisto(struct histo *histo)
+{
+	unsigned long i;
+	FILE *f = fopen("hist.txt", "w");
+
+	if (!f)
+		error("can't open \"hist.txt\"\n", errno);
+
+	for (i = 0; i <= histo->max_index; ++i) {
+		if (histo->data[i] > 0)
+			fprintf(f, "%lu %lu\n", i, histo->data[i]);
+	}
+	fclose(f);
+}
+
+void updateHisto(struct histo *histo, unsigned long curr)
+{
+	unsigned long index;
+
+	index = curr;
+	index = index >= histo->max_entry ? histo->max_entry - 1 : index;
+	histo->max_index = histo->max_index >= index ? histo->max_index : index;
+	histo->data[index]++;
+}
+
diff --git a/utils/rt_signal_hist/histo.h b/utils/rt_signal_hist/histo.h
new file mode 100644
index 000000000..8ff92fce4
--- /dev/null
+++ b/utils/rt_signal_hist/histo.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef HISTO_H
+#define HISTO_H
+
+struct histo {
+	unsigned long max_entry;
+	unsigned long max_index;
+	unsigned long data[];
+};
+
+void initHisto(struct histo **histo, unsigned long n);
+void writeHisto(struct histo *histo);
+void updateHisto(struct histo *histo, unsigned long curr);
+#endif
diff --git a/utils/rt_signal_hist/result.c b/utils/rt_signal_hist/result.c
new file mode 100644
index 000000000..db8c99beb
--- /dev/null
+++ b/utils/rt_signal_hist/result.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "result.h"
+
+void initResult(struct result *resu)
+{
+	resu->min = (unsigned long)-1l;
+	resu->max = 0ul;
+	resu->avr = 0ul;
+}
+
+void updateResult(struct result *resu, unsigned long curr, unsigned long ith_entry)
+{
+	resu->min = curr < resu->min ? curr : resu->min;
+	resu->max = curr > resu->max ? curr : resu->max;
+	resu->avr = (resu->avr * (ith_entry - 1) + curr) / ith_entry;
+}
+
diff --git a/utils/rt_signal_hist/result.h b/utils/rt_signal_hist/result.h
new file mode 100644
index 000000000..5c164fa66
--- /dev/null
+++ b/utils/rt_signal_hist/result.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef RESULT_H
+#define RESULT_H
+
+struct result {
+	unsigned long min;
+	unsigned long max;
+	unsigned long avr;
+};
+
+void initResult(struct result *resu);
+void updateResult(struct result *resu, unsigned long curr, unsigned long ith_entry);
+#endif
diff --git a/utils/rt_signal_hist/rt_signal_hist.c b/utils/rt_signal_hist/rt_signal_hist.c
new file mode 100644
index 000000000..bfc8947aa
--- /dev/null
+++ b/utils/rt_signal_hist/rt_signal_hist.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include <ucontext.h>
+
+#include <alchemy/task.h>
+#include <cobalt/signal.h>
+#include <copperplate/clockobj.h>
+
+#include "histo.h"
+#include "result.h"
+#include "error.h"
+
+#define USE_GETTIME 0 // TODO: when is this needed?
+#define MAX_TIME 10000000
+
+static RT_TASK task;
+static const char *task_name = "signal_test_task";
+static const int prio = 80;
+static int TEST_SIGNAL = SIGILL;
+
+typedef struct {
+	const char *name;
+	int value;
+} SignalMapping;
+
+static const SignalMapping signals[] = {
+	{"SIGILL", SIGILL},
+	{"SIGTRAP", SIGTRAP},
+	{"SIGFPE", SIGFPE},
+	{"SIGSEGV", SIGSEGV},
+	{NULL, 0}
+};
+
+static int get_signal_value(const char *signal_name)
+{
+	for (int i = 0; signals[i].name != NULL; i++) {
+		if (strcmp(signals[i].name, signal_name) == 0)
+			return signals[i].value;
+	}
+	return -1;
+}
+
+static const char *get_signal_name(int signal_value)
+{
+	for (int i = 0; signals[i].name != NULL; i++) {
+		if (signals[i].value == signal_value)
+			return signals[i].name;
+	}
+	return "UNKNOWN_SIGNAL";
+}
+
+static int get_step(void)
+{
+#if defined(__i386__) || defined(__x86_64__)
+	// do_fpe: `idivl %ecx` is 2 bytes long
+	// do_ill: `ud2` is 2 bytes long
+	return 2;
+#else
+	// do_ill: `udf #0xdead` is 4 bytes long
+	return 4;
+#endif
+}
+
+static void do_cleanup(void *context)
+{
+	int step = 0;
+	ucontext_t *uc = context;
+
+	step = get_step();
+
+#if defined(__i386__)
+	uc->uc_mcontext.gregs[REG_EIP] += step;
+#elif defined(__x86_64__)
+	uc->uc_mcontext.gregs[REG_RIP] += step;
+#elif defined(__aarch64__)
+	uc->uc_mcontext.pc += step;
+#elif defined(__arm__)
+	uc->uc_mcontext.arm_pc += step;
+#else
+	#error "Unknown Architecture"
+#endif
+}
+
+static void sigdebug_handler(int sig, siginfo_t *info, void *context)
+{
+	printf("%s called, this should not happen\n", __func__);
+	exit(EXIT_FAILURE);
+}
+
+static void sighandler(int sig, siginfo_t *info, void *data)
+{
+	do_cleanup(data);
+}
+
+static void do_ill(void)
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
+static void printPreRunInfo(void)
+{
+	if (USE_GETTIME) {
+		struct timespec time;
+
+		clock_getres(CLOCK_MONOTONIC_RAW, &time);
+		printf("Using CLOCK_MONOTONIC_RAW: res_sec = %lld res_nsec = %ld\n",
+			(long long)time.tv_sec, time.tv_nsec);
+		return;
+	}
+
+	printf("USING Xenomai rt_timer: res_nsec = %lld\n", rt_timer_ticks2ns(1));
+}
+
+static inline unsigned long ns_now(void)
+{
+	if (USE_GETTIME) {
+		struct timespec time;
+
+		clock_gettime(CLOCK_MONOTONIC_RAW, &time);
+		return time.tv_nsec;
+	}
+
+	ticks_t ticks;
+
+	ticks = clockobj_get_ns();
+	return rt_timer_ticks2ns(ticks);
+}
+
+static void task_func(void *cookie)
+{
+	struct histo *histogram = (struct histo *)cookie;
+	struct result resu;
+
+	unsigned long start_time, end_time, diff_time;
+	int i, j, ret;
+	char error_message[80];
+
+	printPreRunInfo();
+
+	ret = cobalt_rt_signal(TEST_SIGNAL, sighandler);
+	if (ret) {
+		snprintf(error_message, sizeof(error_message),
+			"Failed to register rtsignal signal handler for signal %s",
+			get_signal_name(TEST_SIGNAL));
+		error(error_message, ret);
+	}
+
+	initResult(&resu);
+
+	for (j = 0; j < 10000; ++j) {
+		for (i = 0; i < 1000; ++i) {
+
+			start_time = ns_now();
+			if (TEST_SIGNAL == SIGILL)
+				do_ill();
+			else if (TEST_SIGNAL == SIGFPE)
+				do_fpe();
+			else
+				error("Unsupported signal encountered", TEST_SIGNAL);
+
+			end_time = ns_now();
+
+			if (end_time <= start_time) { // dismiss on counter overrun
+				continue;
+			}
+
+			diff_time = end_time - start_time;
+			//+1 as we add with index i the (i+1)th entry
+			updateResult(&resu, diff_time, i+1);
+			updateHisto(histogram, diff_time);
+		}
+
+		printf("%d: min = %lu max = %lu avr = %lu\n", j, resu.min, resu.max, resu.avr);
+		rt_task_sleep(1000000);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int ret;
+	struct histo *histogram;
+	struct sigaction sa;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <signal>\n", argv[0]);
+		exit(1);
+	}
+
+	TEST_SIGNAL = get_signal_value(argv[1]);
+	if (TEST_SIGNAL < 0)
+		error("Signal not supported", TEST_SIGNAL);
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = sigdebug_handler;
+	sa.sa_flags = SA_SIGINFO | SA_NODEFER;
+	sigaction(SIGDEBUG, &sa, NULL);
+
+	initHisto(&histogram, MAX_TIME);
+	if (!histogram)
+		error("initHisto failed", -ENOMEM);
+
+	ret = rt_task_create(&task, task_name, 0, prio, T_JOINABLE | T_WARNSW);
+	if (ret)
+		error("rt_task_create failed", ret);
+
+	ret = rt_task_start(&task, task_func, histogram);
+	if (ret)
+		error("rt_start_task failed", ret);
+
+	rt_task_join(&task);
+	rt_task_delete(&task);
+
+	writeHisto(histogram);
+
+	return 0;
+}
+
-- 
2.48.1

