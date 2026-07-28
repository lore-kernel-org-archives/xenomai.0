Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C574483AA
	for <xenomai@lists.linux.dev>; Tue, 28 Jul 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249591; cv=fail; b=dv3IA/Si9Kzzk2DAuDEjNYFVlIWY/h27AAZKVyT/5StCPdYdXudkpAy+5PQVJQ6J5gnbPqVpZPnmJ1xrFaGhv2g31nJnONuNmZAQuAjthxsf993huh/Tp7eatrYaVpPXJiqPjaWCaLo1c0Qb1HqUWDLue7Y5s62qNBa5SF//yeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249591; c=relaxed/simple;
	bh=sUVAKAqjMd9ZDksukdpwPrPiudRXW0fQxSLIVKmHBjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cPXTXfPRoFtkWHHTrO5F776JJdJ2jFXLwVOUAXSavVkjPv+vQN7ckrLM+AM7UK95vAX0oLogBt6Ymm0M09ZVR3gpB072Sh/xDhx5z8Mn2qiHN39F+d4dboCBflBa88zcMtXXzT2xhjdzyDGz3BCaiBkNWLUBpP7gjdA5KmrWlrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=pgGEv/tD; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="pgGEv/tD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LESoBNOOlMz/j/e6doGm5DcHbmL1MISVpxVZpFy0LzbPT5QWlBf9STYLOsO7b6+VuMoxsI/+z3yC/vPX+992NRP4UJvAbh54Idky1WJ+BDYZP9RaQROhvZnChIZ2wM9eTzAWRdcxv4EVgWNRxuYQV6Eo4iJgJFRKuf+/fyxDd4+/A0XAo2ScWkxkbxti1Y5q94TFP6PFK0bIAA5HbJTJA4XSuHTshTpbtAYX9p2CEix7mVjYUDj0YttzBl1nVfSZF3KA8FPoUH1qcbpnmBVN/DSTbqAIsCAEEJ9NOEWbPb18yM/+upiiM432QeG50tX+K285JvUflQskE3/OL+0Q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQJ19jXh7cIQyeXOax6Y9PSFHLP4jq5+ffX8lW0g57w=;
 b=FnJwOhYOsimEHB8EXuadURRIWDjnRclCJbXl91xQrOwswNUfGudvbdVtn6MdGs7NV62vMdPL3fnT26KNRSDeLDS2IoDavefShJp+OdiXYtn3as7vF9diAGKPCg/Fyw8KaKZvNN2Gl0yt0d8NCiN1RhDjWpXXP+iyIHhF1n4E41juOjrU6lp6g788WMcdZlGCG18BcxfUsSWBNTTxfdJa1K4XorrB8NqZvOa5hDDu6PcT3m/pz6i2pSehttYkIzbmD23LuBhGjERjILuebXfgsjhT+/OHZg9VjsFkEsKt1IXXGMz0wkcGfbAPEoicC3+YKO+dFcTEU8jLRxxlbgdZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQJ19jXh7cIQyeXOax6Y9PSFHLP4jq5+ffX8lW0g57w=;
 b=pgGEv/tDBX7ttVhq/g9IS4Zqep2qXhA4jPlgff+x2R7wc7GTz6mHJj5Dj8CWkSvqT2mhArV9S67ectnpNVNNkmDT/SiWvBBpAQ8Du9gNPvPbWGZreuKlz9NxSwl5zU0acAQI0vmZya9Pop23B2hFNdKXozbtWl6SoBr5EcL/tmzCZ73mp7iyvBVdxBE7BhSxizG75xlKzERpGKXXnLCrji3gSDVwVDvdTif2vNy2Y1TVtuqBwtKpQ+wn9MkPCNWUZIhvG1baPJTtRsCNkY7yTRt3XcOUnYJhGUL8iF+Jp4nohZd8AMWvpzjo4dqhUWQOOZG3cNydbPFdK/eU+J6aDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB5939.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 28 Jul
 2026 14:39:41 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 14:39:41 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 2/3] ci: Update for longterm test runs from 6.12 to 6.18
