Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE07441D
	for <xenomai@lists.linux.dev>; Wed, 26 Jul 2023 05:21:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmqela3Q6AXCKxqgtKXJYRFLkuHjy8ogTy2Tml62UU5DRj0gDWPvLxJkulynDOpRy+tu8lKUPpq3n4V5ufyVEmqae6VJeWGOuvrOcsp47VefTQyquhN8dvGjMEkEpMXIS5/FpEg5Fs7AE3VjioK/cOzRx95nhy7QtARmNepQzF5EhR7HBRHPodrPlPVgl3MKMSv7oD0uIajRlN+lsRijYUwE1E2oZy4XGIE56NhOLTMl9BhTG5VuSpwDyUAAFzmzs7z+Y1uPVDHZpUNQ0MO3QH64bGrC9O9mbRcHFZEZrfG3AKzzR3YxZHXPJr3VSPLU6PrRSVJziG59Ex/CBj81yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KATyjCTUuRI9hACO//adv4yLpLa11xtJqn8HRWo+4og=;
 b=n9L5qjswqpgNbCdOQfAzWwVEtvzkG6YOCWlXwmrO4jZKwff8O/8+eJAwP6rW3yaF8m4/ftjMPnYPvc0LH8SmjmVAfoDYS5Dd45Wr74hVSJeiO2hZT1OGahnA9ILPT/zBgP20RrBmONfeTkpgb9gYG74smggqnVF9XV9YpC770ehPis5q3zzQVlHISCVppwLoY+RDJoF2zRGXuJfc93tLnUc5cKZrToDpb4O/rTaTt37kIROfayejwvadNgBZDe3kT+wv1Zn/k4IMWxzdDUdPoCyDPXUiu2h4Qos0uWHiKIViae0QtbzSB3IABLnz4gUkYCj/MNCTO5NjF+S60+lqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KATyjCTUuRI9hACO//adv4yLpLa11xtJqn8HRWo+4og=;
 b=q6hnuIbxPlyX/IbLxOYcBtwKT/gX6HWeEWdEVnsKVr59t9HsAQj2G71GVX3fDfRqf9XSs83iB9Fso8pb53nYP8ntaIvKiNIPyicj5TY8YzGqtGAEDDAYy9yG7zI8w9NAi+2dKk4JYWPGKKYBt2s371J7CsngzTolEtExGpgjD2grehdjwJH2emcogpzCDCFneIXqHnoGrPO67D0zH6R5qoq/w4JiWndw3iyVQd5OPTaIW4G5MxW5vzLiHr4PPESxcGsbonTIkHn3YZOyzUQeF7kMo3zuidMCAadbucYp1oRa2EdG3VvhYCrrIhojnthwfBkcWtbtQ/oNi9b8uO/+Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:571::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 05:21:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bd20:71c1:832f:f633%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 05:21:54 +0000
