Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2A1A70D
	for <xenomai@lists.linux.dev>; Thu,  4 Jan 2024 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="o/P8Blsx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vlup8ZqI1IfQuNF3CzQhM5KHn9PhoU1+PTgSnC5gEa2Led6hW/uSnKyvzc5tJ2ak69HfIRFG1M5fUTod8JPP9rTfuKjJ0G4KtERPzXz+5H9k06Mz76Gdo9GYf5ibcXsymm6rEnqa1CVdSCadImvsI7WWnE5p2XyI2O+xPyTEo+vEwn59rdly/FEx3sGeRCemDsCznEiIJaIbifLXzF2ZIT1FLlXqQzIXw0qTWgh5WL8VlzLYSfX4UL7xbNPh+pMFyQZ+gE1XhnRwH5U6EpucoPOTAldj9EpUNrw24ymSkL2ZULSaKX21c8StMQfiazwct8degsjmzSr47GYAfbbFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtvNEJTPirXPrKb/PJ78dQQw49eYg2cmFOfT0BKFhrE=;
 b=kBMV9tjFbKIuw5K/3QzY4zkSmvcE7YcL1civIcsqoSXjuKpnG2RU/eWW+7Xi+0yMN8sKChiGLCl3cn+kNu8AGj+l+wdpFJaTdGWeSE4wBRtZ5LnzGO7BQmtRowDIiBTdt/akUPtrTvp4BWtnkW0XbX6nyKff9SfAIAuSro71y/JT9puCVzhzXFMsgfCdbGjrhtjUv+mWQtvoxYKFh8gSt4LtltZGHZZ52W5dsiSSX/KXI8W6Q/ghvQvRi3ZkEvQWAzO2VwPpIWlQOcvl9GYAf4qdsJlguca3GMtT6hSmIOhQ1DCOp314ftIpT6vUujM22xK1CV7h5ZPtZtoR+TWlNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtvNEJTPirXPrKb/PJ78dQQw49eYg2cmFOfT0BKFhrE=;
 b=o/P8BlsxuoLw+YvYGoLIUXDkT2lsTTXe+6ZGY+dlv15dHqvxh0uX/ZjBEbTirPn0YsjkecTlRjQ6Bqaz2A4dL50ogrQjx5QGvs1SPab4rfKHN6bBU/Rq9rhkMzt5ESFPqJ5RaRDgBRJ3nhSRgnDLly4afTIcxnhYUjx0QmXdHSZAC8n2Jhs3Y2FWAy42ZnH3JPYYsqMMv+jQ2BrCRCY6A269wzcD2z+wqvEMDciiWgLAls9bNobMtmSaZTzd+B4Ff3O4wmy56102OCNnEKs57NizkhPRduGDsTpCSw2KMJHi8Li6O6RzJTvGEKeMae3SVH1IM3kHycd85duKwFxP5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6371.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Thu, 4 Jan
 2024 05:55:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 05:55:10 +0000
