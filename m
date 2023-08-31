Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9151FCC
	for <xenomai@lists.linux.dev>; Thu, 31 Aug 2023 08:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyXuRxZ66ojLfnwrvDjWtG8NA/BBkapbELniZSO+bCEy5YYECpRftINGicjPne5ef0bYV8fYBVs4qJ5BIgheoO7PwlQgNABUeDRDud3F0UuBT5eDjQqvsOD8BYRCs1+3J+uFOcwBaHLDbHCoeDYCqEamKZ/uHWRzOxoYtBDaIcV4qD1hrtmXt4BJpDkPTj4pVHyP5rE/haQR814JDt70lvWCrSoCwcwhO9K/m5UpGhc8yNGGReqRn8PpqSKS9bogBDqI73qpngsa1MMixd3VtUkbrpkymHTzb8MUGsaw1HVSJN4QwnAUqIFvSL1kupvLuA0oYzRuQSMIhQ0CHF+zxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz6ovABdItvYaNS+9qGH9WwpUQKN1IrB+1JrMfrKjt4=;
 b=Auw4P9OuECKD+TsX+gGtB/lakWIv0bet/yurpt2tUyaWQ59JtPFplEhmbtqx4tpG6biv40zW9JhdOjG9O+S/37y+O0IGwRy+TSMWmNFWyiyXUzZgM5Gn93YFhcVXItWZjjz9PoA2k30GFVrNsa/Mr7j9SuD8O8JPTMQBoopgxfChl1caF8YZgaCZU5CvdE+YN+c85spdZMOOzh859VB5cMWfLPQiwtVZdprcLm6la3SZb4GlB/yqL2BvElK35jE7wkhejWdydR8LsG4VPmh22kbOnEjylayo6TfWLEUVer8NAuhN4jaVUsblk1JDOzdegClaTSow7vzFn+/V1tm+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz6ovABdItvYaNS+9qGH9WwpUQKN1IrB+1JrMfrKjt4=;
 b=ItNAlwzvRXKxBasUItGD1i5Rb1aK/i28Hmq7OncPwIdRQ6ho3CbBubhKT2MGpuVO9QVFh3BRE6l6Dm4RAkzl3+gVM4WHdW7Hx9BnV0cwlyRN0r0nCoNp+z9/6vwSctCsf0fliQrIYO2S5LZlfGbZKGSccUZ9KNeyoS9AMc316SdaTwHg/fbtAZuQgfMUqIyaQe3Wr5LuLro30qIe6K1E2Wh4zlGBNFCJD1MkABFohK0hUMICfpBziBj8qhUFLK+INZ2+job/wxgXndiwUAMi2ECaja8tpVo6DBNCBAvkJgWaTiPDk8Rj9BBRCxHYPexiJnPNsBbaJ+juiJYT5lLO8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3497.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 08:01:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 08:01:11 +0000
Message-ID: <f81a2ae7-f859-4da7-8135-ef25db5acadf@siemens.com>
Date: Thu, 31 Aug 2023 10:01:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Sporadic segfault upon start of Linux app while Xenomai app is
 running
