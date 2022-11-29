Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9E536C
	for <xenomai@lists.linux.dev>; Tue, 29 Nov 2022 06:33:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9+DVM+nNsDMj6n26iq64tLSm7atnEE+2m3hk91R4A/2U4KoQRPPj7og+ItvJ6m/3SX+5wvuyT+AEEG0UmCoYvh4EcUutKXdDQUqcKPLP5ftZzQ6OqwmqupJ92nJio3guhvcJ6HW97EevVLojny3pLL24rjKWjo6PRCqumA+nhUaIQNRvJpmJJmo2HkyfbU+qWnKJ/a+r2Z40xCt6BD2wRdMahaDfbBLF93+UPovO26n63Zk7zC/qRIoLOVjBhiqowVDrfOH/8X9EuPQ8sgefi/ZZQLpNkLCAZ85V4bggpgYUjnrnModzLQhulzbTsOzClCYkz1Q4oiI1R0q8dFflQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ULOTqZN4FV9h+FVMqHMQc7ibHk5oDJcP6Y94I+Su0E=;
 b=KZJPbF5tcnXGVO8GmYi40RxpRpEtomeeP7Fw17riG/ChoXGzhz5bSS+1FNQigVp6zvvRZPkTHVehlHml0wDd99vllBQcz73OGwW7E+Fla2YTH2IHwUeYrG+LnKqZqjzI2t4/HuYzdF2mb8KFaDkR16M9Ex4vjoLKVcap+jP0SLJzZAyPPfC1jpiwVDLby4M0HCw7bNxtuAce9DfpyMb1OSvpM8Y6NAXj3eDz95Q0KdwlNJOqfYs4PTlnji945AhZ27VSGyS5xy8iRu04edXIoEtBrkrTQGy9bw/uWtW6BW5G9C1339AfP+o4g1id9NiVl6rIOy2G0E6CWtCpDTlfUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ULOTqZN4FV9h+FVMqHMQc7ibHk5oDJcP6Y94I+Su0E=;
 b=MJJeelgaZnjYVDRsHN7+1H9h1byTRc/VXLx8K8Echfe2oqqSQjOEE7ogwk+EK8wnVphIfmVfrnPQ1YfslRiz/1/2cnXBh27V+yENTCSRLnGMg9XavR3yScsiuXuqIK45kDibf/Xr+BOqr2D6HvMxv2R1eW7HRgZKB1pmJrC7+DzWVZQsHm3FygxXR1haVsFoeXvBkdW88J2jivxumf59hnQcP99PukqQkrTJfUS+7Yw5IiiAr0Pn7XPpySujLZ2y/kck6t8wZuDWWDnSGQKoJZBxmiGcLJtO5R+FJvLQmQDVMS5S5QuI+zMhW4322HeTDBb4g9Bd8OmtVyDjjNHDRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5796.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:63::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 06:33:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 06:33:09 +0000
Message-ID: <94eafc79-3141-1a6c-330f-c7662013ca3f@siemens.com>
Date: Tue, 29 Nov 2022 07:33:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [ipipe 4.19 5.4][PATCH] ipipe: Fix handling of level triggered
 IRQs
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Greg Gallagher <greg@embeddedgreg.com>,
 Gunter Grau <gunter.grau@philips.com>
References: <20221128120908.1136136-1-florian.bezdeka@siemens.com>
 <99782966-4c04-7b60-1b29-0986af501f92@siemens.com>
