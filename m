Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47120E1
	for <xenomai@lists.linux.dev>; Mon,  3 Apr 2023 08:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK/GciH9xTGIQDuehUNBa4Vaz+DwMTY2NDleR8xnP8ylAgtL7UDAUPa/hXBzoHfDnqByx50QdyjtuaFDrrDdHaN2YlZutcD64n+RhHkQR/C/JopymewNP0NCJdj0oR59HVIfmJgm+pV7bmwTSk4FRNMrDoKdRvQv6VTJbtQhk/kOUiFOyUeSQUNQyp8G3WQAfPUDfoE2EtTPd/AiQCvl7Ys8fq5CztSItTkGknuSa8Z9U1+pr1RJxG4ucPCJerwLrNe6zWIV484V3qadXzdX3KiQB43uaaUjA807wkFB8ppoZ3oJBemqmI6sgEtZ4iqDju79ZGQwvEUA+xBLPmY1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGvdLqt/1uffD0vWb8TSPbsndLP36gBCqoztc3+4x8Q=;
 b=J4JnXYxZ5Bro/kFe+qsAfvarrqCLC9e+8AgfkZya5mZKxvBkjjaQ2M58HFAjs+XXFwi/o1O+ZgnxiDXF5M3NrrMRglMubTh3cYoz+lyRTRhaed3rUDswJJziBg/u92bEE0aETm4eDpi+/WBoKkcgnUK3FCHLhCBddDfVE77ETfWzo86akTKunx2w70Zk9Vd0Ydp8Qwy8jsDKrX0IJ+6Hqb+kayfEUnSdYkV/gMA2NQhj1+DwNMJvnN4ZK2U9rT4sbi3VetI+yRA8p0S0UtkWLwRXGWeutPG40TygblpVAxAskjU/5hTc8V6BHZg8ZUGWvLK6y1T+BfQImuuFc5E0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGvdLqt/1uffD0vWb8TSPbsndLP36gBCqoztc3+4x8Q=;
 b=gVlhKGKdLXHCEbSDBrCqwBh18Fq2Rnj+w14NFI92Ovxnt5S4gIUy7ywgbXlszgG6wJ/Dh65j2/TzsE85ZKhp8R3whXJp0mZTPqVjv0dEHo4y+IAxYTqYeS/dpFTZJKiYjoUvpSh5FsOR5yP30AdHQ3zQW95zK6i0KqyoDoOj6wRLw1cHZRP9VGv0ynyWqeDmOZkQcCZ5ZkdnQPQyWMqe9gwxyKUUJ8aaklKCamDkJdx7JTHDvFc5Cf3pFlDCR9dsNaQrnG/0/nLGEWExne5ntsHbnxIUsbRjfMcYp4eTMwWdPtr7OJkusdXlemhn5m/AKXRBWL2fv9a4ryyxVNIeaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7323.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:605::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.16; Mon, 3 Apr
 2023 08:06:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Mon, 3 Apr 2023
 08:06:39 +0000
Message-ID: <f3720ae0-fea9-3b16-ff12-8780cf63f95a@siemens.com>
Date: Mon, 3 Apr 2023 10:06:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] Fix flexcan interrupt request not working on non SMP
 systems
