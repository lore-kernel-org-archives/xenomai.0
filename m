Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DA8313522
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459450; cv=fail; b=teweyV28WCpssNh9WCnYeYqwIZVnWaIAJQku+sOWqze5z6JQvwcudKa4z4+t8M4q98Zts9+QLBqJzdlUnVVu60p5dxKbCaKCogKGC3O9RBPRNHll6T6unrYKaVB2uM39Ej1qZEdYbY1vhWYIYNNdapJvIpDHZgZ28BBdYtKGzPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459450; c=relaxed/simple;
	bh=bIpCWkwQmlXsjfkvK1CPkUY4kmM+k9QrWrTjTUVJFzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PKGrXX9hPfLfXlu27AZ3Og8rVmsSkRGjeQrjX7OcVl2dnHyY1LQJPBJyN2+zcfu7b4hJRnMit7V8WrP2lVTLBslR3VvEb5CYbUyoDSFAKXOPmWLMtr6s1ghE9MCvV0xEr82AaKbaF0NEL7EQZrt1T1QDj+uXSUiD30faMzvU+WM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VBpXAHa1; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VBpXAHa1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9a/ZE7bxKCnBqqIi1CPrR5YZHd2UAtoqg6+vaKm/SGhffTpLDNc7oD6UkBRZ7BRSZtEyT3BDIoQMr8N2iOJBVexgboM7JZkmxZnOyP0PK4f+sSoJCogxvO2DP8Srvh5xK8pDrOBcJbfQfus8SbJ3I6TzYeeoNdPMQ61tf3sD+s3LiOqczkyF6qc8b87suXYWiJA1wrS7C0a/5KFaNc+8AsbzNv3NqyMXD4kRMIRAQ/giPcGXbYKZ22Rd1PHCACKyDqXPKPrEYmCDJVFHd0wmb3KcTc81vVHIBz6MPD8fFStAYP7Vq5dUp+V4ijz0T/zGcOXGF/FmsRpyQ8Jm5/hYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRTYrxTvvUX2zf/IuCd6dbmgR2rVBFxazk1RvMsFrVE=;
 b=pu/voouOFyxnmu7HhB9Oi2aZ6QdgreVvPeGIckQPHJPN7mezKuv5FGZcf8ZNEL2Z5Vj/vfaYnGjPhId3RqDotpzzlL70uUnh0Ojx2QQhQwj3eTENjLCmvNsUSly7a74hWeaBT3aNGhd/ziVFvC+RwWl7uxIRbmB2l4bzEvhkZusLDFNYAi2j+satJcVHASUA8ntP/enIIu16ZDqs67tgCmkLvw1jQ7BnXE1uydAHo4s3DghmTtMqq7hlssUCbyiPjW7ZADmXTOZL5nd/LSefZzu6rFcqpAUjUq1cKJjm3AZbjIZGqWiGnbHJqxJdM4bM8am7UUcrl6znSjRWoVejXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRTYrxTvvUX2zf/IuCd6dbmgR2rVBFxazk1RvMsFrVE=;
 b=VBpXAHa1c0RpsRiTYyo2KsUgjwl/iXmpUaiynuyA64dIy0pE3WKzGavOB59MIOpvp6Vm2RO8A43lN0moKY0oslAu6T9bsy6zu/qsE7rNwRiA4ZAWXQkqA9igvvnC+eIvLXM3pkFaABiVreCC2GqM5c5rKu8ybuO2QrJh6OD6vbq8DtnlJjn8QAvgms/hMcW2IPOvPOr+pnZS568q8amqUfFKgYmyp4aGu5ARXJZCr5ogLU9B8rx0dtVctTL58od/VHZApswsWjFZYQgdD9h0ibAVtBf46CfalSFKhXxD6s4N0pyFszCH2DWzWtuOdUJNTyUdKRfn57sez+Uk7X8LVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:57:23 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:57:23 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH RFC xenomai-images 1/5] ci: Build and test the evl risc-v port on qemu
