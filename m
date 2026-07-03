Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301641735F
	for <xenomai@lists.linux.dev>; Fri,  3 Jul 2026 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092483; cv=fail; b=XwyJuNdVw5AU8TlTH8h+PHE8IpcdbrL/3R1C51NgExrEjHFxzR/Z2JPWSyUkvZV5G96h4TKxLu+r8yGucowIyVftGK4Md1HjS+PVB864LWtRwzUSRLE+iVpUu4oLymCsjjIpQSp3P5GLCia39QWOY7I8VTiuGd4ybEGLxgMHk7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092483; c=relaxed/simple;
	bh=Cdjil2q2PuZfehU0knHmX1mZKEuopio1UkTHzLP8Q4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqZ70PMd8hI8zPF+FBQv8kpuL1aKzc5Mp+LLaauTHnPpCTZAePZGKVAZC9MLnaGwWows4yq/3dg7MaOef6mJ75lalb1hEGqVCqlcrkJUMTTft/tzG0FCZODziooEUozUpBxPtoZGZyCWf2E8yHdfeKohVoaSYVZiv/3/4XyPEXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=U7aB/XeG; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="U7aB/XeG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP4V57xRlms110DTwpuTscUoAwzYNqHJ//gCIVfmaefhl/Nsmv+F683z/Tlakb+11MHHBwMpChL4UxLRBeM1n120iWab3liDcCRUS1CCZ90DoLPn+vxE8lU6bjrEOJtOskhWUuksNgcOwgP+SFVOVDHHgOJ5vckpBZaHHvZ6l4r73MGDIKZIepbZmlmxcXaKF2VhQ7AMVe7OQrupvjCVZ1qucGA2Nwp/lvLIZgloQ9JvnykwRBAX4bakyqRfRlVz8UeFoqiIM1/tJwy9Q4BujGVE4dk7ggFlOf9f/f/UJmU9YDjbYaJ3h/XZlNKpjyPYWa/zHPYM9qUtBXvIYpjiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQC0/nQ5gJPPCJoSc1vVM9nJbnVJRDg7ovgqURXwetM=;
 b=R7iyydXedZ1SmoGOj7lTGWYHbCMCBzWAhOmSEW0utjMHa3Rx3qnttKiux8bE4F0q01PI4HUK71RsVyKPMpkj5JSICI/VjjKs7A/rYtGcpc/bY5ZLb682zfku4U7AadS6RtV+Xg3FnG5MBZkHz3tKcDMovb52BHDxU48jPv1IxcugBy+IqwdVI9k8fmLixQsn8VkCFF3r9bWW+FhXPGH5085gIgRnpHhAuEE6vYXpNwLMln1UxlqsDJL+DTTH8JwgtttPys4RYzszZ9XV4OvRyE7NNICrVIQeq6YY2ezGDWRKksVtPfc2293sK5YcozRRfSjkZsoK6WVKh+U35rOptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQC0/nQ5gJPPCJoSc1vVM9nJbnVJRDg7ovgqURXwetM=;
 b=U7aB/XeGObCxQ0y4O1r/RUReD8+MlwoDUjFogXGDOUjsolfOJf8Tx4q7iO1FucUivosjiuUVvrBA0xh1h9QNeSq1iUpgxNeqaN04cjLjY2KBndWKQ5Vq4s9Lz9YU36trqMdaNgn8QlWmxYFZpgYzB/PsaXwDDStC8GAIeX+WQt/XFCC7KP4x0LowdnK4tgvCTJnV+6uDUFfanxcLjG8RCA+Uga0KPy6xWyYzWyQ8DaaE+fC0aEqFiSRjJokNBFerbd1XcwEJItJHOtX3XEHJSboXr9dz1d1V5YReygRW81IUkLs9CZe7CI92uJhoJt1xtwQ+WsRFfeKxSzIJHSYA2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:27:53 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 15:27:53 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v9 10/11] PCI: plda: irq_pipeline: enable pipelined interrupt control
