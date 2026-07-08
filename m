Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011033.outbound.protection.outlook.com [40.107.130.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9123E00A9
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539647; cv=fail; b=QT4Ptam0UFc1RY1Ni7xFm5TQKos5E816PvQZ1XEaK+qYlMXc/CmPoTQmJpdmkPL4xFqbo8OYXS3erOl2OJFBLnNjbGYl+GJn5H8DRfPZ1vavPOnKqAAQdu1/oBJi6w/3rZATK5AlgWuYlmWHP8d8+V+DwdFiyS120SolReg7w34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539647; c=relaxed/simple;
	bh=gYSGs7IloARCDNpRDJ5PW5Tb88eFHY4ixYpLuKAG9P4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=noWifOJH3vmTUlVGp8wYVO1LeFr/Guzr0DZPu29AIXKd66uylePxpTZAO72CXWaqkWIbMCDUCw7/N+eTj0+ryJwsd8CK7LCPlo9wqoXOJyN1mqA9XjN+H6gkrWIDYa1plrK0bXkxexlTzX/9ZspgqSOCOhNhPWhQPo1/tOFUKu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=UbLAedDI; arc=fail smtp.client-ip=40.107.130.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="UbLAedDI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NU3iqmyqDyykkKUiBd4oCCTjHvpx9VKrlm7ut+W77zIxWUeri4xr6EbjrpPy0SS/9d4OsQz+8qkxaN1J5XvIW8S7hjZqh1jRneGOWYrBCF15nHSOo1eeRpOtBNGE4kh3b+ZMh9nsp8bNP2Ke/u9wZ2nIef9rrW1ZdJT42qOhTzUi2qMKVe9RLmUnp/FYCt3iaC0sM1VkQgAkrCrdt0I6aR4JZVtSYwcQo1DjDsYfbnjzu6AkwRaeinxnb7EwGN2s02PY6RIEoUHKwXbmdtpKMFA8k9IGElBa32wvnQnxHvcQc6Asw86qUGLm2ugl+6FiAm6ru77rTITHdfX7yZnu2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXDcQdSjASG2Qx1WZe+HmLUKQF/fAbG/PoVUaM2ljnA=;
 b=Z5PqoEq2ObPC+kCjpm83gcXBbMTklpEIGtEtnimV7re2AGC+suM7O/8x0/FUhmGkKuKBQLTihEjJLICRTildlZb6TbdydntR+vuFiyEyaq5fRJXCHKQgOLo+ipVsbI9dTVLH5j+nyWEF1sr9sUJfSPcKnCUryF7whMfN2xW7YgCXB4oZ3pdMR3vIISsV6lMrWz3UwyxwjQ00Qr+/VdPR64g9kK4UF9vTz+uJ8Wk+f4WSfI4aUTBRTW+HlvS5E4IJB+t0uVdSpx323FRg4HCsmwf1IOqg0HAxojmuDtj+ZmRxwWeGMu2dLPm1l0alWhK+aTRbgkvmMgW6R1xesz+trg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXDcQdSjASG2Qx1WZe+HmLUKQF/fAbG/PoVUaM2ljnA=;
 b=UbLAedDI+p0imFm8VD/p1VLFiccyUaTX+ULk3e3xCvYw5vFYnLrEUA7Pwy5PRdRPqZeSyoZG/XvcPEAuUv7Z6VZqmyUwhdROGaf0GcqiOpwj2E2Mx9FRUjOiyQ2AkKKCU1DNCpFP/d4YOjXFAB0BTwHtMAGXaay+ciG4SR3M2voWg5/nwnGooiZhZ9ZR+LbB+xkbpkkcFHLsV3tqpvlripLUI8ri8EH52cTIjD6qTHls4h6ZFOh4l4l7Ljy7e/2LbxLm14SvbIDXY2Tu9HKwJt+kgx51pM5U2bnt49sfJc68o8wvX0EjromDzIdKD/XjNVMDKzPGZyvRCSbZ0mWCRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB6445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:558::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Wed, 8 Jul
 2026 19:40:34 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 19:40:34 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH xenomai-images] linux-xenomai: use the wip/evl-riscv branch for riscv
