Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB2BA45
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 20:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4nFaVYhN4oj6XQ065N5ZZzhRj19pBhHJw6tp1poGjZY/fEKT/IHuWmLBiC5DOe2dBjYZ0goLVzkFN2mMZBcGMLLvUH9cSZu0Z3T2Xq2GHJjHpGU74NjAYEiHmcDBOZ7RURhOVXhRiV2tlv2yzXHiNGX/ilGoMRWn6b8zF6ZbRtqb1k85UFyo9VjgD9MIaskLjQ5Iius6cixAADXuzmS90mI9FQz/3M6PXfWGcyyGpTjAX3C6Ytly6AFbJmkdJ0RE3nUwXYjXUtN38HBB3HNAeYnEg74CRxCFn+iJzd90WJpWfYlRW5nmmYTqRwWAHyYEtUF5jSxfQFhLw2ECyVAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=khtxKc36H8rZjBKU4mMkX9NBWPfe9nuiXXwanp1TUFA=;
 b=Ya0lJNxYMyll7hr1KvZbFzv7cCoxKbZYUoVWUPfBSnGXXJDF9885iMVOtDNHJwmIo2RR4vuCX6NfnhYnbckxJacQ+qujsI72BbwohIT6lDN09fsrnZJeu2q6a5kOiZBNVBX7Q5lImiYvZ4MbwEFWhbqrhq2NeZHmIMMifcEBQla9G+WnAZH6aFacddPoFqUSSygmYsBrRHFLLDZT6s32/ujz59I9lZ/mcMXtp6YZbQI1seNHJw2V1oyUw/oeJJYVCVLSzSehcqpWAE8x4dbgNmSvGJAvFDv9rPe5wMI2LLYABUC5IHIbNxFr6NwiiRPNoSGwHEv7t1WBSOgWlD7YlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khtxKc36H8rZjBKU4mMkX9NBWPfe9nuiXXwanp1TUFA=;
 b=KK1b4GjhZHerUT1wjw/oPiD3fOVrjpEgEV8S8yqz1TA/NTD+25Lmq5OPcky/6QFkMGiTC7WZ0SuBlZmcFGTS9ky4ZwkPryLMSPMG1zFTSkZvx8ZkgfyJjiRUwnCDBpWR+sML2jtk27VJzG9bhQks1QdDqWUZvMtrhcWkXpGaf5bpHTv7nZahKhW1FQIqQlbMFEdtjKg6weM1ssLmWoQt1hNTuj9//vSwO9Qa8xO40OdC/ELbupztY2WFejkcWJqi/WDy7MFDN52TCkGGowIGhVnLYYrovt5XvVihx3f3ebQ3JYsWuyq7/9ZoH+nTE3KqB9+sOeNUOyshSPVB8gU/UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 20:58:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 20:58:41 +0000
