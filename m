Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50050.outbound.protection.outlook.com [40.107.5.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED1410F5
	for <xenomai@lists.linux.dev>; Mon, 15 Aug 2022 06:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObNBm+r4URipzT0e4BT+PXgLlIpHaY3/4gza6j2dznlQiU5IIxUDhHsTfJD2lM+Okbx/skzLmnVG0xlgwmwEHorqOrQub+V8k5Jzu3Jy/+qMKO9swpU2iGtR1WCVgBQuKCwToXhGbRgg0uh+jPTpHY6NPxabKXVn9UzSsPOsogO5l2gWQTEt6HfhoxvcE1FysFhIbCs1GRE2B1zcrbJpFgy7QzfzGWK5qgfR0MDdaZCl7Wr1uPFnRA+kK3Q2Heca0Qh6F+U17iKtXuzK2ZKnYUS1Z6ZBIoM5crZFM/A3Ef/t9hQPbm/MIkZDw446fASKSm/bYHGba+2dn8Gn3FXUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4ZL7bni1T3NWSN/cUerWpvEnS+HcWuNMR6ZGhu4J0w=;
 b=l7u2AtUoapDuOTQakBSQO0GKLB47MSCDYJAM3dL7xJjO2OhEfrcFX/bgLqT3nj4qL14wEIeEGX3Fs0GoAHy7d91Jdcc7KawTtgXbHVm9rfFufS9i+DhHy5tlS0pHqNbw768J76kCAlEGpUxYgQ2tkNslvEaQifc4DW9rY/dY4nHH4wmw2mBpgxDm90QBb3usPoftMr3UhA7KvlAj25tPKgI6FOPq1yj0oTfpomGjx9nGgBy9ZDT8enAMtpzEIY7SdnPS15hg+x/A9VKxtweVBCzMRg12Be4FOiriB2lZWDzkJdomYHFl0DpVTuVpSS+fKwM5aDZrxKPVSSlmtKK0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=philips.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4ZL7bni1T3NWSN/cUerWpvEnS+HcWuNMR6ZGhu4J0w=;
 b=jej2xpWORAjruMOpAUm/qhItNjA88FunZkQ+lnWc2cJvkjq265ctr2YgL8xNHteBa9bMNF3s2zXeXNRiEBUOu5ETLLKySKuKfZaVUfAJBonh3o86t3AcK8r9hyEsIeyCLtXz50ClSM/uDq1b0u0yyv6nu2pF3ODfJDA+lAwha7pnnwLAtmALhdJ3ObfowDQYEJo5P6wDQDYps6uXdmb7A4LZD87Kk1exTrZW4PIxaGjK+CAElm8jN9G+bcXBcMjDWgeyjl3nUTTFeCD4A9UGVLyJe4QRh8Y89F6s9CKnR5b7BVJqGOcD5bJv4FNISUm44xPMePZDNpLs3ya+QxPVsg==
Received: from AS8P250CA0004.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::9)
 by AM7PR10MB3811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:175::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 06:19:33 +0000
Received: from VE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:330:cafe::da) by AS8P250CA0004.outlook.office365.com
 (2603:10a6:20b:330::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 15 Aug 2022 06:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT053.mail.protection.outlook.com (10.152.3.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 06:19:33 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 15 Aug 2022 08:19:31 +0200
Received: from [167.87.45.91] (167.87.45.91) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Mon, 15 Aug
 2022 08:19:31 +0200
Message-ID: <86ca964e-62d8-2bc9-80f9-97097f1dedc7@siemens.com>
Date: Mon, 15 Aug 2022 09:19:29 +0300
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] ipipe: Fix ipipe level irq end
Content-Language: en-US
To: "Grau, Gunter" <gunter.grau@philips.com>, "xenomai@lists.linux.dev"
	<xenomai@lists.linux.dev>
References: <94f8dc12-d019-4736-2423-bfacc6b3b0b2@siemens.com>
 <20220217084830.712756-1-gunter.grau@philips.com>
 <dddc8d33-0379-eb0c-f994-264a20bef4e6@siemens.com>
 <CALLqZ8QTq+g7pLx_L68K76ez1XJum8-OkjbC9RJP7tW-VaxdEA@mail.gmail.com>
 <e24f9de7-7170-5c5e-cb8f-07c778b67c21@siemens.com>
 <CALLqZ8THxAWDYMLOCUTKoGjzNt4V-PZtz_hTf2++FLF1QeCytg@mail.gmail.com>
 <AM7P122MB022912B3CD5B49D168974AD7F2649@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <AM7P122MB022912B3CD5B49D168974AD7F2649@AM7P122MB0229.EURP122.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.45.91]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.622600-8.000000
