Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010042.outbound.protection.outlook.com [52.101.69.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCB429006
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107730; cv=fail; b=TsGWdWfsBqMiT5Z24jz5eAqQrDUIFtlFwYM+sgqO8JhK//+y4HDgId0uf9bOnHYo9Bu54e/URhrspPsHPEa9mOz/HgdQODlIEqp7AWCDVTS4tDJNm7ZU8yDHAe2F7C+Xzon+eo1Fk/BFI5LXqxQrv2+zsSGhGh4Yo8j7FMDk4iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107730; c=relaxed/simple;
	bh=lE+hErp2so0YA+DwXFsPEcHJrLBXmGNyi5PLvec+Er0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwPpXLS4sdzm4/7++D21JFEuj9bKnreILjiGd29e0FKqbB66Oxf4UfgstUGftAqtpxfk0PnRyhM1flfslJ4CFvFMykEL8vQl8PJScr6VAz4nuFagRkHDrUdbknh2FaYFotN4QOeTqopM4vFBLY978mZksVmkJsuXqo2f7LH2aW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=miS2LEgR; arc=fail smtp.client-ip=52.101.69.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="miS2LEgR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yisQgiTEiAataCl62ckNtV1yDFExI6EiX/IaeX6GF+Zm8Dw5aWIajU6WV/rEmCmZbZCceA5+yLIxLqvgpEHOgDnVd9IrM5tuAsiDc2tRsIx+Q6GZXuKb7Mmjdn3kBwpxAqul+rAtgBRSh55agRhGzag2vNr6GljCHfp5yCryOOd3L16ieLzWCPDSNK19VE5pVerYikAZEGtWcD+X/VZ/1ksY13wEVNHztU0lgqZfsdO9DSaeXYMm6WCpr8PXOshO2D7VBzuP3R5MQsn/e4A/Ucp6metbF7U8Ub0TkcXIR27xCfYdplAM4L/ECNa0E0B749uHVDAPJPgJMVHsJHmreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWqiGbPuhhTF9Tcft8R/9I3JTWXIkcwsKorit6VgEtU=;
 b=TazxtCsmzXGj39sjoe9/Nc1BRA7ME4u2f3yQFXChh9VfPvBLisFKNZfXdaswFEpjb05sIkd87urkxewkFZlTRNU4556DH5YoDHyJGXN0f4B9NllfuTUNf0bi/gPW9y1wUmv9gAG7nlzrIzAGfHY8JB4rchJqCoOrkYBnfwoxm60UgB6RBEH95Q8jSP3WR28Q8+KRkf0ruCdDKVuMV9ZtuCO70RRdcY+yi6thpbTtjTpDYu68LpijstuAsNsYxxQYPyYr/64O7Gjdk2ISMVxwA2AHHc3qyLemZvkm33co6rIHWbcp9Ltl95IkOBfis7/WGQ/zKajG/wRf4Fp2VeYN3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWqiGbPuhhTF9Tcft8R/9I3JTWXIkcwsKorit6VgEtU=;
 b=miS2LEgRuaMpEXgreax/tL40DMjzW3qASO7jQGEJUJzQQD+7PR6KSn349STZgOLXAe4Gx02bjf854UdHIU5Xm6ZEQPWKXBfDo7qg0jSDbtJoD7Kd9xaybBzVAa86y27WSeHBgtKq1gvaku4k246Duy4kjoYoCuFbBumRe2uJGekESeeLf2JhHfwAJPhukdgSJrohnjtZwzQq4pvt+R9lTDhH6ZOwqmAb6XLwJC+s+3xaGXr/kn8YtFhwoTki18DzhenOsgHhGqogKI7k2VBZwid96C4SzxsC5Gfi6af4l7+Dsf1CpHlueQGuKqya55qNT5hJtUQPlV1Q0qBptu/DvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3745.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 09:28:31 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:28:31 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images 3/3] ci: add long-term EVL CI test pipeline
