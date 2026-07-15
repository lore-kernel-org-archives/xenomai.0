Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A411541BA6D
	for <xenomai@lists.linux.dev>; Wed, 15 Jul 2026 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141268; cv=fail; b=F9uYg7NAXQ93Gg0VFhyiKLAhiHBE8jNSiqumm+udxFCRgDJggwDm1EcpVAf3Ut+GGdZMC2zSUGybgmPcO/fyFtQz+DoXaBR6ZoK0z/k14Zxe1aaRrMFtmqtRziu9PA+3bWxEoLIOSFPYfRedTIt+LMRsyVARVL9JtnRD/PQyo+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141268; c=relaxed/simple;
	bh=wyA5Ff/0S0g9DiGdLEV8jUT8q5PXxi0cujtS6/4Q7mQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WP0KYGKf8hKsDqQ5GPdI3blbBAmGX3UN3dbMBPyDWdOvmK0e9lScm8TeIIj3eL5eTSJ2U6AUIBAwXIXDIVGhR8ola8cv8crq+z36amPAyKEHQeV1wevJh0p/PqXo6gsJtRJQKsl2kcT7E4JsFJ8j312l1SjWbYrusDlhrlY0bS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=uXptqoQB; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="uXptqoQB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOBoeKmHAfOjjjTfOJ99uMaNy5v8sWJY75AyPVlhY5kotpm58DR38fF/iRqJl8g70QaHKTRa5HPCzMKykjkdyVCUDXm3RbZ9zKwrhpCx45i+H0HAKNbc3gGWSlM5NWU586uW1XJTrI30FaHV/EfFr7RONflwUsmm+klyX5g5msR1CxzL4pMZk0pWzyMzke60Sf1HI06iHE5mo9PlIBwEVXuARxX92hE9gETagYEq8UvLdXQW+Qwk9lgu6D5boW0C70WqFvbFgCeYaw+q3XxWv0+vBUI96golEsH8JmcoXJRuWc8p4YS2lCzCQcTcdnOSntRXp41169s+Aw/U4LjHBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2c+esNyBA7FCfjA/Xzlexb6OPf/ySBwZkZjwCogkMc=;
 b=jtNk7ld3V0gT8aUM2AN9es1Fs0zx1gNiXLViat1QuQ+9XLC6Lt7diUzir0o32tDwdAmpYJc9WjIhNrADAXTWyLBgTH09xhYxXB9jPdgNO7UY/RxfS4LBR9Ci6Tk8X7rFcHmbpdNMIsj4xu2OUgVm8+CCZ5r8xlEsTtsHo9vrD5mYCoQvfJJe/Kfhea3NyeJS2eu693zuRrjM5t9cYA3MLxsNkJkuVsIX1rysNBsga6WTiB1LvfBSj7bMOxHvsfhsU40zclLtiepcrHo7CBGcBxDPhHCvC1q5uYCnMwmSFqeMvm/rXFpB2OBwPI2Y3FeOiHLXH00DR2cM2BmibsgL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2c+esNyBA7FCfjA/Xzlexb6OPf/ySBwZkZjwCogkMc=;
 b=uXptqoQBfF6cZ70OcHj18RzV4U1zQF7bqa0cDwkxSQrrOw/nyQ1c+xVvhhULfxRTHJRskNzp8P4jCMUFecKrL8GlZ4MYXS0kcF7M9mVfecLozMfhinYt9GPQvcDfUYwN9x9q4AhXzSjyKdNQ7pzieW0vqU6XaKgRWipE7IjmQZyuO2vGNEQDWC+VqyVkvrBXwHqgOpW9fRVowkg3fd5C/3RtTBDyBsDK4At+MWy4o/w1O3Ln4jqckK0uVbV/hV9CE2AH2tJihsqOhI7+nOyl/WTfBLnuA+OydeOuyDNbz1COWZg/N5p3nr5VfuN7snPnVqAIhgQyndBOpdlQ0ibJ7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB6727.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:401::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.20; Wed, 15 Jul
 2026 18:47:37 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%3]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 18:47:36 +0000