Content-Language: en-US
To: Julien Blanc <julien.blanc@sprinte.eu>,
 "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <2739dd577fde7853b94b9d062033a3f8324ec1b7.camel@sprinte.eu>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <2739dd577fde7853b94b9d062033a3f8324ec1b7.camel@sprinte.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 473c8c0e-5b8f-404e-bca7-08db341a5a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W5R2Za3ZhnGC+37pvRtu26UkjhxPKdeZxLJh0jb03AJwypWgRd9/1dPbgF1ExSQPTFBKJ4R3Z4z2DtBG55YxAItswHTlhNq+j3+Ev4gM13zERXjyWNIG+JkY1gUxSBj3d1NtCMJKIaIxCuf8hOih+B5cQ02slN1kxi8VJ4tQ5HZELFni9RRZ3KzKd7It7GiSQPko5dmNFTXQvG7u2omDwp0tLWfI+tJgtTzzoc+iMKyUdkEz6pFWr6KpgFwFieBDf+0iHsnSZKLGc/m6a7DGMm7F/4C46F1Pk/MP3x3edzVWEneuviYmkIFeyhyXdB4aRXiC3B3G/znQk1cgNdoMGFFF2839PHwu42HXAHWY3YUNgZUe4q6CrWMe5aQnoh3pY1laypo/c/zuNvf6/tO3I/LVfk0bElcy96p4xcNe8Frn/VDVZcngOqjJuigvhAi8E1gR/pl/I3K0ELK4rEAsfa20HV5offdYcdGo4Z2so59+7QjM2Y+r9zqst0xvlthhJ7pTipbvqoUf1Nn9YaaeUVAXGvNDapz+9uw0RTu0XzRVacz3XGmYO1KHpFWossjSF7Ke/Y9kMSlVLgRjGiPrWwkNVIZfP8G/JMbm4SLyEZPP79AHWIfLVdoH5O1QrSQzrpoLz5UUbQXo1+BODp9w9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(5660300002)(6486002)(41300700001)(83380400001)(31696002)(8936002)(86362001)(2616005)(6506007)(6512007)(82960400001)(66556008)(66946007)(26005)(38100700002)(8676002)(66476007)(36756003)(53546011)(44832011)(6666004)(110136005)(316002)(2906002)(31686004)(186003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2NDWEVIVE1nbzZSYVI1dldhMGtCOFY3aTFBNEVnZS9HcGdZcE1SSzI2eENy?=
 =?utf-8?B?UDhEbVFpK0hwVk1pTjUrS1E5ZGdjcmVWa1E4YlhtMThhQ09EdTdaOFVuVlkx?=
 =?utf-8?B?SVNnc2tOL2NzcXZtT3gxUUFvZGM0RjVFRGc2NmhNQ1drQ2Z6VEZmK1ArWEJV?=
 =?utf-8?B?SW03Q21aMjdmWjdqbUVKSjROaXNPMmc4YnhMWFcvQ1VSa0NOQ3c0TGZpTjhp?=
 =?utf-8?B?QnBTa1MyWFR1ckk1dFJlQVF4cVhhYVhHRkI2a21UelI0QWgzY1hxRlJjOGdB?=
 =?utf-8?B?am5uK09velhlMjlEOCtBRU5LS0FwU040R2NwTjhIeCt2QjQrSkNrbDVadEJD?=
 =?utf-8?B?MTNDWkJrcVZkUjZ0clVuZUFENTh4RkdtSjhuVHJERzF0YmEwRXBWYWdKRjE3?=
 =?utf-8?B?RnpXTFU5RzM5dU8wcEZRcE54ZUxrUG5QVVZoRVhLRWthL2RTNUVhcGpRRGN4?=
 =?utf-8?B?L3RWVDYrU1JxMGNIYy9jdllpdDc0cEVmb0lmeDkvV01zMGxuRXEveUxLT05O?=
 =?utf-8?B?ZDdZR25USWYwRXZMN1FNZDJWWWpEYVp1VlhVR3lvZ294S2NQV3BiZEl0UnZF?=
 =?utf-8?B?SUVPQm0wVUJUYm80ZEc0Wis5WmFxdGdXSE5OYXNSTnVrMmdWWDM1aTRubkRn?=
 =?utf-8?B?MmxJWmRzTllDc1N2bnBOVE1LYXU5YXVrU0lDVWtLc3pyLzNSbWJ3aWhvV1dm?=
 =?utf-8?B?eWVHK0hrb3krM3VaTVZaTWljWWt4RWNySFQwVGdGOEg5Mll3enp4Vzk2MHR4?=
 =?utf-8?B?TFlOelI2Q0xtMFVIZkNZcmNjNVB6R1FnTjAxNUx5UmFLNTE4ZzVpSkVuOUU0?=
 =?utf-8?B?dTk0NWdBeTlMWEVJR1gxaFlwRkMzY1FIMng4TmdUUEc5a2p6OE13WDJXRXA5?=
 =?utf-8?B?bm9KL3ZOV0hXQmhHWjVpY09GbXEveUp4U3FjNEZQbDMxbVI0U3NMcHpzd0dR?=
 =?utf-8?B?ekZ6UzVjTytvU1ZyTjlQazY3eVdEMVFVNXRHR3czbU9QMWhkQUFkUDczaWZY?=
 =?utf-8?B?c0FmcXB6bnBjdnEwUDJ2WUN1eEdUWEhPY1E2Zlc1aDdYa1Rrc0tUN29jSHJx?=
 =?utf-8?B?cGEyU0FORjh2VE5sUFJhZmpLZ3VYMHNXZ1k3QU5wOWhJZ3BkRm9XazJkZERx?=
 =?utf-8?B?QmxvbENOSWtSajRkVXpaZWxIeXJucjhPMnBRemJqVlVZb1J1TEN6aWo4K3h0?=
 =?utf-8?B?TG5ZQXF1TnRJWEt2OU1IcGF4OThlYzR6WnNmN1VpTndzRWRIbkJkeHNjM01E?=
 =?utf-8?B?K05BZ2pxQktibHZpbkpLRlRhVUlON0VrTktBWVRqaE5nM3J1NU82b3VKRTlv?=
 =?utf-8?B?MVVwT1hDeEtKczdyaGhpR0cwaE5DUmhDVy9BZnBJSUs5YzJvMExNcGtaSHVH?=
 =?utf-8?B?ZmNQQ0hKeUlua3Bhb1RVby9DMGFzbWxCSnp3MHl1RndLTkhkZ1B0SHFuc2VS?=
 =?utf-8?B?VTFhZWRPK09tTFFkVm9FeTg2elhXTTNkUzNrUmM3aTFOUFV6cWZNbHdvd2xT?=
 =?utf-8?B?Vi95QnJaWGJSbjFaUkFXTTF2QkdndWxMZTArM0ZNNHNlZEJFcm45RkJFUVRi?=
 =?utf-8?B?b1RTK3F0N1FTaVU1S2c0MzhRY0FXQk05KzI4NUV6NHR4dWNucDFBSkZlclV1?=
 =?utf-8?B?WVJhWjJzN09LN09GZkJlOGJTUzlqK0E1UmRJejA0SmllMUdnc2djbThzVnZj?=
 =?utf-8?B?K0F1ZTZjdk1SeVM3K0lXYVhqb3pTKzVBSmRySDJSbmR2Yzh0Tk9HUzVwdk5O?=
 =?utf-8?B?bXZSUDE0VFdUQnR4RFFjamwvZlBuUUE0WGE2L0Y4NFVsR3RRWXBYRGNJVE03?=
 =?utf-8?B?ZDB3T3hFZElCSXc2TW9tOVNKQ0t3cVA5eUYvZjEydVkxTG9OQTdmMUNSTWIw?=
 =?utf-8?B?ZnVudzR1bVNtWTZ3Q0VUaEt4aWpzS2xoTDVJWFdNekQ4M0xyOW40MmFCTjRG?=
 =?utf-8?B?RnkwWG9HeW5RdmNRNTJUTUZMaWI2MDEwSng2bG0rRXJRbHVYYVNzYUxGalJr?=
 =?utf-8?B?dTVHT0ZUVEt6ajZjNldEMytET1lpR0E2WG1wNlZDY1lsc1NlTGpudXdudkRQ?=
 =?utf-8?B?cm5zL2NTSW8rL2hWQmcvRnF4b295a0trc2xnMVBkT3BCODIwaEpaNng3TW5R?=
 =?utf-8?B?UnVnUmRJemh0d3Y3dzhaV1JMVkEwTGtKTDYzMnpBazhCN1owVllTSjJKakhq?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 473c8c0e-5b8f-404e-bca7-08db341a5a4e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 08:06:39.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gaH8LViZSBQfjYed/IK6TyYdJhT/RmceRlvH+YkK8FekGwNhA66JKn30/jHgVetwsj4ZI5+qEt4Hv9Dni6r/UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7323

