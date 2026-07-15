Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CFD42903B
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107726; cv=fail; b=vCDad8fGN76AEdGjj6mNsJZZfviAKQb6EON0dsT0IuZrw3DraapWmq8q9kk1LPnDfPLtY31MDf1IBDt7wwHWKNQUCzi7I/gGyjgjq1FHZdu8OjR2KgSYokfOjgnuvhwQbeWSt60ugsRHwY24bPpoOJo0sIR3+pZRqWc/QQDviZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107726; c=relaxed/simple;
	bh=sUVAKAqjMd9ZDksukdpwPrPiudRXW0fQxSLIVKmHBjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sY2av7lM3vqMCB1s8Uc8vbMVgy/z9oMyUIqdULjcNn8g03ct5UiY+9HpaYiX9tW3RIDlSoEvC7oTyeb/QqKz/4X9knaV8VL6OhfP1QeuqOqmXiS4HrMqvlOzUddU4q8nhpi6FnBn3TM8D15iD9EjVPEj3eK09jTVdb9E64MoO0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JpNdaOjz; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JpNdaOjz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHXv7fRejsDxQpGNhr6c89SwfgeK9ufdR/G2Y9pjUjvTOTJtBVfa3FuEKGYYP3MCDEykZvZ2PLlz84QciD1mTBSrZOKvjumC5c9JR9SFi5nG0xLVBz46f+brNAFGv/slTN/6836nHzVkYUVYlNfQlPML9/UxlVACXomXLcMZOduSSXrC/wYkm0EeEIjZ8dhJkT3HXg0VRbI4A6czm33Em49XpD7ZGZFwC30Eb2+yDSZos5J6ltJreVm2oC9EnQtTDIsTuMatZKwnUb+lcGzjjK2NLvaLbOASVZY2dW9dW1nszrRrTrrZcw/M88i8yh543wgPYMZT6jUsr40qrLLQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQJ19jXh7cIQyeXOax6Y9PSFHLP4jq5+ffX8lW0g57w=;
 b=sh/17ZWl9DfMrw7lg63GGtjDmhEMcmh06G33fbZ1N0bm7aezydRYxm1K8Nu6oIMZt6fJqpM14nMXsuxA92um3bI3qfZugBu14otToFMzn8nZPWILZ/EpnYN8l7vmZSGnCZ48ZHh5Y2iArt1LmRNrNHGnTDx3dPuCHyJx9L4/22qEZC5MacISNeN/xAX1drR73ZfEPb5AzqJFAOgdTLVw0eJ93NlXKIqMJVb+wCePls1e/Vs5IRcLYD5FuP997QsXLmfziuFugsfVsmkGPVA2FTHrNlHjzyML9Y57fjG9wM6Y/1r9Xce1zALU/reVCQRwh/yZty3aE+vIopi7hpMPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQJ19jXh7cIQyeXOax6Y9PSFHLP4jq5+ffX8lW0g57w=;
 b=JpNdaOjzEpHILeSInHgmnqbbRgLIs5UgQbDERFa+xWvXHWC/ONZny5cTpP0cJ0IKnGsNsNTsrK/p3MWdR4tt+CyRIUFzo5FQPuLEsBIY4BTt7UFjeDgyh7nm9bH/VT9KqH6447RidsgIrjH4Q/7qi22rqGNzW1naSOnf97ZQ+hQ5sTENvIfFG0bhYb+TDvb6zjiyL5xa/Q7Yv5Z48H9t146T1U2+oZpCV5Ipbht547vEuDPZIA6PWZQFWGhWVjiX78wMwITscHGDDFFh0MO0kn3e1N8Gbx+B1OIRZ/K4jbUyLXcadKlwWp4O7qMSZ637oNhAlZ/eFz1V/K0N28B09A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 09:28:30 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:28:30 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images 2/3] ci: Update for longterm test runs from 6.12 to 6.18
