Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF42E7F3A
	for <xenomai@lists.linux.dev>; Tue, 13 Jan 2026 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294267; cv=fail; b=NrhcuaCDX5jpmrzKn9ZL1RJGNCJDmzo/UAwfC2zI31Euv2hx0wv282rGhuYvpN0GZm8nmX1EGsO8QVuWECqEDlozUu8kASZjo6Mf5aFygVbHfveLBTJy4MEBQNsdg0tFUtqWXnMzsLfcXeQ99R+BsyO86CUFdoRSj8icYqYfYBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294267; c=relaxed/simple;
	bh=2bFWYzjdQ0WROM9l/VYvXWkOSbuZANCvqmZ1YoQUiCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TkKhBE6N2zV32DkCXRwdfylsyXGkO7/TTmL2hfGILthPgtv+FWGrvBkzRoN+fJK36jbhcTmJRs/IkoA9xJgdZpbKkttCS4itIMIWDVj8BP6k0uG7jCIZFtPCBv1dtdntSUOoj1dkGJRszBZYmJRGZpYtv1Zy1UmjQthvYogmZCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UvMZqXai; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UvMZqXai"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHikCREWcnuFSwnniBhoJQzT4pfYA7wbSP75RzYZ+6bYFERjsC9Ox+r7zfZGGvm5aAZMjw6JF9SUC5OvLWLKXs+beA6z4N/1J1tQgr2YWWH/d6FXED2PhpdjzGaaeZCZMnNOG7quCjiOpYQbMskYQTm9hhqIBgCXlxF3GoOzubLZHvs1mWPKuyr89pchQ8nf8ed4yXnL6i02h4JKXqrJiilHXr5h1zkKgu7B0d40o1rI+hfMzz3RmUnW4wB7hBZTOqi8nnEGwBhmQobL21KS6RjU+Fl5ySF81+RaYOu1d48b2mNs0sUUI+/Z2NoiGnPL81ToM7ta3EdHuGLeA3h0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkA/9h2qo/9jl5DcTxCawu5xQYaxX/tsA1Oy/BHjDcE=;
 b=f+nYYGFQWY+K8qoRsfFAnNEc65iWnfL9zIMj+51oE8PJFfioVqZsoA5Ds0bo3yJb/d4SfOsMitIZt4nMuYzNQklMCPb7YLGikZSVf9PLa5lzoSoANVitZj1Fl16Br8IJJI9/0hJA0F0N3dPGmksP5tau4oAH1k+SefOSHbh5+VjPSDQiCyhff/a/znDXdGTrNVgULqWFO1zhj8YEc6TUFYRfJHnGzscZFMSEKfnHSUap8O0UhPGScIInTZJaj/OTsd52Vh7ZTsfAMwy8NeTWPsk1ldQJM7NPrrJvk289lncvXMqjCsQ2jeM7lHP6yzdBoEU2vLcpTShbhFuEzJ+p+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkA/9h2qo/9jl5DcTxCawu5xQYaxX/tsA1Oy/BHjDcE=;
 b=UvMZqXaikxaz/mI6GkEv6RS4VkJEljICy6LfwMOS8yBE8XBUtFq3CkcYelcm7IA3QwHUDyoNhcilAp43Y4ImAe7pWWyWnF+UEalq85iiKludkmV3ZSCgOJ0mNjVI1XUd0gbTbY0Ud6byPy3EvjjQYvGsfihl5dPuFrj1nLkj+MyuzbI1XutqyOT0txS2FRkFLy3yAe2KotL3/E+6Q5/QlgLP21gp+F+rLmsgTTvwkPWzY8OqYMtDfW9BkqOa1SlC0HR4XKPxY9mD9PIfGb9RS19fVjS0r+Zndn36Bkl4Gp7lkkkToJamQLRLWS03ONWDM5mtdVsAwDHtDCy40dyDUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by MRWPR10MB9601.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:501:96::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 08:51:02 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:51:02 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 1/2] riscv64: Add support for RISC-V architecture
