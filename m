Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10261153509
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514145; cv=fail; b=TyV3LSC9SnOxIkALUmj1DmOcW9cPka1w/hu11yKWn4NripZlTSxF62jYZ7mwkKYvWropxV2EO/xKQgm1oBbrR3tMMZHgxjfBRa74+zUEGPZw9l7Lsww0rsNIKVlLEOgI/nOerFVlUywoGrgky8glmKIJk1RWB4fllTF3gCKibYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514145; c=relaxed/simple;
	bh=NYGN85lMEOD0CzsnV8EICiUDIBp8Jz+Anjp8RkMRvfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qB50G/KoQ6fQAVqASDxnU/jiD1MB4pwSIvjIDcyd7pKkw5LFHZfmCLKK2dIT6LILTFp3Nc5bP6uTJ7cE5mOv7FfDg7mHMU8QS83l9ncuaTbFI1Rt1QMaoIiNCTPQc6hjgl1i5tqGPtIh5DHtSJX2SyYaYlYWF0RyXSB2WlmF3Ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=oXhDpL76; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="oXhDpL76"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHnUtFlbPvx0jkbYa9eyGCf/FMkzsM8WQ690CLgFwtJhduK49SYCrvbPFElR2ViiNiXZX/jRzuspwFu92wkmbwmkb1GaRCSFnPeII27YJ/vbz45JT7PAQulzZ2llTmIPkDV+vlQD17zwIqGA4AuD1m1lY6rX5WMZ/THoFyvm53GF7IT+DMN8h7gjHwbbZWpSSDElzCABmf6JCAtucS6/6r0tVamYOEqXo1Xvzl5KaEhHx6j5ApKzvz4C3jTn+2ijWISJjouYS67Oa1sG9okxqrOtBsjFAdOntMmOX8YQSNMQqW+ks9Dgod3yIC0EpCtmYqXmvX/ObKOoAkT+CX+bmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXdaL0xNos5iVyXZ6Dzu8NFVwddvuiSyZ3W3y0G+cJQ=;
 b=ihZKQFVvab5ykZSCBYQXdjKLMyXx+95JoJy2rwZqE0Lu+VANWUmixjKlvFlAwmkfmg5Kk/ZEOA7jc0j03EvsBVzi1jclA/NVXp2czcAPtX9iMY+yb3T13H8/9bvhy/rpm4XBCRWqsIrSBT6EG5c9ZzqvMw+77wVifr+rYfdm02pfEIx3zlmKBSlqzauOPaAgOJN/8dXvmtNAeTQZ6/4GBIsRUjdXaoYoeQZgqTeA8cMpG4w8kaohrkM+EHGe59e3EGcGCqPmPeDeIMvdeI0BEz0TheVluEcz/nzoOBrwj9LlX1DTYTA4RKM+SeyOPfj6R1FYu2q0bxoLralxyKjz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXdaL0xNos5iVyXZ6Dzu8NFVwddvuiSyZ3W3y0G+cJQ=;
 b=oXhDpL76K6SEtf5ZYzQsJsxUPZLiHepd846zyt9eEBVWEJh8n0ENR1eDoYURUQr2rNl2PskJ70LspYUedDHka3mRQopH85s9jhxKhwrm03OSdQ1ezt9UvoMEWSMkoEhhD06/3YmgKsAm3JTyhPzZvGlwWMYuYq0qh8QBT0edeJxrft6HH4NnYMxcRbdXRvpaQXaPQWKu0UJEQ7MmTqtkSeR5P8JKc44wBzBq2tuZIThUNHRWFT6SHazwLjxhM4e4uDvJTgqLg18cFRUGsfo5DjCvG/QWK5HfhoVaPSmCvba6Kky5TFBBRoZK6gxz4i54GVr0EN1io3iLMG/z0+m/IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB6436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:35:33 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:35:33 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 2/5] ci: Split kernel 6.6 config into physical and virtual targets
