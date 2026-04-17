Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305D3264C0
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459451; cv=fail; b=IRHw5j8vgDywWOZEaWJ3P5oz7CGOhmHRApU1BkLjOg1QADGxxpSTy0jSHyUghfEyzEJnL2xikIJRWLi40A1RYCEPbnLuggCz1XG+j9Gzai+iab8fi/utxrQ7CO0NcMn5cmHLaI110431qGBreCFVRb6mct+rCkqPph8Wtga7mG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459451; c=relaxed/simple;
	bh=Zpiv3LiebO4dnUly/sXdwrXkVRG6PaZvwMIeTEirobg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOZTtXlmyLRCVkat4/m5NcPguzXVm7vFcdCw4vGE5H3f4LLf6Xi4LBspss3T7lvOzkovYoigIXKdu/1ezTQ2bopK/+y5mC5KbGBsIZfrv+Rojsd7QnsqBot59OTTX2YwHZCw5rllFBj87lnEfNhOOAdKkdioTUSPPevbgpBzbXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=R0jv7uFL; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="R0jv7uFL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6K9EuNG9BUeFWxRo3Yz4d6LorHpyK3+2kdhmBIljf/Nbbxu7bdSWqKyA5Dv5qgtCyaLZUMazafJLcsfjUCbvb3t7jyHZOJsz7Zi3wqe5gp1NYWnzVy0EHKkjpvjXcGjyglfYo1s9LkZ6N0Dk6AmVaM28U0tght5wBBKicXWV/cP8iqWXscXZcGZp5g2zlcdHsZ/ZS+GsL09hs1UZ2/T1X2syOqlPRIIhcmovXB94/SfgUiV10Nq5BqIsQ4VoiKf84x4ZcbXrnA1weyABaEvHRKZL0sqMjazH9sjjgrpqaepxdafyWHyq4Y5e/kpCL5FjrO5FwmXwbxVm1fmdcAsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+9BvQ0QFd7rJiaMxW8GprZOGhGhTZajnWuGAroSxTc=;
 b=OPcqiMUme0P14P1/QESE17lVN/Lx/uc3pSMCNOYy12Q0fkj18wJsAEN7ZxNe+bkUN6BM7ii/PQt+Cb3E3/F8FlzyLiWNXbFVe4/+witRT2mUwBLIpw2GsjSrUTTUJukCEogs9uXgYKAfXM9Ad8OfRH+u1WVcmPo25lZHFFEcTEIQXVCcrry8dkEumNRx7SooQaZU/s/wl1fFy7AzyfkxWNVDjCUuRZvsMHU9qklPGpDE/PseuDxW9G+EZesOkQ/p12xjrIrOMz8hAV8CipNfS9KqOVQhQlZgPd9JL8cw2PoW9uq2YuZLndUpqgzYSjoXH7EQonBLCBZO3ukv9Rc34g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+9BvQ0QFd7rJiaMxW8GprZOGhGhTZajnWuGAroSxTc=;
 b=R0jv7uFLO88I5EjoJ1LXWXgMYK02bnFx+PV54/s8Cmvqo5KcDOtdlQu4mFTHxHNtSJCYq0NC+1nTk2BsiQ8uLQ5/erKffb7m7Fmbj5QcHXMQPI95Hm5tEFN0xXCIJF8Dach4jQq1iBcjpYVuFhEnHGoyx6s65AR4A1kiGCDA778aoJW+pvzORRBvtpari9Gg3+Gnf5McwZ9pcqqvn9rEL1QMsRhmJAmIPXgmhw93zsDSiek9gYvIHbnp6DD+Oy3YUf4t3Kx6xsezWsopNELPk+ioTA3QCki5XVcVESk6S4YjPf4faSX3clLdn8k3Gq1u2YDJr0bLGF6/SBFn3gPT9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB7898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 20:57:24 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 20:57:24 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH RFC xenomai-images 2/5] ci: Fix deploy script to handle multiple DTB files
