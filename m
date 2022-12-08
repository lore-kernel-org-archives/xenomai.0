Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7702F3D
	for <xenomai@lists.linux.dev>; Thu,  8 Dec 2022 13:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XO4vRJ5eS6DRtBDzqz1NZEqO8V88UQZKMufkL+fE/f6mJtW/GL7inQ3oc9/mqzH/qcoms5339KxpVGoMPRS4VjQbjC7jda24Cy+Wwtfq231NyED6ZfBq/JhWv/vS7Ni8Yokqr2MLAOHOTu6HkwyWHPLRdbDZIzU3nEc8mxenbwNV7dvQxMlMH7zoHyuumlAErg6SVzoAC3h7wyuxhoUoaeA9qyoYlLRvOSUztTwRvC4O8IY2tzRosJQbsH4qavfP1672sELyXVfkyBRmQzKGbtG5DGwGER4PrqftVsZelNcaVh8IIO0uC4LaOBwzMFiE4+B9VgOfKOqwat5NCKevLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnJhfhCtFNKdC2nVRrupWvpuN7Hs7I+gps4dvTyv9vU=;
 b=U6d1kojhYjTSkO/ONkIIrrhcsiRmUPiSSNSXKpyd0VI61GmspKVIg4U1ROkWWmnA1gdl44Cye5RTIogbN16RvnBCHWmCAi1Z/9Uy9LXOVQ+FQScDeClNEsWhlV/eMnOo4VuzyyTQDhjcx42VPSMeN4yrQnFt3vuUwFYR4Xx+NTilEipvZ61QmrKbGKvi1+nOssBxN7a0/ugV4W05NohNN6fw4myanD+ra6EoGWfohtQQwc0MKFIz+NSclPuYqOw6L77xFpq9SJMerE7/UEhp1ngd9iTT/k4vgrAOk+r78qLOQF4mEyDp6Rj6s14nYNz/o1/gKqseuHMzNH/uOYlJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnJhfhCtFNKdC2nVRrupWvpuN7Hs7I+gps4dvTyv9vU=;
 b=LjsiRx++b59xjXkcgeYFSG8crN+MA+F6BK/cuekWPbZJXDC2mnkj5dJ1k6XFX3V26ApYbR9CUNmG458wCYUFjHOnC38JZ2Q2vp0ACbDlXkN3wwWbMQi2e7a3YFWcokfBxOEJss+7OkUa8v0+5aEIbL/Rm/WJQYA9oTpovLPimrD/OZnNoJosvTyVnb1KWsaj5YaQVIOGONKiuMZr0oAXUgbx9GrAdwcUUDm6eEYN1axN6UAT/czGS9WIt4tKv3sirpdlPs5oyBPTzKKA6SKd5xMJxMEwZGoZqJO+7yFAHSCg6W2gZbWcRN2e+8W4G9Zf8A/gUvsSLbuozs/JqrOqrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 13:49:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 13:49:41 +0000
