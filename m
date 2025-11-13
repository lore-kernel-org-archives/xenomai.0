Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012005.outbound.protection.outlook.com [52.101.66.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2F34D92C
	for <xenomai@lists.linux.dev>; Thu, 13 Nov 2025 12:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035827; cv=fail; b=cQLn7PUwDPQl4kVu15gFlZzhwdM7RW7+xWhergkZS26g1YqQCJvm9eY5UV6fmLJ3e5F0Kup7DoBTbhiDKgK4C2MWdAUVsRK2ZqPV2CJJOujYIcvpGot9A7P+6/YtQNsIk7bRmID9yDCWZvNb0UKOGwUGt8nQNacIMFzV1pD00BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035827; c=relaxed/simple;
	bh=gQ4zNccu2bbzG2o3GJrCBL2jCjw4MUt0QK3aMgY8qg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WkQqUSecXniQ9zHjuFuZ4IIN1M327dXJV3d9Gsc1UiJhJys0272FYPc+KfS6evpbJNujOoLdTyPEPcfcBxxijBBRUzQp7mnxPalGHlBexqOv0rHquf4j6Rr4h9tl8B06DP1UQDX7zLVjx9ThchmIB6gKetHNvgdiZZiXaj4V2hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=umXRF/iH; arc=fail smtp.client-ip=52.101.66.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="umXRF/iH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HovKbKkW9bM/BvyG0BTofc6pW1xdLt4oCUlF1xFGDk3tfJVs+0RoqKRfnCirC+ZEOnueVX3FpiMXOoJzXkR0WUFo3mklbCs+O8n2Yq82CzUHVTNScfg/bGk62q+bWMXDAPkHqJoaMgmnpz9LqZ/OIVI3tJJ1sNVPWFiJX1tcTS6Ikagi155ESPLTBG3wxZeCnKCjdaJr1jOmXt4fIQAKtFvnIUFnyD1/kyya1zizJsueHo4snqfYu2JcjJ1fvijwIn+uoC8+NwjXPaUKAYh4bfVblSZ4PkFZPbAvjpiD+QYNOJa7VDr/6u73U8ZnHbrMeBgfB0yGEXCX459LiySANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MG8gfQ0q+6gDdFXodgopaSf3x7gV/9zl/XGbOycoXw=;
 b=tptwqIQ8QZidhV2ndch5IbtoNpo6Eq2iP3Srlxed7LsDyTbUUhH3h/sQtzWKYhcm/fUYZ2w+XpWNdc1RyVDcdtF0/OWKZN5f8+GVZF828hFkEMOBoRUdTEQQzArzJfDJ2v0g9kIn4tlNzbEBB6Crwx5CrYNlLXQpLNPZDQZ2GCdKKpbjx1Jw6V9hxnAGEPTQiD+c81LsMQIRXwHchecvm0i6aOrL5prObPJp+Kk0v7tesZXqLIrBnJyT4zhI8EcqGaDphTIZxqlD57p2JdbKZJsN02UVkAPSgpDhqIHGVyXB/0dP9ftjTNO+LAVWIw3WYCQD0YlNJ0h2oZXtIYRv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MG8gfQ0q+6gDdFXodgopaSf3x7gV/9zl/XGbOycoXw=;
 b=umXRF/iHCKKthcGB26zjquIn9hARbb6pulLkBS8fShY5qxqol8UUDTHvnx1H2X3gu6l1q8o23/lDR5wLGjrhJXOHz8uCNv2tmv2T5oi8EPXGiGSacU/uxnHh/4piZMSJq4PqDH3Ryc3/YNKswCnzJzmQicR0vQ0ipO5OUrtVIWX/b7+lJJVXspBeRtS1ANVUg9Azzwb2cPf3ukDpExcPue+N9PMylHNoYwQT0ew5G6lQQq2hiEeAXv5e5Me9bPikovQNrYxeqgo0YW6knX8vx0mRrc9QO+YAUtRkty/HlpQiG3+98pThW2ONfEA4plg+EQ6cQyQ6xO3bCl3j+L45KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by AS8PR10MB7859.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:633::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Thu, 13 Nov
 2025 12:10:21 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 12:10:21 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH dovetail v3 3/8] riscv: restore exact interrupt state in native_irq_restore()
