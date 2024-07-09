Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B821154429
	for <xenomai@lists.linux.dev>; Tue,  9 Jul 2024 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514147; cv=fail; b=WlndfQeEC2YN2stz5pIsIXO5eprm6V1v7jWl3d2if1aMUWWUKHeOmKiIg2SqkLKrlAg2ULX75MwXyVbvJisyS1YAMBmMQT/8o6MyITwYHGWnRYy0YgwJ1cybgxQY8/lDG77sa3dt9B4sQmmM0IxBG8Pxmn3WURs3lbv7tv0+WHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514147; c=relaxed/simple;
	bh=duq8icN/3RZjSMgD9cLGdCyZTyxDdyYdpS4tDNBnM4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I4FMonFXlvAE8ee13zVyLm5u5cje+Zxfwjh7+pm5XTmcMC2yuZa+7TgQ02nsxr0MZ1gyJ2Kfwp1SW2dpImzjWnP4un9wTpLW/vGWrUPqOLR4xP5dkIlTSh7/BT46hAV3IQpI8jQNTTaeYtj55g+wZA6mIJ1zLmfv8fzcmguZ3p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=S9Fg2AQ2; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="S9Fg2AQ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJnTPLNr2LP8C29osUoXyEg2fYN8/hdy7zTlRLExvqJwyDXcXG7Z3UQX3YXo5b/pyDjxTj0ZGqHOv5+gtnwAW/GkmdfjuUuB2o8UT8ceOKc3DZmXW+ZBFdXeJMP4YR+OAymNcG7sQmSCyhC6TNwr/ciEvlRWA0nB3zol2u5m5vGVFzatDfLrpZDKArysqsxR7drch92YG1YxUrNTWbUpPxzDEs4WEw+FjsvUwXtclYtPyYGUFYjbL6+ict4mksRGYUwDaDhs78KG5z44AA17LBdfwS4lNZURKK/V+/8b2YxAjWRmZWmlMs9u9bldIBCH1tYYMMkAw853KU5HHcRJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VXi+ieCkutmPecdFkE6Yg1cNcyPmbA/t5j/nTANPVk=;
 b=MegFF5sBygNwCJaFlZFBTqXLp2IpZV3XKcoUPBbGOhqqFr0ZeyYotwcNf/NN1PstpFF9ZelppmNzUFM4nVL8cQxUvC/IAWewrSq7BK0HdFOKQ3UzwsgCfHARnIErOtt0qRIiXeBQsC0r6m1lJUc4FGbGgYfXOWhJxnljor2O6VdTh+mybSWs5ydHA1Xf8CPXH9chyx1sLI0zo7tvdh5AhRknyTD62ySmOHc8aTyDZtTBGfrDH9C8Y4k8n+sqQzEVy5A3tOxlNEf5xUM6C5cLudw2CG3NVnE71jQIn2okybuCDTZgRv0sUbSTciVaKWkBVDvBf32o/XVOK162OBi7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VXi+ieCkutmPecdFkE6Yg1cNcyPmbA/t5j/nTANPVk=;
 b=S9Fg2AQ2BLw6DmorEqdYSjjYuYslzZ6peqgfeml7hRuc6RDWRatbHT6dyhKuQ47pUnzB5dWk3VeG1tHW5om9e6eBlbBAiTd+qGOVph9jUVkrRCqpg3YaxOTRxeTOXqqnrrGxDAy4lmjiYKBqIrUnUGUJka2zW1pvPrmQBUvWyQ7e+WvOWAnbRzX4OJP/p+VhRcTJsK/gp1IFDs1S2fqspPPOaNhajFfZyD9CqD/aciLntCPWYE8skhXu1mIBL0waijuC1MpBtV2urskxaI+f1BtkdVKXSJ3dKeAumPqrKUWKzzS6eWlQGsyJgJEcZ8yE+ESe7R7BnF1c4ClJbY0CXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB6436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:569::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:35:35 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:35:34 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 3/5] ci: Parameterize test command and timeout
