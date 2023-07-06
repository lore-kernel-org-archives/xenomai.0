Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7366137C
	for <xenomai@lists.linux.dev>; Thu,  6 Jul 2023 07:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8IAH02I8rZl9p5mz02qh7MnqYxTm3CoXaikQ+m1HVnQ+sKlvg5Fcr2XFxPF3WDEm5TWwMumUAzOT9MLATcDVzIAfdQJfWwtooGM5XqlYLJZduxqsiXNXsQYd+oxHr4PCtoD7CcQZqwZFHHTRK0sfxnKWT6x1WcHSnefV5iCBRTJdEBB4ocz5JtqC2WlLrDkMaox5ZWevh4ij8zUj+1v+k6yJWxMemIsCv9104559yDAhPHfgFFrX5bUi0xZm6/OA/2tWEQgn0rPKe8iCc7FjglAKjgID7XvHRGMwrQbO1r04rRDUcoRmir+IqqXFV8Y81JvqlcbwTHrvoCM2Hiu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL/szBXv5u5bZEkLZzvESXH7cbNKIKeeItkfNAxz6q0=;
 b=PQKB9IzteLpBO8IzZD23C4uoluqr7hdJeyMy8GXr/v2GWq1ajrWnVhdcUPNhJaU09zFyHZW5pUI1d1/GT49IGhTAP9feeQ/AcEri7X1bWhxofSdWQc/yHQdPIaNK1WWe5ZSSp6p4BF2dnOV/nyfX7TN6iH2b0EksN8eOz12ioPGUAL7gKDNO0IXlQl4yCVFWooSdDkuUgmTyFJ+QokZRXIDmMdLeyWIk1i5l1Vfq7lxyOGws80BPYdsSST4/ULku39qk/k4I/S7KotsykUP8a3vNlbuhpkie9KtJVqnivpjvMhLeuEUlO+yhyqPfoGOvg0mKPquW3lK1ucnpjkaI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL/szBXv5u5bZEkLZzvESXH7cbNKIKeeItkfNAxz6q0=;
 b=f14GVAECtMJnETa6wjIUF2GD4+wJQingwCHzK+ZBt1RJQKeFsYfz8IQi2b5in81QqasnfUCDS4hl0KJjp9HIRGuPvyys/WQ96S2gcUdHDWPv2GkdU+BJEaCxWOV0c9AQ3JzsCC14cnHt3YMRXXMtcyZgnfjdRgLyjQEUgU+0HOF10d4WzBzsa4hT5rzoKq6g3A6XZe2xyy7kOMAFlb9AvHSjGqI7bfVSQjIS650fHQ4WlcDmQOXW7RWFdHQpf9n2JH0LYSJJgTnW9etFk8QkF4wOMSbL7YgkNrV/CBSse/i/c5EVKUc2Ovb1GjKrAmAyKnp4cmS2ZjSRJ++EMW0LoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3357.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:27:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:27:50 +0000
