Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4822F1847
	for <xenomai@lists.linux.dev>; Wed, 30 Aug 2023 07:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8Qd5sdPN8A8qlg4s7DXzwXLNRAgh3uej2hzauykXugULp2MS9GIeqz4ywX+NWW3tbEYmmmaV7uiac1eYthB9O+f3c4ZmQ4mubFT8vJYSqSGiK7ZCsrcl3M7TC+8i63QnJwX052BnQJY2+48vWdxKdf5fbla3+Dsixz3RKF8tl9gON9mMTCS/ZaZpI5d6YOQQYBewIroHiR5KNcg3CIR5l8QscqMwju7/TDnvR28yU0m5fI7IDtApwXp+n9hwhWp6F+80ZyiUWUAnEZ14ExnUezdh+jq4JnKBJ+G8TZpZFfwz1AhE2bKtMMloAcCc0xOVFnoQZKz3pXxbe2X5IXl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fU2VIoiZ6qz3jOQcvl6Xig0+lkXkaXbn8eJ/JEvny0E=;
 b=dhiKZz3kHqSwRNQvbc8o4mvvzVdLfcE9V525DzUjz0JyVZHBARswrYB0jD1VjvNU4hthzEOtbO/UeCJlgegPVKFkQCVIXnLzR0xzEMW5s+wysUyWI/p7MLavxOXstmMhliUZ21ojAE+vBi9ZNWIlAqMXun6ES3uv33wDRgxXs6al589HkYcvmJQRS6JtWwA4QARA2+s9S6Fijbz+nmpcsmsLuVmlZ9qdj14+Qs8MKAnmXjcE/Wr+6Ku036lRtddzHfWgUsN8PJ0BwSnsfR+PSjNs/wEhSzpvm9q3TpPe3VIblLjUOxYDNrghAWriC0fcAnvhqr/lSI99m46pUzkHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fU2VIoiZ6qz3jOQcvl6Xig0+lkXkaXbn8eJ/JEvny0E=;
 b=PoMZF+yzxJsFedi+n9insKMUjdKK3k0atscTfOyGNr172JGYGezKxXQBrsZEEBDVUFJaeMQuj/aUITyA6dRGMXawRMnRLK/uYNTBOMKWtEzIfRD9HoSdJUiID7Hphi6MW0C2dyXyVFRADMEWKliDG0GfPUQxiv06B8oPbyAfwTyCIIjai9VSynaD20Hih1JRDYPsG8YDVR1yghLDyY0KUr7k+8miL976RSUB1rT6FJuZ+tE/4m6at/Pg42JUNWSV4R7/KRtItswC8FHFrkz6sJ7DOaZM0OKDZvwXVGhzGrJZ+PD7Ukq9cKLF8a7h+2JYYDL1nZDNVp8mRXqR2erMaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3476.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 07:11:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 07:11:52 +0000
Message-ID: <30b0a905-f652-41e4-babf-030a861c8051@siemens.com>
Date: Wed, 30 Aug 2023 09:11:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: irq storm on sd/mmc card detect gpio interrupt alloced from
 pinctrl device
