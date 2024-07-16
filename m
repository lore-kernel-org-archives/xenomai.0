Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEABE1A7079
	for <xenomai@lists.linux.dev>; Tue, 16 Jul 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721154829; cv=fail; b=CtkiVIiUOaNjensfZDJvk2Alwr7AMBhOdTSjgh00ffGQXOH+YfixMIsW+1SdSb2EYzl7VI8OMiFNcbdywefvrWTkSNt06aabbR7Ixp9UwDqmqq+/sO6M3g25hEar1u4hSI7FHCyKoIURhIgBbUEz4dQ+cSEatWBKn31iHu8mCZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721154829; c=relaxed/simple;
	bh=YDCyuE/LRp4btkZRzK1QmtPsUaLz/oBfm6P5Mg5mNNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RI887BYG9zMkfqSQH6MocvAwnN8FAeWsNb9QNJisVUmTY0iJl19+HMWvgAY8IQIQQokn+zo9UibjDH1VPsUpDYY2C1OMySMfXJ/g6yHm311HNoLMGlsYm2NxvDIllpUbAF5LE4pPnfGEfXgEAGlelxuSdR/za35eD6SoEj733Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kUPMbHIW; arc=fail smtp.client-ip=40.107.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kUPMbHIW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfRYLPJKYameFxn2GQbiHl2/hWkp4H3flKH48REo6UOn/cCYj3LnAFYnZfHFPxZpj50oMpW1H8E9ze6tlL99MJpK+otWbh0fFpLJWj4c/4UFeplbwtAzRosdRLtXbCFqS60Zu1g5eHuCPfk+4UYVhtKR+1hJOlWY0uL2XvNEqT/5Q1rhglo/x6sh6HCS5OdcgJBSU1UkcmwvvX07+0Gp1dJq3GsME2R5PxUXULyGGdZP8iv47HFqSm2eDmdW9tXojOkpJmoU0hF/g2pjTnUWaFS383LXfU3zKETLAeUQmIaMvnV88g+0QdxiU7HqtPTZMB/jv8EUAGs+xaUaUBGPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmPdbZu6QogkVncwgXGpNJqzTMykykzbVXlCxp5ydFQ=;
 b=ZrR9+VVc8nGemhagNYh5sEuu6Axw6Fs+Ll+YZgCBwG+pY0/VdG5wcu3ah3VFn0bR+5Wl2jnG2GNGxhTA7VKZfchhcxyk3nMc+vebyzpJzEVgxxlSbrxZHj6lacs42bhzEhSBhUWVR6vQ/m/5aC9SGKz26zQc+w/8bCuraFy5Ti6O/GezoGsLZikM5sQfw61uS4ykvvY5RaEmULs/DpMNBNc6oN2Cpw+qeU2iOSSsc9pz7dLF5qmGqC6E2PhB6HtxqK0MkDXsOq918JYkrM91KT43+1b066XL1Ygt8MWswFtP9EICVArk/xWdSbfkxWP3nrNmiIBCKD1RRDfHueD12A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmPdbZu6QogkVncwgXGpNJqzTMykykzbVXlCxp5ydFQ=;
 b=kUPMbHIW5ZJiuLuxBczy5DrbQ6l+k2SvSnJN+K02zviSqUmTCvvGJDiXhxzouKKfCv10CEWt8R6pWIEk3dg98fwXiuNpngkEuN6GwYLKfjDE4iOGbToz+f+CBmpfVbWS+pGN4sHi+aea67nnHsw2Y9aJrrRou7ezk6g67FvWCa87EZnxaeZ403wIILV3Kjyzf/TDRtO6hRxN6j1U99V+VFcu+6QgnxVZdjhbNkN4z/9n2i2W/VM2c5MntCCA/NgDAlSp0v45KRriGTNN8+3kdiP9qj7MRCJAe16QXxPOgLD8a5sYk5G3Bm4BZVA8YTCV+Cv+d9owcLk+pCPdJH5XTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by VI1PR10MB7829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Tue, 16 Jul
 2024 18:33:37 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 18:33:37 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 5/5] ci: let the lava job fail if xeno-test fails