Date: Tue,  9 Jul 2024 10:35:21 +0200
Message-Id: <20240709083524.739194-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240709083524.739194-1-tobias.schaffner@siemens.com>
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: b70df86c-935a-4c88-64d1-08dc9ff2193f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lcD5GkvuCrZX4/rzlE0kzpd4BLIaNviRWyGt9xUFCREudm+XcTQDC6Cnlg3T?=
 =?us-ascii?Q?Wv/EDAlbg8pVkb1tNbpjmat9B8QFvD6cWJBmRGG21x8BV8eqswJs5Nq/OLsp?=
 =?us-ascii?Q?tx6XrpNFSIWISu6p/5e6qSD8oa35Dqb3lpwAzuyiWePfxDV6ZjWhWDyNh1S4?=
 =?us-ascii?Q?9d9cXOrC8gCKcsI6N6WydO9OE9PuzCAUoL7rDrTMZXq7zS2ERrFpP/E5fzEu?=
 =?us-ascii?Q?XuzCgMyS8D3T0m9sADqtRG1Svr6eo7MQjEDcFmf0j20eKeCcgA6sQbCEz6U2?=
 =?us-ascii?Q?RX0BLlFFMXSliXOtiA2gb2oMLelWStFDEXjMtdVwXKLv+Wz0RA9lMaqiOFPv?=
 =?us-ascii?Q?4+ZJpC0M1ccK0KHTe7U2mO85NOj6qfkPn9jWVsCf5zKQsSgrzjPVD8VgG+d3?=
 =?us-ascii?Q?3F2X/BAZ6T/X2CmdqV8oMhvEkcq0NLnEp24qmF+lK8FcUKgfAUPCYsmAyI8C?=
 =?us-ascii?Q?teR/lf27mO8+Q+Zl/uHJfQxKcbS08B2gquEG2aCjeRqHMfQVypkLoKj1IPNl?=
 =?us-ascii?Q?hnbG5tY0kMrWQsBumLX4ikfm9sbJu8hbDwDD5/JIuttfdZKgtgkIo4MwiqdA?=
 =?us-ascii?Q?on0Ka+yJjOJkj6c4ZjGE0IElF5FMIvnNjdH6clW9T5SgIJwUkRsG5TqQOsgT?=
 =?us-ascii?Q?dF+JlKHXQkXxsxLv1KH0q/D+SnWWDMwrZMwpev0h3+VN48PyJXbdAHf61BgB?=
 =?us-ascii?Q?Vwm8PYwT6/ILbhChDNrTnPIv1Ja1ZdG54joPY4UVbVP1cp1Gj8+NiVQm1vVJ?=
 =?us-ascii?Q?vE0Crq07ihrpkDrHoBNeUlGSH1eimEzrprsGKf6j8eafhCSc9e39uRtyMF8z?=
 =?us-ascii?Q?PlLO/7EPocniCYFdgT8ySODtNm4x7C6R6yiQ9VLv1TF2Ng+n1PQhrYVT2rx9?=
 =?us-ascii?Q?lBqYAwms3hJLO9NBw49n/D5j/dKWiNTdKRphnf4/cEDmZ4FNPpI8RZ6Sp7Cx?=
 =?us-ascii?Q?DzOhCyDc9Sso+MVQ3aWVjFWklROFmgweUI1rL1cU0i2Jarf8XZoLupscYmBR?=
 =?us-ascii?Q?tNRIV5DohGv1kbs4O/Qj68x+/rnkRogfE11hIiLH3p1vCh11TbdW6dryEcI7?=
 =?us-ascii?Q?kz5JF7mdKMSHxuUf0px7X+/bkbFQtpeKMQe2UV/lqPVl+AciFCvMwF8RZAJ5?=
 =?us-ascii?Q?9Yz43hdVhHMLorxw0nlgDtI6YnGNB1nMJLErSiTR9xC5nJ1ZVvWdlc0CNHsh?=
 =?us-ascii?Q?tnqrFXmKlqjybXrnKpKF6cSVifs3mnI8fSnu/IlbEcrhxq0FAj5lTzz8FQrK?=
 =?us-ascii?Q?2nql5zXzGVngrp7vRBB+HSR87oMAlaC0bJuFmgh7ot+9/GZgPFrWjZOHakbD?=
 =?us-ascii?Q?c2kWXwZpzsZ5TQpDm1cKM89aaVaz/AYjNV47L+NbfCGIgA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z2DG3CQA4H1AG5+JZTDBSsbtKxeiLI06oK3gY1DLpsyPHRNXHbR5CQsbohg9?=
 =?us-ascii?Q?lWlbv9Fd8MdmWYj5t+gxszVIgNbhZrKShs3YgQQeprn6ZRp3ipUlQNV0rONE?=
 =?us-ascii?Q?4eYrOEloEEXHRfPXnyoxHZNTGKPiFLUccaCM1NDbjTrVe6UIMv43kRwSDUaO?=
 =?us-ascii?Q?LTDHc7biJSeSCweIL6IH2ut8Fyrf11qNdMCs1MQG2B9zIq5mFmiY6nq59OCO?=
 =?us-ascii?Q?1qQFXqWzQ/H+57DmVQmATL04xnwN9L2FDOU8KXVfaD4dPkOr1vY2caeqJBWS?=
 =?us-ascii?Q?QWKpPWdDQCDkgZDhtsXJyrJnXFOyras1mOUnZAumWAJJT+uRJVrh6SwfHdpO?=
 =?us-ascii?Q?nVt7mL/uHsbkFaQQAYJhiUKZ2VIXve4BzD9XH3wl34/mQ7SRnrdAmEwOal74?=
 =?us-ascii?Q?kVxAlq9sYJy+3pe/aVhRSO9goTwTBrpoApV7RihqYKgXE3U8RWH9dkgOBN2e?=
 =?us-ascii?Q?GehMc/NRrCc80gHZwyEK4qeIupH2DqagKmAZxF/5YMBnX/uymfAeIzde5vJZ?=
 =?us-ascii?Q?KNwhw8nsxIaSro2oWxID/d5LVKz+1DXZARZkUHtoh0dg8JGYsybx/IZIxOjc?=
 =?us-ascii?Q?gv9UlLNWHZDBY6O/n9XXJyNA9sWSSggU8g2Ccq5Wqc2us0/6Nwl3tv7sY394?=
 =?us-ascii?Q?aezn4Bt+q7dkvRxNSsc5eKG62uiGarYnJzmV9PpqQlsenq6HZQAd2PwXTm4K?=
 =?us-ascii?Q?yBMqXKcNq8NxA8AS00COm7aPSi2UwZlnCcmGbrdt79yVpCpwX/vsQqEvNmsc?=
 =?us-ascii?Q?VjHEXW88jTvsdBEDmjtwa1STgYgFf9ROTks1zD+WjNNBxKKajBOyaU9YXkab?=
 =?us-ascii?Q?3RNAyXf5Pk75dO/yBeDWqMNzkzF+JYD+RxFDdmAKbXO3qWWaP6ruJQsyGb+C?=
 =?us-ascii?Q?zGcTb+7MO30D9VH6V4Gh6OBE+ERZNgabVI6uicqldvvrP9K/DJqbLXX8/4Pu?=
 =?us-ascii?Q?fHqQ18eOm+UjKtMWv/yxuIrKYXuObkUuG/Fznsf/cG7vLtG8qI81D2761TY8?=
 =?us-ascii?Q?tIvGI83Ckz2/tqSSxi4KUFR7qQaDLYJnWw5TDVUdqCxJBxl/4ZfDVCHqKNgR?=
 =?us-ascii?Q?cm5RbAkt5Dz3wo4JR74sSomY0WrQz+iW7OH4zE8kC0FocCXtzux9hWsqkEzS?=
 =?us-ascii?Q?enC+1Kx+KIsTt9xr7v1Z/DWKuH0QXETFvvDxMWQJLAMi+0DLtk3HNgt1c0g9?=
 =?us-ascii?Q?673MW7ZndoNs1ZwADSdEsLhA2Y/svNapQXnvIYGd611J/11Cvkvx+Tn5z6u1?=
 =?us-ascii?Q?TLoyLuhPc5MksBX7G25XTwGIYFsfZyN+lP5QMxjT/Ey6ZoxuEraZU4c9v2yM?=
 =?us-ascii?Q?SBYg25vzijOUwmG1Ki1ixT7rjiKt4zxZQ9kx5oHXqRILWE0VV+EcD8DYBePl?=
 =?us-ascii?Q?WzPAE/+Ers4fJeWkqszGtq+0QVhkfQffoT/RB44oenkF3BaSCAHvqnik0AO1?=
 =?us-ascii?Q?bX68QVRklOeEOCmBBkXMVqJZudUEyZgczL9hYiHcdhDOzwTnQ2KkKk9tk77+?=
 =?us-ascii?Q?QovCxSAnrFv19ZanF3eBquADK6qN/WE7cQZ2KFs7Q5Fu1nyUAHQxXEQBtyId?=
 =?us-ascii?Q?d6px/+XE9J2FTJGm1x/YBZdRTb9QVaoSfucVbd/f9GhK5oD7FevQPP2Qw8FQ?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70df86c-935a-4c88-64d1-08dc9ff2193f
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:35:33.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAzKhdvTreYGt8W7LMKyv0sjzhwudxaRT6p9bVqA3btGX12YaawmUW/KQzZwLpV5dY2MZL2tjNAzfmmbvlox28s7BPGBX1PkzbuQnm0VyPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6436

