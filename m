Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D075650
	for <xenomai@lists.linux.dev>; Tue, 29 Nov 2022 07:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc/7QOqY5kGihByj0pPfIN7F3TwlNoTvb4FyOnWEsJqJtCLyEC3Vt52cHOVSduvP2hkDXPrqJgj7SAz+xtNXY8eE2wUu3M+sfxS3v4GYcQSqTj6jwjHt6tKHyEzwNIKkANHGc72Ce870/t7BUrTcUpc4Bbp9q8DeBSnafoKtqOreR3xchv4mEHfZr0P+uESehlgKANotd9tgBKI1uqnhZueIoa9Ad8NtUDxcQYXb0fkNKb+RNJvgBP+Hg+N2SFoaoKmTPpz84QgQU/P0nZ50gqn6TcLEG7yuU+bwkKD5EaKRfkT6yL1kCL0vcNmurcz+HqADtNuE3J5MrBtJY2hXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5+n3FlqAKd/pMkrmismFXzfgB8J2tEwN+OTVr0MBVU=;
 b=X68siefid1+kkche4l9TM9hHk1sZkR7DvJDQniORbyStrzTn9ZeR9zUOwK/c1cBgo3tYcHwpzVbnwoQfK8PTJah1C3ZZfu8LOVBKd3ndXXqr46FLClO4nEIBIhmrBbwGcKe7hB5GMyDSBUf6R4jF7ULgqXDu0OnKh/6DqUeNVB3NRvM/A0u2hDKvDSF84W4Lz1XDZ1eSg22Ef4/w/UMyJd8ArbA6ZiXtVavSG0yWRvPbRZVaZHSaiwiylRDLYqdFxf3ffJMpSn5/p/HbycnsLvzps6O4nD6vfZs3jAGYXG7LmrWqriTtBhc0yNMvS2jJNBQ4KZvzkOuRJpwCQeUWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5+n3FlqAKd/pMkrmismFXzfgB8J2tEwN+OTVr0MBVU=;
 b=gQCf2nNglf/lIPFDqeQzAaMkHXb115xasGiUfkRcNknR+gkcuV/LKhBaM7LvvwRuBqBItYT9A9PKlzP7U58F1PAu2QeFgOHTWHgf+9UAc53eraYIzeOaV5LrPCRTp8fVkIslaEaUYAlGpMkozL1qBTR92zFsXpxDkYkeL6FC0KeQuwpPNsKN/DeL3SzwB+xooAXqQB0jf+IBNXylP00Ef5huxa30O9GNJO5us3Qchr0PG2bFAJX/isCuT9gwCh+rmLPfgw8ZkXorohD6uRnFDAzbT8E3p+zQupZraFveiXJemEY5wfE6456ML6yLuLfONfF/L8IsuoTHCDbX8S3USg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5669.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 07:01:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 07:01:55 +0000
