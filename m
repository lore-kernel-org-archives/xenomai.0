Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2042.outbound.protection.outlook.com [40.107.103.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52617DE29
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212694; cv=fail; b=jZSmMYC0qq9XP+iecQz+zUvVnvh8PF6F/G4C1ssk3soHDqFXf983+tjggepxQl9W6gh3UTYl8CR2/x8gikQ3I5U06gm8WOwqTmcslI8j5RmEx6nNyDGndeRvEqBetlSTSMEWjRDxWHiqYcTutsESD64B1gFdIYcrvLD6UYr9nRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212694; c=relaxed/simple;
	bh=M7hx7Wr3hkT8Ls0SgicuWRtdQ29WUdyBJOgev4WDpXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1TqX9RhEULs4DOujRU3ldpwaVhc6hVD4Kk1qTAApHrCkekzu+2t5W0ph6iaHFcdgHIi+DWrKIEE2Crvh4+NswmO9g5KdRgGDsl9j0s7snflF6yKjudRcCKbBGI4FFKDF0PY28Qm6RO+sBzAlg59koiKYXSHQU9FyVo9McwIWEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lHZi5sXM; arc=fail smtp.client-ip=40.107.103.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lHZi5sXM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+MVGzReMspUDeiroyRhsm9nZ8Q8vS7pwD80Fy+F57FrMhC5FJKtoSZ8S9ukiQ97hd051nf57hK39X3hIsVYmyGmnXX3s/ik/2bqJH+8VHVz8RTWGzR8JL8FwiD10LSdUgImOwrqpGauOUSmDfMUfrq1TAc1AqLpkWo5NNUVfdcTQYFquXejHUZ6d29QWhfrTyF3yi5LR5m4u/itM36fbmSugaaA1W6I/fLPSakITXMRJsR9IUrRZ9nchDiTifmTxLtFdCUfkpRxhpO8D1qLN1JYYFq+7jCu0ZS8RyUDjRPw/MxUew0Q6bsYuQzredWfUvMjU9R/TLwuuR3yfjcadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyrnaNA6D5UVQERiqWpD8DtkXgeI+cqXJMRsmvJpZhA=;
 b=jczb+cd2m++4Umfp6yuAGm4PEVqAcM+IFFTY0UlaJ0A2E0RDlx3exO9eDGtLtPgFHG44LtIzk0kTLzJleJRB+TvcjjY0CYKDufbvKhOVoSHG1EKElcpmiKeKg2QvMtJIUHyEfhi1g/yYl49gegGGz87tzVvSTG+hUcIKnDkmLNSLM1eDuiaTGE8/fjne8Jt+ZsO9lEjwy7B3vOSVO9tXiAPgf4dyQjXf37BdGkLG3zlJAUaAubl4BqxXMQ28ImvJcsz0hKO2gfsdCoAEh9Mv3zTKomhSuFnoFz9o2U9IUPj9nNn4qcvd5KwekHXbQoCrcLXvASGD7tzqnmAc8dKG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyrnaNA6D5UVQERiqWpD8DtkXgeI+cqXJMRsmvJpZhA=;
 b=lHZi5sXMuV7aMQWhBo+WgwD910CeOFHNoYT2BhvjqsC/mDkiHpnfhYrZErWNyu079JhdrI515PFYE2tVKZsOD12NmfCa9UEIHx6gXXi5WsOIyapfPSN6cZgd31gBMt2RBsxduHiL8kkyJ3pjAc7o8RIY5giSoLk3SbH0w7vVOS/LPMeNEqCybcYsDJcta+d9mGGUpjoFCXScln74FtEhKejzlwdT77aQDEopLl2UwpKhfgzzHw5kKc0vO3Pu4rT6qSvp3LKFiTc4FneW5vkjSf1D7xt1wc0pLWvO5c1YC7shTZ0yrfA6MrEUW7X+t7LaOhqeoBO55q7AxVrq4aT2vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:408::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 10:38:05 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 10:38:05 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v3 3/5] ci: Add a long term latency test