Date: Tue, 28 Jul 2026 16:39:31 +0200
Message-ID: <20260728143932.2747505-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5bed27a5-c05c-458b-8d61-08deecb60f28
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	be73y61TlahjSLhoPOpNz5mOjf2C0Twn4s/34tPf3qg8xSk1S5btDAbrC200QYObIbmVlCkSJGIVTir4jvFXcNKePD1QMLaKwG+BUPFrw0MW93lP/0gXrAYOKt1zLfp+hQ9iLSVk2CAJblZHejrqLZ8g9SEbFL7zHtONjp5QJQenexMu5sEhJgsd/vLLSN8TcziAZPegW6nu8Yot6pyULVzTPH/A3sB+HjussMp8rpYh2sJHN8VoZOJS+c0JpQ2b/PmEICQhEQhEkmoxz1FQFpMMF2snz5WkmOmCb7Z6c1ZMWVe1LoG6lzA0rWP3Iko3UaDZjxBat7egKOfCBuzZTPKDiLCFgXNWvYKdc6srCwy6zfjvZ4v9dfVqqyy+N6Hqh5+C8Ed4QuF9cFxJ0P5JP3l1tYkgDs3VREEHrgEvMf8UD3vsEkLpyPo2YC5cNudwcEnBxew3q/ftQgUwyI8cW3LOtWjgwsOmnxOgO7pIKAZoJokcjvdGifnGeTXQgv2qsNW17lHkJDjw8rslCqRAXAE8FVZtqvmC3cq2wIyH63IUb81prAG0D+2AteEJEueI3oCiipO8iau7cTF7Y9UOPB0JYF0NWMCyiVHH0oj4agZ6FTVSgxMEJ7G6ykwaUCjJEI2ubFo630GoUQUQC5MF/nkIIZxg9Qeoowzr1pItPB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YpdGtsBT8KsevOFzYYA6iXSE46SK6/ErsQCKdGPOBLcVd6v6Qo4eiz6kfz7D?=
 =?us-ascii?Q?92bScvMqTw+ZUFE6nZjPjwcRN6kZQQNzzZ2eAJ72vbhrbo6AOlgjbr0LBcGF?=
 =?us-ascii?Q?lEaxUtB7tkgl5hwfmvK+7ms9iGVr5O60yEPg0jRz+1mE77q7txQQHv7a+/Rj?=
 =?us-ascii?Q?T+gvFb2q8YI/YxCykDCKRi5GrhecbVdYeSaB2GSAuX5wvYw68XnUhS3b9sE6?=
 =?us-ascii?Q?ctQMKHmn95WUjHD1zMJZjL5X2iXzYLL6XxW/s5ypvkw7LUqvAg638EqJe//A?=
 =?us-ascii?Q?dthuaSJU1CkzuM2SWbd57MXJ6hlzH3or0ulMhvUPxM0AoBrWD/O3/+DNExap?=
 =?us-ascii?Q?OXPJeVnNraS25KjrS4HWpO4sj7aakvbbmEysQrodM79THc9UxcrarWa5PPAQ?=
 =?us-ascii?Q?UH9H7UMgRJADKgXAgh/PyUSJXw7Atmz7CJpOFx+cVEzDT7a2CPtJ/HneNsVJ?=
 =?us-ascii?Q?iMAGnh8QEt4ZrjfhYOMV/17LJDilJV67nEl6rfxIisTN2EPOxi8LgGpXls8S?=
 =?us-ascii?Q?WB9FGOAQSgBt3ItvrBwDl7XGXKgTJUuWrNFaBmhVHLkQAG+mxarodRKFURs2?=
 =?us-ascii?Q?g1BHqXTN2IuAd0KDMS34GG0mXBQASk13R7cR98LTNPtlR0qel335VdziY/sC?=
 =?us-ascii?Q?5uVHgJ9bIYS4Mf7L6HQ2WA3PqblTRZz39vrKc7KC3WYr9tWdy0U398o9KQp7?=
 =?us-ascii?Q?6BkLnmbkEHAfQ62TvwNt22QmB344bevWgwYbq/vuA7NBN0GkIDvqFnaThgKz?=
 =?us-ascii?Q?oBPwletcJtVEdkhBPBUe7xQFBj0qahIZicMf55HflSKGbRzQJy3wNwCnx57K?=
 =?us-ascii?Q?5BeWiXGTgwSULh9q/0R5rbXkT0BSYqp8LvZFCtywJw88WmtoJ5S6Fq4b3MyT?=
 =?us-ascii?Q?CctdK46sgYfdwD4L9ejlx4bD4zDoVHX47plAGlfghTRln8ePefxJ1k+H6Vc4?=
 =?us-ascii?Q?nkRigw3W8FtQbpSLGZS3+P61Or9EFOS9w7ikJldnrfVGJVVcvUXdQ1YHcGfp?=
 =?us-ascii?Q?a1UgxnTnxES5RFiBL2RtmKILLf5C0Hwzwp5HB2uEaeYqyQWYhWTaxSYNsA4/?=
 =?us-ascii?Q?Y7pOTWfu+qsH7mKBNVhr+zHO+1HFxbXRNBRJAHJR/eI47afrWDbwf7Fjav/9?=
 =?us-ascii?Q?xL3riCu9JCUMsBYq0KyrY4XrIvRls+jmXN7v5A7FnJpYqiU+iuhuuXuYxQCn?=
 =?us-ascii?Q?zqSNToCmafl7/Mf76ykw4CHT9E6ihUfYFBeKDsu7z9chHGqGuBEvXyfcDCX2?=
 =?us-ascii?Q?o0NvKk5CbpUypVnRdw3WUjDtTGMN6zKWC2Q+ClLHJQG5uK9hP6pCYmslSd1X?=
 =?us-ascii?Q?gt34AeI/Mgedd5aLZKmPRAIlXWsvM+NQPzFdXRu8UPE3GvrJBE9qVf2zITlW?=
 =?us-ascii?Q?nhfWzlxGKXXSigBLg5gDSVYwfQ66Bo2apr5N+gIy8kb/wzI5LZ+j3xAYys/K?=
 =?us-ascii?Q?/pORm+DTsTw4CHYp97+18mZXNVQWkqagW0qB78JTHITVQHa344Dlnz68VgM2?=
 =?us-ascii?Q?Xxd6xAf9VSp5P/3BL0sPBIIl0+JoOy37bJdliSHZGOLDSp39ALiyMgcDfwpD?=
 =?us-ascii?Q?5CQMP9meiwxhXLaxCGW+wMXBvCRnqDgTeEq0GBOaVMoe4/SNIKK448LrtT6q?=
 =?us-ascii?Q?NzwW2sUv9h7R05lwNvSIerMLzTHbLQMx8yWZ8SIdiKFOirJzdiUhe6VbDYBV?=
 =?us-ascii?Q?Zp+wmrNzOQO9pREpRnODyPq90mnKEtwtcJDtC0axmSRFn/LoDjCQYPlxvCrl?=
 =?us-ascii?Q?mnG72mK4r4YKv2Os9xnrA7HhEsLFK3Q=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bed27a5-c05c-458b-8d61-08deecb60f28
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 14:39:41.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRjSPYZqeXIGKSDqUPnQTJh4pkOvlzw/HqsyjGXapzIJsCi3D77tGPbqb9DTQWcASQoLRyVaJUNq2yzjoL8I9kNHppXWkzEVjqTSX7LnTrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5939

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/kernel/6_12.yml          | 45 ++++++++++++++++++++++++++--
 ci/lib/kernel/6_12_physical.yml | 52 ---------------------------------
 ci/lib/kernel/6_18.yml          | 42 ++------------------------
 ci/lib/kernel/6_18_physical.yml | 52 +++++++++++++++++++++++++++++++++
 ci/xenomai_3_next_long_term.yml |  4 +--
 5 files changed, 99 insertions(+), 96 deletions(-)
 delete mode 100644 ci/lib/kernel/6_12_physical.yml
 create mode 100644 ci/lib/kernel/6_18_physical.yml