Content-Language: en-US
To: "Heber, Stefan" <Stefan.Heber@zwickroell.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <FR2P281MB2654953C4123B74DB77CDC51FCE0A@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
 <906ca7ee-c870-4466-b495-3f5ba2c81d0b@siemens.com>
 <FR2P281MB26546E4A8786BBB886160D45FCE6A@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <FR2P281MB26546E4A8786BBB886160D45FCE6A@FR2P281MB2654.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3497:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ceb34de-ca7a-4d01-657a-08dba9f870d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OIb2pa8Sl2iZDeOy3EDw6+2zqFVjM3Qy1XC1pbtUNmgsDZznMIaQv54ellUTxgVY5JDLJM8czzjhEGxuvFAByAUnkWWHEuzmUo32ZTQV85+GQfqea3F/pAfEsVbBJvTVtxd1XZzz6IoVpfLi61Dc2PFCCb93wC8b62Ia2lwifF15JOXsiKG4mU51V3X2xXBeEqLCMVv7TqHAcdiOYeT11qpAEcXs2kD0xEwAnI5IGe0KW2OPtOhx3ELFu8rYj3Kdi3at1FQw1Ereb0/xkhU2tGpNjlNv6O2GvtjNRwrDqi95nNNI+eAz/IZXjPNYF24fvNasnGxSkfQHUzUqMvY9eUOX34U/YVKLpO5EQpYseX7eMoTJKXMqubIXIa+smhsef+r6gq+6ABChjjU20ycy5WAjlNvZxmwnI3+8QezFAk6ffrMTEEvLqjZRYcsKlNqjcfOteluTBgIInoooLkV6DX4tuGmkRnnAkiCvBsHCVO37+k09fslFO6DvFtFOSQuALjy+qCqBR24UPYoSctqKJ7DA6Zpwi7G7WDnr44sN5cUWXuLJdBO5CtvOhhhvjayX4mLtdACRd02dWb/ri/MV1+RrwKw2+dj9rGPtHm++tg0/fySWaSQf9eiXnNCAq6lhvAYF67GkjsqdBTzZForANw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(1800799009)(186009)(451199024)(41300700001)(8936002)(83380400001)(66556008)(8676002)(66476007)(478600001)(66946007)(110136005)(26005)(316002)(6512007)(2616005)(6486002)(6506007)(53546011)(2906002)(38100700002)(82960400001)(5660300002)(31696002)(36756003)(44832011)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFJ1V2h4TGtqSlVKZGpQd3llZHAvM1RDKzY2eDNENHQxU2lIV3Fad2R4OG5a?=
 =?utf-8?B?YTVwNFV5eEJnVFRPQjY4bkV0WUMyWlRTa0ZIV2tKTFJkNjI3KzZQTDIzYXRJ?=
 =?utf-8?B?Z2VZdUo0NlhGOXRTZ0tXTzR1dUtZQ3FaK2IxRWhlYklpZDJSQjhTOTFNT3h2?=
 =?utf-8?B?NTR3N2RhQjV1ek1MSHNnR1RvcUZYbXhXaFJnNEkvVk5aM0hsSyttaUpoa3B1?=
 =?utf-8?B?aGxUcEUyUU9TbmFMdUxnQmFuSGtEK1hHQll2VDV5MEdoNzRIZWpmNUpvZThS?=
 =?utf-8?B?TkIvYjhJVVV6OFRmeG11UnV2WDJTbzY5dW1vbjQrZDhpMXlVWGhEK1NQWjFx?=
 =?utf-8?B?L2FuQWtuT2swWUpUVTZuelNFazlkcEVwalMvL3J2SWx2bytxZWFHV1NUUE9W?=
 =?utf-8?B?bk9uR2w5eUFNTmd4Z2tVNnJtVUFLWFE0OEU2WGhMOTRudmNERjROd2dPWWtr?=
 =?utf-8?B?cFZCMEZQelR5SlYybkxuL1ZaQ0JudzIvWTRiQWszYTVtV0VITzhKaThmRXU5?=
 =?utf-8?B?U25taGE0aTlvKzdVS1VlMWJXNTVyczFVMlVEYWxPZDZqbEQ1aitPWHU4djBi?=
 =?utf-8?B?b08ya2svQmxlOFNjRkIvZ0RPQ3dtd1FoTWtpOWsxWUxGYnkrQmJGTWFBRnhY?=
 =?utf-8?B?OHBrQjRaZnE4ZEZkWXc3QVBKVlVZNXNFeExGczNyOHhjOGhYT21HQUxZYW9I?=
 =?utf-8?B?aE8xMXYyeEJHTGZ5cm00L3ZUd0ZDOU15Ty9VVkdGa0hYRVNZc3dqckJEMG1Z?=
 =?utf-8?B?RU1PeWJ2RzZnNmVSYmQ4bzF3dzkrckV4ZTExRDhyM2RXaUs1WnJ3cEZVcmlP?=
 =?utf-8?B?MkNSNXNIUVFBbno5V0RXVFdUQjJHMHBLYXVPaDRNVVdQdm5wL2ZNMGtiUGxx?=
 =?utf-8?B?M1FLanlmLzRNL09yZHFDV1pTUXVXZ0tyODcrTnNUMDQxZTMzT3dnaHJkZmJF?=
 =?utf-8?B?Nm1HQldETmxMV3paeUtGUTRRdjUvOHpUYXMxQ0VLUFJLVHRJSmh2S2FzRXl3?=
 =?utf-8?B?dW53bkFLTzBveXcrTFBiSlBJZTBZN294bld6YktrRGE3cHExRFQxU0dsQ2gv?=
 =?utf-8?B?V3J1ZXFSeDRwcldoSk52Z0hDSHA5K3VvL0M3a3VVZlJFcGc5anhLZ3dxZGtJ?=
 =?utf-8?B?R04rYUtFN2VvNzVOai9zNUxhS3VBNUt1WmVTbDZaR0VLM3JEckp3cVVLUk1k?=
 =?utf-8?B?ZWVUeTRsSndHUEZ1Rk5ocjNFdWtsYThrclNGNXY0K0Z4TWZxSVp3NkVIVEhz?=
 =?utf-8?B?MWtWN2RwZmxEWmVqZUxUbzYyeUdDOFJvS01DTGVidi8yejRucnFFcUtmLzNY?=
 =?utf-8?B?LzJTaVBPK3l1TWxUangxT3NvSGtqM0FsdXRadkcxRE5LTDI4Q3BYN21pMFhx?=
 =?utf-8?B?K0ZTVnExT2pmYzFtcU10TWV6Wnpjcm1SdEtkWVUwcCttUVozUUsyalFsendH?=
 =?utf-8?B?NDV2U3gvTDdLVDgyUFNzcEc2THZxUmxUS3FsQ2hsOExHNU1GRU1vUGlpRzVz?=
 =?utf-8?B?N0FGRjBmeHMyZWRUS3JuSkp5d09jNm1zalNjRWhDcEkrcFczK056aGtPeGl0?=
 =?utf-8?B?UkU3VWFCcXRhNXMremdEaXdPT1VSY21JUmR6TGdtT3loQWRlUSsrcXIyS1VI?=
 =?utf-8?B?RlNnRjZPZmRDUGJyaW42bnBNYjk5cGVocG5ybjljSGx0ZjQ3Wk5YSkphd1Ra?=
 =?utf-8?B?enNnT0VyQXZ5OFJCWFpkRlViWUFURjFVYmVBSjBka21zOUJzK3pzcUFIcmtV?=
 =?utf-8?B?dW1LR0xQOTJoT2JSV0llUjZJc2lvWWFqaHVPcUJCYUkyV3VFcWpaR0h2eHgv?=
 =?utf-8?B?bmRaNWRqV1Q5K0x5TUpobyt4a2V5eXBkMS9TdjduR0pIOGhiTWJPL1BHaC92?=
 =?utf-8?B?WXZJZGdUVnJjRWVDOFZ5WGNiZnBLVkhhclB5elhjZjY4K25XRGVkYkdMSkhL?=
 =?utf-8?B?elNKTXBBMUdId0dlbVR4cTBoY1BTS0l2UndlWnppeGdCbFBQa2NYU1F6N294?=
 =?utf-8?B?Yk1wdGlyWlIrSHdMTllvSWlHd2JEcmN4MG04SThCZXkxcTN3VVZJNW8zaURm?=
 =?utf-8?B?NjNta20vY2xGYkhqWnAyV1hGbUs5K2tQcUhiVGZ1QzdCZ2R5czEwTTY5RE5R?=
 =?utf-8?B?UzBXRmRFbi94V2p3bk1ucFJyWllidkF3SFRWK21iN2YwMWltSVZhYndzaEdI?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceb34de-ca7a-4d01-657a-08dba9f870d1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 08:01:11.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXuIka9/67i51kyjWeQKouAy6aRAcySY8V3DQLW0g86crGmt4kkf5P38gGqCq8Va/WtTgFh2maudMS+HVe7xBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3497

