Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796944C50D
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249592; cv=fail; b=kvxg5hKBSeBKJzxO3T70h6EW58C7JpjABosCGrPm8ROW1oNeHbC/Stxq+7h2vVPKXNy2lmG7HcbGhSbhwaO4HBx8fT7ky5/y8kLo0S3srepT6boEwBXa+CMcg+wQ4uic4Te+uBiiSZlwUtlgQDJSbNc0RDnqBqGYWcDM0Ka86cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249592; c=relaxed/simple;
	bh=lE+hErp2so0YA+DwXFsPEcHJrLBXmGNyi5PLvec+Er0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L9F6I8qRsV8rAWaoOueFT20kR2Ce5MQhs+A56g0jHu5k00EHvLM4XFRa6K4jYN4PSFtMNR+a42FkFonoyslHFZl0QZdPT/wwgSTmiko0HuVDnroSA6la588gK6VLYpZ9cq5xuAmONS5R2QWWC+WvhFm75j9ebi/py0MFOHB+9uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IbNZyYTi; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IbNZyYTi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdp1eyvJCVesPOdrbEupSyL4IdsQprsLM+eJXQtDgjhWhmi36uc9dDmHEhhijH+w0pmTVzbUjsTpz+HNPf3rpHZxwEXTCbvO7r0jrwttkFuhpmsTFZEZxjOsjmC7sWRdQjaZP7N+Vwvwchr8yWElfBT9w8kd0PN8i46AsDoXCsEgI6cKOlY0QEWf1fWWb5QoEoaD6+HN0pswL8OK6BR3PFGQKSb2ySJHCZ9A/Ruw+Zk+xTj/E39S2QkzrVM2x/ksyb9caojoqjgkxB8zs29SEWbBQNRNBlcgQigNZOeln1s1QwwW94280j6DtG3LWXH5Qw7vC5wRE0oqBryKR1Ikdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWqiGbPuhhTF9Tcft8R/9I3JTWXIkcwsKorit6VgEtU=;
 b=NIXySJUastdalIHxtTazNjnolMF1bNJZbah8eZlMvYo9wWgbgMuCNlB7PmFuL2l4lCSXMl7M8T2az4tbAWbsztGcbqzGjzqEcsnyQarMYE/aIZPKh0AKp2R8hkQboCSS+eaGqqhYKD6ON2LNhlKivgBsHhabdqk1H3jzz8aHEtw1iZSn1vqL0iDtt8vFCt9s76JSLABeXpsTJUiGqfMWHAF7vuC+dMicnzZWpuHSbIOocjzeXuGMYDUdXiu7gErEXCsWDzAWiRmX5p/caNy9iRLDFMVKndFh/OtyF6onZAK5RooiHG3/v0z0LErzm+QuWsD5UdOh+b/jqfrG8WRwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWqiGbPuhhTF9Tcft8R/9I3JTWXIkcwsKorit6VgEtU=;
 b=IbNZyYTi5jCDnFv303Pb3GqmcDCTUgUnkeG/f6W5ucYlQNlA+sBuQDnQHv4ZLpd5w40SBYoD30DDRuHMWq3GI7XW8PzGgV/omxXjvu/uZkXxJSnYXOK7i0gfdaWauj6Z+aN+eJXyQ8NWXMiATRb0k3UDVWsz/yrgCR1+Ky3oZluiE3ioMlq2ep94t4A2GunnwmzeO1Jn0y6tM9LfTBVUP7AXeRQnIMVvlpzAmn8Xq1kTFnyKuu7gRtGRan2gpH03QZ1Ym2GxV/+LS7SWD7rm1FMnXdnlAVyLc/IYjThIY9xJ1Pj+zbhb6+vfDiv4tFDH0f8jlWBPaKvHKGDjs8f7/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB5939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 28 Jul
 2026 14:39:42 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 14:39:42 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 3/3] ci: add long-term EVL CI test pipeline
