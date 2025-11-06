Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8317032B9B8
	for <xenomai@lists.linux.dev>; Thu,  6 Nov 2025 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762432722; cv=fail; b=doa6GGrfJtkN9SkIog+c6v4fCH+E7paxGlIGhR1VRDw7Z0wy0NpRJV4sDn79Xc54gzYBMPQU8Zg6MlJKXSjPdmp6HvOMKCXUltwFg34utmVZqQCX1FK/y6netc3NBUYcF2PL+sbkT2yrnGO3y/y4sNrgWIfmZJTkJIxNqrVjRZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762432722; c=relaxed/simple;
	bh=gQ4zNccu2bbzG2o3GJrCBL2jCjw4MUt0QK3aMgY8qg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ERiTxKfVRZFdTBxWNS+5NAnTHBXqbr6r3CrF7YZZGMlKLobdFlP04SmvtrnasYw7dfeD6pqwf24S3y7LqPXQpqxq+Iho/f1ikXp2So3y2t0/pN2LMx0z/NdXSObE1V9GHXHew6gqA6Sq8/u0oTMGsMMr6RUQ8PSBj28sdQYbnPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=hE13V7BH; arc=fail smtp.client-ip=40.107.130.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="hE13V7BH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltSjDO0uEjEZ8BBMLewQN7X2nhmOJrRhsQQBFrX16fiyC3uo1eU1ZkWeF9PCpfavCWY47yoJpgFq0cMgMINiYlP4rR63TElO/2m2W89rY1bxQI0hq9Qa+MKtoK+Gcasai6ZgNrnvgLVPCjyAMZd7wxSS9uXW8dYIrAt7QGc49apzwcFOgy30O1Jy2b104vDTKrTXePTS/6RXSFrW68zMXt7YnHcMVNJOqiJalKJsfWak2Ptj2WhI9Vk1mx3rdeCrpo0jh60wBK7HPcePwR0FPe68Da4tPyKnZjyHilZ/zd9JOjHmsG3cVwe7DaCKx3oCgcHOzQqgODshzPftMxjfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MG8gfQ0q+6gDdFXodgopaSf3x7gV/9zl/XGbOycoXw=;
 b=kFJZftdZzFh1D5hdOiWYvHE+ggo8c4+aZ4+lBpI+lBwLK1vOoDbckMdtSZwWz4TbH/Di8TmxDlHVocZGl+aAYNEqlGqqv+vakq7MJkJpE+Mv5+5cRuHPX/4MDd/YvaGxhZ89mNyFz/J+7Ui4hleI7hq0x7GDi2idVcsIEV4PtxUG4zKiX9ydZ3XJfMXMKfq/oG6hVHlA7oOi3Z40sacifkq0XxjQ4+K5zWQezSZ9BFt6iXiju1Sn8+8ugturg5GD49vXOjFey2MZBs/uVlb9j4QG+W/wmekjMqC1ybz7bCNYJWzFwwaGfyNLV8I8qc8qTkPEz4rPE5rsnub7WKjjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MG8gfQ0q+6gDdFXodgopaSf3x7gV/9zl/XGbOycoXw=;
 b=hE13V7BHWT8G35q2HE2HBUopdIYaMJfhEsdBcGcJeBfe6yCzekZ646DnD9+u2S2bbDUugbJrW5c3tdAubabSF7boayZxZttD3nmT5dcpz0ftpwuSrFw3FsK0lz4LiQsCENkFMKrAXc8fJBSe/Xt7v6XZKhKeYXSECXZXGlPIm+5UPAp/YI2/kunoDUQLt+m2u8AeEN7+iDpZem5t5vi/pVvVcqmGPgvSs0J9e5gqQp3TMggdUV78drLiC1vZXnqovRfyhXcgy+hwq/VyurGosDUhkUFtz8R8EHAlCsVwCTcseWHk0YheA68dvNwa174CFT3EOvV9alwtYfLfTZkJHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by PA2PR10MB8819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 12:38:38 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 12:38:38 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 3/8] riscv: restore exact interrupt state in native_irq_restore()
