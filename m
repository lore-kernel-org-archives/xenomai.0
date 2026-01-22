Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457E359701
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085423; cv=fail; b=ff67UuXo9/ALQmh/ONMBW2nxdb2Otlrf/vzwijbCKPMVeZfLkTlfvR8QdDMyk6jcppNXNxU9Nma7IG/qppIF79u2ScXRolXjTJNNtpzAILLjfRbp0/ZbCWrT2rvjer1rR5jkl7gYHiCbRGcYPhEnLy9Azj7/70SJInUImHmnCNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085423; c=relaxed/simple;
	bh=D2uqWNIrD75++wB0O3osm6ZXzxgV5ThXdowZblnFOlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ydm40n4n8Ku+zZ0lzFjw5MV7DgDuZ1VzeehGH3IyfDgZcjqev+ua9qGiJojYm/W9Xx2cu9QbDV/FGX+qaA+HdoxZ7YRWlzx1YRHJrsKMzf3di4aHRXDcQkvAApWsQS2m2bv9z+ryYW23WF1JOg/ZT/UOITaycOqpt2+srUYTaxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=N4Qr9o1k; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="N4Qr9o1k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGBvuW1g6QrDTS8n/s1zoYyCL8j9Ob597z3hlb7sVq79I2niR5sr9CiQ9dqYgYaFC0RukvgjVGbQQ/YbrJZTiZFsf4P1blp06klzn+lubn9zXj9JU3XUbVl1o9KIviNa3+iFipI16vDjIeVZH4mjeb07b1GjlK7jnQvfCdmiscSs9oxQjLjtNLPf7kzeEYAJtCQdtPqBR2wiX74JRYy8DputWJ8aSfpNKyRWaOrkLpjM7KNNv45gZ0P+s9wkJv4b6F4q5f6UKjIOh8vc+lCcGK7ursI1Zcn6E8G5uPFcw/Nwn7aGQ1bphE08qOoZDv2Ev3MV6QxVNtabaaKPGixtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOlyXVBNdinyCCTDL7w+44bGGbKS293gxSK27sqzlZo=;
 b=sn1v99vbGfiq8q0g4ujg+r+i/7NA+/FdT8odtWjV9lQwDJIesfkYnEZd8RgpoEh9pPewIEd5cBefjW/LEdXM6dug8V+7lExaPA4tHxMaumidry9ARF3yYHSqc7xp/4IUuSlBQq/tk+U0YPm5G578ffWMVRteL+wG6s9tUQX247pN1/m82tMBEPyDt0bRMJqbbCGyvGkxkii3xdDaai3y/P4ghAKrb9OM/1rLNNmJmIfbuqDgCaqtHqI+snZenFqgch9JofjFKNAXm1qXBRyCIrEMEFMW3q2D+vhCEOQtgATE0YdPSKP3Qu1mHDfmE6nDhaRUuJFVlx8dYETZ6X/6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOlyXVBNdinyCCTDL7w+44bGGbKS293gxSK27sqzlZo=;
 b=N4Qr9o1k98W1GvBfaEImDrIllzyv2ovq8q80H1BaTvK5vh3MbSxHKZ4DwJZW2TgEpkC9stJ80Qdi/b2kpr3JqC4Zi266adkdkY1dNBQtBs6HGQIiroGMzEBxEe+rcPwURUm7PwK3oSUxDspSgxwHjGfmAkf5VExLrJKk1hzy9Ss1arYNNwjnhE5Uy3wTfXqhBJUR/5bSp5w82nKMRWl0gk2pn6xC+6kaTbAHL/tGk3MV0aw1h3a+qtjFNI6QimltDlIu6Vf4zk55fMUD7vc7OgDUNjFhiSLsramW7dxRJgR+AuDXW49nh04TfGdIqu9ERXjdZuIjSnauFgb/4ekS8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA1PR10MB9101.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 12:36:58 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:36:58 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v4 2/2] start-qemu: add support for riscv64 target
