Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A082F2A
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 18:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3zpVBRk1QpXaKwGEMdlo5xGazB89pbG2JqcbW9X25w1YW5h9DeKliDUo4wUtAOmLuggFUOLF4yCh0BPrJq6vxoDTlQuqqmS+jEBryaZtA+RDMDLp8Cyb96cicS9N+Is7fvOP0kL2WP3px39q7cXRJIMG+8UaTOnzy4nvteb45/Vq2SbLFX2nyq4BK5G6AxCv+0U+w9fKBzIQxGPb1TOEuCNj0dwWKKjAxtK5ld4tXZJ4Q49c6/RWAK9rk80mGjk+MyvxDnWN8Lxs231uszl9GDICarCTfD7gI4xOMRuohSevCyKnJZaLt7hF3Tqz81XKzieC7npy9BLjS26z1silA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRpxn71OrIdEOgiqo9TJcOMBRFwDBIDiF+dh+R5AzfY=;
 b=gVlxqNkg+dSOxD0DpP6Aq1ZjNWEkAibd6pC2vBM9Sncp7uQ+lLEC2a6+rRINGZEr3OCH9t6chyoebt+zaIWNR6izzAvPV7tfijZucthcA5Cuo2pmC2FxNKDdp3b2wkG+NG+1jZDOCLVEJbLzv0ir8xP7CEr6XTx/7gjEdObkNUrcJopfiDDnGAVG0nvdxQMw/F/UyZjy5+Kp2b+UABn5PqHbsXbiZ9zxBz2ZF5+Z1UOTmonNbCC4RS4tIg9muH6SHnT+dFUzufBx2gnFkjFIdrkPTMWONRcWD9pcafUac2cj/PcAQ947PGsT37HUNEKLdGxDT+Teaqv590OlWIhWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRpxn71OrIdEOgiqo9TJcOMBRFwDBIDiF+dh+R5AzfY=;
 b=YkiFbj4m+rkGdhLx3ylgToyHeFd8/rWfF+FgISUUDl+RPrwIJnAyKOQPjh9osp77VqqewolvzTu3nTkMA527tO2NJoUMsEucz83/5bfwnXgGjoozlVl26ScfR3IT66rH/xVc/h9a7dh1W11FPN6vEA7nJWrzA9Xq6Rng2UDjpmiiiswLt+gTOohttlHCmTdvmgpsBnLSRvNn9bqgM74wnB1OEK5/UCTwjN43PsaVwuf2KABOVTbCnrIWwHxdhQLfJG2KFnHX/iAGo4aetrSkwjxCZy15h8jeCYxI7UNWi98kTjenbBkK8G+O2yHS1OQtRakGPU/E9KwU9r1yZniWLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8032.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 18:04:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 18:04:04 +0000
Message-ID: <608cd57b-85d8-ecfd-8221-69ba5dd5f340@siemens.com>
Date: Thu, 23 Feb 2023 19:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] ci: Enable compat testing for the Xenomai
 stable/v3.2.x branch
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230223074841.3977544-1-florian.bezdeka@siemens.com>
 <2f600298-5496-2651-cd0f-dfed4baedcb6@siemens.com>
