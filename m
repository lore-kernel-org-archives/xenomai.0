Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D12F2A
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 17:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTcFMoPoKBoPMx80LCUAUJ23MGjRBtcPaunRenWffaag/4lbAIG1OwOgytYq6rdIyPw26lmsMN/Vs6IZqeYqGgaPzcmmZW0b6QIgweeweWa8BREB+Z6JrsTZPfKoOVq/weH7AVWQDMPxgckRGs8FXdOLO4V9uavjH4InlXRGBz9rGqO7mtUKh18cVUNGHnKYrTJDjo8jCmVwiITgTM5fsfUwGEv6VNXDzq5zCnqcMsGnPFlQsDXbJiZrDtCfflZX8cEAJGmUay4PgSMEqdhadDZ6FGNboh67C9qWkojHkPhD9IxMoUBwXDDtTcXXFJ0kWWkr+ZzWOgO3gyriMYlq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg49SnQH6OrKWYmKGb6GLpuZWsi3nYI4b6bcfq9MSoo=;
 b=nziQ8IkmNtmAxPqnhyYTeKJoCytKdN00zh1PEsAsGLe7iEULl2BY+sO2SJ0aB94CoALJnRv6HYQPIStKCWRxeBcsmi20Oxqo+4Ysagz2vmgjUUD47eVlM8M8zeZjPdXIBhMk529HNkOYzY/SZZ/CI4YVtxRL3sBmnCvZJVwxdMSPAM6jSHdvL1Gn5e7HcXGGxDWBLoJbOoNr4zJgpOFqoCbPKyiJLfxcDhPIu6x4nvGmFBgh9mfU24xMg2rOb0w6TMuwiG0eb+GCgEXJw4oD1UM5aTmLoPNflKUtUjmLQ4D5/Lm/2ruW2HKpbrgG5R4Sr6SkvFWHOgrSpWo3rdAvBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rg49SnQH6OrKWYmKGb6GLpuZWsi3nYI4b6bcfq9MSoo=;
 b=rWhIM1t6qU54E0vf0mCDfQEEXTpVU1+JM2g/R/7on2MJqQ6BSNtcNUMv/rqiZHWv8Gvh39o3scoCTZkjIJzzCD19/2buSTV98HcENe9M0EFAXWdVS4HnUbBGugIEr/WA3ScHCihjvhYXkbZX0jUAdPiYtJ6W6ibmyopIC8OtVikuMpKFDkqBSQhmUQkfSsfsyWtQrdqy9dvQbF79pDy0Q8eXifXI+ERF0mT6yXOzhAKS6t/r4OPEnP6f9M8wBva8lboP0cjb9fvd33cYSGmYstD9ZzNAr/viY/ebaACMkeA2ldGbCfXZy9Q3ygv9oEr6vVrECFEPAIm8R60UVb3WpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 17:41:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 17:41:32 +0000