Date: Wed,  8 Jul 2026 21:40:21 +0200
Message-ID: <20260708194021.1236842-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 443d333d-9527-4f23-bf03-08dedd28c6e9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|1800799024|376014|11063799006|18002099003|3023799007|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	U/Ua9MT43LzoVBstI5AM5YHwoFqkTtUm/uh9D8MQnUuWJVMVyEh+dCo1ttg5Ky6lZ0PD2p02o2rL/Gg1SFZm6Bgsy448LeNN8PjPw3TEk3Efb4s6zgES4Cg3rgnf8A59Yt4gLnTGT1SC9zpvn2DQ+tG/UzntgldDEIPpmhq938+7yd8hhdMKkMTzImg9CNt0gQNWK5sdtJAIrvCyuQ6vm91ZYsPufo+313GQyyiInj63eAw8kXXKWkbH8A64DU2sY3z7z78CaA7laveJzdABKe/isCBeAO1b5bBAP4gUmlMHTEW9Lb79C2iE8Y9RHKoONQM9IrCmlIbzDVf1OvSrTVgDLRi8CJSMpI9Sbg03s2eA6AIWSzL6UruA8vYQdrfCFf3akomgrbQxLhV1cb69FFy0vaZi4NHBDM6WUMY3zRfmcdWM8LZPG/9lUaznikY3HonHqPeAQUKEu5K2oBxIJTldUY5l5L9Q5jKDE6VBgTcW2vbXTJxNmMbcHLwYxYc5Hv3K95sFQ/rgDYEUR8e4dr1nQFy6xDdkGtSahMWzGv+fMb33XZH982GoHvqQUBiOQ/9qvx97BWYmW1R+1+mfRAS3fkCk2/RGNbjpA82U87Kh9Gc/6xJ92dzafZM/8R02weRYPJ7Kzm1gDMJpuKS8Mh8pbbgp/u2pX8CuNYYe8Xc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(1800799024)(376014)(11063799006)(18002099003)(3023799007)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hpWN8KVB04lw2Qkglo1g9XkQ+bSncKwVJlRxVzmtmHNoZdyf4Pi2nC7hveAz?=
 =?us-ascii?Q?O0UluXy5cBJJ8wvHy8VqfLo/U2cu0QvRovzkUt0Z2PZ0/HljS3VKKuyubmcL?=
 =?us-ascii?Q?cIoELpNQXst4A9zl+jjGvLolQ2OuS26Q0TCaxyeTlCJ/ghV8NKzF5I3drmE2?=
 =?us-ascii?Q?GeqBFMLeFQp22L91rp41adEpVpD0f+U6QdrlOuimFOw7aC3Nag3VUg3ECUJa?=
 =?us-ascii?Q?CXiQ7/dh62Ag5aVQTr1CHEycL3VqIDk/Ltghx6G31pe4CgQ9e78k5tLLOGYR?=
 =?us-ascii?Q?mjxd4ixjjwrHwTZo6qRWiE0OQjtRNdiYrbWYHGdPf5jDVqsKcnDNuuUV7Z1g?=
 =?us-ascii?Q?EdX2/X9bKI4B4zvMaTUJ0l12KBSbHxQBH8I0+qbQwHnOr5rx7SgaEbevG45T?=
 =?us-ascii?Q?bhv7wZ+4ObtULKXBuEOzPmTqzHwH+O8BWMhvB8Duv5yRxOf71x2AaHAio/YC?=
 =?us-ascii?Q?PwGEcGjALXjPoZ3iVdyi4TRi8smKEcRt+QpoRs/tT2eTKRGnJETYVM/aEeUO?=
 =?us-ascii?Q?g59aicUgZejMTpHFrMWmsSHydIZLQzCLGWP8IkOLijZaT6WQv1N3GuTGyS6e?=
 =?us-ascii?Q?4QbWWOKMmfBy6/tlSJ2TCe4jDplpBAHmd3bwYQKpjF7hJ+4jyiES0FpVhJlc?=
 =?us-ascii?Q?wtAfRvBMry2COV8pl/Xw6QHZYQPXOwudFibKpnKMh8RSPtzzod6ySaTicWpv?=
 =?us-ascii?Q?I/ldLnTgdmnBgYMSLvG8eI6qbIhoqb4AzWO+OxLTXQokSwnVcl16tVqHaFSJ?=
 =?us-ascii?Q?k1jYbYhyPqajnDnMROiCLa68KPhvRGrHK2HG9vJILzNZ+nm3PV8x2gUVV/ba?=
 =?us-ascii?Q?ct+qpcGjZAHA5MKIT4dStE/Ltalf089+jwumbWP2Q+kCAexBwUelLfU3itR8?=
 =?us-ascii?Q?9BB5x5/cWpKEHMzeOrF3wSysY3wepzlBa71gr9l5Ut7/JNFq1gAsTx8nrE3z?=
 =?us-ascii?Q?8Zl4RpywTSuYiLKYkUasgKs76QNheXftEXqEUGyIvw08rxvOmke17na9/nYL?=
 =?us-ascii?Q?UrGolI7nxDJIVOolq137Y9KPI7kJJfxKiNTdXAuAZzjTMm7xAfkeSXgOnMUE?=
 =?us-ascii?Q?96YeboDNPS8f9ls7aGcPPVK6m1fxTRVGwAF8hIMFDH9DTG/I86VLcSHCarce?=
 =?us-ascii?Q?MGfCZJxoF2QmrI1OP64YwRnEYfafiWelLyrwuDPOE8EClQYP8sDpxMCWVVv1?=
 =?us-ascii?Q?0CpJffxSjIZn4neKt3fPChXWfA/y8VzxoxWfRNWm5DXjA5PYHhCtFLEY4mYg?=
 =?us-ascii?Q?yadJc05HvK8lrlzgxnv1G3rxkYSWsb4sLwfTUwWLx0kT71RzJ7KA9YnWzV77?=
 =?us-ascii?Q?Z9wu+tdW9gDvaSynE759q35CtWFD2VDq9mDiJHdOvUFLsp0Zo4rSHQQvJkTv?=
 =?us-ascii?Q?j+GROizJzC3VEyB8wQpIV9I6xotRHe0A0/OA+SYVmUsNtY633pr7F0C87/hk?=
 =?us-ascii?Q?Zq8CjI94UzUrKegtcybVhjuoMgQ3hYG3cUVOTMxpExbMyp7T6ixDDiZRqrJM?=
 =?us-ascii?Q?WRfZobnWKTNnH+pEDyLpyXcc6sAEOCoIkNKEOk9a/fiMKMf48k4XAfGTsZ2Q?=
 =?us-ascii?Q?IHOT1WhqjoVp/sfPkdM8zFNMimFf0CD4jk3eeKIXNKRdZsrUbc/6cBD3F6t/?=
 =?us-ascii?Q?JTXnwD3i0kebDmFqaC0IjQRFVNalZFAfN6Y5NMxAuPetpN9X7FFuclfM+cyM?=
 =?us-ascii?Q?mIgddoCKfAzfAz8UeCIhyRPoC+NJ2T2U3R9aQ7EHFjFupxyjbcrrDPLd7gSP?=
 =?us-ascii?Q?1C+FyTjh6KLfJnZp5BNRK1h+jMveyfc1MHi2wzaBOIyZ3Kpa+JymYSoV+A6s?=
