Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6C3D5649
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972016; cv=fail; b=RKnG36p0OsKh2/dHb5SqIIsPyADFksjMFQghXE3D6jYfZWYhJnjMA8dbwmyXCniHK2JdflWaiPs/5ht10TrkPBa2sokBlQ/3j4Z4WTqvpuPxa78OPitlPfwkaancunnAaQ9GtnLFfqBuBiKNZhhJuflRVukeDJVkNvLRsB453OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972016; c=relaxed/simple;
	bh=GAEwx0reQQ8oRQztXxhgdnAvZbJytX0qLRFoqxWL35w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lknYUhuq4JqUZTe4QX7MPMxXjIIOrogXOV5Qfz3Py+R71feF4IQLXc35I3g1gHxWN83aFVMTJXJhWo75cMk+2bdfRIR4pBM5ngw6RgVV9542jtoqq6YE0n7H5MlZwu/eI9wfOjw3a+Nc8ccnaNVSEXteQRxGH41CnUi6cCFaau4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mvJbAQG9; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mvJbAQG9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCES9lMl6EhfZeTSICyO/WZ5DBquEBhvdw3rlSd0GCMDAudX6lePN5YuHxmw1k9EFinAvGcYMqyOZjbm7BrECOh90Cc4r1/QyNbCI7zKeeW8Ajm/4nqID1n4a8Xof2WzaM5DYWo1fg0pBxIOufh9H5fTCsitLvxRaQyzeDgFl5mUpZXKlHTjA7+vz5UETCemtZ1t5pSqTnrUvER6niclZNMsg/G/0kzg8upSSwJN1+6nPcHlUqoHGR/dSs3gqb41U9icuQwm/fWNVMyH33favv1ZpAdSdxlSlJDxml/mwRdoOsq3ST3Jew35AOHBTbEg2EZda18sUd+Df1jYW592Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faVOFHsLw23jgfH1y2g9mpMUSMDZsoEzrAdPpLsAm0c=;
 b=bK61v82wLivM8Ix+Va7wgC06bp3FCfEexaKert9o/9k9iot4+6fIxCMO4A6b5JHRr2YN/MEfMegA8AqIkbiw6oS9eTwmld4aRsg6qFemoEhmEs3+dhIMCDMgfD8YKzKoOHCdl7OOL5AP3lxYGojSBNGuLYzsp3KM+8T/ZmwILj/XdsJDAxNGDYwP89FDV49JSuM5kUCtHuLdEY2IQ+TAjCxu870vxSPmCM4Na84fI9HR0Ulib9QjZCOJ3yCW9UM3G7b2uNExJFtlekoS5mA7giFeP7Uv/ffUlKii2BGYZHj32JHFVsaJmQIfCA7TYDcnCdwmeNCy70X4htM3nrzyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faVOFHsLw23jgfH1y2g9mpMUSMDZsoEzrAdPpLsAm0c=;
 b=mvJbAQG9TWT3PeRcIkkFVteJWRzmxFOGuAC90787r8ZFzDlzKMqBtxdpgu+X1fkjQnQiOlj4MjqxjMQUkSX2hU/jdv+hnq9Fa7j7NZpQ9KDYHB92aNE7PugxVAi0GQIKGQImPRqwYVMutbEMd8vOi23LEseeM1gTanAZE4DMUCeYvSWKyoNf7gM5w56WXcRHJdxlpiQb3jZ5FV9S1zC82IPOsldx59B4bUJdYbpKOap1rBoT3s17XYlXXcIkTTXVTYI3rja0/5Mq4p3wtcLIQEMOooxHEbSuE2aLQ+xyxci9jb+0jjHHOWJHdZoaw/1Uan6OzJ85sngUUWUNMek5fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB8PR10MB3942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:06:48 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:06:48 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 4/4] ci: run ci tests on StarFive VisionFive2
