Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A324428
	for <xenomai@lists.linux.dev>; Tue,  9 Aug 2022 13:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYT5K2p8X/ajy1IJcSjcLbmpqZ3UglsgWdOdAeBsDR7VAjTvYkAh/c3+cbxY1CaYDKRwt9Ou3xit8XeIDlMnv7ymIv9WhvPepVWZ51GeJuWsQy6YCcH+XHBzWHjM/W99XGfss9SmG5hpTA2kYATHj2dUxUsrBsU15wQlRqeLUpmjloLn8PeyYrom0PRMBWgh/GmRgph/sL5S5X5sJC0BgbMQrzuWcJ7jr8MREt2g9mg6V0Lt7Mr11271l9VzsB9ZMMD7F+GCaItU2zlPZ9t64AKho/kPqXLz44VapTYvyjyJB85o7u48YKiYlbp6Kke16vNjbKFCmVgWqV09O3vfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWPncyhiLyJXTinqObllQpOk6UC0RJ8/IGPtMPx/TYs=;
 b=YMtOPaElPWD5nSkvd2vszw7nTZVq6EfIOOQcaxdRuWDWkeX4kH2Y2voWDUjmwLmLZaQ7Atefdkzp0e+mJZGxtEgUbwJSIuCM7YYecXaurihbiu30Rk+h/6nLUV8q1baWI1b9Hn8ZctUNa1IbOvaBvvVuBVwiuyUpXPEFEgGnDP7297y1gw5XWlL0WIWDWiV6IiY0YaknnVqW3mHd/sfDuYMNfWPo3NxFXPnllxSUP3cKk9ubJ/qnvby8k23JTWbSLDM2wgBg91wiI4KaSn+/qNeHufGfusgHGv1lp8hG/2IAhOK31Oyaa9WRvp8Rk254D7fTKEIaODRU0y3ihJXDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWPncyhiLyJXTinqObllQpOk6UC0RJ8/IGPtMPx/TYs=;
 b=l1dJXDc5xGM7cKld2WZtG0NEe6eyCqobBsa2ofb8OIPIbf0zhjH+gpkFnUa9n6ocEl/+b1+lUqGtdFGsUJgGaM0giwLM49tUcBHSdKNUFRc4wlFflvkCwyI71h9D8/A2jZqv9hdVI8YGLDPjQQ6b40NWb+676raq9YVwgU2sjTuy3Z+q3PMYkrRmwWzgNyOhoIUy5WQ1U/q8BCLdEv3j5RJvMCuVWsGuGZZQaHOgBxrTUZ774yq3wfw6AE7MAO2yEkD696HpTu68nFc7ddbphwgeK1684Cxxdw3mgLJIww9NCyJxfNud6IV0yZNNPalcIBU0N1C/LhA5BXywgzHG5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by DB9PR10MB5001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 13:44:02 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1194:7137:4cd9:2bbb%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 13:44:02 +0000
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH v1 14/42] lib/cobalt: Fix possible fd leak in __map_umm
Date: Tue,  9 Aug 2022 15:42:58 +0200
Message-Id: <20220809134326.23688-15-florian.bezdeka@siemens.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809134326.23688-1-florian.bezdeka@siemens.com>
References: <20220809134326.23688-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::13) To PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:248::14)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ae565d2-23c8-419f-9a50-08da7a0d3836
X-MS-TrafficTypeDiagnostic: DB9PR10MB5001:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CbqJX3Lz4dlEofEqHBgaPqkuv2M/K5R4jx1nIY+M2UejU0rT5CjOK0joI2WvTFdYBFwuyqITEM0VEiuceAt96HPqHRYwQwCQqOdCBay5KZX3ROP/yf6qSaKXWrOTcgSmq7mguUxt68juLeVI4xMaLqieJlbCzRoeKaIm5Wau9HDWWVl8d+C1mr3rkAtXWs28Gl6jQkPzxJaEPB+rs2lTacbtLkW/+658SG0lMWvHpuz9mEtxLqcEUyLjj0cfEnrGbH21HJ3S4W4OcTlMREZaSrfKMBE+gpikARZMeYdFK7XTjXu+sRcIu0Ie7nkRxcrcGBr5IXnOwEh9T+0rIt+PgO7pH3PYEYlTFWtXjn29WmFeQDHoKT9bRwE1C+Nqxra3Y5LvwBKtoMXDKCiucY2q3fcawDkh+CiR1bPaSCZCXju+yS5qBjTlUsCJF1+0l8d13CX5YsQoJT/ZgcZSmJJChZOHkfJ0jM8cJ0PKH6wJCPQKjY2K76smHFNQC7SaFI/NkKpincR93gKDY3YXxQh4gUVK9Inq/7g3deKCqfrusvcJjqYrEJvREp2NI6Oa2IZBPtIVU3yl/GDEpd6Eu6hp0+333zkkBLHz1N8TLldnGUl7fnKARrzI7NKjQL03OQhrrfEyDtg06x3JrFDOnDnytZoCKUtzEpHV9AyiQ6BBbvJaI2+L674KjzgqbCEAgkjS2fkI+IN77z/iSMLoch3V+eDF8kNtjY1iBlMeva54Ab4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(2906002)(4744005)(44832011)(6486002)(66946007)(4326008)(8936002)(66476007)(66556008)(5660300002)(38100700002)(82960400001)(55236004)(86362001)(1076003)(6666004)(6512007)(41300700001)(186003)(107886003)(26005)(6506007)(2616005)(6916009)(316002)(8676002)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+J1naQVZ0iUV+rft8ROuuc0mUchM79wh65vdq5UrMFB4ogYMHmNsdErAYdl?=
 =?us-ascii?Q?p0pNIjy/u4aqvSowwOnw8sTD+aYFHMDsnAsCIo4ntfg582bXMzuG1mxzPugW?=
 =?us-ascii?Q?Aoet13hiayMqQRZlYGGPRJfA/lu/Imp5KhBChTDyDddZhr9hbBk3y3JDyObr?=
 =?us-ascii?Q?g6J+39E0yviLs/4QOEM5eUz4Ly27w+gXoe+8c6fptCO72lBEbdgmK6iawWs3?=
 =?us-ascii?Q?ViyrVGfW8dTNJrkYD1AkOkk21YU35ksdE212S3YfKhd1avxZ/P1/i4u+LUoL?=
 =?us-ascii?Q?OoPlSwoxEJwNCPb5C/0DN5pe0bVAh8LUR1qw9h4hgHA9v0+XL980lvPv5L+p?=
 =?us-ascii?Q?huRYtvoyc15jDThj/ISAKSCJ004ZxWidrmOY25tHJL45Z8EjJBBFgn3t3uKe?=
 =?us-ascii?Q?JGxqyz0CExqL1qVymrnPx08lqtvCl0VRGCCJYwUI7ItcNtdpvvuviS2SvOMp?=
 =?us-ascii?Q?bH+vYsInY0YR56YrE+hSD6kWDwuqr0TrSoLVeG9X5z8EhJwwaqPUGlOzktF7?=
 =?us-ascii?Q?jeg7/VhhoTbf06BzUUCeRS+t1n4XG+Dwc9H4P3GVExRWSuVM5QdROvYLyRNh?=
 =?us-ascii?Q?QGkxMaFTVPoAMu6zOmHqL6fICx5kMB+Rh29RDFCFvGd4VQ/v/z8XgdPl3tYB?=
 =?us-ascii?Q?nyyR47KhNesN3zmGozcQWl4y9bgNUJfCeCkpdttclXpWZq7WDP1abN1izPRU?=
 =?us-ascii?Q?cgDMlts/wtQEf5EzRZC23vo90Cj+4yyjfF+gc8mL3ZtTQAOjvMCDEKlRSyrL?=
 =?us-ascii?Q?jP55YyyxhetHGMfOkeFIXpqN2NyGc4zdkg4aOiRj1eBVGe5TEP1K8czDxEDn?=
 =?us-ascii?Q?UhuAzrCN74B2TU6fDTCY5l9wu9VQZVCX4vBpWBIXXBGYQCsfhCG67XRkEW3L?=
 =?us-ascii?Q?DzZbqOSOryiCRHgoIqBdHr+DVL3uZm4Pe113J9sqD4bcOjHIBFo/erVqXyYt?=
 =?us-ascii?Q?dLpLYyG530nXWmVUT6Ms1m1sTQd9yrk3IS3Ncm7PKiHLxPsBxltlRbPGCrNl?=
 =?us-ascii?Q?gfa17SaxzNG0H9mKiIS26qB8ApFZUXyOGq+U2KSpAbQkmRgwyjRU9KHLLEhC?=
 =?us-ascii?Q?n7p2vgszG3+Z7u8dZOGGbXyMyTawsh58zrmLpSQLuknDNpDc6Tyr4W5DSUuy?=
 =?us-ascii?Q?PxjOg4SvWkaEO3muAPCSKdTmXPBdkgbcajMq5XkoPuMQv+4zPHAR7dlvn/fa?=
 =?us-ascii?Q?l+GfBh0RbyWa9B+XzdOzPQNrF35aZQ5pVv1R1GDZwyXkieuOzk2QbSyPPkkk?=
 =?us-ascii?Q?UUkjBVdw2jsZelr4D8a6Wk2t4LUAQAsxwEX+haQ1dtYD7bThBBPH+hralv6R?=
 =?us-ascii?Q?xVe2IU8zOZVirst5AX30NWg9xPOZHzSgoFfcQTwQZy04tJ/flpEE8nQdW0bl?=
 =?us-ascii?Q?n5zFP7IJ/akRgu36pFVoZympjPOR0WmxIL0JhbG/fKSSk+oAOsae4aKkpQ/s?=
 =?us-ascii?Q?VCqzXmHHLGncTwXyWEiDU3q6AZYn0vU3Zk1a88fp9cS757KJUVvI0b08wCdE?=
 =?us-ascii?Q?unbnlpR86bUs0ks8BaiZmAFxt6JFhdURy9abYE6CiI/DkJZgAhXI4oyrBw2q?=
 =?us-ascii?Q?JA9sbiV7eOzsOgLw984SAriFeWqFsQqf1zRLicv4CKbt57LPSOGG+Jr1x0Ys?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae565d2-23c8-419f-9a50-08da7a0d3836
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 13:44:02.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHdtlGVdxM53UFXSYIL2r70sSIsQQhDZgnsJndfWKZ9kA4/pogb7ilOzyUPefemHKDhkRTSeGPIqZq1O1CH+ztWXcA8umZJj5MpY4qKUk+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5001

In case the MEMDEV_RTIOC_STAT fails we have to close the file
descriptor.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/umm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/cobalt/umm.c b/lib/cobalt/umm.c
index 944620fee..c30ada6a2 100644
--- a/lib/cobalt/umm.c
+++ b/lib/cobalt/umm.c
@@ -59,6 +59,7 @@ static void *__map_umm(const char *name, uint32_t *size_r)
 
 	ret = __RT(ioctl(fd, MEMDEV_RTIOC_STAT, &statbuf));
 	if (ret) {
+		__RT(close(fd));
 		early_warning("failed getting status of %s: %s",
 			      name, strerror(errno));
 		return MAP_FAILED;
-- 
2.37.1