Message-ID: <0d198b25-1df6-a640-ff31-b464d176828f@siemens.com>
Date: Thu, 6 Jul 2023 09:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 12/12] testsuite/smokey: Fix unconditional unloads of the
 xeno_rtdmtest module
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230630-florian-y2038-part-four-upstreaming-v1-0-604a089542c2@siemens.com>
 <20230630-florian-y2038-part-four-upstreaming-v1-12-604a089542c2@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230630-florian-y2038-part-four-upstreaming-v1-12-604a089542c2@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3357:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fadda1-d12d-4b89-836d-08db7df280b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	scwW0bOo9TZGtEir676UiHp5QypLJ9pzpWPvyFD+7SLPrFircHt1fRJaDs2Mf0xe93c66TTcRYDviWY3MPuRPLDa88jYrfAefm/9iEUCjfqAdRM7PExb93khml+yQflZxqnpm24HcKIXJ/B+dreGkXPluFjGT9qRgVt9bu70c+wzqc6KiKqKhu8FIsa1L8nQ+YiiAt5A4PKteOyVP5+zuLexCPfAetFwux1eydphvYLxGqaoKs/o1lEx+v5HKs8hWSfy13OkaL5G3RKy4OsBzIdI912Mhw/msIjF41yYw+eBCx6088V0ibGOeARmQxMC7uf9s3/hExWs31W1t4+e/aOICI5ICLhNQYte6wr5rWPAnaq9qpZsLwqqkkZMfr1wVDHoKmzfZxxAC8gYuwNtgyLcblsGV58gan+qlNytN3O1vkO8Kh0lx5ObN84NgbWnNWWTAYY/DAmLwcElxqPI3VL/qhD7JtrWfxHdFNtEfdaRzH3KQ55xIn887ImAIRNixWTSqB4IG+thkWJa+2YpKvxqEcD2oNko1aQN5OKCXH/VWCMNh+NECuSeLThFytzxlerynpeJmldcfrfY6JsWSfV4HDE7Nx7K1qQFbPg5qjRnh0cRAUhKDu5SHDDg6NwaFpSQVthHm/TK3LXijBthuQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(478600001)(6486002)(2616005)(83380400001)(36756003)(31696002)(86362001)(31686004)(2906002)(26005)(186003)(6506007)(66946007)(6512007)(41300700001)(53546011)(82960400001)(38100700002)(316002)(66476007)(66556008)(5660300002)(8676002)(8936002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWpuZmY3bGlLa2V4SlBEUzFYR2tycnl3NW1DQXlrcVB6cGFla3FBTnlaR3Fm?=
 =?utf-8?B?MXQ2WE1kZk12anZxK1lUTmlPaU9naENhUHBJMlllajZMMEdVcVoyTTlVbjl0?=
 =?utf-8?B?Q3ZwSnhyckRrVy9KbTZ1bFY3ZUJTdGZEck5KNEM0Vi9Pc3pCaEFacHBjYTlv?=
 =?utf-8?B?ejlNbzJJVGhraVNWVVhwUjFkVEpwQ1MyaEpRVTBOTUdtUEQxSmJ6TXRDSTVX?=
 =?utf-8?B?cG1RSEpoUVhQSmI2WjZ5bTczdDBUWVI1ZFJSYk9BN0tFMjN0cmdranNDc09V?=
 =?utf-8?B?MkRhMWdCRDR3c1Jsc0x1OUR3ZVhFOFZoUXFWVVdmRmhxejFWVVZXaVZlWUd6?=
 =?utf-8?B?RU1hNDQ2cW13d0hKUU1ndXhkOW42OEhBZis3YU95Q1V3eXJSemswQ0o4OWpH?=
 =?utf-8?B?Tmd3a0ZIZVdJeGp5cHFjalNrakJ6TnBLMXJJeVd1MEEwcEdsanduM0hibWxY?=
 =?utf-8?B?ajBVbGNGSHNpMmg0ZGtoZGtEVlY5U0twMHE0UHh4VG1CQ1dUU0lhK3R5MFNq?=
 =?utf-8?B?ZUxhUWtQSDkwYzlkS294OWE5L3VCK054NUFoaGN2QkU5UThpUFlzMEw1czA0?=
 =?utf-8?B?RFFCbk01bGEvT0dKVkFTMjFVcFpORWpxaFZucm82M3pHeUdSVHpLa05idFBS?=
 =?utf-8?B?SDdXZHJZZE11RXlzaTVycmRpbjlMZ3VLMlVvMWV2WlpLZFVsc3MzSGtFMUxV?=
 =?utf-8?B?MENiSWdTbDBxVCsvcHpabkc0dnI4eUNmMm9OdlkzckVwNHVMS2xvWFVQV090?=
 =?utf-8?B?amowOTlZU0tUYzdFaVlTbWNGQlpuL2xoRm1qRW9HLzlMRXRGWXpaeUdKK1Rh?=
 =?utf-8?B?U1J3NU14R2FIck55U0NCdkIzNlU3a2NyVHY4VUV4RnFWNmpJaDJyMGF4TUtH?=
 =?utf-8?B?clJHeStQK3QvQmdKVG9aRXJKUlNUajAxNlJoVldzWkRYWEZCdnA5NDhHMFBs?=
 =?utf-8?B?cFBxMzVIcGlTOVdDK3JUVGZOQm1qaGlJU29RaXJkVkhFYVdULzBkbVY2QVN0?=
 =?utf-8?B?dldIOWduWGpta2c2UkVwWkRvN2ZGQ2lxeDVJUzB1TE8yS08rMlNNa1BEVERD?=
 =?utf-8?B?UytmWHl0VUlTTGl2WXF3N0xmaEt0b1VpUjVHbUdGSW81TCttK2xUOC90NUN0?=
 =?utf-8?B?NEJxd1RGN2ZlR0ROTDAzWk1RZlFEZ29BWUdxbzRHM250NmYybWRqV0p3SG1U?=
 =?utf-8?B?TkdHdkkvSDAvMi9JMnA4K0RaZGNSbUc1ODhDcVcvRG5ST0xkVndTeHIxTURW?=
 =?utf-8?B?ZVRmMWNQK1NGSGVyV21maCthYVR6N1owbUZpa0VKUlFxd2pxYUVJSUl3RW1z?=
 =?utf-8?B?VUhNTHVVVXl2OE9ZOHBzc3dic3lNRjkwZTNsU1g0cUYyZ3oxeGh4dFNKYmxh?=
 =?utf-8?B?TnF1WUVnWGJaeU1NaEYvSlpUUGJuQUxDcGRjVjEzQWh6WGM5Z21lQWRjTk5r?=
 =?utf-8?B?ZFAxMVJsLzB6THM4b3VFOElac3RpYXUraE1DWUJBUzAzUWI0L2lkMXphci9a?=
 =?utf-8?B?aEhTVjdhUWFWUnRHZzZFcWJ1alRHRW45OGtHSk1aMWlmNXpKZSs0bWV2N3FM?=
 =?utf-8?B?WXd2M1Vtc1ppck8reHNNWDNOcFZHWlJmWUtoVDRhUDRFU04xVzZyV2lzRzhD?=
 =?utf-8?B?N0RTb21paW5VcWRxRElKTmFVbUNMbG9EWGU5TUFmbzRSUEZaV1hiQjVNb1JN?=
 =?utf-8?B?NDZCUHNQUlNoNjhuMUJZMU9wUVBrbGRsaG9nYURReFF3TnNYaFA2T3VpK3pX?=
 =?utf-8?B?b0FlYXFlSDVwMzlZS2c0TDNmaGpNSlpmV1lrRG9WQWkwVGhJZDBrd0dUQUov?=
 =?utf-8?B?NEQvQzhMbG5MYWhKQ2ZnWGpSL01nWTAvRVU5bVc2VzRVdTNZbUZlVG8wOGM1?=
 =?utf-8?B?OHRleCtnWTVvWSsrT1hGRW5uQUJpYXlScGZHZzdGaVFaRGkvekE0dmNTdnpR?=
 =?utf-8?B?WTdCV3NVUzUvTDdkT0hPcXpaNHFQejNpRkgxZlM2djhiSkJUaHZMQ0RmY2Zi?=
 =?utf-8?B?SUMrZnJoUTNQMXVDLzhsOEVhcXJUOGJDbTBZWTFuUHNuVkRwRlZMMjJjWExM?=
 =?utf-8?B?QzBXR0w5TU5jS2VpQXljODlrN2x6R1R3M3ZxdUxmQlV2Y0xSWVIweC9LUmNo?=
 =?utf-8?B?bzE3cU5NYU1wMm1mY0d6eGlwaEFqaUVzVzZzcytqNjNzZmdaWElMMEhGVHZq?=
 =?utf-8?B?QWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fadda1-d12d-4b89-836d-08db7df280b5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:27:49.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erVfRHdMttJLVnK3Hu9nagGHHWIvtxI6hZ3Sqn5czwv98cUY8NLwggQ/jq8jajv+11iFW1QIbIoI3RVbEF9oRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3357

On 05.07.23 08:38, Florian Bezdeka wrote:
> The cpu-affinity and the rtdm test unloaded the xeno_rtdmtest module
> even if it was not loaded by the test upfront. In addition, such tests
> failed if the module was already loaded. That made partially re-running
> the testsuite after a failed run harder.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  testsuite/smokey/cpu-affinity/cpu-affinity.c | 13 +++++--------
>  testsuite/smokey/rtdm/rtdm.c                 |  7 ++++---
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/testsuite/smokey/cpu-affinity/cpu-affinity.c b/testsuite/smokey/cpu-affinity/cpu-affinity.c
> index 4a59ff6f5..cbc877182 100644
> --- a/testsuite/smokey/cpu-affinity/cpu-affinity.c
> +++ b/testsuite/smokey/cpu-affinity/cpu-affinity.c
> @@ -73,10 +73,10 @@ out:
>  static int load_test_module(void)
>  {
>  	int fd, status;
> -	
> -	status = system("modprobe -q xeno_rtdmtest");
> -	if (status < 0 || WEXITSTATUS(status))
> -		return -ENOSYS;
> +
> +	status = smokey_modprobe("xeno_rtdmtest", true);
> +	if (status)
> +		return status;
>  
>  	/* Open the RTDM actor device. */
>  	fd = open("/dev/rtdm/rtdmx", O_RDWR);
> @@ -88,11 +88,8 @@ static int load_test_module(void)
>  
>  static void unload_test_module(int fd)
>  {
> -	int status;
> -	
>  	close(fd);
> -	status = system("rmmod xeno_rtdmtest");
> -	(void)status;
> +	smokey_rmmod("xeno_rtdmtest");
>  }
>  
>  static void *__run_cpu_affinity(void *arg)
> diff --git a/testsuite/smokey/rtdm/rtdm.c b/testsuite/smokey/rtdm/rtdm.c
> index 0b89228fc..6ad0d6d7a 100644
> --- a/testsuite/smokey/rtdm/rtdm.c
> +++ b/testsuite/smokey/rtdm/rtdm.c
> @@ -153,8 +153,8 @@ static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
>  {
>  	int dev, dev2, status;
>  
> -	status = system("modprobe -q xeno_rtdmtest");
> -	if (status < 0 || WEXITSTATUS(status))
> +	status = smokey_modprobe("xeno_rtdmtest", true);
> +	if (status)
>  		return -ENOSYS;
>  
>  	if (access(devname, 0) < 0 && errno == ENOENT)
> @@ -195,7 +195,8 @@ static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
>  	check("ioctl", ioctl(dev, RTTST_RTIOC_RTDM_DEFER_CLOSE,
>  			     RTTST_RTDM_DEFER_CLOSE_CONTEXT), 0);
>  	check("close", close(dev), 0);
> -	check("rmmod", system("rmmod xeno_rtdmtest"), 0);
> +
> +	smokey_rmmod("xeno_rtdmtest");
>  
>  	return 0;
>  }
> 

...and also applying this earlier.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

