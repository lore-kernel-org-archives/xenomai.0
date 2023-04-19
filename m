Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E933C34
	for <xenomai@lists.linux.dev>; Wed, 19 Apr 2023 12:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrwgHtkAyxSfYj9Wi+Qcd5mYS1l0vf8B8fIiW6lv2asu+2t+xTbNWD95wc+5ZleYcZuEeFKS5qjQ1Bm5TN0D/wZEujSL4AiZZmtWS9d9lLt63YihZcf9ZlSdo67DM5z9hI7VcVJA5o0HXlsAr/2i3PZgh1XTYwVCcVatrepaiUPzk6CIX/5Nf9yCZrZE9irkGzBxpDxW/DLzfYyQDW04aHm8lqjumOLufGki396WusnmWQ3ermV6E/1B1d/Q6qIJr4m4l5FLeq6Jd6+01ES6ufSu34b/D1BC5znIPE0KAAz3V2EDUL4xwMbR7025Qe2k6gLiGFl2gmCAxIajaTy/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0ckVUarwEx0JhLyATCyFgGCOyASWVCpDBfD5ir/ojU=;
 b=mVMMHuvdSAswsy/dC/PMP9uqEB7Thzgnjf6dDpK4/DQ4HbAkq3N75k/9NHTmvIIxbbYVcKba4cY9uDYnIzlF0q1VYy/S3z44T4lWbRv0sNHhsfD4W89WsuVXEeWrDj0TNa+zcWUrp+n+D44tUD8gJ3usGmzIViQRL2B84tKJsg/AEo0n5N4HT8F40RmuWUs2bMPwYdVXQa7RGstMDB+PeCvv/2zjSWG5ocH0eVEbS6o2Kc9dW1mq4FZZPGkym9gvpfM//49gaBfZifScHACPQc8IA2r+AnL2W0ds4NLLtkBfQuQNQYVMvhvhbrMzSsxmTFPy5L4q0ysAvMTXGORGvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0ckVUarwEx0JhLyATCyFgGCOyASWVCpDBfD5ir/ojU=;
 b=cyY1MoNTBv7yQdT9IlnUqh2HuY5tGB82nkGs6pO/DxRkrR1hv576FPBGJtWY1MSBp6bGINRgikoqRLHYVWwh6yc15as8e+2PqQvb7+iPpz9FBunZfG1bFnS5elrAzVThmULWAJt6UhJYnJsNRySL/avXt8vHcaa7u6m28EgHGOVPRb382ZEdTLBy23L9osYwa4aQUJBhuRCPw+/0f5VHG3+v7bUL6cthVm2teTLt7rTMI9jJJ853JvoOEIp7sDzO3YmjhOIS2Av1gaBSkOWBenu45OeRpX83fuHx/6aAKIyJ8TMQd3QQ3zz3cJ4ulR8zaLhQ+3Dqw82Ud54WM+QSmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:85::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.20; Wed, 19 Apr
 2023 12:40:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 12:40:29 +0000
