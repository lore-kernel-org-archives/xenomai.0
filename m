Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE31F9D2
	for <xenomai@lists.linux.dev>; Tue,  2 Jan 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="eQ+mKXLV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwZDAILb6fl6H6AIN/fPaf8a7/O6QxCNv507u1I9l8ALAGX9hOHppzphTGuD48z0CDSfYnUSof5fUJf2uyzqAug8fuOpX1bgi+/Goh6Y6NhTeEqIsYMv/K7uLrw/Pbz128FSYOzwG7xXx8KT3CfXETIRdpaz0h73gPBhc9qVA8MPMRGlVa3lXGq7TpAmCXeni+zGJp6h71WXJqCTU2byJFc3M0w7dQMsYU5LtG1x93+jmKdiLR4dvZQ6eQYWE5TFRL22qwboUTkkd0hPgzGIn5QN8imuLp8HL01TCLSCq1QVr9vd2FwARIyXQQn0pq3LRr+EnZcpNVvVasSNh4S9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RFX2A8pSlTrVJBcLrzBt1StZVdXpW/IR4g97MnLt7s=;
 b=Y1862IQXDLglaK7ZHgFvkOAEId2GCBpA8qkdfBXexp9w2owu0LS75RXRZyYdQgCe54jQ4grzS4xDPC+RdoLerBooO5VHKCcZUl/TRUmbSI2vLDPhG+Kt+4RHaw+ZwFNq5kBM6DJm79s/Dhr3UHZJxa+nUOTfoCmo/vykqdTOQZmr2AJqTosYL6sZVEtSF/8/jiHT1DvLJxkl27fmfOeGz+sKz0hA+7pg2RXjMkpJ9pMm8kVSMltjxc/f7Hqg7ZS+9ukpBAXknBHqA5tp4VLpKy1paC4O3cc0WxhtskqRaXmMr6CtMXfHycam3fAEoPP6cLKGIv8OmUXniRwj19MYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RFX2A8pSlTrVJBcLrzBt1StZVdXpW/IR4g97MnLt7s=;
 b=eQ+mKXLVk5nknvC9JbMwLQxLPreTyyYz5S2p/ZR4eCmXzv5Xm0kUnLHEC10w2wMKo4s7Ob8SLYu6lOBcq9+gmgRN+zKmJylgwY1x9TI8RnPTe3osFeqOZVs1VDp7iW2ssdskYwLtjYIMnR/Bam4K36/aP3Df5gMyAuJnLilEmwvuIFuDAmSi2ICdm79ByJG3uBmK8BkBbAK+YUM7xhIzcLE368StVAwKS/dXejDsW3fMA29edmIHhb9mKV7dRR1B+aHc/lhtZBuogq2LNLYmdiwz2K/l+lO98ZSbcTitEfUBNsDv1FpdhYqvPvb1bIk0urm8ytkr1yNhghsrdhtVHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7071.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:595::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 12:58:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 12:58:47 +0000
Message-ID: <39da1ac8-9800-4356-98f6-6cc1cbd22384@siemens.com>
Date: Tue, 2 Jan 2024 13:58:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH] meson: setup-uapi: Take Debian multiarch into
 account
