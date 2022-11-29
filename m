Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D8639
	for <xenomai@lists.linux.dev>; Tue, 29 Nov 2022 06:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNqRZgDAkV/ob0hXzkr8t43UOKmyforjLzQYOjuqe+AZl8D3iWnBwdKOXvLduyMK5OS55ZGs9Bt6B+KNWLQ75rM05uM3Ix3PFJo7qdzxRhQwCcvi5Zc5yLrYUHecxhiexJU47EL3/gf0YQctetGvnXZKux9cGyokl8W08BgBNYWASAXb2pTzq/oqZIn+ZL2/sdvuYvsMI5x5Ww01dNWnCwlP6bS6Mh00U6Lmv6me/GtWG77y70q6JXRpqisTznpRJb7Y8cQ1nb3D758r6dhPhBOWegQCUBix0g9X1osTXbbILegFmJQuwbEtj5KUISW05ubqap8HLfUCG7yQjiSfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKagwITMb8fy87E7i6vkHvFnBOjnLgLxulx3iQdRpSU=;
 b=IJRJY0hXnmkdYPbL1KFp4mvd891/Imdh0dczraLsVJHpSDV+CTR5VcN05OHdIoM0PHqB3VOJDBj/18xgb59vLclRjzkQa0pJUCRj/GziM9uW+kY3LOfTtkVuCaaHZhy4iPJIkW0cPkOHVTlLMVAO/Z5myfcqNKQUT7kCg8Rz1dwJ1sB4bjRvKs69xbJnqX+Y/398qxGJNAXPg2Ek5ua32GCl5NGF1HLHYXo4RYRLkVvOPaUC/kziAiO+iqi1p0Q1Aw5T1KGGJcMEfD2kCEJhKZ0PXFjR2GQ8a7jFZ6nHQX/L2oJhjL4H30c5QtYdNBH/3m7PH8Bj2v9oE0LH9nEmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKagwITMb8fy87E7i6vkHvFnBOjnLgLxulx3iQdRpSU=;
 b=Co2a/j6QkpNMrXZK40uCXhZULjQA8I/Nqb6Y4E87OQBuG2LfzHKtbASwALx8RVSpMwhw/NZSihT5kecbypZ+rFycNxx1yE8gU4sIW6waeavGnAl820su4NItUzYeU+jsU9aPRxKLBLnDB2Olodfur99zx4EROT1LjbVpQ7DQNPhFYOExvVPCD/8hCYM6cyPaVv3JIksux2tKUirSySeuLvfC3g6Q3wmtBT84X6hh5ImbYOFCt+yA3kWj2VO5UGc1ZOEyCyxHJutgcIgnDHMhyYZBfkgCv6h3kpPm82y3RpxvDHXQW/34MLqd/Vr9zo5q3zUMlsJCq45+PZbH1bvubA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:538::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 06:29:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%8]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 06:29:34 +0000
Message-ID: <99782966-4c04-7b60-1b29-0986af501f92@siemens.com>
Date: Tue, 29 Nov 2022 07:29:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [ipipe 4.19 5.4][PATCH] ipipe: Fix handling of level triggered
 IRQs
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Greg Gallagher <greg@embeddedgreg.com>,
 Gunter Grau <gunter.grau@philips.com>
