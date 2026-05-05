Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB283D6CC5
	for <xenomai@lists.linux.dev>; Tue,  5 May 2026 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009923; cv=fail; b=ehjFTIXkt/ZXGyBr/lG20JjxNZhH3Y3VgiqyssRXoNTEJyUGsklEpVbTfV/pQBRQPiFPWXDXPUZD9dAIzKfFGlco1x5XxZO3ET3v/Ge+/XDsSI7qrSCYHKMVAzkKOUIqxiy6LepVzomCt8VaFOSV4GZ08TpJgm6ozg3o/yDUOuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009923; c=relaxed/simple;
	bh=7y8UJWiw1c+1tyE8WMV/aj4fAfTxefq6tw+E4koGrj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCddSQWiRfer5P1Yq+pxYeISzYzYId02e25GJEsK9Z9c6EAkrWioVM/8/2z8CQ5TSXMY4ayY/9Y3PE4MQ6864eJOKKNgAQEDfwtI2ytJ0HVa0CAyn7573qHa4CvfEd2IpYEzStHvKi7Wbt5fZDBu/PwuhPASdUqZjQoT1XYVCOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=HWgdDLIj; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="HWgdDLIj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGin4I1fVAUiBBt+2mMy+2v2xW1WjnH56+9UtvMvf6uQFMXBNQ3nkgafY9KrEYvXJLz8P2DV8covh2ZCBsHJ5FjnZdfv0b7iShPPHE57RSKGL2o79QFTE213QdF5IIqXvMpped1rK7eBE41oarGyfDiFU2ELekPrQJ8D87QKJIZHbMPUmLBRfxgvZED//5GQRX+NjBzjqGuLbnxuG5ueN/gVbphZ+MuaR4AmRVCWdqy6kSMVFeN31VIr+HuuRTtYJdflDmJd8pxL0aX67TzSHR0j0+c+fcciUHcmCdyVAFefx7iuv8tuF6sAb661FhYXiUnCiIsmNI78mwSq5va27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIrFqM5i1n5+gMKg0lic0akZ8kr7oeCVvi03t5wfiUg=;
 b=FoKl7IwWCl6s4ARJHpA4HgDgr+/sP7KQ0/T34pNQjnlyuOideDw4Q7ShN5acqkSzY7xLAiHvfuI3rNM+N+YeZDGYJ9zwz8bH7m4usaT8Onhcb33KOZMdPXQuPGYOvr7CGTow+lpKTDJtFPRTGS6V9hZ71dbM90sty+qxBWXmvmBgTKgFylPla9Q4I8uBx77spHoA97oHcNY4ZetlW6eSl8ZVp8BsU6f9QOn1F6AQH9i0JLL0DmRboADrMVT+TVgF3Uv9gFTIGZf0Aboowt5GT0APH9pSyK4klgrmHy+TJS6hVNq75w6SgVF5iXpMlykA5nni2ZyziCx5LI2PD9O54g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIrFqM5i1n5+gMKg0lic0akZ8kr7oeCVvi03t5wfiUg=;
 b=HWgdDLIjwEcASnewVohnm4JrQ6YX6GfqkPipiTiwanFbwwni6zEqixb5/iMzm7kNWl4Sfb6huhIcoTHFYgo8RNLA/1TPV1mWREY9Mgr/btdPDyvwAdCS+sS1oRNOgJniFF5R/K4YUdFH68X1HeQIXPQexgAJCYLcxrHf+tV1rfS0G8gvlb7SuET4t/RQM/Cy64r6Bf7wj4dwOv2vgTl7iujTLutEjswNx19nx+H/IOjltg2TeQ8SqNxQNr+++AmWfy43hgIC48tf2sJ4U3q19Rw78n1Q/ahxYXDoRqW4Od7ZvzbuLrMTm6FDpii2KsCM1hI8hNDT5ibGBm0If8wkxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS8PR10MB6103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:571::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 19:38:37 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 19:38:31 +0000