Date: Tue, 28 Jul 2026 16:39:32 +0200
Message-ID: <20260728143932.2747505-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728143932.2747505-1-tobias.schaffner@siemens.com>
References: <20260728143932.2747505-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2P251CA0020.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: db81044d-5737-4217-a0c8-08deecb60f85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	nahf0RNzsauIHxnKSkJzm5GzOs3Pd5QrDS8ic8UGecfX8kWn+ygMIUFx7IjD4TD2WRxpfMPReZpL3O5GkfQ5Mg4a9lXwBOET8ABTItM8RwDEotViJzlxlzLYQYc5RerouiRY6XYji6LLWO8lPTsk0UWU27uOLbC4SK3CtBBIX2Erm7Jj4c/eFV79xopLpe9lX/nUChfI9j+HLNdwASIkI0jWbsftxMWIwvDULERMypb7FmJUmnW1A/isNFH5NgFN5A8mVF32b4dSuPgfZXapcYec2mxVEll2Ypr4SL10S1uHk4O0fUtvG0WjoJbMrI3kJ8q40IBFmozksgoMdzFjal7ZD/gef8VdG9lG/joeOaVbSMZ7Z6mUhUZiDD4wsdr28IvmgP9sGGkoU32Rj8vWX+a4yzDG34EU21x6jMOngNFy1+Iza2Tammdj0vmcl86Ee8l5FnFDYpZpISybuT4O0/8AnHAX8hRTgGdWTxpoBCOOlAso8unahxPuqo6tSPzanxloSeYz6qVrvjpvMjct8eVQ8MlitRPKCoKf9ddHQkfcAnnjyeyIlSqzf2fX0xKlqqZKLKDPa6RlYWfGYdDoGm7KUQ8xBQI5ZFeKFNDgky5k4ICosbJwqFwzmYPR2uo9TNGEMjIaypUpiyR1ZxKS3fkXz1zjm0bTpMZW4REhNew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vwtJ+QiJVaBG/YK7i+PEczDkx0dz3kweH/25l6bBofxVTGvXMI+4R1RO+G7a?=
 =?us-ascii?Q?GoDl+F1PKi9cPAqx+9QUVFVyBX1JSke263GxJTygU3JUexoRtRySqcojlpmo?=
 =?us-ascii?Q?JL0JBHjs8zXQi/1ek3hn4A8vzcrfQ5RNExfPLnaEHv4G452IghJAuLbKyRia?=
 =?us-ascii?Q?QqrzVm+fYWUMjtrtVOm+mr9Mc8PxGVldLM2ihcU1e0uTpwMOp98N7v0q5XqJ?=
 =?us-ascii?Q?AHbpk5q/eXqKMsAk6rNhTCHPY1VwYPnWtw8a84RvQalXxBB/Uww5SgXXQHGF?=
 =?us-ascii?Q?yoKkblktn4TmgjiFqw8ZfZhasUbczL8u37Aq/ldjHY0PbLz0hwxZFKzquvON?=
 =?us-ascii?Q?ryATcth1rEH8psJ2Ui4wRbOxuUhe177EPeAS77NqhmTqfaZe/4ERy726gzuE?=
 =?us-ascii?Q?r4CxheBFz0BJ6YGwd3jtHUYIul9YiRyAkd+T+OPIxsr9dy5lSk/C3THw94tF?=
 =?us-ascii?Q?WvY8ukepc9kH65W39ucQ/QCYsIBut1/Hxy0t8aPChQlgpBTdmvZZuZGFabSp?=
 =?us-ascii?Q?SxAIb4Z8SwZabdfqf1u5V1myKjA2xXwyE7pk8dMJQFHaAuBn0cwi8RPH6Ker?=
 =?us-ascii?Q?55vEbpbTyBhXL0xOegjaIrYrIIa9V37JhzjyXdS8DeLTh/d5nmjaZJzEib0p?=
 =?us-ascii?Q?ylqv71tDvOKxbPIJ29hi+3Z0PVEdFynUWFeQeAQEgwLcFaCpbrTKnMHmI5qR?=
 =?us-ascii?Q?YZSFhobjHf3hFNMvTaSsllygb4qJPgLIIcnp9UtCPUn4Eluqe5WWOh2aAB6Q?=
 =?us-ascii?Q?I1JAsTEnUCFEeK2JeczSNS7OljU3qnLpwhvMbO/AiF7bdEAluc85SAXrYZKL?=
 =?us-ascii?Q?9hOuXMRLvROqh+ZYxBCJzvHPKxMHdritipN5zwqu8R8iMigbVNmPgl6fa9Gi?=
 =?us-ascii?Q?h1g4kP3pVBkfiDQPFnu7fCGvHqouI6AKABsLJCU5PbBy+GCH8zmXzzw/cTfV?=
 =?us-ascii?Q?NWyX5S1uFyQeunxtejvxsxNa4k63spOIUWvmOstAZ0zoEP711gVK6wuVp/Np?=
 =?us-ascii?Q?jAvYlcjI6nqvz9VLc1CRgFWEm33VUJdl2NcyYs/6FrOERzUNjbI1ggT1syuE?=
 =?us-ascii?Q?xZhoDE42MrzwZdShusiYHK7sM1PwaPJUFTat9q8GtrmfHvalc1ZUH3QwXi4p?=
 =?us-ascii?Q?MmM7ZkqRlN6uBM6KHy1+SDGnw0EL07ch/UA85w/3svsQ40Es+eXxS12dR9EU?=
 =?us-ascii?Q?2aTY4mf/z6wgAFHGnawv9BcioIQ+YECXRAIYNUCJ6R1TCznm0Jy3Ze+vC9Tw?=
 =?us-ascii?Q?dMpVSloiV51I+uhYDcSqmF7H624t0BkFkc7dDbcvMuT4ohRr16RYoB0bBFs8?=
 =?us-ascii?Q?UkMKMeE9i5O0DWScoJdSq8I4o5+5p2+b8Qqai2nWM6XNWiF/+LekqgMUFJZn?=
 =?us-ascii?Q?+NM/tB1VtfwLTMgjnRRZlBLjIO8vqkcu0vQ5ZccA5+af0/B9ddmEymo1ZrhN?=
 =?us-ascii?Q?7SGf9YpBokaJL9gl9Or0nvKVIeNqx7VbvBSvVkZf63JsE2m3NXFWXf49bSeZ?=
 =?us-ascii?Q?1/g9Cl1YeYkX7Ug22j2rVornjdB2HBx0a+/FV1lWS/Uli3e+OTsTlCTjfu7H?=
 =?us-ascii?Q?W0X7kp8UmHEaO2KNNkcdFmVt93OZldw0gIlk6z51JZrLC5bnsWtjb1CLfcF0?=
 =?us-ascii?Q?+ad2cooNE9Hv3qZoLlmqEEQcb4W8A/0Gz8qksL1SZT2aw6yQEorwigVYxp3G?=
 =?us-ascii?Q?eG5hdNn4UMyHtJKksgTTiQ7DrP8TDSsbqOPRTJk+K9DchsDDEp5eCWhns48C?=
 =?us-ascii?Q?h+0MO+ryG7+uw4KTkmyVS6kS3lhInCo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db81044d-5737-4217-a0c8-08deecb60f85
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:39:42.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGAXkLeujsA1UsLOj2+DaWGmj6DT4kTgVgS56k9VERuD3N5s5H62Agd2AftsAnC5NMQFnDYJSkWpqmnRxwix+b5mMyKeuvLgqLq2aCCPqXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5939

