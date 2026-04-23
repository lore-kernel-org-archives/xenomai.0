Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010051.outbound.protection.outlook.com [52.101.69.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441030EF92
	for <xenomai@lists.linux.dev>; Thu, 23 Apr 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957382; cv=fail; b=EfCqwOZtOuYXus7vM8C0aBw12YDvpqV24MvYSTftIeY5BxOt6daNzZpBTFKWqaAY3aNA7ecrk368CpOvGlHI5jx+S7TpRPGZ3tVc3srKd/vkQc/Rp8/fT+D7GlNVqeXGXc069GEc4FOf/XQ5A1QzueIq251zquQJ2ueCw9prbag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957382; c=relaxed/simple;
	bh=ByTGHMnKPdF3nbLV29uWE0tx98rkkIAOae9iGLVuj3E=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=LLKYIt/vASRNFa+nrYFwQ/4IZCrPaKSgLJUSTnv1sUtCs4dzlOVsS6Rap+3AxwgyDablHbwu/5OYLLSYYA/9gTiB3MHMIpnnCtJUOQ2UIM8ZgeyZ0FRgbx4JJWGjPpwqC67aJkKthQp3IqjV3nQCzoDdM7YR/UtVc1SQbedL9NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DU6c4VnY; arc=fail smtp.client-ip=52.101.69.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DU6c4VnY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpoHUXBJgv1/YzbDMROISaOmIGVPnx+VENF1ylecgezhh8eCyI/8H0hwSMOuS+DpSiaczn8+LjPl0AH7399Y8zmCiddsm1uHT0/8skLJO1aSaNFYVvI+VRsIR5QE65W0xAzyzfnRQ0xOrR7g3udNLS4Pj54+nTb94YuNfextVWTI6q26texgkn9jVqfEi8ovdGj3O8exTVNhmDMKjWRpsZInU6/EAXRIiu8z0gDjHffo04qnVdApM25oPVS4s95/BYPDhfBUF+af0xPxEPxh0Cbz8H8HWHEKpQITMjvefzgI9BnhSZDxBTF8ty/gvEdwAeccvGydstXiSDeiU/+9wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jr/XhNwrm7FyjU1ymxIaatgpPbIwod2+vF1JYk4NEeE=;
 b=qQYOvwqaxY8nG23qd1mRWVY5J2cg6y6/ldpsinIFgxqpUXJIwCeHa18bugE6W4ca1MBa8afqMS52OZkDi44ryloECCF9y3VsGnATfmQ9b30HphBustm0caYeA2IhbdCHjb3PhX6XldChAO0JChFVdrmiUbZHq5nOple0i86RbsPCaYiCJG+G4Qp2MSrUnUImU+OSjcdPRDnSrcBQuGc/5tsSiAt5oM1xZcWBOupK3Z3aL5QuAdTAORz3Jl8QTaby/QW4Am8VB5PS2Ho1Jp9/wEFwaKLg3nRSsdU+RhEO2FHo6rwFmV4iLJrXKbu17g0XIFXwxm+NixguYrX8c0UE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jr/XhNwrm7FyjU1ymxIaatgpPbIwod2+vF1JYk4NEeE=;
 b=DU6c4VnYYm+Q22DNe5anGYd6kQl9s9Miahwj2r3hfjToegdaTCL6U1sGfGROwgkeNd6/UzOocBjcemjdkd1Lsvh1r8OAFdmtH3+GxQziebJTxJhj1jXVX57qAATIbPTE3nS21vt2sY39MNuQnE4YAHqvg9+ECd09li9EIcmCZPR4nClVD5ZZcR6Rt3GVNjp9fqOF2cDIJD3C1xKjBy9vh+uWl4dRPzsPQAPJMSPcYnTrYzRQ9n2WjXbbEuvJaOv7sD+CCZMl+qEeyUTR3dYswDv342Xm6iLHKpPFUhtfpQKxSb9qhNL7an5qaOBcf2+2orF1i+zL1Nj+PbmNCVzT0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5363.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 15:16:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 15:16:18 +0000
Message-ID: <868803fe-d033-43b8-bccf-969e4c7daaaa@siemens.com>
Date: Thu, 23 Apr 2026 17:16:16 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH stable/v3.2.x] lib/cobalt: powerpc: Fix build regression
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0070.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: c9960e96-2589-43a7-3ab9-08dea14b4490
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	kkxMBJLAChrLnZ1oNHnxRlSk4NMGYGWgUKxSTfosfo2Kgvy1uDY6VeZmM9vVBzCg3173Vcs4klGwBoljPR5ZY1+lQObzH3XRi/YXcipktiF6rHpTlhjAu6a9RYiDoKihyAkjxKbRAIT5y2oY0ivNm9k2ZXQvp+5c2MLtedyPl0dn28n2OUKLHRwh7D4Sca+OMNno3l3p8YWTYq+eM7zUD0bSUMUobWIeBI5q3mrz6QEdKNdmWr7Hq365c+jj+Ww/lQMzAi3I42UG1KlFvbkhke8s4xzjQOqGVRxpwJZhqnhr0L0aOIR43nTAvJ1UcYpSBEkoNjMLC/3l8zHYmhiZyzOgsVDmFRFkIAx+qwI92x2l3JLgx+EfvbTBZKi2gZSG1ce4HIr0Qt3yKZ1uUTfeJb9qhFvanMpBmwVph2xFItmvxyAnpaiYssFBtzD9az5QYAfnQzCza4nawSs+hbi4bjEauA1MuBDMFI/cppX8mbi1wX8fs1Q1BO+SVKn8h9uBA8fTBwmyZdcRpGs4zyohIywCn8XLIFBWZ9IUhJPXcfFlYyVf5Iua+5suT2GTUFmz/AevpG5PT9+RpCXfhriNbCLReScNCJ+mFqlWKQArjISpQnwcLlcTvXEkOENYJRbiKQPuJUqdpAl2W2JAh6lf4Gq3ybw/QYTdGz+WFomTCNsKqm+0/jfqnAS4dVmsaVTaQLzzOaAGvLrnZ7h7ZAA6akMZIO7s4TTW9HPPnJVrXAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEtIUDZPcnR3K0RZYW5EQTNXUXBSMVZobVdRZ2ltVXdTQ2QwbGZYWEhlTzNn?=
 =?utf-8?B?bloyMFh2TDBtL1k0ajZHZmRvMWlOcStiTUh0Qnd4Y0N5VVBpYWp4Ty8zT2RK?=
 =?utf-8?B?eFk2cTlwdjRKb2E1eTJHcUF2TTdxSFoyTTlUTGtCOEs0WjltYkV2OFFRSVl2?=
 =?utf-8?B?Mmh2OGJLMm1DM3V6U0lML2pVUW5CbFJRZFB0V01nYXNuSXlydGFHWm9Udnhh?=
 =?utf-8?B?b21tL3lkaXpUMXZYQWI4OXY3RjRyVkF3SytHdWltRElLNWhXNDVOWDZJSjMz?=
 =?utf-8?B?ZVV2S1JZVVlGbW4zSnkwN2xJTmhMNWQ1M29UVkoxUFBMQ3pCRG04QndGVk9o?=
 =?utf-8?B?NFI2Z2pKcVJlajV6MEQwR1paYUMvWDBVUEIrS1VOZEdzMzV3dWRDd0ZIdUta?=
 =?utf-8?B?d3AwZGRoZEZtbDl6bGxab3BtN01GOHBDa0dLQ0liVFpvUDlLdXQ1SnVnSDQz?=
 =?utf-8?B?SWhKNGwyVVN0MWgyK3FLREMvaTR0L1NySlBZV3hRbzJtL3dvTDBrUlhORmV2?=
 =?utf-8?B?RnZSSnAvNjB2c1J2RkY5RXpmVWg4eGo0ZUlRWXkxUExlYjlzc3VQb3ZaN2JI?=
 =?utf-8?B?VnVmaWo0Znc3V1pNTWxTUGQzSERZQnN3NmRwUTc5aHNRNENET210aWtsd0lV?=
 =?utf-8?B?UUtGUGp3V3ZlMmVHOWdFS2RuNkNFQlgycjJjbTJPanBwRkV1QmtkeE5uTVBo?=
 =?utf-8?B?VXQ5RXp1bXhvWnlIK0xhN01MRmlBS0h3NDBWcmlRTlZKb1FoeG1vNWVHQU8v?=
 =?utf-8?B?TFFrYmtaL3lBQ2FQdGVmZzJPcjN6NUJGYUlkSlYzOVpRd0txUkNQb1A2SER0?=
 =?utf-8?B?MTRPeS9ackFDdkx0RTh6OXBjTk4xYVFNaHY5UWVnS2R2YUkvYzJ4djRyZFFo?=
 =?utf-8?B?SmtROEZ0ekNKYTJRWnkrNXhoYmFQa0JZSFBZVXIvSlFCZ3pnTllPaFdXQ3h4?=
 =?utf-8?B?eDdRUURtbnB2UmFrSVhpT0EyMEs5Qk1sc0ZxNCtrZHEvYzd0Q21HSnMyeGhZ?=
 =?utf-8?B?OEZoZnhlRHUveE5PQzc4cU5kRkFZK25DNWppQngvQXRKSzBab2ZDRi9MMjcv?=
 =?utf-8?B?Z2RIeEVxTnpaMVAwUkhoa0dacHFOYjRwc1YrbnhmSjNENWNBS1JZeUN6bEMx?=
 =?utf-8?B?N1dEamkvYUdWbGlJNW1pYUJZeFVZUkx4WmFTbjdyaGYvWXlrRXpPeW9yN2pW?=
 =?utf-8?B?YmlWQUwrTXNvQm1RZStvQllENC9Db1NTMVRnYVBSS3Z0N0pxZ3ZvVXEzb0N4?=
 =?utf-8?B?U0tLM0h6VUR0bzMzbG5mVDVoblM0Nk50M2VHdks1VlVJQUFtY1hYRmNsVC8y?=
 =?utf-8?B?QjBzeTByY3J1RGthSGpLRC9XYjAyOG00Z2I3U1RkWUc2RW1sSWVSMmJHSml4?=
 =?utf-8?B?V3YvQmpFbnpsVFVZZGYwb0o0ZlZseEdZRmRiak51V2psTGZ6UjBKcS9rekNw?=
 =?utf-8?B?K1p3SmxTb29DYVptM2oyWGh3Umd5WWM0UEFMMFh6anJKb1oySHFITnlGdUR2?=
 =?utf-8?B?QnRqZGJhcjdtbXVsVFdnNHV2bnNJMnVEZlo3aGpFdGxNbEZhNU1DejY2L1Ni?=
 =?utf-8?B?VGVMU0RqdUhUc0lZekd5MngxalMyYnZqYUY3dnBmeXlhR2kwU2RqNHJVZnpo?=
 =?utf-8?B?U3RyZDVWLzd6SU9XYkhVZnZtZnhZZzZwSExqMmhjVnM0b214MXppSE9KVFhT?=
 =?utf-8?B?QkczQ2llMWhCbzNKSHp2QjR0YjIwYUpWaWtFYjhnV2VVUHFpK05RcjJQdzMr?=
 =?utf-8?B?MnZBQVVaVmx5My9OUEc4Wi9rQ2Z6UzJVVmJ6TXIxcjNabk5TbXUyVkNhNlJS?=
 =?utf-8?B?OVkwWDV6c3pvanhnQTJBa1hlM0xSV3lHbGk1akt3RDJoMTltYlJSZjFGZEhG?=
 =?utf-8?B?RHBEQnJ0bjZmRitrbFJzdi84eDdCWlh6MklKWm5KWEV2cEkzUmhkZjkraGph?=
 =?utf-8?B?YmhjbWRTU1BoUk80YW4wY2RNbGlSa3pYWWtoeC9mbUpaS21RZys5dzRDcENm?=
 =?utf-8?B?dzRkcUYvWlM1RjV1N1FmTmhjbkpjb0lWQjFoNGM1QjdNZVNWNFA5a0pZRS9N?=
 =?utf-8?B?by8rUDI1L1hNZ3BOTnNZcVdrS1l6dlZLenA0cDNrRm5RQTJjamUyRXNON1Y0?=
 =?utf-8?B?aWdOZWwwdXEwdkRweWRaTTZkTUpUVGhDN3VEODhrcVZzSTRraU9QVEJqVG55?=
 =?utf-8?B?WjZWRVhTOUZVem9EeUxaRmJ4TWdEQ05FdnRVL2pnZ3lKU0tuc2kxTzZGNWhv?=
 =?utf-8?B?QlZ4b2FSVFFlV0k5T3N3bW9FUTZmanBzdkg3OUdDcjZveUg5UlRDMDZ5Y2xm?=
 =?utf-8?B?WnNRM2JPcGVJOTVBYUZsWWlkeGNLOW92R3NqY1ZxZjRWQUppUDk2dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9960e96-2589-43a7-3ab9-08dea14b4490
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 15:16:17.9691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XK7XRcFYculttDmpgyEOxf1M4gB44tjPWAziGJE3uC84izq4XK8l5JY3fWdi9beJ/bWMNctyLUzWA9T2YMNh9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5363

From: Jan Kiszka <jan.kiszka@siemens.com>

Fixes backport 4e69a2f59b28.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Another backport fix-up for 3.2.

 .../arch/powerpc/include/asm/xenomai/debug.h   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 lib/cobalt/arch/powerpc/include/asm/xenomai/debug.h

diff --git a/lib/cobalt/arch/powerpc/include/asm/xenomai/debug.h b/lib/cobalt/arch/powerpc/include/asm/xenomai/debug.h
new file mode 100644
index 0000000000..ed25b8571b
--- /dev/null
+++ b/lib/cobalt/arch/powerpc/include/asm/xenomai/debug.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright (c) Siemens, 2026
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _LIB_COBALT_POWERPC_DEBUG_H
+#define _LIB_COBALT_POWERPC_DEBUG_H
+
+static inline int cobalt_avoid_backtrace(int reason)
+{
+	return 0;
+}
+
+#endif /* !_LIB_COBALT_POWERPC_DEBUG_H */
-- 
2.47.3