Message-ID: <1922d6df-c8cb-0c4a-692e-4c43fe407fac@siemens.com>
Date: Wed, 4 Jan 2023 21:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/rtdm/device: Account for callback signature change in
 6.2
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: d222aa2f-fb48-4c32-e9f9-08daee967585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VYCgvn//7MhLoNIMSsvN4wbgTxBqbXZ1FNKSHswWSDi2ifkTqx0W+WqZVkKlZ1W+qVEsriAwF+9K97XHXb0oD18vsqBpSKDAaLl1WgtUwu493moXsb590zT27XjaboLTHaIJoAGrBQJLKX0OvF+/5/03Q4WE6Rg6cHx6fMqZagi30HcY0cueUuxsUmtiGM/BpGdTk97Qwfd3csNWyiomxp8F7VkZ4OHMza16Vzm1b8ceOGBb59uYqqC+dag94ZmRfJ1juggkSQwJG7HS4OV/AVRoCFBoQ7gKO4475wuaa6bM7RIPOoG2XEyET5o4Sh9cn2002JjuyGBxVVCpJWIr5uL/FExus58GwcbxPPAZ2mQgT7quP4DZmawT0y8KHCK32HCBxu6kAJyq9nzqTvzmWIO6LT+3vPHdoZ85BWzF1ldTXY5Lh/fXdhGiRi8N7oHqAn0b3ZmsLdoJaiXvvQAadYspdv0U/hbyAMJ7M0KiE39z6Vm9MVDYZX9HhyIyZlhUj6LLV7LxSPoAfVt1EH5yZWKpXCTY4zbDJ9wFTNtgslZSG+8Maax0tPBmJgFK2LvijYJdZnZm8ou4AEpg4bdfUbA4+zxTCDEA1EMfy0R+VgeN5ibUOYH87tRfIFxAT7617v+QmIOTE0a8bxoYi+XYuZ2WcMEMsBhhDO21Uh7qAHMJPcEHe7rBDz6M2fjLERrrVwVVHxD/YZWfMnztRuhUL5IWDmHQ+Zp0djpoP/FB9KI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(6512007)(26005)(6506007)(86362001)(36756003)(31696002)(82960400001)(2616005)(38100700002)(186003)(316002)(41300700001)(478600001)(8676002)(2906002)(5660300002)(8936002)(4744005)(44832011)(66556008)(31686004)(6486002)(66476007)(66946007)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cU5JYmM1aGlkbXBSd3NhY2pTL1I5OE9mK1hWQXU1dXZldFRnS2JtalUzQzdW?=
 =?utf-8?B?WFV5Ulo3amFtTGRMSTgxTDlwbmEvQmV5QTBKb1NablBDa1Q5eWxQUkwxd095?=
 =?utf-8?B?eDFTbWQ4dm5VanJGSkhYYi9OYU5QQUI0ajJYeExndnNrYjRHQUhPR2YveWpt?=
 =?utf-8?B?Q256MTVIdHFySS9uTC8rbXltY0RscHl3c3lPeWRuelBuaHpMdDA1V0d2ME9v?=
 =?utf-8?B?RnFFbElZWlZ6REMveElFOXEvekgzVDlCMk1lVitSUVM4SFAxZDROK3o2cm1L?=
 =?utf-8?B?Y2lUcjFCNVhROGQ2aTFCVVFETnlBamJUcUE3ZUJaSUVLTGFRTmF6eUR4RDNE?=
 =?utf-8?B?ektqaUJKUTI2ZHN0RXloTDZ6YmloRmRONmxKMnY2ZDE3VXU5WC9UcUtkeDZ6?=
 =?utf-8?B?Ung2YitHSkFnRng1czEwYzVZOGxTNHFUVUR5SkxlSk1yVEhjc1FobE15b1Z5?=
 =?utf-8?B?MTI3U053cFVBb2ZsL3VVSGVNWlRiRkZsNmFqZE45aDFtNVVFTmhOdEswcVFS?=
 =?utf-8?B?NGJBaUJRUi9jSGtRVnJ3U21ISjFUZnRHVlVRZHJtUnlKWDZQdi9wWWQwODVG?=
 =?utf-8?B?elFMaVkzV1JCaVhGd0d0bUJFNDNRK2UvYlc0ck1yZG9WNmdHdUdEcElNSWJ6?=
 =?utf-8?B?UktMdk1Xbld5YjNZZFRGVFNyWVVWaysrYkVySnp3cmRhMldDdEx1UnBuR3J0?=
 =?utf-8?B?NWJVdGxqaXJCRHB3ajVydlZxaFFoaDRKMGhzQlg3TkZ4KzR0bmpYQllDYmNu?=
 =?utf-8?B?QnJlc2dMZUh4ekNLYkxFOWRweGNsMWVGS29hSTdWNnZKN3ZzaWJhYXVSZmdT?=
 =?utf-8?B?U0NOTWdyUlFaanNiRTJaYUt4U0g1VmhwTzFmbVVwUmc1TndrZVlFaFd4RXZo?=
 =?utf-8?B?T0s1Q1RERElvR0tZdUlPN21CK2k1ODV3VGZSZllJUHNkZy9sbE1VaFI1VXpV?=
 =?utf-8?B?UVNHekJGMGN5dDRUTHI1R2ROS2tGSUF0bFdOUXFrbWlhRjVRdENUZ3NBM0Zl?=
 =?utf-8?B?Zk9HVkt2bGlLelR3ek01Z1NCenkyaFF1UGx2WFI4Y3N5Y3RDVE5leVRQbWhE?=
 =?utf-8?B?dGdVSW9EeGxrbVZrcWU1V2Jpc1hJOFZFeFRqcE5xeXhjUXMvWnZoS0hSM2JP?=
 =?utf-8?B?bmszdjBYRmM0cjJKTjhES240d212d0N2dVZDMDhQQnFTK08ydjgrQ0VsbTJD?=
 =?utf-8?B?K0lFTlZUVmlhL3JYYVp2dHFGb1VpdHRYZzRkS3RSQVAyY3BMbktiK2kzS1Fo?=
 =?utf-8?B?OTZuc1J3dEVtdVZnVm0xYnAxYjhveXZhVkxqR0s1QjVDcjZRRk8xK3VhcTdp?=
 =?utf-8?B?bnI0elBVRWFLYUJ4YXFVQXgyZlR5aVloeFFxQ3hwRTd5anhtV09jcGxGT0Ev?=
 =?utf-8?B?Tld0MmpwZUdIOW1QZFpxZ2IwNkRzMS96dm9FMS9LNDJoSXp3ZisxZStjc3c3?=
 =?utf-8?B?OHE4K3RDVEl6THpGNWtMNGlTcWJvdHp5KzQ0NWxnR0VEZjY1NjZLUkRsaW5a?=
 =?utf-8?B?dXM1T3lnZ3Y3ck1rMjMzVVM0VWMyV0crTm9EN2VhKzhuWjVVcThrMkN1WlBz?=
 =?utf-8?B?dmtLQ0djbkdqcmRMeTNKVnZvSHUrYXlpSmVoUit2VTN4TTlEbmp0dTFFbXcr?=
 =?utf-8?B?bGhoZmJHSW10QWFKbFUxeTBYU1Q1Q0RlaWNFSk5nR2FjV3hYSGJuRS85V1Vl?=
 =?utf-8?B?Mm5PTWtyYThxNWd4UW5QYmdpMml1UndLQUl4YXJwVGNPZWhzQW00dUJ1V2Ni?=
 =?utf-8?B?T1BDWFVoMitYTjJSMmtyYktwSmwzSFA4VkUzSnU3cndRbnRQcjl5QU9temtn?=
 =?utf-8?B?cGlCUWpxVmkvbUxDVjJpT1A4Vk4zWXYvRjRJeExhV1c0cExkaS9jMHFvZlRK?=
 =?utf-8?B?RVZVdmhqZmc4NHpIcC9mUWVoeHMzaDFzNlRyNHhXWk9kc25naHNEL3hCSXRl?=
 =?utf-8?B?b1lZSEFtUVA0Vk5aUUFTaUZJcjN6UkJFUG1xa056RXJ3WGp3WUUrWU1zTEI0?=
 =?utf-8?B?cHo4K21OQi9GN0NFKzBRc0twVFZkY3FtbUtmSVhNUzJsRkp2b1pjNUxDS1o1?=
 =?utf-8?B?aVBrUVd2VEt4ZFhGRWp6WWEzVXMvU0JIRGdnWDZ2Z1ZxRVlac0NiaGhtc2pE?=
 =?utf-8?B?NzZaNkN5UXpSMHh4aDV4dHRMdHp3Y2dBTHNWbzN5SWY1VitKcm5zOVNVaGlM?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d222aa2f-fb48-4c32-e9f9-08daee967585
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 20:58:41.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHPJhPPaAm3y5tn9pCZXT8I3HlgXjY/F33WmalZmRb9dj7wAsS7EPbteG3MUCDT5oeyzyVzavuCSUEyJaYU6rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7110

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cobalt/rtdm/device.c b/kernel/cobalt/rtdm/device.c
index 12155157a6..33db21e63b 100644
--- a/kernel/cobalt/rtdm/device.c
+++ b/kernel/cobalt/rtdm/device.c
@@ -137,7 +137,11 @@ struct rtdm_device *__rtdm_get_protodev(int protocol_family, int socket_type)
  * @{
  */
 
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6,2,0)
+static char *rtdm_devnode(const struct device *dev, umode_t *mode)
+#else
 static char *rtdm_devnode(struct device *dev, umode_t *mode)
+#endif
 {
 	return kasprintf(GFP_KERNEL, "rtdm/%s", dev_name(dev));
 }
-- 
2.35.3