Long term latency tests only make sense on physical targets. Split the
build and test configuration into virtual and physical targets to allow
the selection of the latter when running long term tests.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/kernel_6_6.yml          | 29 +++--------------------------
 ci/kernel_6_6_physical.yml | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 26 deletions(-)
 create mode 100644 ci/kernel_6_6_physical.yml

diff --git a/ci/kernel_6_6.yml b/ci/kernel_6_6.yml
index 3d1e3ec..e9efe20 100644
--- a/ci/kernel_6_6.yml
+++ b/ci/kernel_6_6.yml
@@ -9,6 +9,9 @@
 # SPDX-License-Identifier: MIT
 #
 
+include:
+  - local: '/ci/kernel_6_6_physical.yml'
+
 build-6.6:qemu-amd64:
   extends: .build:qemu-amd64
   variables:
@@ -48,32 +51,6 @@ lava-test-6.6:qemu-arm64:
   variables:
     KERNEL_VERSION: "6.6"
 
-build-6.6:rpi4:
-  extends: .build:rpi4
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.6:rpi4:
-  needs: [ "build-6.6:rpi4" ]
-  extends: .lava-test:rpi4
-  variables:
-    KERNEL_VERSION: "6.6"
-
-build-6.6:beagle-bone-black:
-  extends: .build:beagle-bone-black
-  variables:
-    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
-    KERNEL_VERSION: "6.6"
-    CACHE_KERNEL: dovetail
-
-lava-test-6.6:beagle-bone-black:
-  needs: [ "build-6.6:beagle-bone-black" ]
-  extends: .lava-test:beagle-bone-black
-  variables:
-    KERNEL_VERSION: "6.6"
-
 build-6.6:x86-64-efi:
   extends: .build:x86-64-efi
   variables:
diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
new file mode 100644
index 0000000..95fc4f2
--- /dev/null
+++ b/ci/kernel_6_6_physical.yml
@@ -0,0 +1,36 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+build-6.6:rpi4:
+  extends: .build:rpi4
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
+    KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.6:rpi4:
+  needs: [ "build-6.6:rpi4" ]
+  extends: .lava-test:rpi4
+  variables:
+    KERNEL_VERSION: "6.6"
+
+build-6.6:beagle-bone-black:
+  extends: .build:beagle-bone-black
+  variables:
+    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
+    KERNEL_VERSION: "6.6"
+    CACHE_KERNEL: dovetail
+
+lava-test-6.6:beagle-bone-black:
+  needs: [ "build-6.6:beagle-bone-black" ]
+  extends: .lava-test:beagle-bone-black
+  variables:
+    KERNEL_VERSION: "6.6"
-- 
2.40.1

