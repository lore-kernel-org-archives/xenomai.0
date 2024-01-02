Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD5114F94
	for <xenomai@lists.linux.dev>; Tue,  2 Jan 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fsAch5TP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyCQpKgOO/661IBTU67hyOJkeekoSQq1eqNl8Hwx0J26ETB3j8UTqazfzdzPogPvHWx07iOtJY7A3VdPI/iVPXwSj6U4scjtTU9/oLJ//rRIAkJV0CbiL8NoBtp5wXBEkSiFd/neY5lALjH3ZPHQTZPR9tm57ZAHGBk85ICIME3tOANiXM2ibwGWlXWU01sfiqjeXxpUscr4KMXs9/BOD1hYCyCsogI4SvNLyvg3fzk08nF6h8vLfnboHWVRmdxeRlnqONwBsbb5YDq44EuAqREvqnRe3f2KK2AdmL+F3Re8rgevtY8/fLOh2QzFg+Hnbo8GhgZGgj7dIisA7qjQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJU4lc0He+IE6fNbsKoID4O1SLLTIhi8QQAseZG56Fk=;
 b=I3oeyL2gp5G2wcb1ADW3d2oALOjeWNpF9APUYW3mdQ4m0QkeCrXiHlOA+kOwixsTTIfY550l+uts5pQR8Q3tdIfBM4Lg9nYjcOsrt4c8GHhcSANrLxHEmr1kwF2fpBj7amHClONm0zI7l36SRPeJEKcglmqZgonw4q+qwm2oGA9UYqGA2r2wUrcRHdls8roDiOO2FC+sSVZ5QutmhmAu9OWf3CEFb/XM2UiM1H1cn/wPMlNvNbgoc7qDYG5wf1Cri1AI1pnwbLhZJQJ9gHAD/ysFyizgyi2X1YhJgrz6T0lZunPE6+KiTFJKZzUCBmynKBIUCKXCafH1wL5hr2OFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJU4lc0He+IE6fNbsKoID4O1SLLTIhi8QQAseZG56Fk=;
 b=fsAch5TPUAAeSRZCxFr+n195EVekZCwbhMvrNkzjUi+/Vrrbnitl5KCpFv8Egs4nAMz440yiJMfhUhlAY/o38Mgg6F4dev3fulkvuyCq3cvYluuXPcmhPnCqgGTmP1tPt8WlgobisyEg3vWqIKvolQbblVDID1WhF8TKGKVxaWcr6sFvfUwmnObmVZ1QHiTnVbqTBmAuOPEpouCy6/zKpNjVpvcncStj9209aDOrVz//uBF7CYdySxUO39HPArPz1qwFImycukU11wM8FOWLdbfdy7U4GNuT25SmZ9rLUZJMXqVdXzuuYc4tYbA2l1NAcc1jxlMGUuazmbbPgYt9NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 16:56:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 16:56:41 +0000
