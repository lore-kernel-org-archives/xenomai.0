Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22642902E
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107721; cv=fail; b=Gus2QegMBuXa+8b1adkm3XkZPEaFdNDyV608NgbIw4O4mXTTweeEiwOOUfpGC6UG2FtBsGXMO+2EXDZcIZhWmwqh/5XTk1JzWWLejEgQRJDeISASG6mDg6aso0FoWdBGwBong1C7Yn+8hz5rqe3eblG8t0cpDvSU2acEZ84kaS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107721; c=relaxed/simple;
	bh=Ck0XIwyW+tIJbjCJxcbO6Q9YKp8OqtUIuXOjATsIRSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ajtl84ceG3hy5dujyXMyWDfzr2r8EAXnYTDnua7zo3gFobvjcxpBZj6PS6loOFR4HBhdU3pOz4xKNagjEQe0ng/idhRFw86T83nFfw86D0Z8V0QH4J8zIr6Nbo8uV8KpKpr96BhKBqREFLyLgT8taVrZ5bRfdSJb4ID9wGqui6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FwW9nUrT; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FwW9nUrT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knAjBZ/Fqcjn+04B614Td7dOnK2ZNsPXzsPElqbA21nSuDdiP/q4u/t3YRZ/p58IXhGe9LO0afaMZbX2ESAUkAlWC5RvpUKOa7k/8J3LD+w4PxmkUBUw+4rCp0ZAuvlT20l5sBeOFnvCiV3Vk0luEOZP29VA5/A+/j155Kr/39WdVR0crtRRHzTRqgOjtBkX6c9EHHuKS/1EhAqk9xEcwGv2UsQVI9ZBWqHpvwQ1VLIrOQYIAMjvgxPpDFjJwwr+yc30rLzy2xDImiiLDNvxUqX59XNuWf8tY16OgOIq0HWN0HcXoA8+M80+BrQczPPp+pSTS1WOp3XzMsUqTbJUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grk642hCMvG0hkZm38/EnE2ZHEZza0FKgRC2zB+gmF4=;
 b=GT96wJS8iZHd2ZCuEsKT5TFidcLJ9lnJjublJpBjvKK5iSAcNiFq1Zcbsqu9lycUPwwYSWf9XF31HNo+YOLA0AY61skQLpyfIRVa3sJJzjlc7BeZdGSggMjxy8OAI79f364TW4Sk96CRZ3k7E0fsQFHl/W5PYOBrBn3c4/HwEWvK67B3zunm2FWJk4gKzAl8weTc2J8ev2GScVXhcns0BOpC4dltSY3b/lEE3ELj2cc0MwmxpIBqzQafQU1QYnXHCfKPahZwOhldQosuYa6w7XH2lcDfnVkAfW7KlUv55p4AAdaUT9CCzylTJf/kK+ZvdjL8jMhEUH/JTF2xE74oEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grk642hCMvG0hkZm38/EnE2ZHEZza0FKgRC2zB+gmF4=;
 b=FwW9nUrT1T5UwdjdmjtI7LRdAM6grYGJHXEGBbNQtO+7FcfFiOUQUoLhiUWQ4bZOyU/A7wpo4IPPkh5lhmaGJyqLBUuH6/3LuZMAylRWts8LI56fk/8A+4j9Y1gQLrq3nrVKYHqXDsw26JY1W2LTmLlGozgYeTM/6w/guhgBouJ2GhumWZrXknBBO+n8slwYhio6XBatMZGH/T/rLsB2qK9LVqYJunfV7xToZGDUqgZQqAbYbKBCDCbKSGIyDjNceXfY3vZ/v3fHPimeI4d4ObumI8CthAnDsRL6+QTpK249w3Mup4upHy0UCRF93RVndlSRlT1UsIRyxgPNRcNvTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 09:28:30 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:28:30 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images 1/3] ci: use stress-ng to stress EVL tests
