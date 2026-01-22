Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012035.outbound.protection.outlook.com [52.101.66.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D29A2D3A6A
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085426; cv=fail; b=i4mPj4kbmRZHE8Xu+wKIJVRWbfyMiVvOpCNAkyp758UnKtytcxGWRJp8+081ZJ8rgJB1dtkKLSQMIkHq1OsxzICTsnlwK5T0eG6etQDKGPRPNtuqLlg7bcjFD0hiZNjibQhIL/Z/ef9TDy7Xlqak85bBBOcFJzPpJ8NSB8xADzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085426; c=relaxed/simple;
	bh=D4xhzbH2g5uQWikJUKPUdUre6XodKjLHOfjBLqYgdKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfeG+BCskNqxJ+b3Ka0Mv3B909VyprHCT1CQ8rt2gn4cGGAMfaIZZ2VuIH9iB9C3W52h8zBrgwIiNf6kU5rnI8VjOV7i2i8MF1kfMHyIJMOQrw3Cj4DQvXGPnbQP4mXX7glrNkYLQbVVt8o0UiYYdaeS/WOBPIZdUXV3AvgF+0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=H6Fen4Fu; arc=fail smtp.client-ip=52.101.66.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="H6Fen4Fu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsIO8fyTsc7PhYMKAZWXuNNhPzc9BhUlLFMn/4TzxGq4T7wX9cLrcpd/PLqss29PFXci45WncKugInmdaxe+TfP9IbZN3KsiOUSKWh0ywHPBIV6+ky1h8aybO3+96lR0BeFNWceMv08dNeBAEb2IRfzVfNhPCOO2TbbTrgdVXJV3T459UTlsBn3exB8emNHDRWJJWFBsUUSUY38Uw777S1CzUYnJsabvOU7prug2FCtBUiNQieMI/JdHBfGFQnYc3KT4dPpSujtl32nbJV2cT2PZv7yfZ2Omg6Gxk98JFtyVf0qLhgpbrCFKivNSeMjtvGUYJLHAbx+l3zkLUGoC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZY5jI4iz3g/YOfZQjqyjjvDb5/B0Z0/vp2ma6XRMMU=;
 b=IUOUZy3e9LyFMMHoVjM+ONp/0A0d5FvuGjRH8sfhslXy4DFzDoqLJG4wjxdea6LWXAtLdUQWUYQO/MaUPqXDzegWr+4GnQxJburGQ38XcUVpLULjyVpv64u9XgVi3wQhbxNIqCZZoNlX3MQDA0KpcpGw7B79wD0sIwLFSH91b8NujH1Wq4ARvtNNferwoW8A9zK01aCwnyOGPRNOV+cL1OMMbl7tzVP5/mKj4j68LiUFc0hWMWfK/9Q+nlC+4jwD3F8iCMgN+AuRKqCvIaz9dV339nGYLn3+skG9ogRnK/ZucgXhwEeJ1GLZ1TPqo/WXBtCGl9zWRuwgNu2Cy2vPPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZY5jI4iz3g/YOfZQjqyjjvDb5/B0Z0/vp2ma6XRMMU=;
 b=H6Fen4Fu5w+x8CTrpSmRooTiSUI3UXm+7X2LwNA0SNJSZUKUc42z76Nqf/h0BlLpRBJhsI+LHc+SmUFRMgy06Tb+slqPp6in+R7JR91fiv7lpj9cdPZBzVGP+nUeEQs5mtz6EOJlXhwETtsrxG0Ol+agjw3J1nJpsNBJ1Nwad1clLthWGIiV5eGWO1mX3LL9GxkRfMvTx/CIEQHzsgJkB2eQ1SyoTaL0KWLTJny3C9Qw5fCXorlaYlJLPHACwYsB8R8p/q9i/+VgqrsXOq0EEyUKHNWjFXOfxrBagR8NY41O8uOB+Fwckh66VzghTcKadYb10VATLYQmx9CLqB4f+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB6375.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:556::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 12:36:57 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:36:57 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v4 1/2] riscv64: Add support for RISC-V architecture
