Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013052.outbound.protection.outlook.com [52.101.72.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CEB33554F
	for <xenomai@lists.linux.dev>; Fri, 17 Apr 2026 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440885; cv=fail; b=Nr5+MdVRK1eLhz/ue9e1UkW9tNLNEhkMCRJYlPBKmK1b/xm5HoT7ofVri0oXbTTWm9LYMHP1K96h2r4ZYbXxRha+7AaWHp8lVuLgsz06oa6LGHaurRhv+wgLnz3UuAC4OH4upZh49hJSMTN4+PIVHslDeM08LYaUy600PNIX7/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440885; c=relaxed/simple;
	bh=uOUF+VRHCPzR4lyYumA5ij8r3B7m5myHN7PMHt7uZ7g=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=ihsWuSoJMB+lIWE1z+GtCnXLR/gNIRWgy6LdfQGaU700l5kNzqWxxfdWiILNUKKrvFRKuQy59bDdGeXfOy6RvD7C59Bw+G2hPet3Z3xajvYq0NqZnYxbvS7Sognj42pRPKZqjNMdiUL9qVgHGESr5sQzwO1nWoEa24qvPYsGvkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Bv9n00uB; arc=fail smtp.client-ip=52.101.72.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Bv9n00uB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwLaoug+Ylgalo6jRHTefDGEI9MvU2y6SXmf+O9jGRL+duZgWkH1zt7w8CmLJOlYYwxM/IXr4sesmkXj0hGMETp1pUhE/xXPZZjiNX1koN6HjU0V/8ZIPcn3GGGSNs+J5X+qbMQlfri6AEiGr3iqcEUTopXRM9l1mSjJO1UbdMSRJyT8dcjH1Ncj+llcpog9Qp3gqzofSVLjyxzXGpv38FkZ05pSV36urs8hAuM2Hmcz6A3hdet1b7bqUCp/po5Ri7h2e3m3K9uu3cZxK5LIPIoo4iCKkP5ZazS17Kbo206jrbm2ZZb97DKQbvwL2DjudTn2PSXFila+HXSRr9bhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUjJuq70UnyTu/3lfcr91KlnwNvp+Z6+/2JMNQ2/VfM=;
 b=b5zJ5+CIatvvfT8aIqd0KfmuWTrWIxmMlHBU8aLvl7OqLeTqM65H3eM1GjV230FO4qR+yFOLrt1WLXW6y5aEYWJIplrW42iEmZ4AccEC8gyVx+ccYJ/w/uqbdoDga2BhYoZ58T6FKB6K+DwNt4DcQKFhCyYfgT6YHs1Wxq+TVTUeTiPCwdhDNe7hrJaZ3EYMZOJs3ZhUBb4vYUomVvnCpOcNbBFhqgqbMlCtBL8LaN9RirPE1NlddSSzq/MYOhHKQReJOj8yjAZEbBdUgLL+l+FVJrzMt95xued9EUE9Q3ouofTWmCc783BpAbVpDjtGtao8oxm8Ff1sG+vHcvpeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUjJuq70UnyTu/3lfcr91KlnwNvp+Z6+/2JMNQ2/VfM=;
 b=Bv9n00uB0Yr2WPXqpWeYzjLkDlymEFZC+SgGYEzHHlTEcyqZEsX4o8K4XXpmd5ttNzTvMd/t/dd83gvrEYkzA9STWjfLlyvz/idstrPo/zQytfvNYI7S65YrEiNClDM+9jIatjDfQ9GjyOk+k2K4qLAPKcVIvUIAb3G46hbBnLSUNJN8DWs5UXcpyM1piCj3lgRjj/ar4olv/W3NErSZeEMLq7vhaJbZ8Yd9lj3PJJNH2pKQxgs7WWQ3iSU+/iKjz90cajcpkgCFD/S+aJVZYr+bL/s+VTICzZJ3F6p47oLpJrdBVhn4fB2U3Gn891CRr7ng07aVdPJucA33UaaY0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7375.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:615::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 15:47:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:47:57 +0000
Message-ID: <79ba6915-9ad2-46c1-87d9-2aaedf3821cd@siemens.com>
Date: Fri, 17 Apr 2026 17:47:56 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] ci: Do not prefix triggers from stable branches
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 9efd3188-32bf-4ec6-db67-08de9c98b26b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	MSjFjcc3Rg9eQ02LJIom0Zpsnh4/gudZTCPmwyJutx6O6JCIWCGmjdI1yUbhdl1NXI7/MeYyIUf+au+9dcAGgpdNK4Gn+j1ueD3k3HdypKsQKagLc/qlGYYPp7cB2IstdFGAaUbp3kJG21tzRT2DATNCrc/FXw5xQUdOfndL+eaBM6x5A/I5nrZT0Gxt1qRSkE/JVWwtWhax/0EgBnCzgW8SsOcw/FFTIvvLs5fmn4KhqI4SsazzOmtOZ0HkAL0KpxcFOXRxQeuHJU3iBvus/w0PrKvapFohVRQfsxBwKQRBPSKVEuHHgANU53yNUcW01Kl9RtBzgvJlk0Ua9U+BbGtHD2goz/7onbU+vRcHqGfb2LzIUdsniOgSVNIb1jDZL5ml/UsS9UZDbzHZpLvqI389fs6zL2pDpI6nkb8ghl1ZXKSy0imcGk1Y4yEWVJ1jFfMvGxtFBQFYK44b/UZhoVCY8kYXWK670UDLgvYEhP+UhJnYRBYWn2WKdqgWeSS8gZVU1OgM12jf1RxbSq/9XHX0Iw3mnw43PqR3MpfN162SK8Sf6PBOf0mHSk77jPGt7nKs9EoAjroy/cI/p2zOThoDKVzAwNPVP3PPkan9fm2PSsqUAPKvpftpDwKwsSazpT+cKMyo80Rqeu9anRnOuzYfZOwdJqqFE+odozsPBFcDQ8cHK1tJQ+Xs/C7/SvkQWlaWfBHvUO4qUaUXLTLrUumOyv5FHf9SDJSTf9NgXoY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmwyNVRvVlNSNUliWTJUbHdOK1hjVW9NdUp0bER2bysxYUFCOEgrMTRVMVht?=
 =?utf-8?B?TFYxU0VNamFyRWRaaFhKNmY2OGxsTTFJZEl4eHZHRVZyZGhsOHhRcGs0RVFx?=
 =?utf-8?B?OFBVOHdscjNnWWtVZjhpS3kyNFJOUlQ1bFZ4ZVN0OGlKb3JYS216dFg2dDlH?=
 =?utf-8?B?NFJYbDB6eGhKSG1wdytLV2poTHRrdW41ZGRzK0xzbENyT050MEFJejZGMC9W?=
 =?utf-8?B?L1VoTmJ1amlMOFZ6UzYrb3VUV296c2xHUDY2UjI0anRtV2xENWtiakEzRHYw?=
 =?utf-8?B?OHp3RXNJcDFYblNGaGk1djFvN2RSRmtvRTdUTkh3UkgxWGZDT0ZWRzFpa1Az?=
 =?utf-8?B?ZzFIMVFrejBXYllic250YzZrbVgyUzFNYTJCSkNuUzdLQ3RuNGtmdTVOVUxl?=
 =?utf-8?B?dEQrc3cwL0UyVm94d3Yzd2xEWE02dmtKbW93Tk9CZ1NObVNIUVhZcUY2a0M0?=
 =?utf-8?B?ZTA0aFNCWHA5Z2FjZVRMcEY1SFBDWXlUM1U4WnFGR0NUbnlnK0s0dTZCaHNI?=
 =?utf-8?B?MVgzaHVENkRiSThhOWdxODhVdVJNYWY3NnJtdjIweE1UWjhtRWZDMU5QZVRE?=
 =?utf-8?B?ckFJdk1LTDcrTEJSYTk0enZqSEw1em0xdEQ2ZnJlUVRzWU8xZUp4N09sbGt2?=
 =?utf-8?B?YVUwa3lnREtkalVoOGZsYy82UTJKaWdyY1pXcHh5dm0vWGJZWmEvV1Y2c3h3?=
 =?utf-8?B?a0ZnbzdaL2tidUVqYk0rOEFMNEc1N2JqeCs1OXJmL1V5SVdBbkV3V0pHNXVp?=
 =?utf-8?B?dGNkaXNzOFFnSGlRVTNlSUVHVEZPdktNbmExN0pvaDZNa3BLeHBTSWsxNmta?=
 =?utf-8?B?Nlp2NkRyTXVCeTJrSTNXcWJNdGJIcms5NnF6RzNMZ0QvZkhuSUhIeWZPMFV1?=
 =?utf-8?B?UC9FM01qTGNSRVdkQmV3V2JqS1RqVC9ZdGg0U0pDaW9RS1JSRjZibVRJSjVv?=
 =?utf-8?B?OEZralRRZ21vR25pQW1rbWgxSFo0SDI1WnVjQWRSQzgzN0FGTjFSM1E2dDFv?=
 =?utf-8?B?MEtIM2V1Sk1mYXNCZGhZcmpPYW9yWHQ3U1VudkVCNGt2RDh5dW1FMTZzdWtk?=
 =?utf-8?B?bGF4RktiK2FWZk94NHh3aDlzUVlZYWo5Mjl6Zk9tend1SlVjbGZaOEEvclJX?=
 =?utf-8?B?cll5bEdRM2ZTYytFUmNaR3hGTzdaaklHV000YVJoREl3RS9OVkFJdGg1cVE1?=
 =?utf-8?B?VXRUZytEazJCd21FMWdXeVFTcmJOaXM2ajcwNEZOQnBheDhVVWVCSnF0UE1G?=
 =?utf-8?B?R0JjV0lpTUR4V2VKZWZlZHM3STlRTXI2Mmk2QW82UUw5TlRCT1l0RmVxd2Jp?=
 =?utf-8?B?dXdoOHp2N0VzaktUT3A5Zy9oUzBNTUF5QWFlSEUzV1dnRThRMXVzd3BNSm9z?=
 =?utf-8?B?WjYzdlFMa1J2NjdUVnZlWDIyWnFIQnNPbUhoRHhMS01sOFpUenoxVFBUa3NM?=
 =?utf-8?B?bTI5eDhreHhXYWNmc3ZVaDVLNW10NHBuM1NobHB1dXF3d2VuUnVBa2x2Smln?=
 =?utf-8?B?M2JTZE1tYlVZTXlqVGM5QWYxdlU5VUJKQ3RDVEJnN0Q4TXo3aldleENoY3B0?=
 =?utf-8?B?UjdXSzJhV0JmOVBxNnhLTUloQVl5VHFQMWg4OTdoU2dJVFkxQUo4WkF4UlRP?=
 =?utf-8?B?T1B4dTBkSi9XbEt1aEM2dEF5ODM0dmNjd0JvNThZK0syQUtKeXNzQmdwazNo?=
 =?utf-8?B?Vmk1ZjBGeUJzb1N2S2tGdWswTHJZL3ZUZmpGYVl0WFpqNFp0dFliYXR0VGpB?=
 =?utf-8?B?Q1FnY29iMlNtay9nOEpzUmR1OEQ4bWdkYzVOa1pzZDVkTXlmUVZac2RWNDZQ?=
 =?utf-8?B?ZUxoRjJsNkVDVWRNT2RNb3lKRm5BcnBBVG5iTFhTcS9DUkRSUTRhbDlvUitl?=
 =?utf-8?B?c2hkQ2g3WTJmYjJ4U3AxSUtLUVluclpKS3FHQUtUWDRjOTMrVFBWeGozcXU3?=
 =?utf-8?B?UHozdDM5blFNWFpRZXVlUEFYTkFMQnNVQnN4dm5RcWwxNEwvdjA5VnRxTkR4?=
 =?utf-8?B?OGFJbEZWWXE3MUptc01RUmluK0hURW81RGs0eUZZNWV5YVovZWdqc1lEa0Yv?=
 =?utf-8?B?L3B2em5kdjFJd2dQWG5aenJjcVdYRzhrYkppV2k5OUZEY2pDN3NKODRmcWVB?=
 =?utf-8?B?NmdtdWIxNXB3dGRMbzc4blo0VVJrN2pTV29NRXMxRDNIZUJDeU5SMnNKRFlj?=
 =?utf-8?B?Z3NVWFNWZURGSEtTTXZjaTVNTTdBUlphLzlpVi9Yd28yWHc2cVEwMElRVm9m?=
 =?utf-8?B?cEl1Z2V3c296SWptSUtxNitKaDlpVVVCNW5MUEhOY3hpaG9jR0JmYlhEWVVS?=
 =?utf-8?B?eGo4WVNrenFSUVpnNkxJOTNVQU04UmpZbXBkWkI2ekFpQkRhd3lwZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9efd3188-32bf-4ec6-db67-08de9c98b26b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:47:57.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 907DiYtynvhhG0eUYZCMQBMzsme2nIcpKATnPSfT5Ww19x+aJ8V/BlBiU2uafxj3FXn+E1VqPEYhINToQeB3eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7375

