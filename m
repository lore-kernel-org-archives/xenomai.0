Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012060.outbound.protection.outlook.com [52.101.66.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6179F347534
	for <xenomai@lists.linux.dev>; Fri, 20 Mar 2026 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041514; cv=fail; b=SK13gmbrqtA7B2wF88joCQ5UXeIZnjslXBDBgJocl6QDvfY6+wGRYPaWg8jlsdf2Syidqs3xrLgvSK1vJVTGMcUt/fcEjx0Ywhcw0lM8X42WNjz4ZCurWGm7xJDIpGdxkIWuu/vZAObMXY0Vq4Ex4cVQWWQlcsi8mYTR5x68mb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041514; c=relaxed/simple;
	bh=gVMxH140iOLj7b9ExDwVljq+n8Nt9dP3t2m7RLyhyMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=omafPVmuMB7/0vzIEToqiS2dhgUknkuNYYlKOYtudGoMdd9mBJxA/tByDXC5IoP0AT/bCQ4Rb2Y80PBF6AYIZcvUsyV0Eew85BrT00lEvRb0+cAbb1vqYGURyQgp3ptk5aZQQUzA0LSCemKvUIx3CQrEUeVokQYxn9p9SDj4gUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=VAab5MeT; arc=fail smtp.client-ip=52.101.66.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="VAab5MeT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEJ+xdJ2FZuqt8EfjDhDu5lltLLAEykpsuJHTZirb+agEXPM7FhSxMvLGkZLEHrMHMdxClXCqlurqWaDwjGv+YFRDmLzfTBiEUmBnt4Bc/Fo8R2tmTIVvHA4wUtvxOQ3+EkBmNdsGkvKZNXLeMCGDxCldzCnYy52HhwA61605MKHhNjmSsr5OqLCpbm2Imll1U+aE99rIFZDNMzbn9pbcLYikXJVldEAP3RRBRkN4JVptgChQa7Rdbj6JmU6286vX0B4Irhf+N9Iyxc82FHTk18lFirYocQlxl7oMU6wOye3o4cxWuQjjZZtYG0EnBNEF/K2XVWW0+Zf3hVEDpyG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BlEJAQQvzpAqnJOAYCYj4WxehLuT368ANlWe4Msoog=;
 b=w2Hl4ddupiCQ2QChnCtaiUjjNgIJLainRiDj3vut3JC/vumJDXgWsWO7NXZHWvKiPGcZ11sdTd78ljzQGzUkm3+gABQd0iguwoVYTsikgT+0T6yyPSTCJUn8exo5VIcE4I3TBVOnqKkNcEqiobG2FgUKWGiwC4F6Kz5ubYRJ3RF63UKPB03etiCoSP0TFtOaXxeMJmrAZEidMU9PSca8xOAAEPMwKuCDVqA5dj9nexvDwzJsTRWvxhfGjLPD1iQxv3I2x/nToaLt4ps9donQlZ+NrSLKNgj9rtsQQs17MU7VZRJ6snYfiVY7+i5FH0Ld/OPIrpP7k0DF06ZOb0k0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BlEJAQQvzpAqnJOAYCYj4WxehLuT368ANlWe4Msoog=;
 b=VAab5MeTodkWYWna6GuD9Z6Xk9eMdClwiDLQPIpkzg7GUujwVA+W5xLuKI1sHug24XyjD5IwJiwp5Kq8k169WSxojE7mhLtG+wOjphUd6CTdERMT2q+KiJPhKDtWiU1fo9jf/QecW8meND1IeU90HS4lJcVSSfN0EsRH9DIlUPLCg5aRfkeJDbV9c8myBdsRw/j76YhdryJUIssojx0Lz9C3QPEQQ53bsuZCjrfI43aO5dmWNkiYlqFr4ugEtBrUzrlO3y8x+HYizzzvuRS4Zsd4RGmzwI91Cvt5f45FB70FS7x7Y4ZU1rXvWelvk3rfflXprRNE+52kg8IonXrxkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB7432.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 21:18:30 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 21:18:30 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH linux-evl] evl/latmus: handle ERESTARTSYS from evl_wait_flag()
