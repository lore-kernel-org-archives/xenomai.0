Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821C34DB45
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035834; cv=fail; b=c769MzNLf0h+w/bu/xoeSxacsMn+A1GujWiW+FdZKd0Xy0TtAKSbmxTSJru+4+wypRoPRh8lYnB9H5FpFHAE/ul/e1HPNxZxuMaCStmQsrfGSHQR9uGyCf+uOlWtzHXywbiowCpgXpZ/+b09dp0JOwl3IVkCEn+vo/m5g9uEWPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035834; c=relaxed/simple;
	bh=sYV28jNGWOQDoHcR/+Ex5U1BO57v5SUs3Jx5IPlOCu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KAoHIQYO6BnOmbdDdcvFZZ8r6fd+8a8Vaoq/g93zXf7o9ewoZUBB5FesHk/XY3V9x9zmq3r0J2ANNE71vqqiCgUVLBsd0aGnMpCBOimAVXkG9yjR4edicZsdJ2jeG4F24mHVCTNOmjtfuYYUNAHDQWiYON10YR4VyPhZLaNXgQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xVQ7DjPp; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xVQ7DjPp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZMWTh/uKtDfe+0iWyIJ+cDVTxDK5AzwaICL3iO7bmq+3chJWJoixCRsXOBpIhjXzHhEkdu1cFy+Szctp8DukHXPYUlZ5ZaJWBWsE9u7MAr8ok+qOuc6lLVq+oyaUWkmSWsvyvTdrxDiNoqOPa5PRkw0HRQ0iC7u8vtw3jleEKwSDdh4fpV0+R6E4ipnsnjX829HRqYvesm1o13QJCqDDd32AQOhA1Ga4OoXR5MxQaPJwYDUfINPOd8LSwP90qoNk/Y46E6DudYcxxbUPPAK067cDeoze+V9FXEiSIym/RL+MTnk7mMAva4aRZtshaAevUYNbSOwkG3toQPm34uR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arcdjm39MreY2Wmovi+aVrIwxs0gciUrlXPJn46cwFo=;
 b=A3T2xp+gJRZb5yLJXntoVoKERb00hEqg9sPaLlvO+M8mKS1Ip60qNuwfvPlt9K4woDfUq67ZlhYQiA145oKN1QkEUtIReHjltn+G91SqsxIU8Ti+zjyLtua3o4BW8phzpB/Agx/F3Lt3JkWuW9uaFwuoFEJLom0Pfd0LqbNkho4wI3gghvsfPseT8x28bDvN+N5aoFb9LVwKa07yPV0X9JCd8MRVe86NDozK/hWaltd6DEKqLrBA1PGsEdV7JBwWf4JiUucXRILUbBvDJH2mfvFCWOkjIzH4p494v8hSHYcSiS7gKn4o+Cx9EJGukjTLphqzApyO50P1iX3oHn0WnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arcdjm39MreY2Wmovi+aVrIwxs0gciUrlXPJn46cwFo=;
 b=xVQ7DjPpBa6kLwGQOlUhQ+QuorsPBGK4na+vPBrzx0FmYy8S6a4cyP2LOQSZrivXr6j6+KE2yiFUzSBxGptG6RVtTGN8X0+brkjWia36n8JM6cbnyTfQBcn/teGd7O45UhGSQLtiudvYuMfYcEgwF7f9gxSqlZgxYct/qkhwW3Txx6uvaMbKF8rQKT/qod/ZADMPtq7A7NMnfv51zMO/gHIvjF841wpdkE/0lRhW06Wta+6iIts2HInLgBOAjjZAQoGl0QWt7k4Rf+RRrmRhfhEC5qSNPUgdwFUxvIkx+7zt09hjC+OPozpgps34JaySZoRm8wITOW4pxMBzcJZsKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DB9PR10MB8286.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 12:10:29 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:10:29 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v3 8/8] riscv: no inpependent irq/softirq stacks when pipelining
