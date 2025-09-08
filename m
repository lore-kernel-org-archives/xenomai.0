Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7E77FBAC
	for <xenomai@lists.linux.dev>; Mon,  8 Sep 2025 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757354971; cv=fail; b=arqWBUyLnZIYD//c3JmjF6M6LrjQU7I/pc1v/3KAq5AMGq1/l6t6c/f/iGvjEtGQTCa8gSlv2Rne8TKdYAx65tQLAeAogogAI9JGf7+VkEbCuF4/gLMWHFV2EWdr+UvN1oneQWyVV8OL7/F+A2I/NVY8KvmRF5liquqnHN1NvNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757354971; c=relaxed/simple;
	bh=IFiWLlL0SdzR6I1rDF0TvQ0Jh5VvBPxBAfa9AkcYbUo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sC1xsw1Mv6FANzKWJ+BFBzAXY/RxCQszMqwF9FXH6US6kDkTaJ7wsr94qvVoVtPi4LhRX/z1mlnEgFVHbO/+2NmlFgOX5Tpz1AzdWpbK0EgldA84cA+UEDiaHV+X4wH7Xuuw72pwzZxBRwavqAfHccaZRSb7tQmdymZt6QYMLvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xTvgBB0W; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xTvgBB0W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWRX+EtgRlmRWVFYYVM4QIX7fgRMM6al4RTDRpss52U9Xvvfm3RUePyNBrgexFwkUrIliHqUNCK9WJOaxb9ftXMJQBmYBG3cdpe/ErK878nMQhem2jq4sfoadYExxews5V9fxV/dzzOSOmmZzLRbUNCaiGdXl6uWIZOyfgs2zFjVd5lQ6bHZLLB10ahYc5jOc9p0mirEAdNwbkWarpiv6flA/YENj7AoXAoJhGizWvOiY/UAYJuB1P3xd3VUbOFFP7Aia9H1TTt6JPvlINcr+dYuuKsUv/uqH/Z/7AYsyJL3GhsKjp3JWFrK2IkvG9VE5ggqsVIVuc9CvWRA2TEBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OISraMokV6Z6uGSh2VeMcFq1Meo+I9TodR8y57VRWVI=;
 b=v2KOxE/4lqaDzU7ByGUETmbmMzOgma2gxyiOWSDyWyxcU2vrCtWvCOP5/hSJZ6j3gNLAFxQisVZFwb0B0qJsa/mu0BlUC3E6NcHy1tKVxPMl/wae7yadlflffh4s1hWxxrzR2m6dwCGYQZtEalaO6sN0aROg79DBPv4L7T4U+MLoYt7+5b7b8nMzTGEM1mN8D0IjkW2g+ZK+dr8QRaB5VkUYlL9FdKpaEENCiri7J/9pmp8CMXFWPHgsrWMvx7phld4TOCMDsKeKUBBRMjD7HJNxX4HS0GMDISejshZT8AeDEkm5d84T+TCuXXmnTL9zAFL7JOGq3qwpdPFUdHGjpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OISraMokV6Z6uGSh2VeMcFq1Meo+I9TodR8y57VRWVI=;
 b=xTvgBB0W0piChVr2+Q+Uoh68DXdczoVV4TDfBhV3StzfCISW/zIq+fSCWky+iaiokBA458wROsckVYDkdkqZvFwp/ND/EScmhm1X6u6W/+QSdcY1zHFGzDroF7t/hcJwS5/CUpl7/QTr4QNC9flverfevTPFFu7iHzTo6ijU+0yb1uqa7WZrJmj5HKQplRl4FBfH/M/MJEoyL1PepWwPO5joTGgfW+ElNv67CPPaTnkqJEtg3tp0+qb8GWOBJIwF0X22/G9EIO8vNgSdJ9hPknnNvpukEk9icP5Y5UyMOYKYvWlmJiK66VLNYW8VJdEBExy24LCEmd2UJwwnFxNLIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DB4PR10MB7543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 18:09:26 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 18:09:25 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH] ci: Remove sstate-analyze step from CI pipeline