X-TMASE-MatchedRID: jHaaRReu0S85QaOxwNGfvo9bHfxDWoib8lboxuXXyrMkp7iSXiinhEkb
	eKVJE/sJTktVeqGQQrvi0nVT9rWZ+WNw+CBvj5AT25l4a3ju9FF+3MjV7YQcjXYZxYoZm58FsKi
	4EXb8AIpHrX2E2MkfREIjIp4EpSqCfTFHhYwclEGpxN65wSU+kTfa6I248QZMH9HlIp7fUBFLXP
	A26IG0hN9RlPzeVuQQ9VlGBjCDncgrdWdGoKfUyk2D9tvRJHr+SnGtPuNZB5x6bpYuCI/Ut9hQO
	8CvZj/XByKmqDYf1WIf/AI515Wy+QkC2otz3ZOALOAsgxszcM2E6GalAjvSeThk1eHxQ+sgtwAS
	5aedRegb9oq6FrYQ3Ip0zvmLzxGBvyIrut/4j2qSOWrMzZb/64n7DYFw3ayGM71h0SMVl8JOyHF
	6Q7mfS6uPvo9L6iaIYG32ZLukpVN6ipWzVkuu8DN360kR9zHUXHEPHmpuRH05f9Xw/xqKXVkMvW
	Auahr8+gD2vYtOFhgqtq5d3cxkNW3tuIXQKer8QL8AA68DQFr+9YDsM5vvSgBw9cgKeu54cR3qp
	w0DENY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.622600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP:
 11D0ABF329DBF8BFC896205DF0132BC2ECE463AE43CDB7E15FED6BA2D14130CA2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19370fb1-5c63-4333-a29a-08da7e861ec6