Date: Thu,  6 Nov 2025 13:38:17 +0100
Message-ID: <20251106123822.1160385-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
References: <20251106123822.1160385-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:610:74::15) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|PA2PR10MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: a4637b7c-24ca-40b1-e533-08de1d3168d8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lFdpyI/CoA3uUSwaYRX7D6YOtZEP59rtyCxxGNE9D925eeGZesLxs7y5hKQB?=
 =?us-ascii?Q?N5OAa3lO9oNCWQkWc1nzmYGut27QIV1bJ6XkGHQbYb87GmCFcmeAM0Z2NaKM?=
 =?us-ascii?Q?Q/oCF4B/uf+DlT4sD1bbcs6z7S+TZEKgIy1RpxUDGq8fomNyPCyXFcXel6Aw?=
 =?us-ascii?Q?0r3s/HVV9XzJ0vnTbMGZgWfYFz0EQ/UWve2omMeRmHpEAwDoKpovzym5lm8X?=
 =?us-ascii?Q?Wqs8WnZ7icRTVfAoeCj68/zgwh9EmpYtfwGbixnlL5APrP3iEQ2V6XiAL1Vo?=
 =?us-ascii?Q?vYLBhir6UwARgzdoFHvHLqY8SEwCxKZFnf7Z686E4BmGxffo0kgIEWd302xa?=
 =?us-ascii?Q?ubu5I/hrmpTiqDUGSezvlcCvsAiGDcDf6FsJX4Pu8GaS6BwFPIujJki+ZIXQ?=
 =?us-ascii?Q?7tRewPQWoVRZkSBIigXpwbU4HMraOFXxWJ6nX9tKSQ/aoKHkI5Tcpy0seaBP?=
 =?us-ascii?Q?9LNcgMAIQXFdrCQ76tg9gEE4adcg6ZETIbRRcAbEaienFnudzU5M3KmawtGf?=
 =?us-ascii?Q?uGu3JmTkjDDRTPguTpnxznhGyb+2yUCckO7N09CJtlNPNZnZaORGz5Fnl90L?=
 =?us-ascii?Q?u3PVXZOEjDUuLmd9uKRksEOSlmehhISp7VSNoSyK7Vu5RLPPrMUMKojKxO2W?=
 =?us-ascii?Q?JsvL0L7De+vVJck5EbJeaf1qKvc8nXOshqFIS99KxyZxcgzRm1WNqaecyOTR?=
 =?us-ascii?Q?8C0gut7tsbGtNACGdm3R8lGIYu1dgAKHUXBpBd7kTGBQlk7KFonFwExLdZyW?=
 =?us-ascii?Q?S5zVE6bZp/GM4GstIhc4ukbxj6pIP3mJooy5U+4MHGcwVWyqJVdIEGy0y2eQ?=
 =?us-ascii?Q?KTGHk/ifx7oJSHvBT0u7WA/6JYPWLTVaqXBHceiyeuAcN2M8Z3rSmav3xq3q?=
 =?us-ascii?Q?IX5e1WINu1zlleguKHZIdNLyRFszdFxqqvZ6TSK17jnqD9SM49H7mtqk8jEO?=
 =?us-ascii?Q?tCxZv1IbuJalEemOCNyYSJMfNOF/9TkjxPYOiRGIc96sYjjwCcP612VZmZic?=
 =?us-ascii?Q?A7mGNxRLjeZ6yzrmSYdiTrKiaZ+fQUVE1CZHH3PKAi6mbRNc3SyVkYtuTFjf?=
 =?us-ascii?Q?ZKaB4U5WpOw8z03KbQ11NTC3uR08GBZpSkp0Nl4DjTzJGVORaTLuNwM/HHAW?=
 =?us-ascii?Q?Q94ENKoW/47d1sH4lwz1QiGBfp9dwgRGGRHoFuTJiL3RxOSk/l85bOEZp3sC?=
 =?us-ascii?Q?6wwIyWu3+D2qrQtCs/f8U+iIIG7P3ogzpKT3g3msi407TXMku3DbPQLuWmek?=
 =?us-ascii?Q?2cBB7uk24CyB8LLSfeTDaxeeUVUwX/t0E7Lifnwwq4nlsPFHhlFMpFCaB/B+?=
 =?us-ascii?Q?YBKNLYdOAlro3TRep4f3+UTdV0CQAVE3/B7iYsnHOy5hgCM3nYxWmySym0dQ?=
 =?us-ascii?Q?JEolQvw9uDklvUaTfdOm3DaBPlvn411Ve8x3o4XJo4r5wDgU1xejTLlO2/XE?=
 =?us-ascii?Q?M+kQ/dKGA1TDCKhVh/j5IsOvRd7Qfxma?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E13qBq6WXD7nRwNXvXcijOYlAJQYaGerB/go1Di6BYgetfPjEHzuzeF99oYl?=
 =?us-ascii?Q?v3eR3O55dELZDkOmP6h9hqoNSxTLxkr3aK17XNltdTsBXDjD1qlpcf3uHD63?=
 =?us-ascii?Q?LBmz/GErpCLRexKn5gPLqrWZDaaDsRJQx5n0H5EHShFY5+lFcLrRUlrWPX7R?=
 =?us-ascii?Q?tACGCvSZOuR9UsJLSskcGE4sKaySrxqhHXbKWYASoGyAIU4oidOHlwMF6QGu?=
 =?us-ascii?Q?wY98LlZAiykIfjJOA9cpe+j+T6H4xZLuI+yOQohv8B8w/fN+ewjMipwwLvDu?=
 =?us-ascii?Q?N2Tv+whQIekkaCPHjR55TsXa/TzzMr3FmYy8Af9+GEGJZfQLVpZDTL/H2OW4?=
 =?us-ascii?Q?eyD0JT4Zv5+auhwB6EBu7m8c6FLWqM+eo9B+iB80G44WUueDiPYAB5FqhFuw?=
 =?us-ascii?Q?xmAIFZp2wnTnXI3x153UAfO89lnWzcGF9kFspYmnnLWF2MPd898DPS3y3TyB?=
 =?us-ascii?Q?XMGRJYt0lJjOTFjyOI0uQymz8ZKW1fOJl2JEO0PTVz2hRX087Od7uL+6+WXb?=
 =?us-ascii?Q?NhmzvdrCL1sk+udJG83r7XojI+dRMtX9QVCJ5lCmgBkYMAm7Gf/K5ZmLJ6jZ?=
 =?us-ascii?Q?a+hXC6LSvjFi4kRn+FsX0gXBLYD6F5Aj5PJqlG85Vve+hmntkNE6V7MJaZk4?=
 =?us-ascii?Q?d33feLmARSNQwwLeMJO1Pw/twBQqfTZ3yU6qZy2qTt1ZjYZfLDge2+an9CyL?=
 =?us-ascii?Q?7UC5C5OcnP0SlzOe913hQw8bQBNJcDE5m1pTKA9ES6sh1LFt9DGp5DcDl1lS?=
 =?us-ascii?Q?Ch+Pvilzekocclu7gIXmvACU9yV46HeaqzRkq09b4tUqHE++jjEK2bucEaNP?=
 =?us-ascii?Q?UuVJpC+pa/nyfAfSMQbbF7fuvOhzD7oQ6mYhFqJbQf97x+DKGxEGZbTGan+f?=
 =?us-ascii?Q?egeUxXVlZsqTeYHT8QYtOUnM7/nrhyNaTHqrPoX3Lyt8SnvGFbTi7bTkMO21?=
 =?us-ascii?Q?Qt5vQ9GqZ7rzisqGvbIESSOEywSTtvTFVS658d5rbpsrMU8qD+PwT4o60tBc?=
 =?us-ascii?Q?x3+wJD+LajudoWFprdkM0zG1eMSDwJXl9M9rcOmRJFojXv6U+YW+e5++BEyt?=
 =?us-ascii?Q?MWVktK4AHxB0LqPA00eKNWHJ/4rXPEBzS/tHOTrXCJXO4ihF5TfZpmp4E8cq?=
 =?us-ascii?Q?FC3EIvw2lfExP+e1X0xtRBpdbOBy9EGjEsbvdCT9i6/xsgSsNIypP122gozO?=
 =?us-ascii?Q?SXJJ1uPryI/kELkPGxzleVi2tW/qXiejZ25VLPzRddeVswmq+8aMR7Kp1n1A?=
 =?us-ascii?Q?9ScG0WW23TalYkCZDyVIn0CUD7B/uJuR6NzkER8b5O9f5/Q1t2/6CkdxgC/I?=
 =?us-ascii?Q?CIl7Mika0PvqjRDohw9Loh9YSicY+sGn+mLHqKpXiqqm2hmN9+0aOnuf+mxq?=
 =?us-ascii?Q?2s7rl+LurKE5DlQTh+BF6URp16WyoGIhrQwYzWUPaaa5rfSYPpatw9vz+Gpk?=
 =?us-ascii?Q?q6NDrmdCJM6deyATSj2QsN14mW+RejCwQUxB0ZQMiCrHrHv9x6NuYSzN4FPe?=
 =?us-ascii?Q?xY45v1midUWbfVqoxRSLjHmG7veyB6E4eFElBFXEyzvZljE2K68jVxG7FGrP?=
 =?us-ascii?Q?xCRzgAVz6OLMez6ikbG8UfpfSVkxM3w/6hxmUiyB5JL2hDC99bnRA+ETCGMr?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4637b7c-24ca-40b1-e533-08de1d3168d8
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 12:38:38.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntsTsL2GQWEYR+kJsFjOqdsvCVjc8lU+GIXpNL8Im4u7mmYAwJe8oT/42FhCKhQXAjQL8mPPI1xcXLE4fm02qaT6zThz5C9gIJTdEafW0YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8819

The previous implementation only set the SR_IE bit if it was set in the
saved flags but never cleared it when it was unset. This could leave
interrupts enabled unintentionally. Update the function to both set and
clear SR_IE as needed to fully restore the saved interrupt state.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/irqflags.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/irqflags.h b/arch/riscv/include/asm/irqflags.h
index c7602250e981..c3087b74752b 100644
--- a/arch/riscv/include/asm/irqflags.h
+++ b/arch/riscv/include/asm/irqflags.h
@@ -48,7 +48,10 @@ static inline bool native_irqs_disabled(void)
 /* set interrupt enabled status */
 static inline void native_irq_restore(unsigned long flags)
 {
-	csr_set(CSR_STATUS, flags & SR_IE);
+	if (flags & SR_IE)
+		csr_set(CSR_STATUS, SR_IE);
+	else
+		csr_clear(CSR_STATUS, SR_IE);
 }
 
 #include <asm/irq_pipeline.h>
-- 
2.43.0

