Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2042.outbound.protection.outlook.com [40.107.103.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7144714AD20
	for <xenomai@lists.linux.dev>; Wed, 17 Jul 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212692; cv=fail; b=X1dYBWVMV2nTMl7jtCrnT4t8IIcyQ7MtUMkx6hwMqwsVFyAWt9YIz+5YFjY60oEfeF/FpJdD4k/QtyXjdO9Dv3PEevjwHreJHkRYnuy9RCcSQY/BFIQ8xkCRvE6Ak2QeTl5k464F7cmq+6Td3edZs+ewHL6AGv1CVKjcTNDvGB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212692; c=relaxed/simple;
	bh=ZWkFIm59uNJlnlUiJbjqBGFKer+xzQecE0PeaM8WYiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UDZbOjPP5sXJCWGH1LthB+o8uN0k1Tig81aVu5mJjCvXlcznSps6ZLXgX2hp6zoZfNLhD1ptVCLzrLW8BqqukBiRkAeYEk9F3pDaaIAkNP+Ie4aGHEXS0BY8XLqy799NFKvMi/s0vJ0orUGsJnq7ZvD48TyUQTxCALpW6Tfi3rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wek3sgET; arc=fail smtp.client-ip=40.107.103.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wek3sgET"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGBWgox62gBDcL4mZDZ8oT97ZMhjxKMCR7Sx+L06MCvuDrYGby5EFsI2hZxcBbm2HzHdl6lpNBOSoUWigtSiPMF1MrzVM05fsx5cm7EFlZN95WKaeUNjk54TiZzHj/aOZjyuWZ0wa3p4kx5DIDgMaHVgli2+bkdlDi5RqwB3RoywHNrIscxXlStgXaNgiAOUf/iTmhGEry2Pm99y49VMHNRP8iNWF3anDTTQDycuuLxEJIQyIs8e5EwHKd7s9ldyTZG0eNAQ1AAhGZMSLSNvG54pcn8s1IH0U0nJlTJOESZL86O4Ok51Zqgof0YphW54Z23iaUH15WaEuHQOha79lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfPM3Dwn+m1i5gMIrDc7f7+ZeBUkfmLgVwMwhO2r0Ew=;
 b=rsk8F7NZ6zPPq+/9oWbE7KDe/s9KhDy28e1tsdLOhKt1cBlN7Y80hAgSWym+lhe+K5slIyPg8nSHWbCleZkKgho3XSxmSX68QiTABByTCsLoBZ4adaSieC4T2850qubbB8EPcOb3BBYSJ+HTMG0jNYxCPBEMeJ4E7jT5QxtoTPchgjupS7itE5c7SXPeSnl70gg3mFY00642Qcbyns3fnn5Y99M7kSqZOzVmYrP3w8jU9e+TT0ziIhgYWRqqWhlUKPHwhLiIrLBgtyBS4Gc7YioiQy4QtNEzhpor+1kwPjJtRlGjgt+yrYP7ISJhYW8O3NCrBf5pVRxDPHsQ9zaUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfPM3Dwn+m1i5gMIrDc7f7+ZeBUkfmLgVwMwhO2r0Ew=;
 b=wek3sgETr2EEcbeLAAhZLTXiuCYmup18nrIPTaBdRsFLyE7bu1VFb8muXYhIE6UsGo71facXCyM5lww4kdqvIA0S4YfqfZjfUojG2Mq7Q4BTjToKToNcjlCYl+knLksiSryg2nBaYn8YtH6UaxI57zLyeCLl6YTdTFTJ2XMT5KN5xM4y+xIh8SywMoxYrQgOPIYDlmS0ej15DM+z/C9oP7DIu40OobSuFpiXbIPpz+BkeGClTIFAjv6ZVmdtUTuxfAsUhWJRMrVFl/X0Timuylj93Ke83g1o1wtM8tDWxQOVsM1deHoPQni3l4upZ1CJ+TXUcQiK1Kfd2fiYdscpHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:408::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 10:38:07 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 10:38:07 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v3 4/5] ci: Add variable for additional xeno-test args
