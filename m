Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BDB5392
	for <xenomai@lists.linux.dev>; Wed, 22 Feb 2023 13:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USfZ32rfDlakcyvPdiLKIR76JMHcLgSQ2N7LQBGp5rrRcTcUVc+jJdPhRSsVFHqHWiuL+FX7XULAUYimzcs2ny20z/AMUHeAf+GYJdNHg8lLeSXYy6lSqcmzIMNEsso384+7726N3qHGkbshWuocYKJWMecrIGOL8GmRWPz/9QIuiZaXgoSveKbvUXy5oQUX45fsfCIQwEsP/aOn/W6jBx0b9BHlyiMLR70lQtkuN3lYryAiXXXdyhgiRcjDN2Je3nG4mMxfV5qmnr1shTNDPfzDVih19cVfiP+uabH2KpBhwDgvY7YRDrFjqjxQajjc2CSdUhiOQJ9XgoF2GQchJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHR3f7Pi8g/KZqpSaDy9ajp3zf68IYbOuk3g1AYDfY0=;
 b=oWJmiLbuFyf5k5NP1oiZUp5QCw5lRRSKZNPxEaMGaSORbLIkDv3j5b5Y31E7S61lvS+idjUKh5/zMX9TK+Lt2levCue8LhPlzUptca/dLYJe7OX4EOKc7yVJhjWQRC5RTbADU7qNPm5EthBnaCOZ9dL8JQzkUMqLCQPAdgKBpMA+hYa3knwYgZoojQ/g2Fd8iRUoIvcsLkEx3EKjmALBGxLjC8zBHjq/ERvyIUcdxhW6s+IFJu6Ah39Z6F5p9GbIMlV4O/7vxcElgFQMVxcLks01gAMRVX90XXIZV6Jaa8XkeMvC7QJ7vCtj9YRmfFPHPAOon2nk0J6Q0qh0WAuWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHR3f7Pi8g/KZqpSaDy9ajp3zf68IYbOuk3g1AYDfY0=;
 b=tPCmgTUIJDWpl1QEN+/veTvZB/lyaXErAiCGR0XFbOjhdZnCOAus0gAizJlMUI5ijZJ6B4L7Tr/P9awTTzLz9kR4D36Il8dAQHtbT2xLxcuQG2ajKzrX/EhpedcRfGhkhpFFVRocm4wJHFNWJsrjXY8NiTXASbDDxugoHdVqy5ylygQg7dYHkzHF2mn7UnbgJ8A/eBD5BJIr0GWDMRjzEjbtzm1iM+mleMd6tMM3w6kFRpO5GOzP5Zj6P3Zij6i09doytncSm2G5ftam1hZ+HG3IcweISXSKGh0UF/2zigUqFtaO3mKK+zjgIFASYC78o6eha+3hkcc9faP/yiI0lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7906.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18; Wed, 22 Feb
 2023 13:29:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 13:29:42 +0000