Message-ID: <e7e9f82e-d78d-436e-ac82-3ac5de1843ad@siemens.com>
Date: Tue, 5 May 2026 21:38:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images v2 4/4] ci: run ci tests on StarFive
 VisionFive2
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, florian.bezdeka@siemens.com
References: <20260505090627.65515-1-tobias.schaffner@siemens.com>
 <20260505090627.65515-5-tobias.schaffner@siemens.com>
 <c6d3e6e0-5531-426b-8d2d-939b2c9f68d9@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <c6d3e6e0-5531-426b-8d2d-939b2c9f68d9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS8PR10MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ea46ec-3afc-4fc1-ad71-08deaadde318
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	QXpKjSdKzumg8em2ZjRwt3WzgrnE69DtlwzdhERgUn9Dl2eFgmwZpi5YyHNR61+UKMPSeH9FPNS/p7rmflhVefneOQousA5yl3NUpmBtLfjPtnCGx7yPvFz5X5YAGr+bc6sD/QPx15SwZdAlRDobpvBrr2Egq3ReLOvTvdhHqOkELSG4MrSjizUxiK4EAa1Xm5Ed4RfKj0L7ES6VLYVcc/SaLFun/fxcUcOt+Esuys7p3A1rQ7Dg/uhA6cIVwoj8oNnjOO15ppgBejgZ80dWuWqfwHH+XwuMpplT4sz5ZneBJPx+mVUcSm3/oplmtC97xVOhnPcZlUJ0O1vvc7XY0n37kMv47dBs4DajBqKmP2yM/B2K10NKAPKaRh8s0HWmf8/cMfXiO6aGPJPIWZ4+uoMbI0JyOd8tYhB1mRk18yKZej8A1d1RP2hc3WDVkFApOu3/nILBTS7IwMS5FqoBFEhd9JEjNNrxyZjRRbATKnkn65xXfwMmbWTZx80XPehMGvDb+iUwv47XGmtWHHKxZjV+5uVoJ+UTHGgZRR7l5jRF8LdGdh/VUD7FYDMb6VQyw7Hnr+EOGQgEwvD+8iDFfF7NPqFtf9lVuVw2RFzCcNFjT+KmR6lp/RYjijZNSC/yOJnvtaBj/poja8fTP/p6+pkIW48pgg4OPjfwRHLMxTsdP34mgL9m1GMYh8YEukxM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGExYmtpcnF5Tk5SWTI0aWIzWGRrMFYwU2VvRUtMemtDNDFibmIvbkJqellw?=
 =?utf-8?B?SG5nV0dZTkN1MmwvZFdxcHFLVVdOL1ZGaEpoN29XcmlKRVp0eE9HOUZQWnZy?=
 =?utf-8?B?QzRYNUZ6anFhMCtQMkNZYU03WGxrSnR4NUJRazFLaUlOM3hJVmxmeWhkL0pl?=
 =?utf-8?B?Ymd5VkgvOVRNQWxjcG9mTUtEOG5mdHpXblJVWFZZOVRYeXJpYzE5OUltcE1o?=
 =?utf-8?B?Uk45L1Nndmp2V3IranEyRUR1WGxWUDZwVVFibnFMVENBSGdSZnpTd0psbmlk?=
 =?utf-8?B?WTU3NVQyUVliUnNGNVJEOCtkYmEvMUV5NUdhZ2h3SThlQThwN2t4cjY0bG5H?=
 =?utf-8?B?alRWWnlTQ3ZVWFdhbzUyU1hMdTlobzhGT3R6T0hZenkzcEZmYVBGbG91dW1l?=
 =?utf-8?B?dzJNK2krV3hOUzArdDk0aW5vN2tmSFJ6V0I1c21KWnd5bFVUeEFwbHM5ajRu?=
 =?utf-8?B?U01IamVsaVk3MDFUZ0NwWlJwOTU2SjJDQUZFdGdjMXk3ajJVZWhlRnUzOGh4?=
 =?utf-8?B?MGxxZGVvMkE3c0dtWlZuMm5rT2xvREg2ODZCSXcwVTFJZi9ZSStLMmhwSGJ5?=
 =?utf-8?B?YnhuRUl4YUk2cnZ6ZVhoUGlJeFdNcjFsM1ZRTklCeXZ1QjlCdWpZUC8vaUcr?=
 =?utf-8?B?VjFwL2RLcy8yL1hEQXMvcWs4R0lIQ1JFZlc0c3hqVVhzK0RXa0ZxZEw0di9P?=
 =?utf-8?B?ZG9kWCtEaHVWck5CREg1MnNsVFphb3ZxT1lRQk1SNGZncjBiVTA4bnFOczMx?=
 =?utf-8?B?U0l6UDFuNk1kZFpYaWFvdFVtZWdYbm1lcVZQemJQbVJtSC9hcTM5UDR4bk5C?=
 =?utf-8?B?ckhHc1dqMVJDdjQrMk5UYzMxNFAzZ2RBZ2lzS1c5empaWndpT1VibDFUcXFU?=
 =?utf-8?B?WWRXd2wzbXorK09qSjRtYUxCUUxEZWx5Ni91SWx2SUw1aHRrRE5YeU5NQlRm?=
 =?utf-8?B?MnVrUnE3NVpCeVlxNVg4NUprMkFVM2dUQWZFbzU1TlMwREpQS2ViV3pLZVp2?=
 =?utf-8?B?OWF2N2JGRnRXY1k0QlhRNzgySHA0aDU4bEFWa00vSlBLcWR5amFEZzBvbHdr?=
 =?utf-8?B?Q3VYc2tURjRCa1JSV2JNbmhsbzluUy9VN3BTSk9rNmZLdnZZSFNHRC8zQXBB?=
 =?utf-8?B?aUdlMWV5TmlJcGx2bVVCZm93ZlBVUkI0dnVCV1NJS3pyWlNmbjV3SjNncS9U?=
 =?utf-8?B?WkNTTmR3TkN4Ulg5TE1iQWcrUnlIUllwT3FLR2ZkZWlSYUpHbUp1dkRoeDQ0?=
 =?utf-8?B?cHVBaGRwdlJ2UWM0L1J0OE5GWi9KMG1iaWJsdC9PUjV1dUpaWDJSMkpsdFhX?=
 =?utf-8?B?cCt3TWk2T3krRnVQSE5nRTZSa29GQ0FoNmYyUm8wcUJVUWQzdXdGQ3NIM2E0?=
 =?utf-8?B?ZTA4b2ZheDc3SEZNR0NHcmVnOG9Zb3NLcnp1dFZPWmVkYWpaNjZjM3hnVzR6?=
 =?utf-8?B?bCt5aVhsT24ySU5LMThsMjNkZjAwN2NodlpRNkV2NEVseHJhcG1qd0Zac3ZG?=
 =?utf-8?B?ZlNlRVAwVTlEQzBXQ3Q0b3VGYVRPcnFrM3BiUEpta2tudmpDbnF6aEJyMWxo?=
 =?utf-8?B?ck9JTmZwbTA3RHBhVjB6bGxpaCs0cXhoSzFzYkZFdEtuak1mTWd6cDJQb3Zq?=
 =?utf-8?B?TDltZWY5dmhmaHZKdkswU1h3ZHRtU0hnV2ljTnE0WVY2U1Z6TXYrcXdGZHda?=
 =?utf-8?B?aFAzZG0vc25FK0htbFdiWXQ4V3hCYnY5WXNtdW1HRzc4blgyQzhVcE5wS2tH?=
 =?utf-8?B?Wmt0WGV6aTAzTXMwZ2pxVTV6NFBjdFVpc2lXZG1wOE5VOTd0M0RsMUwwUnpJ?=
 =?utf-8?B?K2dzTGxmWU4vQkhZbEY2OC84aDd6SHRnQituRi9xdE82c1AzSEcwVjd6VUYr?=
 =?utf-8?B?UFV2bE9mUUFuRlAxa1FXTXlZdlFwSDZPT0ZwS1RpZm9zTEFsNnVpUERSdVhQ?=
 =?utf-8?B?Zk1aNlpWT01RZC84RUZTV3RIeEw1ak9iUDlYMjFzYVZtY3NqMDViMy93RmVo?=
 =?utf-8?B?QWpVWVppL3dVcVVUUFB2QmV5ZGVzN2wwdjlLUnlNMUlCRTNydmpkOW9ldnVw?=
 =?utf-8?B?QUZrR0VVTyttTXA4aWNHMlRxZkJRRHZET1lRL3QyTWp6WHNFb3RGQXk2aVNF?=
 =?utf-8?B?TEZjU0J5OEtLK3QvOW9JRXhwK0RSZ25tNVdtYzIyeHVyV0VwSTBtdFplU3dt?=
 =?utf-8?B?dW5aNFVjYzdWUzZjNzAxdGpqMXZBM2o1bGxhVDhSZ1hKZG9nS3RVM1A1T2pi?=
 =?utf-8?B?RGhpQUZiWlBpUCtvbkh4ZU8zR2NaNGFLWCsxL05FWG1XSkVvdVpPcW95MlVw?=
 =?utf-8?B?QXZYM0llUlJmcG1XcjNld3dYYXRYREdQY0tnd0k2YkI0ZnNqSlJJRis0cEh1?=
 =?utf-8?Q?W/6GprkNrnEP88MM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ea46ec-3afc-4fc1-ad71-08deaadde318
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 19:38:31.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjtLJiZTyaWXuPtxm/FmMsvoFY65izqXDnkmyZU5XMnZmWzV05nskz/4RniMZcKpFk0QsvbZY7kzKOXFWc+EfGamuoun2JJ9RN7BEEYEMm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6103