From: Jan Kiszka <jan.kiszka@siemens.com>

The branch names already carry the version, plus xenomai-images does not
expect a prefix. Will become relevant after creating a stable/v3.4.x
branch from this codebase.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b82df7e436..1188222d7c 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -268,11 +268,15 @@ i386-userland-y2038-unavailable:
 
 trigger-xenomai-images:
   stage: test
-  variables:
-    ONLY_RUN: xenomai-3/${CI_COMMIT_BRANCH}
-    TRIGGER_SOURCE: xenomai-3/${CI_COMMIT_BRANCH}
   trigger:
     project: xenomai/xenomai-images
     branch: next
   rules:
-    - if: '$CI_COMMIT_BRANCH == "next" || $CI_COMMIT_BRANCH =~ /stable\/.*/'
+    - if: '$CI_COMMIT_BRANCH == "next"'
+      variables:
+        ONLY_RUN: xenomai-3/${CI_COMMIT_BRANCH}
+        TRIGGER_SOURCE: xenomai-3/${CI_COMMIT_BRANCH}
+    - if: '$CI_COMMIT_BRANCH =~ /stable\/.*/'
+      variables:
+        ONLY_RUN: ${CI_COMMIT_BRANCH}
+        TRIGGER_SOURCE: ${CI_COMMIT_BRANCH}
-- 
2.47.3
