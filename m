Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B61111
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 07:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar0h5NYmH97pgfZEVDW2ANbWdmErO7or9i6vR8Zf5eFRAG9WOt5XYLm3TglZA+vgpQy2Zh/21DB199o9rdkMl7XffbuES/e67/2ABL3C0HPs9YwANjYuEoJlh4tCmmoxC+uj40hD3E2BW5ObKmZ8RIq2zwYi0s941ZqL/J5qR9KOPXgDiJRTRXYVOAvsVLECCMHF+lIB8GW0tmk+GMV3U3BOHl10BStHq/l/P6dZ0aXBDvOvKO4TfbjW4/L7EKmhwbOnGUH1VPKt21BEFhlvPHCTAQ42kf4vHfYcVUkvcvXwwwVbEBxcvxNHLSdLKpXwL5TexKdM5WD3KXVPOUvlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfzScB3w/EshjibjPadAjvO9li1CJS2rxTaipztmt30=;
 b=P3rsOAFzEEfGTv/4FWGs1YYFdlXslNqJMf3WB5l1mcUyTJjgbSUn/SFkJij1/ktzifY8XUzEqMkTVN6VPcvl+5RVAPVkN9OTf3VYYvDnmaNIdSIzbEl34b91hpUfXK4XVcK5KE1I9Ay742dh7dRw3QCp3ceF0H4K0gr+nnyjLwu7+++tucvxBauM9ddl4AUdJHUxArLEy5shPvGPcLISntOn/CiKXvcC5DIi8x6dOUE2RdD0ZtBI8eMGmGZiHMwkxSbFCua3/X+WI7MC0wQbl8NC+qNdmlioEM4SRh2kzs7LSKHtgKIs/zcjuzl+TNdkdn29FUp42E8FjlJX3wc8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfzScB3w/EshjibjPadAjvO9li1CJS2rxTaipztmt30=;
 b=ztf/sIG0McOu3NaxXd9OF5ZHoZjSZpKYiFsYcx0RSWLCVRAzzZrlbup/B9xuh3dFT7DCKW2eL7z4EcnJipbHdxVbvkXwjBLnPbXuWY09VSG79IgOzV7NcTwiGsGsIEIq7qzdXvOUQytp22V46Xr/5rB5IvdOxJIcyfy8QpBU9v5dRXFFdInAfVQXpIWmNGl+SCzpA72lir3QsquigXXZftxTj9SzwsdBkLWslN0Zmc0+DVXM26s5ZYIbR6V71qIh0KV/OvHqk+egLIVKG5CwJUA+STKkXqnuDv40KDAE1cvwRR3B6Hk2wz5Ofo+Wu5EdrYq+1kpyKuGNGosgIrfMHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:27:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:27:33 +0000
