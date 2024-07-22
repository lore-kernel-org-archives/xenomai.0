Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B016B399
	for <xenomai@lists.linux.dev>; Mon, 22 Jul 2024 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646683; cv=fail; b=XfccD0gh8pqr/MCofLTP5Uw2ZyU0vCFhBwfOR2v/qithRZM47n/jz08kfcLvgk7xmbi0Sa8F3stYFkjmQXNqxl2cdkvQMCWwvr5z6GJCLhjxPPqR4vF3r505pKaP2c6uAHNu1khLxjLKCF/BtG4fBB1qB+Y/uJmMFakd3d+p5IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646683; c=relaxed/simple;
	bh=bdEV7uEHIuo7e8M9y0nNFgFvyMt2zQW18bJq89D/eq0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c6AJzO6eNSEGE9TiL0ronxwwLdfhjuU+OpcoJ54gVHWvIB0WBMxH/AdvQ5+gNJ94V3ZtJRmo6wvKPE3MTNu5fwrR/vW+TXeD8xWFrJx/vTyF0vl2JUPUEbU3lmkvVe0j1HT6idp4o4lo/QWDO29fBfEB32gsbSV2VqfsPyG2GvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=si47wRgm; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="si47wRgm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sK/maar2C3mW0WJ9JxjinGNpMQQh9Rwu57RA6xsUSTNCg8P5H6xstkZcEeOI0JAdcq+Awkq0BaAa3HcBf5dzr84qTGQM/L80egT8DHqmf9cH4GPryRPo+grBBXov21yz6sOtzR8Rgn/DIop6XyVfIYT49YVCkdScnetH8FpuI8YZzyJ6MC+VvSSW6U3bkRZg+X35PVbu9k7U5AmktwxoMqOhdW2WBz+7t8M9cRbIUwGd7635EWtjxjooyR+PkWhmPmNouHxjhVJzNHhM81yquKNJmxtnFRjVaMOIL/8A2ADAcjCOeLeNgecPbV6sZ23+um9C4JePQYejceAeRYGOcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxMic/Bg1wKILT0iqrSFQAkx5bf8yrfJm2H/4H+4oyI=;
 b=x/MmtBnrG2ZJFBJTeu1WZp2PsEFhI3wZMPhcCYaQGNhIpbHd3KQA9y8/8NVeLJvT5Txg0l1be424Blq2FM24xVQx4jIKDQi9jr2OkObVfY7aETjOoboh2sJMKROtcb2JE9MSPO43gnqTk5cCVkdYTgWX9dcb0FRKH+hjRdVHZ9eJyMc02meOqY82NDokRXRandEqQUMvdly/xotJijrSpxmkWH5BzVF4E6mEBdJrkYg8+1mXBDk4N6d/CHAY4/HqsrI+JmY5eKiX3ovhu1/3ZE+WqwYYRBseYHeEcRFYO2WNymliE7QbdF0R0Kd1zIgKYHxtMxtuNSa7xkZQpqopIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxMic/Bg1wKILT0iqrSFQAkx5bf8yrfJm2H/4H+4oyI=;
 b=si47wRgmpbDqzDtC0qrdj77x2AiCOKP1MwnhykW+t+zx4lM9l6XkKXenFQ2SXW+D7HMS7XeV7/eN2003lvRlw/2fvx32iJmNONY0qMlTuhDdMaWdxRWFMFCTggXZaFz/gZ7vVDG3nE/Q5f+7fWCMWHxzuIwH08PYnvUahCchQ8OYNTTX+Tz+8rL/X9xs9Yc7As6x1BqOD0I2jfydnVWU6a+eqhiD0x+IQGwGXWl2FECY/9BtZiVXB3qNWn8Y2efmr14kAzuUAy9aYGf53UnxHwIgsysjD9HaYNsLAfp9ZpX44sfxLclYUN0b6q4b9/gmmgVr2gjkhA9X0yLvK6YWrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU4PR10MB8560.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Mon, 22 Jul
 2024 11:11:17 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 11:11:17 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH] [xenomai-images] ci: Enable sstate caching
