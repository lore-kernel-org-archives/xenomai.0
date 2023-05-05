Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B771FB3
	for <xenomai@lists.linux.dev>; Fri,  5 May 2023 13:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPwmkPyishd8Phvmucy+d6ryu4fyfMFVdHGsoFS+Bc38HtVCvbQkK0XYpp8sajXAS1SVkv24tVrWkYVS2fn5RTTyBzD3PqXYEZklAdbgUqcNqZXoY7oZVvh8i6/CcpkC0A7WNxFuk+Ii+YlcUR3uBzxU6Pxk58yM22H+IXYdtXKoQDrMebhjXVxRDZYgh8WdPTIDtGAFFwxvv+dcoPxoYqNxdTZi2rjQmIQR/PqRPpAkRJEGDn8oEmrO9HtIx7tufgB+4Jj3ZDjHqCl1+LEZ4ek9lLyLgK05T3JOFVB/aXiIWZV3n/wvnDb9VMpcK3qj4vXvV9wzVyPG835L/DDRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LntOzErU0nX6LJuibFA1E1KKXfVGPDf9R9c7SEDRxk=;
 b=Bw6xbvImsbeo93JLCLKKYfSgCJcKDzXC19NyXn7VPia/AlaB+xTJL3WcCBwwNIlof460pDBFnXC1xXb0hKgXjdt4CveNTkUHXscm3u3yA+1VQSTPZYp0ihuCC03xzC3ucw0jwh9cb7j+Y38Wxl1Kd//99r4ngpnvH32ILB3Fm7o6aXfFcqLlMuI/7wRVE8ALPFkYrJlehpEMSqrn7k1ON8QHK9+SGLU8UVSIt9iCE1bCTr13nszrdAG5SKTgoTqRDYgWfncyg1O6SjVmy6czF0ZZzkWufDm/QPhBPk133rDrvROb2Xl/2l+Hzvy4CxhvSlGesdHr/secZVccn2KTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LntOzErU0nX6LJuibFA1E1KKXfVGPDf9R9c7SEDRxk=;
 b=Un/+BS/PttJFavsAVV+KcSyWtlJmRxzo1E89qsY+4dUlW6tYRKO4OZ8nVN+IPY8oxVEfCR7Z6mKCop+7Hq45Vx/6YStZ5gwvaUPMb8djTr1NhODEqsUYQRluyxhDeH0bcVvwfNALMdZp2kl2YN17socYA/xdPf9flZyaIwMr4adfdnarGWZ+aO1TBCE09xCXBSEAC9EtDjhIWe1dNhp+8qFvA9gvVxwx3BJZqfS/GTJ+hbYMH6rQDvwBl7Lrha9HDN+ZyRC8uDM9hE90/KnWkSqR6+ID2l9Gh7e77w2psj46fX13aGG+YOT4J/WVnRkyk7qoJYfVW3hlkLuwNSGJ+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5352.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:281::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 13:21:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b50a:c627:3d12:6f04%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 13:21:22 +0000
Message-ID: <8060f103-6222-6df9-d478-bbac2b8807d9@siemens.com>
Date: Fri, 5 May 2023 15:21:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Question about a freeze under Xenomai 3.2.1
Content-Language: en-US
To: "Schuman Eelco (DC-AE/ESW5)" <Eelco.Schuman@boschrexroth.nl>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
 <189dee91-923f-131a-ccae-0afcccd06107@siemens.com>
 <7dfbe0c0-161f-0977-4332-75575f1a17ce@smile.fr>
 <9a48d273-5ebd-f557-7941-8532b7ec4b67@siemens.com>
 <5523da9b-bb44-a1be-9e54-bcad21867eb6@smile.fr>
 <CALLqZ8TeAeeu++UP499YS_XPwVYw05eMEYf-K7HPmyhXHBoACg@mail.gmail.com>
 <0e065176-74b8-b02a-29c2-30eb34a79cdb@smile.fr>
 <DB7PR10MB2459812A2291AB88A99ECBB5EC729@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <DB7PR10MB2459812A2291AB88A99ECBB5EC729@DB7PR10MB2459.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5352:EE_
