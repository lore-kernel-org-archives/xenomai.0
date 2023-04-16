Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763E10FB
	for <xenomai@lists.linux.dev>; Sun, 16 Apr 2023 07:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqQHr5gwGf+SvKz3tWzIt90zF7KX3t12+9P/YTqSMCdOxQsU9xpDlm2Sziiv0rLXPRj+HTb8AdV4zV8U6iiewqZEkbwCovJxVEZMk+ZdCIAGoeyXKH0HFqmomfaEHFLe6I7Lv+GuW2j2NJl+aCD7mB5lRWnCUuHTQbPODEXoGRmXWBoXoY2JErfm9pL6bQM6oqo6VAnMzhb3BjEydkcnd5zFSmWnKwXUvp2t5PDu98NV0HtIZ0kj5J2lyPvSQGNKE76hf3AETKEnTr/YrTM9VQwGglc1I91HTnl3lEAgKc99DsYgDKM9C4cfnxD3PRjd2MqUmvg4whzcmIC6KNbygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DisMPx+okGqTQ/EzkbhGdoi0UyUON4WblR4MsQqR8GU=;
 b=LzvzNK4rN5gDicv8sNFvHbG3ct3ZQOncUeVKgQ3/CKp+aXEviTJJ4xFNkxqQIM0WxKOORO4k1paSmn1qWd14Itm0B/QteYCWSm+7vdcqDT+JqvzlQJE5Tctf9b54FHgM9ypJxvw1tbo1c9IIzrENwtFw4nVFw+ugrEiUwJe/jrT+at0c6RlGPI2qHpN/SqoSIfbTfMB1Qz/PrAIDs/IYaD5sNuQ2CPnAJaEoCKa+OKjkRcE5XPT/62pmP2cUIoOa0ZLFW3QsthZw3zpO+wUWHFHMOvL0oOaNKoHA3KKfsIFZcuOwUo1+dbgMugGSdwAf6BSdsQuTLHxFX7np2BzG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DisMPx+okGqTQ/EzkbhGdoi0UyUON4WblR4MsQqR8GU=;
 b=oWclIr6nXm3EbT/EzkHAaGJgH04JCYugZhE0fNEpZSB20QS+ABMiA9Ka3Bn0X5TCw37vNF96FrI2zN8/76OAeV7z8HvuGvflPY9d/XUuvpmGMDvgx4dSb0p5CwtDkSlR1o7rpS2gq1VwyQoaWpCSRu/zuSxi/JtRNNkaPzvLQwB6ys9QH+fqUjHtA4P4QwMg6JsvfEmoX9q1YWu2ysnBMWgYNG0A2UxpyCjXNyWQs1a1yOOWtafpnhK4MmEWQXc/4waUUC+308FDTYCI3ND6Sm8Xe0Ean+FaphCxTizyFPhKEMbUZDgrzlbvLYyH0yBCQp3fGvJWgrJ3fViONld0XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.12; Sun, 16 Apr
 2023 07:41:50 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%5]) with mapi id 15.20.6319.004; Sun, 16 Apr 2023
 07:41:50 +0000
Message-ID: <0443c031-46cd-de1d-6d16-acd656b90832@siemens.com>
Date: Sun, 16 Apr 2023 09:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 0/11] Revive alchemy, pSOS and VxWorks tests
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at, florian.bezdeka@siemens.com
References: <20220413215819.22954-1-richard@nod.at>
 <20230406103341.2914-1-aaron@sigma-star.at>
 <8ee4086e-580d-3d15-cade-4d983c86e402@siemens.com>
