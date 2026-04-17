Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63493264C0
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459455; cv=fail; b=DBwPHX/0+IzAu9WYm4vCIBQo+mwbKXw9CmRG9qC3AjsN9ss5zGz6An7vrMyvj4mEyK6l6BmBlWEHi4FWRejnJmhHgs13KOb4+crsQil5py0UJUcCtmiHtaSaBLm79HFHFoE7qTRieADKR4NkjVBYIo38oJ0n5LsMtl7FJmdud1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459455; c=relaxed/simple;
	bh=DsQB3UDZKDJCzeJJ30YNVppngKkdDb9yRSe+AL6Y1YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWgqki94/TbDu4kp3BSKdUPnfkHG/37O/SzrxYlqU1escy29RTv02iOSFdvULYmKMMLstwHZzZdSiFceHcZZl8zj5tEqrmMgMPfWJqpJGoVs7My5Z8KtKA7FhecXnU/Y5/AXaCRSPHlnWw/5krpadv+clEv7ACWUXf+p75ZIOVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=f1vsZpcy; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="f1vsZpcy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdVFCyovezcgw+dXWURcY0R3UkPyxLcf5dzQPJHoHFlRLaTOQ90mc+Pa/2WA4vf3+UmyoBu3dvCGLbGixFYoKhMXVJ+x97mdyr9xZceNEBT7tJpikm3hj+3bS1vUZuT7G++JauMqHyqrBG1xIHzrHoSVwsDnBHzHWZgPq8EoBa/MUPYn0gfn8ZPXt4Lv1mU/rzGkeH6sYbOVKipwwDWkzr0JMuljOSNCTFFA3YUE8n/SXmlG4gEa26X/PDAuRD3DO4C8i7k0AfGUgLIfrKHE1L3xUSkFgybzDIBOuGZk3l9WtBzsZPNpInkXht63zwbFXPYCLiLLSZT38u1WIUSlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYX3b0KC6SeJ1Aj/gXYooFt36mtTgIBKc2GmI6/cl/A=;
 b=D2JY1vzsx6VvRm5I2UcYH99ek30C0FkqJ1riMHsiDDmUi4DDEfR3WClHYUGTfbLn72VVi9KqckN/NtVaAEyIM4OW75YReMGCOgAglojtjWZ8bo9pH1Y8pM6bOTCUzEc/6mbAjCNFOSp+yGahoCC/vFpJKDZ0c1UkUCrQFUjnvfI7yDl6u6cUv3uktil1z4y4yGK93p9oy3erE36VKW6N01ANXULParcJBC+p227aGW2XMLWXcSE5891hc23WBfa4rVR8+43gl2K81vDL6hNWLN3Woaw7Pvt42M1DS8lDlPMs+qmyBgmufEsIAsDuzce4Ie27Umo1IYxD2esOpBmQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYX3b0KC6SeJ1Aj/gXYooFt36mtTgIBKc2GmI6/cl/A=;
 b=f1vsZpcy3rNztwCSQvh1E1y7X3gQWcmSkVp+LjZrw7CNNlbE2OL7YLYAF/vXGgK1Rj4Q1OmrUmrmeFCS7WKIhOPRFbm6R7u/Dtomzfz6TQh7jEALFhFtcXbOGKeeKbztGlaxai66HzZh+Yo1ZYlAVggtyIk1cKguvNZnFePNUET+a9tfUbc/eIJOXDFVhonZ2T7VZwuHMB3tIsx6jsmPiTBuiRHgLkSY4gXPq85e+oPbP47LsBTPQroTvP7M45BNDKYaHVqE9bnX7MEhqPV47gnurGf0ulYQkOjOG1eDggkgTLR+UDdUI8vaobAb9FpRk3sXMV75VYWiyUF8EMWHMQ==
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
 20:57:25 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH RFC xenomai-images 4/5] recipes-kernel: Move nfs boot configs to own snippet
