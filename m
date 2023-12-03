Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942416438
	for <xenomai@lists.linux.dev>; Sun,  3 Dec 2023 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Z2w6T1yn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfOVOCM0rt/vhGlE73K0Y/5w9fpakb5yOqd7hLJ9YoxhceuLqX7UHdjjIP+9OxQevGM0sYGm0agSfGS8IALiiMk03Fmlew4S1HJFh+zwEPc8rROqHODeS8x5jD+XnX5QYmNOou/iE4ECcrBdIdu/R30oM5VXDvRh7ZQRRz5BDErDycl6xX23RVON3NJCv3b5hu4CnLI4FblagKmzJyar8A+uoTkWO7jOB/UZIG62u7BobZbLyFL4gpw80QKb5GvhU2DRdQjoiZ+J8GvyU6Ovt8MnVXOjfNCI9BlfP2o0SGPN4ARmqvECkrJXLD2+aIFD642gPfTOme9NBnxgY88fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJAjf4KqGXdk19LNS1bQydWDjc2t8kWp46xZez61JCE=;
 b=Q27Xh0AMD2hsid2LNAfR8YxEgIXmPkgdC314WbnrdSl6jkecfWeVLAVizFFlUl6nRHwsfqiELpB8JbkkQYXPoLQPvNh+/t8FZUi2VFLL1//5YqfvxniZDsR9d3ua9ZJPRepZuelZCjjmJzIKdnfiugRVX38lkOE/snYHR3lcoldM+J3KfkL75UDq+/QMOUybbsuq+o6kwRP9BjpdjnFY6mWM6pyYnI9g7Y9yr+wnViQ00KNsN472dFalHxBvG2vjvxoC4jG9skY2zZbsP+CX7R29YuCKvLgb0tOJxhpQFK4lcdfqDolXNgehLlPHCh1FKy4qZk/K6TQOdov4FK3dQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJAjf4KqGXdk19LNS1bQydWDjc2t8kWp46xZez61JCE=;
 b=Z2w6T1yndr+fGDC4avV0Pyk+rbzxHRsvKHj171N9syRaU2PiG7DM9Nfl/KyvYhZsVpSpCg5QN7Ruzga40SuoL24CWoA+gSgVSzUjSC1clRmx7w55QsnlwOeBtxn4nLET6z3WEV0rLqXUPNan92XREzX+aBZmdFg9eTLv0d8zQkO0gpEzx3UCbCQKqsWmlvpm5GWCGuqikJN1wm2tYXx/t/QqTI8rYs12AAytefqdmeQndhKSNwOL80NzTofbcQv5C95MeVPDrqvBI4sdvs1Z02wZt6diqre3vyCpDaE0AYqRxWL6FYZ8iHQYg7KMdkDX9WuJqlb96pnf9uuMKg2bbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5347.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:299::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Sun, 3 Dec
 2023 22:03:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.033; Sun, 3 Dec 2023
 22:03:43 +0000
