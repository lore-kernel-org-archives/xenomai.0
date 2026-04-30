Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF773DE43D
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547477; cv=fail; b=UfpiYovVDko8b418i0tQu26Hlz5GYG17TzbyfsE/ox7ung24In5wkEe+PJGeu183bEvY9RFxIYa8th1u9ZZiwZZxH3/skXBhgc3ksFA+ghqv017ScDVv3f0WAoRC+PFPdsnMqIJliwhca+iUhpb0ZyXJslMcX6RzykTKOGxqq+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547477; c=relaxed/simple;
	bh=GXX+/aS0imoeP3UyEBL0c15Lp+eccu/SlotuSxBeu2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwvtIp9T9Fzgn4dMrldsuapaoh99Fvt49fy83+U4dyf+ubCNcf8LxpWoOqtSZH/pS1gIVmDpSisRd1uJqRgPVw64lLaFJpUfIPX+NIfN2QjGJCJSEAovsu4N2STHupMZs3R9R1CSwFY4D9Q1H0/a8P1V8s+/rXVErdXs8E7U+cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kcfeJ4hE; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kcfeJ4hE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8VddS1QYjpdOOfTN14X2mGSbYkaV+DzONVA1Jy8DLJuKVTBrsa5HikxYkkoyq5zk1QfaZflbUxzGICLxidv4/5fqaKe1qlkwexkyjojcIWuxmBPMa+J57tOMcR9uF6FCc8wXsI+tSUXMEsVYDE5zEvr5s71hVSuTlm15F8yv6NyVjezt0srbDlehJLvAYFbJ0z7G0ihPx5u0PZWopTFixfuyD08y/do0gZvRYWmxDBhnSB1gQQCBhMLuX2gipwl4BDmEyEbAv7XEdZHaPwYEngkfykdqQs4aw5/wvh7S23gj/lS8BeKNDPvdP+oDg54RjD5HjewKF3jXpUQYm1uXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6b4yphSNkR/eTJer715BWvwyMeuuFbZS9qG9XMaQH0=;
 b=iikoZL2ewF9A1HcnIWnqZuyVKeHKsZyqK+OU7ttFbz9oLVBRFMrIwVJwQ/PXFigasuMNBJI1rb2bA2LhPxhzrem49FhbvtQTowPKelERK0C1tt3hJxAed9n2007PGmv+FEM8x95OC7fl74iLGS+iwjvb+01zpENg+emCf/0yexYv7pb0KWc//vprLo30NfUh3L98O2JWd3YNcxdlJqzgy+IdmkkI9ptN2Y2O/qN9bIfqxJPsY9IuaHOaajOF5lRzu+5Dd4/6BWgX1E9oTnNVlgo4wKayXVlTZT9uNI/cybw62QbxSpNhjDaGHl5aOQkeV+53/huX0/2etHbWLdjpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6b4yphSNkR/eTJer715BWvwyMeuuFbZS9qG9XMaQH0=;
 b=kcfeJ4hEbVnpha8N0xNB2yKDSOLr0MgMzCUirbPke/PUkGzSkJA8gmFQCmN/upQR5++lAyzUQGnoODSvWsJAA9tmfuxO//tlCdx2GP/c1Rqza9kgPxIbzWJq45myKUiY/X1HHM+PFSik5+riMh5OKma2kdFR+LerVYbCgE9wLyrLI6Kdzs/tTK5omEragmp4QHNKmt0r0pSer+vXM9aF9OAioaqIKLE4O4M0yYBHHWSL/3dAcTWdEgEBfzQKghDstkdYbmBAsqr4PjDU0Pa3QQ5JK5j8/9tbqBnE3QMQft9laPkrIBEz0vBE3pqgUbzv770gpU+sAv35sG8W7MavVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by FRZPR10MB9890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:11:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 03/11] irqchip/riscv-aplic-direct: enable pipelined interrupt control