Content-Language: en-US
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 Philippe Gerum <rpm@xenomai.org>
References: <MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <MN2PR11MB42855A234CF8BF7D17E9E2ECF2E6A@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3476:EE_
X-MS-Office365-Filtering-Correlation-Id: 453dbfba-6364-40de-41f3-08dba92861e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FzQbStwTBSs3+4ZGQP4H1dKlz1CQFyD28HGHL8wY9V7Vm4GvPagpqsfrmIj/wRuSeGteZYrUUukZItfhd8cOSJQFoa7AYqo5rZmcutVkgg1rAaarI1CR9iVEK6v4e2ymPWI4Pi2aLi7R7BFaVwLm+9pN//rugvdO1ncCrNmWC1pNMEPjLaeoGUQ79Wze7uOuCffATr2Sg2ZWa/1CTvxLsabQNtrGO+btKYZiJ1mF3D4Qdua7oKMaQHLcqzJyGQaMUM/mi7Mc0VB1c7KGOpvtx/ncETLJOq9C2its4RbvKU5nev6JZui5nvH+LuTdVQbL7zMI3QE6OprrylJLr340JZC3jQda/mTz7PnergxpVyrs7Kx7LcpJ/cBKBONEOkzQYHCPPZ4BYxA5HRFuXKugnMTC9Y1ie0b2ykNyCQ5RRWDM1BDrPgcY+dfS6CdNNMuB/qOi7jQmJBOIsqckxQyt/PKbzZr3VMvFSsge0KkXvJPjI9MbgD1viWlzSqIwybJaOV+ZAgORLYWWlnB7dHGwPwmnCx10ojVbgjiVxe+prInEsXVmC+JVYuCl81oNiRylV7rlIOcP4XYgr/x6N7D9gSEDy/yZMGhydaywMEA3Rk8KK+pzeopHDls7j6+ZiT3ncwYH4CFrijzZ6Tv9ieOtjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199024)(1800799009)(186009)(31686004)(6486002)(6506007)(6666004)(6512007)(66476007)(36756003)(86362001)(38100700002)(82960400001)(31696002)(478600001)(26005)(83380400001)(53546011)(2906002)(66556008)(5660300002)(8936002)(41300700001)(44832011)(2616005)(110136005)(8676002)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFpwQjJQbWxZOHA3ejlpYjZCNkd4UHdHRTcrUjVFT0NnbkZXNGN6TndUcnlC?=
 =?utf-8?B?ZWt0RCt6cFRGdndGU09BQkhMZGZTQlEyMmVGSmU1akZGQmtCN2RFWE1XRXp3?=
 =?utf-8?B?R0I3TGwvZ1dlOFZHMkxqU3d0dEpURldRbjJUZDNLQzI1NHNhVmtMM1M2V0JR?=
 =?utf-8?B?ZXg4b0VjSEpPQUxsbDRnYUJMYk9yQkxjTklBeUhKTE9BOFRHMnBPa2NvTTNw?=
 =?utf-8?B?T2JoejRUNDJXMkdNS09qVExjc3Nta2NHUVJrZDBna0d1eXdkeTBUY3BTTmM4?=
 =?utf-8?B?cEFhYmxCa2hzUXlDdGp1czJaYmJqaWtQaVdoNGowcTJERGFRcUlBaFMzQ1FW?=
 =?utf-8?B?S1FnVThqdHc4V2t6QndyZkFhNlJlMDliMG1ya2lPSVVpZ3Y2VlQxQ1FUUnRu?=
 =?utf-8?B?R3BxMENzdC9ZYjBhVnE2RXg3ZWFZdVc1MS85emFmbFJxZUs3MnZscnlHUlk2?=
 =?utf-8?B?d2htenI0em9jdjkrQ0lXZnhFaWUvMkVwVjZHaVlSeWZkYlp3b1N2UzNkdWxr?=
 =?utf-8?B?Q0E3NGNRU0ZOeFN1SDBxd3JnaXdGMGpudzNPU0dEd2xjczEyUWtZUE5oWmgx?=
 =?utf-8?B?OE0rOHZoQ2hzQlZiWXc0NGhuRVBMUkJmdEZlbnh1U1Y2eWRycVUrN3krZzl1?=
 =?utf-8?B?M2FmeGE5YkN6VEkxbFQrV1lscStybkNrN0VCZzJONDBZbE9lRWRzR3Y2c2Ix?=
 =?utf-8?B?Q2xNUzMydGh5MW5VbzlVazJCUWoxVHg3MFBEWTQ5QlFVRGxuam9vQU15eUZ2?=
 =?utf-8?B?OEZVcnViZnJVS1FUUVZwWWhRTHVBaDcvR2Z4WmZHeUpaRWw4UElRQnlsWWtk?=
 =?utf-8?B?ZG5qcTdqanRZVzBMVUxhMTY1aXNreFJjYllmc0IrWFFJbWhiT2NTY3h4amFo?=
 =?utf-8?B?V2kzZnBqM2wrZEtERy9FOGNkdWZndDBIV0krakNpSEZjTU9HQ25iUjJBZ0Mv?=
 =?utf-8?B?SGUrQ3NEMVR2NFZKWDRNRForNUI2UXJoYTJhMUcya21MdXRZbnpRZmluVVA5?=
 =?utf-8?B?STJIRzBPS0JtOW1RVDZrelZhNGhEaHYrUCt5K3I1WFpiajZSQmtBdHBES3dQ?=
 =?utf-8?B?N2dPNnlsRmpzdytjYzRGNjJ5ZzFIR3BiQVArWVlob2dYWlc2aUZQTndtK1NZ?=
 =?utf-8?B?dElOS1JPV0xWeGtFUDlNbkhrZDdNUGtxSDBuckl1THFMd3hueXV5OEY3VUJm?=
 =?utf-8?B?WWZxVFlGS3ExS285QWgvZi9Cd01oc3hhQXNKSzhwQzdOS0tFdEM5RmoxMExk?=
 =?utf-8?B?amthSU5mbkRKNXFMU3lsY3NOQ3R3aGgrV1FmOWRvRktOMkNUVEMxOGs1bnpY?=
 =?utf-8?B?MTFqd2hRRWtYazBOUEIyUm8yNzQwdnpYWlRLVFB4WFhGR1dkbGduTm10ejZ4?=
 =?utf-8?B?VWRsWjVZVEtSZXJ1UEoyTHp6dFRjbmd2bzJ1MUNTUHFBQUM3OUtvZUs5cmRp?=
 =?utf-8?B?bEdRbzhuSE1NQldncmFmVHFiL1Z5SFZ3NklZYjZqQ3NuREpaalNSQUhUdjJS?=
 =?utf-8?B?d3dMWlFaNzU5bVVFSm9seTQyWVkzWFlXY2RUSllNMTdHalNxbzV4VWQ0VGdv?=
 =?utf-8?B?YVltUGthN3R2Q055NXI0Y1VLeEppZWFkZGo4czR3NUlxd1VabXE1U0lQWllY?=
 =?utf-8?B?dkhkb2tpTjc1NU5Tb3JZTm5HdzRGSERhbGZoSk9WYndQK2E4UXloeG5Fd25h?=
 =?utf-8?B?VEFNUENxTzk0MUg2ZmZVN3RteHhmQ2dISjJ1b21UMk1UYUxsNENDa2ZuREQ4?=
 =?utf-8?B?em5ZNTQ2YnZGQ05YRjdCWVZRVndVSTViTUxjZ0xLajBWaHk2Q2ZXU2llWmEr?=
 =?utf-8?B?Y0swb2JsbU9GelhrcDJYelpIcEcxVkQ0UE1qc2x6N1EzT2NnM3ZoZWdGM0hr?=
 =?utf-8?B?b2hjYS85a1NWY29Qc21YOGdvMXBBZldwbGJVR3hiNm5ZeWVpWFl6a09HZTFG?=
 =?utf-8?B?V05EYXFmYnFUY1N1cEE3V1B6aDR6bUJ4MURxZ3VBRnB3R2lsRGZ2dlQreWU1?=
 =?utf-8?B?TkwrT3RkVkxKdTVFT2ZSRnBFYldLcmtWdE9rVnRuVHU0MEpSZm5RNWlNMk5T?=
 =?utf-8?B?UkxZbDVhMWxzVEZ6NE9uNHlycnFHNnI0V2U2V2djUVh5SmJCd3JRRW4xSmFM?=
 =?utf-8?B?RzRSYUVtQ1NYZWhxcy9LMWxWWFhsd2sraklWR3FwTnZTME1vNW9VOWliK2hD?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453dbfba-6364-40de-41f3-08dba92861e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 07:11:52.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A2Xl6eMh1pJyTlrUErkfKa1A3iAmkj6dzFYg/2NzBndqARqciNdBKwim3Hsix3EzoD7aF705GPor7y/qcyvaRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3476

