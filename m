Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56206212551
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980195; cv=fail; b=XVsd6bR8onc0GF4iDR9mRCz/mRO2aLqeRwkHk1BZskShhm3vxlH6whtCR6GqIJvxcoXnAh/e14IKRPSgpPGzXDYmvll+4q4fdkP9gQf75mMd/Ytu82P+x87yUzqRsdxg7XC0waoEkh//XpHFFaFwxuT9ER0TrTZ2RDqNtFdl5Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980195; c=relaxed/simple;
	bh=Tc0oOknWP+cjdhTGK1j+J7RLZR6tXaUpfVEq/iKQQi8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ot53EKV+Y9zqjfVGy8/RrVPygMupFuwID39VND7HV7jo6DNzWlKMvHxbMaqcy6zdk3lSX00Ci4UM7EM85VuOZh0aWdkf+B8xJ2F+UcMElRwu6GvpwaH3J0WtMbSNy2TL/Zi6FYgFByHPftXzMiVBx/uyRs29ZlVJU2vGzRcguN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Jyg5u7VQ; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Jyg5u7VQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8Kg/Ky1t06+ItKOGnxSjN4csigpzTuYn+q4gv51bvM+uTTq2tDjGczhDvEMOQGHtdp3fDTm2+YARibZ9QXvvDrcrqPEFwujxYa8xg1WkdwgtWGSImYLE5xrmS5HUOCAiPMqVV6yvh930OnBY/2vxM/hHB/6/ZoohiDZFXt0WLB7bPDXmohITKZ58oxE4b9DaZ83rxHb/9kX4oCvAtNVrUvjBpEub153DuIAgvXP/tA57GEbnRUz6znu29mzICTl7d/MoNgxbvWbIRX/CiCboQOZOMH6tXxkTjELAwpJ/HcNLKHs7Ms9uro7z1y7osR8ZdvsR0hwqaX6iMhSKA+ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWAo6XD7XqRDbVpzNv0gW3QPZ+jd15oUkeuG7eqDgHE=;
 b=KAGu4vsmpomqPX1TUdggk3NGWCPZPkHVnz1u/uO/hljXBJodgsHb3gjyLoTSD6iOChCtDo4jq5voIMiYxkKAduhxEaCNO2ELCP6ezdbxp4Hh7XN4FOYXXlWTKdQCKTfYKEdbxDh12YKKu7LKT/nXsbf3CeE+dXaZcPxyblycW22+Sf+mBk98N3xBqE97DdcSbhCOxQB0OHoBDKQh25Wb/bwrwCY6UEW6YA9P9qvdVyTdUp/LjX+PB2OLZC+Wxp6yXvgdXaXBbajNfh+TFGdg+/aN/nJ2OQSKqEc5YHqPnSPkmiWiDbqQrOSuqaXnQdlGfM2vPK5N7AeU59BJbF1BtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWAo6XD7XqRDbVpzNv0gW3QPZ+jd15oUkeuG7eqDgHE=;
 b=Jyg5u7VQZFNHL1i8qquU8dw4hYdWx2x4q358zx0+gcn7j6qo9nI4Xgb9Mkuof9jFktO6lsv22vw5WdtUPR3E4nAJtfMTOR1zMV3qOo5x3BOsyfRJnsPzphSRntqvyYM4cJA2H7kypCx4QBlF4sHw54TdVvZhCa61UCAKEEmDxl5Mk6vNALKkXQ5/kR+FtCd/o9NHSw815iQ0JESX5bOo0pP8n/+xWcdYPIAF0HEwnJ7RNz7XrGZBF3oFlMaQRJrtS0jdUTPKfR3rzFYtLHV9VPuOYZhtv2TxgEKpAyQ2ISr331X8XWmptp3TRiSkxoCIliQxQKgzo+kKfOom5nH1WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DUZPR10MB8072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4b0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 10:03:10 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%5]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 10:03:10 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [xenomai-images][PATCH v2] ci: Retry LAVA boot action up to three times
