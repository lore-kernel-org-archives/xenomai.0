Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A73D1711
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972006; cv=fail; b=bDcMjzsQWZK+2+w9vBtV8icJnvZqC5xQ693fmOAptJBxPfL3b+ttRcjDZa6ToKfOTufzCkYxC6YxsTqECWIG8MTI9dW/L6xliqBE1PAsDMzhhpT8RydZstGEN+sSuL1x0kSwQRjg10w7vu8OuXT4KSJcM+10ZubESkGfJuyfniA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972006; c=relaxed/simple;
	bh=hSohCFKuNVTB4XDJmHgGgOvuLc8Y9uYQlsfTzTOOrzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jq/DQV4FodwZ46QHVJ42sbrNT2WXGgj3Ox7QvjT8Nsqt7TVdEZP9TgPvRmkr02PJeOja0aKZElnx90UHS0kLjgZsCTByrH0UgG2HubVgRhIRYRjeDJudZh4sOuowVff6KeDPzyvGb/OjWpIKjptAOFMu2/QqR2vHZarjnaMc5Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ejywed/N; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ejywed/N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai3apwlGr3b+FtWrHkwJilm9hSegWIaJG1yWAdRroxqQKHOffjgYTMpxIpk/5deNmTCUeo/+fwU4ixds8/Pyyal6K00pJ4f3m+7/S0pMlgu/ee8h2StB9de1zEHuowKNpz0GQV0CLoVNH0xwgcNN1zkMfVDYd41F/yWRgc80YmSLPIejVtz5Avjs4oUNMC4SuDonLJVWFPXmtLhS5h57JpEIhQMD4DeppAcXFqTYqMtg23lah9HDKkV2txIYD0YnRnXfs2L4ut9KQYz8JpOw/nYTw8OGxJSS50lbgbMzXDqVxHHNTSz7hZa4VVqWehrB7d8I/s76pg9UptZ8S+FyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY6e4yAhStP5c9hDqL71776zen1iaLercgv8JJ6dCfI=;
 b=VT9w1Hi4Ow8N8CR1GuV851le8+Om+2CP80DETvymySR+znNZ0lNH5nBmInM84F/w3UrXKUme9zIp2xPlFdKWCUEXFUq9hdzfeurLGmgvPY1fV7ziamj1uctBw+2oJ9+pf4BYg7x52zOiEtLfG6A991Va+raRBlo8O0db/7Ud/Sve9xraJ05YKvOYNU6zXH1ePxGOysCzmbEhmMDExkx8Cnm7o81shhchsH7ZVHYW0aqzoE5L0P5E5znbmDF7EvEdwGm1rEEH9DeeoxF/xBHMvTgjiL/LL+PzSRWec3Jh2ro/R3p7NCVVyRw9e8RcrwCHFoWLzg8NlzHe54Kq/Ad2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY6e4yAhStP5c9hDqL71776zen1iaLercgv8JJ6dCfI=;
 b=ejywed/NF1jiVMKlSGwgpjuIGs6xwtyomKrmXu+lCaItXjB/Xjs2GoHET4L667aGllpY/jY/o1W4cF+4EtUKmjNGyOrzaDVLMLeN5ep1sdOV7Nw2USIwQ6rM+3ZclBy5r6lJ6skZELqjyhRFiq8Q2Vd3GUNBBa25Qw2XSFnJXX26q1Y4RecB86sqo2YWGPvNyTSCEyzZI45Sl7xxs5cTQd0mt62vAgknzGarmnrfLozt0zo6x3di0R7Mpf842vRkKWPPw4B/7pnMdVb1894A5ohKHzKhmsm6Nh0VThW8uZxOVEnEIDp/EsLGZ25T+Xx2fq3QWmxyIAtV3C7QLwnzTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB8PR10MB3942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:06:41 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:06:41 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 1/4] ci: Build and test the evl risc-v port on qemu
