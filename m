Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A9334D913
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035825; cv=fail; b=lR5LX9O2tpyOIX/QgFAxEXdGeyvSDjxYo3plXiUbKXAJPCkMfNKp9NeI9IxIDfFOVnDs8vi35h0zpohVEDhHP8hjGcnEyn9U84wQMpqyp9sCpqYkKKqqR/DCYKyJqPlsZZ4oN2gqCtVlz9gR2lYO8CxbUjL/Nffuilk47nk8up8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035825; c=relaxed/simple;
	bh=p/TeAcBnRY+oeUJxT2mKKQnCOmVX7IOoF8VMEGFnYxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SeKS0vp1mjIavd43bh8Go6GbBoccca3UnDowUxKK468mwOwwTA2Z/dTEl1Y5ePhoQMRpFEQu3YlERlLhov0ugbc4eSgtBiUshNJr0qc2zH6kmu4npwWkmGM721cMQYpUfQGjrGAIMNFo3sY3nzGNTaaCjsinMgqj+HOu2vTDqkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=J4myVyic; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="J4myVyic"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCGh34LWdd7KuoRFvsF9UZ/dIobD6LjZzSS+jp1lQ2gQv9PGUkGNppOaOof6U1to3BrjEF/EmeTw/eurqHNZ/1ko8vyWe+N9ZSF0r4Dga0Dc4r9RtxOmT93Axz5D21iWNbzcIaW0Hp80quD2noYZ5pMXdc40hHDUOw4xm11UdlhWXvNsKC/Gccig1GG949ZeHVMZU3E5SFBdixW8ghHw8I+VcCbU1/pQNlFiELxtYctW6QHLaSXRbejb+bs91EiiepLSI1D2Q8JOEnV7nty0kJUSIGYXxOmTd28LuQN5D+RGfHz3lJPkP4WxN0LiUGZy9aNAjgoMlxjMQftJiiq6iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41h7E5maVO4mxEN1t80VnZ0HZZpsbS8X8+b3YLSjR+w=;
 b=CJD1zdZ8sH6rqnMz2ioaKbxC3+osPoS/YnkPMJIvnGv9jtRV4YmodTbOdLyYppjzCdY6/Ol998H0z6lrAVc7nFTlN7qGRevIa96Yg4O/8HQVeNdlce7nE3UOvKbi8jcZo8dEtwpZRu7ilfVEYVKw0GNPu1LZ5+geBu/IBSQlsZiSKo76e+mM1/pDBSbf4P0xOWsRz+liDABBuprDy7qzYeQwN3Y5zk9xWs3btTHS42cSHdPrpCgNZXtufozNTvgLCX1Stps9/bcyBuA0r5CBC7DN3RGtuG0OD2Xu0kildfH8/BHzFnelo0XMDHAJW6XN6eluhnd6/1h9pa92BK4sJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41h7E5maVO4mxEN1t80VnZ0HZZpsbS8X8+b3YLSjR+w=;
 b=J4myVyic0Sj8QQ5OrMX+0HIAsmXm1bYRFBX6tfWR/ir83RzyEaj7eJCUkuzpiQtAIQ7qD7vZm7s4sh6xS66XTgsXBaLXXpL558x17kBLboce2H7Oy9iveHAd7PGJlJnxKwmIlkKTpRqbj1jY9xwTTEdA2YFrvpCozHtl0PvWIl91NgqxzVTbN4CwvNjp/dzAzB/F/zct8lcJfJeFVQ49JSmxiJvM42soO75GDVMva2AhkBmFAhcRJYWcmcwVAbO4ASV0VgEF0lWy0Xr4iVp7kRBt2iBEYhe9TA7ah8xKkla0wbsKssDFIdb0DkWso50R9pemgUcy9Pj92/VCD4y8Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB7859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:633::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Thu, 13 Nov
 2025 12:10:19 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:10:19 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v3 2/8] riscv: only store interrupt enable flag in native_save_flags()
