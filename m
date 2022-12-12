Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6BB28ED
	for <xenomai@lists.linux.dev>; Mon, 12 Dec 2022 13:54:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8z9Fr0kyrDcVIBu96SXOMktMq0RH811F0WICo+Xgv5vKhfuCXRuUUGaJEVt4qIA0YF/sng+cDub8zDYqCsMmImj5AebPyscoznHjllucypQJN0kt2jn5fpV9TKkDPo4S9NHHZTzJPG5Uz4yBq+X7IpXzluPcRwPn1tqKcIqDspOLQa3xleFsjwRPQZNtTC/HDuhiU25TtKWdD2FI7QR7t522SXYIftVrcRXx/7SoRY3+D+35YLM4uIcPp16V2CUiYGHxR4h5Ta7HDLRghLvo7XKFz0rOexL82ndOGqsSTqQ31/n9/SBVy8vMk7jS4nwtKfLkk8AomKHwa9LL9FzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czgf4+ReI9tqehbBNfHKRTyiEp3h3Xhv5iQBwOfgM1I=;
 b=h4i0ftBCP5diBt3FQlvGjHu1CKj5U1JZJY4mif6Drqj7BUO2JMVqljt3nKUJ3XZeM0IAWkxR6wJp7waILJgwPcebFvsgTHvC3JbxvPPXeWzIFbRMG7ZOPOOWfiQ01kd3Fn7ONo0nyr0+Z9+mxXiwgVZ30aCE1YaydDr1P8MIdHnk14YydP5vRm77erg6ABZ07CcVEi33S7ah1l5nacxFp3hO9EEIcSOdKalrNPy5y61V9pFmoeKROeaKtNdShw2nswFvsJM1AJp4UgFhbKIoSNxKoGoTkPU2TDNUzp/jNYlgGjHR1hEIlCJHlWv0bpNqQhucRt+/4+vXT+a23NWj+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czgf4+ReI9tqehbBNfHKRTyiEp3h3Xhv5iQBwOfgM1I=;
 b=spyvwrRdH17OJHjUHynPq61R3C73I7ZUlC2md62cT5T/9J4LluOqjnpbuqC2IxcMcc2fZXSadQdewcyCPPHpVS9rhAdKGBqjz+R7JZZI15fIUJ03QUONKK/9O/ZSm+bCLm6m2P2JGkux9oRn18cyrCkpFvIqeOtnw3n0ckysm2Kb3upt3a9vzG+KcsoaAiS6A7fY/1B36/GASn0fyh7LPxo/tEWvCZjsdfZFZphgdwIPviYqQrYoDIXK9hBT/Jut5Jl5h0aKJErkihiVWQzDK0MD6Uq2EjExl1H2nGqpfAxn9qopOf1FZnM0cFhxd4hT54K01mK8Z3qHg70b4GHvdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:633::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 13:53:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 13:53:57 +0000