Message-ID: <ca68187b-b9e8-4200-9090-81f768b1b5cb@siemens.com>
Date: Tue, 2 Jan 2024 17:56:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH] build: Reject building for i386
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <76d5ecd7-ff91-4973-ade0-a1a63fdbd9cc@siemens.com>
In-Reply-To: <76d5ecd7-ff91-4973-ade0-a1a63fdbd9cc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3938:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7d7597-aa2b-4998-6d8d-08dc0bb3ca6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4jDhwhhjD2qOJsdP3RrkkkMIbk4HiiY+P/97ls8G11srtPYV1bnp80gXb2FoqC2lQvu1SpZN3hJ2ptkd5lwbQdqQ3YpwVZwokDFS86dwR/2L0JAN1nk0qfelK2OfN/JQKO+OYbbC7OMBrZQD5qeVwzK7OxR8vhaCXip6kTIY7b6TiI5rw0ge2mlJTqWRvoQiMIUu/JWNJBSt/rr6bi4fcdIEjY59ytSwuGQJocu2e1l/EWaWbmmEzfn/j//MR0nS4g1lSz7t48AKhFfEBZ6Fo8GmQb87RPcHgIzREZsP0SmjpOEhlMAvcprXprGzCnJnkULfn2e4MaVdDN/RHItuIML2za60PjkSjXXjGH04yddarhbC0U61WPiJFoSVnXlcB290Kjb+Aar01HwSTby9kS/0IxZ+lypis15YHBFsuOvytxRMnonwpKmDlDWFAcWGDIxu8MiRf3gtFWh676TVTuzkDT3VzFdL8iiFtp+OzVv4xQFucqgjOMr0iofxwMz0KggeeWe1bIL2COIN4pXvGlaorBb6R5m2QjU5+JozbCrrhwu4xCb1EQBivqMxpphIJUw1ecmTlpzVgxi0YAVtttw0xBWJzFBAw7kpoxRD8aRg0QxFoVl7VkEZz1MqA/xAVTLNCirwNtGf4lYv0hzR3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(2616005)(26005)(38100700002)(41300700001)(8936002)(8676002)(316002)(82960400001)(5660300002)(6666004)(2906002)(4326008)(478600001)(44832011)(66476007)(6506007)(6916009)(66946007)(66556008)(6512007)(6486002)(53546011)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFZ2SFdhb1NCZHJKdUZVOURaWkZ2YW9mNXFaNU9UcUQvN2hyMlFBbitYRXM1?=
 =?utf-8?B?Z3o4UVdYMlFqdy82dmRmcXhqYlVOejMzNWhZc1dRb3Uydm8xY2Z3VjRrdmRX?=
 =?utf-8?B?WnI5akVtR1AyM2Z1cE5rWGp6V1c2dzIzQ2VnTVJVOVFsQ0hpVjV4UUlvNGpi?=
 =?utf-8?B?TVVFV1lZdUJWTGhzZ2Q1Q0pFVStJSitIcStXRGp4dUxlcEJiUjBmQjBhN3pM?=
 =?utf-8?B?Sm56RXUwa1pieGcvQkg3NnhNRUUwbDhCTTl0ejd6RkNvc1Qza085VmlxTCtC?=
 =?utf-8?B?anhDYllQdHF0YUNTc25WK2RGcHEzOTY1eWdlWm1xMTFhNGhMcU1NSzNwV1ds?=
 =?utf-8?B?SXFNSG5NYmN1VDV0VGxwNkxMUk4vd2hjVDVCZFlnbk9XSHpnY05seVRjYTUx?=
 =?utf-8?B?THZ2SFoweW9Nc1Z2ZmFvK1FGb3hZdUpzWkZLSUkrZFVQSGJSa2FyTmZabTNN?=
 =?utf-8?B?YVFmWVBveDdiSzFPcEM0cmxPOGZ3OGtieHdXUW1ieVlNQ1EzNUxkRFd0TndJ?=
 =?utf-8?B?ZUJWd08vS2FHZW5rSlJjdy8rU1NvakpoeXNXbW04R1Z4eExucFJFUTUvVlJF?=
 =?utf-8?B?RjM3MTlqaURqOUxubWxJT0VPT2VuU2pvbXRkVWIreUQxbFMyL3dkd01TZnk1?=
 =?utf-8?B?a3hQMmVFeHFMb2R1RnJPYkJScjAxRnljWkJQUlNuWHk2Q0owVnduYjZ0OElE?=
 =?utf-8?B?Qk5BQXo0S0NCZ0RMYTlJTGpoTnI5eTFUOWtoZE1TTE9obzZtRVJ6TDZybVVK?=
 =?utf-8?B?aTR5T0F2SUxKbGs2NDVTZzc3Qnl3QlNiTFVqNGJmaWE2TzJkWElnUE10Vnpa?=
 =?utf-8?B?RUU4YTN3TVNHT3d1RTdRYjEvM3ZTOUZBeXpNeHlmU1Y1WlBodGx2ZHRzRTht?=
 =?utf-8?B?T1EwV3p5Q0VLYXArZDZWVXc2WTVpNFc5OFVmWUhhKzYzUHFkQ1NFMVkveXdY?=
 =?utf-8?B?dHVpVUFZZ2JuWTFIYnl5bUFHMnZaSGNXRG1scnJlS2Jra2tBdjlreTFBb2hX?=
 =?utf-8?B?NUU1SmQ3QU5DamlvYmVRYUZWRlVXam1CVlFzLzIxZHdGVmk3YU1NbnNLYVpM?=
 =?utf-8?B?WXE2WjMwMmpBczBvWGxxZ29LVTJPYjlyK0F0eXFFZlRPTXVLSkVmaS9mQkQv?=
 =?utf-8?B?QUxYZG9taGtVdi9YZUFIZCtmZnlvZGxlZnRNalJIRHI4bkxkSlBzaGl5Rk5P?=
 =?utf-8?B?YUNiblRhRGErMlVwSkwxNER1WTVCTVRrdEF6M0FiSXVlUjJ3SXVLZFlGVzNl?=
 =?utf-8?B?SzFRWnR5YVExaDFtVHpTeWhsN3lQWGxrYkNVRkFseExab2ltOW1IUEpobDJx?=
 =?utf-8?B?ZXZVa3FWbnI5YWtaTmJaaFBZT294Y2JTZTZyYnM3REdnVkY5dTVSb1YraEFU?=
 =?utf-8?B?elB6OTdKUzVabGFUUmRKUzM3TmsreHZTeDNidGowZDJDNGlKUlRwUlFWazEx?=
 =?utf-8?B?MmJoU1ZLMHA0WEVJYWt6REtEMVJJUExpYzZwSURERWJMaEhodStIQmNZcFV2?=
 =?utf-8?B?UlkwNDZwekM5cjE0emtQYTFwZ1E0TERVZ1V6dU9PWjNVWmR5My9LejRCUVh4?=
 =?utf-8?B?N21uSEhOUTdTTitYZEwxdjJML216UGpnZzFJaXJiR1QwR2JSRTBDRyt3QTlw?=
 =?utf-8?B?RnNxb2ppc0FYR3FCamhFK3d3TFJRRVBuNXhJdlUzMy82RTBTaHNmQXNSN1k3?=
 =?utf-8?B?VTZjTDFCL3FYaGFUbHIxcUE2bkJIL2FIOTAxaDdxS3p5dXNqZjhVbld6RThP?=
 =?utf-8?B?NldTRThnZXIrVkJhSmVkcEdTYnZZSG9NZ3JzUVc4TEU1a3pWSkxtTG1SZE1q?=
 =?utf-8?B?YUVsUm54ekhaQWtRVTRiRFgzSk1KekFkb3VrTW8vbDRCZW1NcDNVU0RIWitC?=
 =?utf-8?B?QS9nVFZDV1VuTmxDNnBhU1c3ckkvRXUxSmNEQ3Y5VnFvT0xxRTB1VzVCUkFy?=
 =?utf-8?B?dWhjdWFFQkgrUGJ2Wms3MmNGY1ZzNVlxSDVPUjZiSFExN0FmdnpCWGRTdndB?=
 =?utf-8?B?dlExUDM4UkdQbEhMVnRDVFlUV1dsMVlKZGI3YW00S0QxSGFMVWgydytaT0t3?=
 =?utf-8?B?UFRoRDhWMlUxMWZpUjFPbjY5SGtDZmpVVUJZWGNrRTBTaGU1WFNSY1UrWjZx?=
 =?utf-8?B?aXFVQXdodm5lQmFHL3UyZ2NvTjhuUkx6dWZJZlJBbmlPdzNtSk5ZUnNnbDIv?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d7597-aa2b-4998-6d8d-08dc0bb3ca6c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 16:56:40.4555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHJ+XXWcktcEi/U/Zc/POY5phHng6jjQWUOW5dNgBImpHMWno9RW6UglAE0GfPOWNQWiuI09XJf6rFUsoGIpqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3938

On 17.12.23 17:22, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This architecture is not supported but we were silently converting it
> into 64-bit x86.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  meson.build | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index bbde902..fdb2e55 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -46,12 +46,15 @@ pthread_dep = dependency('threads')
>  
>  # Do some architecture name remapping
>  libevl_arch = host_machine.cpu_family()
> +if libevl_arch == 'x86'
> +    error('i386 not supported')
> +endif
>  if libevl_arch == 'x86_64'
> -   libevl_arch = 'x86'
> +    libevl_arch = 'x86'
>  endif
>  
>  if libevl_arch == 'aarch64'
> -   libevl_arch = 'arm64'
> +    libevl_arch = 'arm64'
>  endif
>  
>  post_install = find_program('post-install.sh',

As you are merging already, don't forgot this one as well. Minor but
possibly still helpful for newbies.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