On 03.04.23 10:06, Julien Blanc wrote:
> irq_set_affinity_hint returns -EINVAL on non-SMP systems. On such
> systems, setting the irq affinity is non-sense, so just remote the
> call in xnintr_attach if CONFIG_SMP is not defined
> 
> Signed-off-by: Julien Blanc <julien.blanc@sprinte.eu>
> ---
>  kernel/cobalt/dovetail/intr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/cobalt/dovetail/intr.c b/kernel/cobalt/dovetail/intr.c
> index a9459b7a8..88116c7c8 100644
> --- a/kernel/cobalt/dovetail/intr.c
> +++ b/kernel/cobalt/dovetail/intr.c
> @@ -100,9 +100,11 @@ int xnintr_attach(struct xnintr *intr, void *cookie, const cpumask_t *cpumask)
>  		if (cpumask_empty(effective_mask))
>  			return -EINVAL;
>  	}
> +#ifdef CONFIG_SMP
>  	ret = irq_set_affinity_hint(intr->irq, effective_mask);
>  	if (ret)
>  		return ret;
> +#endif
>  
>  	return request_irq(intr->irq, xnintr_irq_handler, IRQF_OOB,
>  			intr->name, intr);
> @@ -112,7 +114,9 @@ EXPORT_SYMBOL_GPL(xnintr_attach);
>  void xnintr_detach(struct xnintr *intr)
>  {
>  	secondary_mode_only();
> +#ifdef CONFIG_SMP
>  	irq_set_affinity_hint(intr->irq, NULL);
> +#endif
>  	free_irq(intr->irq, intr);
>  }
>  EXPORT_SYMBOL_GPL(xnintr_detach);

Thanks, applied, just massaging the subject line to

"cobalt/intr: Fix interrupt request not working on non SMP systems"

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