diff --git a/ci/lib/kernel/6_12.yml b/ci/lib/kernel/6_12.yml
index a9bed87..529d24d 100644
--- a/ci/lib/kernel/6_12.yml
+++ b/ci/lib/kernel/6_12.yml
@@ -9,9 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-include:
-  - local: '/ci/lib/kernel/6_12_physical.yml'
-
 build-6.12:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
@@ -50,3 +47,45 @@ lava-test-6.12:qemu-arm64:
   extends: .lava-test:qemu-arm64
   variables:
     KERNEL_VERSION: "6.12"
+
+build-6.12:rpi4:
+  extends: .build:rpi4
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
+    KERNEL_VERSION: "6.12"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.12:rpi4:
+  needs: [ "build-6.12:rpi4" ]
+  extends: .lava-test:rpi4
+  variables:
+    KERNEL_VERSION: "6.12"
+    TEST_MAXIMUM_LATENCY: 150
+
+build-6.12:beagle-bone-black:
+  extends: .build:beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
+    KERNEL_VERSION: "6.12"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.12:beagle-bone-black:
+  needs: [ "build-6.12:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
+  variables:
+    KERNEL_VERSION: "6.12"
+    TEST_MAXIMUM_LATENCY: 150
+
+build-6.12:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
+    KERNEL_VERSION: "6.12"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.12:x86-64-efi:
+  needs: [ "build-6.12:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
+  variables:
+    KERNEL_VERSION: "6.12"
+    TEST_MAXIMUM_LATENCY: 100
diff --git a/ci/lib/kernel/6_12_physical.yml b/ci/lib/kernel/6_12_physical.yml
deleted file mode 100644
index 86cd23c..0000000
--- a/ci/lib/kernel/6_12_physical.yml
+++ /dev/null
@@ -1,52 +0,0 @@
-#
-# Xenomai Real-Time System
-#
-# Copyright (c) Siemens AG, 2024-2025
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-build-6.12:rpi4:
-  extends: .build:rpi4
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
-    KERNEL_VERSION: "6.12"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.12:rpi4:
-  needs: [ "build-6.12:rpi4" ]
-  extends: .lava-test:rpi4
-  variables:
-    KERNEL_VERSION: "6.12"
-    TEST_MAXIMUM_LATENCY: 150
-
-build-6.12:beagle-bone-black:
-  extends: .build:beagle-bone-black
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
-    KERNEL_VERSION: "6.12"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.12:beagle-bone-black:
-  needs: [ "build-6.12:beagle-bone-black" ]
-  extends: .lava-test:beagle-bone-black
-  variables:
-    KERNEL_VERSION: "6.12"
-    TEST_MAXIMUM_LATENCY: 150
-
-build-6.12:x86-64-efi:
-  extends: .build:x86-64-efi
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-6.12-head.yaml"
-    KERNEL_VERSION: "6.12"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.12:x86-64-efi:
-  needs: [ "build-6.12:x86-64-efi" ]
-  extends: .lava-test:x86-64-efi
-  variables:
-    KERNEL_VERSION: "6.12"
-    TEST_MAXIMUM_LATENCY: 100
diff --git a/ci/lib/kernel/6_18.yml b/ci/lib/kernel/6_18.yml
index 88e3915..5d7e409 100644
--- a/ci/lib/kernel/6_18.yml
+++ b/ci/lib/kernel/6_18.yml
@@ -9,6 +9,9 @@
 # SPDX-License-Identifier: MIT
 #
 
+include:
+  - local: '/ci/lib/kernel/6_18_physical.yml'
+
 build-6.18:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
@@ -47,42 +50,3 @@ lava-test-6.18:qemu-arm64:
   extends: .lava-test:qemu-arm64
   variables:
     KERNEL_VERSION: "6.18"
-
-build-6.18:rpi4:
-  extends: .build:rpi4
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
-    KERNEL_VERSION: "6.18"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.18:rpi4:
-  needs: [ "build-6.18:rpi4" ]
-  extends: .lava-test:rpi4
-  variables:
-    KERNEL_VERSION: "6.18"
-
-build-6.18:beagle-bone-black:
-  extends: .build:beagle-bone-black
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
-    KERNEL_VERSION: "6.18"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.18:beagle-bone-black:
-  needs: [ "build-6.18:beagle-bone-black" ]
-  extends: .lava-test:beagle-bone-black
-  variables:
-    KERNEL_VERSION: "6.18"
-
-build-6.18:x86-64-efi:
-  extends: .build:x86-64-efi
-  variables:
-    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
-    KERNEL_VERSION: "6.18"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.18:x86-64-efi:
-  needs: [ "build-6.18:x86-64-efi" ]
-  extends: .lava-test:x86-64-efi
-  variables:
-    KERNEL_VERSION: "6.18"
diff --git a/ci/lib/kernel/6_18_physical.yml b/ci/lib/kernel/6_18_physical.yml
new file mode 100644
index 0000000..68b7892
--- /dev/null
+++ b/ci/lib/kernel/6_18_physical.yml
@@ -0,0 +1,52 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024-2026
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-6.18:rpi4:
+  extends: .build:rpi4
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
+    KERNEL_VERSION: "6.18"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.18:rpi4:
+  needs: [ "build-6.18:rpi4" ]
+  extends: .lava-test:rpi4
+  variables:
+    KERNEL_VERSION: "6.18"
+    TEST_MAXIMUM_LATENCY: 150
+
+build-6.18:beagle-bone-black:
+  extends: .build:beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
+    KERNEL_VERSION: "6.18"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.18:beagle-bone-black:
+  needs: [ "build-6.18:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
+  variables:
+    KERNEL_VERSION: "6.18"
+    TEST_MAXIMUM_LATENCY: 150
+
+build-6.18:x86-64-efi:
+  extends: .build:x86-64-efi
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-6.18-head.yaml"
+    KERNEL_VERSION: "6.18"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.18:x86-64-efi:
+  needs: [ "build-6.18:x86-64-efi" ]
+  extends: .lava-test:x86-64-efi
+  variables:
+    KERNEL_VERSION: "6.18"
+    TEST_MAXIMUM_LATENCY: 100
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
index da8749e..c22374c 100644
--- a/ci/xenomai_3_next_long_term.yml
+++ b/ci/xenomai_3_next_long_term.yml
@@ -11,11 +11,11 @@
 
 include:
   - local: '/ci/lib/gitlab-ci-base.yml'
-  - local: '/ci/lib/kernel/6_12_physical.yml'
+  - local: '/ci/lib/kernel/6_18_physical.yml'
 
 variables:
   XENOMAI_BUILD_OPTION: ":kas/opt/xenomai-next.yaml"
   XENOMAI_VERSION: "3-next"
-  KERNEL_VERSION_WITH_QEMU: "6.12"
+  KERNEL_VERSION_WITH_QEMU: "6.18"
   TEST_RUNTIME_SECONDS: 3600
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS} -- -m ${TEST_MAXIMUM_LATENCY}"
-- 
2.43.0

