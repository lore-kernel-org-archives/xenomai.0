Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1B5668
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 12:59:30 +0000 (UTC)
Received: from redirect.mail.gandi.net (unknown [217.70.178.234])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id DA33BD40BB
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 12:46:57 +0000 (UTC)
Received: from spool.mail.gandi.net (spool5.mail.gandi.net [217.70.178.214])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id 4695F1A0003
	for <xenomai@lists.linux.dev>; Tue,  4 Jul 2023 12:46:50 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe12::630])
	by spool.mail.gandi.net (Postfix) with ESMTPS id EF029D800FF
	for <xenomai@xenomai.org>; Tue,  4 Jul 2023 12:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pv22ANdeOIXWssis7N7mhxNePJ2NORnoEnTQaSYY4Th6M3ydaJ/Wi6ER5pHm28ayF2C/kbx8Q0j6OsdhXgwL+D5FP+eOUGaJ0N/TPhQkExMfBQATVO/ExxtuzPdyXXHPx4MpG6cdR4h1Wu5Ij8fx2AaXHl+edf4TyJ+VH77TdFZs4WezXEUFhRyBElIvJR5v/kAVitw2w0oUgUCwsY+UWFzoCsZtw2fn1aGS5s+vB+foiFN7FHR3EvHVyejjC0oOjFUI/EZd0M7JSU106bd+VQtgwyiE5pdlPh9cAPTvKbkh7OPBQ1ntGnNMNgqhIjIXw3ZTHoqo0DeI96vSE65DPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSL+zn8xtKv3nEMm4KbFo17KD+g1qFPyOWQqYDP/G7E=;
 b=lpN+Ei1Pj6QRftXSp5vMVApPlOg1QTNX3EVYqFI//yEdDHx4BSY1eoOR+6oDtEVIwIvFue5oXZ3e/NJ9oJ/Sw1FpWHuEkbwa/vqglRrFFfqKzvzhMXWs24p/kloznUaYEYh94PF52tv1qbciyG8PorUTfQhEltsB9FIBjlswTnNpOllQOzsxrqpcSCNbGr+Av7ZWTAqDV5mDeWLdr6OrCOQXlOXc3o36pnbeV7MI+5hVw6MbFOjfgmxmTPxkbYGKlo8HCLBkXHIDKXFo8fKwTVoIr3dB2QiUGmv84GsK2d09kNpjdJ5yAGVpxkWMC7dASCXNTZsu2h29MiJTYK56ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSL+zn8xtKv3nEMm4KbFo17KD+g1qFPyOWQqYDP/G7E=;
 b=DmmndQiHDdPOUmEDTzGu/FCK/OgVuO6YSAffioeRVrPM1aAeGybnnM8H2RnkTKNmbHF8kxctslYmo31yYI6twH89ocHSW+eLs7oC41i6W3fTRvTNpiTOUJw2dn0Et33XLgoY3yuvaJFilN0tF/Lne2rjQxES+5Nugn90seffY9JvYxPPrtq2w8HCwyx8MG9+89UvIajpyG9Rf9KLhSYiqab1FLFswJGQW9fip2mwWgoS4oOzYkI217UNF0dZF25q1G4eOinN2XAo8OFde7iSiLuWnm7fSFde9g6SJF9PD0lxymBp0G4I+gcFVxxWB/8MVK80jDUlXXe/PV5ShVr5ZQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7515.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 12:46:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 12:46:48 +0000
Message-ID: <a14e96c8-d165-0972-461d-5a8e3200e28a@siemens.com>
Date: Tue, 4 Jul 2023 14:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] Make macb/gem RT driver to be built against linux >=
 5.0 kernels
