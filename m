Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DF142E7C
	for <xenomai@lists.linux.dev>; Tue, 23 Apr 2024 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905756; cv=fail; b=CM10KmxkvhUCxiqowTYxXt8tt68WAaKhJ5/e0t3ovXm1RAvwwUBXr6BJuoxPB+D3deQCgfUG0kMQjbBqQp3yYy1nIu7uKb3VIySC0K+zivm/z5szmlCP3hOLatXvaZh8ZgQ+UIpq2qzfAqhDSI+McE5G8xlpf8R+hDw8yLhUp9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905756; c=relaxed/simple;
	bh=MiPJnUepmCTmsz+kZMSWD/tJ3W5aq0MRgtRJFrzKd1A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W/hPQ1PxhqKbP9EmXkcI0IDPP/PxVR5OMi3RNJjiXVTcK7IaKOTMPQo5UReadhzB0hGNB2UsuM80EHUw0r9bm7aSubRMNty9V4vFjMqA1XvNYMqwMSH1Q3f5Mw9H9qi2XzBUDsVpdSC4JYNfDRY+zStGMmSuVeloADikX+8MOaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=guca2rdB; arc=fail smtp.client-ip=40.107.14.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="guca2rdB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhGbvcSFRHjIZO+C70j0YehztgqM/J49ZNmiFq6VoiCZAZg9VLBgzfwO7IuVca9ceNQxgAyOE1xqq2EVuxn2frZHCpT5+Yz+akAPuXkdI8jMKwv2xENX5bMLyPtsL7UuxtEDscD069x93svcQVY9M7Mby42PlqkAY+Oy+vSqRb98Sy8UoE16D9DqY1ahLeztce3fgqzB+wcCMoINR4SuyW343n6bO6xijqk+HO61wwrmlA+uNFFxSd2kZYOu7nYLgj7FIHmWn3lO8kWhvnb2VjCVW32arBDJdze0MPSoDu8R4rasNGb8H4fcKOcq3DkvWUPLOFjriFDRegPWLMPHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJQ1qnKxW1oNaDgQtZJkaT2Gbvqrtl7wwswljK5DXgI=;
 b=RqperVgehiTC6EMPnIgwIbuh+spxUQAPC9Cw+60AI21rbeWoli8YExegiyrHMK+sMP+85ydBIWUJgfr6i3Iz8n75CTiAp5vG7lrU5ROoHiwfBhZMbLGd1ScqVXKw17Ka7QGr8hHvxtuXyOjw70WPYHxS7TR3Rn+hlsBzqSZBmnszX0KLzN8udKk6iqZ4DsOQ3UFGvcb1NhpM9UHq8OA8cCBrK+cxGVa/+QfqFYS56HJSP0I0G5yqd4dYUOeCk29VA2Zv0EhTswhek/iijcIUuk7w11suy1k/CLEgHhsF4X/tw8UrsVutycetfnUyCixhPr9MtXavibt+J6oYn8E0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJQ1qnKxW1oNaDgQtZJkaT2Gbvqrtl7wwswljK5DXgI=;
 b=guca2rdB+x27uYpJvtkexJ+n4S4t1ec/RMI6n56UHp4xY9IuC7vyd46KAjTymFa8o+UDblWWF25QOa4lcBsTEAJrY267BvUnv8DWTlBQ5zMtDzPjIh8+WeTCNM7KTpYjj5hb3kaVIi3UTapQgQjQjtNys+amaaA1+hF1zj+1AwLu6RxCJk4kSjnDXDRFNFR7JCFcNpDbVy51frpLA5IKvbGTMoERyDAuwi53LfjBkvsoBaDD6OFI0lBKAgyDWrIWlr3J/uekKKiMdTC+/+fxiuOzXxhBiY6H4DlHLcWM1m3g5bmdeoGhPys5sa/65Gkwfo4g2N/eVJ7PYTuWWnkW+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 20:55:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 20:55:48 +0000
Message-ID: <6644bcdb-5867-452a-9c11-c82014e50b7d@siemens.com>
Date: Tue, 23 Apr 2024 22:55:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: MSI NOT pipeline-safe & Internal error
To: Yao Yongxian <yxianyao@126.com>, greg@embeddedgreg.com,
 xenomai@lists.linux.dev