X-MS-Office365-Filtering-Correlation-Id: 715f0814-5991-44d4-35d0-08db4d6b9e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oso4raL56USMntvCswT7XHAY1gk+OMcYwOZdXHfxXI+TPBmYPv3C1nYtXbwB/Ti6PYsykvVjaZ2GryZweFfpuzsMsCOs2xyJHuluavpbuPa7FXvGGTxViMO3Vxi8Rriwf3TmoBVNKqg4QbzPifXa+W7EgsSrEOmynmci2B+BEbH1F8sQiqFwOE6liu6luppU6SkPYvQDb8G74SfA7OGmwqRoxsDx0yLVQgBLRy4Ae1jKEt5L7V/pmL3ZpIS3j5SpzMepg8yyekTutZ04pEV1M3mBQIPMshfk9z4Cwx9GCVd8dQXbjdskGnea4mFpMvAoS3L6uesUEi+L3W2pvcYKTWtj1MFhzpghtPJ6lNz4lB+e1QOAotktok3mnx1EJqdkcdxvnWQrnKSebrU8p9fZdIxLq21PTh+ChpkKd9IGoM0OTQEjd2XBQUqlPLf6La3UcUSZnHmDA/4sJNUq0u9venC8DSL7ero6k94cXBrfxAkfrC9Aixng0G0PFXU5WlrxpRfj1qrPj1tNTU/phlHTf15krOUebM4JURJUEa0y8dPbUSF8y5MKxgKg4X0JF0gXLs1vnh/H5Y+QLNXmF/BTERPxiYPGU0PMCUFFXOGyhM1xy/X/Grc+o3HYDvA8fYpGqSjv8pLWUfX7P3hmarAp5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199021)(31686004)(2906002)(44832011)(5660300002)(8676002)(36756003)(8936002)(66556008)(66946007)(478600001)(66476007)(41300700001)(6666004)(6486002)(316002)(31696002)(110136005)(86362001)(38100700002)(82960400001)(26005)(6512007)(186003)(6506007)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEhmb1diUFB4dThpcWhDak9tQVlYaDczOHNPTnBVQ2xuUkRGNVZCV0puMWR1?=
 =?utf-8?B?d2NhYndYdWM2eW9yMVY4VFRLYlJWWUE1SFFodlVvb3RnL0pld0VFRXZCZzZB?=
 =?utf-8?B?VDRXMWJYS2hQOGRyUzc0cWxCWC84N3JjYzhmSk5JYlFSbkEyRXpIMktaMFJh?=
 =?utf-8?B?endWa1IxTVFSTTRCd1o3VHh5WjVDdXU1cHBjelFaU2loSkR3ZjlMa013RkQ2?=
 =?utf-8?B?QVFpZXE0QVFwWVEyMjZ6QkNQQjhJVmdHVDZLeS9DSXhBTmlDZ2ZFVFhXNTdC?=
 =?utf-8?B?dDVwWGIrVVgzUGczUzRJTlAyaEJWbjFRNFk5MW1yVWx1M2YzaDZFMHVnV1k1?=
 =?utf-8?B?SjEwVFF6K25TTWVSYkxWWmxiRWtjc2FRTmRsRUlGVmRGQ2xxaUFLYVNGL0pD?=
 =?utf-8?B?WUcvcVBST1QxYVpXb1hYdUxMVEVPZWEwdUdUOTVYYkxrSGZDWDJkQXB3YTVS?=
 =?utf-8?B?a1RsaW5Ob0h2ZnFkeTJ4MTNuUUNsNWs1czFxVElHVXVySEcwaVpBNVVDZW9E?=
 =?utf-8?B?SncrQ1NCWit4d0loS0ZqZ2V4clQvQ2JQMEVHMVRDSHc0NDdvSFdqeTdRM0xI?=
 =?utf-8?B?TEhrZ1l1aHpibC9mcFRHMStKYVNUZnQya25rUTNOZEg4NndTSmcxYWNVbU9R?=
 =?utf-8?B?MUYydEd1djUrQWJYeWlJUTkxOHU3dWMvN2tTZElZMmlETThMZGdpb0VvV3Ev?=
 =?utf-8?B?Wk00dVl2eFpIOFl2ZTFialp6ZTRFcjFzUWtUUDA4Um05bUk3cHJXU2szaVky?=
 =?utf-8?B?QThrL2RSZ0llYlNTNjRYeDZEQjNtUEx4bUVldjhwaTVRUGQ2WEx3MWdReUVY?=
 =?utf-8?B?YjJzaFhKaS85dFpTUmtuVjRiOW9wc0k3dDBSbGNlcVRVK1VqOFJKQ2pJcW9F?=
 =?utf-8?B?UFBCZCtBdEtRNU44YTlqT1J3UXluc3k0R1lUTG9Va1E1WUloN3lQbFZnbDdI?=
 =?utf-8?B?bVhtOE9ucmQwTHlFM2xPUWRLQWRmMG5OSzY1ZlJITmdOZjNPUWVSVnUxZ0lN?=
 =?utf-8?B?RlR0eTQ0REFjT1NsSG9JbE5DNW4xcmQ1Y3NTbzNnWXlOMU5LN1ZlVWlLTWpx?=
 =?utf-8?B?RXBaRkxod0g0T0t0Z3hyZThmUVYzK3lCbXFUdWg0ZGI3OFJ1cVhBSlcwQmhl?=
 =?utf-8?B?U3ExL3BBWlpHcmhkOTNPWmMwVzJZREcrQTFmQ0QvazZRZWhSKy9nZTZJbW5E?=
 =?utf-8?B?MGphVzY3WE5CNENpbkJXWXR0ZENHajhMajRXVFZSZjB4alN0YUFTRVFxd3U0?=
 =?utf-8?B?Zys0amdWdHFkbmlCTXh1RFF6bUt0d29VSy90S29EVXpNNmFockRwZk9mYVcr?=
 =?utf-8?B?YkpHb2wvMlRJOEYxbW94dmI1VytPNmJRbmpDSWxnakZUTU5DQlFUbXk2SEl3?=
 =?utf-8?B?SCt2SzM1S25GMGY0M09rdmFpUy9PV1AvUWFPZjlBc1AxU3ZsZDlURmpyVFVQ?=
 =?utf-8?B?c2pmWG9RR0FybVdST0FoMEdVSHBwcm5kdnhSaGNZT2FpWHMrZURzSk9JbUYw?=
 =?utf-8?B?SnNVWXF1K3RjMWZTVE5sVnlrcmNEWHhqMW1xdk4zdkIyME9kVU1RVHBMQU05?=
 =?utf-8?B?T0VMbmJOeFZGOU1yZ1VFOFVjQ2lvSXI2S3NSSHB2ZWt4MVVpZm02NnlJZms5?=
 =?utf-8?B?WTVBc2d0T3ZBSE5ENUJhOFpVNVppME1VYytNMHIvU0lwN0NjU0RzRndqdkVJ?=
 =?utf-8?B?N205c0loTDZDcmJnYWNOd1RwQjFKY3VjMDNvS29oUkhLKzBKTXBZeUFzeHg3?=
 =?utf-8?B?R28waUtMVWV5RUppeHIxNU44eTFtTjk0UlBaL21udldNM3o4cVozbmZzTTVQ?=
 =?utf-8?B?NjFnUlZiWGJqbWlEb0huaXl3TmkrelFhbDZVbjNRb040clQ4cEo1ck4zaC8x?=
 =?utf-8?B?WDFBSGdRQjlpZkZPbXFTUUgzSEhEZWtIbWxQTWV1aTdZSlM4dWpWc05DcmdX?=
 =?utf-8?B?aWM0MmYyZ2RzS0NxVG5wU2xPaTJhajN1elhVcHc2Wkd3VGNOV21kT01XREd0?=
 =?utf-8?B?MFZmS3FTaGtibm4wVXB2djVaK1A0SFJjTHN4clQvWVB5ZXNqMTUrMWJ5N1pO?=
 =?utf-8?B?L1pIelg2eDBMWUVqNWNxOGlzNkRtNFY4QUcyaDdpOWNEK1phSlZ2KzdoNWJy?=
 =?utf-8?Q?yjrqnREVQ08ry90InC1Pbrhjc?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 715f0814-5991-44d4-35d0-08db4d6b9e5e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 13:21:21.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0A5gBeHz7sZjp+LhZipPGHCGf5D40H295ZADgCPrNWycOxu3l1srdn2xGlo6+tZU4pDXBTEpT+ZzP1KsUYSrVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5352

