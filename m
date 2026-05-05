Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5E3D5649
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972009; cv=fail; b=tEK1cfn7OXThHmupSIxTaHc5yk7iu9T6HviobrVsc29q3snGVkkmUDmc1RDeRMfw6rG4w3BkbERTuxuUBygovpZGUjc9hE4w/SGKnYF2q/WED7ZqRjkV5Pon/4hiCij4u0HFj7zTaaCeeN1bwPHj+sRso51xrNItJk6CNKYnyPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972009; c=relaxed/simple;
	bh=3x4MrHmfx9wgVsPbsf8UGBgQXj49Gm46dKHVA8ontw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GdFHLUvHWdF9lZADpe3JsRUxgtbGlKYsoxKOJTvaxLpCCWFAyvgLd8Si/0pxR0xOvCIzASVbv5PizbFbvl5R2h0tngLiNci0oTBR8TtAgVm9zvl/PqagYS/4YRsQWk2oPmQPpkdHAR5DrpT/3DUtuf6VMhMOAW6uJPlQ3d9OYS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=N2ZpANeO; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="N2ZpANeO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRDoJ/7bNpP1Rnv2CqAAcDGzwJ1mstv2rxMu3A4ssh/J3DYfPg0fl5Q3irsOlRARlt00FFPwoCWZv/5ABqKxOFsMKT+My7jN6MYrGZuKGQmqIpn+Yy2otnxmqvNCU/lg0tC6hXX1988TNn/nXNH6XYuoQ8/82NF9YcAZzu9Fo1nZW11hzCXOUIoYb/m+ubBOimdtGqlbhoPrrhyEY7az4DQXZxXcw99N1l3s3oLY69tMx4qYy6BGem31+uUmU8Nmdbo6cCw+WvthD7RliY7tXJegNUjVP9B/FPYCzUj6HyTSvL99TeBNt0jf/lFtiVp8ZmS9YNuqJ4xHgCrY83ZAug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwxU5pQcSueua4p6z/GZ1EJNqkZ2K+XemZP+ZF02hgI=;
 b=bjQV9hVr7ELUTobm/cycl9R4+WWc4X+a78quVUZc3gjjOXvKutsRfKE20Jq9/XhqErjRbYzKn4zgSqE+g5KR7eF3fDc0q8b05qwksjxg4+xi6+qajXZLrQyQwFEc9mNE3A9sFph/DD23nxNfDoysPsldA17EtyoAjIM1bBXC/S0KeKuqVKE6j3VQDjvXIV96bNSq92OUFxGgEHbwu3llCG+5XrcTJr4XmTHz6UKedKKmTGGW/vHUCIamf+6THXh+dUcglrgNzr7HysCLOvvxAKc3+J2TmpV+iDWFrOWeYXnZPmbBAWXisFTDucsv5QMxpy8yImWy0E8SwUlyGzal4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwxU5pQcSueua4p6z/GZ1EJNqkZ2K+XemZP+ZF02hgI=;
 b=N2ZpANeOZfKlEHUi5NHhd7NjxBD26ay9+Cn4xPnPXrjVCdrQX6ohB1dmS6K4wrTqfqIUxbBB1VsXHPcXEyfYcfrdTQ/6oCx58wFmGds9Zr1Eb3c9B+QJB50SGS4rfd/keVQeVWIuL/8DWBhTQkyEcc0qzZIj71A5vuYDPbcyd384twsImcPIpIihBtGgXUZOaoCap2kBMFTP6f8ApYIlYmnKpoqnzCaT4P34TzV6Lr3ZiYVFLjBimKPONEqOoSNLGqX2XmAB8tnfXBhSjdSfAK5JsxegMNCHu4QobEw3IT1GYxqZxqXTfUCQzOduhb1jg5l1KRyME1rRBKWjaAcY2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB8PR10MB3942.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:06:46 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:06:46 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v2 3/4] riscv: Add StarFive VisionFive2 board support
