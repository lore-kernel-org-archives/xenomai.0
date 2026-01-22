Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8F3C1982
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077413; cv=fail; b=JEHlYUaANLNN0abUQqYc/3Vg8grHs3EJfKcm/av25ZIeVaUU1cSLz3aHK7rDlJ3O26bCKpSfXzCZml/KyjwFTNfd3ZZl0ZT0734kHigjlEi1NEDngZiI6hK5kB3ug2owlxF4bz6LE85rsLKN5anpneeexXg7WNz6in9jIiLS5A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077413; c=relaxed/simple;
	bh=AM+hfDan650qN8kJWFS/CAA6wfsN0W/QX8LAsWi9dlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=osyyjosbUJh2X9DIm5IjTEpDcKGFmBRkRKN0PL8qRtDcKrWDTNaUD6BUVhB3mZuTM63k0va1s3JHtIqRigVlH9a0SSx5Eg2Kv6edwQSYabo4yMQRBEY/p2jEzpktjj2tvBatgIeLuIFumdtTLMp9+v/Lqt88k2i7PogECMukR3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IrTulitV; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IrTulitV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3B2r0cmWBpFRWIoWX+zHqvuWujw49Dvnqkj21pdi4r9qRixlEZC2YtOUpbJVjhuNuH01k/TegZ4UBJ5l4H1ITroPh9Rk6JuBljIxOXor7W48oH9qjTFohJL2Vyg02epknBE8yOO87xRTNnqaB2z5OtUhXS3vqX94sE2DfklX7G5Zs+f/NPomTWvEQoM0bd96cI94KOeGpOP5BmSBURC1CcgWk97tt6HAV+hqcx7LCJTA8vM64pic9ZW08hufbdL6z6IHpEUerzaZequEQBYPAALhAi0XypyX6K6G/7PtrKHj97si0hX2VOlPs604Q4qtQnDXff+QAyXdE3+4576DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gpUkS3Ojfaa5n/sd23VqH95da9LdVJF9/FNK4cnx7c=;
 b=snMRVlgKAOUn4PQP0nj2uV2iRlYqsnBRHoFctdXO99v970AxLRNC1n58FZgAPXeQjais15nMZ1PohS7CHiV0bXp3o3FCceIiUpWrc4UYqG4Fd/JPEQpDTMF2CedHGRKL+9v3zohiaFsNVjooWEDvMN6s+ms6p8DmbcsmYEOoYDbXcKAcPn2p6oXPQUs6Q0LcN6KQIKIgtiMFEv0qrZwERJIrXDD4kSFeEWkjEAhg0pP/bwKBNz2Cov/X3o1KwhTtqO9NdljVvyIJn2IiDeneNirpwlF2cwfpkRjvPsI7pFEpWnd9fogEyduQRHPrEWnFDMO57G6Gjh/v70Tog9ibbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gpUkS3Ojfaa5n/sd23VqH95da9LdVJF9/FNK4cnx7c=;
 b=IrTulitVw3FFAGSoNks1TfYQQBJy6ycnoGuBZlrMZEyjWTNndtjhh8IReafTsdirp+kj/Hiuem9p3qZ66rTAZANwkXR/YlSVSTUpp3wJt44pfLGAMsawMeQWDJE0hspVHbqeF8RNmaVR/KlBj5+fgEYNtP8vTbJ9fq1lbQJID3fFyzOWW5AcqVaZUJDS2CHu7puqpE/6hCwFMKcn6jg/4kaGQjvZuVtJIEmus6kYMWUP6hdRegykTA0jXeQq2oHeoaplfIcvLet74UkHQEnZfvIEk54yxCqLfA0b5+81VpfN/qLLvOh1n/o7iqMIYVh5pJXsgjPbDKxA1hE/S2HDCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS5PR10MB8174.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:673::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:23:15 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3574:ee1c:94a0:7492%3]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:23:15 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v4 07/12] irqchip/irq-riscv-intc: enable pipelined interrupt control
