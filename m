Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2066.outbound.protection.outlook.com [40.107.6.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6E219E5
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TOH61NU3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WopIPBL6bR8jhxo+b75rYPbNtz5yztvFkFxR2NSnzmd/clAPlajS1Ui5d9xH++AUrHYxUUl+FD2iJgT/WBwlHEaoi8tdtfpAcLlY8O6oX2Ddb8154QV4OKssmfUtxA+Gt2RbgjTvgMh8dO/b2to26/Jfwno+OStEpr2z9Qun4I7YwluXOExwfG8XBOo/yeqehuzjCGhle6KKb8Emdz3ZGKYMZC2B3AalCGyPWwl7SnUlvHv6t7W1p0O5V+M9SnPbXARgDAS3xYIrXwQARlrpFBMTUuopK7odUD5mCgrgM760MYPvcb0BS8Ea2HQnqrcMsejO/W0nMyYwCXYFZr8Ktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSdzNrtV7fFRlGgJ1clDQKuTfKu61GS3Kcw/r0KKH04=;
 b=QAHrKpDJaQRkGPHyi4JIYCo/CmwUSV/92NaECc7vj7PgkDYfzCQB2blKKinnC9IHSFc3AiPMLnDtHZgY2EhYrQ4xqAslFVk5IVlN+wtsxbqUaCiv8Qz32yx8AAH0xiOdx93U3jwAktYKNP0b/gMDx7vTeSNSbtO7FxjBnOqtgaM5az++zKsFn8lqaJ7OgUbZ/l+4DVvwvQA90ZZwq87T2StnbvjTU4v/qfsw+A0IYcQKGC6Ey7thIay4cj44xpwLJB8wzKLPIelDZG7NbcoQAnQl0ZWL4YfEVYnzBIVryLh8I7gh3SQIJNVJxQMwcpCQmPnt3rVwEnXcVxFyQntOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSdzNrtV7fFRlGgJ1clDQKuTfKu61GS3Kcw/r0KKH04=;
 b=TOH61NU3abVK2yZdMRRgWCqJ2pUrJS0d/DvULmraPnTLoj0qPBZZ5J9m9jWLPUh8DVGXrL1oOXFPzFynuM4b9AkqI5mK8lFOWgpT3+WhxlFTEYNdyiC2FgNq2gGfFNbE1njZsCBhQ3GMoN5tpa5fm8D88aea6iTolIxmu2F0SP9/RKS7b2QWbjLdzQUJrbqwB++V47HAu9wM52jG3Tk38VOOZ59skJz8NYpLKv/p4eCeo8BLeiPsE74OhfDLx1AbSc747SSpN0HUj2U0tbbYTkZvwHDukJp8bSV+++MTl0CBLFay6Ms0bssAQrDPpfxTix7vMjBDEkrcBfvHIc3bDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by PAWPR10MB6902.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 12:29:09 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::55c1:2302:1bd8:d9db]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::55c1:2302:1bd8:d9db%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 12:29:09 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] ci: Disable bracketed paste mode