References: <61031e69.8c6e.18ef0aff82b.Coremail.yxianyao@126.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <61031e69.8c6e.18ef0aff82b.Coremail.yxianyao@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b50a00-ea53-4250-85b6-08dc63d7c118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1dQYldmNm8rdGNmaTJJS09CdnhWQmZYV3RTckhNZGZWbEZ0T1VOWjlGd0lM?=
 =?utf-8?B?Sy9OMTVtN1ZtdWQrUGVPaEVmVEMwUmx1Mld2VFRxL3h6bTUxWkhOeUVNakVi?=
 =?utf-8?B?RlduUkNLS2J6T0o2a3hjaFpyZjBXQTJ5QW1KcTFxRFkzR3p4WGErRW4zNnA4?=
 =?utf-8?B?eVpLdDVyOEM2ejdjUkJEMkYxdHI2bmx3RXZmRTBtY3JHb3B1VzJDYlk2Tkx2?=
 =?utf-8?B?MDljK2VLNHB2R25lblFwS1FsdHhTZk5uK01sY3R5QUVjaEc3alhZM2tDUFB4?=
 =?utf-8?B?MnRHOEZ1SUNpN3QyU3FXR2w3cy8xSTgrdzk1V2oxTkh1U3lYcDc0N3dQYnox?=
 =?utf-8?B?VmhTclZSWmIxbmxWY2J6cDdjODNFaXRvNHQyaGFBV2lNTzRveGFDRCs0aE9W?=
 =?utf-8?B?R05weG1GVG9ic0grL3JlZkdqQThrRklpSmRqQ1ViTkNHS3pVYzhPUDFaNTNZ?=
 =?utf-8?B?aCtyQlFuRDIrNEpNOGZvQzhVRFlpVVF5QzJlWElCWldPZFg3VGtsTnVNa25h?=
 =?utf-8?B?NmFqR2R2ZFF1WUROYzcxNlZUcVdXVFM4ck1MT2hjVUF1SnZDWjdBSWp1VWw4?=
 =?utf-8?B?aGJiTUU0eUM0VGkzZnpTaUdRWmVmZWYzdUtyb0FOaXdSRTR5YjRSZmY0NlRB?=
 =?utf-8?B?M241NGxUeXFJWElJa0Zhb0lycEpiVzkzSGU3TlpsV09hck51MnU2enBjaFlt?=
 =?utf-8?B?cEtMZ2VMSE1RVGF5VkFINkNsblRMSXA3aC9kU3Vkc2lZekxEbG8wYis3YTNM?=
 =?utf-8?B?dlRVeGpOVHhXZnBpWnJyWDRUbmw0RlRUNmRpazdDYisvanJQVXlZY0UwRjBn?=
 =?utf-8?B?K1JWajQyOE1oZkx6OG4waFduM1NRUXdFQ0dTUVphbzJ3amxaWWs4Q3Jla0dZ?=
 =?utf-8?B?Wmt6TmovRGZ6RnU0TGZsOHo3SkpYekVtekcwQ0U5cWxBSnBJYkdOMmRVNElv?=
 =?utf-8?B?MXYrVDNscFRXYTF5c2pYc3hiVUZ0dzEzYTBSLzVMMTlrTzVZOUpjWjg0SER0?=
 =?utf-8?B?R2RraFg2dWtDdUYrbEU0RU44T1BpU0pTbXRhT1NWdDRmTTUyUFpCUUxoRzZS?=
 =?utf-8?B?d2swU0xRbjhuSXV4UGlOZkJDZnpsejFtMXY0TUJWYjdMQnpzUG85WTFJNk9t?=
 =?utf-8?B?RFN6R3dHZ0NiOFZlYmthYmtkZkpiZkZhRTB0Y24yQVhzN0Y5MFhodTJDZTk2?=
 =?utf-8?B?aVZKeTh5Qk8yd0RBVVg0Q2UyK0kraGlZTStXNm1VVXdMK0dZRWhDV2hmbkVI?=
 =?utf-8?B?SUJtd0lSam1sNW1zUVlUWVhnR0hBYXg1VDNyRE03L3dlQVZDN0RmY0Q3NjRp?=
 =?utf-8?B?TWQzVit6TmNQZVFXM25seU1scHFBc3ZFNFRZVzlNK2o2aFd4MVNNbW1OcEtY?=
 =?utf-8?B?OHI3UGtvWmF0QW1XbERmWHZ2YVZKckxQd012RGpZUHFFRjc2STZ6QTBTSmlH?=
 =?utf-8?B?cGhuNGhuVklNcFU4UEhtNEs1dzR4UVBLNmRzMnZXSDExQkdLU2Q3eFpRTmJq?=
 =?utf-8?B?NFd3OHJrT0RVTFlaQ0RHT2VoSXJWZEk4Nm9sRkViT1NEVnptMlN1bktvdlo3?=
 =?utf-8?B?TkJKbER0WGVabDlMVFJMazNzMlZMdWJLOXE3bU9YRnMxQjZVcWVSZmdUemZu?=
 =?utf-8?Q?34hLaH5Ei0RHMoUnfHFh7dEXVugMaydJtdGIvn1C5wDI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVlDU3hVREdkVTRHU1BRcGtWZUU2aWFpRTVTRU9LZk9mM1VpTnl5RncvLzBQ?=
 =?utf-8?B?WFdtbEs0dDR1WGRhbDBTaTV0eVUvSHFONEFjWVdQQk5qWHZMbmZreDBHd09Q?=
 =?utf-8?B?QUdDSFJHNTJwOER0K0RDN2tpdWZhM3lKNkxrL0VmLzQzcVNWdEJwU2Y4elBX?=
 =?utf-8?B?bDZscnpEeGFLa254aTJDcW1VOGZkcHgwclhWN0h6SUtFdllGU0E0OFlneC94?=
 =?utf-8?B?QWdLa0xzWWNRNTdqY0hUMUlMYTFoditLSnVhL1U1bFhablQyWThCQURDWjhH?=
 =?utf-8?B?a2hMSDJ5cjBPLzIwWnFGYzFQNmQ0K2dRb1lCbkZtVTRvRm5raS9uc1ovTWRI?=
 =?utf-8?B?VHRrM0ZYT3hhb3c2NVhySFdZWGZOMER2cW1wUXBoeXY3dDUyQytiTU1YWWRB?=
 =?utf-8?B?a0xiVkgycm9UK01LUCtUNTdrM3RncDhiUjRrakVPR2JudGFyV3UyYUpzSEdM?=
 =?utf-8?B?VDFtRmx2UzBMaU1tTStPaUUrenNnYXlIV3h5clUzR0VTM0pVdHdJajdQVUdU?=
 =?utf-8?B?Ymx3bWxncGhXYytLZVBMMUhrRTdGNEZHaWVrK2FHQUF2M0RNMlEzM3lPaDZX?=
 =?utf-8?B?T0NvQm0wMzk0ejllbGhOVWQ1SkVhS2pzMEJBelBGdGJ4akVYNnJIY0E4VWV3?=
 =?utf-8?B?REluUU5mbUlUbUh2dytFeGlBS1dYMmwrZHZXelNZY2RwTlFGRGVrYXNOODZ4?=
 =?utf-8?B?S29rcEd3YmE5eGtLSEZpcWdkd2tISkRPV0FZeUlUV01NSy8vWUFQWllzRGtS?=
 =?utf-8?B?cCtjWmFFb1BrMmlaMVJ2YmNDcCt6aDdBZWp5YnRaZC8wVDdkS0RqMUFvWXQy?=
 =?utf-8?B?YUE1U1IyaVZtV3VoOXNCQlZaVXJyS3YxYk1jMnRoNy9sd2dIckNyZURRQVpW?=
 =?utf-8?B?aXYwRjJSVnhnMmlrL0hneVZsQ0JqMC9CVFhWYXd2SXRZK0JWajkrRi84ZUE2?=
 =?utf-8?B?L3VTS3dMSzhQZFFhWTV6dTVObmIzWDY5aDdJYWtIT0xvR1NmRzZOTkxSMnYy?=
 =?utf-8?B?VS96K3poaUpxOWpjeE9JWVExUUhxY1QzWEEzaHZMQXhkUyszUlp1eFlneFNP?=
 =?utf-8?B?Y1FrMDYrODgxOFZqSGJJZncxSDN1Rko2TlNybXl0aHE5Y0ppdzFWcDh0ZnRX?=
 =?utf-8?B?WmZpZWI3NVN6UHV1RDY4QlNlU1k1RzEyVDdZM1RqN0ViMVFaSmJ6aUVCVXYx?=
 =?utf-8?B?V0VzaUtFZUFsL2MvWWlGM05DKzBCSDN3ZDU1bHFmUHdhbzlPVTBXcnNYVzBP?=
 =?utf-8?B?K0V1MmJMMWU3MzJEVWl2Q1NSVWFnRXNETitmY2lsQ3RHcElwVU1yeENqN1lW?=
 =?utf-8?B?RzYzZVlnSUdQY29Xb1k3QmN3QVhROUVrdEYzbnl6bnRVdWFCajAzNTdsUEw2?=
 =?utf-8?B?a3pxZXpvNXVKakJqNmNRcGRpMjlXc1RjTkg2TTJvQUUvNDdYM3JhQUhsbURi?=
 =?utf-8?B?K3c0ZktJbWxuMFprUVRueTBFRDVudTVzUW12ck42dVlUZ05vL3I0QnlKSlFL?=
 =?utf-8?B?azZoWWxKYmNHUnh4NndLSENRK1NBM0hFOGlwcnNwZW9tMDdIM0UvbXRCelVX?=
 =?utf-8?B?VkdzU1IwUTYyTGdYNk5kNlp6bGkxbmpJdVg4V09aSk9KbEtCcWRCeDRZcGZJ?=
 =?utf-8?B?NmhMV0MwQ0pqSlFsRGZhTmR6NFJZaEprdVE5S2kvb2d4NjFrNkdDTmZqK01a?=
 =?utf-8?B?TC9FaGE1bzNqVmNHUHcvVGl6SkkvcUdCSmFCdmsycE11Yk5MNCszSVJHaTVq?=
 =?utf-8?B?bG0zaW8rcllrNmpWRmlqRDBWOTVydW4zS0RONDVJRHJWVk9MQXZkdDRqbzNX?=
 =?utf-8?B?b0lrVDUrNzRHQ1F3VW9SdXZWeDhTZEhZS2hMd3p6WHlMQjhVdGk4Z3NvekJt?=
 =?utf-8?B?L0pPVHkySUZ1d0tJQjJQdUo1MTBoWllONHN2RVhGZTFFOXBTeGFEWWxWa1oy?=
 =?utf-8?B?NTQ4YjljUU9lTjhPTkJiOFJiK21uTTdIWGt1bTF2VlBZNVo4OWxYNVRCODFM?=
 =?utf-8?B?bmdwbzlONmZjZlIxUnZQN00yWHIvS0JqaEI4SWdqbUlvbUxIVkRDTXcvNzBI?=
 =?utf-8?B?aWxCNlN0ZU9FZ0ZFOC94cS85aUMvRWtpN3dSS3FEbE1pei9JSklZM2hyNk9s?=
 =?utf-8?Q?Adna/+xtecgdciHjAQCNRhph0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b50a00-ea53-4250-85b6-08dc63d7c118
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 20:55:48.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQB8Kj/2k1es8vLWBoM9iXjviUzZEhfz4dUQhiCyYoxABRNJtntutVz2aT4OxZbM/9t/T4Oairp326Sr5MAvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8251