Message-ID: <f35c03f8-29b7-8e52-282b-02eaa92f27a3@siemens.com>
Date: Wed, 26 Jul 2023 07:21:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [xenomai-images][PATCH 2/2] customizations: Install
 systemd-resolved as DNS resolver
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230724074035.81965-1-florian.bezdeka@siemens.com>
 <20230724074035.81965-2-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230724074035.81965-2-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c58193-295b-486b-1ce3-08db8d98390e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AmC+z96CUGfSyEGv02vR92c05iAOkkyAKvvLK6CRX+d3tcMdm+uWNEkovkMrp0YABC1iTj+pbj87Kz9kznUwK7gzjQXWgLZzDaW+5LQh2fBKZpBD6jyTp0uebBvz4k9zEIGFow8QT/BoMbpIUGujSa3EgoTKs2OrVVjWObwlFX5qnYl3AYXdgmnzY/RlqbOZ2sETSC7z0JlJI2uKZR7aJ2DrdQd8K6Y4WKQcRcOnBl9VSrj2erKdNlZHxR7zHk3wjYPVzSynfcXnACiGRxTgZIBBEoO5orHy2VRRt71qFgkhU4j/ODbN/LQCoP7U4tSEwifHZtsvSg1zMCuRFVQRPE2a45hOLROgYgr7O+gfezPmmbponMgzhLtHBfGunWifwKeynsD76JfyoXdDLVWBYuJCLEEGumqq/KUg1872eAMSbOMOH+4GrTnfDZ3AdAPO6CNAVuqPhD3iQBv/HlubrY2ddDyJdTFQ+OKYSmxyAfA82IViG4XTHdFDYALn82h2w7rDiIJq7ehVUuxaoBAfvansRPT4p3yJbOUMOAUnJb9hXHrL5/uHXcTvXN14A/OTKW5ZsnZ5Mrw0L3RkbkNokyS4hYFatUunp/7WxjjdkHQHnhyFDVNh7jxABM1OvfCB/9Nq4enYYoC9MGMk7UAclw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199021)(316002)(53546011)(6506007)(26005)(8676002)(8936002)(41300700001)(82960400001)(478600001)(66946007)(66556008)(66476007)(6512007)(6666004)(6486002)(38100700002)(36756003)(4744005)(2616005)(2906002)(86362001)(83380400001)(31686004)(31696002)(186003)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnZjRWdnczF3NzVRc2FnTlNjV2NIMzIzSEtUMklnaDlST2NUUTVoVTFoQUlQ?=
 =?utf-8?B?RS94T0JmR0UwQW5BOTZIZWNuMW9oNHNETHYrMUpmRW4wNG1CMkg2Sk5EOVc4?=
 =?utf-8?B?WHhVS1NNOUUrbUU3QW1nTkJIVVlFWkI3Yzd6VVUyZHI5eE5pL05mdTFmSHRK?=
 =?utf-8?B?SUlTd2RoVXZjT2s1Vm5meGl4a05lRHJ5eStPa053M0Z3bng2WWY4Sks0dDQ0?=
 =?utf-8?B?emM3d0Uxd0hYQkY0RnFDRlgwUjMrSklKTkRXL1hYRER3S0ZZUlRscGZjaXlM?=
 =?utf-8?B?R3M0c2ZNZXZuUUU2ZE42OVMzekRuWXpkbFNFVnlpZS9pTHcwTEVrbHdQNXJQ?=
 =?utf-8?B?VzZNRUJ6SHFVaDJXZDluc0VhNVMxZStyMXBVSURCV0twZnFaaXhVazhFd1g3?=
 =?utf-8?B?VHkrd3BnNlF0d3pVcVMvemJLeVZ0aUppWGZ5aVFicDE1a3JSVkJGK081SmU4?=
 =?utf-8?B?Sk5GNVQrd3hhUTlDcms2RWhFaXJFeGRXRnExMXlxNElicHJOV2dKbHEreDVW?=
 =?utf-8?B?YzN0UGNMOWVOMWVjRHlwbU1MTnlINU5oU2lFNXY2c1Bja2RaYVFONVpYb2lD?=
 =?utf-8?B?aW1RdmdjQmxEcU5wcy9ENkd4cW9SYW5uNk80a2piZXNXRUI0Mi9oU2Y1SXgw?=
 =?utf-8?B?VS9KV01tNC9TQ2Z2L2RVSWRXL2s2STN1UlVYa1lyMWNYMFZKOHI2MzFkS2Jy?=
 =?utf-8?B?ZVl0OHZBeGptcEtGN3BIbmlqbHYzQmxzQktWNXNwazF0Mjlacm56bW01LzJW?=
 =?utf-8?B?OTg5VVlxQlFmKzd1Yk0wU1pJT2REc1lFVU04M3JsaXVubFNYYjN2Y0pjUnpI?=
 =?utf-8?B?UkNIWndiMXFUVmJZNlFRQnpmajI2QVNBR3FOalA0MFBUYSs2d2tvSWYwZFJ2?=
 =?utf-8?B?NjZVRkR1NlpvWTVLalZ6a0JiUk9lRjU4RGdPMElhV3BTa2NBdmFZcDVZRGJu?=
 =?utf-8?B?SGo1RzAvSmEvYWFHZ05rQng4ZG4zanlzRW5UKzU4MFMyVDVjRHVjT09DTHlY?=
 =?utf-8?B?c2VJNmFxVXFDWG1XWWRkY3dZcStqWEhGejgvbk9uTmZ1NC9YK1ZsbG5qY1BO?=
 =?utf-8?B?aURKMTMwWDR1a29QU0Z4QWtDcGNQaUZoa1JSNzlsTUNyZHNNYldxL2hrdzRR?=
 =?utf-8?B?cWUzVGY3Mk1XY0p0Q1gzRURQMk5mY0pPYjdxRFZVam9DZDgvVWpDRmFBc1NW?=
 =?utf-8?B?bzZNak0yaEtZaGFaSExuczloOUhzSDM3N1UvSE40cHVkYm9NQVRYTTVNQVBG?=
 =?utf-8?B?a1YwdHBDeXZxdnVTMGFCYndCTUF6TnF2bExmZEM0bTJtSk1jVmxKVktDZkM2?=
 =?utf-8?B?WnFBNXFUUW9pUXBXQ0d5ckt4TGpyUUo1SzNjYm0rTnllSW0ydWQwNkl5RFhQ?=
 =?utf-8?B?Z3RZd25tVzNvTjg4SThVOFREelB1K3RYNDEzT0IvblkzaXEyLzFwL3BIMXRt?=
 =?utf-8?B?dmZHbTkrNzhjVEppQmgraEc0SG9RTzkrcWNUeldqVTZXVUdWOVFRK2tyRHFk?=
 =?utf-8?B?NGtwYzBmYml2d1ZzV0cwcUdLMjJpQ2ZzclpLQ2JxNTl1bkgxUGtqQjN1TUVi?=
 =?utf-8?B?ZWRHeU9yMGdwSDB4dGswS3M0R3lRY0R4M3RtUXQ1dzU4RFBRM242TUZpY2pX?=
 =?utf-8?B?TFdvdVg3WVVRdWZIVjVzMkdCOWF6MjJBc0VhS2RaaHFEb2lzSStxUEJ0dGhI?=
 =?utf-8?B?bFAxa2dYWkVPaEp1bmJVaEF5c3F6a2RXbnBVVFE5QzlxNEJ2ZVJUVlp1NWRH?=
 =?utf-8?B?MGhQS3JpQmFuTHM5TXRrTzhwT042bTBTd2FYQnVjSFI4dHVpNXhGeUw2LzVS?=
 =?utf-8?B?dVFBbEhjM0RseVJxZndqdk50QkMzM0ZleDE1REIyS0NMc2hDSXZxakpEQUtV?=
 =?utf-8?B?Smc4ODhVKzVSVTJlSGVaTU9ESHY4Z0tYVUdtU1lBMm1lcGUvNTZ3eURSOFVU?=
 =?utf-8?B?Z3hUa3Q0c2JPK292V0xOOE5zc0FxWk5EOFpFeFVZR1JlQWl0WW81NjlteStV?=
 =?utf-8?B?blFzejgxTnpiZHpjU3NpTVFtWENZY0NJNllMWXpRWWY3L2ZhUVhQaHJZeWFt?=
 =?utf-8?B?NWF5aElhaVlBUCtKVm9KRXhSYTR3R3dDNStqV3BOWVdIZXhBSHhjUjQ3eFJ0?=
 =?utf-8?B?Y2RKVVR2eVpmdk1vdFc0SmMrMnNEeVdIc1hLZ0JaSEs4VXhlVEJ6bGlKeHVl?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c58193-295b-486b-1ce3-08db8d98390e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 05:21:54.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SfCaRJGEP7pBdkxz3oXMz6RyznHxES7uLy1L/t/b/Bv+6sTe12/Ai6DyMgajTMc1SbpR1Fjp2WYsXqv75Al3zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6080

On 24.07.23 09:40, Florian Bezdeka wrote:
> The DHCP part of our network configuration was working but DNS was
> unusable due to missing systemd-resolved.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  recipes-core/customizations/customizations.bb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
> index f86bf68..fb79a8f 100644
> --- a/recipes-core/customizations/customizations.bb
> +++ b/recipes-core/customizations/customizations.bb
> @@ -18,7 +18,7 @@ SRC_URI = " \
>      file://primary.network \
>      file://99-silent-printk.conf"
>  
> -DEBIAN_DEPENDS = "openssh-server"
> +DEBIAN_DEPENDS = "openssh-server, systemd-resolved"
>  
>  do_install() {
>  	install -d ${D}/etc/systemd/network

Thanks, folded into the original systemd-network conversion commit.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