Date: Fri, 17 Apr 2026 22:57:01 +0200
Message-ID: <20260417205713.2290350-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
References: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: a977b877-b2c4-4358-f9a4-08de9cc3eca6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	cUJpXizjUQtFlxvEI2TKRD5ARRmwplZ0YslyqXbUKZ0t5OzO0G9Z957dJg3WPdEwjW2tAI5QNLjARN02javeF6KhyysjscqNSFY5t/tzXi74Tf0L2uE9AM3WKeLwG0UGKJ/7liU3viagxD5fgSy6pBcKl3FAaPKg0uZjgHFfEp60SDp4fF/c5BxjXOlkHCBu0FJib2pp9fF67mwuLzb880a5l/XC7gdXJ0Vc8ghHhxQ2kdKlr8d2JYvUwigy4JevA8Xbj9fC7WztsInOvt8lvSQOq3d3uSkwP6Ech1RJsTT0xCl28U5NIsmpB2nd//GWRqLE5Pzpqpm6+3YcKqHgwxyPXcwBfIG6X0A3vhp/Qlo7wr3h3+Jn3ng3egUuawmav0xivimyUV0uffQ72ATREbq+QahQn/V9b5CAq5NzYDvjnleSFULRUKlhELbn2y6fM8Yli8vTIbRJ7zetu8wqW8jO2POuG8OeZKlH11mBiscYtX1YZiEuYrqKhAb/6xu2xiiqPReO2ZEspT5l8F0zpETyPnfkhDWAm3bZQesT3RMgvym1WgXNvVkJ+clDOdepzfulVYeCzugGDGMYRIHHwysQ/oSBiazzTUToc+k691FcaFfukQNoeYvF8K+bpU2k9JVa3Kp7tjcsOc7xtU0IQSsNumueYqgy9cV1KzglpvqGfOpkQrbqL3EkbD+Q92Q3Ko3Fwag9x0EorPoZaAuQrklxH7VTKXNvUGkthhD3u7M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R0X66GvgSCsnzVSwyV20VZO2S7LwDsToaYTf7/7CoLyq5QFYrcdwMu7HTom0?=
 =?us-ascii?Q?qUw7PvZh6Wc+8QUboCd7Q0J/IffmxaivwPyPAIpWKmPtTu+3HamuAJg49gJW?=
 =?us-ascii?Q?E0F0VBmLDxJRzCegZQ6xSNwWFxVQivFuV1Ktn+27ae32+vp4WfMEiiCb8QUr?=
 =?us-ascii?Q?SM6lBVT8RRufKomNkXkkNm5utIPZsCsmaR82hg3O3FEfLnyL+eM2lAhW4F75?=
 =?us-ascii?Q?UtYSLRevUsLZ7zesXuEMOUHb/DjdNJ/u3B0RjzV5KEuJ9J/hr2rNztUil4CU?=
 =?us-ascii?Q?9Sh2QqFbBvW7hSAXk0chwhmvvMSfeTs7sSuPzsQRxdUcDo1fECoUKKg4HTot?=
 =?us-ascii?Q?vYIaW2xv+D87imeVdPo0Ik/pp1WxUtqZ7vnZ/qCEEuvCHON1Lop25XXQVBtJ?=
 =?us-ascii?Q?y/1sdItF+u4GP2LQXeFuhSrRLfNDSElKwthqKtjKRkvMgom36IxGjtGHmabs?=
 =?us-ascii?Q?8gXo/ugHkLKCxjZmMNUfp8Az5zvEQiEF9yiP85hgUk3tEzuLZL8VbCbsj4BT?=
 =?us-ascii?Q?mCzK29+LlDrfEUlVDzFNccdt8LDwxt21B5KR8cxDnBwKl3r4tZTL4hl4nkt/?=
 =?us-ascii?Q?kq7v53sefarxVypwXM59zGPLQhdW/8yhJxDoxAi2bqrJ1vRsTQXWX+BSBz0g?=
 =?us-ascii?Q?nrlQImcORXnOM5KupjROSu/D9VLRx0z2gHGaVoTdZwMSUFF/lWi3qbGE+V7x?=
 =?us-ascii?Q?Wy6QIm+KDG5KPHUT0hE7LUjyeD7M0n8IkvGk3Qrc+6RYRS2DYz5fwKxeM2ht?=
 =?us-ascii?Q?AjP0cYOnl5Yu8Cm8nu6RxJ1yHDO5ErL7CaLQpq7zNf0z00piEuVNpbf95tTD?=
 =?us-ascii?Q?ra7edjF1hbF5tAF8YFdvj1uLI6riyfRlbCwAV4jv/LxxmeYJg75pVxWzzeUJ?=
 =?us-ascii?Q?fZGTmbGFoitUpbxlnUM0Fs+Cd1+RDXYq/BgBo/i21z8A4polZz3ngNnTEFI1?=
 =?us-ascii?Q?sTjnOMeGH7XnkupGIpKqSDH0o5MJPOz9EaQyhswcC3OAVkhUSvb/Paeu0RqN?=
 =?us-ascii?Q?ABBEgJa5ymQnQetxQUQ+P46nxmNHso+tqKE2uo5M3lmofr1Dh2JehiNYJ9Lp?=
 =?us-ascii?Q?9sKpJ/J2iM+qUQW8cRU4pocFh1D7zFgDsO3diSf5cq9V64RSMEZChFYEqdG0?=
 =?us-ascii?Q?fWLtqPVDbm/altHAqVzPrH4IMtG4xr+r7QdH4om47WpFYzxM6MDZgW42h9Rh?=
 =?us-ascii?Q?fFR8CcMdIER8J3XhwDYZuLBCFDprdbnkoOy+QTvgpnKTajlnTD4jUPRoDV7i?=
 =?us-ascii?Q?BdtlhSeI9awzNx71s4PO1D1MHdkz9OHYq5Rk3WX6Pk5BwuhrAXno7qRVj42l?=
 =?us-ascii?Q?45JziUCSgWruIx4TrMrhhmU5Z2BsC70ynXk12OMyQ0vC+mA8WdN6541i6yyy?=
 =?us-ascii?Q?DkX6x1rzZOlls0Nf0aHJSvCmoZQx/DkzF1BbxQKtGZIEbWE9Y971t2/rHESe?=
 =?us-ascii?Q?A6FurWaVldBA94BFKlD5D6efhdyGjKyb3HTekH81TYGdXzjlJDb8WhWs/Xxe?=
 =?us-ascii?Q?lpmrEY2E2C63lHt0hVwEHvFYQ+7N4P40QykMQECqTGXOy2QACZViJwc9iRho?=
 =?us-ascii?Q?3ak18xBKIa3Qldlbv1m+9r32hO0tF73SZHxmSkaywXgrVmLDsIS7KVesI6Wk?=
 =?us-ascii?Q?oCHsPtmZJS9nlzfuFxbHulu+MydUqHF3xlJyvTdTNaH6kjwAKyJaeRR772cb?=
 =?us-ascii?Q?uqpdysLE0V6efFuQK3/I3Pcg9iPgGqTjajG8D57Bl4r6jlm4t2vLuql3/NAC?=
 =?us-ascii?Q?iM6GHaftfH7x+ehDieI4P3HSGtO6wwI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a977b877-b2c4-4358-f9a4-08de9cc3eca6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:57:23.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0zztQEEFOA8UsVONI59dcFhi7YXFl2HbmLj/2sihgSwE3Z+fPzQoZsswXCgxqHdZqhs+OatX6OTHKXDhB4oqgzq/WEgfCWfiCAUjiFjyJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

