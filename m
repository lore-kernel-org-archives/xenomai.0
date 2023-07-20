Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418C2FA2F
	for <xenomai@lists.linux.dev>; Thu, 20 Jul 2023 16:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki4CenXsgjzz+u2iPLubWYh0XQN9wD6INJkRGYIqZM/wtxMbXkqIx/tgw7AR2IiSJbkCYxbkieaGwIxlMHVmuCIF+3ujF+2vOLgV/ZCTWmXSn+tfvCUofR4OWOna+wn2t+8y3ML+TQyrud59RgwJQgB0t9dqOu0xXIVkKo9/ICrWedGLBoEChX1LGtg+jHfxq979QXJ4Fweou83hHv0kdaXGrcafb4rrNtkwmWYQclDKNxcWhOVRvjnnKSfMGX43Gt9P9G+nmNjB/vQN9580e9lRJju+p4drS2OkwYqWs/fXikId4HXjzs5ZfiSNsUZmFI+Ob+V+aFpwFIaGdZ3AVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCse2vxruDqT6WFHunMElxY0S2yB0p7nEp/zzvUXiiA=;
 b=Mmufj6c8sDuYxWFiP5rrPK9/3FMcYtQv7ki/CnM9eifE1jl/g+zYCjwdNueua0OMJVkpSU1ef2Tillp44c3jWa0JV73RyCd3OGAtN8Er/ag+V/x/dVMLXQXrzh91yQiEHMZ3oEN1ArZDh37c7qIeMOKWhXOP5NGKCSCd/giT8rSkBw7TnnP/QfdAs0kau9Fpy1ZKLZJGk/gM8g+UqlCNke6sC4xEPVThWC0FH3cotHggyZLDgxrBNAFHQAxtL1dUP1oRDCjdYO9UEuW84ssbHtwYRQ8knilKAY8kLslop1ubrYGHsc8hXGQ34wWtGwkGwI98jcjL5y09n8fd3Xat5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCse2vxruDqT6WFHunMElxY0S2yB0p7nEp/zzvUXiiA=;
 b=R+C3XSTgS/C4pkLHBAB+MKziPTZ7HY4KaQaw462+pKp36b5qRlr00LB0QQgJpABC6dGthPPu6rVEczZ+0JiXc7lEgyM5DUTxOq4sv+HFOPq5Lp9ua1yJ507fDUx213MA4Gc5WhPa0jHU3S7452XmIpnT7eikUuli4Xw7/S8k6VsxnKdtkGZYtUcVxzZKBY0BMCCmXe9z0bpmgyfKKBDOr0jd4LyjfK2uKmDhVBwkwYDNNsOqrJC5bwHzS/PpIgz47wBryQDg4QXEaESyOWEeN1R0C44v+rp8higKD64NtPOSyKMMdcDcfRQF0QRlBh+oTMu2wkDTI+/qgWuzaDY5yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7153.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 16:50:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::77d2:3a68:9741:67cf%4]) with mapi id 15.20.6588.031; Thu, 20 Jul 2023
 16:50:53 +0000
