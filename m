Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187B41216
	for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 13:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RstwsQDNYCZ6SE734pn5LEsDH2Sfl0nFwhE5ojQSDJoI8neF9OOAIa9vi9afXj13wYUUXVSLFbAnerTZKc5NG4bleP6dKyjLJ9XSdjn12FRiw8zDS7gdmKWFW4BH0gNazz7XBV59SvtolJEUeSxrm1TrZ1yqUoYkCzo7zz2p1WQUin9pHEDzfG2EQ4tlWcGLslTEY7rxaD9S/SSGWM3T8Vzf8wHk/IldDY5S/0MeZxOGwKDGJsfM0ZIga2Ou4ZsPnv/aDUQMywgsVRiFx94gdIRCOKckQ7f5VHn4poza72WiY+M6w5qj95JrmoVGBQt6nzbv7lIgoMoYIgrcodcixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTP6ykSnjONGVtXHV7wpX/hhFidRob7TjprPO1TvP6g=;
 b=YtSuXiLGyVkdr1Cp/JnEkrs8vWuvTqau6FqBsoa7D3pAQyEyizohCK9ZxVaoLkGSRZ1Rx9xcmCy50DaBFVlzwO3LNNiFXcP1aUex+musxiTdq1lfburSMTd7YD6J1x8505C+C7nDuwiBuvu0xgoq04x2paE8Q1GYt6n9QmJRXRydC7ogf6uqWibrt1DtC/aiHUxEcGlSKeBDPhqnFlx/egP6lCOt8aGKfnrWQo5eBlwRDWEDY8IQB8nm4Lxuz++pIWxirprApuabSTvVuIxWSvMIWyav6bgvjHG6QeNxAp9WvqpZkqwkTMvFEVHUXjVe77YFoD9VPdNMsVTFLx0JDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTP6ykSnjONGVtXHV7wpX/hhFidRob7TjprPO1TvP6g=;
 b=T4CtrNLVstX30tE0HRUtN8FMIbW1zPYOQkPyjxfYcFipvjOQmZ43EBibva+pGT41B23Fj6cpW923t+eN/kqtVPhSc1ZW08mW0WoIGSM/pId6a+CBv1tg0r7jWD5coBo9n33Bm6lbFmpbIaaOLpOvsF8btmaavJiJecbSncw5N9l/NWmsz1gbjHkCvVvqB224yINm83lw6WvSSFPVNQESBfYtDCZLwMkB8DnWgtk3eVqZys93t6weJgnqA3PAcQ3NbpNjn4vyKzm8WyHIrsXABAroU/jez4aWAKnf6kEDonJcRjj3dU2PCFDhJdm0yZAwbiBHi8bcqO5ehp/6bAFyWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Fri, 29 Sep
 2023 13:53:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Fri, 29 Sep 2023
 13:53:57 +0000
Message-ID: <4ebec015-0aad-4292-97f2-5310cd10de6e@siemens.com>
Date: Fri, 29 Sep 2023 15:53:50 +0200
User-Agent: Mozilla Thunderbird
Subject: [xenomai-images][PATCH v2 4/4] Update Isar revision
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: xenomai@lists.linux.dev
References: <cover.1695915167.git.jan.kiszka@siemens.com>
 <3f1040095513514d822a8db109d7bde87df48d75.1695915167.git.jan.kiszka@siemens.com>
