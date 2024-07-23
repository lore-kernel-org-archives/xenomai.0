Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453CE153800
	for <xenomai@lists.linux.dev>; Tue, 23 Jul 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743690; cv=fail; b=QbYRY6JeKWzs47uxaux77/59ft0fB20PPQl2Gip9PA+cYS9fhZZB4/ofDtSgWMaRXW0gQ156Ro1mMRe8SVcUK0W8MvvlqkrNNpQmD6P3mRcs4foLvK2ZnnUhWhnRFZHmAMhizfQKbK/6Wb+rD4vwB5xOtg/KmFVn4C9NSpTVHlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743690; c=relaxed/simple;
	bh=BMLQbw9OcwAlBixJq+WNxkX/PXgPi5nUbusOD2iPyE4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ljbZ8/6lrSL81Fsl8oj6lP3uqP1FFtF+8qmIWqNGpiYN6rH9qbLNRP3gPvqR+dEWYpQwFoQTEhD/NFPQEcUABSzcNqgfGtEPv7dwPklEL6xeg+rKGlDm34TAd0avwJEMsowlX9cBsKkmrsCJWu0eE/VYGPMbyWqVY2Y5l72gFR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=XpJCTirl; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="XpJCTirl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJc81lUbV/p63LdehiWJ/TxP0QZBE0oE0Pmdaq8kqV25kAOcvTCbpEfxZcCDq7oHUnlgO2UDJdoLN2trarwBXwwQG+C2CszDTok0Mu/awKvLl+1jQA0RHnbIlWDqmYXNBoONg2LEszibos/n6Gv/xvDXLVrAhC4gPUdojmkF2LGac+8iI2U4cexbN057o7GKWSEw9NbtFgUIajQ1nF7rX3KQU33JPveZKenuq/Ygy1pH4XTh72kC9rtAc30Wq6obRZXd17Dow2kdZeB1u2cY5fYT8tWlXNUSowAOLzHQ608xknJggldFeRVzsVWqjcmoGPZjs7G26O0mSZUEYOMc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEEDHKHsevt1ZXaSOr9J4GIowfK1+rWw5ZQ+ym197Wo=;
 b=Rs7Xt7weLPQmU67D/Kr7LyqmHrWjPuRPptPbiNEcJex4SrWkvWoo0Jh8WbkhDnbHzjh8QtFwBXUIqAvwJIo1JIq6kx1u0pawDW7JC0rPVZvYSB6UeosgLrXxtnrukdnSZUMh5iNcvkMTdJD8BpUTisHcX4PLNsKP8oQNrFBHNGkiYc5E3TFDkclVyZdXLJcDHntaZoy79bGJoSmBPCCgfRdBKKsF1eXl6Wscn4HuA4z6JGzKjj/JqU04lDOKTxJcHZ57FAnZRi2z1DK8FtteAmMdiQ7Okq/bgZAWkYqHVBBXKaHBeDnMiGP8cLqHs3jPjgSw0aJDEF7bQLiaozHaoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEEDHKHsevt1ZXaSOr9J4GIowfK1+rWw5ZQ+ym197Wo=;
 b=XpJCTirldXWhMciFXE4cDjGAaDrdF4YILmfEW+TppqNDQr8FT7mAVnXDBgpBqd7sz43ltnB3GgTO+Zxni8HlroZaOlkevvpSTf9PBRhX1ko3B/SXkK9GqlHwepfuj7sNGZyMydkMYvqIzkYKd5j/VC6+1nE7dQNL4waxu1kq3FcmxMKmRGVr/Ihz5aw/lw0FT4D2O/VRBOdYLsD0ej/1rFtgdamD4L2OsQypZJ/Xp0Dsqsf9cQ5yzrZBKHG/2Ao3pCfsRkVM2RupzqlCBNMBnVsChrC3+WB4GWhQnqGrlqcP36L8fS8JFqEbN8e7Mxp/7W9w0wswTdV64APtt17TSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PA4PR10MB5514.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Tue, 23 Jul
 2024 14:08:03 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 14:08:03 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH v2] ci: Enable sstate caching
