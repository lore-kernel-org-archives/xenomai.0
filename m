Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA00128370
	for <xenomai@lists.linux.dev>; Wed, 14 Feb 2024 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942365; cv=fail; b=sLqmBj72TOVplKpazbfG7UadpH6u1MzTmRwX/8KM5luPY16+CsGYyY2wJheOLv1gYyoYSK5DA26kNzfUxJXh8sBIv5kmXa3WB1Wyd4GYKnCAgfU30JqzLzAbxtCRwvZdbQw+5jsVi0b47eFfN2A7XPIjWU+lrm6o6t4A4f1fV9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942365; c=relaxed/simple;
	bh=k5w2JQlW7t/1tIPh+8Ydy9ffj0aHI5lSwcdUVlCr208=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=LHs70WhUyydxoXEs6wklRh3A3TrTvi0gH7pDFlrJZe8CpUUaOZrqKLij/ES1ZqGyu6M8MVMLmqqwQiZRYxjfgJat1YOS5MNh2S6/jvb7cyHAw6cB8aAVJkuaEZ6gnZhVZ63YXs0kZTalh5FQmYtdP577EDgP+ClXDuOUV8ABwt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ymHqNOLc; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ymHqNOLc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njpX3/HYUQQHRtmm0CxSgqDZV0OtqCQuBsaOH75QAYsh//bDTMH8rIClZ+aEclTOoLQJvccWssCy0duJ/aUGlaksfcyrUCWJsBAxgbV+JkKUJmYjAA/XKpnCnFDkR7xbMv6EJ4NMoU4zeloPsM2upkoxQVvZp3AJ16PNFWNrXuwhU+oEsYKYZzd/h6xkTaN6KvHv99DFw1RUAY7+ZGAxyfwXl1yedJWN/VhGCayIX49yp3yfkdxxF39VA/LfFwtm/ruJXeUu/q8j9YhAIAkFKcwvVFDVCGvjnAjhDVE3HecEIlhxvEgTJwYU/mFDnKzX/2clMu0Xk9nquWf6NNZKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69Xf7M/G4mvhEkLV/rmvGaKyPaqKX3zw6oiNPJL3Hfw=;
 b=bDbQD5J6f3BCtNts5qe+JwkZJ04XM4Pe4Nz9OE1rPrQzL1cgrBjlBu89ZKFdGVZmLkydSux/OEnYNqlTHtU6QoODKq/3VtaRozwCLTcuoI1V9I/jbzAd9WsJyy36OaFGb3uNdkbXUoVX6uGRWS/Bslgig8ZGlmHCpj/BOHy45YDYGQE+9dGmGg6dJ8nVTnrSHgGJU4YHCPA13GBXrfgdRrCQ9G4zVj0DNYtEbhbq5ZxoId6mq2GsyUggORAy2ZY1ykpBrdxiCy6URIORA9LMd0B82lUGzAkw9jHwlOJae5gs9CPktVnnXGrE7I2xyddEU1CTl1dawQXsCglirva4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69Xf7M/G4mvhEkLV/rmvGaKyPaqKX3zw6oiNPJL3Hfw=;
 b=ymHqNOLcM2JMSTuCClpr9ZOmhKdaGZIP1GNrepFs3/x++CNPD4HUOjBI6XWeBoqf1TFS9G6ILKhelTFwwSd/PBdQLpwq3Vp1nW3brhq0TGOUzTfwSNaNYuteqZnFRG701xUV1X/PujFWBuuYGQ1x/uW0k9yerzXNfgm6p5q5EDNdlQrFW2608rGBvwD3S6CWoCNHh7pHpyPaiLuszAn0RT37BupybHbJCIScNF4ksMj+8OO4WgtZ3iTyQQLscoyVkxLfO9KAAN0JPC3Bp0ocQwc5CcVmvgI7o+06Lp5FThBhwu7PyrTIuxg2CkAZJmnq4s0Vcuf4CjOFfQv6ayTlSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7330.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 20:25:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 20:25:59 +0000
