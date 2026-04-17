Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7F330666
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 20:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459453; cv=fail; b=XeCGNOxyo4yq9ujP23UDj9s9zGkjAD2MpxFGBUDu8tV5KhHFG+YUJoL6KMaLNG5qOYvfUpbgsjWQM1aklOuYmM/23pZIanxB0+wcYcH73lup1sBbaBpMThZzvgjfLpntYssv8NGeSkRHqhMdQZZZqHqacULHEivB5zJyojPCkus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459453; c=relaxed/simple;
	bh=IVGpMg9Ow+Viv/tgOhG2vZSW0oxtmGCTc4kgYnnhlNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rz9j/C/eqL1SRP9ykaYIDtbf8CmUUqEiQhXHSRoRX7IgZW9o7vqoZVdxBxwTAttFd+vyeHUEnhgRdn8aydEv4ZEFLAkWYfbvfohk3K1iLI+FHh+pOD0WSxLAXdT7P5EI3YVf5yw4saW6o9tTnR/lwlecgPWVIoLYgCjrvt4FeLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ejDXqZJ4; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ejDXqZJ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQTuE0jiaP3DkX00aq6DPtYA6R7S/AhXRWzex4M7+vPMXsy16lq1QkFQxLv+/3t40k8q9YCNKuHAvjhBW5ao6uo1QLEjh7wYR5RXeyQP+eitW8bVFheZJplhHxDhQpoFsBC8saNcydd5mVBb3v2QC4b+Z1Bdmx5ITHFtOaFyAXHjeOUUs67Jg2HXbfsA8LKrV/KzLFA/GGqNbGkcAz11zTPvjJRMyYXwSoqC6Lgb6dPmYteIXcRdsaUgcqyZafDgGwfwI7+ep9yMDeQU2pgEjxBFCnjvGFaqsXNcEsykqDXMbiQNuNrBxbZslhQxL88GNwrbAE/4AV0WDR/r9u5+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK0mJdItbWjIRHvZwdi5LSTEHvrrwRg6s3x3nmrOTlQ=;
 b=CTbxsRy3HUsTEiYJKspQf0ER1cy7fuFOkueg/H3kgmDIkJEaQFDt0UluZYhSf5w5bKK8ZgdYFNZAJhPMUFOmMQi5lWQlgZy3pED5ny5ozSgcTcTvUDTcquh0G5hHFodFhxLQ2HC/LSXqoBAYqZD3rby3qBz/fC5Fsh5kVpaqcXJPe5iEzQ5pnXk77jk5ehyVVWupqNK7QVGGKcS2JoIRppLJAcwDq7s96o36z/pu4J2iZcQFck4cjcrgoH8iLqvadIVI0zTrNAe35UZrEhW7XpRYFc6jHYaS6IgjW1MtSw7geN4bqtZqzeqk24Krjp7AG4VQ7aiOZPyrqATfnIdWbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK0mJdItbWjIRHvZwdi5LSTEHvrrwRg6s3x3nmrOTlQ=;
 b=ejDXqZJ4uQ0ZeKiTkEuMC/6YsmGizCAojhpJCZapY5Czc1ZldfxtSlUIUpmWgqRDxs9RdYtM2NXzVR2wy4pMB45vDk8ybpOKNAihP7bmzElTS3RqvI1NH28z7iGkYBleNg4sCocDoUz+MTSxHsIFkSmgXWRCOTbdHK7B/k2iFLEOCDVzEM7c8xoxACoKoWXO7bbBdc19MeP67YBt7ojLWYhWPjXOUVtPT7j8HheEwi47R9t/RpwufkM9j/HX6hYJTkygveeaN+uYpy3uIT9EeGvkttHH+8QK4ZYv1ZKJZvHolFyZ/QSQkeFkR4SV0b/0lkmqk5Q7zw02ml/R2mx7mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:57:25 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:57:24 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH RFC xenomai-images 3/5] ci: Add the starfive visionfive2 board
