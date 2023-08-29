Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8E13ADA
	for <xenomai@lists.linux.dev>; Tue, 29 Aug 2023 08:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgdMjV23uvNdxa7Qr5T6iyLvvpORIlRmDWd+d6vs36Dvo43TmiLsDDoFNvA7gHxSSNObVMgwaIaYigUauEQ9Mfaq0BW3E6lqbjzzrVBvEsMFSVkGKbznDUkUKoROf1S3JZrWYpWIEaMAF7UgBvec63eeX4PmXQc4I4OSsNdoGrE56RGGmtgPgpdiYv8o0WR+2mID41587625VIdpHvMbBSXmpWiOuTGhxamLWdfmozzXkVv+7KCdz1Qc8ak2C+fdEMHf04mS+tKeMYgCkcXBML9WLj/NxfiRyBIOK26eLplKLfXmEkuilANEeA5hBe7CfbTLvCyLEGH0pMnTQO27YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvJp9/mxj2aTsGCnhXv0W53kLTrx4ENgdWG4zrwxJBY=;
 b=GcRkA3JyYQ+FiXR5iWwXR7XqiYu/2dcsPxp0bd6dhWGR+59r7129XWK4PPqJApZuo6XzKOAs2Tjv87q/eQYGIEG/n7eI1mxsXgo/0ANN3bc3cfwy+beWR4AHWBhjO2ih8QobNTrx+xfcFgN5pCvQ2LH6TWAhPe58IVpgw0rRjnmY92IVLuOhMlBuWnbwVimt7t/y7lD+hcy9Se3c5JLh7ZdKgYCletK63KrYRKc6vfz14jrp+wOHcR2UT4KfXvJusjfDNWKj1FUgENPoQpeecPC7+Y9RALwrI/7M9qsOod7JXour7ITVwmJDQhQh0tIxVc7IFwon3WpEB1tc9+uCfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvJp9/mxj2aTsGCnhXv0W53kLTrx4ENgdWG4zrwxJBY=;
 b=zOXOMivX0iXZ7wB+zL2DdpOV82VxmiIlwbzR6FdgG/mOuNrYIVKa+i9MfebaDW2cMohylCzWiSRxb27BTl7wdO6cW6FSCZ75q9LY7KeWWtQXLnvG0SebQispn7egzn03Z5OuD4KDiYNkJ7zrOCSZ1n6WSwmexDVYmOfqj6sGpHHfx0yIZFo5Bjfi2c7y4cjVtiK8svITum4k592eY9kSH4gGFBXw3d+zU+uQp14UP0CRa7TtrVuAyd2Og8Kpbpd9N23E+ryWCOkRCpCVejcRBOj/J7xGGb4/BqDkZDwioD4CBFlYnogXPiCJpvXaW39evq793zCfw/Nbggo3DPKoNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 08:55:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 08:55:38 +0000