Date: Mon, 22 Jul 2024 13:11:14 +0200
Message-Id: <20240722111114.1080113-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU4PR10MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4a8487-5050-4c1c-e068-08dcaa3f01b7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FdL0oQHBDo/Z20H16o22hMF9br3cCp3m8fLGVy5xjW/2BTFnmzMdRtZVTlTR?=
 =?us-ascii?Q?P528Rks6fNQGbfWOa+HlgJBOh3Efn6Ui2KakUktJr0edH/AgxWzJK5DwpQ6J?=
 =?us-ascii?Q?X2suJR9Dt3KNqRh5YwqTAr7az45m777ernUjiI82sW5CQqKJve/m98CH1e8z?=
 =?us-ascii?Q?GJzI/dsHaCI2aVhmbtXmnUFWHMwhg3aB16MKJ+fCCMDzb9Rp7HBUIFg393e6?=
 =?us-ascii?Q?fDpb/AZHXQfFVETUswIb4LL6gBlB2lLmbLneAbCJOjwRsbDIUjJUfIOarrCG?=
 =?us-ascii?Q?ca4/0GplIbbjfKZPbHTLJScp+aGUvQVJi9X4i6LNfS15rTK08HG2XOAxRHmT?=
 =?us-ascii?Q?cCAJJeMltHQUT2RDUASvPstFSnujMnftHLioFcreYS1LONJCzCBPx8nCwMnP?=
 =?us-ascii?Q?V+13spZlFt5GwKVlnRvbHbUwR0UFVgs/ZdwPi9Y+K9dIpiJPHgeA6PtVPDYk?=
 =?us-ascii?Q?I77PC7a6hDruYvSWldKz/ohMg/Pju7Nh8pXPoeC2/W5JFeF7AHw+WHIj+ja5?=
 =?us-ascii?Q?TgCbp4MQIHreKRgztEbSba2ZGQW6h6waiGF9nMPB5qO416LqGaYEW2de9Kzg?=
 =?us-ascii?Q?iW9YOMVwLVfo5jF+02cTMZJjcSXO7+YGFgbu36t+VQmMO5LjVpQo+oePnFMq?=
 =?us-ascii?Q?ZfBDfe38o02oeJxQdI9mpGaOLb+EnHuEIPOFtGhmFrC+UybwKAF/s2mG2vBZ?=
 =?us-ascii?Q?TkZ1SXrBy9eYzdN3dpAwl0a8z+f0z1Bw2jBS/9qsaZehYh0crNAmelgblYT1?=
 =?us-ascii?Q?IEiguMt2cfkN1dB7QDt118EP4NXk9UsZ1qCNBhXJGztzIwegtahvusQGsnvJ?=
 =?us-ascii?Q?lzeSSbiv6ajxzFSEP9rc97M9c/CqlmmdCjzkzIk5+BuijrzmMkzgBbFPxDts?=
 =?us-ascii?Q?LH8uiwsPkDTlCjRzOJ5zEJHxfW4DYK9pVcubVh9EA+Yr3b6WQwQeie/MVPYQ?=
 =?us-ascii?Q?VvR0mbgjsLaR7nq8lWY7wMPG1rGkQvVbCiWb+Fdg3cVZ7wxgk+qHZR4ax6ct?=
 =?us-ascii?Q?F/I+SjEeR+Hw0AwOgWreH1A6aQa9L3A6yKnaIC1Y/o/SkKGWMcLkMs+lmxkl?=
 =?us-ascii?Q?9SjPLjfW30rz5eMmDdV4ToIAvbDQ4MKjzNXzoK6mtuxYMrF47C7IzEmOLu4b?=
 =?us-ascii?Q?j4ruKCz4m2XUJa9j7VseeFXZaQM3owNLinOZeNksxpJRle6m4zCPtwWaT20J?=
 =?us-ascii?Q?ztXSiSs2jLnNJFsOi77iOIUHyoHNvTpzsLkQ9EBj0W17h3ydRP86TvMZJwMW?=
 =?us-ascii?Q?zZiXUwNAXhhvSbHrS7VQhg/IYqdhaJfuR0RGv4WvmJZqOlMx2JR804iBI63P?=
 =?us-ascii?Q?b4I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?87v8DAfpMn6oUt5H+kaC/si5hAwj7Xx1umo6F1G+jta3t+uTYCQfpN0BMlEZ?=
 =?us-ascii?Q?K3SMp228SvGJTuUxmHh3bWVnS9QQgm23pAUXdXjlDAiCVhdKAcNERzzBLq09?=
 =?us-ascii?Q?gLSKruARzJGYrUpjkdeOwQ0QcxZyUg6CjtvOyO6sJzEai7+maCFhK1qTTvbM?=
 =?us-ascii?Q?VagnZ8l4ok5FNNMz3mSMt7yBjQdR6ejoLk2MVEwBYGjP7o0D3eETzQ7xZnTw?=
 =?us-ascii?Q?1rsDGjdJSI+xFLsOiwK363vXhKzoVaoHRFLnbWfIY0zz0ZUGnp6XE2rxAUKL?=
 =?us-ascii?Q?3v+DPQ6Wj4D0vKPHWn5PL1a5OTD6unIyimHbbQBRU2nmUq2/aW4ZV0pUnQt6?=
 =?us-ascii?Q?SOTkZxNQT53xrT04omlj76pSkY3J7bdwV6l5rNQ6vtY/HxwfzXC3GDYZ4i0o?=
 =?us-ascii?Q?m1LDJUtckkAdqdKVnIrw0i3ctvm1BglUChHmroZ9sdUO4TgwEfXzhwS30sps?=
 =?us-ascii?Q?Z8K/i1nHMfrtKnGDw9SzOBsQcHTNe1IxX4Z9944uhHjB5kUfILP0cN7soDti?=
 =?us-ascii?Q?bYGhE/lX8eOjJJNOzix7uyDhkHzyeZgwnjn3ojFzzPmfBmsgfuuORRRfjIAh?=
 =?us-ascii?Q?02uqJEJ7bJbfT1H6QqR11d8NRsC5BRfX9dO3A26zYaVMb71BG/xPvJmr9MR/?=
 =?us-ascii?Q?MV1iJ4/5855QfIbaQK3sDPlvl+fs/AC6AyYuUtVkjR/ctKtZTAt2ApnQZoFN?=
 =?us-ascii?Q?wkK/VBD89aaPv3qAcU7o+W2DbftMmU2YdMvEp2CfnRluDhyoZE74VstxgF/c?=
 =?us-ascii?Q?LSZQkoUMDwS9xBIIMaqW9TltkuK6kCwMX13s8AEhfUCQGMoLkGd6oS0hI1+w?=
 =?us-ascii?Q?cUSrAlh2P0EYun/cf9JhtN84BzwICTGe+H8KxMMrAr8sp+cIuTqyXLZAaIcL?=
 =?us-ascii?Q?4MqhFWyTKtvr93z7hypLJVI3LT/zQygCREP9OQHblH2O7mern2Vv6yJ8AR2o?=
 =?us-ascii?Q?NDl02mTAGiT4keyfwnHtMZt2fO+gYobLF62S4NiPryOHhCmfBdcHAIDwNY95?=
 =?us-ascii?Q?TMmqfqf07rf3LrL6MxEU1QMTXqwp9Dsf3nmfkJIi9vpy+HsiIaorEjRGnDkH?=
 =?us-ascii?Q?3EWhAhMlvLPKR9WLBNpMpJ9TaAYLfnECaHhMbeQ+iLmluQO7Nk8TnpEs4Zd6?=
 =?us-ascii?Q?im/g4xXjMX+y7qGBtb+ahmCSdsmOXJEr4FqVBko9YlffTAUwxkT+JRqiwHJx?=
 =?us-ascii?Q?M1FhWt2w8XYlwE6V5p7QuC1DsZlUKPBaH4V2tkcf7qizeFIkGCOKpL6JXU7x?=
 =?us-ascii?Q?ED0joEvODhf5gBfLmX2GisH5HEHjYSTDiD3mdg3rvtVUtVGG6YdUmGJDzFHS?=
 =?us-ascii?Q?e7uFu/C/K0IYqlHlhRsFcAs8B7mg2jMzmC6uOn1aBsUMOOR57ErzOpDQgDNn?=
 =?us-ascii?Q?KwWNnTkFZaO36f6HFYrQREvTnMH/pV4gJPtBP8isRZRHSbKFhtKlMdraxpME?=
 =?us-ascii?Q?tc0K9nallI+pJ0nl9AZngmEBt45Sjzyt5RFMMc25xm3oNurY7wBScVOh+OBn?=
 =?us-ascii?Q?/ovbt4zAWE/h+z/mbAyfdTT8/K1QkmPw8l/vfb8a4J/hvPWo8AZ7Fsj/UcIT?=
 =?us-ascii?Q?Iu5W834ZAYku7zPTw5RluS2QfL/Jjw6MoXHduHazM4MleSqlO1jtLwV6s9CU?=
 =?us-ascii?Q?YPq7GmKuQGUkYSvLSaHihHpnrTTd+DyzZwgen47gwDUIrBIR1zH9UGfGRBfj?=
 =?us-ascii?Q?iQYC8w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4a8487-5050-4c1c-e068-08dcaa3f01b7
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:11:16.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6+bP9ZDFAw2ExzACx809/FO0ARrrnxxWhdEQp2skQBKUSOaIKscA+Nk2VkRF4geyJ9yZbCbflGYHS3pJXbgE9MpEX222ZZxTYIFmdKG9rg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8560