Date: Thu, 13 Nov 2025 13:09:58 +0100
Message-ID: <20251113121003.416012-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 727dd174-ad33-4daa-e4b3-08de22ad9dbf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3/65kP3lTEuUBeAJmIIQw3SsFgzYXWpsdQ37lZTh/Fg0NRD3XxQc8wvBcbEm?=
 =?us-ascii?Q?/AlqNpipp1xEf8fzhKzZqJa7+guT5wRdvdurgalVoaOFRotcRbVrG8uOxdRc?=
 =?us-ascii?Q?zYT9UhRrTBYh38wLkWQ0w2qyRy4mPtqKX+7vDOecW3gUs3XSJpvpswtW//Xh?=
 =?us-ascii?Q?zHIMYFp1iaL2JmeAI9gYpjQ995vwq+ikpBpU1JAQf2z6OlkBe7Ww97HHc13U?=
 =?us-ascii?Q?fwRJL8O+JrMgtCwEFg6pQ1woqG8Ptaajy7quE03q28rApiOnAHdAH0IOX+Wu?=
 =?us-ascii?Q?Hf9g/GH9PcRFJmcVsyBpH9c111mMc1XvxUVQsWPCFVEfYRmtOo/ZW7uuYIL+?=
 =?us-ascii?Q?wEof0TSt0OjiEFwZTzv0W0f0cfrpaEaRiMlLfaFa1Ze8/lqyUEksO7nTTuGj?=
 =?us-ascii?Q?4rOU6BEZT4DLL5cfQ/PyJO/ZtgwaFaABWbuPx0/4J7D4wmJrg/4jl1RAR7jQ?=
 =?us-ascii?Q?W16YHrbU7WRnnNCPqr/E4pLzO87U4qXMLFseL1BLOeC2zekwV8o3pHqeQMdx?=
 =?us-ascii?Q?06TjQMCtEbLZaWpHlGD6bccCYBLxxtecF+CYJapX2F1ObfQJbai/DbEBMOZu?=
 =?us-ascii?Q?cD4NYQFwVJPvGv/h83OIGlhC4JE7Qjqa4hZAhlfFAjrAmzlG58F7gZDOZ04e?=
 =?us-ascii?Q?qNGg3Gi3wMJ+yQvZgqZ/x6VAXSYX4aYsl+FxNrmoEcMedCMUsoTaUOMu4OuZ?=
 =?us-ascii?Q?NJcdI8/RVs40+xHHj6JyYkxqHV/gl7VjzoTH+c3hk+qKrpl4ii6xEjg8s0ke?=
 =?us-ascii?Q?JQqMChDWmFgRJl4WOLVZzTkhqWKS9qvS8MGeEXUONPvN1L6CoaT2WyPzQdSW?=
 =?us-ascii?Q?x/bvMzx0jU+wJuNF6xGWcz51WwPKufIKawsJGqrMZj4Law70qFdfNHFxfyat?=
 =?us-ascii?Q?sYCduJtFmvw21+ZwQmUWZ+0EqF4ccZrp3A7IzHlwEB6sVUFTo++gppCfLvlX?=
 =?us-ascii?Q?ibnb2WcQpfRbf2/S4tfylfqv7J1wZhZ/XT1raCJSTtnJyXbTzFFjDMvRVPDj?=
 =?us-ascii?Q?TTC1/VXYFEODWaJSKSiF4EGNu3qPrZ1Y3nxYN21+F2HdLFPoW5odoYGNnSwX?=
 =?us-ascii?Q?AapDrnpzT0JOac4Pkq+kKO6U3RrVapzmNSk+5cR3Fzsxn+NgbOP1v8mnbgOl?=
 =?us-ascii?Q?SvlcpL3Ht1BGEfSjfe+me3XAVQLonhZgecUuo7JUsHuK/Lg51F5YSBcG3H1z?=
 =?us-ascii?Q?d0SNKpJxwuTA+KaSvTQHCxeg1bC9EKildXixY6V2dfZdjPTJz65oUQjPvQTK?=
 =?us-ascii?Q?2DTcOmcFognVL62SIRoW3aJOWtEbWipy6WFrJ+Tgh0zNOSWitpqaB0ig/DVj?=
 =?us-ascii?Q?RVGtDDkKWasQXrhYZwtBXpfuDVTOpyfe40f58uEGH6CmpkpHHm50kxM3nJtS?=
 =?us-ascii?Q?nF0nol/8gB0OZBz6tL5LVlZ0zc4kxsp/oHvDnU2pKJFmXFIsyCLfGTB1amBa?=
 =?us-ascii?Q?S0F+CrZXvVr6ljOskBi0QVwjfKnOf++N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?77pMbO56T/zNvtYbmwZ9BCzM9cZma0Tdm0ckupAU2x+4nPLFZkWu5bd1a433?=
 =?us-ascii?Q?+tAVTlx9hHdPYJZzL5qqWoCd+pq1iJm417qRItDnbMoVXX+BmzJZh/kOyYEV?=
 =?us-ascii?Q?EeYBPaOGn4ReyEK0eSo1Xq0bkl4/AIcV0Dkf778oEVGv/fx+dUBEjw4n29Tz?=
 =?us-ascii?Q?LpXcNvKJi8tKPsAw8Ipmr6+6+c8VMwJO3xJv93eTsVkewXjBTtLLxGCD+TWl?=
 =?us-ascii?Q?v67i6HfzbJAuwx+Uvn0836Jo9k6E6WQESFaQKn/ZapDxCseMd/yroDPMEAmi?=
 =?us-ascii?Q?jVJw1jHDwKUULWLTkfLhmdoN8jf24VRZ3sNGODPagBMT52iqIOWl0tG6X4e2?=
 =?us-ascii?Q?x5AdHNVrkkt7OYN3MhdENeNyqbGurMz9fiFMq9JBzCNrbeal0i3TfyVOgYX0?=
 =?us-ascii?Q?SFIyr3GzN7stu9eacIPLrVQKmNkWA+QrgCxhnaQ1OqBIPMMUsuET0z5p9Ssm?=
 =?us-ascii?Q?1Qn0wuVxJ54+y8tNwCkrZf4u0jnIelyEDGovz+fk6cSmMINKFoOi2TjuGTff?=
 =?us-ascii?Q?empbDtcVaYS8cps6z7vSsy4B3JK5l9YVe/6yYGG9jGMWYksFhG7muk0Cr1Qd?=
 =?us-ascii?Q?1CYjRWbvOpaUc9fgGR0CW4lcZ6ebQnKTPHFXCP18fcd91dghCEQAXM4ifUeV?=
 =?us-ascii?Q?ewloSxT3YNLM2EHeExXuS2+7j4VndhQw22hLfo86uhRRpuWk7aviFTlIorM2?=
 =?us-ascii?Q?hOOGKlGwM9tDIFkOogIjDhU19eqVdvyszdRGOVHCSHMi4phtTSHWZYCtnpEv?=
 =?us-ascii?Q?e4nQYzo/Ya1ieiebcSfsRN9MiMhHWcRwQLvWfXmUAOT0xSbgAHAj8YG2wKdo?=
 =?us-ascii?Q?0FNn4wLKncWEzP8UwftXUX8WMCAnGt9caZaS6EAUOEj5imzQHypGCZ/8XBTg?=
 =?us-ascii?Q?8NtweIpsBpCP7XzpkpY7EKKLaZvB1pKPsBWV8VLUUaX1cGlDffXnHMjLYqHv?=
 =?us-ascii?Q?gqTp6mraE7oM3vBJjUlVPRUIM5bh5W2QFt8U++yxqo1c1Rbw5iruhAupqi0O?=
 =?us-ascii?Q?CmZV/Yb7H1VtzlkMyrrJhbaopugOcQd/i1lwF7v1dqZjIKoh7JDeyNhB4FmH?=
 =?us-ascii?Q?FK1U0h2DxNvpEqEMY7wq1JDJtWJ2P4eaEFfO1JabLwZ/4DVF3QqM1GZhLc4e?=
 =?us-ascii?Q?sM6gtjkuAgkG1L0Ndci3LkqZO8S3+0pYOn7EHYCnvWPUH9o1kCwoFZUWmgje?=
 =?us-ascii?Q?uW0eXVDSAEZoiHzynPMyedIqe/19P9B2DwjJhFBuvxZSUmud6ZmHmYFPUGIt?=
 =?us-ascii?Q?pB1TrSIVTDYptRr6/PUvUddl4BujmR68HWx/v1OFrsq94jw97zXhNcVqL0IY?=
 =?us-ascii?Q?WmRI6fioK9A+reWn31EtKOnspSUU3j14Kv2CkiEWmctNAIQrcRAAvBeTYwyW?=
 =?us-ascii?Q?MUyYO49AZ3DulS9JRV9ZEqrqxC4Sdi8rP2P83zJG1M8Q1/FVCEhvEuh9mNTp?=
 =?us-ascii?Q?Lq7UuUYd05lVvUhzb81zrCGs4yfo51cGu+DUL6vdKkW3TV8dg/ZoGufLTvmy?=
 =?us-ascii?Q?iIT0DDhpfXJcmXtZIjW0r6QNe108tDqyoryO/FGTc8XuEjHYo1qltTE9g+1n?=
 =?us-ascii?Q?LHJxBd4bcVk962hAGJCl2CVQ51LlFcEZRoY8v7mjyqEGlFU2WYSLPG9tbCUb?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727dd174-ad33-4daa-e4b3-08de22ad9dbf
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 12:10:20.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFFkecJcShCCI9g6VtI222t3mqX0A7CdmO0gsqy4dB0jWR7NGkMTQNIU4RAffNQCt1GcvuXUPHPHxPu0/ayaOKKAHvV+FzchE1bed8Q5m1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7859

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