Date: Thu, 30 Apr 2026 13:10:53 +0200
Message-ID: <20260430111101.1539377-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
References: <20260430111101.1539377-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|FRZPR10MB9890:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c203dc-24f5-4346-374a-08dea6a92f2d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	5LwuX6vam0yVhK7IRarpsh5ZWWW+2DuQ0BfHnEEPBzJGw/Osa36S1+z8MowocnCE+WRtZKwwMDO+r7YLX6eWTiWOVfu7tWnh8M0geIA4RvoBxo2eWO2fCrpleDhtTWp2LdRBi3Z6/zpazGW4fPVY7EZ2ECCGgXUIUx4biexXWKV7GtVG6bg2SpCC1Qe/oA+oSCrPAKK7rOrkJ3psk/A5oHb0QSGOqPjiSSB4s8SBZR7dQ+3c9qqJjd1I7rHYhVK3m4pY+2+wxE67lkfBqqmkqDA6Yux/uHHS96FIXJw0ZRTzbrep6hjmB79ZNwkgswzFLdLywX+0E7ejkUb6AatRbnEqgsfOUlpSod//GR1yYnwPiR2zYTjgyx9yZ4tiyw6sLJTYD5OeOLaqy+sCKB6CGSajkgZqAtVp+YzFvDwpanj6/5wPiEeiLSzTtNYRblWx3m6lf+7+RjXDQAWBslIDWCHmtIJ73dEQKRdPkfrq/gbGj387DW4gv3QHA7IXn9fOaG7lRughsXH/ijdYg1jXew3B1inyLOqbC2uF541XX11OQEkyjp3fXE2TPjyr9bds1FQabdEhD1IeqWgATr90/F5BSKYVadJbvLvd1clzAa+iXuPDfgTwHrMN80I80BeQPXVY/R7v9alwHZHca8d0mHA1QvbI8/wVXDrmro6nIQqm3K0LYqcFCoyddV7ykUs3ATlgSbY4P4Kppec/EifMncGLrnFXDfMGctePg7hie0c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ZKur0gv49az2rxlgoLf8bmpnu0fz9J6K0OzyXpzr8la2kcu9zzebZKIrSVD?=
 =?us-ascii?Q?8tH2qoUYgQhbRCTPOM2SM8AGQ5xOjaHrrATgBw1fQgNYnD6RdnGuvTgRjQQO?=
 =?us-ascii?Q?90iGq4y+T5La2pJiNw8+Os0tZy1AtSm0MPEoOZVysNksg5bEmYD0msQfH3Kg?=
 =?us-ascii?Q?GjGtXcPoUxU0UZQ8Kbqck2WSQzIemMSQur+7YUGUOrHwynpcSM40ECoWxHD2?=
 =?us-ascii?Q?wjvDRB5XmGcBwpjPu1NYX6KqvoURGAJWx+HcKQ84xo2GWLVDwW0hQ3Yiii6o?=
 =?us-ascii?Q?YfxV9znZc/xathJVhWaLSKS4xnr8/XmFsJcgiMINVsxmJYTEdLdDQutmQUC3?=
 =?us-ascii?Q?/QAsCsPrTD3rp8UCq9UE/KrNzutYyeZ4jw98dVSIENFL2XWUhMZ6BtxzmntG?=
 =?us-ascii?Q?hfQRcbIQDCYjRv7oIf9FeL19mimiacW4MRyQB1aALU7GbDgDrTyHXTSqZqHk?=
 =?us-ascii?Q?9QEEirTgudxX87dcOjKBCdOgHsC8TWjhrwl8RHJuiId/h/unjbG93IK5LZsQ?=
 =?us-ascii?Q?OJk/VwC8sjMBlXgrQUZdQXFt29vYCkHslm+Yq9UhPeZnr5NmABNsQL/scbbx?=
 =?us-ascii?Q?W8tk5fSVdezXlbmUCu+Kxgz/kqNjmTa36RIGLDx6vSMMIbH+AnUoESXwn2AP?=
 =?us-ascii?Q?R1A1qnSUXuQCFg1NHr6ykZiNY4ooDu6I10pykW+NMhoTfA8AMeB4UbzWPyqK?=
 =?us-ascii?Q?CROMMoQd/oC9zs9uhS7D7XO6yVDOuTJxs5XsVs5eu0VqltShPPzCKiKkeIDG?=
 =?us-ascii?Q?PX9wdbZUWygJS3KywkZAvgQRvjHvr3QmTPtjvsxvrQKaAItptcY+Y0zdGmlk?=
 =?us-ascii?Q?UdbkbeXNw2vikMw2VgOp+wNfB2VEaDDYaOVZ8pz4zCTlbq/i0BsrwR6yxTci?=
 =?us-ascii?Q?+pYCJNLIsmJD/qOJf0AuEpyvSPEFK+dL1iS+mxFXDnnNx8dVTbOcUCXtN/gS?=
 =?us-ascii?Q?C/8gpGQt33b17lD3y3jQTDnYyi+1+rnfSa1GwpjNq8rtCM2gOXqJqBLmNQqf?=
 =?us-ascii?Q?VgKnULoOsXPf4AvSricw+7cMBakm3yd15G8X8KeqDYU6Lk0bAZuBgxlRSTFZ?=
 =?us-ascii?Q?asQO6+4HyCdVDb776O6PmPSypajUqoZLyBrrZ9Lww2o0pKb3gbp+bWlBmnqG?=
 =?us-ascii?Q?7qGwRZbjqczPSChPmrsGhVWKO6EwJEVBoDKBDqO3HW4fNGXj3CuECu1t8eqh?=
 =?us-ascii?Q?DcTkY2AQoFPXZQVN8j915jLxjnCsGJeP43+lmca3b/4PEy7axFRkkeku7/kQ?=
 =?us-ascii?Q?kmTHVHGc24fJJoyG4Ef5IeTHX0CNSNOenJXzYgFX7xNf/NIz4+YIf8HHwjN2?=
 =?us-ascii?Q?ZlbUR8b2TNOkO/nelIbASOO7UnROfsq8s7eSzwOcKWJgOLmA3oVDD5loYdHU?=
 =?us-ascii?Q?DJqckLCHxpyPjjMphbnpaa/HBnMxgZIBd8xYkSApaufHe6QdGKPLPKRySz+i?=
 =?us-ascii?Q?RdkYmRlZcUIVdwmcWMXwqsK0Qy4APo8naXHmqIYG6yrKwKxWVHyvqPflxIbW?=
 =?us-ascii?Q?Je/VMWZU23O2F1CkhZMPgGe6dHRpQ9yWzGN2vCzBeEn2LkBWKu3Ur1h0aMMo?=
 =?us-ascii?Q?Pkoa+qgXC2ipixd2iy7M9VSFBXvlFr/jPRBUwo+cThNjxukSzrxwXSviDuwP?=
 =?us-ascii?Q?tSRY6fWJGKkwB4gqNisdBDnq/iZJvapW/Lt3YnQ0gKzUUy8/YnNyi1Ow41Tb?=
 =?us-ascii?Q?I6s/EOj8dhcjbnoYnCRF/TNQs2PBs6GgUvtCKpRGI5QiqXYrPciNCDJqLCw6?=
 =?us-ascii?Q?Ri1pzwNAQtM80W/VK2K2wt7EubnpjNs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c203dc-24f5-4346-374a-08dea6a92f2d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:10.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yio1BfPXR7+smgGyqZm4iCV5xJ4JPk+jjCSgjiOa95Mrf8xnIZ2+CXmuDkytVqYufcBJtGzaiLFbxyUZV4XiEYWCU14DSwoZd4rCVOJn4Gg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9890

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-aplic-direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 5a9650225dd80..b5d7205e10552 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -89,7 +89,8 @@ static struct irq_chip aplic_direct_chip = {
 #endif
 	.flags		= IRQCHIP_SET_TYPE_MASKED |
 			  IRQCHIP_SKIP_SET_WAKE |
-			  IRQCHIP_MASK_ON_SUSPEND,
+			  IRQCHIP_MASK_ON_SUSPEND |
+			  IRQCHIP_PIPELINE_SAFE,
 };
 
 static int aplic_direct_irqdomain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
-- 
2.43.0