On 18.04.24 12:10, Yao Yongxian wrote:
> Hi,
> 
>> On Mon, Jan 16, 2023 at 9:44 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>
>>> On 16.01.23 09:40, Yao,Yongxian wrote:
>>>>
>>>> Hi,
>>>>
>>>> The following exception occurred when running the kernel(Linux-5.4.180, xenomai-3.2.2) on aarch64 computer.
>>>> Attachment is startup information and kernel configuration.
>>>>
>>>> What caused the exception? Please give me some hints!
>>>
>>> Maybe just something like we have in Dovetail already:
>>>
>>> https://source.denx.de/Xenomai/linux-dovetail/-/commit/42f44cf859e3525eb26dc090fffa97bfc35e870c
>>>
>>> Jan
>>>
>>> --
>>> Siemens AG, Technology
>>> Competence Center Embedded Linux
>>>
> 
>> Have you run the ipipe on this platform before?  It looks like you
>> have an IRQ source that isn't ipipe safe, it may be causing issues
>> when the IRQ is trying to be handled.  I'm not familiar with this
>> platform. Did you port it to ipipe?
> 
> It runs on Huawei Taishan Server(CPU: armv8 Kunpeng920).
> Does xenomai/ipipe/dovetail not support this CPU/server？
> Does the community have any plans to support it?
> 

I'm not aware of anyone having tried Xenomai on such a server. For some
in this community, it may even be... tricky to get one even if they
wanted to.

But I'm sure that any patch written to enable this support will be
welcome to the dovetail tree - provided that general support is already
in the upstream kernel.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

