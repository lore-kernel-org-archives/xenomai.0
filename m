Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010055.outbound.protection.outlook.com [52.101.69.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562AC3D2FEC
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081790; cv=fail; b=MvocxfrQ3OUTB2NSLpGAaOR1e8JtY7zyCU1zbv7daqqQDMQ7gw9PnKnWj0Woy56mtz+p6O6dHd1713dbf2pyy5SqIBRYqebcURw/FlGJmfYHAtwwYcSLTCL4o3wEri9JLjFI0h1znH9rATbjsuc38Z2hm32kL6c5qahNXQ2+cIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081790; c=relaxed/simple;
	bh=SUfJounz8L3U1hbnzAhqcIMU/PVLWAZxvS1l0+Oqy1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MKirpTR68aKY32TfyuDF7XRFU+9Yc9Y8AnMcSYg9z6rAMG8MCS+p72Jz4v2gbWXIfapW/vVsOZ7MLxTGVe4a8rRLbcwXtdmCG1xL1rBdXE8TDwVMSpmXJRODO+WYkzFFae+5gXTt/gQ4wTxe9nCnUF56B99yHBoFFiV2XbLuxH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uVo/8N5Q; arc=fail smtp.client-ip=52.101.69.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uVo/8N5Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJrj7eYh8eRB9uYCl6Nmug/uTA3VsnuTIA4HL3LQmsfarVeaoImrjoAebiQyB+G4JTKGnDwrHT2VNEw9IHyLe6Zdiy0bAPx6aE5RlvSxsWK8nsdEPOxbd2Zefo0BAWIYiNK3WJrAbA1DV5vaOpxyJD05lyaeCjlCbGVWKam4qkvIGN4jLVtCpp3i+FvA/7wujOXOxMf8A9iWyDa9fgQxDKJihu0M9YEoaq3EovdDDMxVnN+5pIrmpn6zGicf4D4dKqLnSETfbFVGkJTLgAyuW02w1YdVCP7WcjK7EuDLGcMPgnIuebKz3D5YWusywU/RDMX90X/CIJQx8uVuVUH1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGZq/rw5m7TA3+QZOUAGFzjC4resQPOuew5OZPwntkc=;
 b=aGGZFZPROMMIbVfGD7+0Fc4UGNlVVDSyIFDPr2kN+AgEo07q9NNyh4i/i0ILHcRV0T3yGKpQsOYm50vFC8ClPwyfoLN1VYTC39wsZm3FygWF7Y9x+d/ulqNTEcbqLbFb/m5qz/aSGs/59StrDFmfBwTMfTCubyqtJV8u6T0g/TPVsh887MEet5Vbjw10A5FUvNU9qu6A+QuqtgjlwEu9JgJQ9D7MsK7PFvB6ErMJEKu9b7nmbB9EhUby/k4xW/nRnAR8GwbTG0s9cZ0KGoKilvknA7b6zgxFxf0qC4S9VHQy+RJ/dzCMfLSe96m70CW5i0YXoZ1/QqVPphh+t5//rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGZq/rw5m7TA3+QZOUAGFzjC4resQPOuew5OZPwntkc=;
 b=uVo/8N5QncSz/KDmM1Z7HmVxKvpu9wT3N2NSX2ZqtAXm6oD/takXT9G+KyeFy+ErP8SwhVmGpreoAk42nnz21lKS7214zwrKACQpk2vulJN0Z6kJ0iKQyj5KQUqnadM1k/Cg0/nL3Oa9DJEgC5WiNcODJKzA5IbPMWQPsNVjJiUuLt6oQOi/rOWZtVHfjv9TcW9XI9hqIOPapoyYGsiYkZBz//10i8b+oakX34OSaJ3wBdazgY6qyWsodjW3l3fVPtDM9GC1499E3F8zaLDvf2iAg/PI/A0kgrV66sl4fflqolRVzgUTkIri+Gk/Ex+M+FsutgSDmYO2wfg4aBIBug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PR3PR10MB4093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 12:29:36 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 12:29:36 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH libevl 4/4] latmus: send setup messages to stdout instead of stderr
Date: Fri,  3 Jul 2026 14:29:24 +0200
Message-ID: <20260703122924.30212-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703122924.30212-1-tobias.schaffner@siemens.com>
References: <20260703122924.30212-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0313.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PR3PR10MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4c0cb8-870e-4ec1-3ccb-08ded8febe4f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|11063799006|56012099006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H4VA9AUhOY6yabXv+/IKY+hj51bPlyWPD17T8GNc8ShOAFZRwteEXQZt6jlRYjExLyBYJSDiyciIwsZMlz8MhUvS7eUuB/QMRbsS7HTlwpdXxpQTVybmOTwP1qgPiOkEhD4Ae/6NoMm2ITrQF5K12kKqbhkwPDpYZpX+2dA0/7BkHK05oRU6BKUwQORhja1LuprpBaxgh75ItweSb6XICpW0cWeEnOuEBFcHaFUlLIK90KPO6MShKqVvIaLadNkCT5+QZwO3leVMsawPuVmqhYk9XPegda0KUvU1OCqd6lq25mCwSeNoKLmbjVAVBWQkSKeTeW+qWQ+7okCPBbeoAqvCnXGxXy9uFECqpYpCG2kENDrGMsqVvx1tbSiLj7BKkxZAcHYxQF+mhVSTKVllrqLm1/bQkpTNuCXhyb9sHNrgn9GkfIhfXSr2jp5QCbGdaAXtTJ5tbofy1q7dmuBh9uzGniHrgERDc7IFXeaCdkpNUa5Pf8nM1DX+9SWu75/aJqlabX1IX5Hif8nO02+sPzmQc6FzfBz0JCqssfE8TVgNcy3iBKhjuytK2YmkVbAxzh2IN/A81UjnT4j2Sn0QYJM6b3M98utaBGlDZfBpOMqzDxdhZf1ty8TCwC+RMQZ3dRCRfy4K8kYOpUGJR78i3aV61uPzMUdgygZoXuhPcgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/kR0cAhDIdcfDP1ItOUMF1P2joKFaeP2ofPkzmA5EfM6DvXxeJpZ+N14frtK?=
 =?us-ascii?Q?bVb4PbEFTAmbFhQDw22Su00rBwy/br30JMKiKCs5QaL2shfAj0QruwlE28VN?=
 =?us-ascii?Q?2Gjy3IymRFsBGfPG2t9WSHTIM3dULSU0zs+KY9Uo0c/+6wpBXCTpISTT107C?=
 =?us-ascii?Q?omeiSTDJz73kJOqNQnmOr1SW5heWrmfB9aHii0LfG2cFfBL64Ql6b3wnJO9g?=
 =?us-ascii?Q?B39zH/WsrekGzbJuDV8YzA9j12okig2Lc3QrYToq3UMys/xQpdsA4GhzOlGr?=
 =?us-ascii?Q?aIWD6KbzYQB1YPOcBLTAR1xWxUSAd30lbrpdgOOpEHbBaGjC/Jtpoj3B3E1L?=
 =?us-ascii?Q?r+x14chiGLm+H/0zA1qZmAFVTcbL77zxuLuHe0AaGdMPQYldpfwwq1IUX4V2?=
 =?us-ascii?Q?8TrZhRc3pvcUcR7AFjhORcEaznN6WNMBIJQRrI8L+rTAZ1T3fvpsq2fs6R4s?=
 =?us-ascii?Q?yI92xtVJGfMR9ILMTiJ8ptr7HfKSGY2lOdQwkDlBgeaa6daeoEGVJHtOuzIz?=
 =?us-ascii?Q?xR+IbGD/apcm8s7Bo88BgDOUzu3hhULwnbYFQXeiIu6x4gTZKDTsJIYLO6fa?=
 =?us-ascii?Q?UzuO95rKYS+XM4Ipoibl9Ket0iVOx1Xi9nwA1lgLXYZVeyyNxf6gpdoHakRT?=
 =?us-ascii?Q?H9BT0FCxckTpT9C2ws+lNYV4sM3AwkZI39hcSSrd56K/BNFJ6Q5d2MaPCBTa?=
 =?us-ascii?Q?2VYluxjdVA88QLUvFP714Iw7USkYooL16aaAdI5o+94no+jGRP1GkQdaltSu?=
 =?us-ascii?Q?ifMEokD3kj2zm5AQHRg3uPEYePShGCb0hXnB/wGGK0+laKvdRfmraXC4+ck4?=
 =?us-ascii?Q?A3cbUyns0ngC0nY2FBzJ7pqYm1g7Sg2b62icA0JF0XInGB/LnBpiPxqcbpQW?=
 =?us-ascii?Q?CopBFhzPM6XLOX3cuXDtd3YEylqZhJzegwjKg8+wGU5p8I8Bs9aXv3wxI3u4?=
 =?us-ascii?Q?HU5+rEAd4HlBsdR92OIbYrzJvg1Kme/Wl6YFO8dapckPlEegSbNn6s0iT3zw?=
 =?us-ascii?Q?oYRUkKpl1gvH6TpIQoUsSwU1qSsga5jIA93Ljat6/PFnbSHxHZSaoypwQRUa?=
 =?us-ascii?Q?9qbgXvK6ZYL+9DQmK8fiqP/Qaox5PrnRmtxKY6bC3g+VK5CyKS40CdHiBN6J?=
 =?us-ascii?Q?pbXoxjyY78Gs1TIdvI2F8GS4yBvIRq9ugrPJIZXbTYnUP562QOHURro6elj1?=
 =?us-ascii?Q?eiY0i3SrwVPwq3vpugEVxq9l6202fvq63UPvbU0nT9+I1T8K5A2Aoyh7MEFX?=
 =?us-ascii?Q?STWb0f71R5qO4wGNgVfUsOSSCFon6hW74a7VugeQHnYxyd2sxoXgJqKfQoaM?=
 =?us-ascii?Q?2U5tqFLIsncHldD2bjW44trGNG6P223Hxy8HUylwUo0N4DktIjgL/ukLndJe?=
 =?us-ascii?Q?I4VIdqeP3+YS0psIo7O2jWIGBoG3Nyb+xcHESfNO2wq3awqTrjjsaezmAqeg?=
 =?us-ascii?Q?nLUaSvbnHTPFYiYhwKs3R5J6hsrH369Oqgtk9khJT+oaybs8R1NlsIYdIeto?=
 =?us-ascii?Q?+J3y6+faJVPhYCiHRDhL/zznUkNKj+dRAFwUOUia8A+H6J0aI3CNNpMnqOlJ?=
 =?us-ascii?Q?GAImlbA9FK1ZPRXx8UGcQZ/WNZ4EOa4IrpgoO0XfhWRvKUq3LISLa7x6KKoB?=
 =?us-ascii?Q?BWPfJ9yqTHJcetHs6cyH2yvGBLcloz4/rT0PteHrp9DiydbWRKVr6dUOTlMJ?=
 =?us-ascii?Q?lxAqlZqCesKLNDoH08ZGmp2oZmXWGwPIEqZYGnRsfquuHxaammOP5eUOcZ74?=
 =?us-ascii?Q?z/+eE8v8Ek0K8iim53ST5bzwj3zlTTKEFnEKer+mjtpFSMaEL/cxRoDJ62b9?=
X-MS-Exchange-AntiSpam-MessageData-1: ZGbgtX5rth5F1l5OW7Ksvacmjsx2J3mJjzU=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4c0cb8-870e-4ec1-3ccb-08ded8febe4f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:29:36.0971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mztKbD6f4B5Osm73W9bXLbFNO8KFFHtW7uwIwA7sUh2ZpfBfpP1JqRZqszrWOvz/7Ko3BWpjM6gkwJsatikSCDcdPOh+oVHk9raL39Ftr4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4093

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

