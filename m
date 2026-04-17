Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3831E832
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459739; cv=fail; b=GvI6tqICGSHFXBPmEAumMfvN/VQzavqq82FLIyn2o6+HvZ+SsQnd7U6XY5Gz19D8nYtBv+GVYlKm3BwPeMBulmEfjevAygncB09abDzwFvABB40ZhTuYCZzdKnMJhtEfQ+FwcP3bFIf08GiKqPTgpA3606uGAyOFHkfrzRXHTPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459739; c=relaxed/simple;
	bh=1QoFyDr0qdK5Y8esuNX8egGfJaoqMdACWikR/SGHa2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gpSfr82mPkaroa7JCMj2xcnekiu9uk5W46KFhkIa+2Tr0Zkll/+zVFjNP0zvZH9nXFMJsYSfrrJ2NUJdBQve0lPHE8MBhpRmu6FZFwJv9wfcnZXV4bpk9SUL0XLV351Zyu2ND9aozu47rYIjJarrOOT8JT/CncEmIGMkp8N+6l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DY+xCnmD; arc=fail smtp.client-ip=52.101.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DY+xCnmD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5xuZiTLj0ns6ubD7MWHAr210lFJJbtOnAKTNSw+Inn/pltNckkSlNHrfPdIWNAPtn/hOan2zcEJr6/oBpdVXbB+ujfIjQXx4UBRC7P+hAhMTb2dDAgqrhqKEbR7BI/w7CSDwSpAozWJHrp3GVjs+tb1br/VHTxY+qvQlNBQPpZ5qDKVN+CkCKeZ9iBXLIFwDqFkJd80xH2sQfnSCAl1EACJuXi5iNnMmdHc3e1OuUs3l07UwjV0hVip719G2c5kKYA76iDhMObYggC35hmbRQT7MpEJGV/RMRlAZPbkSyNxyUeenvEQ4j9BGJ+hQi2pYAfbLUkyChUyYE5cKbxZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKNAD6yH/tizzHzhjSpyif+it53znoE030hY7E/eOH4=;
 b=J/Op0MCORb5bPN3w342x8yLlhBDSgqn3toW7emrmjCqWwtRzmh9G//+3R8nvgDuUgWFdOU6xMjJhZH9uST0GlstSr67Ytqq2+JoBSqXN970qYJIa4wMFTuSF/z5MZcDxeHFzxTAKoYPi1OAlovP3PibWP1GwHrOSbdZSYOXNNhIRqq9QWFGapioVMkMljLaWWJagZ2f91z0IFYb3h1N2wn2D9JCrEL+uuaq1v1t2NUS71DvwYKc8Vp7KeQ0tZxJpwd1A+/fRQJEw6dbnS4dsnzVSZdXeoh8J6fagijcON+/Pi9oQut39xLDZoMbCxCWhhzkESNipf5loi1lJesVbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKNAD6yH/tizzHzhjSpyif+it53znoE030hY7E/eOH4=;
 b=DY+xCnmDMAiuP5VcXfYZY2GbU4umKZbwZvltCMYoXEglRC2Wp5frcJNMFGM1OHqubAB7PFsTFLq0ui0dwdO3Uh6Z3ZMqeyrWV1jO57B0wCfPoTdMCRZlh1rw17mLv75Z8c5QPnLRygsWmTbzRTqzjAEZxYKQ2t2os89B38MteAUg3jrcz/uDR+WS5vlFR5wnnVgh7g8gt1tEn8ZVIvnvCL5OIgGARZG0mmjbQJZkZhS6SzIVXx9/UN56DooF2gMadOwjajKFjarq3ig2SLHR7j9QMen3cEhzgNBT0YYznK4g7DB0ZcVHBMd+ad9wuXL1VQq/r0uYwZFu2fpRMoCpaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GVXPR10MB5981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 21:02:08 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 21:02:08 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail 10/11] PCI: plda: irq_pipeline: enable pipelined interrupt control
