Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8352ED84A
	for <xenomai@lists.linux.dev>; Fri, 10 Oct 2025 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089949; cv=fail; b=oQaFamnApFAdJN8n+6veyyN0SoKJKXSp8L+CjU0bRKU14TeesdtkCH3LfeEPvOo0DxPOBleGjXAo7j5PETFLowtDzQTAS0kVQLBeac313+zWRWLFpqKGTETcnhIOhr6Ev4zI8LZzwmr2pRWjUi5ybIBuaC9lwTbn4oEHOoV6Qhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089949; c=relaxed/simple;
	bh=3XpMROtlW7+u8Ecg5Ohtp+fblhtg76TJLD4GfWggwd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ydm71QAzTmGq6bP0zzDVN1uq5T5tVQmJ8vMRzsTp+DsKTRphRHoptfmHJnKs1qf9RSpUvK9PNQuND9Y98L+SgQF7lneH6URIA565hOcLxkpYdW+g+gSDrQ7rvsE7MPfR7fQXxbVYggeHRRQ2rwiGDdMYBqhMFs874CeYIbH2E08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=C76Mmozp; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="C76Mmozp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeYKy3gpit1gWmcwKBzIoXi6j+dAtS+7Qj403XdeRy4m32s4KbkE5N3ddc7DyCgGW2Gj+B+ww9urpRrfyRAxAlaXwKbeFKGU0ICqeKFW7eyfLcDcIK7+yfBWjwCGRogZdz58sP7SUE+KLj6N+i6ZxuKzGTfG+scGFbVhvuMygqDlZoxuseHCr1RTIOlVoOS4IWaJ893cPqL14zexU0axqyDJOMCPyw/nLbdy/GgVjZbG/t9h+qsKVNOsaCzOS40P3ldBmQDWsIWIcu4C8ivVHWtojA3om5wK+U9EYKvIwuZasj4HcaHD9c4sXJjvdhbBiDM609YlKICaNNBEcB+1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuaVhMBwJ9g481V5G1iojLtt5K0x4MIzj0UKGcRQT+g=;
 b=THcNUjrSh0yElyHKL09+NUk++BFZgovqvvfy4RtEmehamOokxwxtUcR2R23FJ8ue8qpID9vqSSWjInX+UFDzfPh0K0PETR3p2pP7qukex7xImMgEIm5+uH2/uw5Nx8nyfa68QKg9xAIY3E9Z4GvihE7uH+zNov1Q+20QCw3p3TEg3cYfTjClN93viwU6oapeFIlqBffth/2sae7DZGJ5Lsmg+nsOYETwLlU6CPieWMsQTppCTrTmrFeCIEVviuUC2wTWSUDiD8EMp7Ifmh2Y2VM0ysfC76R8KWbNVQ1GGmpqbd/T5aP9bwmuMuMtbAgTJ/ifp8ceZmgkjkyic5wwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuaVhMBwJ9g481V5G1iojLtt5K0x4MIzj0UKGcRQT+g=;
 b=C76MmozpjbJiVHpz4oixnckx2tS0aQWg0ocMu3l2Uev92f9vmxEgnSlEElByWkpFe3ENjsKQQSmJnRdcaDSq8hoM8PEpoRlFBKzrSHDPQVJo1uEYwVulMCDUuqZeHfPWL+P1x712DtkTPZRAmcYkukC1lEdcViNEy7EhPuOH0UDoJx7AunskYADekHGLF9fNyScSf3RZxjmK/TN1gxNqayPBNZBdvvjKDQW5fs0ntXnZyj8vpRtSZplqYtVisP49fVIB8zQ8KH58GuqFNJnNOHF1GWqytPjVrbfc7ei/7Y5eecJJ+aJzl65OiU+1OltXwlAVNO35pwGGkoOYTwxhGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by DU0PR10MB6084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 09:52:18 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%4]) with mapi id 15.20.9203.007; Fri, 10 Oct 2025
 09:52:18 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: xenomai@lists.linux.dev