Message-ID: <f2cae451-2af0-83fd-7b75-28ab7afd1638@siemens.com>
Date: Wed, 19 Apr 2023 14:40:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH next,stable/3.0-3.2] lib/cobalt: Fix possible fd leak in
 __map_umm
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230419080307.125787-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230419080307.125787-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0045.eurprd04.prod.outlook.com
 (2603:10a6:208:1::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6683:EE_
X-MS-Office365-Filtering-Correlation-Id: 19babacb-dfd8-474e-e210-08db40d341fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	afNwsBsthzKnjSBHH9Ak3762lYj8f2Wo5GPhsGVB3TlcQUcsxobduw1iv8xFjJgbTMmaGu05n+95E9NNXNdNBNoESJkQJYTcFvsjQmRyCPtPU71klg/xnAVRTApL5Ybb+x9vkhhwOhmblbI3fBiQThnPJTAsSpkZFHpv/oXoSfPwzEna+8YqRmyJsx6/zcjqKoXsyrfBPqyrPZR5HIxMmcAtP6CKHyHfwEzC4RKB/nta611V/k6eChwtjNZrgtZBqe8fnoJON2pKf1VWJC7rkXowAxkF9AeQg+t1G5mCC+Q1jjQM4vhVvxWm2jvhew0yQxF30LMYzax+a5UnZeUaGy3gO8+QJEGhJ9nxuU+daO33aiGM8gCQCzSQQ5mWSan2YdDrQfdNiJ6YLqaYTsh/rUB1/7VQETKbihITDkf9393XiVUqpEsn3bHOVihXe3G9F4szeFYMe4x/gHFjWtjxHyv+1EPSmf93vUHfVVyha+VRNrrbYJwDexu9CHYmmNIzvxJ8A1AZsvWM3TxNUUHIQmcumUhH6Kz2G2VjGFRkWPeY4t5AIEK9W8j+nTxyHsOOXgEKqO35FKGuxdRelMBPk6WEWmgcaUaZDA5NMEjrJdlR0SvOPA4UZJTP6Se2ghIm4DxH/MbMWfbg8AcrAl4NkQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(5660300002)(44832011)(2616005)(31696002)(53546011)(82960400001)(6512007)(26005)(186003)(86362001)(6506007)(38100700002)(8936002)(478600001)(8676002)(316002)(36756003)(6486002)(66556008)(66946007)(41300700001)(66476007)(31686004)(83380400001)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDVNN0FBaWtQeEFkMGJkOU0yRnF2d21La2tQUkxkZzIxZUVYSm5IY3JpQnU5?=
 =?utf-8?B?N3AwN1pZZkhvazVXYks0OG9nTzdXY0lreHA3NzJtT1JTKzdXT01uclRISE1a?=
 =?utf-8?B?UHcrVWI2c0tZRlpXSEd4SFBJYUZLL2R3T2hoOThiWmU3V0NicDh5aXV4L1Ba?=
 =?utf-8?B?YzZxQjM2L3FpWG1RMmpCTW9pc0VpbVlmSU03NURhZ05nOGErRno0Y3MxU3B5?=
 =?utf-8?B?MHgvN3R5ZkVKZnBtUUZqcGNqU05hdzJjeCtIZXQvRGJMNkdlNllNSGl5d013?=
 =?utf-8?B?YkNuUzdadm9sK0NnRlBBRkt2L0FHblFuV0tJSFl3NDZsVGJsQmlmZU1IVHJ3?=
 =?utf-8?B?ZDBLSUhmMldOKzhqTSs5R3FQUHNkNzJlOVhFVk1oVW5wR0RxdmF0cFA1L0Jr?=
 =?utf-8?B?MHBXQTZHNkJDZFg5Rjh1ZTZyMzIvQlNPOWtiYU1oK3ViMkc4OWxZc0JLUzBJ?=
 =?utf-8?B?a0tXUWVXZ1ZHRkxWSk1JR1hhazJubWFlblNrcVVCQUVwMDVhTEoyaEo1Zkdo?=
 =?utf-8?B?ZTI5a0oxOGQ0REJGOG1zREhuVTU0S2d5c2VKcnVWZkZyUkhyU1Q1K1pkajFR?=
 =?utf-8?B?Rm51UUc0NG03TEk1OHIrOEdxa0k4YVk0QnRGZCtpRS9MWVF1TEdpUnJJSmZU?=
 =?utf-8?B?NWQ3d0pkSGM0MU9DRFVUR1JJY09tTzJWTmlsOVA0UG94SmFoVEtzblVsMnNV?=
 =?utf-8?B?VlZWQm9GbTVJOE9LY3l2Z2FmY1BlUFlMcXAvRkJDbzkrOUliTmxLanBFUWVa?=
 =?utf-8?B?U3gxSVEyS2E4NjZSSElrUmtNNkFqMC9yeERLUjNwTldKWkVzL1NVYUIrK3pF?=
 =?utf-8?B?WDlyc0hhYWNibSttZVpUaVM5emhnNWl2aWRCdW8zRDhhZDFvNmJxZWl2MlVw?=
 =?utf-8?B?K0g3MFFzcm0vcFIzNmhCZjJRL2hwTFdXL0g0cjJpNkJlVXg1diswVWpSanRO?=
 =?utf-8?B?MXlsbml5emtrVnFFVWlBVG1zZ3FIVlRWZzF3RFBqR2tEdHFiZzlFRnZwK0Fa?=
 =?utf-8?B?R3pPbE52SG9ZaWc2UjlLdmQ2aHA4ZytnTWExMzZxWHdvYzdkNjBienRjNnpu?=
 =?utf-8?B?TCsrRlM4UzJ3aU9hRU5ZbGhUaHNsUUJHT0dJWHd3ZVkzZU1WU2JaUFVleDVX?=
 =?utf-8?B?Z1pzOURQd0gvTU5IbEdpVnk1WU05WU5BeWVYUHhsakk2VkE3SEtPZFVGZEdv?=
 =?utf-8?B?eC9STVowQTFvUkNMWnlOR3Q2VnZLZzhYQ3RJM3pYRXJNM0RnNWFxVGpCcjlD?=
 =?utf-8?B?NDdqeXU3cUJJWnhaamFBbVNNYzZya1Y1ZVJMSytFdGFCYUZvZzA1bDQ4ek5t?=
 =?utf-8?B?L2FvMmNadUFzVFpKbEsvMUQxTXZNSFdtbTd1R3Z5Z3d6Q0lpRGxmRU13OXhF?=
 =?utf-8?B?bEl5WTlRYmVvbGhCb3VjN0lZQ1hzaUVWckFCK2U4NDRBUUloenVsa3NCS2Ix?=
 =?utf-8?B?TUVjazlvcUx2QjQ3RFJZRmsvZHltZ0c3SGxSTjlwWDZRQ0ZZR2oyV0RTaTZP?=
 =?utf-8?B?Ym1EOTRrQ3ROTi9wTml4VFREMmV6TWUrV3JoVWthaWtvb29GRzgzNEc5RS85?=
 =?utf-8?B?U0tCOEVNSFMxd1BxaWFoeFYvTTZwdDZ0ckFIbk55eGRMUGpvTWVpRHNjR2gz?=
 =?utf-8?B?b2l2QW5zay9wNERTVytOaWxvenlLWTdjOUhWcWVZZ3JOOGpOOVJHSzRyNXhJ?=
 =?utf-8?B?eFhoRytPTXVlL1dNQmN1NzlZLzBpbzVDcjczRlhvM2h1R3crN0NIcjVBOEw5?=
 =?utf-8?B?TlgrSTFuUzgvNGVlQnVxM2JsbWkveG1JUXpMS2NsVnAvU2NyRFNFL1Eyc3M4?=
 =?utf-8?B?bFdqZmhOQmpjVU43Z3NDUXYxMFBsOWptWWhEb0RDelhTT3ZNUFVQNFlERUNs?=
 =?utf-8?B?K3M2akl5NGxUUHFjQXVjNkhlbGt4SDJSSFNmd0NGdlBlSkh6bThXMTB6VlYv?=
 =?utf-8?B?R2hBU0loMGVBRFlNMWwvSTUxbW9aeUpLNSt4bVZsNzNSMnM4QS8zTzhLT3c4?=
 =?utf-8?B?L0w2dGluaUZ2dG9DOUlsRkdhS3BaeGU2WXB2WXlzcEF1TkdPdWZ3UE8rWllo?=
 =?utf-8?B?alpPT3VCdWVNN3A4ck9oTERueEoyTVdXRjQvYkprS0tqZURtUDZhNXVRTDJm?=
 =?utf-8?Q?8GlHU+3JelWjw95q9tpp9L5yT?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19babacb-dfd8-474e-e210-08db40d341fd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 12:40:29.3746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JZC8JLJLHnm2hOAmZWU2HoENsHK4/YFxjDb8Tt9GwThyGBJ/gC6mLbcIU1KAM9RKs2W6+2wzGPGotD3UB1cSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6683

On 19.04.23 10:03, Florian Bezdeka wrote:
> In case the MEMDEV_RTIOC_STAT fails we have to close the file
> descriptor.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Note: This patch applies to all stable branches as well.
> 
>  lib/cobalt/umm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/cobalt/umm.c b/lib/cobalt/umm.c
> index 944620fee..c30ada6a2 100644
> --- a/lib/cobalt/umm.c
> +++ b/lib/cobalt/umm.c
> @@ -59,6 +59,7 @@ static void *__map_umm(const char *name, uint32_t *size_r)
>  
>  	ret = __RT(ioctl(fd, MEMDEV_RTIOC_STAT, &statbuf));
>  	if (ret) {
> +		__RT(close(fd));
>  		early_warning("failed getting status of %s: %s",
>  			      name, strerror(errno));
>  		return MAP_FAILED;

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