Message-ID: <98a42704-654c-4153-b241-3d7def5f721f@siemens.com>
Date: Mon, 4 Dec 2023 07:03:37 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/psos/task.c: fix build with gcc >= 12
Content-Language: en-US
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>, xenomai@lists.linux.dev
References: <20231203144307.1940139-1-fontaine.fabrice@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231203144307.1940139-1-fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0071.jpnprd01.prod.outlook.com
 (2603:1096:405:2::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca30ba1-b685-4ea3-2021-08dbf44bb64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S49sBZNB/4KSgp7ANjlHW2YJaCOWDsDWWIX5W9qvF/8PFX1LGPKH4a6pVlng9qJOBd2AkQDkl0CxQ1rpCAOPFjgL9kSSImAehi+WUYqUivRZfrDIxm8v4uIqeJ1ZaS89R8cqqbqXpt9iabPvUQ4yVIKtH12MJZmqw1xjXPHSaICkUVkXkkn/xFVWNgCQka+h+kOiNN79bXGdLmEwm+IRaAJqE8SAAhgT1XeXyotdQmyeU50DB4CzLPCcEqYxHCucgCLilvw2ferEF+Ke2KFJuXtU5opOmXFkxk66P2GUuTdPPo2SjiEctrgLre2WwHxAu3IPqpvOYaIbAqaYLfTNvUbL6M4d2A5lP7yRjeWEVYxYovPX+QyfmzQhj0wYpwGes7tCXVdO3HQbNCm6ALOnQKaJhVHxFjAmAY90UG0dz+MRbu2vV1IYHVUp76ekTsAF8LRXT5eW222pI5u/8QYgT2Fbfz1SeEBtzDwon9hRWXKH4FWmlWB2L/gHp7fmXFVLBagFFt/bS+CoCHZ5TzZtEj3zB3lD4dYQizeBzKcmBgpXAmupif6o1UaorT9j0XgMO6rpq3RX9S4eQTHh40t89N8YsNXpRrBR7W/YwA+2s1QaNPJB3LIx0nGoRhofKIsI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66556008)(66476007)(316002)(6486002)(966005)(38100700002)(2906002)(5660300002)(31696002)(41300700001)(86362001)(36756003)(8936002)(8676002)(82960400001)(44832011)(6512007)(53546011)(6506007)(83380400001)(26005)(2616005)(31686004)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTBHUXc4M0hyR1c2aktWZlpqb0pLTFV4Qm55OFBJaFovdWtBamFVZ2s1cFhO?=
 =?utf-8?B?SHZrWHprcGRmWXdqc0VCRkMrZE93bVN4MUNISXEvYXVKT1VNdllFMWZ4RnVI?=
 =?utf-8?B?OGZpT2dKZGg3dkJ6Rk5CZWx5cjNIdTQ4b05yV1JZN2RHTWRIZjZadjN1K2Y4?=
 =?utf-8?B?ZFIwc3I1UURvSFMxYzJFRUp1OGJDZTJSeG9wR2pLZGl1T0NDb05jOEtRR3VC?=
 =?utf-8?B?Q1J4MVEvVUhiODAxT01vaWtxZlZxS1J2dEx4cFZONGlyaHpaZE03SllsdHAw?=
 =?utf-8?B?b1dkaGdRTnk1SWFsQ3g4amVCTGZRU3JqWGozTTNPQlhIRmxhUzNLMVJ4VDhH?=
 =?utf-8?B?QjhFY0Q2R2Jvcys1RUVCSW9jRWFkeW5WbDNuOTBZQ1VxSW94a1h0MGJPbWww?=
 =?utf-8?B?SDd3NStGSmZHay9Eclg3Ymdmc0oyQ1RKN2JleWNNZXNhbUZoRm1nK0F3bTJq?=
 =?utf-8?B?NWFQR2o1RDVZdE5QQVR4UFEwR0czV0hwaE81SWREUTZwNzhSckVaTzc0Mm9H?=
 =?utf-8?B?UU5zM1VhQ0QwS0JrUno1NFcwQXlhK01rUlo0N004c3ZyV0dUdElyWmpkK0JZ?=
 =?utf-8?B?akJESUw0eCtydGt6dXBGWHJsWVhvejRxK013STg1SUNueEJZUEZPWmk3a29V?=
 =?utf-8?B?OFBnZVduWUtqSjY4ZjRlckxYOFdORnBpdDVjSzYwTTRzRElmVVBVTnhTYXJ5?=
 =?utf-8?B?c2luZnRTWkVhQ1NNTU1mY2FIMm83U0h6SGxGM013L3BJTlZMMXZSWnVQTTIr?=
 =?utf-8?B?N0huOW9yc2gzeGtJQ3d0aW82RmxuNHJ1RW0yQm9QZEFJWjUxS0JFRjVpSm4y?=
 =?utf-8?B?K0xZdmFWTnVteGVzQmQyM2R6NmRIc2FvZkFSb1hMcUVLc1VFeUsrQTVKREpV?=
 =?utf-8?B?VWFNdlNqSGdwaVZ2SWsyY1ptTzViOURzQ0ZidHprbFJuODYwalNTR2pReS9P?=
 =?utf-8?B?TStkRnU2L0Vid0tYOFVJTmxhNlZkbFdReGZlVXV5a01qejNTNU1nTDJYSUxD?=
 =?utf-8?B?dnFxbitENEcreFlYUDJUaHFvVy9SdVFWRjZMSll1eDhhNTZPWkpPWldIVFVS?=
 =?utf-8?B?MVlEeG1zNXMrZVM3cS9ZeW80TE5PUXBmS3VmQjJ2NE9VYlc5ci9XSmczV3Z4?=
 =?utf-8?B?OGs5VmFEOEVJNHNMOWMyanE4d3N5VEQxSDlWWVpJRVE0NGlOcVpCaStEMzUr?=
 =?utf-8?B?dmVBVXNYSFNrK3ZDL1dmR3U3ZFZYdk5JRjhvTmwxWFhDNGhQV2I4aUNJc3NK?=
 =?utf-8?B?MktucUIySWFIU3U4UDBkem9Hd2dRZWtlaFZKQUlWTXlCSEhmUFR1QmwzTkt1?=
 =?utf-8?B?OTNiZ21Sb05OVVl6NUdHQitsWXUrcWxGK2Z5bUQ2QWNSd1VPbnhJT2d2SEhU?=
 =?utf-8?B?WjZ6bHVGbGRZbkZyUS9hOWZNaUI2OEdFQ0h3alFuWXVucHZYTVVPTVcraWEx?=
 =?utf-8?B?T0l6SDFCSVV0OU9UT0Iyem91Z3B6WHpyNk01cXU4TjNFdnd3WHljM2xOaFJM?=
 =?utf-8?B?T0piT0NHN0VpWFA3elZQK2dJdTFSSHBwaGxNeGN6YktiQXNsTEJWcTBJRXA0?=
 =?utf-8?B?K1FiM3JUeTYrQjZ2YUhVVUZqc1BSZDZVOC84Vkd4bFEweExsbkI1dWRkNS9E?=
 =?utf-8?B?anFWSWF2YVd1c004YVVVZ3B3UkJOeHA2bngxcm1nYXhhVkp6Y3VIRnVMV3Bk?=
 =?utf-8?B?VjVpcmJyY3hRUzZaZWM1Z2hndEdWa090cFZMOHM0K1IzSmcyYVhnVThPV1Ay?=
 =?utf-8?B?Q0x1UmxlbGZOdlhGTEVvdndnSFpEZ1B3c2I1WldteGlRVE9iOXd4aXY1OTg1?=
 =?utf-8?B?bTQrcFdxQVl3TjlEbFlodTI4ZXBsT1RnUmxZTG5UUnpXcjZOSkYvVXluTUxZ?=
 =?utf-8?B?MGdKUklHRDBWaFJTdE16TXRwOTBHK3lXOHpNSitpbjRzL1BUMVBxd1JDNkpO?=
 =?utf-8?B?TDlucHZHU3dQRWtjOGZPZHZYWjZZUW1MY080UmxVek82dUM3dGwwWlRUT3BJ?=
 =?utf-8?B?bEc2SUM5MUx2WDlVUGsrUTh0aEpiVHZUQVBIRE1SbUFTQldBemswNjJGNEhv?=
 =?utf-8?B?UG5LOWdPNW80UHVodDRRMmpXS3k3MlN5U25kelBDT1NvTWkxWGk3RlpyY25v?=
 =?utf-8?B?ejlENEdvNU4vL2NieHZIcDYwUjFUSXFpdjFJeEZYUHdhNUpCY3ZFenpjOFl2?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca30ba1-b685-4ea3-2021-08dbf44bb64d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 22:03:42.7380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPO0rK85cx1XgILmTzERry8xwZ1v7R03EUfPKy0Vn5SLSQZfBNt32dNsC4g9wcPX5vqoLVwoZSBu1CZjHQdOSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5347

On 03.12.23 22:43, Fabrice Fontaine wrote:
> Fix the following build failure with gcc >= 12:
> 
> task.c: In function 't_start':
> task.c:398:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
>   398 |         return ret;
>       |                ^~~
> task.c:364:13: note: 'ret' was declared here
>   364 |         int ret;
>       |             ^~~
> task.c: In function 't_resume':
> task.c:444:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
>   444 |         return ret;
>       |                ^~~
> task.c:428:13: note: 'ret' was declared here
>   428 |         int ret;
>       |             ^~~
> 
> Fixes:
>  - http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20b6bf4d1f73a6ed8a
> 
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
>  lib/psos/task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> index f678be61d..27bcc28a9 100644
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -362,7 +362,7 @@ u_long t_start(u_long tid,
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret;
> +	int ret = SUCCESS;
>  
>  	CANCEL_DEFER(svc);
>  
> @@ -426,7 +426,7 @@ u_long t_resume(u_long tid)
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret;
> +	int ret = SUCCESS;
>  
>  	CANCEL_DEFER(svc);
>  

Thanks for the report, but it looks to me more like get_psos_task should
initialize *err_r to ERR_OBJDEL for the case that threadobj_lock()
failed - which is hopefully what gcc found here.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