Message-ID: <43946553-443a-422d-ae1b-773ddf6bd9d6@siemens.com>
Date: Wed, 14 Feb 2024 21:25:56 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] ci: Prefix ONLY_RUN with xenomai-3
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0286.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 81c6250e-852e-4111-66d4-08dc2d9b27e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4NUtJNKiGs0LchRgT2Z57d/xUrJTkb0zsuADqBR8c8akQb8W0XwB1T6QVgBN0NPhN76KrRzbl9aMtR4Z84dGs0FsT8g2fYPkEMqKzR7M1WtVdrFeZi5u2w2o5tui8NA+tpH+mdCQwt3zmPHFLdBeZx6ajYeDOvflFwtQv5+2GMTzfBa4SKIy/GTAQ8U6OAbi2sDlp77iiA76Mv06SJHF1q2CX/qW1c/PRmzFUYexbsDpkwDnU0ZckM+WpAIOdWf0K781V74Xj+wP/M1XpEr9w9QkCG3276geOjyA7LpcWRqGLN18iXtNtTRfHSvvYFTE/wYqY7InzuVmLG8JCldvjtkfIBadMh5FzBu236Wcz8muBY6LgdZ4goVP+jBWN/c956ab1ZdN4XGFsj8V68I+RY2OH+5EfxQE1tx4yVlf3hJbYcphL5pE6731+iHzww0Oes1Kesal9zulZ8OqhEm/mxyzbXRpz7zV/qJAXjEVRPd86I2q4Mq49mGDZblkZQCe9NT24tzx2sXKfP1izfGmfkXCFIt/cLrtkzv6uZnN/MKpSPgr82sa04oMjnoi8GLB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(82960400001)(83380400001)(26005)(41300700001)(38100700002)(6916009)(4744005)(5660300002)(8936002)(8676002)(66556008)(66476007)(66946007)(2906002)(44832011)(6512007)(6486002)(478600001)(6506007)(6666004)(316002)(36756003)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzRvZVhYTWxKNkVhNmtYMk5JQ2RFeVNIRmN5c2M5cmVFcmJkRk9FaHdyUGpz?=
 =?utf-8?B?M3ZoeTVFbnVLR0hCU3orNi9RQ1FvZWV5djVmYkFob1pGMjVSMnpRYnMwaEFG?=
 =?utf-8?B?cExsUHFvWVRPY1lpNWRwNW1yR2tPWDV6cThaWHBZb0JmeUtGUkFlOFZQcDZP?=
 =?utf-8?B?NjNQZzdNbUJMRU9hd29CZmFmZXJJUisyeEZrNURUSEJ1T1ZKWWR3MWY3NDVS?=
 =?utf-8?B?Y1NsSDkwQjlxNy9lcllLSE5TUU1HU1MyYkNqb0I3OCtMSnRLQ28rN05DUE9s?=
 =?utf-8?B?dUFOOGdjdTJOWkRmLzFPN280WGowZHdqd2Q0QXpYNkdka2hQMnRtSjZYbFlN?=
 =?utf-8?B?aEVDNjFQY3F5OUptL2lDZi8zbVEwRHV1N3Jhcy9LU3NQZ0pmU1VNU3F2Qmxw?=
 =?utf-8?B?SEtjYjR3NS9nNk16czhWRUlsN0lpa092aTZkejgvTDR1c1NCSG1EMzR5L0Q3?=
 =?utf-8?B?YWtKbmF4M1VQTUdoR01yWDJQTFhTTGZHaFAzZkRrL29ObkU2UXNQeGRJMjVL?=
 =?utf-8?B?TTV3MFcyMVdtMnJPazFmdFJGSEpjbGtoREl0ZGhVUFkwMWowNDVDaDB2Z0ZQ?=
 =?utf-8?B?SXYrR1BybEV1SnZmaTVRUEllUXBmTTFHUVRIMDdlckxCK1VJQ1IzRVZpQStm?=
 =?utf-8?B?N1dFVXJUbHFFNVpTRTk0YjM4blFwK20zUUhNMHR4UFZKV3RNMXhxbm0rMkZj?=
 =?utf-8?B?Q0pSL3JNQzdiSmFkRW5kd1U4c3dja05PWkh2My9yN21hQWh0akFOUjJpL2xS?=
 =?utf-8?B?aTV5ckY1SXdRTWg3RFVlclBnVzRIK243L0RtZ0V0RU9qWXJTUm5YeU1pRFBY?=
 =?utf-8?B?MzBHemJSd2lhWTJmUSthTnBKU3lxbFNOcmgrMzYxTzBrbGNBZGJ3cTVGQ0pi?=
 =?utf-8?B?c3lWK00vTkxYbStKZGt6c1ljcURWMGdJT2x6eXlULzlKZUROd09vbEp3MGF0?=
 =?utf-8?B?VEdmRXFpVEwwUzlMTFo5a2hFU1BkcHM1NjFHV0lQWEo0THVaSjhjczU2WmhC?=
 =?utf-8?B?UitHbFFvQXFWdUszN2kzaXJDMEp5NlRwWXFGRXFRMUhxZzR6VE5QM0NtRnJy?=
 =?utf-8?B?MUhiT0M5UC8zUVQzMnBCWkZmeHp1YmJiVnJtVDg0bnI5clQxelNNRERZdHc4?=
 =?utf-8?B?ZTBWVUs0aHRkRXRqQkdoOEYrR25hT3BzMmFSSGF4UE1abHZqbzM4VG9aV3Vi?=
 =?utf-8?B?KzNBN002ZEEvQjg5SElFd1BzdGJWdE81ZFhybngzbHhwVjgvRE56ZmdmSGtP?=
 =?utf-8?B?SzJGQTlaa21PZ0E1ZHBaaWgzbUhYclV0cDAwYlR3S3ZTSk42VkYxYlpKQ1l6?=
 =?utf-8?B?Yyt2THd0WUd1N2RoaWp0Z2M1U0kwY2FtNkI1K0NjcGxZR2VsbmJObU1vNXZh?=
 =?utf-8?B?VHNLUEE2NmZKRE1vQlpyR3ZYRDdzemJST2xtMXdLV0E5cHFacmxCL2RKSC9Y?=
 =?utf-8?B?ZFIrd2J2R3E0QnZhcGs0T3diL3UxQnZ3OE1wVmJWSlVIbk1IRWZRN2dSL29h?=
 =?utf-8?B?T1VCUHUzeGdHRGVHOW5IcTBLeWE0Q0hIRDkrKyt5V3JCMDk0UDhZMnpGWkJt?=
 =?utf-8?B?dDhKS0t0am5KNHUvMnVGalYvS216R093dmtYdmdTZVRYeTJyVStkc2lxcFIz?=
 =?utf-8?B?eDVJV1hzU215Qk9nc1NQV0N2VjFHZUh4UlZiTWo5RXJXbmhWRFVwOGtnY0FZ?=
 =?utf-8?B?WnNNNWR3blpyRjZXOVZrYUVtMXNBYmxKZjVVaE9QSk1vYytjeUxYcnYyTnhB?=
 =?utf-8?B?UWYzUHp6SGlrL3ZkejRCR2ZpQUJqaEU5WkJMZjlxaERQVWIzKzlrMXlKZzlO?=
 =?utf-8?B?bEkvV3FFNXRodTJydng3MlV5ZkdYSTZXMjROTmJSditrU1Y2TmxXWnVBbGx4?=
 =?utf-8?B?VWxiWHc3ZlpCUVcyblZQd0sxRzA4WXVOQmx1VlYzR2NYbWhlR2VmTVRqWUxJ?=
 =?utf-8?B?OFQ1bXM1Y3BoZHhCUGkwd1F4dVdBeE81WVMvbDVyQVZ4bDJiM3YxMFE0UStk?=
 =?utf-8?B?V0g4Y3NzSTBtMXNOQ2dkTWpPV1FEanNFZFZKWmVkWG9oVnoyQmFYeGcxa0Y3?=
 =?utf-8?B?OVYvSUx2bjl1T2krTmZwclZMeWJwSU1OekhoOTZlcXJUZ3dmSXN0Q1JHWk4w?=
 =?utf-8?B?WXo4TmlWYzJJVHg1eENmd0ZrOUd1TkNHaHNrbXc1SUxvbVBQU1RMNHhqdG5S?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c6250e-852e-4111-66d4-08dc2d9b27e2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:25:59.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWiYTRZK8sBmfcJRsxY7AtKZqHjayZMlwPS79ZYqcpYQfMqPXb5UevdqtQrrqmX0ZuEBfhPAL6Dw6goLqWxRZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7330

From: Jan Kiszka <jan.kiszka@siemens.com>

This is needed to as downstream now calls 'next' 'xenomai-3/next', and
may eventually tell things apart from Xenomai 4 trigger sources.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8b8b9131a1..21df3c8799 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -266,7 +266,7 @@ i386-userland-y2038-unavailable:
 trigger-xenomai-images:
   stage: test
   variables:
-    ONLY_RUN: ${CI_COMMIT_BRANCH}
+    ONLY_RUN: xenomai-3/${CI_COMMIT_BRANCH}
   trigger:
     project: xenomai/xenomai-images
     branch: next
-- 
2.35.3
