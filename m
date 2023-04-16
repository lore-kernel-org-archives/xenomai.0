Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5810FB
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 07:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liEpbnhfhILz2aIPieI6/hHb6KHe4D1W1N7bBgXul/mrVViSz4lrjNAQDT0bnrUSheT3ELHK36lAqqlt+POcEIUZJUNukL3xorrCXZj6R/f7641r2jLpUypDY/ncYKG6YhqsWJW5lgf8vF7uHEGtqDmy2mC/q7CFDyNzESNugE0zKuFxiIibsOZoVPRgCSm9VTJv0vAA0a/vQyNz4fVE8fQTHIaDsLbov1gy717VVkrYVwz1NblTIY+K3bV/6aPExk+KmaM8QfFSyqkP1wW1uDM7bnEJmtsZfxKoIhH/1bzReVf+4cN/0q9MK/4cgT7gR/i5ALX3Y4YPm/7uUhB5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq/BVEdIGTpOCDYBXfOwiE8yRaDc5H4NE01lHxxhb6s=;
 b=izXyHs6IXMsQl+WUxVJL3pDGe6MDupqH1FXE5ruVI3rKOp4EP50HVSCp+g0TN1lceRKPOMV5AT/Gef5Q7jidXmPlsreqgPenus/BUgQw0RC09WTNQg3Z4OpcZ5W4Kp6jhJ66PO8gQpCb31HOsP6CunQgcwi2F6ExZT6bAzu3pY7cCZK9gd1j6FZG0FGgcngQQWzp+nKpTcbfTfZiDcf/oK0SlG1HhkpJZ3lOnM1h7JofAqwxFu+ITZ149Gv6KqZ4d/UopFzUTvk8pJYLq5I7lsWXYaGhMW+nqPowQYBCwNY1oyrP8VDgCwUG+zxv81caQaIHTl6AhUkfLqk/tK4jPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq/BVEdIGTpOCDYBXfOwiE8yRaDc5H4NE01lHxxhb6s=;
 b=wjazTOBgTrefC4BmWC+OAidg+GdazDQGVrQ+dVCJOP+A8LcXJYFSXrHM5DNfNTXrw0PKsZxailIKIrsS/Dh9zXPCW4zwDFBxrbXMkBcp6zZbVxcn/k0ZueUQjcqmQLqKI9GOpadJU0IBzr9b7G674sC6aQmPmUaPE3hPly4QOs2Wrlbh0rqArvQgIznxBA3+89lQHF8T4iWI+wpLw7BMYw4RukEUQ8xs4W2BQyXjQHuNKK9Y8IOBiihIyREoiRiHzDwPA3BFjijs+GlYZWT4kbkOv1V/08XyQL2KwWsy/IUslJ1rVvV/q1VO1OcSxUgEvhhG4oFxTZAUBEYuTjDQ6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.17; Sun, 16 Apr
 2023 07:33:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Sun, 16 Apr 2023
 07:33:25 +0000
