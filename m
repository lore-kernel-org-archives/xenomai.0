Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040118E1B
	for <xenomai@lists.linux.dev>; Tue, 26 Sep 2023 10:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuLsRtdSuhZbSvBAiAjfn0flY+bN2F+NuiTkJqsOQEI4lKYPzre2/f8F9bx9AGkgUvdHfdmlT+M92r7HA6pi/4IDsnaBqEhhqUXv2ycAZz3MYQ0mvyix6BUaF4zQTdPOcDTMPpvP79xBNRHNiUE0Zl4nbyQtIXBCS0cvqy48d7fLmgOzZyXWpRCgFDUky9dCjr4gc8KKz0n8bwUKAwKV2/sHFTBwYEhGxJ/VdhpZYxNRToRhwITIE+2fyxyiQW0zUq+457E05WJolguG9siXshttNVXeF5fmL2eV9XRU1YxDG9NQL39jKzGlsFh8cP+IJbvDH2GnCUYVQ6p3F0dHtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWbWXztZCSCyTy6cuIYWUUYgIyP0QqIaIOooSQ9qCc4=;
 b=MDNASJiiV5gzpLicT2ZUUwG9N3NVdotwLRIdQvFZ4/ld8YCM6EC83T8vN3lJEAKIZvrpHWf0XoX5jtvZ320zjuN+joj9ug2XJM3B4C7qVQzTFjsPbl6ed95xenq6RN5XgilfioAtlpqZdXdM9EjXNR4Pb4d5mh/bGyaQWcIyC/wSgX+YmfeBzG847KQwLYc3sQKY/f4dYJ+teuAn8RUlZNOaxqg4NiuaN5eS/MA/2HQ5H28whYVhy2dmNvja/BUdRYseX1QXwKZ4tBB09DbOUX/Zr8EaNRBngc8ro7gekUushKUIAnKgNjtKkY3BYDOqOO0Ev20pWy1OLG6Alvf85A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWbWXztZCSCyTy6cuIYWUUYgIyP0QqIaIOooSQ9qCc4=;
 b=ACJ++7PCkhhOeirFIX+jfSvTZ5NKDvnKuycO2cW5znfojXWS1ECVozu1djKzj7DiSiEqf9aLLboxDMVF1A5rnkAu6OnSt3hXIKQSI1qropwUO32yrrrBr3YN4zCa/bEpBBYXulwYbMbw76y7mmV0XVALMj3Fbe6SPhDeJNVbokwdCHJbpzSPy2EVTpdW/OlLpOyJ/ZjBoD8BZaEEYHglipAryW6ixXtrHU7l5Zxp8NPPHH9Cb1o7ZOY84DlHKamNVahqK75OnDKawF/qBQG4nYVkPOePRmbSZegaZpy56aY2iyRL9FCTfxyK4rDLAnC2Gjb66XAhwY0rNCSr/l92TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:59b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 10:00:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 10:00:38 +0000
Message-ID: <391a0665-1236-4ace-88bb-33e206ed4b18@siemens.com>
Date: Tue, 26 Sep 2023 12:00:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Shell command segfault occurrence phenomenon when xenomai task
 switching running