Date: Wed, 15 Jul 2026 11:28:20 +0200
Message-ID: <20260715092822.223712-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715092822.223712-1-tobias.schaffner@siemens.com>
References: <20260715092822.223712-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3745:EE_
X-MS-Office365-Filtering-Correlation-Id: 70277f0c-a5d6-4259-306a-08dee2536eb3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10070799003|55112099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XyY3l+jcsVqW2pq+m7G0QG8AnuBP+YBcSZd6EzjnFfkwSfuejdJ8vlqd/yw435YXT0vN9xh5rGI2JxVskG8fPiCFnWo+vPrNkmJekHRv44UBB5/vb1Qw6ZmDi+WKtgn3QYlIQMQk6aNekLD2WVLMaKaBOFCS/+N/S/rmKKOEOfPiFuyL0729FpOhWKtszTi+v1wRQyo5bMlTpINsLMzXf1Bb2o/cBKGmYhlF92f8CzjgFrCjlUnr/yL9CHqu7d88T8ArvxuWFwsFQv2Cv9BMVUaDz9JvYp2B1uJJ7mvwyIpWobgvS0Delr1wWidLUzHO33iH/wGa4PgDP9zhCj/y37BEZ9ppEmFscSVMh3BkaBSG9dRZbPUNwntlehrPE9NvS748KKJhVnZVSCeZsfzLyjtcDdRBHctC9d6Ly2ludyZbSmw5Y0ATEEgb64QQE+lVLoF1OPxAKHQhM12264CVTiUFRDgueCK0LT+jWFrkG5H+xMKJ8rmiMhQEaaXrF4n9pbgbM2sr+XWrjFUUaNVgh7mKklV3g5uJ9P8X5093WUjKI1EQx6fr2uXofTFHZEl+VeKipZPGi8mFXTxGveQ4WB0kSgM3ZAXKmPjgdWBWCsdRA5fnYl7P53SWKBqNdhjEM8HC19MEqdWqtHOyCwghi0IJvAGfGNjUNXOfG1rCWr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10070799003)(55112099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xnRIAZitNdYRVfSSC1R/tO/9nji7egvXhz/u1n2CbkLcH0THAYAnN75jpBh?=
 =?us-ascii?Q?iJrhDuYe+rKKwjxtlbM9Hbb7BHk3GQkdi98rht5THBaHz7r1XVzYMdziY4ap?=
 =?us-ascii?Q?Maim9AVHx0XyQYfa8KGY9RzReO+8MEz3BWrkxxgUjoqfVLLuNwNs54i5K/M7?=
 =?us-ascii?Q?ROiNpMHQiaLlkti6VlXCRBU9KXk0RdRiO9zUMysgNZ7CL7HI0Bt11yYq/eX4?=
 =?us-ascii?Q?W5ykNg/7Y6dVdHLnvX8KKqMIDJ7C3cZ/QCeY90iX1UedM2wfQiosECIP0oj+?=
 =?us-ascii?Q?M9u4QFMevByx70TiPia2CRtMDtEW80lIamK09Qe9Y3BPXUGF9zw61DJiLf8g?=
 =?us-ascii?Q?E4qFVa0JiBLIisGOnV5xyr62kViDuedxgolg2qR3RAthfLmULz98i4C0eAdX?=
 =?us-ascii?Q?8L04NzB0iLDDG05UTuYFOPslsCvtCFWDdlB8k59P8DYDv19pyyt8svhPEduU?=
 =?us-ascii?Q?tJ37TYLr33lVNPsFNqi4jysbHLuPyvjjeK0W/+gz5Asj3546xGEyI+cw3qWG?=
 =?us-ascii?Q?aWuviOXwtTctORL0FzCSpVrxumihu1M3RVw9OzI1eWznEaUkWY9IiO2gxvyW?=
 =?us-ascii?Q?Qx9WTrrTDxqVs3V5pI0pbfgjFLNq4gtnuvqhxlHuMgpbv5WqzeUiTmjhMCiG?=
 =?us-ascii?Q?CSdxROud5OKnCnubYyYzCqdeCjKvt0t9s4H3iCikEE/dVBeQdNtpvGaoMM4g?=
 =?us-ascii?Q?vIbyDp6d2HwmWuR9DhgTGNskA+ktjYRwI+SGLD5DdM+cVeflrrWlDheYMhEY?=
 =?us-ascii?Q?TuXcK09/UpIcvPgXebIe/ujsH0VJpQVevU+mbm+0YA7EQ0ify/s2ZjnXc78W?=
 =?us-ascii?Q?hd/6N0LSQR/CJ8wH8HwWsRt8TC/TKdIqzq2ALDLcgqRfWeM8pMUAyYQav6JY?=
 =?us-ascii?Q?Tnx7WM064RHC/dSepFOYvxEhJ4iqLy5n7eI72BBowPEt+sk5mwZoLKLiEFlE?=
 =?us-ascii?Q?ucoYQCU+Qrr8oT766HzYeYl3BuQNcOw4jwMoqEiSoHoCebgcQsMDw+nRlLJV?=
 =?us-ascii?Q?B5yjFOfIthB1eZIII+8RyysnrGfw32cxjXZzQUlgA+ByMSiB7HCdxlbe9Jtq?=
 =?us-ascii?Q?oFdy05DBV/5hIpiQjMowmZm7mh0AYt2/iIZ+6Sc44U5fxeWUIqnC2Gn6JYug?=
 =?us-ascii?Q?V+263p3ukg/xPBTSlSYs6bDG7mG2xlHI4Bzymc1ak1Lrqk4J91izhGulo8mM?=
 =?us-ascii?Q?Sb352GYWi2LyDeU97p18WoMyf9Y/FQOjSyNIQaF3jj1zrFxOSV3DzBQKnM3E?=
 =?us-ascii?Q?ZBYLR16sRPzsouqB2H5w5g6QtnFxNHxxAocY0c/HDx8+YxLSnwvavzNy2WHH?=
 =?us-ascii?Q?YMEfJE+2+CsuyDdNdsdp0Mz/ZG4KNEEPgcXdGt0b0Arb0EvN4vIWJekf28zy?=
 =?us-ascii?Q?a7UNFFFZQnh5N60F5WzT0WePhW3mB3PVtpWVnmKsKGez52E3e5BoF5lSHXY/?=
 =?us-ascii?Q?OrWMXb2Hvl64aJN8E2vIYEsuhcSrOODd2YxwJlPgB246eNFI1OtuQkwpr7NB?=
 =?us-ascii?Q?X+1rkI4CJCaUtFgTldSNNaoznVSdYWky7TtTNH0Ssu525ebOrCy4uLt2xrq4?=
 =?us-ascii?Q?oGuoPMFnaFwCm6WD/1+pqvbLtbnMI0TziWfvuFKaseUIWfezH8wC+HJfXpnr?=
 =?us-ascii?Q?upRhzg3+/1iirW70hDxgiQIxbZ9JGJDrMu4WPUiLLz8Zm/nTuufIF9sUOklA?=
 =?us-ascii?Q?qisUO26TFmKxajFIxgHaBFg1IKJN69O2gSGWB1eBM0CdDg+0fFhUhLBhPaJJ?=
 =?us-ascii?Q?mh6YQO8hQoO1wHGDzTO+hCPxLPcEtrRHTxESZC81BcwLO0OkzFA31FElT6MD?=
X-MS-Exchange-AntiSpam-MessageData-1: iBa0e50SgWxr5hWB1mEDUOm+6dmCcPdDjlw=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70277f0c-a5d6-4259-306a-08dee2536eb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:28:30.1937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmTJOoiy0JGMP8YFzb3MBEiHLxkyvWtL4VR7t2Gy7QMtWDHDOj3lNpnYIbyeoJ9znVpcVWf7/XV60BaQynm4Xp1twy6xNHl9+OrdeKsGVdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3745

Use stress-ng to apply CPU, virtual memory, FPU register, and procfs load
during EVL tests, mimicking the stressors used in Xenomai 3.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/lib/gitlab-ci-base.yml | 2 ++
 ci/xenomai_4_evl.yml      | 2 +-
 ci/xenomai_4_next.yml     | 2 +-
 kas/opt/ci.yaml           | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
index 0540628..a3359bb 100644
--- a/ci/lib/gitlab-ci-base.yml
+++ b/ci/lib/gitlab-ci-base.yml
@@ -25,6 +25,8 @@ variables:
   ADDITIONAL_TEST_TIMEOUT_MINUTES: 10
   TEST_MAXIMUM_LATENCY: 0
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
+  EVL_STRESS_COMMAND: stress-ng --cpu 1 --vm 1 --vm-bytes 64M --fp 1 --procfs 1
+  EVL_TEST_COMMAND: evl test --stress-cmd "${EVL_STRESS_COMMAND}" -k $(evl test -l | grep -Ev "${EVL_TESTS_SKIP_PATTERN}")
   SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
   SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
   SSTATE_MAX_AGE: 14d
diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
index 283a1fd..c6a92b8 100644
--- a/ci/xenomai_4_evl.yml
+++ b/ci/xenomai_4_evl.yml
@@ -29,4 +29,4 @@ variables:
   XENOMAI_VERSION: "4-next"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   CACHE_KERNEL: evl
-  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
+  TEST_COMMAND: "${EVL_TEST_COMMAND}"
diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
index 6ef4b6a..7ecfbb5 100644
--- a/ci/xenomai_4_next.yml
+++ b/ci/xenomai_4_next.yml
@@ -21,4 +21,4 @@ variables:
   KERNEL_VERSION_WITH_QEMU: "head"
   BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   CACHE_KERNEL: evl
-  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
+  TEST_COMMAND: "${EVL_TEST_COMMAND}"
diff --git a/kas/opt/ci.yaml b/kas/opt/ci.yaml
index e1466a0..f9e4bb7 100644
--- a/kas/opt/ci.yaml
+++ b/kas/opt/ci.yaml
@@ -20,6 +20,7 @@ local_conf_header:
   xenomai-ci: |
     ROOTFS_POSTPROCESS_COMMAND:remove = "image_postprocess_sshd_key_regen"
     IMAGE_INSTALL += "customizations-ci"
+    IMAGE_PREINSTALL += "stress-ng"
     IMAGE_INSTALL:remove = "sshd-regen-keys"
     IMAGE_INSTALL:remove = "expand-on-first-boot"
     IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
-- 
2.43.0