Date: Tue,  9 Jul 2024 10:35:22 +0200
Message-Id: <20240709083524.739194-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240709083524.739194-1-tobias.schaffner@siemens.com>
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: a5a68d20-90bf-44ba-6df7-08dc9ff219d1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9nt0LilZtWsHIzczP6/7juGlB49IOpApYAZFO6k+4yhBrMHtSRXGRdd8NQCL?=
 =?us-ascii?Q?KQyRQCjS+qkdz8a2iOCLmsT95oj0ATNUjzHPGVoROjYnjE/osotFUJxFnain?=
 =?us-ascii?Q?rr+T3fSUP1PEkU5ig6zb9LpjwNopwiYzFEUhKAAM6+9+eplN53eCx9kTKxHe?=
 =?us-ascii?Q?2IKrdXGD5H1bhDAF0dZDUpW9d7mNPX0Wpcv6qkGJvyaINIXmmPoSpGnHEAjc?=
 =?us-ascii?Q?70CQZYEcU9hInKLcwoulpTYVM8o7Ln5AisDbINW1TB0O0EcNpERerXcLTJUV?=
 =?us-ascii?Q?a+QjCYVcXgxLvtHyRrDwA0E7x++q95G8/lq4IoO8r+/0Om4ijRQjsMRnH6Pm?=
 =?us-ascii?Q?unVeWRT2tHwC/2LdiJp0qoP6oSIQ4WrJ7Vnc4C+Y/As9zN45B4vIqmw5kRo+?=
 =?us-ascii?Q?Hpy61agS4Hl0NfzlAFFYLg/oOnNsEkwYdlKvxF7d5ml5ZEpINgDyZ4tItu1y?=
 =?us-ascii?Q?481DEODvFI3jqr6PsU6zwG9p8i/0ezJfkvPipkCFfKvmXHEgxZmvIq2Hl0zL?=
 =?us-ascii?Q?sbWirzIsZFBeedLN38fZoZdZ1WbkTZULOJIDiE7gJFhoW6piMLDz2E7Rb6Pt?=
 =?us-ascii?Q?muaX3xZ/bm35Bke0Xb+uShKxiGDWiUttC7q8E+X+TwjZ7NXIxKMHWF60v5vi?=
 =?us-ascii?Q?s7sAgbSu3pwgthxIci3CBWhhCBAtJ553YGcsD2X/oYHigfZnZ6+mpW2n4SYf?=
 =?us-ascii?Q?gkEf3iFAY31yFbhsQOfSPw/vnTDM1+fBcIh87L/f0yZ7MzdfzwWTXtKo2MzX?=
 =?us-ascii?Q?PNUEClEfbuuTMrRTXn0eImEmA8gly2gMyU7foFMORS6H4tJwr8NcRP4gkq1L?=
 =?us-ascii?Q?0C3aY/SX1NCJetwqdnlV292z+Ja+pQWIWtcWSlUWkUT88oQwdCF84bNaKoDd?=
 =?us-ascii?Q?f7efF8hGjGQjJqLxxNqg8qmQBU8dyhaGJ2UMDyoNee4aEpxRo8Xbwqu8xNns?=
 =?us-ascii?Q?4kpR6V0TI7P4si8+doIbnaC6NC/a+GdKK5+IwCPDOlMJM+Z141ot7YgNsG0O?=
 =?us-ascii?Q?hE2lE4LNPnDqUTBQSPFqKXr1yHLPhFFsehU5HHEkXq9ld+1Dof39gw40ZvPx?=
 =?us-ascii?Q?/2k81SwmhfuN35d0RYOiTPgqJu1bYJzA7rRJgWUeU1cqBupOLGxNtmrl65Xh?=
 =?us-ascii?Q?cVZTjAAwsL/0qHkpKAjkpYkNu2GXPGRTadl0e8inpRUz0cYRRhADnfwCLlgh?=
 =?us-ascii?Q?Tu4YDfA0ISYbcWJ6OjcRF6E/vHD09Xpt0vtLqQSGDptF3IRKZolph+xs2t8w?=
 =?us-ascii?Q?GqWZ8anb1rbRmdwI6a+sGZ5DXFCl+kjX4QL4C5qCBEu49JDoX2B3OIIy7blF?=
 =?us-ascii?Q?tHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZLu1L4QrZnIXHb/XPZRBgH1PRbkVvXpu/KtXMNE1oyXU4AnS22uSNQkpCxge?=
 =?us-ascii?Q?3rgt0bntYubDTCRMXEpadRQ1NBn167Z8IgDBsQ5+5clOJM5uKl72jJnZJ6MS?=
 =?us-ascii?Q?UYLM8y+Xe1g0JzrhcP1sfPEqHTRHacV2NkuQF9PyREvol4GdK9buHOr6T9Mm?=
 =?us-ascii?Q?bjSMsST2CVLAVzsktN2IVsish2ieQ91SuLjiGPoA5sta5bCNRpHZVPtNQVmE?=
 =?us-ascii?Q?PcnwAm/81mZ4o8B9l/60bfjh5jD86CPFRuQcjZdQKsiDt5OBiFgWjNFPzgeG?=
 =?us-ascii?Q?63mf5wKZlwgV4/yc7JN8iexPQjJ4LPQnvZ5XztgubKV8AOGDkxOrDQ6XmJWh?=
 =?us-ascii?Q?+kQtnPDTM5XXacBIb2JzkBe44cTKE037PV2SBIX92vXeuzRxEtx+QvzSUR+S?=
 =?us-ascii?Q?j4yocau/xmHvqFOrnLvCzUQ5QhHEUkrPKEvZO3yncjI2Vc9fvteY8P4BJX//?=
 =?us-ascii?Q?zQh/V4RdoRMPzo+uKlJVroDeXTxuI6ObiEw9554HavSRAuW945cvHSLVlpRc?=
 =?us-ascii?Q?j8vRUv7t3UE0sINEoXVnThBWmiUL8seF/mj+7AnQuh5WSlzd7n6ZvsTdeuK+?=
 =?us-ascii?Q?PA4dwTbdLaQB7ARb2sIwl+KS0A7wr/QPyGZFhe9GjFceRR6SjcPnxWt/hLdB?=
 =?us-ascii?Q?FyMuLXuP9KS3kEZK9ZVoPHFwQhQGJiL7qCw4C6qiu5RPTE03bxg0NaObdoaQ?=
 =?us-ascii?Q?zJO58zfBiV3pk1ZPPaXgsafAeG+4ITCTA7V+ktd+LiJELZiXGONG2lx/P0X7?=
 =?us-ascii?Q?86We2cSWc97IcCWWlXdpfbEeWOywFcjeF0YEvyXg55D3wCTaxBaPbl37jm0E?=
 =?us-ascii?Q?2U+EwmklHX315CyHPAXFPu+eq5p+X6//EN66hMT/AtRIzJygm+d8ydtdmZGn?=
 =?us-ascii?Q?+HGI8J4Y4XfrnebXQzmXcSaA54GF30/KkZPK3B93NHPVvQ7fM7Ld9h9Xs29Z?=
 =?us-ascii?Q?FjGnSOuLC9ee12foFMpq/jcSyRfcH+4xjNf81yIrbq2PkBzyVzAsPxSEOGBl?=
 =?us-ascii?Q?T+g2bVGO+poBLz7k3pEpQ0Oa0HPeXBy4tnIM0O3R+7Ex6J8VoEY/nELSS1If?=
 =?us-ascii?Q?jtd36ozlff3mQL80WOWiKJTQzPZ71NNX+gUMZlaaqIObArhos6IGVZg9Nbtz?=
 =?us-ascii?Q?YDeh9aGb1e4l1j2YB31Dg5VMNP1fXkIgSuwKmMQdWvWHeJZYaUR3dNvt9+QJ?=
 =?us-ascii?Q?uMbwqwTNi4JzHRXjJfUomfFa9ehhtKjppgzhQypWsWvsXcswHwpbNU+ujhcv?=
 =?us-ascii?Q?WWdOOBXygWkWkD9XJ6u4eqwjW5o+HZDnQIeWJu7gy/clh9MqmVYGVhz0akAf?=
 =?us-ascii?Q?04wMJu1iy6E61tmZdDyoyYteMqKncyAYBr3TCjffkFpSmrdBDeVMND3tKFSg?=
 =?us-ascii?Q?/t+ZjKjGI3kTyXDnFnOL4tD8mt7D7uTdEK19voxdO3nQvxd4gDjNuBY1xeGR?=
 =?us-ascii?Q?VxkU+YiSfoUmPhfpuAQZFoogRxF1kVOJe2+GTMFpgoS/jMLLz8doSxUWx5jj?=
 =?us-ascii?Q?jjKjPXYxCz18t05GsYS3FiLnmJ2Iy33A7718e1Z3wkxvMvocjk/BJPLfXAta?=
 =?us-ascii?Q?O8UiIa2gAvw2ZGKtaHMfSRRje0wG471NZ7I5du+DlCK0328Vo4nNZHOfGVX9?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a68d20-90bf-44ba-6df7-08dc9ff219d1
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:35:34.4909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrIYXXjQGaQpuumGpPmJ2JiMNzup8VDSzEvFkZIMc1JvxWQiCRSirk0Mj4HCsSLRLgLWcF3boaFjRS/tJ8k1cIkhbmwQvCnR7EUF7pvgJ7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6436