Date: Tue, 13 Jan 2026 09:50:47 +0100
Message-ID: <20260113085048.1380995-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113085048.1380995-1-tobias.schaffner@siemens.com>
References: <20260113085048.1380995-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|MRWPR10MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: 6597f2d0-b18a-4183-0217-08de5280e12c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QXtkOjT7UNH7sZyrghwMn4Tad/hll9wP9WtT28y8F8rOTBnfp+64MIJP/ypi?=
 =?us-ascii?Q?mJdrAwrKcvTLunpOUQaygyO62nJ3WMUJ+uONIMGd9z0uDHJuyPlQ+Xpt/km8?=
 =?us-ascii?Q?pynBonZGQoCZNbsWpIssR3JViE4o5Mq3TQ2QZJ2sHgtwgScFG8t9szjZPDPB?=
 =?us-ascii?Q?/smWWyCgaUeEyA2uwAsiUUi7cwAKa3CcDY+lBkKckgyRcE5jQpiZdbs/PL3d?=
 =?us-ascii?Q?13uVgOo9LGGPV5jGM9gtZrPLsHbs5IjwYKK2sIT7RsgeUK5Pu+qb6ujT/JXk?=
 =?us-ascii?Q?hJK0/RzMN1fLTCdsjTbFyXbpa2C05t5jhZj5HQrXxg8KuqspPbqQ1vdf5cPz?=
 =?us-ascii?Q?Tr+L22affGjS6s1FJD6nuioauRWM5ePjAR2A9WtDMpV5Vftpx9bGWJBv3/Iu?=
 =?us-ascii?Q?FLqnC9c29bSA1hwE0p3WyTgPxdh/nMKC8p1i/2BGbT/JTx8U9JFke71/Gmoq?=
 =?us-ascii?Q?w75Vm2GSlzUOfufIM2a31bw20yFbXEDSACoIjr+h9mQDM+24Oy4Br1WfgQOY?=
 =?us-ascii?Q?2/tOl68sqx1wy74hE+5Qk3+Lt4ULYyxNNp96+MfQ4ddx3heDUjmGaVB/e8SF?=
 =?us-ascii?Q?8Zvmd5Hdk7Jw15QjADAhDk/3Z2xl5E9G46FyZuGdWC0lLidZw1omGVOil0FK?=
 =?us-ascii?Q?eHetORkQ2kchXoXjqGI0GrnwDFNiBI75m7eb3nevCTAQznB0nH7yvlMOKEjq?=
 =?us-ascii?Q?k7PgBfekS2jogTVaZbGc7/FJvgi/HDn4h8pMpHg+84t5uWckypRyF7xL5dW5?=
 =?us-ascii?Q?OH6EEhln3GDQyTXvGjmfPIfzT33N8ktTTkELyJ57QuchC7sqo8eeuOcmaoAy?=
 =?us-ascii?Q?oGvz3TR71izFom5sLnyPlOoUqT0mgGPyEdrU8TBIQe5hDe3MumAJlnPDpmNO?=
 =?us-ascii?Q?H7W+alTwtTifejIzG6pRecgUS1yx0Nfi9fD2rM34vx0BTyGXt5a/p+Not1Ip?=
 =?us-ascii?Q?9hkywj+1ji9HLhQEW7gsBScn82x11GU604BoLulYjHHTzI4MFD90yAMY49Xa?=
 =?us-ascii?Q?+4pKo2YgdDCAk0hJgplZvrlFmNaO3gZW1wYpbQj5SJlWxy2IWalx3Or6eHgu?=
 =?us-ascii?Q?c1KVODWlny80ytl0CTjljzo5HGhinMkKCzTIc8hXwFGUG/IN5zSkSf1IAD/5?=
 =?us-ascii?Q?tA+Xm6YXfY+26tINXw0ZoSQvUglNRXq/u6AM1egwMdXyiC+7zNhfQAQdRftO?=
 =?us-ascii?Q?W/jQTtLE+BOPCAE918m1hAHgWDczh+bnLw9t3JgBHdX7y1cyNoVO7hVQ/PGe?=
 =?us-ascii?Q?8+bJ/idS7tKjv0N1+dUf2eHabbjFCsxKBbPa9/kdMkgP7hl3mLui+bMW6CHL?=
 =?us-ascii?Q?JWNs/CjeKeZq4w1e9OiumpwiMqLyVyXscjBSP8eZvmFpCt3pxsDdROeF8lh+?=
 =?us-ascii?Q?E4E659tNSJ7KegdovNptiwL81T696dxjunf6BxAg6PYVRDpc4+Wk4bg8aJrn?=
 =?us-ascii?Q?o/40YCa5vLDMR/bXraCET7YNSYplfrsg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I43bdpKt1kGJ9xZ8BSae4oFHNqYrd07liMDBPtkuZaVhVClKbhPbuI6QyyTw?=
 =?us-ascii?Q?39VFQv525opj5A75TdO6U6hdAyUclUP2MLeJhx92r/VCUisjbYJzKUN1cTKz?=
 =?us-ascii?Q?0VP28Wu8hqObs4wXWLHrHGpS4coRelCfMxIYjJbMKQUiMtSB2RI6RU5hu2sE?=
 =?us-ascii?Q?NXohb4epkahBCef1Pg8MgNhUEkG+W7BQmMAbEKgyerK/yTkbVjVPM574+Bcv?=
 =?us-ascii?Q?K8IgOgXZf7yPGc26jmZs1kVms9+4T77baJxWiP20xyrHErd21+Gv0YVSKOrq?=
 =?us-ascii?Q?CpemRekEEXWNCGN27raQocapFpNOuPzCZVSvv84693YcJ2BUc/jHr3+Pa8q6?=
 =?us-ascii?Q?6lJwQ4Ob5qsH371E1wlr/Hsp/obQK9ziAJxOgzkJAfWEwLELLTDkuMbUcoA1?=
 =?us-ascii?Q?eTiWbQ4BH9r5wkaFVMj2KL1Ork1igLC1DywzJ66W+HKpL2R+LdF+JAy6kMPU?=
 =?us-ascii?Q?wklHbhHHY9JLQ6/iBQ7WgkMjqVqECF57aqp5yAkp0QLpqvBKDv/kBGUMpMWh?=
 =?us-ascii?Q?PD0Rk6D5uMntnYIZR+Cx0nnKSeFFbQ3UZKAWrJSEt+pPpDjiPR+aalJXPbVg?=
 =?us-ascii?Q?uClj9LdUpXBqe+gterrZbOBIe5PWFEtNtDtW7m5D7dxSGwc9BwzK73kwJAdP?=
 =?us-ascii?Q?XPHtLVmRpEct3mmQlvyyR5JVqWNShXld9yokNd6+0jrIhkXv+YtrnEmjxqYR?=
 =?us-ascii?Q?n5xe7hWHKZyBiE7KBM1URVZVPeB/d6IX+0zIbvGtGjubYkAo6t9AcPynhF6G?=
 =?us-ascii?Q?o6xEEen3IccDrVMS6Yr5+Csj+SBF/cqiX67rDCi9KKEQ9BxCeGRv87t+7Cq0?=
 =?us-ascii?Q?i6WtC85wgSqxV0AyP/K2kvZFe9uc3Zqi+vAl9l0+PGxg1jc5lJWT2efsciai?=
 =?us-ascii?Q?QV1EN3STYs1jQM5g0tH23Ya5d7fhMFV3iOhSThmOi0T7IDrHCQkresAlciMy?=
 =?us-ascii?Q?8UOMSmnhmUfhzLnydscRzN3Pa+eeKiC+OqV4iVcL8VKBYjTc/tpJ3nMTL1m6?=
 =?us-ascii?Q?om5I7FkGo5IPf0P3sIc62xiStrOoOHtnHNccfwBdoAJKwTK6Ibt8e1PQeQu+?=
 =?us-ascii?Q?F4/UjzZrV06DiPLU+l71WbjBYgHhEw5p+5J867zObSWaA4KcWhulvld5R3px?=
 =?us-ascii?Q?U6hwp2VvTS8AvSU3tiqeL5GeEneko9FLum4/NZcX6/d6SY0q4A+aySb3L3J7?=
 =?us-ascii?Q?VxTNHd7Vpdj8wTk2600s+/tvgrsS9rYJX5IbovuJsKH4eZdncSCxjaS0Ffek?=
 =?us-ascii?Q?C6xX3R6qPanDMT2C01mPFqL92wGBj2ubYoMA7GYa6wCy3YwqitqMukqYs1t3?=
 =?us-ascii?Q?amdeyWTqA1C/nmPOuIW9EGyegxNp6l3MndQYhjzlQLvXz3aXHE1HR8I+v7JV?=
 =?us-ascii?Q?JIotQwDhwyNtoI7ws2Nf2PwMvCwjcJ9VKOY4+uRz/g4RCfE5EMGNdeiBQumj?=
 =?us-ascii?Q?2iz35I30gDiEPI7hRnG5BCcTY+5ARCvgOwAhdrGjjKXC9dQztCGYjxFAHRZ0?=
 =?us-ascii?Q?4GKBnexXOXHzqCnBvZNsHXD08f2S/EqUfgMxpkFFMzkFzlDAC2oL6aU/GicZ?=
 =?us-ascii?Q?4V84LZL6tSxcpONVEHjmWl2Va9SLUaflgAPBrbbZ6bJLTQWGOR+ycHIn8cng?=
 =?us-ascii?Q?hhcWTkoRDzoKG+rSKzhCc56t9NlMny4UkNB0XU30OuASvjCPhmkIHC6OluGx?=
 =?us-ascii?Q?rQvBqfSy5ZatJx4aBSMGIJDDMMjRo11UEAxsfmfjh2GsYtkO0JaLbxitgV9c?=
 =?us-ascii?Q?zS7xdA0Zqd5zNkJh4IWM+YIhAC/h0Os=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6597f2d0-b18a-4183-0217-08de5280e12c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 08:51:02.1568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNBr2b/Hs5fxWfXeZLvpapnVXwhn36IxGyu0n1/EYVjeZ9NRzATTxQJMLvudvpuko/hwL6aA6i/2Lc9ZgNZy5+Nx7cU22hfu3iT7RVHnix4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR10MB9601

