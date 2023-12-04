Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2A23759
	for <xenomai@lists.linux.dev>; Mon,  4 Dec 2023 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GaRA6qDd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+oayo6ADkCnN/VwFY28wAgdgL5iWQba4gs2m9JGnS/Qd3YTAQMrNLoyfDm75YRi5HINXvDzQPloU4UZUTOfB/2eaXAgRhpfGEsrWxqp7cj5CaNbDPGWM76gQK0F0zgxGzdrex9yq5ir7rkdqbmmEn0fuwBauJFnztzKcj7akK06dV9R6/K8ZIQM1yVBHg6JUUMWuFZnCbAYrDA0d64OrD6ertslyykCso9HwGYT/q7LvgBvlkYCAuH1sdETlgXv9ovQdWyu1asbMo5IXOob5t0e8HZfDTRzUEDfb5UZizCAZzwzoqE48SmsP1setbKAx388jbkwlWNoG0+a6KWTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ip/C670pNiHljsAOc8OZXzZ6M79w5TvL8+EGEna1uU=;
 b=NnwTrs5ByWwvBA5+TKKadiAihkEjk5MWoFAzsuEj2GO3DH7bACkGw3E171NH+s5OuO2Olpy4JjUE1zJLwpi139v3PWa3CGa12VKHNmBQZUzNL3s6OuUjTqa6jRVKBn0AeY+H4lqP9m0IVfPN4UCNobtG4fjq+6Ug+jaiSC5M3RHKDNjoKxpKrcF2gShYlIo6V/8hKk6g2Zqd444vZTT0bba6Yh4rJALorMylCnv/aFD2H8KN4zgUiNU9k7nXzweuUlFHhO8k1qFMqEXecRWyIi7nqvZZK5VmiupQiUZO6YgUe0isMV+PwwPpr2TvDno5GJDmdVTL8cQBZFpT6xMNFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ip/C670pNiHljsAOc8OZXzZ6M79w5TvL8+EGEna1uU=;
 b=GaRA6qDd2uWgErfXmkbPMHrcwkfNmhdclxvZChAD69SkLYmA9ztlMv/B5vwSMzcyNDUMeSWkqmTNtqoDpdSDgvIGri/47JbXOU4tZ737Kl0CL8HTSYlOrsq89cBNg1741wS0oJHUK8bQNqp5Jrl5K2vQhlBZwBRnhOj4tPwFws9ycPf1W5NTWHgMjsLdQjwmp/g0sVRTOYMG72h3aKx1+AIbsJJneKGVFlicRgwcyN90z5KnAqhymvmHCdNV33pQegoXSQd3skJsj+4U3f6lvxXGsbymI9KkfvtWw++JvM8ieWKQ+MRZWNO/E6u4ysVPpG4yRsUNWkcc900YLVeufw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB8035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 12:52:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 12:52:53 +0000
