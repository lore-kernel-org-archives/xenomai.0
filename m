Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011065.outbound.protection.outlook.com [52.101.65.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082A313543
	for <xenomai@lists.linux.dev>; Sun, 31 May 2026 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780206805; cv=fail; b=H1yX13iqZaNUfEyC7+mFNDeQ04W/Xn7gpNthiIwqsJ7IYmhiycjHDx8cHSmHE4Oxyr9Z/yTt1J/M0+jTyGAvKw7QkgGmiCQDQ2k2Qs0vRA4mjtkWTrabSLVCN8I+7jCzgtshr4ilCEkDSdVJO4e94YI6nzn5UmTLJPHQjtZqrUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780206805; c=relaxed/simple;
	bh=LgduWSsYxzm9yWIzp92uq9Yyf2wuC04qhjFPZr0uHmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3LPrGRn0DWN5Zm20B+pQIu9axWEF5Y4yotUX3MQn5kOC/0YekYzoZUfNmZOhjjijT9Y16h2OOGfH0o5eLFGPxrIlhagOU3A98ivHwY4ILbBhTo1SfYk+Dn11pNivL6dmYY3JMkIRIXFmXiLXThz1FTuDzSUFc5kAV7xBgLiWoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=o+C9zla2; arc=fail smtp.client-ip=52.101.65.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="o+C9zla2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZ7f+JK/yrrMAuC4PGCMWPF/G4Xak17fEY/a9B/h6vZw1/D5dvW7jPGNeCkBRvxscdr0AMkg9/53oAf4EINTVIcJAy3IT2l4uQ3GFTqdMx8eoXfQgndE16O3Mz7pKgbVk6GqG3ZA18ojV0Anq5khFHqyuA3k9ENS4iO9uxK8z3AmuKZOPDO2iGmyaoGFNgguHhvp8Tdb4b+msw9mCe5Qj/CLgZhlABoZj2naa180t+2yxJ+YqvmueOAJXdSLxoRTjnCoYQzgpd7JcfSMBBHSgyhMxU18K096jTWQFpd5QimoIYlUCOs/EI70mJhtOu1v7aNlNF72lNhOwdX3EKarng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlZGenQp2DOsDhLfM1Nvxc1dTvHotvKJaVnXJvPTqZc=;
 b=wOocjrHfP9mQU+lkZXkxA247v3kvZNOPDtE6ESOYPrZzqyz817ZLyplTa7rMZk+AfOepilT7qUP+Y+Cv0lKhDdRzgLNBlWDU4QI7ERb2NjShjtuG5rvLzOImhYnf8UAcB52ExuBDVQwsEKumg2hO42UtbYnvwCutgIBNAwl2++w82OJMLA6U7xkSPpSaKy4mUYLTIs0riMds6C/ZZOwv1eOzH2d23bWUREfQS8qUIaG0XI2sduzX8pmXXKYSansFXUW8PllOdUoytEIXJEaGcLJOh7N15y5umwuiGx/Wx8aZUTGx6TehqVte3I87h9E1k1SyvY4GJ4GFhvEvGAbV1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlZGenQp2DOsDhLfM1Nvxc1dTvHotvKJaVnXJvPTqZc=;
 b=o+C9zla2gJSsjjE3/NC66oCNcD3hC5CehWAJvTQ33frlQzzO5LzYe/vzvgSZNWJKGsgTcGPibdqvhdpz9P9VC4DNp9rf/vfC84OL6jMNNbFaf/cUNGHgOQ2t18O5wIWSxb1CTYDyCORKf0/5FS6evyPcsGttY0ADQHYfBikP/1m1NV4IW266T0VeiN6ECZoOs/WtSZUWBv8XFGSohzzzF77uVzKPUSYcR3sPBAYRX8Im+ev0vzM7sdCeFomgTqmOyUdns7rVyx0m+D/oxXHeovFt0ZyyQR34f0D6Y1eBO+1zUmQ9xMydfwpq3asb/bR/ZnJL70DXnWH6seGG/USLtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7127.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 05:53:17 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0071.010; Sun, 31 May 2026
 05:53:16 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v8 10/11] PCI: plda: irq_pipeline: enable pipelined interrupt control