Date: Thu, 22 Jan 2026 13:36:46 +0100
Message-ID: <20260122123646.445823-3-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA1PR10MB9101:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd66df7-3658-46af-3bad-08de59b2eebd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FpCBZ1Y44Q4Kf/75HReoBPkADGMHAbeAqXFcr54IphO8A07gQCvTV5uY+C+b?=
 =?us-ascii?Q?MT/NNqORednW3KiBoKFPBgC0uv1uIr7PQD48DiI7LFX69swUI+Ku2EnFkcow?=
 =?us-ascii?Q?P5AUwxvCMOfCQj3la8jpfyIrrZvpd/O8wdfucOHwfvVEf5Uxclq/fjtYMdc7?=
 =?us-ascii?Q?V3Kk8NIlFwMmRKmaQuPjFZS0XNr/2cgjLEuL+F0vF9dFKe4x9j3LTBfi7dV/?=
 =?us-ascii?Q?abs7kRMbfIS2n0tDeKPIXYG5PpX39jz1KR54tAEJkFmt0qGznc9ErOygoNqz?=
 =?us-ascii?Q?qbpFoAAADAWP/fQI8JjFSy6ORzav6WmtcYtwNxuGmRRwNWqJ6MO++7N8UKTa?=
 =?us-ascii?Q?rmcU37rD00DbhYl0dSk2GqPr4QN3evLBughQIgtoj+bCrJyxoGX1yUvsnfKC?=
 =?us-ascii?Q?gBDRBWPR+Zk6C1pzBr4sQbpNWuNp0ZDgqWw/YRgFGt8QeQ+KxY037ufvlLD6?=
 =?us-ascii?Q?lMa+7CqTmlFBWOLT+WJo367wEeSLIlLwcQ82YYaBpm2B+da2erG29DzOH2Uu?=
 =?us-ascii?Q?8cuhUJdBappdOlv+RVQMbIaJY4uUZvlL9V83wzql0ttTapXl3f4MpWQlylbQ?=
 =?us-ascii?Q?OLgD2vHwosFsNagEhf4FvHnOKzrhtjtTtphiY9oMPreS4pj9V1F9yOgFkjZr?=
 =?us-ascii?Q?CwxQ3DmgOM8NMivcc38xK0YVHV5aoOvOmRSFXPbuEZiZ9/awI2jvDBtIbKfD?=
 =?us-ascii?Q?5BYbviVMXP+kCTAJMaY1Ae+dx6a8ETWlLxwGAsUzyqHQ9xm84lS3lmLHmjxK?=
 =?us-ascii?Q?NwBofjf4SKUl5KFnHOSQF1uaZWs4CXtjJPx/cS4IoIVZSV2wzHLDTSKC0Vw3?=
 =?us-ascii?Q?UsTm2B/svdDijbQmH3JfWBTmnqa1dJhRrVFfbTNR8xls20IlubmEX8n7BdfT?=
 =?us-ascii?Q?SV/P/KsHIDkEClyC6kmtSjoq18sxmnBfV/FkfPKh2d4fBvQG5879KvTDX9lj?=
 =?us-ascii?Q?c4s7aDAzih9lqjg+t1nyPXrdwfcb/D6wcAybqqjrood6EcQTG8NK0WrQCgIR?=
 =?us-ascii?Q?C21xRCendzsnEOz9VRJTMTYh62e6vI7ap5p8fQxw487mDqUujxRC2gkLkPMg?=
 =?us-ascii?Q?2pNgfiT1mUjZgA72ffCqqc4+r7RnO2Fo+DsFL0js96hZmjW1QroWr0EiZAc2?=
 =?us-ascii?Q?vDa0u1dFFXlmm6oJsJ0yFUL+HEN4uTybULYLXvRnwzw3lwfsvrrpFs4+KcLA?=
 =?us-ascii?Q?8jnitq5wIrcuj7u0CHqxtSv8/rrKsdUejKGDcyXiM9OIO2EFRrg/CamKkTW0?=
 =?us-ascii?Q?5LzMBZAbDkKq4nWf1jnXQvSfDl4HOVGfd8Qc/BIDo+YjSKlJbfIn7hpwZEAj?=
 =?us-ascii?Q?TjVbnVNrq24E4RswTXv3zNiGCOFLrNTP95JXDytp32yZ3DLSgSwKmp7JOWsE?=
 =?us-ascii?Q?UHumWITH79nucIE+HpLFWiismmrYL5h0LImxLjTUs+wZmex18Sa8RCkYYYRK?=
 =?us-ascii?Q?zeO0l/wgt9JkDj5AaTo63VhF+TxVGYBPuHJrRtuQTb+xvcF4cFBQ/dJaLJ7/?=
 =?us-ascii?Q?IT1u/3xsuyjnoLNGZzi2V3280iqDnjR8b8G37L9KAWcp8FFw6E5D5pZxRjJV?=
 =?us-ascii?Q?3lMvDg+6OP1EEkvAo74=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BKTe3jYV9rGm4F41ITdCVgk6E04yZWUO7iuamiDZCfqUCqCkKKqCyfLbk3za?=
 =?us-ascii?Q?dhBj0U46yogNMZje24GD85HmV+da6blAIR9o2o0SnL+ZiVxEFRF1nNw9u9Nk?=
 =?us-ascii?Q?qVivzoPbVpAelyOOU9CSd+LWclQ8wPGQxE23mNZv2K+eyXMoxG5o8VleaTGZ?=
 =?us-ascii?Q?1Sw1iDt9enxnFJfGWzcFm+nh2JHQM0kscVUgs/SqepwMBBz03Kon5Fo4iD/e?=
 =?us-ascii?Q?9ZVLDtRT9zBPQ8lUJJnD0WaobQu/h8GUOcxORwYwpL1T1W7sDgSQaQItq6Bo?=
 =?us-ascii?Q?n7oDJXFASdGy3/r3TKS4Tf+xiG6DNb7lSDl0xQDjwnADW9NhXXfyhQHv9Opv?=
 =?us-ascii?Q?Skq+dkAnLghx3LkYF5O+A+L2IDOdJvGvrHnIF4YdvrVxECH2qAcK/y7vsa85?=
 =?us-ascii?Q?f21+N8SUxdo/Rfce6DiqQygLCKfGYMKD6tcR4v12c9LRqtEMermFkjKc/7Ye?=
 =?us-ascii?Q?I5TPC4Pm1yb/RFZNJXKLhINPOJEpcbH432NGTLDnLhDl5arjJ8rxIQHl+YS9?=
 =?us-ascii?Q?Uz0Wmrxg8KfHmcQEr0Lgf73GtaOHtx2pqJERFy4NDPMQ3m2WNfHy+sMYFx5C?=
 =?us-ascii?Q?Se0KOl1KAGihm5dNzmJPkQkujLkcNt+cyRThNnNW90SreG3bYwo/cFGcoPnp?=
 =?us-ascii?Q?XY8OuL898FqLOtk/JrwMJkBiTBValM61Yga6GvJ17+6+/yKccaa21XLjITRb?=
 =?us-ascii?Q?alAGLZpcszQSVPDZr11+CNejI5AkG83bCxx47aftI8hhQhsu3hyUz3JpNkPJ?=
 =?us-ascii?Q?QH9WO529J8O/etiYW+opireh+27iVOC3gd4dXDFPB4+ZsvshZm6820EdVCFD?=
 =?us-ascii?Q?tIvWcLMXpnTW+kRkh0bFiNyEz8x30NrX05WIFUHXIFHeml4pj8p+YSSevBmj?=
 =?us-ascii?Q?/R+kkvB2k4jxcnwzjzCcbHPaNZfxdwOOJ0wU1xTxbBdWHbzW13SMBzH+PSvy?=
 =?us-ascii?Q?bExZvGFAcDQYEhvcYBvQgyspgO61wwpdHMvABUE/cjgHRiWWgf+WXf9QEzfn?=
 =?us-ascii?Q?qtP5HyB8jSUHUIVwoqEaEZosP22tZZMCqBNbHp7FCwRcH0TxHc5MsrLqw7vn?=
 =?us-ascii?Q?sLMWaojxCNZ0PIlchMcurbCWFQlm3p5rwPG55Xo8KWQMkfwkjOcQMF2S0tOf?=
 =?us-ascii?Q?si7sphe8BNcsxuCFe+JgOEFmZ1HV0x6Z4fdfgGLt/BK/NwgOe8EiVPQtj+s4?=
 =?us-ascii?Q?kYOCqLGA/hguPQTJJQ5Z9n0E0hZSjZb1K+BzE/iIBX8ILS7OpwZpceNseHEh?=
 =?us-ascii?Q?WVAFejIIUX+EhqpQ6WxNvnzvrjXYl0HU8crFqAraXL+arRR2Ee6ITgOzzfu0?=
 =?us-ascii?Q?FSGWqtg7KgcZCQU4aYNhY240T4+jc389gbufwGb1V9dgoWmqz26Y8lswggAr?=
 =?us-ascii?Q?HUz8KfA5mPlrO2mlVFT6TsRDFGBOIXvN7tYXoUJ6gPyyXcDdHqRBe/VrG/bv?=
 =?us-ascii?Q?e0U0wIXpv8mzv9VZ3c8mG0M7S2CWpaoz3+Pd5ug4KvaWvbxelUXDrvetTfT7?=
 =?us-ascii?Q?JtS5m3ultmdc/3NE0z56DoMtD/HkwAlTQP63lIkB6nzbfDtgdmhLoRQcTyal?=
 =?us-ascii?Q?jsTLN61YZlfWQAHQqoAxFx8GJ8iWVetJWiKKCEqLLpR8jp7rrPuCK5ZMAhSJ?=
 =?us-ascii?Q?eVSeFUolCCYCvTNk/iNIwcuyk5Qb8mdDnE+43anaPSytg4+Wu5qic8qmQy4q?=
 =?us-ascii?Q?GcT7euRtrzO8B7wcS0B8AucH4wy40RXLKUXYuojoJ086keBemvlWNYYrZQJY?=
 =?us-ascii?Q?hPl5FFsfeWMqLCQy+DOrxKBygz29q14=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd66df7-3658-46af-3bad-08de59b2eebd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:36:57.9934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0KMfae1DbrvHzhZT8rfFFI4uH7WEiLXg43xubdRCeUHcEG86CBFTKKrRKxGB3NgrONOcV5GsOw4OzwG/0tO7bpJ/QtJcuYlwtvMINqQaIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9101

