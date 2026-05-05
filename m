Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58939098C
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012198; cv=fail; b=LPkRXf0Wf2B/EkG3e4qPKUYCadF5Bo5q1wynrltzMpU/pTbhvcmEHqDYiMR5/98mT1Vfa+FeLqMXiqlqIWsuVGWia2ndzU6IIMrtJYWD/g0Toe14Hsqh77+t65Sqc7xHM9un+dBL+dWpXwkn2xAdek7YNXasb7YGvyMZSLQGKsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012198; c=relaxed/simple;
	bh=xPDR+7xna/B9YcCy0XjCAduocKEJQAmL/phdPRG5+6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cRa1GECWrD6kwqhK5jonaGXSsHCDo7m8jFB1JgWIGYnHEBzAirHLNZGOkcr2TtJ5H9nQp/GCOO1PbPWreCL7rUVr0gsBR4g3iVyCkNTyw3+46/5gSMYBMZr47xwmzgYEqmqOKvTX9DbNzZxJgKQWl0cmYg0ROY01LiE+3LbAqnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=YEM61LBe; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="YEM61LBe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3GS8C/yKjywW3i05GKBr255ekVcugwX+c9JFe+47fpW76OVgbFIJcUHwgp7E7ke3/+rgOfX9+B4At5cEZ6TErEJ+j9xbosz2Rq9ldUVROQIR6BjbU2NI9Ii9goWYLhQybCjtTFQAio/3yvrBsK8QhErqwFrp4YBxYh1UiZvuMypDu8FRIlPhOWAounexS3/t0v3+9j6CgwZS480PuUxEC3Agofvoxqks6qbi9ChBOLJof2fTPBoCKr9ofgrsWXptFG1WJXXJ+J3ROTgTGUqLBtTCY/KDdOmGy1w7bHBeYr17qf4J8GOs/xZQFYeobPCONEkHKT/966pfUQSgskYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOHy+UHFqvw4m9o+biKmzoPRQJILqa5ItK+TwlyRrmU=;
 b=RKEiA4NWKgmtYu1AbQnMPpGhyosD6W3M3dcb6I+f8ZSNdRuEroLa5vyvBssUnjZh4CtW4etsw1lr8M5JP4UzLDX3UtanzTXuLiFd9t5+lZ3jtY68lsmDqQ+/T93a34ijNTIBZkglw/xU5WRWDsb1La2R9RBsxlhyrOFz3aBVc2CzUhiYWFFEpO4vd3SWufxs7dbNeKDm87/fPjfOyvim+OegIMH9f1uRr0For6YLP4dRdVlvDAZcoLxWJNqSKwcm2fKiinXWfZBioWxoqp+rpVKrsJ1t54E9xaKvY+mmqOcot0PvTusDFrF2f6i/GkpmzNEmRNVHbkeF9UwOS/AVLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOHy+UHFqvw4m9o+biKmzoPRQJILqa5ItK+TwlyRrmU=;
 b=YEM61LBeFrsKrxMSis4H7dJCKA8Ew0BzXgU4Ia9FtCfbi2NjAaqu8C0LVWHkSFClj+6kKpTnxA2f1YZ47WTh/Mpaqx+drh+/oPJ9L15oFq3b83UwVUOnC/CAfcVX14SFptrq5eGz8WfkI5xp0bUj+A9o0a0oqdwOomltS5K1sPQab16oe/XS0D/qimsuR0Ku8DmA4PGYzs41f6ogquskNKjvdLOeuYj7qjGbH70FvTJo9MJvo2porw7JGP4dLRoJnY6Ky1UsXGbblMyehlm4nSgYe97Ef1O0U6Zjr3EfsnUUnzjDxYpw/Lnm3DPgYzqL61lWNDyV4rN21dSDcLE4YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB8155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 20:16:27 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 20:16:27 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v3 4/4] ci: run ci tests on StarFive VisionFive2 1.2a