Date: Fri, 20 Mar 2026 22:18:22 +0100
Message-ID: <20260320211822.2151049-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f386ec-31cd-41b8-d183-08de86c63c0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GZbgRB60AFEhtkPueeM5E3xrEzOmCvCdO1F+pk2fI0CdnkwiVELMQxkcNn8P4rIQnU9UhURk2Pj0oIPl5Nlt1Gu9pOrA2JqrN/WnaTUy5lxBF2qL33XuI6qAFwBbA6rwD848CeAY1d4tPgJW+ijneRroGa9KrHv+PCpySr5MLJ+hVAKwtHwYHRdX17fVwGTUQr5oT8WkHpXI+oaSoAaFzUKUpJX94x13+8wn7D0nya5C36GLoNyf08rEdE9BPU4BmYobNPOPRJtlqZUTnS0fWt5NHmy0EctM1TucSoPlYMzRIdwCRbTbcZGVgSgkQLmnGjcZPk3OCU6HsuyyWam4e9oEoIJdJorwxTvSfE4XH4n8XvrdGs0NFK6nDuS88uWHM/Z/dxZC7/YuGRTbledUyWDdKu0T/pAi4GWI+YxdITp//IoUoz5i3ja8WKnNkDVgJJjtciA1ZKgnoR5XY4Q8OVSe+KYZtaOB1v4oM3mJMOlJEJqOL7e6mDSV+qW7oDfGvQB3Ie3xZpQ3l0ct6JpuWKqpSbo3lymkA1lUXXcbqabnq/jKJ23+nVWbGW5oaoEiXPCYhVQOFisRqt5KA0Mt4zBcVKoC47Apke6uPDtq8t2dUMGL5oilQhJhBiLMtmszMS/rinj6ajLaqXaSC+HEwD9TlYTWRMf6TyHx6F92ruCNo6cQ9j2RL+b6Evg+q8VXLNigg9oc5DPWCnTwO/TqmikPKf0X0h16Bl8lexkeipo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jD6lbyaQp1eJaqiNNrP38akP5liE2GFerM7Y5375QvTNgrHKr/qfHwEjbfK0?=
 =?us-ascii?Q?sw8UTFScag/DuVR4GnznjLe2OEgibnDpVtlzsDhtsZTN7CP7wIrgvUgQku3F?=
 =?us-ascii?Q?0w+lJuvMY8By/lNpr0GgBpJR8zsesFhzBjMyotjyzGnPivdUIUyT0yfgNSX1?=
 =?us-ascii?Q?iEhHC1t/lSW8bYoO6tjQzo5rkven0sbtHz2xFPq7V54Ysd6W2pt2ffZGhCoz?=
 =?us-ascii?Q?oBhIYMpCdKbH/9SwZLhGmPnupj6NYGeoj5q0GyUQwBWrmn4BxFgrOdiLvEUr?=
 =?us-ascii?Q?hq8njIam2JWPahnmKaY6Vl9FyjFSYsMD1TmjCD5mPjpFguLEv5bQCMomJOD5?=
 =?us-ascii?Q?hO7oFcj0FNSLWsBZTP5BGcqKrsoJ8NpQQK3vQnFFEMuQa03i2XNEhRhdI9ss?=
 =?us-ascii?Q?KllOiqSwqPgpuabIyzBvqhGsaU6TuvinJgVI7RfJ5ExvxHSINAiV81xH3T8/?=
 =?us-ascii?Q?g8b4BvZeuVQA7cVO6+nDzyZQVNJqDy2ho//J1pPpHDl7RVjzfCqdjW62EWnn?=
 =?us-ascii?Q?DgIBWg7vIYWLbYGtgiRPZCK91XBmbAZ7+t2d9oahCfuIkR3ws15+s0yUWkn/?=
 =?us-ascii?Q?M3tr7em0k9giIzM4LLTHI78MAIeF+z5bJ6jb9//4xGheZRjeBWSREUcmz2J1?=
 =?us-ascii?Q?/douEnO63JI2XAgVksQthKCRc3CBao3rhJjk2Lp2x6UdZqREjKKevWqb7qvz?=
 =?us-ascii?Q?bnP9oizKT8vF+ByiBWL/tUFJ6TDpKicV5FyhlgxygXx6p8fATICN9SRZfS6c?=
 =?us-ascii?Q?8vDFon7jJunxxhTci4bcvLl1c/HG7i0R0turxgyjSphKo/VkwZFxmHSvNswZ?=
 =?us-ascii?Q?CaAVuJUgBTooGc3wnRUHjstFaqDxVgRVhmZMPIghutq5LXnYroosf3+2Jm3+?=
 =?us-ascii?Q?BwRZ0mUl0Q+MoCbGtV+8/GSBbk1ZdDE615bdggfS0my0BKD0zB0Siys2GzeN?=
 =?us-ascii?Q?TbOIFDQylggEct2wxROibg1REw3LlxsxScYz1FxYQ7fn2zKbSObIUYTKQ+hP?=
 =?us-ascii?Q?G+ynxTlaxMZjTM3XuJoeQUdOyQJdwZ9ykG/YqLIydUaemZAEllYKyvKcOut0?=
 =?us-ascii?Q?GR3VHtY/eSuyFOC0dONeCwdUx4TeHgmreMqOLepSpa9YLfaPiAU7MoZFbNUu?=
 =?us-ascii?Q?KlmxbrLVpNSONaKmYCgkkeeVXAV9lbBToQSCmSJlHD/9VRtMTFhrjXGR7qDo?=
 =?us-ascii?Q?Ordub+YYHOZyIWJIUYvcTnzKFMr0IIENxiZg29h9D9ZYp0unfBVQBgKOUQ4A?=
 =?us-ascii?Q?+qVbIDrMklCx8VzRSn67i1tin1PTgNhQMLyuk7tVymQhXi87S1LLGGI/MIdH?=
 =?us-ascii?Q?lqFZPnCywMFGwYIAmBoE8i0Nvd3QEMzPk/pKy56uVN3UjS70v/mMgCyFRoB3?=
 =?us-ascii?Q?s6d779qvSwrP9BDzKe03dPZcCTQlStg3M+G4M4oAJ3oeCNBIiHtBOeeN15om?=
 =?us-ascii?Q?ceuCulD0+oH0qWM7TDWyVndKPKqlNFUUPqY6FWGJu6glmn1JIMuwq1CZZt3E?=
 =?us-ascii?Q?/TDtTOcx+rOXETywZOpVu6ous51UwOLHxMxy7eRU4WGFdKzCztGD9XPZtBcv?=
 =?us-ascii?Q?9nVnGMLc27BWRgGGsQ3uajTrLO8mjOVQ7up1M8Cq8U31YkK0ZHesdzmvcDky?=
 =?us-ascii?Q?3XMaRZpBA4hE5LcdV11q7XqmmNFnMVrbg27KrarJ8bX6bmbO8OZ6RAS69SNi?=
 =?us-ascii?Q?HavVirP0arTr1Emp2c35CyBZoZSJbm+lq8WVlHtJRl7Kv2UgUFAWAGDxuCpD?=
 =?us-ascii?Q?aMm8un+iibzr8gLOoJ3OF2oMdO5VhJg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f386ec-31cd-41b8-d183-08de86c63c0a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 21:18:30.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiMLLPxfcfwYBrgBkPWdVlW3+mjklZsyqOIEVG8Ez0hdzsLVnw9TBeI4LkdAeGqk4APDbQOFZU5pGUc1LrNCCXhsUi/rD2KrJMW4mxxG9sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7432

evl_sleep_schedule() returns -ERESTARTSYS when an EVL thread is kicked
due to a pending Linux signal (e.g. SIGALRM from the -T timeout).
run_measurement() only checked for -EINTR, causing the histogram data
to be discarded instead of copied to userspace on timed runs.

Fixes: 6f1edfe3b73e ("evl/syscall: fix restartable syscall handling")

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/evl/latmus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/evl/latmus.c b/drivers/evl/latmus.c
index 0303e21d066b..9a0295044443 100644
--- a/drivers/evl/latmus.c
+++ b/drivers/evl/latmus.c
@@ -970,7 +970,7 @@ static int run_measurement(struct latmus_runner *runner,
 		return -EFAULT;
 
 	ret = measure_continously(runner);
-	if (ret != -EINTR)
+	if (ret != -EINTR && ret != -ERESTARTSYS)
 		return ret;
 
 	/*
-- 
2.43.0