Date: Wed, 15 Jul 2026 11:28:22 +0200
Message-ID: <20260715092822.223712-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: d5dbeaa0-9f22-4623-eb7f-08dee2536f6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10070799003|55112099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GskB56Fkp3fOPnNah04MVGobAiA61Z3GYJ1b0hSTitIDzpwJlzGMZLewdIgv6qNbitS/WijHg8HwgVp8RXSfa/71mq4M2yfZsr0xAl9yb/Lec/RXq0UHGU5EheqKk/G2Y/1K3fVbNXlcI8Sd2fd1NqwgibjUWHJ8UlnQhhTJrS+y9d8elkeq3yJpbNsIFR07G8tA5HXa+Tic4giv7QiJUWjHfctKrthQHbhzc5cGKfUTYobF/WvS9yI2vLjrqeuJscVUmnTvcTErbuV6TaMPGbJm+stBKi6qZHMMFya633sljho+ZowcZeZqjCM3QDTdwKaGQzMyUgwm+0JsyRJUToATIAlHOiMBgggqJYjPXMGvrc5cHVChbd9SwTFA/nh70pDUV71mFwAdUPX3PSVqi6ew60VNW2qosmlW8PRqRr0eFe+TYbAmw+QoXoAv6IkdOaBXqTsqfxay+bbzLwjBRzUlyDOqUZ3KfxpBQ/5DFSlImYIs+0N7bcEOfIm6CwJvRihfQCgoYJdtmzpH6M95hlhGIG4ah1rR37CnccFrLeIBlhfcbC69+8MoKQIJZeHvp+mdYn1InTaix5yyeIWFKjpoW4BuXR3w3HtET0oaq/zQy9hx7D8MtAiPIZLxzX7FdB0je1bbf1WXe1mSnaYB+cZLPe9gvjAeu8XuZ4kJ2qU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10070799003)(55112099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FSfNNSWylwOlP5007dhNEuda6cWQPlboZikC5V2ciDhx+Di5eYUZMnG2UOJJ?=
 =?us-ascii?Q?CIDQOa6Q/7RhrTyjmHZ6QxxVYNf4S+ee06a8+i3Ctd1dcUxWWDlJL/nl3Md9?=
 =?us-ascii?Q?T5CShZEcb8iydtA8IEw/CTOhWexWViOTNPq9D844GxdiE2r4AoBR+sYj1sVT?=
 =?us-ascii?Q?b5Y2nsEvUHy0cXMyTNPjQ3v2E4GpFIVdNmPu2YMGJvJalBj6pOMmTF5mQgCa?=
 =?us-ascii?Q?QJGEad0xo+NZ+ZGPkyjjuluWlv5xwZSU4aiNU/QV6P70kzdb72NdF8QR2NDn?=
 =?us-ascii?Q?uoB+zjpiyRyCgYKct2JvO0N7faj5g1HLiRb5EiLEDgGKQDBj/nUc/bt+1TXK?=
 =?us-ascii?Q?KAYSKUMDCFhKpFAOEgJy49Pbj7qIKAcKZlKOApwFsrPIMFY5RbIyMOT6hMx1?=
 =?us-ascii?Q?19ce1nHsX+XkGW/uU3OSKZ5DNCGEX7D9uok7G5q5nhqZsn8BHhuqBzwMrHn2?=
 =?us-ascii?Q?atKq2n2pclfCR7sEBaw9B1rZIMIwyYhkFZqXjx2D+CTY1SaXyl5VumBDW2ZT?=
 =?us-ascii?Q?7xZ3NlQ3S50Bv1xWaKhr4dYoOJBK2CQ3mn6rQ8R7tVaiOonwpktv8uTMzKXS?=
 =?us-ascii?Q?MVWde60xxUTHwsf5bM+ZdhTlnx+0joZ5ni6+kmoW+vYMkiRmHEyFwUNdNiHq?=
 =?us-ascii?Q?/qx2lzFvmF7skQiKERjr1PLqRxXzjQt49RwGc4tZkT6YSxQaRTTlfJRLOfhJ?=
 =?us-ascii?Q?nH58JZFfYeQ2QMPMDBzioforN2FR1C/TbExALmJ+rbBGfK6R29TNoupngPyA?=
 =?us-ascii?Q?BmaQlDC9JFoXoEVlgyiDBOPoaqqDpcToxsRRx6IfqArPTYN2Q9o96ypajBe0?=
 =?us-ascii?Q?Pkx1FlBFrwisD8V/hZetPXEHHhkMMaV1V2R/u0dJhCS3wMV7x5F6HN4kBbGm?=
 =?us-ascii?Q?hsMeoUhFT/vtVrjtdafVMU3gj9QQhjgdHlNuqa1BsVxVap+dKpnKbSohhheW?=
 =?us-ascii?Q?jtIaXyHaOchwBiklY1lvzY8ctVKE71sXDaTXtCZixNLvWSze4kQfXR/wZD40?=
 =?us-ascii?Q?YZbfi8yPtGmQxc0rusBnvNAwy1t15VZl+JS89HYiDWOkBOHe7EC/63p14/pe?=
 =?us-ascii?Q?bLorXB4vCgf3SYoYv9AoJnmOiiSzkGObtXxQdd1WRhME4rdCTlfntDIA6vgX?=
 =?us-ascii?Q?6r4ZbbPUzaFaC7OtOg7/+xwJ6Rv7dnirAzWDrcOjVm8xP1S7sZW6S3fponVq?=
 =?us-ascii?Q?563GZL8Mdr1Qln1Fw55U/wydb1oQMRlmHCLfnp+yegjBs0FU2QQCIbDciLBk?=
 =?us-ascii?Q?uktp7YQS2LKegfePhw54nwouMZjbLN7a/nTsO6wr0DUHTWcINdID1cUr0TxE?=
 =?us-ascii?Q?hiPfQ+uP4IqT0MpMPpajlW54/CfX1y/a+3wkUUM3FX5phj72utg3j2HyP/ZN?=
 =?us-ascii?Q?j14OEGki0k4T+FwJueol61qggiX+6l347O57hlBsur5I5jLRL7Fa0QemKXOJ?=
 =?us-ascii?Q?7wt9UQq8vG+h7aiLGwCU3xoDG3JXJWbw2XTuz0CWfNXYYLCqAqlLGAAbgTDD?=
 =?us-ascii?Q?2M3hzgovWiPTd/l9HuRd1DMRjeknnUiGRMgUoQsxEgmmNso5Xjj4Wu7sgkEm?=
 =?us-ascii?Q?rbi9S6FDwldNJK6BwiOSExDHck/61C+bShGJ647DMvYgphbo2qitnUy36UsC?=
 =?us-ascii?Q?f5i+Mjp3sS77ix7L2p59kkE2CtK9caEHZYXhsb5ZG9JRBW/keNyVCxVhIX7o?=
 =?us-ascii?Q?yhp8ZhA78beETyqJvuyX0NhNXHCXkMA4cAU4tHd5qYuzCx13mufn1JCwuudD?=
 =?us-ascii?Q?3KybODVz8AYkWXcPqGMQrIhQ6Hy2emLPuoUgX6VI7byMmvAzzbGAtyAOfuQ7?=
X-MS-Exchange-AntiSpam-MessageData-1: /XG7No2ITh2XnUweiucgm8MhMtfOJvpnDSQ=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5dbeaa0-9f22-4623-eb7f-08dee2536f6f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:28:31.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUFB0iJIaPAc/+01cXADhtDDba81FkQxUM6DtlKcwedjpz9KN/0BlO5SqspRvFA0o/O4hrYRcYKDBfwuNXZ3l/1btNAO11Pvx5SkVTVAMAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3745

Add a scheduled Xenomai 4-next long-term CI job with a dedicated
pipeline configuration running extended EVL stress and latency tests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .gitlab-ci.yml                  |  8 ++++++++
 ci/xenomai_4_next_long_term.yml | 24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 ci/xenomai_4_next_long_term.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b3d025e..589db8e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -91,6 +91,14 @@ xenomai-4/next:
     include:
       - local: '/ci/xenomai_4_next.yml'
 
+xenomai-4/next-long-term:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_4_next_long_term.yml'
+  rules:
+    - if: '$CI_PIPELINE_SOURCE == "schedule" && $ONLY_RUN == $CI_JOB_NAME'
+
 xenomai-4/evl:
   extends: .parent
   trigger:
diff --git a/ci/xenomai_4_next_long_term.yml b/ci/xenomai_4_next_long_term.yml
new file mode 100644
index 0000000..906f23b
--- /dev/null
+++ b/ci/xenomai_4_next_long_term.yml
@@ -0,0 +1,24 @@
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
+include:
+  - local: '/ci/lib/gitlab-ci-base.yml'
+  - local: '/ci/lib/kernel/6_18_physical.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":kas/opt/libevl-next.yaml"
+  XENOMAI_VERSION: "4-next"
+  BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
+  CACHE_KERNEL: evl
+  TEST_RUNTIME_SECONDS: 3600
+  TEST_COMMAND: >-
+    evl test --stress-cmd "${EVL_STRESS_COMMAND}" -k $(evl test -l | grep -Ev "${EVL_TESTS_SKIP_PATTERN}") &&
+    evl test --stress-cmd "${EVL_STRESS_COMMAND}" latmus -- -T ${TEST_RUNTIME_SECONDS} -A ${TEST_MAXIMUM_LATENCY}
-- 
2.43.0

