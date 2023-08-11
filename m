Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE863B6
	for <xenomai@lists.linux.dev>; Fri, 11 Aug 2023 15:07:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/oe5IK3K/Ay6Yb/Ubs6rLulohtRDOCKpYYIhAwO2pGXbbQYTYvH3DoGX5rRpKe9qG9ihtAvk8xdy/yiZOmDt3fFXnw4xyYANaSn73AptxOZCng7BqMtRqDfMjCxAKqxQEvJTOs/KdBTldoOFEuaugw3PtGEhc1wO5Op6muAgOggG0jeADxsloXpDM31L44bYc7UxCA/kwto3+3mHyBGtaMm3SIcMcwzBx74t1QbRTsrGabd1tsNgT2HpKxTbBMSI97X3FTmv8WghIathXglzLofYu+XFmazk50BtryAX3DnEGaMJqWWf/WuM+SmFyDK+S/zIxHFeDsFm8IBah+b6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g0cUG0stZ5nzPcLczJKd/HpgfgqZZYUWR9GSsSLjsk=;
 b=NSuJikAjrQsWRrmYQbOuw/9PeQAJ0fozYRDvxn9QozgAzWbIYuMV0cwGDnuIVvzQRS70B/7KaisFvm/8IGO9+aI6sct39p5Y4zbgJvDAId+07CpVBh6UBbjccXY+TtrmgEFmbgaDPFtkIxqOSE1eDic1Ck1wa0wPWL6TB/5v69hDM30m6qD4Uryc+/aOICBCFCopjeb92pYA5NsOIkFf0pDBw09aC2QSvoHejHPjnnMWs9hWZFJ/9IZj5taUOkhpLGPLw9Mza1cCV9Xmn8MEkzzJUSX/eO9gkKkGxeda0H+NVwwW6XkqTAJjudedYLqbMsXdWyeAPi7gyWg2j5vbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g0cUG0stZ5nzPcLczJKd/HpgfgqZZYUWR9GSsSLjsk=;
 b=xRwDEVe7LZ8l+zGbSo+AXU4WSkUXlvQ/x4Jb6qm8XP20Eg/RGA/HiYvTXNuk4+wKljaWB7AMIlYKsZvkYMJiHjdb3GKui83u6HO/2QSOhK9FPtuS4kiR1oE+IL9X6QUO4Z7IwN9D8c91taRcn32vwJUYwdnSZgcoL4KsbcHrIddUH78iTTAzgk9HjVy3EJpIegv0JZ3ccTJI/SmdxRoZ+ojUg5ZamOJO6HbItVujbjJ0ROz/zCHff3HO7IG7M8LxF67Z8AvwslAE8abVTfQ5D+8hyk/XOfwrrr4f1ynC5b2LRUqvQo/hkT2ouAQ8o5HxvBQyjdhtDUr0KFrT+6/nrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6165.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:07:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 15:07:01 +0000
