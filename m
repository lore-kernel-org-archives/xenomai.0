Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013019.outbound.protection.outlook.com [40.107.159.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A413BB9F7
	for <xenomai@lists.linux.dev>; Thu, 26 Mar 2026 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515822; cv=fail; b=GVP9wqS6levG9BflkVNSf1bqgj7QGAkJBUnD9jp2VuT7RIZgKyGcNm4YmkSFrH1SppkC/qU7zBjTr17H+yh1w5cqnVIEq36WMmV4v8JEyBwsqXyy2ziQky/oLWdSU9KByo2YfV6Wm5mbf/ARgJdmQPPkNKKKcQFrR5C1O60jSWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515822; c=relaxed/simple;
	bh=Op+voJythMQTcqfZQr+6mpyi4E/BjiV+b8P395IlpkA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AFCb927np75o+5mAjf9ab9whqb0dT2xCLqgv33rupC+vmj/8RanbsAFHOlqhJkjqLvNurHAtwgVDst7oSJsQxSxr/tccB7K+5fvKquo+LudlD2iAB4xeujOSQmK+FsIGKchOcp8fIDE3R6fRRsjSIumUX9c0WPaVby1jMYZ2oK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SY5p/4Ll; arc=fail smtp.client-ip=40.107.159.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SY5p/4Ll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeiKkV1cV//ISWvpr5fOMhD+D9EXiRERJdtb/U3R9Z48zqKn4TJNmr1ZCXi+uVxofo+OqEGPv5kfv0ujd75xEgbi6MYAbew8ZAnkrpvPM/VFxE4H+xYsA7cDpg1d4Fmp+dYVWF5VN16CPmnpNg2JPs0VRPly2zi/n7hxljUVMrGtpCC+/O7Nfe11cZQt8a60qpI1ItHRt7RUUngXdagR8h/wNeqqNIeEJKcuzptpf8uvl8iZBBCM4/1wcFzlZwY/V2Yn7KCGsnj1PhZwtimgEqF6IE1I35opftWFUcZUlNuRhX9OegUqhZlyK/D+Xts8dD3xYesh91JkY6CQDy6v7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=al5XFrCq/ZdHtACAbOOXFu5x/k1xjrfswhZtWNVpTyM=;
 b=KlXaOGEP338ZgYF0KjzyVqxW3tQV05gq5dgYGjfruq/sZ8K8Z3jIt9ps9VGd/4NetyXd2PhN6xpSQnWLPSG1CvJBTvSqA3ke50FcgwCzKRLU7bbCTGwz7JWaBCDjJnA2nXtWpQQz2r7ej1wR3q+ALqkGUeefKv9fOthQdaDqJzO++Lyc1Ga4jz+Ce66ujt6Xb4xtzkko8eUZ32p4v5XVc8VPBtRzVh7TgqOVXULVg+QI6uozv/ZmzJnk8ikqGrSUXBVavmoJ4FkjgxNQyOMUZzDVQO/AJ33i/gESKoIPzGaiAtC9EE1/xnT4O0Tq6x7jhV5IKQHVdgn4zQ7H0AC3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al5XFrCq/ZdHtACAbOOXFu5x/k1xjrfswhZtWNVpTyM=;
 b=SY5p/4LlaSYDsJWYhOagcs5QuGPiHG3i9LB8GKVMSxlNbkRo3xPpAG7hzJj/HPo3CyiQpVpAoorybH/DlvP+LFzJKP/+OkAp3uBrARWSL/dPaEIPRCk99l4aSHIkr5pbu9tdTLVQJ7hkAtWkXdMEZPAl5ZEAZDRL217lCUy8QeVq1jdcrCBep67GjF4KIFF9M8Td4raYE1oMFp4h8+oi8+ZCh3h3avreXPfmShYsJu66GwwUVx1IAm3scT667Rokl7T5PIybDAZ7LoBgkvTavAOLLe/En2nOHDm412D3zsLf7k7nY9+VaraLFn4pqKodH0U41BrfSiDpZOiLcpIoHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA1PR10MB8540.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:446::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 09:03:37 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%5]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 09:03:36 +0000