Extend the start-qemu.sh script to handle RISC-V guests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 start-qemu.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/start-qemu.sh b/start-qemu.sh
index 7b9fdb1..9e9bac8 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -32,6 +32,8 @@ else
 		arch=arm64
 	elif grep -s -q "TARGET_QEMU_ARM: true" .config.yaml; then
 		arch=arm
+	elif grep -s -q "TARGET_QEMU_RISCV64: true" .config.yaml; then
+		arch=riscv64
 	fi
 fi
 
@@ -78,6 +80,21 @@ case "$arch" in
 		KERNEL_CMDLINE=" \
 			root=/dev/vda rw"
 		;;
+	riscv64)
+		DISTRO_ARCH=riscv64
+		QEMU=qemu-system-riscv64
+		QEMU_EXTRA_ARGS=" \
+			-cpu rv64 \
+			-smp 4 \
+			-machine virt \
+			-device virtio-serial-device \
+			-device virtconsole,chardev=con -chardev vc,id=con \
+			-device virtio-blk-device,drive=disk \
+			-device virtio-net-device,netdev=net"
+		KERNEL_SUFFIX="vmlinux"
+		KERNEL_CMDLINE=" \
+			root=/dev/vda rw"
+		;;
 	""|--help)
 		usage
 		;;
-- 
2.43.0

