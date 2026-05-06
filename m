Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0B3E51E9
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056939; cv=fail; b=jQzEbDq+QWxamA1DrVhCVVvqi/zkUcx1h/0lpqhD+gHBMW9QjQyW2XNqUOKqfEZOuBlIpLAjmEMbuodgR0ypq2jGKj7j5eQEQdET2+LNgzhp35zIEfHmY5LlxlrKLtm4Cgvkb67jUGzn/Bwtrj5LHJuQlKTnVPNtTzE+kDlf6kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056939; c=relaxed/simple;
	bh=YTjNATkx+lvC9310BfOgpb6iETRXnq/1dvbj+dPMBOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElpReTr3otX6f8YluvOZHH5iBQkSvy+C/2mQZxoeWLk8cK+93gc7isfWIkoiVVZMfqKwmarAIU7xs1VeQlckMpDcT2HuOOUAppWEE+8SeHdQi09ptUd9T+bsOyNPQpv1o7p48BqtPxVfU6QCLRt/20Sb4Fa6mv6Js+Q1MsXmF78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cyKCAFXP; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cyKCAFXP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqqFuZcFNEVKuHLeIqriVqh0/z5euGPKxQk0qNhwYHPqddzO+f8k7seBAI1k3Epgsi/t4PSbbxLBUcMoVdwg7/hSAez0/X/IVx3jhxeUrg4G8zXKz2c4AcKWEvQljysujFaZVHcGMnE+/q60+5GpAkn17FPH3z7QSi3ea3zNTvFG2MdI47oqpwgpcxrHTFKaK7r93loqX7HGugTXC4KIzvo2WBcZMK6ajD2JFSyGveYYCkiZGVQvHfZ6VdaYc5Ye1BWux2Lr81h3sGl9A5pMcmL43cAtU62W2VJV76sYTpmHmDAzPprXlyUaSnCJ4QlS1U5PuRDdcPiUs37EjgMB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtTfLKfQ81MSF+304T1B2CPu6GWjjOtjtz6llMPyL1Y=;
 b=Oc3hE0IXpdYKqzARfDbIN+PZuVtMzfC0erLwg5GaOfoTKr1cqeQEPuVTx3lZ210z0RZ4eV2PydH7o06U7Q3uS1eg85t16f7bEwPXUWx5Sv2RlxlRz+gxV8LEdir/Qgjg3QP9OLUe7tdaCbgvEdZN0kaWallwEVY/SLHLVSJ6V+VJTWjZZIisoOxCZpEBj0E+PN80+QSXqGEEPRC6u497a5jcsCUWLsYYgOnSw+uaWCh3+/OxcnfvlViMOhfWnZCaM1Wv65Jkcg5wkrIGZlQ/VpmO3NkaYTrYHe4ppYQRhXDQXftYU1vaoACiMOkk+8rWJpL9Vuv1UhiAQrpy9fBlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtTfLKfQ81MSF+304T1B2CPu6GWjjOtjtz6llMPyL1Y=;
 b=cyKCAFXPZQtaoB3RYXnFt5GMAtX9b5xOf0w4G5c+WSinmNe638HUGkwgjZN+LDrRAYUTQeanO966qYKOIMr6f0W6a9oI/oFaRIapOpac6iqlRvAFeVw1EGP9fokqa2S4mMmj+aLgcNAWluxQKgp3frc0HjrfpEbOM7JobIHW3nSqWsu9gJrHLRV9ahjaP1epXJxUO3PcJ6DINLElkqCnO4fCcVd78TRbXpbTeN4BULZDLa+04b0o+fvkjGsEe2EbAgr2SDhOuXPp2GMClEra2Naxt/P8uqNr/3TZyNuR1OYi/+s2+EW/oqwRtLeenUJ5IFF01o45vaEbVu3iJE8rgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM9PR10MB4070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 08:42:10 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 08:42:10 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v4 3/3] ci: run ci tests on StarFive VisionFive2 1.2a