Date: Thu, 22 Jan 2026 13:36:45 +0100
Message-ID: <20260122123646.445823-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122123646.445823-1-tobias.schaffner@siemens.com>
References: <20260122123646.445823-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: b51bb76e-1cf9-4186-0e00-08de59b2ee3f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ibACV61ZCaWEpMv6Jumh+m0Q2Itx+hGRh5rQ60cwcfbrfNvGTdmi9HlujByI?=
 =?us-ascii?Q?gDDL20uxbHd53qx985s0+1BlUNyfxu0QAkM1DTxZNItu6BnruRcBAmsQ25hZ?=
 =?us-ascii?Q?LyFD3Y/UWu5cSGBfQINbsVigXJkgYk+zzO77iVAzgYJK1v+D1YZIDqb6L8Cl?=
 =?us-ascii?Q?efDp/N1u3X71V0swpExfJZKT1I6ip73GgnzNZofNeSp1KdgvJQNyGz1aozkK?=
 =?us-ascii?Q?S6JBGHWeHhC+29NFXZjr1u22CKffR9Sr/+gcnXq2wQbT0O/tpW6e81AoDan1?=
 =?us-ascii?Q?YiOO+1UU+pWwjVg/phC9K8jb8GEp9pV/jvqa0R/ga4sITedg7U84eh2eAhR+?=
 =?us-ascii?Q?NvWNh+ByBFA6HK9dU9K7AJ1o9EU474cXmXFwC90FKKm5mO0865kfhLLzuJNd?=
 =?us-ascii?Q?xX6He6DB+3+rmoRMv5zuCq5xKdgFnrsyU7ohX/nKCb3lTtk6U78gepqZ7y5Q?=
 =?us-ascii?Q?wHfHpUeb9bB9CclsMrpUKrghsQ7MbXKWkyJWdCVIHGkybHaWdmwNy8GqixJx?=
 =?us-ascii?Q?cMk2safRVOUlxzkOjelkN5LMxgq+KzsvB+YRtjBPXuW4eJySEPWlm8eENEBE?=
 =?us-ascii?Q?/BTf3/T6QJTKmi01TEFZobGb+ndzx7DF1Zw+6t+paylO/t/RyDkTg/hDWyfF?=
 =?us-ascii?Q?zAeJd/UQvD8pHc1zKpL44doFUbfzVaZNOCsEbJJJK1+Tg+dl12SKTLhEfBSh?=
 =?us-ascii?Q?xSEIrZtxmzldP3tOKhkY6MfuOSwIrwuI60Gyud043hGLm1vBgm2/yyr0+nYE?=
 =?us-ascii?Q?HbjgDSqG8SLtk7meZoOca6xwtrSKxG/Eh1zOrFoQPDE2KfJNuovK8QLbQl0p?=
 =?us-ascii?Q?xqRSiiXADuMza369XXBwwEWmZxcI+xYyMIe6VQx7kt3AJzBHEAxNlAUeTGYk?=
 =?us-ascii?Q?sV7CKY8SHJWtFQzFk0pmTxXMKByomoxSwIC/llfm5EuQWnXheGtbLeftN1pb?=
 =?us-ascii?Q?nFR+EQMTQ7qVP78Q8ivQ0ZsVO3aaX8Bxng2PCkNJ+8rRm0OeDz6sNFDZfKWK?=
 =?us-ascii?Q?DX9QfJcHNxmcV9Y9xHE2TEHAUluPT+fhSfzsWP5aB2hkV+UdenC6AswcQvh8?=
 =?us-ascii?Q?zQk/vK3HyamkwjJ3p7BHvp693/gbsA8FFeCQxeMQd5bEYjYU8g4pCNE3Zef2?=
 =?us-ascii?Q?GUtt7fITA8toYFUpKblrNKct0MaZoPVm97HtDw9jP8ftT0K77fju/nebeArt?=
 =?us-ascii?Q?F587IVwEVko9ZijLHK4YbZ4OEbBwjjLWNSXg61gYjvSCFoEjq3hcCRbQtCfD?=
 =?us-ascii?Q?y3poQiV+sPiip4P+wif51BYoQuk4pQbBqmzUQE8gEuZ7+GEqYsvoB+mkOVtL?=
 =?us-ascii?Q?QToBEVc+r4O4NXIJ5bMRzoeteVyudJKgkSpxquNrLjfsd7mR5CU/uCGQCFNg?=
 =?us-ascii?Q?htmqO13EWcBeqqosd/z5vTqEcHH+tbNNo6lxn3B38SWBCHW93L/BU5OWMPng?=
 =?us-ascii?Q?eTkLsr82kBpZa0xXsV+80ciSCgRFa3yhShB+0YPGghkQ2rQHb+faqOQB8tuD?=
 =?us-ascii?Q?ijZR/B8+rZ+jmtHppJILeiOlt+D49r8lzWMVcHrUAuCLlNa7ykWsH6rXn9lp?=
 =?us-ascii?Q?wGTolo62dZqD8g79+P8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nqfcpnHW31HWzixLZof2Ht04eDJjW0gxaZD5gHdJMymzLLDd4kcSABITPqXA?=
 =?us-ascii?Q?DqXF3ofwYyXhckLx4df6D1l/J5qdrAYvOJ9e0/M1JM6N962xOGK7eVZQE76e?=
 =?us-ascii?Q?H2J+Fns1gwj2KVEHERITUvtH6gL5vJ9/vkrQUZE85nKUSa3pM9TPn0t8Pj+e?=
 =?us-ascii?Q?lT7MW4k/lAmzcw1sZM6WmrhsWEpoV5RdBzqLQwEmRRE85qyoKQI89RAAyojh?=
 =?us-ascii?Q?N0+TBXnnQetgnRDes7LNfdb5G7phFs7uX+SAZXEgu1ena2WyR4vR7STJPzSv?=
 =?us-ascii?Q?R17CSSwHhrQi74ciWCq7sn0Ro6koSUMu8lY0D5B3AWNnIOwJFnNYI64x+vb5?=
 =?us-ascii?Q?Y+ybaeJOFiquwLQDqUufQbTnZ8nfvu1NGtdjNkOqrMN6Dxa5X59zFd76HMxF?=
 =?us-ascii?Q?Ed5XKS9+Ed3JPmQilOYcdydQu7siUGTWbwh1SLhIVHwWQ+TPE59esEHEAyZ4?=
 =?us-ascii?Q?Fe19fpncaaC80E7S5dBGQbisgzotbQfXVYGcy4qwRqFniIfTLWPiK8Slqjsn?=
 =?us-ascii?Q?xTkjiKROLqKvAvXrzuMZqXy/uXpzlferKmVv0ieuLO3EgXp0p6TTC+yhmt4W?=
 =?us-ascii?Q?wu7WBo63UfLsaijW2p9+SZ27s+LziWeDqKwx74YEECSPmHy6578jh+1OZyjH?=
 =?us-ascii?Q?MsnhCC2JPVp6jGlfu3ZV+sFNJkEjWw+iW0EdniviJt0HJMRZdHDqcwyFCDKM?=
 =?us-ascii?Q?vXv+UmaabCkBMPgh0GjARmFvBrDBObZdXEy1a304lt2BH69C51N+5Cgmz7J0?=
 =?us-ascii?Q?GsuCM0d5tRU8ek+RZZ7m6Xr1csk52zzs6rGrqstgeMS6xLOyBehFKRUaP/cS?=
 =?us-ascii?Q?3tX1MWom/OQfxc8saybfC3kMxglyigzJYntML1SNdKZzncbAvEALiCpsxeBW?=
 =?us-ascii?Q?58Th7bt4FhpRdcZobFEYwrI0h6GjIu8lD2FivTnK6QAqKNNpUYhd0Xa2Pbyh?=
 =?us-ascii?Q?9QgfKTqs1aSrRwgoYSGcyBYVYJsfwx9wdxnx8zSikdY1MHStDVulxI4A6Kz6?=
 =?us-ascii?Q?lkJpsVUiT/gVGi/yvhyHmUGFGJffHLTwArq1xilnji5kUCfEQbGhp2xV3RJs?=
 =?us-ascii?Q?ZTOEBXdDveh0rGru/jk/q3XWLg8QelMknCD/qUqeesFm0Wf8RhDbcDSSmg1J?=
 =?us-ascii?Q?EnQZ4MawNALTjMEjYiBLRGYRASuTjYrDyom79Ma4QjdAQtq4r11K+/jPwMBo?=
 =?us-ascii?Q?3gXqiaeSz/16esV5laWKaolbv8lg+l79y1d9B2sKI8Jb6v+NZGdmQDr2/Rel?=
 =?us-ascii?Q?B/L9Oxhhl4Ex09giLWBPqfkT82/LQ8VdfGZvh3YjMniJD5v1vBYGvMdhE2wC?=
 =?us-ascii?Q?OZx2IkrRNmGvcGrsVcIoEtLuxQ+lyI3bmkUNNblST4s2SkaUqyMzC/EXztKY?=
 =?us-ascii?Q?A1fISc1oRIaQF0th+QQ4MH7zVItc/pBD9vEnhRG0HlY7NnXtCLhKfUADWs+i?=
 =?us-ascii?Q?6olV0cMX5W95Az5W1Qdu1fuNzJS4mpAs+Qp19cn5pAgbNiVBRRq8P+TTvAkD?=
 =?us-ascii?Q?+uz6T0YMLJnwyz1NYC9uudneSpBcd1ZOaOty6rMKfu92BPd4KeDzs3B25hNe?=
 =?us-ascii?Q?Mv3n5xKlZX0PQ1nTbGtHB4zF3sRK8GKR8BjPOn1XQPGWXrO19q+gWX0KDYzO?=
 =?us-ascii?Q?ubuTIRsR37KhkfYAWW2Vbe+J+8VeF34FZcIogALeC6UxU7Qeuxekrk6+j1Kr?=
 =?us-ascii?Q?tq2H/j4ObqQLroUT/+Tg3OVeIUc7tzGgjkJ5rGVB6kHrYcn5weUamJ67qSB0?=
 =?us-ascii?Q?/0/cK43wdxK+l5r0smZrcK+RgRe6bNI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51bb76e-1cf9-4186-0e00-08de59b2ee3f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:36:57.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coa1woqTdl8acxIzPRgq7El2NlLm0od5VvIla2UmniOZlvW4bFCQ3D9Es0p6AQr+Phtr0eTCYlDNiB1Tj3oHlOd1jeOe+HR0v9UsGqM/pls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6375

