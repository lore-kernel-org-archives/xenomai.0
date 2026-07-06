Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882C436BF1
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362588; cv=fail; b=obiZRp9rDD9J8oibr51UIAn+n/2puzPmFgchhgIdgfsYRqxLggAUZqW5YH45bHPVz+4aH2HnxBrI9WLGBrIYmB8J9SThCutXoEQaBvusQViq/1ujpwoXVmEy11rL3CFgoUsNOVrDXjQKcMvmsrpOs8Cnu1/3rbvhClEu9kC0Yz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362588; c=relaxed/simple;
	bh=6mQOCTGkqYoblTG2viJ2VgniBCF7SP1KX+1ZS08p8RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WiqsI22/YDueingDgQGXvCR6yIo18XpbdclV156a7Hqs32lDJH4yjt9Hip5tpkL+MKl3YjaWSiBzQIwVhqXV5mSuuvLkDqUJoWRAcMUflz3syVbzECADESw8pMfD7lr5o26axPWlAi3osfB/BL5OWm7uYlRU2p7KMKOk+VJJsDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=H95/G6in; arc=fail smtp.client-ip=52.101.72.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="H95/G6in"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abcMePWgKRVfSOCwnShcrAcm/Hsq1roV8gIFygizQ6tzd/hrsiY7Hfm5Rs0uaHRRGsv2Fu7nzXwrTVMOqprx/ekTQVSQtyDoG8+GtWBecZFVo75ETzqgxJgNKIT1IEPh1Qu2O0rFos6IxVQL49aka1G2T7IMeXcelH1UnVD8eJeM3YFYZxG/H7KZ+P/g4C8+pun4WdBAHpI984qfVbcRJCLb4fQGdGHElPAh2joq4R9w89N5v2vYQsPUne/Oy148aSlF0A/cPAUCG6Nj4o8QWD/5uTl8o+4sCYHFivEVT19yWFHOzKzLIX44NWdcRtpvSDq2hIeFKlD9aOl/1tEnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOTpuAIdFjyxxaWQGWatRjCPf9GF+srUHag5qrGm7hE=;
 b=bq0qsmp3bryo/2fbjKYx/RkzpGC+TvpEW/4ck9Ikz2lfwOu45Qe5GyI/1S4zdr8x/K392cVpuy0CGxDv7CzN9sUlzLKz2yViQqg+G80cuQFonlGeOfoagoaCnLkb+WyjTmAoYiFTUMHRe0iYP/5ZGZ4qBheCV+Ev/YQ1BUkNrAJbAF3sfBs3xCb2hU0c6uaUTDQTbBy6lnUBYBDx8KH0Qyo+pqKLWfNmDrEJFQTHxP1m1bzn8275JTyaKA68OTt6L5TFMNlmyMqAMhv+G+QYGPe7labdyNAB9iCSLFoKkOP3YKIpWwD+wFBT5LkMb+Ln4zfE1uX0qQ/+9twCmNCh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOTpuAIdFjyxxaWQGWatRjCPf9GF+srUHag5qrGm7hE=;
 b=H95/G6inAYSVS0M23z81ao/uBpgreO8Rv2Bp+yMVKNEVZIhA9DKWc/cKBZiBG45+q49FLV81Zl204WzQ/O4h6e0Xs2lsQj8zEDIA2LuJjk03rxsMFozn9iutsUnMtIxWRvjPaN75EwlXjszAR569pGuAs02XpnvYg3SAlqWU4QyBZfcYh0gdyiVBvYMRhHpnBLDidgtHmWhEK/kutjosjqnPRUKvXCahs4kXbZJeUZJxcSZUjM4PRffRkDFWCIng6N0Od52FigXPI3hleNyGQKnnIMbOjzy3AJQiahX6oDcOD8MxnIHa1G64lE8WhSq/VjpeCsVQWV6Jhf/y4dhOvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAVPR10MB7419.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 18:29:38 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 18:29:38 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v10 06/11] irqchip/irq-riscv-intc: enable pipelined interrupt control