Date: Thu, 13 Nov 2025 13:10:03 +0100
Message-ID: <20251113121003.416012-9-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DB9PR10MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f87d5a-fd39-40cc-e080-08de22ada2f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?scpefY7vPJuHDxn7FDOOhRRUgvWGIhBIbQtijg4VGl3Kce2vi3o02ZYI72hA?=
 =?us-ascii?Q?OnoqhAJDZebJelsj/UXxYrTgksOChANOW7TqaSJkgvZerz6jmoIEV9MI5eV3?=
 =?us-ascii?Q?ZZ0HZdTz7aRkSUZCd7kaVsV9QoHmKYJLfaf2hOr+50p3jqWSaHmg7F4kBOI+?=
 =?us-ascii?Q?ZgzXl9IiZkGOshDjC8rf8G3TkgYF9uvTJJoe392w7P6sfeozDLcSz+/nNfoY?=
 =?us-ascii?Q?kDTzJjumo3a/04otp/VZFRvXhgKRjduiKhjHaYPMN1uStKXtxOE6auZ3o4h1?=
 =?us-ascii?Q?XbQYVKjZMEZcDP1fyIwStQaDSJOw+79e+qevZ2qqqTZe6STLUsMakUlMLfC7?=
 =?us-ascii?Q?ViBAnntfa5HqkRuvI+9EnVAcHDw6uVkTYN8R6PSAjuzriqUL8VFAyGbtZnck?=
 =?us-ascii?Q?2eGtAwUvH/AkLVhLqJBA/k5lfQfNoG6ejRyXKcePI4I4YHtbZevBcIzpG38S?=
 =?us-ascii?Q?NbrppOt8Mjf+cRI9+oCnkq/AL6WCyYKLk/irAU3zs2QD0PhH0syFvuBks9UI?=
 =?us-ascii?Q?HogAruXY8m8+m/JIu4NzS9r1bF3bLw50/A5qyunUvefwUmNxIyMDsJj+L18r?=
 =?us-ascii?Q?q5MQXvLdt3n/v2khJw5+jTVDFf7+IO0gLDaXMqysPZyQgf4unt4MfdegNExW?=
 =?us-ascii?Q?9RRRIQFQbuSB7CQVlA41SDUacfwx4KyEW4IbE5RUxBLLSCBpEwZyRvlxlpn9?=
 =?us-ascii?Q?zX1wZnwClqwlqgaH2Fjam6sjRK5czo/kM1xB/L9lzWisAiq4EmapfVy5yQIR?=
 =?us-ascii?Q?fV6WboECJnIHUn4yfklumWUp6csQM8hjRLT7s3TgPAWXbPsNCZacE/TJ/YWQ?=
 =?us-ascii?Q?EHIsFSCgCpLzgVSoQqEsxsnAAC8pn7Nu2NoWcLt0OUhER0/xLJTjY6SUEVSL?=
 =?us-ascii?Q?+tP5i1hmpP3Z/NF/fL6U9vuJ9DJeBY8sbMwHFwTMFFQ5rxIfQT/tgHvxTFUZ?=
 =?us-ascii?Q?5Vj5L2EDCz+mbJrfhBEhuFvrU0Hx/wBMklfcOXA1QWAIUJ8UD42tAywXVDQk?=
 =?us-ascii?Q?IF90a5yGK/tdmd/HYfh3aXUHl66Z/ukW3FRheAIY8ZZQdaTJU9OOxKc8TCqR?=
 =?us-ascii?Q?C8umj1fgfRIaHEHtFrdiNIcCSZi3CClKnrQqaC9qdejHnKZQwUDpcOed0lTT?=
 =?us-ascii?Q?VP4NN5cwRuD7nTAL/yUBHxTvuKnSi/7B2fc1NBVaoYuJOrMM065m2cvV4ktw?=
 =?us-ascii?Q?RzdbOs7UdTjmZcLMi0clOMDF2FGv/XucjNSddViSITJe2l6E6n/r0bGcinue?=
 =?us-ascii?Q?+SnNK4LrfqSnG5cAXURnF+3DsEVsfQMOHM3na4hxYLbm0Q760H+ymCUcQ264?=
 =?us-ascii?Q?bbdaKADvPqwxhn0IC/tIxFltRkOhnkLt/O/K2ELtOAHQVa/6GlnevQ8tfPjm?=
 =?us-ascii?Q?XKs7wa5Jwat7vAG6KHOVcP8KqSkM3KhYExYaeKk9wYZAQq9+2cdqCl9kYp4T?=
 =?us-ascii?Q?l+z1aNJB057foiF448uCYpfg6jz8Qw7y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NKXz+aF2iI8l9dOmsBqbF3OmodwxasDUmO2tDgZxtWEPNJPcT1uICaAt6FZj?=
 =?us-ascii?Q?KursXeyadCiJdNVM6w1KL9kd0EnFx/WLmViaKdB7uVkq9wLGYOOxKAe/oIwl?=
 =?us-ascii?Q?dUqXwKLi/FKKrSj0LnX2j1Bqtg9RNRxtOB+9c9fCfJ1PYeOwnnsZa/1sOoZu?=
 =?us-ascii?Q?X+H3/SXqAPyjj4CiVH1NSzAqMl6+6Oha7N0vnATyeuAD/mgXnqte8VBHu+3u?=
 =?us-ascii?Q?NtfJHkw6qBpTVu+o+Jn5h5TESM67/cHXK5wMklyMR0B3xMit2IRY6VVm2UhY?=
 =?us-ascii?Q?XkceOHePkYC7Cy+aZnzbNVLuzf0zBnDp1P5G2HfPPp0b2rj/v6gbvulFW3Pl?=
 =?us-ascii?Q?U+29G0uNB88SKe7KFRM85O0aJ7owQgYSYVtqBZsHpeVd9nU3LhLVdq8wMp+8?=
 =?us-ascii?Q?ZNMRr1MIEgmd+5DpCKrkh2A1n8ilwIucFnu8pVr3RtKQZsPqq0EUBLf0FaXW?=
 =?us-ascii?Q?3IYPZyCOE+d6Sz43c84W+VUwQhPcQKEw0Snpq8V60kS+IhneTdVlDfxpA7Qe?=
 =?us-ascii?Q?QB9Bw4DrhMqGo7aKmnW3BXPby3kWcpfoFno/hD8GeGGWtPeBklAyWtz7VY1H?=
 =?us-ascii?Q?E/pBioC6ogCrKwpzCprD1RSMFHnCy9OuDWXYUgJZcUElsW7XpqWi9NPkDF7r?=
 =?us-ascii?Q?6LADGxooyV6zUS5HNSiA5tCPAjHXp5nEKIQX3cu4WDOXBmi3wKISpxP7As+j?=
 =?us-ascii?Q?GJg6P0fJSgg0tK5FSEW22XFlbm9mY4RQDQ+f2f8W3c/gDe8hdnLkp3dbUnyE?=
 =?us-ascii?Q?OlBg0GAqsLf9Vc2t0FM9sfkRrpYutZTKCAlYot+mGFg9PI96nulxdloYpGOj?=
 =?us-ascii?Q?2jJuBfanqtzy6OhjKbOVAEvF+dUr+SPIU3KRUsdf8aVKZ5pNHzc+jhCKMXk4?=
 =?us-ascii?Q?xrc9mbcLeLgdjFMHXCty6mvReba6muvcKQKvHpF7UvORmM6tjkWJNLUfdpAF?=
 =?us-ascii?Q?O8dE7YKg0pjNhqaW5X50RQeruCMaDZALsk8ENs7NhWNvaKiPu1jGDY4zpduc?=
 =?us-ascii?Q?JZQbsOJWvuoVMJU2OKFIwZAOUSRH3Y9iFeJScCuMCWHtQ5OPwuwuATtzNAav?=
 =?us-ascii?Q?par9IwOhRuRyM4Z/JytRIOANxVpBWuwjnS40gqurw0KdlYMBVgWf27ZPCjjn?=
 =?us-ascii?Q?NX+6LUzJdt58X9Vmj4Og4fxnAMAhkS2t1BrwQUiTHY70BErhzQnQXwNkKDX/?=
 =?us-ascii?Q?WhZoQ4VQ14U0r0KKjt5z/gP+9D1Hyofk20r3RGTajEdF+VsMBwAWNbjgDbbj?=
 =?us-ascii?Q?cFLrzUwd1Sdpi5dJ9ha5YIIzLGfqiIM3cAp323nr1qvrNgygyDJShpQsr5r8?=
 =?us-ascii?Q?cTKKcIxBprpGojQMp3I/8vW+ydlWwnaMqeJ88JY3Z+1vjx/PyLNJfE2qNzzp?=
 =?us-ascii?Q?K0BDegwjvDrk7hKKK6uYIQL7YX9eWNVgmWRWUrZ3/jG5gXNbE/k1LWUeKrbv?=
 =?us-ascii?Q?1+KtJNNSUoEeAqqY7/7gfZ88jNzH+EE6qnvGt8T4cs+zytaCOHoIV53a66Mo?=
 =?us-ascii?Q?lQUfjHrZz85Yyf1DQ/fvKU/8z2D8QkAIWN4eA50ClO5x0D1IYAy1fpMXkIPS?=
 =?us-ascii?Q?XfdcJZsFDnXXQlJS3BNvpwEyi0A36iUKubEjVosb1kZaUWKJOebk5eqjfXiJ?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f87d5a-fd39-40cc-e080-08de22ada2f6
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:10:29.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMZmAQwInynB5rc64h7ofIgd8/PlFEbz06vIdjSH0GI7pK7GFQ2QADCo98ZQWqf1jxCiwLLjK8oK3e7czv7sojoc7zcoNVTmu/8GY5a25/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8286

Do not use independent irq stacks when irq-pipelining is configured.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5cc3df56a58c..0e720f52261a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -770,6 +770,7 @@ config FPU
 
 config IRQ_STACKS
 	bool "Independent irq & softirq stacks" if EXPERT
+	depends on !IRQ_PIPELINE
 	default y
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_SOFTIRQ_ON_OWN_STACK
-- 
2.43.0