Message-ID: <5d2efb94-81c2-4243-9801-3ccb7a4a29a7@siemens.com>
Date: Thu, 26 Mar 2026 10:03:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail] net: skbuff: add missing OOB stubs for
 !CONFIG_NET_OOB
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
References: <20260320211911.2151219-1-tobias.schaffner@siemens.com>
 <877br0j725.fsf@xenomai.org>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <877br0j725.fsf@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0049.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::29) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA1PR10MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: d4671bdf-06c4-486a-385a-08de8b169031
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ue/93QjsT3YrrhML8dnjvHvuAknZXCrM0CTLG2pWuzqdZbHKc54quYMMzTVqkj4vYNPOh88aCz9VXp6hxo60YbsE1xjxBuSdw/nmPPSZyofPTBwqzzsM07C4cuq5oY3yRxSg6xk2HxUkdH4VDnG2g61ezlhTsMKHmVglblJN9VBUOYhzLayA8uQe7zUgeoJTnLWqsHJU6TGAC3k/MtFkSDL5Nn48RrhFanPG06PR8FTrozROIe5yZ2imzdjkeTJhwnTx25RxTjYPdHQaKDMimN7KYsUKNuzcrFe/9ku/fpvBxMW6PXRVPIdDfYRwSdDFm7PLyfboHyJOY9s9IXjmKYPVAYkK7WS3TKEBHkDwO0D5hJjZCSr0XUgvB7okXz7VQOeJ7/UyLZr4RpAhD+wVeER1kt6RN4IeIZlY25SPHevGU9WAxp4K+WzU9yKcPbix+GhEcPylY6t+UfRWxe6kg2wZ8r6gLI1ylI4KE8cR1dHg3He8O236E10y+FryBPrJIqwGhLVWgQ/iVs6nVLUwvB87H6uHr+F0qav8t4uvzS+Mw1o/K6F+VfRT6XUiBBYA3S0Omv5U5u6chk7471OjzxD/tWWPU4Y28FNAZsfjgMwEyGCNPz/i4qYvy9npBw1WUNqUcLWSicc7C7L76pwJWzAeO7ZrEa5beph8V8JYxLXiXwTvVAQCCcFIyw7NLOEB3zxRyRB78TLUG3BpKP/GopUyYWBgFU5fV2c4SbRNPGU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1E3alVGMGlOaDR4RDRGQXRnUUs5VHVhc0h6RnZFejhpbkJpbERWZ2FhUENV?=
 =?utf-8?B?RHVrMGRzVG5oZHJlcDcySjlvSElmMkpvbW40STRpYXI3ZXB0ejNFQ2pPTFV4?=
 =?utf-8?B?U3FyZXVwY0tuVzJyRTJaVnhDR1JTcVI0eUZZYkNKRUtsT1dIakdZaXhISnRQ?=
 =?utf-8?B?UkZxeVJEcXhkS3liNktZOGJQbTU1MlJhYXZYK05sMUVaQjBFUlMzbkl2YzlW?=
 =?utf-8?B?ckg1Q0s0TUgzUXAwQXd6YUhqVVAreVdrTEhKa214YzFDN2tRLyt6ZVkxWHhF?=
 =?utf-8?B?Z2NlRE5vSWhMeDRVZ21wQU1hSXo2bk5rRVFJSGg3VWRHVXdvcVlVMnZqMGJN?=
 =?utf-8?B?eWNsQ1BNUUtoMVBleDRBT3h6cVZMVmYzV2xONG10cHltYlVaT203MzZNZTRu?=
 =?utf-8?B?bldvR3U0aExsSUlrbDM3UXFvS0lHd2h2K1ZyNUJ2R2pwdTB3ZTFzUnNrTTZq?=
 =?utf-8?B?TGxCMkEvNUhHNDBHbkcyWVhpdHpRU1RPQVM3NS81cmdsZmFxcjVFaGtud29B?=
 =?utf-8?B?Vkl4Q0dBZzNuSDM5K1pSMW9MWWNvRFNobFFKQW90Tk5lNVU1RmZWZWJxVGx0?=
 =?utf-8?B?d3VnSThQYnU3c0dqZG9XMVNveExKSTEwQUh0SjcxL1F2cHAvR1hWWXorNzJh?=
 =?utf-8?B?dnlRQ3BIR1R4Q0xKOGxaVjI4ZW0wYWZMV1MwSjNseXVWazdJKzBGK0NBdjZm?=
 =?utf-8?B?NWJjL0NIeldqejlsdFJmdWZaSktHVmN4UEZMaFdkTjJ4R1FCcDBWQUw5V0xr?=
 =?utf-8?B?VUFwQnRmUlZyZVdrYU9ZVUt1aEVUcnJUNW13elE4eDJvdHIzVnBISCt2aGIv?=
 =?utf-8?B?WnBHMlZxOXZ3SEtjVWhSd0R4cm40Z2lpVVJ0MFh5R1NLL2ExazBsVEcwZmZD?=
 =?utf-8?B?bnpDMlJ4MkNET1EvVklOK3lZRTdHRU5ROTNmRndHN1d3dW1hSXVsMDFFdUl0?=
 =?utf-8?B?eVZVQnIwL3RIRmUrVzFYWTdQcjJTZ2gvTEtUUXR3eVJpQTBTS1NyNDJIdkow?=
 =?utf-8?B?dHUxMTV0dVVxanlMY0tydEdoYWNxWkdJejdKdHp5d3Y1b2xnbE5QWlNEMDRR?=
 =?utf-8?B?N0J6clREOU95d0NPNmN2RHZ4ajh0ZUZmUlRNbXoySTRSSldmbk1lTGJxSitL?=
 =?utf-8?B?WHBxVURMQnZRdGtYaEpIejdGZ3Jxdm0wRXY0aTZnYmVVU3pGWjBCL05sSm9W?=
 =?utf-8?B?UVBUeUFoSUd1VU9oaFNhVlVmTW5wTldYS24xNXYvTUV0aExyMFB6R3BPdk1r?=
 =?utf-8?B?Z084VFlxTU5EM3ZaQTRWMlBMa0RoSVU4MmJsUloza281VTFIcnlsSXpKZndo?=
 =?utf-8?B?bVl5TzJRVXpYTTFaODdkdlpmbmhUSFAwKzE3YVBNUlFCT2tpTTVZNkVsVVZq?=
 =?utf-8?B?bkJSb0xmYWpncUU0cm1OR3ZWYk9CNVppdnNMMUxwdWlUUW4vaFhUbmJNMHFz?=
 =?utf-8?B?OVpsYXJ3czM1SCswd21aMEVTbFNEcCtkaHpWT2NMVGhScDNyYzV6RURiWjQ0?=
 =?utf-8?B?RC9NbFJvNzJhQTA5TVlRMkMwekJuSDQ1TERkZEt0ZkdVTXlTUHJzNUZJT01r?=
 =?utf-8?B?TWpXc1RvNWhkaHNKbkhMN3R0S2xoNjVSUHF5V2JLUHpaN0ZMbFRLZVhXNmND?=
 =?utf-8?B?VGdVeGx6ZkdMSW05V3JPUXQ1ZHJHa1R2NFJDSDh1RStqRElYMEZOY2xFV1dB?=
 =?utf-8?B?RFVhRHVZRldFQkRBcXlkdFVaYkRvL0ZTd0NiUVQrSEMwSHJFdW10K2pXNHFB?=
 =?utf-8?B?bGxEK2MvN2diMWN2TDBHSGszVkNESzNxd25ZSk9HMU5USmVHN2w4dnVxQ21n?=
 =?utf-8?B?bkhHNUdoS2x4S09vN3Yyd2pTb005Q1BxR2U5VGVieTRBZ2kvZ1BKcHFIRmE4?=
 =?utf-8?B?YmpjeURtRjM3cTlNWDdPbnVHak5BWE9RelFjcndFcFRHVGhYM1QyQnlnOVI5?=
 =?utf-8?B?bWcvV0ZMZ3dKY0hWM1AwQktIY0NzTlZ6UlJIVXZDTlVibXVnZkYzZGIrcUNn?=
 =?utf-8?B?Vm5EVDNxRlppQWdkcDBNa2dtcEY2R254Q0NJOXppZkZTQWswSm5LeUxLS1ZK?=
 =?utf-8?B?S1oyeXNFNFFwV3g4QTlXTTRXN3lPQlV4RkErdkxhUUZueXlHbEdkWGZuTDNl?=
 =?utf-8?B?OE93QkdGalJLaG04alMvOUEyR1Y0ZXBhV2c2QmFST2J2bzJENyt5WGhyemNw?=
 =?utf-8?B?MUhQQzFOQ0lYaERTb1JUM0tDc3hTNitzM0VudXFxdVpZMHlBayt4c3JKazhu?=
 =?utf-8?B?QkNlVm9nVFFVaDJmVEQvVzVnSTVuanRvUU5EVC9SWFR3aUxIZE5xMUhmL0pN?=
 =?utf-8?B?bmRrTzdrK3BGWlE0dEtWS2ttdkdGbVlnUnNuM0ZXRWtQQzBFMEhkMzcxYzYw?=
 =?utf-8?Q?kzwIQql584ns0wgA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4671bdf-06c4-486a-385a-08de8b169031
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:03:35.9461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pr5fZS/yy3k8AQ5y3xYPAQ2GtKzjXHP/tZ4UK2ukNTMRd4samKkEmeMUIU7FNb1x32nKruH7PK3hkaDDkTkwGZk14BN0ChICmNexp2qr4Hc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8540

