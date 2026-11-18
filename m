Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795013270;
	b=rVfA1rZsfrL08WNJehg+1oAKs71a5wfDt9vqsI2xXU4iL7szDuuxrBonN1bvtCoJkYeG
	 2BAft8ZWI2wy5V8Z1TJQdtxZoJd63do5BcJsye1nhyFI9L3FAeY7M8XZkVtdSzbL0zJY8
	 4rnqilaDb74CG4mNt9FD/oZkZJjXv7pJOTJ4QAEBxcsXZktBK7DCRwJKXedW61QxFW2Fl
	 B71CBLZrZvm1RLVn2f6ZkDFxOccQ8xk40oRAEoAapgbq2ywTby8idmpLm9abF14xUN0Ze
	 khqD/Ay/6oxq5mMrLQ9oyQaBCyRsjIkt6Q9j4HITlG5Xa7Os2TE/HaZgROes7NAR25A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013270;
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
	bh=g4ShE8f9w2FY1059I/LJxpsa1YaM+FridAyIQ3QqcLA=;
	b=YibIsY3R/0YfQzwdv1fa/2b1n5vIfiIM6Ui6EcH9YCdZW6z2PBk1y5HMM3cokCiNo68p
	 C88xUrG2jp4aDw1k+HuFykjxw8jlAZi7EgOikE8TUM8kng+Fd9FmowxawBF9kQxwbyNI+
	 TUZctvyaUsHNXw2gG2sMZNZfp1/YDbDe3WtI21+vzuO8zCPQBwAF/uTFDcsj1QSAfva3H
	 PV7ohHeX3TXg7VR8InlqXAw/zHgj7+Vu1kqdJG8US+r6HTh5yDMBJ5k5D1SfIgyUc2ijg
	 W/rTwvF13eXncPNB9z8hnLApx3nmsCRUFCERivNMKnGSg8alRqeF37nHWW8weLl6D1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=p2NJCyCc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.40
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66560A2635
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 14:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E66560A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=p2NJCyCc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZvJA/GaW0UgEDTVhd5bE/Nj2su3PIjbW1aWesWlFdYooN56BmVeG4pR+QJT7hSSuPzJ7pp9prxya0HLKELaRWsQEdCWME3f927YVTQiBtqZzKMJHBH/7GndMNds/Bm5n2KmBnj5a9IIGAg9/jgNm4nlGbnEUn/eRe0vVl68nSJFAmls3pPUnDAl6yzSSLvytkzbtgHXICklBknK2lZBltwycG4dPAzwtMEPmYglF1NMjbCNFw13/LczQHmIenXdThzr7DUJU7FwFIb9CjWijokUmdTi3CdkOo22bnlfziJsF71ChRtRkb6smmCuIx0CKVVNVObDCcpi0c1+6tCQmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4ShE8f9w2FY1059I/LJxpsa1YaM+FridAyIQ3QqcLA=;
 b=eSGd8PljHrFN3PUVzRtiHRAKqQVY3Ew7n9DktjwzIXGBMBaT1Uqbuuk4FLKNoh4bPQEImC73dlRSPjyq7KYqQSFCV4ZpapxuLq+ZkBhzv8FcEjnTTIKqktw8BmLAqO+6JKNJJIyNJY88jYVtu6BqSGi70iZF3muwo/wdEdHPpWJOoxPsBnyqc7Wdm1olDqjE/DzxPxH9KReWAEO8ETw7pnUvvCy788wuLUucU1zaqHpFhQHK9kNIsghdYDrz3Nwpc+4vy2/hwOCJ60aluFbxLNI/mbAL6CyJetQGQvqJPv8X2LbAUz7aK6xnofw9OgOsFYxXuyZ7o4+xkliVjEd4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4ShE8f9w2FY1059I/LJxpsa1YaM+FridAyIQ3QqcLA=;
 b=p2NJCyCc7QELwoSIqUFq+DOFTRvXzVSs59x6et18VIDxhbSJ4J5YcHXAPUie2FdIBsVyjKhiZvSgn3WLYbQSpt5iHIncZWi0AyzkqE9d0hVrlGjjEpN9oXEWnOMAVosrnavbE1CpcEmoWhDeoxKZHJB3+GNAdomwuiWjWpBvv9pW+cFzx4cm1FS8mwPXyA8/EtqQY97WqWg7nWdsjusvTkgdVJFJbZkATOixwOanpbpsY5Y/QzcpCTaEplcAyg9c47yxAEqq+hj7MQ94Ni7EMpSwaR0oBd9ex2VrvwXW755n6Klhw7iBTA5mdkGSU+g+/6Rc1apeuWgXsQkC51GCKQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB9073.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Wed, 18 Nov
 2026 14:47:44 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Wed, 18 Nov 2026
 14:47:43 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Subject: [PATCH v2] ci: move downloads cache to S3