Message-ID: <39aa20a7-e1ff-4335-96c5-3df0a487cf85@siemens.com>
Date: Fri, 11 Aug 2023 17:07:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] y2038: lib/cobalt/select: Fix __RT(select()) routing
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
 <20230809-florian-y2038-2-v1-7-d1cfe2f394a3@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230809-florian-y2038-2-v1-7-d1cfe2f394a3@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:610:cd::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: a506e512-0bcb-4ed7-d1d4-08db9a7c9da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NlSu8zt/7/yWSPQqjZ3zYPOeqR/orStIDCXxxgOycxBGUY7WwDQE3Wcgd6767qxOA5Umh744qWjNRd0/eS/01vaSynRbY6556w1k+203HiYukGK0MgDGklIv5AFj9UhKxnBoNoITAKo0APukN2PYQJzaWFFizz2Sp4gg9l8LlJc42/bLKkgzuFJoJAi9UhFutvOMB9vez2E3SlVxFejZxJizYLwVcH7ne+A8QR5cpU8jbXAu23fi10UycxDBd8jYoQ6w/I5fbheKhBBNFeLXIaEY57OVe6fdBM2zkOmkW8pbFygck/MJ2OazglbwPbnki3UT97s5xTiPs15MBSk2tKCPfHhzQGAaXe6ymkJkz2hbnrtH2pfquG6qkDUj2+ZReIiotCAZXClSvWSxYbgMWwmIAQoic5MXuO/Ju+u1jmKBFStT2Wzbsm/hgOJD2M0cJLx6ZxPci5sNXWjdWYIcr1qUsfjPXYsUSZa3CQL7v4Nqu2EyjOSOA7sFC86gLDYOyEiGcFyUIsewjW3XNbPAYNy2qFrgZZGofEx8pkykR40kZsU8gZzHWIqV1wxE7UkqbgJ67nq2PdXWjG09I0KdNVekMfAHsYjD7x+4POyXeeIlD/xHnELHmvgin7bVfDlAcQnoEVth3MDTaNs7PCmgGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(186006)(1800799006)(451199021)(83380400001)(66476007)(66556008)(44832011)(66946007)(6512007)(26005)(31686004)(6506007)(2616005)(53546011)(38100700002)(36756003)(2906002)(5660300002)(6486002)(478600001)(82960400001)(41300700001)(8676002)(86362001)(31696002)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q24wczk1SlFKT2FBQlFvMy9rMmZqY0oyWUY0eXZteVU5SS96VzNUd0ZvTlV5?=
 =?utf-8?B?UEtFMStGbDJkRnVnWnJhRzhoVXR1S0oxdjFtQ2k1VEZRby8wWHlSc01rNVd4?=
 =?utf-8?B?Q1FTTmN0SXFlYmdIUWxhTGI4VmszYUJkeU9EelZ6NUZCc2Y1V0NvQzNLbmkx?=
 =?utf-8?B?SnZLZVFWWUZtaGorY1oxWFFCd082RXdXL3VJU1hpbEtpVG5IVm9XTlJ5VEpD?=
 =?utf-8?B?SkEwaUg0Y1ZQZUNocFgyeDZycDhVWWVhdzFNNGp1bGphREZRLzlKYTJkeFNx?=
 =?utf-8?B?ZXZXOVpJT0RLRUtOQlRnSEdHajlZb1NwYWh5V2ZlL2VXZUFWOXd0Rm9BQmtI?=
 =?utf-8?B?MVNrSS9Lak94TjEwa2U0NGF6S1ZDaTFLb05TOVBwVWo0SmtKZGEvaUlzRFp1?=
 =?utf-8?B?RG1QbFhnemprMTk3bHdMc3pQanFSYUpuTUIwZzY0emh6WmNySnlWRXVqYVFU?=
 =?utf-8?B?RU8wbEwwS3ZRdkZ0bUx2VDFRWktlVWpTbndFTllBYnRtUmE2YmIrMHprVFh6?=
 =?utf-8?B?Z1p4aUUzRDVvOVFoUDB2TmU3c1B1V1UvWFJBSk1Zb0NGVVp1cVFkalc1Q3JX?=
 =?utf-8?B?WjdVY2FNY2FaL056ZWhmVDZ1bXdLUmFCWVZnVXVNbVBPSlRnczdxSkNXSlNh?=
 =?utf-8?B?OHZocCttNXVnbXNUdFgxWW5uNVVBcnFmUkRkWk9VY2ZRek55QmtUMkIySkhE?=
 =?utf-8?B?dFhSSW9OZ2sxb0JkaXNuck1Ebmx5LzhaTm9VVDhFSU9hazNxbis5aFh3aUlk?=
 =?utf-8?B?RDFsT0R6T01teFIwbTVqbXordFFvVHFHZzUrOUJSdmFEeWVKME9rZHI0UmlE?=
 =?utf-8?B?S3pyL25ranFBK3RiL1VzZnc2RS9sdGtmWWtjQldPWWhwSlg0UENPRmhna0Jv?=
 =?utf-8?B?Z0RPQkQ4U09SZUhibVdSaVRkNzVpUEttRC90YTkwZ2RkTzYzSERKNDFiNWZo?=
 =?utf-8?B?ZFhzaUxncHliVW84TFRGKzV6V1ZmM29RK2t6cEFINkNXUTVxZldLUkUyc1ZL?=
 =?utf-8?B?YjU4WWZPZnZTZkpIK0ozZGdzc2NsZGo0N1JQeFExTUVZM1dmc3ZoWEplVVZt?=
 =?utf-8?B?MXhUeHc1d2gvbmlNenZKbGNSallPVmpYK3R1QWRKTXZ4S1YwTTluODBGTkFh?=
 =?utf-8?B?OHNKM3dUVDlYeFJjUEpXR0N3dHRTTXllb2phQ1AyRXBmSko4OVR1RURtbFUy?=
 =?utf-8?B?ZDVUZ3RSSks5eFMyYUJzTWRkbW1aVkNQTy9wSFE4OEVSbXlKc01nRzVBZXUv?=
 =?utf-8?B?RnJjSFZ3ZnNMcHdNb092d2VJWjluUmI4R1BBbkdJNFdlZTlTMEszdGNxTzBN?=
 =?utf-8?B?SEo5WGQrbHIwWEpOdmlaWHRaM3BjRmU2WEF0S0ZoRC9yNWk3bVEvVVE1dVVE?=
 =?utf-8?B?MEErVkJHOERwUURzVHRGRnpaR2V6Q0lxT3lkSzdRSmF5Qmo4YXNRdVdCQmZN?=
 =?utf-8?B?anc5SjBHZ0RtNmNOMU0ydk5Faks2eVBBN3V5Wi96L3g2bUpVK3F6cG5LRGQ4?=
 =?utf-8?B?bkFOR1BHeE5Zb1U2MjIvc0lLdnducXQ5TDBqc05zRlhJcjc4WVJucEtOUFl5?=
 =?utf-8?B?dDMzazZXVzRrajJjNmhucHFmQXAvVXBObnpWaWlkci9oejFNOXJ5V0hjdkpK?=
 =?utf-8?B?TXJuMkFGZmdIbENKRVlMSzMvZmo1K0tLSFBRZE9IZXdyemtFNUJjZXE1eDE4?=
 =?utf-8?B?OVczenhDK0N3aEhuMjFlSXNSNXFPZ3I0MU5DdDIxaHdFZno0cUZSaGlNblQ4?=
 =?utf-8?B?aVlHdjhxSWN0WjZMdGFXVkl6M1Y2TEQxdFVyVTFESVVHL012Wmo0OHBEOHpB?=
 =?utf-8?B?YVRsVkNyekx1OVJxQlNHNDlnZjUwMlJPRVVBbVg0bVhQeHpmQi81T1JwM0FP?=
 =?utf-8?B?d1JRekZsZUV5L0c1L2RtV0tpK1JTeUJEK1ZuaDRvbXVxV0pmTDBMd2U0cUE5?=
 =?utf-8?B?V2hicFRabiswMzZuV0s5L3cxV3o5bVp1azFFTFBpQXBPSjRTeEFxR2I5Z3Ro?=
 =?utf-8?B?Sk5adlFIaFFIcW9Jc2xOWUtLcEMyOUh2S2crOVF4RjNMVFBsOG9EcTFJV0tK?=
 =?utf-8?B?cTRpSDJqcVZOb3dzQnU2cTN0MldjY1I1UndWb1c5a3cxUDJSNC9ydHVoTkRx?=
 =?utf-8?B?OFN1TldKZWNyaHhSNVVlSzloMFhaV1hUMWZmbVZDZlN1eGdOUDhEaWhjcmE4?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a506e512-0bcb-4ed7-d1d4-08db9a7c9da5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:07:01.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZMACR5lPhIg6JkUAH1pUoRQGj0G2Dh+7jwT68fobgVhEJRXyHyyC38JtHOnNpNHbdcfEkfPNJn56WRxbc8suw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6165