Message-ID: <90821f88-1370-e168-6563-94ebc5143db5@siemens.com>
Date: Thu, 6 Jul 2023 09:27:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/12] y2038: testsuite/smokey/y2038: Fix reporting of
 thread return status
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v1-8-604a089542c2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-8-604a089542c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3357:EE_
X-MS-Office365-Filtering-Correlation-Id: fa02de3e-26a6-4327-7766-08db7df276fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UHISKvtb9oLjKSH8LxKIr+a9Nb6SpS3oV4SMDCw91b7m5XN/d0HpTqh2B8jAmJV7n+m0Oo5VvAABrcQk0URBivIQAr2rhfczGpBweamo056pwRggZHI1WJMZ7XzvMThmyhUwt9GsUPfa9Hi3odDqWoh8ZR6kscmrhoBgFAVE0epQMTa8/lf5JaHg6CXWPSoeetXoMyfo12SCHKknGFkjpgy8v9ZsHhBU5EVxDSPhsPIVnIPiL4me3NAkYTtGA2Gi3FRCaD0ICZM4vPzjtzsuzvGWzYkanFtqvrqxqyd0rCuWxn8m2ydrBWu6EWP7sHV0TKoLr41wCXr7FgH8ZcWd450QlhmzBXIKYWAZTLb1eYoIUGSGCYNJD+X/FBpaicLemC/lO49FfTnOSSQ+OpqdoNXfKB7YXuA8n0TxU2heLM9OZU1OAS4j2HKyA1sxWLL7evf/dPr9vG5MXUTIHH4Fhkj3t01jY5EVm4jSvIHb9M/CCD0LBJPwxA39+ppQOBMR5ySyDIADR958kNZ8fsBdWlmBLbfA6I6BbQZFUbiTdrdnKBHXO0B1LVm/zEkpxjyt/L85uAzkxOtnUvqbWCaFOwU0Ayl46n0P10bOVb4q1pTWKouKxJ27tL/Hb9fE/KraZM3j6CJ7f7aiwNkskeq7OA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(478600001)(6486002)(2616005)(83380400001)(36756003)(31696002)(86362001)(31686004)(2906002)(26005)(186003)(6506007)(66946007)(6512007)(41300700001)(53546011)(82960400001)(38100700002)(316002)(66476007)(66556008)(5660300002)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUs1MmJOdEdxTUYxWjdsbEh5cjZtSUhHVXhuc2lNSzV5TGd4eWhxVnFlaSty?=
 =?utf-8?B?OS9DdjMxbzNGVVo4aVN6NmpNV0I1SmVnVEpHSG9UUXIrSldlTmk1Y0lnWTVR?=
 =?utf-8?B?TnpvelJMb0ZpSDkvM0k4Mm9XY2VKYjg3VWJMK1k3cnNjVGJsMStDQXRiVGl6?=
 =?utf-8?B?UDZIcS9JSW93UjIzZjVXdmk5NnZkZHVFaFZMRzFGWjJGVmltb3JydGtzNU83?=
 =?utf-8?B?bG1pY3VkK05LYjFyMEl4bXkzV0JJSTRlSkd6V0NuNnZEQzd1RjlNNFRkRlBS?=
 =?utf-8?B?MGNyem9xNHVNWEhmekd4dWJTRFRwaXgvM2h1TFJtZVZMZ09JTmtjZWxRbTFJ?=
 =?utf-8?B?cVE4M0lYck8rbjZOSGJKd0ZiWm1Cc2xXYkRYMFFWeDJ1TExXeHNnUXJ0UHda?=
 =?utf-8?B?VjFEUTlUOHR1b0JaY1Fpd2Y5dUd0R1RhWWNLelZiWVR6L2ZFelJ0WlVFYWEr?=
 =?utf-8?B?eVdFWm93RHFyTnBGTndDbVpuQmlaTUZzL2U4MGVrb25NU1FKUyt4em1UMGlx?=
 =?utf-8?B?S2NaU0thZVQwb3pTbXh6YldPdXdaOFdRMk1PRERybGJ5UGtGYnFtQTIyY28x?=
 =?utf-8?B?U0RMNHRGbmd0TUJ1dWJ3aEw5aCs3K20rcDRBdTdRUVQ2Nm9EcXRrTWEyL2pJ?=
 =?utf-8?B?UWl1QUpsZ3BSVDNIQ3dGdmNGZWhnTW5RMGJoeXdYUUJzbUl5aTFUWk1Iem5N?=
 =?utf-8?B?TXBTOXk5SC9uRGRITE9XQWZlU2M2SjkrNzFKSEFlaGpjeWFNWWprSVhGci9C?=
 =?utf-8?B?bUlBNGtkVjFpa1BvWDVsS3ZkOWpsVEFhV1VjTkZCMjlZajk1aVdtZms2d0pq?=
 =?utf-8?B?Y0s0T1N4djJwSCthYlcwaG0zU1ZwbXB6cjYvK1N3ZHNGN1JtdU51bXNuMFll?=
 =?utf-8?B?SUM3eEdjOU5BUDBOU1lRaGQ0d2MzL3FNOXUramtqZll5bitzM3BkaGwvcktP?=
 =?utf-8?B?czhKZWd3OXRsaS9PSXB2dUJ4cVVmV2UwVGx2OWZubUFrYmk1ME9SZXFTNm5q?=
 =?utf-8?B?RDVMelZ6bTFQamdDeXM0SFVQMGM4ZFZYU204emprVDdwd2JiV1VpMC80WVpV?=
 =?utf-8?B?QjREQWduR1RFa0c4OUptT0hXUUJDMHhVU2M4MU1LZ2g0TDgrNzRqVmIzdjA0?=
 =?utf-8?B?RlNpNnFiOXBnRGhBZnp0RVlGaUJGemVSNEltcGVLVGNoeVEwMGRlbytndkEz?=
 =?utf-8?B?SjJ4K3hDSjN4eU44ZmI3QUdOVjZRa1IwK01NU3dlcHN0cjM2WVRraUcvSVdx?=
 =?utf-8?B?N1JJRTF0cngwSXVUQ090N2NTajZwSUhFMjZ3aU1aVElMaENJRFBhOEZNdU1Y?=
 =?utf-8?B?VlNWRnBGRzkzT3hGazlUZ3lvZ0NCZFBaWUhYTllnUnFwNzl5SGxSek4zRjZs?=
 =?utf-8?B?R1lNRjE4YlRTZ3ZpUDNCckhNTzFBRjgwOGgvWktzOUx2elhES0Q5VURreEVn?=
 =?utf-8?B?YzdqQURic01qMXdHYnNZK29nUHVJM2s3RWcyOVdKakk2VllEcHo2MXdRcFVy?=
 =?utf-8?B?RmlsdUJVR1RwdzB4L3diTGdjWjdXTWpHZHErSUJpMnY0SlNWOWFuTjAvdGd2?=
 =?utf-8?B?M0E3V29BbGFGZWlTWnlUQ1UrRWQyZkVyOTVsbFFCcUFienJIb3hFU3VqUmxa?=
 =?utf-8?B?b0JocDVlMHE4K2UrMUtiQWV6QjRCaDlIK1JQbzhHMGo0S1M4RXM1OXI3ZGd2?=
 =?utf-8?B?c2hTVm5SQUg4TlpucDBMMGFMa2xEWmtZK1J5K2JKcVphNjNjK2VWYlhLdWM1?=
 =?utf-8?B?aGJQRXh6ZXBmZjhFcnlPbWV5b3pIZHlsS0lneEF4M0lWZW1tbmxFK2N6VGZj?=
 =?utf-8?B?aHR3NlJsVjlLdWFjMzQ2ZWdJN1dtUnQvVHh5TTFYVXpnZTlPeVVxZHkvRWZi?=
 =?utf-8?B?L3RuOEE2djlYRXJCYUd4ZXp0VjZTaHRFUng0bGg1djRtSElqTlVCMk1GMEg2?=
 =?utf-8?B?Ti9LeXFCNjdWdll4MXIwTUxiS0dSclJicElVNnVDdTd6aFgwQllXU01obkJj?=
 =?utf-8?B?N055ZktNOTdlRE5hYTVKZUhBRHdtL1hhTU52VURiVlRwd0l1K0s1Sjgwa2lq?=
 =?utf-8?B?RlVOU2h1YnNPVVhNZVFoMnBwcTkreXBJdHJsLzk3ZnBoWXJlaW5pVzVtbStx?=
 =?utf-8?B?VmRXZ0MrVnZMN3NLYnYvYjlKc3oyZGh6WmZwMk5mS3pQNmZmRHA3c1hpdG52?=
 =?utf-8?B?TEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa02de3e-26a6-4327-7766-08db7df276fa
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:27:33.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wm7LyiLrLkNJvto4xDGU6CASldcbsGNj/WjJv0gJCQxCYmp2mBXRjLuRJou+K2L9q3E5W8jshqtnA0oyIfiDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3357