Content-Language: en-US
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <francois.legal@thom.fr.eu.org>
Cc: xenomai@xenomai.org
References: <300db1-64a40f80-4f-79908c80@57806517>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <300db1-64a40f80-4f-79908c80@57806517>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: d941e25e-cf5d-4af3-4ebc-08db7c8cbb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+fTCw4pN06wiXGLbgwR24LYHFlUbeNg6uyBfrqBph4Mqcqvii7rPEDkZk00yuhGm16wBCVxCKI9B85qC51OO08bKmqmQ1/ZaIFhr41r+AZSDUfxC29f5lO0AihaYDNveBeKZ3jk3J4ITHFnML1ePmzalQPzuojggsb+ogeBnJDO0NbTP2yzoed1OE2s4P1Nxx3ZHmMvHqI9CklFAg/cOREG+9nju/MlCC+IdSbAqXbN2hkqEdUXtAcbI/bBxktiE2nFjF0xGhKKuvSlrpKTcVZ9Jy9as+/fdLRYi9ZJCmZjDiEBWpiVLg/m+CNaKF44Jsde912qc+9y/WOeTHcQCf1n0FK4nTwzYtu0EAj/0m55T5jEJ9n4qhmPtHQ/4AWhZDkn+5vQ53Nn4A6Py1w1aKXlduE53vNnZxK4SM0zZcmJ/BdVT93xjq+J1BKg0GIkpGhpee90GTQMWNHl3auBPUZBx0Zwd4hQ1WNaKwsx1EWj0N2t/YI8Et9PG53BQo640lvOcXNX/LZ+UauMM8jVLqIahTbfrG6aB3W+U05AKxWFVxwSxH1VTtZMoD35gTlvQ7m0Lkv9Z7Yd7GsI/06ZV9qng67cOmwiQS4XXrQkprP8VjJC7Ll6fHLeFLfbW8Eqh9hu47UW8HpNt1yatQr8lQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(31686004)(26005)(478600001)(6506007)(82960400001)(6666004)(6512007)(31696002)(86362001)(2616005)(186003)(38100700002)(53546011)(4326008)(6916009)(66946007)(66476007)(66556008)(83380400001)(66574015)(6486002)(316002)(8676002)(8936002)(44832011)(41300700001)(2906002)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFN1amJ2L1Y3T2JHcEtpbEhlTjJTenJXWk1PTnE2VWk4alFnUVhZWldSMm9W?=
 =?utf-8?B?ZWt2Sjdvak9td09tSFo0YWxITnFtRnA3bmJFY3NFSkxqTG8xYjFWZE40NHlq?=
 =?utf-8?B?UGdSZ05DaHZwenBYamlHekxRZG5EUE1vZEtjSDNaOXBTNHYra3ZKMmtJSDVp?=
 =?utf-8?B?MHhzVHRjaGR6elEreU5SWC9iVEV2bDR0SG16WjVGczNmR05ZekhLQmlNNm1Z?=
 =?utf-8?B?TUtZUlg5bmI0cTRuMXBDTWZkV01QdmV1a25zbVlCK2hxQXhaT0VBRnZtL0Zu?=
 =?utf-8?B?bGZCV0l5MlJCUDI4ZlQrWEg2VUJ4NzhPdnNrREI0ajhoNkd6WGVnQkJaSWcw?=
 =?utf-8?B?RHlhckdKSi9qL2tnWklWN3lHMGFpZ0Zpak9JWEZYRXU3MUh6d3JHZm5Xb1Zm?=
 =?utf-8?B?ZTUvMk1CZy9YY1VXajgxenh2aVJDdXcrTHVqRUl6V3duZHM5SVRwSFlVUEtn?=
 =?utf-8?B?QjdpVVFjazJXY3c5dVlCNGlta2RzTHBlWkVBYlVDQ24wWHBJTUswcjJlUTNU?=
 =?utf-8?B?ZVdHN0N5SDBSY3Z3RE5HbVJ4Tm55SVpPWkdYcDFHc0RzYWtNNnNBNkVEL0l0?=
 =?utf-8?B?UFo2cWtHcmhseWE1WHVQLzRRNUx0MGVydVdFY2IzbytSRk85VDRJMEFvbk5r?=
 =?utf-8?B?N1lDSGtRMmp4NkpIS3Z3alJZc0RJdHZUMzVpVE9PeDN0bVNwSnM5NEJMMUFL?=
 =?utf-8?B?T3lkdC9zUElOVlZ1R2t2TGJJNVFWMEpLWlpCbm9iS2JUM09NNXhxaWxPMk1C?=
 =?utf-8?B?aEJTWjgyNXFRZEExaWlSMmhwZ2NTdTluaGp3dXNBSGlsZ3pNQkRTbzJhOGdp?=
 =?utf-8?B?RXpRTmt1b2ZFSzd3aTNGU2M4YjJDT0IxVDUvT004N2dpK2pmZmdyVFg1cGpP?=
 =?utf-8?B?U1FNOVYzUU50N1hKWStDUVZVeldQcHdlOXF0cWZUcHZxOXFWcUdUaStYWEFT?=
 =?utf-8?B?R1FDUTl0M2FzK3hTeElOa2JJWFRLQlpaRXdJaStaV3JPUVpGQzNpakhqU0RG?=
 =?utf-8?B?VU1hRmthQzAwZGhNUDVKMlpjSTJPa1J1MWZ6cWN2N3JZeExISXBVRkJYZk5a?=
 =?utf-8?B?akwyU1JTRVlWRWZ6YVBNMDVQWWYvNkFMSWtpdDhsRFQ4T0REVmVCakx1Qzk5?=
 =?utf-8?B?YVgrTjVyZG1FQ1hvcUdUMWNFSm1pQzdHSmVHNWFKelV2SmI2dE5ERGkyUUR4?=
 =?utf-8?B?LzROSnVwNHdrcER5eTVTdWZ4L0YzOTJCMkFJYXoraWJXcnpGWVNDaWoxeE5F?=
 =?utf-8?B?ZkpGUTJnT01EZmhoV2ZNWE1xQUZpZUtFVGk2ZzhmVFZmS0RESmNaQm5PVFh5?=
 =?utf-8?B?a3NDTEpHdXZFUjQ4Z1N1VHNEZ2ZrRDlpcEU2L3FSeFJtVVQwSFFXckVIM1Fz?=
 =?utf-8?B?L1praFpsWG1ENXd2MmF0cGI4czFWcVZUK3lLakt0eHZVdDRGbnR2UHZ3TUlO?=
 =?utf-8?B?a0lvYkwzRE4wRDRvRGlOZTdyWU44bk4wbFNYSWNQTHJsMUV0QmV0RkpqRWV6?=
 =?utf-8?B?eFBUS2M3V2YvZm5vOWlXM2QyOUJjMEpqU1EvRDRBSVZHcEpBT3pNN3NySFhr?=
 =?utf-8?B?MlVpd3c3S0d1VFEwNWNINkd0Q04vQnQ2cmM5MkJJNWVMazdWMmY4YkE2dzZm?=
 =?utf-8?B?ZEZYUWJOSG9NUGFLSDM2QUNNYTZzSEJjVk8vTDVwcmhWVzFlSG5QN0ZJaGpx?=
 =?utf-8?B?QUlzcmI1c2FXRGhEZkJ1UVRvWUlZVEE1ZTNpNDlNK0ZiblpyRExHeXU0M2FO?=
 =?utf-8?B?QjZaVkxoYVVvWHdlR3Nwb25JMHQ2blV6SWFtOXVrZVFEcG1KSzY0TmZaS1M3?=
 =?utf-8?B?WjBtV3ZpeW1BUWhoUmhDOVZZd29VL3NxNFBhTkg4MkVoU1dyUzZiOTRNWDND?=
 =?utf-8?B?UUZybUp3ZFVGem9vUWtWWEJxemZGSS8zelBxd0Ryb1NvRy9DcXp4UUI1V3BK?=
 =?utf-8?B?VDhJdXl5Rit0RERpakI5cTdHVmlBR1ErRlFqcnFBRTAzVWwxZ2dVVFp0N3NL?=
 =?utf-8?B?R2JJZGNkVjZHQUxuQVZIMzZnK2Q4dko1WTNSUTBaV1lGVHcwY3Z2ZmZ6SDJN?=
 =?utf-8?B?MnNrTy96WmRTN2twaDNzQTBuaGpBNUQyeFJ5Q3F0UFdnWkwzZTJxQXRvdHRt?=
 =?utf-8?B?d04zUnBPQUV6cE53OGF6c3dvUTIvaTBYeXJhbnMxcS9BcmxwVjU2T29vTVJn?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d941e25e-cf5d-4af3-4ebc-08db7c8cbb09
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 12:46:47.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHVWzc5H14ZTzlJTv0Nq3+ZEDfN6DcVsju0DMDuwu1y0z4CedWST7gEWrhviDzkvaj5UMGZV5edCi/0gefLAkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7515
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=selector2 header.b=DmmndQiH;
	spf=pass (spool.mail.gandi.net: domain of jan.kiszka@siemens.com designates 2a01:111:f400:fe12::630 as permitted sender) smtp.mailfrom=jan.kiszka@siemens.com;
	dmarc=pass (policy=reject) header.from=siemens.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")