Message-ID: <d5bb587b-39ef-d2b5-7dcd-79e6543fe5bf@siemens.com>
Date: Thu, 8 Dec 2022 14:49:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] switchtest: split the set_mode method
Content-Language: en-US
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
 <20221205152104.3555474-2-tobias.schaffner@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221205152104.3555474-2-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 076f1a4f-864e-4ebb-310c-08dad9230e57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L8YrzYHrRWdsrLUJotzkvwIjKVwc6fYktiIxtBmTU0QosD6IXa/q44kiwPKdvQ5v6r7+vwxBVx7xxt8RqZj6tmn7EcfQ/27v+PYTJoGIhdnhg0Q6CpPs1gTjgWiyCOC9ODO26p+lX5kfe3f4tIk1y5uT/SZopORQ8G6VpAlhCQgzoChSzczUngFBsebvsjOqNz1Sc5MwhMN3/Egp/r+dshTmCcv3ycFlqBz+hnZzI3L3u/net85VzOTpt5toNmA0qbVftim6uQViVETW6JvPwpLICGeM2LqOajoA7J+F8enU479KNdMsPz4VcCTGcP9DDnuLffhY8sShRHdQaWgQj/BfiLp/+S9tFaAB4Su2jrhP3OkXuwaxz5Rovrh0XBX+a4h5GCslEoPdZfhqNT2tIhzezcmawQlxYIBhABRMfGWw3LIovYX+ouIb3IpqelurxTBMXDTN0+mOXD14wjJhcDBtLkTObQLu8It8wTEq3M4rNVC7D9mfRYqT4hOVJ3uV6VMIVTllDfpQINyQZOmv3KNw7fnBrpCXvuRpYdsNc0IPKmJKPvycZUIN8FT9aK3AJXwHjPt7NN8KPGlexAbp4fMzfcgd2fowtWMt29rkoyw4Y56H27xohsdtSnnDRuVi1Z6CrGv1i2uUkgq3JolIhl0KBEM7qCziWd8qY6we0brttnEhQVn0cRxe/j3j5p/yP1uZ9ArfDSVMzp52ZBgeYjiibHUs1cPDci97lZaiG1A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(451199015)(5660300002)(2906002)(31686004)(41300700001)(316002)(8676002)(4326008)(44832011)(66476007)(66946007)(8936002)(66556008)(83380400001)(26005)(478600001)(36756003)(107886003)(6486002)(6506007)(53546011)(6512007)(2616005)(186003)(38100700002)(86362001)(31696002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTQ0c2c4RXZzeXBKZkxTT0xlMi9EUkdha2cyRWYyUkk2YlUwWlhjb1creENM?=
 =?utf-8?B?eGhZejRJV2IxKzAwOFJrQ2JNRzNsVGo0YTZSV2F5M2RPKytUWHc2dnpuVStk?=
 =?utf-8?B?a2p1Uk1UZkRrMHNTN0kzanFDbGVxK1c0K0h0S2JiUE4yd2RIekFaUGhVdmdT?=
 =?utf-8?B?MU5GYkltOUU0bXVUcWNDY3JJejhUL3RNVGYvQUgvUHRlOGo0cDZ5OEdmckd3?=
 =?utf-8?B?cmF6aEgrZ0NwNVFuV1BPN2FpZ29HYlZuTTVJWWdiUTA2R0hmNXV5b1hEMWRD?=
 =?utf-8?B?dDVZT2pMQjlVUzZrcjY2ZDZzSlVKUVowUDBnaCtoZ2w2eUh6SFNRWUNESjZ5?=
 =?utf-8?B?STNBaHBnUDF3TXk2bkFKRVU2SERYMW5LODhlUWl4dEJ2N2pQbXdqVDFpbGFr?=
 =?utf-8?B?SWtGNjJGcWRKMWw1RzBoZXZRekVNQ2VPTmlQTW5GTE1LbGIwUnJVeEEvMTJj?=
 =?utf-8?B?b0RaM09NS3ZhTWxoV2JoTUdTTC9LVjY5N1pSTWFJeFRnS21zMDl2alJoNndy?=
 =?utf-8?B?cHhiZHUyampoRnQ3eUJnLzloazNWVDNGeXQySS9FRE9KajZUUmUvZnRpZVNF?=
 =?utf-8?B?aDIycmhVcGo2VEZSMVpUNmV2bGptRnNGYTVacHVBbnNrMWk4L0NrUE5ZUW1B?=
 =?utf-8?B?LzkxV2xaYzUydmJOTm9BUldVL3FEZmtaei9oZlVQMGh5TkVCaGcxbDI1ZEVV?=
 =?utf-8?B?djQrV3RyWjkwNnFyVmRjQitaaUoxUWxOdHlLVjRkUG5NTDk5WnlnRkdqMmR3?=
 =?utf-8?B?QzJ0cEc0dmJuNFMyaDZxUUtWQStFL2wrSWdMRzZ1RU1ZWHVwa3BQUFZCVzhj?=
 =?utf-8?B?RVVUYzlOVHhGQ0I5NWpqQ3d6WVV0bVFSbE1zTUpwdjkwTDYwaHpaUUpINWVD?=
 =?utf-8?B?YldHZHVrVTBGV2gwcEZDU2dPRlpldHFXVGtXaGFIYk5nMWRnQTE0UUhLS0Y1?=
 =?utf-8?B?NkxHc2NHMkVHd1VIRnVld0N2Y2pVbHVsMldVMkFvSktCT1hzZTNESThYeDNH?=
 =?utf-8?B?Zm9Kc0dhSWpNQW5kN3NQTklmYVZ0Y3c3ZlU0Tkc2MU5uYklDRHUxQUdoNEs4?=
 =?utf-8?B?eElGazVTTUZZSjVUZHluTUErMXNKNG9tekdVa2RqRm55M3ltTlhHUE1XZk9q?=
 =?utf-8?B?T3F1dTdnT04xOUNZd2xWeHptMU1Dems5c3VFSklCOFVTQ1BoQ09KM3pEZ3Rv?=
 =?utf-8?B?V3RCblhCMXRYNWE5ejdHMUNTRWFqcVdST1B0SW9OYWtnOE1KRXI3bDR1REYy?=
 =?utf-8?B?WmhubE9XT0d2YTlUUVIwZ1JVYTduOUs1aXRiZkNETzZBcEFEcDRtWlNIYkZO?=
 =?utf-8?B?WWtFQ0Znc21tcmNvMHNxUDdOblVrT0JBemV2clNLOFpwUWs4YUpWaVZtdWQ4?=
 =?utf-8?B?bjI2TFF4QVRGM2hhbGtUTjZQMzJXMi9lb05CVXZtcVp5ZzEydENJVlYyelFj?=
 =?utf-8?B?VlNZNGlsNThxTjRad0t0MUtUeWFpVXRsQW5aNkNpMklJam91cDU5QktXOUxp?=
 =?utf-8?B?M2J1NTNFbGNUdHV1UFpUSzk2VjI0eVZEMk9XNUZsRmxVS2xzOTZ5NENSdlpE?=
 =?utf-8?B?NzAzYWdGTGVyelFzT1BTYlg5MFE4eFZHeE1NSldzbXJsVTc1Y1Y3QkJueGV3?=
 =?utf-8?B?YmZ4RXNkalRjL3FZVmxjaUtpVUNub3dGMUI1Y3RxSkJRcGRSaEJIRjAvK3FS?=
 =?utf-8?B?dWQzNHh4QUhPaWlmb3RUQTJUNmRhZWd4aVBRNHBkL1A1VlZSQjNXUmt1NlUw?=
 =?utf-8?B?MmMrdkRDbFNjUUY2TEtmOXYyOHRmT2ZSeWdHZDVhcFpQWWo5Qk8xZmMwQVJq?=
 =?utf-8?B?WGNUdmZNc0dtNVpjckxqYmpXWCs2K0lZYjJRYUovWk5Hblh1aDRKQnZUZE9s?=
 =?utf-8?B?UW1zUmJ2MWQwTWN0K0Q3dEJoYnpOVVFEVXVlMm91Z1FWVCtJTElaeGRWS2Vp?=
 =?utf-8?B?b2RTNzdDSllkcTRWZTFkTUJ3TDBEVFhQTkhkUWFZYmxNUmQyN0tRa1VCVkxu?=
 =?utf-8?B?ZTZobk9IeDRmb2M3dG9ab01lcWF5UUE0d3Z6Ymh2N3VHY2gzRE5lR1lYa2I4?=
 =?utf-8?B?VlQwbVVQS2dmaVN3K3VsK3RhNG8xMFNGaWZ5OTZJVHptZGhhR2EzOFFENUtR?=
 =?utf-8?B?ckNjTHVsZ1M2NHhoZDkxUzU1elRQVitPd0lGNDA5SnBSZEhkSEJZNGxoMWI3?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076f1a4f-864e-4ebb-310c-08dad9230e57
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 13:49:41.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkZ3jzXTcVKVmqP+wChso4FNshj01GOljvSAjWZRWsM7Wakrgz+L1ansErB4G5dYx4xTiwiK4XmJ/+3AtBHsVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6682

On 05.12.22 16:21, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
> 
> Split the set_mode method in separate methods for switching to primary and
> secondary mode for improved readability.
> 
> This also fixes a wrong evaluation of the mode variable that lead to never
> checking the FPU registers in secondary mode.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  testsuite/switchtest/switchtest.c | 48 ++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/testsuite/switchtest/switchtest.c b/testsuite/switchtest/switchtest.c
> index f2a5c1601..f8a37da79 100644
> --- a/testsuite/switchtest/switchtest.c
> +++ b/testsuite/switchtest/switchtest.c
> @@ -440,15 +440,21 @@ static void *fpu_stress(void *cookie)
>  	return NULL;
>  }
>  
> -static void set_mode(const char *prefix, int fd, unsigned mode)
> +static void switch_to_primary_mode(void)
>  {
> -	switch (mode) {
> -	case 1:
> -		cobalt_thread_harden();
> -		return;
> +	cobalt_thread_harden();
> +	if (cobalt_thread_mode() & (XNRELAX|XNWEAK)) {
> +		perror("Switch to primary mode failed.");
> +		clean_exit(EXIT_FAILURE);
> +	}
> +}
>  
> -	case 2:
> -		cobalt_thread_relax();
> +static void switch_to_secondary_mode(void)
> +{
> +	cobalt_thread_relax();
> +	if (!(cobalt_thread_mode() & (XNRELAX))) {

Redundant braces around XNRELAX.

> +		perror("Switch to secondary mode failed.");
> +		clean_exit(EXIT_FAILURE);
>  	}
>  }
>  
> @@ -475,7 +481,7 @@ static void *rtup(void *cookie)
>  	   allowed when suspended in ioctl. */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>  
> -	set_mode("rtup", fd, 1);
> +	switch_to_primary_mode();
>  
>  	do {
>  		err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
> @@ -556,7 +562,7 @@ static void *rtus(void *cookie)
>  	   allowed when suspended in ioctl. */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>  
> -	set_mode("rtus", fd, 2);
> +	switch_to_secondary_mode();
>  
>  	do {
>  		err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
> @@ -637,8 +643,9 @@ static void *rtuo(void *cookie)
>  	   allowed when suspended in ioctl. */
>  	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
>  
> -	mode = 1;
> -	set_mode("rtuo", fd, mode);
> +	switch_to_primary_mode();
> +	mode = COBALT_PRIMARY;
> +
>  	do {
>  		err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
>  	} while (err == -1 && errno == EINTR);
> @@ -668,8 +675,10 @@ static void *rtuo(void *cookie)
>  		}
>  
>  		expected = rtsw.from + i * 1000;
> -		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS))
> +		if ((mode == COBALT_PRIMARY && param->fp & UFPP) ||
> +		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
>  			fp_regs_set(fp_features, expected);
> +		}
>  		err = ioctl(fd, RTTST_RTIOC_SWTEST_SWITCH_TO, &rtsw);
>  		while (err == -1 && errno == EINTR)
>  			err = ioctl(fd, RTTST_RTIOC_SWTEST_PEND, &param->swt);
> @@ -682,16 +691,23 @@ static void *rtuo(void *cookie)
>  		case -1:
>  			clean_exit(EXIT_FAILURE);
>  		}
> -		if ((mode && param->fp & UFPP) || (!mode && param->fp & UFPS)) {
> +
> +		if ((mode == COBALT_PRIMARY && param->fp & UFPP) ||
> +		    (mode == COBALT_SECONDARY && param->fp & UFPS)) {
>  			fp_val = check_fp_result(expected);
>  			if (fp_val != expected)
>  				handle_bad_fpreg(param->cpu, fp_val);
>  		}
>  
> -		/* Switch mode. */
> +		/* Switch between primary and secondary mode */
>  		if (i % 3 == 2) {
> -			mode = 3 - mode;
> -			set_mode("rtuo", fd, mode);
> +			if (mode == COBALT_PRIMARY) {
> +				switch_to_secondary_mode();
> +				mode = COBALT_SECONDARY;
> +			} else {
> +				switch_to_primary_mode();
> +				mode = COBALT_PRIMARY;
> +			}
>  		}
>  
>  		if(++i == 4000000)

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