Date: Wed, 15 Jul 2026 11:28:21 +0200
Message-ID: <20260715092822.223712-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715092822.223712-1-tobias.schaffner@siemens.com>
References: <20260715092822.223712-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3745:EE_
X-MS-Office365-Filtering-Correlation-Id: 3352c4f5-a6e2-424e-a20a-08dee2536ef5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10070799003|55112099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VeAqouJd9Nw4uSFLUZaArwnLrWsz6dreVCC0J0Nf2ME/4pgjc2elVA6vLVJL1y/ucFJCCtbS8SkCWqKjTOWGo9GALfd1xuC6kgkVGMZoJHEIZOffcD/lKyF3otfngimC1uUEMrfPd0AHDUxxEsAhYk4KyIHIi5gYU8vIOksDURoA9jNZe6+nvxY0BvwJJD5kf8vKMHq3+V1PHr5ZtxNudAYFTYGhXiDNd4gWdIp+TKcHWgNHMkipHJMnG7vz+byj1GwOtxYgWMYC2NyQIBpaie79kDgj65VD5hpf2Hi9vqBbiSlNA0ta10V4ObFBBQ0Dys7W/tzQcaWFJius58OiSPKg0zerPIvLXC4EaqLWTL+id3nwilrx+5by9qxniL5oBHe12XJzrlj1CrJo5EAXW0fKsCQsaX2F/1uBKWsboVc0FBjDQw8I0NR5WwfLtApWu5KTZT6PqI3L7YJ7EmeZNwULNnorr98li+yKbTVddOnQawnTmoe+jTFhNyr2CiHyExvxa0UcfBeUGaomfL0bZkzidyWbzlD9dIYu/TPIUXYUEc+KE9CuKdKyZcLUdSrrIXZjDmbWzxc2FRG6J1kL+OmWdPLyyX/KKzdik2dbLnV9/zvPtU+6/CIJBlZMjX8T7EazYrbmjImtxsNrf7iDQaBGJDVOdsxL/UbH//KOybk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10070799003)(55112099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QTpYFh19pmRE3oadSi6FbbMprFrf7NcdTH5FH0wT7tiRhJv6fdQeGXGWg5ue?=
 =?us-ascii?Q?9Li/a+0wFCj6X1JDUuu5vrka2rW0wI3Jn8C7iyE9gY3MWdxm207C0QMovHD0?=
 =?us-ascii?Q?Yov1pTzSjMom3b26MKjqoyJyIWjulreZPal9xpb50cuPLOvBuTPT+qnDohgv?=
 =?us-ascii?Q?P/5g9f6uVWnYK/NftXjc/POw6/BldecTQ1MVFxnakEOffINz65XRobLQOzuS?=
 =?us-ascii?Q?j/U5IXf4cQTu3ZbFa5/o0ZGjz6vD8WecJgwBfSRU97ys+T42KXYRO7SHGDge?=
 =?us-ascii?Q?UXs+qWI1T7uyyVSmHWrIzfEUuac4YyKZm4mTEtv+Bp8CwNW81jy+kyeDLt8J?=
 =?us-ascii?Q?SHuRleiOJyou3zVywqI95iT91c12ARgW8eM6dwFl6M/AZQHhz+aK5zOKe44H?=
 =?us-ascii?Q?1HM6rv5fL7pCGcUJOEacLOPIz95GzPIiPDyQmiTBOhb0eVMHHDI68ER3W3nG?=
 =?us-ascii?Q?K0rxAN+4Mo+t5v+Q4y+dyfJHFwgowngDcbnjxI8ZOxyIwL4oycKrYHPcjDAx?=
 =?us-ascii?Q?iGuecMT1L0OItVLGrMLvDmspAA3plaY2+RsZqwje6MXUWwwTHRjjwf0x7MAV?=
 =?us-ascii?Q?uuaFWXBLU6kHPn8bxcfz5tkdbbSv0oKKTAV2XsmUCObGIa3si3/mPgh0BDn4?=
 =?us-ascii?Q?FzCPHUzJWtjMRaRPbyK2ni5FKNb7K50QFqHzmO+4VAzEqQoHqENSTSQvSMIh?=
 =?us-ascii?Q?+UhpEsjx7hgRgMoXHYfOV1gJJQcPt3lbkT+kIv5FxMIXLIuHeHOIm9raB5XT?=
 =?us-ascii?Q?zwgCxrA9pd3GNvfiYqKu9agLmyZtWgExrq5jOAi0PKPY9bi1SVtoVOlhr3vP?=
 =?us-ascii?Q?7r52T1VFsrMwB/VUCJEr+XlPByAHvxbRlKxCjtYG9dNsUlzbNCM0ZBcNInTv?=
 =?us-ascii?Q?E7cEJuKePWzD4nePT7L0GnEP2qlH7WHwLLdQPAdH1yrGIwZr2QDz1ysmMVNL?=
 =?us-ascii?Q?1nR+oNmnDP5A9HcEpIQcwdLhXZaUQdrOnjoHNZNT2QNCF7k+xx8oMDBK2J26?=
 =?us-ascii?Q?2Sy54EEEaC/OO6rq/vkmVo2H1KQrK2TBqCEM7tdaF+1oEqOwfKiE2N8iS8Xg?=
 =?us-ascii?Q?k7G4rlfWgFAh1YfTKuWWYtGfpJC8uErkPY6VyLMduxz+fyBVoDxhDKTuSOHL?=
 =?us-ascii?Q?UAbssY+pQ8L6I0MI92P6OpJCu1e9Ty6Qj8rZtUiKjMKK/2QUtX11Oh7nfRxO?=
 =?us-ascii?Q?ZVLs2d3rMfObHX9VKqfUjC9QkxCvYZgC9pZVWg0O1NR2NlF/7C3ggjyU9Sxa?=
 =?us-ascii?Q?ZqL4nMiHfq396Ql0/e4KICtvJUuEO51Pvo+ykK+wDGHCueTJATeBN6h0cf56?=
 =?us-ascii?Q?RD3XCDHpBQlNBJ0V6ku1txHBvVbhEdvbP+JeDtovhKb0fHEvgx4hFZ3Yxfzk?=
 =?us-ascii?Q?jDQBbPD3I0cuJG+awTOVUVCqrsBOlR671JGb0egRvfgV/x4iLURyPl+4zDyd?=
 =?us-ascii?Q?efwz4p/1xNPF95YdUj1gGKU7qf8R2YvMOSDHfyys1IvGzvc02ZPYZLWaOEDg?=
 =?us-ascii?Q?juAVnvfS226AttQhyeN1//rh6TEZW0dOUpoK58llN8yfz5GyIf5IZp0KFhRa?=
 =?us-ascii?Q?SAhR9v6agqev+3BGMFVmBUZTi3cpgHqCIPwdHOhTZpOb1x05lnROS/oxg1tJ?=
 =?us-ascii?Q?eSlmQK464wjiTsZn11/Ez3bby52O5TX1+L1lPJ7n8kOu95iSPFBj7J2fyVFU?=
 =?us-ascii?Q?+LAXcXERRsQqYOWJwQ+dZVTh8OJWv5Gim1RgKiDgLduVbS7kvBFCfz9blX+V?=
 =?us-ascii?Q?XVLbhCfof1y4ZFxXYNwzS1jg3y0d1w9Z8A6az5/tsC8JR0EYe72SHdYbtfQD?=
X-MS-Exchange-AntiSpam-MessageData-1: 2I3HsHCTqsJdNpNu8U/v/43Dbh49LN8NZ0I=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3352c4f5-a6e2-424e-a20a-08dee2536ef5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:28:30.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqDKHxMDKcqTBm+Za7qNYJq/HwkHxB8UGj/VFYrhFXLSrCaT7byc58iet2PhwosgDbIRKJ2LdUwWZpcUm+USH0b113lxYwdroR/BjwLUKSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3745

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

