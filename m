Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB614F8E
	for <xenomai@lists.linux.dev>; Sun,  3 Dec 2023 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Rgfv66GY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEj0EBhSkjsiiY4oP+6mi3SsJzAudtj8o0IGK0yxhBXrVRc77Eov+SVdl5RmT6NWDgDVp4KUuWhRiB3FFGmiaxfDjU8SDZq8dtzLow31kX2aTEc9sQImW/eViIkjj5h/VvMB+vnuvWm0jbcjL5+v0Ut8ghj6TKo25j1Al93MMpcGUuUkNH7cfhY6zbNO01zQTvk/FPjRyqjpwM7oEQY9YjNEVuB35g5/+PZJBHAT+9DqwiVl8SkBI/+RE58Um6KEHuiS23h/se+lP7Dxgzrvk2/JjUg5zguN1EUTD7nbzbvAUD3jHCk+zGoL1nK5sdm1A+Cz0bbpTpZxofXzpteKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nK0SdHOrMyy2XhwrZPFF3YKNlL8DAXBZjKmER5GwJo=;
 b=dtU/WFp57VNsMsUWJGZhr525xOein55A6qknaMOsAFoyyL7DvTLPRNYkLEat/sficbOMh1PxLt2p1+DI0IOphlG0HvyMxjkn9YAdfIf3HFYaDw1iJ5yEDh2uJumE0+R1D3bnN6qYPmPw8SFlBxLhIihJBlpGe3n8A13GuWH4zVZ0IWimOzvuOslrUR3T5lkTex/SAvIpfpbQvmwjD3mWgD3cXkbW9RPXHK7koqs7L1+ilPzafihpgTO6Rqb77W8dE/2HslK37y/qsYkbutG4e1w2KoGzznSgLSOj6z3ENcbXapc/uGQpEpIjjhhmVgRmMil06xspA7vhF35fYqQP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nK0SdHOrMyy2XhwrZPFF3YKNlL8DAXBZjKmER5GwJo=;
 b=Rgfv66GYx6LRPD4Jg/ibgadE63wplE5rYOcLR80ZaBcR6jFQVTFm2XZHhZrB/R8pilAdriOQ1DNDCBppABJDWcGJKfWyjF5J4LWkbK/DDo2cVTmJpby4jk22+XE7dzKg2QchVUXdZXAS2bDlku0JZ9rDJYvchyQPOivHLAxgwGZLrPa9EQ8SlIvjAXhwwTw7pGhdZ0uxe7GM1N4ywgYAfbRF0dBx+Wu5YBVdlPn0nGfN5l+d6OKmMPAY91tu+cLwJ/xg24jUJeMBpWH2RqBSu2w7E4xqRTuPWrH3qClKRHuXg50LYCdSyHcxgtwebflXWQa1Ns9Q54zgJiPPchXQsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Sun, 3 Dec
 2023 22:37:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.033; Sun, 3 Dec 2023
 22:37:32 +0000
