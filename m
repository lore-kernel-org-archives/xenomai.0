Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699413B8BAA
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077995; cv=fail; b=fMdat8/6ngiDpAnx7N3IOG01ePdPjNhyPCJJH3ZUjzf8etIRtRnQhcCr/lUOfvYoR5vyrSF8NPL7tYpigjuWK6TUVZS5HhKVScrPVMwAx1d5pYkhNxGJUIdRWq8xdsCT5IRp6vl99Z4ZM+mRKAmkPO3EHt8xjnkfuLfvVNj517g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077995; c=relaxed/simple;
	bh=VVTGdblH3zFezseDnIW2RP1+NV9IAOHh+il5r0pcb7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LbkAvOqXP77W1Cok91ofZKp+GhhRsgoeia9AVWyGfSHfeqWWym+w74Yjt5un5AHF6iypd96XOJDW3d9eggvEQ2WyVj5aS6ptVYJXbF4uV0J/HGuJQSjJljIljIjGcQ0HJ6K1UrIeQbrAzlaSv82Qp7Hi2ZqeOZKMwYOmWPi2Jn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=nkiEd9Mw; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="nkiEd9Mw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZnCbXymcGwIjP3u/IbC8Rd+pTTHSM4VEBWI/VQD6WKK8Sd3qhnN33wZvF29VFL5ISjRmI8fWr6jQV2NNzCZ2sII0NjljTcBGBRYS4sbs0em4fYsQ9OckmUpDBAtOxMoqJQ0BqMVHwpNAiljWcI2tJB1p0T9LF2kav1RfTx0egyd44cPHxFeJsgk0ZSOlr9NzE7IUtUrAeEB/6XR0MQldd5kpFhusZCBjKAUDYjShrwBpxWF00TM1uVOv9adSnRPoThnZnOw4hqHr5GkwlDnfCzGpSWpRH63Bxfy5fMSQihaO2UV4R5kdXyyQEgZOwlz06VpHKVB+WMq93MWdSUz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNJBDllB77lnhuDOf81rxFQSZWIuUIvCbLSIUZbs9LI=;
 b=F+1WX1UZNj2YfmeKNIXeuBOsmLX1mGGIkAeAHE7sEqSpxAYVlvLKr2EZ2Iut/1sPseUMSVcpxt/fJag0T556MgU11T8BMT5I2y1jxOXM2c7wX83xdRZ4N8dDMkjq28Z6tdp7KcHAMGqhiuAyKKVaZ4FiIgCTewr+wwOOVicnP2US+yP73GqlS85o9tXoNwQMLYRHEjW7AG1Fxc1dNNq8janY4wMKaPDe5C7juWVQ3JXtzskeJMiKSC9Do9QtMiM6KkTZD2sXGZbetRpt42yNwvbF4QYSIAlWgaU5GxpHZo5doQo+WgzqlIIJMfjC84Aw/sXcLqpwLBf5Wmb/9O7cVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNJBDllB77lnhuDOf81rxFQSZWIuUIvCbLSIUZbs9LI=;
 b=nkiEd9Mwpj/M1ap6oMbvQfltMvCeUAIX//bdPY701QNC6ZI35rNB8JEntn8iJ9K8HXZl2Gn2C1lTVkNT9tWY7ly7f7smJHVDHrBWjTf63Pjeh7S6Xf2QYB6F5ZscEfqFts149QRoB2wa1bO9Z1+JNbtWlstOZcLQ0bv3BN9Y4VSDk/++zHQzIDbPmwUShWrvUrg4mqJXrAHwANr5l1RUvYEqI2CAiplxu3v+F5DQCODCVuUAr0ZeTQJbBKTplibTdd3auFwxEHcNY2kHOk6CMAGy+jjBBte+d0ocE22EVmHPtWZafDaE6If2HGMWB/0xKy+4Q2aDJGzam2j+ceH56A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB5641.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:33:07 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:33:07 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v3 1/2] riscv64: Add support for RISC-V architecture