Message-ID: <f7897511-3723-4962-dfd6-f25466b50f94@siemens.com>
Date: Wed, 22 Feb 2023 14:29:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] copperplate: sysregd: fix Makefile.am
Content-Language: en-US
To: "Mauro S." <mau.salvi@yahoo.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <fe268669-3bf8-627a-05c3-6231e44cead5.ref@yahoo.com>
 <fe268669-3bf8-627a-05c3-6231e44cead5@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <fe268669-3bf8-627a-05c3-6231e44cead5@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f32640-d62a-4789-3a69-08db14d8dade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QPj9WYhfblOU00ewKeCTH59zzDV/B348CAaL6wRPnlwV+JH0lbpZYgokz4QFyKig/qJ48GzfVsY7kfnwDJSt5wIZA5/yUEgG1r4zSr1FJksd07/DKX+fH2kNKfY+asX3JFct08i28E9vY2jd/T3dqU5AMz0eoS5n75prmZVSIkfCyquIm8SxahxKEZZBfxJQQdVPAm9jY/I8t05FGgODDbxem24sLuJnKwM1JPE0EWYk82CkBbvT0VfOFoqcUkC/sN0fG3zwq+3Bmmj8KVLT1XlAyOzDTOXAFp1u3dYNhCr7xZcFKoG1KTuepmEUkyG7K07J2Ip9/S7984IneEv3n0GQhX5njsAaJbNQcM2Wuuty5/zt2qRFykRSX2iKFzZOzs/LODNM46+VvBwE0X2k9xgdJ/KUuEp6sONBnT1tfRDHL2V18aJZcyMhTIgJtCgZ36j/y1LQujHQWC7yudHw9sJgAEiXs0WDjpcj8qXk3vHy0nZ5eOs/33oOHu0YSnFeom6MjDmApYC47BPwRkxa+k/ixXkaQkAFID2L3xwd6NY5r9wRxQuiuqolmQzP09ESVoDdkBCID6oqEFLPgAe6LvrDcokZllSN0BdZsWCGjRayw1vdeS+6VSHO8nCp8RP/vdHZwjobimAr4721iljkUsiRJesn72DcWDkwUjhjVt6F/LdwW9Hr7CoJhsrlIBeuKaGwcuJExJ2SzoEZpYTASMWI6tPXFI3+rJPgcRbscf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199018)(186003)(31686004)(6512007)(6486002)(26005)(53546011)(66476007)(66556008)(66946007)(8676002)(5660300002)(83380400001)(8936002)(6666004)(6506007)(2616005)(36756003)(478600001)(316002)(41300700001)(110136005)(86362001)(31696002)(82960400001)(44832011)(2906002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVVtd05aMnplNkF0ajVpeWM0Z1U2bW93Y0VkNjBDRzBVajBYSVhPNDF0aFdk?=
 =?utf-8?B?VWhIcEhsM1o3U2lYRG5jbkpPOXhrcDdNRHovenllOHprTHJaVEtGZTNTTWpo?=
 =?utf-8?B?Y3dwZGdHRWE4dk1jSGdaNEdBbVhGRVp1Y3lNRHQzQmovZ2IvL0EvcGxTMEU2?=
 =?utf-8?B?Y1dhdzh4UytKVEl5M0ZobzZEZytkZTJBeWw1bXBtcGlGSk9POW5BNnhmZ0tR?=
 =?utf-8?B?L0lqc1FPUXR5QmxGeWx6RUpmbjZRMVYzRCtTbHZnTk01N3V3ZW5sQ1JqMVpj?=
 =?utf-8?B?WjN1bUFkWHYzOUpQN1RSWHg5T09RQjRRdC9ub2lzRW5icU4wOWRENkhGQTlt?=
 =?utf-8?B?MmowYUJjQ29venN4Z3lUU293eWdVS2hNN2x3VTVsTU5BZWRweHhLaTFaYmJW?=
 =?utf-8?B?bFJIZy9UcVNBellRUHpzTm9CN1JRUUdqTy9rOWNDM3YwS1ZzaWlrU2hLaWh1?=
 =?utf-8?B?M2FkZ2FRUGY4NDVZWkY0L3lrSk5keGNBZEQ2SzI4M0Q3aDMvbGZ2Yit4Qllz?=
 =?utf-8?B?ajB6NDlHZnJYZHA3QnRVcU1SbWl3UkhOOHhxT21nSGJuSlovaGhkL3RHTi94?=
 =?utf-8?B?eDU3bVlwSDVHY1kxaFN1Y2cySERJbHpQU2pjUWttaUpwajBpKzJybGZiN2oy?=
 =?utf-8?B?N1h1R0J2UlltOXdQN0JHQitNZ0JEQjN6ZDJUeWxYODJSWFYrc2syeWZqMVlB?=
 =?utf-8?B?SmwxQ216YTlIdTZNTmJpdUN3L29YYk0rWDF5RjJ6RVJJa2tKbXRVc21CdktW?=
 =?utf-8?B?K0hrbUwzeFlzRU9Dam1hMjl2b3RqbVUzMmR6K3pyM2YxOEZlQ1VnSjk1Rm9p?=
 =?utf-8?B?K0RiWENTdUJDZUVKYnhlQjdTamRlMjlqcldCSTJmTEFvYVZtMXRvREdEbDBy?=
 =?utf-8?B?K1poTTJJUU1EcCtIaFd1a0lkNFlqamNKTTZUY2NhQmRPR0xSaU9xa2ZhdUpF?=
 =?utf-8?B?NXZyc2Y3dEN5T0MxdmM0RjRGd3pDMk4xMnJ6OVNBZXdrQVkwNWRhV0JYcHFT?=
 =?utf-8?B?blA2NkF1TGtndlZyUXJ1RzRhbnIrd2xEK1pPT3lLQzY0dWxXbEJINW9oYkgy?=
 =?utf-8?B?S3lsVzBXMXlUVHN0amh6b2lDcW15cUtNY0ZzQ3ZtUlZVdGVTaVMvNndoMkc0?=
 =?utf-8?B?ZXhITml4cWk1WDhMeGUrcmt1b2FNdHI2TmdvTG1JekNET1Q2alRQaDA2YTNu?=
 =?utf-8?B?bS9PTFFiY0MxdlVkTm83dzN6S2daSFVRSEtLYVpPdmNoRzdCSHRwYnlMNFZJ?=
 =?utf-8?B?cGVPaGlPaXJOMzdJVkRuU3EzeVZaa3RwTFJlemlwT0d5L1o3RXV6ZGU5RG44?=
 =?utf-8?B?SHRqSHZLbGpuWm40NHJFY3pycEwvSU5QWmc4bFFvc3F2aGRaSG1Lcm9OUlB5?=
 =?utf-8?B?VU9Qd3hSaHlrY29ocTU4ZUQxZ29JN3p5QWNoTUFTdmpGaWhQRWhYeWtEcGcz?=
 =?utf-8?B?RVg3ZktrakRZUFBnYzg1QUlHajFXK1RXY2tJWlk0Y2ZITzJuRndoblRSK3dI?=
 =?utf-8?B?M3pKTjJOV01Hek5KV3dJeXE2RGE1UFE3ejZhV0NZVmlPNmlTeUxKc3BFQ0NV?=
 =?utf-8?B?eERjSTdGV1crQnRnbTExclQ3Y003VWhhN3krTjM0QXFTN2ViTFhpb3VvQjZk?=
 =?utf-8?B?TkJrTnVNQ1laNUtOWXA0WnNwbnNhNiswMDhtSGorL3hicFVFSWw3eDM0andn?=
 =?utf-8?B?R2pLNzV1VTlnMWtRenFaaENKNW1FcFlTN2d2UDNqcGFKTVFySEZ6U3hmRTVH?=
 =?utf-8?B?ZzBidDJSTUhZRzhLbENQcnZWdTdtWEVuR3hVUmN0Y2FnZjF4Q0pFVlFyRExv?=
 =?utf-8?B?ZC9Sa1lVOEtUeVE0cXcrM3lrMUtIYTV3bzZyWVZQZU81T1hNcVc4Wko5dEND?=
 =?utf-8?B?VTNLWlYzR0dmWFlLVGEyWU4zSHl0dUlXUm9qcE1VcDVWK2IrLzA1aHZjdVRO?=
 =?utf-8?B?cFJ1MlZoS1dTcGpMQjduSGJmT1hUQmY3TGlJU3hUNEtTdnp0YW9ZSkJiRkgv?=
 =?utf-8?B?M29CTGtQTWx3ejl3UEd2MkJwNDdHRHU2OStUa1E0bGlYOXRkZE5rdkIrTS9V?=
 =?utf-8?B?MklIUVBPam5Fa0x3N09XVHJxNS8xY21JSHE3bTJGU3d2YjlXbWI0VjdBYllw?=
 =?utf-8?B?OFdyUXRQNkJsVFYvRThzQVB2TkpqdkVaVGN6aHJUbFlaNkpSaER1eklNUkh2?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f32640-d62a-4789-3a69-08db14d8dade
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 13:29:42.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaGfOdOLRrFojN/cwO60/ztsUHOZqF7zF/6MECI/Y9ZsRDx8s0dZalz28DIEF2RdH5CM/SHey9B8y4DDgDM+IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7906

On 22.02.23 13:51, Mauro S. wrote:
> 
> To avoid following Yocto error:
> 
>   do_package_qa: QA Issue: File /usr/sbin/sysregd in package xenomai
>   doesn't have GNU_HASH (didn't pass LDFLAGS?) [ldflags]
> 
> Signed-off-by: Mauro Salvini <mau.salvi@yahoo.com>
> ---
>  lib/copperplate/regd/Makefile.am | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/copperplate/regd/Makefile.am
> b/lib/copperplate/regd/Makefile.am
> index 3b14e9863..590a47c2f 100644
> --- a/lib/copperplate/regd/Makefile.am
> +++ b/lib/copperplate/regd/Makefile.am
> @@ -1,14 +1,14 @@
>  sbin_PROGRAMS = sysregd
>  -CPPFLAGS =             \
> +sysregd_CPPFLAGS =             \
>      @XENO_USER_CFLAGS@    \
>      @XENO_FUSE_CFLAGS@    \
>      -I$(top_srcdir)/lib    \
>      -I$(top_srcdir)/include
>  -LDFLAGS = $(XENO_POSIX_WRAPPERS)
> +sysregd_LDFLAGS = $(XENO_POSIX_WRAPPERS)
>  -LDADD =             \
> +sysregd_LDADD =             \
>      ../libcopperplate@CORE@.la    \
>      @XENO_CORE_LDADD@    \
>      @XENO_USER_LDADD@    \

This was heavily mangled. Please check your mail client settings or use
git send-email.

Besides that, some explanation why making the same settings
program-only, rather than global, would be good to see in the commit
message.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

