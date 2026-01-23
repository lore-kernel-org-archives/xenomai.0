Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE96221FCA
	for <xenomai@lists.linux.dev>; Fri, 23 Jan 2026 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769164451; cv=fail; b=UhL5xYtR55vk44BVu/4HS8DrtsUqdUY+BOZ3VBX9AUPgVLCQo2Q5bQgNpnEKBcrokx/x7Qj89Y6eGQTYOQNeC4tgdBXsb0wckYjJV7U0yj5Mio0wuXNzPHyetDD6jw52ppBGip+pz8cHQ0e+gEvbqV+eDA5+1IuH9lO9rodBwYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769164451; c=relaxed/simple;
	bh=F4mEjEo5WWCoklAknJtOZxEtJXJSuMh0sHXldcjvJBc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G+CUXrdCtwFmJMIAYpBh18cilRvMp9vudyQY6hDVp1K5JKUk5i/B2XSMvns5g5wrD+iiPo/zfCIXsfpPSReGcDnN/+RFTmH7GHX7K4NSV34pQaq2HEZW7zt77/np+EAapxNYdCxishSOAhK+7H4BBQbv+de/jgMhkR29RXhcHOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=c23hkPoD; arc=fail smtp.client-ip=52.101.72.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="c23hkPoD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOIsIZVKyzJR/dADGzabEBCQ2v1f7R+0JUzCP+dbpGKaadznjXDkXrNPK3cPHrHVJLEvgZPfpLbkTGGwx8HaaFlidQ4ug+R8Ot7lQg6/jGAp47lZYml265cX7D6lTj8UvSd3/KFsRhbugdltzolwEZK5czxx+Ldq+YpKeWwU/OACzJx7YQpsw3ARtB0TfwX1/Km2xPtMD3C7OYdk62fqIUOmOW021qSkNsG3pwClsx/8rM+9bKi/10JYfEFlhYovGxq4hh1KTPSL7eJjxYQWgI6AHKK594xbqZClvQEzUoHzvK2iRZ0QTtniLGVt8+eZaPycL4DjkUpegU7pnDsolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdxqiACJ7YZu+mClGUSFl1Us1I6DLiRvlCYRlhuH1yQ=;
 b=AbnD8wrI5bY6g7VjxPa/05l+F3lFvHyJAiJfN4dqDT+kVVshZU1JnDrqqfOIin+2HaX7Dpmwi88BBEI9U8oY8tsrsAcpZeQJTn0cZfArYO0ul1LyT6l+PcjId6RCjdvXNO50DHLxPXDfIcyyoSgeOz1Za0Cj27xB+sK5Hb/aALdlTwnNUf3xxfa0GgV7TbUqQIf4PzojCzf2ffv5Y8kHsQdOawHDCYWixV7ZrZb7kB0eEsIPfYN/vQiVTr9fWsmWZH7Cj6ad+6vhSgKc++1nSamnuaNzM0OFeecgNZshvcYNQ3aKjySkjX/XHeqhD6bMzZD0XhXpmOy69hOOiKltSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdxqiACJ7YZu+mClGUSFl1Us1I6DLiRvlCYRlhuH1yQ=;
 b=c23hkPoDw2FE2mCEqsh2rGMtoDKayMxq+D2vh2VKAQo48Edjahz/CIP/YAbBmN6W/rGWiY/A2iIKAiSYleet9hnmhqj+fZEsx12d8FvuaBxlB/xGSbq+KEVzwZIWSe+GdG2w3Lpl4a5tyJfuIfoeJ+sUCCeX1aOG8M9aA8jGsg8cKAaKwKeelEV4dqWjdxa5i/wax0ie7IbtR0RHd7y2CeRgtr7XN801O+HDdH5RjRUuTjeo5qK3Dmh42K23iArompDco7kvY8SIe8qCrZm8SdoZCfGg45qrBBhtGoIe/7fpQa2iZUkTvZzYfwBXKAAAWSWqSOzcOP7BspRvDMSuSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM7PR10MB3559.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:142::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 10:34:07 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 10:34:07 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] libevl: allow gdb usage for ptrace-sync test
