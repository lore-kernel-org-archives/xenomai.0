Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794931564;
	b=KlkjWkCkWFyhkC1NyCYmESIK1AyBWMLgyT6EW/VapUagpkXzTSHpN76YHXTJ3yY/g39z
	 p/FfVXIfEAXc1qtveGr3SkAOd0F/ni0FUwUSnYHdwbUmv8yjmVQhQxwSyIX5TA+KpX/nX
	 /EfspQ7St7ossn4VDJSwygJvugNx4aEVj/qCJS0A0YknhseGLj8vleQz3lgclTixoY5zp
	 46buhmn8B9vU71/8RsZ2PxS1FJWAi674V6FeFJ8Eu+bqy2JjWTtMbFWFP+jHiOLny2oci
	 EgXZS6fmv3ZjVTFs9J0GPeiV5Gtq7el7KA+2S/hRMFkKn+TfxpR7hgFKnsOlGsj62Cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931564;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FYEPx9waIU45RqNRNTimLpTmP/gntUdONJtvmuA3T0Q=;
	b=O1yUKgGFlR1GWsh4XzqD2rV3M4Pc1zEqidWEWKRMfzNnDJoVAdKoXsyAp+FFUCjFwb+t
	 TYOm02bvWOA/5+kcAX9UNtifaa+fkK7QSAgvAlW+I7RxdCfBVtqXj4Q4FK0zFEXyocnJr
	 Pgy5fitu9RKe/3VKWhfNKqFB1lPXLTu4r8X3UUEE+FMz+xrZt8Qeo/8Qgns5CIMxT5gg0
	 +y10wl/BDl2yoShGhoGN/9DKsmLzQqDffr3ptQixb1UHys4xzbu7X+RE7Ns/prsJ7h8yX
	 xUib4fcbnEbr1p0f3BCeXYuONvcULvWD/u/kW/cw2S84/b/NIF4Q04x/hhicBzjpdbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=v3K4sfi8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.0
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE9606A32F
	for <xenomai@lists.linux.dev>; Tue, 17 Nov 2026 16:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8AE9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=v3K4sfi8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRQvYvtfPYh5d/8J/ORJUXNrVwTU3At2wrAvV+keaTjlsA7vQYHQrSg/QdV4KPszztBjhMgf0P5O+zDrdIQhAte2A7QdhX/y8V8qrrhdPGCOwAnTC1dq6N9WgGgBNTuu1VjzX8Kkkanj2zrWsUeCW0JBdyCKykdy9sWY0wQR8SROwLMcLS/DIDCgkvEON1v0Kcd7bLbhWqXPt3YkXbz5Qb+K968451G4ZVUrKCyVoxdSux4iHuKWAWAHdWGIc1Kmq9tvZpWgKf1uw3wAVut+/+dIxBcrfG2WV5Kq42Upsl7QoEm1fRXGfZxssbuqqwKEO+RE+q9lQqO3tIsoduf2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYEPx9waIU45RqNRNTimLpTmP/gntUdONJtvmuA3T0Q=;
 b=j928/FO7VYDEqffTEdZwr5pkYIaGDzZ/k6zJv3/6SyyO3d+EolVazZEiwBevskVWYPvphcG82++vjxANW0240hKdoCUIG4Q1uOyAD7h76c7nu/cEGZgZIfph2gCw+XTDeSNZosZk8yQL/SdsEmqwHBM+ayrVPAkyjXthTE0ysLquxJ8zKVkj0xQSHo0dqRZqaAnkocn+cBDFEjjjtnz7YcGxKPDaGjDv26YxobhkTRwST16V4H23sC4zPT5BA0VY0N7E1Bx4N9iOpoXs8LjI4A+0VFEf8Um34nLXAeomqOuOH0qToMSF1wjxOI+4anqJOTqHxBrKcQYRJsabXVGfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYEPx9waIU45RqNRNTimLpTmP/gntUdONJtvmuA3T0Q=;
 b=v3K4sfi8nfJY/v+4bqVXOWobuBq5cwrGyIwqoM7tHn0FLyEGcri3dkg5L6epWD/g7SSnRzOUUt91NSVOz6KkDM02nRUI8wUEpdkVf1TXThDKgwER3nT3nv+ZKsj1ibFeZgIp+d93dDLCNwsEZcskBTyOKQJVfE/pgg/4fguprlnE86X6OUIE/sn4c/ePprH8vkKsK0uL5wpNgzN/Sv7XhGHyNgxwMA+KDj6JsfD9hLc4suPFN6/htelIHg6AmrCYePq4of0sZ6fOqIXBKdzabk0KQg/Bb3Mo6IOu7rjYW3DgVCoo01QwASQ9bbFOUhy04WMsDBuNEI5IHZZpFa/xgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PAVPR10MB6839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.4; Tue, 17 Nov
 2026 16:06:00 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Tue, 17 Nov 2026
 16:05:59 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Subject: [xenomai-images][PATCH] ci: move downloads cache to S3