Enable isar sstate caching to an aws s3 bucket by using the
SSTATE_MIRRORS environment variable.

The isar-sstate script is used to upload, analyze and clean the remote
sstate cache on every build.

Cached artifacts will be cleaned every 14 days. This can be overwritten
by setting SSTATE_MAX_AGE.

Credentials have to be injected using the AWS_ACCESS_KEY_ID and
AWS_SECRET_ACCESS_KEY environment variables. This is already done for
download caching.

Currently the size of the cache is ~20G in size but I expect this to
rise to a multiple as soon as this is used in productive environment.
Keep an eye on the output of isar-sstate info.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml | 47 ++++++++++++++++++++++++++++++++++++-------
 kas.yml               |  2 ++
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 1dc05a8..f5009e3 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -24,12 +24,39 @@ variables:
   TEST_RUNTIME_SECONDS: 300
   TEST_MAXIMUM_LATENCY: 0
   TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
+  SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
+  SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
+  SSTATE_MAX_AGE: 14d
 
 default:
   image: ghcr.io/siemens/kas/kas-isar:4.4
 
+.sstate-prepare:
+  script:
+    - kas checkout kas.yml
+    - echo "=== Prepare for sstate at ${SSTATE_LOCATION} ==="
+    - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
+    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
+
+.sstate-analyze:
+  script:
+    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
+    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
+    - echo "=== Check for cacheability issues in build/sstate-cache ==="
+    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
+          --sources-dir "${CI_PROJECT_DIR}"
+          --build-dir   "${CI_PROJECT_DIR}/build"
+          --pedantic
+          --exit-code 0
+
+.sstate-upload:
+  script:
+    - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
+    - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
+    - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
+
 .common-config:
-  before_script:
+  script:
     - if [ -n "$ALT_DNS_SERVER" ]; then
           sudo sh -c "echo 'nameserver $ALT_DNS_SERVER' > /etc/resolv.conf";
       fi
@@ -40,17 +67,22 @@ default:
       fi
 
 .build:
-  extends: .common-config
   stage: build
+  before_script:
+    - !reference [.common-config, script]
+    - !reference [.sstate-prepare, script]
   script:
     - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
-    - du -sh build/downloads/deb build/downloads/git build/downloads
+    - du -ah -d1 build/downloads
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
+  after_script:
+    - !reference [.sstate-analyze, script]
+    - !reference [.sstate-upload, script]
   cache:
-    key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
-    paths:
-      - build/downloads
+    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
+      paths:
+        - build/downloads
 
 .build-qemu:
   extends: .build
@@ -59,8 +91,9 @@ default:
     - if: '$ALL_QEMU_JOBS == "true"'
 
 .test:
-  extends: .common-config
   stage: test
+  before_script:
+    - !reference [.common-config, script]
   script:
     - scripts/install-lavacli.sh
     - scripts/run-lava-tests.sh ${TARGET}
diff --git a/kas.yml b/kas.yml
index c0cce41..8bfea21 100644
--- a/kas.yml
+++ b/kas.yml
@@ -42,3 +42,5 @@ local_conf_header:
 
 env:
   DISTRO_APT_PREMIRRORS: ""
+  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
+  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
-- 
2.40.1