Message-ID: <e0089ecf-a597-49e8-8186-9944101260f8@siemens.com>
Date: Mon, 4 Dec 2023 21:52:48 +0900
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/psos/task.c: fix build with gcc >= 12 and -Ofast
Content-Language: en-US
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>, xenomai@lists.linux.dev
References: <20231204083935.629619-1-fontaine.fabrice@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231204083935.629619-1-fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0298.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 9819da57-c43c-4173-833a-08dbf4c7edf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vvTKGb/HFuEKsK69/PM9XBPvy3IBeUTCoMsJqewfZQ1Ck/5y+s26X4mqKbKfsRu73WIDXLtDTFoB9y2TNAZrFjcD8OoTnUKh7wfISH97dLoa4wotg0zYNo/624V0rGv0+fPxhIHUWm1o7QX7h7a5yXqFJ4En9S42xUS8keBGLz/XdhjxSimiQKAcd8pZ/kzrs1wGpqmHCwqLwonSplyYN974dJ/jo4swN9K22w220g3GKBFgMyG/qbNKBcvOGGwb3jTDcMAqo0MutbgiwHyt83frYaB1L3obB/I7cgOTjOn2QtXO52jqH3Azp5mz0jN//cEQt9NVVIC/vDuOe4sWEPWRQOMK2LX0jIpqDLPl1wHLT0RJtXeWgY2880ouCYF2YWVa724Rd2l2pyF/MnVV66LPi+KMzX85rRRrivYqnhJXHt9jHScTNu6A0dk9j6qDC5vOHoXGUtIlJcaAVE+qjHgfS0S+1huZnwz09iRKQfdox/LQWVLALJNptSRk4NSs7XJNM4DcKxeR9xpX524zz1UZWphOj1Oz+FDb7t+7P8Nys65de2eJg2uIUaYDmwRRFtcA9ZMefqmTWF9ik2WQyAfwjwRa4wOLTdIWskvSat+DyOAdESdw1uzyz+8w6NGHVeC0bX/r7s6bWaQ8HvrewQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(966005)(478600001)(83380400001)(6486002)(6666004)(6512007)(6506007)(53546011)(82960400001)(36756003)(2616005)(316002)(66476007)(66946007)(66556008)(31686004)(38100700002)(5660300002)(86362001)(8936002)(8676002)(2906002)(44832011)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVVFMzNXaE5rYUVYbEo0QzYxdmlJTC92SDRMOHlMQkJlMGpzaldvTWVPM1lt?=
 =?utf-8?B?dlZvM2tHTmNXU2IzTmJkbTdBMGhuQVc4aEx1M1F1aHNpVUhuQmNkL21KVFJO?=
 =?utf-8?B?Q2lTWFZFWmhObUVhMStHWXQzaTdwZ0d4VVhMOWliQVlNTVBrN0ZZZzBheURz?=
 =?utf-8?B?ZERmOVRMS1RIWitiUjFPUlprVTFJbUxxVTRXRUxKT0tjRW5mSU50dHo0K1NX?=
 =?utf-8?B?RXJMSG5EK21xZ0hSLytqd0hvWkllajRNczQvOW53ZlF5QjRWZkZNYWNYZ2wy?=
 =?utf-8?B?c0JXSS9PbFRsWGJjdk1jV3dkZHNORmJ6bzloMVFSSmQwQktobUM4dXQyQmdp?=
 =?utf-8?B?cFN1SUJCTUM5SnFyZkJ6YXJOQnlzeVB0eFg5T1RTY1lSMTZNVHEzQlA1YWhQ?=
 =?utf-8?B?dEpDZkdWbC9qRjRpUnBpd2xEZjVSNzdScVE5Z2Q1UG1CS3Vka0t0Y0dXS0dW?=
 =?utf-8?B?SWU4RjZhR0k2OGlmamtTOVdJa2Z1OW16ME1QakwvZURtdld4K1J0VzUvcHdl?=
 =?utf-8?B?SU1kbUkwM2RtMjl4bHNJTXI5S3FBN1lPVTNqcHN4UitCdUNDa0pveDJUeFF1?=
 =?utf-8?B?VU5keXdOQVhnbThHNllUTFpIUFRFMDlycXNCdnZuRUtYZm1RTUUrYmxuUmJ5?=
 =?utf-8?B?RkQzRUFXMkpMTDNhOWEvdVEzM1JmSEdXMlpmUVR2YkJJZzBhN3V1aDd1Q2cr?=
 =?utf-8?B?YXdGaXJud0F3S1VuSXZUVC9rN1h2YldhbGpZc3RUK0oxWVo1T3F6UWpBdVJN?=
 =?utf-8?B?YzQxamV2ZlowUS9kRGVrRWI2Sk83Q2s5bmkyYVYyMVF1VUdkMDJEQ3B2S3hp?=
 =?utf-8?B?SXFwb3lleHBpTXVWZFdoVXpkSUxka0xHdHJidnNOT2NXNzdoQ1AyOGo5U0c1?=
 =?utf-8?B?THI5ZXU3emE0bUJ2d1Y5eldvd0lqeXllUTFWY0dNUjBWNFhoNTFyalBPeVFF?=
 =?utf-8?B?WnhlMWFDOGh1SGdxVkk5amdkdkdGN2RzQWxwWm52REcyR01mWEhORW5iRVpa?=
 =?utf-8?B?Qk5wM1JMdWpTUjl6MVA3eFl3c01qY0JKZWJVaFJFSzM1cTUvM3BvYXR5dUR4?=
 =?utf-8?B?NlR6eDhPZS9uU3pialBQVWlwa3hXNTcwYXQ5YkNqZ291UktLY2RmdisycVQx?=
 =?utf-8?B?WkFxVlVsa3cwNnE3ZTN3em9KSmdoT2xyMWNCTHBhVXNPQXl5NmZXWm5wbXlm?=
 =?utf-8?B?bGIvVjU5WEIvejdDazNuN3FOakVlMlF5MEhXems3K2FsbCtQek1jZ1JtTGRJ?=
 =?utf-8?B?clhUSTkxRkEyWEZvajh6YUg1VThyYmVvKzBkNTRFTkdRNmtzT2lVSEJQc0xC?=
 =?utf-8?B?dFZQWVlncGtVeHVQZWxUeS8wRy9ydEVJbXAxc0FwQzNDTXF6TnRJYUJDTmg1?=
 =?utf-8?B?Wms2MkJjTlpNN0x2ZDdMOXl4Z3E5Ri9ZSUV1RVdzVzFsRHgxNHZqT2RNOEkw?=
 =?utf-8?B?ZWVDZ1BTZDB2Yjd4Skl6OUtzZE5DRVpzVlZNdi9lblV4VUdmMkRodUMvemE1?=
 =?utf-8?B?R3FwMDBpSnRLZ2tsTVFmS1ZESG9NeXJPOXNZckdIQTBhNk4vTWhIelZvcEhu?=
 =?utf-8?B?T09nV0xDNU1BLzJNVnp4V3grOXB1UU5ETU04RjBlb08yam1nTVgzWlVUZEdz?=
 =?utf-8?B?djhhMDJrMkFMdFI5WFM2RjJoME1QbVQ3d0tIOGVPaDJEbVNVeXBXbE00bUJU?=
 =?utf-8?B?MXpoY3FXZXlEdFNuYWEwd1VpbzhQcktQS3QyOGRtL0RWbUFuWkhyaEFlTGsz?=
 =?utf-8?B?cEhuTlNOTnJXQmlzZU95dzZENVNLNXh6blcvcWZoOHJNR2JRNmljTitOdjZJ?=
 =?utf-8?B?ZHBKZVI4c0pJd0xwYStaTXM5Sjl0VVZXb3gzVFQ5akxrdVkrK3R2alZ4aVdC?=
 =?utf-8?B?bCt6Z2RwelpMN085aFNRYVBwazVBZFZBc2UrLzRaanM3VDlWdnlhbkVDeDYx?=
 =?utf-8?B?YVhrQU91N2dqbFRsQitnZU94WitkQllXcmlKK2thQnZLei9NME80ZDNYY2Rj?=
 =?utf-8?B?NE55TnlZL240Zm5wY2lreTJRUURvMVZESFVkZUs4eCtKSkZaUGFUSDExU2Nw?=
 =?utf-8?B?N1RVUnI5UWZDV1ljaWRKa1YyTE5RL2o3NHdwOVFMWlh5UUhSME5jK3hXV29X?=
 =?utf-8?B?Z0crOHhXbmROQUlzdnJlVXp4QklKWDNmbjhlYWNFM0V6ZTJURmlvd0p0RTRa?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9819da57-c43c-4173-833a-08dbf4c7edf8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 12:52:53.5328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZsS4O2ZwbbkUDieD2tm2yMv1Gp2ysCzo5UdXo0wA/xqYrkqiDgTe7bAphZqdqaxg9GV7YM3Q24EVV8qFpU9ZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB8035

On 04.12.23 16:39, Fabrice Fontaine wrote:
> Fix the following build failure with gcc >= 12 and -Ofast (found by
> buildroot autobuilders on xenomai 3.0.10 [1]):
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
> [1] http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20b6bf4d1f73a6ed8a
> 
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
> ---
> Changes v2 -> v3 (after review of Jan Kiszka and Florian Bezdeka):
>  - Move ERR_OBJDEL to get_psos_task
>  - Update commit message to mention -Ofast and xenomai 3.0.10
> 
> Changes v1 -> v2 (after review of Jan Kiszka):
>  - Replace SUCCESS by ERR_OBJDEL
> 
>  lib/psos/task.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/psos/task.c b/lib/psos/task.c
> index f678be61d..b5cd087e4 100644
> --- a/lib/psos/task.c
> +++ b/lib/psos/task.c
> @@ -99,6 +99,7 @@ static struct psos_task *find_psos_task_or_self(u_long tid, int *err_r)
>  
>  struct psos_task *get_psos_task(u_long tid, int *err_r)
>  {
> +	*err_r = ERR_OBJDEL;
>  	struct psos_task *task = find_psos_task(tid, err_r);
>  
>  	/*

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