Date: Wed,  6 May 2026 10:41:42 +0200
Message-ID: <20260506084142.190854-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506084142.190854-1-tobias.schaffner@siemens.com>
References: <20260506084142.190854-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM9PR10MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 032b6a3f-50a9-4430-bd91-08deab4b5d05
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mM7oipG2bL5dmpXoZb5u43xLX32vrv8PA0qz5MHsQFnX769rNfZlJNb1ofFAnE7zwnTCfKcVnOATrMVtcDpYjFPy1NXKfO0Zp07ME9qmwwCz8haJBk/ccV0T285cBcGPVWnq+dD3VXxX9ENNrqC5sY9k5D9Z2x4yJAbMxZ1boue5qTCkWjGOPYqwABxyrwu9muezdVIq9i6ZB0E44ShzQDH3sV4zZwgpUivBRxR/MnIq9h5i6Xb+cveE/g1hqDacfu8oPeCx2Z2ThPQoReX/oAjbe+I5+Fx2qePAa2Hc91FW+rBEN/5vwDHYHcyW4jEAE/WngC8CakoiL5MAJvrhpm9D1ngGAXvFHoQgLl8LUYN9O0WAz0YD0QL7iN7e0+2U0ydMN1MolkUI2EzSrIBKCqzBOi990Vdcy7jh5+TR0puiBk7FnykJy77pxB7nFetVm/PhTof4ElGFnc8AXXWs9ts4KW+f4ukch9YuUaEiWA406Q5Gxr1TNQD+K1GMaFt5FWN3JIwk9UqkFJ0O7Bd49CI7czCaoYhXhUPAPGhrRWGcmA2vDhvSfnyqwVRQFB3D2wZ+MQmU5G1dNXpUDFm2e131zNANnlCjsgmXc4qF1fv+O1Qs4H9TQUcWtONd7WYJOz09KXV6gVmqUQqU4hufT6zTmAJpN5NDpiC75YHs5ESe32h2l5ndTYZYZDGoWuVK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v4/iSNEwlmR/o4OkMATUv44h8nQOlSZLa76t3AcT+znpjGnot+lPXeCi11Eq?=
 =?us-ascii?Q?d19ELt+yCB8hFTpgY70FXudaLhNyVyev56a4z3ihgOD7tpKUiuygTED/gGvv?=
 =?us-ascii?Q?kdCcb8X/RiF0kCreOQLNYU+YMUkxpoc7/pnYEzV46wHB0u/hlPlxtNMf24lJ?=
 =?us-ascii?Q?SwGod9zRXALNaYxpa86efb2ZDyEQhcsnSS0UeReEYtaLSHSP/3/3uZNDMipc?=
 =?us-ascii?Q?E6DuJLzOCa7geiokkg/sbkofn3GgNy2MslfkVYgGyjCUTXSQqnB9kxFoMPa8?=
 =?us-ascii?Q?trgm5S1L0qBiDlmRQY/QQJ8bwFCMTDEYgDlTmVYlaFY01H+BXROuk53qNb1t?=
 =?us-ascii?Q?LlgI403924Hba9B3uGMEnkigu2WvAgzxcnf/KmlVKjER6hj1DPvdYZ8MF988?=
 =?us-ascii?Q?zOnxVymVWgI6+u7fC2o+U1h1t+mp4yH60m2iKk/zFZiyQt3YvdeNXouCGHyE?=
 =?us-ascii?Q?Ces6+cLYhDg+eYt30bBd+Ri0/JuUf2+I5iuiPeHqggqEp55ouqD0QFOsAURI?=
 =?us-ascii?Q?Yoybg4Z5eAVAh+Lztyg7Sb4exSIoejlQvaRd0L9H/EY27BTTwMTIep5tnqY/?=
 =?us-ascii?Q?A/xgNAMGL/qujPtmYHY9CqLMj0Vub+JEKmf2cXLdSfo7wxifQz8IsLeWRWSR?=
 =?us-ascii?Q?DSu7q5BzeJ1wj+5sn/6sz0l0grsy0kS9d7868yZT6TZJPvsxNptoJKxL2Afs?=
 =?us-ascii?Q?tXAze2ned6ZNgOfpwp416wFmLG4BBSFdR3V2USv1EYgLUBhAVOkdDbMSbdG1?=
 =?us-ascii?Q?e6gK9gXgsC9DCgEp0vhyCaT3mTLvxFspzPTBJCVZzGMJgMsEkJ0bmTnFM05j?=
 =?us-ascii?Q?m5twRxpy8k9+SfMGtsDyDQnwqoC0NLhZ7jMyLvzluWvm+raiv81fV3ExyjN0?=
 =?us-ascii?Q?tkveE3kE7FsZvAZdtwNBpIN9FY+0RN3vgnru5VNyz1pmS2jb/BdsLdhEBr2D?=
 =?us-ascii?Q?9ryu+7lqvjKw/rFX+vHmDtw9m12oKGkeXYkaCDIJPPDkpsE0EgJIbVOLX/BB?=
 =?us-ascii?Q?0KYUmKUOqLE82YOym276KwU/M9YNEyBMuryCASj805yAy7qL88+EoHWCEDd/?=
 =?us-ascii?Q?CHOGb08/uJ4VBIG7O+Safda1LJyyQH5PnlfOa/+k258qtNbTHgNuhwqdhx0X?=
 =?us-ascii?Q?g7TgIeIGFXLPY44eEnPGbH2N4fCp64/3FP+0wZG0kZ998w/8VuQhDG7I0VZF?=
 =?us-ascii?Q?oJUFmzkHV6WwW1ndCW0D47rpa1BXMHOyuDDrXlzlZAU/x901Ah1SHV9LJYlF?=
 =?us-ascii?Q?NDGBP3+rV17gWiAehF8HC91/9wXMqowNswZXgWMY6UuBnfXbXkaP6z7chLdw?=
 =?us-ascii?Q?tS/i8IwantDf+BMfW9UnEsLxDAgZF/Z1DNy4Wxi7hXLwus3FtagySXEIqyTX?=
 =?us-ascii?Q?LEV10GREA7Jp0YTRcjHzlQujOE7cP+Xq+JcogJ0nFKn8q1k+w149e7IOkI++?=
 =?us-ascii?Q?Dka46SvNBdjpAuNCv1tCF35PL1Cpn6e40prAB+aFEwd4z3ia8hUy1errgsEk?=
 =?us-ascii?Q?mIE9hSBILNF0SrQCaTck/K33WTbwIK0Z3awxcRByMMWKRRloPl3/xOR6sixN?=
 =?us-ascii?Q?roewzSNBXPmfPThj1UZ+p+7v2M3gHZMQmLGlJEFEvl+qAXl4Vs4aad6d5GeW?=
 =?us-ascii?Q?oseuHxlqRT+9KpRA8xUno1Ab2mU3H0oIl4PuKPaylam1DhvSi8mGqkoMuqG/?=
 =?us-ascii?Q?b6sTzAjeblm3GdUfBujCeZAcGLkvSd7EwZwXCPHtN0IDdtmtStvdoGOxwea6?=
 =?us-ascii?Q?xdJASsORkWMW3wE/X7gVHy33hfHsCd4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032b6a3f-50a9-4430-bd91-08deab4b5d05
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 08:42:10.7824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQCaG/g/99KlestKC9o3cSV1l8HmE8OL3sRWHvPtj9szFxhslKof7F2F8EE45N5Zq7ENov/XrRNFBiB5uEEoVZ/Ow1X/bfkZCJHyc8YggSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4070

Add CI/LAVA build and test jobs for hardware testing on the
StarFive VisionFive2 1.2a board in the xenomai lab.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml                   | 21 ++++++
 ci/lib/kernel/head.yml                      | 13 ++++
 tests/jobs/xenomai-starfive-visionfive2.yml | 71 +++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml

diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
index 536209b..dfb33ad 100644
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