Date: Fri, 17 Apr 2026 22:57:03 +0200
Message-ID: <20260417205713.2290350-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: e1c66b7a-bcfd-4c98-abd5-08de9cc3ed40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18096099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	AVEf60z4bvREZSFXAEmlv3xexTarELFOHoutbKQcVmRDwyDfNcaWfmEoJubWrXwrw0fQFEr6ss49R6CMusZ5vuiroWke1BOMHmVZQl9kRjS4QfSpYgFcio11g8+OWBatkgRzjnlFv3iDH9G6TcsumzPKw74cuhxpvrTeZCTMLIdF163BTKgXcw9oV5fiSB+Q/Mehn5wSa55t82kkBobpaDYhicI48/S5nsQocTNWonEvyvQ6EHPva5gj41BDCd9L2nvmsa5mHIrmsgt1af6FbUQDxprxTIGKQYSD2T7dY12OU9UxtWX2UhntgVTWjbpGQwlvCUd9uThuwZvE+GS49yky4k/yStjDkwNCcZLZ6CS7ppkzgjIOhnl77cb/b/IHpVoIrt6qFLqqkk/4VSvt/LPwMhaE0SMdV1DQUSxaqP4r4Tz1RtxNdUdesp6uFnpMZeDqz22EbO2vgM7sG2cdcm5aYtPLaySCnjXCbBqD/nJwgyoR9PjX5UnZHFUUNnpgVNvQDjsp6vAgqY8eHSMmJf92TQDWKZFmjCTyTDb6pJWmjVJvz/sy1Hp12QeLFa+6C7oMKbXeFU0kPZdfmNXgb+KDlZZNRCYBrH2Gagl+zWvc9JRh3YKZRt5C31CucD0b18Tb/Wjiskp1eGgY8XhXGOXNJzYSrEuC9gi6YQSQGFlroyspbS4vGpEMgt3b2wPXxKbEYY2N09QvUbm41MZKalvBoNlt5cmnndP8NGu6idw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18096099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bqGcCE1jXoYhlufipMWirFQkf8gMAH3g9YGyfXtcOSYw9b+OoAvnKQtbRFH?=
 =?us-ascii?Q?myaWbW/Xw8mL76NolOkyJHfPK1SShzu1+e618CEvGkBZw7pMBiygG1nsnX8d?=
 =?us-ascii?Q?zdYcxqLvcGNCyclhtReJJMY8M0pmwCNGwk7hWkk6SUXzzE3+Qb4FFcCb6HKW?=
 =?us-ascii?Q?1zeN88nF1m4MIqsROMLlks+WqLe3d8tT0cSvoLaZtTKAWUV7npCWwoH0wOpv?=
 =?us-ascii?Q?7G45XNKJOhmD2itV3sd6rTc1Gx6IFlOZJPP0DBAZTf1miW6zzXnUsamDEjJc?=
 =?us-ascii?Q?ChR7BqDrlseRu3xeNI0KNhu2mR0MBt1nF2R9GuX0qFGCd/UgVFe9zKqJyxNJ?=
 =?us-ascii?Q?oWCdVhxEpd/M8YbkNKfCjmXWJc+3Z7/m1o+uzQYfiBpXSgt61bDd6DvzlBr4?=
 =?us-ascii?Q?2UqjWA6HRRycCwwmqmvhUZYNvx+lrPFZlyZ05lFfRchEdRyNRajxB0mBjfR9?=
 =?us-ascii?Q?gvru5zq52ZqTOCYdihkudvpezcF4zgqlGzxehhdf55PJwPCiVBI/6OS9a0KU?=
 =?us-ascii?Q?DR+N/BnDpz2U4KtGLGj1CBZlHJakz7ch4ZOkNpLMw8y7DYVO5vIkhwEPbAej?=
 =?us-ascii?Q?EC/8OlMZdoeqMQLx+avExLa3hE/uYYJG1nlHekWepgqa6Wmw9z/P2VB4VfMN?=
 =?us-ascii?Q?76QEEXljJZFO6Y5inuf/rhNGYw4VC6lnCpJhtKTQMuh1mepn6uFN2ao93uU6?=
 =?us-ascii?Q?h3Joaij1WeYAz3AsqIeI1hZ2iQJ2Ktv8OPp+6QX1Gh/ZpYXig+E/OJeIOC+G?=
 =?us-ascii?Q?QavVTH3P9xaESFZS5L46vIFLFe2qEafb3BZen+Za2RTvHnpM+ktGK76zJ6UG?=
 =?us-ascii?Q?MxYCNcdFNBdYbgl0j9tLDLf40He84MG14FBzpaFlEe+mQsVJ6ouqgfrJyMYh?=
 =?us-ascii?Q?YgaNVPmympCK72u+ASsBtPnxaZ4tigKmqc/kNSEK5J5l4jV9VIWDUIiCsHhA?=
 =?us-ascii?Q?NBhJZTJfzRZ9mbbozll5h6axhNGcCxTIfu/sbsX3EeKAt4ljwiRA+ZhfhUTr?=
 =?us-ascii?Q?GM3gCljdj9xblcd1kRmIDkjqPq/12zCyfH+5XjwJRo1fZbbr+qSLOVcrYwwV?=
 =?us-ascii?Q?b+rUWFToOOhdeoJJJHQRW1iKnQg7oqSMT6Ni2ffa7alf2dOD6qZT5p39ctQ7?=
 =?us-ascii?Q?71/tCxS2OHsw3e9DMqxolhG9ZSSFIlUSVR54lhyJBkOI7hzWbi3YpZ8RDI7r?=
 =?us-ascii?Q?mxc0oGF10/7CRLxSefEtuJ3Yxn3NCU+NZKOTQbYuG502uVLvKrBs4XLefUJ0?=
 =?us-ascii?Q?e7vAc8rD/pRwz9tksGyPzo2AXuFunpS6+5JxBSkAvbxfLJUrWu3UX0A3O/HZ?=
 =?us-ascii?Q?LCEgSE/bDAHDcYRYwqAHDCB6y0EOxpFRX9dqfE7PnkAD/2nMQUAQb5tkIY0d?=
 =?us-ascii?Q?8hh+txgY2AAD0iYb7Gv3qruf/z5E/dwxW8JEx20NR8l/zvjr5VLIHg3QbzZO?=
 =?us-ascii?Q?KZzpAZeKeAmQGReO2m/auu9irerfFAvNDbOHnMY/3sqmhxBUhfVnvP83odCA?=
 =?us-ascii?Q?aGGvoYolAaOFkQINQMgDz492xt2xz9UfZ/r2y+0LxttN7Ie8Y+f9T8haWlQg?=
 =?us-ascii?Q?E/zgPthz5OnKC6yRc05XC9WOU9SNy2XIllcQSyZh45/hhMnCt3MKvElDjzyC?=
 =?us-ascii?Q?V0lxHPwPGiJbK3SKgpWn8IUb6nauF2Vz+ySlIyQuBUvewfXARN0vaUOSUrNZ?=
 =?us-ascii?Q?NpYN5PlFKX2L6iwO+7AFb7Fe82IHLwprP85yXcCRLrEeHRe3whZW3YZRJhju?=
 =?us-ascii?Q?6WF80hGavzxXP6QXNPeSRE1X4sSkO3I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c66b7a-bcfd-4c98-abd5-08de9cc3ed40
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:57:24.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbdqmhZuhIFm20va72AZJUGBWFXZFG8P9PIFhlDi21Y5ceywlRm/r9z/w36ka0DbFkug159lrt/kMKJ/pX5gq/Hu2gG6LkYkNh6dZj+PXvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