Message-ID: <8c44d8f7-25a3-4a9d-84fa-4b0c0fb82032@siemens.com>
Date: Wed, 15 Jul 2026 20:47:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH xenomai-images 1/3] ci: use stress-ng to stress EVL tests
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20260715092822.223712-1-tobias.schaffner@siemens.com>
 <20260715092822.223712-2-tobias.schaffner@siemens.com>
 <ed278400f8b7ca4cf3ad1c653989f86db14d867d.camel@siemens.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <ed278400f8b7ca4cf3ad1c653989f86db14d867d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::13) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 37751158-15ce-4d5f-cc1a-08dee2a189fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	HFQVuWmxWplPY5ws7s68endomkSHY2+xIthT5UMMdG180O0RtP5fZF9HVR8hcH2Wj39a58gxTVyfIv864BCWvvlBO88FcXdw2cMzTTZVgu+xTa7J2ydoMalxXegtss1QY0iNBnOAq3OIEI6HQ1ybuCwhzU1FzVhuCFazZjv42PYjb3RFKQ+nAa3Mrq1hI8S08E+g6CIpnvtVnIxAQcUP/LoNuoI/5nJkl++Lnd0K12C7lCVouZVI42d0u8c+FKYzG819R69cQWcvuWPlDAxcIqxfLE0t2bVdmTTf8wKt3k8jIk0fVJzDTzvHZ20PC46BqiC4hpgpkv/C3q4dbeeizgsmHl8bP6aY0q3bUmG1l7hyeXXUgDrrJhlyr7qrr0xqimVatSEuhb/Y6Xamw5vJYKPqAXlJ0JqXubKKzE9hEf3f2S+958nepyoCUu9+UqjElxTe6UwtZCK/GrUYOePE+FdLHeCt+jPqYTwLfDrxMcSzfHFMJHxLGa0VnERG60u/23Tci4okdj5svuWF1vyikV1HUXHtjsRHDJkXxgG3gtvXfP5DJgUus35JAXfw5Lq0QjRYkuzcVqUzA4N9HqFNpcWrU//EgkxFenGodNjmxHvyTs+8WfDdH0myGY4SanSp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFlIVnp0c05oUE16dXg5SkJ1TThBTW9yalJ1SzBLQnhwS0FKQkVFR3Zxd0lY?=
 =?utf-8?B?WE1pRjBjQUp6RnBrK1o3b1RWUWxyeCtvdGF6Vk52V1IzRVhpUGRoRk9kMDAv?=
 =?utf-8?B?Wk1PR1kxT1V2c2Zoa0lPYkhzQ3VSUHpwMENnYnhBNFJ0cWdUaEVOeVNBRXNC?=
 =?utf-8?B?VysxMmN6eHoxbEIvUzlKdlVWcWtoanY5SUc2UzNjSVZCcTB2TGdFbEdBLzNN?=
 =?utf-8?B?ZHpTZnBkbVBBUk5WenlrNy9Ia3hBZW9meW5pSUFBcXRVa3FGUEl3dlk1RkZl?=
 =?utf-8?B?dG52R2RlU1pXUi8zTFkxVnI1K2JlYVZ5L0NwT0ZkdXdOREhEQXBrSGhoWFZZ?=
 =?utf-8?B?WTNCblM0V3Q4QldQN1BCVWJCLzlQdXZYSkRKb1dMT2JuSTV2NytpQ3FFQWhG?=
 =?utf-8?B?YUVuRkZTbkRoakYrS0hHbzI4aFZQd0JsdHI1cSszSDRwUDBmTnNyVDN6eWlk?=
 =?utf-8?B?YzBiK0tXVG9MQTFuLzc3bExYUjdGSXRCaCtmYjZSLzNHbGszTWxKVUpsbXMy?=
 =?utf-8?B?dFR4aTBuK2tDdlFVNkRVSFNYbVM3YWNrYzhmTFFsRzg5d1lFOHV0QWtUcW80?=
 =?utf-8?B?MjJmWHlhTFo0K2dSZmw5VWlsTURBRE9uem50V2tkWlJ3QkhqeUc0TXhRQnVO?=
 =?utf-8?B?UE51L1VKOGcxbkZVT0NqZ09YRDFHTk1veFdIc2YwQkM2amlJOUJqV0owcG1O?=
 =?utf-8?B?RDNkVVE4d1lHMXlBTUU3bXlES2M5VW0xMHo2N2gyUWhOTFFqbVZ2aUNpZHRL?=
 =?utf-8?B?OW9yYXlrUVkwWnA5MjNOZytCTHhMTkhLYVlBUEltVjlyKzVwckJ5dHFPNncw?=
 =?utf-8?B?N01wcmx6V0pUZFRSZDJIZlR1UXR4dlJMYWN1eloyMVA0djJXbEMwYXNSdXh6?=
 =?utf-8?B?cGhqcko0V1g3QkU2djI1KzJxQ2UxUk0wdHhnVU5ldjNKcC9xaHlYNFQrU2w1?=
 =?utf-8?B?eEFSQjY4dGY3UE1XeFFpaVkrUUxIekhJL3JYNmNkZ1lheVpEcHRJeDN6YjVm?=
 =?utf-8?B?WEs2MHVoVmlIK1F6OU9nT1BqdHdwaWQzeWREZkh5TmIzbzZjK0p2anRVc0Fm?=
 =?utf-8?B?blhBeGp6TkZwWkJMRUFFMnh5NkRzbUFKSDFzcFhoei9nVTNIRHpVRW5mTFNN?=
 =?utf-8?B?cUd4R3V1emdnOTNVM1E3QUtReDVoTE9scmo1VUNidUFHNnFkQnpGOFJMemI3?=
 =?utf-8?B?SzZ2ZmpmQkZBc092M2FpOXpuSmI2MTlIQUswWTQrb2wwRHRHbzRNWGtBeEVJ?=
 =?utf-8?B?YTBmZUtVbUFrU05YQWxkZ1dpcXYyVlNxN01ncXg3bStqR2ZQVDh5K2EyMFZN?=
 =?utf-8?B?MnBVeURSMkJkZDB4cm50TEQyRUJVdWhObHRMUmg2ck8yRVBwYjVrSWxxZDRW?=
 =?utf-8?B?eloxdmovaEtyZ3NLMEVoaGZ2VStQd1VoSUhkVUNqNFN2WXp3d25lV1h6Qlly?=
 =?utf-8?B?UjJycytydDNOdVZuNXV4eThxN2RYcFdVc0c2YWdHVC9FRkQzUWswOEpCT0NI?=
 =?utf-8?B?S0VHVitURU9vMVhTRFJDSnIzVmtWRFhWZ1R1UEt1OVJlZVIyNmhBazhwcElv?=
 =?utf-8?B?V0F5akM3NGJzcHFDaVdHUG43NFNSQmlJS1NYMHQ1Q3Y3bndXRjgrOXFKYlNF?=
 =?utf-8?B?Vi9nYTJtbFlMRzI3cmt2bmcxNVhRK0ZoZitveVFSSHM2OWp0dHVkZWYyZytJ?=
 =?utf-8?B?TTFzNUN0c1dNYTVxTGdoSG1ndDk2SVF1YjBKSjNMbjd0N00ySHpHRG9jaVky?=
 =?utf-8?B?YXg2dXBOWGhVR2lGUTFZdTZ3U0ZmVUVKQjBJODFUcUpLc3NMcGVlWVB4THB4?=
 =?utf-8?B?ZHBvOWh1RDZFQVhEWWltdTRCN1ZELzNOd1AxYlg1NWdwdG43V2ZUWVhpamdH?=
 =?utf-8?B?MU9xNHRPVmtZeStaS21VeVo5c0tJYmNHdTdxQXhmOUV0L2c2cGcwVjUxUCtx?=
 =?utf-8?B?KzdmV3NqRWFBeSsxZXR4NWFVRWlYY0lMRDlJNlhnQUtjM3VFNTFpalN2Vllr?=
 =?utf-8?B?b3h1K1hQTUhWUWtXdVFkZ2VBZm1EZjIvK09zL0pnM0U4d28rdmU4SjNpS0RC?=
 =?utf-8?B?OU1ZMTBTRUUxdWxWaXBndUxCemdGSGNVUnhaZWRCNzM4SzkwazhRZW44dzQz?=
 =?utf-8?B?K2JQRjVycmttc2N2cXFDdktYQTdjVWwrMXJZVkd3d1FmYm5EMlo4cmxQWmxn?=
 =?utf-8?B?cHhNeWZzaG9BcEpQZWN2OUt1N1ZlbXV0UDA5MG1XTTY1VjFBVXJwd0hBVjhl?=
 =?utf-8?B?YUNCL1M0SnYzaFZGQzMrU3RqRGpDSWtoMTlXZlZLaWxTRXo2QlowSDZDNGpO?=
 =?utf-8?B?NCtYTFFWaE9VOVFpMVBDTEphV3NNRjBTUnNxNFkwTVBiVlZXalpRb0pyak1n?=
 =?utf-8?Q?C1tD2+nvN9yBQU0J6HVablG1XICO7Zd5hS8jHOfq44zQ7?=