Date: Thu, 22 Jan 2026 11:22:59 +0100
Message-ID: <20260122102304.421957-8-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122102304.421957-1-tobias.schaffner@siemens.com>
References: <20260122102304.421957-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS5PR10MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f996cd-b353-4c6b-973c-08de59a0411d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CoN/uEJv0XX7YKnVvODymcp8jtd5PtmZmzlCSbJWKOVgHB7WyvCTAdgNs1iZ?=
 =?us-ascii?Q?hTY05+o5TyHNEr9gwEaRZ3gsuKjkwoDeNWtpt8eeF1Eca5dP5Tk1Mp6zPWN8?=
 =?us-ascii?Q?0Mmg4Tcm//WTdFNNf0EMKhkRixdjgl3lx4G3RQwPeFTWjcOpidMGsgC+CHD4?=
 =?us-ascii?Q?uEvIgEZJlNi1NC2EHBv5SXrI+oRSi4Hy+dkM7nGDIkmuICyhykdMg6EUBllT?=
 =?us-ascii?Q?1vIVRUpnDTvpwHY+fyFVcBzENPmed0ZRM6uYFIKk2LIvJAw3+cmYWk1sjLDA?=
 =?us-ascii?Q?hPCeY8DYWRGPAaDaoR+hIN5AMYuCSLSpD5TYOl5JCXA652ERtoDgz0OU9BIC?=
 =?us-ascii?Q?7NcGP0R+al9a2vHRpXLAB0dQO1rGbIRZI16F3yndHaYLj0Pa6TKwPZXK+2m3?=
 =?us-ascii?Q?ehaShoc2EjMlVPYgWkYsZgbyS1W2y93kYci8/VDq03Y6WhP/1kI4wu4wiPE6?=
 =?us-ascii?Q?LgUniqTftgFeQl+bUh7Z2GDn2cK8WMTZzZ8Zz6yK0qRqj9vkUbK45OM2y64z?=
 =?us-ascii?Q?SYgyBuxGrJpzntyRZB1P38aMH90G9EVFxARVj/+qdL4QgTKcyGF6NHThRlxE?=
 =?us-ascii?Q?dWkEW466d3ZRqm3O4YlpwMIHlfGINP1vufQ7wkaxJBVgjB9sl1xAwcgYUIp5?=
 =?us-ascii?Q?bYT/dadtlLiIcs2oNgchaISVceONCTITrZPzsEyX+iyH/trOoxqEiDqNjVSE?=
 =?us-ascii?Q?I6Qqn8t21wPncBOEAjnkuNQWE0g2pQdJUeFbcufqBHkpiSXy08yY0gAZbA9C?=
 =?us-ascii?Q?Eau5Xap7wZs5jS9NFXU5jkh3/grbyueRE2TcO62cMharm908DCqeFzxBqHUV?=
 =?us-ascii?Q?vh+PQyYKoYue1TvOvWiN3f23Lgtt4vWlsTl8anGHEDZOP6IkxIKrT2gLCmEh?=
 =?us-ascii?Q?aABfvhy7rWs0yP+/2kq4DAGgWUB9owfo8aMFN5dnT/gRzYdTfkdmyBIYFqmR?=
 =?us-ascii?Q?CM1I4nUraE2cIfEzuhDMM5lfPn2vrm2fYOpdWaaSJJIj+FAax23/162QcAR0?=
 =?us-ascii?Q?EDnvKEMpA9+TknHCV7vk1VcYRlm2FVvknm9P0XqZvxp9f8Ii7KLI84pQfnVc?=
 =?us-ascii?Q?UY21quwwOce8GCX6vkaLAh+P4WtgUEYZI8jmAq72k3ZtQ7FK4bL/RXqmrbph?=
 =?us-ascii?Q?d5jHs+aLQ33fcNiGkzlqL3AgfV5laZozlk6uSehc+x2qdfeGQubokXTHawNb?=
 =?us-ascii?Q?A29XP1GXDMCSYqB3xvMuWB5VDlmuKsRC0y4HVXiVojuBSrAuPGK3YrK2/SWH?=
 =?us-ascii?Q?xwQ3qbO+2immD5Rg+j4G7EyFuJU4DuZJfjMSvlnpNtsl7RmdxMPgcUKPdNVK?=
 =?us-ascii?Q?zVbYEgZ7Ma1Roz/Fxt/KIhMFNU6LOZNlAIAVjf/Qo36nwDfTXvvbEvXFMNKE?=
 =?us-ascii?Q?JnNISeRVC3eyaMQTMG9ZI89Ua7KcdXSSrN82ZKRJTyOab+rg1MlTZXlUngWd?=
 =?us-ascii?Q?B/q3WNOLtbbyhdTdBHCRky6lfs0V6J00PpPGtiXSiBKvrvA/QNWD14LPsWnV?=
 =?us-ascii?Q?xwvBTBGhnPaJBqEZ+DQxpggAnD/L0CZ5AOWGk49URYK4wRQ8GzrbUFUMsFLi?=
 =?us-ascii?Q?jWrNXzyyGOoUL8/XLig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qJSesgT/y9dS/y77/uIms1FqmOW9p4hK1oU5RrMAp9tSq+ML4gLcuPVOHhlQ?=
 =?us-ascii?Q?nEUD9TzVyX7tr4nvV50v72JRKDKhAInDkEkKGUYpUpr+vU07wS3jI14sTz5/?=
 =?us-ascii?Q?wS2reoY2WXQzJic0+Nh+FNKjIa5b0AvFGql94zrvH3RTbUmVUloEq+lCzlca?=
 =?us-ascii?Q?1VRSwmCbwBMswLXnr0ZICuQVJTNTek+Itthn5GMpmxxtYfRSrer8fwhHdIc3?=
 =?us-ascii?Q?TeFTBuDEqeXcPJU4B05OPI0modgP2aLrv4iZ0KzjxVgsvWiSfVkeU1WA3LnE?=
 =?us-ascii?Q?n/9QKL1r/PVpQA0t0owxrQPpcilqblVq2rS0R/0M8OCpIQSq8oK9TgyU0hQq?=
 =?us-ascii?Q?j58gwDNb0JDWfZlhZfJSPx2LnnolX/EIwP08phMNd0ZNfVfMWglZvYloe89G?=
 =?us-ascii?Q?J/+KllybxDavTh7UduKYVFee7QtC5OVlBDC6BBscnXUROyHyVlpgJvf1ocAG?=
 =?us-ascii?Q?vIi7z/sKQvrtxb4mU/TXjSfX3xo+3I/ZTqE5g0cvT5lCi981wZ9vA8DImljQ?=
 =?us-ascii?Q?MdwFp+QVs6Kr9OlYekz053Uye7moLalX4rXx/nqbDVNaL4StqOBIu2b20Ga/?=
 =?us-ascii?Q?IpO8GnIZKc8K2SjiCzAXgs+f/zfEG4UoWGkhC71IPWt18bqes3nZ9f6rXXH8?=
 =?us-ascii?Q?waOyyw1YdoTq+SOswXNZKH6/HSrj4Y8wUv0N3yWRjyZ73jMFBlCVtdJj9jpX?=
 =?us-ascii?Q?xv/M0HxsAFiZx36huwYsJPg/1sdiqczM3bmVmthSgFGrw25BiLYDZoa0btfH?=
 =?us-ascii?Q?fjsTpiKkBLbXItheWBpkPvSaFV021DJ2k6K8nIEgxKrKEY6H749il1DFj4ir?=
 =?us-ascii?Q?ULWXl5lWDWspRkf9oxU8QcJufNxfNIuOXmkFgCZ7g5/jrROZLcab9Pn0UUAe?=
 =?us-ascii?Q?iKtZgDaq/0pHIVipPSlYF97OJxU6PYuKipfMmWTbIrpG25R/x0tHTjEUGsF9?=
 =?us-ascii?Q?bamtjYCsLrnA+H6RHVX5vAJnwaEoL0tiB6TnGR0c9Q7MS3tryjVqt0l/0Lz0?=
 =?us-ascii?Q?wlYE1VS7w9+CQzpYTX8ycW4tF6Fb4HlIJJv/6em/eVVh861qmUCgSyFmewwl?=
 =?us-ascii?Q?cbU0U48YVC2K7HA09tIoClgXrxSM0R5EQqgqucD+LaUyCuENvyEnCN2EeTWO?=
 =?us-ascii?Q?9QUJxuRLw/w8BLBnunT3pxqnL2WyNAqLxUiAsg6BpLmIjauT7TZUR9gxxxMr?=
 =?us-ascii?Q?dGd1VgVEUikLRapb37kaghbLJFWS7JB+pl7za3dcg+zjKF/GB6Lc8iZhlXEh?=
 =?us-ascii?Q?tJISe+JeusLUFFCfkuwntXNkZgSFPc+puicHQ4vtN393FHmtFo9PEENKoQWP?=
 =?us-ascii?Q?BMDm9AR7oe9u67nBdHeoRzOrMhUweqAD4u3vuUyXj5Psm5gBmNsWyQDf2eK/?=
 =?us-ascii?Q?GU88HL5shHHmNCeTb7TMMP3tJDnmIvv8A+EklpRaNyoshDzte9pbl1Smq2k3?=
 =?us-ascii?Q?JdUy5eQoh5woJY7+b6ea8BJmHB6gN7h767bIFVKovco6ODqzrzco1zVGBKwz?=
 =?us-ascii?Q?eahINKDIzvcxpDw5AUEj+7y8qYGqfKbyE1XmJOwUNJqRTWRpR4kEPwNZZWCo?=
 =?us-ascii?Q?ffBwuinwC8Vmjoppo2QdU7PyQFlaJsDWYNpTsPAhfKIc18UsZn+SDh+DATeH?=
 =?us-ascii?Q?MH8N4L24CDx68FzyiOCGKHpC5zApNAhb+Kx9g0f1u1zq8kLWxjJgfqP4B8KQ?=
 =?us-ascii?Q?QWSbktbUra/dOD6CF2pgb+LkfPK1GBs6a116CPl3275gN9uU9xOsb2acsg++?=
 =?us-ascii?Q?rc6SED5mYCn7mBugiVAH6G+GYEWchEM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f996cd-b353-4c6b-973c-08de59a0411d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:23:15.6992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BDauAmMVUosQo2/vuJIA0oEkp7L4iuX3e/3aaE5CGG6/eXINcyp5tWUfRUhqodTDQ8K71M5eJUEOusYzjLQoYVNDiaXo6DwiHJ/PalJlfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8174

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 drivers/irqchip/irq-riscv-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 70290b35b317..2aed498d68f6 100644
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