Date: Wed, 17 Jul 2024 12:37:47 +0200
Message-Id: <20240717103748.161788-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240717103748.161788-1-tobias.schaffner@siemens.com>
References: <20240717103748.161788-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::9) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ba8624-7ef8-47c3-ce02-08dca64c8b97
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+3DgyXrksbIItaehunj31Yi1U/WTNgi9hVOOKtUSU6tVn8LyyKla7mN4cXl?=
 =?us-ascii?Q?JkCn9fiHMFfwLtwzu9+DOGuBn3PFY3hs6WzbeUCsHQg5mRXcudTLR7dT8epv?=
 =?us-ascii?Q?ArgWYRd+clpOpTbVM4C+zb11xttrJGWZef8S0yDuATil8PcGR5l86gMA4i58?=
 =?us-ascii?Q?hLp3iU4qnRpb9hTQC+hO+rKyuNSEswVs1cXxNi70aqyW9lTPBeYvNnwHweBF?=
 =?us-ascii?Q?kUrlXn0UdMEQVsOkB+RqDbudUlu6IsYcVnztAQFC4H4jRw9MFUWzjdbSJNnI?=
 =?us-ascii?Q?iXW/mThTPdjS+hbnV2/+reJ6eXGpCthHOf3w+PgWfVR2gnh+ZSplRx+8nYna?=
 =?us-ascii?Q?PQ3TIEbxlijD4MMFvRZRKDlY6P12ptCuJU1qOu6BQW/qFHtbFI8LM8+kYV3e?=
 =?us-ascii?Q?DIKhU/r2W1EdDAYeQRSLY8plc2SIjAQFA3PGemaFtu42yNPrY0F2n1tpeykO?=
 =?us-ascii?Q?BpguwR9/57ZDZ18j2vAVUD2u6MVR5pUSqi8uLHCfvPc8joWdy1PSIfh/o5nN?=
 =?us-ascii?Q?tQ4jXgsuXtdKlaDdNuvUg/O+o3rXTEdGrRWFtmA+of3SbUhu7sNd46eZu4qg?=
 =?us-ascii?Q?widMQdWV/48GUYUFPo0b211vctP0hLJ1YAt6A3OBDXZcbPnFa8Wy+s+gz+Jy?=
 =?us-ascii?Q?408cVcCKpoPsw0foXAtKsZrRXiBuJXmDnAGKpm7/F3Eb8unUcnNqytz9AlRE?=
 =?us-ascii?Q?TtZ8BEhxcWsv5RDGuxhaR1RAC8rNUOhxpo0mLBxj4Agyab+e4ZKcyaE3q8k5?=
 =?us-ascii?Q?HAtZMye4oN3sCtt3ODUs+WTw3gCJ4KH3lo89E9HpV7htLyJK7xn1Iyu22qsd?=
 =?us-ascii?Q?bsoCkJyX0YpPic2LoV6od4qwJI7btbzhiLYHRysl8u60oJqJwxmexMhJ8VGA?=
 =?us-ascii?Q?hrtvGfdbErQc+XhxT4PSSfVSOZ8HSnMjUq0b1l2Bm06WN8TD1nfhcW9y9aGr?=
 =?us-ascii?Q?YlHDvMwUjGBiwKkLq5Mq7SJzI9hx1VsAyjMR9FT9J6Yk9vddQdeZQXhARcU2?=
 =?us-ascii?Q?GyTjM0mrc1H6B3S1hwupyZIQwduJSSrcjwaS6m0D9taBRZcVv8M6EB4HnRKS?=
 =?us-ascii?Q?1DjjS21Y20gZUiygpIkHoMWQr37k/SJsjeY6haI7WBPFcgrV1RtV8fi+M1jl?=
 =?us-ascii?Q?dJe2YBZje5rU7/EUvi9L/sQFn88QoClNLp0hvzut/9vDyBXCpb+iyLOVyJ+P?=
 =?us-ascii?Q?FA2R6vDgfrT/c6A5IPi42TFsM/piIChEezHw6ohv05bNeGokVCaDpE/pFwZn?=
 =?us-ascii?Q?3F9ZsnNyXIm08sojYrOMXyh2RimrRKOkWVrOgGC1Mdt+tRBUztGRf2S0WBhB?=
 =?us-ascii?Q?Zrk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5DiHusewMUhLXE3OwrpXkEhvAtXRZBa3qByovi8ITJgg34dLRPRmBkLgN90k?=
 =?us-ascii?Q?O6R679+VCKzSpM/n6nuCu+MUUNAPFH3PavRzIXF5IYYzdME5R1D3ewFPSLCh?=
 =?us-ascii?Q?DeG+j/WcWd+ytXCI6WZN6908UTzANsI710ktHEw4z4GqcPbpdKVb5M04duBT?=
 =?us-ascii?Q?mpAqZrUOvnSLQXupjmCz+jYyJ+bSChnFyguIqkI0fggOSfv7a1Ube/GLkaqp?=
 =?us-ascii?Q?sgqfO3g7jyFIoL3Nno7lzz4EN2Msnop7X+pMhoT8FIOa/4oqhcYY63XBq6z5?=
 =?us-ascii?Q?fQpoP0dOHIPoVpj9mmzA6yBbeXi3W+A0BcPYwbU2EHvkE67zboFHpvYUAG97?=
 =?us-ascii?Q?Au562wqwFWFuR1fLpnpVVNbLGKgwAwp/ncgNFbV4NSu0/Co8Epu16kbUkIln?=
 =?us-ascii?Q?4i8BHtZaoARWJYv+jaMM7EjLTiKzuRm0NoPsAnCAjAhL4EmWvd8EvSWEgh12?=
 =?us-ascii?Q?Dxe29eLVRa9+Qgzf9OkqDm88u7YqlSEnj/fd4Y6pVbYBLbo1x8RU/KGe/EXT?=
 =?us-ascii?Q?1uotsZ8ldWJbMsdLdKxPNqu89epw43ZyKWopQZCY9UMptyJn2rf/FnXfK1TW?=
 =?us-ascii?Q?FNBpCBSNLoARzu0FWogZJGoeq8Cx6BZSOnkAkbGOKSKWjbS+CQrNHnP4ruIn?=
 =?us-ascii?Q?si9A9ZpYSTGdCZ2HNmtCDWyqBVBijRgjiuVkAjnq25KpyuvDWLc6lXSlM/pB?=
 =?us-ascii?Q?fOe53JAecFcROv+2tTDCduT+2rZLrKFMF9DCRevHlI4KmaOT2skyaYrzlQWc?=
 =?us-ascii?Q?+zj/766MA5B1bkG8EfsIGRgHnuVxvB+piHOOFaU4C6m4cXWA/bz7Fvc9rfhi?=
 =?us-ascii?Q?CODW3T3ZbubKeZc/WJaQsOc7bM+K6bzCyhVj7zosTuGbllqAVIvkt+m28YjG?=
 =?us-ascii?Q?u100DaV1XtsDGyTqZW5nmKfnpw94/Orwfllh0/Q7UUYjIUwEM3oPPxIGHbsb?=
 =?us-ascii?Q?QAbN2WnSU8M2MoFvN7y5t4wv176xFjw7NhMqm1fqmNsjwNGYq+GR9zv0FUXm?=
 =?us-ascii?Q?JL9nY/moRsT0nC1xmFKNcTx+ivVKg6iC0fNmAMKsmrWHvCFq/pl/kKsXK490?=
 =?us-ascii?Q?5nttpUJa9p38Zn+vU+c5RcC1wuRmcYWeCf+cORctitar6jyW7DAtULTVJ9U0?=
 =?us-ascii?Q?77axPoGGyO14YeUxvxF8s0hGZ2Xp2i7yJiwni0iBcoQ+Ga452ZA7TS7ZtHYg?=
 =?us-ascii?Q?2CnW6ZOGB5IsTWaRyFNV5DQkXZ8G7xV4sprAqlth0R0Vd++GOcuZCS1Hlsvx?=
 =?us-ascii?Q?cG5mo4ukfQVVu0Sa7X7NjtyWane4zKXmJhs3K2HDILoI56m/0UQhHu31h9Ca?=
 =?us-ascii?Q?dIeyIsrhFE/eHVp4652o/6oyfakUF5Wmd+sWpgMCLSC/OpKgH5k3719WSWKp?=
 =?us-ascii?Q?eZ1woc+GhItEV0TB3sFqphndsGHWney5Ndh6WM2XnzFqAeiJlPiwIGOeCVah?=
 =?us-ascii?Q?DHbXdnPGS0qkmVbY1MIO3dhivfRO4dTh2PEBZNJjyF25PQ7OrO5kmywTQaU2?=
 =?us-ascii?Q?KwRi24kZqswrVtpiM754s8zlYhDSxVsXXW2JyCpgZ89E2MWVLbQeBTN1AjwB?=
 =?us-ascii?Q?o7EBV5/Ft6RfgQS4DSkP66RNOYMrwb+rxVqHB/VMKBbPpvr2icTheDEHp4xV?=
 =?us-ascii?Q?R1AAKhoD+WmWQ89EKmA+hrE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ba8624-7ef8-47c3-ce02-08dca64c8b97
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:38:07.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pV9NEqGZZkz7rXmOWPKVKmrP/rE9WaOYDYhKA9sDAIufZQBDnjnMS3pXWym4i5PNd2Jg51plDFHk+EbRGAcBZ+S0Mf8XiX3OQaQXfDpEZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6439

Add the additional xeno-test arguments directly to the XENO_TEST_COMMAND
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
index 041157d..cc09205 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -79,7 +79,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - ${TEST_COMMAND} --vm || lava-test-raise "xenomai-test failed!"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 09cd0ce..2e9d1d4 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -85,7 +85,7 @@ actions:
             - quirin.gylstorff@siemens.org
         run:
           steps:
-            - ${TEST_COMMAND} --vm || lava-test-raise "xenomai-test failed!"
+            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
-- 
2.40.1