Date: Tue,  5 May 2026 11:06:24 +0200
Message-ID: <20260505090627.65515-2-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: ccf6eab0-cca7-4e10-a70a-08deaa859f0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wkmrlegcweWpUxOjfHwwcKltzjiQFuVfVWSfVlkNabmeVZReCfwlXijFSrTmHrDDgguuKB2HXiwIfciIkzXLxLvh+KJTlU27WcslpwSsphthkTWgocmzP84AChPRyRT+gYjJKqmCFffHiDkejtxh/Ew5hA1fUzQfmeQqqnZpEtcn6S9Ca7LgeFpJgTY2CaqU8ptNcxFbP9YgJJRB7OiqyPRIGijKjfnMC3K13jOE7VD5MUDNC0Kvk9EpquHm0jXxmaxHs30hVpGVIBg2tpRDRNbQ9iNvvSHDjQk/L4HtaX7B7beGP+fgjwOy0bfHE4PHZ6f7s5vpjBB10F7ZTpU/vAGhHC5PpzkzvE+kCNFGuVYoSRkyaSsBR7K9zpf4DKrgqe+sP8/1Pxt4MmKZiQ6QZnRBKXI4Q+wwoHCupHeUQluGTqTYbBior3CjEZtuo1gyiJdyKA+ToU+PQ4sDP9RVmKIo4U2vYqLHCAN7HqoE7CIa9D3kvG/MVkeXWDBjixF8x1ZqOabqMsHS2dd40tQHrQU35lvwr0Fa9x96COOtjN5Wz4HIAbhX4pYOLGqitd527joNyKJpX3wOlvScbhILUdfTGPWUGInhHDHK5nWYIiQOrsFyyJisJ7eU+5sAIakw6tHtoc5yzfq66wPVP5XWk2zuj+QH5ZlCtbWOyMvvgXudfYudHvPd9A83YXBAAGsA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o5494nm1vpzPc8JgEeRvsNVrQGoFCG3Mdg0h//ox3FWrgn3F32wtd6DxViCV?=
 =?us-ascii?Q?SuwFPNVp+0CjN7uGCGMubr61XjK1Nj1JaIfSQvZufiIiw3T130ml4utYLnbH?=
 =?us-ascii?Q?/WGDwAd+PVC39pHJyTCWiNM1/3gmn+XEPsBkhTN4CJrx++SS/Homr0AxC7Gk?=
 =?us-ascii?Q?FqYEpuc/3BpyYyaCy7Y6c5V1jEvqBFkcTNv8JqJCB02KrgkU+2gE7TS0GMeQ?=
 =?us-ascii?Q?Okhwi6mI8DoKfl1GH5ktqA60tH71Y59CWh7O66mA7Qr8kZY+EWPEChnVjJmb?=
 =?us-ascii?Q?q3oznQFimavi7yZephbMiwegTQUhCT09IXAdFp9we9iP9PenEu3GrRvHCRfE?=
 =?us-ascii?Q?A2il9ZgCztJNAKpr7pLncnu6uTli9qLsnMUptbVJzD+ScIGEF05loTDU/2oR?=
 =?us-ascii?Q?IvrQn1tz6Gxcmd6E89RFISfHmylE0gPDHQS5vbLQJStXatc9orjAqmToy2zI?=
 =?us-ascii?Q?NQukTpuZ5g9OFT9ccvEtrITyW1fyEK3pV4faqm1tScGPD6tCFWGwBOH+4qme?=
 =?us-ascii?Q?pUABUg5QfFrdcS09p2eQIaemouYSNQRw7NWPDCByqeTNXSOClvVQwfWqgNvH?=
 =?us-ascii?Q?74jexrUwXiE/orsu0QnMLXoGVdT8WNmu/AWVcv6XsJGf85Y0iJSKNr05CYgS?=
 =?us-ascii?Q?cD0PO568JoHRObPYpNC7FYSHFL8EPu1diPqbg12BZOX6AWDWvPZfO2kor3zD?=
 =?us-ascii?Q?dXybNB+O40908o2l8jkXt4aPAO+wXj6ToAOa45St3EmFsdAEJrZhStImxXvP?=
 =?us-ascii?Q?YkISHSszygwF953vvBVjzeXx27cQMYwr+HLE0eYEIrmoplrjo9Tc+v+8+yRm?=
 =?us-ascii?Q?bamFnjQGkF2Nwa2EPEKyEXYieoaoHEyRuogk/9mJxDGiCqLdY6OrX7t97OlE?=
 =?us-ascii?Q?Yw+I2Uoy9tuHMC7WrvruFTqUNiA/ld8j/J0ujBM8CwzdKQfUVWF+JdxLKTJD?=
 =?us-ascii?Q?DiU9Q5iKeUK5Uhv3FWbAK+8rpyoUyBOyWKjbty3rRJQKI2wZt33mEMvXufZd?=
 =?us-ascii?Q?yik7OzmbFle5zhuQCF6YSmx09FYDxwKkBPU1XMaE4iNGB2t0G/5GX6T+c+xt?=
 =?us-ascii?Q?mwSrFSUwqkc9+n5AZUBV/Y3NX9qhk1iLrnuzAaShE0VC37HIpVlIfiHrghq2?=
 =?us-ascii?Q?quSIhfG2svHDiQipVlGhomnJsVQxckU4OonuZo/isnheaks34mXAGNISElav?=
 =?us-ascii?Q?h8u5YJZhfy45WMkeNQnRj55Fk++fddEX0zc+csE/9VvjGYFWca8pN3WELj2C?=
 =?us-ascii?Q?fElSm11UYGsIsly8oT4wxkn1AFYlnbmFfDH3sGGgloXvf0JkCQyTHhlQ+rUb?=
 =?us-ascii?Q?sPF62mLu4pQDEhXnMQ3CLpnIIzGCZF4Aetuq2wKLelQJhBgzxMjQjrSPfWFj?=
 =?us-ascii?Q?EUnRjtajCd18WHcyivR/l6bmfMJTaW3rZ73Mqs/8SbaV4046K3Qp0/G9p0AL?=
 =?us-ascii?Q?XOr/w7s+0T+AI4GDNC1I3JTIG0UT1wMUbtfor+OT0AJtyj740s4HTI3KC5q7?=
 =?us-ascii?Q?iQuzBKGp4Sb7pB4tDYWPqwzDcXUQqP0ETY6kzOBPwxmRffQFqyms/ArhQyLx?=
 =?us-ascii?Q?JoJr4N6Kux7aQIVw5ArtxAOLlCbw4sakpcM0yNk4fpwPqzzwHGxoYaWoLxim?=
 =?us-ascii?Q?gPmSJwwJTipV4rhv5cwUdGFOK4ZK+C0uOZ5Gnuy8a/paW0bMAXCSJOBvgYtu?=
 =?us-ascii?Q?zS6YaqBHt9opzhAcAADvpy0Xm8wn2U9lGpuIfnQkKmv5VmReiElQQ46LVrZK?=
 =?us-ascii?Q?2Fe3uvo89hIyqjGlXwRV9FB1YVhM1bU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf6eab0-cca7-4e10-a70a-08deaa859f0f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:06:41.5016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65RwDAIb7eELK/et4KXmrfKLp96Kdxfwwuuk9nqOLo+BFIWbbPrO/yNg3VOe2Ty1xvw2DL2J+vFDlDlvn4/4ClWdRSBEgJ4TFJzuYLeS/II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3942

