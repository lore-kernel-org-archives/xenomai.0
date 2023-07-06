Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE7137C
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 07:27:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiUrdnR7+2Xo6dhf0pfxypPHjOA3i8gFgd9mIyKRiaGCuxt1aS1OQ06x0n+U4+w1nvTCT75pSGj5kfW381PW0CnlLkD5QpEGb7215vsUmPKyLzWMv7xMix+1jHC3MWM/OQZUi2tV+SikxPxvfoSW3cD/eDBwfvj3/GYbr1zwKCTEmN0f+UGlgWjXK3/H/OaQvrqgRuS19kMaL1uHBFpxv9rQaTFE1J5Ca+KojHG89PgowyG3WPuplZ8Hy3g3lhlXx8gtzy6P/aJgE6BVjxRuCMe1pdv8QSA8UxuEx7sjZ4TaimN+1VjGaInBnLQfveMFf5tbi5sNLYt2JRyecaUbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zl8dEFNsa2gejH3f/Lghg1Gd02pIc7sKZf6nezo/SOk=;
 b=K3eNI3F2DlyTIRQOsB84GhmJp7ivVBnWSfHIYFTQ3eY4oLeJc2LY43mex4tUHGmfszO88DqRKBKfNSd4wk/LmczI/srEoka3DWXlAw+dTATjDKP7FvDFShkXW9plWz+seWVbfjKtew9D0SLx+HlUY1+FHRqz7PM/y2l2ajulWyxmmSE3vSIXU4fDh3QGqUcCBr2bEZ6ZtnIMCDn7je7pBLbgK6nxIH36saC232GEcXWRuKhesLWopiFjxeozYQhxXUi+RL6A776q9UyMIDfHkjEQeAvDIDyIynnkiIVd10JkbSPPZ8YD9/iL8Ds3Ww/r9GZrP2r4zaNSaMuPAG1+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zl8dEFNsa2gejH3f/Lghg1Gd02pIc7sKZf6nezo/SOk=;
 b=zP+mLvXqyU7/DPS+jeBp2jV9VpP6tVYceLwuXaSZPd+erw3xqdiI2M262IZ1PpmDqhgGpQLVgstu4E60Muo6ixdPy6v6wBERmqCz3GeRLYRIAL53TuPmNK+xWx6zepHzgYmF/inv4D+qmHDh7KBXlkJwvU/RB4YwotQ4wDG4N7LqeKaTKqmo5gF1PrAeO7R33v2mA+c2mF8NuJ8XdUBaljvCqCkWA1rbbUDLi6uB5OIHzrcm5w8CcZRPYl+CU/8CnYNRW7UtmhjCTckJIZwI0oweraLu02q8u4CZeQXwjliBEfbjJxxnzoKJfeqcUik8itb+NFs8dgG0pQaamJP4mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:27:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:27:42 +0000
