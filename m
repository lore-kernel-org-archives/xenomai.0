Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA83E1CF8
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056937; cv=fail; b=o3MqzdLbHw2DHXkoaiAsyqFUNvLO5QKbfPPylvmg2pz1Y2j1UWOiJe2b5IS+eDvbqllUVF/50pDNdfZEJbSH/2aBfobeakvqpgUD4YAKouK9TMncNDrmnwjcMxrxo0VJaCgR9KznACIQBSk+vVEGPP3fT/mCZVmJu1FOoEEBvSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056937; c=relaxed/simple;
	bh=yVc5mKeOpt/QqXu+0F8/xhJN7Hm/AP3gEGqou9llOwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JU7eATH4Uv6Z9H+KSGOOWM86oALfMxqXp0D9l6DFzLOxloLGOxkp5isL4gYYbo8D5R/F+mun3QnXFdlTqb+QUXy+GaOawIEa+nZ8Qz46ZmLMtJ3790bNZ9Vfvwql/JWLfRz4jhevGJ0MlPpS8mghuLFOJqSumQJYUIK3zsiUMsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IWFdfQf9; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IWFdfQf9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/bfHehc6AmWRR8rPCKW1Mw7t+BKRTnOduUhC+d8nWGPrOqAs9PCNJLdrcvLtRgIpel7TZF9RTlzfEo+m4yeKZ/FvLtfDFmP+EfFsouTVuuZBiKj7IC7E/LPLudGHN9krayfOkokm3nEV744nZcTbAFGzuXYom9962vcwAs4e4KBe/gk/xYmcaTcxgWS3fnhaSyhuUezWMEzxtRPI4nBcrNc0On4OZAFN3n9VxFS1IMQ0oGhHfHSjCfz+lQ2vKxxYJZb9ZgWEVs2PC7qVKSHlAISOsohQsNqfIRfgsEoEReA39gPqZdzqV7MpUgmhNm30HWw0ItgP7jpHN8Su0uLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcfNdky5dErunL0bm6zsan2b/fqdSCshSVdeN0XfmT8=;
 b=Ngq2y7jTIqekO3cJFb51MM7/aUb5NwJKCUtJhqXZ0DD2RppSo7nMjhWDwYmtj8YqEiMGPD9VoCRwU8+7H3PaCpyVMVsJvtSYKC4Dc57q30PTVfks7fPQVRwvMhbbQn/FnubiqLLwDu+Zruv4sc86dE1ru4dqR1tOa+4MnwLxq+NNepNDzGW4q0oc99/JsEewV+E3SjAtiah28WD1Mn/xNRBCRMct5RfHd2uDee/RgkfaZTMcG7tL1tZu++64VTAQe1nAwmiVy16JRIfmobJk+9nQ/8HYZV+eJK7WhTjgQ2la+/+UjNYHIAahKUyXmNQsKeAJ+GOnlnNovx+uLd2xoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcfNdky5dErunL0bm6zsan2b/fqdSCshSVdeN0XfmT8=;
 b=IWFdfQf9LBcgfDxsgM1rsZMyEZUS9F1IjGizZvrmXIr+U+4q7C3AmRaTLwkLmSIWg73Z6SGT5RuM0af2z8x1kzrCkMATIEINkmQ7evnA4CbI5jGBVG50uOsF1pY1aunuiJBy7k/hL6S7IeD0qLtdlLC9fkjNq+t1ZMK7YnhL08Xz9gzHcz7zSXuoOSDgAFRlMeqK+alTV10iU11JOrlgSwOkFKjgN7pbgHghJWOxsm82kxkko0l5oZj195l7Io3Aa2eTxSfTnIIyCDlQYNiklKhOUyLPEhpOdKZhGTqWhCcIYEzpfJjpBNmipEN8bqXMoOsDOwYQkwGepj7C0o1mIQ==
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
Subject: [PATCH xenomai-images v4 2/3] riscv: Add StarFive VisionFive2 board support
Date: Wed,  6 May 2026 10:41:41 +0200
Message-ID: <20260506084142.190854-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8281845e-cd81-4ec4-ca18-08deab4b5c9f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|22082099003|18002099003|10063799003|12006099003;
X-Microsoft-Antispam-Message-Info:
	24x02mgkAkQCQFgkTNVAaMk/K+5yp0H9lOnnirkbAVMEwlR0wsLNKFFtcdffWDgwuus0Gmp2uK0CByRP0wWHAiKnZbwD24bbugUzM58I3WIvxPmWQyCAlwY+zJ5lScIQWH5/tsS/ADy0aXpZ/8RKHWWrJGIpAcMA30xWtaqBZ4jl9hnPxTNho2NvizIi82BBk3/5900NB28PU6Kju37jO6o31fx4LyciaHZJ6j948W7JnkZYJXtID7b6AAsX0jEaFgW7U6h+59OagyfJ2Qm3vphMaTjf90n5HKQ6FgtsE3NdLxTDB35IRx+8CfLmQy/Bus26JC8bUZ4umEoIthbBDtTPynR03tDrwu2FZU0jdmGoAMWrkvRulUyrrLmo9WKnsp9XM2hEqFzdBE9cAixsI3TUMjhmhCMWKv9gtW3MLT0xrFZsentq5gYUR5yCzmPjbnDZcfg6HmZO7k5wYQhlm9hiblIZfV4yI4x5Iqn+PUp5fTapu4XYgiQSxM4LkeLdgmAgpngWG9NBy7lRij3HOWrDxN7/iN/Y6VrGLcToGMKhQD07dikx1PXfTPIRqz+Lt3FrESts0zADwktdi8LthFbG/yeVaF2pS+jq4KeOpxVVhfqUXbpCaybUXGu3xLzo38dXoit2wumwpQHC94XpRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(22082099003)(18002099003)(10063799003)(12006099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BtcIyU728DELXunQQXrRT3k8/z0c5Fi7RcgT0LuW2tnjQgeyWKBZzCr892kM?=
 =?us-ascii?Q?qJuaPasiDjpQeJVQhgIr6kf5W4bwU+I47ADG+/x62wicaSP1lT4ki1UWjzBn?=
 =?us-ascii?Q?n/96u5FEK6JLEpL0k73kzL60vNuPnhC7VteuCpegcW9HHHz35G74/aNCeg5h?=
 =?us-ascii?Q?vz0ld7TeWWUyU/1izRwYq2qkibYOfRXyBo9rJkrIZ/PSmpH0HMd6LObJB3CS?=
 =?us-ascii?Q?uMAUDkm2yzFm9FaVNl8dcP/7V4VLsha7vAuKoazyfGzZDaMtBVECtUYhw+vI?=
 =?us-ascii?Q?YCDAV+lJI/6jFrEa0CRX4pGyQjgtdCBAkqvM4Fs7hoc8MwaJ3t0ed8wlRgvA?=
 =?us-ascii?Q?OKsknktCGYeXPl8qMKu++PkTDxzHhOhz/xZu+teRusC+9IVpp807pbTe+Zs1?=
 =?us-ascii?Q?dix2INuwdvdXiYyuzdzMLigCSZ9td69qCIo3R7Ng5TzXeE0Y2IWUyxZ+2nkN?=
 =?us-ascii?Q?bky/mQaWexOq2/7xKc99hDNZmFKD9GMQfyn8KtQUj87JHh6pttSfpPCdRQDX?=
 =?us-ascii?Q?7KZsEX6lkLIM+eY+fH9ERtPfai3S0x28kPtLqH89IipQbIR+1rM9LqlfzZCQ?=
 =?us-ascii?Q?eHrDeQ6opcB6cLuMQPchVoBjYmZ5gT1yfeGPpHuEppWWSCA4nTVhG+S2R/Ym?=
 =?us-ascii?Q?UJSgrM4ZzaICadsGSj76cFXDCF/R/GMGBkhDAebZtQatgq54zGVkQLEnPNhM?=
 =?us-ascii?Q?DNQ66GOM/ZNI9EYiGsBhPLl1kOWhbPRRSPRd6NcYHntjs3Em2iqzmoR5vSuL?=
 =?us-ascii?Q?w8ILNKrS2dVWvEW56Qc49ZtU1eqFa+waOMtdLXD63slnwtyStH5jx4h+QFUl?=
 =?us-ascii?Q?dthKR/+E9Zb/NJo5QalIq9gGpheEUnsrr00KyRn7k462jSLTn08PjLjBWALC?=
 =?us-ascii?Q?Y9w45xRDaLVtQWkN2juWmQtAJoDsGFoEEalmj9BZez8FBTABuZZXcc5KpWTA?=
 =?us-ascii?Q?KuIhX9KQnCCaNdnmvezR46Wl4cn9P2hFnNC9eEtDwOqe7jdIOVB2I5AoLk0Z?=
 =?us-ascii?Q?LmS1qmGDY5CIyFyjQe6ety3hJtiuFzXWUZXAFAmsGJSZafrhybP4DOkdpsOy?=
 =?us-ascii?Q?7tvs2WFuOnMD08XmRsnlnmJcysThWWzcPpWvbZrwcC2TrByxVamWS9L+CznG?=
 =?us-ascii?Q?KAzG+NAGbLCbHWjWqYWQLqdo2TUf9unZAk6lyRzMhZ/JkG4+fok5DGkdgChc?=
 =?us-ascii?Q?po8/WuQGncsbKwLlgY71bF0j3a4ld2XcTprIaut+6xuG+GuB5JDMJkKGpzvZ?=
 =?us-ascii?Q?CIOE2VNdV6Riyen2jv/y4DIvW0Lk+2nLpXknxiC15IUsUFGCOUVjGUg/6R2S?=
 =?us-ascii?Q?SGYzFj0etog9/SgVnQy3PK8fAmWODI+O/cPnDRiDYM24hHoPLXxGyFBfe9k5?=
 =?us-ascii?Q?mcwPERG7GQGOur/1DwPQ5hlKt5drxwklRa43zAju2jG8XfsJQ+FUJdv+XgbO?=
 =?us-ascii?Q?W6Fh4OedRcxvGMqseR0fyZjlUdRlStkP+/33JYrOsr7sXm7dNP6qOdhFj6w+?=
 =?us-ascii?Q?phZJmT8IEJV0n3lzHnbEURIXxvV30RLHCNFIAGcLBAW7Q6x6vx3raC+q9ezE?=
 =?us-ascii?Q?nSvqMW4BH1fNHTf/U974I9M5r+7X32tMxkgnp8J+O9xVz60g30AkPGm2xHd3?=
 =?us-ascii?Q?2U0n0xDRLtz0nxY6+zjYmUyHNFCLoLYJI4WCfrNJgzDYYj5TghGLJq6R4JgW?=
 =?us-ascii?Q?n0Eghp4eVC6nAjJRRQwJ2RzwfpYDjJgHWd23rxZzXoZIAbYHVA3c0BatB+Gr?=
 =?us-ascii?Q?vn3wBaDu45Lke4rDk+DbsS/5p+q2gJ8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8281845e-cd81-4ec4-ca18-08deab4b5c9f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 08:42:09.9797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMV5A+kr10fTmzhkQl4y9yKKga9iNS8xfTvuNPY1g3TjgLLYmR+ze3/ttfgTDSlZO+5QC2zziUWL4nOjnfjHPA5GfBJLhPGV0HFP/95/6lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4070

Add machine config, U-Boot, OpenSBI, and WIC layout for StarFive
VisionFive2 RISC-V board.

Use the latest openSBI version 1.8.1 but stick to u-boot 2025.07 which
is unfortunately the last version that supports booting from SD-Card.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 Kconfig                                       |  5 +++
 conf/machine/starfive-visionfive2.conf        | 21 +++++++++++++
 kas/board/starfive-visionfive2.yaml           | 15 +++++++++
 .../opensbi-starfive-visionfive2_1.8.1.bb     | 19 ++++++++++++
 .../u-boot-starfive-visionfive2_2025.07.bb    | 31 +++++++++++++++++++
 wic/starfive-visionfive2.wks                  | 23 ++++++++++++++
 6 files changed, 114 insertions(+)
 create mode 100644 conf/machine/starfive-visionfive2.conf
 create mode 100644 kas/board/starfive-visionfive2.yaml
 create mode 100644 recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
 create mode 100644 recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
 create mode 100644 wic/starfive-visionfive2.wks

diff --git a/Kconfig b/Kconfig
index 93958b2..c58e206 100644
--- a/Kconfig
+++ b/Kconfig
@@ -56,6 +56,10 @@ config TARGET_RPI4
 	bool "Raspberry Pi 4"
 	select ARCH_ARM64
 
+config TARGET_STARFIVE_VISIONFIVE2
+	bool "StarFive VisionFive2"
+	select ARCH_RISCV64
+
 endchoice
 
 config KAS_INCLUDE_TARGET
@@ -68,6 +72,7 @@ config KAS_INCLUDE_TARGET
 	default "kas/board/qemu-riscv64.yaml" if TARGET_QEMU_RISCV64
 	default "kas/board/hikey.yaml" if TARGET_HIKEY
 	default "kas/board/rpi4.yaml" if TARGET_RPI4
+	default "kas/board/starfive-visionfive2.yaml" if TARGET_STARFIVE_VISIONFIVE2
 
 choice
 	prompt "Xenomai version"
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
index 0000000..13f4ae5
--- /dev/null
+++ b/recipes-bsp/opensbi/opensbi-starfive-visionfive2_1.8.1.bb
@@ -0,0 +1,19 @@
+#
+# Copyright (c) Siemens AG, 2023-2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit opensbi
+
+MAINTAINER = "Tobias Schaffner <tobias.schaffner@siemens.com>"
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
index 0000000..199932a
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-starfive-visionfive2_2025.07.bb
@@ -0,0 +1,31 @@
+#
+# Copyright (c) Siemens AG, 2023-2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit u-boot
+
+MAINTAINER = "Tobias Schaffner <tobias.schaffner@siemens.com>"
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