Date: Fri, 17 Apr 2026 23:01:53 +0200
Message-ID: <20260417210154.2290819-11-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
References: <20260417210154.2290819-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::15) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GVXPR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fadd121-f86e-451e-66ec-08de9cc4952d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	mwMjZAubraYoeUV3+DG/teKoFizxVjosEdJa3Taf6V/IXljjdybVrEBg3CM3nL7966DgoaEWbXyPcgSHtdpIA1UBLC+ylirkjFv6JVEYZ9kv9AVjI4hhdPJKYg1BzeGJEXbptOjrGyy6rf4b/b1hJ5AqDjnWAIvsh3q2x8uvebtZjcz0QvLHic/P8w9gloiJzLlVFlB6QqV2bSaZIq01QD1nwtPtgQ6sooTAvlpg1MUxn0dwMUC+Lv7C/PseGSi3AjPsda7xvYCraaXJUVRS715E50Hf1ym7MCzRAb6uqhthAtw5QEvF0L4fCSVJp9N/f/fzJkgXsdrLiOwbrcFbV2LGTr0BdNBHniXEuFRuezNWCHQvKku1OKU4gPLP/8WKJGuzPC/N09dp3bj+Oij4kdowiet2U+A6YdAJgLpEbtEZyObJfiwNYOeGSF9uyaHnQoOQJk/2t020aFqZp7O+6gUqN2gknqSnTE1tjm2BpCTs+gqZsTWTjVcedrS3zzG6KSzvtip9In+o3rfVAt+kvNHLJPFyJ0oX2TcywDdmwjNnH9j9bq9/RBkCMcMc1opA2Dx7zCbPuvdKNC+QnwrvPDQkGKvCQMklKmWRBxmuGg0Oe+jS+7yk98aeJoFlr9fwNj6pAxgCjTqF6GkAFuWLHxKv02BZ0WNQes6K3ZkVD/aCVubl4pmI5tcU3caq22OoJEMWUr9x0TwrrqQxUPwAGlcp4d7BOllGOdYH0xBEW14=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjYMzRTfbgJOie+Ye7fWlSUG82VrDuIhW7MI3M3D+ONUxm+sEVMPwREe6M9z?=
 =?us-ascii?Q?C1UAsiLIY49qnfAcoxutth92GBua9NF2gEzylT+PJt9YCbE3eF49bZ+GRs+u?=
 =?us-ascii?Q?Ovtdf1cFWM+j0QM0UWxZWZPf/+EN//vmAQqCnDLIV6Vq0ksfXFuqRvfS19Wm?=
 =?us-ascii?Q?EOO+yEJrl/P5rwBmkQfnwDLFg+mMMNzcqtnQ86pOrpi6F1rT77NcdCt3n7Gn?=
 =?us-ascii?Q?5ZWlKLGmrdEhSrniuemWW/WgF8N6IUe5zzPuzg+apd1p8mXppRNghMsdXFxv?=
 =?us-ascii?Q?BYKf91q7BdZ/oYpt38JCEAJ6p7Q8gQcIRh1QPa/SapPj5alyLVYwV4GnFI46?=
 =?us-ascii?Q?ABQRF9CFRdjJlqsS+uMrkJYteULJhfkU8rmtVkEvfhqyfVubUL9IJGsRJfSe?=
 =?us-ascii?Q?mx9SF+QvKrnwYfn0uE8m+4XBGu/oChtwiEt+RaDBNDRiOCX1jVpxGWdGYJ8O?=
 =?us-ascii?Q?mhx0Y6S62t8meP4tLV1jD88CN0B9VNtM32P2DCi+t8BSefSqXLYwM2NKdxxf?=
 =?us-ascii?Q?8XljEk7N30ewkT9KBtO4fD/TfSJlP3Bm1KLIK/e2g2PDfhsgBBSO+oBwqXYT?=
 =?us-ascii?Q?qQI/Kdt97GhocdpSJQYaoPf5MJvGLv0OuvkWLufycuMokeicDjhB345oopf3?=
 =?us-ascii?Q?/G8oZx1ejrzKoZL9f27QI4hCXfz1+RfYIrY6MdNYtjZYuZPI0s0NyvSqMvfT?=
 =?us-ascii?Q?VxxBPOuKkBnvJkbH+Y3NxOIN3IQJG9WngmwnYNb53/ldb210tFW9kZuCC5YI?=
 =?us-ascii?Q?3/F85gCU2MSUZTOim8AGNdkFLz7K5P94ENAnsG4EVOJedcCNDxeF22zD0XAE?=
 =?us-ascii?Q?0rMS0eMQqNmFA/rnd108dzDbLP7ne02yTf8+XtzWIH6kccg7eFBBHwwJrZZl?=
 =?us-ascii?Q?T/QpULuhCuoikfgrF0SVSZdS/LEvfkW7rbpU4iKbqJ32t0FZaeVmaYZzAipP?=
 =?us-ascii?Q?0Yt5OIFAz/KACBMdR+PTCEwd04puNBYYHzmNpL7K5wZjQE5V/7yQdKFAenFe?=
 =?us-ascii?Q?QDxehvv+XgwnXKsXZcz07C8KNKUAMxAucDwg9sHsLD5RrINXDA5DmdgKQnza?=
 =?us-ascii?Q?lcFAaGKKt031pe/6kgZQuUDCYEtQU25fJ7csWapYdK4gL8euoMlWF63IKn4K?=
 =?us-ascii?Q?XuaHjl++ns9ic5hokD1fOe01uj0y5YRmn6Z/kbAExGjPsCQzireSeNFaEbt/?=
 =?us-ascii?Q?SHUlO8AMIuCMwxv4W8lyxN0dHeR1ReBVM3F+jmsJeMNRWoHw+HF5S4PaVG29?=
 =?us-ascii?Q?hYjKLWir3795Aq6Zp4PEyMltSHBznM5F/ayxPJiP5QBCTvPl8Fi45ODOU7yZ?=
 =?us-ascii?Q?JczhZcpOylQVkG5jXmW7PTNhjzHdE0ILTCiLa+LhAfl3uSs9RT3WY75/MBkO?=
 =?us-ascii?Q?VGkkOYskX2lT90MK6KgOaQOJnollDNtc1fI2hqqnZC5KKeuReP7hTajyLYXs?=
 =?us-ascii?Q?fLJlBG8eVilwTY3lsBEy4YYhK90eLE3Ehw7EDZootx7Jg2HH6sJNA/onpurx?=
 =?us-ascii?Q?lebmzUuKnnXKn1VilENsOBbEu/Kxrld5NEEJzhU4HmEzVuCS7Upok/MFPxYj?=
 =?us-ascii?Q?h7ePnygeLjmzPNnjnGtX5eU9pzXS/n/cPBB71jkyGEgF8V7ysJMp7nJrhjlE?=
 =?us-ascii?Q?HV3DbVr1hlQev99fYFlnzVLqPfmW4gBscDgSqC3RvSVM20D77tsgTCzfkMep?=
 =?us-ascii?Q?H87fxC7WVHeLe3UFZgi3N3f4/kxm+4JAYm4tSYEtP+NcKIpBhrDcsMUFCqWh?=
 =?us-ascii?Q?8X5qkYXRz+eJbqcpTt9j6TDpDXIiyEY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fadd121-f86e-451e-66ec-08de9cc4952d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 21:02:06.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKvWfoIKh8daPnZ1Jy8opCtWm01w1SvYdvGsQRWxWolr2Q7oH+uSLceCD7pZ+gBjNXsrvnr2OtPvQEyAHQXd3vX/2u4e89JWxArJHBkh0T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5981

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

