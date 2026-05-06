Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013009.outbound.protection.outlook.com [52.101.83.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FBB3D544
	for <xenomai@lists.linux.dev>; Wed,  6 May 2026 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056935; cv=fail; b=tpPyXoZOOrJ4NetKB45Go/7ZFw3WlQwSHTfz3IABkxhLhjf+s1FQE4lFH0rToD6iBSpeNd5AE4q9qlzoDKhAQ6jH2Cv1LZid35izMhcDeyJ5XE6vbO2I+EYUBAho/K30ym7nw7hun1bjt1LIMX7akyRKBC+6e1RQDitvWMbTHR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056935; c=relaxed/simple;
	bh=Zpiv3LiebO4dnUly/sXdwrXkVRG6PaZvwMIeTEirobg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jUHROum5DBbTMTbBCFnmQY50F5FzmM4KhFVxwoU47KhuQ3gl0SOQCjRUrN0pzHrWJ6OwQAaWO6exrsTSYPdSE7PgCO8xPzDy3h/ePonA3P1byqKyvUkFpK5Qm+1QfWS33PPP5IfzHca1kreXc00AXuUsuQC9o0SWY9lna7klGiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=EkLMpHcW; arc=fail smtp.client-ip=52.101.83.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="EkLMpHcW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opiqzdMDzeQ9Zyz9zlk4XJvIXoPK8E/gMtfGK3DcQbK9N4pM4Dcek0C0fAg/T5+E+z/ECLfLw14gKqKFIJ95L94/iFObcOs9Qu9w2e1KMW7N0reEwEycNbe9G674ajbn0J0zgDQc/qcU2jyVMVJpaCHq9o71KdFMmn32jBtKjoRrr26zw1pF6VI5iQTDQdRfWpwrQ5T8TJDK/nNbyUUliSFI6KgrUuAW0KIPB9qEk6BhxizO9HHmzkQ3kjK8TLIr//JGyy+WDd2627Y1i2xlSjog3L6iwcD1B9BEz1+0y+q9jEdQeEqfU0ZGLzDDuiyt/UyMe3MW0gN996A1MxQ0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+9BvQ0QFd7rJiaMxW8GprZOGhGhTZajnWuGAroSxTc=;
 b=qxRmVsMG3yaVbj85ZGXbXc3yykSPqa+aaH4P9SH0S3LX6HH4NSv4zI6fFL1EhvW5IOhyVhAtJ18pMYd5YPqX9yJlcsjT0OzfcPap3tr54P7EZzslqjSAPitqoMNAgytSimzTrVDdxvD/p07/5z2THAFy6f879Y5MlMj538uqqvXdBq/iDtvAtEDsN58JJZjd4FQxXXcxu1HcLf1UDSUS6LI33uBmRseCRFvMtAnPkmo0nXYpVkws56ZHHLxW14hgdBF9w2Ez3Ld5WzMf5qXnhdhN+5c+XzWf05l5kqGoAkm2EwA/J+1rcdAV8j3OSxZt0EhHUMbONHiJszIxTlzjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+9BvQ0QFd7rJiaMxW8GprZOGhGhTZajnWuGAroSxTc=;
 b=EkLMpHcWYIDIuHDiCUc6p6JeZVgi5TihZxEOExBQslwwfqbDV10XqLxA4EQhdHEQsHj1Ei4VRa84sMJWvaH+8JgLCEOqzSDurESRwV0Gnj52gjmsNNq6+/FFTym4+/zDzSRQp1UyBpkXIaoHJno3+Gokt1AzlFo39C4kTiSswHBw2uNKQkAFyIJfr7mMCwf6bQmbgzLAw7OGCcLB7XXAoEfPNLbls6am6q82JkrgFWY3z2JJQnknepLYruXJf4YGTM5xo4qAtAYJcy/qKoO877pD6OXv5k3ESIeSzOIVWDozlBJStFTDRFi+XZh1FLKBjNM/U/Htk/VzQCchqFUSXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM9PR10MB4070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 08:42:09 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 08:42:09 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images v4 1/3] ci: Fix deploy script to handle multiple DTB files