Date: Thu,  4 Sep 2025 12:03:07 +0200
Message-ID: <20250904100307.1096684-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0354.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::11) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DUZPR10MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: afc19be9-cbbf-4132-4e03-08ddeb9a4074
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rMBuoUPEOpdAealuXfM/ixY20xPtllftmo8XgQ1euHVi2Vy+QGfEhnzROHkd?=
 =?us-ascii?Q?xd9iYpFF1RAjdgmWsdMuHnzqQcS6mB4qS+OsSVD/9Mz6I2w/DM7zFlDUMABb?=
 =?us-ascii?Q?w/1J6D1AGrEep/ZMjhzOXb4ANB1L8RMAw2BzU1+e/z47+7J6WgcoMWMwqIdS?=
 =?us-ascii?Q?TjbLA55oPEtQdauZVaf/xtB/DD2ydHSdo9tEMDvTz8PuCHOVzXz17sMFVZkZ?=
 =?us-ascii?Q?uy2N5y992nt2pa8UPd1k+ivT5yA6ZOxB9TX5sQgFaP2C89QNihP1PRe5KIhn?=
 =?us-ascii?Q?jAbcUY+Nyst1kLe7o5BzPg6j2Ty0h/8z669XdDVxCka77bNLzdVBX9DhJJTp?=
 =?us-ascii?Q?p1/5LFJP7hKBAWEWbfiTdytMnsqBGnOYdX27Qd7dkC7AVUhLNd6cZDxHMnOq?=
 =?us-ascii?Q?YfUbgtqNarveIB9OWB7q18gcIb1edFLuXGiBVAlryK3bLMXxACoDhz+wyxYI?=
 =?us-ascii?Q?CGfo/Jle2dcDEm4OgrlJGrKmOIR8i34ZciAMgjiBBuRm4wYHJB7yY0wcQJ58?=
 =?us-ascii?Q?1Te7j1ckZpxBPz9ThO5xz65qCacTz4dgyA1Hnf5y4B6LViBwlDsziHvDeTAA?=
 =?us-ascii?Q?+cD/HlRhGm6Iw+uOCXmBWeBvjO9HQ6gc3dYVy/9Vk+S75VtfZ4ytssfY8S0T?=
 =?us-ascii?Q?3fnGjtpu6+Ny3JpLw8zwTHTZpxIxh/SYOesV4iKYaiFzY7SqdHZwrhOIU3p/?=
 =?us-ascii?Q?t5e1/gC029ZbQ0cnubVDvtv9hUhes8XXXl4H8mZ2osKIl2ye4iz09vKeZhCO?=
 =?us-ascii?Q?rePPHoUNpYCUKDXJLHEOkQE+quCnPkmva3TtWoc8S6AcOexty9My1bES0TQM?=
 =?us-ascii?Q?66M7e5ydOJU84OjXKUYGLJGNono4LNtXoPvjiYxXQuBXecL+o3XC+U7vL+gS?=
 =?us-ascii?Q?dz3lRqqvWooC4aQBw7ZWqsIJvee3oxXajD3ru1lMxWodAjvYe2Ojclw1q3uE?=
 =?us-ascii?Q?sHeo8wKm97zdbBw7lrygWDqcsS7WywNqt9gBbFrNe26ukxbrcgEWik8HlpTg?=
 =?us-ascii?Q?7gm4GrcsaBzZfADuuCHrJt7sNNHZK4RQsWeTo2kuaPPxgWrM59JZhIb1jFu+?=
 =?us-ascii?Q?E/iQycS5Fk+0LlW6/x3eI9DyM9DKDo8qtT0J0XJvotZK3atM7EuJldFQqq++?=
 =?us-ascii?Q?54q/7uoAISiO9lQrasrCosTh21igo5dD5mdDjMm5KpqzIfa+zuxnASyrVV1P?=
 =?us-ascii?Q?hR0q76WZo3r6c5T543CMqeLDIpJ1rVhbCR5bpTF6pkWZTToVe2ar+M56Y3dM?=
 =?us-ascii?Q?6tRet5HhfdW/zIEl7DNQjyeCz3yoG8jHsKWpHchcn4G5xg+j6Do5gV0HR8ag?=
 =?us-ascii?Q?HUbzP1lW/Ufhe3eW1NjUpEEFShLAG4ad0V70+lsjEFjruWMedCf+2L09U8uc?=
 =?us-ascii?Q?YHW2iwfgPiAqckYf55jee7I9Kmg0PGwqbGotT1ozigBhvYbWfyR8LMcMTAGm?=
 =?us-ascii?Q?o32RJdJLY9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GxL3leVNusQR/Gc58QRUuDNb5nU+pgZokFceBVj95HUKenxQwvFc4CKipHMF?=
 =?us-ascii?Q?woQ2a3GjtIKSqk/3cC80CELgekF7FlDYmBZ5XWznJ0CQQwLIqqIykHinCyFm?=
 =?us-ascii?Q?ePVcCkgFuSfyR6yXinetCOF3XZ+0DyeUd8jOOqNwr5yQvsJM3ep1iQtQWhMA?=
 =?us-ascii?Q?YXivA3s/fgohsogubvvHCWe0mrEYPv07+a4NhckxSmBZRuiQBrqKCuUk+CCk?=
 =?us-ascii?Q?xkfU6TunqJeALAjvRZ3U82E8GvJxJGswZfPKhJ+GXGZjbqVoGXVc43KgT1A8?=
 =?us-ascii?Q?LZ2omGuBAB4Rawuw3ms1xqM9lYgvNQ0xrv4hucfluYAXWJueSyNXQgjaCiNE?=
 =?us-ascii?Q?c5cHHdS4OJ0RNKY3ZxGR6Wjlve2tUaLxWh1qxdmG/BZ6y1H9P53d1bVpc889?=
 =?us-ascii?Q?OaEeM2K6EAxq+NSqCvkEGyERsAx7QLxRIjVoN1Uq9GoKnsAp+xb7EqAJQ2Dg?=
 =?us-ascii?Q?EkwPT2RcEaPxkwY5t8KsEIZG1Ne2Ok/HYukG4Ug3mNI5dusI1ZycMxUPMyj1?=
 =?us-ascii?Q?yDi4kKYmCn/FQA/y5WX6DcZM+kjJ1sUN9KNF4m4+QLT7rX8WRK3M144BqS6S?=
 =?us-ascii?Q?Eb9O7oZijdUpCn4j/93l0vIlLnCEVdHSDmR4gR21jc9t+SWgq7eSHsIvZrYC?=
 =?us-ascii?Q?HYNRO5pWyLsVMnkDAMKQ5tydIK8iQakg0/fusifxeIMCc9IQLEOopwPU83rH?=
 =?us-ascii?Q?r74v+pE9E3Xd069J82Tg9TDtC8l2HLoK9DL2MMkjB9y65oOBS/SMZOtcZRk1?=
 =?us-ascii?Q?oRZAlPsxOBJqg6DFaIyEhlHlh5WCWy+2Do9W2de4SRKUgbbqYBh2UZ0OA4Sv?=
 =?us-ascii?Q?wDsTtD41pEHtDjb2N2E4ajZoHsZWYn9+jnHAt1H81il7aLKOc/XOM86U/ue5?=
 =?us-ascii?Q?W0C0buVh47Gm2Is6LNcdgG1zZGngmLNtY4IyR0Ir7O1upqro8QUM1bMtyGLG?=
 =?us-ascii?Q?kZkkNv0NSL2UE/3JKIjY4Zf2uNCST4lvbB8rbPjj6HmylIaOOtD+21vrIwEr?=
 =?us-ascii?Q?w3eEBjAvF8Fbv7HyyccNaFKx5U+iihzA8FhW3wwn4U6DYKTvb/Tkini6bYOj?=
 =?us-ascii?Q?67FXQ/wPTqn2Hn/Lo41f/YK24cz/JjocibB0iazVUCTRv3af10WSHw7TfVs/?=
 =?us-ascii?Q?pYYkAlqnaqO18vnYevnvJv0L5dm2G46wv7Rj2VqpIgi3+ri5ojZ0oZzzdEV1?=
 =?us-ascii?Q?VC5B834J1XiWPs48iK2C6J2WNngAIVStv+0aJ7/JzSZLEEZGKha1X2LP1WYf?=
 =?us-ascii?Q?IG+iYxtCtJK1axcmxem0/rtaFz+t21WDmkoYC7uVHT461x9E5t6RV8QIE69q?=
 =?us-ascii?Q?iC0f0Yi37zzWlfi9vGNFnucuDk73TxhToSTyVUutGXUrmCIP01RYo8b4pEsx?=
 =?us-ascii?Q?APdim769wP20jiAozD3rMqoQ00x6xaZR18uI9nCItFMmRi5bfomxzhvTxvNU?=
 =?us-ascii?Q?gpweHfxNWWeDrv8e6vylAYzTecB3CgofEl84W3p9EJGnWzlMjIVParjR8pNw?=
 =?us-ascii?Q?oHxiosa143wEpUMg0fnuKNDyCqASgaHhleTpp/FtpqG13NdonXJbvaZ9f+fL?=
 =?us-ascii?Q?wlMM9en+5Nay95rT/TPMDWsI0zKDc3veRJ60U2VKn3xPQUfVG7R65D7zbaxF?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc19be9-cbbf-4132-4e03-08ddeb9a4074
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:03:10.0266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/X3C/P0DgHQ0nCxinfMReI/Sgx92ejR3gTdcKDRZdbkD3A7lisYXgV2VHDwbxz56Y7RiNIDhSyh2mDMMaxXlpo76hoEn8WGFiYF1F0b828=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8072

