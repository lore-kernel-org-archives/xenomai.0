Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFEB32B9A9
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432720; cv=fail; b=dppqXjhvBFyYUhKVsPplJGYNhE0qQWm9reLbb71qgktzFWKjTJ0/h/NQcNt9tITMSdFaKQGaAL0mRzk2T5Q9s7OcsExFC4jcnp/GMWt9MRFpXvbNahrD4mM9hXe3rfcXkEaEcufgB0dEji4bi64JcF7erj9vqpn4TBy11OToRu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432720; c=relaxed/simple;
	bh=p/TeAcBnRY+oeUJxT2mKKQnCOmVX7IOoF8VMEGFnYxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tnU4Lh4ry7OvJhIdviW5/ef7zRe8Mv8DYFdJe8tJI/tlZOVSGi6lX16+cPGU1JEG7hM6+p3DE7M+yJ9UsldLOGH9VRJdDJfHaPpjZi2X7Hyby9kKfKdYbpP4FACiyv0ZVyep9YsLI/A6XXMd4QUMJxac4bG0YgcG8ycu3zm5xYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=teLiHipn; arc=fail smtp.client-ip=40.107.130.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="teLiHipn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T111Ne6h6rWtTWI87Ve76QnrgesRKFRpkCtIfse3xoFQNeOdUboE2m50+fRp0q4hfK32RTrQGtwZSGmAqcK7StKC0kuM5rP+QKIUsiHC3UXvMgF6zg8IlcBmqL19AhheiD/uHUP5EoMNXBjlSneGLf8/xMubq7nrf4iKO7oXjstgRUOebQdSdvY6pNQgYvP9hMRQazDE36SIuBqOdw39vX97qWkhQMu6HD73VK/x+rR6FGIOZKJgm62Kre65LiVxfG2vHD7JIZXCaKYCO8K6wn7Q7Pe9DrEURMwVKMf2cgcKoSCxsS5lnyv0gr/NkjliBK+zt46T65XdsyW6QLcWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41h7E5maVO4mxEN1t80VnZ0HZZpsbS8X8+b3YLSjR+w=;
 b=yL1TASxRIvm5rADur9KO0YD233eMFbSj3y1fcGQwgAQNhWj9A7CRNVI3lfEpR0DwBkaZI5rHE7gkE1NY1OUkY6HMa2QCBBLC1Z4XRYEyI+FGuCxKdihAAOL8rRqrQdIwIB0uS4WQ6qV2glXg42vyCSES/tCt/czwxNfUtYrZC06vUliWtpj6Q0Pqqv1mpSRUJ/Nw0Y7EcceF/O2fkgBZJcm0fWKAGWRhO+ge4aFaLXOthjBDob6z+LyHk+v8DmRbcZVSI0KC9TQWo5s9Lt3Jtfogih6Co+fhkszPA3DaBOyFj6GuWH4sSpeQoS0QHtXvX5wSqHn1Xd6bCf8rBvKafw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41h7E5maVO4mxEN1t80VnZ0HZZpsbS8X8+b3YLSjR+w=;
 b=teLiHipnFzlK09r7KTnT+vG6KXQYalI82JKx2fKakbR+WnUwevfHWyi2fNlVRKrG3cygBorJrUjNij1YfptLcDhZM+2getHdYpfB9jTAbTDQz3DZzKs9X5DwMjiHLS33b4RqK7t8wIA6zvxYWtNYWT6ABxvQyfO1VZjc0X9swV4CBORMxtiCjoqwu0LhZbJrlhFRn8Cg8wKna50HyMHJZDjWG69gLiPou9HaY28LnaN+l6r9rYtx9aqwdrodmWYVjgY44aolQSvvTjdzLjnqKSaCrl4uWIYjYduJkWcK9Mw0UkEBdaVSfIx+Ds+VVEi3TA9ONAY+/RLhyvMThl5rkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PA2PR10MB8819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 12:38:34 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 12:38:34 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 2/8] riscv: only store interrupt enable flag in native_save_flags()
