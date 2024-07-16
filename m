Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9D1A3BB8
	for <xenomai@lists.linux.dev>; Tue, 16 Jul 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154825; cv=fail; b=LmBjR/ifv8Z7XXuvu7GRQGYEwtxuVB+ih/mblXzpdz+LjUZijzny1gKhu3l+p7cJAPjKcfEC6jG0gSMrALpTpl2Jfu/44IUfcJIyuJXwxKM8KEZR1yAbgpuZr2nGTX3AP1LnNHlvJjV9dtIG/8MLDG1FoDMQh6Dc3re4dy5pcP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154825; c=relaxed/simple;
	bh=7HCf4RfFywWOgf+y48svKDnePDyQe+W9rsgyA308uFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DxK6UWM+GLFT0GWmBesqFFENDDuRng0BIoLu+5orzSYme7Oxt2MoGYq9ddRGM54LBY46YXXmlpXlHAVJ/IQsDduobN6WoemeTKV7PqSy7WV4nYlNqbjj2HvhZ4b8Z8/NoQA1Co67CDWGjfw1BPUHgv3lxmXcFFMze4VuYHWTpQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cOEWIweX; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cOEWIweX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3u9jtcGkAl6tD595eSTgwNps+dRzUMXIqrkEDLxnpfmNXXhoggtMe6v79MiBp7V+rLgGA0WCj7I455JxaZvk9rtCXGu6JKyZRQ9BeUajX8EW/iay1B7lytmg6jleUm/LnGJbChVTfq96u1FeH1kYBSu+Ts/v0GXVdZ/HwRzytU1vdbtmX7+PyIFYBG8+rYRuga7kFoQoRu+pe3CtH85kh3NaN3nHthth3EpGJigRcc/scEkik1e7Brk9bjczRXvt3LIJCYFRVpzyeFIey9Ujr1kqQzKdPbF0uN3nThRasHkMGXpJNRG56adx5TCSfWioeGNmW81oEIqwsk/lMPCEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5AKgelkVRWEmCoYBmDOrQo4akk+Ous8lD0vn7e1dNs=;
 b=RrLQwm3Bg0epVEy4K3Nrh9GHkEPEr11y4ztiTWJfNh4/0392rv3Zj0rV8VuSd9cFCOBhpqGT0kZtDrePEQwebg2DP/qYCsHHcInH9TJvenV1QLwTu78WlgcRvkUlz9L/GcHPknKzhI+W63g9dhoVM806ALSKZD3RqMnsbmYYAz7WqncwEd6Y2y/xbQKgyAQCDQqrMZ1/c+hEMR36ZG2ONyxzyafAJn6gIYSIo1bIJ4Pg6SoeueGH47ydTZFteuPehBrLlkIVJUuMmvYE7qND9yNjA7e+Sqmk/Zse/9sqMUTFsY2L0vQ69RWFLku4DBOliAoaqzzXGenf8eW3azWWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5AKgelkVRWEmCoYBmDOrQo4akk+Ous8lD0vn7e1dNs=;
 b=cOEWIweXVtFmpK6rGmrIBUuTOj9aeqAr6vrTEUxZr7iUefKhJO8B5PIk1lh7GYUaXhD6yomlnsiyLQVx2nxnMFZEK+Cpkqhae4tlN1PxRy1J4Toc8iyXFFzePH6II0gSqF6C+qNvwp3TngyWpWkcWhJeAJR7XjA1qNUjSWh6aluqyO4GHfwNrGyKF+6VD2n4KlOuVIvF4gclYw6Mu0sv2otwaJ7DP4YeYPVxcbVuxK4IEnqX399+ReRdBp12YsCiWgxp7JvX9OVyJu10VCHz/jUxVYEG1dixgtWFqKcHxVJU5eivgHXdDT0S3HnEP2gyNUcYXY9koEhmWFE94lLGMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by VI1PR10MB7829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 16 Jul
 2024 18:33:34 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 18:33:34 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 3/5] ci: Add variable for additional xeno-test args
