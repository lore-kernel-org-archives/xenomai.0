Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2087.outbound.protection.outlook.com [40.107.241.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BB45BE4
	for <xenomai@lists.linux.dev>; Sun, 17 Dec 2023 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Ljb0wYxU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3BuX1ONZFsn/OjBhJUDme+RX6xm5lbZQfJmO4rcUTLAYQ8T9xp9qW7UrOaVxlhhGsyW2AFVTYGg9vxxe0b8j1VbiNdTQS2JFFhn3QbCPuePpbNQJ5AAVyCCyVFY3VS0cWcacdkSzq+mDqBqT5z4psp+eytuisBs6Ew9grhbfjjOnZCLYrjhiWJwZc9aoU9E1izHxcEyO6Vg91ImkQO+3M094qNXH0T5IfqEiYfVc0xMK78yYSOV7NBKlVdnNGepHUvk/1+a5bRN9qRihhjsAsmnt1SLzcNjeTOtyzKVhAWJLP3+V7w//Ln6ptXF0Wu48bENV7ZdyWTPIjZ54HnOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPlWwsUxS4Dv2BWiNFWu6LuwQwXCzbURYhNLt/TnrsQ=;
 b=aN4746v5PvXEKOvXUwLCzzOyLkJcuohPoUm/MpdoBnhSo0YszunDoeTZ5Ev6JExEodHY+vJrq5npSnG0qzw0kB6ImbVsW3YFK6KwtnxWhN7K7+1/3jX4S79prJOpe/CpE8a9Vb/m7odl++rqAngVaNHq9Li3MsxzorgBKVKmuDTR+k3AM7JHot8RkAudpQ6DbM7gs4vYsGKtwn/IYT8nalOr1+fbrUXKEblAx7YKun3p0C5CtJ9V6I9dLiBMgIgUm50hhQMRL2sglts3C7I+2yo72G4fYIpOD0ZIp/kMG9j1kH+ui1qPRGcWZRTZn9lMmQkfkV+qXZci2aeOe+xXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPlWwsUxS4Dv2BWiNFWu6LuwQwXCzbURYhNLt/TnrsQ=;
 b=Ljb0wYxUdwsXEC3zkeqIw5eaeDIUbUgIsz/7yUlauXRgT9f8edKYJxAZOj+vLDNsLY0c6VK3E1A8K4j799pWLJshFMJaY1G9ceWHytdldDPfpuANXl/82yRuENRxwHWeyWmVB3TiNBXh1AGlEC8LPKFaq4vPKGmyhuX7OcmZcvzMmIrIoqL7EZONWtexzF3jFJ8imgnSceurOajUyqXr2KHsWAiTMHn8N9bi4CF8TYbqd0JFBfpKP+jHOZmizyyleooeFyDhsoDxAmC/iUnUqEtun8OTuSy+IV7GV+oiY3oyvL+4EG2DwdbcpzDcbtQ8pqmuMpzu6Zw0rx4iP6ii7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 16:22:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 16:22:22 +0000
Message-ID: <76d5ecd7-ff91-4973-ade0-a1a63fdbd9cc@siemens.com>
Date: Sun, 17 Dec 2023 17:22:19 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [libevl][PATCH] build: Reject building for i386
Content-Language: en-US
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5300e6-2c58-4885-56f6-08dbff1c58c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LrmXrP2N7b8kaXJVXdrJ3Md2IVjaTpiauZaYA45FXpYRgvJzf6riIO/7N8/St+y9/nU0R09FporVsCzLzkX3fKKhOtFt10aaWTb/P4kJ3gtuxSS+wyNvKbnjRHYneSAfDaWQ8oadHto2CJ75ThuDTuf62RNiTip0JMGHV7bATlC7cekEMGZpd4KrlAhYbAsZJYfNkX68xF10kq1qXZ+r0nj3dXc0ACL5ewr5GbB2X8IZMNJ06EsB3gaAGlioqoDaAJ7AoseOF/hBMyM9xSHaq0Mg/lLaFpigcQoyzLVCyun7+utjwWSln9241cVglQdVcxt5f7PmZBcz0o73m4zqGIiV8roNRwaDgRzXwZynEMR5SjuFVujJA5ihXHfNHuKz5iL+1wuz/xAXCWlfE0LgmBbCcFVVERyFbqe9Apn16S8EC7bheZ3wU4ln2JR9uKn7bKQX7eZr6HxfGtpEpEj+yXRB0JOuyr072k3j06Fr1qtIUDtijMXL51pRY7iV++WZYFBbUZwKWndUgMcmkzO7bEY1aQUSOOKQBkmr7LueUklOmmlWjaIC273kxki7U3c6RjD30OcrhVfj8gqdNKrxbiOkQCsDvrWTR4hxtpiMEAG+Bf1qF5OYidWffsY3qs2GCVUZ/j+/f0TVpf/B44WzGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(66946007)(66556008)(2616005)(478600001)(6916009)(66476007)(316002)(38100700002)(26005)(6486002)(4326008)(44832011)(8936002)(8676002)(6506007)(31686004)(6666004)(6512007)(5660300002)(4744005)(2906002)(86362001)(82960400001)(31696002)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OC9yY1BiN3J1SlN4TXI3SjZpV1BjN1pKdUp4bzRyQjR5OHdrKytnR3hDTlJz?=
 =?utf-8?B?UGl5Z1U4RytiNVpuaTUvd1IzbDZtKzdxMllxL1FjaXovblRSak5MMVcvakx2?=
 =?utf-8?B?dVpXbjJsM2syVFpJM2FUMTY4S0dHa1l3RGU1MXdjSnliRUNPZkpoMlNPdkVq?=
 =?utf-8?B?Z0tVOEdlekR1UVpHUXJTbDJWb3cxRXNjN0U1K2IrWnZUK0FjK2V4STN4TTZJ?=
 =?utf-8?B?ZEZsSkNUWFR4N0MzS1Brd3YyczE2Nzg2NUU2eUdGWFRlQkJIUG9sOEpLaHRn?=
 =?utf-8?B?VzV2Nm9WZnJIV1VLQzYwYkJwU0lQMjZwQ1lCZ0ljeXpLUk01ZmhDdkdjZDlp?=
 =?utf-8?B?Y1J3dnYzdlJLTmYrbElTUnhFUlNLdGdsejlxeWNRRWZXT1pra0Qyb2pSaGV0?=
 =?utf-8?B?cWUvZWJkampEUXdhTFIyVm5CK29sQ1lseVBVdkZZWEM5b2l6S2pTQnRtWlE0?=
 =?utf-8?B?SG9QVXdRdmxLQm1MSGJveFR6Zkh0N1Z4djVMQldteDkzN2lDUVBTMEovTWhN?=
 =?utf-8?B?YmRBdUVyT1J0enBMSnNFbzdqV3h1UWVtMEl2Z0loUENGNG1kQzdVcHZUQ0U0?=
 =?utf-8?B?NFd4OTBtQ0FoYzlrUUx4TVU4OGtidmNheXZ2a3VjcXdwZHFjdGI2MmxyLzBE?=
 =?utf-8?B?UThvb0lPSWtwUng3UGZZbm81eWJvVURSRGlJRHJZOGxLQU5KWVN4YXoyd1FD?=
 =?utf-8?B?ckU3bm1qMUJIZUR3YXhOaU1RbjJzTFowOTR4OGRBVENBczNLdG5JY3VUZ2gr?=
 =?utf-8?B?a3J4Z3lLTkVEbnRzQVpRUm9CUlRPTzhCZ2tsNTlSa280K0ozTjFpZzBWTnRD?=
 =?utf-8?B?QVVmbXVRYUdWZExCbHpyQllOeHBFZDVrYVFnQVErNXBnMXBBNnNTTE5oSFla?=
 =?utf-8?B?YlJCS3BsWEZZRkFQTFVUQ202VW1wdVNhVndnaU1RVXJEYmhDV1FMdkx5eFpJ?=
 =?utf-8?B?SWxYbUNSempLcDFQVkl2T09qSkJ2TVlpL2liOHVBV2IvVmxKMkdrUE84MWZi?=
 =?utf-8?B?aVV0cUx6L3lsTGd0bTlFdU9mU1d1STVESU4xUVVIUU5XTk5GTklzU1BUakxw?=
 =?utf-8?B?VVVBakRnV1M0dERoZUJjcmtveUxOcHAvQUt1dWtKek5MTEhka1dtRUxxTXph?=
 =?utf-8?B?N01PTktGYTVTSkd2WHM5TlZiaTdhQVFZVTdNektmWGt2K3psNlF3Ykx0cmVR?=
 =?utf-8?B?RndybjNxa3oxOVF5OTZScVVlcVJTSlI2c093d2lBNUFMRlF5Vm1VSzVNREhh?=
 =?utf-8?B?Qk14THlHTDBsUjFjSVNQa3JYL1B6cElJWkFUR2lScFcySjdFL2NaY1R4Y3kv?=
 =?utf-8?B?UWJVK2g2b0lnY2RnKzE2emJLQnFaR2ROTEdEQm1jQ2FGQVVZYzBMOWlUMUpC?=
 =?utf-8?B?b3hMUVNYckhGZGZhWUZTeDhQKzg1eGlrQ0x4Uko5czcyTzQ4OXMxTTNvNGw4?=
 =?utf-8?B?aXFOeTh3Y0MyamxVc3huNjZ2dDR2ZEtEOGpOTHJBRTBuNGxrU1hxNUcrNVZB?=
 =?utf-8?B?ZlNEV3NNeWcrL1VDUXVmbUdnbGQ4MUVxSU56OHNtNUpreUoxNTV2Sll5N3g5?=
 =?utf-8?B?NEhvZEt1RTJ1S3hZdUhDYThsWGIwNmVxSm5uT3l0VzRZL2JWVmd1YThwSUpG?=
 =?utf-8?B?dWdMdWZibVBCbnZ3VFlvaDhLeWpUYlpYMEZBa1NyditUYlI2SER3ZTRQNVlB?=
 =?utf-8?B?V3BtV2d2cmFRd3ZEaU5BZVZVMnlqbkRYcFZwd09yVGFxK2xTdjlZaW9zYXB6?=
 =?utf-8?B?VXZ6aHIvUytSN0xmVUU2bXl6ZDZOcmxraVcvYlRUTVZyMGljU1R2eW5PL3hh?=
 =?utf-8?B?MHRRc1RxQ1ZXMVNheUFWU3MzQndDNE42QlpLaVhnT0VJWDBQTW0vazVwRm4w?=
 =?utf-8?B?ZlhRbW1pZndpUnlkVXNaRFFHemg0QWV1SWR4aWl5eGZGY08yVjM2N2ZLZ1Z3?=
 =?utf-8?B?WTBhS0MwMVNNV1pqQk00VFFnK1ZqMnlhTmVTdlBnRGZKZHpZZnNnaHNZNlZN?=
 =?utf-8?B?dlpCUkpwSm4wNkFxZXQ5dG9KL1Z1bE13NDRIeFFIMG0zN3pkOVlTc2lCZXMy?=
 =?utf-8?B?QkpKa3NrNVdLOXhvWlJFRzcrTTRuakRNWHIyajhRaXVGMWRxeDd1c0R5QkY1?=
 =?utf-8?Q?Ia/Nz4eAVva8mWqddbyE4HmeW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5300e6-2c58-4885-56f6-08dbff1c58c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 16:22:21.7463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yboVWu/0+7qh/6RQS3NO7Xgj9QlrXee8XwMkGacdCRLIBOykeBMa4ELeaopbOl6SDanUN6HU250AfEzN6gE97g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6057

From: Jan Kiszka <jan.kiszka@siemens.com>

This architecture is not supported but we were silently converting it
into 64-bit x86.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 meson.build | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index bbde902..fdb2e55 100644
--- a/meson.build
+++ b/meson.build
@@ -46,12 +46,15 @@ pthread_dep = dependency('threads')
 
 # Do some architecture name remapping
 libevl_arch = host_machine.cpu_family()
+if libevl_arch == 'x86'
+    error('i386 not supported')
+endif
 if libevl_arch == 'x86_64'
-   libevl_arch = 'x86'
+    libevl_arch = 'x86'
 endif
 
 if libevl_arch == 'aarch64'
-   libevl_arch = 'arm64'
+    libevl_arch = 'arm64'
 endif
 
 post_install = find_program('post-install.sh',
-- 
2.35.3