In-Reply-To: <99782966-4c04-7b60-1b29-0986af501f92@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: f1cbdd7c-74db-4336-3066-08dad1d394ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vVskxlIo+fsOBEJtx1HcykcdT8kYBKbk8aCQjnxn8HD/Iqk196+ZshXtbQs+trMiEwp/uio1KIdZmVyNsnDBZTWsnMGdLoIRXHuEiXpyILZkjbuOr1udVQI4Jq+arHucuwfgNPDcB2nNzFSjWWU4qhn9CBf3SDlRvW3dUTymKiGdrTcIPWgmFnbUo0/CqUoA0GyqDWJntdrkjIp5OqnT6Sqzz4ZsFc9PMSmUFmVdrfHG2J86hKBzMnBIpQl7qRZHv2W3sHUCi9rQpWabVLrbG3Ppu/GpeG6PPiUWMKyV495YFNxa1vrESpr05qkPlsZmfotVdL08qrgggG7/m8WjttP463E8HlMEpmP0hNA038SDDeRLPtB15N6irMSaduFpyhszHE+UE4FGKkTcHj6sfKQVS2bkujWvyw7+Gts0dm2EzQVwydPONvuPw2PsAhPrUaE2bUV8UQ/YuEYWq/9MFfAHPKAffSb5osXfxVw4Vz0+In8guRaIXHgD1a+5CUNv32zhi5lYFAA6IJCDQqj2us4M8f8qVOgBxNOL+ZYWgLtW539quXQY5Nx6INtnuHkCFvFycBuE+ZM0eq8mAdP2G42xKuPn3igLHnf76nE0adYnEzDpFXwukycJ7D2LHe9UbF+W/fziUZr7G5tP3JL6mfl+XFTV0YStOs5CuNvJzQ2UW7Rglj4Czq1QyTqXjL4VLGqtSUHbtjsE1UpPEp2kwdgXBkhFen/b7vPiV4CYYJn4kWKwiae1w7F5iNRTisdgjyEonhqhtaBaVpMI5A50hQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(83380400001)(4326008)(8676002)(66476007)(66556008)(966005)(6486002)(66946007)(316002)(186003)(54906003)(36756003)(2616005)(86362001)(31696002)(38100700002)(82960400001)(5660300002)(44832011)(8936002)(41300700001)(2906002)(53546011)(6666004)(6512007)(26005)(6506007)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkorR1NIQk5jWXRHN3NtQXJWS2IwTy9aYXNhWmk5UHkwZ211RGh1akM5M3dp?=
 =?utf-8?B?eW5LQzRnVjhOOStRTk1hdndSZVVCZnQzUzdTQTRjY1pxa3dQbUhMbENQMVM5?=
 =?utf-8?B?M01LM3pjNktMbU8xM1JydDJtOVlmYUFuRi91enFYT2xrd3RCTkorM09pOFRQ?=
 =?utf-8?B?ZC9nTTN3TXJNYVVRejFiTThYTnhGbWZKM0MvWVZqODY5bmxmbm1IZXN5S21n?=
 =?utf-8?B?d2JZUGlDVEw3clpVbHBLMm1hMENWTW5Uc1M0alJOd29jaFlTK0txdTA5SHM4?=
 =?utf-8?B?eDhYdEMrRTRZZ1BENHBSWTMyYzNVeTVjQm13dVBMak5ic241VXhHb1VnUll1?=
 =?utf-8?B?VU9FM2J3dFpReGxTRVlRcEhvaVFrWEt0Mm94UWgyOGdQQk53Mk1haHl3Zzh2?=
 =?utf-8?B?dkxlNUlvWUhUNUVoM3ovU2FrblpRcEJnVE5haEFCLy9neEdjN1o5SERVSG5M?=
 =?utf-8?B?cUZ5bGhCSXRPWTVWOEY4MWlOaWxpMnczYTRtOWtPZE5QcDhUTUFYcVJpOHUv?=
 =?utf-8?B?eHRERC93QSswTnlON0E5dDAzL3ZXbFlpV2Z0Z1hycHpCVGtERmdJRGpxKzhz?=
 =?utf-8?B?RjNPb25BVkJubjh2RFV0cHVQdm9saTMwUThmSWdNOXdsSVhSR2ZzWC9zQjFy?=
 =?utf-8?B?VlNzVnNKMU8wSVoxdDRMZ1dGbnlOTGg5bkQ3RVl1T1lRdEpRbFp0eExiY0RH?=
 =?utf-8?B?RFZEdkNPVFRmeUxHMTF0ZUFzTzBacXR2QThGOWgrNGptOGhIZkJkMzlkSXJ5?=
 =?utf-8?B?RksrQU5MVTIwWWpDS2RuQXlDcmFqQ2hWWWZlQnN3RE5TMDlZUjRJQ1FJOUhI?=
 =?utf-8?B?MTZTWnhlS2VhUVptRnprN2lGOFlIeCtuVjJDbFhmVVA3OHVOMHZNd3Zmcnp3?=
 =?utf-8?B?L0RXa1BJcHVVV1gyditOSlQrU1RYSlFxQWZGK2p1UXlvZmJrZXpVcHJQWVpJ?=
 =?utf-8?B?WDV3bVhnSWpJMTJuMittTExaWWd1NWVwVkZKSmZrMGw1cFdFRFlVZ2tJYmV3?=
 =?utf-8?B?R3EzVmdweDVycys3eUhiSWViUndpOTI3M0NJTWtBay85STVkS1h5S0UzRmVS?=
 =?utf-8?B?Yk8zSmh4Nk9iVEx1QlFkQ2ppUFpnWFdFWUpaVFh2RXdoY3JhWlp3YWNCcjJr?=
 =?utf-8?B?VDNSQXJRUDV2UG1BVHU5VGRqcGtFKzFXWWgvbEZEUk4zeWhmT3psV0kzNzhj?=
 =?utf-8?B?QXUxd2NneFRtV1dKME1qM1RkVy9WVDJLcFdVSGJLOE1OekNHQU5NYTRnaWxs?=
 =?utf-8?B?ZUtMRDJRbzdNRnFXZ3diclhqUWdCcDlhUEFIUjIxb0J4UVdLenUrS3NQaEhW?=
 =?utf-8?B?VG1XQm4zaDFRRUdSYTFHY2FaaVBwTHNld201UWkvY1R2bjVVclh2cU5NZkVB?=
 =?utf-8?B?Njh1d3ZWSmw3YzhXVU1BQ2pJQWZoV2hSOHpnNTh2WGNyL21aQWVCdlR6bkwz?=
 =?utf-8?B?K3dFUkE2K1huQkZka2g5Yy9ibzBXWDZ3U29OWnBqRlRmWkpyTS83azhHRmw1?=
 =?utf-8?B?NTRpeWtyQ2NsOFZPRFpucFNxZ0FiY1dBU3RPc3BodnBBa2M2ZVZWZjc0M2E4?=
 =?utf-8?B?M0JzQTREcURjNUs4VEo5L0h2WkZBeHZwVFYyM3Z3Y3E1M1JRdUNIUEFLL3hk?=
 =?utf-8?B?R1NRaDZJN3JMbFQ1c2JwK2RkRnpkTzl2dDNoUlhZZGRRMWdPYnYrUDVheWpi?=
 =?utf-8?B?QzRLcUJmZ0dROXVZVWd2cGlpaHdManNSTTZMc2p4NVR6SGRSdGtSeGx2bU9B?=
 =?utf-8?B?aC9kN29WWktWUXRaVVpRM0QrTmNNeWZodDZPRm1WMUlOQVc5cTNrczNXMHdj?=
 =?utf-8?B?eDd3dU11Q3l6clFObnRWU0RsZHEwOElSQWpqZDk1ZFFEUjNFTkRRYlNzWEti?=
 =?utf-8?B?NDJRMTVTc2FYb1FBWDduTkNBQmNRMXJPeUpzY1hhUWVpU0J4Ukw0NlJyeG5S?=
 =?utf-8?B?dnB0dnI1ajBrVERlRkl4TW1GWkNIMTJWMUdPcHkrVzBZcVl2VkhmUnZoL2Fp?=
 =?utf-8?B?UnYvMlF6bjhYUEZKU0hzaldxa1FKRUFIbTRZZkZ1VUxkWFFYWW1KMW1vSVo3?=
 =?utf-8?B?MmVvWGg2QS9HaFRrSXFub0pqdFdReGZIUTl2M2lYck5NWkFuMWhwd3RzcXpU?=
 =?utf-8?B?UnNmY0ZGVCt5d1JqOUlCYkI0a0w3bUZtVEpzOHpUREVieE4xMURtd21JbXZ3?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cbdd7c-74db-4336-3066-08dad1d394ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 06:33:09.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9L+JjgC3N2/uV4B7ov/xNJSKq3tltSYXXr82U4JDZ7gdsP4B42j3NNoM5cmwagS7FryPkTyFIlNX6V8WclvPKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5796