Date: Tue, 16 Jul 2024 20:33:24 +0200
Message-Id: <20240716183326.1432379-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
References: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::16) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|VI1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: ebc972ec-d4fc-4f4b-3983-08dca5c5ccad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fY/SRjz29PjyRWmeyPgR/CUC9zU0E4U1VAmUDQq0jz28S9r3Yb2FzkYBTC0g?=
 =?us-ascii?Q?6SgoiE9fByypT5PSBDj/vuv+Qx0Vx/bCvvgi/6FRzs2EXS5B3RCI+WAYar2P?=
 =?us-ascii?Q?KP7Ge1VG2pIN2PkuwcLFWP1dhB7XIjtogQk080T64sW8UxAxlX5Ov+Ethvve?=
 =?us-ascii?Q?D5KzQqAgIKVy0RtDd9wEvXZABwrbb4mNDQbKoBndkA0CkyQcEbdXs0LIjPv3?=
 =?us-ascii?Q?N091B35VBJMkD8k56F+MGs3qXACAf2AcjPlFWNeKYYLZM0g6InisiUvj0JSx?=
 =?us-ascii?Q?vvd0jUcvkLRu9Gz0d9IL7C2Oi05uYgzYguz55/CCT0lcVDpaY2SiIrN2xpuc?=
 =?us-ascii?Q?FAfzm6WO5wi8gMWt7S/B+R7lPxDj3HPIxTRz+z7mDmbGEypOO2Za6NpeYzGX?=
 =?us-ascii?Q?nj0Ggjm+qBi6y5TD25/quanoh3A4eZNWbRP3ETm6p9I6kpttZipbtGqA749t?=
 =?us-ascii?Q?WWz7gBidSXwrmpezRy/f2ASTTaJ1qBGD/Qc0wG/CTCUM1Gl+YPj8fXRtk4Wl?=
 =?us-ascii?Q?Qy7m4Yz5+PB8Hfk8XTv3AoBF/FSScaxxAfV7m8b/ejB6n5hDAFwcN6QnNala?=
 =?us-ascii?Q?0GUz7P54heuz58gc3ONR5jceG35WbgmegBqP8NV4mMJAURrzajISMTSwjyto?=
 =?us-ascii?Q?WQ905c9zyIipONR4zObRuacveyasUKSGVWF0wWhqbVByKkeQVlOXyEIs6cmF?=
 =?us-ascii?Q?zYJ+i9OvRkpVECy0Pcpy0QtiZz4DNIoSYbpjlO101ch0pkm/8DpYjdLKMDNO?=
 =?us-ascii?Q?rv2mhwjVsm9AJA1FTDzBHgWd94vM7brnS60X0d9YUwkunIxX3h5PIN7dCLB8?=
 =?us-ascii?Q?Xzdr99RLhGAHVSuRV7rBPyXJMXaIFEOdx1YItcmu7GpqQAWAjFZQ5VZRIS83?=
 =?us-ascii?Q?zv5e2bhMZCFOIFq+U0skSzSCYWMwJHxfGNom7ONhEjy0jOXi3zgzkvS0lX09?=
 =?us-ascii?Q?zxQewXn/9rekONIjZROrV/0BTsjxW1SvSf8361T2J5hUmgjzVOYFqHrfkAtX?=
 =?us-ascii?Q?Kx2Qd4hiJ7jheY9+IqtMnk0YLWRmjdEnwOXw2qQ+glB2iy9oni4a6mZOT8Rm?=
 =?us-ascii?Q?fF9fksOP8VkFtxpeN/n0SN9UfHYktRoDMwbIXfVtf5zCQpxJiGZUYiCWFj3l?=
 =?us-ascii?Q?SiRyc3TmB4twRSbgUH/tdibK2jtU/DXfl0sIIz2EpojgAEeM51qStbqYjLzX?=
 =?us-ascii?Q?vAEN5nUqtn+1LPqkEm3/aXPFSAncZGlbO8lYTr76/LoxCS/lppODSuCXlVIf?=
 =?us-ascii?Q?RYrGDkbXn35ffvbcK+F8CNUptSQN/0RO1Apr5eeLr5zMrEW8uljol4wP7rLC?=
 =?us-ascii?Q?Tq4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQGi/FE/D8SjLAvXlRisVkfrMfuqDOnrEtOz+xLe/5LfpkzX2BFqeEC1qfVs?=
 =?us-ascii?Q?XtK2vpbgrRGzE2oxMKLWzTCsVDPiu1nbQMW8JQeNOp52FXU5whVl7XvUkqAq?=
 =?us-ascii?Q?dczEfGQBxUpWh0ZjDa0I4iV2npSdm8TdYgE23X+tfvzwQ5/IU5aJIj2z+M1W?=
 =?us-ascii?Q?jLq9QThEqYuddV+tMf+iiMmRugG3jPeGH6q0TD93o6G6r/d+GYDZLg8Pchj5?=
 =?us-ascii?Q?R3M+U9kMQ2nAuaJvv0dI1mzAtqPSZztpZofgz7cu4YwOIFLJkffYNOUIuDY/?=
 =?us-ascii?Q?2NiUp+fAaaw2G8g0/XfjP9W9g4rrwX/5ffLmvwfA0Vi+2NZzVqgFpcWzZ0Vb?=
 =?us-ascii?Q?haRTFWYqNZX0JQrJFAupJB9mho/LFMC487Tk6rTNeLbW47Qr1Wi0d+7C2xo6?=
 =?us-ascii?Q?TR2kSUuFbscg62yIGQnH1Lfmvdnz+isX0QcYJ/sNYlrSoyIm2KWuyrhdKEFr?=
 =?us-ascii?Q?3B/2hFp3EhBEpMbrT+eHyZJjiKbjRuprg921Ho6hhKUXxODR/yXOrdll3k3k?=
 =?us-ascii?Q?/Ken0VZ09htYqHNHrwQHAigYKIXgQG9KFcTfn12+Bym0T6/bCVYd/WpP4waH?=
 =?us-ascii?Q?dUY4XJjROdWoJeDBz/mFvlM023EDApuqkowycIhynnxQXo/AxjdVvZSZtiNT?=
 =?us-ascii?Q?QtPdwRf2RtEtNR88X8U6XdSa0fUjzetehMJ8kLTsAS5hp2ix+b4R077FcFww?=
 =?us-ascii?Q?WsfllLqlAqmo4eP1Yo906rEyyUtN2xg0ZWXhkeRpi3qvKS6+PlgRhtGbPH5s?=
 =?us-ascii?Q?6GcBtH6IgtqFObUPoWZWgOO+l+pta8rWUkvgqFus3QcaGnicSz83jynr/3wp?=
 =?us-ascii?Q?e7xLGOF7g06CVvHmQ63RVZNGffnF4TyVe9LMNcjGutB1eJ1Diq/DZ2Jx1fJl?=
 =?us-ascii?Q?n1TJAFQ0W4bT2Vq9rXkbBAHTdYCc5sZyJY3/CblOl98c17TzlrPH/ObxD+AC?=
 =?us-ascii?Q?30V3+/7b1WhCoZjy7+fEutSCyCKMnGbCi0ODjhTO7rD9WQdEl3AMv4O3Dmar?=
 =?us-ascii?Q?4baJKN6dOOXr8K0uk64jTwt6q6zDV4sJ1sK5Lj3KLylznoQDT1jI0Wo2s79C?=
 =?us-ascii?Q?v+aLdA49bOO78nM/sL8U253AajXwnr9GyBRlpP4qN2Sw8bYNso0yBGlf5K1l?=
 =?us-ascii?Q?eVhUKPraP7/hNtOjpVAfk7njTefGyqdVhsxORRzg/m7D2uql8bm6OkB7ANv+?=
 =?us-ascii?Q?F8HcnYWZUBXubmvOGiNqzPML7Pcd/KfYoqThHT0aVrpzZpwz8Foz3UwQB9aB?=
 =?us-ascii?Q?vog0zjug3Ms7mCbWwCqQEE02baQvEzXuB0+Sx6216SgWMBjRmRwYWnPAAiju?=
 =?us-ascii?Q?cvfNPmfhD6svozPl9BSgo622L6p2gklPUCIy/y1nkHpjnXFLWLOlFHHrdpE8?=
 =?us-ascii?Q?tUUGERSNjQjSBay27macGjzvQwrMYgFsp4pllxTBzAob5K1X0/n+dRukPjdw?=
 =?us-ascii?Q?xa9u/5n59h4Cuo0e94b9iZsqrck7KS6eM2eX4mqDXrTi/RCB+VgZaQL6t7cu?=
 =?us-ascii?Q?JO9ID9V7IZncpa0E6xqwZ6+ERC2d4EGhmzNHRk54kTAu8RnfTPwvh+0t/bZT?=
 =?us-ascii?Q?ZzfiaZkQ+Xwy0f9fM8n9lshiGhoeUDk9IVuCD8CD+oAk/EXjQe1tWSl6a00O?=
 =?us-ascii?Q?Q+FVW3PCzKRf2Lv5cbp422uUzWvLW5/JNXcevAZVuBmTQt76yMT+A/Us+cU1?=
 =?us-ascii?Q?muwbFg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc972ec-d4fc-4f4b-3983-08dca5c5ccad
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:33:34.1498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHwwhtM8sv+JLn38sIyDhuUA5wGHjeg9MEcwpMBkZbEPHspJoL/ChueFD7/DpKfQi8Eac2mdw/YqeX/HlsJa3/rQTook6F3+98VSvXNc9XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7829

