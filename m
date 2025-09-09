Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D539303CB6
	for <xenomai@lists.linux.dev>; Tue,  9 Sep 2025 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400304; cv=fail; b=K7fqXZfbbbFueDd9Zrrc7gee5njl8YGBRHtngcFKUhsBKi3lAQ+OH3hF5t9yRGul8fGDVpbuqyTjn81tUF+gZkExEr3bnZ3e39/LD+MDNf8yqIsjR6+zgQno0janS2175WIRLrKkKec3k6K7p8u9WkdydAgu/6GsVudXrqqnzKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400304; c=relaxed/simple;
	bh=Q2Ci3NOFn8IN1T2eawFKT0dpnA7uhMWx55HuUJFfSGw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DFTAP08YhfzWlc3cw2YUu0zAHLOdx+h7ocmvqWHf7VH8yuGDmQIzo1kazFH4O5gob3MnQm85zvx0PVpMNWuzpqYYtF6X0QUxyyGLPHMOK0vBq3aed+jVYFgAm7iORbpdIGpLFkyyZXN8eGiSIBko3TLObpO6rCWnq4/Lbjd2SbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=POLfA6Qt; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="POLfA6Qt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE6qHH/4cWRJTTse35l0y90YnJmM3Sa61QBIiHniuN+wnGtSlXN8ndU6R240rJD+aq2VdTm8ighV9XfC+AV821lzDmttiCz1A28vPyPhi8lZwPg5x5e414lnSuHViCZcuEYPvikPvqKuUZd4thJgbfY60t3qTgJbsDiCaB0jqjm6hyJipJQKuuDRmUHLr//HWpC9xVU/KSz3jzEjRi5B1swtLs3fmbXjhLHUYbfSd98k9/QlDTpgMMUlCw90Lw2X85TaMQdHNi6BcU/tC/6OTnUmNiSTFeAO67fHixPEvd/ASdZGHplfDiEkV0ImMFGcxrXTCUq2dE215EbCYQ1Sbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfOYyDP+JPP2WEfoyZrx5FusKPOMUfrGK5jfkC0pmaM=;
 b=UBnwiMFFyRcQL9i8NXM+wE/GvB6ruaWK4+XOlB0Pit9sjneTQNA4o8oafdXlzbLy39Mt5KgZH4/gmsIZCpZiH0ECjoWRC6TmYdIRvfyP4HejTaHzi+RBNfbH1u/dt3rDHsRYYSGNOSMrORe7Ss35Br9tbeuQ7/Lla+QsNB1KLwxXlhi8ZTjxZiLmwEfUS8fx4eU08SqCTmGQzJmyrkc9IzsUi6laAu6sLWo3dMHztop0PSCJ9Nl4bLpEve0OSAK44kU9fkA54kg8QdbQ0ua+3D2CvMzSY5momFyQ7QcQrCqUC4Cwa/l5LNjdKjSg9ZUjtHftpHpmcV6ASgM/0TC4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfOYyDP+JPP2WEfoyZrx5FusKPOMUfrGK5jfkC0pmaM=;
 b=POLfA6QtASnLreoPL/IOMraySKk2gxzldo6NzcueLAl5eNiqImE2BLfGOX4wewYzMnv7aMjG9Cna8WDGxc6NEyPoPlqgVcsMcgsQex0ho6bTVgtAbdiTkKQsk2WqRBzNKlgF+QPfFymSGKavQPNSDWT7LCol9GsHR29vqNx3byUyn2zYaDSxqnKSGAHSlAqX9lrQu9YF072YKWuEsB0qxZw2pSVEtCcbNo/kOh0vyAIB0WZsjZ3EXwkYKY9EunJkHsIu0FfFJV2p6zSzyJiNdLUqaMO4Zab2l02aZmssqh9oB8uPcwp5XbD8M6nafpcjHI0sN51uUzs8B9GeGRD6nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AM7PR10MB3573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:139::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 06:44:59 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 06:44:57 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH v2] ci: Remove sstate-analyze step from CI pipeline
