Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DF10FB
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 07:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL6cLyuZVDrF9eqfKuR5b9S+2MLBrXA8JrG0xnGENN2b3bYP6ZRR5C+Via76Grbbh11G1jvs4WBo9mIYkqaZjb2C6xklc2tR1cp08619LQqkZTyfFDelBmHsQpBxnoapBhm016WjzT8Lxuq3cjw/J4oXIwo7ODaAvpnXJhBN11s4JtG/F4wHjwIoY3088Q7ts6h8HnLru5FPF0uL2abRylhx95FFQuccUq7rFs6RYa44aA1Q6GRxf5m0FLZbDHr6hjBVKyW9/07U2vtY0clZ+xq960vzV9MzWLy8NjLUVedG6ZTyWyLoPD7lbbDcsD5CdXgzBW0mdfYgtrSshABCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GMnqJ7KLjGldG538QbSm5MfJUJKHSMMjUYr33Gh6bk=;
 b=luzt5r7qEVzMfbxJnS+gVihv4vTNc9tWj8JY0osc5s4DUOy50qD2rg9LjdDZ6ZpPxByi+vD0amKfliKeAycmVV5FvAF4+swDP9TrXEWC0FV6tKy2m2sQ59+2luOSLHbKxKFh+zSqmRi6Nfr0rync8E0qCD1NeAFZCrS85LvgrytYw2gJp5+DZxm5z1V3WJ1kEFK/7pf/OGNh0+36SLCTKz0coJT8vEf3iJdjFK9+8nST26DvM7aGuj0KwBvK8FMTZAniwhO8WkImiCD9TbxhDu10NOET/2Rowbqq1gwi44kBLTDcXk1AGFzoAge1vsB0efUeIJ2re+xuGkDlPQtHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GMnqJ7KLjGldG538QbSm5MfJUJKHSMMjUYr33Gh6bk=;
 b=ZhKUM2wDsW3HszTRmm1FkKDWI2QbIebilFFek+hawlJFXIgWMvU81ZzfUqEurMzdcn6E9cd6IAAVVzzwnjj+ioBK0xDz15CQEmpy4h7LOV7mpt7Ka401G264shY42yK4qEjADnekrGfMCsQH4nWeIRoVcTYtaF87AfCFY/8vAL6hR2UtCjql1sFYeQSe2d6QV7zfgaMD7IprML/5rpyeJvsTo1TumZXefNc5jIzh4dh8pYStfOQ684qVgR5yhPO6KU1V4CvGCDHF95uxs5zQu97TL7CUuwl9HrRuDoMu+nu5o03my4mNCAhXOJFnVDumt+6C4QPQ/YmHwiZ5YEPEAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.12; Sun, 16 Apr
 2023 07:47:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Sun, 16 Apr 2023
 07:47:09 +0000