Use variables for the timeout and the test command run by the lava job.
This will allow us to override the values when running long term runs.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml                    | 2 ++
 tests/jobs/xenomai-beagle-bone-black.yml | 4 ++--
 tests/jobs/xenomai-hikey.yml             | 4 ++--
 tests/jobs/xenomai-qemu-amd64.yml        | 4 ++--
 tests/jobs/xenomai-qemu-arm64.yml        | 4 ++--
 tests/jobs/xenomai-qemu-armhf.yml        | 4 ++--
 tests/jobs/xenomai-rpi4.yml              | 4 ++--
 tests/jobs/xenomai-x86-64-efi.yml        | 4 ++--
 8 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 1157fa6..1160039 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -21,6 +21,8 @@ variables:
   ISAR_IMAGE: demo-image
   ISAR_DISTRIBUTION: xenomai-demo
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
+  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp 300'"
+  TEST_TIMEOUT_MINUTES: 30
 
 default:
   image: ghcr.io/siemens/kas/kas-isar:4.0
diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index 17e807b..f7966ea 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -54,7 +54,7 @@ actions:
 
 - test:
     timeout:
-      minutes: 30
+      minutes: ${TEST_TIMEOUT_MINUTES}
     definitions:
     - repository:
         metadata:
@@ -63,7 +63,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\"
+            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index 8489594..67c35b9 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -53,7 +53,7 @@ actions:
 
 - test:
     timeout:
-      minutes: 30
+      minutes: ${TEST_TIMEOUT_MINUTES}
     definitions:
     - repository:
         metadata:
@@ -62,7 +62,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\"
+            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 62a268b..6a548dc 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -70,7 +70,7 @@ actions:
 
 - test:
     timeout:
-      minutes: 30
+      minutes: ${TEST_TIMEOUT_MINUTES}
     definitions:
     - repository:
         metadata:
@@ -79,7 +79,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" --vm
+            - lava-test-case xenomai-test --shell "${TEST_COMMAND} --vm"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 9ce451d..35dd3b2 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -74,7 +74,7 @@ actions:
 
 - test:
     timeout:
-      minutes: 30
+      minutes: ${TEST_TIMEOUT_MINUTES}
     definitions:
     - repository:
         metadata:
@@ -85,7 +85,7 @@ actions:
             - quirin.gylstorff@siemens.org
         run:
           steps:
-            - lava-test-case xenomai-smokey --shell xeno-test -k -l \"dohell -m /tmp 300\" --vm
+            - lava-test-case xenomai-smokey --shell "${TEST_COMMAND} --vm"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 070b801..9560a85 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -70,7 +70,7 @@ actions:
 
 - test:
     timeout:
-      minutes: 30
+      minutes: ${TEST_TIMEOUT_MINUTES}
     definitions:
     - repository:
         metadata:
@@ -79,7 +79,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" --vm
+            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
index 627deb5..e8b9a7e 100644
--- a/tests/jobs/xenomai-rpi4.yml
+++ b/tests/jobs/xenomai-rpi4.yml
@@ -53,7 +53,7 @@ actions:
 
 - test:
     timeout:
-      minutes: 30
+      minutes: ${TEST_TIMEOUT_MINUTES}
     definitions:
     - repository:
         metadata:
@@ -62,7 +62,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\"
+            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index f4f631a..4aafccb 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -54,7 +54,7 @@ actions:
 
 - test:
     timeout:
-      minutes: 30
+      minutes: ${TEST_TIMEOUT_MINUTES}
     definitions:
     - repository:
         metadata:
@@ -63,7 +63,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\"
+            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
-- 
2.40.1