Date: Tue, 17 Nov 2026 17:05:51 +0100
Message-ID: <20261117160551.357134-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:408:ff::26) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PAVPR10MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb5d865-0c1b-44d4-fda2-08df44c4abcb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|261009223027099003|55112099003|3023799007|260925021311599003|260925021911599003|260925022911599003|56012099006|10067099003|11063799006|261028144727099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261022075727099003|261102123227099003|261102130727099003|261022115727099003;
X-Microsoft-Antispam-Message-Info:
	dMG7RMiswsanfu7E5NyZNz2jUKVgzYa0ltocc82Bkn1c3lkPwsVexthSVMexS8tBHGpOIcCcRHGoca9BVi7j2NKKLVd2gd9N2ckp9BKin5ECuV5Z73J6DYTMITJZwAeo6vVDHyWYt1ykU6Ob8s4x75WRESz92zlBvbt6rJGMyfXA/FV5TGsM87ICFU8G+aupH4BWlxY/ZbsNDDtyj+ZA+HnMzcricS676wAYZmWQwPbPlJ1mCT/kM6+zKm69ePtzT59pNob3p2nfxYhUSrqKnqmd3qnU18AXXpO1+Lx8vwHtyrC2PSk5XzjATOonR9FKLfr4sTXU8GTsRtOUJv+L9c9RaBSfMdh4JtvK1lxc65caY9xFHbAqT0Kofs+MV8vtvVWHTRqxp9u0xfaLv7uBScv1hZoHW+olX1pWpTD6XoKjmiY9ks4tnT44z9+F+IAC0/CEBGvkZ/SvPIkeoXHr813C7eHq5kffxCtlOPwrRqxYcYAMsxGANs3/VVeaohlFBMeGpnBydT2fCBSYAYZg7/Kf2j45Rpx1FDCVjzyEZB0CJLKV/Ty0PhPCS+cLLjHLdwgmEETfy4Czhq+y43hjObE5mIMCgACXbzNp4Irr0ir0p7ynKHuOKTsWn0ebi2vrzkEQ0gktqjtPa27yVG6t3/6SPVKiPQDzTk/eKDUrxFg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(261009223027099003)(55112099003)(3023799007)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006)(10067099003)(11063799006)(261028144727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261022075727099003)(261102123227099003)(261102130727099003)(261022115727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uVk2LTeX6FYZeYPd2XzLcP7CU9lxqKblWymegSocaYVJ2VwN/UTpFzJ/F35F?=
 =?us-ascii?Q?mdnCyD+J43/rfKivSQyQ4opp0BI4HQ+ayKE81xGQ5SWVoj+iBb0jcsYH3nZS?=
 =?us-ascii?Q?8kh4PvrDfWopMDO7Oz4lWbQWvpNCfHeIupOyFw0GCpPZEetqpZkVLIh6sAT2?=
 =?us-ascii?Q?Kpq2gVKzqyrSqZhBHhcxb1o+sXw3k//FkCtlvoR9Zq0uhoftIfltmjKQQhyG?=
 =?us-ascii?Q?XtQxRdGdrZrDg9OR9dyytTRCsqH6beo0os/o3JC/XY16qFfi97lW4pO1OjR+?=
 =?us-ascii?Q?1ZoilfWR11grzOQG/LriuUzHmML4u1UwRLlwjU7jr4TYJArRzP6t0CZpA4qZ?=
 =?us-ascii?Q?ANvHX9cradxDczGX6fnIT96gQyRAseB1yANbkubTTnTZ+0y6kOCQt3s35oOy?=
 =?us-ascii?Q?0Rk4xsSLVFXONb8fFZCHY8hFc0Cx3qDgrdW2gRznk3cUH7Om8dgWbw8F5oQC?=
 =?us-ascii?Q?+z3/RXtqdD9mQPX45E0Oj0Oobp8KFdnTIbLaLxVPxQuWsEYe3tqVbvYWQby0?=
 =?us-ascii?Q?Vjq/fgn1bokYzxAd0YAAL+HaGRuOeeeJcCk993KQ/yZXHOVWOdaICoYXP9BS?=
 =?us-ascii?Q?ts0dNsiLVcDt9bjqSWnaLYmk6BCmzZmRiaFhuqMnFu1eIpUVmNgoDV4wbIYM?=
 =?us-ascii?Q?CJnZhUPC5j+j4QcaDpThj+kVCwvSdR/awVXqytzssomNPyCBhFEnwHDlJ3gL?=
 =?us-ascii?Q?nG12SBNgVTAEaqnnZvP/wHPuPm4lxQJLvNRkI+wq2ILf/OG/gUh9jKz0tewJ?=
 =?us-ascii?Q?sSIn7b7P9ZCRnOqV/XolgC9GH1n21RQ1ZALYegyty3LPp/2gaxTaWLGtbbu3?=
 =?us-ascii?Q?tPxeezD6IKTEFHvEEgYuIAL7PuDGqehwhxdomiE3WHyoRBHkvhXbJmDpcc09?=
 =?us-ascii?Q?9Lptiq+UFEa4M3TwrWbbgfmK20ZfjXnryLdpJneGA6lCdR/Ln9YAzDgQOne0?=
 =?us-ascii?Q?/+ctf7S0aVl3UBuEfFWBFCj7E0TNVz/eWTSySbqqtshW4IamzioKYKpuM86J?=
 =?us-ascii?Q?HFWEsbVgxqF32VdWdyhH27rrBjTKD+Xiso5IeOZH5gdwPWeCCUlFEg1EBaZ5?=
 =?us-ascii?Q?E1EIjg0e7JZPevCUjrCLl6p4RDm4U9/YoNZ8mqiqG2fCDjr+kVmNTA9CpJT9?=
 =?us-ascii?Q?sFE0nXjAdmpe/9Q8HP/sVIOptHCguf52g4FrO1/5mzP5FAutaswcvn0Iu9Sd?=
 =?us-ascii?Q?fAQQOJSSfwcVrxZuXLYKq7ydeWFTicKS1T4ZzazN0mYls5ybNl2+InyYTkEP?=
 =?us-ascii?Q?FWea9VrRc/+M5IAkJ/fe0g+XlLAsrDJ7U6cNEBDPVMTHz/0vaHQ7uDqxcBO1?=
 =?us-ascii?Q?WhJaT00cmooRX1oUz4Q5hMVsSRuDj5jWdpvyL97u+2Unhm9LYoFtj6M1JMfQ?=
 =?us-ascii?Q?Ujgbd0wEkNlNWgm5f0nlH7v23bNfoTjj/RSZN3SXPr3t+yC0e6ynHk7e4JRm?=
 =?us-ascii?Q?JGCDm7w5uU6kZ6Z2gWHb1R1vj3YujNn/fGN1cetwMS8736nXf4eybiu83QGL?=
 =?us-ascii?Q?ACTAoDOdKQGl6kbq+/CnpoDiP/BwJS2C9NLklGKXhPcgwb/ld2kDdqWq1dMG?=
 =?us-ascii?Q?aj4BZHSx0CKkTCLnRpa/RJPV0JUXMVGk4UybHSQyiVheg/Pmtxr/OlETGXou?=
 =?us-ascii?Q?R1XZrC5fj69BTqd5csIMo22dJu3KxwdGqaXa076PrfSTcfn2rI/wIMC67YAW?=
 =?us-ascii?Q?YfT6Nm9nyTz7Fcda4UXZOUNeCBjaUyq/mh8xmuUWHwSWwbpjsJLBp1b4Z8hQ?=
 =?us-ascii?Q?H6qSJc3eedClJpBQWcUkjuQ/l2UO0e8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb5d865-0c1b-44d4-fda2-08df44c4abcb
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 16:05:59.8491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gni6rczcCtD4+/+EC1AabrBa+ozlKIFEn/7Rszy1krALtz8QcA2K7SBoVFdSSSXUsSIYBuGY9+m8qqUEv/bk539GZeA83YnTldCcu2mGuzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6839

The runner's native S3 cache fails for uploads larger than 5G.
Replace the GitLab cache: for build/downloads with a single tar.zst
per arch/kernel stored in S3, restored before and saved after the
build.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Tested with:
 - https://gitlab.com/Xenomai/xenomai-images/-/jobs/18111617260
 - https://gitlab.com/Xenomai/xenomai-images/-/jobs/18112103215


 .gitignore                |  1 +
 ci/lib/gitlab-ci-base.yml | 14 ++++--
 scripts/s3-cache.sh       | 95 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 4 deletions(-)
 create mode 100755 scripts/s3-cache.sh

diff --git a/.gitignore b/.gitignore
index a796dba..c85555f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,3 +1,4 @@
 build
 isar
 .config.yaml*
+.s3-cache/
diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
index 7e15321..3516ab3 100644
--- a/ci/lib/gitlab-ci-base.yml
+++ b/ci/lib/gitlab-ci-base.yml
@@ -54,6 +54,14 @@ default:
     - ./isar/scripts/isar-sstate upload "build/sstate-cache" "${SSTATE_LOCATION}"
     - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
 
+.s3-cache-restore:
+  script:
+    - scripts/s3-cache.sh restore
+
+.s3-cache-save:
+  script:
+    - scripts/s3-cache.sh save
+
 .common-config:
   script:
     - if [ -n "$ALT_DNS_SERVER" ]; then
@@ -71,6 +79,7 @@ default:
     - build
   before_script:
     - !reference [.common-config, script]
+    - !reference [.s3-cache-restore, script]
     - !reference [.sstate-prepare, script]
   script:
     - echo "Building kas.yaml:kas/board/${TARGET}.yaml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:kas/opt/ci.yaml"
@@ -80,10 +89,7 @@ default:
   after_script:
     - !reference [.sstate-lint, script]
     - !reference [.sstate-upload, script]
-  cache:
-    - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
-      paths:
-        - build/downloads
+    - !reference [.s3-cache-save, script]
 
 .build-qemu-rules: &build-qemu-rules
   - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
diff --git a/scripts/s3-cache.sh b/scripts/s3-cache.sh
new file mode 100755
index 0000000..2525ff8
--- /dev/null
+++ b/scripts/s3-cache.sh
@@ -0,0 +1,95 @@
+#!/bin/bash
+
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+#
+# Best-effort build/downloads cache in S3, authenticated with the static
+# AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY CI/CD variables.
+# Usage: s3-cache.sh restore|save
+#
+# Defaults are built in; each can be overridden by a CI/CD variable:
+#   AWS_CACHE_BUCKET, AWS_REGION
+# Provided by the job: CACHE_ARCH, CACHE_KERNEL
+# Any failure only warns: the cache must never fail a build.
+set -o pipefail
+
+action="$1"
+downloads_dir="${CACHE_DOWNLOADS_DIR:-build/downloads}"
+state_dir="${CI_PROJECT_DIR:-.}/.s3-cache"
+expected_size="${CACHE_EXPECTED_SIZE:-107374182400}"
+
+warn() { echo "s3-cache: $*" >&2; }
+
+AWS_CACHE_BUCKET="${AWS_CACHE_BUCKET:-siemens-xenomai-gitlab-cache}"
+AWS_REGION="${AWS_REGION:-eu-central-1}"
+
+if [ "${CI_COMMIT_REF_PROTECTED}" = "true" ]; then
+    scope=protected
+else
+    scope=unprotected
+fi
+
+for v in AWS_CACHE_BUCKET AWS_REGION AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY \
+         CACHE_ARCH CACHE_KERNEL; do
+    if [ -z "${!v}" ]; then
+        warn "${v} not set - cache disabled"
+        exit 0
+    fi
+done
+for t in aws zstd tar; do
+    command -v "${t}" >/dev/null || { warn "${t} not found - cache disabled"; exit 0; }
+done
+
+key="xenomai-cache/project/${CI_PROJECT_ID}/${scope}/downloads-${CACHE_ARCH}-${CACHE_KERNEL}.tar.zst"
+object="s3://${AWS_CACHE_BUCKET}/${key}"
+
+export AWS_DEFAULT_REGION="${AWS_REGION}"
+
+fingerprint() {
+    (cd "${downloads_dir}" 2>/dev/null &&
+        find . -type f ! -name '*.lock' -printf '%P %s\n' | LC_ALL=C sort | sha256sum | cut -d' ' -f1)
+}
+
+case "${action}" in
+restore)
+    if ! aws s3api head-object --bucket "${AWS_CACHE_BUCKET}" --key "${key}" >/dev/null 2>&1; then
+        warn "no cache object ${object} - cold start"
+        exit 0
+    fi
+    mkdir -p "${downloads_dir}" "${state_dir}"
+    echo "s3-cache: restoring ${object}"
+    if aws s3 cp "${object}" - --only-show-errors |
+            zstd -d -T0 | tar -x -C "$(dirname "${downloads_dir}")"; then
+        fingerprint > "${state_dir}/fingerprint" 2>/dev/null
+    else
+        warn "restore failed - continuing with a possibly partial downloads dir"
+        rm -f "${state_dir}/fingerprint"
+    fi
+    ;;
+save)
+    if [ "${CI_JOB_STATUS}" != "success" ]; then
+        warn "job status ${CI_JOB_STATUS} - not saving"
+        exit 0
+    fi
+    [ -d "${downloads_dir}" ] || { warn "no ${downloads_dir} - not saving"; exit 0; }
+    new=$(fingerprint)
+    if [ -f "${state_dir}/fingerprint" ] && [ "${new}" = "$(cat "${state_dir}/fingerprint")" ]; then
+        warn "downloads unchanged - not saving"
+        exit 0
+    fi
+    echo "s3-cache: saving ${object}"
+    tar -c -C "$(dirname "${downloads_dir}")" --exclude='*.lock' "$(basename "${downloads_dir}")" |
+        zstd -T0 -3 |
+        aws s3 cp - "${object}" --expected-size "${expected_size}" --only-show-errors ||
+        warn "upload failed"
+    ;;
+*)
+    echo "usage: $0 restore|save" >&2
+    exit 1
+    ;;
+esac
+exit 0
-- 
2.56.0