Add everything needed to run the evl tests on the starfive visionfive2
board in the xenomai-images lava lab.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml                   | 21 +++++++
 ci/lib/kernel/head.yml                      | 13 ++++
 conf/machine/visionfive2.conf               | 18 ++++++
 kas.yaml                                    |  1 +
 kas/board/starfive-visionfive2.yaml         | 15 +++++
 tests/jobs/xenomai-starfive-visionfive2.yml | 69 +++++++++++++++++++++
 6 files changed, 137 insertions(+)
 create mode 100644 conf/machine/visionfive2.conf
 create mode 100644 kas/board/starfive-visionfive2.yaml
 create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml

diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
index aaeb778..e297f54 100644
--- a/ci/lib/gitlab-ci-base.yml
+++ b/ci/lib/gitlab-ci-base.yml
@@ -227,3 +227,24 @@ default:
   resource_group: board-x86-64-efi
   variables:
     TARGET: x86-64-efi
+
+.build:starfive-visionfive2:
+  extends: .build
+  variables:
+    TARGET: starfive-visionfive2
+    CACHE_ARCH: riscv64
+  rules:
+    - if: '$XENOMAI_VERSION != "4-next"'
+      when: never
+    - when: always
+
+.lava-test:starfive-visionfive2:
+  extends: .test
+  resource_group: board-starfive-visionfive2
+  variables:
+    TARGET: starfive-visionfive2
+    EVL_TESTS_SKIP_PATTERN: "ptrace-sync"
+  rules:
+    - if: '$XENOMAI_VERSION != "4-next"'
+      when: never
+    - if: '$LAVA_TESTS_ENABLED == "true"'
diff --git a/ci/lib/kernel/head.yml b/ci/lib/kernel/head.yml
index e2884c2..e5af966 100644
--- a/ci/lib/kernel/head.yml
+++ b/ci/lib/kernel/head.yml
@@ -61,6 +61,19 @@ lava-test-head:qemu-riscv64:
   variables:
     KERNEL_VERSION: "head"
 