Message-ID: <e16782db-9903-495e-8b01-5102febb704d@siemens.com>
Date: Mon, 4 Dec 2023 07:37:26 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2,1/1] lib/psos/task.c: fix build with gcc >= 12
Content-Language: en-US
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>, xenomai@lists.linux.dev
References: <20231203221711.339018-1-fontaine.fabrice@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231203221711.339018-1-fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0122.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 61063c56-b87c-4d3d-dc5b-08dbf4506fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	to9u6eelx/KLAmvWSzrJfRo6WpYZV8dnZo5zWVPLFBaxCtae1P5YDZRkurGAzJsA62OJ6joVKluJ8DDCab2z3ZcntU83T5uJvhUI+KKeUYU0hHGHcKVrD7CBAG6XWO/8Ct2n0P8dvjsjk6NSBRGr59jZ1ZG85tEcTX3MiemfSDRLGtPCCOZ4ihMBZx+jSOTrT4kjpKX8j/7jrBv5kBQxhdDJ7UebHDaNeGMP5cb30F7j/aHBLqj/87PqMH2vB9SZqbvTc0/Lcv7G/+CAns16UpT0lKIq+tyDd5XKvXoEzRRROkgMWipwl/kwYJvHZYcoz0QWRLQFkHKmaLTttu6ZrZp1PT4YLrtjTsK3fWuLfw2D6r6O3CPtZGWAzGb93uQeks9+UvFPhPZ/F3jtxdUYNbfueatYtttuvG9Ofmx7ijARhGJKR6lPdZNYMMyFbvydVqKrzUNCA4Of4kynRNOigSTt60uZ2tX1GNpKYNYnfgzN73iM3VaYak6ZJObWf5GqLbvG1STEO86BIDkTjomAbeJJ4rKIPYwD07+VMIVGfcjJpQccG9IPDaB3QbEWHctAIvn9awx8z1HzS6VC8aT5uj7DlaCI3Nh+FHP/C9c4IyIXIEPOErPyuU00oRM59Wz2V4c3qQ2mXAxt8QmFHDp2YLfJFPv+Hbc/4taA6rJP3GwqYggRKatsqh/1hCbOXSQT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(1800799012)(2906002)(6506007)(6666004)(478600001)(966005)(6486002)(8676002)(8936002)(86362001)(44832011)(5660300002)(31696002)(66476007)(66556008)(316002)(66946007)(83380400001)(26005)(82960400001)(36756003)(41300700001)(31686004)(38100700002)(2616005)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0kvd1AwTzVob0Y5d1Q1SW1BK3Y4eDB4NE9UWjNCTkhycGRYendTUVJpWHlU?=
 =?utf-8?B?MFU5amZUYTJMcEhDaXFJOW5ydnJ0eUZsNlF0aXBNWWxyTjQrOVlnZ2ZjcWRP?=
 =?utf-8?B?S2xlYmtPV2M4YmxEMHFsZEVCVWtudittT1VlMGtkUjM5WTArbWV6YnpQQldB?=
 =?utf-8?B?dHdZbG04TzV5TDAyeFFYM0lDQUk3Z2JWS0RibFBUbWZlQ2FNM1ZxZ3NsQUhu?=
 =?utf-8?B?WlNVY3IrTWZOWHJmQ2t5aEtEMXBvY1Zyd3JBMzVJTHZSMmNCU2txeStiSHQ3?=
 =?utf-8?B?UlZ4M0FhblcvaU16RzBMZHZFQktZK21hMjRIT0Fra1dlYW1wMW5XZXQxM0Nq?=
 =?utf-8?B?Yi9wZEY5alJiVklyOGk0eVdCaHVyYUVsUWw3azU5WEpnaDE3V3Ria3pnYWw2?=
 =?utf-8?B?YlVvdVpuS2pYdVlDWm5SZWpZSXBqTDlvclpXOS9UaCs0K0J0SDJybHBlbFRk?=
 =?utf-8?B?RG5LaUhVckhkNGJCYmZweU1wL0pMYVBqaHlvU1BVTjlsWlRxbDU5TkJIWllF?=
 =?utf-8?B?a2g1bG12SWt3akYwdUlpOHlzZGtGcmN1WCszZDdWOVd5cG96a2VpMnB2WDlq?=
 =?utf-8?B?QW9maE9NcnBYVXI2dVAzejlUMU9vaEp1eXBuM0U5OG9wWkZ4a21PYXlOcjZh?=
 =?utf-8?B?S0dPbFlPT3pzTjNWclZQVkJtVEdha3JENFg0UERaWURrMHMrTVhTLzdKUTQ2?=
 =?utf-8?B?enNyNDNLeWlBNFVCZTRwN2YxZ1NOMGVweVgrZFAvamJNL3JTZVBaeGNnRkRE?=
 =?utf-8?B?UzM1RnNmOEdWU0tZMU1rc0kxM05ZKzIweVFvMDZFZXRaM1p5dzFVSTJDYWV2?=
 =?utf-8?B?N1haRUUyNm9BbTBhZFdtN3VVZHpkK1B4Y3RhM0NvNXlJNTR5OG5XNUJacGpk?=
 =?utf-8?B?b0UvTGRmVHlhMUIvUTZJckN1bjhGeFRiWG9aRnBLYmorNmdOaXN6LzM2Z0Y0?=
 =?utf-8?B?cEIvVGVzUUdNMEVQTEcvTzByUXdlUUxubkx6Ly9xcDJOd3I5c3BEbFFMeVc2?=
 =?utf-8?B?WU9OYm1lbVNWRUowSndpRlMyeHdseVh0T2dIekZtbURGQUp0NlAvMHJTb09Z?=
 =?utf-8?B?dElvZ0VwcXNCYit6T3FWYXZEMGh5RE42S2RIN1FSQ1A3REttaXc3QjhuU3Rv?=
 =?utf-8?B?L1NiMlp5cTFCZWZTYVhVdi9ScFJCdlJMMnF4UXV6S0MwTndyTWFhWWx0VEdZ?=
 =?utf-8?B?NEF2alpsa3dScDVBR3ExQklXMEJlOTljUTNMRW5VdzI3OHBBQ1FSdTM3L0w3?=
 =?utf-8?B?RlR5RjFaaE1tUjVJdHZrT1lveXp2MVZVRVhkYmpQbmF5VEVhUytXb3k4aDFs?=
 =?utf-8?B?RzRLcU9jd0dHbkZiK3IzVithTnIrVUVOdVR5VjFVM0M4MVg2bUphMVNna1Uv?=
 =?utf-8?B?RzlsK1hUQmZvZWZNa3hqemtaK2MvcnZsVE9UalRmMGNQbHJpNlVnSWZsMlBt?=
 =?utf-8?B?R2xQaW9uUE5KUzI1ZnJxeDJndDQwRUNwQWdZbjJ1Ti85TnhZeVdiWFg1NUln?=
 =?utf-8?B?MkpHU3lmNmxwZGNCbDROTFBJQUxHaWNpM1VwNGp6bnlmWXU4dFdCV215WUtp?=
 =?utf-8?B?MjJSYjI4Q2loQTZrWEl0VWEyWmU0cE1HT2plWTZrc2ZVM1NmN0hrN3A3dFh1?=
 =?utf-8?B?K09BUkdEeW8xWjNaNjZ0dGpBdmV5Yzg4MkkwLzVqeGF6SkhUS2J2VDJwT3Y5?=
 =?utf-8?B?MTZ0bE9FcnpmV0QvaWM2MzFsZXVYa1ZpMG1QUU5hWDM0VjhWZUVtNUZyR01G?=
 =?utf-8?B?YzEwdHpVUUUyTG9vYjBGRHRZYkRjSXRvUUpyMEd1S1NIOE8vZ2ZrbTZDc3Vl?=
 =?utf-8?B?Vzk2OThmdzB2ZlFuNG9aTTZaNUFuRksyZWdnMlMvOUo0MDAxN01XaGZuSlZI?=
 =?utf-8?B?MWUxY2EzSXU5Z3Q1TVhwWEloWEUvUm0xbjFtRDVuZWprR2dtMnM2U2F4L2FM?=
 =?utf-8?B?K2Y3cU9EQmI4WTd6cHFJSS83eHp2YXkzczNkRVFLSlMzRlk0d080aTFwd1pQ?=
 =?utf-8?B?em50S2haYy9pUWtUVi9xRllmc2tobnBrYW41L2VNN2RGWmE0RE5jZkxJOHh1?=
 =?utf-8?B?NEI4YTRBVVFvdEdNVWNCUlRIekQ0VEpvUUwzNWFpMXBtc2lFeEpPdkpZSnJo?=
 =?utf-8?B?c09hYUY5a283blo4eDFXb05OTTY0VjJQNE1KblNLdGNXZlM2WDVZeDR2N0Q0?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61063c56-b87c-4d3d-dc5b-08dbf4506fdc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 22:37:31.7351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5xAOvkg9zEziaoyVtD2lSZs76AnZ9QwHF87UccrmSLPUR95417uR+TIq0arA5k35FF/G59Ky2dW37l95Jj6Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5602

On 04.12.23 06:17, Fabrice Fontaine wrote:
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
> Changes v1 -> v2 (after review of Jan Kiszka):
>  - Replace SUCCESS by ERR_OBJDEL
> 
>  lib/psos/task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> index f678be61d..cc7e5c9c4 100644
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -362,7 +362,7 @@ u_long t_start(u_long tid,
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret;
> +	int ret = ERR_OBJDEL;
>  
>  	CANCEL_DEFER(svc);
>  
> @@ -426,7 +426,7 @@ u_long t_resume(u_long tid)
>  {
>  	struct psos_task *task;
>  	struct service svc;
> -	int ret;
> +	int ret = ERR_OBJDEL;
>  
>  	CANCEL_DEFER(svc);
>  

Not yet what I suggested - or does my proposal fail to resolve the warning?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