Add a scheduled Xenomai 4-next long-term CI job with a dedicated
pipeline configuration running extended EVL stress and latency tests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .gitlab-ci.yml                  |  8 ++++++++
 ci/xenomai_4_next_long_term.yml | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 ci/xenomai_4_next_long_term.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b3d025e..589db8e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -91,6 +91,14 @@ xenomai-4/next:
     include:
       - local: '/ci/xenomai_4_next.yml'
 
+xenomai-4/next-long-term:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_4_next_long_term.yml'
+  rules:
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
+
 xenomai-4/evl:
   extends: .parent
   trigger:
diff --git a/ci/xenomai_4_next_long_term.yml b/ci/xenomai_4_next_long_term.yml
new file mode 100644
index 0000000..906f23b
--- /dev/null
+++ b/ci/xenomai_4_next_long_term.yml
@@ -0,0 +1,24 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Tobias Schaffner <tobias.schaffner@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/lib/gitlab-ci-base.yml'
+  - local: '/ci/lib/kernel/6_18_physical.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml"
+  XENOMAI_VERSION: "4-next"
+  BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
+  CACHE_KERNEL: evl
+  TEST_RUNTIME_SECONDS: 3600
+  TEST_COMMAND: >-
+    evl test --stress-cmd "${EVL_STRESS_COMMAND}" -k $(evl test -l | grep -Ev "${EVL_TESTS_SKIP_PATTERN}") &&
+    evl test --stress-cmd "${EVL_STRESS_COMMAND}" latmus -- -T ${TEST_RUNTIME_SECONDS} -A ${TEST_MAXIMUM_LATENCY}
-- 
2.43.0