Date: Thu, 22 Jan 2026 11:32:58 +0100
Message-ID: <20260122103259.423957-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122103259.423957-1-tobias.schaffner@siemens.com>
References: <20260122103259.423957-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b5271a-17b0-46b3-a062-08de59a1a1c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2+X5ZbF25r+Ipg5Z1M9RDQeRMWgrve9J9hmwLaAyLyYsvy5lq+eDoAeMoP3?=
 =?us-ascii?Q?gbbylHZoHbHFd4a2a/7PQYcTtVmT65OGIjU2+/x/MqhJgr26/T4L7Jj2WcIN?=
 =?us-ascii?Q?Ku6zSwZm8CQaNwcIWCTmU53NyRkr2VLbRY2DDJWz2ed8Td3/BACuVe8hjzx/?=
 =?us-ascii?Q?f8nf80xAcsnifxegVEdn8TAdh7tiAtoMfa3VbKnslFCxvMekmYfV95Wb4afJ?=
 =?us-ascii?Q?oJu9BIGWBLwqbzfmpxvw7htWTKqn87zj7Ci3X/uTermhI3BKWU+ub1F/lMUq?=
 =?us-ascii?Q?VxJs5WH3SfHpqcz3YIN+s7aZ3zPVlKgYIcWWKzfqjjwawmDCmgCbA/uc1Lb0?=
 =?us-ascii?Q?Ok8/PwMWMllBDueXR/WqYFX6RqP0SgO86QMZuwF4BWewHriSXn4bR9OH+mU4?=
 =?us-ascii?Q?gpNGy6ZXfHuAOCyj+4vVua0HXHndTmggRCat8Kh+mFyknWm58V6MZSUFgA3d?=
 =?us-ascii?Q?Wo2GSge3SjWAre2lS2V6+X4NiugVTcTTapFGhMFtiuAAmWKzY4NAA+773BoH?=
 =?us-ascii?Q?qyhkxZ8SyfjlVeRCluqo+/VxesXtrzHaBwoYm4T35DSEuHKLyJJEgUNGDBa0?=
 =?us-ascii?Q?QnSrDJRV+UjTIyWqVSeWV+YqYXuYyNNM07N566ixsVA25CQFR5OIPpP6Inex?=
 =?us-ascii?Q?3fN5kiVrcFIJ+0SjucN8kE6/S1V4vBeUwKWJnkQy7CGyPGDxnSn6sGITZgcW?=
 =?us-ascii?Q?lDbHPIVeUqWaAAluBf6bWbMRoYNJWWwTeEAyY8aBMl33jUpeqIBrwL8kX1kH?=
 =?us-ascii?Q?kbF5V98aXzxlxkB1eCQHZXxSreV2kQs4JKfcU+6tshJGrDhh8xub1R5GkCq3?=
 =?us-ascii?Q?fBEeS65DISxWGrHql+wJnwGalCfJuI63OmhlqihppKJs+VUacjiG4oELxG68?=
 =?us-ascii?Q?xSVJb06ID/zkSHzXWvXdOGMrvB+XLPHcvn/vyNFd870QPdhb9O1t1ft7Wnx0?=
 =?us-ascii?Q?DNtu+54CUDy1VQ5Gyv9DcZmm8Ca00QqOpbsqLtRO9Q00quTNMcR9Mmojn+CF?=
 =?us-ascii?Q?uJibhSc9EveKhR/v9qjUzFoP5l9y+JHs1XYbzmXAT5HkS+yRSosACqQinHSB?=
 =?us-ascii?Q?yf1hvJAlQkLmDlVvWrCiVQSWXUMfO/XCWf049No/EKeYhWoMGcKLMNxk/lhl?=
 =?us-ascii?Q?gh02x1y1vAgZLWU0qRDfzBmjr0bf7JUx4NNCYrO/ta+1S6ipP6Wkq292+Czl?=
 =?us-ascii?Q?teFTlqJtujXHwVAmvMQZI3s0L00hrCWkfyMf8fHYd+v2kRQI7QmAxUDPJc54?=
 =?us-ascii?Q?8qizgVKyJ/jrRf/ae+GGkz6eVjfd5M4pQVDi/+UeoYNyiJlMmaEYrG0dZDiU?=
 =?us-ascii?Q?Qg95SiEtNHyuPY7ZmW2FdP/JlnimgyJk+dfVt7O4AhWRdXpbFT12smo4qBor?=
 =?us-ascii?Q?MPnkYyua+VeqAC2pkmNEpjY45N81sGoitaE4/WMri2JlLg6eDRu4o9aI4q1A?=
 =?us-ascii?Q?8S5xBx6+vlU+NgJ8R6fbDxnyckqGgPoWCUaUKirxXMbK+VcxVRLbqncrRUbq?=
 =?us-ascii?Q?SSsXHT6wRll7h77NZFcyzeI9Au5YMpZUzNaCg+t8cAaMuzHS9AeImVWglmiu?=
 =?us-ascii?Q?JAhnR8ZWxzbyaEkYVyk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ohuyAfqeLIVPIHaNsXAPfL5OCZQRubI8C6KVnFhWCyk+kyGq+5wrfxPb+O90?=
 =?us-ascii?Q?ZSOzT5z9kQGZjoiPmku889FqWCKD0JDbhFzmSgN5v23oArv+e5D5Wan+8pff?=
 =?us-ascii?Q?qBdMPYjasBEVAfX5VBHPOGDdWKFLbRFpPpZZLrEFG9WIbReDbO1BVFmtCvYg?=
 =?us-ascii?Q?7oJc3ZNvgIOMzR6Frg9Zra+RCqy6gL3DSwgTLRjQ/c7kMW7xi+IaYwVOA+7C?=
 =?us-ascii?Q?RdwLB3bzE6FLbLUB2++ywjXO8+DiqUq+Z3YHQXpq+ZTkafPl+xiVHh5Ddnc2?=
 =?us-ascii?Q?EAuLTGXMjvuTt0/83DrMlIVxWu40SBTDaqK6rjn7K+w+MVK4RM1GZHI8tNUX?=
 =?us-ascii?Q?Fls8LP8QolpE9wHKy+y+0m2dd6MQJJX1LTn81VcOpO+6kXYIM8pbIqTatMlK?=
 =?us-ascii?Q?xGxBCLX47gFOXLqz8OpVw4+Nrn5glP5CSt3TdsjNf8RsoFRAh4PIQB40nTD4?=
 =?us-ascii?Q?2FV7eYFkECcoHaNodtRN7CVzGQSdsmWpONVd2TRysEOyvGyW9TlROYVFFrp+?=
 =?us-ascii?Q?X8RaDEpmA9p2Y98w6jJ8qao6/slyni78lZ0VeNLwjcSygPB1z35zIJqxeTz2?=
 =?us-ascii?Q?57iDhsnGr1P3vlZMjSkaGHLx3TNlrLpPOtwjpSuKKsgPCyiluPF/MpIKEdCa?=
 =?us-ascii?Q?o2rcybJ7tzbwxLUUrtaIwpKFyQaNAdAdgcRe5beJEV+hrAUUBbkk2Y7TjWNs?=
 =?us-ascii?Q?AMKYgP4aojuaTdV4eZwCDVDTrNQS7Ne9K6PCUudMeel25QiAr3atKKhygTrq?=
 =?us-ascii?Q?DJ2rY4XNDuAcQlZBGtJyGKbEwzh3l1Khyd5sBQlF02KJJxqd8oWXzJAAOJjp?=
 =?us-ascii?Q?euIk/bxQ/YUStfmKDi2NVOvB1KVbGtzFQnDN+OAWJKYUENbuxWu5BiBueUxa?=
 =?us-ascii?Q?cUCLc3qF9lv2LYbAI5pbdHvcUaBfxdasRAviQNZi12PH9pIGmkL7ps8nmPM7?=
 =?us-ascii?Q?uUvrU56OQkEjGnv04l6MUc7j7xXZZv1d4o9mWeySoxeE9rlmDg27WFQ0FRoA?=
 =?us-ascii?Q?sGzejoEV2YdnunZeNHmsA+b91UFQqevqut8lTqer+FX2SMNoBK0nmb1I2lyz?=
 =?us-ascii?Q?MusF8qj2FhgZ6ryEMtwBeVrEUTozN7ts7DVmIPKpu9zV92Dh8YzzL6jilVsW?=
 =?us-ascii?Q?A1RZ4UG40VHhUZ7L0cwBQwIggK0vrySrzNU5Ysvi602QSia8Z/rFiGmOJ2YM?=
 =?us-ascii?Q?H496YI0Z8KRH7xend7jy4QGY2rffAbKz74J8BxyZqe457k4CMfn3l9jdVZnJ?=
 =?us-ascii?Q?EdMj0Yw4vEQWvoKYLqJ/R8L1R30Wae0+E3GSm5OB8EMzCZSCqZFR20DBuxZW?=
 =?us-ascii?Q?bagztCyFlMRQT5Og6KNgPtCrARjqy0JbYz0ZcWqttG8Jy7sBN4Oe1ojD4Ct6?=
 =?us-ascii?Q?HE4SZeBZBmItKBe9FnTMDyk8L/UyanRA17/QfCwVuaQk7EsTf5/n9f2pAjlT?=
 =?us-ascii?Q?/2ORnabvFNeNOSKygLXSILFpUWGWJwDnxOrXXaYK6IkbINPgyQ81iwBk/NfP?=
 =?us-ascii?Q?spNQi8vdV3QK+PT85+9VWVQtgNOs/RTocnC1HutgLJGUwa1QDTOQmxf/bH5l?=
 =?us-ascii?Q?ZC3BvmVGxxevEVCheI1oVzvpLv2hs4bDFu1ZqOXXpECEjenedO59HP7x17tD?=
 =?us-ascii?Q?qADb50RF8s55u9Qa1xaeDFOTL66Ba1ZU2iv7HXiFuhWKEfplu3ivJlERInkF?=
 =?us-ascii?Q?JqH1K3E2pEcQOE4PJgtktK2JmpTpz0Ol9u1AU00wm5ZQiogwEZtZ6T7wM5DL?=
 =?us-ascii?Q?ZEWx5Dcqn5QhmI8UZcJYN8H6Zdnutgc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b5271a-17b0-46b3-a062-08de59a1a1c5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:33:07.5620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbSb8Lk4FMWFXb/PG5Bmdl30/+USmsN+1WSlmLBBr2v79Wri+ZNkEU+hY3A5WLTho61fBaTCRKDXvKK4Z6UdnCXHqlZU/hkvbFZgJLJTa9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5641

Introduce support for building EVL for the RISC-V QEMU target based on
the current wip branches.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 Kconfig                                         | 14 ++++++++++++++
 conf/machine/qemu-riscv64.conf                  | 15 +++++++++++++++
 conf/multiconfig/qemu-riscv64-xenomai-demo.conf | 14 ++++++++++++++
 kas/board/qemu-riscv64.yaml                     | 15 +++++++++++++++
 recipes-kernel/linux/linux-xenomai-4_latest.bb  |  3 ++-
 recipes-xenomai/libevl/libevl_master.bb         |  5 ++++-
 6 files changed, 64 insertions(+), 2 deletions(-)
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
index aae7910..4ae9774 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -31,7 +31,8 @@ python () {
 }
 
 GIT_BRANCH = "${@ \
-    'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
+    'wip/evl-riscv' if d.getVar('DISTRO_ARCH') == 'riscv64' \
+    else 'v6.1.y-cip-evl-rebase' if is_kernel(d, '6.1') \
     else 'v6.12.y-evl-rebase' if is_kernel(d, '6.12') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
 
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