Date: Wed, 17 Jul 2024 12:37:46 +0200
Message-Id: <20240717103748.161788-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240717103748.161788-1-tobias.schaffner@siemens.com>
References: <20240717103748.161788-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::17) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0b3f7b-c99c-4dcc-dab8-08dca64c8aca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T7BMcWDLFrZiisA9h2CzbyYpSR9FL+kWiI78yZvcU7SGT2nuN/5KdXALWdQr?=
 =?us-ascii?Q?QbqKMHp2MSlCLM6PKla3AvjkMk3z3Trr1pHSZVCuyonFagS8dRsIGMLPhlTL?=
 =?us-ascii?Q?InostlCeXcIwt7VbBy6tiMfULw5aBsujjelRf7xx7CzfOyMulNCM7FIykVBN?=
 =?us-ascii?Q?ODq/3QuR262AcmMQ6rWpN4s+ISzmA6hL2BtOm90iFgmYshnEmza9j75RlD3M?=
 =?us-ascii?Q?ZpyXiIpaM34JWh84az6RJDCFlXGVE1sNx3Am43mF/kaVQdw/3oSe3Ts0j4el?=
 =?us-ascii?Q?C8YEKxjQmxuWwgQuCjN8O84/aJzgKYRV9y2rCr38dBa/9jDjLx5PU7Yp0mZY?=
 =?us-ascii?Q?hSVRysIxDb9wKptRSnwSrxhP5NUoOhRQu4bXYYa3msbyRQXqfiIhfkGAsZFr?=
 =?us-ascii?Q?geyWd3aT9zp/Z3MENnuTXLzhmGZ7o0DIbIZ3IS9wSpUdkq2cHKU+TcmtECJg?=
 =?us-ascii?Q?LoPaVtVlXXFZMAZK0UlfIMT3kmjgrTX6ZC9NCBvW8J5/0K7iPnj4lIzjZ3LO?=
 =?us-ascii?Q?Q/2o+rHbQh2p5Ci4oSrFtHitpdKo9PuzKZfCFql0ErrW+WtIMV9sALQOdJg3?=
 =?us-ascii?Q?y0lCOpiPswIy89qZR5FPP4Ak3kYW6NH4uLDN3wqpp1TSVBPb7mCL/vI6TZ8X?=
 =?us-ascii?Q?ZYI1fryE/VU+VvXemPicAG8xv12EU8XDtQ71Y//fF+SlbT7tyuDKUOACZT9S?=
 =?us-ascii?Q?5O6kJNxHKqjhk1sOw6DdQAGJi5gT7edqIsBNCv3EsKmN8g8R4PlNyozE+7qL?=
 =?us-ascii?Q?9sfghQs+4cz1fD5/wFG4VrJ3se3baS/twhWwryvzPXSqRXfT/5Vu76rj2Fc3?=
 =?us-ascii?Q?8KrS35o6uBnpNGvvqpQypNRxPe2ASfnjcofSdNYv2Xd776ScQ/Gf31tzcIxO?=
 =?us-ascii?Q?ekkLSEcCETY79Rc9PL7cgJYTZbpM8KSqWrUZHKlqnmYfKLcuRHfrsdvfT8nP?=
 =?us-ascii?Q?5j0nEEuQcRp3DJPHNcUK1nyejPgc5ZTCraMlRhomGEkwlsOMgPOXz7rgsbdw?=
 =?us-ascii?Q?VfwwI5lwJK7lyuMqQNOx3RQhhZmGqxVtf6RkdYoI9eu9Vm+k2vClENoErhGD?=
 =?us-ascii?Q?X6ZE1ngcozaizhcrurL3Rxw/ek6KtbRljYzo8N7Ofc7sy0HHtLGTjS4XrY3m?=
 =?us-ascii?Q?JcTIwer7LyCGLtLvgcmD862mlhCAZR0dJU9580dzHURka+41BjvuQdO7wG8y?=
 =?us-ascii?Q?amMzKQGyv1gaLYKzBa010l9AT59Kg5D/WLe38Q5CKV2f5QOHLHj6IU6A+0Ao?=
 =?us-ascii?Q?NwwWr5yZXdYA1O0Ka862o/LWpvwSKVslHikqtk8WbLnpmPs2EhUNJlPH1gDF?=
 =?us-ascii?Q?XcWvk/PP8jOrFgqK3MfQ6e9DCCNK5d+di/5TeFV5IFMIgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mOutQetbvHkZplvnt4l4myhSJi5EIj231qc8hmWgc3UTNm8+rPfOcFkc+5fD?=
 =?us-ascii?Q?e5j5V76bvyGZqEKo/G8PiHfNHyb6uPk3c7b1WO8JSj1PJIdhedFOTXZSuyss?=
 =?us-ascii?Q?7HAG0f0Apo7mVumNk2YKid9b4j9PHNsjTNdpwuc/9Kc1WTmAJSIGmfekDey8?=
 =?us-ascii?Q?v/IQGWLAlmvP70jTtg3XL97XxNMVjX/KvdCqnfeDqvGni9iZXZQDDpOGY8ih?=
 =?us-ascii?Q?aDH8EwgafE6HIN/ZS4QDags30Kpb1XLRiWuqikkkvwP2OhQWh+EVXpIwA/Ld?=
 =?us-ascii?Q?wZve09v1KQNePqihLCO/EOsNInEpL3WKo9aVdOLZ4h1jy/NrCIo+qEIF0pbb?=
 =?us-ascii?Q?lDc+L8s8b7LX2Gy/xmBGDKYkPjvcktOidEnuQ/RG92rj5grYLpvtyWADcu3w?=
 =?us-ascii?Q?xoXaMi+iOhqhGcApJAWLL0+cVufpqcVwMyizPhxsvqSoEcRugZrT6yEaH8Z9?=
 =?us-ascii?Q?wxETwvYsWLTc25mAa1N1VzKrMQDR117nYLyk1N5jC4kIPnY9AKPsK1HDTQjJ?=
 =?us-ascii?Q?06wEArT0NSrJIfYl2uGLUzBzPNPbXh9AAMjCYzSrr7DKMp9Y0EBOq3nCMTY3?=
 =?us-ascii?Q?YFH5xLjMCujkgGNVe4lagXtk7gQDHAcq6iECttlSKPAn6ZCXcbPlrfVVHctw?=
 =?us-ascii?Q?y+kJYDflK7QP9luLpHKvWs9akhWq1oEgY8qLKfpZypQCRglv5XzG9WdZWGj9?=
 =?us-ascii?Q?FNkC/xrRrXwEHzya0JksZ0ZkiMGOXLZAfrnHj+dOySN4PQr59JKiCASpX8sR?=
 =?us-ascii?Q?qmpwX9LT0VwlJLfWhnbMqiyNXMiIMT9rF8Uyce7r3/ZgvmvKaY8+PkCyFCY6?=
 =?us-ascii?Q?q3o1XZDK1zPxOe6blwuEwdmcUJ7jeBRJmtehIkbyd7M5xIFXxJz67WdCfntb?=
 =?us-ascii?Q?hhWURNelpoxv18iSV1AbcJnMmjvlW8ZlaVr6aXJ9+X/LmQz42jJwFU13pzyC?=
 =?us-ascii?Q?wj/JQqu7A/TDrHTg9cGKk5ShqTIyBomuHu92DcRpyyEzpXuaddw/YTgKDhMt?=
 =?us-ascii?Q?jjwFPCHGQDXYiXizHIVtB6nOPZxzuetfiIde+6uN0ZmIysrxwjp8ZWJy8e+P?=
 =?us-ascii?Q?RJT8tZZgczyeT2Vjtx8B9AIspjx/9IatUn6zsuFO3nDy6E7gMNzpGwMcSEJN?=
 =?us-ascii?Q?WyjHAQYcstjQE0FYl3AMQXvOqJBjiSRTmcFB2LESbHkKY9mCPz3Q2miODUcg?=
 =?us-ascii?Q?l7f7zrbnJbaZf0T2YjBQ1bjPJiwyT3ltxktuxDj/ocfj24ilY8BbtGEzGoDc?=
 =?us-ascii?Q?7nbOff30lHntbYtr+OELkKwFwrx7WQD4giYqYP8R1siRvaIfcc5u31FJLrzN?=
 =?us-ascii?Q?OydPepQMcV8x+E64VqSZgWryJbwI12MVtgq5GibSvkPoISeCC+QkmLn1fI85?=
 =?us-ascii?Q?AcyIgafapTeYu/ogwRsTK03IsXHdEUHebrw8e+jkFQPSHDp2K+Qkjukl1Foa?=
 =?us-ascii?Q?RXwtjZ/Nwq2hALVC5k+wvSt8u80wDnKxL81zzV23+BwBP0eSGUkjGTHDP/Sk?=
 =?us-ascii?Q?c/o826INn9ieDBKVzOVSb9jAN1cJmGvBgueLJiLv87GzwWHRkLvI3xUE5/ep?=
 =?us-ascii?Q?0G64rV2L2PXKgraQIoa5eNLhD/6KhuMdWOZPhj6yUVfc+A2P6/qfjWZb6b9f?=
 =?us-ascii?Q?BvC3CrbvSoMMM+LWByXLVmQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0b3f7b-c99c-4dcc-dab8-08dca64c8aca
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:38:05.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rum7tsZy1y3ag9aJQZVGeB5rXAnkN5NuuhaeoQS2p6mxVGguypY6IIhC7NX45H0VFROECingc/DZSKvQO/Fxr16UKu/fNFKdTwAEMENcXJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6439

Add a long term latency test that is only running on physical targets.
The duration is set to 60 minutes for testing purposes.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .gitlab-ci.yml                  | 10 +++++++++-
 ci/xenomai_3_next_long_term.yml | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 ci/xenomai_3_next_long_term.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9edf635..b8945bc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -23,7 +23,7 @@ stages:
     forward:
       pipeline_variables: true
   rules:
-    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}"'
+    - if: '$CI_PIPELINE_SOURCE != "schedule" && ($ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}")'
 
 
 stable/v3.0.x:
@@ -49,3 +49,11 @@ xenomai-3/next:
   trigger:
     include:
       - local: '/ci/xenomai_3_next.yml'
+
+xenomai-3/next-long-term:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_next_long_term.yml'
+  rules:
+  - if: $CI_PIPELINE_SOURCE == "schedule"
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
new file mode 100644
index 0000000..5fb0de7
--- /dev/null
+++ b/ci/xenomai_3_next_long_term.yml
@@ -0,0 +1,20 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Tobias Schaffner <tobias.schaffner@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/kernel_6_6_physical.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
+  XENOMAI_VERSION: "next"
+  LATEST_KERNEL_VERSION: "6.6"
+  TEST_RUNTIME_SECONDS: 3600
-- 
2.40.1

