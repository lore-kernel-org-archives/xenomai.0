Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C357F
	for <xenomai@lists.linux.dev>; Wed,  1 Feb 2023 10:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQz1TNt1Of6rvkvkAdP6O8bScphYcWAe4jpcD4GCsfctYmctMdHKHbcEAXkNu+MPX0W4l0bqgFUrDmxgjimFJ9IoZqymgifUKdrDhmZx5uxM3HoTxs7JP1fzXrv9BB/5NvrVIbOJVgDcEUSpNEdPk7tH170fTrr93EVyPnbnldpUHo/qkvN216zBoM3J2gZ9sUEQ4W+jrX00ud293uuCvj9b6jq9YF5u1YRQaPjCeOVm3Z0+XIKLf+HtOreImt0b6vfcLq60mpL/27g257o+oMBzD2R5MIEnhy2t9sYU9mzbbu8FTWvptn04QPHsS9z1Ppq/ihoX44+VRFbcS26EgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jein/4yYOc9DxKxXLCRssnkwoaRotkbMOw99f61r/Vo=;
 b=elfjTpMrm22ws35oMfgrGPQ8rzOxbWCL7R5nPPlbgO+ieyZcfwXSEzmY3UbfCZpN4HDw+YJO2q6yxhkXFp4ZsODjE/NwLakuop8EP5Ej2n6VPD1mFlQ7/rm2Yd2Cu8Xda9cc9K5naS5kaTBJVoSRMXulF5f0SH6vJ74dbqQsdCNSXpUoxbY8HRITsKA6eMNmUTl3Ko/VQ+uyIEwxD02gWOc8DtkrWq6dBjmwInf4awZXLnSe/mZSaV2k+WEhIGANsN6LGFcIv3rmUI7U/Cqthvfhysi8bPOvhvVkcFHtavRUsi+1nQ67U/bsfijlX3TeJZW/tYeZ4fZ39EwdcXXb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jein/4yYOc9DxKxXLCRssnkwoaRotkbMOw99f61r/Vo=;
 b=yORTexqhhPLFL98MvdA80xRtSWCAYuUEZgzasjhHN6wVTmTfpxg0eNITuqtXwJIfC1PQEqXBAduqhM2FD1gCsObo/0kKTrNNUILbHCKStlHpwKgxW/zmkYbYtf0h5Cm1MJ7ISsZXXRjQ6IvRFILpKnHTZ3qrnDxgj6zGj3VrYCjLRC36bHUgBbWukVB7n03/D7Kdaz1lY1fv/sJm2WHD8CQnx3BES5FSxUtpML2ZHXDqJ7gbVTNC4E+RCb26sG4Rgnha4eRJhHzIwl6tr8c+JQAghyTess/YngQcwqmpdQOIo2+rW6cIV6i9krhZqEojq3JJKnyQ46DW5XxaIRyA7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 10:18:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 10:18:56 +0000