Date: Tue,  5 May 2026 11:06:27 +0200
Message-ID: <20260505090627.65515-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505090627.65515-1-tobias.schaffner@siemens.com>
References: <20260505090627.65515-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB8PR10MB3942:EE_
X-MS-Office365-Filtering-Correlation-Id: a47757db-963b-4b34-cd6e-08deaa85a34d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	82NRvN/9VuW+HFed5W1EeC4jDd6Lp0z0D16QLauL0vcaQSNTTdubv2UXt0H4kMkIb5/mD9tz+547pCGR4VDk+G+G7JFUPUUAsazxd8YhHKWJeja1FaGk3K7oTs9nzzCSdQ41Z55BSMN/ZKTiVPe64OtnJwvwWq4HtyW0zEa4z15xeRB1KF30mdoL3KXUDLEyx+DYuoHbFG956Eb2c6A4vwr9TBEi1s0ns8MbXeVd5shTpVgesI9z+rqX3mIr9V+bfC7tiDnsgXkhNYvKXgrn3pDs64CEeykZUbHr+hEXa3Lel9pNQkpwCsOKYH7I8sSlIX7COnPOpB81sPNcap/z2PBMzBQbh9Wq5/96N8AnEXGeMCQBuXsoEtlZ2ZhPX6wXorpbzV0IVSJR9SgRnuaMWAAlfz98tdoT4vMmR3M06DJA6XjuMx7ijsoLnvqnKiD+gugv+LFbi0V1m2wL8VYteYMOpzVyKh3R4fx1q0psIa7K+jiBqduslTBgHq+SOq5AN6jPOT98+WGo9YH9R80eeYDI4xkA2xG+0+YN4WoynrPdvTmyj/8vnJXOg2wzDgbwYbhufUV5JNdDl5MpDDcJ77KrcQF4ZCbonCPQ5ITJnRLf+cuzatjozpH4ObdwhgNci8DXSBo4Syv0KWOSDrbwKUoQZGaTD83+ffKV5S2htZF0tWle2OrAiB44Ra0tMcvs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KbcStUVpkk2L3vYNnzcpTkq1kxp6HiddFmxJ0kKAiKvEdILBNPR5RFdqq4zN?=
 =?us-ascii?Q?1BF9lOqP4PJmkvUJ0NdeChZVlWr0c2c5iPGySbn6gwK/xZABGAZpNRXMmqwx?=
 =?us-ascii?Q?sLuBpX5vKGU5bkjVkGKDQMOdEUdXpBrnxqQ0MHCJpYWWX//pHgiJ6cqlBDcI?=
 =?us-ascii?Q?3v6h2y6RtXPrRkkp/3L0Ufh3NLu3xBSVejbeo9rvG4SgRcLJsN6ycVgz6Uyx?=
 =?us-ascii?Q?BxeoNNKXXRM/8OaZusOQr1W5OxEY7RrCQK595myN7AKK4zKA9DCvQ8G9+pBv?=
 =?us-ascii?Q?oFZOgn9CdlUC8yy4lAKaMqa2Q1r428mQe7Gw+m568a9tDDAzl8u+SCbJLyLv?=
 =?us-ascii?Q?JNlAfu88v8PVmUpZpAuBFzzM1KDrB1fa1LM5vyZbmeNyowJnoAMhw44S9N/g?=
 =?us-ascii?Q?fNxFiQ1VUGQVmJkwd9Mxu/3j9DE5slM6nuu60s5SfJVu8rUTkBQWah5M1qvh?=
 =?us-ascii?Q?i1nmO3GcvQgDPSjeOAapkXmfKoLqf2oAsI5XV9T6tJgPkfcYVAGAivIrzFQ4?=
 =?us-ascii?Q?keNtXbEYbofiG03EOujd2mimQxseSOADKE08MPnUw1ih4QlVNY0JDQWPCeoq?=
 =?us-ascii?Q?UZU4fvPs1vDotg33LHq2I03zdntj/aPeJalCQRvFthPsDCWRaMfCCMcfNhTw?=
 =?us-ascii?Q?OvloBrBA/XzE5jDnKm8vhIjL1Oc9NnKa5hO3TF0xp4SX6LWGH7aMYBnnhU3L?=
 =?us-ascii?Q?iaW1tbDNgPbymHJWEpUn2t3a6D7BA5O8Y9gm70k6RYI/lQvX76G8PMZ1TzVk?=
 =?us-ascii?Q?dLePIiJBocP1vwkFx31j7ydgZkH20BmCSy5KhxSgDErE/WOFxztgHts+BbtI?=
 =?us-ascii?Q?6CnIMOdh2XFoZ3RmaHXTfs62zcCNCAGuFSVVTpnJ0yCDFa/0t9rSgiV/VAic?=
 =?us-ascii?Q?DyIiU/cm0t14mLu8tgWIF1gUrndhk5EhQZaPhl/kWGz+ADNTe9A5TCBrckvq?=
 =?us-ascii?Q?7xHBwbrB7oVCFzJoauFiv2CcOHmW7PD2S19J+Zyt0UrJOIY5nA8rVOFtq1XV?=
 =?us-ascii?Q?Qhupxv53WMCCww/DMFcQVe/7HvAXIeq4Ywp7xyf63bWxjsclsP1apSKMZGgA?=
 =?us-ascii?Q?4FsClarsWdlyeySwUVa+iwhI9fDc3xUpVoO3Nr+SWj9WPgYWtKTOVQkuoOhc?=
 =?us-ascii?Q?sZovGYQH+xRDlyj6MU3w2SXjk1U2DSf8uE6RKDN5fPVmQaS0JtX1p22GEYUN?=
 =?us-ascii?Q?aa+Vhyd7XjCo24m2XidbrcSp2FF6GPQKu5nb6tHFmjbU467+lBHrTbVt4oF0?=
 =?us-ascii?Q?dX7qERN+WJtpGVKmMMXDNB5w2KdBVLubXORk7nQ83qZXZW0ytVCtQF5EwPbv?=
 =?us-ascii?Q?4v30060S/acV4XrXZCmN2apvvd0zqFMjWoSKkNfU/j8hkiKqqsrCD0qQXN/5?=
 =?us-ascii?Q?CMz0XybJgJcZ6IK0KKW7fzXbIKfunk+8d91f2ITs2Kwy/LZb03C3c3nseZt0?=
 =?us-ascii?Q?+qFNH1cVSMdL2JsVNzm+DPQobwh7ALsl2klHc8tYdm36Kpto5nxu3cRZ5ybM?=
 =?us-ascii?Q?+Rl1bVKJhlainhedpT0I31yVlFzvSWlHZIsJJ844EWZSdP1E2guJo4jgKFct?=
 =?us-ascii?Q?coQlywUshfpmEEIz1r67QtVicm61OyDSlqzrYis6jz7HznXcMbHLYyanWzqW?=
 =?us-ascii?Q?I4IGxqqj1O9ZcNHHBFpTdsellCYCUfgBZK1x1yeTWN1C51+JcTjA22+lgByB?=
 =?us-ascii?Q?cJqgM5PyZvgN8f000AElttO56+fZJLDXNS8GiDiKQi2lkh5PsFUPB/3Wc4w9?=
 =?us-ascii?Q?1ajnhVIvaxIHvCR0oR050U/uXgWlMDk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47757db-963b-4b34-cd6e-08deaa85a34d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:06:48.4331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecR+wMkARcbzsQrkhJd8e4U2UZaEB6ho3XgLuIumCVxuPqzVCMwKlF75qRCKBVm9AqOF3Qb3XleCSoEFAAP0I7RklnJvl8zp7PkN6w0+jao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3942

Add CI/LAVA build and test jobs for hardware testing on the
StarFive VisionFive2 board.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml                   | 21 +++++++
 ci/lib/kernel/head.yml                      | 13 ++++
 tests/jobs/xenomai-starfive-visionfive2.yml | 69 +++++++++++++++++++++
 3 files changed, 103 insertions(+)
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

