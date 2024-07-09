Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F0153509
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514149; cv=fail; b=FMn3hW8ps5KyAy4/VSlgWmIY2lGcvVyCdGeqw5Mr86GDqEdg6dW+oRPqFDmHpWbBYV898kjBxmeNOq1l9Lu9tXYpyDSP/MAQr7Q7x5FWCQYCAdKjb67kxdI20C0UsoskPtNnythnGMIMYAWg7M5vRXUMR82pNTle6UffEMrRFp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514149; c=relaxed/simple;
	bh=BW4/T5kNbCdrljwm6fcg26VroPVg0LIuRGT+7ZTX4qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RztROF5OObR9eQSU7Cn7LTOPsMM61j1wZ1cESBmsjg1i0wbpjl+5Y6d+H+F8/ROfMjFDupFCSuelEkEkZL4fEiiaT9ATuEZEVHAzBGqii0KiAUxhnNYbZf16GdQOei/hFpG+TFJsWf7ZACQbAJ4gTTNI+U466Yphthd2r9ImXnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zgh+cmkk; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zgh+cmkk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTzj0qmcxzPSxXPq7DMP1S1MiWoGAgTXpzfrvVHcNttO3vqFvAm0SY10kVRbCd1vtE8ceBc2WFNYVocpzo8I/R+zXO6bRhBEGzvlB3lTDrCe1Ye+FD4WG9IZez9Ait9aIpa134CBBrf14a4AM2E4RxPvOiFoh5YDoCF2/cUzssr7Rz1rExPVfzz3cFPIFTzsHjD0zKwb38gYyKPk3tIAy67zTTHu1kLR06XuNdSgrI2VNghDRscfaTQ7YSjQhhjvNYDtZU4paao+ReS3RK7nLUkcGkUUDGnHyEAeamrJPtWsAxT8dKReFxHTGmflR6AbzCjZubqZRHB9y4Z7vzCh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1tf4A8GHBjodNdJw913SGjrRzXOphhRH7rCQ8LHSRM=;
 b=fFTMDH34pyqhGPn5rfeMKcxFRhHdcGpuUOJX08Dvd9bFeqVGSVEsBOyfomwpNPGWp8r8Q+tdEdEckfUM6Y6mEnrqVK1HZygX4oE0BqzO1veernyASJzVecD/sdiVQhLVdzdA4mmSjrGI+jyLLMcHxslJCSGM3gqEjNGojoZrU8dPFiIcSkgEFEHiYAGS3Knzh1yMQiK0BQ9LSIWupQLA84ESmrsABYpu9oT7xZqsjgYFgGI3gNWmStT60Dz6oLAhOVKvN7t70bvQWgTjwCv6O3HCoxEXoSaePKS+1DiCJZwQ5/5O0yBS/HwCc9OxIwNNQHxvysSmiLmfxcNaIfpMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1tf4A8GHBjodNdJw913SGjrRzXOphhRH7rCQ8LHSRM=;
 b=zgh+cmkkFv/0Sker3G9BXnVL6O1Fz2WaJW2F8t4Hrcpio0gdBdlhTUqFcphiZ0AYy4s0nHdZVxOc1p/Kf3iaQLvPxi1JxC5Ef1Wz8d68kvkhd5rgBTQBMy2jxEHze+PpZptR+H4fKK22BADAl88pchzhiCv/nVIDBmZRdYZ+VU4zbi8Ihwdv0PuPUnFJikJWOjZLfrfM+YnVPhKHZZdfPHthroeZsme0iwfHRZHTwKHVawOeGO7MLs+CiUT2GACTHzYJ5ALAnQ5OyusCXgqtJcVz72EUqWxR67drqKs9UK9RQCo2E8nzoK7eFO4xFPUGQ0cxx34+phHkW+4MlsC6/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB6436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:35:36 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:35:36 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 4/5] ci: Add a long term latency test
