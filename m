Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553A2F2A
	for <xenomai@lists.linux.dev>; Thu, 23 Feb 2023 17:58:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyTDMIlLvX4KHp6OU1DrI+gD/bTZCqU/g+Za+zpsntuxuzMq8hQ7tdUg2NgJg9YjKoZPpPgeFZdXM2FJ60c38CJGAXe3jQ7rqwR/3VSZxAC4Iv0E4ff6I6NOD+cePUP5S7mEQuWZKRIGyZnOMdGBCzfU6KCDirW0+idKifdV2Bt2k6Kx1N9ECm7HcngWYZojj9BAVLfmCe/rqLqjac6euIA6BGr7RewU4ECQvgGnspV4tzC3q2I6fNWyRgeBMDr32bLoTlLBzxNhbsiE0DuSkLYtGP6PJVlATWEFIwpAE5SAUUgC06CoTZEfU7wf0e+KfS97Aam2XJM9F69ZGv8ckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvagNJ1hLow0NWeEQRrsp1wUh+LknplAtKdEiVbrKLg=;
 b=bmwDhAEvgS3UNnwLPldpENpBYVEdEscr801sHjtQBs3h9JdJoXqKJNTsYxbHiDA09TxaOy7T4MFuqa9PxHj1TbItKQMubnU+qJG9y9HpWQ61aI2XqGvTzXBnXYyRBrXX7fJHQp2XwnKWRYnlrcXllkSHwTiN8VMpYolaaIcFb5DNeyT3FM1XNNWmZgbJG1FfPuZmwIbzB4GzACumeEmqt9CDTz8zaaSoi4mkVvVDyybuqd5OmSwlt4KJYYhUbbHkQUz2FvQjt2wni6vi0L+0KzMCbooxhBsFxNCqXUPURz11a1TxbFh41iH7EM4bWPE4CVeu9ErtYAfkDKc0l/+M3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvagNJ1hLow0NWeEQRrsp1wUh+LknplAtKdEiVbrKLg=;
 b=fRQqrQpdnPmfbDBszaKPMQPLSuPIp3Sog3ALq6x4EKh2BdE+ul+nGFMAso9mKZtLh18OBkoIQGFXtZeZOL1lENuUuQDFaXQKk4gtwXQ/iq7bv8ffyHv1qE6yt9j3KDUP/0xnOClKvSSyJgFaXEAO9/QhOn8sYiFDAjO+xwzI4beurmBEScUQ1UBOmU05lpaccIufuMGrQgiWNXI7jDxnR1tqbrAU1qoIkj6fiw6gjZQzUgqgllhHK+D2eLlJ3tIOZAY4TfRx1VfNBVOBMZgFAqMBmzZb+pWYawqH+A55/2gR6Ee7+HQg3Lrbbu7DAlLvzD29ay7/TMV61LcflDL+Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5369.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Thu, 23 Feb
 2023 17:58:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 17:58:08 +0000