Date: Tue,  5 May 2026 22:16:17 +0200
Message-ID: <20260505201617.148513-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505201617.148513-1-tobias.schaffner@siemens.com>
References: <20260505201617.148513-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: eb7e713f-fe24-44a7-1558-08deaae3300d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	H1tfNPzhQzvGPxyEhDzyzqCTq4J9UF/Dmt4CG3TJl1P4nX6wToxxiguiJQk7cw1fAxMrr2sVaO3TLYoAu7SGmcV8d9nrA5qurhp8u/TrnTZvZsRxlsAG8EDf/mMmQP3RG/iHZWS/mwbpkNUST0nnU/Df5zlHGWHXfQcgKkkRd4vpxk6di20hnAerBG9/RxW3MqFLfj619bvsKCUJw5bkJD5zhqgRNed59ehs86wpEVdkDxFoRjKCW/HJan+vSZtRcY0Ra3rjBke72nxDeROtx9Zc3+rYlcy1xYZmqZqRkP/9IaLH0vsYd7W8xeS7KuXMso6KHRzU+ZjwAJyX7EaWS2j6KEWxQI/7MlQmdhr0dx2J2BZI9XREtlvL1Q/fHlzUrYGs+jXoW8UXBKV7MRcLxU4xUWjPjnacg3FyeRrSDbl+dAqECywTfwkQHz8XpeR8j5MkzcTK8TbDHJQaIpOik53Zxsu74G7sxDI6Qdyq1XaJB0hE1YEm0CP7RNn0U6057wYvIxgRRls9WAQxSzr8+dIRSwdd9yXPf5bFAV9XqD6VecchR1HHkGNyfQKUZkc329GiTYUYQ4yNcVsxhcr19ndLlaVwOrWENIHPXcC3GMUC/ZNKD0GeYq8TUPYl5k7+pnmUI8/QrPs3S7xFphhqpwhTPWRDtflNVDnIqwHGojGxNl0H50da8xayR6aCBVzv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vb8WFmEEH3LS07Dpm8PscXtx0MKyYLBWO1OBxax/IhTdXdA3iNEYavRQCcqd?=
 =?us-ascii?Q?LcwS4GmpGUvXtrZ/J9y0L1Hz0QAoa0l60jzkbreGizni4AKx8XYCPa16lKip?=
 =?us-ascii?Q?icbb6ppodXZMGvubqYUDJ+vOBIshWgbAunb7gjdTNSQ1MKXZABFDYM+6BzL4?=
 =?us-ascii?Q?KDAyVHQYa3I62UmQYQ+qLFXLUdOtOfVP7xTPUPiGc4JA+Qghm9Arwnii04Eq?=
 =?us-ascii?Q?VYkRPvPcafbQML58RIXeWswIthCN8XDjO4ozBaaMCnNrQx4CtfersOw28oT2?=
 =?us-ascii?Q?CFouwFLRLf1duHHQgn9B6DhmQ458azcyQr6l98yJbFvEzVC/bsHp9Vlw83/W?=
 =?us-ascii?Q?CzXapn/ujuReWv6n6AHDezl3RBf5mhGLEDvsvLbj2lbQgvLsC0rjiQTInWt3?=
 =?us-ascii?Q?/ejzJ6BhUJcx6Bz3TmRqj4Ne/aD9tQTCqWvTGxmAP9hBrMQqYekYxqr+A9Bw?=
 =?us-ascii?Q?GBmxLIwFkxdXSYdkAX5EfQik8IdCtYPpQorArtarX2WsWT3gzTc61Dh9NUhI?=
 =?us-ascii?Q?UVyc25wGjYts2m1ph6XuYfoIWd8KNZ0LVfYn5F8JaIiAFK/U7pFvf9nQLdYw?=
 =?us-ascii?Q?wGKZpj9rt8KbkIAaLo6RfCo0iQ57uiKQxqQVEIW3zhRI/JivLctVkM46aENv?=
 =?us-ascii?Q?UYTv0ueExaRcGOUJGkw3UzfM4dGARZHyhL1Ixu+sgG4YC5QdNgokGorW3VCc?=
 =?us-ascii?Q?PutxsnxdW0Q84N9Gfhx9/MMIs+snENLy7KKD60ZJ8fgIarb57AaJn1J06/F1?=
 =?us-ascii?Q?ETAP3pONuQA4w+B67XcTTe7GBnl8/8hPQtghWBP+CW3vL3+Yj55xf3uqJC1w?=
 =?us-ascii?Q?gvLX2XJ8VwZJHt2n/BrUL52R3qUxETGzSrh8h/v/sNi3AFhI9K9BEjOO/XVQ?=
 =?us-ascii?Q?eNW3D+v7fY+DfQ8PhZsvPe0ipOL//cXTkxwKcUzEFA6gOtRdZa6cClZ6sRdT?=
 =?us-ascii?Q?3e/NiMhsbx97s5QEEcW0ULMf6wURsgO/dUjubGyQwbFu+/7QUbSuMlm0Eatj?=
 =?us-ascii?Q?8hy0RZMMbFbu8g+lergZVqaoCFV84cvBVI5eV2eSKos5Ei1uotOcXwsfujSp?=
 =?us-ascii?Q?FW63u9duRWO4Kb597OvjC7XDvvHhCslSEbZqt2FxirpowVVpSixGWR4f6WOh?=
 =?us-ascii?Q?zsvPieoSz/jWanKLNLvjvH/Avf3daUjXAd+Ll5k6seLhqcEGg1Otqb4n9KjI?=
 =?us-ascii?Q?n0+87x7yK5cPyCzgzdbJf1w6vd319FVWgSsDdVaONu4pa/R5V3pwZAwEu2+H?=
 =?us-ascii?Q?4mAdOJDd9E+xXYyziSsDi9bhEKXPttQGlxU/xcLPQh56hzltQHM8fHbk/9wO?=
 =?us-ascii?Q?H6fPp9DWSxmy2Df4qUp9FuEXXenfU9oPRvoESRa4TBSxPztbBB6/ISy1Ydnm?=
 =?us-ascii?Q?rXgvEjfllPSpf/pUjeohtMCtIyNMMww+UP3m5/hwtsPKgFE/b7ALlBTZEU/G?=
 =?us-ascii?Q?d3XHqtzVKxJTwcyWCy/iIPQGZW8Ir0MJpcQh5GQf0NI0xc8+pV/JVcYb5iUc?=
 =?us-ascii?Q?tQVOr8NNCYgYdnMEjdpzTr/nCzD2IbK4N3veYv0htYd7Dv3QypLUAWmSqn/e?=
 =?us-ascii?Q?pVyuVOMZuPPvqcgXwapRVCwcy1d2ybPnWn4CV4j9XkxOK6c2GmxpQABE52eq?=
 =?us-ascii?Q?avFqz+rcH+EQJ20b2ywy9Tjy2Tt6er2a1KQ85QrE71jw0HjaCtVWYYZdxyF9?=
 =?us-ascii?Q?qG7UpVhVEoHVOMAUGuthRuRcmjfie7xMOeCbal7CSzOJCCdiXvBQ6u44OtCw?=
 =?us-ascii?Q?p6rFrlJ3teEMi+FCnn1gKIaMB2yVgW8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb7e713f-fe24-44a7-1558-08deaae3300d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:16:27.5347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2omueVaUg+tbeZJn2r+zEzKlpB3XIcIj1or42o2jrAefdfG9i9YB6K/Ow9PtSpQqoqVkoRMNafozIyJmwYVRP9z8qVJndPH5ttAQGEb+y5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8155

Add CI/LAVA build and test jobs for hardware testing on the
StarFive VisionFive2 1.2a board in the xenomai lab.

Only run the tests on the qemu05 runner (tag: SIEMENS_ERL_QEMU) as long
as qemu01 runs on the outdated qemu 7.2.2 which hangs up with riscv
workloads from time to time.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml                   | 21 ++++++
 ci/lib/kernel/head.yml                      | 13 ++++
 tests/jobs/xenomai-starfive-visionfive2.yml | 71 +++++++++++++++++++++
 3 files changed, 105 insertions(+)
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
diff --git a/tests/jobs/xenomai-starfive-visionfive2.yml b/tests/jobs/xenomai-starfive-visionfive2.yml
new file mode 100644
index 0000000..7f8b515
--- /dev/null
+++ b/tests/jobs/xenomai-starfive-visionfive2.yml
@@ -0,0 +1,71 @@
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
+# Note: This test uses v1.2a DTB for TFTP boot. Adjust DTB URL below for v1.3b boards.
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