In-Reply-To: <3f1040095513514d822a8db109d7bde87df48d75.1695915167.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:610:53::39) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ff8bc9-c03e-4f7c-c011-08dbc0f38664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5My9Seg1YIgTc9+RjFxVHamtPkw8BKyM3wc3W6Ub5ghqQhVmXUaw0teBz11xDbqbxKRqcmWTV+5SP7gq7O9mEug1qmBOTS4DILdzVQRBbfn5sY6s+im0gKzqCb6ayZswn5hwtrU5xXQ8hd7fy4GH0J3ttwfU4we73lTMkpWgJwljKUyyStX4eVMy1LUTMAdCx5OrBDtjesOIjE/GnIJK5fo1CbRmMo0hcak4GzEN7ElXFor9lSOFJet/v0FStpm/UwnA5RWs5RSEDnfOtmip7hYvDG0FzlJWD7+cqGCgQ7bXN3DbRRAXhVmghzoL4GtNsYWO3fdClrdO5eZAFtu/NhdMcSK7ar6wqOZ2c6/i5a8YDs9b7am5nGi4U65ENHftAYfNQMAqtbe3SsBXRi1VF+ga06f6VdTRo15wHFPgyN328XUo7SnxQUsr8q6WokQVZaLiXnyVSRAVwBjicsyGlzqUDXF186TdzapjBPU6psMeNlVQfKsvR9EKHtIrSoV/M03vRAD3RiSWSNK9Fc9j1t/kR6TZjfWKpiyK335PJE593iXHc6qfhIHWQBLTiw666tdSteAZsm2nKYEmKDutbEMtQ7GIbkOCuTGHCGqmYVfjC5knXC/mjaJT507fO+vu/u62Y16IrW94c6NWa91XMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(83380400001)(6512007)(6506007)(2616005)(478600001)(966005)(66556008)(6486002)(44832011)(316002)(66946007)(66476007)(6916009)(26005)(8936002)(4744005)(5660300002)(8676002)(41300700001)(6666004)(82960400001)(36756003)(38100700002)(86362001)(31696002)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG9Vbm1hOVE5bW1BMjdhb0pISjlBWTVUUnZkQkhwanNvbnJZWEo1SE1qOFU0?=
 =?utf-8?B?dEdwSkhZTVhLbkphMElPSE5UcjdlZTgxTi9Uc0VKY29hMHI0SEFReXBOQXQx?=
 =?utf-8?B?MG5iK0dqZWxHazlJcGVOaU00aTQwbmxiZzIvQjZqWldHVHRYdDBFY1VDK2hI?=
 =?utf-8?B?aDhLaWhvMW0xQlJWZnRCaWhaR000eS9McHA2Zy9pZzdzcnlzaWxDUmh3eVZQ?=
 =?utf-8?B?bzhodWNlaWxmK1NnZ1lET3VvcDhvNjFZYUVybWNhMGxZZW1LNHczNm1rek1T?=
 =?utf-8?B?eU5QVUZBVGxrWGZxT094YzlqaTVkWm5iWTkvUmRhQ1FGU01LR1FXT2d6b2ZT?=
 =?utf-8?B?bk05ZnJmNW9jRkhHL1ZYZU45WHVtWHJzRmdZQ0h5KytNYVpQaWZKTGVsZXJX?=
 =?utf-8?B?SS9XTnB0Y0YxTDhhM2ZRdC9CV3RLUTZUZ2phM05HRnI2N0tQdG5WZHpBRGd6?=
 =?utf-8?B?cC9LYXp1U3JXTXd5bC9NZk1kWUJaMG5yUFN3WXFRWVJhYkxYVTZCR0M4N1kz?=
 =?utf-8?B?Mldmc3V1RlhxcjFhYlZxa3VOekw0cDEzN1JNc2cvQmlwbkZKaHk2eHRmYWYw?=
 =?utf-8?B?N3F3MUV4VFdRK01aNG9XUWxrdExZUHdydmhHNThhMk8rWk9BZ0NHOC8xYU9B?=
 =?utf-8?B?QzhGejh1ZDh2UzY0VSsyZjFuTmtYM1hnMWtWazVFaTFJZlBseEhudmZMYU52?=
 =?utf-8?B?WjNiV3EralFEMWhZKzFiUjcva1Z2eFdhNDNSTjM2aHZzMXJrdVZ6Z2JWWWpN?=
 =?utf-8?B?d1FIRWljRDhYMHZLYmZpMVlaRkRsM1BxUEU2V05VY2JieC9QdFVZZGVjQXcr?=
 =?utf-8?B?d2JiQk1VYTI0NzNVWDJMcGZQQWZzSFlCL2wzZzRnY24xM2JYazA5S1FUN0ho?=
 =?utf-8?B?elRKZ3lCYzZ5QnlianFyVnFDdWx1NXJPMkVDTndhV1RPSSsreklRa0dwb0Ey?=
 =?utf-8?B?clAwNkhPTUxLQ3E2aEpLVjVCRkR0TjErMitTMmV2S1Q1d3pFSlpLai9EMXBn?=
 =?utf-8?B?TW1XS1FySUd4cXNnd280clJFdDdKc0xJRmg3TjhndmJ0Q0ZyZU5VSDFaQkIw?=
 =?utf-8?B?UGQ5Tkg0ZUVEM0FHTzVtVWVrRXpZc2twYm5qdjZzcUZmaEw2YU9ubC9xOW84?=
 =?utf-8?B?ZEpFam5jUDQ4eFBqL0FwdDZtUmw0S25VM1F0QkdOdTUxMkloSHltbThCdllX?=
 =?utf-8?B?QjhNY3FyYWtBWlU1Zm50aUs4c2lKUHFveEswWXdKbXI1elZBYnBraFBSV29M?=
 =?utf-8?B?OEY4dlZKSDM5c001WVQ0Rkk4eXU0eDJQaVIzaER6aEtjOFJjb3luV2drVm1W?=
 =?utf-8?B?VTh6ZVQwZ1RjYVNyMDJoVktsc00yM1dEZGJ0LzlJK2xJTzFHcjZwbTBvc0Z0?=
 =?utf-8?B?SHdwUFFUVjl3MXlsbWNTcHg2ZnVQRzYydzFSVTRES3BHRnZRT2FsYkhpS0s5?=
 =?utf-8?B?amVyNHI1c0lCNFIrOGY4Qjc2SitxNzFMVlJrUFAxM3ZlWFpYcnlrZEZDNS9i?=
 =?utf-8?B?OVVhV0VlMjNwcUhlejVIQTZiYWd3emk4dVhXV1ZScXpidFlyYk5WOHl4V0Vx?=
 =?utf-8?B?U0FtQk83UmNPSjE1NHJGNnh3RkFkMFVxVEdmUldoR2ZScGZUQitubVRNRzcw?=
 =?utf-8?B?NVQ3RUs2QjJQUEdVZTlBeUs5bVJVV0hhZVYxaTE3Wm9KRWVmdHlSdWJLdnh2?=
 =?utf-8?B?d3pzcERJOVFWTy9zeXVnYVNWdWFFTUo4V1dLM0Fkd0pxakplOUJEWHNmY0Za?=
 =?utf-8?B?aHBjTnpmbk9NQW0zeHB0YWpmelRqZlA2L3ZNNHd6NkJSaUJzc2JQMmxWcFBz?=
 =?utf-8?B?L0tod1MyZndFdDJqc3BRbmVPM3MwdWJPYlNMdHExWVR1dVZIM3hrSGtWMGxT?=
 =?utf-8?B?MllLWCtqRjVqWjhKcUhJVVYwZEsxODEvMU1pY3ZUYTFiQjkwM3dHdE1RL0dP?=
 =?utf-8?B?M0lTcUpjSDRZU2V3WHEycldOLzIrQVZYUTJodTNEbmxXNmhOYXRjMGZrRVdZ?=
 =?utf-8?B?MW1SVEtxbXRCdUsvUmVSYWFSSldzbXhGenY4alQvVUpPQnNES3BrV1VETnpy?=
 =?utf-8?B?U04wVmVBMlJwaGZaek4vZjJRbDBsRXBrS3JIcVdsWkp2WkY4ZEVSVjczTzlB?=
 =?utf-8?B?dys3cGloclVYUEVsOTdYclJwUVZtRndEdFIyYXdzTk0zSjEvT2dBK2kvVDQy?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ff8bc9-c03e-4f7c-c011-08dbc0f38664
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 13:53:57.0978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOGLk8X7KlivkeqliDZs9fm/PcT+0jkPzhHg5UWcZsI+Nn1hpyGhucDwiBF84NkuUEj0RNXDRVZQGHw5Q4ncqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7588

From: Jan Kiszka <jan.kiszka@siemens.com>

No adjustments needed on our side.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Patch from v1 is now upstream.

 kas.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas.yml b/kas.yml
index 26ea415..1b2e857 100644
--- a/kas.yml
+++ b/kas.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 4de8b0d5d68ad46829fa1360eabcf3fc8662a39e
+    commit: 216f0721265fcfe965ac48b51a0128d612d89bf4
     layers:
       meta:
 
-- 
2.35.3