Date: Fri, 17 Apr 2026 22:57:02 +0200
Message-ID: <20260417205713.2290350-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
References: <20260417205713.2290350-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ea5352-2906-4af0-3fcd-08de9cc3ecfb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	6c94JoQwBGDKqucNwpzb++f7J5lorgbEU1fAZgmfS+NPGBO1iOgGFTRGHpo+KW1FqdjSEbVp5PDcAo8SbbUl/QAza2DeZlSW8y2XhpdzBc2nPTJ8BlRHEcS8NDl/DpngQpA82JzE38HFQuCDpJ9SnjEHUiDj3Fv/zsHH34ishCkJRa07iGPStzM4QCv6unicAdkXPlByFOn5Iil03Ihg+G1sciRtKsMnahuQqU1Y2m6PpP03DAH7jyGhtaIJuLNUtRxagFlYbbTBClpco/COhtpgz0r1MfNSV4D+GSyuGIppg9u3Sagg8tqJfaCk4oIbOYTCRu1zi30PTpYf5SDmPic9PyW48UAaJ/q2Nd3wIKd9MepBORFkWERRhvIkNraKzD91hu84igXf6Au3SzmJH4joYsaX72UBFBoZv4AZF3owXpXmbLL23F93tRFUq4iaaZvVJrFJK6U+XR0+GEp73E2L6HXasaH1RK13MrAiz+wJdy2ucLL8JuAOFEzFME1y39oLHIDEJTkXS1WN0Q82wcgDjqDUlJ603CYFHMexsqG4xGNU+kcoV1gGFCVDMUGN9pLyxhQUYa6f6GTlE29hDqjoL/GZp/Av9KJ6e1SKRaoqwJ9dHuAD35E5tHJyFj4WVpV0BEBgAyxPRhxkiEHMh8JfdeltS/n2dgYQHTZRLdXG1v3Rqgk8XGwcUDT/SBdtVQUy1rEJ74qOvThTL8t1Bdhc63kLxHkvKkaiBZYHV7g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?krW4iQvHCX6d6Qh/bLkMt8B0a5EjkegU8VAF9fS/SW0j2+pfYDZZ4JUuUF9l?=
 =?us-ascii?Q?auwWl4QK5YkRXRNTQ7jLGFkzKtBo14xopl3b0yWvShgjJxgA/Uo5Bhp/01Wd?=
 =?us-ascii?Q?VJWlNKHQ+GYKaE4I0QrzR9T9YZPCsneeDtMhm9YoYFnBsa8JibrLARk6Xp2Z?=
 =?us-ascii?Q?sI/VSGrQEEqDQKXLmDyA8ePjsVoXFFnIQmvOX+z+vopeAqVWTl7TDy7JbPBL?=
 =?us-ascii?Q?l//lWvpRZzvHFGqVf+tCUS+oXPzLhQHkD5tnDh8ngDHMi9hzc0cwVjYf5vuX?=
 =?us-ascii?Q?nyj+r2gqGkmfa3KkbUQGhCwJqZKzxrpnSs+zZNa5nGrp7XzRTgtB46Am3C0w?=
 =?us-ascii?Q?Q8wGOSmB1mRliFDluN7nh2L6xx4AEbgoLN6nYH6iCK7pRpKNLJ1xOhmFz/y2?=
 =?us-ascii?Q?nq2feWHLAS9IMdpvlfIuqBDSe2z/2E0684jmaKpMBMxAqhL0fuuoiNvyeoKs?=
 =?us-ascii?Q?6y5MdLoWXJMYAcuGVIaAUSENQdSlRRgs38mQcFNk36Xcpf5pDUMg5kblCGI4?=
 =?us-ascii?Q?6c94L2ZfQA3aqWLx9Pv4W41hd8na0cdkVZZwsLL/X99yM9Amu/8pEhKTgRMV?=
 =?us-ascii?Q?d7qmc37MrgAHSvID0jH5nWYofMqMmpsxWL5Liz5iC0HJqivNft9N01cI5IKE?=
 =?us-ascii?Q?dgsttLlG8OupUpDtGL0ksATTqCZpWGDfqe1JOkpyulJVvc//ANbGoLWxscdq?=
 =?us-ascii?Q?WTUMIlV+ImJo9wnh1KeitITXEiN8eV5CNASrVVKBcf8nOCDOBPlw0XQtB8up?=
 =?us-ascii?Q?rgjmg+MEUDE3uiNsTBA53c8qv71g6LN89ooQ0OKxZ3p+MckRi6jbAme7IQDB?=
 =?us-ascii?Q?d+zqhbKJQy1CcFH0vWfEjCgLWOzCnUoFdbkmBdsHsmxGQ4mMfVg78pGPgfV4?=
 =?us-ascii?Q?FuoucLlAZIwfhqeFUdBe4rjMieDLKk+3PSXSYx+xUeob/WFWXdqeBnDTOWR+?=
 =?us-ascii?Q?aqNy3Mni0kfg60JWVHbo7a9qqiTDx7B4cdeqx/G2c6nwJuige4XYli5rbipe?=
 =?us-ascii?Q?ajzCuuySasvE2ZGOukvyc5jcTVn5dSnuwbrpshJlDxb/sVvsMyxy+OX/vJJ2?=
 =?us-ascii?Q?SXqSCypjN4DeB+tadT+EIUNS732cR/mlnUD46AgvRJ8gj2zNSPt4bw2mNE/S?=
 =?us-ascii?Q?j1tAxdlm50FdbJIxXDXtqa53S0j+x+vAnWHolxflll2o10hKzkku2wHoPT3s?=
 =?us-ascii?Q?QF04IqR0fEJ6czuu5w57sETNQAE7KbgCAt3BjAYhEoYaeh82GH4fEpBess1K?=
 =?us-ascii?Q?AZuRwNNgPML0lVSi/Ly5ZimqA7ZdYcHduxoRi7Oq0ZMjO3SUQl8RNfW4/BDI?=
 =?us-ascii?Q?d6RHxLwYeljrRC2EVtm18QvPW8wifPGtTttzxfQ1WjLrOgRDDNwDwi8hlTsG?=
 =?us-ascii?Q?piWgkZcd8NRBWX8ZHzCSdF0i+I2E/4B0yV5NzNGhRmpQF4gZfSl+Tm9s3fL1?=
 =?us-ascii?Q?DkbSdGqNW8q1+F1e5Fcn3Ny8/gnl8O29yprrB2OWgaTuVRzEydJ28uA/Ta+1?=
 =?us-ascii?Q?qowaw1g/mg3nJXd6RXmKhMlHZlJa38xRKmT05XWi7uc8V1k2fkjUCy3vbfCG?=
 =?us-ascii?Q?CJJcShzLav4M7Hzxri+T6v68/shaD5qukd6Tl76fqL3gEdKUh8eANzcpZ4UP?=
 =?us-ascii?Q?5Y3ufbDqkGfxo9hPeL6Hhar1nKmYpGAbboRRUoBD0V5DUcn9jcnBA4djr7oT?=
 =?us-ascii?Q?oLyqZ8Hh6TJUluKRnkDqP1r3mxa3J2ysurQ4bQN/yQE4DwrWSBX4S4IMFqw4?=
 =?us-ascii?Q?vnuJVHPRIBrQkHGoq9PS4erLC4XPFCo=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ea5352-2906-4af0-3fcd-08de9cc3ecfb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 20:57:24.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32/TCObVqToOX9iVd69tr2KWQvO4ut81bqgfr8A/vQUHio3WMIs0OO2w+lTBVOidJpsUrglN9947eve7AIh5XErNOfxWIW8iv6A9w0/y7Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7898

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