Hi!

On 3/25/26 15:51, Philippe Gerum wrote:
> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
> 
>> skbuff.c calls skb_mark_oob() and variants behind runtime running_oob()
>> checks but these are only implemented in the CONFIG_NET_OOB section.
>>
>> Add the missing stubs to the !CONFIG_NET_OOB section.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   include/linux/skbuff.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 73dd4a58d181..1278d0a58677 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -5630,6 +5630,22 @@ static inline struct sk_buff *get_oob_skb(void)
>>   	return __get_oob_skb();
>>   }
>>   
>> +static inline void skb_mark_oob(struct sk_buff *skb)
>> +{
>> +}
>> +
>> +static inline void skb_mark_oob_released(struct sk_buff *skb)
>> +{
>> +}
>> +
>> +static inline void skb_mark_oob_timestamped(struct sk_buff *skb)
>> +{
>> +}
>> +
>> +static inline void skb_mark_oob_managed(struct sk_buff *skb)
>> +{
>> +}
>> +
>>   #endif	/* !CONFIG_NET_OOB */
>>   
>>   #endif	/* __KERNEL__ */
> 
> All current users of skb_oob_mark_*() calls are currently guarded by
> CONFIG_NET_OOB sections, or enable CONFIG_NET_OOB, like the evl
> core. Did you observe a build failure with CONFIG_NET_OOB=n, or is it
> preventive fixup?

I am building without CONFIG_NET_OOB at the moment and the build fails 
because of the unguarded skb_mark_oob calls in net/core/skbuff.c.

Best,
Tobias