Hi Jan,

On 5/5/26 18:37, Jan Kiszka wrote:
> On 05.05.26 11:06, Tobias Schaffner wrote:
>> Add CI/LAVA build and test jobs for hardware testing on the
>> StarFive VisionFive2 board.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   ci/lib/gitlab-ci-base.yml                   | 21 +++++++
>>   ci/lib/kernel/head.yml                      | 13 ++++
>>   tests/jobs/xenomai-starfive-visionfive2.yml | 69 +++++++++++++++++++++
>>   3 files changed, 103 insertions(+)
>>   create mode 100644 tests/jobs/xenomai-starfive-visionfive2.yml
>>
>> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
>> index aaeb778..e297f54 100644
>> --- a/ci/lib/gitlab-ci-base.yml
>> +++ b/ci/lib/gitlab-ci-base.yml
>> @@ -227,3 +227,24 @@ default:
>>     resource_group: board-x86-64-efi
>>     variables:
>>       TARGET: x86-64-efi
>> +
>> +.build:starfive-visionfive2:
>> +  extends: .build
>> +  variables:
>> +    TARGET: starfive-visionfive2
>> +    CACHE_ARCH: riscv64
>> +  rules:
>> +    - if: '$XENOMAI_VERSION != "4-next"'
>> +      when: never
>> +    - when: always
>> +
>> +.lava-test:starfive-visionfive2:
>> +  extends: .test
>> +  resource_group: board-starfive-visionfive2
>> +  variables:
>> +    TARGET: starfive-visionfive2
>> +    EVL_TESTS_SKIP_PATTERN: "ptrace-sync"
>> +  rules:
>> +    - if: '$XENOMAI_VERSION != "4-next"'
>> +      when: never
>> +    - if: '$LAVA_TESTS_ENABLED == "true"'
>> diff --git a/ci/lib/kernel/head.yml b/ci/lib/kernel/head.yml
>> index e2884c2..e5af966 100644
>> --- a/ci/lib/kernel/head.yml
>> +++ b/ci/lib/kernel/head.yml
>> @@ -61,6 +61,19 @@ lava-test-head:qemu-riscv64:
>>     variables:
>>       KERNEL_VERSION: "head"
>>   
>> +build-head:starfive-visionfive2:
>> +  extends: .build:starfive-visionfive2
>> +  variables:
>> +    LINUX_BUILD_OPTION: ":kas/opt/linux-head.yaml"
>> +    KERNEL_VERSION: "head"
>> +    CACHE_KERNEL: evl
>> +
>> +lava-test-head:starfive-visionfive2:
>> +  needs: [ "build-head:starfive-visionfive2" ]
>> +  extends: .lava-test:starfive-visionfive2
>> +  variables:
>> +    KERNEL_VERSION: "head"
>> +
>>   build-head:rpi4:
>>     extends: .build:rpi4
>>     variables:
>> diff --git a/tests/jobs/xenomai-starfive-visionfive2.yml b/tests/jobs/xenomai-starfive-visionfive2.yml
>> new file mode 100644
>> index 0000000..6155fdf
>> --- /dev/null
>> +++ b/tests/jobs/xenomai-starfive-visionfive2.yml
>> @@ -0,0 +1,69 @@
>> +#
>> +# Xenomai Real-Time System
>> +#
>> +# Copyright (c) Siemens AG, 2026
>> +#
>> +# Authors:
>> +#  Tobias Schaffner <tobias.schaffner@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +job_name: xenomai-test-suite
>> +device_type: starfive-visionfive2
>> +
>> +timeouts:
>> +  job:
>> +    minutes: 90
>> +  action:
>> +    minutes: 65
>> +  connection:
>> +    minutes: 5
>> +priority: medium
>> +visibility: public
>> +
>> +metadata:
>> +  docs-source: xenomai-starfive-visionfive2
>> +  docs-filename: pipeline-xenomai-starfive-visionfive2
>> +# ACTION_BLOCK
>> +actions:
>> +- deploy:
>> +    timeout:
>> +      minutes: 30
>> +    to: tftp
>> +    kernel:
>> +      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinux
>> +      type: image
>> +    dtb:
>> +      url: ${DEPLOY_URL}/jh7110-starfive-visionfive-2-v1.2a.dtb
> 
> So, this only supports the old v1.2a, and I assume we need to be exact
> here. Maybe name the test file accordingly so that it is clear which
> hardware needs to be wired up?