Date: Tue,  9 Jul 2024 10:35:23 +0200
Message-Id: <20240709083524.739194-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240709083524.739194-1-tobias.schaffner@siemens.com>
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 8879e527-a9f9-48cc-34f8-08dc9ff21b19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eMYoBPhuuIiVNdaDN5fCScWtkzTAfRUHkRpCrxinK//hUBH1Vhh0dE6UiUux?=
 =?us-ascii?Q?avYRYl+lHd29thVL3ISIP/+evdtInJgbg7rFXV9Cm0zsZ0ht9bszXvub0ejW?=
 =?us-ascii?Q?dTLFcEpDGT8NFAwaa+YeHZbt1sWZ5/cTEYZ70T+QdAJOPZ0YPC6nMltAcVFF?=
 =?us-ascii?Q?uhW6BC+iSz7SRNqddrCRSpcJtp8YPifzzVX5/UXsEV3sp3BvJEh75GwwyB/n?=
 =?us-ascii?Q?mNtfldp6jx8JonX20Neq45bRyiSTsBeMtbHd/MGk9NEVtH/XR2rwjBpwYGo9?=
 =?us-ascii?Q?G/84QFbE5KulyUPsFSYsXQHZqY/q0Fb9gpQPoYEl9XXtm3CNyJ3WFM9ZcOFL?=
 =?us-ascii?Q?63X2OlvbbdBwnLoROinEWOvfkREKa2ASvc2V6UzN4fgb6bkf0Mhe3jpwiOhj?=
 =?us-ascii?Q?zVFvTPZLz8VgwwDC2+H3HTiALgtVOud1RYigzsSq5FKB92DSAUc4ZP11R5AV?=
 =?us-ascii?Q?PWQOLJZ9aI9Zf2Cu0IyNiE4gEHr8MmO7hytBvrGs3CUpF1/Atc444ZoLvL35?=
 =?us-ascii?Q?ClRW0EvRFMmkz5Ys656qx2ZA3PDhViXdNmDgY7wZFiB52ttnGH4MFDNKJrDv?=
 =?us-ascii?Q?YB7xN5GPx0TNbt8ylQzy8GQSFT37xmrpo7DLfkNeDGxOt/gGJNBJLJYCGX4P?=
 =?us-ascii?Q?cIXfvousMQEj8NbVH6XcQit6M7EW1xNtY7W0Zpc5Y44PB9D/KRb+dzuPS0xr?=
 =?us-ascii?Q?Nb4H4ZkbC5eGZ121XHXh998wK6sWNbLDYuUP1KNUWMYp3iljimPz1h3N+zQW?=
 =?us-ascii?Q?NYv3X6XFW1ubIY6yMFoxENckpwMvCPLhgdkIfjaGqJ11Q8eNoS6TUIoDQTCa?=
 =?us-ascii?Q?2Doauz41g0V65vmQ6qHBT74TtSJQIRJXLovB3sbkFqWrBvjcV+s7vZPrHP1D?=
 =?us-ascii?Q?KVXjoL2WxoRt+JVh+5JfiC3VPoF/jeAPKtSmjD7ncFJuarTRVctMU+P79Zpo?=
 =?us-ascii?Q?NCD5fzG9D9HwaGXROa52DHbLvzZmQIfgV9MMfmPA8/0VBSraNwatTLMutd/q?=
 =?us-ascii?Q?IUKsbrUsHsXUnln1i1+ndsxQ/kPzEBA7CP6trIyyKKZBc/r4hzwq/jhPfbBa?=
 =?us-ascii?Q?EHSG836MNbR9Idq55qjTXuR56YqzDZpdMbiBTepIyS6dyby96vYTquNXe14F?=
 =?us-ascii?Q?/I5SIcLTbKe+iU9V/vBkeIhoJfZQ53p7aj7Nd05jW+sQhIiM5oHzv+xHLtNq?=
 =?us-ascii?Q?dPR5gC0aHVjpCawuW9AFkuMDbpdJpOMEvjDgZH42bWnQ00mR4bw1ZIRAIRvR?=
 =?us-ascii?Q?ANCXtL4ao+Ho4AV+li8hgilLikV46eaGwV2QT4Qgf+r3D8daUU07j9AU8Zbx?=
 =?us-ascii?Q?ofDoqu+EnUlvX8fl/Tm400U7d0V9SzJfLaHfJueAursp+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JG68VwV3DBEPouw0vsHamxhDvG02ZPDouxT1tOztHo7uQ00hpUKUE9UUrhh8?=
 =?us-ascii?Q?JmOSRzmkwK8ahDcqGDx68KuMohtBek3rEX5r/OluwyrHreoOxLfG4twDOySx?=
 =?us-ascii?Q?1TNFUpuKHfC1+A+LrWwI82y/3uhCkIQON9x48JmFGRTlzHPcVNFS2oRqGuBh?=
 =?us-ascii?Q?/oc/PzoC4nTUJc74hOfUi39aaTn93qBYKcBeCFFJXvAYFonSvZNMN8obmCsg?=
 =?us-ascii?Q?vF9HleSvNccJ0tUSI5ZTbmLAwEv9DOqsF7SfvpPwNTNsnJ3e6ijQC6bckVk2?=
 =?us-ascii?Q?s2QqfcrdnCsLNxiyiGFsoHFMSxwchRq0iNvCm1tEFCNuhDuWgvX0prxgFfd/?=
 =?us-ascii?Q?6Z2EJVHrhAWboLDKMWmzP5u+5WgbwbFNJnj1ZLrxpEe0ARAuEq40LnbPSKTg?=
 =?us-ascii?Q?kz3m34TbqoFaTNfPJostIMcTUZtGr5PFA+RjP6bnLW4CFT/UL/5HuZOUuNxP?=
 =?us-ascii?Q?dn5xVoABCNTfYyNITdTY/GKcceBH0GDa34kzltwNGas8hd42BOUI9/PsjdeC?=
 =?us-ascii?Q?7nHKzF+OHiGn7NlJ/QCR7cU6f6v89+BPLga9vYKn4ofWVvjPnSdVA8Zu2FXw?=
 =?us-ascii?Q?x19EIZZ7uoE1xi46U+eD+FXDlkoTgwynMbMki191J+TcTfVYkl9GFmIj5b8v?=
 =?us-ascii?Q?+S1WfRJZDnkIBpqGNpj7KlxQmpq3+3Vflro9WLMGhXN1q7eBrQ3xUBhmudWh?=
 =?us-ascii?Q?F0J5etySBu3+4SrMy+WT49f2QFXDaIJjLhVdEURkFbqZBrjFqRZq/onjdx6e?=
 =?us-ascii?Q?AOf30TPVvrMTz4kBSPh0xorWi8NkWbZaw0porI0b57ObVMiYD/p0rS9UUCeP?=
 =?us-ascii?Q?5V23BVV5gBDVPDIyWMBqj54ysKETmqZkZmTIfdA3vf9inCXA9R6GS/at/kpJ?=
 =?us-ascii?Q?cn3o09TM5PUNHKbvuPnnXTBtJzd0+MBXlHdyw4As9mpHS4EaKf6xQT/5lXSU?=
 =?us-ascii?Q?kYrQrGN8ETxD3oErYulyEVqRY8dthvoSAm3Yqy0V9GMv1W9eNSpt10TP9Yi5?=
 =?us-ascii?Q?Dsw/NASS63H4rUtrwbhWO4R53RyP20cVXz+GQa2asbRjL38pSTvtVfeT/udT?=
 =?us-ascii?Q?oIXEMqzO30M3fa+L6OE/8/6lJVzJPXuL23x0df3h+TnDIGdjzCUczfkIoUvQ?=
 =?us-ascii?Q?4ZVWXaO/rz8lIBujuTKM8FaWR8xcFUkmgefCRyrXKYUnkEHgK782BiXOQil9?=
 =?us-ascii?Q?SwQCpVCNHKx5tc47Zh+7ZtUvJR5T1sKTXWWz7Yl2EnBCbW4BC2cVfUiu/1xo?=
 =?us-ascii?Q?L+0G0+lu16JOZ3u6ehE8P6lNVJvatHNSnHagAXRVE/4CeRFfOBKnikZVJpR8?=
 =?us-ascii?Q?Yys7FD9Dg9YIfq+weh/Ug4z48rjU7ytJnAjbRKMf5Bh4u4IK963ptG7ii6Y8?=
 =?us-ascii?Q?RbuvFAJzr4U4rS1Pm7lcYpl9WHUqQm62RK5//24iJzOQXbaFfpHdQhqjm6Fn?=
 =?us-ascii?Q?OT5kVAfuF0N2SrS0oL/NkWTU3NBR0MyaYgUTJlughaZssXbGp+7HfTVpqPid?=
 =?us-ascii?Q?0sCiJdIW2YuG/MMnUIzc51W3rFyGUhUk+G54V/wkhDrw8XzUQ/nCuxlS+HJh?=
 =?us-ascii?Q?V9HmIg4tO4Awy6DCN/NPHd3SXzpvLF2DfZiycNMwahCK7u1PQ4mfgeIBWKuH?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8879e527-a9f9-48cc-34f8-08dc9ff21b19
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:35:36.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtBVk0EeADWa+l3vfAN6lbV+9S/kAzKZhaOPtxDOLzd9Q5TLrSFvtgEUo3ha/OblwoTLJOoxUp/VpvT2MmsUsUCc0vgkJfxggGYCKDrambo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6436