X-MS-Exchange-AntiSpam-MessageData-1: cwfzRh5+i/BJf1gKUek5tly2KvoFOF4SzQo=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37751158-15ce-4d5f-cc1a-08dee2a189fb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:47:36.9347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLt8F5EC+aW2rCJ2qNpmGtamTnTyBPChxYehmp2VhtjYoIfG1W36CLAacGX61MU8YDkQn6EmqpdYl4ad+5+AtLzP3gEgkui99/npRUh3Ook=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6727

Hi Florian,

On 7/15/26 15:00, Florian Bezdeka wrote:
> On Wed, 2026-07-15 at 11:28 +0200, Tobias Schaffner wrote:
>> Use stress-ng to apply CPU, virtual memory, FPU register, and procfs load
>> during EVL tests, mimicking the stressors used in Xenomai 3.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   ci/lib/gitlab-ci-base.yml | 2 ++
>>   ci/xenomai_4_evl.yml      | 2 +-
>>   ci/xenomai_4_next.yml     | 2 +-
>>   kas/opt/ci.yaml           | 1 +
>>   4 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/ci/lib/gitlab-ci-base.yml b/ci/lib/gitlab-ci-base.yml
>> index 0540628..a3359bb 100644
>> --- a/ci/lib/gitlab-ci-base.yml
>> +++ b/ci/lib/gitlab-ci-base.yml
>> @@ -25,6 +25,8 @@ variables:
>>     ADDITIONAL_TEST_TIMEOUT_MINUTES: 10
>>     TEST_MAXIMUM_LATENCY: 0
>>     TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>> +  EVL_STRESS_COMMAND: stress-ng --cpu 1 --vm 1 --vm-bytes 64M --fp 1 --procfs 1
>> +  EVL_TEST_COMMAND: evl test --stress-cmd "${EVL_STRESS_COMMAND}" -k $(evl test -l | grep -Ev "${EVL_TESTS_SKIP_PATTERN}")
>>     SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
>>     SSTATE_MIRRORS: "file://.* ${SSTATE_LOCATION}/PATH;downloadfilename=PATH"
>>     SSTATE_MAX_AGE: 14d
>> diff --git a/ci/xenomai_4_evl.yml b/ci/xenomai_4_evl.yml
>> index 283a1fd..c6a92b8 100644
>> --- a/ci/xenomai_4_evl.yml
>> +++ b/ci/xenomai_4_evl.yml
>> @@ -29,4 +29,4 @@ variables:
>>     XENOMAI_VERSION: "4-next"
>>     BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>     CACHE_KERNEL: evl
>> -  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
>> +  TEST_COMMAND: "${EVL_TEST_COMMAND}"
>> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
>> index 6ef4b6a..7ecfbb5 100644
>> --- a/ci/xenomai_4_next.yml
>> +++ b/ci/xenomai_4_next.yml
>> @@ -21,4 +21,4 @@ variables:
>>     KERNEL_VERSION_WITH_QEMU: "head"
>>     BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>     CACHE_KERNEL: evl
>> -  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
>> +  TEST_COMMAND: "${EVL_TEST_COMMAND}"
>> diff --git a/kas/opt/ci.yaml b/kas/opt/ci.yaml
>> index e1466a0..f9e4bb7 100644
>> --- a/kas/opt/ci.yaml
>> +++ b/kas/opt/ci.yaml
>> @@ -20,6 +20,7 @@ local_conf_header:
>>     xenomai-ci: |
>>       ROOTFS_POSTPROCESS_COMMAND:remove = "image_postprocess_sshd_key_regen"
>>       IMAGE_INSTALL += "customizations-ci"
>> +    IMAGE_PREINSTALL += "stress-ng"
> 
> Hm... As the CI configuration is now requesting stress-ng it seems right
> that it is pre-installed by the CI image.
> 
> OTOH I hate those loose dependencies. Maybe the (lib)evl test package
> should pull it in instead? So that the dependency is handled at package
> level. Someone else might like to install the test package and get all
> dependencies accordingly.
> 
> To solve that properly it might make sense to make stress-ng the default
> stressor. That would allow the packaging to properly depend on it,
> instead of only "suggest" stress-ng.