On 04.07.23 14:24, François Legal wrote:
> Le Mardi, Juillet 04, 2023 11:25 CEST, Jan Kiszka <jan.kiszka@siemens.com> a écrit: 
>  
>> On 29.06.23 22:04, François Legal wrote:
>>> PHY layer in upstream has changed a little after 5.0 in the way autonegociation
>>> capabilities are encoded.
>>> MACB platform data tend to disappear after 5.2 upstream.
>>> Plus, ioctl prototype has changed in xenomai. RTMACB driver does not build
>>> anymore.
>>>
>>> Signed-off-by: François LEGAL <devel@thom.fr.eu.org>
>>> ---
>>>  kernel/drivers/net/drivers/macb.c    | 60 ++++++++++++++++++----------
>>>  kernel/drivers/net/drivers/rt_macb.h |  2 +-
>>>  2 files changed, 40 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/kernel/drivers/net/drivers/macb.c b/kernel/drivers/net/drivers/macb.c
>>> index 77957d906..0648afa3b 100644
>>> --- a/kernel/drivers/net/drivers/macb.c
>>> +++ b/kernel/drivers/net/drivers/macb.c
>>> @@ -132,6 +132,7 @@ void rtmacb_get_hwaddr(struct macb *bp)
>>>  		bottom = macb_or_gem_readl(bp, SA1B + i * 8);
>>>  		top = macb_or_gem_readl(bp, SA1T + i * 8);
>>>  
>>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(5, 2, 0)
>>
>> Thanks for the patch, but master does not support kernels older than
>> 5.10 (dovetail) anymore.
>>
>> Is this patch needed for stable/v3.2.x or can it wait for v3.3? In any
>> case, we need a master patch first, then we can discuss whether to
>> backport it as well.
> 
> Well, I started patching 3.2 then submitted it against master. I can submit for 3.2 as well. I believe this is my target version.
> 
>>
>> What we also need is enabling of the driver for CI to catch such issues
>> earlier. See .gitlab-ci.yml and all those driver configs there.
> 
> I don't really know about this.
> Do you want me to submit a patch for this file ?
> Would it be something like 
>      - ./scripts/config -m XENO_DRIVERS_NET_DRV_E1000_NEW
>      - ./scripts/config -m XENO_DRIVERS_NET_DRV_RT2500
> +    - ./scripts/config -m XENO_DRIVERS_NET_DRV_MACB
>      - ./scripts/config -m XENO_DRIVERS_NET_FEC
>      - ./scripts/config -m XENO_DRIVERS_NET_ADDON_RTCAP
> 

Yes, if that is sufficient to actually build it (check if it has
dependencies that may not be fulfilled in a defconfig).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

