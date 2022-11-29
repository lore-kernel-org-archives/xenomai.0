Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2064.outbound.protection.outlook.com [40.107.247.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB78F55
	for <xenomai@lists.linux.dev>; Tue, 29 Nov 2022 14:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSvevv2syJEBAM/4KIMVHwd54iW+jDxjSLMZF77DeQP9J0pkGp3cHGfqYmS2sAX05R45yV9oEMFz5P17++uzx320Ncj2ejyiWNqklloUaUZu05Qpwe04/95T3L6ytu/5/VLEGKXQLg+hqVfHEat86aLvkt9tjiaEhber8jIhUQ8QzTs0KsiDvovhXnZaGknGEWoXTsTZ0Bfof8RoHE2y2lxTEI6Xp9INhgmPDfJnSRUVpPu9VhkPfWCZx0469A0Fob9ALIL6N/tlbI2IrBdE2M7brFR0Q3GXjjXlB2KnULE8lbhKgtCVInRZCPXgGTEZB9NJh7ouAgtp1ENgWINI2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya5pr1cYVZ9kVgSOIwhy+p/rnmMEHa04UyUKxkLD6tk=;
 b=eCIsxoaOiDrtDUW5UiF1CT7jbHyNPsEMrJtySF8YTKrCHoSB9n5KCoRv96zsZQkbeacLgAebTZmivXnpzVAJ1QcSix+TTlnvqb0kyNvOCoWO47cuI7MNS3eHzmqRpqazP+qThZQQuYZ5od/9odO89fABNG/7P1FtiDBE9guylE/kbnFzkCB/BOw/ew7DXdov60skxzJOvAFdm/oHSnZ5zmeBp4/I9axIQxporS6NXpB9VFgC3wgv/2n0b9F9q7n018O9eyJVmXooTjKCtN+iOuBwGuzpq98sX4kVyA3f0Zc1tVy8hVYSuNYALx7jTuzbbcwYCsW/2Uv5/BaYDZMZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya5pr1cYVZ9kVgSOIwhy+p/rnmMEHa04UyUKxkLD6tk=;
 b=E1ynRcInNiaNdVvpLMwrmcPdZdUD8fPO8NZfNpd0j0iO5W1KjQFb+tbofpJGY1fUbPk9InRTBZDOBGg86UDWZli0MKhAicW0nyQuryqeROy4PG4ML6ZzkI9SWcZjy+PMNrA/vKdt/9xdCAvWyS7vNS+n3e8VnuDAavSeKII7fXfM0f7ilxpr7nA6yllar+VndQ4uaZC9apK4SCsa/gXYwRo8BKmEwbWV6egARacamuG0BIJtUvap83PU9z/qAy62BvLEUrNHHZ9tOcwUV2EckQNUUfszMAk3Q+09Z2SwoV47Xvp4UL+g9eZt3QVlqNDkqDC1gkEiwgMsfi5xp95qTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6554.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:567::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 14:58:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 14:58:27 +0000
Message-ID: <6abaf413-421a-d5a4-5b08-15b51992ac19@siemens.com>
Date: Tue, 29 Nov 2022 15:58:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [ipipe 4.19 5.4][PATCH] ipipe: Fix handling of level triggered
 IRQs
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Greg Gallagher <greg@embeddedgreg.com>,
 Gunter Grau <gunter.grau@philips.com>
References: <20221128120908.1136136-1-florian.bezdeka@siemens.com>
 <99782966-4c04-7b60-1b29-0986af501f92@siemens.com>
 <94eafc79-3141-1a6c-330f-c7662013ca3f@siemens.com>
 <ea06df62c8c5458ddce909a10d94492a4e1072e0.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ea06df62c8c5458ddce909a10d94492a4e1072e0.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 51013822-3e7c-472f-9f35-08dad21a2a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W0gJw0XiAoBI4jcO+NNLqHCksU6TJrZHurUGe52p+qUqcfmEMYJvLAz8iiKTkCq0UCZUp/cAvckjmYbr33gYPLnoucjpAvjstIWh2Buwmgr8TPazy9GQNzYVuNAGiRB7wFXq4H86QBnurBYtzh/hw8MkzRIAz/cjbq1fAxxOQyV8Z5AYpvN1x0k3wKrauYAUYkF7oSZkfj3O8ZakySXsHU1sgrle/H7bTaVG37I126QvyfHVeOr9UVRkdQa+wYaiLB2ainfN8sPUcYihEOq6HVTjhoOwm0bqpT5015iXSC35w3CShY+f2161JGpXKcB0DAhvM+MiEoW3M8OmC4yNhn91bVwmKoDGwp/2LFuDgQsVp52rOeqjGqa5Odi+kUdldD+/BA+/s8Q38w7NkPcNEk5yLAFQwO4KqWKOjFdnnE5Z2J9YZioE1ayCjq48nw2iRp5qmbhKcinMnKh1MIpS3rEN2TlUUguZy/ILvP2NF2o4ksfh7b83RX7dNH/J9T44bsp1qYWScrqcdU2bK7lnRBwWGqY2dMb1lr/11A26R4/URwNdAjdZxXfmdVN5iZ+4+OHO6Lss2TKBJnTnqIXItX9Qu+BdCHa8vGznOVw+UqpCAnCkZ3++mtco2YiqDh0SR6WOf5ddIcj0jS5tBf5kqlhgntd8qhgJajY7PTdeYjlzqtYZS/MtnI/DMdSATU+0N04I2Wwni0RHhRNyTKznjPMfTUb2XwEJvel5asuRAuKHFpzzZ8+otNd59MPp23/x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199015)(478600001)(6486002)(966005)(6666004)(31696002)(4326008)(66946007)(66556008)(66476007)(6506007)(86362001)(53546011)(8676002)(54906003)(6512007)(316002)(26005)(2616005)(82960400001)(38100700002)(186003)(41300700001)(2906002)(4001150100001)(8936002)(44832011)(83380400001)(31686004)(36756003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWxzc1o1ajllTmkvN0dPZFpXVXJVOHdZZGNUaHpYNmo4TzIxMUZSMVBYRmtv?=
 =?utf-8?B?SnBmY25DbTJGM2JNVzV5SXNFNC9VQ25XZDYzNkhtYTFBTXdYdGtvTmhNbmJm?=
 =?utf-8?B?MEd3UVA1NDFsakEwL0NkeDdqVGQwYUk1dHpVUGNQajk1UjF1WCtIYkhudWgy?=
 =?utf-8?B?R0R2eGtFUWJTcVEzYnFjMW9qdHR1b2UxakcxS1BWR2QzQWMvVjhDUWl5dW9B?=
 =?utf-8?B?MlNEY3ZNVDdMRC9UV0Z5dnQwdmN4aUNSUS8vVndxSDQ1SDBNaXZuTHNiaEl2?=
 =?utf-8?B?TGM0ME1qMkxpY1QzcHdVUHlHTHMzNnZTWFZISWJ2S08wZ0VLVUExMUsxbGtu?=
 =?utf-8?B?MWYyRmVRSlVmM3gvZDVJNG50OUo2cldPRk5DZElYKzk4NVVKNlJ3VWZvdUJu?=
 =?utf-8?B?Qm9jSnlnV1kvWXFVZjlPZTkvYjhWaHE5K09ET0YwQ3d1Ui9VZzNZbllsTVMw?=
 =?utf-8?B?dDZ1dGxaVUQ4K1daUGJReXVXU3hYaHZaV1FKanQvcFd4ZHpJc3lyejhVZGkx?=
 =?utf-8?B?d2xzRE56WUt2L0p2R2wxRzZ5MGpQUHViQkxXdlk4aCt2cjQzRDVSYk9PWjJY?=
 =?utf-8?B?bHdiaFR2emkwSG5xRVNsKzNoMndlcUE2TzEwdzgwMWRqNEtERmpjZS9EOTB4?=
 =?utf-8?B?SFBKQUtyTDA3VVJGRUxpb1RrbFZHWGNBL2NMZjh1MFJ5d3E3MXQwN1lmclFM?=
 =?utf-8?B?U2djTUJqU092eTBJdXdGdU1wZHdlWnNMU3Rnbzc0ek9TWEJhaytDdmtKWXlN?=
 =?utf-8?B?WEk3T2dxbWZmMG13d25RSGlCdDFHVTBtbXB1cWJTQmEyOG1LV3ZBKzc0Uzdy?=
 =?utf-8?B?NEQvQnZNMm9uYUZ2QkJBNC9OZys2UjJZRVJWcWRTaWZ3aE9DaGVkeGt0enpF?=
 =?utf-8?B?cDhjdEYwSE50QWkrZWxCZzNmanBWUG5BNzZPaUVpSHo2RlVhSzFqL05RcTJE?=
 =?utf-8?B?OGdhb3BSSGNNVEVrNFJBTmVhSm1jOFozQyt6V0FSZHFobTRxelVCL0JqQ1g4?=
 =?utf-8?B?T0lpUUhkVG1DOE56VWs4KzBERkZtczNSQlV2M0hOSkdlUmxacm0xYk1UbEcy?=
 =?utf-8?B?YVhVU2ZJR0owRkhiQzFwMlU2VjREaWJFT1E0TkE3cHhsVG1iNzRIYUtrNVBE?=
 =?utf-8?B?OWt2NUg2YjRScDBKRUsrUi9uOXdjWi8rQm43RWNyV3YyQXZqUnlXM3RTMzBn?=
 =?utf-8?B?RFB0MmxSeEJ0SHdSS0pGUU9IcEcvRTRPUTJTYmFtSGlEb2pDREJoSlRrQXVI?=
 =?utf-8?B?aG1LbEYyYjIvaWN2bm41Mm9BQ3lnZ1B1TFBDTFZHbW01LzdZcW1qWXNvTnVR?=
 =?utf-8?B?eTlVakhYT1JNbVlLQmJHL2Z1RDYyTW8wbjRTQmpxRFhhMTVRNVVORnQyOUR4?=
 =?utf-8?B?Ri81NDZpVE93MWkvMXkzbVdPS25IbE9BVHp0UE41K3NTdGxXQjNpUkZOdURl?=
 =?utf-8?B?LzdiakkrYkprUlhtN2hobTZhMFBEUWFsTGxmQ05TK1g4bFJIaXBEL2ZIZHU5?=
 =?utf-8?B?NTVvR3N0cEVDRzdqckVNd3N2akc1ZkhTbkVvdWJNb0ZzaFBOcXdZRzFVYjFL?=
 =?utf-8?B?OGRQRE1UaDZYdTJaREN1M0dpaExXNFhmOTdsYmVJa05LWkUrYXZpV1VmTzBM?=
 =?utf-8?B?OUY3dlAxQWV0RzVUTDJNcTBSTE1BN2VOQTZWWm1JOURDWWlEMDExLzVPQzhK?=
 =?utf-8?B?dEhYMW5YeXlWNGRXQ0E3TFNGdjB4ek5aaFJ4Zkh6TjVuNUVJcnBTVncwNFFV?=
 =?utf-8?B?TG5TNW10Z0FYQnlmeHFhUHEycG9LR2NEbExqRTh0VGplUERoOUhZMndwQUkx?=
 =?utf-8?B?SzBRYkZZR3ZKQXZUdWEzUjgzVEY5VGxHeVBVSTdlYmtlWGIrQjVpZ251bnBN?=
 =?utf-8?B?YW94L0kyaHpGZy9VMG9hMHd2R0x5ckxsWW81OTBLM3FkU3loWnlxRjM4L3VI?=
 =?utf-8?B?ZWd4bStlTDQ4RnhrYkZ2b1hLRjJYRXk3Y0tGemVTQ0NvdEVkWFdzZ01reFll?=
 =?utf-8?B?aGhDaXV0NkwybzBYMzNnTy9qRlErc3VaT1pHNDZyNlNpR2gyUnBIWXFPK1Vi?=
 =?utf-8?B?MmZOYkowcTRHRWgwa0t5b2ZUM2R4ZytQb3U4TW4zMmlsSmNJMWM5bm93Sks0?=
 =?utf-8?B?bnNib1hua2hPcGZJcHRONEgzYldDMExkc3FqbGlPRTNOdjFtTC81bkZmbnJL?=
 =?utf-8?B?Smc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51013822-3e7c-472f-9f35-08dad21a2a95
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 14:58:27.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: euis67Tjpo/3TuI8IFjAwlhkms0ktXhASgbriXTFRYI/TQEXRtaMX+ypE5AtwJ0jyFWR1zZ2Wl1eiAlUTWpXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6554

On 29.11.22 13:48, Florian Bezdeka wrote:
> On Tue, 2022-11-29 at 07:33 +0100, Jan Kiszka wrote:
>> On 29.11.22 07:29, Jan Kiszka wrote:
>>> On 28.11.22 13:09, Florian Bezdeka wrote:
>>>> Hardware IRQs are enabled here! It might happen that right after
>>>> enabling the IRQ at hardware level the IRQ comes in again, even before
>>>> we could fix the software IRQ state flag.
>>>>
>>>> The result was a IRQ storm and system freeze because the same IRQ was
>>>> not properly masked at hw level during next IRQ arrival. The software
>>>> IRQ flag is checked before going down to the HW level.
>>>>
>>>> Switching to unmask_irq() has two effects:
>>>>   - We do not have to care about the software IRQ state flag anymore
>>>>   - IRQ state is updated in a hwirq off section together with the hw
>>>>     state, so the software state flag and hw state should no longer
>>>>     diverge.
>>>>
>>>> Link: https://lore.kernel.org/xenomai/20220210153313.2229625-1-gunter.grau@philips.com/
>>>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>>>> ---
>>>>  kernel/irq/chip.c | 3 +--
>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>>> index 41415a5ef7d0..6b34403858aa 100644
>>>> --- a/kernel/irq/chip.c
>>>> +++ b/kernel/irq/chip.c
>>>> @@ -990,8 +990,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
>>>>  
>>>>  void __ipipe_end_level_irq(struct irq_desc *desc)
>>>>  {
>>>> -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>>> -	irq_state_clr_masked(desc);
>>>> +	unmask_irq(desc);
>>>>  }
>>>>  
>>>>  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
>>>
>>> Ok, this is part of the answer to my other question.
>>>
>>> Can you also document a code path that enters __ipipe_end_level_irq with
>>> hard-irqs on?
>>>
>>
>> To answer myself: E.g. Linux IRQ handling uses ipipe_end callbacks like
>> this, and then obviously without hard IRQs off. I'll augment the patch
>> explanation.
> 
> Exactly. Who is responsible for applying the patch to all the different
> arch trees that we have? If you need a v2 to make the process easier,
> just post your adjustments. I will happily take them and send v2.
> 

Already in ipipe-noarch and the x86 branches. Greg can pick from there
for ARM/ARM64.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