Message-ID: <6c6ae6d1-01b2-4659-9c31-0232c01e0d4e@siemens.com>
Date: Thu, 4 Jan 2024 06:55:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] customizations: Enable systemd-networkd
 on installation
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20240103182839.2512889-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240103182839.2512889-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0434.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 075a4222-0f62-4f10-f83d-08dc0ce9b5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ASjWPEI4psEExFfak7/nEV6WSFBfGWbxzlZtVjj4VfJ2t1aJ11i07aCa+3RT9P5TORQhDaBIFZ0cFz2vr/hM/IQXYSQz0oEi1cfj5CcNArzJdtH+XGD0Sm0Oi2WKw/3RdsmUXaFjjgzsjRfkWrAdo8d4AEZbrfIhIjfZ0nIShFUcB6Tp1mHVO332Pd4Zs5LkMNbN0CBzqA7otthkpKCR7rmwIaT9uqS8b+HneihUK/QRey/q1O6kOvZMZYc/84mlHqtAWwVcpmLMHXux4m1b/AP92wyUOmuZYw7JhpSCXJH6/40yXkLOpewdACtA7gFCJ1rOzJKclRTUTLgDLNGhvC0TrJZNQ+fmpzSOhP2qzDjAZC5FQdUCriAvPet+tMC6DTIcywWkPo/9mNJmwluvOh3B6czazKNuh2+0NzkO4p+hNtGylUbWEseP/YfFwt0jHDD8xC2ZMNefQuRvQDSOqta/ETyIP79qXZzQHPtCFiBuoxu3MFOWk+1OhodA9FNlxmjOxzfz8oAjAHBmJB18tOgNC4eKtoxzJejUqz42OQ+iWVLMs9ym97HP2RRVWShAKXpwpMeZMaHV83EfIHRkxL0SLZOYjHWZXHdFDEDTYvkprg9hX/dwvxNwHDjJVjyKFLHfrYrQMNkqzVl2v1ED2w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(2906002)(8676002)(44832011)(8936002)(316002)(66476007)(478600001)(36756003)(86362001)(5660300002)(6486002)(31696002)(41300700001)(53546011)(6506007)(6666004)(6512007)(82960400001)(26005)(2616005)(38100700002)(66946007)(66556008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azFMbHpFRHVZTU9NZnhNNkhDWVlDeUMwN2IzdkVSNEFzM1A3UEZTVzNyVUp3?=
 =?utf-8?B?cjBheG5mOTdCUXRjRzlPUkRISmVwM3h3aWEzckdyTHhQWVBkRW9ReVlFMnQ4?=
 =?utf-8?B?V1pVaW9sMVpCNm5uVHg2K3grVWpnbWV4NFJDNnRVWHRSbCtIdmpjQ251WUJo?=
 =?utf-8?B?MzdiMEF0dzNsenAvZWFNd2tNZFprYWdpTUFmdWx1YnVFTjJXcUdTekxmRk1G?=
 =?utf-8?B?RWkwcEdweUpyamZCTm9FczNrb0RZSkJISW5VS1h3RGUrZUZnZmM1NlBLZzln?=
 =?utf-8?B?VWZIZDM4d040dVM3U296NFE0SzZXTkp1Z1UrMG9SNHVUNkF0R1gxMVExd0w5?=
 =?utf-8?B?ZUFxaFIvNzl6UmYxc2U4RGJVdXVFV1g0K2QvODU1SE9vaXlJSEhIQWNNbUww?=
 =?utf-8?B?NUZyQUhQQk90NEpzcmp1dTZDT291SXZLZUdOSTdsTk5IclAxRXdXaXZ0cUtY?=
 =?utf-8?B?ZGJKMkk3ZURnVzZXZ1JIQ2ltakUyY3FIN3NpeENhQWhXSEw3UEZ6dDZ3ZnNZ?=
 =?utf-8?B?eVJLcDFsdWg5eEk0YnFtb0kxeWdEeXhpQXQxb1JkVHlOTHhYVlVPV243MzBw?=
 =?utf-8?B?aEJtQmtWaVNTZ3ZiZTdZMGI3c1hlT1hKaVNyT0pWdzU2SzFGQ0xpSndFRWxh?=
 =?utf-8?B?OVZBa1EvMzFRVHJENmN3Rm1CZDM3VFhFRlN5WmlzUTk3L083K1ptYndmL0wx?=
 =?utf-8?B?WEpBRTlLbktmbWcvRVhTV1U2bnFnUlVBcjVhLzZHVEJFVVFURUEvaEtqd0RR?=
 =?utf-8?B?UURGelk5NE5EUnRObnA1UWJVdEVhYk82YWUrclVMTEdGNkdiWUt0NXhXTWNK?=
 =?utf-8?B?TGV5WklWdThsR3JZaVI4dXZJMDhHc004VS90aW43VkhHcWpXOGwwMzJyYjBQ?=
 =?utf-8?B?VUVsbDBBb094WFh1YUlwQlIvQ3oxdGpjK2xNbVlQUGdWa2tIMDZSMm05ZkM1?=
 =?utf-8?B?MXdra0pjVEwyT3hPY245YUVYR1AvT2tDQTVuZE9QRXNCTEtvV0xLQXZYNG80?=
 =?utf-8?B?Uk9CTGszdXJiNEhXY0k1YUNDNURGSUNCSTQwUDZZWUlONWpqeXErZGhoRUdW?=
 =?utf-8?B?YUkwaDVpRjFuSzNjcHNpTmEwWWJaRFV3VkZ2QWlsb2ZSOEVoU0orU3IxWG5K?=
 =?utf-8?B?Z2plNnN2Uy9OaW1DWGNSYUlVWGVIcUY2d1luekMxaVBGRURHdzdUVnZMZERZ?=
 =?utf-8?B?aUlsZENvV0FuUzZadXVsVzVDL1dvTCsxT1pWQ0trSGNJcCtRc2dEV0I4RHpW?=
 =?utf-8?B?M2J0T0I2TlpSWXVnUFV2OHdxVE5LcEhpVTArTFdKUmVsNTFWWk15a1J4NFQ2?=
 =?utf-8?B?TmZ0Z2xqRy85OXRBMC92L2grQUd5bjh5NHZlZG8vV2c2SEk2WUZOeHBrYzAv?=
 =?utf-8?B?T21kdTBDVEdkQ0dGeTFoTTVVK2JDTHM4emE0VmpJNkZPOEdCQjhMOFZsSGNJ?=
 =?utf-8?B?a1lvSk42cloveFhielNJbDdBQkovS3pwQnN3T0wxOW5KdHVpNHpVcE1TYWZL?=
 =?utf-8?B?cWwyeFV6elgxemhjU1BDVkxMM2hnYU91eGpQeHN4MUUxcnkyRjB0N1Z3T2tk?=
 =?utf-8?B?THYwdVNvWDFzM0wxRktXaWVkN0lJaUZBTlA3dmhHSEYyTmdXK0ptQVpnOGRr?=
 =?utf-8?B?L0Y2VEV1UUFIQUlubUNuWHVSc2poRHdTZ1NldHFrWU5BSUxHMlQvcHBZQjU1?=
 =?utf-8?B?dmRITHV0b0NmT0k2b010bG1uYWs4eEx6dHBjT0V0SEhFTXJ6RXo2MEloVDBE?=
 =?utf-8?B?UlF1MmYwYkpHcHRNTlpuZ3ZVRjd1ZXNia01NSUM4djJSaFg5Q0dLWmNzYWxF?=
 =?utf-8?B?c3VXSUhGalZCeXhPT2VOM1BrOWFjSUx1c2FyejZtd3JyQUNOQ0s1NVdSTzRL?=
 =?utf-8?B?TFFIMzY0cXZqdlJZTENBdEtBamxZS0IzMFAyeVNiZmVrOHUydG1XMHNBRXA4?=
 =?utf-8?B?aThmblN4SlBOaHRia2Y2THoxMmJBdWM0eGNkWFdNMFFZaTIvNGJHT3d0ak84?=
 =?utf-8?B?QWhxNjFHMUxRYlRXMm1uREJ5YlVqWUR1ekdOSnhpbnNpdzQrVmFrb1pLRXVN?=
 =?utf-8?B?K3FRYmVzam1aTVQrVk5tTlFaZ2lsYVlBNFRjZG9sem5ZMlFVU2FZTUJ6a2R4?=
 =?utf-8?B?WUdBWkExa0YvQXhUQnZVeXZNVjd6RGQzTmhWZlptcmpoazBKQUR1Y211c3pZ?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075a4222-0f62-4f10-f83d-08dc0ce9b5e7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:55:09.9666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMjzlwaPbLputvo09YJ10aF+NMs66P4TK/9DShV4B2g5LmzNaEOD3Hnb6gFo9tpyk/EAzOluRuoFg2rHr5stPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6371

On 03.01.24 19:28, Florian Bezdeka wrote:
> The network configuration for systemd-networkd was inplace but the
> service itself was never enabled so the (default) interface stayed
> unconfigured after booting up.
> 
> This is a left-over from the Debian 11 => 12 transition. The service was
> previously enabled by default.
> 
> CI does not detect that as the ip=dhcp kernel cmdline argument is being
> used and triggers a kernel based network configuration.
> 
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
>  recipes-core/customizations/files/postinst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst
> index d8d141c..c7c688f 100644
> --- a/recipes-core/customizations/files/postinst
> +++ b/recipes-core/customizations/files/postinst
> @@ -2,7 +2,7 @@
>  #
>  # Jailhouse, a Linux-based partitioning hypervisor
>  #
> -# Copyright (c) Siemens AG, 2018
> +# Copyright (c) Siemens AG, 2018-2024
>  #
>  # Authors:
>  #  Jan Kiszka <jan.kiszka@siemens.com>
> @@ -16,4 +16,5 @@ echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
>  
>  echo "demo" > /etc/hostname
>  
> +/usr/bin/systemctl enable systemd-networkd
>  /usr/bin/systemctl mask systemd-network-generator

Indeed! Thanks, applied.

Jan
-- 
Siemens AG, Technology
Linux Expert Center