Cc: rpm@xenomai.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH 4/8] riscv: save program counter in arch_save_timer_regs()
Date: Fri, 10 Oct 2025 11:51:52 +0200
Message-ID: <20251010095156.3756799-5-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
References: <20251010095156.3756799-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|DU0PR10MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 25032f81-0ab9-47a1-5c5f-08de07e2b30b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z5RNwfUxi4lPcH6K6GsXBLPv7yLb9bpzhD7xg1m4Wr6KEHg8o5at9BmpqUCA?=
 =?us-ascii?Q?3kjQViMv+67R3qWhABY7juObAojYL9FT22ZdwSrzdiuJpuXVYKcLlonRLpfx?=
 =?us-ascii?Q?8OBePlnDITgsth0ATjSeMIy2ZMiYNfamdB2Y685fAFg+x/SVuuwwGQxKYrYP?=
 =?us-ascii?Q?fNr8Q1RTEbErJqZcJxjvnezRJnP9V9Z3AuUqZTDamKm4MCRhWYHOA6l3aN+t?=
 =?us-ascii?Q?tIsAsgqaiUSFW1IG/kIr0lMrtgE/JHxlzj9CC7XTfPOVIr1U4NzsAF4bDQL+?=
 =?us-ascii?Q?qZaoOI5Q318vIlyiB23SRI7G2yD8kR1sToAHC/fxd0In4hhuMiPuPuw/rVS+?=
 =?us-ascii?Q?+7/qmd4pJ/y9BnS2cGaOI23knCq0SiWE7UALn+pMPd4qE86gu75JcX8Oa+Y8?=
 =?us-ascii?Q?MjERQoKX/roFEAuTJKnl0iJpm6PjHNPQVWYljWVbpQroQ89Tnmi65AuC/fVJ?=
 =?us-ascii?Q?XMIzcBk7jTE++M5A06869j0n1APFLLJvjcqlDi6xsp+fkg34ipuIus2eAZhp?=
 =?us-ascii?Q?/Cfy+PBhAx6YQ9Apy7MQWPOm8hyNu9JdYO7Lq0bKNbMbZHPe6Z2To5ZfMrO4?=
 =?us-ascii?Q?a+RGSh6ztuJHpls1rLYFpAQmMmi+iV2GC6FHU0CLYZbW7zUO/9YHAvbe76kO?=
 =?us-ascii?Q?e8MPQ0NV6+wLFF8AYR8nWFSaA3aNjPiAF375yUeG6WOwotl6zDJDQ7I193aG?=
 =?us-ascii?Q?2v9OWWoM4c3R+xtj7QvuyYqnD1ccQyWT0RVAI30ZYMA2Yubs3eqAhNZOEhKb?=
 =?us-ascii?Q?54PHwxMt+j5eU1+Bzn//oRpxW801I4Z4xwoWYvdeTavi1nQRZMfW0xRTFF5n?=
 =?us-ascii?Q?6zdeCW1FVw3MiyIxiC/GDDBtEXK1lJsLR2eIwc0pSXMV6fvnc4ctO07o6sg3?=
 =?us-ascii?Q?VWVIyXtfF4yIpyypDXcIwGOLmyAvIxrK6ZIVMe2x+AKn0WcSrSM+zLu/2GHy?=
 =?us-ascii?Q?WbMossn3obpnrIyFlfa6/PHb57ocOF2a+21OoXZ458YsZSQ7PM5I5MR+K3Ly?=
 =?us-ascii?Q?Q8fnUDlfW9gkAgmjd6R6EJghd3oaSpFVw/ovashemoS649Vq6v1uUN13WSIs?=
 =?us-ascii?Q?jML3odCCAh5fxxifBm+D7O44IFEJiSzNwvdMzchpsgrA+sUALYrROjYM/gOx?=
 =?us-ascii?Q?QfP47HfnGKujlmvkhBjnqVrA5igvPgGEgfeQGnS69t4UvzClsZlfYSKEjU1a?=
 =?us-ascii?Q?y+fyd8dCwZkEh+LCp/qY6SRi4mwURSWU+gv18tIiSrxzQvURaS/C2xYMwDkG?=
 =?us-ascii?Q?CuB738xOCHm34FUOBF+GZ60kskEZduxUyyou8dKFsZjYx7MBOitfPCVWB19b?=
 =?us-ascii?Q?w7u0k1wzchlQnApR+GOJQOmpg/KOPwKq98esEkEUAiDNvWQ9FB2k64ysO9DR?=
 =?us-ascii?Q?Z7rcOx+I/M786Y+YEpKIS48i9WeTrArCTgdEBVjG6udDjMU/IkSHJnAeyer+?=
 =?us-ascii?Q?iyrXBKRtiVbVORZQ70fJ3wAEOcVcX/Y/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRyySBJ8bM/wFHyCaOMAYZI/ob+7FhS70ls70C/8oBNl7YGpEQGSL61GHY9/?=
 =?us-ascii?Q?rEIbETu/ldkRR1Jt+x1oqP+lF2LkeseR9tnoDr37aHu6i/lamp3LJCmuoZKO?=
 =?us-ascii?Q?fxQUOFYry7hiPt7sH1Hx6FWxgMi7XhpQTYRWEUvxmeAzRUNL2t0rZzJpmlob?=
 =?us-ascii?Q?kOw3vT7VPotMY+k09JyZ0mgDYcF9SnR6PiUZ7M9JWVIzL40xdR4rtNVKghxQ?=
 =?us-ascii?Q?GMCf0kTAQcxhPdXkxdrx0WFwaSbpF9BF23cI3Y/JpJ7XqS4ry4FMMWgYypjV?=
 =?us-ascii?Q?f40jWfLF1BTsneCftWNhrWaEsQDo/9u4vBhiHVTS3weNvp7O4yHP5VGyBt3P?=
 =?us-ascii?Q?d12IjUt+v8doganjbv3MIREssWJ0xJNmeijiUpx75fSu9NCDf1bpGtThIWmV?=
 =?us-ascii?Q?NKSBTuv+8sHjtaoQZRyKkhlGuRYBHxn4Ds8+TNU6zh+af3Fph7JJ6OwtcxvK?=
 =?us-ascii?Q?prDvZLDOgm1Ukaubm5BwOPWsVUXHJpbsmdEcF9akXtJ5IGyk6CXeHi8jGgUh?=
 =?us-ascii?Q?Nrz2q5r9XI9ZqxmHAiXHa8bHaMGSy8Z3/nRfLuCTRoaLA4s3u/+U4FAvGsBI?=
 =?us-ascii?Q?S9PRWjcpXw8QL6lax8RXpnX5Fav/oS902cNlyRqDzOXMzA2KmseX1IB+2adQ?=
 =?us-ascii?Q?Nro5HWzc/SIniQpKxYwbp6c98LCiYasLMsk4Osv5SSmSixXxbL7E9GWfiRGd?=
 =?us-ascii?Q?KIzFLQ6MU9siPYg14Rh1VadnPKzDpaUqD2kFNt3ycqRnoZ8yvWvy3mFkEQZE?=
 =?us-ascii?Q?NsD1xn5nI018bqfcG88YRnvc8EMP23/3hf3udtS30RzAXqQhj7V7ey6JRYHx?=
 =?us-ascii?Q?Ix2MaJmWIX7F1VzdR3d+O3b2rdyGu9dMdSLSh7ecLIZZ1FnHadghdrF87z1T?=
 =?us-ascii?Q?Z3tUOlc7uyVWHzkjZBAsr9+KN9Df9XMVz2lK5grOnForCI+sbih+zfz2X1xY?=
 =?us-ascii?Q?3jCUxgqZZ/p5mymm/zeKfxalkmyQ7fovKLH/5rYTktSf1jGmhddRA/km/MRZ?=
 =?us-ascii?Q?Y26H1W+FY/iV+LEzFCfVvVUa2p0+HmPVYyXoDdmXdsILaCJ7SL3e0xnN0SWy?=
 =?us-ascii?Q?QZPsN1Q3B7vP6eatqq9Dyr+1H6Oe5w6rJ3SNBb5DjibtBt37eNaJXTXdy5De?=
 =?us-ascii?Q?0RXoRtEy9DUfab/9KUGftGWB6Dl/A0Ci75XFcg+3ijSAss+jX+vabP1C6DoQ?=
 =?us-ascii?Q?bie8jC5WkBrI/34lIMkbT+CXQjYVUkkwl5UOxRzEn/lIyxNytZBG/mBNfdPJ?=
 =?us-ascii?Q?UFOnwafISoPg/y1BaooXG7Njp+l6If30sEZv2ip7jb4mlXDn7lTDhazaGN7f?=
 =?us-ascii?Q?f8DXbA3zYhXHBuHALvg8CxKgRTE9v4f9Fq0t/UcOEV+GtMKie4DD1Z6yAu6H?=
 =?us-ascii?Q?pRcyobvHB5Y9FNkDHyCb68KR52R9m1DKuUdADGK2oNdUF3/CYxRQplo3XG+F?=
 =?us-ascii?Q?pRYrBVUOOt1LMp0YaNxcTLztGClbmpVQhy6uKUjSIURLXbr0nei3SBQ/WMXV?=
 =?us-ascii?Q?ow6ddiXdI9rdSH66zwG86u09APmXNO+p3WQMXZzEQb4Zuv2V+lc3Lsv22wlq?=
 =?us-ascii?Q?kkMlhU/1RgSkE5FU70E5IYvkzGRaTKe++INJ17HdpPUsw12S70r3MJki0pkl?=
 =?us-ascii?Q?gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25032f81-0ab9-47a1-5c5f-08de07e2b30b
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 09:52:18.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPcyEA3d/5AG6KbuK7D5ze4+WNIITnTmWHEsqAXIhTLXLnb7pCtFpo5imXUGMzqQf6Dt7jmQvuxroZ+eXosZGcpGOrZRG9PA8iNLGMzUDLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6084

Extend arch_save_timer_regs() to also save the EPC (program counter)
from the source pt_regs.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 arch/riscv/include/asm/irq_pipeline.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/irq_pipeline.h b/arch/riscv/include/asm/irq_pipeline.h
index 030823745787..c479ec44b3a5 100644
--- a/arch/riscv/include/asm/irq_pipeline.h
+++ b/arch/riscv/include/asm/irq_pipeline.h
@@ -88,6 +88,7 @@ static inline
 void arch_save_timer_regs(struct pt_regs *dst, struct pt_regs *src)
 {
 	dst->status = src->status;
+	dst->epc = src->epc;
 }
 
 #else /* !CONFIG_IRQ_PIPELINE */
-- 
2.43.0