On 11.08.23 09:37, Florian Bezdeka wrote:
> Some parts of the testsuite use the __RT() macro to make clear that the
> Xenomai implementation is called instead of the Linux service.
> 
> Code:
>   __RT(select(...)
> 
> Result after preprocessor:
>   __cobalt_select(...)
> 
> In case y2038 support has been requested (default) by 32 bit
> applications the Xenomai select() implementation will be called instead
> of the __select64(). Catch that case and wire it up to our limited
> pselect64() implementation.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  lib/cobalt/select.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/lib/cobalt/select.c b/lib/cobalt/select.c
> index 7727012c7..d2897066b 100644
> --- a/lib/cobalt/select.c
> +++ b/lib/cobalt/select.c
> @@ -27,6 +27,20 @@ COBALT_IMPL(int, select, (int __nfds, fd_set *__restrict __readfds,
>  			  fd_set *__restrict __exceptfds,
>  			  struct timeval *__restrict __timeout))
>  {
> +#if __USE_TIME_BITS64
> +	/* Might be called by __RT(select()) only. select() - without __RT() -
> +	 * will be redirected to __select64(). Catch that special case here and
> +	 * forward it to our __select64() wrapper - which might be overwritten
> +	 * by application code.
> +	 */
> +	int __wrap___select64(int __nfds, fd_set *__restrict __readfds,
> +			      fd_set *__restrict __writefds,
> +			      fd_set *__restrict __exceptfds,
> +			      struct timeval *__restrict __timeout);
> +
> +	return __wrap___select64(__nfds, __readfds, __writefds, __exceptfds,
> +				 __timeout);

Rather than taking a real call, can't we define a symbol alias?

> +#else
>  	int err, oldtype;
>  
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, &oldtype);
> @@ -45,4 +59,5 @@ COBALT_IMPL(int, select, (int __nfds, fd_set *__restrict __readfds,
>  
>  	errno = -err;
>  	return -1;
> +#endif
>  }
> 

Jan

-- 
Siemens AG, Technology
Linux Expert Center