X-MS-Exchange-AntiSpam-MessageData-1: vBGnt03pFRqQAOvWRnLAG86F2v5uBqsRQdY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443d333d-9527-4f23-bf03-08dedd28c6e9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:40:34.1246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOLm9tshJqjCI+pkRSN9Ct7J5AEWWtZJEoJ2z9hbMyET0OhI+Hw+6c0Lj3SUw5oLq46EcaPQGHJs150dGOATnKP2lapGydQtmRjyvtFUaYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6445

The wip/flo/v7.1-evl-rebase+riscv branch was a temporary branch
for integration of the riscv patches into 7.1.

Switch back to wip/evl-riscv which should generally hold the
current riscv patch set ontop of the latest next.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-4_latest.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-xenomai-4_latest.bb b/recipes-kernel/linux/linux-xenomai-4_latest.bb
index 48499ca..a542e80 100644
--- a/recipes-kernel/linux/linux-xenomai-4_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_latest.bb
@@ -34,7 +34,7 @@ GIT_BRANCH = "${@ \
     'v6.12.y-cip-evl-rebase' if is_kernel(d, '6.12') \
     else 'v6.18.y-evl-rebase' if is_kernel(d, '6.18') \
     else d.getVar('LATEST_KERNEL_BRANCH') }"
-GIT_BRANCH:riscv64 = "wip/flo/v7.1-evl-rebase+riscv"
+GIT_BRANCH:riscv64 = "wip/evl-riscv"
 
 SRC_URI += "git://gitlab.com/Xenomai/xenomai4/linux-evl.git;protocol=https;branch=${GIT_BRANCH}"
 SRCREV = "${AUTOREV}"
-- 
2.43.0