On 05.05.23 09:36, Schuman Eelco (DC-AE/ESW5) wrote:
> Hi,
> 
>>> I think we saw this issue a while ago.  I can't remember if a proper 
>>> patch was submitted.  Let me take a look at my setup here.  I test 
>>> ipipe on both zynq7000 and Ultrascale boards.  I had a dovetail 
>>> environment to test zynq 7000 since there were some small issues 
>>> reported in the past. I should have some time to boot something 
>>> similar this weekend and see.
>>>
>>> -Greg
> 
>> Thanks for your help.
>> As an additional test I tried a RedPitaya that I own (very useful tool
>> btw) , based on a 7010. Same issue occurs in the same setup.?
>>
>> Interesting to know that some issues occurs in the past. I'll try to see if I can find some insights in the mailing list archive.
>>
>> Julien
> 
> I had an issue like this some time ago, also with a Zynq 7000, Linux Dovetail 5.15, Xenomai 3.2 and a Buildroot build.  Processes would freeze after executing
> some kind of delay e.g. sleep(). It looked like the default timer for the Zynq did not generate timer events for the proxy tick interrupts. I'm now trying a setup with 
> the Zynq global timer as source of events. That seems to run Ok so far.
> 

Now I recall: There is very likely some adaptation needed for that
default timer /wrt dovetail. Someone would have to dig into the details,
looking left and right on other board/SoC enablements.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

