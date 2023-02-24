Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711ED7C
	for <xenomai@lists.linux.dev>; Fri, 24 Feb 2023 07:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdC8oGK82+7IsyHAQjl+MbjxE+YjQnjsLKmgBEFHyOcD3MHeUx+7lApTkM2iCclTOVi/9IfEjejnbeuJ24gEaxKBiotn7GX5MfFMrubC1+HTytCtRIq/qgyqS0ytQgQdLPwaREfN2xNrM+fg+Wxs0DdMRlOHdsL4q4JrKkz/slp0StQC6W9+ETshtTMzwA5NcoDgAc8wWTN5pIjDMkqp+c/eap5flB73bplWPtLZhgGyo+v8zDiNT6l2dmZ93hxi+BTo8aPrb7dkQwxHywCXQceOpg3uey3FUa8pH+QDofQpQ7revv49zuAlolZxx187LFDzFlrqOT2VZlG6Obrd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXz8dmTI9zT+ylGvrOZCKeiNFL2m+Hf9OcT0Rx/jXDs=;
 b=LUKVzhrmipXGvoIkSao+dlb6TwBA5SVLSQqB72p2CjQCn9yIXSMKX5+bxtvH1ZaMPYwXBdOhWRHJBuXKl/VfT52CZUFjQRvVXq0w9p2Dt8Zw2ZjhBqunJs79LjkC9ijqGdVeDWtFIF/rVfvRxH+s4lpnwvMOsXi5zJSleUs2lS2QRJhtGSWW/nNexIrAKdsfqUuK7BS6TO6Cy7fCLNq8OByl8unmEQmu1bZbYmVeiNlWkP84JQD5XwaxMOc9t0yw6ZZE17Pl+4VqL1+BxDhSpqPnoGWmkOAvyVjtunyIdbbFJIOPTtUNB4bZO2g/LDjJOnIgVKGTxe1ED7RqNNna8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXz8dmTI9zT+ylGvrOZCKeiNFL2m+Hf9OcT0Rx/jXDs=;
 b=GxLyubDkqgwj5hvx9vW0k0hPxoyK8rzaEidKQWsfjM7rGrTEnhPrsoPiVgxGnx8SHJHV1HxwkvYfc3yY/kI6waSVG1oSgLVylEticNkU7MJVOEdXxqePF6ROWlntxBAguaUC6PhitwygTfX2M9NPTO8+RyeeGPcywON361PH0pIvdEkQKh3OeVsQb+S3r5NF4cW9KmLChaxFguTWEASPINWb52YgBQqjV/FJd+NvPZxxDBfSS/Fi+1jusIKLBP52AX/qZgr37ci7axBL8FliEjw5Y6CCPpLPjUeMww00FIgRzzyS750/HZTqwgXMIjlCJwrIioCXFK2/2tfmb92DiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6748.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 07:00:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 07:00:16 +0000