Date: Tue, 16 Jul 2024 20:33:26 +0200
Message-Id: <20240716183326.1432379-6-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
References: <20240716183326.1432379-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::13) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|VI1PR10MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: db05bfe8-6cf8-4381-596f-08dca5c5ce80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QoGFXJbiwwZSE0wC4bScRgJ2F6eZj81pjvC2YLt8eU1VxEeiy28UsH4WCeWI?=
 =?us-ascii?Q?XWT3sbvL/vDuscNBKyiA/hz808bjgSvVQnw8Wa55dn1T2FN0uVIAR2ilzjmx?=
 =?us-ascii?Q?7VOSCGRBV8cCeTAtz/yDr1rt6Y2vS+1eGFxtI3UrFvrSBGUIby9JfdU04kVo?=
 =?us-ascii?Q?spSQYDnODVhf/p7wuggS9CCsM4jfmTq/+Wf3BHtiKkMSfrrOimuYs4gOyfgJ?=
 =?us-ascii?Q?xbPwtxtqF8HOF0bdUoyBuWCc7IxfMRjohMgnFyklgTZFkqZQ7K2lUSsSgWuL?=
 =?us-ascii?Q?2MsSeO2q121tUlERS5PZFCejKvEeN1QpM9mIIFXG2c76PkpwoiqoA6uTJhd3?=
 =?us-ascii?Q?huGs2GI0ewAPFMOUNO2ZgD4oJItIaZUNMYC5YCkyV8gMEea7cAqCIS5IcVe4?=
 =?us-ascii?Q?FS9dHYHvfqQosAVRxnwoXdRuYKDzb0GZNsoG7RT9uSPCx0A25+gxzlTbCI9n?=
 =?us-ascii?Q?ecpGpHdHA2iweWeKLLHRcMVZhAiJsoI2X0amGT9XACeuwNyX1xU8TfhPX5i7?=
 =?us-ascii?Q?PukchxpNI1MFnV/gwPTmopA9YlJVNw0iDxGzK92L63AFsEhxx3mhTjxefdwQ?=
 =?us-ascii?Q?eCIdYtz2j6BD5B0gR4B32raXW14zrfQSCKzc1377ZRjrM4hrHHdjTHB0ROjP?=
 =?us-ascii?Q?cZ/cgz+XcohcVYBBB8CAy45/7riNkgS6g8otVZW8igAet8aLrh4I/tyWq+1k?=
 =?us-ascii?Q?49aSmAGrbTthYV/xPUXroWHlUONXysp/TrfGeOpkl6aFsKUkYY7hw1loghmk?=
 =?us-ascii?Q?SCm+gVMAYP0haz0ZtXvS1PJ7pd3Ipg82zJdlZrUX0s4eZBJ9dPhrzA7cnyQV?=
 =?us-ascii?Q?lRLUVpoSPpLMzcYhvJkhLcdis+tFgc8GZwwXdA8rS9e/0HY/3leHkNtY7tCA?=
 =?us-ascii?Q?XqiVh15GIwAwdCvofoWMn2n3DBvxXZdmtqa/sr7AQ/CxL5qJFfBfcazhrk01?=
 =?us-ascii?Q?9UwW9PgK1g/eYxDmNNeBF0goEx4RwqJAS7ngHsRGMhxEI/vhstF7ydIGFEta?=
 =?us-ascii?Q?9a7WIc22555EPLerlXLWjtme4/Dg8DRGKmq6o57mh5a+symE4lIlu6k01zL4?=
 =?us-ascii?Q?O3gpDMH4dXY5/fUY9Ob1RRBgOuym0MTQpMkT1lD7SirzpQa5/qG7V694hcu5?=
 =?us-ascii?Q?XkS+lIh3wugGYarDYbMm4sPWirijqWE2Yv+tNLAH20ncFvZXO2j5WXGx0oSo?=
 =?us-ascii?Q?KmFywuT9ePbgq2iMOnEDcD+iiXvdHnJsozIBcd5LllDOmqVXnW+NfOnacD8R?=
 =?us-ascii?Q?vDf3ub+6CjPjVxMsm4r1Qt8qfC7WlwXzS1IVRAJRlr7nUB2J6glP3J9i6PYB?=
 =?us-ascii?Q?ep8P4Z9XiltMGiinJ5oroJl277lCXGVi87thqIHDNVJH1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gjwZCJGoYyoodtNGR3Kwep8gEThxAB+AdjD+bzY76bjADRWOrI3u32kRzWYq?=
 =?us-ascii?Q?0P/WS2ZcXfVPSvxQMvKqU0S/CHRxAic1Pqqu/KU2x9E6jj2GsQTgHH5kVVyU?=
 =?us-ascii?Q?7DpBpj+leIRpdZDK8HVUzbCxJvDAuNArJ/Fb0jOAEPRihlMqoMXfO44FSbPy?=
 =?us-ascii?Q?PDAoXDgQJt+RyQkYu7kewzTiwX4TbtG3y5O0AD0XyOxDfvUrS3x4vO+C4PFQ?=
 =?us-ascii?Q?i3YCekZLt3GUioZzx6i29O6DwAvxiLL4HFM1ndddICBa++q2sbPBydh9+15e?=
 =?us-ascii?Q?grRA38LXHitmnGAYGkgRU6YMPxw2GOXmZn+VjQ4DTjPngEbNNKJCrmoWfpB0?=
 =?us-ascii?Q?yKY7BPF9u5jy8VmIGt4JD3bel10/ynA7OD8VTGViFP3PISr6b8QQhO6Uasdn?=
 =?us-ascii?Q?pMl9P5QmApRrikHWab23j1G9Tu+DZU4lC4SCgqwlxVL5ifLrQ2Y5QE5x2the?=
 =?us-ascii?Q?fLtwfRc9w4hE62iHCwqkIAQHh8bnzbwDVWTFjA62bxRMktuO6nfFTU29H8pb?=
 =?us-ascii?Q?1PtrsfN8WVobPHu1lzJE3uQCi0fa4pdeQNo2XRHQaDh32gbM79+1taryR7pJ?=
 =?us-ascii?Q?EWUi8WG6YOlDamKvarLa3bldO/1Xn+IYXLHwS5XfOmW38kiySNf4Y3DJH2if?=
 =?us-ascii?Q?lJu0N5WaDp3wm1elJ+ue139Pa+3RIisnzvRwwxjGvPiATXLj1yJEYG+vEWuH?=
 =?us-ascii?Q?GJXKT6D/uOlNPxhPs3e6kk7OBdMad/E7Glrs+n0WCUtiQ6tPvCXEU+mfw7Z6?=
 =?us-ascii?Q?59Wu8j7vWouIYtMHUd9M2kygknaYJO0lYKP7VP8XMG5IRAXBm5u8HQXmXj6U?=
 =?us-ascii?Q?VKLVoHV2tjflSHi6b4xcbg9VJybjzN1yVSQgC+nZUmn3BwUGFB1FYnoH8xkG?=
 =?us-ascii?Q?ncGZ7Wc6tv0xUZ+fM950vMSwvh8GGtexFNS4yFKSiaJsZhSa9u6r9u2B7ZAY?=
 =?us-ascii?Q?8ICg71N+rHzuKjeT5OCq3/d4VsmGQlRcJLnBjH0QC8qT2NypVazWU4bDEiJx?=
 =?us-ascii?Q?BqmR3vpmKzPkDjmzlaD11xq1AkmCQAyRNxvPeAPDLZFXAECZfswT9hQ4FzLO?=
 =?us-ascii?Q?/Ap+9eQbBmkPxpuHrlCEXYo04FoyEIqC4P3mJ1RMKgF++OJMZlUNwn26gWby?=
 =?us-ascii?Q?wQBiSGHErr8r2egclyIJRwf/4nvg0aIBKBo4WrxUYy5ATFMWbXYy60a49EBA?=
 =?us-ascii?Q?6ZyTAXvz87uSXvWyeS6rIFxYN/Q5YvffcO7jb9yaMq78zGWrEruXITrUqOuj?=
 =?us-ascii?Q?3Ektc0FL6bPqJWfoch5RqykkXdR4LAnrCs7zXzyO7tFZaYCyDpE7oh2hGYEO?=
 =?us-ascii?Q?uaXxtiT5lgMNO0FaNmju0nokIxZmgWzgLF6/amuY/yWV4PyHAQMtKILtqdIK?=
 =?us-ascii?Q?hsIE+bUZ4u/D9SMpROvLm8cIVJiHI3X9aupPLMMYr2bokLJ/yjmvd4RDUduV?=
 =?us-ascii?Q?2h94HL9cyWaY3VFU4YvL/GYogqBtJbeH16bFVeMiaSjYviVDWTcGRaKz/R5E?=
 =?us-ascii?Q?0jSkMt0N9v6DJVYYaZ6l2IDNlyyFhU/l3lOgXSAHvDz3Bq7DnJx1vdRhx7EB?=
 =?us-ascii?Q?PtnId8yn3qnofbUwWFY4i7ELbq86JSvOB0ZtdcHz7q5IEmrjQRIxv44T4RPE?=
 =?us-ascii?Q?AnbE20C6PXokT6M2BGGX+igirfVwTw3QSA9XwJzaCy0lSXOmvnOlvshWloNB?=
 =?us-ascii?Q?4aOCrw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db05bfe8-6cf8-4381-596f-08dca5c5ce80
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:33:37.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrAI8smErwAUU71zLL4Mkyz3yLgafOBgBgxN4cDZigqdlC3iSVPVvtNduNivunRX6/RzNVpL2+omtHCSqfVeWtD+pca4KVB9tCoOEeYt6Sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7829