On 05.07.23 08:38, Florian Bezdeka wrote:
> run_thread was not reporting back the thread exit status but the result
> of pthread_join, which is normally a success, even if the thread itself
> was not successful.
> 
> That revealed some wrong exit status checks inside the y2038 tests.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index af27f2bce..d5ab2e8b1 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -155,7 +155,7 @@ static int run_thread(void *(*thread)(void *), void *arg, int exp_result)
>  
>  	res = (long)status;
>  
> -	return (res == exp_result) ? 0 : ret;
> +	return (res == exp_result) ? 0 : res;
>  }
>  
>  static int test_sc_cobalt_sem_timedwait64(void)
> @@ -528,13 +528,13 @@ static int test_sc_cobalt_mutex_timedlock64(void)
>  		return ret;
>  
>  	/*
> -	 * mutex still locked, second thread has to fail with -EINVAL when
> +	 * mutex still locked, second thread has to fail with -EFAULT when
>  	 * submitting NULL as timeout
>  	 */
>  	ctx.sc_nr = sc_nr;
>  	ctx.mutex = &mutex;
>  	ctx.ts = NULL;
> -	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EINVAL)))
> +	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EFAULT)))
>  		return ret;
>  
>  	/*
> @@ -546,12 +546,12 @@ static int test_sc_cobalt_mutex_timedlock64(void)
>  		return ret;
>  
>  	/*
> -	 * mutex still locked, second thread has to fail with -EFAULT when
> +	 * mutex still locked, second thread has to fail with -EINVAL when
>  	 * submitting an invalid timeout (while the address is valid)
>  	 */
>  	ts64.tv_sec = -1;
>  	ctx.ts = &ts64;
> -	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EFAULT)))
> +	if (!__T(ret, run_thread(timedlock64_thread, &ctx, -EINVAL)))
>  		return ret;
>  
>  	/*
> 

Applying this to next as well already.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