X-MS-TrafficTypeDiagnostic: AM7PR10MB3811:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FcvUxtZ+iReqRioe+8LnvxpjN4i0U7Qr4nZj6syrvrHbf3R2ftdSaER+wzu67wkPSrZ37OYknSyan4poPaZGGQTO1LwcB02pZyxHDm0/eRL+AYpM5Oj+pKGVEnd9cVzYJquCmKYW/+UXWWeNJt09/2/GsaLDHIteW89IkqrVE31JPhtFqbijnB2eVJO80yjkzOGHzwc9/iPhgs24zNkP+ZazwHVJSncXvdYP4h+4E2a84etm3SEB3BAwycyw5bkB420kLXnrEg8NluGNfkYr5tMqpQJ2jsCr6Ig3ie/F56TO4ogPfrIZafWf+Vq/QKsz4cy4ruHPcUL82+FPURrWQOynvPB+2Qfos9anRb07NYklnAvBkmhTrnDSFeRtKdtutkimNl1xkHA0o7d+NdzhZFvvNLDt4IOfmqnY0Wt5R/n8CezCGW8yu91FskZUdhwsjGTih10mR/ryLm+X/WzbND21hVhmQBH6uVzapkvzeUUaHQnpDgYBtET94sW02tDTPXxGvRLdwJAaenLURXiK5L4Ortv9J0lhr0K+zf4Z/ugS/I6HwOveGos6TxDiPruUEe+QZHlSN8ZIdx5Otf+IpbE+Tj9tAf5UgRYZUfNDv/JD3SFtI4dKLbSwK2X+r0LdnKyyjTHZXnBnksEOMbN+8Ym1hR3Y2AAnqPt51pzVVdUV9XslzWJ1Hf135D133vgFtNzqL1gHoFtjjtvcZ7eWb3Vv6yWN+kiJZw9vbtsDlsOBFTfa/hYg3iAxWALX6E1lE22Qd8gcVAIDfYG0C9h9NLouPjoqqvjJ8TW2ZNpvhg5ZV5tT0jgykUfyNcSruwuD+bDlkvLiDiHN3eJW3vEawL3BjxzZhtQtu9F8y7iydaUTN+YYfzIeNFJqunuSktCPSeSn6tpVq1rRA/adW/GA8w==
X-Forefront-Antispam-Report:
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(40470700004)(46966006)(81166007)(82310400005)(356005)(26005)(82960400001)(5660300002)(53546011)(40460700003)(478600001)(8936002)(86362001)(83380400001)(41300700001)(40480700001)(8676002)(2906002)(316002)(44832011)(82740400003)(31696002)(31686004)(110136005)(36860700001)(956004)(16576012)(70206006)(47076005)(186003)(16526019)(36756003)(336012)(6706004)(70586007)(2616005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 06:19:33.2929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19370fb1-5c63-4333-a29a-08da7e861ec6
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3811

On 11.08.22 16:05, Grau, Gunter wrote:
> 
> Hi,
> 
> Unfortunately I have to come back to this.
> 
> On Thu, Feb 17, 2022 at 10:12 AM Jan Kiszka <mailto:jan.kiszka@siemens.com> wrote:
> On 17.02.22 15:11, Greg Gallagher wrote:
>>
>>
>> On Thu, Feb 17, 2022 at 4:15 AM Jan Kiszka <mailto:jan.kiszka@siemens.com
>> <mailto:mailto:jan.kiszka@siemens.com>> wrote:
>>
>>     On 17.02.22 09:48, Gunter Grau via Xenomai wrote:
>>     > The following commit in the vanilla kernel introduced
>>     > a check for the cached interrupt mask flag in mask_irq():
>>     >
>>     > bf22ff45bed6 ("genirq: Avoid unnecessary low level irq function
>>     calls")
>>     >
>>     > This means if the flag is not serviced correctly
>>     > the real bit in the hardware interrupt controller may not be
>>     > cleared or set.
>>     > The __ipipe_end_level_irq() function does not follow this rule.
>>     > It unmasks the bit in the hardware without setting the cached flags
>>     > accordingly. So after the first level interrupt is finished the
>>     > mask cache has a wrong state. If now the next interrupt fires,
>>     > the mask_irq() function will not really mask the interrupt in
>>     > the hardware which causes a interrupt storm after reenabeling
>>     > the hard irqs.
>>     > The fix now also updates the shadow flag correctly.
>>     > ---
>>     >  kernel/irq/chip.c | 1 +
>>     >  1 file changed, 1 insertion(+)
>>     >
>>     > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>>     > index 7c03e2931189..ff9a8b3f33db 100644
>>     > --- a/kernel/irq/chip.c
>>     > +++ b/kernel/irq/chip.c
>>     > @@ -988,6 +988,7 @@ void __ipipe_ack_level_irq(struct irq_desc *desc)
>>     >  void __ipipe_end_level_irq(struct irq_desc *desc)
>>     >  {
>>     >         desc->irq_data.chip->irq_unmask(&desc->irq_data);
>>     > +       irq_state_clr_masked(desc);
>>     >  }
>>     >
>>     >  void __ipipe_ack_fasteoi_irq(struct irq_desc *desc)
>>     > --
>>     > 2.25.1
>>     >
> 
> We discovered some situations (with iio drivers) where this fix seem not to work.
> Obviously in the moment where the irq is unmasked, the new interrupt seems to fire again and the irq_ack() code of the new interrupt runs before the irq_stats_clr_masked() is called.
> When I wrote the patch I thought the irqs are disabled at this moment. Looks like this is not the case. At least when I change the order to:
> 
> irq_state_clr_masked(desc);
> desc->irq_data.chip->irq_unmask(&desc->irq_data);
> 
> My use case works again.
> Now I am unsure if the above reordering is the correct solution or maybe just calling unmask_irq(); which was the first proposal is better?
> We dropped unmask_irq() proposal because it does additionally some locking, but maybe this is needed. I am unsure.
> 
> Do you have some advice?

I didn't wrap my head fully around this again yet, but if you can't
ensure a correct, race-free behavior by ordering, you need locking.
Maybe have a look again how dovetail works in this context as it should
have logically the same thing to do.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