Content-Language: en-US
To: =?UTF-8?B?67CV6rK97ZuIKEt5dW5naG9vbiBQYXJrKSDsiJjshJ0g65GQ7IKw66Gc67O0?=
 =?UTF-8?B?7Yux7Iqk?= <kyunghoon2.park@doosan.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <1695706251-3997-mlmmj-62db5be2@lists.linux.dev>
 <PS2P216MB13306DDFC18190667DEE0409D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <49968ea8-1651-4bf0-bdd5-b3e3dbe252b0@siemens.com>
 <PS2P216MB13303939F1828F55FF296B3AD1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <78d7a44a-c84c-4a36-bbb6-fc6d7a3bb3b5@siemens.com>
 <PS2P216MB13309086E38D6FFB0E59C2A2D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
 <41ce2ea0-5e13-4c4d-ada9-9c9f5c296e0a@siemens.com>
 <PS2P216MB13302E4AB022FA29FAC6E510D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PS2P216MB13302E4AB022FA29FAC6E510D1C3A@PS2P216MB1330.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 93923931-d064-43ae-351d-08dbbe776fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s5YniI3x8lhuXP43S/yHcti37mwKdvJUqH7vM4jFkm7/6rvX5M/Pl2l8do+Lh30/x548SVSdFNrODLxZdCTr3y8DfGraNfLb+3E7sj/AttcrlfnuDzR06Smuszfdvy9nKQvgmBM4Tillb3lR2bQYSSdbdf7Hq9PGbUDHoW4ZXtpHl6/DE/ZDfbhlAWKcWl740ILOUUyRTPA1US9IdmLnsDYYoyQ9OEbYRSPpVZtq7pHBUzsbnQOIl4Roh+cFKgkwzjMQwn5L/ql8Et5YO2Q0MHC9zW5OCyyWxorUr1AdTGaIDP9jcCz2TCM/Tw/M1syKd5cPbZTOj9Nh5L8AWyx8cwlxWPcdS9ZiJRB9U3pdhNVnCWbVj2JORlY+67JJpth800YIrMtWODoC9M5dzljyRx4/w4TF6pjJJDkAyPUIXE4HqV6WhC2YgN9tCdjJnIWLX+nEOUd2A9PVKQ99KC19aFCA8GIzpgkYLVPebJ0CwH9BXzQ1fJ6kHxZgsXVUuCn9WSf30SFce+huwbSgcixo7a6N20/o73mGeJXvECO1eZBo58uDxQRVih58z3C45JUyB8kloz+eUecINKCh4Yap5WgKY8/kkpGF7OhHtc4aOyDU/uF06mnQiuPkMh38DFC0vqYbr+vHCd8l6JWBk6V8zw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(86362001)(31696002)(36756003)(31686004)(6506007)(6486002)(5660300002)(6666004)(26005)(53546011)(6512007)(66476007)(66556008)(66946007)(2616005)(41300700001)(316002)(44832011)(478600001)(8676002)(8936002)(6916009)(4326008)(2906002)(82960400001)(38100700002)(83380400001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YklpYjFNMGZRdGRmMGFNSkw3NUd2MVdiN2owR2JHVHNDMW5BbDZpSHR3WTh1?=
 =?utf-8?B?SjhQeGwvUU02cUhBRFE5R3ZERnpBWG12SXROVXE1NWsyRjViUjIxcldKWEQz?=
 =?utf-8?B?Y2xvM3k4Q2FhQStuMzBuc1VFbEUyd2FTQmlNaUpCNjZMdGpmVU1zdmEwQzhN?=
 =?utf-8?B?ZjcxcjJMeFVDWEFPZTE4NjdLRFZ1WDlmdUpyKzJFaHZ6UVBKTGZrVDBkYXRV?=
 =?utf-8?B?K3JCcG92dE1rb21kNEc0U003Y2xhWUJ6N3dPOGxpTjVHZ1M5Szk1VkxDYTRX?=
 =?utf-8?B?bmJoRGg0RkZRd1ZQeEh1Vm85YkhZcHp1Ri9tc1lycEpCSjhSME9PalBGNVVF?=
 =?utf-8?B?SHZuNGI5TGdNTlVtUnJEYkcrN3Q1MVpiTzVSbCtZMHBsL3g0SXQzejZjK0kv?=
 =?utf-8?B?Y3J6Q2VTVDZwaXRoYTdZVzFwWDZCWHpRRVVYazFrR25aZ1VtVDYxcjhSSUdq?=
 =?utf-8?B?TVovbDgzZUpkMFRlM3RyUjc3cmJBbEYxblZhcW5JTC9SWExpczN5N1BGdWxW?=
 =?utf-8?B?RUlkcUdIOWZ1bVIyanlIQlhCeGxIdmZpUFBKZjJEYUJUN2dNTmgrNkZHekpJ?=
 =?utf-8?B?ZndubzRsa0ZaY0t5amhOdGc5WWZ4MWFLM3lKTjNFMkNmN1FibnZpSVJsbXdF?=
 =?utf-8?B?RzU1SEtnWDZoTGU5cjU1ZFVaSnVWV2xGbHh1NTNFSXdYU0VqcmU2NXYzbVIr?=
 =?utf-8?B?aTVmaGs2a3pPN25WR1NtYVJ2Qk5HVmZoLy80Uk5NaGRPSURHeWRuOHhldjdK?=
 =?utf-8?B?Y2dKcFc0a3VKenhRZkJ5TVVRSnNtRnlVOU53SHpzTEJCeCtMbUkrVFV5amNV?=
 =?utf-8?B?eC85ZGRvVFVIdi90OEIzYXQ1QUxzazBESlJneXBFQ0ZMVCtnRVRqcitUby9Z?=
 =?utf-8?B?clMxRjNQV28rcTVpREhxRm9saEcwU25kMStBZ3I1aUdjSGlsS2trUW9XSzRI?=
 =?utf-8?B?ZzFMN0ZFbjdXK0NlVGc3a0wrVzUzV2VVQzRobEhOUG1tQUFtNFRGcmMyVndy?=
 =?utf-8?B?eVBPcXJUWkI5K1ZuY3AzbEV5azUrbGlWWHFQWGszckE1WUl2d2dBRVlibHNt?=
 =?utf-8?B?R2NNU2VobE9Qa3d4SjlPVjlxK0owcmlCSzVpZ08xSnpQNkRiamVPU3pTVEwv?=
 =?utf-8?B?KzJJMmZhQ3QwRnhETHI0WUhGRDI4TXlpWUhUOGtlSnlVMFNkTGgrNDBPZVE3?=
 =?utf-8?B?TEpnVmk5S3NMdVdPSkFMMjk4TWRpSXFFOW4xcjMrMCs3YWNmT0h6Z2I4QjJP?=
 =?utf-8?B?ZmN6YVJScktNYjBjd3UyeGk3bG9SVGNZb1ZQT0NKSndmQURhcnptbWJwM3Zo?=
 =?utf-8?B?dFVwdW94dHlwTTIzVFFtVDl2b3JLdDkvbm83Y0tiMGlBcUwxVndhWlN6V2hR?=
 =?utf-8?B?Q0lqKzM0QjNyYWZBeGQyR2IyZ1RDZ2hjZlY0Z0FLSUY2cncyR0ZsNExYd3Vq?=
 =?utf-8?B?UG5xeXJwcW5uMFFGWEIyd2NyQXArV3FGeThsNkwvaElLUitHUHArS3owK25q?=
 =?utf-8?B?R0RpTmREUWRJYTZlWnlXZnN0Y0tERkFrdkdVdlI0MjJXazRtN01rS3lzVVRn?=
 =?utf-8?B?YjkzVlZPT1BvNXFPOTg1azF6Z0JDckk5QTBIQkFGZUJDUjBDUFkwdXdIaS81?=
 =?utf-8?B?NGVPOHJ3dzdwZXhEZ1VHQzI5YWZPWW5wbDZvUWNDSnpEcU1oeGd5UnJpaWQ0?=
 =?utf-8?B?MDFCZHJmNjZjWmhLZHNoSFltaGRBVmsrMUtFbTJvVkpEZmpTbVRPdmg2QXdL?=
 =?utf-8?B?b05pSDYrc1dDZng3NHMwc0lBZi9TejFUMmJBQXR4YUoweGtEcnFQb1d5SGlu?=
 =?utf-8?B?ZXVobklmN1l2dEQxU0dLUlJqeDhLUXhLWnRqdkJMYXVEL2taWWVJNys4TWxP?=
 =?utf-8?B?Mmo5RkZSa2pDenNMc1JQVHJlRWRhNml3TkVjbnVQbDdkZDJIMnh3WUloWGx1?=
 =?utf-8?B?Wk5NZDArMWRSTU9ocGtIT2hLUW5rLzdoUWNrbHFrN2k3YkJPK0krS3hDTHNq?=
 =?utf-8?B?MUV5Yk9PTkNXRU0rVGF3QUJZZ2NhZ2pUaEYyRllraUdJNlpZUUZzS3c4MUZ5?=
 =?utf-8?B?N21LVklOeVBmYWZmSER5M3Q1SjBscS93U2l2MXN3dFhCR01mUjFSblkyUW9i?=
 =?utf-8?B?ZitxS2JUbmtGUGhtbnRZYnpJbGNWN3cyck1HVnQ3bFZzenU4b1Npa1UvV2Fk?=
 =?utf-8?B?UHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93923931-d064-43ae-351d-08dbbe776fa7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 10:00:38.7765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUgSDNjukRA+zC+C0cSsE/aoMaEYKxbFi7WQmp5MiUuipdRitD5q6JdNdvM8H9v7lNYCejEWS0rYmZuna8lizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7021

On 26.09.23 10:37, 박경훈(Kyunghoon Park) 수석 두산로보틱스 wrote:
> I met a build error as below
> 
> 
> arch/x86/kernel/tsc.c: In function ‘tsc_refine_calibration_work’:
> arch/x86/kernel/tsc.c:1373:2: error: implicit declaration of function ‘__ipipe_report_clockf                                                                                                                      req_update’; did you mean ‘__ipipe_report_cleanup’? [-Werror=implicit-function-declaratio                                                                                                                       ]
>  1373 |  __ipipe_report_clockfreq_update(ipipe_freq);
> 
> 
> The macro "__ipipe_report_clockfreq_update" is defined linux/ipipe.h
> 
> CONFIG_X86_TSC is enabled.
> 
> What's problem ?

There are two

- you are building with CONFIG_IPIPE disabled
- our patch does not handle that case

We will address the latter in the next I-pipe update, but you should
look again into how you configured your kernel build.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