Date: Wed, 18 Nov 2026 15:47:37 +0100
Message-ID: <20261118144737.635199-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 39de3e0f-54bf-4a45-75ed-08df4582e72c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|260925021311599003|260925021911599003|260925022911599003|261022105027099003|261022115727099003|261021121427099003|261021123027099003|261026121527099003|261022075727099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|55112099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DLpxMyzxdwthbv95BtHMiKEhPxrEe+KV4M2pqcZsYHAG5vun/i6Vuzijike7ZVOC2ERdZFW3AW6EDnMSQ5m43XzCPfKREyDtDD6Se4LeKqJcOC2wPciMq5wsdze3TThMBnmU1XJDx5oTyHWJYdBq75ZyUDgvshNuNK1Y37aorFKxSIYPTCPvoH7JPZx7s4H4W0V0BkO7pAL6TUOsaKTZm5pYxC1k7WVMIFpEIylAB2t4Lysxaogs5RX0jUpvrz7ZeL0aMfmQYNc86ftG+uxFEb4NYLrox1ig7hkR6miOsa4MlryTJwK773ca8O3HXU44KHxm0vNBwMj+AosxnKyVOefzcKoAduyFZSnYAcKaLnNL7kpIePlOIRizCwl2tb5R82HsmSfdDHHnhY5ijEJjRilNHXHut9DDZAUFbBQG4e0KXhiaF3LO+C1akHZU1FiWm/1RiwNrD30yx+oyvVj4FaH5a8VwdBcqynBAlmLf5TTZJfD9jbKDlZis6RhLQ+1KfNAKMqMp1iiFkZHtvkc9dvDuE3SvxZ7c8ouDLTD+EAvB5wMQJ6GxMxRsPFT0NVzdIKCiVAnA+uIqJCa8A2IAo1extqYnijwa/y7aUjVfUqRreY1XiGSsfg5jEI3cJHk7EDTBah3CwKXEfvieuxWsxBSAO8bH3Ve5rp37NBLJ/5Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(261022105027099003)(261022115727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(55112099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?liVwKaFI2VdMXztCcm9gXFSwhRBYw2VogTrB68oMZ/2VfHc6FYfsegZo2fIE?=
 =?us-ascii?Q?GwYHqkFnmYP4CdxkxfD2aanJxx7DItJglJoAOxSX8OEJswOx2rWdyR740LRG?=
 =?us-ascii?Q?Ieb5QgYJXjs0kLzo84540Do4i7/zGA7qCNPJytq6/SapvBgRDbcaJ/uRhfXk?=
 =?us-ascii?Q?qpSHpsYKJKmJUh8kXW/PNpICHklTmsGyp1erqnLJ0YcaJNPICss4kzIeHEOl?=
 =?us-ascii?Q?iIJlZXuSTFgaIJDUhQLiyvZHxvcXQjru2tLQ/06+Hq/OZm3Rk43iHyeoTMvq?=
 =?us-ascii?Q?qZPG6L+t07TK47Zyi80/uKYkIotoE+41DFb1qsGYdV4+iyNbirJDcps/8OkN?=
 =?us-ascii?Q?bbxDMpANmja4lqvKJTegRWVFiLV+4QyFgKm3K4zB7Zc3W2vIVOdRBzGVRBG/?=
 =?us-ascii?Q?OiMEdLnYawX4jnIDltZ/z5uNDDzEoyHwRtmnGvyO+mDtwlEzVoWWQ5gilNq2?=
 =?us-ascii?Q?8FBa+EwvXduGpLKLuWoZgdU/LW9rf7fBZISDz1VNTJFDK1XH5HCiSGv8OoIv?=
 =?us-ascii?Q?eLSfUzQSBQwMFFqQKTl9wcbQXPyVNwBTzVgT6ja5sN2/PzpJSoyLERYYCp9k?=
 =?us-ascii?Q?BiGONNP8fCIxAhGmHbfTchJ/HFe+FJbG16ey+fXBnRos9gNPDs5X/UE075qH?=
 =?us-ascii?Q?Q6koYaAV0wIwvsoENTKMjEIxOdXjDUhJ/si32jb2gKyVHDzgqEIzAU2Dgdeg?=
 =?us-ascii?Q?LTgLRHNMUf0SkeeNg+lbxjyPHNDKIX+M7xVqraU81Y9aM0+a0e3x3fUZKu1G?=
 =?us-ascii?Q?hEaQeX66Vq7HRtrw4tkx8rvIeHgfZUjShu0rXL/vRQPaNarDIubX8tTHRxPr?=
 =?us-ascii?Q?UCG/TaykFUCre/DMClUeTIkF7bmDE0WnibXHpaCK1DBF6kMAdHLoaewfD3Ou?=
 =?us-ascii?Q?c8MVjuGzl06dri78Txx4rWC9DTXi4MkTdl/1lgW5CgeZQd6l1n5tSo6fq+Lf?=
 =?us-ascii?Q?kd1OyGmLk2xyukatZwghrZgpfPu0j19theq6lJ+0o/YzcSI3rSTMbjVKuoVA?=
 =?us-ascii?Q?BMTVFACdb2Rremvoe958jdoiE4D4lIoH4nX4T+I+xCzlG5VOnK4i+W/t+EgP?=
 =?us-ascii?Q?GeLtoTOCwuhSAIpvdmcZ/3uRtny0AEr6LHro8SWWUuu/s/Kym8Ew+Yvm2lsQ?=
 =?us-ascii?Q?RTWUmn62Swv/vyJ7/SEOb8BRPxnybq9ww1aYb3yXZ+wFhP4hTP8VlM54kjeN?=
 =?us-ascii?Q?ZLLurICEA4xWgxcYVqxY2ReOlKbqmupIuWZTPmikRCZ5HSC1zXLNS9dQwYeq?=
 =?us-ascii?Q?CI4VEX8QvxUsvPhzGtITvSDthCW7JcsXTxjn24QKajOwmI1HigbxEN9Fxfki?=
 =?us-ascii?Q?aZMaoIH2mK971koT1zljns88A/3WLxhaIOrxfJ4lrViBMkKJpTSFpkOcIpTu?=
 =?us-ascii?Q?hlRMLj3IVnSl7TSPpsNo5emnCYZ2e6sTLKtJ6tSBQGqCn9hWP1eKhUqOgvdM?=
 =?us-ascii?Q?4QLKRoOLfd17+ELQbFUA2pYGDKJlbogjQsAOE/DWXMVxAJVE3Scb5NShl095?=
 =?us-ascii?Q?GZJb4pBquYYHZ2AsA/hN6I93gztXyG8GApgatrdN8BM7E3McAigDiG0XAt7j?=
 =?us-ascii?Q?nnj+t35sTsLaahIk0XjXpq44wa2K2p1k73mUSP3EOysvOCKgkD10spN6IncN?=
 =?us-ascii?Q?PwrzXkCuBys/h52Y3BgDkseVljLlIDcQtNBvZJs7tKjUZ7REv2WUi87oRK7f?=
 =?us-ascii?Q?quPjtKW/f6Ym0SSnzqPwaZNhY+JepdFTG2KSdrfVwDUNwC3PSukjDNrGYG10?=
 =?us-ascii?Q?xZbKFg4mKiodAZsS6nZ8q09afOcagtM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39de3e0f-54bf-4a45-75ed-08df4582e72c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 14:47:43.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xr74tcgszg+2frjB7raxJAApH/toTkyIURASdoKNGhPxlRecTx3xw4zvefKMUoe6jwi/aHU8JgTHCfu7MQxwHYSkIooacxsejLVOvph+gUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9073

The runner's native S3 cache fails for uploads larger than 5G as
multipart upload is not support by default. As sts access requires
a change for each fork/runner we stay for now with self implemented upload
script.

Replace the GitLab cache: for build/downloads with a single tar.zst
per arch/kernel stored in S3, restored before and saved after the
build.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

Changes v2:
 - clean update remove unnecessary code
 - add comment to multipart upload in commit message

Tested with https://gitlab.com/Xenomai/xenomai-images/-/jobs/18136100219
and https://gitlab.com/Xenomai/xenomai-images/-/jobs/18136323078


 .gitignore                |  1 +
 ci/lib/gitlab-ci-base.yml | 14 +++++---
 scripts/s3-cache.sh       | 75 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 4 deletions(-)
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
index 0000000..ff66142
--- /dev/null
+++ b/scripts/s3-cache.sh
@@ -0,0 +1,75 @@
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
+
+warn() { echo "s3-cache: $*" >&2; }
+
+AWS_CACHE_BUCKET="${AWS_CACHE_BUCKET:-siemens-xenomai-gitlab-cache}"
+AWS_REGION="${AWS_REGION:-eu-central-1}"
+
+for t in aws zstd tar; do
+    command -v "${t}" >/dev/null || { warn "${t} not found - cache disabled"; exit 0; }
+done
+
+key="xenomai-cache/project/${CI_PROJECT_ID}/downloads-${CACHE_ARCH}-${CACHE_KERNEL}.tar.zst"
+object="s3://${AWS_CACHE_BUCKET}/${key}"
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
+    [ -d "${downloads_dir}" ] || { warn "no ${downloads_dir} - not saving"; exit 0; }
+    new=$(fingerprint)
+    if [ -f "${state_dir}/fingerprint" ] && [ "${new}" = "$(cat "${state_dir}/fingerprint")" ]; then
+        warn "downloads unchanged - not saving"
+        exit 0
+    fi
+    echo "s3-cache: saving ${object}"
+    tar -c -C "$(dirname "${downloads_dir}")" --exclude='*.lock' "$(basename "${downloads_dir}")" |
+        zstd -T0 -3 |
+        aws s3 cp - "${object}" --only-show-errors ||
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