On 29.11.22 07:29, Jan Kiszka wrote:
> On 28.11.22 13:09, Florian Bezdeka wrote:
>> Hardware IRQs are enabled here! It might happen that right after
>> enabling the IRQ at hardware level the IRQ comes in again, even before
>> we could fix the software IRQ state flag.
>>
>> The result was a IRQ storm and system freeze because the same IRQ was
>> not properly masked at hw level during next IRQ arrival. The software
>> IRQ flag is checked before going down to the HW level.
>>
>> Switching to unmask_irq() has two effects:
>>   - We do not have to care about the software IRQ state flag anymore
>>   - IRQ state is updated in a hwirq off section together with the hw
>>     state, so the software state flag and hw state should no longer
>>     diverge.
>>
>> Link: https://lore.kernel.org/xenomai/20220210153313.2229625-1-gunter.grau@philips.com/
>> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
>> ---
>>  kernel/irq/chip.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 41415a5ef7d0..6b34403858aa 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -990,8 +990,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
>>  
>>  void __ipipe_end_level_irq(struct irq_desc *desc)
>>  {
>> -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
>> -	irq_state_clr_masked(desc);
>> +	unmask_irq(desc);
>>  }
>>  
>>  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
> 
> Ok, this is part of the answer to my other question.
> 
> Can you also document a code path that enters __ipipe_end_level_irq with
> hard-irqs on?
> 

To answer myself: E.g. Linux IRQ handling uses ipipe_end callbacks like
this, and then obviously without hard IRQs off. I'll augment the patch
explanation.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