Date: Mon,  8 Sep 2025 20:09:21 +0200
Message-ID: <20250908180921.518004-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::12) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DB4PR10MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bc2ece-436f-4c09-044c-08ddef02d852
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1afAVkMviTvcV2ZcKeS0mdITnabwdTWQ0ErpMx9sXkvTYXp3Mn3V6SejOe/e?=
 =?us-ascii?Q?Gy7vGeAH9tORNAqm2rXANZ8mbW3Ja806MM1Qq/auQSKkMzVlukRZzanFG8L7?=
 =?us-ascii?Q?PAdR6rBHkPp8eidHhVbz51b8tkCfzADs7PLDD0GK6hJeAu/yXeH/i8S61k6a?=
 =?us-ascii?Q?9WcNIXHsQnx4CA/5PErXPBAy8k1jNYdFGquWgaoai7meCTNzI60+RsILQ/8J?=
 =?us-ascii?Q?78nonzWkFtDSTsautR+tY2mNjAx48iZ3T3M56pxxDUTXC7WeoVgKF5Jcbdw9?=
 =?us-ascii?Q?LsKnt54fBQAkChBXnCDQx6BfoW03FOFjMBZYoW+34nkxe4/JotOtKgNu7ecE?=
 =?us-ascii?Q?HLB/xSJooDexY/WnnUhD7+vPQxR3wllJUDEiTPXSMyM+tdgsjjrIPL4DzEfw?=
 =?us-ascii?Q?xF66S427/wkEyhUQyiZOYJ37XL7PlCv/qxA2RhCexjTLA6KO7My3FSajfn1q?=
 =?us-ascii?Q?exFHRtyRWKsAwbnZ0Lb89d5bTZNdQQfK1bHZHnS5qj9o5skHcGz/3xBWiEGV?=
 =?us-ascii?Q?vKSX58YDhG58LtIkO9+36xASX8jCJPhWDtFX7dfujnGfXeOmQISMKkJpgIt6?=
 =?us-ascii?Q?hE272MEqSiie5hq0Pcm+Ks6DeBkHgHz8iXvCwi9HOD/WLPfFz2vENHHr7FwX?=
 =?us-ascii?Q?+zE9Hko823S4M1Oz6jTi1fbGKLTue3RJDuz4QM6CLz2oFsfdoA5miRQvGmlC?=
 =?us-ascii?Q?M9Nwn+DHqzK2imRX80viugrIapytMHqpOEEsb99LYz2Vay+Dl4/ENMcsetn4?=
 =?us-ascii?Q?LLFdpjdxLeSSE6Jxo0X+045iIBFOnk87EWtXUm8H/jLFSXmBIkuQeoSQ1UXl?=
 =?us-ascii?Q?BppclegR5fOtGFlpbl6YehtC0Kgl1KG7YrNkJ6eRgGNo/00tpbr90Qc+QMGS?=
 =?us-ascii?Q?uKIWizRrn9m6d4ilC1Q0bzGtRMurHw3NWk9Ln5dJFCg49UpNimA2K8TGepRQ?=
 =?us-ascii?Q?Uwfqsr+7bpoEcI2/AItefFxVUW+GKs9sL3bPHmav4q45FpJqK44S37yerblP?=
 =?us-ascii?Q?AlQFCw7tqvWVXRbiCpTeHyjH3VkGa5GRs7SWVFNAXQnknfoe1XfDltHtoGuA?=
 =?us-ascii?Q?fSGlG5MemUNGLNQaZw/i+BphoPPtz2t1M4kQtL2YBnn2l9Ll1zW4kjjSaaKI?=
 =?us-ascii?Q?sSYnEaOSXrD6pgNwWEd5TM/1Xa+0JbqR0UGH+vadDj6zFFCd3SVeRG6atJ/7?=
 =?us-ascii?Q?0XaymY4xk8S9jIR0qaw6fNHFkSNaSCYK7UDxSdrbwe2EYP074qFJtA3sC3KG?=
 =?us-ascii?Q?2EW33Q1/ZYdCOaio+bspwm3ZZgjnFCfymuVuWh/zbBd/dfhZshkn4SZQ4J20?=
 =?us-ascii?Q?PgxANObdSdHrkW7fFTN93xPM4q2uuOMOKOwOFbn4EBerh20eMZBOp4ltO8VF?=
 =?us-ascii?Q?UdxPCLIqeF5WmQe50aS2Vfwo3cjMlFAJYcxw7CCES3BqRJllbZdoYDMQI7D3?=
 =?us-ascii?Q?oNghGyzUXxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YgcKSzqjbnCbiexYBoFlqBkM3B0ghg9K/oNf8nXZuWXVM3+r43VSn3wOgMRo?=
 =?us-ascii?Q?CkbVX8jTSD3U4wFH5fzBy+8aELKMEi0lsZPPuHHQcpxVD0sw9WB0twiXD3Ct?=
 =?us-ascii?Q?NKbtGdZ3vrpcgacppgJXU4B6bL9oVI9bCoqEKsfrn7cfY0h/5m4m+KvFIBBQ?=
 =?us-ascii?Q?Fx8w9/ewr59Ouq9+ljbIOH9vwfJkScH+fD4UV5Yva26ilW8QYo3n4u5xCfUw?=
 =?us-ascii?Q?HiQrsaMZw6mpboW2GPlvOMrOQAZpP6e6yxAwWUdGWSVgD/M4A9Z1jU87Cgjr?=
 =?us-ascii?Q?6Jy1C8WDqTqOkDv41JMnFjVQsb1y9BU5mM2iJ2W/jk+e6FZkrxLSI1KSyrPP?=
 =?us-ascii?Q?ALEdXXNL8El0+xCnMYBG0xec54crDrnFkNa61v2Go9kcPeBJ5lM7YNT/7lKg?=
 =?us-ascii?Q?9Ca3n8QPyoQL/b8nQNtDvVjKtTV5CIclL56vKVz6kLGn5BpBON1XxAwc+LIr?=
 =?us-ascii?Q?E3QS0VvtVVMcR7U89gU+8UL9CW91bU2C3XzXT2/5/FgTRmMDS0J3kZGxwxGc?=
 =?us-ascii?Q?hBX0+6eNAgRfmUKBYtdvZ43IXMqVwDpZkwi16jCG9sD1UNylrWoP6frSMiDW?=
 =?us-ascii?Q?DovJBoXYOj0iqzbx2wKYpIUItI3Mh9c5RdtxGrL8y3LNp0qwone3nh7ttKVx?=
 =?us-ascii?Q?QvI5y5ow53mQUrj6k6i1cm81axYIWSkGFhMgLRPDGfHv9ad+YLWADGQm4s8u?=
 =?us-ascii?Q?D77E1rpaZ1nrTpdjoJd+edBjUER1iRUVHY1vvfz1y2Zyo7qj7ucx17NHNWYo?=
 =?us-ascii?Q?q3xI+Pd0sOvcWbjMNoLCHunsoFmqZYJvyVGwfz3AlpckOsn7GSuQcRbeEu5j?=
 =?us-ascii?Q?3tkJQvjei9flkHevxcY9efZIY26vDXCUOsFfBFp9YZcVlgaIXjbf0KZ0UQcw?=
 =?us-ascii?Q?F11ZWE1V7ILvbyn4dtVNwXpmpCchRnd4PqJGUbCVTUdbieZzUDfi72D/or5s?=
 =?us-ascii?Q?YMR+aL/o3rLmPca/aP4orCW4Kxsr8FUWpn1U2eTYXiyJ7aX0R0LgqEgh3t7W?=
 =?us-ascii?Q?0Tc9kkkcBcY/E0RQY7k/8eTM6pxV65N4kQcg6Ryv3yTnu9CITKtg0JGV7bJy?=
 =?us-ascii?Q?hgoyCQXCs/VMRYZa2CTSSzVXYHt7c1/7/5ve1LMamS5TcnNu19MeKbtp60l8?=
 =?us-ascii?Q?+d9scznhstIHAPUXHwIcWMVkQhp4fDRZC5wqx7j3Z992WAWfY2cAeC70hZ1s?=
 =?us-ascii?Q?1B3BkpAGHbapXnAj1UN6PpP9n/XSnnZeflhiplCfCWDF+8si8nhIRqp2zwiq?=
 =?us-ascii?Q?iUt7xV2YpxNJnniEXNKCLAGVUbf3GGgXtMuqPbK6g6+/hxRup4CmBVGlfRPl?=
 =?us-ascii?Q?Gcgk8HyLuaEwiLXgxPdaWAZHf24Xqv5H7Zp/JQSM/DI1taTPEIPHZTqwuOsy?=
 =?us-ascii?Q?1gec8u9zazz2vnifpgJdFIIEENJMxRdVDbVDSoolKEeYmejRHSztRIJGrJby?=
 =?us-ascii?Q?zLhDY8tvnIeoFlRv7cninXUMWKXwCMXrP4h5Ef0yO5IF7kt0R/hL+kFYHpOh?=
 =?us-ascii?Q?QwAtQEd0dbiS1aQ3TuQEOIE6vKgxDDDM1rolzOsqaFGxLNqB9EsxhRWQxroU?=
 =?us-ascii?Q?XFd9m5xwRaTVrYcKfBlSdvWtt+7eXbVZWDB6ti2b+IrXvTfRfMZ1bjPkjdVY?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bc2ece-436f-4c09-044c-08ddef02d852
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 18:09:25.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkxeCLyvSsKCs8AAa0nLwW3tMU7k0Ky9apv0UD1RI0Pg+YA/Br4KyrUAT7veTfkKMI2RS/qfgXeaoz7bTWiTs3bkLuYZJ5zwwM1RFtiJZpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7543

Do not run the cache debug scripts for now, as the cache has been
stable for a while and their output can occasionally make the job
logs confusing.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 875d951..e3e310f 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -39,17 +39,6 @@ default:
     - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
     - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
 
-.sstate-analyze:
-  script:
-    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
-    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
-    - echo "=== Check for cacheability issues in build/sstate-cache ==="
-    - ./isar/scripts/isar-sstate lint "build/sstate-cache"
-          --sources-dir "${CI_PROJECT_DIR}"
-          --build-dir   "${CI_PROJECT_DIR}/build"
-          --pedantic
-          --exit-code 0
-
 .sstate-upload:
   script:
     - echo "=== Upload sstate artifacts to ${SSTATE_LOCATION} ==="
@@ -80,7 +69,6 @@ default:
     - du -ah -d1 build/downloads
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
   after_script:
-    - !reference [.sstate-analyze, script]
     - !reference [.sstate-upload, script]
   cache:
     - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
-- 
2.43.0