Message-ID: <52eab6e8-f0e8-de5b-9563-15651c440967@siemens.com>
Date: Fri, 24 Feb 2023 08:00:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] ci: Enable compat testing for the Xenomai
 stable/v3.2.x branch
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230223074841.3977544-1-florian.bezdeka@siemens.com>
 <2f600298-5496-2651-cd0f-dfed4baedcb6@siemens.com>
 <608cd57b-85d8-ecfd-8221-69ba5dd5f340@siemens.com>
 <1110fada-c2ff-c68d-042a-e19ab6878592@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1110fada-c2ff-c68d-042a-e19ab6878592@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6748:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ad7b199-c0fb-44ba-141f-08db1634c87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MyMQEoEXmHzLiAKrRx67qdlwz7RsKTeT6JePDMhjDSlnTHy4zNti9ZRfDLp7eGiQgC/nevwOQJeZNTzJaeswLvm277whpRZFqe71pIIfkRdDJ1pghQwvcsCu0HWP7LcrlyiA1aDgqF0+lMI0vnEtgu85rxyREtGLoXqvVb1s3m3eJQTVpDBI/WS+GpihjLv3c4BevRgRQOYD8vCyfejCjeVbyILzJzsevOO6rzgrL5yrA9WHMtCL3xobKmMkfzpsf13nxvl/UxpHmGFuwl/5bXRsRHjzfV8fwvYmr+Isj2zCmaL1r/Zdjf3/p8tHD0KVHRzw9IJ5ilM9oIfxNxJdj2q1zi36KruBZ+U+PbF+yuHKEyk61lcKJHQlbxAXlk27lTI/N7XlrzATmwKRL6jnjETBl6O9uP6/2Sin4r2fHbaqOnK6BnrQAQ0zZrBY/EOB7oV0L6JqBqvzC1CESqkKWLcg5PqTFjBJWvXcoaRcXiOQ+ZUWqTwOYpcM6zSiYIrngpEUEDmPe/fMgwQfh1Cyo3+MS4hm3imP9/TT9HyhDAI8QPZ34pJ1Um1+NlgbQYaTzwFUUA2EagDUdGIF6qoEW50PCft1fdeOtzHKPp9p93qUfutmtfQ8OHt5iqD1n8g/+WA19SkpTWqaitt4i8aEKKJupoYNldVnCH2p5WzAYohms9V1XLC8zyM5pibV8n8JMFnfyvZPgMtmy2Wa0VRGlk0qEFREuLswIZSBKjDlptg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199018)(36756003)(38100700002)(31686004)(316002)(478600001)(83380400001)(82960400001)(66946007)(86362001)(31696002)(8676002)(66556008)(6486002)(66476007)(41300700001)(53546011)(2616005)(26005)(2906002)(8936002)(186003)(6512007)(6506007)(6666004)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RngrMTZmTHdMWkh2S05IcWdUc25ad25TUEd6VkxBQjZpUTFSd2pkL2I1N3pS?=
 =?utf-8?B?aURHN1Nva3V3dDAwdGQ5VktoRXphSDJ6RW84TEZLNXBmSnVXSkczOG13VXFn?=
 =?utf-8?B?eGpmWVMxNUpHQ3dJZGxaeUlCaGdJQzZ6Um1oWndjclpBMmh4MGFieHZxSUhT?=
 =?utf-8?B?eXNIK3pLaUxlMUh0algyNHRKQUJhcmh1cUlxUDVzVmRNUkp1dVFRSEdNVXl6?=
 =?utf-8?B?a1VFTGsvQkZsS0h1QmM0S0YzVE40Ni9YUEQvV3VGa2ViWWRyRFZHdERKdkhu?=
 =?utf-8?B?dGMrR002dXNEcXd3WnZDOVkwQ0FsU1Y3S3JBdGd1YkRFdmtHV2ttV1VDZDUx?=
 =?utf-8?B?b3pSU3UwZGs1NzNxTGVndXdzVjNTU0JXRFV2NkNvcktIdkNHZ3BUVVhTWGta?=
 =?utf-8?B?UHdJQmxodWNIRENiTGU5MnZqNkN3cjlmWCtnZ01PTWZnSGQ5dDJiUytmVlYw?=
 =?utf-8?B?YUYxNTFQSGRSREl0S1J0V3FacjZSbFRFMVVQM1VTUTIxcTVUL3NPWUVsMGVm?=
 =?utf-8?B?UWNBN21GN091bjVEVFowc092ZDlxK1JXaG5tNFhCZllTS1QxMmRwMFVGMVdK?=
 =?utf-8?B?VW92Nm81aVVPUUxSOXFkM2ZRalhEakcyd1VleUVmUU0vaWx3a2plemtaR0Ir?=
 =?utf-8?B?dDFJdkZoVVRYdXc5RFhjcHVSSHNUd1k1aDNVck4rWDdQdVBwU00yVjNsNWMz?=
 =?utf-8?B?UEY1Y0VMQUdOS1hwY2RzMnU2RldCYXdVazZnR2h5OVpFS3pmYklIb3d1YkIz?=
 =?utf-8?B?MU5OampjM253ZHBWMWdicjd3WExsUXBJYnV4OFU4bHY0OGtROWlFZWNFcUkv?=
 =?utf-8?B?aTZ4elRESVNydWVSV1NMN2FqdzFoTjNEanpudUkxZFpHWG5tVmxpand1Rk5V?=
 =?utf-8?B?SWlLRjhOb0grVWVld1M5QlI1a0lrYU1mT1FmeUY3Z2hiT2srRkNqUVJZWDhl?=
 =?utf-8?B?aThQclFuVDFKdDMxM09pWGwxdldNT1V6cHQzRnN6NGxnTkhYVk5haEhGbGpJ?=
 =?utf-8?B?WWVVcXVpRXFseUc3RXcxVm1CczMydTJjRHlERVNkYXQvOHF1Z1I5cHE0Yitw?=
 =?utf-8?B?czh1RFVvdHFLeWFjLytSUm9IQi9HQTRMSEtkc09LUCtiVWNEZ21EN25aSFhn?=
 =?utf-8?B?OUdRajVQazc3ZlN2VWNiRXlrV0VRMitmVE1vQmZIeGxrZnZwR3RFMGpVcW1j?=
 =?utf-8?B?RVRScXNBNkg3c082YmVORnNVL2E5WDVPejZMeGMyQ0g2eThpZnZYUFV1UEw2?=
 =?utf-8?B?WWpuY0h6RTl4SCtjRE5GRElMSENYaFhub3AxWGFPei9HMGpTWUZJTFZUMklt?=
 =?utf-8?B?UWhpSWN0MFUwU0NxNGY2QXJTRU5sSjhhaWN1RmFlRE9kVGl1VE5wdVlKNjhl?=
 =?utf-8?B?bUkvdmovTGZGL0JsdHkyRVhTN1ZwNS9iRHFLVW12dWk2Rm9UbE9QSnBGcDZ1?=
 =?utf-8?B?OFdqOEpjNW16STQzelVNejh4cW84anRTV3dXYm1xS2poVEdCR0ZIaFFZZW1x?=
 =?utf-8?B?UHZsWjhuTXdPeHExWG5uN3EvVUs5TVhxZWpyWkNGb01leWkzWnB5Vy9OSlBO?=
 =?utf-8?B?MGhTSFhnaytVNnNMVkw5ZGJubmN5aE85alQ4blh2MVFyUFNNK1lxTFk5WXNw?=
 =?utf-8?B?ODZMTlVQWVBIRVN2RUNuUVNlbE5RLzJKVktaOWx3NDdmK1RSdTh1NmVYdVpW?=
 =?utf-8?B?QkZtaVdvdlp0enBzcnFDSmZhM0xzS0ZMREltcjlaYTFVZGJtS01PeXdVaVJO?=
 =?utf-8?B?eUV0N1pmWE4rVkhGbkRPYTZlUzVnbjFqTlhPYnRSVzc4cTVyTHkrdUl4cFNx?=
 =?utf-8?B?Vm85TDQ0RXNPMnVVK3gxVm0wOCtmbU95Rks2cnJzY2RJT1Vka3Jyd1pQU0kw?=
 =?utf-8?B?c0o2d2Jod09KbFhpZnpJbm1oTUR6MUZic3NHU1grczBEM1NjQVpGVDVyN3Y5?=
 =?utf-8?B?cEM3eEpRMlNjcngxL1ZVQW50a3VrR0tQVXRiTVE1NndWVWZaOC85d0QwQTho?=
 =?utf-8?B?QTFpSXY4ZHZSZk5SMGFuZlM3NW1sb09XYnk3TjcvekZOUTY5TFZqNnVLeU1F?=
 =?utf-8?B?L3ErclB3bGVuWTlUYmE0ZVdxenpyNFZrWFpWRVYraG9oMU9TL05ITkFMV0VD?=
 =?utf-8?B?cWtuMkJkRk9UMGozNUJNelh3Tk41VmRzWERJQXFaYmtyR09JckFhMk95SnBI?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad7b199-c0fb-44ba-141f-08db1634c87e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 07:00:16.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4GFwDBMEocyUt4ulk2WxppOaeLTZu+X7Tts83UqSc94Cx2hbHuemPdEJKXzmeKyPEMTvvANAnNxdp5mIRJ/rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6748