Date: Tue,  5 May 2026 11:06:26 +0200
Message-ID: <20260505090627.65515-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21524198-dd63-4f4a-2608-08deaa85a201
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|55112099003|56012099003|12006099003|22082099003|18002099003|10063799003;
X-Microsoft-Antispam-Message-Info:
	wp8e8XsOOOYOi3Rk262HXlLDB6E9B8qziVBvJAVvucXSFt+ZayLJlcJOFR0IROsgAulYjEgsZvh4c+ufk2I3i2w7BTneNQoygl52Eo+gZpvL32keo7eZgB422oUG5fBMM2F8RehQ9A5oMw2VmRd0ohUU3sudrfr2urIrcAgtcHiH7Y2tuFwSWezKX3Ei6Q63dUEyHCnjnoME/qhO7hEKEh20Xk9J+hOLZkbzDK7XWgPLD56Z8YDfgZagW0RDPkqTI+ug+ELsWyinXOlL6U8z7tL/nKaXfqg7Veq8R97YcGVOTMdKleSeJ1qwHHM6YQItMr/B6wuA6VCGVV19m/DyzL4G/AiW9B2Ql67BRG9q5rCs8IBjRiNsC66hqw4SvxSxP4qy7MGc4HqTQSe4Gzq+9SRUQvsntdf87YkW7oq/DQ5MrNA58dVEyx+daiszRUdQ5oTTUFfd9VCknwV2P9stoFKAChKB5KUdH7/X3cHA+qC7ol4f2Bw943Zn5D+xEtM6EjkfWi/YHkKkLmP/H/zhgQpdCUKukOxV6DifGuegP9igyXqwjyexN8y9YhFzMm8E3udEc+ykckZ2F9Y804l2krdNXKW4KM14aVkiVxsabxZzOGF3Bn28wazF2oTKtJRbZt0ubTI4b2mhBhWIR3/a/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(12006099003)(22082099003)(18002099003)(10063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5v/Ym32mtJjtXPmnFAIGKRB4/TgOcPCi2hEQOHnkNYgM+MoB53sB3HIIVWkA?=
 =?us-ascii?Q?A4nS6vrX4VOj8qmac3iQfpLCPoevA5UFWLLArjHOMxu65yb4qAQ0GRk1KXAo?=
 =?us-ascii?Q?U+z7OO/afouCbvNHZeEkYD2AW0fF+la72yiae5/Luq/DUHwWuLX3fXUOSc+H?=
 =?us-ascii?Q?XZfTMaXSWIp3XHgcv9j0Z1BvymEKDLI9V2u7pNVuVXkeGBCj9gDbBpWrFtau?=
 =?us-ascii?Q?mp/ESlkwyTkHfUPdztpbzKkaqDKaK3d/mLh5Hy3PPU06n/XONcZDdvampVQ+?=
 =?us-ascii?Q?2ceaYH1bdN2d0URZoyqds0CLn644IMS+XUU5HIK7xJuh/xQE0mC3Wp9Pb5MW?=
 =?us-ascii?Q?8L1S4vSdsjM0pHdpm5PDJzztVQaclzCzgvQD5/2oQ+sqQ7MMD93eRIa7QzqI?=
 =?us-ascii?Q?o4FsEZlfn/E9+ai14ASNMZqTMX9+m/ValOIp5zI4h0jt2XhHyNUYjR6VgBSM?=
 =?us-ascii?Q?heVV94CXhloXBfUpcMhvkfwG2UmNIhRN61ZXQLzgQIS0Krn4CQY+gMsXfFgh?=
 =?us-ascii?Q?951/rhnfflRSo4AxBEP24BXeR3asXa4VAePsPwbGhp9HNYHipSEq4fqbcMR0?=
 =?us-ascii?Q?OmvU7sdg9066aHYkJ8w9MBUC/bP6nvf5/zHXc3z0sy3UbTbnc6I2QS+Qlvj1?=
 =?us-ascii?Q?fn3jI7Swm0p/Bv1QFwDo0VTvnFZCWLjVfw61sEljyfCQ89VYs1XESt2A7Lhr?=
 =?us-ascii?Q?SRlaunKydqpkzV68vaE7l9TGi0V1l4lZ2LEXTfWOU18x/HQqOmnRjOMTzRYA?=
 =?us-ascii?Q?guuRhmT3ox8YNMhIyFtjJiuy55Qou90UXSwsYJWVEHGIh4wMsvaG2to/0+vm?=
 =?us-ascii?Q?GXP1+kKuj+cguwAyAndl/Su1QWzCfxC1a4/+KH4lwE41ECS9W0Ax4uThtcrI?=
 =?us-ascii?Q?zNjAWSykeCHdp32+bACN7fSfMol27izry7qxKRhzMfwEBGGhXmh50b2PaqH6?=
 =?us-ascii?Q?YfTVd8xBBwl18nW6oeuegFiZFvbFMIa2y/uo4CnIoGbXX672SNQA58GX7WRs?=
 =?us-ascii?Q?xJEnzS3b6jZ7J7ZjH6k6bb8fp5CnNENMpOWa2uIztqWL1/ljGgZW/7cG4GtV?=
 =?us-ascii?Q?9ghPNdNjnYTQLe4sthOSXcuxq2Lay106ZaJNZKzZYIPQYbqT9hhkjyMqvbhv?=
 =?us-ascii?Q?7pi5AJgmRh8N85XI0ikOkpID4Fn2HgwMULsz5RT2SlebnG94oDyybjCam8lo?=
 =?us-ascii?Q?hQhph88yyNXFxYAdtOOwht2HVbyvKlVPz8NHc5dgdwTdFBR73czw1Bx+pu1N?=
 =?us-ascii?Q?LlGCZ8PhsKgK4sHEwPIC+hMKqyb8MLlF0w13PRkIq2kHqsz44NtzXymIN3wx?=
 =?us-ascii?Q?hgwSaZb1saXIyPgE07xaMlYHtM0DXXOb1A2xwNCc2AJxbNpemRYh5kRQ4iYc?=
 =?us-ascii?Q?PUdpiBViWk6izQl/Ou77HGIraN6nvOSuB60fuDX0xSTFwAmMxFZXGBGs3tsN?=
 =?us-ascii?Q?DdrKcIO/M48geZx7h2KahrukDt0hyPlQUw7M8Oo9cslwl8fgk2AGHdwXa413?=
 =?us-ascii?Q?jAivhGnP35n4lEgTNpIMtQFjh0zekf07Xx6d+Z9+WsXNFhzgfPqCt0iXm1U0?=
 =?us-ascii?Q?rlOSPek+sMCbDXS7FOBEyNvCRHSzD0ORsUyhpVfM7DN3a+y6Xk/LzLahUR11?=
 =?us-ascii?Q?DeelTlnj2qazsHZeNJ+4i+nPe5QNiotzolGwn0TAYu7mz5ChBjuOWUQDPtwK?=
 =?us-ascii?Q?19rty1ZzIWE+BU6CnyD5bJN+BWuU3Uu8WDmcjDfvIIM9MNWHm1nMWLaezOni?=
 =?us-ascii?Q?1GbDMiVKAKdEJU+sB+AUHrDTsOxasok=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21524198-dd63-4f4a-2608-08deaa85a201
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:06:46.1355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TH+bFy88jqIZ2TaVrcoTLXry9rPzCqCQfbHUsB51RS35HbBh2Ox/aTY72jOFN2O+VvdZnL4H0jSZbfqMkcfa5jOQRW4o8YsCCYJ4N/hZd+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3942

Add machine config, U-Boot 2025.07, OpenSBI 1.8.1, and WIC layout for
StarFive VisionFive2 RISC-V board.

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