Date: Fri,  3 Jul 2026 17:27:37 +0200
Message-ID: <20260703152738.129122-11-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703152738.129122-1-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB9PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: f813e52d-2a40-4bbf-cfaa-08ded917a646
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mjx7asZadsJ14LcUi4FB2Zsrd4ADIaotJtIqxbX/M2wt5XLAr4tJfmmZuKSgIRq+RvMIjN4i/QGVX+0qRQiwVrQBsHcj8i4MYZyZ8E3Rf0OPo0ouc1ckHsAFe0mu6zt+tyrtl0VSmO8TR27ZflYs3ialI6HOWaxw6aYYJsskYpHzSjFbebrMPG2B6eMH0D9q/ChSoLQ7WqVK5o3DlfLydQdy2RaFddb6iQhq9orc1tOF9Mk/cjpTHhHAvIZKSUGX2gIwqUBHyCj9P03wWxKxqgaUH8AtkZjNtzDMgPNZHHNpeirs8lAt17no9wX3BFfhKMfzx/w9KCFHHS33SKV+AL0Nb+ESB0HBoEoqtaGuOW8OTonOgEUm4Io8WUuaYLZYqMDmy5rFDgDXxAtu7lYhtsfpChcCjZuby3Onjv4fX4bRqBjgDnJrpgnuDqD1IsrV2DDELjXWl521wwV5xrBmrbQSb1QjvxkLq9SHIV6hIajwzHgnl9uSpy42Eo/xFsLVw3thfzqCW0QCnN3D9Qse5aKxOjRFda09ammdt/NS/pFj5GjKmhvr/l/W2x7GEUJcpa7I27cX08xzqX8N336MxB3Or66a71XXH7Z9n5AG29Sl2N6eY2hB2cbTxdOPIJz1i+iowPjRKc9SnYnn+Pnbs4k4iv2eZwh9Ga1b6HJKIGg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fT0tgqpThtS6dxTmJ0lbNvSC+wrN7hDAAsDFH7vaIr1LzpVUf713UpDup+Hz?=
 =?us-ascii?Q?LaZ3AwEWiMlDLxOB6rvdTIqIpbtScWEOP/wIw7VnC1PaTK4MwxUiNVdqEZKE?=
 =?us-ascii?Q?EP50aw38LGqEnfBRg3J2butb2hD80dIWh7QIoRd71KEUKCclKc5nbDmURiPh?=
 =?us-ascii?Q?pLGOKcXFFpukvUqUcnF0Hgatd1ap6sx21eoBmvFE8xyL/Vu3Xgunq63oEiAY?=
 =?us-ascii?Q?6i+pDfvBMyfmvQzpkswER/UFGMQAhYJz9F+0va3fe4dXE/d00cYS8hPGAwxA?=
 =?us-ascii?Q?gHY17gPTBmiLGPEataOM6vWKKaywgoXwwghnh1CslIJi1ium+MLXAej5TzW7?=
 =?us-ascii?Q?UdCIwN2CzBkhMyLYD6143pj7+LfIOCgs1zB0cTBp5dn4XKDfga/N9Okk6MQ0?=
 =?us-ascii?Q?f3kY7OHduhnbODvoTVStDGMLuZd3N/hCKglUgmwp1n8g5sQfaXxfZMoMY2Cc?=
 =?us-ascii?Q?sjUHtrIoF3ElsY4AQMCtvE+Lb/D+IF5O4naB7EcEqeIC0/aeeQPAzUhk+hLw?=
 =?us-ascii?Q?DCLvnrj0EUy++QauHUDpSmkzb/s3BLoz44nyk/m+Ix6xv1hLAff8lpfDDEAK?=
 =?us-ascii?Q?WX3O0OHgMvuP9sWdC36yWrHJArjODhbMjb3k0wcQN/HaE6X2z7QA+2qbCNe0?=
 =?us-ascii?Q?BU2W+ksJqre0Fch6o6litnei6PzFdNak3Bp9BT7or7SxQkimtw2qxMipbWPa?=
 =?us-ascii?Q?y5d6M9mhW+VuFbEsFsjo1NzbPDO9q8TN1qWaNbjd7H/5l7E0MVJVCl9zePfY?=
 =?us-ascii?Q?EKSV94CVjEGy/yU3xBUjkBGHPi1p6RR/UbBrp/i+ZusZiWIDdhrbHeLQr/Br?=
 =?us-ascii?Q?2L7xfaiEUC537Lh/bTiDqnJz3GvwrdtugXjj/66yqS0XCfCNmNf/Clt0Ik6s?=
 =?us-ascii?Q?gRwxpn4P7XRHUIpqAKD//8j7QCgAGP1ugO9z8aIoSR0Ga0xUt5j0Bz/hTgGK?=
 =?us-ascii?Q?vW5ucPugXxus4f8kEs2vDS2rzEvWvIeqjIxBTVg3Xq05JCqmbVJL8X5gKgmr?=
 =?us-ascii?Q?SYqQsSx//sgu2eafaS2IOXJ7trNLt+fPl99tVWsfBkozkOht5wNx9RhDtVrG?=
 =?us-ascii?Q?OPqv2TEfs+E58bFyncGybc2tE2DiZFfVkIXSH0Egl0p9LSkRFDNEs3QBiteQ?=
 =?us-ascii?Q?lb6sO09Knknmiarkj4KRzfb/1T0a/zc+6s3WexRb6isveqee3kPfGZmA4JZ9?=
 =?us-ascii?Q?pQg5NeWIRKHUcgKREMvDWrIawEOCZ6ww/z9Taw6XvyKOLtz1MdnB9PFwvUgc?=
 =?us-ascii?Q?FJz6Bi0seuH3McrRrFWgz7JLAwhNY+eXuRy+18QxtYF2HeN/Z3JTKGAcfOmb?=
 =?us-ascii?Q?RMUq4XxY1M+oOy+RRQe42XH+q08sfJbfld5jz2LPTl72sgtQJdO5iVj8TP41?=
 =?us-ascii?Q?/I1NN+H0TCLjyqkU3SqaNDjFQv7oL8QF/drUKvIW4kBiQaRHsxRMJjfR1rWg?=
 =?us-ascii?Q?sMXx4Kd/9dA29/4HzZuap3Enl4C2nPKJvCI/azWDVxQK9ujV9qMJMPJvcTNT?=
 =?us-ascii?Q?E4L50jTZQNCrfGWXyRbbcgJMnZ/7chfl9hjcFgCfTGlvuBNL7/MtkcNHPxwr?=
 =?us-ascii?Q?qTn5y/ogQBD2A7qzRjoO9PBLxvE3uZr5txNBGRfqQ98x8kJXE3LbAQIpWgKj?=
 =?us-ascii?Q?UH6UxnRRVcFt8Ca9xToLtIA/xnIh/NqjK6f0D24i5aFDpF1S1XMtpCbnJOSE?=
 =?us-ascii?Q?HKDHC+Lq04RLsRQtOmQZBQBTn9LQDqlJbzC5Hw5WVh4sGd2G4AVUZEwwKDCo?=
 =?us-ascii?Q?hPfEz/UXosKveXXVYXlBggNRTEkrODa8dPK+X603h1e3lLO3KbZX5czaeIub?=
X-MS-Exchange-AntiSpam-MessageData-1: TpEGAgnDU42i/p8AS4k+D7Vwh3h9otqgWxQ=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f813e52d-2a40-4bbf-cfaa-08ded917a646
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:27:53.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5H7DkrUGPgdI8dfIbSAo2w3heCR7CY6X1o67V0eY9P6FpLCP/RTjdeT5WNMRpSJf4enGFXzGxpustlc6DJJjdAtNEbweHOtWbAJiA+k9ur8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
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

