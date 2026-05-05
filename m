Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B537C909
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 20:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012200; cv=fail; b=eiOSzG0IbNtfhTb83rcrwmlvpoOXMnkX+O17jSS8kRfj9kUhZWK+KW5B9x81A4dNp7DL2FxhSKQ+Yxoz1naAcWsGAFXZjY98sP1AeeF9MIwnNfbqABX7/qfrxRpNpEnS6T1sqPCYxG2uM+L9hQoIKZgSFPz6uUFje54CAc1O8XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012200; c=relaxed/simple;
	bh=tDxO4h2+CFaYcl0v3TWvnMTqlDp30E+jf2cgOrW79wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EfeszT8rRjCMZ5yKUH0W2QRUDmCEunqpyO8MeJuFjpWMJTW8GDJBMHK2CgvfGHBBCOL9WZm8p5biJAvti/Y2RlQ1PQ5ipNi6ffC14WBPTQUtqHSCb9g+3FvuMUTuYjKmnK7VJHh8Pvh+Y2oEuceDkXAWc2eqLXdDBqen+6Bsm4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=W1BaZ8yO; arc=fail smtp.client-ip=52.101.84.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="W1BaZ8yO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRkKcc8I9b/LsojsJ54nC8vYz5KbBYb1hGfmB0Okc0esi8mYeiohnnayOM+dSgK6HGVeYb8CoC33ajDNw0do4sK5cJB0iO3/8isVey8SF/qRSTN1Xpr0HE8gzGqjPjsjogoejkRiBej8bcrpddnt8iSQ2yNVfyHn+uR1GW5ewSiR5qMeDIjEf8ZEdIoVkadi1ntFt0VULHckbhW+L33S1ua2jO/5g/4972MmsPO0Dkj32hfQ+SpPLKfkJAZpIRIz1Jr5u/aFBcjLSUYyKyqF7Lgv1axBissdDDnFKsx8Ed+SzsibuLqBO34WO4ZSy+5aovSpqJSu1dB/k1xvbR/2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrGSxlHY+yGKDqd46+Cpd3RdAyG20hZWG92PVrIt6lQ=;
 b=EHHGB3tXjGj1cdxcSLFyhG50l0GpBII+GgUwMEoDUeW7wAYyEH2cRy2ZgyYlYFVaEySZtH60mn2w10BXFOCSRyO/FV7YmUlAZpAsHSscvcIt/Q7P9BZIhlDj1k9N7IePfadhrV+MRun8XYEpUt1o+RAqe4hAY0gyOcbCMMmw4uRX2YgapSbJpG/hqY19m7/puukmM/mGQEbkPEHOSu8UKQA/8mBch6bAb81S/lNBW/Qsw+nQTk6COFkZsB5Wem0PnU/r76Tub4UHx9ZWNav+w4QnArjDBbDArYRretvq4trziLkcmDIsv5k3pgQ+GBMuzh4OXwJaWPKHLGGWC42CZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrGSxlHY+yGKDqd46+Cpd3RdAyG20hZWG92PVrIt6lQ=;
 b=W1BaZ8yObCTuoG4h2dXjX/+AxgImdjZZ4SaLhOJqlWfNEXLrxVSyBJhj6pddsbF2Zuec/g437VxB6VMa7Z82o2VhwSGTrQIjbB0hrGOtJtY745IRPdtcAeJLuyQ13mheLff5HZjaWuJN0719J8rw0zbTeWz9yQaIH7UHp8YkcCMjPw1+T8Bg2KgXcJQSogWr3xLVhqHLD1dX2EqahW+6zFf7Wk4vJJ5MzcvWlrej/2QoCoLEVZE/UP4jNcK1Mf8tVqs1GcNfjOh1suPSlyXA3IQJ4n1QYf0sNL2iEkWv+5xAJDEImEaLxyCw7RpLRqy7wilLRW3fKM8dIqeqqhh28w==
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
Subject: [PATCH xenomai-images v3 3/4] riscv: Add StarFive VisionFive2 board support
Date: Tue,  5 May 2026 22:16:16 +0200
Message-ID: <20260505201617.148513-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad70c104-8d72-42fa-c357-08deaae32fbb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10063799003|22082099003|56012099003|18002099003|12006099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	bnljIinJWwpmgrVXN+oa525JHDt7BKOUgV9Qg0f2b19BX5FxCshNZoO7MnRrAu2JwxxdIZ155A5UXFdrvQrxA0KB0MD8i9e0LC6yUnyBklGOCrxgNBvu/Do5vZSd97QW9YwC5Znuhp7keoMYzJoorrxmtiy7vGbmvA3P9qV8hcQq4a3sLOsi879BOWfgJIFGYayz3c25od8TvP74yEPkjPF1loePe4IO7Fhhkz72fgAANRJnZ7G1HS8/eTgfwo092J+KisWP94gkqcKYOOWqjDtRJfgt4BsY6N/6FeAq8A7H3QSL5TB7+t37omgZoRoKec/8rDDw9y95TazZTkIT70aFP3HDg1zd7p3zNqzrD+2o8du/+Lh+V+sniPA9H3wccORjdhGlubwJdi1t+UAEt179NdLcOxDIMafWa1fxdrQU9BTGkVValMtSSWOB4yjM6oA7eKGb/blVTxahYu5tHgqFl25zJ9Ix93AiKVvORf6og1Q7OmlF3cHWntDclji1mwCijWupkRocIOcQvc94Y9y38T6iPOy/4qUVhyu0qZovvBxX26kHv3BX+qh5et8hQJashNrXGixOKGDgJC4Z9sbkLobM1Axdi9yd/H7KqhKKQC7vXmLK1D6qc3nSleTkENSACUCAny9ogquO/hMLzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10063799003)(22082099003)(56012099003)(18002099003)(12006099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o6kE3rFlgjr1xS943gTii/X0cUUsaJr4nn19LhP4Dhni2b2+xmXNcD1jL5Rc?=
 =?us-ascii?Q?YD20hfCdBLGwLUyzafqHrxnBOots7qU42Tmd92Na+t42yAnVScGKE8EWx3rL?=
 =?us-ascii?Q?mV5TSJtbGCVGDZaWiHGnThH9HXplxDDMvTp1bd4qRCsQjaKSChbtUFPzDpBJ?=
 =?us-ascii?Q?BuQjA6Ch4JGjZUWxh26sz8jpjDphXCOYEbLFQx9utfvEhEMx/WQZQVVoxejS?=
 =?us-ascii?Q?w0MCGTio9Ck5WAABHlXzSoKlhwG2PBq9adEFuKfIqfRQVzxGw0O2q4EMzaQL?=
 =?us-ascii?Q?CL9THlSVMIWLqkmHjUyC46JhNPF9T1YkJWYRwbNv3L1sKcy9YnNuqOveqMc4?=
 =?us-ascii?Q?BqvkwKFjZ1CTAu0OaH2sdRgP4FYZpqhzqQB6T2mvcvmbAVPfKiaPC4fU61mB?=
 =?us-ascii?Q?STcDRgi4g3a/l/hfpZrsjyPT8TQfg7nYs56d6cLCuuM4k929PBH047tuKXCl?=
 =?us-ascii?Q?8Z9WedZO30BQrk5lWS0Wh4SwXFrOc96lmAGKl7M8ipjmDjYUgqlJ/jUvR1MO?=
 =?us-ascii?Q?9MVLN9PMJp3dgZU0pc/hFJ1pHiNIKn+f4VbqEPuNur8j8Jug2mymjFysMAyR?=
 =?us-ascii?Q?8fWwZPonrkg/ysuZ7JtCGNULxkqbxHmcwIHNcQSr/aaBWm9amH1IuTk98Y6h?=
 =?us-ascii?Q?c1qV6M2h38GZx1m/Yznnm7qj23UDnA5jvnLGH+eLDJVll4aCQSxzyFTt9p6p?=
 =?us-ascii?Q?Q/bRs4rCecVHm3knkzr+76+D+ecbYSshXhpy/ru+KGFNEjhnlMz1jGtNoa5J?=
 =?us-ascii?Q?Vx5MCjaH8Jv76H5k97xWkOBG9nvaHsCZ5bmlDDB/jTl7OFPglMXYUncY62bc?=
 =?us-ascii?Q?s/1SOtP4slza40c/G5eYMgnmeof/GPZy0dcjgesLMnsXUAJycrnzyQD2WHN1?=
 =?us-ascii?Q?qLHQtstM5HXWjgVrDlT/MfXQXWqeOeKG2gML3rlF7VIZ0UDHda9bnw8a2Fs8?=
 =?us-ascii?Q?Kzx9LP3u9VWSJAP1ci5hL1vmj6DUGjdih7nkkO4JP7CaW2F9bbfFsA6x5XgV?=
 =?us-ascii?Q?dw2yaNwGmxrt8QTfL2sOvVB0kimrvuuFgxvRukYTX23sHCtNrO8nZuWuyp+o?=
 =?us-ascii?Q?43iWtTOGGWNadyWEgysQLR/X6kGBlxJtEoRzTayDh/309L6K6DGIXmcceb95?=
 =?us-ascii?Q?KBJURG5AO4Yiq5bhXGiEXIPn5TkHEF1NyPOyAanP1qmKbZH26KzFu7yiPLUE?=
 =?us-ascii?Q?POoFl9nnhXp1ohbmsuBPbDpyluz1IrsiADdHb9UcxqDIjm9TjtRO2ycaFAKx?=
 =?us-ascii?Q?42cTEieuUGFwyYt9Qc0utwePNIrQqHwLdnUDCtuJvGPjltxi8JV9EV8U3nnx?=
 =?us-ascii?Q?VMNdJm7rTfSChBr11TMO6shXaotvRs6hLYNQK+R0c9yBcPEkXMENqELo6inc?=
 =?us-ascii?Q?9GNsGmX9jNpFsCD0jyEDChsr2i5oKJljsFdBsrfXFRc+lVwVrd594kfRQ0Vy?=
 =?us-ascii?Q?dYBH4PlqzBK4Fx8PFvy54ZrDit24SW8B0fjMl7rE/xVIP7q1+N93CexT/Yy+?=
 =?us-ascii?Q?HFOel63S8Pm+Dc7d889kkfYhf8W3lNW1jkY+p3EzdBDwmeshFqJJ9Aie2zNf?=
 =?us-ascii?Q?kcJv2QTMcQFXRvxgYIdzOAN8M4MVA9Din3gCmaVgSoANQ7WYbl21JVIDq2OW?=
 =?us-ascii?Q?AUHp/AUuRxlH5N53LqME/Xm3MtDVLlxWc/zeXmu//dX4LxO4DGWLQMtfFH5i?=
 =?us-ascii?Q?D/rIuBn+pDl/E7c/bTuPxOWDluuKsfUmpEiQzjAWHsOV+prSDKUaYGvkcRnX?=
 =?us-ascii?Q?SxpHI57M5kID4mXqA47JXGuGwrHsURA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad70c104-8d72-42fa-c357-08deaae32fbb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 20:16:26.9510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEhc0MGoj3TIjUkbCwVrfiOZryAwrGczmIAv5VdtJq51DCqkC63f6/EIRbmOwfgByjEvnVjCB3UMRG2FqzrywWMvXZEKJ/mo9NFcX3hgYBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8155

Add machine config, U-Boot, OpenSBI, and WIC layout for StarFive
VisionFive2 RISC-V board.

Use the latest openSBI version 1.8.1 but stick to u-boot 2025.07 which
is unfortunately the last version that supports booting from SD-Card.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 conf/machine/starfive-visionfive2.conf        | 21 +++++++++++++
 kas/board/starfive-visionfive2.yaml           | 15 ++++++++++
 .../opensbi-starfive-visionfive2_1.8.1.bb     | 18 +++++++++++
 .../u-boot-starfive-visionfive2_2025.07.bb    | 30 +++++++++++++++++++
 wic/starfive-visionfive2.wks                  | 23 ++++++++++++++
 5 files changed, 107 insertions(+)
 create mode 100644 conf/machine/starfive-visionfive2.conf
 create mode 100644 kas/board/starfive-visionfive2.yaml
 create mode 100644 recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
 create mode 100644 wic/starfive-visionfive2.wks

diff --git a/conf/machine/starfive-visionfive2.conf b/conf/machine/starfive-visionfive2.conf
new file mode 100644
index 0000000..9f8b67d
--- /dev/null
+++ b/conf/machine/starfive-visionfive2.conf
@@ -0,0 +1,21 @@
+#
+# Copyright (c) Siemens AG, 2023-2026
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH = "riscv64"
+
+DTB_FILES = " \
+    starfive/jh7110-starfive-visionfive-2-v1.2a.dtb \
+    starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
+
+IMAGE_FSTYPES ?= "wic"
+WKS_FILE ?= "starfive-visionfive2.wks"
+IMAGER_INSTALL:wic += " \
+    u-boot-starfive-visionfive2 \
+    ${SYSTEMD_BOOTLOADER_INSTALL}"
+IMAGER_BUILD_DEPS += "u-boot-starfive-visionfive2"
+
+PREFERRED_PROVIDER_u-boot-${MACHINE} = "u-boot-starfive-visionfive2"
+
diff --git a/kas/board/starfive-visionfive2.yaml b/kas/board/starfive-visionfive2.yaml
new file mode 100644
index 0000000..406ed07
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
+machine: starfive-visionfive2
diff --git a/recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb b/recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
new file mode 100644
index 0000000..bef5b04
--- /dev/null
+++ b/recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
@@ -0,0 +1,18 @@
+#
+# Copyright (c) Siemens AG, 2023-2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit opensbi
+
+DESCRIPTION = "OpenSBI firmware for StarFive VisionFive 2"
+
+SRC_URI += "https://github.com/riscv-software-src/opensbi/archive/refs/tags/v${PV}.tar.gz;downloadfilename=opensbi-${PV}.tar.gz"
+SRC_URI[sha256sum] = "fb1ae61a85e966322101acb1c982f84d9eaafc4de7dd474a7d7546d9bb321c6f"
+
+S = "${WORKDIR}/opensbi-${PV}"
+
+OPENSBI_EXTRA_BUILDARGS = "FW_TEXT_START=0x40000000 FW_OPTIONS=0"
+OPENSBI_BIN = "fw_dynamic.bin"
+
+COMPATIBLE_MACHINE = "^(starfive-visionfive2)$"
diff --git a/recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb b/recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
new file mode 100644
index 0000000..d5c8d92
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
@@ -0,0 +1,30 @@
+#
+# Copyright (c) Siemens AG, 2023-2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit u-boot
+
+DESCRIPTION = "U-Boot for StarFive VisionFive 2"
+
+COMPATIBLE_MACHINE = "^(starfive-visionfive2)$"
+
+SRC_URI += "https://ftp.denx.de/pub/u-boot/u-boot-${PV}.tar.bz2"
+SRC_URI[sha256sum] = "0f933f6c5a426895bf306e93e6ac53c60870e4b54cda56d95211bec99e63bec7"
+
+S = "${WORKDIR}/u-boot-${PV}"
+
+DEPENDS += "opensbi-starfive-visionfive2"
+DEBIAN_BUILD_DEPENDS .= ", opensbi-starfive-visionfive2, \
+    python3-dev:native, python3-setuptools, swig, \
+    libssl-dev:${DISTRO_ARCH}, libssl-dev:native, \
+    libgnutls28-dev:${DISTRO_ARCH}, libgnutls28-dev:native"
+
+U_BOOT_CONFIG = "starfive_visionfive2_defconfig"
+U_BOOT_BIN = "all"
+U_BOOT_EXTRA_BUILDARGS = "OPENSBI=/usr/lib/opensbi/starfive-visionfive2/fw_dynamic.bin"
+
+do_prepare_build:append() {
+    echo "u-boot.itb spl/u-boot-spl.bin.normal.out /usr/lib/u-boot/${MACHINE}" > \
+        ${S}/debian/u-boot-${MACHINE}.install
+}
diff --git a/wic/starfive-visionfive2.wks b/wic/starfive-visionfive2.wks
new file mode 100644
index 0000000..4b0fd69
--- /dev/null
+++ b/wic/starfive-visionfive2.wks
@@ -0,0 +1,23 @@
+#
+# Copyright (c) Siemens AG, 2023-2026
+#
+# SPDX-License-Identifier: MIT
+
+# The partition layout is based on the VisionFive2 example image:
+# https://github.com/starfive-tech/VisionFive2/blob/JH7110_VisionFive2_devel/Makefile#L394
+# However, instead of booting via ubootenv + fit, we boot fit + efi
+#
+# When booting from the SD card, make sure that the DIP switches are set to SD card.
+# By that, the board reads the u-boot firmware from the SD instead of the internal flash.
+# This is required to boot efi with the correct device tree, which is included in the fit image.
+
+# SPL
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/starfive-visionfive2/u-boot-spl.bin.normal.out" --fixed-size 2M --part-type 2E54B353-1271-4842-806F-E436D6AF6985
+# U-Boot FIT
+part --source rawcopy --sourceparams "file=/usr/lib/u-boot/starfive-visionfive2/u-boot.itb" --fixed-size 4M --part-type BC13C2FF-59E6-4262-A352-B275FD6F7172
+# EFI - DTB comes from U-Boot, not hardcoded in loader entry
+part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --use-uuid --label efi --part-type EF00 --align 1024
+# rootfs
+part / --source rootfs --use-uuid --fstype ext4 --mkfs-extraopts "-T default" --label image --active --align 1024 --exclude-path=boot/
+
+bootloader --ptable gpt --timeout=0 --append "console=tty0 console=ttyS0,115200 earlycon rootwait"
-- 
2.43.0