I see your point but the decision to not make it a dependency was
intended.

First stress-ng is a debugging and evaluation tool and we do not want to
have it installed in production most of the time.

Second there are indeed persons/projects that have specialized other
loads. OSADL for example is using unix-bench in its realtime farm.

But most important this is a huge dependency. The large number of
libs needed for all the implemented stressors adds up to a total of
~240MB. Imo that is to large for libevl which also targets embedded
systems.

Best,
Tobias

PS: Taking the chance to share that we now have two EVL boards in the
OSADL realtime farm. Running on my 7.0 version port that I had available
at the time but will get an update soon:

7.0.0 #1 SMP PREEMPT EVL Starfive/Visionfive 2
https://www.osadl.org/Long-term-latency-plot-of-system-in-rack.qa-3d-latencyplot-r9s8.0.html?shadow=0

7.0.0 #1 SMP PREEMPT EVL NN/Raspberry Pi 4 Model B
https://www.osadl.org/Long-term-latency-plot-of-system-in-rack.qa-3d-latencyplot-r9s8.0.html?shadow=1

> 
>>       IMAGE_INSTALL:remove = "sshd-regen-keys"
>>       IMAGE_INSTALL:remove = "expand-on-first-boot"
>>       IMAGE_FSTYPES = "${@ 'ext4.gz' if d.getVar('MACHINE', True).startswith('qemu') else 'tar.gz' }"
>> -- 
>> 2.43.0