Generally, a good idea to reflect this in the name. Unfortunately, the
test file is selected using the TARGET variable when scripts/run-lava-tests.sh
is called in ci/lib/gitlab-ci-base.yml, which is also used to choose
the machine configuration.

I will add a note to the test file and also mention this in the commit
message. Hopefully, that will make it clear enough, and someone will
come across this information when the board is replaced in the future.

>> +    nfsrootfs:
>> +      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
>> +      compression: gz
>> +#  BOOT_BLOCK
>> +- boot:
>> +    failure_retry: 3
>> +    timeout:
>> +      minutes: 5
>> +    method: u-boot
>> +    commands: nfs
>> +    prompts: ["root@demo:"]
>> +    auto_login:
>> +      login_prompt: 'demo login:'
>> +      username: root
>> +      password_prompt: 'Password:'
>> +      password: root
>> +
>> +- test:
>> +    timeout:
>> +      minutes: ${TEST_TIMEOUT_MINUTES}
>> +    definitions:
>> +    - repository:
>> +        metadata:
>> +          format: Lava-Test Test Definition 1.0
>> +          name: xenomai-test-suite
>> +          description: "runs the xenomai test suite"
>> +        run:
>> +          steps:
>> +            - ${TEST_COMMAND} || lava-test-raise "xenomai-test failed!"
>> +      from: inline
>> +      path: inline/xenomai-test-suite.yaml
>> +      name: xenomai-test-suite
> 
> Jan
> 