Message-ID: <1a1ef314-13fd-10d5-3a9d-6e6e47fa6d1f@siemens.com>
Date: Thu, 20 Jul 2023 18:50:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/10] testsuite: Fully integrate alchemytests into smokey
Content-Language: en-US
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at
References: <20230406103341.2914-1-aaron@sigma-star.at>
 <20230720145150.24607-1-aaron@sigma-star.at>
 <20230720145150.24607-2-aaron@sigma-star.at>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230720145150.24607-2-aaron@sigma-star.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 880ca359-d709-434b-8141-08db89417b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O6ILrBN5akxxGK/opwHEvMsIvOcYx3hpm+ATIiMjk6M4vVUWrKBabx/X1ukkL9O/L+iWQ/dAReINsxgTc2ZELyBEWgnM2mLcLaG3BUOsY0I6q/28RCyTqSpka3pQIkjpuHVTAx+qwr0aEwijXfYc2xVRxgo39rY4kG7G3LqYx7GmWXmjCHMlFkIEAIGJTeButgZvAfEL9YNFg6LbYnoazavgx9qQ1RaoRdpIXuBBfdwbw12nc7O7qTDN7s04Wnu3ld8PP97tmLHR/IE+0sD5k1bOH5+8pcxm/xEHhe8/mt6/K9O8NnzglwsLMbbVPeu/Z1BnIU4h7Yj8OR8mTf/UUW50OwgSOYTQWYKDLL2AZaYkqhqflwa+K6OM4hgX0vQcOylU1oLCCh9DhdJUCugExTJs/JdvIWXhOBGv/tLDHaBQa7RQMV4PSNa8v/maSnqa0+QH2/2A/rbEvgX7GXPYiGdE2fqMjVDnfwjYbAJCMM97gGs4RisUk0kQ85kwgNFWX6m/BDp/XlNIol9g2JcvEMqurFbqhMdlK7Ml4FCXBgTW9HbECe019XDug23Ge/gctVRv31IvH7uDZLnhZLaajl8FHmcNp3j2Lw/yfGQ81NiRZCaFw4Q+Lf1zDKdlhIabePqGqd9+F6aII4knypQi7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(86362001)(478600001)(83380400001)(186003)(38100700002)(41300700001)(26005)(31696002)(30864003)(31686004)(8676002)(53546011)(8936002)(316002)(2906002)(4326008)(66556008)(6512007)(44832011)(66946007)(66476007)(6486002)(6506007)(82960400001)(2616005)(36756003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SS8wdGVWWjJuL2RMTTM1SFJTd0ZDN0xQWWdvbkxRU3g0cTZYQWMxT3JjcThs?=
 =?utf-8?B?K3EwWnRnc01BS09MVWU4cGNaeSsvVDJIRHdveGgxcGVaakVYdmV3RWN0dlcr?=
 =?utf-8?B?UGV6ekFLRHphMlF5K2lPZ0h0VWdEVmlyOTVDS2tLaThiTnlCVEVHajYvY09o?=
 =?utf-8?B?cFZyMThpNTVtWUVFU1U0V2xhK1Fhcm1ITGdZVm96MWZSeG9LRll5Smc4anN0?=
 =?utf-8?B?d3NjS3p6TldFZWFHY3BFTGFqdnlxZXVVY2t0aDZya2Y5R1ZId3pZYjY0bEtL?=
 =?utf-8?B?K3FKOTJBK2xSR0h3NXRSS3FKajFNdGNtM0NMeHd5WW5ObnkwanpPZzBsUitj?=
 =?utf-8?B?T3FLRTg0VjNYR21kTGtYVXppZStxZU9MZlhEd2V3MVNvcG0wTWZkc2hhTEwv?=
 =?utf-8?B?NE5hQTlESFRxcXo4Nms4SzhOT2Z0TnFEakloMXZZRE5kd0NjcGJISEE2YkJI?=
 =?utf-8?B?SEhBTmM2VjFsRTVpQitsMHBBWEhKcW1xcGhMbFU3MWRpUk1HQ1l1b1h3QXpj?=
 =?utf-8?B?YzVSa3V3Q3V4RTFha1oyaEphblVQUXpLWkFuVWFpNDVJK3FUT0lNd2hrOVVO?=
 =?utf-8?B?Z0NXZEQ1QTZFSWdBaEpaRzFadkk4enBzVk16WnEzNmwxQnhKbjYyZzZIRTFh?=
 =?utf-8?B?d0FaN1pqN1NOZTlGbms0bjRrSFFmN0VIVDhxMjdWdWdqbDdDcEt6eThBSmY4?=
 =?utf-8?B?b0ZpWDRtUTJ6K2pKUnRhMlYwZzNSOVZjSUhkS05NTnovRDBFZkdwN05IQ0xo?=
 =?utf-8?B?UllOMzVtandiNVBjdHdqeEVBQWJFQkFNNlRVdjgzZGRXT1ZrY21IS0p0eFlq?=
 =?utf-8?B?WDd3Vk0rK0ZwR0ZsYk15N1JZWXo2TEsyQkJuc2YrNWYrWkM5TllyaXNIWi9H?=
 =?utf-8?B?QTg1VjR6clkyOWJtKzV2Yno3RExrYzJlMitJNFVWRllJbDJLZisrd1VFUWhr?=
 =?utf-8?B?aXRRUEtkVkd3QUF6anlyZHQwcFdYZFhzVWl3anpLclM4cTJEYzZDd09PNmhL?=
 =?utf-8?B?dm80VzQ4UEJ1QkM5STJLM2tWZTdQYnNtRGVvblh1MEZ6cVRDM1FCOXJKTWlk?=
 =?utf-8?B?N3VCR25IRWdkVUZ0bGpET2hhUTNQQXhJZWwrS3hIL200dFg3UVJuNG55QkJa?=
 =?utf-8?B?RVFQTDVGSHJBeWY1a3BkTHErNHlOMG5MUXc3TDdpTTlDQjRHTUNVZjBCOFFx?=
 =?utf-8?B?endvMG5tbWkrN0xTVXJhKy80ODJvajdCdUtnTVhLc0R0RnhLZVJ0eHhsVm1G?=
 =?utf-8?B?OWJLZGZLYStHZFhPbzlpQWZKK0lWUC9saGZNT3JYM3c3cGhTYUJSSjZ5NWlY?=
 =?utf-8?B?cGY0RGNkL0lVK0Q4YjZUSXI4cjZCT0Z1by9zRXc3QTB3bCttTlcyQTZMVUdo?=
 =?utf-8?B?d2FQMllabk9oWk5JZzlwTGJsS3QrNWQ5dlZKcGhZdVdkOE5TS2ZiS0lSSWRF?=
 =?utf-8?B?ell1WXdzUnNFcUVXV1lyandhTFYvcTdIQVA2S1NrUEwvcXlOL2FLSkpNbXQ1?=
 =?utf-8?B?azNVVkdOc3dkby9sUXZGZStOTWNpYjBJT0o4VGxMRnhwalR0TVJjNU4vRDY3?=
 =?utf-8?B?ZXFucm9TUVJaV0x3V3U5ZnVaRVNVdHZJWDVTa1E2MzQ1WnhnemU2YXVIWlhy?=
 =?utf-8?B?c3llWS9IK0pJeStMeG1RSk0rc3o5QWVPalYrRVNGWGZTZXlFQ1BZSU5wVEdl?=
 =?utf-8?B?L0ZHc3h4Z0F0RlZ1UzZUOUM4ZGdhQ29FdCt5bW5rVTkyMlpxRENuSTd5eUJQ?=
 =?utf-8?B?R1B2TEplVExMdzhwVCtYSTV1dVFrcVg0WDhRRnkvaDVMWTRCdVpqbHhyWGNh?=
 =?utf-8?B?WDVMTERCenhDdmxCSEg1bDE0U3E2LzdoNU15amNwMHlyL3l3eDMyRElTV09H?=
 =?utf-8?B?T3R5Y2pxVGZVbkozbU1mNlZ3S3pWRThvQjVyeDVRTGhWU09EeEora3B3ckow?=
 =?utf-8?B?YXNkTFhpU0szU1p4U2tUQmRPeEVSbUJzbjREL3prc0x3YXRXbWpFZEswQnZu?=
 =?utf-8?B?T3BieWpTUWwxMnB2VW9mR2l0K2E0SU9OT1NuWWZMZElZS1M5WnlPMk14SDV4?=
 =?utf-8?B?V00rMUtzMmU5aklMbjgzVSt2Tm9rU2RycTAxRVY1RE03enA1QU92a1pLWkJC?=
 =?utf-8?B?bEE3d1FneVpZUXM1dUFCSEo4WDlHY0VBaVV5WGhkOEh4TXdZTVJzejg0a2Jq?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880ca359-d709-434b-8141-08db89417b21
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 16:50:53.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4z5BYYnv3cSkIPZRxL6N+oULTngq01OuJG//UbhDKi5IB1DMpRfhCX6bZ9c/lK3oMytMIMGl58i7JjIwU5EdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7153

On 20.07.23 16:51, Aaron Marcher wrote:
> This is the very first step to have the alchemy tests embedded
> into our testsuite.
> 
> Build them using Xenomai's build system and hook them up using
> Smokey. Every test binary has it's own respective testcase in the
> testsuite.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Aaron Marcher <aaron@sigma-star.at>
> ---
>  configure.ac                                  |   7 +-
>  testsuite/Makefile.am                         |   8 +-
>  testsuite/smokey/Makefile.am                  |   9 +-
>  testsuite/smokey/alchemytests/Makefile.am     | 148 ++++++++++++++++++
>  .../smokey/alchemytests}/alarm-1.c            |   0
>  testsuite/smokey/alchemytests/alchemytests.c  |  55 +++++++
>  .../smokey/alchemytests/alchemytests_driver.c |  32 ++++
>  .../smokey/alchemytests}/buffer-1.c           |   0
>  .../smokey/alchemytests}/event-1.c            |   0
>  .../smokey/alchemytests}/heap-1.c             |   0
>  .../smokey/alchemytests}/heap-2.c             |   0
>  .../smokey/alchemytests}/mq-1.c               |   0
>  .../smokey/alchemytests}/mq-2.c               |   0
>  .../smokey/alchemytests}/mq-3.c               |   0
>  .../smokey/alchemytests}/mutex-1.c            |   0
>  .../smokey/alchemytests}/pipe-1.c             |   0
>  .../smokey/alchemytests}/sem-1.c              |   0
>  .../smokey/alchemytests}/sem-2.c              |   0
>  .../smokey/alchemytests}/task-1.c             |   0
>  .../smokey/alchemytests}/task-10.c            |   0
>  .../smokey/alchemytests}/task-2.c             |   0
>  .../smokey/alchemytests}/task-3.c             |   0
>  .../smokey/alchemytests}/task-4.c             |   0
>  .../smokey/alchemytests}/task-5.c             |   0
>  .../smokey/alchemytests}/task-6.c             |   0
>  .../smokey/alchemytests}/task-7.c             |   0
>  .../smokey/alchemytests}/task-8.c             |   0
>  .../smokey/alchemytests}/task-9.c             |   0
>  28 files changed, 252 insertions(+), 7 deletions(-)
>  create mode 100644 testsuite/smokey/alchemytests/Makefile.am
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/alarm-1.c (100%)
>  create mode 100644 testsuite/smokey/alchemytests/alchemytests.c
>  create mode 100644 testsuite/smokey/alchemytests/alchemytests_driver.c
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/buffer-1.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/event-1.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-1.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/heap-2.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-1.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-2.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mq-3.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/mutex-1.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/pipe-1.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-1.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/sem-2.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-1.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-10.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-2.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-3.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-4.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-5.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-6.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-7.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-8.c (100%)
>  rename {lib/alchemy/testsuite => testsuite/smokey/alchemytests}/task-9.c (100%)
> 
> diff --git a/configure.ac b/configure.ac
> index 3ce34048e..fe59333ed 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1041,10 +1041,13 @@ AC_CONFIG_FILES([ \
>  	testsuite/smokey/cpu-affinity/Makefile \
>  	testsuite/smokey/gdb/Makefile \
>  	testsuite/smokey/y2038/Makefile \
> -	testsuite/smokey/can/Makefile
> -	testsuite/smokey/x86io/Makefile
> +	testsuite/smokey/can/Makefile \
> +	testsuite/smokey/x86io/Makefile \
> +	testsuite/smokey/alchemytests/Makefile \
>  	testsuite/clocktest/Makefile \
>  	testsuite/xeno-test/Makefile \
> +	testsuite/psostests/Makefile \
> +	testsuite/vxworkstests/Makefile \
>  	utils/Makefile \
>  	utils/hdb/Makefile \
>  	utils/can/Makefile \
> diff --git a/testsuite/Makefile.am b/testsuite/Makefile.am
> index 4932f6d33..1be7eaba4 100644
> --- a/testsuite/Makefile.am
> +++ b/testsuite/Makefile.am
> @@ -7,7 +7,9 @@ SUBDIRS += 		\
>  	gpiotest	\
>  	spitest		\
>  	switchtest	\
> -	xeno-test
> +	xeno-test	\
> +	psostests	\
> +	vxworkstests
>  endif
>  
>  DIST_SUBDIRS =		\
> @@ -18,4 +20,6 @@ DIST_SUBDIRS =		\
>  	smokey		\
>  	spitest		\
>  	switchtest	\
> -	xeno-test
> +	xeno-test	\
> +	psostests \
> +	vxworkstests
> diff --git a/testsuite/smokey/Makefile.am b/testsuite/smokey/Makefile.am
> index 79dc61e9f..633a87387 100644
> --- a/testsuite/smokey/Makefile.am
> +++ b/testsuite/smokey/Makefile.am
> @@ -40,12 +40,14 @@ COBALT_SUBDIRS = 	\
>  	tsc		\
>  	vdso-access 	\
>  	xddp		\
> -	y2038
> +	y2038 \
> +	alchemytests
>  
>  MERCURY_SUBDIRS =	\
>  	memory-heapmem	\
>  	memory-tlsf	\
> -	memcheck
> +	memcheck \
> +	alchemytests
>  
>  DIST_SUBDIRS = 		\
>  	arith 		\
> @@ -80,7 +82,8 @@ DIST_SUBDIRS = 		\
>  	tsc		\
>  	vdso-access 	\
>  	xddp		\
> -	y2038
> +	y2038 \
> +	alchemytests
>  
>  if XENO_X86
>  DIST_SUBDIRS += x86io
> diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
> new file mode 100644
> index 000000000..9da3a98f3
> --- /dev/null
> +++ b/testsuite/smokey/alchemytests/Makefile.am
> @@ -0,0 +1,148 @@
> +testdir = @XENO_TEST_DIR@
> +noinst_LIBRARIES = libalchemytests.a
> +
> +libalchemytests_a_SOURCES = alchemytests.c
> +libalchemytests_a_CPPFLAGS = 		\
> +	@XENO_USER_CFLAGS@	\
> +	-I$(top_srcdir)		\
> +	-I$(top_srcdir)/include \
> +	-DXENO_TEST_DIR='"$(XENO_TEST_DIR)"'
> +
> +CCLD = $(top_srcdir)/scripts/wrap-link.sh $(CC)
> +
> +test_PROGRAMS = \
> +		alchemytests \
> +		alchemytests_alarm1		   \
> +		alchemytests_buffer1		   \
> +		alchemytests_event1		   \
> +		alchemytests_heap1		   \
> +		alchemytests_heap2		   \
> +		alchemytests_mq1		   \
> +		alchemytests_mq2		   \
> +		alchemytests_mq3		   \
> +		alchemytests_mutex1		   \
> +		alchemytests_pipe1		   \
> +		alchemytests_sem1		   \
> +		alchemytests_sem2		   \
> +		alchemytests_task1		   \
> +		alchemytests_task2		   \
> +		alchemytests_task3		   \
> +		alchemytests_task4		   \
> +		alchemytests_task5		   \
> +		alchemytests_task6		   \
> +		alchemytests_task7		   \
> +		alchemytests_task8		   \
> +		alchemytests_task9		   \
> +		alchemytests_task10
> +
> +alchemycppflags = 				\
> +	$(XENO_USER_CFLAGS)		\
> +	-I$(top_srcdir)/include
> +
> +alchemyldadd = 					\
> +	../../../lib/alchemy/libalchemy@CORE@.la		\
> +	../../../lib/copperplate/libcopperplate@CORE@.la	\
> +	@XENO_CORE_LDADD@ 			\
> +	@XENO_USER_LDADD@			\
> +	-lpthread -lrt -lm
> +
> +alchemytests_SOURCES = alchemytests_driver.c
> +alchemytests_CPPFLAGS =			\
> +	$(XENO_USER_CFLAGS)			\
> +	-I$(top_srcdir)/include
> +alchemytests_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_LDADD =			\
> +	../../../lib/smokey/libsmokey@CORE@.la	\
> +	@XENO_CORE_LDADD@		\
> +	@XENO_USER_LDADD@		\
> +	-lpthread -lrt
> +
> +alchemytests_alarm1_SOURCES = alarm-1.c
> +alchemytests_alarm1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_alarm1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_alarm1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_event1_SOURCES = event-1.c
> +alchemytests_event1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_event1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_event1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_heap1_SOURCES = heap-1.c
> +alchemytests_heap1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_heap1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_heap1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_heap2_SOURCES = heap-2.c
> +alchemytests_heap2_CPPFLAGS = $(alchemycppflags)
> +alchemytests_heap2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_heap2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_buffer1_SOURCES = buffer-1.c
> +alchemytests_buffer1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_buffer1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_buffer1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_mutex1_SOURCES = mutex-1.c
> +alchemytests_mutex1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_mutex1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_mutex1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_pipe1_SOURCES = pipe-1.c
> +alchemytests_pipe1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_pipe1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_pipe1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_mq1_SOURCES = mq-1.c
> +alchemytests_mq1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_mq1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_mq1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_mq2_SOURCES = mq-2.c
> +alchemytests_mq2_CPPFLAGS = $(alchemycppflags)
> +alchemytests_mq2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_mq2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_mq3_SOURCES = mq-3.c
> +alchemytests_mq3_CPPFLAGS = $(alchemycppflags)
> +alchemytests_mq3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_mq3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_sem1_SOURCES = sem-1.c
> +alchemytests_sem1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_sem1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_sem1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_sem2_SOURCES = sem-2.c
> +alchemytests_sem2_CPPFLAGS = $(alchemycppflags)
> +alchemytests_sem2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_sem2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task1_SOURCES = task-1.c
> +alchemytests_task1_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task1_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task1_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task2_SOURCES = task-2.c
> +alchemytests_task2_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task2_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task2_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task3_SOURCES = task-3.c
> +alchemytests_task3_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task3_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task3_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task4_SOURCES = task-4.c
> +alchemytests_task4_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task4_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task4_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task5_SOURCES = task-5.c
> +alchemytests_task5_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task5_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task5_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task6_SOURCES = task-6.c
> +alchemytests_task6_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task6_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task6_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task7_SOURCES = task-7.c
> +alchemytests_task7_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task7_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task7_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task8_SOURCES = task-8.c
> +alchemytests_task8_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task8_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task8_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task9_SOURCES = task-9.c
> +alchemytests_task9_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task9_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task9_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +alchemytests_task10_SOURCES = task-10.c
> +alchemytests_task10_CPPFLAGS = $(alchemycppflags)
> +alchemytests_task10_LDADD = $(alchemyldadd) -lpthread -lrt -lm
> +alchemytests_task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
> +
> diff --git a/lib/alchemy/testsuite/alarm-1.c b/testsuite/smokey/alchemytests/alarm-1.c
> similarity index 100%
> rename from lib/alchemy/testsuite/alarm-1.c
> rename to testsuite/smokey/alchemytests/alarm-1.c
> diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
> new file mode 100644
> index 000000000..8dea068bc
> --- /dev/null
> +++ b/testsuite/smokey/alchemytests/alchemytests.c
> @@ -0,0 +1,55 @@
> +#include <error.h>
> +#include <libgen.h>
> +#include <smokey/smokey.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#define TEST(name)								   \
> +	smokey_test_plugin(name, SMOKEY_NOARGS, "Run external test");		   \
> +	static int run_##name(struct smokey_test *t, int argc, char *const argv[]) \
> +	{									   \
> +		return __run_extprog(t, argc, argv);				   \
> +	}
> +
> +static int __run_extprog(struct smokey_test *t, int argc, char *const argv[])
> +{
> +	int ret;
> +	char *tst_path;
> +
> +	ret = asprintf(&tst_path, "%s/%s --cpu-affinity=0", XENO_TEST_DIR, t->name);
> +	if (ret == -1)
> +		return -ENOMEM;
> +
> +	ret = system(tst_path);
> +	free(tst_path);
> +
> +	return ret;
> +}
> +
> +TEST(alchemytests)
> +TEST(alchemytests_alarm1)
> +TEST(alchemytests_buffer1)
> +TEST(alchemytests_event1)
> +TEST(alchemytests_heap1)
> +TEST(alchemytests_heap2)
> +TEST(alchemytests_mq1)
> +TEST(alchemytests_mq2)
> +TEST(alchemytests_mq3)
> +TEST(alchemytests_mutex1)
> +TEST(alchemytests_pipe1)
> +TEST(alchemytests_sem1)
> +TEST(alchemytests_sem2)
> +TEST(alchemytests_task1)
> +TEST(alchemytests_task2)
> +TEST(alchemytests_task3)
> +TEST(alchemytests_task4)
> +TEST(alchemytests_task5)
> +TEST(alchemytests_task6)
> +TEST(alchemytests_task7)
> +TEST(alchemytests_task8)
> +TEST(alchemytests_task9)
> +TEST(alchemytests_task10)
> +
> diff --git a/testsuite/smokey/alchemytests/alchemytests_driver.c b/testsuite/smokey/alchemytests/alchemytests_driver.c
> new file mode 100644
> index 000000000..cf9045bb5
> --- /dev/null
> +++ b/testsuite/smokey/alchemytests/alchemytests_driver.c
> @@ -0,0 +1,32 @@
> +#include <error.h>
> +#include <libgen.h>
> +#include <smokey/smokey.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +int main(int argc, char *const argv[])
> +{
> +	struct smokey_test *t;
> +	int ret, fails = 0;
> +
> +	if (pvlist_empty(&smokey_test_list))
> +		return 0;
> +
> +	for_each_smokey_test(t) {
> +		ret = t->run(t, argc, argv);
> +		if (ret) {
> +			fails++;
> +			if (smokey_keep_going)
> +				continue;
> +			if (smokey_verbose_mode)
> +				error(1, -ret, "test %s failed", t->name);
> +			return 1;
> +		}
> +		smokey_note("%s OK", t->name);
> +	}
> +
> +	return fails != 0;
> +}
> diff --git a/lib/alchemy/testsuite/buffer-1.c b/testsuite/smokey/alchemytests/buffer-1.c
> similarity index 100%
> rename from lib/alchemy/testsuite/buffer-1.c
> rename to testsuite/smokey/alchemytests/buffer-1.c
> diff --git a/lib/alchemy/testsuite/event-1.c b/testsuite/smokey/alchemytests/event-1.c
> similarity index 100%
> rename from lib/alchemy/testsuite/event-1.c
> rename to testsuite/smokey/alchemytests/event-1.c
> diff --git a/lib/alchemy/testsuite/heap-1.c b/testsuite/smokey/alchemytests/heap-1.c
> similarity index 100%
> rename from lib/alchemy/testsuite/heap-1.c
> rename to testsuite/smokey/alchemytests/heap-1.c
> diff --git a/lib/alchemy/testsuite/heap-2.c b/testsuite/smokey/alchemytests/heap-2.c
> similarity index 100%
> rename from lib/alchemy/testsuite/heap-2.c
> rename to testsuite/smokey/alchemytests/heap-2.c
> diff --git a/lib/alchemy/testsuite/mq-1.c b/testsuite/smokey/alchemytests/mq-1.c
> similarity index 100%
> rename from lib/alchemy/testsuite/mq-1.c
> rename to testsuite/smokey/alchemytests/mq-1.c
> diff --git a/lib/alchemy/testsuite/mq-2.c b/testsuite/smokey/alchemytests/mq-2.c
> similarity index 100%
> rename from lib/alchemy/testsuite/mq-2.c
> rename to testsuite/smokey/alchemytests/mq-2.c
> diff --git a/lib/alchemy/testsuite/mq-3.c b/testsuite/smokey/alchemytests/mq-3.c
> similarity index 100%
> rename from lib/alchemy/testsuite/mq-3.c
> rename to testsuite/smokey/alchemytests/mq-3.c
> diff --git a/lib/alchemy/testsuite/mutex-1.c b/testsuite/smokey/alchemytests/mutex-1.c
> similarity index 100%
> rename from lib/alchemy/testsuite/mutex-1.c
> rename to testsuite/smokey/alchemytests/mutex-1.c
> diff --git a/lib/alchemy/testsuite/pipe-1.c b/testsuite/smokey/alchemytests/pipe-1.c
> similarity index 100%
> rename from lib/alchemy/testsuite/pipe-1.c
> rename to testsuite/smokey/alchemytests/pipe-1.c
> diff --git a/lib/alchemy/testsuite/sem-1.c b/testsuite/smokey/alchemytests/sem-1.c
> similarity index 100%
> rename from lib/alchemy/testsuite/sem-1.c
> rename to testsuite/smokey/alchemytests/sem-1.c
> diff --git a/lib/alchemy/testsuite/sem-2.c b/testsuite/smokey/alchemytests/sem-2.c
> similarity index 100%
> rename from lib/alchemy/testsuite/sem-2.c
> rename to testsuite/smokey/alchemytests/sem-2.c
> diff --git a/lib/alchemy/testsuite/task-1.c b/testsuite/smokey/alchemytests/task-1.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-1.c
> rename to testsuite/smokey/alchemytests/task-1.c
> diff --git a/lib/alchemy/testsuite/task-10.c b/testsuite/smokey/alchemytests/task-10.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-10.c
> rename to testsuite/smokey/alchemytests/task-10.c
> diff --git a/lib/alchemy/testsuite/task-2.c b/testsuite/smokey/alchemytests/task-2.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-2.c
> rename to testsuite/smokey/alchemytests/task-2.c
> diff --git a/lib/alchemy/testsuite/task-3.c b/testsuite/smokey/alchemytests/task-3.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-3.c
> rename to testsuite/smokey/alchemytests/task-3.c
> diff --git a/lib/alchemy/testsuite/task-4.c b/testsuite/smokey/alchemytests/task-4.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-4.c
> rename to testsuite/smokey/alchemytests/task-4.c
> diff --git a/lib/alchemy/testsuite/task-5.c b/testsuite/smokey/alchemytests/task-5.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-5.c
> rename to testsuite/smokey/alchemytests/task-5.c
> diff --git a/lib/alchemy/testsuite/task-6.c b/testsuite/smokey/alchemytests/task-6.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-6.c
> rename to testsuite/smokey/alchemytests/task-6.c
> diff --git a/lib/alchemy/testsuite/task-7.c b/testsuite/smokey/alchemytests/task-7.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-7.c
> rename to testsuite/smokey/alchemytests/task-7.c
> diff --git a/lib/alchemy/testsuite/task-8.c b/testsuite/smokey/alchemytests/task-8.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-8.c
> rename to testsuite/smokey/alchemytests/task-8.c
> diff --git a/lib/alchemy/testsuite/task-9.c b/testsuite/smokey/alchemytests/task-9.c
> similarity index 100%
> rename from lib/alchemy/testsuite/task-9.c
> rename to testsuite/smokey/alchemytests/task-9.c

Could we also get a copyright header for new files, please? At least an
SPDX-License-Identifier line.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