On 23.02.23 20:29, Florian Bezdeka wrote:
> On 23.02.23 19:03, Jan Kiszka wrote:
>> On 23.02.23 18:58, Jan Kiszka wrote:
>>> On 23.02.23 08:48, Florian Bezdeka wrote:
>>>> Add compat build and test jobs for the stable/v3.2.x branch.
>>>>
>>>> The compat build and test jobs have been moved to compat_jobs.yml which
>>>> is now included by xenomai_next_compat.yml and xenomai_3_2_x.yml.
>>>>
>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> ---
>>>>  ci/compat_jobs.yml          | 43 +++++++++++++++++++++++++++++++++++++
>>>>  ci/xenomai_3_2_x.yml        |  1 +
>>>>  ci/xenomai_3_2_x_compat.yml | 19 ++++++++++++++++
>>>>  ci/xenomai_next_compat.yml  | 34 +++--------------------------
>>>>  4 files changed, 66 insertions(+), 31 deletions(-)
>>>>  create mode 100644 ci/compat_jobs.yml
>>>>  create mode 100644 ci/xenomai_3_2_x_compat.yml
>>>>
>>>> diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
>>>> new file mode 100644
>>>> index 0000000..aaf582a
>>>> --- /dev/null
>>>> +++ b/ci/compat_jobs.yml
>>>> @@ -0,0 +1,43 @@
>>>> +#
>>>> +# Xenomai Real-Time System
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2023
>>>> +#
>>>> +# Authors:
>>>> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +
>>>> +build-5.15-compat:qemu-amd64:
>>>> +  extends:
>>>> +    - .build:qemu-amd64
>>>> +    - .compat-vars
>>>> +  variables:
>>>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>>>> +    KERNEL_VERSION: "5.15"
>>>> +
>>>> +lava-test-5.15-compat:qemu-amd64:
>>>> +  needs: [ "build-5.15-compat:qemu-amd64" ]
>>>> +  extends:
>>>> +    - .lava-test:qemu-amd64
>>>> +    - .compat-vars
>>>> +  variables:
>>>> +    KERNEL_VERSION: "5.15"
>>>> +
>>>> +build-5.15-compat:x86-64-efi:
>>>> +  extends:
>>>> +    - .build:x86-64-efi
>>>> +    - .compat-vars
>>>> +  variables:
>>>> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>>>> +    KERNEL_VERSION: "5.15"
>>>> +
>>>> +lava-test-5.15-compat:x86-64-efi:
>>>> +  needs: [ "build-5.15-compat:x86-64-efi" ]
>>>> +  extends:
>>>> +    - .lava-test:x86-64-efi
>>>> +    - .compat-vars
>>>> +  variables:
>>>> +    KERNEL_VERSION: "5.15"
>>>> +
>>>> diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
>>>> index 3a1d5e3..3ee0b7d 100644
>>>> --- a/ci/xenomai_3_2_x.yml
>>>> +++ b/ci/xenomai_3_2_x.yml
>>>> @@ -15,6 +15,7 @@ include:
>>>>    - local: '/ci/kernel_5_4.yml'
>>>>    - local: '/ci/kernel_5_10.yml'
>>>>    - local: '/ci/kernel_5_15.yml'
>>>> +  - local: '/ci/xenomai_3_2_x_compat.yml'
>>>>  
>>>>  variables:
>>>>    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
>>>> diff --git a/ci/xenomai_3_2_x_compat.yml b/ci/xenomai_3_2_x_compat.yml
>>>> new file mode 100644
>>>> index 0000000..a212859
>>>> --- /dev/null
>>>> +++ b/ci/xenomai_3_2_x_compat.yml
>>>> @@ -0,0 +1,19 @@
>>>> +#
>>>> +# Xenomai Real-Time System
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2023
>>>> +#
>>>> +# Authors:
>>>> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +
>>>> +.compat-vars:
>>>> +  variables:
>>>> +    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-compat.yml"
>>>> +    XENOMAI_VERSION: "3_2_x-compat"
>>>> +
>>>> +include:
>>>> +  - local: '/ci/compat_jobs.yml'
>>>> +
>>>> diff --git a/ci/xenomai_next_compat.yml b/ci/xenomai_next_compat.yml
>>>> index 92571ef..f7e3146 100644
>>>> --- a/ci/xenomai_next_compat.yml
>>>> +++ b/ci/xenomai_next_compat.yml
>>>> @@ -1,7 +1,7 @@
>>>>  #
>>>>  # Xenomai Real-Time System
>>>>  #
>>>> -# Copyright (c) Siemens AG, 2022
>>>> +# Copyright (c) Siemens AG, 2023
>>>>  #
>>>>  # Authors:
>>>>  #  Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> @@ -14,34 +14,6 @@
>>>>      XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-compat.yml"
>>>>      XENOMAI_VERSION: "next-compat"
>>>>  
>>>> -build-5.15-compat:qemu-amd64:
>>>> -  extends:
>>>> -    - .build:qemu-amd64
>>>> -    - .compat-vars
>>>> -  variables:
>>>> -    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>>>> -    KERNEL_VERSION: "5.15"
>>>> -
>>>> -lava-test-5.15-compat:qemu-amd64:
>>>> -  needs: [ "build-5.15-compat:qemu-amd64" ]
>>>> -  extends:
>>>> -    - .lava-test:qemu-amd64
>>>> -    - .compat-vars
>>>> -  variables:
>>>> -    KERNEL_VERSION: "5.15"
>>>> +include:
>>>> +  - local: '/ci/compat_jobs.yml'
>>>>  
>>>> -build-5.15-compat:x86-64-efi:
>>>> -  extends:
>>>> -    - .build:x86-64-efi
>>>> -    - .compat-vars
>>>> -  variables:
>>>> -    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
>>>> -    KERNEL_VERSION: "5.15"
>>>> -
>>>> -lava-test-5.15-compat:x86-64-efi:
>>>> -  needs: [ "build-5.15-compat:x86-64-efi" ]
>>>> -  extends:
>>>> -    - .lava-test:x86-64-efi
>>>> -    - .compat-vars
>>>> -  variables:
>>>> -    KERNEL_VERSION: "5.15"
>>>
>>> You aren't getting any benefits from AWS, are you? ;)
>>>
>>
>> Seriously, we should look into scoping our jobs down again, a bit. I'm
>> currently counting 54 active jobs on xenomai-images. There were also 15
>> kicked off on xenomai itself when pushing to stable/3.2 (build tests).
> 
> Totally agree. Any ideas which jobs could be removed?
> 

We could start with dropping QEMU from anything but latest and oldest
kernels. Or we even only do builds and test for latest and oldest
kernels by default (in 3.2, per pipeline type), leaving an option to
still trigger those jobs manually by setting some CI var in that trigger.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