Message-ID: <5bbafcfb-5747-4dbd-daa8-a62d02583bad@siemens.com>
Date: Sun, 16 Apr 2023 09:47:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/net/fec: Declare broken with 6.3+ for now
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Cc: Gunter Grau <gunter.grau@philips.com>,
 =?UTF-8?Q?Jean-Baptiste_Tr=c3=a9dez?=
 <jean-baptiste.tredez@ba-healthcare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0131.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: dac36f91-8c0c-447b-a0d4-08db3e4ec855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E51BoRVFkC6n1zF73xZfNvRL/gcPLcKn1q3buSz2nbSa0lyHoDAWUaGpOyhjZQhO1Qj5lDxry0Ee4VnX/1piNBvfeFSv4LNBB7vLUIGUcOAnia3ZiJhU08s/oufnIQj0gwIbzDvMX/S+pQdns4r9HAvlsE4shDa0/mXvWvqY9E6rXzh1BMun2GIeL/MeBQ8jXuNz9skv4uaTVugb7JYsLAU1SWdSaoeWjLOhBsbEfZB2pnxgRk6fsxpS5c6VhhijYS0UcndUvXKblMmUd4t+4Jb6+tn1WoXEpCtSYOcAAnppE03Y0/5FpDvG417pghMEBWZJipHrcT5/u7K10Yfk3Mf30JMr//UmdLMFfYtlSArIGitnEsoU/ZfuGSs7jlueclFlwmiDmYr0Oi07ljXx5P+mZ4jq5i/zHTB0oHxg9mH/6CJL8TqULdG24ilgqLV877yozf+93Yi81LWrJedYrPh7pgW4RorQ19Ldu3wJwtlE4PNiw3T/GozN41SQc0RWfg4FmL2Afcr480xpQ6igmX8UYA+DiTqMirjtWf9PxrewDrKOnECG50H4qpkN+kAIII58I2xdD6KW21huX6+5nMeWheEY7tHc00n5/wkcL4N325u6nXK7NrVp/hy4ppVTdK0eNvEJ/QlXW3OkvRnLlg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(36756003)(6916009)(4326008)(54906003)(316002)(66946007)(66476007)(66556008)(478600001)(6486002)(6666004)(8676002)(5660300002)(8936002)(41300700001)(4744005)(2906002)(44832011)(86362001)(31696002)(82960400001)(38100700002)(186003)(2616005)(6506007)(26005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkhMQ3JwVEcwZjVKcXQzZ25JcVNwQjc1TlJEakxTUnhhd2UrYkVxZU5aYjI2?=
 =?utf-8?B?N3BzWnhRVUN1TXZVSld6UDdjK1czK0RDS1FiQkpnVjZtdHozZS9SWDJLdGVw?=
 =?utf-8?B?TWdWT2R1VVUxd0ZHZWtpZXlrVSsrd2VHNjljOStQUkh4UTc2K2FvVnZZZmg5?=
 =?utf-8?B?YmV3dzBrem0vOVlPWk9JT1FvTUR2QXNoTUx5eTJETW04dExLR29vcktzYmRQ?=
 =?utf-8?B?ajdvUXpGcHUrRzlkckpOclZIalkrQ1ovYjVQd3NHL3g0SjZXeVBDY3lXVnE3?=
 =?utf-8?B?YWtoMnd1aU1LSFZLYjR6bm1ieDV3OFllVzVXdGNqUWNRblhvUVl4anVLWk0w?=
 =?utf-8?B?VWFOZUY4WlRDNDcrV0Y5ZnRyQ0c5b3pKLzdTZWZEcDdiaTRRVCtKMXhhYzNm?=
 =?utf-8?B?M2ludGt5dWNsZXJGbG15YmJMOGU3WkJIWVlzWGNCSi9HbWltZzJNek5kdFcx?=
 =?utf-8?B?WkpvVENWQUZwaHdrVTVwOUlZcXRUYUlkNGhSaGxpcGNSQW5QRTVyL0FDdVYy?=
 =?utf-8?B?M0NpSERxTmhPZUpENy9RNUZBdzY0U2lFc1N4S2swbE53OTR5c0VMYTFUZnd5?=
 =?utf-8?B?V2VTU2UrdWtKSTdaVnBxbGVZZlFiWTNlU2RvSnptVzZyTk9lQmF5THBEOW1o?=
 =?utf-8?B?NEp4b0JUZlA1N0I4Y2hhVktualhCdmJ6d096bStMTS8ydmpmRU1VS0c2NG9x?=
 =?utf-8?B?RXpPZnpQQ0sxT2RYUzhJelk5WTdxZklqYzZGSDJTN3ZFUFFVNkN0TmJVd0ND?=
 =?utf-8?B?QjUvQkVIdVRkbkxBSkFXUWRBMm5YSkVCdzlIOVZBL2pmU2tlVUVzMzJUeGVl?=
 =?utf-8?B?K3gxRHRxdEpMNWZUcDJRVGVKZDR0VlY2cWova0cvRWFlRWNIZDdqb1JWZ2dv?=
 =?utf-8?B?RXBpVldPYVUvRmtyOUJWK1orVm5QSFMyZmFNaGRoRnc0elJhc1ZIS3BXTzZ4?=
 =?utf-8?B?c3NFVVBKdEZYWVBmODFURW5CM1FySjhuY1dGYnBEZUVRc3Y4MUh3Zm52UXdh?=
 =?utf-8?B?WndvS243WTVwRFlOaXprZkNISEZYcWV5N1JrSzVha3FwME01WjhNOGpPVVFh?=
 =?utf-8?B?V082QXNaMjlQSlhGODFwVUFBdUpQZUx5YUEwanAvM0kvUXRKZElmRUJFczl2?=
 =?utf-8?B?eGF1c3Y1THNSUEUzc00zV3hIQXFUNXYzYk9YOWU1MDhITkhXKytjSmpaanlC?=
 =?utf-8?B?dGhhZHhZQXBLTlJsc3lNTWRISjNQcEVyWDlSNk1VUjZhWnFES1hTQnYvSEdw?=
 =?utf-8?B?cW85MVVxc2FVL0NVY0VDR0lDalpaUmRTVENURVFOeGhxYm5DcUl5YU1ZOXV3?=
 =?utf-8?B?bTlIYm1xcVpseFpIYWxoUUpCQkNjTVUrTDFSNjJLWEQvcWIxRndJa1AzY1ht?=
 =?utf-8?B?dVNEMks3NDhLT0dFTXE2bXBQT2ROOFJZMFJFT1JXekpZcmtwRFRORjFFVWRD?=
 =?utf-8?B?U0hqeXZqdzFMMk9qbmxVTXYwZHpqaUkweU85VGJSaWoxZ2grZ2tvd2dRSTE3?=
 =?utf-8?B?bmcvOWtuZVlOOGtvMitTZ3ppUkYzQlI5YU5rclBmTDZURExiSmRxcC9Rcko4?=
 =?utf-8?B?L2RFVHRyWkZpSGwxV1lwaThTZG9nUmVUYzVNYUtoQ09FdndkMnZmcGtGVjFk?=
 =?utf-8?B?MlhkQmN1NWtWdisyU0RueDBHd1dUUEFxUFo5MEVCTjRCemVjUUlJZ0pJMWND?=
 =?utf-8?B?aXd5aW5KckJRSW5rTzdtZEVaVmV4Skt1V2FGSW5kTHpuRHB0Uis2UG9ORmxx?=
 =?utf-8?B?SmFJTFNlMzc1Zy9kbjVLYjEwNlJpRWY3N3JWbFlNaUVCdURsMDJqdi9EbWVN?=
 =?utf-8?B?ejJwMDU5UVRGa3FKVGJsMjc4bWI4ZDZ4TTFqUkRGdmVncHRhbjNlakhTb1Zr?=
 =?utf-8?B?T3JMQVJIbUtxV0ZadUpqRzhDT1h2bllybDRQT0JaTU02MVYzV0RnUXdPTzRH?=
 =?utf-8?B?c0cvYUlYN05FK2NWL0pHcGtMWUladHc0M1Nka05hdERXR3JmeUFnR0tnZWhH?=
 =?utf-8?B?bXBkQUk0UHZhcTNXZGFjN0JIallqTUNDRjY5S3R3M0ZzUmRBWE5OZjN3bEhU?=
 =?utf-8?B?VGdKRkJRZTMxZjI0WkdtalFsbFF3ODh6K0sxTU1YNXBnQlV1TEJOWTh0TCtZ?=
 =?utf-8?Q?QFVifSG+4xRif9FFi+WG+O24M?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac36f91-8c0c-447b-a0d4-08db3e4ec855
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2023 07:47:09.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpaD5MHPdk67o7+8g+exJ3EuAuvq0ClQvyRDBEBD+oBxmq+BDix7CVgKMe4NGd0uzyDIqcvgTFDaTtfcx6om8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7908

From: Jan Kiszka <jan.kiszka@siemens.com>

This is due to Linux commit 8d03ad1ab0b0.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/drivers/Kconfig b/kernel/drivers/net/drivers/Kconfig
index 716f67a74d..8ecd560b01 100644
--- a/kernel/drivers/net/drivers/Kconfig
+++ b/kernel/drivers/net/drivers/Kconfig
@@ -106,6 +106,7 @@ endif
 
 config XENO_DRIVERS_NET_FEC
     depends on XENO_DRIVERS_NET
+    depends on BROKEN || $(VERSION) < 6 || ($(VERSION) = 6 && $(PATCHLEVEL) < 3)
     tristate "Freescale FEC"
     depends on ARCH_MXC || SOC_IMX28
     select PHYLIB
-- 
2.35.3