Introduce support for building EVL for the RISC-V QEMU target based on
the current wip branches.

The current wip-riscv branches are based on:
linux-evl: branch wip/evl-riscv based on v6.12.y-evl-rebase
libevl: branch wip/libevl-riscv based on next

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 Kconfig                                         | 14 ++++++++++++++
 conf/machine/qemu-riscv64.conf                  | 15 +++++++++++++++
 conf/multiconfig/qemu-riscv64-xenomai-demo.conf | 14 ++++++++++++++
 kas/board/qemu-riscv64.yaml                     | 15 +++++++++++++++
 kas/opt/libevl-next.yaml                        |  1 +
 kas/opt/linux-6.12-head.yaml                    |  1 +
 .../linux/linux-xenomai-4_6.12-riscv.bb         | 15 +++++++++++++++
 recipes-xenomai/libevl/libevl_riscv.bb          | 17 +++++++++++++++++
 8 files changed, 92 insertions(+)
 create mode 100644 conf/machine/qemu-riscv64.conf
 create mode 100644 conf/multiconfig/qemu-riscv64-xenomai-demo.conf
 create mode 100644 kas/board/qemu-riscv64.yaml
 create mode 100644 recipes-kernel/linux/linux-xenomai-4_6.12-riscv.bb
 create mode 100644 recipes-xenomai/libevl/libevl_riscv.bb