Date: Sun, 31 May 2026 07:53:03 +0200
Message-ID: <20260531055304.2890455-11-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: a12a5614-4625-4bd2-09a9-08debed8e92f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info:
	SY/a/TYhiLlJWsKywRVT5O/Mz2IxXZV5cg3uFie2vmNpcsMJvklitTY/zOL/A1GJixFUC+uz7cF9nIJzt03a4iDO9WZ8n0aOczhg1ruJxRizHO573AYABXDU37WF7ECoPNT3nV7oGj2bGbxs8Kx3wF2O5XO+xrV8glD9p+FQD04kTt5Hw0XB9RjwW0zqxS4AcT+ENj6JTx3tl/S/bQfPiC9XFdO50HgoSnjGR6ryFUhVS5luRRdrN1+CX1O6sCiegUkGxPjsqNLh1ce8p1yS2Wp9/6FpPN2k+Ww9TBCXXcrH6skT5gKMw0XOwwr0cKLFi97imh9gWARzcTlDPw1FK7mV4j3ML9PjmNqwD5YrPQCD51/IKCbc+EQiYf1xW2qmTn4dIOO6SfZcODxU7VUxGCvReLHZVN6RTgPYOSmV8MwyXSgV8JmGNlebfKsUEXu+p6Vm6p9P6U8quZ9f2tpD+dqnETasp4JWPZlpydVV+L8Didv6lR45GHz/BYS1qGFGIjdEDm93o5xUbG9SQGfVu4CLuzHCCjXdcWVfHGrmnWSeFFJ7fIaGWg5PdKDPRJ7ljefOurqJCM4MZ6kT+9E1eljMLe7FKwf4eaSqKkZY+Hbz1X5ZdNg1scXrPCKEHRJR94i7yXzxln5CIa5oD4e1oUnqPDhfBPZx4J7K0b337a6iwdfyVoGv7upc1r6KD43W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zHWq+7GLkq6Ae7NJs+wowgNyJXMf9hIYCpBiXUM/KfWIg6gG4mxJJcQQQIkw?=
 =?us-ascii?Q?GxtS0Az9cN+osUJB3kArqF0H8bTpd5uo8HAGlJpHgVlWtkUKPK2E4j55C+KS?=
 =?us-ascii?Q?12vvD6dxEALtD+42l/zFsG+CQtUEkbOjLlfIQwBvMQFh6zxQghxBJQNFN7GX?=
 =?us-ascii?Q?VuGD5+5s16loEm3br2Y9j7WOEl4Bq+i8+A09T9Rip8sszvkLcPZKCIpH2fRH?=
 =?us-ascii?Q?fPXl3+KxLad6xKvfdbXPfyr9bdBF4O42Zy4JJABCcVbLahrJMf+DsyA15ggr?=
 =?us-ascii?Q?+x+jnQUNHWlZiv4F+5nbqA+KOupDEpbIrnUJtfDHwGBw40OXLhJJIhr5bJFH?=
 =?us-ascii?Q?FdXpV0HlW20jNVQWlVDym7rtv+BKYmCUEJFfa6bBdP+wmhOl40Uw1RT3GpxS?=
 =?us-ascii?Q?qeZra/yodNhu5tc0lpU3IUqhh1+jXmOk73cxBlgTaQ2lnGCsfSedtlaCGgx1?=
 =?us-ascii?Q?1PiH3w1cT3aaPw1V88W6QpU2qWk3XRNEnvDq3CJ32x/jeIcxDYOdSeNKe5ek?=
 =?us-ascii?Q?Kw8tVX5jsM44476QBIYFdyCghSZIeVctICg5Kk2Yzgu1Py9lB+SZdX/0+1Zi?=
 =?us-ascii?Q?yyEdmOeJShobPdZzIkc1H/zgJfC1YRNCqy9a7Z/Fbia0qXk1KthUWy4wRDaK?=
 =?us-ascii?Q?+UaBqga5rqaxoACZWd93AiELR50h6B+oRAUJIiqLF0W3BZZGBed9U032BhWP?=
 =?us-ascii?Q?PLQ8rInOheJeYA8vteroYdwyq4SrRx4EnyuHwhuh1PK4qeXZ7j8Wtgh5QuPq?=
 =?us-ascii?Q?1J1VEwR0ThUZcDQIhhd7cKfpLKHPMr5i2Zh7fc/It00j6Nl2zsdymOm9C5k5?=
 =?us-ascii?Q?WfsiAZCkRFD5PSFfO/JbCSxbuxGcnQ2LkPSvtQA2cmXZQQ38GlLAaBU1SiXN?=
 =?us-ascii?Q?Q+UxpUr/8wLp8KJxl3p4fFBk1cALPIsdGqp5mLaa9qgnln006De93CuLHSEP?=
 =?us-ascii?Q?qcPE6jM4XTYnNuaii7RHslUqKIoKueW4TJQQ321XCYUVUkaIexRc4wkOXbn+?=
 =?us-ascii?Q?WyzOsGErBJ/2IuI8hFMhBm6nSm3a7yeao6F8xhCwSUJDi6y8r9qdW5R3+QmS?=
 =?us-ascii?Q?PuTl2Rb9LfRvnYrbK9U34QYZR1PPLOZdKSESjD0mzloS2LcJDCKspkKv1hTK?=
 =?us-ascii?Q?GWJkl3dUMFzyCHDzWVtNVYh2/wftxF7p6yxA5cCpcJ7xXhPIUui1bEF28vIT?=
 =?us-ascii?Q?Xe9tL4QN4iaNEXaGywrjvXYnvak2kxv+CpHbbsnTYpmtC8iN3ofIaVAjoOYR?=
 =?us-ascii?Q?aWseJWoZr5Mf3hUxo6k8YhMzizjRT4s2Rru/ybyKy8oOlrQKE4Z7iZOQWP88?=
 =?us-ascii?Q?F9gDB0BV6XVLuCxRpRiWpGnfP2JUucb4257iq0qPjnxNTFt1a0guyHZFjN2q?=
 =?us-ascii?Q?7NDMwURiwVZXLlqUSO4VbhBx6pz4BBGCGdViBhddQhFgbm/bCyr/9MPNclEU?=
 =?us-ascii?Q?jw23xG7djXHQttCex3L6HPuAjW3ZfHqTnoeldojCPcy5Ag6Q+fnnyXhogU2b?=
 =?us-ascii?Q?6dTz0rVgdkBXXkdgmATB0YZ4Qwt3ulcNW6+q2sJhoLH85KUh/maDJtG3qqrv?=
 =?us-ascii?Q?tbRN3lVHqzBtG4EV+rsW5RdZUGY4EaN6FnOxK7WceX2BXgU0hr4OfiI83MuO?=
 =?us-ascii?Q?CdyYogyG5r+4lWL8LTYFuEwvNZmJXrCnX8BsVxLLSBJePIUzV5N3vOhe+bpv?=
 =?us-ascii?Q?8FT/6QAAGl/aKeGaJ+oybS+4iBKTdymXSWhNYQ0GHAn5TxPFyjt3L3+U51ar?=
 =?us-ascii?Q?e8qXcn+MggYWttFTf/tHmYFHsvZXIkk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a12a5614-4625-4bd2-09a9-08debed8e92f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 05:53:16.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ruh/9dGB4UPVdsHblPJwqzeB+haq7li7Qqx/slZBNDg6o2Ju2qF+xIe5Q9rTUd8ASMQUpz/lQZKnTCETr5xaUBXT3OCOPd7CdM9RH0lrE1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7127

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 3c2f68383010..8f0fda4b9421 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -244,6 +244,7 @@ static struct irq_chip plda_intx_irq_chip = {
 	.irq_ack = plda_ack_intx_irq,
 	.irq_mask = plda_mask_intx_irq,
 	.irq_unmask = plda_unmask_intx_irq,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
@@ -358,6 +359,7 @@ static struct irq_chip plda_event_irq_chip = {
 	.irq_ack = plda_ack_event_irq,
 	.irq_mask = plda_mask_event_irq,
 	.irq_unmask = plda_unmask_event_irq,
+	.flags = IRQCHIP_PIPELINE_SAFE,
 };
 
 static const struct plda_event_ops plda_event_ops = {
-- 
2.43.0