Date: Thu,  6 Nov 2025 13:38:16 +0100
Message-ID: <20251106123822.1160385-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
References: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0065.namprd04.prod.outlook.com
 (2603:10b6:610:74::10) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PA2PR10MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: d55ec22f-bb6c-4a15-7dbe-08de1d31667b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sLaWrWwyyKIaeHi3ZiFWBfvNU6DcI+Evl2Q9Wxf0KcTD8dXmA5npjQV4g5kS?=
 =?us-ascii?Q?kkV2lgzqup/4R1uESNUqAciO6BcqRi2bASFf0oda8DurM9WpdTkqrpJcX9RA?=
 =?us-ascii?Q?8niBv/3iFdg4Nsh0F6bu3JBu+d6/J+wyzaCUJxcNipNeF40MyKWULc3EhIOF?=
 =?us-ascii?Q?qDGc3jwwq2TWm0L72R3sut/ndUfFilvMZNSWpOyDsS5W4NXoTNLiwZPO9kG9?=
 =?us-ascii?Q?tr0aaCT6blwSOpeTUcnhOMzb0tHeYGKZC+gtXrOjBQ/TcwkLcSwbe7Kb7AZ+?=
 =?us-ascii?Q?d60dzikEO3fU9KG86XCudBlxCW/59oi7O9YYXm5Ny2MqB4xDIOfcJfXmDNYA?=
 =?us-ascii?Q?QozTd2yOPfzMpb9oWhYE+O5PB8a2xsky88JKhWj5h1fOmFhwOzZYY70v2bIV?=
 =?us-ascii?Q?jnWifvS0h9HWGbNbO1QgsZH8tMfk+5ml2Sgvzi1x1s9JTxf4zdSsNORBnfdF?=
 =?us-ascii?Q?Wu+MyXt6sjsyQqhLR4oMlTFOuhNNr2QMASP6UWaZSye/ZDMvr23voQzkNrnn?=
 =?us-ascii?Q?ACpT6L/GhSwvvyGrF9FcecBY57SGdF9K9pSWa8WkgDoNei1Le7dXcy2Zb7Mn?=
 =?us-ascii?Q?DbTFArnYaQ/tY7dHWP1istS5yH0cCcy8Vz9gDVUjf8Kk77iI5ytUSxATWVLi?=
 =?us-ascii?Q?XvoAzLQAoK06ZMst/rQIRsTnQedQwSJlSOwbkrdGqN1ts48ZhTsj0Zoej6CM?=
 =?us-ascii?Q?OQkiKeA+eeTknXqUpcgPmAaV7bI8W9Q+n4dD+xeT3kjNQOkeeIAasQJDm8sF?=
 =?us-ascii?Q?diFn4sj46TAwfMkdX57BJdIUZQTbz+ozo4rP48fAV/+tq9F01ExRqxldn5uv?=
 =?us-ascii?Q?DPC/IXAj+2JKTEIyr51l9BMcbKeR2zuG/D9AziCLe0KQTXUsmv/3TskQNOpE?=
 =?us-ascii?Q?9Bc84Uui8xGUXxkN+g4s6rKqMAqyIdaSR2Y31SRjUz5bZdgAJTQ4DFyqNzA9?=
 =?us-ascii?Q?S/7QbZqWcZ5kl/linrLxFZmH/cd2oHggaYSu5wvzRQEQOlb/2saxvm1uvNjX?=
 =?us-ascii?Q?Pwwhr3y0CDjEz77H3tJurrUZJdeAX+WYWH+vTeon7eAGKRKE+x3OQ+TSnE2R?=
 =?us-ascii?Q?hACAn1zhaYPsFUsGBCIaNiaXt5EiDOM2czKfkjjWcU8dw1/nQ7SeM0W72OMA?=
 =?us-ascii?Q?HZGv4y/ta1nrf5oeKsa94xLQHXLY7rP4f49vwtaU6Vkp98J/099WguLFE//e?=
 =?us-ascii?Q?rJzI1t4bfeMNREy470tgmGL57FL3ctyg0E2hinFG356sfL0YliWjR9eur1Um?=
 =?us-ascii?Q?dEbaf6WFrvh+sZGfURVOsg2KnhjvNpsjN5oy81bq2G0LQipxnRjKHW5qrqSt?=
 =?us-ascii?Q?QCBKSIK+scO4QXvtr1NJEgLd2j2UCKckEit87tj0p2MMg5HC6V8PtiT51OZW?=
 =?us-ascii?Q?Uu4U/80lF4eKWwJYxsXOMN7qitTtwlet8Qv24zT9G8t2gyiR9ebltLQ+/hRj?=
 =?us-ascii?Q?ER49Pon590wLhm7w/LJrUCoXxM0MKEY4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6UXQJK9lyIQZRIKLzPGrj4hwPyB1kCqPEtlNe/OIsiSktesr3TEvKbrhEk8R?=
 =?us-ascii?Q?IlbPNeXPc7/MvwEu10tHDP6IPVYwP6slcziPTYw9ebaDdL5vz6ZRv51xXx4a?=
 =?us-ascii?Q?GTHK2t+W1CBCJXnFG6fWlfN8ycTZ72BTmFbZ0kB/PmPCI0zw8GJ3qf/HsTOK?=
 =?us-ascii?Q?8/zT73Eppnmq4Sl4aMRFwvWfkCExkqOkywyQPxW182YtRHN9RlXFmQa6KRls?=
 =?us-ascii?Q?GTUCi4nf063ZpWKTU87gxxTqUD6rpMdaQ4GeXx/M7QWqwAWbfN9B/qTtJkiV?=
 =?us-ascii?Q?SNcm8pLPeLpMI/yhvcFt5Bu7/DGahVVd75KpE1lb8s6+JhyOWfphs2od3dZs?=
 =?us-ascii?Q?1lVO2erXv3j6yijlp0a0DdLv614zH3vhveJqx1gSoKEYtQqB0yKqmt6SNsgA?=
 =?us-ascii?Q?MZty+DooWLFgrWVc7ufI4Jfc6i0sfkSRmRSLzPkgmJxStkCWF6VxYvelg/su?=
 =?us-ascii?Q?GC7K+b0d8yNuQ/gI04TbJ5zEY3dG6YeDcWfMj4KCkOINbPheqtyAI4GVsy8L?=
 =?us-ascii?Q?e21TUo+9AbsZ9vVHzzsnD6kofHLKBmYXzZwuG4M3Q0dz+4UBl9ZSGEfxv1vi?=
 =?us-ascii?Q?D42OG5T4sFjzqs109KSC7ZoNGrmszI305+XUF5hvkvLoFtDd5RkpRdwEVwvH?=
 =?us-ascii?Q?MJ6FibM3O5UiTE7/hBaTSLYTrDuuOGRTf3KSR+geAshdsUn7gMtX0vtLuCAd?=
 =?us-ascii?Q?xqaii23MYIhO/4nuELjCPWV/I7iuoj3ZekuR/wQ7U2RMWnoC+K+Xn0vU/fFO?=
 =?us-ascii?Q?Nw7rVWTRHA7zzEaJW0BQBBzdx8z/pmCpLmbIqftaG3Y7EbrE2iblumONMOJM?=
 =?us-ascii?Q?T7tGGEvJuasPHCQdFgi60sqGC0aAIXRYRid7AcdLdzaNsX//mAIH8wO7zefH?=
 =?us-ascii?Q?+vohkv8wiKNm7dt1LPLwFSoTZ7mdx4Ym9LCws+TFeRgtnOKqhnVZ5Rlr4pCI?=
 =?us-ascii?Q?Dk5EK+nYfVQrAelVdv2/GJz04Z9KrrTVbrrMB68sLvj/98VUG9KGHnMimO/0?=
 =?us-ascii?Q?3pCIpo53pLcnzD5t/JKbNQ1RMoallYYkvehdP0W+4dU3C7pukhyd7pjyPB/2?=
 =?us-ascii?Q?6u6A9qV/L7QRB8wqtbIdLqzOTxhf5PePlE2DcJAaPxkxKuQVxBCdEkgwoemk?=
 =?us-ascii?Q?MngQRiUECUKQEK4pDXSanQ31sSMW5WzCKmlenSw5cZjdxRFeY8AP9ZdXbiT5?=
 =?us-ascii?Q?mho7249WGlF2D4qNFfC5ebe+5ZjRlDxMu2dMUKF9cYKcj/cKWJSbvrynXUvY?=
 =?us-ascii?Q?+v/qjLonk5Eep/1qhSmAUbIGdurTwZoAQ/H3dDsJ3PH4rsWIvvmTnpp1A7WL?=
 =?us-ascii?Q?+ekLdjCHXsc7Dz1o19j4oq71hPqK4YVdBk3k9Io7Ycmtk0EAWw+kzpTjN8Xs?=
 =?us-ascii?Q?sZB4sB9VajMIRW9I5RmnKGpr2bCn+Ya8t7k1sbhCS/EVpUd4xQ05W1AdzkML?=
 =?us-ascii?Q?1Dvjgg/c1e61vABRFyTuGCcgFQdGthWSj+LqjzvlUzwQN3/hhKET+v0Kukmd?=
 =?us-ascii?Q?9PnY538mdRIZCMmPb5AaKCVKZOHfqGgR1PW1XH4vgFse/IfqcCLYPq38G00j?=
 =?us-ascii?Q?jDCD3+s/7mlCSv5MAbrqF2JBJPizy/m67f3xvlctTXba5HgtKbP3Be2L793p?=
 =?us-ascii?Q?K3UJvRtmMaSQD/gDOoM6wWY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55ec22f-bb6c-4a15-7dbe-08de1d31667b
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:38:34.4944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fs6hM+kAmWAMAj7OokKiUfwBkJRlXHUZJWq7l5AHmft223D1EvhCjs5jQ55QQk2XBc98fnYlDHswiHV2UTkYQXVNAa6pj7a/zrIy/pOqjSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8819

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