Introduce support for building EVL for the RISC-V QEMU target based on
the current wip branches.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 Kconfig                                         | 14 ++++++++++++++
 conf/machine/qemu-riscv64.conf                  | 15 +++++++++++++++
 conf/multiconfig/qemu-riscv64-xenomai-demo.conf | 14 ++++++++++++++
 kas/board/qemu-riscv64.yaml                     | 15 +++++++++++++++
 recipes-kernel/linux/linux-xenomai-4_latest.bb  |  1 +
 recipes-xenomai/libevl/libevl_master.bb         |  5 ++++-
 6 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 conf/machine/qemu-riscv64.conf
 create mode 100644 conf/multiconfig/qemu-riscv64-xenomai-demo.conf
 create mode 100644 kas/board/qemu-riscv64.yaml

diff --git a/Kconfig b/Kconfig
index 178db97..dec7458 100644
--- a/Kconfig
+++ b/Kconfig
@@ -17,6 +17,9 @@ config ARCH_ARM
 config ARCH_ARM64
 	bool
 
+config ARCH_RISCV64
+	bool
+
 choice
 	prompt "Target board"
 	default TARGET_QEMU_AMD64
@@ -41,6 +44,10 @@ config TARGET_QEMU_ARM64
 	bool "QEMU ARM64 virtual target"
 	select ARCH_ARM64
 