Date: Tue, 23 Jul 2024 16:08:01 +0200
Message-Id: <20240723140801.1247672-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PA4PR10MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: c608bdde-ea18-4f34-5343-08dcab20ddef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rah2PjYGamu4ERqqU3cX6FdlNdWu9N2n0pcabThvDCZK/n6B3xVB8kgp47TP?=
 =?us-ascii?Q?OelaqxUCqF5hmUmIaXPmCo7lLSckZ/fyqdyhhv2+4S4s9mELfDHAA6Jmzt4+?=
 =?us-ascii?Q?2+yjQfZ9p9bEBKNB/JkmU43g++oyxFnuFGo9VemnKFegqRqJw73OF+TKvJDC?=
 =?us-ascii?Q?zWhxgV/mOW+gzS9LqXiJfgm8kjNA1Y1qzQUHpM1nUwwG/5qd5kom6EJyaJZQ?=
 =?us-ascii?Q?h1LGAgEVFsxnvSHkue6Z/zzr3GPzkn52Br2nSFAxrpy7aRFPmHytSXbRmQgL?=
 =?us-ascii?Q?3LuEfo5L1qKOa32l8Dx8ITi+VtLgYWkk9lvUfFoQy4qB13gJ0gWcqEafb45e?=
 =?us-ascii?Q?tRihgkEhYGEZiTvEndX6vM+vHNTkac0u2+o2VCR0Wcwzh55bqPHN6PKQyYNz?=
 =?us-ascii?Q?waP+rAT9QtNw5q0KHPYch7bxE785fNCEBJ7944asMTntQZEb2fB31UrN8hbQ?=
 =?us-ascii?Q?DNN2BhACQ508FYr2hLwId9dmV32Cf+SzPcGQZPx4B8EOX7KhDn43POG32JrW?=
 =?us-ascii?Q?1whgRMr38bnw+2Lpgkv2E4LxcGvxTr1rsUnNeYWWIyZPCT/zynEXu74IgJZ7?=
 =?us-ascii?Q?ujs/R0sOB1RFFn7kQFFVaBsBalYY81VDR1uP6ArkgTo/GHIbB9ykSmX3jb83?=
 =?us-ascii?Q?1+4YZ1O+ssZRSpa/j/Z+y5jSDRPJwX6QtoIEbel20yqssYnU16Sk0TL6Qyqi?=
 =?us-ascii?Q?eHW5pInsq4+5+SA9ICdIIRebyE82kKDLfa7gsakS28Z2mPZYQRGoPtUYsL8h?=
 =?us-ascii?Q?0uR6cYY7ehcSK7b/SMj7fURr9I8kPrmTigBZyWCXLkYbvYeAxNpRtL8ywupB?=
 =?us-ascii?Q?BERk2zZuBmvQdXciovYRSi636/MOENtGq4oCRPQTOSvqO2l9pTPEOPagIKpD?=
 =?us-ascii?Q?9j2DX+VoVrJAWxRKE2YNsYrNP4Gr4bzq3enX96u75nSZKp+5nOlfSZRX6SjF?=
 =?us-ascii?Q?yKajadc/E8UtE+c+Dgzw7i0lm6slUsP8h5L/LP9VaHZ0pIv9h0PgwcUIe7FZ?=
 =?us-ascii?Q?2H/EUUP9z9MXK8zxu5mDMT+Kn9HSkioag0FA1asm/xfOdBpBG5LJAKFMz9Ed?=
 =?us-ascii?Q?CgWloTTxi+Mq9pRi/iUGzo7xPS13yBMTRPdHIxwMQKoLEHk3819eKyGPNShk?=
 =?us-ascii?Q?jVZOLFypns/sRls+SoEb8JHl18uLNzaqDwq+TT4vdMUftNiSSeEPTA1CifJS?=
 =?us-ascii?Q?CHu4NS5VN2FH3jvi6+GLwtmw748CwIPWyx7hfeIe3uM022CM27SeLS9BvHCj?=
 =?us-ascii?Q?PcNW97gII4i+kkxNSt7n0R9ChxtqYAXfNbP8MuG25v+3iKk6af5vbbNIi7MV?=
 =?us-ascii?Q?fN4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pm78Ox0xjXbMv+tI0ibxuOTNDpCzQD9NZRB9mFCGiZKfH9N/Q5PVqjELo8tB?=
 =?us-ascii?Q?UQ+CDI04VXZNt+iGlodZjCdlt851ZWQu85pVrFA4Ehr34aCRglJip3yGeu2N?=
 =?us-ascii?Q?XvOoSxvXPujkzOX/Gz4VWu/NnRtZVDgda6MbGc5Qb+pie0bSQ/Bx98SsKZVL?=
 =?us-ascii?Q?8ECCrFayCczMgwS7Vt/vNJOd1OM6ryasjU+MZMHUgqoNyUq802ksZZxrW0RD?=
 =?us-ascii?Q?0pQ5evglc1NTLqfGk4tlUF6vP2vWJ22m3yC4VpcMCUs7y45J/yTJ5PUPKfM/?=
 =?us-ascii?Q?Xz7lqwh4goGW3F1tBR3D1Nq7D4mRNJkxeNrEYxJK/1P92gAW+snDCodPQVya?=
 =?us-ascii?Q?6F3ZkaQS2A/6Za1Lsaa7tmOaWdGaV4MtjEEUdZCp4jRyajZGkk6iRRCpqhY4?=
 =?us-ascii?Q?oCT3Kx5jyy8UqLFg2rlDKo3SM3NDrzTjn3HSzT/uYWtv87UZULa7fdW05/oA?=
 =?us-ascii?Q?7TFzqmn8bRzn7Sg7omew96DTP4LJGRkJ8ma/7TYNqW5BxWJKYcLPjFNG2bBA?=
 =?us-ascii?Q?2pRdXr/Vrvhu7KQZgfZMAwolnVZzcQG1vJx/PTmnmhrtFb9LOXCMeQEj4vxo?=
 =?us-ascii?Q?naxqT93+g8o4K5rr3qZe+4t8TMWAuj5Ub5++NTi48piwmb7PzmqcdS+P/sFX?=
 =?us-ascii?Q?8Vo2aETeV4x2Z6ym28WpCTLq3tMOP80PJm9N6hFNhJa6oNLYzpmr0AM60hSr?=
 =?us-ascii?Q?8kxbI4xsKAxNVKVd15tEZkP/LCEcWXIB9MmWUXaiK5r9nta7KxsYszXLBa+6?=
 =?us-ascii?Q?pjzFptO3G9gnAafi3K7LiVBRM0G225VpLQYCsu12b17newyB+9Nka7N8hZRl?=
 =?us-ascii?Q?WdRK6QDPnA7kE4m0mqT2DkcZ0xU/bhf6RLIff9yugcBb7F1mgz8632rUmndT?=
 =?us-ascii?Q?IkHWOTj9AUqqfWgbqRcRGSWPE8C7SMfNJYHTrnt+D2lLez6XyNc8Hme9L+RC?=
 =?us-ascii?Q?tk2L/ZwOXwscMC6/6xex4z+hOJiNP7R3++7wqmCFi6V/M9FJkBcxmUGwrYGt?=
 =?us-ascii?Q?gndgNBBoNlyvFj+JYmvAbCvDmADUKH6b0j1XXRaWURL4sEO/sMlIyMozPPPf?=
 =?us-ascii?Q?xqEjD/NJrYMUw8OHBosg3Z+tQxM2FK9FBwRsrIU7btLVaP+VIYsohgzhRg3U?=
 =?us-ascii?Q?hoVvimQPSm+StsCpcbNMJ3r3uvnxPqOwgP8oIXwTqwMmFTJRuQf47x24rInK?=
 =?us-ascii?Q?O6JJxiK4Np4By1kaItsKuwUyaZWPq9v3WKCvpbB0C5SqmuQnIg2v4ZQ2qb2W?=
 =?us-ascii?Q?wTmCK2R4UNLuAOdt78juFARCCfOfEA9zfTXwz3b9N1g7XR6p9OyyHzpETrZG?=
 =?us-ascii?Q?vnjYjX1jscsU0b1dGrMgndLKPFLHhRjsYNcoy2WEEkQkf+nSMz3C6Pf5rahj?=
 =?us-ascii?Q?/pIOxhZ6uA69+0gSA5tW5HIzeQOLtQb/szkGVmAZVzT3+7rr9fZs6pIfXJ2d?=
 =?us-ascii?Q?pVyISr3PHoytuw1Esw1/N9UnpqPxSikS+BqSgGdwuK61ybtViUdX4kSnAWxs?=
 =?us-ascii?Q?tETLiEdDHHW6D+TvCB8o0Ftgn3F2b8DRUjF0UtkzV+DC+MJavgOEOLD6VweC?=
 =?us-ascii?Q?37Gtj14r+o7J08jVIIEjLK21HlGHohf9ak5UadukSTyOwg2N//NSJb83kgZn?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c608bdde-ea18-4f34-5343-08dcab20ddef
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 14:08:03.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIb536nVNb7yloUhNAQXxD9wqeWa7uFnU68zsRTnJlANnkGr3WfOcD2z1MkCMZpeg05kUdo3MenWhUfzgG7MQo49lJS40czt1uSEEuPECFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5514

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
 opt-ci.yml            |  4 ++++
 2 files changed, 44 insertions(+), 7 deletions(-)

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
diff --git a/opt-ci.yml b/opt-ci.yml
index 01d5c07..e1466a0 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -23,3 +23,7 @@ local_conf_header:
     IMAGE_INSTALL:remove = "sshd-regen-keys"
     IMAGE_INSTALL:remove = "expand-on-first-boot"
     IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
+
+env:
+  AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID}
+  AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY}
-- 
2.40.1

