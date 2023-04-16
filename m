Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0410FB
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 07:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvSJ1IbNEikdQD/iFxe385cJHjsZIruiLsfVJsiKgRgVPIGA2UIwtVUXxormnLVUG+j0C27r2sjdJbPExVZIbbR0NsL74COFJlall+HhI+WcUkZk0OGXOLEhtuicHb/l8tnggjt0GuMXnFt9C0qkVp8eMz89NbzEyg3mGdWWvXX6aHuStuvXEWLIgcp0+AXOUXHNazQNwrnBoUOwHIHglxoW7WOdgh2+mOmIQ7DH642axtUQqshpIqeiTPHHE5mgXYdPVeIOj6dsE9OJ1Z+v6oVpVGhHm58H1qWIVzNLz7GxomntZTOXtxvMspZzXLzpNinGtRfDdx26IjztZWOZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwf5n3NUlSCRPcghuRgrSEYBfvaw65JwvCDVZp7Tioc=;
 b=WQGiugR6EQHBxcCd7BugHW/Si637iA+SIA2SmGaw5ykJuUSKPUNPXufTeWJ1CqntQh2LTROl8RCQuu2zxFROamvflie/+AkdyCJU/49/LrMo/DIwtbXqlJQ0e5UgK33C6BxINKIzj73UGIadJUtSZZzQr7jbgg6hFXlwsIEDwlDySRppeTYp05WFMobYeFTq1q+bgLV7d6kQir9F3OWi8mVRTLaD8FqV9rzUSKml0Jeh6iYJd23pD6N+CDUrlHVkrcAUaRdFxPcpj8m9XvmcfWntCeFkPwstXigbDOLtBFFzu8eVc/UyrI4Fk3mVe6Gu6qrXX5yda1GhAVDTm9nVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwf5n3NUlSCRPcghuRgrSEYBfvaw65JwvCDVZp7Tioc=;
 b=TP/raIKkvmX/7j4q6nOIGWvA3s4JaznHSMAau1N+Au/+hwCwsTyDpO1cnIBrwUk8noSxQ4lCXeFy1LPaVgnhe3aeHjq5sa/XCURB24iNAm44MNChTZf3gwiIsXBrMy2W8SL3JjjwzWTMkZPHoqavDmFnkhe55OWDcgqJV8olzU8k0oYx+Cj6mrZuIyjnaHfNFYrg08ZFP1CdUR2EezJ8CwVabyqrkOU3Nxc/mishU3WDExf25CGmlhAwpkoavnZyy9Ep6NdiMFSfPKeYzc64ZjvyZLI1wQj+rd9OpfOGjvxf0gMDYgetNhgUflVVV3/k15plmtj4B4uZQHh48kQDoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.12; Sun, 16 Apr
 2023 07:46:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Sun, 16 Apr 2023
 07:46:22 +0000