Message-ID: <dda4a74d-84d2-7282-7517-74ec4cd58436@siemens.com>
Date: Tue, 29 Nov 2022 08:01:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Synchronization request of supported ipipe kernel versions
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Greg Gallagher <greg@embeddedgreg.com>
Cc: xenomai@lists.linux.dev
References: <c7b9c30c4f0685adbd3f3829b9bba4b42835177a.camel@siemens.com>
 <CALLqZ8RgN_WNdf_k=My5m7kyOKFw=gmVB36e3ztQVUjsN9V_7g@mail.gmail.com>
 <CALLqZ8T8ZxV2bJD7h47t_cQDkAyb9dMUpA2HOUO0x=0_0Pht2A@mail.gmail.com>
 <15331e9004e2a34e03bada655de9895531befaa8.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <15331e9004e2a34e03bada655de9895531befaa8.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 4064b7d2-3f2b-499b-a7f3-08dad1d799d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FEMAamhEM6DMV12pHE8Y6E43x+LhoeFZPVZNVbVS3cayYlvFLQoB7q16OLGhiYLlKx0c6QLpsAVedxsdT8EQbh/GpGM/hQOj5x/vuIL4WSu8hfSpxS1JcjGVXOZsUrlr2HeloNfyV7yqlxq6C9S4ezNnDcIEeDfcEXJrdcOG7iNomgRjUAZcAA01kvBuMCHoLI1PRHMS0k2L7FnaBEs1rdJEaxBNDhQl7BwqvTjoKvCV7lFjAt6KYxtKNEbPoqn0jXDEdzKKEBzMqru2X/dgj3SI4qQ8Dt4bic9Ev7cUfN/BlwQuZefhURpi6A6fTA4i5GXTZ4EG60DhXqXS+t4VE7ObABbDM2ZY9F8I6L3GyV5AC4AUHSskqyHvt5mWIp57C/dZIlq9lvgc8XDssvKnHjK+13Mhs+BhY2i/+IFxgtbp1e1s18WfzwjQGwX1SnsN/2gXaaSdS1mgd3ovI7AdjHOaUNNCU7UEzUymTiyXg+zMfHq7FOWCcqX6vfEGIxiqAZJO63mlrYf5gVoy5p1UQE5y0qkZbW0r5AuhZgcKurFujz0k0VszhINRzeHimz4GKr+yTZ49M7COok108yBOwJwsF3wVFjryKgMGTvxv9fcRxdbqYPcGnvWc2vesk0C56c8caRZZgp+Kw/Ig7kohpyCTjHgfUFgk1CKB2mYBsG1knvH73zw0LbbtS6xgXfoQh5ttFSQw4nQj7Q4uwgO4lIsVwsaqVbsCwokyj/67Lcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(66899015)(2906002)(31686004)(31696002)(86362001)(2616005)(186003)(4326008)(8676002)(5660300002)(36756003)(8936002)(4001150100001)(44832011)(66556008)(66476007)(41300700001)(66946007)(110136005)(316002)(82960400001)(6486002)(478600001)(38100700002)(26005)(83380400001)(6512007)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTE5ZUQzZ0w1REl5VlgzZFAreWdRUjk5S3dTdXkzOUloTWl3S254SzZBR3Zn?=
 =?utf-8?B?VzEvbi9aV0JmRytGQ3Q5UTdhamhjbkpwSmlJRmNKK2lQUWxUMXYwK3B3dXhC?=
 =?utf-8?B?c1p4dWdyNHIwc3Z5VGJkN2dYcFMrdmc2TE90ZjRDS3F1U1pIZml2cHIvQlBN?=
 =?utf-8?B?d0x2dmpiK1NlRDlObnNsa2FjSlFQb2ZpeWVaaFJWOFpyZTdPS0dJUXc1TTVj?=
 =?utf-8?B?emVBdXZiSWNZZXBrTHNXMEJaVjNyS1RmRWJiNDR4TmFyR0FPWTlzZVdySVkx?=
 =?utf-8?B?UkxvRW1FaVd2aktJVVMvR2FrMDJiSlhjbEFQeEp2ZGtCRWN4Z3VyYXN1emI1?=
 =?utf-8?B?cTljcmxUSUlnaHlrL0lKQmw1djNST3VqcEYyam5Bdzc0Y1h4YkFVWnlEUmxE?=
 =?utf-8?B?MW5zR012UjJCRFJFYUxQMy80RTQ1RDk5ZmYyZW81dHk2bURBRk9RSGdkRzZP?=
 =?utf-8?B?MHgvVlpBK0J0WGdDbkRaUEJ5eU52QXFzckxPdUR6TVVucGQ0ZGlEbXBoWFdB?=
 =?utf-8?B?ZmVWTnorQkZiV1NOdGovN2VUTzdmWHEzQUdoeEVpRzYvN1A5Nk1CODNiZFFs?=
 =?utf-8?B?VXRVRjNyTUR5a1I2emhZOXRMVXJURXV4bW9teU9qajgvMk9XS3o1WGQ4NUxV?=
 =?utf-8?B?dXpQT0JFNTdKaTgxdUd6V0l2UEFGSjl5aWV5ZFN5VTUrYm5jblI3eEk3bDVT?=
 =?utf-8?B?cWp0dnFnM3I4TFNubThUVWxJVkxqVDR5VmlTNkIrMSt2RjFnc01VYXhqeXZM?=
 =?utf-8?B?MXNJb0M3dHJ4RzZJYlQzNE0yZEhXMnBhWFJNMS9jc3k1Njl0WE9FV1dpVVBn?=
 =?utf-8?B?L2F5d01KQ29MSURacFQ5ZE16REMyVWFXWStCOVg2YzVETmtVZFprZ09jblFv?=
 =?utf-8?B?MkVIc3hHQjFucmNEN25YdHNSRW0xK0JTV0Y1MTNDUjRYcENSQlhGb2E5UjJj?=
 =?utf-8?B?V2pEQzhtTE5wbVpxTmp3OHIwTXFNdHpNc01PekVZb1JoQjZYQ3JZU2NoZWNZ?=
 =?utf-8?B?UFprbnA1RFFoZ3VXb3ZydGVVN3hBdlRTSXp5Z2JxcEcrRUNpVWVPZ1hIYytM?=
 =?utf-8?B?d29Gd05GZnFBSTk3NDJrMDVZSnE3QWhXc2llVHlpY3l2OHNTOXZvNFdDa0dv?=
 =?utf-8?B?bE1qcjlNRmp4NjkwcmJwd2FGL2dFczQ2Y3hWUXB2c1Erc2hPYmJXNGxRYXhj?=
 =?utf-8?B?V2RONzFiZlk5T1VoLzA4RjI4VU1XR2pHSklzQ1ZPaUhLdWhJa0xDU0FKNFFw?=
 =?utf-8?B?ZUhVbXA0VXUzdzBHaEdYUysreVZPM0tEaEtqeFNSall1RndHSkdlTVJ4akpl?=
 =?utf-8?B?aWJweHZtUW9mdit3cFFRaEJJT1JIRTN2LzhFWE5rYjJKRWs2VDRaZjBVKzVm?=
 =?utf-8?B?Vi9uOXR4Q1ExU3B3a1FJMUE3VGdxVXk3aEp1bWxRQ2dJUVd0a1JkMkNNMjk1?=
 =?utf-8?B?QXhJOUJ2K0kwclhBSlU0eVhOdWtIanJrQ0NVSEFDK2NLamdsckFVRWlwenYy?=
 =?utf-8?B?cW9kYS9PVmR0d0hucnlWR1g4S0dWOGlGbVV0T2UxQmZ5QUVIUExMNS8vMTBo?=
 =?utf-8?B?STZCY2xhZmc2V0ZmbkZ4VThwSU9FMFBWYUc1Wm9xcVpYOWJGZzNYcUJvczBl?=
 =?utf-8?B?Z0NnL2t6ZEM2SmdXL1dlaGJkK3NiUSt0dmh1ZUd5ZGdmT0RpaDUvaW96bDll?=
 =?utf-8?B?V1FJci93d0FhaCtEQTJHRFdyVGZKVDBqdGNmV2RYTDZYakp0QW1BR3NDQ3lo?=
 =?utf-8?B?Y2lydzBWQWVDT1NXNUNGSHovYnVUQnJrQkFCaTVLd1d2RWo2aGVvSmJmY3Fw?=
 =?utf-8?B?cTVFUVlldmg3N2s5bHVGSTgxa3ZkbHNaRGtZWGJIV0NHUkV1RHc1VVNZN0Zk?=
 =?utf-8?B?Q3RtcGZmUXNRdjVHN3hJWmRneUpDNXVOVXhDbGd5REwrYm1OMldMR25VL3la?=
 =?utf-8?B?SzVYQ3RVSWp0QUFMb0x0N2pwSHkzZXZCUC8zbldHS0lvOFlkK3c2aGR1R1c2?=
 =?utf-8?B?cElLektmQVJjaWhKeDQ5ODA5bEFueFFZbERNeEhMMWgrYlBIR2dBUVk0THE3?=
 =?utf-8?B?NUFlQnFzWmpsQVRiMTY4bENuaVp1R1NxSHk3Y1pTZXdMN1VxaWI5WndOc3NJ?=
 =?utf-8?B?VU8zZkhwZG5lV0NtSk1qSDREekNsMnB4a29adzRka04wTHpVQ3psaVlLS3lE?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4064b7d2-3f2b-499b-a7f3-08dad1d799d8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 07:01:55.6882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJ5GVSU+KDXS93a3yozzetr4jwx7fhLqT433j4t0bj4YV1BDqNRdWpSSBcALipC0cOzAyrPENt2yWCl9WQgDqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5669