Date: Fri, 17 Apr 2026 22:57:04 +0200
Message-ID: <20260417205713.2290350-5-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1258cd77-6a6f-4f62-2fe7-08de9cc3ed85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	g+HM9GFhPuAYUdGiz4518tQa5kXEGdGM3Uc/WZ9xj3/9IF79Eh+VmPu2lNnY0iQMg+9zID5W/ZyEy1AQoq+xa3SO5HEUlSwEJ21sVn9+OXRDr2gO+ZGtMVKJWp7GrIddp9M1wKA0gOqR5uFtbf/v3ErwdHbA3cTg1ncRKi5BH4xuhAFqjrFkYYdN7u2yIfJr/OEkA48QTSuT16mzxjbao5mDjP0ET6CKqcAf3gDO25gODE/iafwHPv6jFCPgHUDMUBD8yEExXu3K6dmoSuL9wvOkOCI0lO8co/+0B21+jZiigOB9CPSW1ni80XunmW06NgmnHFYJLg4TcbI1UEnVyPnr4bPqEaKo2V4HfiBOtTWH8Udzga0h4G6T7Kys8h3bD9XyjbqvVMckwZQcWwq2SqLUN4S7hX+Ok2l8OhFOLY3kyuLQQwUVvJNIdqPqw2OVbAIXA69aytIaQ1AmgNWEegHKaHhDyYcns032D/LsEqmNWOViy1+Bova1P9s+9n+IZRHuDugF7XAhAmo2lPutbnSTZNmerbRS+mT4+gRtwU4xE8wYYhxRVbYxiFYtOES+BdX+KDpM604Wd+Z6fLX1edBMYMAfLajFFGV+In6CJrp0wTAgUL8sbGsBp2bTjd4nj7Jnkz2uSh4JzfBWZGiIYD/QwNH8VvWSzakTAQSnjI30srnhj7Nlhn3LsN1C6EousIKNvDxesqXO09Yx50TMFyXR3Fh2pLM0sdLU/qxQEUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nA+yNOruT2LuAHF+DQHtxtlLLs7YGejyJbNIgE9VxovAqvl8789Az37yqto6?=
 =?us-ascii?Q?6wNx+dg+Ihx/lE77mNH1Wedboi/Lk9qbzedPRAwoWMk7FhMFHF1V3d3/w0wt?=
 =?us-ascii?Q?OoUdilw5oS5IduzZo74UnnbCjkzFT/5e3fO2lk/DnE5gfAiO9+eZHGHqZgB/?=
 =?us-ascii?Q?SkJl9ugyObrV6i9UNFk5aqv831vVbZY5kjip0tFfVEAvL7frNoIWSaBf9QXE?=
 =?us-ascii?Q?G9tc+5NIznTDTu1RZR18koTSTmbM5Z2hwv5uNyDM4JtpcJ78sx3xP55ealll?=
 =?us-ascii?Q?lkxogeh+SV02WP/bZVUTdvDVLpVa0utDG9NCZSZVuT/PDeEJTZoZTiKq9350?=
 =?us-ascii?Q?boKOPg0s0Yvn5x0pLtRcRN1cqYeRsKmJm4NfrDZDQH25Eq7IzTryTB8oejwX?=
 =?us-ascii?Q?bAsV+/Cd/RomGxniSndhqwc2/3I3W0ic4qmoIeno7Q8VJvGtLCTqwaRO0Rxh?=
 =?us-ascii?Q?aCytZrmMRbrVRsjV1Q9+9xki1n14jBxXg6FqpqtgSb6GxvYmZUgqqQYiwIJs?=
 =?us-ascii?Q?IqloskMF42MUlRSLqjS4Xs0eDDcm26hhCA1X6DxYruDh/pHwchZhBS7DGJJO?=
 =?us-ascii?Q?mDMU8SX9Wiwb11lYmMJjmdgv2n7MjQ0HrMohHJgmUsxYiox+XLAFYBgVSLPo?=
 =?us-ascii?Q?aECg2xWSL+NUCkyDV025A1CzRDBOTB6rdk4Su7fp4fuppHoP8s9uL/LAa7xX?=
 =?us-ascii?Q?E5K8GgMFPduJNSGR80jIic5W65AW2ZcfRNAHFaH8DcuQMhCz+3do45qx5Tc8?=
 =?us-ascii?Q?u2xAauV/VywcfGvUh97SD7jgRAiDq/UVxz/DKGNrGwxRDx0gUW9NcwZjN1KS?=
 =?us-ascii?Q?F5nw4ZdyXgs+CSSBLIo4bxo6f5fbGS6AcHkgZk+5UTH1KjyPEF9tRAB7s8f0?=
 =?us-ascii?Q?fHz+mV4TqfhyBZy66stVbvMstC3JIsaFL9LLGM9GgXhMnNyBk6uHtJDztE/k?=
 =?us-ascii?Q?twDfumLAwhPP1XvMWBsDwDGoD5ALM9sDl5k9uc0K2NwxOZZaOoFqWA29KvaG?=
 =?us-ascii?Q?AJntAziArkNEgfxG+58UtVMXeEcorGzRB9twcJNWv4yPatzu11m/4fg8rfdf?=
 =?us-ascii?Q?qPtjbckWM6SpcLcZSCub1MWuEVvm2QHdaJPE9wbP31MWzaVZvkpHGgT3i9GK?=
 =?us-ascii?Q?HouvUKdgE/rccqEiqRONnZ27rXPoMLc/EscthBsLTTO13s5gtkcKAYsn8hBe?=
 =?us-ascii?Q?DbMJcY057iUU/piwajkKupnuwxFvqP1NYI56DFjaxzdqYzJi+ZNkapfUuay6?=
 =?us-ascii?Q?sEvGyr4bzaKQncGyPZXF9lRkjO01XNq0WNWj23E/T4ZdDmFTjQTUPQevI4xH?=
 =?us-ascii?Q?X3fzNDQwGoOCGr5JiV+7yjfGmAcsBipQ3VH/vK7/tb/0hytFFqVurLAlpt8D?=
 =?us-ascii?Q?SCAwopl7OnWZhrFOWWa9IW46qQu9bmKQNawDjkWjZa8nw9vwf2Gq9fOQKdNa?=
 =?us-ascii?Q?XYFJfyk6kNZI8Ts6kk2m81njkpMCkWtfzOdPFedarrfsqxG6e4PEakxJuZVx?=
 =?us-ascii?Q?mVSBnjbmXqtZE0ykbphw1gHi4FqQnOU5vCxzw7ykToG2NSYY8FxGJsRiGVNu?=
 =?us-ascii?Q?r2XVUtFfnZYZWWb0K1cvjBNki/sKTD1yr88O/wcEtKBtZUd2zSVnsvMWkgNM?=
 =?us-ascii?Q?tzvbCfpSIPEKzbnHPocBE9hF+92E8dcwp5SYqe2qANKyFn17K04dXGbMdVg9?=
 =?us-ascii?Q?3NsIMGOtzQKVg1tZn/o5HUSgQMoZGqwLt62YLRMugf0+nrKYObGTiJor3TTb?=
 =?us-ascii?Q?W+Lk1svPB5T0+dghSPtDyFa1xEOXzEk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1258cd77-6a6f-4f62-2fe7-08de9cc3ed85
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:57:25.2132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4WrFochxcLIqiNC79tvla1gCZouHKfi4y+mBpjaEi9cXXxDlXlvPwq0qhNBuNy349pxSZaIetPLePVOdZc0R7QEKpyDb/NvULCWr2Lan9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