Build evl for quemu-riscv64 and run the evl tests in lava. Skip the
ptrace-sync test for now as it fails because of an open issue in EVL.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml                    |  38 ++-
 ci/lib/kernel/head.yml                       |  13 +
 conf/machine/qemu-riscv64.conf               |   1 -
 recipes-kernel/linux/files/riscv64_defconfig | 313 +++++++++++++++++++
 tests/jobs/xenomai-qemu-riscv64.yml          |  93 ++++++
 5 files changed, 451 insertions(+), 7 deletions(-)
 create mode 100644 recipes-kernel/linux/files/riscv64_defconfig
 create mode 100644 tests/jobs/xenomai-qemu-riscv64.yml

diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
index d815474..aaeb778 100644
--- a/ci/lib/gitlab-ci-base.yml
+++ b/ci/lib/gitlab-ci-base.yml
@@ -85,11 +85,14 @@ default:
       paths:
         - build/downloads
 
+.build-qemu-rules: &build-qemu-rules
+  - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
+  - if: '$ALL_QEMU_JOBS == "true"'
+
 .build-qemu:
   extends: .build
   rules:
-    - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
-    - if: '$ALL_QEMU_JOBS == "true"'
+    - *build-qemu-rules
 
 .test:
   stage: test
@@ -109,6 +112,12 @@ default:
   rules:
     - if: '$LAVA_TESTS_ENABLED == "true"'
 