+config TARGET_QEMU_RISCV64
+	bool "QEMU RISCV64 virtual target"
+	select ARCH_RISCV64
+
 config TARGET_HIKEY
 	bool "LeMaker HiKey"
 	select ARCH_ARM64
@@ -58,6 +65,7 @@ config KAS_INCLUDE_TARGET
 	default "kas/board/qemu-armhf.yaml" if TARGET_QEMU_ARM
 	default "kas/board/beagle-bone-black.yaml" if TARGET_BBB
 	default "kas/board/qemu-arm64.yaml" if TARGET_QEMU_ARM64
+	default "kas/board/qemu-riscv64.yaml" if TARGET_QEMU_RISCV64
 	default "kas/board/hikey.yaml" if TARGET_HIKEY
 	default "kas/board/rpi4.yaml" if TARGET_RPI4
 
@@ -67,6 +75,7 @@ choice
 
 config XENOMAI3
 	bool "Xenomai 3"
+	depends on !ARCH_RISCV64
 
 config XENOMAI4
 	bool "Xenomai 4 / EVL"
@@ -215,15 +224,19 @@ config EVL_KERNEL_HEAD
 
 config EVL_KERNEL_6_12_HEAD
 	bool "Head of 6.12 EVL branch"
+	depends on !ARCH_RISCV64
 
 config EVL_KERNEL_6_12
 	bool "Latest 6.12 EVL release"