On 30.08.23 11:41, Heber, Stefan wrote:
> Hello Jan,
> 
> we see that the standard application always seems to crash very soon,
> at least main() does not (yet?) appear in backtrace. We have only 2 frames
> in the backtrace without any debug info, not even function names.
> We don't know if this problem occurs with standard x86 image because we
> don't use xenomai in qemu images. We don't think it has anything to do
> with the kernel config.
> As you will probably anyway have a standard image running it will be
> easy to find out whether it is reproducible, with our script you will, 
> if reproducible, see segfaults within seconds.

Confirmed, also with the most recent ipipe-core-5.4.253-x86-14 and my
local config. Debugging.

Jan

> 
> Stefan
> 
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com> 
> Sent: Monday, August 28, 2023 6:29 PM
> To: Heber, Stefan <Stefan.Heber@zwickroell.com>; xenomai@lists.linux.dev
> Subject: Re: Sporadic segfault upon start of Linux app while Xenomai app is running
> 
> On 28.08.23 15:40, Heber, Stefan wrote:
>> Dear list,
>>
>> we again have some trouble with xenomai (x64 / 3.2.3 / ipipe /
>> linux 5.4.105): If we start a simple non-xenomai program while a xenomai
>> program running a thread in SCHED_FIFO (in our case prio 99) and getting
>> scheduled frequently, we sometimes (in our case with a probability of
>> 0.2%) experience a segfault upon start of the simple program.
>>
>> We reduced this case to a very simple xenomai app that endlessly runs a
>> loop with only nanosleep and a simple "hello world" non-xenomai app. The
>> sources of both you can find attached to this email, together with a
>> Makefile and a bash script that starts helloworld 1000000 times and
>> counts errors. Additionally you can find the config of our xenomai build
>> there.
>>
>> We also experimented with xenomai versions a bit:
>> - xenomai 3.2.3 ipipe with linux 5.4.105 shows the problem
>> - xenomai 3.2.2 ipipe with linux 5.4.105 shows the problem
>>   => it isn't a side effect of the patch you developed for us a while ago
>>   and that is included in 3.2.3
>> - xenomai 3.2.3 dovetail with linux 5.10.127 is clean.
>>
>> Could you please have a look into that?
>>
> 
> Is this reproducible with a standard x86 image, maybe even qemu, which
> we generate from xenomai-images? Or does it need specific kernel config
> settings?
> 
> Did you already try to find out more about the crash of that standard
> application? Does it always fail over the same instruction or same type
> of operation?
> 
> Jan
> 
> --
> Siemens AG, Technology
> Linux Expert Center
> 

-- 
Siemens AG, Technology
Linux Expert Center