Build evl for quemu-riscv64 and run the evl tests in lava. Skip the
ptrace-sync test for now as it fails because of an open issue in EVL.

Added sections in the end of the riscv64 defconfig for nfs and
debugging specific configs to allow easy factoring out as snippets
later.

Only run the tests on the qemu05 runner (tag: SIEMENS_ERL_QEMU) as long
as qemu01 runs on the outdated qemu 7.2.2 which hangs up with riscv
workloads from time to time.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml                    |  38 ++-
 ci/lib/kernel/head.yml                       |  13 +
 conf/machine/qemu-riscv64.conf               |   1 -
 recipes-kernel/linux/files/common_nodbg.cfg  |   2 +
 recipes-kernel/linux/files/riscv64_defconfig | 335 +++++++++++++++++++
 tests/jobs/xenomai-qemu-riscv64.yml          |  95 ++++++
 6 files changed, 477 insertions(+), 7 deletions(-)
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
diff --git a/recipes-kernel/linux/files/common_nodbg.cfg b/recipes-kernel/linux/files/common_nodbg.cfg
index a57463b..6637d16 100644
--- a/recipes-kernel/linux/files/common_nodbg.cfg
+++ b/recipes-kernel/linux/files/common_nodbg.cfg
@@ -1,5 +1,7 @@
 # CONFIG_IPIPE_DEBUG is not set
 # CONFIG_XENO_OPT_DEBUG is not set
+# CONFIG_EVL_DEBUG is not set
+# CONFIG_EVL_DEBUG_CORE is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_BUG_ON_DATA_CORRUPTION is not set
diff --git a/recipes-kernel/linux/files/riscv64_defconfig b/recipes-kernel/linux/files/riscv64_defconfig
new file mode 100644
index 0000000..a4ffa7f
--- /dev/null
+++ b/recipes-kernel/linux/files/riscv64_defconfig
@@ -0,0 +1,335 @@
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
+
+# lava lab nfs enablement
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+
+# debug additions
+CONFIG_BUG_ON_DATA_CORRUPTION=y
+CONFIG_DEBUG_ATOMIC_SLEEP=y
+CONFIG_DEBUG_LIST=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_DEBUG_VM=y
+CONFIG_DYNAMIC_FTRACE=y
+CONFIG_EVL_DEBUG=y
+CONFIG_EVL_DEBUG_CORE=y
+CONFIG_FTRACE=y
+CONFIG_FUNCTION_TRACER=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_STACKTRACE=y
diff --git a/tests/jobs/xenomai-qemu-riscv64.yml b/tests/jobs/xenomai-qemu-riscv64.yml
new file mode 100644
index 0000000..d1f0217
--- /dev/null
+++ b/tests/jobs/xenomai-qemu-riscv64.yml
@@ -0,0 +1,95 @@
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
+tags:
+  - SIEMENS_ERL_QEMU
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