Date: Mon,  6 Jul 2026 20:29:22 +0200
Message-ID: <20260706182927.281078-7-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182927.281078-1-tobias.schaffner@siemens.com>
References: <20260706182927.281078-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAVPR10MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: d8838be9-16f3-4094-affe-08dedb8c8988
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|23010399003|55112099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	04OGx3MF5z2uwfwGHjQM5adTEQuPW1PUy8UM6GkOtqaQ6pRNCfyOTvrt6SZlD5irDhjjmHL+eiEaNRUOoLmNvf92DXpkZlhqy2FqRX2UckghEmrm9Wy77PHwwMdCGgXzv5Zu4DLVRbm0S5ktyBaWR+yaCntSeikLEUhqftCkLmtsdjA2yHWuyiFNNM31MHbd2gN/Mjk/d/h4wFSZ5Q6eKdMMKnZtYUjlAbmmjIni596jsSmxTEtm6uPCeCh+sc+FCvqrKzG6965rWpCUAoU1mhWs3QcqMlU5jGf30iJAp+tvy1MTIXy3dzrddw3+S4E7T+eUUHdyQJbQmqDuYz6YMtTuyHcVbFL87oatZRWGqUUuhhfFskNCEoKDAQAqB7BW2KT3GpOP48mWPyfy+oFnBckiyIS49nq6RpPPfWSLHfDYj3nXYTlkuYJEdzmFoo4pQ9+OhODeExcyC/fsYf/Mqrs+MBzFS7H5gKZJJAvqVEt8ul1OIk6tKk2l6lSaEWwxBsS1Lg4wjZ6ECNlN03O+h2wk8FDbou+WOzc4Eu5lIDRRHt1ZIhnAVKLqEvcguKXsYlgIxRxdmcfAo6R1cV49uwEKNPcJdpQXwvCtvmZsBUeA9lsMy9/3OxOXzMAmOC0j38mYNP91GE9rwA8RGfQobn1qOGmyfZt/axWVz9NXnQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(23010399003)(55112099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tCzGMOGiVR8NXJx9gWDiOj2xEoD/3VSqEe5GMoKMeI99k8rDrxd01Tcjmw9T?=
 =?us-ascii?Q?OQzHI/VBBgeC0UUppSFHDgeutgVP0UWaR1fRw2xU+xK3+WKarKJ5gQXsJZnD?=
 =?us-ascii?Q?pkiFPcpUqQ6Vea/0r1AhPY/IfIRpftL4NGbDE9L8i1fjOZf92w2yrvuHCFYB?=
 =?us-ascii?Q?8QVmbNG3PnsNiXokbxkl5YNFUzyouaxDd0nOti4Mh2Tc5pv9xH4I6+ASXb69?=
 =?us-ascii?Q?/hIjS7DUSZKA59xPT4ZVpEt65GKZcgXpimTv017M8YGqdlP//caLxEQSwKjV?=
 =?us-ascii?Q?yUk+EW/DG033iKzgsMumnzGCUUP1awOmjHhE3PpHDt3r0ZtCcq/Jt+rdWbO7?=
 =?us-ascii?Q?sjNHRDtD66ec9CeDE8hGBh7xpH4rR1vikSsRqfOTXYjo2ezA69eipOl8RLWK?=
 =?us-ascii?Q?yX9hoJIN+MTgRRUND1Td7w9QvwF5FkDxgph8LTPd8GNFJrostJ+9CV2sz131?=
 =?us-ascii?Q?5kDJcKnHkN/elf0GInl33ZpaUAC5szQx3n/WlQVTnfOgv3hrjacmz+8I3i6l?=
 =?us-ascii?Q?Qp/3cr43smdVnlwn9YZht6s9rJWADtspiC+xz/QNQeRDlVT9OPxvvFqqm2Zt?=
 =?us-ascii?Q?hTWgi5ET4B9miGyAcjJI1aDDFT5Kmkjckqp8CYoTXJoSKwbLe2cGBDFpLP+A?=
 =?us-ascii?Q?jHlg6LXUiUxnD+/+X1BP7t5/jPdZ2FdlLrNkY4UvXnFvdy3tMMB2LY0KdF7i?=
 =?us-ascii?Q?jXEJGz5nnvgKuZB/YlV8GX4Rjv+cwnPP3DAKSixEDkmXMMPPupLe0AZ06bRW?=
 =?us-ascii?Q?twgx+sucSGpXgTkRCldnTRAldgDm3UgbfZBgl2l2ws4O51VUSpUixBtidexs?=
 =?us-ascii?Q?u51OGMeTQM6k09QmrrVOJEDvLWPk8PVyQi+wNA58c3dm/WGOgnMw/zqtHp4q?=
 =?us-ascii?Q?opTqiIkD3dXqr/A89n8rnRQwfi0EKHoWIQZQwnekiWvxzP1KgSelTqw8ftwd?=
 =?us-ascii?Q?B75sXkMJuyYr7H0/e4CwmDa0QEwIUzuhHcObNRprthD5ROtWFFvF9zQkJwcz?=
 =?us-ascii?Q?b6g24XOaBKUrVq9o/XAhDSBIbJOaa3rDvtAZtJpOr9JBXF/SBCNCE6tBbxNH?=
 =?us-ascii?Q?0r3KuN6i4Rtnm1uDWICbX3eGsV31CQKCpw+FFVRc+iluaCxoCAMm5BOVt3ja?=
 =?us-ascii?Q?trxenuKdsttqsaqHSNdVjeMy9fhFWZ2HP6ovX+GgGdStWPZdpVmAX08vHYfA?=
 =?us-ascii?Q?alIUU23KDSmZ83Hq5Z5jAFjf9vE+1uzLIypGbU3vRS8oLkOun+HThUxvlkuU?=
 =?us-ascii?Q?YcfIQQwj/cZT8W6pFMUecl9+nGICl1e77avdZlD8mT8p+0Pqz5HxaNzAKRsq?=
 =?us-ascii?Q?TLCVd6xYamectk9BuPZawhkeBgj63nAEx80WVJVLEW+23HsiCxsSFZMBYE62?=
 =?us-ascii?Q?qZi2BOTXmd1QMrQ7OiZXrBV24aA68s6+8CvAVo0/A9LtT7npuuKkSzz/yVin?=
 =?us-ascii?Q?XGKli8mX07KCSW9OoNKtBwFPRHPU2s4H1sbEKw8zR49fStQzZTb4wDdLgg1k?=
 =?us-ascii?Q?1f8dV0HYTpP+AJwP1pBJnFiScYh9Mg1z4aT7lsCWGzUPDWD0YDsa1F9ZNC91?=
 =?us-ascii?Q?EMBQIxkshWBDH9DjQYmv6OyDjmFBJ7LcH2hSz9BWoF9L2qU6k4mv8DG9qjB3?=
 =?us-ascii?Q?BLRrH8lYP2ZSMAIoWxxCSu+U08Fc4H/FwsDkkI7hU7tBZ8RlkQyIrPOGje+D?=
 =?us-ascii?Q?KlOhOL/F2TfSAdl5HesXlA1y5I+x47FYroD+QiC/8GhXEZ18Lk+zKe2WOSJn?=
 =?us-ascii?Q?Zi/ZJ89l8iHVke3gzVpLJQeQUj5foTVrlLrQrq0060oiFiWVwueAsqdypTXJ?=
X-MS-Exchange-AntiSpam-MessageData-1: sJV6g9+U1bzS81ucyYMPhXsHBopdGr0Bdrk=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8838be9-16f3-4094-affe-08dedb8c8988
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:29:38.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mi5IsozSpUUqN90I+DKGZd7TbyEp4uuP83/OmRzZHujHSty31FOnqXLNBjBqownjcDkUsc1GHrMhVe3sbmPSQ7uxDHwpHr3UIu9ElfceutE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7419

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 drivers/irqchip/irq-riscv-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 84418dbd5a27..855ce8dde27a 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -111,6 +111,7 @@ static struct irq_chip riscv_intc_chip = {
 	.irq_mask = riscv_intc_irq_mask,
 	.irq_unmask = riscv_intc_irq_unmask,
 	.irq_eoi = riscv_intc_irq_eoi,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static struct irq_chip andes_intc_chip = {
@@ -118,6 +119,7 @@ static struct irq_chip andes_intc_chip = {
 	.irq_mask	= andes_intc_irq_mask,
 	.irq_unmask	= andes_intc_irq_unmask,
 	.irq_eoi	= riscv_intc_irq_eoi,
+	.flags		= IRQCHIP_PIPELINE_SAFE,
 };
 
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
-- 
2.43.0