Content-Language: en-US
To: "Kowalsky, Clara (T CED SES-DE)" <clara.kowalsky@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <d5c7f346-1137-40e2-ab24-958d7bbd339f@siemens.com>
 <AS5PR10MB817309AB8C068BB573C637349395A@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <AS5PR10MB817309AB8C068BB573C637349395A@AS5PR10MB8173.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: 7601a47e-dac8-4cac-bdc7-08dc0b928f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zEKdJ7Er1b6Umx6DwwSR9nX0R9zyV1qFDSH8DJeuVw7Ef8QkoB6rnYeoTZgK61gUNX0gnvmZiljsF9hqzA1wt2AR0Ub51jYZ6oTK9f2/LqsdUK1WGcfKdX76DkuAJtIKX1EeI/4FiDCHFiGhEswE6KLv1BIxq9xprhdhoDbX8Bq01DzxCC1+CoI/KvkYuAB0ejEmXLs7iK4ZkuIM5G64BLtAs9XoenApYs3ueBXn0DZz8UCmtbb85YlQlGhmx47lqbFZeBKm6PefCi4ORaMidhUtzPE7kWaRWyNEEFlytlTwXJBtWORfE3In56Wc58MoTrF5R8J2zisvMjit1Vnks5Al05RT45F8QRB/tbp4S8LZgTPSOm2TnENTj8B+WrOQBZfA5qhOVoRl1CmKvX72hh/qL5dQOTXDJnFxki18HAF+F0Sn7fzMyls9649NsPZ09oBmTRqgkulsRx5zS3cVSoxcyw8a4xw+ff5qVmwmwV4i0HVAfMX04KeOfv66q241ygprJewBxOtraBuffMOW31aKGElRsbWkNHYfbIns/eRbgDgIzvARIQF5UjtzZQYc8IrVlGuI/ywjEHAPSq3b9J0/8laOlZ0UW7uIBJCGU4xfsQU4MAPzL/rupeRHmMRngbCQNecJlN2QIBzBywKLrg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(41300700001)(2616005)(83380400001)(38100700002)(82960400001)(110136005)(8676002)(8936002)(316002)(5660300002)(4326008)(15650500001)(2906002)(478600001)(44832011)(6506007)(6512007)(66556008)(66476007)(6486002)(66946007)(53546011)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjZHVERORm9sOCtkSzYxWmhsVmVsaHlFRzRXWFh6TlFEeVJHTGQyajZGTmI5?=
 =?utf-8?B?ZTVyb3dWMEQ5anJTTlhSV2FQTWJ3Vi95SlY5TFhxQVRIUlRodnlqQjFibjlu?=
 =?utf-8?B?S3RUSzJXQk8rc1RheWhqUnJuOHpOUktWQkZtc0doM3FsTlVTMXhLRFhPb1U1?=
 =?utf-8?B?OGxHclA1UktHOG15Zng1dTcwM2QyeVc2djdIOEViL0NUVU5ocHFuN012bUd1?=
 =?utf-8?B?SWFVU0c4R3V1cmM4dFVWdXJoeGYzazlMdHZPblV0amFuQUMwcUYzQ3QrR2NZ?=
 =?utf-8?B?WnFvWW9JekN0dEowOUNuSml4TWRiUmVMWldPZ0Y1Q1M1R0NLL1lMU29FUDJr?=
 =?utf-8?B?ZzF2aWIzRjNTalNFdXdkb3BFRm9NSlZmRjEvWDE4TEF4K0J3bU4xck15Vitp?=
 =?utf-8?B?d2VKSDhsT3ZHaFBtMDRYTkd2bUNMSFBwWGdDWkZ5UHJ6NEpiSDVpaFpVbmcx?=
 =?utf-8?B?MVM2V0hLMm1SWWxPOEhNSUhUaE5DL0pBR3VZYWFzMTVwenZkaVY0UlpBd25T?=
 =?utf-8?B?aHNIUFdaWTNTVTJCUisrd0NydzRyZEM0RFNEeU0vc1VsWmgzdGp3RnN3ckRy?=
 =?utf-8?B?dVozcUZQTldyb2NmNDRJUDR5N0N3Qm8zalFGVXN6OG1CWDcwQy9nSUZTVUFX?=
 =?utf-8?B?V3E0dG82R2l6T0lwWTBqSml4TlMzRXN6OUZQQTNmNFBoc1VnUkp3WGhrcEND?=
 =?utf-8?B?MnhZcEgvcmVwNktDazhiVkJDOHhkUlBwbmIwMy9nRVlJT0pCRjhnL2Eyd25w?=
 =?utf-8?B?S2RXcXZ2RjhvT0hKdXpEY2pMd0FHbEw4WEZKTlZEWEFXN1p1aTQzc0hyQUZV?=
 =?utf-8?B?MDFxb09FSk1YMmlLdmsxcExmUFhVTTcyQktWNjBKVmJNSkwxL0JvS2RpUkc1?=
 =?utf-8?B?Ti8xKytYWjd2TVN3QzMyOFNNL2x5NHVsUlpsdHEvSGVXWHpKVk4xWDN6LzAz?=
 =?utf-8?B?N05vRmV0Z2ZTTHVUcXJqOE1jRnlDdlZENkh5blRVNlovWVZURmkwd085Qyt4?=
 =?utf-8?B?bzhGRWozQlVzUVlFQkRLWGtIMkhxYlZGMHpQWjdnSjl5b1VQOGpZSndLTjk1?=
 =?utf-8?B?UW1MUVlHMjA0VXg1Rm9NdGcxa29QcmZ4aEJTU3VaYzZ0TXNRdTVoTGhhV2t3?=
 =?utf-8?B?U2NPZ3hOdWV2UFdLS0RrTHNQdWpWSGVwKzN6dWp6YzhtY1BlVk5WZ0xySlFm?=
 =?utf-8?B?S0JZeURUUC9XV1FQSHgweXNRNjhWMVVRVm5rQnpKZG9qVk9yOWJaK0VFaDBU?=
 =?utf-8?B?ejNWbWNXQ1RjSFQ3OER6MVJiaEt5NFA1RDN4R3FWZUlPckdDWkVneUliRVYz?=
 =?utf-8?B?ZjA0bzNaOUdiellUakd2eFBjR29FZmNVbUVsUkhmU2ZYTTRpNWoyK0ZtKzlP?=
 =?utf-8?B?L3FWV0tIVEhlVDA4VkFvNzludmgyOFdWRjFzWTk2RG5JV1NYTldveTUvQ2Ft?=
 =?utf-8?B?QWozNnVkVnF0SDd2SVgrbFFLU0x2dGZBdWhONkVVOHZWcnNTc0ZhSEEwdEg1?=
 =?utf-8?B?QTF2SG82ZGVmWEFHdlBIYk02QXVMajlIRE5vNVU4Uyt1bzZVZHpSdkhUQW5G?=
 =?utf-8?B?K0NJLzMzSHBSaUd6TTBIY1ZBTnZaM2FHL3g3OTM2RTZmdmdMMFJJQmYwZnVC?=
 =?utf-8?B?TTN5QlJKejJ5YUZxNzBpbHB0STlLWFk3Q3ZJTks5dVhDUFg1NHYxSjRRZ2NU?=
 =?utf-8?B?VUJrWkN5YmM5dkc2ZGJwTDRQbnlnN1Uyei9wb2dGaDVTRGZTVmg4WVJGLzhW?=
 =?utf-8?B?dmwxSGU1cGtsUUtRSGZva1VyMTV0TTVHWVlNR0FTQkxuTTdsYWxIaXpHY2Z6?=
 =?utf-8?B?cGx4czdXQXVJdVlVaE5jbHVseXlreEFwN0h0NFplZUEvSnBoaFFGU2VZN1lC?=
 =?utf-8?B?SDMxK2tKNmNxV0RZaVl2NjdQMWV6ZnJjd1ZPY0VKdDQ5QkcwN21RMmhFbzcw?=
 =?utf-8?B?UGpsNkRsREpkOUhVVGwzcVp1THNUU1oxV3IvRHVSNFBrWmR2NVBIaDlqSTdO?=
 =?utf-8?B?cVFyNlBJMSs4T1NrdFcwS3AraStVN2ZsTGxzVVp2OHBNRDI5NUxvbEZCK2Vp?=
 =?utf-8?B?OGhpVzl2eWRSUmZQZlN3cmpPNTVEemZwWHZ2eE9NZit0Qm4zQ3NYYlRzN25Z?=
 =?utf-8?B?YWRGZnpXUGcvVDVnWTdCM1RaOEUvbnQ2MnZjWmVIN2c1Tm96bzAyY2lqdkRt?=
 =?utf-8?B?NVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7601a47e-dac8-4cac-bdc7-08dc0b928f2d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 12:58:47.6712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9sl7pzRX42KFoJcGblqpxUuyKcrycwlRDWcSJn4vcQeXoEjHN7YGL+D7Hkr4zAtyuWk+D6HUQIilzB1pqdT/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7071