Date: Fri, 23 Jan 2026 11:33:58 +0100
Message-ID: <20260123103358.1440709-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::20) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM7PR10MB3559:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8fe9c0-344a-4ee5-1448-08de5a6aefce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DOlA5PzgNELN94oh84o6K3Cy00niuSbqfxyE1xZWIRN2kIOj9pA2bsYzzs07?=
 =?us-ascii?Q?ZT2hfr8mfwtjigsyd5iTuYPvmo1Sr4FGlPo4BDo1HT5Ff8fR9ivPf8sZX+/S?=
 =?us-ascii?Q?u0NTh8jYkRN6NNE4LHelG3ctnYpIZIgacRAdC3LGnA66b58+PQrnSX8+tNRd?=
 =?us-ascii?Q?+NRDZO5VecmHzukMImInjtsh1sFDuCMuJdzzZPGYoG2SAUekmrtwXnNlmPeX?=
 =?us-ascii?Q?zqXQ/imu9slgb3S4h/hnVm935Q/2n8c6DeJOgB9red/uYplnkiWVg6r7GHBX?=
 =?us-ascii?Q?Kc4T7DtYxT0GzKkL/0gVT72Z0WaCmmT9TOPZ6JCTlB4hf6l2jHL7ukgKl8pL?=
 =?us-ascii?Q?02GE3rF2H3TQ7bW3yrqENvAx/JVjm2t/wz+G4DeFXQ8yh7mCvJ7sbrGYDU/w?=
 =?us-ascii?Q?KRdY7lxAorzy3HwtxLnpIGpnuvVY2qiyo5/8tgpvNCoos7AHIQyGQEUEUtec?=
 =?us-ascii?Q?rTzHKS26nDmmt+DCGzsZCEtDzam8SQ3hdNKFWMSltLtJcLDm/wa/dW0JwStx?=
 =?us-ascii?Q?yb/YA6ws5lXPF/V84qAIKgJ0b412peYzydiWzJLlIw6djqciaSfi/P6xpwKE?=
 =?us-ascii?Q?V/6kJHWA8BH3YuQDxoiIQ/raHEX+0TxOfXVeIY4+5xZXfIS2YqUZLjdYjkGg?=
 =?us-ascii?Q?G+pGa4hH8TxPcwP95s8RUZDllb0ZwIQF68N8GCO8Fr9OPKRCfI+o65Cj1BNn?=
 =?us-ascii?Q?j2DFO83NYs20zW6QaiPkVrhpUZYOdxemV4c4p4rOGGmuBiow/9KiNIeB4dM8?=
 =?us-ascii?Q?QM90uhyfl9pt8t2z5P4kDBUPgKUjxSBAghhHmuGX3EiehGsyKMaW5WdFhs5n?=
 =?us-ascii?Q?9LVpG0F64Zq6K0EGZGqV1/55ulAVzjVEWAsfGDVTXqM9CzwPaIZHF1isGv0p?=
 =?us-ascii?Q?xYMZXGfTTr73sfrduuPHQXQLcjHBH7ZbOVteErcTJ4CTM57W4wfb9ke0fPEZ?=
 =?us-ascii?Q?wWirT8meFX24kITAR3tKNDpV3OyStuP6eEq8RbM9PLFQt+7eQRKCbkLlSMhW?=
 =?us-ascii?Q?68fkLw6ToVBxF3SbfO61tn72FwWx+cA38PGboebO4KAfqh8BlFktE8ZWkLJs?=
 =?us-ascii?Q?fIoyaoKxYBdKUmth5VLuVQzAA8fZ9/RgV0CqwsfKydJwPIB8enZD6LodidjH?=
 =?us-ascii?Q?2yzzNh5l1071IRZzm3Vdc6Cp2Q1/wi+xKW3z0CxeTGbaoIzLG12RGL4AvtOs?=
 =?us-ascii?Q?mJLj91xzQ31rGtNKCDMGexxsAS20oFbbGzsK0S+W/AbCDkr2GoVAu2WvG1O3?=
 =?us-ascii?Q?5IsL6xGjTWwFuupR3+8i1M6emIhRYNI3zwZXPr/PnL41uk/TmdbLp1m5/PbE?=
 =?us-ascii?Q?E5o+YXK4Uj0h3/ccfjcP8CJV6EUKZ62jnsS9NP9Y6XSonHBUB8U1Ewd4ELkX?=
 =?us-ascii?Q?MdURJmWYptFLwRPEXLe+vJsESdkHhJ6Fc5wEGD5+qA5oah2yqAlOIuBskPM2?=
 =?us-ascii?Q?wwQaYO9ii76kqqjmEUA7QxMvFPu6c86AjaZt3l6ox8EgT5CM+rrb4LNjXZJA?=
 =?us-ascii?Q?+2TZur/Tb5QjmfjWm5P2P/dClvXrcpqK9YlNUdoDNqZsHkxFsKgrK1++us98?=
 =?us-ascii?Q?x2c9YSsPTdwKSk+eetE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CaZUyQR6C7QrDfCsKHqaO+3H59T7wXHSuakNm5WzH44EeN0qpnYtberQesdU?=
 =?us-ascii?Q?7+gXXgeWm+t71gbL69gPD3I7zyzQAUCpUuh/MLboEUvhXvXuqKyTgAVM6SNF?=
 =?us-ascii?Q?PA/j4XJqQVGKRLsGzBQyBljIaLOtEJDMqdJXfkqgr5Zi4HmP7UK0y4x8Cyq+?=
 =?us-ascii?Q?YeQRp4VU1v4+nQtvZMzchvud4Byh3OdGS92H/UC3yjDQR7Lm2ATTqVmRY/9N?=
 =?us-ascii?Q?ZngjoOxYYe3xyxF7+qUfL37Sp2cJk04lcT3NPMDxXOv4uWyVol/Jv62GnB+B?=
 =?us-ascii?Q?ta4bCMZgxagjGPn80ea7UwlHxzhcynjf1ZzJGNt3TLJeIxhY5zMjBAGiNM7D?=
 =?us-ascii?Q?xI6283jskP2XgK13DHwe55XSFYW+UjtzlXKyoZS5YpR3ZjPwoT21KpJSMJj9?=
 =?us-ascii?Q?7miNi2SjrjCMDTnYcGrIVkE3W9y97Btv6QLuJ1kgGbQJeX4hkVbXzhgj9se9?=
 =?us-ascii?Q?SIunsO+zgfAycT+xcLoLP/wmuOzXkyp/yHm8x46SgzSZKUkM1ZlzpOnaxP+z?=
 =?us-ascii?Q?32N7DzxDYxh4lQ7vNXXI3efa8Uw/o7ishid5BJHWXOrQDsFIar5SSvBLI+XP?=
 =?us-ascii?Q?I0uR+aWnYaZ60BSlgXN0AZcqRsMSzNv+q/xv0FGuwl0e5l1nx+mDufLfaaDW?=
 =?us-ascii?Q?BlFp7thWSEMDAp7piBng3rFrrvRtSRiuRkDktynwTeSzBCTPRdwpYPpwJZ6F?=
 =?us-ascii?Q?wCGnAjUvq1fgxPfFOGSgBPSC5ujNZ5nVR/q8RG4eRShmXu/LusK23SBcX629?=
 =?us-ascii?Q?7TPbCaKF1RDhJ+KoS3lFxJcAdiAD/Qn0xiMu+mk3MnodjrQ6ILMs8QnQFUC6?=
 =?us-ascii?Q?R47b2FrRwoBXaVqdoOXeVBi4XgGm04OOk7luAKZwxdtnwNwly9W02Y2YcOHn?=
 =?us-ascii?Q?usFF5UEdRkkK7ObAWZIMJ4JNKSU1F0lAyRcIApwQ6ejNdyNE6MVh0VwqxX0m?=
 =?us-ascii?Q?jbcobsrJUXzxgNN/gv8uXof3a8+2Jm6mhGOYIvuuy1UZ9Re9DLB6xHM+jqT3?=
 =?us-ascii?Q?opUPPsT2dFOIuMx9qbL8NgcqTlvre1Ctg3+u1nJidG+Y9YNLvBmHFdS/1c0d?=
 =?us-ascii?Q?vdUNLZ/LRwk7jEvs/Cfa0bc2Nzqe5q8W9n721Cveh2JDq+zKCGPtth2BjR67?=
 =?us-ascii?Q?miGT/SW46f2CO/Dt51toJJ0neFcdTZ5FpQ+/1plEtDygr29rcs6x1bbi/XTJ?=
 =?us-ascii?Q?reeA4E/g0HMlC820jnfcGrCS6Ok56+v7DREg/pyJ9CjeZW5fYibCu/b//Q8R?=
 =?us-ascii?Q?VA/VpCKw6v4/7D9mBpSPd7ST1SH4rmD/TC+E2imkCxxnfCAhZlgmluIxuedl?=
 =?us-ascii?Q?GKwaAooXI4i27DlefYEzFoQy2j/vHaDHTAolxWMv3qINZsyqHWFjcdnmBPr1?=
 =?us-ascii?Q?aFp04afndJoqlen7hn2NT+4LCwENLmUOk0vx38I2B1awQOr359+gqEjh/X48?=
 =?us-ascii?Q?Ra2NV43Gvh4TJ/KQP0r77fSMbfrn25T52aYN01Rf8c7bgk14VvShYiqlniiE?=
 =?us-ascii?Q?+tlgGLClTJLQ2KEqj0xCgEO5vILWh/2htRxEq/TRY6dmdCDQWL9Cu30p76jH?=
 =?us-ascii?Q?aboNvhZHxaw/3Lch5wNx8OpHSwJ8qC+hUp40HZbqTwhy8fbbXFBMaS69+ebw?=
 =?us-ascii?Q?k5IyXgVDee6kiXpmis0SU+Gkt965lHRMSyC8sJ5RVf0SrNzSKtSo4LwhXTSy?=
 =?us-ascii?Q?spFqjqAzpYqm3uXicdo9KOUIVNWVhyWfPDSManaCzW7KM2fUY+bDul1J0DKW?=
 =?us-ascii?Q?YYuqp8pMGlh0KJW5avRbNSH3fMm2LEc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8fe9c0-344a-4ee5-1448-08de5a6aefce
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:34:07.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1whz5LpbDaW+UPixZbxvi0+4mpUE5TzxWh1w6jD0l8uZOAQWQ+nPSKKVjVuXAWk9gRL8+P9dzzh23Pdnrl08y6UDK0dS75NriHIE3k0cwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3559