Use lava-test-raise to let the complete lava job fail if xeno-test
fails.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 tests/jobs/xenomai-beagle-bone-black.yml | 2 +-
 tests/jobs/xenomai-hikey.yml             | 2 +-
 tests/jobs/xenomai-qemu-amd64.yml        | 2 +-
 tests/jobs/xenomai-qemu-arm64.yml        | 2 +-
 tests/jobs/xenomai-qemu-armhf.yml        | 2 +-
 tests/jobs/xenomai-rpi4.yml              | 2 +-
 tests/jobs/xenomai-x86-64-efi.yml        | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index f7966ea..8e47dd6 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -63,7 +63,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index 67c35b9..aaf8949 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -62,7 +62,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index c20fbf1..cc09205 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -79,7 +79,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 8c15026..2e9d1d4 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -85,7 +85,7 @@ actions:
             - quirin.gylstorff@siemens.org
         run:
           steps:
-            - lava-test-case xenomai-smokey --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 9560a85..0bfed71 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -79,7 +79,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
index e8b9a7e..50ff9ee 100644
--- a/tests/jobs/xenomai-rpi4.yml
+++ b/tests/jobs/xenomai-rpi4.yml
@@ -62,7 +62,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index 4aafccb..4f1a7d8 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -63,7 +63,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell "${TEST_COMMAND}"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
-- 
2.40.1