In-Reply-To: <8ee4086e-580d-3d15-cade-4d983c86e402@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 802b32f3-403b-4c68-f530-08db3e4e0a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BaFvzwJIP2w56KlNpcljU0Y0ml0sPqP5nK0Fth0mwvVC2WUGvtIJIAHdH5Hp+V7iewC6HDoTz+nze8SMXZe6SwiMQsEZW3yroTfAiurtAP7qk+HMJWKxN8V8aI7V5hTjMnSdUgteNH3iWBZTuUsLOLlnBSucVnyc0Cx13FYDGeuGpqG1dkan84D+Z6Qh/WwGM3YbbjssV3/RQIIcJ6wvr5fmYrK+TDsJ8dM9jQR+JV/0X7VrMTGHihrQQKZ91nZQlSj19ygzsY7tFseQaq5AshRVn174fl4IYYsgaV9xjPGM8lcc6x7E+NtnNVkFu8xKCqF5E49tR0CzPgm7qJRM245yCXyVXna6grTjEsrIpKyAdlOl3B3lWPo93OXMAjK3CUfnqAe//htn1Pr3W/uyYIEhaHqDnapgtlAXCVThDOh+LitBHmEIm4lTFLOGc66RaMf+4pD+c/wIinrlC0jN8ukZNH/pvLWcLv2GuJDwfIP5p8xOm6pny63rWJGPXGcM0glM1vrE4G6Yr9Jd7SKrkpsFi2QfP9BzxdSaC3MpGgz1uilB3gVsngphKLzqURnQ2t61m1y9rMfwgFGvRujn1qs9uIWzncjEWC4KE7GhYf0/Jk+uMwq2mgx2Pwo/lK9GH4SpF6bZoNv5EwRKLVDERA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(36756003)(4326008)(316002)(66946007)(66476007)(66556008)(478600001)(6486002)(6666004)(8676002)(5660300002)(8936002)(41300700001)(2906002)(44832011)(86362001)(31696002)(82960400001)(38100700002)(186003)(2616005)(6506007)(26005)(107886003)(53546011)(6512007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXAwME9TOWJhQnF1VWJEMFFaTjNnU09PQzk4ZUtKRk9MbEwrTjFCOWZzMC8y?=
 =?utf-8?B?UWNpVVIxdkJ0T0s4djRVc2F4N0RJY05TUFNxSmdqbHM4QmJsZEZmSFJ0emFM?=
 =?utf-8?B?K2d0cU5NM0cvSWsrdUswN2owaThjS1c5SUNsZEdyLzM4ZS9WaXJ0V29xdCtv?=
 =?utf-8?B?NGlRRmFHRHdocnJCVXd0bWNXYjlUQUdkY0hEWHJPcXJWdVY3dGJBZ2RPVzRM?=
 =?utf-8?B?TTk1dG9sempyVEsvK2E1OHI0NkVJZjljQ05Va25XVzRCMDU3VkxtSkE4V3lH?=
 =?utf-8?B?bW8zQVRRbjZpTWRsWnU3WlRib2h5ZzZENzIybEM5YllYVHZWUGRkem5KTk5G?=
 =?utf-8?B?aDhtNTM3eDU4TkhCaTBFUzdXdWMrazQ3RFhpdktRdCtaSjVlTjVML0dlQWVD?=
 =?utf-8?B?RVRTSmZpc1BwM3Q0NkJmbDR4aTAyVWpaRTVsYmZsakNZbjhVYm90SXZBdTZm?=
 =?utf-8?B?WitEZFFueEw1RlEyZWQrSG42dzN3aTJETTVyV3U3SlVzaFJnYm1RbnNSejAz?=
 =?utf-8?B?TnhLamdvOXh2djVreEovcms4bTc2c1Z2VXFNOE1UMDh1TXplSFVKSUoydEk1?=
 =?utf-8?B?Y05xSUJLSklhTnBsOFM4TFVXbE9GK1JtbU56RUtLMGxEZERneXdaeXVDc3lN?=
 =?utf-8?B?b0IrUFM2NkRrN0J2emQ4MDkvM2ZLbXZvTlViYWpPZkdreGFNZmpGSVU3dzVU?=
 =?utf-8?B?VWtqY3M3dWhaUVhSVkdDMDkzRG9zNDgxMUFjT1FZQWZHZ1FDc0JLZ3NDSWJZ?=
 =?utf-8?B?UDJ5RUYwcnZWWmFwamxHdFV2aVFhRGFTajhBZVhDM0lLZm50K0lyWUd5SzBz?=
 =?utf-8?B?bXNjcWtVUlZWWDhTWlNRU1h6ZU1uOWF0TEdRZlRoK1VnVVh3NmtRMjRMamM2?=
 =?utf-8?B?UzRUK2pWYW41amRPQzZXRitoL3M3YjRTUno2NGxXY2ZBRldHTVRacVVsaDhD?=
 =?utf-8?B?bTNOWXE4L1ovYUg3cXBjMnhGQm5oMklKc2JLNTlBYjdOOVhJeEdLK2tSNURK?=
 =?utf-8?B?dzlOL1VYU3hkZVhQb3dnR2FleWJEK0hhdTNVZUFadmhnUTd4TlBQTEx4MjZo?=
 =?utf-8?B?cmdSQUZuTFFuaXZOOUpwWSs1bTRBdjJUcHRtNmYzc0kwSnhrMHdPNnluNEFB?=
 =?utf-8?B?RXlaSFh3eWY0MnVyZFFadG4rVkc1aFphYzZ6T2RwTUV1TlJwZ0tGQktMNGxV?=
 =?utf-8?B?dWpKL0NrVEpobE9CN1FzVlF1RTFRRlc0bkw1eVhyUlhLTExJSXNJQTFCK2dG?=
 =?utf-8?B?d1FXaWxScTlnRVBjUjg1R0JsMSsvT3hwVGpOSWwyQkYwVUJFblRXcWFkRHhM?=
 =?utf-8?B?SzNTUWdOQzNzZmFKc0NVQkZJbis5ekNhMFRPZUlmTTRqTGdSQ3d6dHp2aUlZ?=
 =?utf-8?B?dmxQSy91cGJES3pJNXhQT0s2WXJ3Q2s3ckE1ZXlJV2g3OU4zeFJiQ1FUdXBt?=
 =?utf-8?B?aHpVRy80c1dYbytqSkdGVGJMQkFsNTBud2xreEx3dGtsQ01PN1RGMDZ6WlRt?=
 =?utf-8?B?RnNVb0o5cWNQeDBKcjlnRnVYM2hMR0YyVlF3Q2drZ1Rkc2NxWnBDZEQ3cytl?=
 =?utf-8?B?UEt1V2tmVFlFaVgxNHR4QysrWVZKb3ZwQVNHVVRSQU1xbTdsSzd1Z0RDU3NO?=
 =?utf-8?B?czJkY05pa0h6UGNHcmdrVE5FbjNMQ3dVSis5SGFDWk5KVUNXWTBuYnN2ZUI3?=
 =?utf-8?B?eGxvcnFaU1BraGdiK1gxR2RFeGRXQzhkZmtUM0YyMkVxQkV3bGZqc0dmOTRi?=
 =?utf-8?B?Sld5Vy9rbFJ0eW5HampiUlovTGgxSzdtTllHZkdqRUYySkRBV29jMnZQU1ov?=
 =?utf-8?B?aUNLZzdzczBZeTZ1V2Nza0U5SGlMV3hqMDdDRGhmd04rYWdEZ3RCUmZwaHlH?=
 =?utf-8?B?VFFJbDNYQjVoajJSOEhsZlgzTHZIUHpObnEwNlVxR2l1M0F0YmhSbVZVUkJH?=
 =?utf-8?B?K2V1Y1NKWVIzRTkwWkpaUGVYOEZwZWRXb3ZiTTJRU3JBRWZaMW1wOFZZVFd5?=
 =?utf-8?B?bjVYcHNxcEt3YmVySkpuT08rM1pwTjBlUXlJR3ZIU1J0TFlMa2VzQWNmU2ov?=
 =?utf-8?B?UGU2SkxqeEZiOHhETloyTElFb2hjNGg1OUNLbFIxOEFrblVMejZJNERxd0gy?=
 =?utf-8?Q?aJNW09u2MpKtaaH3WOEbWSpbg?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 802b32f3-403b-4c68-f530-08db3e4e0a30
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2023 07:41:50.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9G6R/pTDlXtBGwsHL7/wa/cRLEiCfGWaR9/eXvaOdnoca0hcyHD2RAcJ0vbDBjLd6bcsT7w0MfQ157K38DJxFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7908

On 16.04.23 09:32, Jan Kiszka wrote:
> On 06.04.23 12:33, Aaron Marcher wrote:
>> This patch series is an attempt to integrate the currently abandoned
>> alchemy, pSOS and VxWorks tests into Xenomai's test suite.
>> Since each test assumes running as own process a test driver is needed
>> which executes each tests separately.
>> The driver makes use of the smokey framework.
> 
> ...but it does hook up with smokey, thus will not run as part of
> xeno-test and our CI. Please fix that - after either resolving the
> remaining broken tests or disabling them for now. It should be easy to
> spawn the new tests as separate processes from a smokey instance and
> visualize their results as part of smokey.
> 

BTW, mutex1 from alchemytest fails for me, all other alchemy tests are fine.

------------------------------------------------------------------------------
[ ERROR BACKTRACE: thread taskB ]

   #0  EEXIST in rt_mutex_create(), ../../../lib/alchemy/mutex.c:148
   #1  EEXIST in registry_add_file(),
../../../lib/copperplate/registry.c:239
=> #2  ESRCH in pvhash_remove(), ../../../lib/boilerplate/hash.c:436
------------------------------------------------------------------------------

I can confirm that task8 of the psos suite does not complete. And the
vxworks suite succeeds here completely.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