Message-ID: <e9607eaa-6ad0-be28-d06f-b3021c1cf6b3@siemens.com>
Date: Thu, 23 Feb 2023 18:41:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] copperplate: sysregd: fix Makefile.am
Content-Language: en-US
To: Mauro Salvini <mau.salvi@yahoo.com>, xenomai@lists.linux.dev
References: <20230222140543.19880-1-mau.salvi.ref@yahoo.com>
 <20230222140543.19880-1-mau.salvi@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230222140543.19880-1-mau.salvi@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f51683-bd59-40f3-d9fc-08db15c533b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1qizR/BgvSzjQFmclQ9kLQ0Z0uuOJHmm+9y0ksD7JomRIIoc7bUU00/wrl8r7mP4vchlBK+exB1q22EHRz/iyo7lAwz728kYbGGmsugHl0SJrMQ0QWeR6mKbc54GrLOqHWu2wficfCgA0i3dEdwRgWtQBMqt8uTiYseao1MWUhmwmNMSdRznGB+vzRqfxNFlboWmSPcpjNw66hWSVwnm5o/Q37OFl5RfPBB0WpF1cwskpQVSiOqnBAVuY72anCTXkSgvueicMT68TGmdqmkIeY15pAPt889I/m06DxeyC/iJqYJZY4Z3OflRF48yHO7iDT2F1sqq6xTmbmgJUMHAuCRDvOm6oTNEo8dlqokTua8R2hdqEhWzS94MdloztOKYQlfZKHWjylBn41nU1KNkS8djy+jcTRqJaX17PM5ut/QYNPUE7IlcVoMPK+w33p6ArYnllO3bMCK4vG/DZg5H3TofKrgvCZ456jAQMYFAThtjfPlZO466U0XNIVxrrSX+MCL3xH51+FcJY1qTXcAejjuOdXmtqeTU+II0UoMkv0SReEIcR3H83vlEQjyiyRtbL5AqG7VvPIW34jVpwnHNWM0gCUwbe2MG3Lqpk8K1akB3HvVwc/ja+Lc1p92BfV6F+KPfCagXUiO0WHlPjGZYiZZiZFNMjBwUyJhaJ1AouoBrZ2YHyMcQ2+aR322+Bfmn2G+lioibeNUYnwNOT2fdXWTf6DWraI94fXwwjtDakSU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199018)(83380400001)(38100700002)(5660300002)(82960400001)(2906002)(86362001)(36756003)(31696002)(41300700001)(44832011)(186003)(26005)(53546011)(6512007)(6666004)(316002)(2616005)(6506007)(966005)(66556008)(8676002)(66476007)(66946007)(478600001)(8936002)(6486002)(66899018)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWh0UFAwd0JMUWR6MmM1MzJuVmJQMWphTUdDM3R5Z2J4MFdTMXo2VGQzSjF5?=
 =?utf-8?B?S1hlQW1VT1RTQTcwRHJjN1FxSWRBR3k5SFpMTXRnb1FQS0QwbHNFNEd0b3Bk?=
 =?utf-8?B?b3VFaTd1ZVRmTS9EMzQ3S2RBaUVuUm9mTENXYjVCNktDRVZTRklUYTd4aDBJ?=
 =?utf-8?B?NUlOODJtVFFGd1ovWE03Qm4yS2hiTDhCT2VzdWNaMTNWZkxPV2NuUVhKY1hI?=
 =?utf-8?B?UWJqYTJnUWhoNFRBaXg1cjNHcURtR0JMZ3FLc00xT0NKUFhKVDFzblVGZ2o2?=
 =?utf-8?B?cnNIQWpBdmZJTWlLdFNoRzNBYVl3Skgzb2RyODJpd2k2MFFKRi9mWnBsUGhw?=
 =?utf-8?B?TVV4amJIcFlBRXhZVkJmVHB4dUxNbzJUQkdYR0ZRNmIvUEVnYjNjakQwa2FQ?=
 =?utf-8?B?WEhka1dQS1hWNlVZZHltRWlYWFNjdm93enhsUmtvNXVud2pPWFplYm5hcEQ2?=
 =?utf-8?B?aTdyc0xUYXVBeGJ4YXFYMGVBbTdHcHBkcElBWThqYU9PZ251a0hFaTZER01Q?=
 =?utf-8?B?WHZwSDFkSmdETDZvZ1ZrOG4rb0VTaWdoZmlhVEtnRStwd040SEg1WVpSYWdQ?=
 =?utf-8?B?ZUlTd2ZxeUdacEdDQ2FNYUhnZHAzUEtjZHk2QTBhMUIyS3YwT1B5NmxRb2ll?=
 =?utf-8?B?c0FnWmFXOTFOa3FCT3ZBOTZvYjBXY05DUmh3c2hFeHRRNW1nYUdsZEk1REFY?=
 =?utf-8?B?b2RKdytxeTllYXdWMU5qYm90d1J1SnplUWI0SmtiMGRpc0NTT3VpY0trT3VJ?=
 =?utf-8?B?TCtHeW5kRnFpaEpoSGdaMXJEeDQ5MlNyUUFaT0l6blg4UkRBVCtuSkM4Z2Fw?=
 =?utf-8?B?dE5jMHlUS1pISkljanhOT2tWeG16Ky9QeStYcU81QTJITjZBenE3YUhYSmxE?=
 =?utf-8?B?VGdpenZZZzQ1Y0lZNTE0cmtRZGVyWXBVK2dsQnNiYmdFUXFTdjNWMEhxM1hO?=
 =?utf-8?B?YzVmUUlsNFpCQy9xWmNjWDJDcFE0TTAwMXFRSVN4cE1WZ0hjNThWeUhSeDRD?=
 =?utf-8?B?T1hhY05iUXVaVXF4ZUlFU3lKVlhPSGlnRENqaWsxOHNHaWhlcDR0aStuRm1F?=
 =?utf-8?B?Wmo1MFQxRHJma096R0ppWGU4V1RsYm5jTkhKbGR1eXdualVJMWZRbG9FZGFa?=
 =?utf-8?B?MDhWZ1RQWkRjb3pvRlJ1UUM1WHVzbUIvZlo4Nno3RVlmd0ZuZTFIWWRCY01j?=
 =?utf-8?B?UGpuelQzN213bHlJekZXc1lvT0l3S2Q5N052cVIyQjBKWW5vSllSc0hMUEVa?=
 =?utf-8?B?TG9XTTRaVWtqUlVqUnpoV2Qxb1YzbkMrdnlrR2p4c1pqOS9FSldvdFVIeE42?=
 =?utf-8?B?aGNFRE9EOTVwQkdMQ1RrNXhwNU9WZFNkU0ZtY1F2QVd1Wk9aYVBpZm5QeUQ2?=
 =?utf-8?B?bjFNK1FLbzc0NjNjZUlOMmdJTmVhR3BhSk9nNGZWSjdJck9iaXhhbHpZRFZW?=
 =?utf-8?B?dUlvMnd1elZkRzd0WjU0YnJIZEhUVDVCczZyR3ZRSTFSd09mV3AwREdXTGF5?=
 =?utf-8?B?dWVUN2poK2xuN1JpcnF1SWk0RVdZTEpDdTQ0ZVpINldNMnhQNUNpc1RqQnZV?=
 =?utf-8?B?M0VaN004aGFZS2xoZnhrN3hWK01IL1BhZEJQekRIZmJSdTZkd0lJblRaUFVE?=
 =?utf-8?B?UFpsUjByTXNDTkltZDIzK3JuNEFtKzRHWTdXSkZYNDRmV2t0YlFDKzU3Ritu?=
 =?utf-8?B?R1QvWHFZaGNrQ0xwRHhBMWFKTXBnYndkeEtHNVMvZnR2OG51VW1tamllYUY3?=
 =?utf-8?B?UlFwZmxpdCtHSnlRcFd1UUZRVVVTeU5mUUsvL0VNQVhQbitUVmVmUXM3WWlv?=
 =?utf-8?B?a05hOXZXckFLbGtHOEU4eFRpZXpHSlN6U202dWdnMHVkTkZhMi9MWjEyOVY1?=
 =?utf-8?B?QzJuM0FaUkFjQmZXOE1LVkFSVXVVampHd2RHME5oak43RDhMZ3ozQnRrbC84?=
 =?utf-8?B?R09CZ0c3c3JSYzRselM1TVNqeExBOUNubjVmcmdxblpWeHdFRitGRGRyV3dF?=
 =?utf-8?B?TmdVOUZuelNjQTJEczREL0p4cW5abmx1L2owUGJ0dWJmcUllL3hwK3ExOGkr?=
 =?utf-8?B?bUZJVnZyaUZaVGZFREo5dVVSV2dmWGJ0SmlHTXI3VlgzaktKT204dXl3bnRq?=
 =?utf-8?B?L0pGclVnamxNZC9XeHd5dnIwRWh2OWRiSmRtWDV0eDRjaEpCSWE5cXgyT0J4?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f51683-bd59-40f3-d9fc-08db15c533b3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 17:41:32.5878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1Oep4ECxDBwaFO+htP+z7LNpqvFEjMnX/BIHHUwvWw1KZdm9tgFQa5Q8wctFfeQopxHFeDFwnGwzp4udKyLcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7404