On 30.08.23 05:05, Chen, Hongzhan wrote:
> Hi Philippe/Jan
> 
> We found there is irq storm issue like [1] on sd/mmc card detect interrupt alloced from 
> pinctrl device with Xenomai 3.2 Dovetail 5.10.*

Is this 5.10-only or also affecting newer dovetail kernels?

> According to our test,  the patch [2] works for such issue in our case. It seems that handle_edge_irq 
> never ack the irq to clear the interrupt status for the Linux gpio interrupt. 
> 
> I am wondering if there is any side-effect for this patch, Please suggest.
> 

Reminds me a bit of Florian's issue, though he was seeing that with 
level-triggered interrupts.

Are those interrupts surely edge-triggered? Just to exclude that we are 
seeing a wrong handling in general.

> Regards
> 
> Hongzhan Chen
> 
> [1]:
> cat /proc/interrupts
>   14:    2440190          0          0          0  IR-IO-APIC   14    -fasteoi   INTC1020:00, INTC1020:01, INTC1020:03, INTC1020:04, INTC1020:05
> 128:    2440190          0          0          0  INTC1020:01  112      0000:00:1a.1 cd
> 
> [2]:
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 6aca6c036ada..4d08eaf076e9 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -869,7 +869,6 @@ void handle_edge_irq(struct irq_desc *desc)
>         kstat_incr_irqs_this_cpu(desc);
> 
>         /* Start handling the irq */
> -       if (!irqs_pipelined())
>                 chip->irq_ack(&desc->irq_data);
> 
> 

Looking at a larger block of this function

	if (start_irq_flow()) {
		desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);

		if (!irq_may_run(desc)) {
			desc->istate |= IRQS_PENDING;
			mask_ack_irq(desc);
			goto out_unlock;
		}

		/*
		 * If its disabled or no action available then mask it
		 * and get out of here.
		 */
		if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
			desc->istate |= IRQS_PENDING;
			mask_ack_irq(desc);
			goto out_unlock;
		}
	}

	if (on_pipeline_entry()) {
		chip->irq_ack(&desc->irq_data);
		desc->istate |= IRQS_EDGE;
		handle_oob_irq(desc);
		goto out_unlock;
	}

	kstat_incr_irqs_this_cpu(desc);

	/* Start handling the irq */
	if (!irqs_pipelined())
		chip->irq_ack(&desc->irq_data);


it is indeed unclear to me why that !irqs_pipelined() check is there.
When we are entering with irqs_pipelined() and !in_pipeline(), neither
start_irq_flow() nor on_pipeline_entry() will takes care of the ack. Who
else will do it instead?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