+.test-qemu-rules: &test-qemu-rules
+  - if: '$LAVA_TESTS_ENABLED != "true"'
+    when: never
+  - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
+  - if: '$ALL_QEMU_JOBS == "true"'
+
 .test-qemu:
   extends: .test
   variables:
@@ -116,10 +125,7 @@ default:
     ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
     EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
   rules:
-    - if: '$LAVA_TESTS_ENABLED != "true"'
-      when: never
-    - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
-    - if: '$ALL_QEMU_JOBS == "true"'
+    - *test-qemu-rules
 
 .build:qemu-amd64:
   extends: .build-qemu
@@ -154,6 +160,26 @@ default:
   variables:
     TARGET: qemu-arm64
 
+.build:qemu-riscv64:
+  extends: .build-qemu
+  variables:
+    TARGET: qemu-riscv64
+    CACHE_ARCH: riscv64
+  rules:
+    - if: '$XENOMAI_VERSION != "4-next"'
+      when: never
+    - *build-qemu-rules
+
+.lava-test:qemu-riscv64:
+  extends: .test-qemu
+  variables:
+    TARGET: qemu-riscv64
+    EVL_TESTS_SKIP_PATTERN: "ptrace-sync|sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun|monitor-event-untrack"
+  rules:
+    - if: '$XENOMAI_VERSION != "4-next"'
+      when: never
+    - *test-qemu-rules
+
 .build:hikey:
   extends: .build
   variables:
diff --git a/ci/lib/kernel/head.yml b/ci/lib/kernel/head.yml
index 376a002..e2884c2 100644
--- a/ci/lib/kernel/head.yml
+++ b/ci/lib/kernel/head.yml
@@ -48,6 +48,19 @@ lava-test-head:qemu-arm64:
   variables:
     KERNEL_VERSION: "head"
 
+build-head:qemu-riscv64:
+  extends: .build:qemu-riscv64
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
+    KERNEL_VERSION: "head"
+    CACHE_KERNEL: evl
+
+lava-test-head:qemu-riscv64:
+  needs: [ "build-head:qemu-riscv64" ]
+  extends: .lava-test:qemu-riscv64
+  variables:
+    KERNEL_VERSION: "head"
+
 build-head:rpi4:
   extends: .build:rpi4
   variables:
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
index 8dfcda4..4fb66c4 100644
--- a/conf/machine/qemu-riscv64.conf
+++ b/conf/machine/qemu-riscv64.conf
@@ -12,4 +12,3 @@
 require qemu-machine.inc
 
 DISTRO_ARCH = "riscv64"
