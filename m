Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C843E866B
	for <xenomai@lists.linux.dev>; Thu, 30 Apr 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547484; cv=fail; b=PExn8ABh8kV3c7dxo0eXGaZEcu2G1YYVGpQ/mhQ3QqaCZ4MHg5UigRveNFCVcjXm/xQmGOMhhSvesSNuLpfBVYZP7ZtP4qLbEJ5A+sWsJ3p0woaATc3CLno3zNqgQFhp4noWmWdGcs3dIUMt4f/Xnn86yNZjH4M0nX8nTQ1e/9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547484; c=relaxed/simple;
	bh=1QoFyDr0qdK5Y8esuNX8egGfJaoqMdACWikR/SGHa2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KE6Z6b/FbYMIu9GQ6hUJnqbDty8uYKR2uDJf6H36z6+HykcDe0Zg6oH4T4J/bKtChYNMrH4use3XmbHd58nqAEtmjJdAzBSH4RKJg3auqh0uhQ7dhb7iMowacvvp25yMs8B/cMORw3VP4Wu94l3ly+wxJepInE1J1jPJ/ehGWp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bRoRRu/3; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bRoRRu/3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6ygbwVqFaBLyxpY7fF2wGB9CB4QRr3B8pN1db6FRXkdxdPIeOKyiThVM1hHrNzoY4L6onf1MRcYkFQaiBHxU668UIHjLgTv5/RUrZPhXR+d/CwTYnpxCRJUqPdAjgH4zm3x4f9JNlElW4VdCZ9UrKNr6wizboyH/4vvfVTtsNALIiEiWzI0pxuKxm3rbb49MJy7RbZg0+RMPpu3+tbVVP5xhlJUeF29xB4WudwlcHPqO0uyflCf/0Q0UYbVoiOPf9+QmjICxGOSKcXLN6UnTuILvs6P1wJx8QLHcqzOZh0ZVKdpUyhwb3QIF4XBRdwz9Nzsn/oTRbVoNkkPEZW2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKNAD6yH/tizzHzhjSpyif+it53znoE030hY7E/eOH4=;
 b=lW+qO34XCUAM8GLtRJ802sr2Lu7JQt4AhnTQk5DkYNDzHGaN4KDhny6et1xEaDUka91hqM2clPbhWKXefBdg/YSbmSTNlo10zeq6SJyBROhGAS+i9v3q9f/51bi1zPdwM2wEdh+60SUtDj/XZlYsn2CAfHUv/jI/4ByLYfRf4oq22/OFx+SvTgtqC/hSDLywnxDJDtPDQqBMUrOX+p2EXaQcw9Z0SOXPM4VaaE/VBB16/ZrKALNH3Tif+Qz7Yz8GK/mWUriWbRVmvZ9/Sqqj3LcedxpjCKrxMo77RrXyJzb6vNqCv0fW3ovcJOfD6MnfCD0hntSodm+hYxMFYUjYsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKNAD6yH/tizzHzhjSpyif+it53znoE030hY7E/eOH4=;
 b=bRoRRu/3WAFuAcEAQHrSpicss0Onuk7Dd1M+kEzHFgmR69gRFhYMemWLJSa3NUAjRkvgwhhn7dvm/0VOhQrrnxA/t5fi80npS/tEbx9UpoX8Jc5Lp4DOJLbYICcUNufpn9N4xmHz/u0+MLk1JukROvq2syrkgPy3CQw2jva1UC+mhwQyH9UDdDhHkgL9sGiBffnWq0cfvJkpZhTxXXgqOLyBlJmprVfiEFqMzt4DJtltZxewtq1wkNSeYN4rkXjTzXGWnptAPfVfvqtL629SXSiFiqu0RW1V+Xf3ou5Q4FbNshRE0WtqleLsJzJ8I7NJ9ZYOzx4yIaDudNTZVAj2CA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by FRZPR10MB9890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Thu, 30 Apr
 2026 11:11:16 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9846.025; Thu, 30 Apr 2026
 11:11:15 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v7 10/11] PCI: plda: irq_pipeline: enable pipelined interrupt control