Date: Thu,  4 Jan 2024 13:29:04 +0100
Message-ID: <20240104122904.2662979-1-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::11) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5712:EE_|PAWPR10MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: aa608ec3-5874-40ee-1f60-08dc0d20bff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+lJPCddFSzVFr3Tymqz7f84udqEGKsTLruSW5BaI/PfMMlDo6unR5LVgN4hR1iD02j2aWvSQqnKLM4kZxTeCQNpByZ7qJ3S16ZpRVU1RreG2/N1Bx/4G9OBeKEFTEgv27ZBbVWSWGJDy4uzcLK3GrJuBW5pHHFXh6A8+lyr1aubHiLZNMi+WH4XYDz8yGhhAieib1cR4DIF7Zdn4os4lch7GP3UPNA8emq+VUlGxr3wk9uOJkkOz/XK6ewvwcaj+OhpQ3TDDTLLgQoRlL6UQBMyIhA0UlxRo7GkUCWtOhC4u297QRE7z6aXrflr1/ns7cEX48tUf7+ldbjj6LBiFAm1d1fTf70BtQMWRH/iqtiG1GRrM43dBaFqvw329bihAaikd4DtjPCgCICgtLf0oPRkr21rpl/DuArApRVWnRI2EZlAwIzSd4km3RcH7bVkVcNcPXOKrhG9326C2o9IAKY8YyD5++kmX9SuGALbg0kH4AnRo/p4LHh3YHryhC/xmt3kBjTSijovlFqN+vPMs3ubJ75uWpd+CeJl7Wzn6LtA9+/VH1byAZCxi8JeMV899
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(478600001)(6486002)(6512007)(6666004)(82960400001)(86362001)(6506007)(83380400001)(38100700002)(1076003)(2906002)(2616005)(66946007)(41300700001)(4326008)(107886003)(316002)(6916009)(8936002)(8676002)(5660300002)(44832011)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGRIYvZaQ+pUFI4JVP4IXngfUAYBAgkYi0cqENcf6QKL3l/n6Np7sE2E721U?=
 =?us-ascii?Q?hIT2Sb9YCPix8TLc3OCW/0yYlpc9vY+lqEtu02rZ9Y4kTeH74/sx1OanIqwd?=
 =?us-ascii?Q?TN7IQ5ED2DPNsdf6HVZkgPEc740Rw5oMd0zdDqV7astJcwR/i1blzH7Vf4XU?=
 =?us-ascii?Q?HFXFAkbeuabtQ2bOPnOzzP6IBVfVUCpd7JMnQ7yvgcIu8JJ1UUtfjd1F7OJb?=
 =?us-ascii?Q?Z3NM8MjMyT/ZJeC3xqkvKqimr3vekxXf1payh0vU6y8j7cbMD/l2j1l3X7Sv?=
 =?us-ascii?Q?3fIFyF0b1kUwturkz8e6/RMXiQXW0AWTKdAhA6+VAtGhEZYxDRm1t7d3L0o5?=
 =?us-ascii?Q?n/lo+5RxY0VDPBtcAkXNUFAJDCaW4tCdDEuurHGri/hCMiaGLBLgSxUEztxn?=
 =?us-ascii?Q?vwxyy+N5rAL23O1EZUUeHrQ6/tCLAC/EMK3lVyDVMC9f5+HJ56g9rdPZVcZY?=
 =?us-ascii?Q?ox+jraX/I4i19VgqO1mAzNAaCsIlGDPXUI0HTpGmeWNJBwW1fyGkAiubvPG2?=
 =?us-ascii?Q?WE68L61s1huj2dd67izDDg/M7Z4IyUOIkfuELwfGf+THcGoTWcvV3OEsGpQ/?=
 =?us-ascii?Q?DRI9MooBN9JRHxez1ZPGk2X6DJRNwBuRzh1dnT4N5yw5CNwF2Lwis/J+1mbN?=
 =?us-ascii?Q?6pw48fJZLn0Qk9ccUxFWZAEDyhRg63BBeyapVIDizXF5FLQwzG+A2Up1Mt0N?=
 =?us-ascii?Q?ygPEMiV7Cc6nxMO5i2pFlF51R8Iv1K5giv8flFGMQRabcfIpLmukxxKfNHfB?=
 =?us-ascii?Q?YVbVluRLDrf+I2Vamq/TauCuR8bRScNJf1d7Q6IYQMaLT2lCuajCkzhXkM+i?=
 =?us-ascii?Q?v8R1oOm6BuK16QhGO21U1pGo2cr6vd2h8gCIuEVTSuOZCq8UeS0wwfPnSCuR?=
 =?us-ascii?Q?0ftVlAv20EefBLAESF96/YSaDQPS12bUwsCKHoC7Vqwi0//OABp9ou5tdE9p?=
 =?us-ascii?Q?6SwXXugS/3KJqFxF/jwMmt0hvPgnfb9ibHXo3UD+w1jmw4W+9/yl5Guyyrtm?=
 =?us-ascii?Q?foRjhriDsQY4cErUpFyAleBuyMBoYg9sm1kwYUxUBO40qef9ESVZahNxPkmK?=
 =?us-ascii?Q?cGd2V+4n6ZU8obqG8qGfZDl0L+vemU44kHa0u+f0HPMmUJW7jaL8jmfTLmbs?=
 =?us-ascii?Q?UZ1kmCE7seffJ4742OXIy7rqEny5zPXdZT4De99LHy7eA4Z+Wu4oke0IiR+j?=
 =?us-ascii?Q?eUoXNM7Pe4qi6uqOT7AARqajdKDnfGutk3mDdfH2ZAGrXbuzHPCm8fD0FVvl?=
 =?us-ascii?Q?oNxYJo5nt3zeSUe54476juWp1Yft7KexUN5wwyKprZOQGVh9F3MX4cM7aXtm?=
 =?us-ascii?Q?CjwOzZdzceRc4GFVhxgo12DgAXJrjG4eys8Rr2hyNejprn7MIiq0DVcNVvuy?=
 =?us-ascii?Q?LGQ9evrNTwYkDSIzzF79gV2y8rKcYs6bUyPW6N7WrVQXtEk1bvBNZN+bPkxH?=
 =?us-ascii?Q?Ns6qoMaLeTpYCPsA04EHlTsE5jUjMwXoBzWTX0vTyEPsah1pGPEVuZwIGTJV?=
 =?us-ascii?Q?lyfYDE+5vN2E+kNkkswZRMiPYFYAB0cC0iw+vA4qKMURDBsbyqeyA0kMAJsn?=
 =?us-ascii?Q?+2DIdEp7HkodR2Ax7RbEAJ+zohpmujP6I80PuMZ6h2GNz8qMRbDPh+dD0ay1?=
 =?us-ascii?Q?PGRkXu9taN0BN0uyT2M0RpnyLm18WAjS02Az6VrRHzVIZ4joMT6MQ4gs+oLG?=
 =?us-ascii?Q?WWfWxg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa608ec3-5874-40ee-1f60-08dc0d20bff8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 12:29:09.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1drh6e1SMr6fWA0Xw1roDaJfDAcnExaE3acHYgYIE8cyVIIg25iAg5mLrSaKCcbUjVFfRZk3UM8oRVJeyYM0y+6CpMUcIU5gWZpZs6l73w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6902