On 21.12.23 17:56, Kowalsky, Clara (T CED SES-DE) wrote:
> Your patch is working, there is just one spelling mistake.
> 
>> -----Original Message-----
>> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Sent: Sonntag, 17. Dezember 2023 17:25
>> To: Philippe Gerum <rpm@xenomai.org>
>> Cc: Xenomai <xenomai@lists.linux.dev>; Kowalsky, Clara (T CED SES-DE)
>> <clara.kowalsky@siemens.com>
>> Subject: [libevl][PATCH] meson: setup-uapi: Take Debian multiarch into
>> account
>>
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Check also the Debian multiarch include path for the chosen architecture so
>> that we can support (self-built) linux-libc-dev packages that contain the evl
>> headers.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  meson/setup-uapi.sh | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/meson/setup-uapi.sh b/meson/setup-uapi.sh index
>> f2d0774..c939254 100644
>> --- a/meson/setup-uapi.sh
>> +++ b/meson/setup-uapi.sh
>> @@ -17,7 +17,17 @@ if test -r $UAPI/Kbuild; then
>>      link_dir $UAPI/arch/$ARCH/include/uapi/asm/evl asm
>>      link_dir $UAPI/include/uapi/asm-generic .
>>  else
>> +    DEB_HOST_ARCH=$ARCH
>> +    if [ "$DEB_HOST_ARCH" = "x86" ]; then
>> +        DEB_HOST_ARCH=amd64
>> +    fi
>> +    DEB_HOST_MULTIARCH=$( \
>> +        dpkg-architecture -q DEB_HOST_MULTIARCH -a $DEV_HOST_ARCH
> 
> DEB_HOST_MULTIARCH instead of DEV_HOST_ARCH
> 

Thanks for spotting!

Jan

>> + 2>/dev/null)
>>      link_dir $UAPI/evl .
>> -    link_dir $UAPI/asm/evl asm
>> +    if [ -d $UAPI/$DEB_HOST_MULTIARCH/asm/evl ]; then
>> +        link_dir $UAPI/$DEB_HOST_MULTIARCH/asm/evl asm
>> +    else
>> +        link_dir $UAPI/asm/evl asm
>> +    fi
>>      link_dir $UAPI/asm-generic .
>>  fi
>> --
>> 2.35.3
> 
> Clara

-- 
Siemens AG, Technology
Linux Expert Center