+	depends on !ARCH_RISCV64
 
 config EVL_KERNEL_6_1_HEAD
 	bool "Head of 6.1 EVL branch"
+	depends on !ARCH_RISCV64
 
 config EVL_KERNEL_6_1
 	bool "Latest 6.1 EVL release"
+	depends on !ARCH_RISCV64
 
 endchoice
 
@@ -244,6 +257,7 @@ config LIBEVL_NEXT
 
 config LIBEVL_RELEASE
 	bool "Latest release"
+	depends on !ARCH_RISCV64
 
 endchoice
 
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
new file mode 100644
index 0000000..8dfcda4
--- /dev/null
+++ b/conf/machine/qemu-riscv64.conf
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
+require qemu-machine.inc
+
+DISTRO_ARCH = "riscv64"
+KERNEL_DEFCONFIG = ""
diff --git a/conf/multiconfig/qemu-riscv64-xenomai-demo.conf b/conf/multiconfig/qemu-riscv64-xenomai-demo.conf
new file mode 100644
index 0000000..90980cd
--- /dev/null
+++ b/conf/multiconfig/qemu-riscv64-xenomai-demo.conf
@@ -0,0 +1,14 @@
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
+MACHINE = "qemu-riscv64"
+
+DISTRO = "xenomai-demo"
diff --git a/kas/board/qemu-riscv64.yaml b/kas/board/qemu-riscv64.yaml
new file mode 100644
index 0000000..3b9bd6e
--- /dev/null
+++ b/kas/board/qemu-riscv64.yaml
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
+machine: qemu-riscv64
diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index aae7910..ed49555 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -34,6 +34,7 @@ GIT_BRANCH = "${@ \
     'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
     else 'v6.12.y-evl-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
+GIT_BRANCH:riscv64 = "wip/evl-riscv"
 
 SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
diff --git a/recipes-xenomai/libevl/libevl_master.bb b/recipes-xenomai/libevl/libevl_master.bb
index 8fcf768..48f10dc 100644
--- a/recipes-xenomai/libevl/libevl_master.bb
+++ b/recipes-xenomai/libevl/libevl_master.bb
@@ -11,7 +11,10 @@
 
 require libevl.inc
 
-SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=${PV}"
+GIT_BRANCH = "${PV}"
+GIT_BRANCH:riscv64 = "wip/libevl-riscv"
+
+SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=${GIT_BRANCH}"
 
 CHANGELOG_V = "9999-${PV}"
 SRCREV = "${AUTOREV}"
-- 
2.43.0