In-Reply-To: <2f600298-5496-2651-cd0f-dfed4baedcb6@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:610:4c::37) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dc511d-7b8e-4088-e86a-08db15c85952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EJlFRpnrtv+L6KbxaESm7TBXyFSTY+hrs69/CQonqYWKzoACkCMQavjPzf1wuBD3FhwomLW2wSEcj0pfpw/A5AiIFjWmAuhcL1O9NTFUQuBepQ1TXaSUHgIPUONdWJyR/eIOtBxEphZLG34nGs5riP843tCIjfxygHhxxJhKweBFoi2dyiSm9/n8n68E4vY/VMxQck/PEc9ytbZ8SBfY2nhoKAD9MBgNadutiC/3mjKWWI/U4tr/ulxKwLZmZoRZ0KzTW4pElgNA4BMAzMBQb3DquJzEhkjl/BRTNJzYyV8vPd2NN6c2XX7TtoZrUjSHWZjekEUXQ8d24NwnlK1BCgZXEbqcAL7boBm6plG9SlTn2jlqrR4biysXkMoTh9sfxyZZgrmlRd+4tlnHyuPDEQn8efrP5NyB96xI/ALsctdf18bthwZvm5bJ39VCiCG1VPWCYYb5aWgHTq6Fdvbk8HfNmpUJYijT44ARbmL3MyuHgf0h1Yb1bQdN8fV3EU1OFDW+mqXLYYALvHa9XKrB2hQIZYS7YA2NXyZy1daHfMWlbk53XTexSxEFbmCfkgJS+1P604Pu2sPquAbbQIDW459hpLbCKaNOYdNY2V5rQkuEqq3eYY4LsDk4Idk3FAjFj4JSTSnRPBsfuxa3153lJDY0/xfdTB2oF4euvycogl3X+crVvAoKMEFEXvmhCvM8kKAcqgYjLow5pFjt4AALo3vE9xKzITs4QqeT6U7CObc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199018)(44832011)(31686004)(83380400001)(5660300002)(82960400001)(86362001)(8936002)(2906002)(31696002)(6486002)(316002)(186003)(26005)(6512007)(6506007)(53546011)(41300700001)(38100700002)(8676002)(66556008)(66476007)(66946007)(2616005)(6666004)(36756003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWtFbWZ3T3hMZHpnZ1ZXWkd0cWtEMXRsaGRpbE9ZYThCTWdzVktJR3RCZzRX?=
 =?utf-8?B?K3BVMXNlRFN4ZHp6aHpJOGcreG5tV1M3RDBpc0cyOGNDSW9zL3ZJajZYUmpE?=
 =?utf-8?B?OFp5UU9qemxVT2J4d1R5Mmh5WVJ6MzJkc0tTVjlucDA3VzAyRUg3eEJwMnBM?=
 =?utf-8?B?bUxqeUw5a2ZvbThrcXhZdmp1YmFqK3gwcWNZOFRNYytnMTdMSENESjlaNDgw?=
 =?utf-8?B?ZEZ4M21RZkNGbGNlUklRdEN2MDZuWXBwUDJoWEdnQmlVc3ZDWmdTZXFYcFdK?=
 =?utf-8?B?N3lGcEFmNWU4K09EcVZYeUd5OEpsTi9udCsyb2FZbExYb2xzbmNHSE9XYnpE?=
 =?utf-8?B?elBQRDM5dVk1ampQaENSM2hpUFIrd0Nka0VqN1R2aWFIOEl1TFl0QVU5T1VQ?=
 =?utf-8?B?d3ZFQktHRkVwSUNHeEtTV2ZIV1lRRURQaU1kMnpGd2JxbXFkbTFNVURFQ0tW?=
 =?utf-8?B?NDlSNFBsbC9LUDdRSUZKYVFKMlFGS1FLNlpZUU5STk5qTk5idFoxUmdGbytt?=
 =?utf-8?B?a2ZuNm9uTEVBazlFTWV3SFNQY0lmbXIxd3hNN2dQdEtuckVqSE1yTkRhN0JR?=
 =?utf-8?B?RTR4WFpIelBsUDFGMWZubHpSZGduNkJ6UlBYL0pOSGJUU3V4MWhXUXp2bDFL?=
 =?utf-8?B?ZGw0WnR0NGxmV2FUcmV6MXVLQmJXaUJCZHpTZFhSS1ByQ1FzdUJXNWlUR1FZ?=
 =?utf-8?B?TWFoaXFPK1ZSSWM1bzlBWHI4bERWMEVidjM2bjEvQXBJN3VEU3dmQ1hyUitS?=
 =?utf-8?B?WTVGeGF1M1AzUjhnNmUxbWswaDN6OU9hbXN3Rk9TcmZYTi90ZXVka1NNdUc0?=
 =?utf-8?B?eFFDakIyZXUwMFJiTXVyTkI4eTU3NE43M0VwY2NLa1Y2bmJqV1B3V3Nkam1J?=
 =?utf-8?B?TWozK3dPL1BlaG5JNjdwTEJ2NkpoZlhaY01wR24wQlNHTWpXL0YyaE5OaTli?=
 =?utf-8?B?SGlibUlVamZBYjNPdnMycS8vaG02V3ZabloxOWQ1V3ZCVEYyWWd3TDBHY0N2?=
 =?utf-8?B?aEVKVERzbW00UklVVkpUZ2UzRDJBN3ZzUmxTVXpzTll3b0wvNDhHOFRZUmFh?=
 =?utf-8?B?cDlmb0Ircy81bmtvNk82WUZ2bUFRdnlSS3ZuWldCQXZRVThIekg3dmRZcXFG?=
 =?utf-8?B?dUJOUWVwZzFIaDBIZ0pXQTlLMCs4VGxKSGNkM2ZOSHVyY01pY1h3d2tORWQr?=
 =?utf-8?B?VThIbVY2SmFHMFQ2TXczaUN5akJpWnU0UUtBYk45SmJxa1dyajczVVluYWRq?=
 =?utf-8?B?WURpZzV2UXlOQWZwZFl5Qm1JSHJ3QzQ5anhNbDMrZHNOblE1a2pqRnR5T092?=
 =?utf-8?B?NHJWYTBPT09BaWRaYjVwRXdZSW0zSTRkb1BLeFVCc05tdGV3WkJQU2FXT0V6?=
 =?utf-8?B?MFF2dkhpM1M3VkZ5UHVVK0ZtWW55V2Z0UXJQaVdkbmZ4Zk5GM1FKN2RzNDFt?=
 =?utf-8?B?WENsaTFuTG1FRzE2dmNTYnJVcG1lU0kwN3lHNHB1QnFXeU5xYW9ISHlENkxs?=
 =?utf-8?B?Z1RSZmxab2ZURlNHbVhFajVDeWppYlJNcldqVUJaWEI4K21GWVRDTVAycFJC?=
 =?utf-8?B?dGRKQnZ3NGJXVjlmNFpXYS96RGlIcXRzM24wb3pGYTZoV3ZpWExDLzVDbVRC?=
 =?utf-8?B?RTZId05TY3BUNVBmU0ltenAzMnNNQkNRbzN0NkNKZFo1Y2Z1NDdGR2VNaDBD?=
 =?utf-8?B?STRicHlpUlJiMmdjeHhnSnpzN2xJNjgxT3dTT2xFbFgrdTdWc3FnWnhlSG1p?=
 =?utf-8?B?aStFNVJvQytKMFI2eWNVb21ybXA3V2hMRmsvQ0RZWm0wWFUvcjVST2oxOGlo?=
 =?utf-8?B?RmdFSUlXQVBmZVVDM1BVaEYxL1JjTElpWEI0UjdRNzdYUktiVlJiYWE4MVV4?=
 =?utf-8?B?S01haEZUeVJLNW41Q243ZDRUK3A1Y25IeUw2RmJQeTlNUnhhTTJ3b0phelli?=
 =?utf-8?B?WWxQRXdURU02cFNEejBEZWE3TnF0UEJzWHppRnlqelZZbmxZUXkzemFNMWJO?=
 =?utf-8?B?MVBWdEJ1ODFKdkxrd2QvbWRkY3hMZjBqQXN1a0hjMitGbTBDQXRuVDhwd1pl?=
 =?utf-8?B?Q0tmWEJtVEtNQWJzQU5FQXU0MzVEM3Nya0xnRHhKSDhVWlQvS3V0ZlUzL0g5?=
 =?utf-8?B?YXFkd081VU1HTjRrWWgvTGhiNDdwQzRkbE5zcW4vdmxXNXBxUEZUeDZMNWJI?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dc511d-7b8e-4088-e86a-08db15c85952
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 18:04:04.2429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LFovcKLb9zFJgrR48p2JiDOWW7s10BRs6LHPvxWKk/fpP8V82zCCzrsgsS+X2q3sXOOYdqr9PH5bYaOu63t0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8032

On 23.02.23 18:58, Jan Kiszka wrote:
> On 23.02.23 08:48, Florian Bezdeka wrote:
>> Add compat build and test jobs for the stable/v3.2.x branch.
>>
>> The compat build and test jobs have been moved to compat_jobs.yml which
>> is now included by xenomai_next_compat.yml and xenomai_3_2_x.yml.
>>
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  ci/compat_jobs.yml          | 43 +++++++++++++++++++++++++++++++++++++
>>  ci/xenomai_3_2_x.yml        |  1 +
>>  ci/xenomai_3_2_x_compat.yml | 19 ++++++++++++++++
>>  ci/xenomai_next_compat.yml  | 34 +++--------------------------
>>  4 files changed, 66 insertions(+), 31 deletions(-)
>>  create mode 100644 ci/compat_jobs.yml
>>  create mode 100644 ci/xenomai_3_2_x_compat.yml
>>
>> diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
>> new file mode 100644
>> index 0000000..aaf582a
>> --- /dev/null
>> +++ b/ci/compat_jobs.yml
>> @@ -0,0 +1,43 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +build-5.15-compat:qemu-amd64:
>> +  extends:
>> +    - .build:qemu-amd64
>> +    - .compat-vars
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>> +    KERNEL_VERSION: "5.15"
>> +
>> +lava-test-5.15-compat:qemu-amd64:
>> +  needs: [ "build-5.15-compat:qemu-amd64" ]
>> +  extends:
>> +    - .lava-test:qemu-amd64
>> +    - .compat-vars
>> +  variables:
>> +    KERNEL_VERSION: "5.15"
>> +
>> +build-5.15-compat:x86-64-efi:
>> +  extends:
>> +    - .build:x86-64-efi
>> +    - .compat-vars
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>> +    KERNEL_VERSION: "5.15"
>> +
>> +lava-test-5.15-compat:x86-64-efi:
>> +  needs: [ "build-5.15-compat:x86-64-efi" ]
>> +  extends:
>> +    - .lava-test:x86-64-efi
>> +    - .compat-vars
>> +  variables:
>> +    KERNEL_VERSION: "5.15"
>> +
>> diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
>> index 3a1d5e3..3ee0b7d 100644
>> --- a/ci/xenomai_3_2_x.yml
>> +++ b/ci/xenomai_3_2_x.yml
>> @@ -15,6 +15,7 @@ include:
>>    - local: '/ci/kernel_5_4.yml'
>>    - local: '/ci/kernel_5_10.yml'
>>    - local: '/ci/kernel_5_15.yml'
>> +  - local: '/ci/xenomai_3_2_x_compat.yml'
>>  
>>  variables:
>>    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
>> diff --git a/ci/xenomai_3_2_x_compat.yml b/ci/xenomai_3_2_x_compat.yml
>> new file mode 100644
>> index 0000000..a212859
>> --- /dev/null
>> +++ b/ci/xenomai_3_2_x_compat.yml
>> @@ -0,0 +1,19 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +.compat-vars:
>> +  variables:
>> +    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-compat.yml"
>> +    XENOMAI_VERSION: "3_2_x-compat"
>> +
>> +include:
>> +  - local: '/ci/compat_jobs.yml'
>> +
>> diff --git a/ci/xenomai_next_compat.yml b/ci/xenomai_next_compat.yml
>> index 92571ef..f7e3146 100644
>> --- a/ci/xenomai_next_compat.yml
>> +++ b/ci/xenomai_next_compat.yml
>> @@ -1,7 +1,7 @@
>>  #
>>  # Xenomai Real-Time System
>>  #
>> -# Copyright (c) Siemens AG, 2022
>> +# Copyright (c) Siemens AG, 2023
>>  #
>>  # Authors:
>>  #  Florian Bezdeka <florian.bezdeka@siemens.com>
>> @@ -14,34 +14,6 @@
>>      XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-compat.yml"
>>      XENOMAI_VERSION: "next-compat"
>>  
>> -build-5.15-compat:qemu-amd64:
>> -  extends:
>> -    - .build:qemu-amd64
>> -    - .compat-vars
>> -  variables:
>> -    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>> -    KERNEL_VERSION: "5.15"
>> -
>> -lava-test-5.15-compat:qemu-amd64:
>> -  needs: [ "build-5.15-compat:qemu-amd64" ]
>> -  extends:
>> -    - .lava-test:qemu-amd64
>> -    - .compat-vars
>> -  variables:
>> -    KERNEL_VERSION: "5.15"
>> +include:
>> +  - local: '/ci/compat_jobs.yml'
>>  
>> -build-5.15-compat:x86-64-efi:
>> -  extends:
>> -    - .build:x86-64-efi
>> -    - .compat-vars
>> -  variables:
>> -    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>> -    KERNEL_VERSION: "5.15"
>> -
>> -lava-test-5.15-compat:x86-64-efi:
>> -  needs: [ "build-5.15-compat:x86-64-efi" ]
>> -  extends:
>> -    - .lava-test:x86-64-efi
>> -    - .compat-vars
>> -  variables:
>> -    KERNEL_VERSION: "5.15"
> 
> You aren't getting any benefits from AWS, are you? ;)
> 

Seriously, we should look into scoping our jobs down again, a bit. I'm
currently counting 54 active jobs on xenomai-images. There were also 15
kicked off on xenomai itself when pushing to stable/3.2 (build tests).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