When looking at logs produced by our LAVA test runs something like the
following could be spotted:

	[?2004hroot@demo:~#

The escape sequence is triggered by the bracketed paste feature of bash.
From time to time this seems to confuse LAVA while searching / waiting
for prompts.

As this is a CI specific problem the feature will be disabled for CI
builds only - where opt-ci.yml is being used.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 opt-ci.yml                                    |  3 ++-
 .../customizations-ci/customizations-ci.bb    | 22 +++++++++++++++++++
 recipes-core/customizations-ci/files/postinst | 13 +++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/customizations-ci/customizations-ci.bb
 create mode 100644 recipes-core/customizations-ci/files/postinst

diff --git a/opt-ci.yml b/opt-ci.yml
index 431b070..3581315 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2022
+# Copyright (c) Siemens AG, 2021-2024
 #
 # Authors:
 #  Florian Bezdeka <florian.bezdeka@siemens.com>
@@ -21,6 +21,7 @@ header:
 local_conf_header:
   xenomai-ci: |
     ROOTFS_POSTPROCESS_COMMAND:remove = "image_postprocess_sshd_key_regen"
+    IMAGE_INSTALL += "customizations-ci"
     IMAGE_INSTALL:remove = "sshd-regen-keys"
     IMAGE_INSTALL:remove = "expand-on-first-boot"
     IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
diff --git a/recipes-core/customizations-ci/customizations-ci.bb b/recipes-core/customizations-ci/customizations-ci.bb
new file mode 100644
index 0000000..89bfed5
--- /dev/null
+++ b/recipes-core/customizations-ci/customizations-ci.bb
@@ -0,0 +1,22 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+DESCRIPTION = "CI specific image customizations"
+
+SRC_URI = " \
+    file://postinst \
+    "
+DEBIAN_DEPENDS = "bash"
+
+do_install() {
+}
diff --git a/recipes-core/customizations-ci/files/postinst b/recipes-core/customizations-ci/files/postinst
new file mode 100644
index 0000000..f89d9e9
--- /dev/null
+++ b/recipes-core/customizations-ci/files/postinst
@@ -0,0 +1,13 @@
+#!/bin/sh
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Florian Bezdeka <florian.bezdeka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+echo "bind 'set enable-bracketed-paste off'" >> /etc/bash.bashrc
-- 
2.43.0

