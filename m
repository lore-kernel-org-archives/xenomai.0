Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8D33E358
	for <xenomai@lists.linux.dev>; Thu,  9 Jul 2026 14:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607735; cv=fail; b=WZefj5Swoki5PXZFPL6HklXNO+20oyvekWFHBmWJvBeFvnfqmJDIN8GQznnuRkVWYvK3NXLwxtm8BMCfSjuJ8lOpuU2aTN6UzuHNLmM7fc04Bsz2SZoU2rVN+kOpktM4hJzkQwzTClu2GgSQ77eGQFr5vcfWyqvu0X1R9CAxPYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607735; c=relaxed/simple;
	bh=SUfJounz8L3U1hbnzAhqcIMU/PVLWAZxvS1l0+Oqy1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jjK2noiym9AVDxBCzl27ozUX8FLQyfjiBHXT/N0GfuOMbV5aOPg/0tqKSwG6lNcLmm1b8w/bjH6Nco2wspvFdlH/ng9hyek2Azo+zSnvnBZYQRU8lvmr8Q0V/iFG4DkIoY2QxHca4aeZxPETiLD18rBZHFV/qnFDEOP2IUmv3m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GwMqws1w; arc=fail smtp.client-ip=40.107.130.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GwMqws1w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rK/GTdWdIgA+QKBh3mBCHVAuxwG/PJqmP7LZtwQY9oq9c7w2ITFgmcbHxx40WQ/sF9csC30EhZA5l7dZyGzKMcCF9bqfk6J9PV2y3OoZ0iAQdILjarXPaKTGwYn54f0bhimE+oAvR9IuVo/02240IZY32tnQbun7TM9HixK7rqfg+rQPY2TQ3o89cMOieRBy6fZ2Ix3aSBSeNosYjM8ITWCyjWraW4s1IKRd2zCAhid8x2y38YVepPJqFWE2Disu/Ji4FqiDH1gFuXJLLNMx+pXZs00f7aWjCCiJSlTRgTtrALeEoy/1Jxm3L3suIeZi9zu1n8j60oeJdLZVKKFzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGZq/rw5m7TA3+QZOUAGFzjC4resQPOuew5OZPwntkc=;
 b=cnA2gv6fbSBHm1CxOZT8jmw702CN2GDXnsvqSyfhj4Tg0ty33MAt8R5Hpf8sdE9rvKFDDWYn1FqLrJqalMe2Nw7eZWJTkpwMFK0MuHvCDFj9KCb0J63brHds3DFNAQUdYsUO/SaxgQN59F9Goh238hk5hTc5pzbqP8c/QgCgkf6Yq3NRSLMkCh77lZSxlmW1SsytCP0H14seu5RP2X7bK3tT3HoFOrq8CvlseXaGz5qvwkqpHVX18NTi+dIMdoX9adJJT3GfVUfG+V2BKuiWPrjfVTZ/X67BQkEjxONdz2yI61tWtSea5ViAVjQnBMN8nJDrF1LTRI9NhzAPvRqfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGZq/rw5m7TA3+QZOUAGFzjC4resQPOuew5OZPwntkc=;
 b=GwMqws1wwKB5zdY560dR1MDKSr6B2EKXkVo9Om6ARDNuzvf19t3dLKr3yuGX8q+10Qjf0LMlZsBCUfu/AwAFxrWBLHUeuQ9qfmOKZurnHJoz4VUGcNWOrY50lscvqTYTidBlaajwhMkVPszEhl5NxROcNbJq7mABnpq6WjiPwvssUAZdXBueWfjnX5WkdyIdF+yTd9lOwVhJIETjL6U+dke3L8G1LwK4+u46synD8jmEwzFMTKniFE9k7k14Hb23bYDVL2c+Ptvw33fpp3CzY0JmdtXMlj4KLh6b8Ngvyx0S32bR0naUnMjenoRNbaAeqUzIMIHrkf0Bzu1HZ2Mjlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI0PR10MB8984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:213::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Thu, 9 Jul
 2026 14:35:26 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 14:35:26 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl v2 3/4] latmus: send setup messages to stdout instead of stderr