Date: Wed,  6 May 2026 10:41:40 +0200
Message-ID: <20260506084142.190854-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506084142.190854-1-tobias.schaffner@siemens.com>
References: <20260506084142.190854-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::14) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM9PR10MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a11569-4643-4668-2975-08deab4b5c07
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4+rQliOk+DjWFNKl1j/qAv+vhpunpEQV7s/n/MeY6ZGNPCaijrnf97ubyH4q85jXRInOp00Tz0/5EGovSbkVpy2GUMRPXD+CqB8Js6wWFseUNAgIoY/Kr1tdYky0v+Drpx6zgb1EDTU51TjNa/i3Ipdhp5DeUcnwrK+GeAQlcUJ1VPKHap1M6bUT/CBXIzGr4BPvDMTYFEaLa7NofdIQVi6QsGc+MP9FO/5tHvPfZgHQnysyovGfLVVpUczEqTcR+X+pqxlr7MEPGfReq/Uc1L9kdrg06hanrqDFVC7gt43lkP2MmNe02SEur6nbbzI2LCa5scnX0h72+gyXj3UbG/kEJ/+DCw/eUFR7pprRzjDGE3qfwgOCdgCiLZqlhzhWNlJ5U4trahWZdeXAWhhddBI3DBkfO/c8/7wq2tJ1SWRyJGTFpUMOXald5fUHL/QErWK5Dvm/csSjMjiiBFcZvAQBc2RR4WpqZ3axhyEf5OZLthmg4bHmLywa6D1ICbv/FuaJt/Dk0ODaSG8OZbQFYX+OfLltnhT6Db9VlSPDDXqyAAGkg+yZsK5nOLanfOQdm+ejxw7wAXCERDp3FP3vRQsGY24ysMoD7T+6EJrrCisHeaVBTKDHcEOI/x3QY1WOKg1AsMM0UiFXUtz6fa1btiXqbGEQ3SXfzSozkSmiI/Yb/Kqxw5zIXVD77sG9uNMg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbjQrrdXrrQW4ls4rka8u1HeZvrIvTVOQY9dmmpBIpsgjQLbJFWJ7BLhlgPA?=
 =?us-ascii?Q?fftrM85V1mORn1ZGdfAYSKQlz6IZonLI5BTZ5lo7ZLpwnvCs+AzB9CjSHZt1?=
 =?us-ascii?Q?liKGZnFGpR+vriKNLxW6XeWY/V5Q7FL828wOuxJqFP7IOHLQfYjIuvtvSL3e?=
 =?us-ascii?Q?/VuAuwc9wkDV1mP0AAsjvMJnlQjjEkAiG1SnFkCZ3PSDBxFFI6noycqOi1xm?=
 =?us-ascii?Q?VSvXFkiNQ1ZrIP5Fdx0oyGB3rImI92KPBJFWOAs7Vw93ODBTOzZRDXY8k2zO?=
 =?us-ascii?Q?dAeZBkxJPe+ldfWCBv/rtGAHXrDXKdQfdG1pS5cXK5zZPTXF0Ho8eqi74HP+?=
 =?us-ascii?Q?TE3vcVvCPZJUhrFrCRIKSArPoIRyMvibJyptrXx1GNGHEmH7374Zi7c287xs?=
 =?us-ascii?Q?6Q9/Ocivn5i0UNZAHYKStlrQ7nCeB2W/8ne+yywHAp8CiWBki3mw7CJcgk2m?=
 =?us-ascii?Q?GGBP0kLwS5ckiNzVnhCGm1hx6nTS4dcpd9i4p/N26PvpyaXRGRoYvhLYJRzQ?=
 =?us-ascii?Q?nWx/9poWJ1ExaD++YYdcWzNDpSBIZJO5B51d/4qbrqpK/JddsO5moFAg55s5?=
 =?us-ascii?Q?QeiFu78j4sNmarI4sNpUD6vSnOzcmgIr0cuIKixk6ojvPBrwBaKINXd5S3iG?=
 =?us-ascii?Q?ZuD2S+RlDWyhF+u8jIHqghu5yu8rzptN1GKx5M7RkcTmc6vJ9Loa5pGScJpU?=
 =?us-ascii?Q?3X7vGTXzq2Y7QDVKmEz1wjQh4KTmmXGFapSThsiolpHFXnsQyUzbtAWwY4jM?=
 =?us-ascii?Q?oGUipzQ808R9NgXtlqROZ4zWt58RkMabsWZBFj3CiRaTOdRas3M3J8VFnluP?=
 =?us-ascii?Q?5R7KEZXmfd6vNSPAzKjKS04owg25JAengGzOQUa8WNsGQUWWTlvy/M4fzaj0?=
 =?us-ascii?Q?CKOKtZbtojgProkk4RI7XtKnFM2rqWFO8I8r1MR/v2NQxSA4r3fMjJqIePN+?=
 =?us-ascii?Q?cAn38FR7A+J0lnYvGpk2kFo/aC+lKX4771vkdflOkP0YJXlIZRTJjZF0Kwrq?=
 =?us-ascii?Q?EuZW07LGrl1wgqOJYLEK3CrbDeqvoyRQO5Y24gdYOTCZ3b75iQlYtLTKG7B/?=
 =?us-ascii?Q?hJBThEp94+Giq9SK5VUxCSTCQfTeDzrjs/Pby7v++kLFVH+fwDssJpzAy/Io?=
 =?us-ascii?Q?WSIIAYkfXmZ6KxdLxpznn/VnbcpDOwKAjvxK717kmnkrU6SzxprGR3rh+Ddj?=
 =?us-ascii?Q?gfjnNqfXvYFp6EnPEbTUa5ff/oKXf0B1O8gPhnwKJoCMiJ9PKrFNqqh99AzL?=
 =?us-ascii?Q?FiFibuHWYLT92n0ARgVrOlDTdbzl+VcbNio4MURfsHjefd99sgw2GqMZ7joO?=
 =?us-ascii?Q?VFa8ixLLy/wCqtOu+Xo6EuQSowg68XbQJAj4UJEjV7OokSvbFUsqW3A5c5d8?=
 =?us-ascii?Q?fKL9pblp9gU/EeDdcebtUJ/pb221MbI4Wq5zWnLH0blsyFUbhPZTnFWLEhVH?=
 =?us-ascii?Q?Mls18ZEVVXbKFjF4vm4iN7MKfvVzhobZwA6asaVpJyjCL46JzgagbLJOXIxB?=
 =?us-ascii?Q?ztG9RoWtK9Oh4PkFrVTW5QWWYP9L1ZAn9JltzdeIqpS3hN/gnu6q9piWJ5ev?=
 =?us-ascii?Q?Gqp5Mh1cXmgpbs6e8zdHnVh3XFnmueoqOVfNkoI/T5cnFSy4nSDE37oXg1pn?=
 =?us-ascii?Q?B2nXCG6j8kZUdWLsunIpGTUhx46//q9i2xSBH47huZT52Evic2VtKGePvrs+?=
 =?us-ascii?Q?ApfK/wgIlID+a2ihhK3zgNkIpbwPlNMPPrMR0NGT19bmSBBpRZOW6CjydgO4?=
 =?us-ascii?Q?2LmB8uPXJL6Pt2OrorchDa7XmZS4k/0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a11569-4643-4668-2975-08deab4b5c07
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 08:42:09.1510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmmRwUcKlaIkWRjI7n6TNG68HHxfPgpEKSIxTXZ+A+7/a7SxRYo1n0McexagGb/sJplJwJbPEcn706Ren1UAUQJXBYijYj4Cg53Ew30SRXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4070

Loop over DTB files individually instead of treating them as one path.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 scripts/deploy_to_aws.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/deploy_to_aws.sh b/scripts/deploy_to_aws.sh
index 2e0ee41..6c9d8dd 100755
--- a/scripts/deploy_to_aws.sh
+++ b/scripts/deploy_to_aws.sh
@@ -53,7 +53,8 @@ image=$(ls "${images_dir}/${target}/${isar_base_name}".*.gz)
 aws s3 cp "${image}" "${deploy_dir}/$(basename "${image}")"
 
 # DTB
-dtb=$(ls "${images_dir}/${target}/"*.dtb 2> /dev/null || true )
-if [ -n "${dtb}" ] ; then
-    aws s3 cp  "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
-fi
+for dtb in "${images_dir}/${target}/"*.dtb ; do
+    if [ -f "${dtb}" ]; then
+        aws s3 cp "${dtb}" "${deploy_dir}/$(basename "${dtb}")"
+    fi
+done
-- 
2.43.0