Message-ID: <2f600298-5496-2651-cd0f-dfed4baedcb6@siemens.com>
Date: Thu, 23 Feb 2023 18:58:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH] ci: Enable compat testing for the Xenomai
 stable/v3.2.x branch
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230223074841.3977544-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230223074841.3977544-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:610:119::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5369:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad0eae1-828a-446f-1112-08db15c78571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hs00LUU6I66nrIUMFX9Uaw/gtvDQsyf0m4FZZM+lvTPIb3oSmsYJ1IvubNU3611fLV9alCOpxXCgt2eW6X/pZgjmszxXnpScny4Pu63sdv7QWfJmUac6apDsDErc3dxSeuPXVeYtT3I+2oSrFp5JrzqLPceavwpIccZgsCxzmoGPmqygdPY7G8YVmBSjEOOBegZO5wt92tKPvL/g22azyIw1pdpP9ppjBu+UAq7s719xXfcXkHQgsQhPc1oDKTlQ13roqGIyFWEI9rKmeBYl/M7/aYJX6KuUg5BMqh/zxFRTbPFpTnTNfiewnF5NxU8VkD+mP2aR+ZsSpCAiax82Wxktu8DpUR3FrIWUslJAxu6RtTVnnMg/J8VK7D1KjDGUMe0c4xBxxmrHLG8nFg2rrRYZ8WkP4Z5y5agnyoueSImxtaawtlvgFklzDtmaYLlJ1N7G5um4JUgTE1JKHYOR8g5bQs3DrzJRBT44ruAm85W9g9pVt9mzilRpZJoojmORxKpj3oNvlQu6iGuFsm7FsvuiOU64Qc+4bXha7q0QEvBWYL/gne/ZMehXB74IKo3hEb/FRCQcpKmk2qc0ArL/0oF8+fbDn0bW2MSXsA30EItrNzwms2aA7XTG+n10HanYBFw3hP07ALoYCjVuCsnRYPz7Gdl4T3poMq0ki0z49kg/MnX+3T3qxog+ftz1fj5aK/kecMRvG8nUC+cmhvQCVijdzAMtkQAhYhC5dHfDn14=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(38100700002)(31686004)(2906002)(82960400001)(2616005)(8936002)(44832011)(5660300002)(6512007)(26005)(186003)(83380400001)(41300700001)(8676002)(66556008)(36756003)(66946007)(66476007)(53546011)(86362001)(316002)(6486002)(6506007)(31696002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2dMbkdWQUpmVGhoM1EvTTF3Q0FQaHF0c3RRa2NGdkxsWjhWeEtMam9QZkFS?=
 =?utf-8?B?S1hHL1VSSFVNZDVEc0htOUJnUmZJNVoxSkQ3cEIwcVhyT1JUSVpCN2Z6QXNW?=
 =?utf-8?B?MW1xY25TQ2Q1OXdKenN0RWlVcEFGa0h4WmJULzhuTDRQZ1RSWjk5MHUzWXMz?=
 =?utf-8?B?bGt3cWtGOW8rdXViSjZ0ZWRhS25UUFdSTUd2M0IxMytna04wTzVtdXdHc0dB?=
 =?utf-8?B?MW5tb2NZeVp6eTdPZi9mOUJuS2RlUVZGNzV4VmE3dmw2SW5RNE9mV1ExUVlK?=
 =?utf-8?B?UnFCYmRwbWVvUUVZOGtKcmZyejdXbnRYeHg3ZllQektRNURmTDhRL1dmNW1G?=
 =?utf-8?B?ZGczZk1HbERsVEtuY0M0cU1Kd3pZREt4U0kyZ3NNSzFSOVRjOVRVa3MzUWow?=
 =?utf-8?B?NVFTY1ZsNktsNmZJYWkxVG9uTy9oSlJ1YjdZeFF1SlFIbmUzR3pDelNVY0lZ?=
 =?utf-8?B?NWlzWlpKcmxPb3RlL0Yyb05LZnNVTHhwUGZXdlVpRG9mY0dWMUhOYUxRMGEz?=
 =?utf-8?B?c056U2x5NzEvNG5ydS9qanRWNUFNdVQ2bENmU1dJeGVORkxWcGhydUJocjMv?=
 =?utf-8?B?V3E3YjlJVy9uOGdoV0NwUVRwT0MzbXBjeGVYQjFjNkl5dG04alVESHN1dTJk?=
 =?utf-8?B?WUVYbFd3Z2ljNnVnTkJ6eGY0eUhXZUtTQkhzMnNsVTV2RW4vdTJyVGhFU0Z0?=
 =?utf-8?B?MmszOGNtb3J6aGY4M2VRL1NIbE1HUldTaWVUWU5LZVlJTmR1OVQ5U25ubE91?=
 =?utf-8?B?ZVZPWlZPMit4RG93SUxhL0xPRXVKK3dOMElGc2VoenUyKzBlNGJOSG1KOUFK?=
 =?utf-8?B?WjUzVHh3bEtiZWtZMHdKeXNuN2x5VVJJTkhpbVhRRlpDdUJxV3gyck1yUkI5?=
 =?utf-8?B?Uk9YOHdBQkFybDFIUCtTNFJWbU5tWDlIYVN1TzdXRGRGWmVBbkZYQ2o3QnEw?=
 =?utf-8?B?TFBIZktYY3ZVaTlCTWlpSEsyY3pIK0taSjZoQ05vcmNucTJVSDltUVJGNGFX?=
 =?utf-8?B?aWpUNUhacURJWFVmVENtd080VlA1bDEyblg2S2RWODBkcm42NzNDVzVtVmRa?=
 =?utf-8?B?UWNNVXFISnZyc0FIZWJDY1hYeldYdFA0Z2hDY3ZsZzVFelduNkFoL1ZpRUlV?=
 =?utf-8?B?M0ZaS1RHbXFVejZlYm9hVSttWWEwY3BiYXkvUEE3azhaNkY5U3FPTXpGVS8x?=
 =?utf-8?B?UkZ5Y1VJdFlHRDdVbnB3ekx2WHQzbzQyd2VCVitaVkRzTVhRa0hKY2dyWVpD?=
 =?utf-8?B?N3QyekMwb0FOSEorQmdORkdSQWZWVjFHckZZQkhEU1BtMUIwcWhXdlMwaVc4?=
 =?utf-8?B?eXVkUWtlY2RVY3ZZbXNDcHJvMzNxT3RKRGJleWxieWcwTWE5NHBVOTdDdkN5?=
 =?utf-8?B?WnN3SU5MRkxVdmtTMVpZY1YwVVBTSVdsNG9iVWFaR1JrNXZCM3ZnM2psYlVU?=
 =?utf-8?B?VWZDWWxzOHljd29iNzI4S2hMbzdSYUNNTkdyUnR4STh5ZHl5NHlKZXRJQ0dT?=
 =?utf-8?B?SmExVXU4OEQ5NG9BbTlNS0JaNXRYYnNaNWxNWUF5VDBaZTZqUGNMSHhGM2Yy?=
 =?utf-8?B?TE5LWVVBWEhOWHROWFlOQ3BxMmNUa1RNRFE5ZldNSlk2ajRoS3JHdVV1RHU0?=
 =?utf-8?B?U3cvMmJFcmxGRzNXTUZHZC9Ua1BmVU1zUm5CaGUwQldBOHBNVkNQemV6aWN1?=
 =?utf-8?B?WWpqQnJGei9CSGpwMFVRWmpUMG9rdnd1cVZNNmV1Qm53SDFxYW9RalFhZDll?=
 =?utf-8?B?VDB5amJYQTVqZGZGNkF5T1dKWjF2UTNUWFg3NlprYUs0Z3JCNjI5K0lyTmZS?=
 =?utf-8?B?aGJLVHdXRllCcW5tc1JtRWpYT3ROOHRLS1NwRys3Yjl3WGttdUd6UnVyQVNK?=
 =?utf-8?B?TFlFTXVqSjhqdmRpc0JWamtEeS9aSHE2TUE1dzNOVTJRM3NhYXBodzhUYXQ4?=
 =?utf-8?B?QjlJODdKcU5VMXE5N252V1hpSlB5bnVhSUZsSi91T0N5Nno4TlRLTEFFaUps?=
 =?utf-8?B?T3FpdWwyRFNKeXN2amYwVndJU0Y0QkVzQXZYeWhXRnlQUFd6bUgzTVY2cnZW?=
 =?utf-8?B?K3ZtcytOWjRiMUdUYk1hOXFpVm5td0N2RVlReUJhbnYzcU1meFhRVVBzT29T?=
 =?utf-8?B?SzhFbDVsQ1RkdEg0MWFWNjhmR1dxbmd0OWVCSlNySkNKSnFKWTFPOFBidUsw?=
 =?utf-8?B?S3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad0eae1-828a-446f-1112-08db15c78571
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 17:58:08.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpShpkywbayh49fr/UJ1pm5SXRr2ZrAtQIRCSAUrbB0BrzAt+1Am+S8Y8H+SPWWYOrP8cCvvXy/J4rcRttXRcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5369

On 23.02.23 08:48, Florian Bezdeka wrote:
> Add compat build and test jobs for the stable/v3.2.x branch.
> 
> The compat build and test jobs have been moved to compat_jobs.yml which
> is now included by xenomai_next_compat.yml and xenomai_3_2_x.yml.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  ci/compat_jobs.yml          | 43 +++++++++++++++++++++++++++++++++++++
>  ci/xenomai_3_2_x.yml        |  1 +
>  ci/xenomai_3_2_x_compat.yml | 19 ++++++++++++++++
>  ci/xenomai_next_compat.yml  | 34 +++--------------------------
>  4 files changed, 66 insertions(+), 31 deletions(-)
>  create mode 100644 ci/compat_jobs.yml
>  create mode 100644 ci/xenomai_3_2_x_compat.yml
> 
> diff --git a/ci/compat_jobs.yml b/ci/compat_jobs.yml
> new file mode 100644
> index 0000000..aaf582a
> --- /dev/null
> +++ b/ci/compat_jobs.yml
> @@ -0,0 +1,43 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +build-5.15-compat:qemu-amd64:
> +  extends:
> +    - .build:qemu-amd64
> +    - .compat-vars
> +  variables:
> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
> +    KERNEL_VERSION: "5.15"
> +
> +lava-test-5.15-compat:qemu-amd64:
> +  needs: [ "build-5.15-compat:qemu-amd64" ]
> +  extends:
> +    - .lava-test:qemu-amd64
> +    - .compat-vars
> +  variables:
> +    KERNEL_VERSION: "5.15"
> +
> +build-5.15-compat:x86-64-efi:
> +  extends:
> +    - .build:x86-64-efi
> +    - .compat-vars
> +  variables:
> +    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
> +    KERNEL_VERSION: "5.15"
> +
> +lava-test-5.15-compat:x86-64-efi:
> +  needs: [ "build-5.15-compat:x86-64-efi" ]
> +  extends:
> +    - .lava-test:x86-64-efi
> +    - .compat-vars
> +  variables:
> +    KERNEL_VERSION: "5.15"
> +
> diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
> index 3a1d5e3..3ee0b7d 100644
> --- a/ci/xenomai_3_2_x.yml
> +++ b/ci/xenomai_3_2_x.yml
> @@ -15,6 +15,7 @@ include:
>    - local: '/ci/kernel_5_4.yml'
>    - local: '/ci/kernel_5_10.yml'
>    - local: '/ci/kernel_5_15.yml'
> +  - local: '/ci/xenomai_3_2_x_compat.yml'
>  
>  variables:
>    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
> diff --git a/ci/xenomai_3_2_x_compat.yml b/ci/xenomai_3_2_x_compat.yml
> new file mode 100644
> index 0000000..a212859
> --- /dev/null
> +++ b/ci/xenomai_3_2_x_compat.yml
> @@ -0,0 +1,19 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Florian Bezdeka <florian.bezdeka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +.compat-vars:
> +  variables:
> +    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml:opt-compat.yml"
> +    XENOMAI_VERSION: "3_2_x-compat"
> +
> +include:
> +  - local: '/ci/compat_jobs.yml'
> +
> diff --git a/ci/xenomai_next_compat.yml b/ci/xenomai_next_compat.yml
> index 92571ef..f7e3146 100644
> --- a/ci/xenomai_next_compat.yml
> +++ b/ci/xenomai_next_compat.yml
> @@ -1,7 +1,7 @@
>  #
>  # Xenomai Real-Time System
>  #
> -# Copyright (c) Siemens AG, 2022
> +# Copyright (c) Siemens AG, 2023
>  #
>  # Authors:
>  #  Florian Bezdeka <florian.bezdeka@siemens.com>
> @@ -14,34 +14,6 @@
>      XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml:opt-compat.yml"
>      XENOMAI_VERSION: "next-compat"
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
> +include:
> +  - local: '/ci/compat_jobs.yml'
>  
> -build-5.15-compat:x86-64-efi:
> -  extends:
> -    - .build:x86-64-efi
> -    - .compat-vars
> -  variables:
> -    LINUX_BUILD_OPTION: ":opt-linux-latest-5.15.yml"
> -    KERNEL_VERSION: "5.15"
> -
> -lava-test-5.15-compat:x86-64-efi:
> -  needs: [ "build-5.15-compat:x86-64-efi" ]
> -  extends:
> -    - .lava-test:x86-64-efi
> -    - .compat-vars
> -  variables:
> -    KERNEL_VERSION: "5.15"

You aren't getting any benefits from AWS, are you? ;)

Makes sense to include that into 3.2.x. Applied (to xenomai-images, with
whitespace fixes).

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