On 22.02.23 15:05, Mauro Salvini wrote:
> Settings in this Makefile.am are done without the sysregd_
> prepend, differently from other tools (e.g. utils/corectl)
> 

Ok, in here seems to be the underlying reason:

https://www.gnu.org/software/automake/manual/html_node/Flag-Variables-Ordering.html

Summery:
"Thus, you should never redefine a user variable such as CPPFLAGS in Makefile.am."

Now, just for CPPFLAGS in utils:

utils/analogy/Makefile.am:CPPFLAGS = 						\
utils/autotune/Makefile.am:autotune_CPPFLAGS = 		\
utils/can/Makefile.am:AM_CPPFLAGS = 						\
utils/chkkconf/Makefile.am:chkkconf_CPPFLAGS = 		\
utils/corectl/Makefile.am:corectl_CPPFLAGS = 		\
utils/hdb/Makefile.am:hdb_CPPFLAGS = 			\
utils/net/Makefile.am:CPPFLAGS = -I$(top_srcdir)/kernel/drivers/net/stack/include
utils/ps/Makefile.am:CPPFLAGS = 						\
utils/slackspot/Makefile.am:CPPFLAGS = 				\

So there is more work to be done. Patches welcome!

Jan

> This also avoids following Yocto error:
> 
>   do_package_qa: QA Issue: File /usr/sbin/sysregd in package xenomai
>   doesn't have GNU_HASH (didn't pass LDFLAGS?) [ldflags]
> 
> Signed-off-by: Mauro Salvini <mau.salvi@yahoo.com>
> ---
>  lib/copperplate/regd/Makefile.am | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/copperplate/regd/Makefile.am b/lib/copperplate/regd/Makefile.am
> index 3b14e9863..590a47c2f 100644
> --- a/lib/copperplate/regd/Makefile.am
> +++ b/lib/copperplate/regd/Makefile.am
> @@ -1,14 +1,14 @@
>  sbin_PROGRAMS = sysregd
>  
> -CPPFLAGS = 			\
> +sysregd_CPPFLAGS = 			\
>  	@XENO_USER_CFLAGS@	\
>  	@XENO_FUSE_CFLAGS@	\
>  	-I$(top_srcdir)/lib	\
>  	-I$(top_srcdir)/include
>  
> -LDFLAGS = $(XENO_POSIX_WRAPPERS)
> +sysregd_LDFLAGS = $(XENO_POSIX_WRAPPERS)
>  
> -LDADD = 			\
> +sysregd_LDADD = 			\
>  	../libcopperplate@CORE@.la	\
>  	@XENO_CORE_LDADD@	\
>  	@XENO_USER_LDADD@	\

-- 
Siemens AG, Technology
Competence Center Embedded Linux