Message-ID: <d90fed20-c189-4eaf-2063-fb50203a44e5@siemens.com>
Date: Wed, 1 Feb 2023 11:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [xenomai-images][PATCH] Update to kas 3.2
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230123120846.2253996-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230123120846.2253996-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3543:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f968b6-1079-4d00-04ab-08db043dba39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pMWGDN89IPGNN9qzJhPY8rHHnvjNLTnDFrM+JM8rg5vrlYP1Gk//BoR3UJOq98KAvBWApl1fiFFk5uhMqyqQwT6sI2JKlVFEhrCsdQlksEpYtCLMZEn0cq+fB0dX7ojIE2DVuLe0zIrKWObnUQZGE5HTk43Y+JIULkTAJ4v5tyj5vlDKOpFcJ2nyslIBRY1WQJDVgr2G5y+TotBCy209QPVh2ALsq3bg6bjjPeq6+m2mx+Uk040r2bl7xnLvuYaDtBZ9uF7YIwQfhSOS8zEe1KfLxKYQms+wPRGLmK1PawsU4Zff59q9uXGuUvThLwbSW6vbQnruJ+ltxFl8yZhfRWmenDDo6k+DWCF/ghU7cvRWTVH6EWqxmmN76OPpK0hU3P8ZG/nSiotjTXmnkfKWFZzkr8y8mkGpDI6vyCEc0lJRG70J8ff0A9JiEqXXQ5gvOE/mYkpwCBm1jCTeg28r7r2uwDccWlTEjlH6pDEFPcCCl7uBrPQ6ldl605rf6TKZpgZlb8iZ17y/GQ2V63T6S7pNGC7L8sck3NTqFZYapy4setKYS03y8zgDV/UQ46FgqUfgFPZ87T+3WfbzJrnulYwoPvdcizNpWgIdDmUG3Ru0jMQYNZOskDOEhRs1+k7jWZsQGpvlY38zV9q5LMFZuHkqiIp/lcGMit1iDYUfisjQJkbtDtLh/eb0ref1mFknWAv3USPXL7p2KFl3IYvhWQJDF2ojeKz9Q0nm2m85ZYnYAY6RyE7Lhdxf8HoGZVlVPnt9otup+FgSp1OGGGs8IrzTbWPzsWCENq01WO56p/g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199018)(2616005)(186003)(6506007)(82960400001)(36756003)(53546011)(478600001)(31696002)(6486002)(44832011)(6512007)(966005)(86362001)(26005)(2906002)(38100700002)(5660300002)(316002)(31686004)(66556008)(66476007)(66946007)(83380400001)(84970400001)(8676002)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJHRzNBOEtDV3ZoUFFVMFRPWW4vMzRqR29odWtXRHNBWk9uczlldG42d3BJ?=
 =?utf-8?B?eHdVRjdCNVRmQjBOVzl0bmlyNGZuVSsySWNJWTFxMkFJS2ZQSnFzbTBuV1VY?=
 =?utf-8?B?Ni9PK09rYW1rdFVmWTd0TG1zcnUvUVJTSFNEUEd0NmZKS2syc0EyOWxhZkVT?=
 =?utf-8?B?VGhGNWlPTlVPTEd4ZzhjbHhjWnF2WFF5eWFQdFVQR1lzc3BsY0s2TnRFU25n?=
 =?utf-8?B?SmdCRVBCRW45R1QxN1NUUjdlQk1CRTVwdU9FYXZJVjZFOThCUmo1T2FJMFJa?=
 =?utf-8?B?V01iejFUNWx2K0ZBNGRWN01zSzZMN2k1M3dyTzNibWlZaDNKMmRNd09hU2lm?=
 =?utf-8?B?RG5Zd2drMnltdGVGbjRUdzdmRXdnK3JkNUlrWWt1NFNkZXlvUnFPZDhvbmZm?=
 =?utf-8?B?YjZyV0dQcTd2azFHT015RlUwU04wY0NPZHRoUVpmTkNQckdBd1lJM2poSWlS?=
 =?utf-8?B?S3dHMVphWTlMckdBTk1nb21TVW0zMEhvOGVBQ3RKeVNTQ0hZZUpVTEsrRGl0?=
 =?utf-8?B?bmtLNlgvRkhqVEtVeWp5OUdETmJnME1GUXBCQVJoR09weEMyWVlaRTBROVF1?=
 =?utf-8?B?cGtxSENpU01xOWovbk9HRzZ3NkdkK0JkRWFKODBHNUJzWDdjcUhZdThtMzEw?=
 =?utf-8?B?VHB6RWc3Y1pIRkJFNWVtMVliczljR2VYOGZPUnErTFpXVGxzYWo1MVFOSThT?=
 =?utf-8?B?UGI4bWNpR0VMS2RPenBvenFjRmNKWjV0bjVtY0VpYzBXZ2FVaDZEWnBrM0RG?=
 =?utf-8?B?RlhXMTR6bFhDQUJ6bnNvaEQ5SjJrS3RBenA1WWRQRys4UXdSY3dObis0ZVRR?=
 =?utf-8?B?L3I4Y1psNkpCRFcvbkJNWG8wSGMxRTEzaFNCbnU4c1FJbTk1dkFjV0tMNlhY?=
 =?utf-8?B?Vk9zNEUxSGhSaVA5N0FEd29OL3NqK3MxaWJHaXhSVXNTT1JMTVZhYXBuNzBE?=
 =?utf-8?B?S2N1cnd2WmlDSkMvL0o1aUwxUVRiaXFXc0o2eEhIWnRKeFJHcnk0U0NQVk1z?=
 =?utf-8?B?SlVYbWhVM2pjQnJ1eWlLM1VEUlcwSVZVWEJ6cElzUDUvYzBBNXhkTzFqSFNr?=
 =?utf-8?B?Z2Z2WTFxRXJMME4yZjN3M29yRGIrSXFuZWsvR2pYMWZsdURCMmg2eDF0SENw?=
 =?utf-8?B?S3VJeVZOWHF6ZEJzYUh5cDdINzRoSWIwaFE4aEJqYWh5Si9nOEtxL2w0RkRS?=
 =?utf-8?B?citrclp3cVBRUXVpMzNDbUtaenZpNFBDLzFoS05YMEVvUUR6TkF5bzBtRDVU?=
 =?utf-8?B?S3Fod2RERnRqSm13dkhpV0dIcndLS05hMXJCTjlhdS93WXhzOFRVWS95cEpy?=
 =?utf-8?B?WE1EUSt1amk2RUUwTWZlU1ZHRkxDYWdjSU85KzU0R241dzdrcWNPU21DOEdu?=
 =?utf-8?B?dVRXemRkV3hYM2JYRVZwbFpvNm5NWmp0bGxqYWZZSm1QM1ROZElWeER5K0dy?=
 =?utf-8?B?aGYwc1Q1WHdwc2xBTW04YW9vZzd6ZTJYSlo5MkxHaVBaK1R4VW1FUHlLaFY5?=
 =?utf-8?B?a0x0d1Z2ODF6bjVqditpMDF0UWhrRGwwN1lQejVFUkY5YlV6ZnZmNUJxSTln?=
 =?utf-8?B?V2dBTktHM09QT3k1OUg4NExuOVM2Mjh2aTZuY1k4VmZDL3gyWEE1QmZ6M1JP?=
 =?utf-8?B?amJjQUZzZVlmMy9XbDV2ZHowWEh3WTNDRUc3UHJsVzFFeWVvY05MZ1ZKYStQ?=
 =?utf-8?B?WGliZnhOK2wrUGFuY2pTQzBHQXcxRUJCcUY5dldHc3E2dCtpN29oR2p1TG1z?=
 =?utf-8?B?emlNOS9aY200VkUwb3ZucGtSc09VNW1nZE1vZFBQRkRJcVE2bHFGKy9SSG9T?=
 =?utf-8?B?V2QzNzF4R0NGUVo2U0VVYWlCdFpYREVMeHgwMkJIZG9GMlUzS2NaYXpoTmJM?=
 =?utf-8?B?U2NCekNua1gzNWFFN3NGZXJKeEwrVXpINE5ZOTdCVk8rVjhaOC9WVkVzZCtM?=
 =?utf-8?B?NFo5UnF2OU1OajRIT2NSZW1KRkhPYXpaNlBvVXlLQXpRL3BnN2lKSmJITzJU?=
 =?utf-8?B?R1JkRGJHclROeUxnZXlFTGt6RDFqUUJMNzYwbnNkYTZEZXZiT0JDWEp0djI4?=
 =?utf-8?B?Z0xEVWNkemJVSHp6dzYralhZekUvQVlZWlBvam1lQjl5azc0S0pHeXJ2Szg1?=
 =?utf-8?B?TFpQUkxqUHpkcll4Qy96R1Nya2JuRWJjbXlycTdGUU9jYTBLUlR6Mk5pdzZF?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f968b6-1079-4d00-04ab-08db043dba39
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 10:18:56.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4g4iOOqVkrax7FEdEcX8VoOPP7nsFEGj3hy3tQC8mhtpYk296hohhnKMv6IqG5jJxfqrG5+TgGqSVtNc/7kHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3543

On 23.01.23 13:08, Florian Bezdeka wrote:
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  README.md             | 2 +-
>  ci/gitlab-ci-base.yml | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/README.md b/README.md
> index 392865a..589b24f 100644
> --- a/README.md
> +++ b/README.md
> @@ -13,7 +13,7 @@ from scratch.
>  
>  Install `kas-container` from the [kas project](https://github.com/siemens/kas):
>  
> -    wget https://raw.githubusercontent.com/siemens/kas/3.1/kas-container -P ~/bin/
> +    wget https://raw.githubusercontent.com/siemens/kas/3.2/kas-container -P ~/bin/
>      chmod a+x ~/bin/kas-container
>  
>  Furthermore, install docker and make sure you have required permissions to
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index ee71ea3..40a0437 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2019 - 2022
> +# Copyright (c) Siemens AG, 2019 - 2023
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -24,7 +24,7 @@ variables:
>    BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>  
>  default:
> -  image: ghcr.io/siemens/kas/kas-isar:3.1
> +  image: ghcr.io/siemens/kas/kas-isar:3.2
>  
>  .common-config:
>    before_script:

Not urgent, and I'm planning for kas 3.2.1, so I'm postponing this here
for now.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