Date: Thu,  9 Jul 2026 16:35:15 +0200
Message-ID: <20260709143516.395611-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709143516.395611-1-tobias.schaffner@siemens.com>
References: <20260709143516.395611-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2P251CA0011.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::6) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI0PR10MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d1ebe4-9cdd-4d97-3f61-08deddc7513e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|11063799006|56012099006|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GPF5cbZEndM5tM99NB5rzkyx5WpW6YzVGmJiuqieHqs12IVQuQUZbpSarH7frfQtGMC7mJq0G+g31SHhoTYbtWOwLig7hX7BNL9h29RCoRTpy7mm/bcd7DvEYrhQ8+ibeO+p/S4pooeyYXxTf8t8Z9fdHcXnc8YWJ4kcPxv0w463RZN0PrNlp7lOFgs0jl11N7C3rSxXQDqJTC8v+U7n5FQX270Obo9xG3yVB+nbRMiVD0vhRv/HRhHMJe4fOqEVaQrRAgRIo54Qkt0ucfc8YR8DYQSsfOKrWjGTsQBt+ncvbbPSW6aGDJZMCMOVQ511kagZwimP/dw5IRfvTMWlekaGVttaTdEKLmnmXZmCsSkNiz5zt0cOuzmDZqWtN8+SbzVbhqPbeYN5QcjcOv1aua53S7sQZJ/KldiTE0YbJ6uTifKsZhYpEI530wVha0bqg4hDyTOps/c1anC07ujvFr51dhAdKMSFdNJg80n7PVjX0Ahgx0oqssEnhwdYG0vrDscKr8kCnvI4oeeBFdjHsuJQaXM51tyb1qDRy7cgfRWfH2hHhOS6eLUl39s4eFREoSE+jV2eTipdcfpCp06mlFhzyIS3eAG0PoYRQF0SBM/tqiH6U9WYiG5FpVjTDrcdJ3spbve4JtEM6k09AdMGL4ipXGqippP7OcOAp4CRkZU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(11063799006)(56012099006)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+2cqt0WSYhT9YEr9hQIlJVr/mzyhoydRBSN8/n1bWJ2NIW1xA4x3i+0eVRw?=
 =?us-ascii?Q?IPXl63OVKfR4jD5LZtnLwau+wW//1xxS4t4G7ifoLwBrCPgwBmugv02wLtGU?=
 =?us-ascii?Q?AEVjvv1w0g2pE1itX34v/9MlyzAGQDp6yMtVKZ4BQrQkJHvygtf3wGCygiKc?=
 =?us-ascii?Q?N6RGbZ1HehzOMU4ywbHRLmW6olKczyFg/Jj5vnnqe7Pah+oGm1o9T5/6ScYj?=
 =?us-ascii?Q?ggy7A9TDfNNEH0HUuRQzzFc0w46JK4IO+JurOw1YgNEzqSMXlcKbDpHr8mK2?=
 =?us-ascii?Q?veAutwL2pAQp+Pfq8A5H9haz+229Z5DWC3to3gYP1yQqkUoJXvUx0NnATn2F?=
 =?us-ascii?Q?KlBe2l/a0C9J8Om/YM4KWwB3yqOas0qsaAgAMxLI4bJOe+QJHSIi51xtE/zZ?=
 =?us-ascii?Q?iQUcfyvbGbwCsNf1Q7BO3tK27o1sE+V1D62MEZLDz6L9v/5inx+quCN1qSyv?=
 =?us-ascii?Q?w/BUWuezaAa/2O8fYAXSJGheauO4VkuoJc9hp0k30K2T6YCJlQ4ANQFgn2Ij?=
 =?us-ascii?Q?VNzKwEcxO+NPS92aV5U5YIL+3u8GWBsg9PVcdbTxJn68sh/gva5/Du7XYF6n?=
 =?us-ascii?Q?y8qjjrs5gu6P0DR3v6gWr27kLRQDYlNFsdt6x+133fECBVGBhB7td3emwkKi?=
 =?us-ascii?Q?fWmF6vrFVa63rl78f4U1uySQE/kGBbzZdU7UxOuPkfK+4zk2ezbZeWxDit6u?=
 =?us-ascii?Q?FevWqfcSd9PUCNzsIQ2KeUPVgSAdJzTZvJdcVnGvyiAgY515Nw3pg/D3oEj6?=
 =?us-ascii?Q?jaYjjn4jA7xDPq7NAK2+yy8kYMG5CuNrlXyDfvJ18H1HMZl9ij5QLyt4Pk+Z?=
 =?us-ascii?Q?v8rJagfPPlBV6oAS15SR5E334r2Petq+k/Uw9buKe2mJoEkKnGEoChkutOFL?=
 =?us-ascii?Q?FCplt0cCsEs+R+1hP9P7ekKnAFU1eyz6ZD1DHSomAKDZNgJYbC7mW8W06P2G?=
 =?us-ascii?Q?De+hBkNp4NWqnZHP6XSIC4Svi9arLRsyI9r+stOHrQWxEBTDjgTGhTJQpFYM?=
 =?us-ascii?Q?dq/TkagMzJEPHJfr5kOx+q9Wdjmc3lKS/NyrjrIWf0sPsUcViRTRjatAcvGB?=
 =?us-ascii?Q?NEKXVsxrOAqdIQ9cPhDfPiyiSXNkm6SEkp2dZEywf6K+8QCVBq40YOXHpDA9?=
 =?us-ascii?Q?SX6Fr7E9dS7EYL/MJWBoNwZaqd1T0r+/DN//geIWf2ofyb370I5+GpAb/uCr?=
 =?us-ascii?Q?RIXJ2ypxLK7OGU64YIvEGvaqRjX/JYQIMd5bY/RvcCNppXzeNU0mZqNe0Tv4?=
 =?us-ascii?Q?pRHwvBpBtJ38lzEFX9ja9+NcGj82iixi3Yz7Lb3NtHwr+vGOD7utQ1/Y5kPf?=
 =?us-ascii?Q?oNAeIrTmJ6mRFb042Gu+N4qFbKFHxrT+v1VLr275GEUkC/cSqUtaF5YYfb5x?=
 =?us-ascii?Q?siO5YL6IhLCxfvA7fMfEI6ntzYyUA/6e5JuFUImdZ0jCY4lc2JHTp+KEluos?=
 =?us-ascii?Q?imZxL4JBCiX+BbL7B9SPoEe2DZ1J1wi8S4uNShpEb7xcM/i0UnMnrIANd8tF?=
 =?us-ascii?Q?uMX9u6F48KyMUe0Aa6OVQT+xVRgVHUXJGUQRc13gHXYWoMfXK/BGBxALN0j1?=
 =?us-ascii?Q?VLg12TXr5KZaZB2CU1ZiMZzVx7pfgnLP3iM51AUm/K6kd6G9y/T1fPOU9mon?=
 =?us-ascii?Q?3i3XFri6U9oSE15Y64ehxQ6LEOQaQncGskTeIHApeuiFrXyweAyXcziOff00?=
 =?us-ascii?Q?IRgCqCloLUymNzLV1S0I5Cw7Q6FM+lnqGYIo1F54t12DPeraSXprYkq+abGx?=
 =?us-ascii?Q?MSP4CbGsk4AB2YEVIHQzE0BSM5UtwDg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d1ebe4-9cdd-4d97-3f61-08deddc7513e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:35:26.6438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mj/gL3PiP7M/p7FeGLZurjMjZPWDtfJkNone4wa3rIT0OupO8uNgzWx4Czylcqw/MWTdL4D9sf3+evaYQSKhqLQt6jwOVMwozDbqOSvr+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8984

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 latmus/latmus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/latmus/latmus.c b/latmus/latmus.c
index 9b3ed1e..772cd9f 100644
--- a/latmus/latmus.c
+++ b/latmus/latmus.c
@@ -369,9 +369,9 @@ static void do_measurement(size_t histogram_cells, bool no_check)
 		cpu_s = " (not isolated)";
 
 	if (verbosity > 0)
-		fprintf(stderr, "warming up on CPU%d%s...\n", responder_cpu, cpu_s);
+		fprintf(stdout, "warming up on CPU%d%s...\n", responder_cpu, cpu_s);
 	else
-		fprintf(stderr, "running quietly for %ld seconds on CPU%d%s\n",
+		fprintf(stdout, "running quietly for %ld seconds on CPU%d%s\n",
 			(long)timeout, responder_cpu, cpu_s);
 
 	switch (context_type) {
-- 
2.43.0

