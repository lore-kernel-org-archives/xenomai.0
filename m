Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A3246AA
	for <xenomai@lists.linux.dev>; Fri,  3 Mar 2023 12:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LybwFObzOZ6i/AZXSxTXz7oWxF91qvR62r+cpOPiiidXoRyaqwa5kQt5IjBci9ZCPTDQmUC0IL/82Fsg+8n5XZLigAalWjKqBgapjmyynNcNmY75Hygk4QVtsQdC+Oca7guZZqla2A7nYbEnZsBXPgkhR8KFsbwEV3WjoY2e+U9aGSMtmrbt1janF+IytpHMzuw7N+rMxtG2VWRRLeGaQrZlT/LcDJzAuvlc1k1TvQNBbxBiW+BTy3jyKlPPJfEsLvqLfnq7Bwhjr2/w6SH7Z3WWNa5ihvdUVWQAsEYGtK5IrzJ2kEWZKOAu1YdRm1cN0uUuDXvizKxh1ZzcXLTSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgNOV/1GNCPcNtGcpnW7xeSO0k3i0f+YwgQ37FVJbwo=;
 b=ExcEBlfsS9G50AlTy6Gb7Q65BZD0d+DvU8jdlaPlcPu0432T/SYv0LhT1l8x8y/MbAnEpjYhYimXaYvVW+Bv9gkvAjoMHGWUo1di/HQmz9tKhdX/v09eQqvPkVEPaOX2w4lo133jL8NKrzkK51kQv+ArQdakiVdqBWHzS+FN03oTFLgT9a0EYoC/Vd/NOtsUHFFqv0fSE4y2g345xfMxk+InUv2joiemn5A409PkJflflnHw+XLqC1wMCfAJo3WE1EoRlLUwc6emxFRyKFL+1WRH0nluWO9x18TtZsEJdJ9Je3kYHcA7olFIr/NmUh6w7xCFBGHJL2bSV2Rqalb8oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgNOV/1GNCPcNtGcpnW7xeSO0k3i0f+YwgQ37FVJbwo=;
 b=q5ec+6yj1B2RVSochcpPXMaPRkZ2l+Fv8v/0WDJpN6RYcbgFf4aGujDkIbF3FJNuLi8+v+AHVxk5Cr0sSun3tQDWkdqIetCgMfQhjZTWGfTtR4pfL9thHg86YeVxFkp5ee0FVpTALrffB9imVbrLBDthMWcUUPCYqPpHvmUMY/036tiChleNHrJrD2kY+J+cWOFVe7+sPdvOR7o8d4E0u6vTpR5m/1x3EaoAnqS+vocJjMQ/NOaQunUGI90PiwCdImTC7RkzuoOIl6BtvdR75qCzRZi+2yuDPI2KhSKVSvGAkNCzi2NaTTwS7xydsauTXkA7sL77f2WOLW4a9VnNjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:633::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Fri, 3 Mar
 2023 12:32:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%6]) with mapi id 15.20.6178.007; Fri, 3 Mar 2023
 12:32:19 +0000