References: <20221128120908.1136136-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221128120908.1136136-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6029:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe908f6-bf3b-4a07-bf8d-08dad1d314a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/pcV7/vNu7BwxVFyRoYZGuvyrxFvjQVn6AnQiI6nxwkHFgCqDIApM/5WVhAQYK7GTQ0xEbu0Lpn3V1nRMASTW2t88dPZ4rUFbuyl8vJdFUorUGc20c+4ZdpffwgSfxLSfIzygyJlofnnNtxixt3S+DptNjy+Dl1N2K8OHJ1GkJzd2U7Zwq12cA4yH5m54V7q4L8n2y3o1JSSJtXS4pYfOFEW4ETbfU3fPPojDDAPKGi9HVDxXB3sQWE77JpzSsC+CkHjNlBubZpoyJPZI3cijnGG5bri7LaGTn4nE545Gj0yPwjMZSDKqV8T44kASaok0NGPHlhgogzt5UulpARqOT7WP8xZVCeJfngiu/xtK42tVJArQgDYoTaIgE/uy9WK7LfkvRhWU4kuH/7bYqpgiqCcStrAPtP4yUh7bDOIQH2VHB8uHhPOkEdLWNJ8TR4k6NciT6eZ+cqKJviG7DeLXf55J+zMFopsPNuVG82wzyClZHatKQKrXxRUZiyFtttU6fclYBpieM4ntO8lZAFBVPWdrTMloCe1zIg6dcSr9Hvn+LMhtyncjtuO0M46lbvES8ZhSk5TMPbLTho2LXY3JjU5KNMG5URQR7Kfz7aTW8S7HBn4+VJWIFDXOvsbTLObrGM8c/DoGTAn4VtRFgn9nk/z0mhopvu8E9IV9j/PZuxSnxWxJ6caeCWZs6i0JEOiOVufLOgFkq92NzwC3vJkIdjUFbcEUivZMGkBV71Z9f9Qxx4dTQMdueEvusIQ/Vzc1vob9SBelfNi6DwtGiYyOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(2616005)(31686004)(2906002)(83380400001)(82960400001)(26005)(38100700002)(966005)(66476007)(8676002)(66946007)(41300700001)(66556008)(6512007)(36756003)(53546011)(6486002)(6506007)(478600001)(6666004)(186003)(8936002)(5660300002)(4326008)(31696002)(86362001)(44832011)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW4vdEQxZG1tYjAwNGxlYmRsZ3M0THhDRXFxUFVoeWVYYmRPdFQ4V2lEeXND?=
 =?utf-8?B?c0hWK3RyL1VLK0h2QU1oQmlvRVdXOUtLWHhPTC9jeVUyY3FZVklUTksxMTh6?=
 =?utf-8?B?M2kxaXhnZS92N2lqQjJPOElNUFllUDBRYnhIVkpwWU54TFRmOE1qdlFzRmx0?=
 =?utf-8?B?UTNiQkpFdVdYd3Q5L3RpcGxld0FFcGR4TFRnT3FzeHd2OTh3ZU1DODlNME1w?=
 =?utf-8?B?KzRiS3Y1aGlMOGtvbXU0bFdPMTdDa0Y4Rk4zcUNaRTFVR3ZIMHdtVFBtR3Zm?=
 =?utf-8?B?Z0hCbjBKamoxelFMUmFZNW41TzNKRmN5MzVPVm1neEMvQmJ1VzJWRXFBUmlB?=
 =?utf-8?B?dmJuNEVtbWVQNWpjeDNvVnl0Unk3dEVqM3hrcXpWR0FGZEE1RWw5SXBUSFZ0?=
 =?utf-8?B?YStZOXQxVSt2U0FsVmY5cUhpVVVYcWd5dkNVVTZOam9EV1dUUUZxcHR5WDlh?=
 =?utf-8?B?aHlmQ0l0WUZXbnJ1a2FLVlRxend3d1hIU2lCc04rOGVSNzFQSUJzRU9FdFhI?=
 =?utf-8?B?MURMaHZuRjZURWVjS3VNZ3BkVUxlYUVLR2hlV0tBaGlSdlBBWFYrbGp1b1Mv?=
 =?utf-8?B?djQvWktuYlRZVTE4eXFQRlZSTHNzbTJVS2x1ekIwem5Jc2ZzWFdrNW4yV2FW?=
 =?utf-8?B?OFYvNXJqeDdaajFUOXh6K2VGWFFLLy80YjQ2SFlSMUtQeTJuSnhIT0cwbk1F?=
 =?utf-8?B?S0s0S0RwWGk0b3hmZyt5alhyZG1UaFNJcU5XeEpoU2ZnY1Z5UU9JbFEvM21D?=
 =?utf-8?B?M3B6TklLcW1DZWYwK0pCQktEK1FEQ0ZnVmtDaWEwR3g1TGxtZHJKRlBnbHFN?=
 =?utf-8?B?S25RSzlNaXpmbG50OHQ5V291Yld2dDNadFFGaGZyRHJ2Q0hiYWd4Wmh2ZXdk?=
 =?utf-8?B?d1RtbDVUN3FyZW5CNEYvRVlvU0FpdzBRNUlIMnRiM0x0V2FCUkhsVzlrNHhP?=
 =?utf-8?B?RHpsT3FNTjNTbWtuRjlXaStUN2FiOElYZWhZZjAvVTRBNVZ3eVNDNG1tRlJF?=
 =?utf-8?B?bzdnejFWNFZ1bXp6S2FiTEV5Y0U1Ulg0ME9LMmpUcGlCZXZPVDc1b1lCTzlT?=
 =?utf-8?B?N245RUhubExOUFhjVmRqUkxSRUErZE9vaTErZTJzTkNYcXVJV2lJMDJSU3Jy?=
 =?utf-8?B?cDRFV0NwMzJiMjFqU2pRNjlwL1dxeXkxaDE1R3JBTEVFekhnK1FQQURHZUNT?=
 =?utf-8?B?S2gvVXRaaHNwVnBZeUMraW9IOWw0RWd1OTU1U3c0bllRYzNwZlpGK2dDRWJU?=
 =?utf-8?B?VFp2R3cxWTl2ZU9mbGtZTVdXYldBcVlUUnBaaFQvR2ErZE1pS3NiSnErdW5p?=
 =?utf-8?B?M0xDZkRTV0F3K1MraWY5eXBGeVF3NVVYdllLRFlUUDhJV3MyQ1RDVklxdkRT?=
 =?utf-8?B?cXYyb2hISUlCRWFuRUdnVE9hRE96MXoxc1NrQXdiM3BKZ1RkQjJpcGFaSWdq?=
 =?utf-8?B?OTZjbmZHQUZHSWtCeUpzbVR2QlV6ejV5dTJLTFpnb3kyeFVjWWU1U1BwWEJu?=
 =?utf-8?B?RzVydEhPSlc4ckpBbEdzbEY2NTRiZDMvYnVqdllGVUpnbGtrdnB1R2hReWpi?=
 =?utf-8?B?SWpVYm5kaEYzczgxSXRBVWQxZkdZYkhmeGtLcE1TRDJ0NXgzcWZJaUpFNGNH?=
 =?utf-8?B?T0plcGh3QWNCVDZkNjUzZ1EwUHNrTTM1bGhMcm1YWS9qVFM4TWFyMWh1VkEx?=
 =?utf-8?B?cVQ1b0tEWnFtWVh5cXlJTi9sa0RYZTNpaW1LcFExWjVxamZMWWNKclAyT293?=
 =?utf-8?B?a2l4bWN1U05pNEJrZUJVa1NPQmdSL1Zxa1JkenNVNVlLM3V3dVA1eHpMdWpu?=
 =?utf-8?B?eFNiYXlyUk1tOUpBb3Mwc3daU0diUkJuVFJpOEN2cWdSc0k2Q1gzZFpWZUxn?=
 =?utf-8?B?QzUxMEdzRnp5d1Zrd1hpRzA3cUxqUVU4amx4dWNRS2l5RC9nemhPdTNuKzVJ?=
 =?utf-8?B?Y09NOUhzSUtRWWxmMVBxeC9WNEg3NTJIRGUzbmZPMHJpU2tManZUM1NWM0tm?=
 =?utf-8?B?UmhwcmZJZnpkRncvRkFOcFdNU3hJY3RXSUxwVXF3S1JHVm5XN3VIU3A0YWNk?=
 =?utf-8?B?SDZxRFN5S25wS1U1U3B3ZUQ3ejZVSHMvLzRVQkJ5ekxnc0VXelRpaEZzRnJk?=
 =?utf-8?B?QlFya3hJTUFlNWNvcDNZZzZIK25ZZnI5VjJveGRKc2VHcUZ4ZGQybU1sZ3Rl?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe908f6-bf3b-4a07-bf8d-08dad1d314a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 06:29:34.2242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAcwaDIjA/WUYrS9whhmav/6T2aXaQs88rRz9HXbUGGlp4+3Wx8lhglXtWiEK0QnW/cnTF5tphO70ylKMSbLig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6029

On 28.11.22 13:09, Florian Bezdeka wrote:
> Hardware IRQs are enabled here! It might happen that right after
> enabling the IRQ at hardware level the IRQ comes in again, even before
> we could fix the software IRQ state flag.
> 
> The result was a IRQ storm and system freeze because the same IRQ was
> not properly masked at hw level during next IRQ arrival. The software
> IRQ flag is checked before going down to the HW level.
> 
> Switching to unmask_irq() has two effects:
>   - We do not have to care about the software IRQ state flag anymore
>   - IRQ state is updated in a hwirq off section together with the hw
>     state, so the software state flag and hw state should no longer
>     diverge.
> 
> Link: https://lore.kernel.org/xenomai/20220210153313.2229625-1-gunter.grau@philips.com/
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  kernel/irq/chip.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 41415a5ef7d0..6b34403858aa 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -990,8 +990,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
>  
>  void __ipipe_end_level_irq(struct irq_desc *desc)
>  {
> -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
> -	irq_state_clr_masked(desc);
> +	unmask_irq(desc);
>  }
>  
>  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)

Ok, this is part of the answer to my other question.

Can you also document a code path that enters __ipipe_end_level_irq with
hard-irqs on?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