Date: Thu, 30 Apr 2026 13:11:00 +0200
Message-ID: <20260430111101.1539377-11-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6e3f78ab-25f8-4c78-abae-08dea6a931dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	LIxaJblxgCAsoa+KSc/9nRduoCAoagw07rgsqSWtmOua4+PltFj77ZqsEmWqDn31XYUZe/bEjiVX/oOFVh5uFUO/aPUgAaj7w6c6ydBioxZrjPF8q6B4cyfGCDpXmkfa+9o1c3BRSjqKICxEiIO95dx3DemWTYI1HMqgkQP/Hco5aWzcJyqbA7b41FzHiWY9zewfut7jeWdp+eyO1dpd49rI8DkysuXHUSVIjyObrjs/o0lh03/nNHUegEjwfKjm6DqIZDBDV789tgml6IMYjq0RcyLyyz+GgejuTGvKM4M+Q6qOjEomznY+bM0twj83iQ9Ctm6nTOsRtUhhUGPnEm/1p8kZRkVyMyumD5Eq2I/WbjN28Ea7oAU1LdazjiAIoGohVtAdZRGMw3zT2iJo1ER4vnmXl6qQ8WbmsGPQ+2lGSNYd4IDki5tqjOAWcDMksNZnBh6B2icOg3ZZ5IUHPI35tU6vBIbuLb9bj2KTIuFC809HM1k5dJczrcO6izlrvyGVNLrP7b+L//QftNYP4sUYRVd/Zf8xK5nlFuxDKCzU5XAk9uSdKgP6fHCNzb1dTkxg1m3AtjEYG59WeWs/99O1vrYR/DqlgM9JAQiM/FBRmQZoal/6vOrstCznyhDWTjcpKM/fV1UJH3A02KlkPRadKgYj3wN2Q6HeqW94CWW6XP3C7ASktugblIy6DYOUEq/HM+IjqOD0bSm+njZQeP8U7lidF/5X2PsrSfuHTRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1jbgbZ41qeRS/qzJQI5VoJcgN18hMbsD1XTzE9pW1GO2tMqRhimZw64E9ZX?=
 =?us-ascii?Q?sJLbZCaol96dYUCnESrnlIEDZn/bMZE0Sfn6Wsh21/9mfL5KGn8lMktdMnUK?=
 =?us-ascii?Q?tPQqbqvaRV5Fwd6vDH2xcrEiBr6bvPVTkyFv/epiGZqRMUtRKOiudElmSKyB?=
 =?us-ascii?Q?I7nWAu24vv9n4SUDmgzB3jm+D7FIbgstW7m90ez5H+QXZx6uVZt/t6uh9WVF?=
 =?us-ascii?Q?TOVAitThUyFYnuAKBTP6vam3TBv2pir9SKndVTkCTnmXaberstlUUdjLTq0a?=
 =?us-ascii?Q?YI4xGMZNAgFH0/tUgvEG3G5B2hPyMcLeKdgtA4FmcJeiFbhOtOhBA94srx1F?=
 =?us-ascii?Q?YSVoHnf2iMKLgWKdkXFqT0i9DzeMkzNJ76+C4JzUbPgoeBdBN5Yamw2xqZfn?=
 =?us-ascii?Q?G0fGOJWLXY21q0KQPMuVh+d0fh3d1wVmoxiAxdeK2XVYg3mRDoyPz2mcPR+r?=
 =?us-ascii?Q?01JaiVUO6M3RDexuwGlbBrG7v/HVyM+dnSUmuaNTXCtD5DFhueg6xWmzEsSG?=
 =?us-ascii?Q?5zTOYS4vtlh0AgOPmNC6AIfa5WE8WP7whNjGg6iDPDCF8sn/mg9PhePKzglQ?=
 =?us-ascii?Q?Ys5dxBpWqfthCaG7Vjs9IY/pbE8F/BGh96ya8d8X78j09VZjQjcigx4v5fcU?=
 =?us-ascii?Q?lH7osa0B8dpml7hGSjQgXob4ABHFBEl7Wa3hqQ13LYAFUgXCrkj+AS7GtA6o?=
 =?us-ascii?Q?OzMoaDu/mhhfB9W5kjH3q82axIeZOJdmn5ZT06ey+j5h4BAsXSMcvFiEnz/6?=
 =?us-ascii?Q?reKdNRRrvanRPB03bTCiwt5q7lxZ7OeLlqKBdSiSb+dHryUh+dNjDMSc2DdY?=
 =?us-ascii?Q?rN42c4XMSbFhYf02DNFgD+6kVlDFAm6i6SuZOP4ArZgU2AqE/wKPYxkPl6++?=
 =?us-ascii?Q?EwMBQY31foQ+y0FpLQpqpvdAb0r3Tr8/DW8Q/O/admwn5fTAWv7xf83Lrxak?=
 =?us-ascii?Q?pZGAQpJBePMKyaHl+JLcIR6CFkc/MgDwLILX6o29nw+8zMmIGnRSdkzFpOFA?=
 =?us-ascii?Q?PFZE3Z5EEKI/UACSyqK+2HM94oDELkeQZNY9FVzDiWgsFA95jkKCkdCbZw2S?=
 =?us-ascii?Q?1b2SEWDxQJxZ9ITZXlj8qbUnLs6U+QcCPcgUn8a9nXui1CMHp0DxcODZgGcg?=
 =?us-ascii?Q?l7FFjfbL+JgwidB5tQT0AVEyF9aCsaXwdGqiqcS9kNy8XWwDySKLHnjkgcx8?=
 =?us-ascii?Q?d9NHDMr5wLqBNggbRQaTS6izmoW/GGChHIIoHOV39uX+0NPQID9LTmgpy1j6?=
 =?us-ascii?Q?ulfDQJidro/vAsijrtUI8BSPPOwcu0aCix3hrKbXLJjvwvKEOU7C5l9V4/xH?=
 =?us-ascii?Q?b1X7WgZndhXp7jHiKMWmVwkx+Tx/VWlkhG8JKZ4CmTy2ciBy1hemuICZ/Ln+?=
 =?us-ascii?Q?TkjOhaT5jbz5AVqwTfZi0lFwbSfFvlqEm3OtsDb5Vljbzu2X6uI5IGmn+Nmy?=
 =?us-ascii?Q?SUR83UDVoHbLEaZv15noDd9OT7B6sAM+Xs9mu7QbPGkHFwnKaf8eAWyNL/Pi?=
 =?us-ascii?Q?zQlIW0JUBLBVLkOqIR0HuoCmAj56TW29XPgJJNmgQglHij25QP+wECnjx1Dh?=
 =?us-ascii?Q?TcXEsuPPLtW4hxR2gBVtYrG5qODl4Rdmw/2EgKi6+LSxopxW7hG6gpUzjr4E?=
 =?us-ascii?Q?0AZdF6pfhtp4IBQPrZxw/Yj0MTBUGJMLMGcFZXf6LMCqYcf2ayqq6RTFROkG?=
 =?us-ascii?Q?z+hFWmVFqS2GKqf6BreDNjlLGgIXOZjZ0RTSLOEcpGJYmqr1+ulDRWhq94nz?=
 =?us-ascii?Q?Wu5NbLWEZ2/G+Ino6CfJNWGy7S3Ju7g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3f78ab-25f8-4c78-abae-08dea6a931dc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:11:15.0847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uP2GnYAZ26OYF+OFoDz9n4c8L348osczlnWF9QpQ2Tq0lmKCmQGCeMCg/MoO4HHvO5oqJP0UKhsE2PhQAjo3aUnBNluc5dR0ZaKMvMrPuYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR10MB9890

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 3c2f683830107..8f0fda4b94218 100644
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