Message-ID: <39fb838f-6c4a-2bb9-3d7a-6dc65a3a1e11@siemens.com>
Date: Fri, 3 Mar 2023 13:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [xenomai-images][PATCH 2/2] ci: Limit ci jobs, remove qemu compat
 jobs
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230228104434.15829-1-florian.bezdeka@siemens.com>
 <20230228104434.15829-2-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230228104434.15829-2-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0057.namprd07.prod.outlook.com
 (2603:10b6:610:5b::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0e9968-0825-4ede-ec60-08db1be354b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1CMVnQQhYYXGyo+2j7os9dCOgKFfABBnZ7wKTYNJtmW2rjGEg5tIMReypD4x4Ev9lmEj7qmOAYU0c0hdMsAPGrZXlH2vnZnbgb9bWmlEsNRUKnH4mf7Or5CjASMqFjFYLuq3F63Aw2aAKyei2NEle/OppZTktEOWtu5a4OUU/PPNO18itGtl85x2E0zYcnsiooS3VakM7cKj0s7dNcZGNip79c5YPxdOIT8VGnW5bSGNJYXFmOH6b7QQ6EXEVY5Sd98M1v/mbmeqCnJMW4Tu1XxsIXhn/tSmr4HGt0tKdYUXR23pMQL5RFgCNIfwkYtcr2dw34V+muTMPvVJ+gFT8L9lIEFM+aRm3o5rBqc80MJqpxoTxEidQ130c9yGQBiV4bH+ohZglnXzwwwY434viVWFDlFWSuRyupcQm0wxvZJ5UIAmiWGpsX9f8BuSQ1zKrSlSsmqTo28Eqc5FzkdGOEDHGQiR4Ok6hLSRiYHQCVhbwhVk1nYIUwaxLMaSVE3HFxL6zKyptxPFkJbn2Hir4bJXJ5IXqDsAxVDpKaGcDHi2Ey8mVTfzZUlLlmX4BMkUwf0IJzn8HYnTP3NP5M01IpqIZPa9RiVs9KrRUEDwpO+LYdnoaWhJlPpM1ReIiowBX3T976PijlEgYXdfjERUY8Os71+uCmI5L9JjUQ+R68dxHMfMt9ljd444XJTIVbMs2IHGdor6voR94urqg1lSVCXmjmQpCYQjkD4nps8uy9g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199018)(5660300002)(44832011)(8936002)(86362001)(31696002)(66556008)(36756003)(83380400001)(6666004)(6486002)(478600001)(66476007)(186003)(8676002)(66946007)(26005)(53546011)(41300700001)(38100700002)(2616005)(6506007)(6512007)(316002)(31686004)(82960400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wmk4L1hEZ0g2R1VCL25mdmJKOUd5WTlmUXNPRlFSMkZCSngzb1lub0UwbjNU?=
 =?utf-8?B?cWduN3lmRzM2T3gwbVJjYjNrR0lUR3NsNTIzek95NEIzTmQyVmp2T3JSQ2Jk?=
 =?utf-8?B?ajM2c0xWdEtNU3RNSGdyQWE3MUhaY1F2dHdDak9NZ3Q1SFNMcTE1TEg4ZGFx?=
 =?utf-8?B?RW9abWMvUlVVaXpSSFNsQXkxRzNJdHdHK1ErVUg4WVh4NlZobU5panZpQTEx?=
 =?utf-8?B?bVNQc3JLNmU4L3lTYmgzazVSeXlvc3pTZGwxaGJjcG5XbEp3WVBzNnJZTmlq?=
 =?utf-8?B?L09jZkFiVE5XWHl3cXl6czB2UmFleGJBN25uaGdXM2lmTGxQU1J0TW9JZWtJ?=
 =?utf-8?B?L3A5c0JrU3dtTEtCZ3BrODlpTjlRSkhrcXgxQnUzRmh6Q0pUQTJKenVFdVFo?=
 =?utf-8?B?MDBKVVcvVDJJZDMzZGVKQ2hmZTh1VmNZdDZESEZoR0MvOVorZzdLVjFMOXBi?=
 =?utf-8?B?OGtQOXpGS2o0dTZsY1VFN3Z5WmF3YzZZdnV3MDVvWHg5b04yZld1bDV6RnNG?=
 =?utf-8?B?akp2eG45WFlMdkczSVpJUk11S051TG9rR1FyeTRlVnMwOWJuWHpLZDZ6cVE5?=
 =?utf-8?B?d0NaRVhEWE5Ra2pkaXFydytTeW5xU2FnQnhDVEJlMjRZVisyTHEyQS9Fa1FP?=
 =?utf-8?B?dXZBNEJQRVpGNXJ2cC9ZSzdNOSt3dkxBQWJySEhWZU55bmlnUU1VN2JMcEpL?=
 =?utf-8?B?Q2swc0lxZlEraXF0Wi9HeXQ1a3k4VmhqV0lRVHkwRTFkcUFtekRDV0pxRXhS?=
 =?utf-8?B?UWRFZUs5R2pkZUdWd1VBYXZJQm5VZXRkUC9NVzk5b2EvallrUXFOYUh5eFJa?=
 =?utf-8?B?N3JlQmNFZlZ3bkpZblVwOVhKSmJubkJ4RVpjeVViaVd4cTBtN2NwaFJuOEQ3?=
 =?utf-8?B?N0xYK05TR2pPb2hQNkxJejBLTWVEUGVTYjB1UDVpVndPL1ZhYm1VOWdYSXlq?=
 =?utf-8?B?VTlLa0xQVzZCMXNqZjBwT0Zpa3ByWCtuUDVISlUzY3RDRGVlTzVlVTdZTWdw?=
 =?utf-8?B?cXVpZGdVK1VuL200dlg1eG04b3hPRW1jK3pqSk53TzE5eDgwelFGNmtLT3pw?=
 =?utf-8?B?R0JCekcwd3M4bE9NTFBhdzVxZmUvR0Qxa3U0NzZhZ09Pc3IvbmRDWnd2NFhI?=
 =?utf-8?B?eXdYY2x6SExndjF4aGdTbTFuREFieXZsd05xOGZvbng4ZjVTcUlSaEFqZjhv?=
 =?utf-8?B?RG9TZ1krUWRRZmZaQzg3NlV1eWxpSlI0V3lyK2x5NnlhNlFNdS9KczFVMk5S?=
 =?utf-8?B?R0hhbmtoUkpDc2hXQ3o0WDBuSVBQWGkvdlFId1hTRHhUbnRiWEN5MXU5SU12?=
 =?utf-8?B?TVZLQ1NNdjBhQ0QwUFdlUzBpMkhVZlJYY2JtSzdDU01ZVGZpVmRaOG5MQm1N?=
 =?utf-8?B?NzlYWVdUMm90R21ieGo3M3QyVkxjbDVpSGJFaFVjVXJDQUozczl0dzlKL1A1?=
 =?utf-8?B?YnpOWkhaSFZwRUQrMzIxbkFRNS9DQjZIYTh3b2p4dFZEaW1MclMvQ2dkekFk?=
 =?utf-8?B?cHJLZmliNXRXdUljZ2xkYW1oczVTODhtaUNVRGFmSFlZOFQxOW1RV0UyWXB4?=
 =?utf-8?B?aHZ2Q0pIUXdMZit6OGZUcWpLU2NPcWFQRnY2S3V3aGdPdldWUXArakRmQlhI?=
 =?utf-8?B?c3RCTjRNa0U3T0Z1dStwSUxxeUFCNHZkeExKQnZjK3VJRGd2bUpOS3RTcnVW?=
 =?utf-8?B?RHVUN1kyYzk5OWkyUXlEVU1mcWFHU2doczVaSkROZG5mYXBSNjZFMGhyTnV6?=
 =?utf-8?B?c0ZwR1YwRXFvWnpMdGVZc0k2WWFSOWVjaTM1N2ZWdVo4SitFdWxpYXo5SFVi?=
 =?utf-8?B?cU5zU0drblRkeERUQW94N253N0M2TjFnRHk5N1ZkWFVVTDZGeS9QZThlR1di?=
 =?utf-8?B?MHlhYTlYS3FzRzRWUjE3TmU2OXNtUWpZcnZlWWRIVnhYQThhdkJ5emlmRG9w?=
 =?utf-8?B?K2lWc0kwMkltTDl6dHNqMUJhOGpEb05kSW8vbkExSmpyN3RTaElOL1lTRVEz?=
 =?utf-8?B?TDI1Q2dGaEV0SVRQb3QyamJFVjlweVRBbWxxR2VObnZzeUlRQVNQWmFndnZa?=
 =?utf-8?B?TkZ2ekpzWllrUFFybk84N29WRkhoVmREN2xvUlpZRHpDcDUrc21kN2lOaXM3?=
 =?utf-8?B?ZHFPTng1ZUZqNlRxTFRKU0RJaVlEdnpDVnhRZlJqaHFxZTd6dG9ZNktYL2tt?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0e9968-0825-4ede-ec60-08db1be354b5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 12:32:19.8603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVBzgkiX4mM4ojvD0xvi1uU7jf2FymDWIHZTLy9KVxvhAFCtb+h46dkomojK/InvaJC5d9eCulkVGpP/+kdNxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7643

On 28.02.23 11:44, Florian Bezdeka wrote:
> One more optimization to narrow down the number of CI jobs that we spawn
> for each CI run.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  ci/compat_jobs.yml | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
> index 9308679..d8ee86b 100644
> --- a/ci/compat_jobs.yml
> +++ b/ci/compat_jobs.yml
> @@ -9,22 +9,6 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -build-5.15-compat:qemu-amd64:
> -  extends:
> -    - .build:qemu-amd64
> -    - .compat-vars
> -  variables:
> -    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
> -    KERNEL_VERSION: "5.15"
> -
> -lava-test-5.15-compat:qemu-amd64:
> -  needs: [ "build-5.15-compat:qemu-amd64" ]
> -  extends:
> -    - .lava-test:qemu-amd64
> -    - .compat-vars
> -  variables:
> -    KERNEL_VERSION: "5.15"
> -
>  build-5.15-compat:x86-64-efi:
>    extends:
>      - .build:x86-64-efi

Thanks, both applied (with trailing whitespace fix for patch 1)

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