Date: Tue,  9 Sep 2025 08:44:54 +0200
Message-ID: <20250909064454.657166-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AM7PR10MB3573:EE_
X-MS-Office365-Filtering-Correlation-Id: b2cd1019-13ba-4905-6446-08ddef6c641e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8GvOU2JNeKTqmX3KSgTUHASeweRXB1+YAOcHvneXRyeWTKTLprsYSqGyv89j?=
 =?us-ascii?Q?Cn4oopcOP09F/TygpKUxGE9oaLgm+EPW6CbEvXbI/qDtqJW/4870niy564s7?=
 =?us-ascii?Q?vbCLGouWj8XBLSAs8TlacYBYpXCzMhGdV6+qZwmddsYZXR6XWohkc++5DkHx?=
 =?us-ascii?Q?s/va+McWW8GyoGXzYebP7quahVvC7/Rm25BZYfRVZE0/CNI7fdRDmoGRBSpq?=
 =?us-ascii?Q?CkUujv/rhHYMmR3tM3tTgL+2PPLxYpNz/Cj0LtW59u6ci3gX92BXAlHVTZoc?=
 =?us-ascii?Q?+cT7kMAORgoP/d7WmsrB6F0ATPjXfRjCH5V0PqbvgZLsH7egBApyGCnSfLcO?=
 =?us-ascii?Q?ctbo0/LPD7ZhofE+hTyWrnJqUY//HS+3lIsdmohbTJjxjXrCwSfwZln0wn85?=
 =?us-ascii?Q?NX9cQ4YaF6F8qn2oxn749AVWoNw/WPerUtpMxpomHF1A88wM2GmAfImhm9xh?=
 =?us-ascii?Q?lldDkmZyn5JTTxnnJrm3P53iMZAvhNuNGbSqu2l2B9KLECWj1BYkoKPAVfBL?=
 =?us-ascii?Q?lUSWgjaJvNLPgERTIcTUjIqNjmd7DAcMcWMlh1BPAwKzPG2omlcmmBIjkh9w?=
 =?us-ascii?Q?Lbncv6V82+RTV0tls5wpW+XFnjL2pW7q/qNkrnza40Mdgdm8yR4ajbUvKB16?=
 =?us-ascii?Q?zAjnklRj0GBhdbJsV2QlRDoN7G+WYcF9vLE5hQy4AWwUN6RYUfM++mgMKUYc?=
 =?us-ascii?Q?aX8/5gEhm9P25h9UaOmJacPsxy8B3j8G3moEDQRc28zfHCjxRpg6USKbkuX2?=
 =?us-ascii?Q?YP+czXkDNfylysFbNywKiw4tCuTFFvasJGJmQWJEhM5uBeXci7tZuXUmyrL/?=
 =?us-ascii?Q?ARPrjGHTci58WOZO7WflRr1GSepXhQDJFYr5VBiSoyAgXTFrXFzuHvZV8zuq?=
 =?us-ascii?Q?Sg7Y3CCwNq8v71yByj86Eaoy0Rl+xGlzDaGs1DXOngUmdPGeEJ/OVB8FVCDA?=
 =?us-ascii?Q?xzyJlUe85YnfuUuyaMxvOxZvgxE0dTV7avHS/IXSrV4wtg4Iuw7pBBq2dCl2?=
 =?us-ascii?Q?Qm9TT/Lefra+4u3vCHeo0GWdNrDyIQPleXSmk1PEFXu/EJlSVKsZxqOL3L9J?=
 =?us-ascii?Q?RJemdd5R6lDH7AuN6z3v16zM7BemrR5Y91qq1CGKKLjiPRSnT2zCI34dxbrp?=
 =?us-ascii?Q?pQmS+RS2sUt1oWbkL7qn6DHPBIYRxdFwfYTPgp6NPcFfURr6jsan7F04BXiq?=
 =?us-ascii?Q?gdHLG0pWlPWpOVzwLo3GKJgs5iqx55BIKd2jNu/5ZlYb6aYKU6KNs01MTc3r?=
 =?us-ascii?Q?23HcIhQ2Xc/VntZbdRDS+QZxVYVBerU3Gy5h/b3hR4T4NLobCOAStd2U/KYP?=
 =?us-ascii?Q?cJQFRberAEaJIk/jZCjB6jdKB4+JBC6n+dGpQJ1VBBy/ZvVnjsRF2Jn0rFo7?=
 =?us-ascii?Q?FWcdz7nNipgUWtpmZyL5oopPljJs/mUfO55cJTYZSoSIAJafPfWHOqVapCwU?=
 =?us-ascii?Q?GAxOXnXYins=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VqGT0qlhqrF9ixkCNEPX/5iR6tEoxf6fsWYl1qsMrKNEKXbh6Y5in59c3PS3?=
 =?us-ascii?Q?R24ZEI5wGnk3T5GMXI9T1A0UPaO7f0qYcplW/zLNdJflApqe5P5zz/HiY09b?=
 =?us-ascii?Q?VcxSqhBN3W7/y9TpGt/UOMJatrbXXNwDRedydBx+p5EV/u8uXgOYfb87Rrlp?=
 =?us-ascii?Q?faSEubb/ftuE15OCPlR7GTD9j4ePUFa3FkqeCGhgPNUBHIi7zqFy5K5Gck3X?=
 =?us-ascii?Q?LGDgw5Y3tsPEse/wkRg3RnbbqTmBbtS8lLI7Mf3RgoQcTQ+WCe/Zk1dCQoB/?=
 =?us-ascii?Q?/xuK1xyBxCi9OVvAP5cL68mN/z5mtKLyIVYjEQHadqg0SbO1PmkBhWPWTAsi?=
 =?us-ascii?Q?6ZsbNqAJHjaIDmpjXnPUera6DSCzfH8KcnVbLlB5B1clwJW9tVYk9rOo1txR?=
 =?us-ascii?Q?s5Fgo0lRXVkiF6qguup16yDSNZL6ztzGy56IhtBMeCmP7vM9QJQYxjn+M2+e?=
 =?us-ascii?Q?eMDfM73X8ghXYydqePOoYwAP6NReU/9Z045dqWBKICBTlUp0ITa4AtUxSIvp?=
 =?us-ascii?Q?KDnnldCDolUb83Dt9iDUSEE31ufbl9WO3hX5PyGYAhCAQfdbOgTe8bA/HWLh?=
 =?us-ascii?Q?2w62/4jIliCuoeRUxGgZHRPlVq84sQAH4fslV9OtI5HudUJkhWAok14Ig/gD?=
 =?us-ascii?Q?3W7k30gV8s8m6qB6GoQyr9CboTlpstKWJO11FeuOxh5oSu5r1cw6SF6pxbq7?=
 =?us-ascii?Q?llRSeLmqAMikYdtmwuV1AaBQklD5uUHjiaK88Pd4xHyzg8GErNNNoKQp5afY?=
 =?us-ascii?Q?qb8Yv0u2mC2MA/+uZ+cobohNa9u2GiIgFm11HQRvpcziCFpDMt80opW2jXK3?=
 =?us-ascii?Q?G+rdAZE2SwiYaW7dmD0QF+0tckSDksxDnpMY3okq8H3uksS6fx1T0kPQ+qY0?=
 =?us-ascii?Q?fFsn889IGtyG0mbmH1CEWDjhX1YoBYqUy45fxGfwEM9KH4M5ODzhO+kiC+KA?=
 =?us-ascii?Q?PlWhb9ogVQLt/HqKlqXnrFRuAzEeH2kqrDwxtCuPQVDFCWc8NeujoB7/K80u?=
 =?us-ascii?Q?8SaxUeqpN/4wB5y0jEA8dLGew2Dv700HlSdF5Au1ney+2WSag2eXI/yEFner?=
 =?us-ascii?Q?5o2VPBd7Tl77gnS4DkuGeMbuL/Ob8DohwuIWlOec0MBs7F7LqBLEUgCuraQD?=
 =?us-ascii?Q?DdGOalnKHdRC5Dl6AWiqRJVEj8mFV5XmmXbWpdGYnwWbImYs9W1lBejXb5p3?=
 =?us-ascii?Q?0hJXASF82ekbE059InyeUtuwE1mnUvQ5eB/H8/XxSOLM4wUGYgf6fVYJYm88?=
 =?us-ascii?Q?mUQWqbvH34EhBM9tMluR2Zs4L08EEkL7LrIQGDWv6zt+yxbCvB4gKIgjRuRr?=
 =?us-ascii?Q?lHkUAO03yvqlbbpZTh1IdWNLwOGwJcTlli23iZEf0gVcvQ6HNPqDjeShUyxe?=
 =?us-ascii?Q?Cf1tEIGz5mSxJdHwFgi23+/4K7xs1xb7ksRe1hqkRfFZ1ja6jjQbLas11P2E?=
 =?us-ascii?Q?JFj5z45uXBgrCzJ13238KlhpFAZpRnWEbFCP7L+2oEvk/GxekboOf2BhJUpu?=
 =?us-ascii?Q?iTictnvUsUogyeOB8IkDCVjsD0JV4nEG9WabZDAJw3qMmRhXKLDaevhmeV/P?=
 =?us-ascii?Q?3CH/BYU3H92Vrfs8Ruq4Hcb4vpUMn/vDTqILFc2YorY2Nwpbhq4ENJns3FZd?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cd1019-13ba-4905-6446-08ddef6c641e
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 06:44:57.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr1U5IAxGuflCgBoq3Yb8UL73+QNNGK+zFPalf1P9O7TL3hl6UFqziKFO2Fa+JlgJyrOmT1C1XkCuSGMo4v2WFSakjhipFZq4vW57+GW18E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3573