-KERNEL_DEFCONFIG = ""
diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-kernel/linux/files/riscv64_defconfig
new file mode 100644
index 0000000..8f9e852
--- /dev/null
+++ b/recipes-kernel/linux/files/riscv64_defconfig
@@ -0,0 +1,313 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_CGROUPS=y
+CONFIG_MEMCG=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_BPF=y
+CONFIG_USER_NS=y
+CONFIG_CHECKPOINT_RESTORE=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_PROFILING=y
+CONFIG_ARCH_ANDES=y
+CONFIG_ARCH_ANLOGIC=y
+CONFIG_ARCH_MICROCHIP=y
+CONFIG_ARCH_SIFIVE=y
+CONFIG_ARCH_SOPHGO=y
+CONFIG_ARCH_SPACEMIT=y
+CONFIG_SOC_STARFIVE=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_ARCH_TENSTORRENT=y
+CONFIG_ARCH_THEAD=y
+CONFIG_ARCH_VIRT=y
+CONFIG_ARCH_CANAAN=y
+CONFIG_SMP=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=m
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
+CONFIG_CPUFREQ_DT=y
+CONFIG_ACPI_CPPC_CPUFREQ=m
+CONFIG_VIRTUALIZATION=y
+CONFIG_KVM=m
+CONFIG_ACPI=y
+CONFIG_JUMP_LABEL=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_BLK_DEV_THROTTLING=y
+CONFIG_SPARSEMEM_MANUAL=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_XFRM_USER=m
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_INET_ESP=m
+CONFIG_NETFILTER=y
+CONFIG_BRIDGE_NETFILTER=m
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_TFTP=m
+CONFIG_NETFILTER_XT_MARK=m
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
+CONFIG_NETFILTER_XT_MATCH_IPVS=m
+CONFIG_IP_VS=m
+CONFIG_IP_VS_PROTO_TCP=y
+CONFIG_IP_VS_PROTO_UDP=y
+CONFIG_IP_VS_RR=m
+CONFIG_IP_VS_NFCT=y
+CONFIG_NF_LOG_ARP=m
+CONFIG_NF_LOG_IPV4=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_NF_LOG_IPV6=m
+CONFIG_IP6_NF_IPTABLES=m
+CONFIG_IP6_NF_MATCH_IPV6HEADER=m
+CONFIG_IP6_NF_FILTER=m
+CONFIG_IP6_NF_TARGET_REJECT=m
+CONFIG_IP6_NF_MANGLE=m
+CONFIG_BRIDGE=m
+CONFIG_BRIDGE_VLAN_FILTERING=y
+CONFIG_VLAN_8021Q=m
+CONFIG_NET_SCHED=y
+CONFIG_NET_CLS_CGROUP=m
+CONFIG_NETLINK_DIAG=y
+CONFIG_CGROUP_NET_PRIO=y
+CONFIG_CAN=m
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_PCIE_XILINX=y
+CONFIG_PCIE_FU740=y
+CONFIG_PCIE_STARFIVE_HOST=m
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_SIFIVE_CCACHE=y
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_BLK_DEV_NVME=m
+CONFIG_BLK_DEV_SD=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_SCSI_VIRTIO=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_DM=m
+CONFIG_DM_THIN_PROVISIONING=m
+CONFIG_NETDEVICES=y
+CONFIG_DUMMY=m
+CONFIG_MACVLAN=m
+CONFIG_IPVLAN=m
+CONFIG_VXLAN=m
+CONFIG_VETH=m
+CONFIG_VIRTIO_NET=y
+CONFIG_MACB=y
+CONFIG_E1000E=y
+CONFIG_R8169=y
+CONFIG_STMMAC_ETH=y
+CONFIG_STMMAC_PLATFORM=y
+CONFIG_DWMAC_STARFIVE=y
+CONFIG_DWMAC_THEAD=m
+CONFIG_MICREL_PHY=y
+CONFIG_MICROSEMI_PHY=y
+CONFIG_MOTORCOMM_PHY=y
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_KEYBOARD_SUN4I_LRADC=m
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
+CONFIG_VIRTIO_CONSOLE=y
+CONFIG_HW_RANDOM=y
+CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_HW_RANDOM_JH7110=m
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=m
+CONFIG_I2C_DESIGNWARE_CORE=y
+CONFIG_I2C_MV64XXX=m
+CONFIG_SPI=y
+CONFIG_SPI_CADENCE_QUADSPI=m
+CONFIG_SPI_FSL_QUADSPI=m
+CONFIG_SPI_PL022=m
+CONFIG_SPI_SIFIVE=y
+CONFIG_SPI_SUN6I=y
+# CONFIG_PTP_1588_CLOCK is not set
+CONFIG_PINCTRL_TH1520=y
+CONFIG_PINCTRL_SOPHGO_CV1800B=y
+CONFIG_PINCTRL_SOPHGO_CV1812H=y
+CONFIG_PINCTRL_SOPHGO_SG2000=y
+CONFIG_PINCTRL_SOPHGO_SG2002=y
+CONFIG_GPIO_DWAPB=y
+CONFIG_GPIO_SIFIVE=y
+CONFIG_GPIO_SPACEMIT_K1=y
+CONFIG_POWER_RESET_GPIO_RESTART=y
+CONFIG_SENSORS_SFCTEMP=m
+CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_SUNXI_WATCHDOG=y
+CONFIG_MFD_AXP20X_I2C=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_AXP20X=y
+CONFIG_REGULATOR_GPIO=y
+CONFIG_MEDIA_SUPPORT=m
+CONFIG_MEDIA_PLATFORM_SUPPORT=y
+CONFIG_VIDEO_CADENCE_CSI2RX=m
+CONFIG_DRM=m
+CONFIG_DRM_RADEON=m
+CONFIG_DRM_NOUVEAU=m
+CONFIG_DRM_SUN4I=m
+CONFIG_DRM_VIRTIO_GPU=m
+CONFIG_FB=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_DESIGNWARE_I2S=m
+CONFIG_SND_SOC_JH7110_PWMDAC=m
+CONFIG_SND_SOC_JH7110_TDM=m
+CONFIG_SND_SOC_WM8978=m
+CONFIG_SND_SIMPLE_CARD=m
+CONFIG_USB=y
+CONFIG_USB_OTG=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PLATFORM=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_UAS=y
+CONFIG_USB_CDNS_SUPPORT=m
+CONFIG_USB_CDNS3=m
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_USB_CDNS3_HOST=y
+CONFIG_USB_CDNS3_STARFIVE=m
+CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_SUNXI=m
+CONFIG_NOP_USB_XCEIV=m
+CONFIG_USB_GADGET=y
+CONFIG_USB_CONFIGFS=m
+CONFIG_USB_CONFIGFS_SERIAL=y
+CONFIG_USB_CONFIGFS_ACM=y
+CONFIG_USB_CONFIGFS_OBEX=y
+CONFIG_USB_CONFIGFS_NCM=y
+CONFIG_USB_CONFIGFS_ECM=y
+CONFIG_USB_CONFIGFS_ECM_SUBSET=y
+CONFIG_USB_CONFIGFS_RNDIS=y
+CONFIG_USB_CONFIGFS_EEM=y
+CONFIG_USB_CONFIGFS_MASS_STORAGE=y
+CONFIG_USB_CONFIGFS_F_FS=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
+CONFIG_MMC_SDHCI_OF_K1=y
+CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SPI=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_STARFIVE=y
+CONFIG_MMC_SUNXI=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_SUN6I=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_SUN6I=m
+CONFIG_DW_AXI_DMAC=y
+CONFIG_MMP_PDMA=m
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_BALLOON=y
+CONFIG_VIRTIO_INPUT=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_CLK_SOPHGO_CV1800=y
+CONFIG_CLK_SOPHGO_SG2042_PLL=y
+CONFIG_CLK_SOPHGO_SG2042_CLKGEN=y
+CONFIG_CLK_SOPHGO_SG2042_RPGATE=y
+CONFIG_SPACEMIT_K1_CCU=y
+CONFIG_SPACEMIT_K3_CCU=y
+CONFIG_SUN8I_DE2_CCU=m
+CONFIG_SUN50I_IOMMU=y
+CONFIG_RPMSG_CHAR=y
+CONFIG_RPMSG_CTRL=y
+CONFIG_RPMSG_VIRTIO=y
+CONFIG_PM_DEVFREQ=y
+CONFIG_IIO=y
+CONFIG_PWM=y
+CONFIG_PWM_PXA=m
+CONFIG_THEAD_C900_ACLINT_SSWI=y
+CONFIG_PHY_SUN4I_USB=m
+CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
+CONFIG_PHY_STARFIVE_JH7110_PCIE=m
+CONFIG_PHY_STARFIVE_JH7110_USB=m
+CONFIG_CLK_STARFIVE_JH7110_AON=y
+CONFIG_CLK_STARFIVE_JH7110_STG=y
+CONFIG_LIBNVDIMM=y
+CONFIG_NVMEM_SUNXI_SID=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_BTRFS_FS=m
+CONFIG_BTRFS_FS_POSIX_ACL=y
+CONFIG_AUTOFS_FS=y
+CONFIG_OVERLAY_FS=m
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_HUGETLBFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
+CONFIG_ROOT_NFS=y
+CONFIG_9P_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_SECURITY=y
+CONFIG_SECURITY_SELINUX=y
+CONFIG_SECURITY_APPARMOR=y
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_DEV_VIRTIO=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_FS=y
+# CONFIG_RUNTIME_TESTING_MENU is not set
+CONFIG_MEMTEST=y
diff --git a/tests/jobs/xenomai-qemu-riscv64.yml b/tests/jobs/xenomai-qemu-riscv64.yml
new file mode 100644
index 0000000..4d10c1e
--- /dev/null
+++ b/tests/jobs/xenomai-qemu-riscv64.yml
@@ -0,0 +1,93 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Tobias Schaffner <tobias.schaffner@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+device_type: qemu
+job_name: QEMU pipeline, xenomai-images-qemu-riscv64
+
+timeouts:
+  job:
+    minutes: 90
+  action:
+    minutes: 65
+  connection:
+    minutes: 5
+priority: medium
+visibility: public
+
+# context allows specific values to be overridden or included
+context:
+  # tell the qemu template which architecture is being tested
+  # the template uses that to ensure that qemu-system-riscv64 is executed.
+  arch: riscv64
+  cpu: rv64
+  machine: virt
+  no_kvm: True
+  extra_options:
+  - -smp 2
+  - -m 2048
+  - -device virtio-serial-device
+  - -device virtconsole,chardev=con
+  - -chardev vc,id=con
+  - -device virtio-blk-device,drive=disk
+  - -device virtio-net-pci,netdev=net
+  - -netdev user,id=net
+  guestfs_interface: virtio
+metadata:
+  # please change these fields when modifying this job for your own tests.
+  docs-source: xenomai-qemu-riscv64
+  docs-filename: qemu-pipeline-xenomai-riscv64
+
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 15
+    to: tmpfs
+    images:
+      kernel:
+        image_arg: -kernel {kernel} -append "root=/dev/vda rw"
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
+      initrd:
+        image_arg: -initrd {initrd}
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
+      rootfs:
+        image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.gz
+        compression: gz
+# BOOT_BLOCK
+- boot:
+    timeout:
+      minutes: 15
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:"]
+    auto_login:
+      login_prompt: 'demo login:'
+      username: root
+      password_prompt: 'Password:'
+      password: root
+
+- test:
+    timeout:
+      minutes: ${TEST_TIMEOUT_MINUTES}
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai smokey test suite"
+          maintainer:
+            - tobias.schaffner@siemens.com
+        run:
+          steps:
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
-- 
2.43.0