Message-ID: <397bddcc-9429-d850-1fa3-8cf1c1067a80@siemens.com>
Date: Sun, 16 Apr 2023 09:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/net/ipv4: Fix build for kernel 6.3+
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0123.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 903229ab-8ed1-4cf9-d30e-08db3e4eac8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BibxC4SuF8vnKNMOTJluK48rMpUiwnahIFtpf0lHrBaiITNnCIXD6FrI8HM4hvlaVRI2bACfB4DYczbEgc+tVdrSpe+dXK7LxZUsRLCqLuaq5yI6UR+t9Q9D+sJt2siIqrAXidYL9dEEvGlyuC2uNRovdy+ary3sJapBrcC80vUGqG9mdFvP1niWZLh5kcCZGpnDTEvSmWtaNifw6EUZgAiKiLU3MV0XKc5vJ7rbG7Miqo9/MWm+1D+iTVmGS9sPcYPUgs6CRKK2bDe8fLXCxka8xg4NrDySRiUyyBTd2YS4q/ZcY0q3Aoas1ZnYkFb+iwK8rEZFtStglbiWju579jXCv+kk1qC95dMwWnK0w8w4JluqehsF5h27lBamHLo8TkxtVoHtj2P3QKn/HhUhml3iJjMgcxJTCCKX+xOC7A6v381ZlbTisa2OVhDPEozhcLP9Dy9xCn2oJPVw66z4BLO0T/cXL711q4521oFXBXFfVY6Ot2rMdcrrigyPgUqCVgHHyYKPkh0cNyPw2i77teXb28DJUjYI1UDekRO2sA6q5lFY8tqficqB8947GoF3B5GdytevGkh//4QKgqBscR1uelAJHtCn/acAqzjdtxTAeB+7i77jkeMrI1IwGzDhvZCHzicmPJSSmBoICp1Nhw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(36756003)(6916009)(316002)(66946007)(66476007)(66556008)(478600001)(6486002)(6666004)(8676002)(5660300002)(8936002)(41300700001)(4744005)(2906002)(44832011)(86362001)(31696002)(82960400001)(38100700002)(186003)(2616005)(6506007)(26005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzBEQlNNRURBQkZOSzVhTlk1ZmcwUnhVdVB3b0o2UmU5bEROdkJ5NWFlSGpq?=
 =?utf-8?B?amhaRjlDdGZwRzlRZDlFNHFCRzFiWVptb2FRSDVuRmNUS2tFT3JOOTNleWhy?=
 =?utf-8?B?K1ZpYWgxMnBiMmxjZDU5VTdwMHFKWTdNckE2Q3cwNWdZanNNeTdRWDB1UEZu?=
 =?utf-8?B?a3Jza0sreTRsa3FFNmZYZkZPV0JBM3BOQnJVL3BLMjZlNVczU2RkTDk2QkNP?=
 =?utf-8?B?bHJabTNSZ3FaOGgvNnQxb3ZSaEZqeHJrZVhDbHA5NjdLR2toRWZpTExldy9W?=
 =?utf-8?B?Nm1VWGNWbFhpbndmVHYvZy9OV1ZlK2FyWitDVWVDZ0pTVGFLdkR1WmE2U0V1?=
 =?utf-8?B?N0ZhWlBiSUcvRjJmNGNndENsYWk1UkluN3FMdGg0TnVOQnJveW9ZNG9qVmdS?=
 =?utf-8?B?cXJvZU5kZy9SZzN3RzV4T2ZLTEx1UHFBWFB2ajN6S0NaOTk5QllvWnlIVjdZ?=
 =?utf-8?B?bTJLQmpyNkdzT2VNMUFmOU4vS0YyWDVadWVCK0hrZGgrZlM1dU4vbG5oTUNF?=
 =?utf-8?B?YklHWG93L0xmTVNWemtwQUxPbGhXcXg5b0EyRkZNYXZlcDE4L3dGTlJmNkNv?=
 =?utf-8?B?c1QwOWxHcVRBMVJkZHlhV3NHVVZCU0pkeDdWeHBhdUQzM2hNL1Y2V3o5Q05Y?=
 =?utf-8?B?RENuazgxajFUZlZlN2NyV3F3dllnVjJ0YmpoNXhMTTdCSzFSWXdHaHRUUUZL?=
 =?utf-8?B?ZEJLdDllK0hhUDEvWW1mdkNGMFkxdlBoREkrTS83RDBQS00zREd1bGVHdldu?=
 =?utf-8?B?VDVxR3N1UzNaMzZDSjN5cTVTRUhpeFZQVktoUi80OGZ3TmZMRXhRdlZ2OFlt?=
 =?utf-8?B?dDZVdk8zZThYNHhweEs0L3dDSytNUUlrUXVIWWlWSCt6UFdXM0UvbVBTdE1P?=
 =?utf-8?B?d1RvSHdqTFJPaElhL0ttMUwwQnJSYWxpczRqWHI4czI4U0Jwc0F2UXFIeDhj?=
 =?utf-8?B?REtSZS9pL0lTQjFQMXFOL2xoZ2Qvd3Y1M1V4SjR4cmRWazlRWUdCTHg5a0w1?=
 =?utf-8?B?YU9MUzQxeXlqOWIzank2OE9OMzJFOUUwWlNvSjc2cS9kNHFJTDFCUktSa1hn?=
 =?utf-8?B?Vk1xVjlyZGphYjRRUFNGY1QyRVNmTEJidHh2T2tpc2xGNGxnWDBMdG1JWTBO?=
 =?utf-8?B?endVSzRUSm1Pb1BNQjQrRHhiU2Vjd3VKM1d3d2FNdENTN0JPK1R1OUJXaTN6?=
 =?utf-8?B?cG4veFZuYllIbEZzcEhnT05BZTdIMzNFY01NdUJxWnRETDVPMDdBVllvdDdR?=
 =?utf-8?B?dmNVRW5oOXlnVU9BWHFMRDRYV3AvRnduSHJUb0N5WEM3cGd0UWNqai8reDUz?=
 =?utf-8?B?Si9rT1g2N05HNm5XK2dyU3o4Um11RkhKMVVhYzBPNlNUUkpUR3F2b0p6enNB?=
 =?utf-8?B?b1Zjb0JTMTY3Ym85U0tFK3k2YWJKL0s3Rzk2U0t5TjY3WmFsenp3cEJ5MmNq?=
 =?utf-8?B?aksrQkVkaWk2c2ZtWGQ4OHpsY1VtZHNGazhMUUVjVkVLdjZ5Zm03b3pIbjQy?=
 =?utf-8?B?bWtOVlBSejVDUFIrY2gzTFhNdlg1TFRpZlJBZ0NtZW9ZWHVMaUN4SktTYkFo?=
 =?utf-8?B?UUltNTk0OFhWeSs2RWQ3Q0JKbFhsZ20vMVlBOExaTkYzbDNpeUtaTk0zMUsz?=
 =?utf-8?B?Zmk4YWoxS0lBQWVIVlgvQTFBNWtjTFUvbVUwVEJGWW13VklTS20yTHZ6UFdO?=
 =?utf-8?B?MldaQmV5Mmszb0dMZktHdGc2RUhKcDBLTHZuOGVIUDk2ZElWWXNiUDJaSEhN?=
 =?utf-8?B?WWZxV1RMa1I3NlJEaDVMbm1TNGZHSnh1OXRwbW03Y0xBZ0FGcjNSV2VobVNZ?=
 =?utf-8?B?V0Q3bUE2Smo3dTFDb05zVnJxamp5SHQ0dXdleDkxTmQ3ZFhWR1BsU284RWpL?=
 =?utf-8?B?WFU3elByQVVzTStVVnJ2S0p5R0RmVE1ZTXZEMmEvR0ZOSnI5NjF5S0FqU3Vv?=
 =?utf-8?B?ZXFiQzVSSDlGU0lHcFhJRTlZcGp0VzdITm5NR0ZQOHZEWllCRFdhbzNhaTFO?=
 =?utf-8?B?UEx6OWxBcTVJTlIrVWZTU1FoNS91MXVXY3A5UGtvV1RmUFVqVkNlUUhNTVdE?=
 =?utf-8?B?UXlESHBVYnIzd0NzTUUwdWdra2oyVWFqVWd3YmhpTzVpSWR4YnlIa1V4ZmM3?=
 =?utf-8?Q?FidnuvFcrjNnuhreChjBHxaVY?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 903229ab-8ed1-4cf9-d30e-08db3e4eac8e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2023 07:46:22.7729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jzqCNycs8XmIs33lh4ds+GEv9vDh/P2yDLBCMrcqgdJtvbo06eFeOI+zvdIMhYFlUzcErJaPDJ6VxgoyRf1Ybw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7908

From: Jan Kiszka <jan.kiszka@siemens.com>

linux/bitops.h is now explicitly needed when including net/checksum.h.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/stack/ipv4/ip_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/stack/ipv4/ip_input.c b/kernel/drivers/net/stack/ipv4/ip_input.c
index 4495b8d2d1..6941e73ed3 100644
--- a/kernel/drivers/net/stack/ipv4/ip_input.c
+++ b/kernel/drivers/net/stack/ipv4/ip_input.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <linux/bitops.h>
 #include <net/checksum.h>
 #include <net/ip.h>
 
-- 
2.35.3