Increase test robustness by retrying the LAVA boot action up to three
times on failure. Failures are detected via server-side error message
matching. This logic will be refined in the designated repository.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 tests/jobs/xenomai-beagle-bone-black.yml | 1 +
 tests/jobs/xenomai-hikey.yml             | 1 +
 tests/jobs/xenomai-rpi4.yml              | 1 +
 tests/jobs/xenomai-x86-64-efi.yml        | 1 +
 4 files changed, 4 insertions(+)

diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index 8e47dd6..b7a95bc 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -41,6 +41,7 @@ actions:
       compression: gz
 # BOOT_BLOCK
 - boot:
+    failure_retry: 3
     timeout:
       minutes: 5
     method: u-boot
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index aaf8949..27beb07 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -40,6 +40,7 @@ actions:
       compression: gz
 #  BOOT_BLOCK
 - boot:
+    failure_retry: 3
     timeout:
       minutes: 5
     method: u-boot
diff --git a/tests/jobs/xenomai-rpi4.yml b/tests/jobs/xenomai-rpi4.yml
index 50ff9ee..4074825 100644
--- a/tests/jobs/xenomai-rpi4.yml
+++ b/tests/jobs/xenomai-rpi4.yml
@@ -40,6 +40,7 @@ actions:
       compression: gz
 #  BOOT_BLOCK
 - boot:
+    failure_retry: 3
     timeout:
       minutes: 5
     method: u-boot
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index 4f1a7d8..0014429 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -41,6 +41,7 @@ actions:
       compression: gz
 # BOOT_BLOCK
 - boot:
+    failure_retry: 3
     timeout:
       minutes: 5
     method: ipxe
-- 
2.43.0