Add the additional xeno-test arguments directly to the TEST_COMMAND
variable instead of passing them in the job file. The latter will break
as soon as -- is used to pass options to latency-test.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml             | 4 +++-
 tests/jobs/xenomai-qemu-amd64.yml | 2 +-
 tests/jobs/xenomai-qemu-arm64.yml | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index be1972b..29960b3 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -22,7 +22,7 @@ variables:
   ISAR_DISTRIBUTION: xenomai-demo
   BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
   TEST_RUNTIME_SECONDS: 300
-  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}'"
+  TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
 
 default:
   image: ghcr.io/siemens/kas/kas-isar:4.0
@@ -76,6 +76,8 @@ default:
 
 .test-qemu:
   extends: .test
+  variables:
+    ADDITIONAL_XENO_TEST_ARGS: "--vm"
   rules:
     - if: '$LAVA_TESTS_ENABLED != "true"'
       when: never
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 6a548dc..c20fbf1 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -79,7 +79,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND} --vm"
+            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 35dd3b2..8c15026 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -85,7 +85,7 @@ actions:
             - quirin.gylstorff@siemens.org
         run:
           steps:
-            - lava-test-case xenomai-smokey --shell "${TEST_COMMAND} --vm"
+            - lava-test-case xenomai-smokey --shell "${TEST_COMMAND}"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
-- 
2.40.1