+build-head:starfive-visionfive2:
+  extends: .build:starfive-visionfive2
+  variables:
+    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
+    KERNEL_VERSION: "head"
+    CACHE_KERNEL: evl
+
+lava-test-head:starfive-visionfive2:
+  needs: [ "build-head:starfive-visionfive2" ]
+  extends: .lava-test:starfive-visionfive2
+  variables:
+    KERNEL_VERSION: "head"
+
 build-head:rpi4:
   extends: .build:rpi4
   variables:
diff --git a/conf/machine/visionfive2.conf b/conf/machine/visionfive2.conf
new file mode 100644
index 0000000..ff42ecc
--- /dev/null
+++ b/conf/machine/visionfive2.conf
@@ -0,0 +1,18 @@
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
+require conf/machine/starfive-visionfive2.conf
+
+MACHINE = "starfive-visionfive2"
+
+DTB_FILES = "\
+	starfive/jh7110-starfive-visionfive-2-v1.2a.dtb \
+	starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
diff --git a/kas.yaml b/kas.yaml
index f856ae1..875132b 100644
--- a/kas.yaml
+++ b/kas.yaml
@@ -25,6 +25,7 @@ repos:
     commit: 9792d18e9334b3cec72e2ade6a1065084c0c24d6
     layers:
       meta:
+      meta-isar:
 
 bblayers_conf_header:
   standard: |
diff --git a/kas/board/starfive-visionfive2.yaml b/kas/board/starfive-visionfive2.yaml
new file mode 100644
index 0000000..4b38ef0
--- /dev/null
+++ b/kas/board/starfive-visionfive2.yaml
@@ -0,0 +1,15 @@
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
+header:
+  version: 14
+
+machine: visionfive2
diff --git a/tests/jobs/xenomai-starfive-visionfive2.yml b/tests/jobs/xenomai-starfive-visionfive2.yml
new file mode 100644
index 0000000..6155fdf
--- /dev/null
+++ b/tests/jobs/xenomai-starfive-visionfive2.yml
@@ -0,0 +1,69 @@
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
+job_name: xenomai-test-suite
+device_type: starfive-visionfive2
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
+metadata:
+  docs-source: xenomai-starfive-visionfive2
+  docs-filename: pipeline-xenomai-starfive-visionfive2
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 30
+    to: tftp
+    kernel:
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
+      type: image
+    dtb:
+      url: ${DEPLOY_URL}/jh7110-starfive-visionfive-2-v1.2a.dtb
+    nfsrootfs:
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
+      compression: gz
+#  BOOT_BLOCK
+- boot:
+    failure_retry: 3
+    timeout:
+      minutes: 5
+    method: u-boot
+    commands: nfs
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
+          description: "runs the xenomai test suite"
+        run:
+          steps:
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
-- 
2.43.0