diff --git a/Kconfig b/Kconfig
index 178db97..9f7f793 100644
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
@@ -212,18 +221,22 @@ choice
 
 config EVL_KERNEL_HEAD
 	bool "Head of latest EVL branch"
+	depends on !ARCH_RISCV64
 
 config EVL_KERNEL_6_12_HEAD
 	bool "Head of 6.12 EVL branch"
 
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
index 0000000..96a0bc8
--- /dev/null
+++ b/conf/machine/qemu-riscv64.conf
@@ -0,0 +1,15 @@
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
+
+require qemu-machine.inc
+
+DISTRO_ARCH = "riscv64"
+KERNEL_DEFCONFIG = ""
diff --git a/conf/multiconfig/qemu-riscv64-xenomai-demo.conf b/conf/multiconfig/qemu-riscv64-xenomai-demo.conf
new file mode 100644
index 0000000..a789b9f
--- /dev/null
+++ b/conf/multiconfig/qemu-riscv64-xenomai-demo.conf
@@ -0,0 +1,14 @@
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
+
+MACHINE = "qemu-riscv64"
+
+DISTRO = "xenomai-demo"
diff --git a/kas/board/qemu-riscv64.yaml b/kas/board/qemu-riscv64.yaml
new file mode 100644
index 0000000..a659c2b
--- /dev/null
+++ b/kas/board/qemu-riscv64.yaml
@@ -0,0 +1,15 @@
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
+
+header:
+  version: 14
+
+machine: qemu-riscv64
diff --git a/kas/opt/libevl-next.yaml b/kas/opt/libevl-next.yaml
index b9c858e..d7aa62f 100644
--- a/kas/opt/libevl-next.yaml
+++ b/kas/opt/libevl-next.yaml
@@ -17,3 +17,4 @@ header:
 local_conf_header:
   libevl-version: |
     PREFERRED_VERSION_libevl = "next"