The ptrace-sync test uses gdb to resolve and set breakpoints at some
named symbols.

Add gdb as dependency and disable stripping to keep the symbols in the
test binary.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-xenomai/libevl/files/debian/control.tmpl | 2 +-
 recipes-xenomai/libevl/files/debian/rules        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/recipes-xenomai/libevl/files/debian/control.tmpl b/recipes-xenomai/libevl/files/debian/control.tmpl
index 36eb68c..d9c0ab1 100644
--- a/recipes-xenomai/libevl/files/debian/control.tmpl
+++ b/recipes-xenomai/libevl/files/debian/control.tmpl
@@ -8,4 +8,4 @@ Build-Depends: ${DEBIAN_BUILD_DEPENDS}
 Package: libevl
 Architecture: ${DISTRO_ARCH}
 Description: ${DESCRIPTION}
-Depends: ${shlibs:Depends}
+Depends: gdb, ${shlibs:Depends}
diff --git a/recipes-xenomai/libevl/files/debian/rules b/recipes-xenomai/libevl/files/debian/rules
index 07c28b9..debe269 100755
--- a/recipes-xenomai/libevl/files/debian/rules
+++ b/recipes-xenomai/libevl/files/debian/rules
@@ -15,5 +15,7 @@ override_dh_fixperms:
 override_dh_auto_configure:
 	dh_auto_configure -- -Duapi=$(UAPI) -Dinstall-uapi=false
 
+override_dh_strip:
+
 %:
 	dh $@ --buildsystem=meson
-- 
2.43.0