Date: Thu, 13 Nov 2025 13:09:57 +0100
Message-ID: <20251113121003.416012-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113121003.416012-1-tobias.schaffner@siemens.com>
References: <20251113121003.416012-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:610:118::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|AS8PR10MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: b8b88b22-a4e1-480a-cd1a-08de22ad9cb5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HIkB+henQcQ7inHu+yZnw5rirSxsJx7bzLyeab/Pn67wPQfsDmmgoCsYnYeq?=
 =?us-ascii?Q?VZQb1xVrohd29Kcsue9d58X6DHkLC6adqN2DXLaSiJAJCQW8eTDyDtRqzQ5k?=
 =?us-ascii?Q?g1fwYG1UjKOmjM7cpis8gq6qzZzOrchXFPtn+XPvZq5pkNz7rRhKlzbEoIqo?=
 =?us-ascii?Q?zXSoTiH3NIrfh8htBZ/tYSMEwv9VeOxk5blyxM8ymrN6O7p+85kCiOwrlgUJ?=
 =?us-ascii?Q?vAj0rX6FjOowfhJMiaH3NiOyaFkU1O2NvW8HhHmcf+p+96vz4KYlvL1mjq9+?=
 =?us-ascii?Q?n7LwZZUrNcHRZTjspONQIJ5qWiUNIKwdSR65qIrPAnTSB4UQzo48qcv5kspo?=
 =?us-ascii?Q?+CmeX2o4rOsxpECuJ4BGhRDSoT/Mlurk4G/ywEl4lXrC01fzrw155jxGvTBV?=
 =?us-ascii?Q?PsaSfS9JzbW8KqlXK6K9TthTm5jIpTQ0pin8+bn4EUw6TqkAkmuZd3xKSIU6?=
 =?us-ascii?Q?X5pFswJbRSUd32YsXh5kmBNi30DW5vra0FWU1eWLNbnFiePkmWqqLqiCYl5g?=
 =?us-ascii?Q?aMK5m6ILgz/PhEcMzbuLE1sx5Dg5dDxRrxZxv6yDY4ndfmzcX/zzeS6Lc7zi?=
 =?us-ascii?Q?bC6jiQmmQWH5Lktp/iEx7A9uABGYvmMlMNKkn/A85zjqBV2bjr47yr7iWDzT?=
 =?us-ascii?Q?sJvSwjx6TAyISPL5YxHzq50ni3cGulffm0tOl1Pio/Y2wJgfKscYVSHIHK98?=
 =?us-ascii?Q?KInT1uOw6CyNyJn+PAeNo7DVak2K+igu46kTvjqRvDuNJLqzbrKzP2Ils6Sx?=
 =?us-ascii?Q?XWXGZf2pQuscKMwFvU7IYIrADKwsyui7dK4+a4bQVIkTJv6mGaZzsV2VGGtT?=
 =?us-ascii?Q?iaqssdpF/KwUEeq+j3XfFM5A+CLGrd2z7Tu99qGBTS/vvqukwXPlH3ac5frr?=
 =?us-ascii?Q?VbCaEcLxiCsAmQxrBgLJuSeVItK3NhZAsj7xJxXLcIvYBCzv1HO9ctxT69S2?=
 =?us-ascii?Q?rf8Olm9gP9V4jJ7AaEKncPe0XUAAJbPrv9DcTqHkHBoxOtrYN7pV7d5UbEnL?=
 =?us-ascii?Q?X/eMxBMa7VIF04VQgAfbcnV2M36CTb12NxwNJ8Hu8VFf1/oBkGkExV3sGpMN?=
 =?us-ascii?Q?LN99tfR+mI3PyPF/h70D9x1+WPF++YQfGUTdwAAfY1w0hR1PBcFA3Ps9a8HJ?=
 =?us-ascii?Q?gpQM9tbODhlNumvrJM7P5oPPxuzl+isdsQGaBHBtktzEIXKSO4ffty4V8TpD?=
 =?us-ascii?Q?4rgKvuF5bKaO33MIvhECB24us4zpNszGf3x+8kzxrmBARvfx0MLsSUyn+sLA?=
 =?us-ascii?Q?V8cHcjvDsJnqWEbomk5BauTVtx/s4xmh7UUIFfjgnedlOryq92S3GTCsIUwC?=
 =?us-ascii?Q?vfrWqnw3AFc//oozlmttbcoMow7ARFTTrUIjnuC+qn78M6YSgOEnAD9/dAGo?=
 =?us-ascii?Q?mmxcy8Dhit7a3nRVQo9oC4hWloUTGCUtz9Fnje4EYnObWLzWHxgRYyqgtdK2?=
 =?us-ascii?Q?ISBOqNVuqWQRt3dONO+/0sV5jjgDlHoi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8A0Q9r+6PhWyq6+4J9MCDMvrPaYWyviIghbBGHN0zG9x04931+sBQa43f3p+?=
 =?us-ascii?Q?m5R55Ci6Z4nYbRRh907PqcS6jATEm7b1BvmemWl3S193+agrH3tsUlHzP7n5?=
 =?us-ascii?Q?9GOA4krT35rboXbEq7wEYOE7/LXM9jQKdiZQvD7lImyxSjXIqchtCiou8XYw?=
 =?us-ascii?Q?1dkf8xGDwUJ7gIIbu4UKlB0727JotdDjp3mbJ9QLbCl0FiFFTDvHjBYQlBrx?=
 =?us-ascii?Q?cb840B+BjJ97ylzk37g6L20PDUYXUi+33aBmvutEAee9Lx2Vd/TBD2IQZXqp?=
 =?us-ascii?Q?bSyO243861wfhNbLi17YJDkjIBLw5nSseMRZ8j6ZH0BCk8gcG39lfVNAAdkc?=
 =?us-ascii?Q?O3YB0DqsGxlTyKHMNQCwsN85ztaV0eEB6ke0WstUPSL3CK2n9/4X/SnvrY2y?=
 =?us-ascii?Q?JzPoP1078+vB6YoEOcJCnDFWqcuLukP8mFrQ+pheYPv7fY839sXZaZMd9wim?=
 =?us-ascii?Q?dpT4BcffHkIDJ+SNWqjKWDW7aXeNH1ail9yom3RLM4UESkvVx1oNBjabK3sn?=
 =?us-ascii?Q?HBzUEQ+/cVuX8CGHu55pPVaZtllodN7mz40kH/4i2Fa0UE/1rfYpuLMqpUSt?=
 =?us-ascii?Q?Y5uDLTOJdF15K+EUivMQ4RNPhon1Pf57/j7BqFTsTClz11xILpAcZebRcx3T?=
 =?us-ascii?Q?CysIZFvatW8mPLnLiyBCv0wRjP2GQ3PbLkGiqgjTmT6hvopb7cyNUC1p17qi?=
 =?us-ascii?Q?1LqkVJCE9IkAECZgodVtkbv9/1HqaEEnMfqrS252ZBYVnqQszi2LGeswLR/7?=
 =?us-ascii?Q?BhArl5FVHvquJGefXHRspunPo82GuNlFhmUIdNvR/ziSAjdzMiIJ0ULui68G?=
 =?us-ascii?Q?sT9xsXJSqoMtwCrP1dfscu8boSbAsAja5pdV3FBpuh7qUeIXx1VoGIdWqRhX?=
 =?us-ascii?Q?ydkIenXqZhroHhWZ5TO3hHKSkC6S+lPbAnJCFCUcZrW1AlmT50d4kx6O+4fk?=
 =?us-ascii?Q?dLWL73NfE5UzXLR74b9wlpKWArc84FX+jFbp2bALcsbjBHRpZvCQLr0UcSrz?=
 =?us-ascii?Q?1UB3PCSxAc+MFiH3vPBREBrrzsooJ6uBxUwB0nfxUTIIiqjkzWv+4ufs0jne?=
 =?us-ascii?Q?bMhCq+gUVW6VZGeaBeX2J0ZKO75QlxA5G6JbAHlXfYhNnb1Ffur8jBMbp3RI?=
 =?us-ascii?Q?zk5fu+OO22+X0HWKxXYIXJHqF+sBaet9eOTz/CEZJHXnTpLD0vicZCLZ2+3M?=
 =?us-ascii?Q?J63fV+IbA3hEtfc3is/f5oScvukuOOYPFgYrOC3R2GSp460JKLJiWr4QqnhT?=
 =?us-ascii?Q?cr0vcveKE4F4PYYfXtbwmRNA0heay1C2fq6D1qBjjZPM70D5Y/9wMaHiC6Nh?=
 =?us-ascii?Q?kyuVcf81IFEhdF/ba4ujENyIIYBjbp0H3+vIpYuyZ8k35fFAbPTWmMlnBm2V?=
 =?us-ascii?Q?LH0HMQydAW76jt4+whfF1Vr3wWWBmPRAp8Ruupjg9dV5FTBI5Rkp3/jhXPDi?=
 =?us-ascii?Q?AUhvx21wH9pXtFDOV1nbXfqPVIk0zPkVw24KhpTNIz0Mq9kFw4teJT3JuwXM?=
 =?us-ascii?Q?KBeQX+M4/WFw0zNpX9F9AP4uNDOIYiPAOYMCgxY/dBpDNeL1SCKV3ekkGSBF?=
 =?us-ascii?Q?pYJq0gbFf8VrMXkl4DdF4ad5F3hPtKqHO3QG0wBfwY5+5teHGmdmaLOLFVGY?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b88b22-a4e1-480a-cd1a-08de22ad9cb5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:10:18.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9a43TOYngvDQE997luqqUS630Yj5vEfCuwCGzEkRkmbnlNX/VkxcqG7vO4uGouhcpoikVJ/RB5qxgDgoxBxartpFeEFz4C980nMln3Evl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7859

Limit the saved flags to the interrupt enable bit (SR_IE), since this
is the only status flag that matters for interrupt handling.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/irqflags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index d488b316735a..c7602250e981 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -12,7 +12,7 @@
 /* read interrupt enabled status */
 static inline unsigned long native_save_flags(void)
 {
-	return csr_read(CSR_STATUS);
+	return csr_read(CSR_STATUS) & SR_IE;
 }
 
 /* unconditionally enable interrupts */
-- 
2.43.0