On 28.11.22 17:36, Florian Bezdeka wrote:
> On Sun, 2022-11-27 at 22:09 -0500, Greg Gallagher wrote:
>> On Fri, Nov 25, 2022 at 4:13 PM Greg Gallagher <greg@embeddedgreg.com> wrote:
>>>
>>> On Fri, Nov 25, 2022 at 9:11 AM Florian Bezdeka
>>> <florian.bezdeka@siemens.com> wrote:
>>>>
>>>> Hi Jan, Hi Greg,
>>>>
>>>> while tracking down some ipipe issues that appeared while trying to
>>>> modernize the CI toolchain (Debian 11 => 12 update) I had massive
>>>> problems with all the different kernel versions that we have for
>>>> different architectures.
>>>>
>>>> Currently we have:
>>>>
>>>>             4.19             5.4
>>>> armhf   4.19.229-cip67+    5.4.180+
>>>> arm64   4.19.144+          5.4.180+
>>>> amd64   4.19.264-cip84+    5.4.223+
>>>>
>>>>
>>>> Might I request to synchronize them?
>>>>
>>>> It would simplify things a lot if
>>>>   - all 4.19 versions would be based on the same patch level
>>>>   - all 5.4  versions would be based on the same patch level
>>>>   - The 4.19 and 5.4 versions would be based on the same stable
>>>>     patch set. Currently 4.19.266 and 5.4.224 are recent versions
>>>>     with the "same" set of patches applied.
>>>>
>>>> Concrete example:
>>>>
>>>> I had to update my 4.19 baseline to recent 4.19.264 to make sure that
>>>> I'm not hunting for something that is already fixed. With that I pulled
>>>> in the following upstream commit:
>>>>
>>>> 211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle")
>>>>
>>>> This commit breaks (or will break) the pl011 driver in case ipipe is
>>>> enabled. It is part of 4.19.253 and 5.4.207. The only tree that already
>>>> has this commit is for amd64, but it's not a real problem as x86
>>>> normally doesn't require this driver.
>>>>
>>>> a) I'm currently not able to fix that for arm/arm64
>>>>    (too old but not yet affected)
>>>> b) If 4.19 and 5.4 for arm/arm64 are not based on the same stable
>>>>    patch level I have to backport for each arch/ipipe.
>>>>
>>>> Let me know what you think!
>>>>
>>>> Regards,
>>>> Florian
>>>>
>>>>
>>>>
>>>
>>> Sorry if this is a double reply I think my original didn't go through.
>>> I’m good with this, I can update the arm/arm64 branches this weekend.
>>>
>>> -Greg
>>
>> I've got my local branches based on 4.19.266 and 5.4.224, running
>> smoke tests.  I haven't looked into the pl011 driver breaking yet, do
>> we need that fixed before I update 4.19 and 5.4 ipipe? Once I run my
>> local smoke tests I should be ready to update the branches tomorrow or
>> Tuesday.
> 
> If we do not fix that upfront I would expect Xenomai CI to report
> "hangs" on next pipline run. 
> 
> Jan, can you also offer 4.19.226 and 5.4.224 for x86?
> 

ipipe-noarch ipipe/master and the heads of ipipe-x86-4.19.y-cip as well
as ipipe-x86-5.4.y have been updates, CI is running.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

