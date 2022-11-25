Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2078.outbound.protection.outlook.com [40.107.103.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA11029A9
	for <xenomai@lists.linux.dev>; Fri, 25 Nov 2022 10:53:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGvzFB1GqLMAmwqZaKFVp8zM0vuhggYqPWpw8mAbbapGS61ghRzToMWM8vpzmd3S+OfpEX7wCbqF83AvAvUepyMIeU9QEbYxxAroE1BgYCmX4ZWzQ5PJlZ/NLRY4pX/DFCdhhIi3KP+/uKK0lnE59ODpAY35LkKcE33yW/ixU0nckDQ2xZUwes62qi6z6ur9or4kGi9KFmBVL5e/4tEU6YtGzufpbyqcVe7/xe6j5xSG41+Yn/T8n9PyK4E2i1fUQWK4TJhWgHgul12SPO3XaAxdcKCca7owQGa+t7MXejSY30BmV8STzIDsVqSTjy1jfkhnA6OQSZxdfM3+AfCD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU0dOfETDAzGa0KAu9IiZAExiTWF3R8Mq1PULNCYnvs=;
 b=OiI5ClB6Zyx3O06Fs+WjHB6UM3ukbhecIfZ2HIT4JtUzOF2tQX4Zz4QhDTjhFzj0kzGAP7iq7mMfXDyd5AXHxg4Mpl0/gP+WmOw5xrr8zLmthGJX9aSx8AXo8x+oPCZkuFlULMCpVBjGd30RNU8XUqVLyo3Y+zq/diq/r4M1D3WydAX9BsF4u8UKlkYz6BK64M6wNbxfW/hxax080i/SYKTBIhTVzTG136hgygGW3etN/0JVf42vrr0Lt/0IRXx1wNIn2ytF1grdQYfEHFGBRGZDKHXWZoRflPCKyvVSoPc6QySvXpaNmttOtxzW9GwibwWGSktVvh9gIqv4eyyxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU0dOfETDAzGa0KAu9IiZAExiTWF3R8Mq1PULNCYnvs=;
 b=NMB+CFXUiXIX3xu972PUyrj80IMOldBhfx1cLtTwj+S4DOWVEgp1tfzupK5fYBukYqemic36H715cO64hVSx2sPL9iQ9wcZHRlMKJiuk+fr9detir6xK5iVgKC8/xOjwPQ2YQ5xfV7GF+MymrD7QsRhUQB/xxGyFC2doMgIFGZOace+A/wyhnaX3uCIyL1ESvzAMVVrZKRtMzxE60OOPsXeZOp97zP4pyy0H0V5DHLVOXy/ZPvHygSlr/XyFBKm68uToKkIxn7fPqHT+CqLALTDNK4NxBUtYUTQVS/41693CEyifCLDSawEWdNj/NXrM3DWUQrKkh/tSjRkLb4r/PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 10:53:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2957:50e8:8ce6:124a%9]) with mapi id 15.20.5857.020; Fri, 25 Nov 2022
 10:53:21 +0000