+    PREFERRED_VERSION_libevl:riscv64 = "riscv"
diff --git a/kas/opt/linux-6.12-head.yaml b/kas/opt/linux-6.12-head.yaml
index 27d4845..4243c18 100644
--- a/kas/opt/linux-6.12-head.yaml
+++ b/kas/opt/linux-6.12-head.yaml
@@ -16,4 +16,5 @@ local_conf_header:
   linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai-3 = "9999-%"
     PREFERRED_VERSION_linux-xenomai-4 = "9999-%"
+    PREFERRED_VERSION_linux-xenomai-4:riscv64 = "6.12-riscv"
     LATEST_GIT_BRANCH = "6.12"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.12-riscv.bb b/recipes-kernel/linux/linux-xenomai-4_6.12-riscv.bb
new file mode 100644
index 0000000..431daa5
--- /dev/null
+++ b/recipes-kernel/linux/linux-xenomai-4_6.12-riscv.bb
@@ -0,0 +1,15 @@
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
+
+require recipes-kernel/linux/linux-xenomai-4.inc
+
+SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=wip/evl-riscv"
+SRCREV = "${AUTOREV}"
diff --git a/recipes-xenomai/libevl/libevl_riscv.bb b/recipes-xenomai/libevl/libevl_riscv.bb
new file mode 100644
index 0000000..a025dcb
--- /dev/null
+++ b/recipes-xenomai/libevl/libevl_riscv.bb
@@ -0,0 +1,17 @@
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
+
+require libevl.inc
+
+SRC_URI += "git://gitlab.com/Xenomai/xenomai4/libevl.git;protocol=https;branch=wip/libevl-riscv"
+
+CHANGELOG_V = "9999-wip-riscv"
+SRCREV = "${AUTOREV}"
-- 
2.43.0