Add a long term latency test that is only running on physical targets.
The duration is set to 30 minutes for testing purposes.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .gitlab-ci.yml                  | 10 +++++++++-
 ci/xenomai_3_next_long_term.yml | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 ci/xenomai_3_next_long_term.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 9edf635..803feaf 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -23,7 +23,7 @@ stages:
     forward:
       pipeline_variables: true
   rules:
-    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}"'
+    - if: '$CI_PIPELINE_SOURCE == "push" && ($ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME || $ONLY_RUN == "xenomai-3/${CI_JOB_NAME}")'
 
 
 stable/v3.0.x:
@@ -49,3 +49,11 @@ xenomai-3/next:
   trigger:
     include:
       - local: '/ci/xenomai_3_next.yml'
+
+xenomai-3/next-long-term:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_next_long_term.yml'
+  rules:
+  - if: $CI_PIPELINE_SOURCE == "schedule"
diff --git a/ci/xenomai_3_next_long_term.yml b/ci/xenomai_3_next_long_term.yml
new file mode 100644
index 0000000..0edaca5
--- /dev/null
+++ b/ci/xenomai_3_next_long_term.yml
@@ -0,0 +1,21 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Tobias Schaffner <tobias.schaffner@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+include:
+  - local: '/ci/gitlab-ci-base.yml'
+  - local: '/ci/kernel_6_6_physical.yml'
+
+variables:
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
+  XENOMAI_VERSION: "next"
+  LATEST_KERNEL_VERSION: "6.6"
+  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 3600' -- -T 3600"
+  TEST_TIMEOUT_MINUTES: 80
-- 
2.40.1