Message-ID: <8e95dbd6-b120-11a0-8c30-ce4f29b1ec84@siemens.com>
Date: Fri, 25 Nov 2022 11:53:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [ipipe 4.19][RFC PATCH] ipipe: Do not report spurious interrupts
 by using printk
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Greg Gallagher <greg@embeddedgreg.com>
References: <20221125090834.617271-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221125090834.617271-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc1f2ce-fd15-4a9c-93b5-08daced3450a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/vBePeE2QKuSOG+LuukmID/f3SMdxHznt2bmAhHKMzHho68ab0nyvzLL3bKrs/whssD1FWRSSgqm9qHRpWCNq7KvwLKknnK7qWwj2qo+Kvwm97U8V1VNuxEAjpVpo+j8IbLm0cbBbR9qNTcdycXCRTqRWyfZwVRvmtQF4+58xV0uy51kdetYRlaE6P3FxxcgZYVQZ5fzVHPr1MFP7Y6tcbDF8QFiqQl/yA2WxTlgOHbw00BgF7B0ts8zU4oqjjVhgA8ldnR81ewineSPsrtjD7ahkwdUBBxzZtlIOcZfMuUZDQTNj71ZyOYrysJwDx3WAfTejQizzbjUXY67e/3tQuekX1k8HSTZquFEv+J836036h2abhquPrXmBU8hxIrIGkiRdwSxDZzF1zZE/l3l+dg64qRrqhI6fYrm10dBd/mdD9aancC1GryZw0Sxpud5LZ3yzOWrrxDPDb4I+DIEvWVZRvdhRxm0r8od89PpYLLEWsk3d6zYMe3b6Pv7A07vLC5+LwdFreOrS9I8NtLnKDAMIFVgxm72AL1myw4mU4cop5g6KDiDIzv2ylBFY8cojjbhA1DiKTffumBLY7rQlB/D5rcVevsCxJFM2vt7mxaxjckBJA1p9Jw2yw67xEKnSJSJilV19cIb8a4RCuChKpBCRdH2FeU3eqegGWTZlFUMYRij1gvLcrQE0ZyvHjt9e+5RBF5bPgjk4+UbiCDxxRm+c4bCaoVnL2sX1APjF2Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199015)(66899015)(31686004)(6486002)(83380400001)(6512007)(36756003)(2616005)(8936002)(5660300002)(82960400001)(31696002)(38100700002)(478600001)(26005)(86362001)(41300700001)(2906002)(186003)(8676002)(66556008)(44832011)(66476007)(66946007)(53546011)(6506007)(4326008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDVTK2w3bTZFR3R2VHdzMkZMTmtYR2pVU3lnUkFjVkYxQXU4bUpOL2Z4Yitu?=
 =?utf-8?B?U3NTTWw5R0Y5SWlGWGtJR1MvY0hTMjE3a3k1MVJCamorWUxTZmduc25kcEdu?=
 =?utf-8?B?K3d2VXZML0JpOXFjbmRxajVZYzlWNndYTXRyTXN2MjMwa0pvTGRIa0hPZzhq?=
 =?utf-8?B?ZWFLSE9XQzJwK3NtbkR5aXZ4cWI1MHlHV29OekNNaXVuUlhJNE0yZmZaY1k0?=
 =?utf-8?B?TlJ5N0dTdElJN0g2RnZjaWtrak9hSHppZ3pnVEpaOXhLck5UYUM1SW5vbGp2?=
 =?utf-8?B?cjlSb3YyZWZFVkNZK1lUOHJHeWQ1K3kvNGpNWmdTa2pqVWRnamMrNGdHWDdN?=
 =?utf-8?B?aFQ0dkd5YmgxL3E3MHl2dE1CNWlwblpFekFyWUl2RTZOa202RTJLUWJEWjlT?=
 =?utf-8?B?bUNoeE11KzVKMllseFlPQmZGL2Y2U1FHcDh1cTZGdTJYbTY1a2VMMUtzN2ww?=
 =?utf-8?B?ZHhveFFGWlJsM1ZNaWZ1L0FqcDVYV3I0YkNWWFNEbDlmUjFEQzh6c2wyWXRN?=
 =?utf-8?B?bTdGRTd0MG9DblVhNzRHSmlyaDFXSEpVMTV6djZRTS84cERNVFF2UVpBcHkz?=
 =?utf-8?B?N0h6KzBSOU5BWWZkZjZCVUFJUDZrOGxYOWgrNWU4TE5qRlRCZ3htTExaRlA2?=
 =?utf-8?B?NG9sUkkva0JFNWRQR3RheFYxR0lwT0xCeURpZVNCTWpsRkNWRHVmbHdQR0Zm?=
 =?utf-8?B?QlpCTHdyY0tXcVF2eFFvbjFyL2JoK1pFUCsxV1BOdE1HS0t3aVNqZkJhdU9U?=
 =?utf-8?B?T3ZXcjhvcFpiOWI4TFRVTTN6N0ZTVGh1VDRtQ0NSQTBWVUhXMkw1WkFQNEZm?=
 =?utf-8?B?VEM3eEU2bFg1dGFjSVZVbS84am9rL3JNWEMzZHdPMFFlUVgwSDZNLzJlMmNZ?=
 =?utf-8?B?dzlKcFBPeGZlUXBqUGNoZE93OWJ0dmJpb25pUlNaakZqVFlxN3BZbm0zd0Vv?=
 =?utf-8?B?QXdqMjZHT2F5cGQ5cXZvN0h6ZFlDclRXQk1NaUJKSU5pT2xScTR5b0tsY0hm?=
 =?utf-8?B?eWhUZXlvUXVzNmk5ZXdVaWYzNnQvUUZ3WWpKczF0Y3JiQXpqVUZQay94eGZL?=
 =?utf-8?B?Ry9jYjM2V1QxMGU0QzRzN2QxUDhTUWhpUmlzWjJHMlZSOEhOUlE1Y1I2cGRy?=
 =?utf-8?B?UUJTNnZNRDNZTmd2a0Jxb3QxSU9vN0NCeW41UGtHVUQ0MkhYM0FFZGk1TDRT?=
 =?utf-8?B?dzEvME1hQ2FZRXhncHBldW9YelZwRE5xaFdkU0NJblgrOUpHcTdJamRCVlY3?=
 =?utf-8?B?a0plMVo3TDJHM2xqTGFYZzMvZUY2VWgxa1FOVWtpNXlSczhxVzdTelFEUGVH?=
 =?utf-8?B?anhQdVVYQ1o4VjluUjQzYmMzUGcvc3FzVkh1RmxTQkp3SjA4UUp4aEFnemRr?=
 =?utf-8?B?YjhBVnFIamtIODg3b3dSa3kzazQvUDdFODJoWHRwbkJFdDBSbVJXQWJYcDEv?=
 =?utf-8?B?bnl2Zjd1UTVMWFUrOTk2SnB5ajV5TjZSNDYreSsvd3pONDI3VnlxZDNjak9K?=
 =?utf-8?B?NmQ4UVBNTWs0VEJCRUZkSHdWWU1QdVErMGVOT0tSWjJ3eSt2NjZSSFB1Q2hR?=
 =?utf-8?B?ek4rYndacWM1TGUzVFBHUDVqVWJJRTh0aCtzdWZ6OXZkZzhPSHNjc1RzNmo2?=
 =?utf-8?B?b0tCSlhDR0MvbWhwdCszdVlSV3lqWGNPSkxaZ0x2STRTazdjVlE4ak5SNy9z?=
 =?utf-8?B?NysyNjRqSkZKajdneDRJNGx6bjdhM1FNRHFVdEFCUlYzQjZlc1UzVWt4NHlU?=
 =?utf-8?B?K1BCNEJoUVdIS3g2dnBRTjlBaSs5cGFFNUZzM1J5SDNDUlVnRmFSeFh1VnJT?=
 =?utf-8?B?WnAxbTFDcHdyb1ZyUmFyUWwyOHdNa1Y1TFd2enRadi9MeG5QZEREZktNTFBE?=
 =?utf-8?B?OEZ0V2d2NVREY1Fvb0hTbTRKUFBkekR1T2Zod05XUEhhVWxjaVJuSHNibnZo?=
 =?utf-8?B?MEwvWEN1Rmt4L0xNMmpsM3ladktyUzNtT3U2WmVnMVg3RkpOU2kwbGJCVVoy?=
 =?utf-8?B?eURuMllEWDgxSkZ2RjAwU1djVzZSMzJvMVlBRUF0OG83N1VyNVJyeVNpb0ZX?=
 =?utf-8?B?bmZlUWt3R3NQYlFhN2pjaERYdU5MOGxiYmdLTFNtQWlQY0thbHAyVzIxdlEw?=
 =?utf-8?B?dkliUkY5RGRBd0N3VGhvcHJ4aU1yendxa1VBSEhzUUFqc3lnYldTd1VZR2J5?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc1f2ce-fd15-4a9c-93b5-08daced3450a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 10:53:21.9026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67FY6DtF4f3EQKBb6MW1F1RfAaruYtp4VamUlLXn8Eflww5ulxm51FYR6hvYMw7yxrhL30/XCPOwg7n1b7Z/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7007

On 25.11.22 10:08, Florian Bezdeka wrote:
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Hi all,
> 
> I need this patch to get the Hikey board (part of the Xenomai CI lab) up
> and running. The problem appeared when updating the test images from
> Debian 11 to Debian 12 and with that from gcc 10 to gcc 12.
> 
> My understanding is:
>  - During boot a UART hangup occurs, so we release the IRQ
>  - While that happens there is still on IRQ in flight on a different CPU
>  - The in-flight IRQ is detected as spurious interrupt
>  - We try to report that using printk()
> 
> printk() internally calls ipipe_unstall_root() - by using one of the 
> _irqrestore() macros/functions - which unconditionally calls 
> hard_local_irq_enable() so HW IRQs are enabled now.
> 
> I end up in an IRQ stack overflow.
> 
> I assume this happens because the UART IRQ is a level-triggered IRQ. So
> it simply fires again.
> 
> Does that make sense?
> 
> How to fix that properly? Ideas welcome...
> 
> The problem can be reproduced on the hikey board quite well. Nearly
> every boot ends up in the IRQ stack overflow.
> 
> Best regards,
> Florian
>  
> 
>  kernel/ipipe/core.c | 2 +-
>  kernel/irq/handle.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/ipipe/core.c b/kernel/ipipe/core.c
> index d12e71103424..17ad6f2841f9 100644
> --- a/kernel/ipipe/core.c
> +++ b/kernel/ipipe/core.c
> @@ -1491,7 +1491,7 @@ void __ipipe_dispatch_irq(unsigned int irq, int flags) /* hw interrupts off */
>  
>  #ifdef CONFIG_IPIPE_DEBUG
>  	if (irq >= IPIPE_NR_IRQS) {
> -		pr_err("I-pipe: spurious interrupt %u\n", irq);
> +		//pr_err("I-pipe: spurious interrupt %u\n", irq);
>  		return;
>  	}
>  #endif
> diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
> index e2f7afcb1ae6..1c3221c72977 100644
> --- a/kernel/irq/handle.c
> +++ b/kernel/irq/handle.c
> @@ -32,7 +32,7 @@ void handle_bad_irq(struct irq_desc *desc)
>  {
>  	unsigned int irq = irq_desc_get_irq(desc);
>  
> -	print_irq_desc(irq, desc);
> +	//print_irq_desc(irq, desc);
>  	kstat_incr_irqs_this_cpu(desc);
>  	ack_bad_irq(irq);
>  }

Is this issue 4.19-specific, resolved in 5.4? Or in dovetail?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