Message-ID: <47ac0775-6fe9-690f-4b61-30a7971033d1@siemens.com>
Date: Mon, 12 Dec 2022 14:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: Adjust 'latest' filter for 6.1
Content-Language: en-US
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ac022d-823c-40ef-ee3a-08dadc485079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xBgO8Z0J4HKVq2XQqdH7kMmy/OJO9hBoveaTa5VIYg2AWB6/nZuqvLQyJ4KwADyzxCMH371QmW5EgXPupWtfji4uqX5I1nblBIrQZ+njGUfm639QX+83UKK7IZJfjPsp0oq53ku6xhtUg4KvnPI2mFxLqkf4u6XqI/G6dUkWxkiYGhiFMPdvIXwGW63cqP6j013YVYEM+3gc/UCqisL1Xwz8hZ05NvPpsdBJDXGpNG6L/C/SjIf1bIrs9I5a9xQi8OzmojI8nPSlmHcCkbB81MwtAq/xCRaFUtWe3Ip0yaoySsvyrM+LaUZ1vX38xEnhZoynhkWkIzaTeruMfQ4gdP4tjDgXCp7M4+mI7yiaAU/1UZQjK+0mUMuWnZ4dlABmsUiHcLiU7hA2/f4JK1cKJ3mnBbHPUNmAENwOwJDW7bFAFPxL4QtSzNsGe1J6yEjkqgm6AaI63kZPdaegJiDzWS/LEiN7tuzPoO+sgjyJ0hYMRJ99pMz9K0XDso8fJFQefSSmf+7hTe4kmAdb57XOH7c3YhaahBIgQbmnkmflteehuti33OzF//pniaYRugZcCNH6fscIF/bXuhqUzqagzG5Iu5HfWUQ4aX1LFTKMnoxJKV0c+ac8RIuoUopNg9QZNSQvWWTmxXtuTAqosL8AocoaoVnnAAB+TzrSvXXXmoDsEFrMdc6TwLZlNK/SdTUR1YGYWDYt5yNVO/cydDAxXpz0cunAoq8SSiQ9Jfm9v3GQdxJzctsqzj4sx4vxbxHH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199015)(31686004)(44832011)(2906002)(8936002)(6916009)(316002)(5660300002)(66946007)(66476007)(66556008)(8676002)(36756003)(41300700001)(6506007)(966005)(186003)(6486002)(478600001)(6512007)(2616005)(31696002)(86362001)(26005)(38100700002)(83380400001)(6666004)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGJqb1loS0FlM2dXNUljYjJjNkZHOGRNdFRUaXpUMVp0aFJGUG1wNllVUmk5?=
 =?utf-8?B?RkN1TVR6WjlBYUw3cXd1U0xpTm9LQTBqNmhRcG56ZFkrMTB1U3JJdjZjR0JF?=
 =?utf-8?B?V2JBV2oxeFZnaXYyWXhZZGYxQnZEQk5pTlJOZ3hxVVNQcHVmVzEvTERaZWVW?=
 =?utf-8?B?VWVFWnB6eElFTWU5SC9xUzVNYkdhQ2hRNlRiM25rOVFzVHF6UlZSUzFIbXlX?=
 =?utf-8?B?SGhUajA4T3B4UlcyZTB0MzJuR2RrMVJmSjR2dVdoZTJCUkhpbGF3b3hLd0tQ?=
 =?utf-8?B?YW5QaTZaaklOeXVhVGNsb1J3R2IvdGgyL3lxWnJBRFlGN0VKSUl6MXkrOWh3?=
 =?utf-8?B?UklNWkRReHlHQVFKOXFDZy9NelBvajZMRmZRREVidlJXbTFYL01ZWCt5WUNq?=
 =?utf-8?B?SEYyQmluWStrWlNDekZSV2psYmt4Uk5vTzErWDNQSXFDSmN0V09GVStsaGx5?=
 =?utf-8?B?L0Vsc2x3dW93NjdSWm1RMVAwN241eG9SZDlUSG1YSEg2b2NQV1ZXWEFBNWRm?=
 =?utf-8?B?dTZCL1RnZmpNYTBENjZTbzNQTXVXa2VJVW9md2F1VVlwZjl4NGRmU1RVWkZw?=
 =?utf-8?B?RVYrclA2aFdQYVdaOWxtcDl6a1N1bVczbHo4U01tbXRWQUhUSDZtOEtncita?=
 =?utf-8?B?Y1pYc3o3VmovNVNIbzRmS0xBbWxKSlEyaXNVUHZ4QlJ5bGJkdG93dlNRSm0r?=
 =?utf-8?B?WnhxdDlCRXY1QUJQeGZmUzl1NkplZFBKZk9lSkV6RVljYkRPdW9oc0FlVmhF?=
 =?utf-8?B?QlFranJvZ0pUQkhWZW1TQTFnTHBGTUFYUG1wNnN1dVp5L0owR3VzODZXc3FQ?=
 =?utf-8?B?SGNlVzF1RFFMSzZtUUdwNXdOMmlYbWVRR0o4NjhiSTZwd2w4Nm9iY3RyTlpG?=
 =?utf-8?B?TzcrbllZeUdUTzdkZWZUYXhKOUtqdlgzeENDVHhwNjcvRmhQcjY3QXk3Ym5n?=
 =?utf-8?B?Z1lxQ1JyNTB1RW9NTWFOTWFFS1NuWXZzZzRVL1IvdUlXK3BValFEMWg1VnEz?=
 =?utf-8?B?MUdaVWxaSWxwNnU4MVNyRGU4b1F0ZGsvUHJIR3NYcFhEbHJwcmdRSVEydnVH?=
 =?utf-8?B?TjY0bk5PU1UrbS9raitMSC93ZXJTb2QxdERydVhLcWdDdmhzbWZ1SEltSklj?=
 =?utf-8?B?c2N4MStoekIzTEtnaDVwbTJIUnRJQ1plTVhyMEJXY3p5dkc1bWwzTnpzWjdL?=
 =?utf-8?B?UmFPbStCdHQzRVp4dEpEN2tqQzZsNjdOWVlmNWVaeC9kTDliTVhBc3ZtSzhF?=
 =?utf-8?B?RVlCQTlmZXJZM1lwSnkvdlVtWjcwdTJzdXYrMmFGaUVPUHI4NG1yR0Z0RE5M?=
 =?utf-8?B?c3haZ21QQ3JoYXJnYUJtbUpHOURTUUZCYnoyNmdvRHMvSU5uWXFqZ1dpVkZ3?=
 =?utf-8?B?S0w5a1VQUDlsUnNaSVdTM1RnSXRkR2tHSjBlTEhPbFdIUjVrNE5IZzJpRUZS?=
 =?utf-8?B?MFNPbTU3OFVwZXV2bXFMTW44ZDhTdzFUZGFRZFc5dEQzdXZObDFkWmQxelZl?=
 =?utf-8?B?MFFjZU13ZnF6VU01QmEwdGcwSkk1czhVVFp6Q2FvRDlQaDZkVWJRak9jTi9x?=
 =?utf-8?B?VWtOSlJORmlTTnlPMS95OThCY3R2ei9hdWpxQ3JIaTFwVTF0ZjNoWUJ5U0F1?=
 =?utf-8?B?SVp2Vkc1YlZ6M2wvdXF5N3p4N3NzUFNqR1NBVU8vak5vNHRVOXNBcVMveU1j?=
 =?utf-8?B?bHp0R1dTZkJYL3hEc3R2ZXpMc2I5UitJcDlGWFdsQmVsR2hsTEdURWQzZmx6?=
 =?utf-8?B?a3YrbEtzalV1c3JLRkExOU5rMzRWNGdvZVRBbXB5QzdEK1BlNUJmZVpFMkhn?=
 =?utf-8?B?NmxGYUgwQ2k4eTJpaXlqc25ETlY3aFpBdE1EQXBVTklZUm9MODdQbTJvVHB1?=
 =?utf-8?B?bGtpR3hHRkc1NlRpS3dDLzRQNFlFbHVkallIRTZBanpYa1VGbmhzZVRWSEdn?=
 =?utf-8?B?MG5ZYjhHcUZVOVpQZHBkREtqT2MzYTFhdjlacm5UYW42aUpFWDl5OUFCbEZk?=
 =?utf-8?B?enNTcGNwTEdsaU5RVmJlZnJYc1JyZHY5dXlYZmVvaXJCb0RJMWl1YjFSTG9X?=
 =?utf-8?B?cVNnRDFzN2JiQWNYRWFtMkNYU1FvR1lHSTRWLzRGeHlpcm1GRkhoZCtPRktE?=
 =?utf-8?B?SnFDTmNUNkxXTmh3RFRHVk5xM1M0NVh0ZVJxb2sxRTNiNzFxdktSSEk5blo0?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ac022d-823c-40ef-ee3a-08dadc485079
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 13:53:57.3051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHgku9m71lD2RvrC69/rbH68YG0DpQYOYee4gNtUDt5s3VMAJ8GxGLUumiL2zaxEjO2+d6a6tlVUgf1ppY56ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7682

From: Jan Kiszka <jan.kiszka@siemens.com>

Analogously to the changes in Xenomai, we need the transition to 6.x and
a fix for the sorting rule.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai_latest.bb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai_latest.bb b/recipes-kernel/linux/linux-xenomai_latest.bb
index 9c6fdaa..9a8c6fd 100644
--- a/recipes-kernel/linux/linux-xenomai_latest.bb
+++ b/recipes-kernel/linux/linux-xenomai_latest.bb
@@ -27,8 +27,8 @@ python () {
     if is_kernel(d, 'latest'):
         cmd = 'git ls-remote --tags --head --refs https://source.denx.de/xenomai/linux-dovetail.git | ' \
               'sed -e "s/.*[[:space:]]refs\/\(tags\|heads\)\///" | ' \
-              'grep "v5\.[0-9][0-9].*-dovetail-rebase" | ' \
-              'sort -r -n -t - -k 5 -k 6 | head -1'
+              'grep "v6\.[0-9].*-dovetail-rebase" | ' \
+              'sort -r -n -k 1.4 | head -1'
         (ret, out) = subprocess.getstatusoutput(cmd)
         d.setVar('LATEST_KERNEL_BRANCH', out)
 }
-- 
2.35.3