Message-ID: <310abe19-450f-c70e-f75d-30f3c7ce4904@siemens.com>
Date: Thu, 6 Jul 2023 09:27:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 11/12] y2038: testsuite/smokey/y2038: Fix normalization of
 struct xn_timespec64
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v1-11-604a089542c2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-11-604a089542c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3357:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dc74f6-dbf9-4b0b-3807-08db7df27c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RwYoFlp9/bI4phzYxOwOf2kJ9a8B9GvGARk2oT7inWkJhFU2bFo3U2/2RE8FIlS+XQqX/SF2nF6dVBKGpwc5KOGfNFO18MvOexcT9GDjXZfSObKUci+AgyytznrSvc+voZRN+hXOPBVEv17ePOEpDk3ID9tBl8CCJryULU3n4lY0HwSPZ6nVvdpVB1qvA30FNpGRifjgtkE1Ug+HVwBxllOHlP9X7R2gew4UfvvR6zIrknHSECTE0PZ07x3BbxAQ3QGXHiuKCp6QJgiyizpw/DXnrnpNpzqoIktoIhdpc7r6dBt7d1wmL4o/AdTkYaspr11NB/WHNEqDGCzeJoQYQM/EXh9/kwEYaEvmzQlAyBUJ8zVJnvzKfcaY9+O9TqHRy2QpvhFV217PcwWPf7KIBRd5N19cKuBXSOf8R67fW5BCdt+tn02qugs3JG0mhEwK7oGfCTT/MwikD3aSVN5l50EICOys4GIlgM3IPvWvJJp8OOLY+Ik6yiGEsrA3QfqbpNKI+USeptFs7VBQA85LY6C7qSEthYHwCK4KK36Cd6XNE+eoJyfOS0F1D1i2WaDYmC0PSpub+OURQ+zsuxAMNZ2THSWVuHuxdHUdSJisokThkRNnXGWUEnudMnbaUaqnc3GkHI+R9UkocG9Y9DwIiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(478600001)(6486002)(2616005)(83380400001)(36756003)(31696002)(86362001)(31686004)(2906002)(4744005)(26005)(186003)(6506007)(66946007)(6512007)(41300700001)(53546011)(82960400001)(38100700002)(316002)(66476007)(66556008)(5660300002)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTJybzR5d0dYUzNHVDU0V3hGY05WNm4yZG1aTWpCaWZFaGhmT0NTZEpITGNX?=
 =?utf-8?B?Y3BXdUYxYk1OdzFrRDdvdnZUNGlGVkkzdklwVUZtVjFIWVM4OTV3dEhpODlV?=
 =?utf-8?B?d1I2WFJwY1RGOUVzWG11NjEvZEFQMkdlYUJEcUVRYXlKai83Q01sS2pvYlN2?=
 =?utf-8?B?U3BXL3ByOTdCaTVPalV1WGIvaDhUaVV1VHR4M2FwbHJ4d3QzUFljYzExeElv?=
 =?utf-8?B?a3JEdHR2VEw3R3B1eTB6OExtWU0wYjltU3Eyc2R5NTBjYXR1dktqT0ptZUJT?=
 =?utf-8?B?azdSNnhhVmZJeW5ZRnVWVGR0RkI5TS90d1B6bVNOZGlyYlhCbVpJMStxUjdq?=
 =?utf-8?B?c2NVQWgrU28zZ3NFYXEzSzFmN0t6eUVQTk5mQ3JUbUsxV2gra2NKSHJ2Y0Zq?=
 =?utf-8?B?bmxKWWhYMFNzcmhZNDBRc1JpMTBEQW8xUUg2UFM3Z0tyeVU4K1NuTGV5cmRY?=
 =?utf-8?B?d3hnYW9HM21xMzhkTGlWckdRZDBzY21ac1oyeG5mbTArS2tHQkhjMWxKeDU4?=
 =?utf-8?B?ZnpEcUd5bmZvUi9iOXdCSzYvV1NSSkgya0lyc1pIYUc5cXJiL0Z6QnROUkZz?=
 =?utf-8?B?aWxTOUFXOUZmN3U4UXgyYldWbEh4dUh4Yk44NDhNVW9Na3MvM3BQWGI1MXZS?=
 =?utf-8?B?N045cUdNZnBBYUVXWHR6dVhWb3lRYlJJbGhEaVdjRUZwNXo4RTRNcDExQ1ZZ?=
 =?utf-8?B?TmJWd1p3OVZQclljbXN5eHBZYWpkaERsbjJnVUZGSGN6dDlLNlRXQUNtU0xS?=
 =?utf-8?B?UU13dVFRbE54dWlzTmV1TDBHUHpFMFI3OURnTWFnZDhhemR1THNxYzJyMDNW?=
 =?utf-8?B?S3VsT1lySEJMV0JNNGswTFBxdE5VNWlORUJHWlpIYnppVHVNckkvNHlHWThO?=
 =?utf-8?B?Njh4YldVZjFZazAxbGVqMlRxMjlRa2xtSFV2Y1lQeU10N08xeks3VVptV0VQ?=
 =?utf-8?B?bFBqdU5OZ09ZM05LOHBkYWp4dFRhSnRVSkFYc01GVm9qWDJaWFVpaVdSdUN5?=
 =?utf-8?B?Q3UyVkJzdXBpNkFRUnVhV3V4TDB3NEZucjhuNzZPMjJNV0M2Tll3Vmp0VnYv?=
 =?utf-8?B?WVFsTTVJRG1nV0NwSEcrTlFhakVjNGhXbVFlekxJRXhMM0V3S0NHanNCWmNS?=
 =?utf-8?B?OXYwRENJajdWZ3FLanczSEhncVgrUmRVRDUwSWloMEJ0bWFWR2l1RSt4M1FQ?=
 =?utf-8?B?NHRYYkNTRldFcVJUM0JuNGVTdDNJNk9iTk1aQTZ5bDhDZDdaMXpDdmxyT1hY?=
 =?utf-8?B?MjdtT2FwMG1ZQlIyb0VEc0pFUEs0OU5FMTVobWViZytUdUtoeUpQMk9ENU45?=
 =?utf-8?B?cjdyY2o3Wm5WWGk4Y2d6a1J6c2kyQldWMmpubG5DUFZVZ3JMVmhhQnZnRE1I?=
 =?utf-8?B?aVdHNGxzcTlra3pBK2dWRnBibmZYWmcxRnJHR1ZSZit4OTdieW9lSnVvZElJ?=
 =?utf-8?B?aWRObmdiNGJTWFZLVkxKK0orc2pUejYrVE1TUnZsaWJmR3F1QUVxWmtzWXVS?=
 =?utf-8?B?b3g0aldiVVRDSnIvbEdjYVVGY3VNRzlXMGtRVWtBYkJzbXFoNkRSSVlGTDBN?=
 =?utf-8?B?VU9iaXlyVCtxaVBnUWJTc3hrR05wMFhFOExQYWgvVDM4KzRNaTJJN2lwdlBh?=
 =?utf-8?B?d2o2Z2ZiRFNueTZrU3h1ZDJhYmRpc21GcXpsV0dWWGUvSXlCeStTQmJIVytl?=
 =?utf-8?B?am9BSWkxVTI0SzgvbVFYTFMvbENuZkVxQXpCV0s3dVE4ckhZbFFZa1l0Z0s3?=
 =?utf-8?B?Q09ncFlnRkk1TzlxQ2dJQnRwOUt1NWN6SkhuRngzcjFIcEE3TTJzYlYxYkNR?=
 =?utf-8?B?TWpoWE1UMVdEWHBaU0o0V0FiWEhQeXNvdDlkZ2FuRVRFdk0rSEIwK1NJV1ll?=
 =?utf-8?B?b2xuNi8vSC9mb3FrWm5WQktIMjZHb2pFcFNLa0FNVzhHU0hNdTBoeFdZbU9F?=
 =?utf-8?B?Z21VanBseWNQanozUmpNM0JEUnluNU8zajR4czNkNUo0RHdVckR4SStvRi8w?=
 =?utf-8?B?blFuYzFjN2pud0lUVWgxcW5EOHhuaVRGeEhXaWQwbld5K2o2a1VMUGtwa1NR?=
 =?utf-8?B?TUFNYXA0aHpReWdLd1Fta1lTcDcycHQrV0wvSHVHeDlBUEVBeGRlbEg0dC83?=
 =?utf-8?B?cWdEOHpJY0J2UWpiMzhIWncyaFdKN3NqeWI2Q0ZvREExNjBUSlNwS3BHUE9J?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dc74f6-dbf9-4b0b-3807-08db7df27c49
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:27:42.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eigWjLvkPnYVMnOHfXMIsbFhB+X/JhGLqkTUcnUrcpJ+GWe79avLJEEd/5kXTyNIFHMJlK21tBcP2M2kUciWPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3357

On 05.07.23 08:38, Florian Bezdeka wrote:
> We have to increment the seconds if the nanosecond field got too big.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/y2038/syscall-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
> index 0ee0bc48c..0b908f3ac 100644
> --- a/testsuite/smokey/y2038/syscall-tests.c
> +++ b/testsuite/smokey/y2038/syscall-tests.c
> @@ -69,7 +69,7 @@ struct xn_timex64 {
>  static void ts_normalise(struct xn_timespec64 *ts)
>  {
>  	while (ts->tv_nsec >= NSEC_PER_SEC) {
> -		ts->tv_nsec += 1;
> +		ts->tv_sec += 1;
>  		ts->tv_nsec -= NSEC_PER_SEC;
>  	}
>  
> 

...and applying this.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