Message-ID: <5214e623-87fe-4452-88dd-05b98c1055e3@siemens.com>
Date: Tue, 29 Aug 2023 10:55:35 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2] cobalt: Adjust dev_addr_set wrapper to 5.10, 5.1 and 4.19
 backports
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3682:EE_
X-MS-Office365-Filtering-Correlation-Id: 89954062-a856-456c-d8ae-08dba86db71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VjYf1Si4xHQcOiP1TsVJ2cKl5xPYUv+opCKmKXMZ/Foi0WgKbjmI6B+Pu2aReHyjQOF3TyTsTNzGuZTg7xMFV3hPz4m2KB3shQOYlk7qj2SKD74JHHLJEbdGzx8uAygnWMfeXeh2bhnEKM4/fkmeFfppg1lqq8ERojk0eZdEHExGBxq5hUlqwFrON8PoaAxkosOpgQySUIyUEDsLvGLzPVlCKigm6hjD0Zvx9tALuMDpm52lfV61beiQfcXmE8L66pTuys3/r0kBIiRq75sBsp3s+oYISMk8q1JWtX6L9iWBDWIgGkrP+SWidIe3UHV9q2+9bquY1y04nvOvSWlnXMGeNBDs9+N+AF8TsoC1iw5MgRxZeUuAOAD1akC31g0qRC6E5D+k7CV6xKparVfev6NaGJCtAOZrZ0T6+907+BvHdmMys57JpskyKjs7fC9sik7nYRU8O/r+A2sgAFdFeE5HyeiSHNb+jeTC7nl3FoTFh6asiWm3gx9NjoURQlFY3l4npzPGJYWzi+GGjIxE4cGdAl6cy+IjJG7R2rC4aPz/6YSKUOZOg+d9GiEGAEnCJGOffukKlvlCi5U8TCzBTp7VacDYEWb1KDXRHvTrat3uqeDTdl7eNJzskBfzqj0Fy/PH9GA1GtwcJiIguLmvxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(6512007)(6506007)(6666004)(6486002)(478600001)(83380400001)(107886003)(26005)(2906002)(2616005)(316002)(6916009)(41300700001)(66476007)(66946007)(66556008)(8936002)(5660300002)(44832011)(8676002)(4326008)(36756003)(82960400001)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3BwOWdrbTdTMkJSOHVFMDMvSC80WitDOWR3c3MzTGhiNm50aXdVUFR0a3ly?=
 =?utf-8?B?Y3RYemJKaW5DZlp4QWtHOUc4SG54SyswSWVkZmVRSVJOdDBabFdtdnRXeXFh?=
 =?utf-8?B?bUdYYXBtSmUycU1wWkZJZDZEaU9WT0F1K2NuVVZpRjdQT0lJMFJ2TVRNT1pU?=
 =?utf-8?B?SldWRGpNYUczZGJNMEJZNlVxcCt6eGtOeU1jb0RidUVWRUFWT2UyRDM1bVE5?=
 =?utf-8?B?YkVTSVpNTUhDZWduano5UUZXRzlGSVNuUWhDMHJBWmtGY29sT1RIOFMzeXBM?=
 =?utf-8?B?eGNQTTJQSjZhbWpHOFZUUHE0RzY3ZmhzdFl5YmhmR2I5cnRqQVVZVytUZ1Rv?=
 =?utf-8?B?ZFhnL3JzbS9MN3ZBTTZPSFZWUjF5QWhiYXdiLzZqd3RLazI4WEhnVVJIZ0hw?=
 =?utf-8?B?Q29hQ3d0V0kyZ3B3WFBjU3hiYWR0ZXoyWGNiVnJuYi9vcG4vdURrWWRNWk5i?=
 =?utf-8?B?Z01KMHRSMGxyakZJdlBBZFliU0luVWp0dmcyeDc4OTVUVHVxTUg5V0FXSVRL?=
 =?utf-8?B?c2gxSUREV0xJTCtWMjBmQk5HR2piY0NOZmRnVFhCcUttZlB1dks2dEdDQ1pi?=
 =?utf-8?B?OVhNMGwybDJHL25hOURMdlovYk54dUVjTnFLLzBQOGxuWmE4V2lqYUw1bFFs?=
 =?utf-8?B?ZW5pV20ydHcyOWdzSFZjOEZxZkh5ZHJYQlJkV3Q2OUdTeFlMRHp5ZForWGlX?=
 =?utf-8?B?MXRBN3dpWU5zUzVhV2xYU1NtamFwbytuSHc3Y2pQUGd0MkkvaDRnTll1czFV?=
 =?utf-8?B?TnZSV1RBeWNnQ2JiYjJkdWpSOEViZ3VDY2xleGNJQjdRTEJhOHBBTGFPUVlh?=
 =?utf-8?B?RG50TU1RL0xDYnRybVQ1K01ubUVnT3JVN1Y3TTJ1UC91Y1hHbmJ1M2RLN1kv?=
 =?utf-8?B?TERmK2xZR2x6MWZDcXVld2ZuVUtFRW43ZHh5a0g5VzNuZkFiRU5iUkZGUHhY?=
 =?utf-8?B?WlQ3TjgyK0VtMWphSDJ4NklOM1cxWkFjSDFrWUJpaXZYQ3FlSkVrWVhNQ1pE?=
 =?utf-8?B?WDZZODUvT1JXWlpQdFJ5NWIrR0RibUNRUmR4elIwUGNSYXJSN2x6ZnFJOXYz?=
 =?utf-8?B?Um1hS0RqNFJmaHMrbDR0UVZsQnJzUktJbDYvdVo3MmlNVVRndXRNVStRM2Q1?=
 =?utf-8?B?cWUwV0t2M3M0NDZDSzVIaWYvOEQ2U0ZTbHRJWmd5ang5NEZEcFU3UThaS0Rm?=
 =?utf-8?B?TXZET2FOSWJ3VTNlS05qQkNLNk1XMktMZ0RxZ2VJb21tVDVWcjhwbWJ4Y2lS?=
 =?utf-8?B?VEYzR3BnOTFSaWJGcHdFeWJkTCt3MzF4OUNwQm9mMkRXaGVBWVJuV0M2NllU?=
 =?utf-8?B?TWZTenZzSmdJRGpBNlBrVXAyZjAwbjVVbFRrSmcrcmhINFhYRU5meHNFbnpk?=
 =?utf-8?B?MnFZYWJiVW03b1U4WkZiY0RWdTZCbytKS2M2Z2gyR2N6NXdnMHRXcFp4blAw?=
 =?utf-8?B?R1ZRNVpxbFUwRi9GRnVNMC9la1dlTDN2YmJjRFg2Umxpeld2WTNhWE56ZEoy?=
 =?utf-8?B?TzJXeWJEdTJteGxPeXM3cnJ2cmpTQmFXdmxMek9PY09XeDJPbEFHaXdZdGhm?=
 =?utf-8?B?K3hDUUlNbkZRV3hLWVJ3ODNrZlFxM3hVb0k3YjQ4ZkV4SWVJbUs0Ynp4Q05K?=
 =?utf-8?B?cGg4M2lrMDd3VFkrSnFhRnZmTjNRajNMWDlHNUQvTW9LQXFlWjNnQjJTbTRh?=
 =?utf-8?B?aVIrblJaVVZ4N0NWcDU2Yy9rbHpWaUtFVVB6NnM5cHd4cnFuZ3cwOFplbDVT?=
 =?utf-8?B?aDlMallPT3JON0FUOGFOK0FaRDRSbVorK3ZnN0tLUXNQWjZQSlJ3WUNkUENl?=
 =?utf-8?B?VE55OUR0RlV6R25VZHlPcTlET3NsdHNRTUlHOFJhcnUydXVNMWJMM1JQMW9P?=
 =?utf-8?B?L0k0TkRJWjZ1MWR3ZFlpN3BGb1hwSk9TK0lJeHYxMC9GdUZYMFdaNEdQeUpF?=
 =?utf-8?B?bFZzOHArbnFoajJpY3ZwelJKd2NQcVNoNlovVklZczgwZHF5TmluTStUK1NW?=
 =?utf-8?B?NzFGaDJ6Z3paamFLVzllWjlyNXFKcm9OaVp6cmZPSFRkL21yK0s5dS9pL3pZ?=
 =?utf-8?B?MGwvMEIrc3RIR0wxL2kwN0h5aUl5MEtqWk04RGRPRnVXSXNZazMrOENGT2gw?=
 =?utf-8?B?Sm5UN3BHMmRqUXJQZEY2MkhVZ291UlgwcnQzWHRIb096K2o3REpIQVBYT01a?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89954062-a856-456c-d8ae-08dba86db71a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 08:55:38.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua3Ma0i0QUf0Hk4iRSb1X/2u9Bk8ygaXwJ9u0K5lQx+8Z0IYK1+bce+TjPsHFSJ1jY6mLdKVojEjm+rypjQzFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3682

From: Jan Kiszka <jan.kiszka@siemens.com>

Some stable kernels gained this helper meanwhile as well.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
index ea7ed3ad56..75a1da3504 100644
--- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -54,7 +54,13 @@
 #define close_fd(__ufd)	__close_fd(current->files, __ufd)
 #endif
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0)
+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,15,0) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,11,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(5,10,188)) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(5,4,251) && \
+    (LINUX_VERSION_CODE >= KERNEL_VERSION(4,19,0) || \
+     LINUX_VERSION_CODE < KERNEL_VERSION(4,19,291))
 #define dev_addr_set(dev, addr)		memcpy((dev)->dev_addr, addr, MAX_ADDR_LEN)
 #define eth_hw_addr_set(dev, addr)	memcpy((dev)->dev_addr, addr, ETH_ALEN)
 #endif
-- 
2.35.3