Move the kernel config switches that are needed for nfs boot to its own
snippet. This way they do not have to be maintained individually and are
also enabled for riscv.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-kernel/linux/files/amd64_defconfig | 6 ------
 recipes-kernel/linux/files/arm64_defconfig | 6 ------
 recipes-kernel/linux/files/armhf_defconfig | 6 ------
 recipes-kernel/linux/files/nfs.cfg         | 6 ++++++
 recipes-kernel/linux/linux-xenomai.inc     | 1 +
 5 files changed, 7 insertions(+), 18 deletions(-)
 create mode 100644 recipes-kernel/linux/files/nfs.cfg

diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
index 590a1d5..d46064e 100644
--- a/recipes-kernel/linux/files/amd64_defconfig
+++ b/recipes-kernel/linux/files/amd64_defconfig
@@ -1040,8 +1040,6 @@ CONFIG_IP_ADVANCED_ROUTER=y
 CONFIG_IP_MULTIPLE_TABLES=y
 CONFIG_IP_ROUTE_MULTIPATH=y
 CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
@@ -3664,14 +3662,10 @@ CONFIG_PSTORE_ZLIB_COMPRESS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
-CONFIG_NFS_FS=y
 CONFIG_NFS_V2=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
-CONFIG_ROOT_NFS=y
 CONFIG_NFS_ACL_SUPPORT=y
 CONFIG_NFS_COMMON=y
 # CONFIG_NFSD is not set
diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
index 1dc8b69..84802a3 100644
--- a/recipes-kernel/linux/files/arm64_defconfig
+++ b/recipes-kernel/linux/files/arm64_defconfig
@@ -981,8 +981,6 @@ CONFIG_XFRM=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
@@ -5768,11 +5766,8 @@ CONFIG_PSTORE_ZLIB_COMPRESS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
-CONFIG_NFS_FS=y
 CONFIG_NFS_V2=y
-CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
-CONFIG_NFS_V4=y
 # CONFIG_NFS_SWAP is not set
 CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
@@ -5781,7 +5776,6 @@ CONFIG_PNFS_FLEXFILE_LAYOUT=m
 CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
 # CONFIG_NFS_V4_1_MIGRATION is not set
 CONFIG_NFS_V4_SECURITY_LABEL=y
-CONFIG_ROOT_NFS=y
 # CONFIG_NFS_USE_LEGACY_DNS is not set
 CONFIG_NFS_USE_KERNEL_DNS=y
 # CONFIG_NFSD is not set
diff --git a/recipes-kernel/linux/files/armhf_defconfig b/recipes-kernel/linux/files/armhf_defconfig
index ff8908d..c8b46e1 100644
--- a/recipes-kernel/linux/files/armhf_defconfig
+++ b/recipes-kernel/linux/files/armhf_defconfig
@@ -1250,8 +1250,6 @@ CONFIG_XFRM_IPCOMP=m
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
 # CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
 # CONFIG_NET_IPIP is not set
@@ -6723,14 +6721,10 @@ CONFIG_PSTORE_RAM=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
 CONFIG_NETWORK_FILESYSTEMS=y
-CONFIG_NFS_FS=y
 CONFIG_NFS_V2=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
 # CONFIG_NFS_SWAP is not set
 # CONFIG_NFS_V4_1 is not set
-CONFIG_ROOT_NFS=y
 # CONFIG_NFS_USE_LEGACY_DNS is not set
 CONFIG_NFS_USE_KERNEL_DNS=y
 # CONFIG_NFSD is not set
diff --git a/recipes-kernel/linux/files/nfs.cfg b/recipes-kernel/linux/files/nfs.cfg
new file mode 100644
index 0000000..23d9357
--- /dev/null
+++ b/recipes-kernel/linux/files/nfs.cfg
@@ -0,0 +1,6 @@
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index db0abb6..a07811d 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -22,5 +22,6 @@ XENOMAI_DEBUG ?= "0"
 
 SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d.getVar('XENOMAI_DEFCONFIG') else ''}"
 SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
+SRC_URI += "file://nfs.cfg"
 
 S = "${WORKDIR}/git"
-- 
2.43.0