Message-ID: <54578173-87b8-5230-a88f-66b8b7c3a0e8@siemens.com>
Date: Sun, 16 Apr 2023 09:33:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 11/11] vxworkstests: fix Makefile.am reference
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at, florian.bezdeka@siemens.com
References: <20220413215819.22954-1-richard@nod.at>
 <20230406103341.2914-1-aaron@sigma-star.at>
 <20230406103341.2914-12-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230406103341.2914-12-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 24591ebb-6644-4a4e-f6d1-08db3e4cdd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ilJ0/6NQxZxOf562p0uSf+xqpRZZYcUhFZ0BEEGHnbav+MBL4C7logUc28qLOEn4Gb4ZN3Nnu+KU5G3rhcDdUBLT1elBomxWx5OC4u5dRYpYWFq8SGxYcmu3HY86z91n6QJKRuuZwzWjcJhkUt/nMltbrQljJRoXG373P/DISIphqIVgESpBwR8c8ayZ4UHqd2oc3GrrgUpWXZDr8xeTXp3u66ssO7OZIrEQzmksvE1XoQNyHJcLeXWqg84umzQeAnsQO1CSWCL/8Hl3kf0gUcDwQXqfLn2N2kF+cEsOX6GQMXZ/dhChwv9+nTo/Q1eRherrhEcke8OtpBhHlbfWP4OSplAPgpxVanBhJmo0Mb08zEkxK1KkCAXUPvT5QKcFcFv1ayEHmH1+D+4Gr8oGvCq01WgKK9LhCU4qdCsQAtrqyRHdyuJEbQ0gwe7uBKdi0/lBh+Lbaya3HLO00oIYkNMsNvxWITvtRdEaVnWOhHBjj5M94oR3Q0O4kel0+/E5im4DQp70wN1omdDKX7TI5n9YGevd5shHLeuI7KoYElOT1NwOlFvrdWTpEASho5ilVyP2Q17Xm/JEi1K1YliD6bkUBDBwYM4fk/4Z7yEvlVfF6z6v5GPwi+xfF1qx7UvUeOe2dThTOKJXugauZ+1lQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(31686004)(4326008)(316002)(66946007)(66556008)(66476007)(36756003)(186003)(53546011)(6512007)(6506007)(26005)(107886003)(38100700002)(82960400001)(2616005)(83380400001)(5660300002)(41300700001)(8676002)(478600001)(6486002)(6666004)(8936002)(86362001)(31696002)(2906002)(4744005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTZ5by9kWXlOL3FMRnlrU01SeVZDREJkdjNHMTJyODVWYk5EVHFlQlVZTWha?=
 =?utf-8?B?VGRlT3lEV3N2Y0N1eVpZZXJrOWVqWXNsNENMRW1LdFc3RzFoVldEQkVyUmpH?=
 =?utf-8?B?dVBXVTh4QnBQTVpWR2RGdElvQ1ZnL2w2cDFGekt3VTFkOXMrMXd0TnBiV3B1?=
 =?utf-8?B?MjUvN1BSQ0xxWExvZGZ2UEdTVDYrS2h4OEg5aWRuU0dlUU9BVzZ2T2ZVUTk0?=
 =?utf-8?B?Tng2Q3A4dnQ5SDBnZERmRmN5a0MyeGRBTDBTWkFFeE9zb09sWHJxN3M3eC92?=
 =?utf-8?B?WnVKL2JXRHhlNnhGWFlvTWpmRUlvdHZYVDZsRHVxbXg2YUlqc1ZMczE4bWNs?=
 =?utf-8?B?Z1hzVm1yd2ZUUy9CQXpuS2FpQjN6bVVLeHFwQ3J5T2pMdVZ3QXdhWXV4Nzgy?=
 =?utf-8?B?K2gvd1N5bXRWaVNuK3dGaUcyUmVMc3VsdGNSVS9abVc2bnJsMzNYQTNNYjFa?=
 =?utf-8?B?RXVGcnVBbVNsZlN6WDMrdHl6U2w1V2J2ODJJVFg5U1NPYVNLeE5rcTB6WmJo?=
 =?utf-8?B?bnBLUjFVRU44TmdMN1pRVzl3Y0hPTEI2UzU4dzFuR3VjQ1MvTkk3ZFpoQlh2?=
 =?utf-8?B?dGtLWXNGMUJxVi9lVWpodXJxOXJDOEpMbkVvVVhsK0lVT2lYQ3UvUGozdlgw?=
 =?utf-8?B?TS9XTXZSMUhGRGhKSlhNenYwUzdtTDJWVFNvUHhzYlV4WHcxL1F3TERISyto?=
 =?utf-8?B?a0JzbjZCNHJCZVZ2UGpsR1RSV3VCbFJSWjJlQXNXQStBTHNyaTFlejVVeG84?=
 =?utf-8?B?aEg0VFhIVmRsWmxDN3cxTkwvL1VWZzRWM2k4WFVKZFR5Z05IWVg5eis1MlFt?=
 =?utf-8?B?QUZpRnQydlQrMlpFOFV4OVBkSjljUXNTenpoRVFUWkR2V2RiNEJ3NmtSbmoy?=
 =?utf-8?B?bU5nWnJheEIrRTMyZy9mS2gweWQvNVZHRjBCV2hOUHdEOFdOSkVpdGd0aTk4?=
 =?utf-8?B?b2E3b1NoREJjbitrUktKdE1GRmx6ZXFlQ3M2NXhHb1VLdTBNcEw4d0ZsVzJL?=
 =?utf-8?B?OWJzeEdYSUgyK2owbzJ1a3AzREd6aWwvQ1pBeEptTGlUUTRkU3BZUEFyKzlq?=
 =?utf-8?B?and6cG5VMkxiYi9SNXN4NDNEeUd1aHhPT1BiMVlXakdITG9Scm1JZWJjU0Vq?=
 =?utf-8?B?b05EWGUreE1TMy8yNG52cUZGaWZMNXdBdU05UDVjbkJENDNaMXNOSEk1M0tz?=
 =?utf-8?B?MGt5Ri90L1RlalhQTmd1MDZ5dU9vKzVITHl5SUQ0U1hZUGhNNW53V2Q1RTVV?=
 =?utf-8?B?c25OT3QrNHZScmVxNFg3Z2VLSzJDdjM3L0J1VkEzRUdzZjUwL3duZTVwODFJ?=
 =?utf-8?B?MnpmcncxU0VwMDJsdDQvdFBrQ0U3YUsvRy9FNVUvd25yV2daMlFCUWtnV01V?=
 =?utf-8?B?WjNrdU14d0Zsb0N2RGxOL2p3OXJ3WUp3ZldwNW1PaEtvaEZVMWpsRDNJd2x3?=
 =?utf-8?B?cFBqdWZHdHVJVTJUbjVCOENMczA2aFl0VThYK3hDYzI0UDgwRnduS016RTJR?=
 =?utf-8?B?elZ1cWJ1WkVLMFloN3ZJck5kZHRhTDdES0hQdnBuWkM0RDFGRDV0S1JUNmdV?=
 =?utf-8?B?dlpBaXN3T1NDV1YremZ2OVFFbmJpKzVmVUUrWWo5V084dklVdnVSWlFLYzEw?=
 =?utf-8?B?S0JQN2dIcVBCNERkWDI5UThsSXRheHF3MGxYald3VkZHS241T0dKUms4NWxo?=
 =?utf-8?B?T3gxVG5YQ2NBVWVZMGZXSEg0RjBZZGV3bG40NXNUWmI4T245c1lycmx2Uzlw?=
 =?utf-8?B?SlQ4bE5ZV04vWFNNYlJyUkVPWE9DVDBremErNERVSEZjVkFWVk0wZFRYSzg4?=
 =?utf-8?B?eHVQSWYvT2MrcmI1aStYZll5NkZjcEd0MUE4L2dpNDdFMkxPQVVjYnJtTVJX?=
 =?utf-8?B?YTdVWmFCcXJISnNYZDBianZiMDVTMzBaRENXdEwyY2xEa3JMNE5heVUxZEcr?=
 =?utf-8?B?ZmtqT2dFT3lYL1IremZlaXZVaTh2VFNFWHU0SmZNYU11NjNpa2JsbWp5TEhB?=
 =?utf-8?B?aElSNGRxTnJlSXN2cnBuNWxEVnJRRGhmenZvR2QvQVJMQ1Zuak4wQ0R6QWhO?=
 =?utf-8?B?MFZPWlJ6OWVqandWMm53eTdzbXBpakllK25keFQxUEcvb3RGNThlZ3RBam5J?=
 =?utf-8?Q?q0KjFGP5Dgi21gmW5mJuBcDkR?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24591ebb-6644-4a4e-f6d1-08db3e4cdd78
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2023 07:33:25.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QC7+OYioK6oFsPQnXq5QBUvXaa9TkoRMfndnK8H6sx+kZqblAbkb9a8C4cy+ExQ6yuYP4glZaWRc6nEIl4DE0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5313

On 06.04.23 12:33, Aaron Marcher wrote:
> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> ---
>  testsuite/vxworkstests/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testsuite/vxworkstests/Makefile.am b/testsuite/vxworkstests/Makefile.am
> index 39cdd043b3..2c7c77e6ea 100644
> --- a/testsuite/vxworkstests/Makefile.am
> +++ b/testsuite/vxworkstests/Makefile.am
> @@ -28,7 +28,7 @@ vxworksldadd = 					\
>  	-lpthread -lrt -lm
>  
>  lst1_SOURCES = lst-1.c
> -lst_CPPFLAGS = $(vxworkscppflags)
> +lst1_CPPFLAGS = $(vxworkscppflags)
>  lst1_LDADD = $(vxworksldadd) -lpthread -lrt -lm
>  lst1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
>  

This should be folded into into patch 9.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