Do not run sstate-analyze for now, as the cache has been stable
for a while and its output can occasionally make the job logs
confusing.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 ci/gitlab-ci-base.yml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 875d951..bf1734f 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -39,10 +39,8 @@ default:
     - ./isar/scripts/isar-sstate clean "${SSTATE_LOCATION}" --max-age "${SSTATE_MAX_AGE}"
     - ./isar/scripts/isar-sstate info -v "${SSTATE_LOCATION}"
 
-.sstate-analyze:
+.sstate-lint:
   script:
-    - echo "=== Analyze sstate differences with remote ${SSTATE_LOCATION} ==="
-    - ./isar/scripts/isar-sstate analyze "build/sstate-cache" "${SSTATE_LOCATION}"
     - echo "=== Check for cacheability issues in build/sstate-cache ==="
     - ./isar/scripts/isar-sstate lint "build/sstate-cache"
           --sources-dir "${CI_PROJECT_DIR}"
@@ -80,7 +78,7 @@ default:
     - du -ah -d1 build/downloads
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
   after_script:
-    - !reference [.sstate-analyze, script]
+    - !reference [.sstate-lint, script]
     - !reference [.sstate-upload, script]
   cache:
     - key: downloads-${CACHE_ARCH}-${CACHE_KERNEL}
-- 
2.43.0

