Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301099448
	for <xenomai@lists.linux.dev>; Tue, 12 Sep 2023 17:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3Cph1dOZLQrp0H/VbsmOomPCz9aVF2beMYnwkSnFX+Ag4Vpv9QcamTKUISf9POPD7VeQ7/SB7LWMlfizae5R8bu4UMg7VpT0+CecDVX7B/SjAKMSf5TnZSq61TqT9FlYkwkpNTzSjnr7oigER17l6pb3Vk0QOvLWu8U5IglWA9ITLDfUt41OHBJW3q6XlfyyowrtXyOZsrX60VdqhisRDEOqpwxW6xloBtRZ++0qEGfYILP2kX8e09mh5FapXcdXuMzHYd4gvzG14792cKqUkmpDbVPi4FFxlr47zFTr52vg1wM0SxGVLgwn0O1YgXTl7Q+2tBF4C53HZMbij2cQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AcCwK65JaJsseRjIsD6Jwnt1+YaWBC8yDjG9tSTHSY=;
 b=ZLFzZ5tCW95FEYxLE2yhrQZAZXIhOHr31igxOGJ+SsNxlS5oF8ngYqCNThAsRa0QyPcTAuZvxMBPaOPFl+H1gwDBO2hpwS9x1MYXijCIpW1CtA4R5v6UH8lWcKq3j9LZM5aNdm1sllHSBHqjGoHI2DSlw3MKXQqR5HiCNpdQIx+OtNy2H221e7kAKsKaEIXCX4LKuOrXHqN2kAPREicdOFb7WDXDaLkLOHeiWhxIPLKKpRELm00G6j2qPMxsrAnhdZgv8owBsrWRNQwiYKXvidCqnF7+o+O7E7szuej6pVDVUBma32pEXosFPyOxp4cCaw0QthhkHlYKLKY/AMy66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AcCwK65JaJsseRjIsD6Jwnt1+YaWBC8yDjG9tSTHSY=;
 b=YVoxnKE9Kqo8Kcim5iXpvYNibGH/k5LJ4JnPrVeRC8Tx7FfU+d9F9nzZuAkOfd51mlAyWE/EfRW2+DEo2ael7l9+cRwBVbHLTlzYIilJ5FpuWq3V7/kc/m7lj4PXQvs63wq8rVwYffNKZ6ELKN6fSXXhEaqCK09ptrwpasbEk6heTZHAlCL24/vJ8mXMUvq/7ZDW8BzijRB+KQYqgOs9DuLW1tZ/ZM4NIRkLdc97FU1yJr1xMqr2VKMiZyjHQZ4q0zIb32a2vMpJpTVXgcCG08Zj35YUiTrnuHDuJHJeHg8p15lQXTJljaQk76if2vuPNPd0QRpe2cNTzbMPwe2TSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:337::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 12 Sep
 2023 17:55:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 17:55:56 +0000
Message-ID: <a1295fef-350e-401c-b644-569be0d57981@siemens.com>
Date: Tue, 12 Sep 2023 23:25:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][xenomai-images] ci: Add kernel 6.1 tests to xenomai
 stable 3.2.x branch
Content-Language: en-US
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <20230904130404.3838872-1-florian.bezdeka@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230904130404.3838872-1-florian.bezdeka@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 1380057e-b401-4f36-c1d9-08dbb3b983b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	14nKNsXLk2pmh6ioCVXMzcEgWL8GKgjJMD87XAIfdBaVknLt6iME6cEBn8Bfm8c8PbX0N8+Q8fwwoa1hxBKg8ONvDVAJ2ZLSWfEPxBKBJ12C4dBfP7343QKW9XwDvPhql2qLu9m4pX8HcOi1DjSn3anxV46M84pHEN+0YzxOfV0gbUZJewHpHt6cTqfqcaTBZpwY/CKaH8Yg8WbzYIg75gcIWmomKcusp9MATKLyWzwTDHXRlX5lXDut4gdi8C4aNDZyu3XyVit5P9exZZZsb4ZpLCe4SDtllhBU8cZ0JQwAPX54eeRdFQhbq1NEBfXNAT8+4TGKC3WZtjQlL61FezHoP2q6QuHSdIbYG4GRpGLsDEbcFyIWecqXUhuuJydbAd0V0eCfpU3yZwuwlBuMORPnkauEPo/WkoPhnR/XJJQds9ussoXTU7izFNnXnEHSgeBWOY/xbz1Zn/578AkhyMpBmOu65nAPfsCBigsdzg1XR0h/ka4f/r9TGUbOxKx2beXomy86lrZi6VdHilJgJFj2+VJMsdaPgxy313PcPimlHufvFHrWJV00WMMdvKEUs2xEGte49VJm5lzsPbRbf6UXMYSR72AQN0+QjfPi84wmtGsGKKu2ncrVZXGB9VShf6fBxUV9C8K3xqCT+uN6ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(1800799009)(186009)(451199024)(82960400001)(86362001)(31696002)(38100700002)(36756003)(6486002)(6666004)(6506007)(6512007)(2906002)(53546011)(2616005)(26005)(66946007)(66556008)(66476007)(31686004)(41300700001)(316002)(966005)(8936002)(8676002)(478600001)(44832011)(5660300002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2k2aStBL3FvUmR4bUlhWGRtaFdHUUdRdVY1VnJXV05IRFUrb1AwOWNCM1BL?=
 =?utf-8?B?a0U2WEJxc3VkYlNUT3hRdmgxQktLOWFaZTh1YUVkSHhyalFXeVBnN2Nzdjln?=
 =?utf-8?B?N1pwQXkvSmgyNi9DWWxBRVA2YkJBUGJxVnVuR1IrNTBOYmo3R0d6K1FoKzNj?=
 =?utf-8?B?cG4zUHNlZ245NFc2QUhwWkk1Y3BFYzVDbGZid21FMEtJQ1BTNEJlenNFOVdH?=
 =?utf-8?B?alg2dTQyU2FPWE1PTVNLalFud0xWM3htYlh0MnVaQUxURXRTeVlwb054c1Ev?=
 =?utf-8?B?N1UzL3pzTmhuemwwNWRZMEdHc21wUXB4MUkwOERES1ZkR3VpQjBuVUp0dGRR?=
 =?utf-8?B?ZlExZVNDbHM4RXhtdkNuN21ueGxuQ3BiTmNWc21rS0NkQmIwejNmbXJrcUY1?=
 =?utf-8?B?djZpMXp0ZGNHYnBJc0RuakV0TTRNbnc1WnlBWlZWU0phQ3lURWZVbUNWN0Js?=
 =?utf-8?B?elBKY0hvKzMrelhtdFhpMzJBdS8vUHQvMmp5NkQ2dVNScytBcWhMUDJ2ZVdv?=
 =?utf-8?B?bjQ4ajEwTjNLcnQwR1dVdW45WFNqdzF1QUp3V2xTRUtzdHI0NXIrb1ZXbG85?=
 =?utf-8?B?Q2ZuVkM0cVZpMVRIMWJDT1Q5clBIMG1XS3JoMkxpN0xFMVEzNlRCR1ozRmxs?=
 =?utf-8?B?aENlcFNZNW1HM2dGS1JvWmRadTAwazNUbFFUR1pLQUdNV0JzckFZaU10cHZE?=
 =?utf-8?B?Tzk2STlqVmFoOCtqdmVETjJ6dGllYmppb3FGOVFrWitJek1velUvbWo2OXlV?=
 =?utf-8?B?eHNXbWgyOXd6bUZaR2FCNURhbFRGSXIxSVZHcSt3dERzYnVPWk1TZmIyWFZW?=
 =?utf-8?B?Uk5ualNPVWxZbm04eW9tcnJBa2REWkRCdURSZ2E0b2hpSWNUNVJPODJKTFRw?=
 =?utf-8?B?ejVWaGU3WVpYaGxUK1NoUEl2YUlTQktkMGM3NGx5aTJGd1ZBazNjNnllVUI1?=
 =?utf-8?B?TVVhQkM3UUZRa2lBRXV0YjcvcXRmS3JJanhwQ2N3ZGtrL0hkWlZ3QnlNWUZP?=
 =?utf-8?B?T0x5NFhvS3FhU09uY2ZhNVlmRXdmWVVGWE1SRlJYZXpUQW1yOWFNRko0UHZE?=
 =?utf-8?B?YThXaWZFZi9VVi9aL0dpT3dsVTMyaTkxSFN1NlpFMCtMS3EyNVE1aGpxaHJJ?=
 =?utf-8?B?bUo5YUZWcVlIVnpGbGUxK1lzQTNNMnNUbTlWYmpIRmtHekR1QzhXN2hjVWVV?=
 =?utf-8?B?S1hjZ1pVbGNQR1VLSHBVTnBnMy9rVnhVYzNSK0I3eWNMU1BiT0Q0c2dDa2Y0?=
 =?utf-8?B?eWRKWE1GWC9QV2t5TmVxaEt5S3Nrem9tRXhaWVRKK1BMa2ViR3VaTTVwaE1m?=
 =?utf-8?B?aVNJZkNhSWpQaEc2RGJSVWs2aVBLYzJkQlR1c0RodS82S2Vxd2RGeS85Q3gw?=
 =?utf-8?B?ZDV3M0lGbWJsOHp2RlNyaG1CUW9KeFpRVXRHaW13dFRrZWRad0JGRlc2dEZ4?=
 =?utf-8?B?czJBY1ZQZXYrMm9IRVhxeEp1bjd1T2J1YzVUUjN6TStpRTFMK2IvcDVNSDJQ?=
 =?utf-8?B?RGJtYndHTmtoTGdJUkhIS3J1eVhHaDFuOFBFZUhpTkM5SzcySE9ueXZqM09T?=
 =?utf-8?B?NG5WT1dyRFU3aElDbWJpalRHSmlaWWhVemJMWU9NRndlMjF3enQwTW5SR25o?=
 =?utf-8?B?Y3EzY3MyV2E5TVFpUDd0RTZzWE15c2lqbmU1ZzBFdVlvUWlzZHFiaitmSUpF?=
 =?utf-8?B?dDVWM3psS1VmbzgwYlFJY2JmSjRkVk1NRHhpd3BUNmVwNHlUMzRPM3VpQ1RJ?=
 =?utf-8?B?OXYyWDZPUnpwUVpudmx3V1FXWVp3ZU5IQ05pdzBWTEhKUDVITnliaWh3SDUw?=
 =?utf-8?B?RlZzU2tDajRvc2h0YndLUUQ4cVlZd1FJTkxRa3NRcWh3UjU4WVNwMEtFS3RH?=
 =?utf-8?B?ZFpUODhraTNRSStiK1JKWmxobUxJMFRKZk1ZK1BwaGZkVFcwTWZNaVVybXhS?=
 =?utf-8?B?UTNGNGlTWDhuSDBPNDJwWDZyMGNoZm92c3EwME0ySVdYcjRRWkdWcTJhRTF0?=
 =?utf-8?B?ajVlVUxGTWVnemxiWlNmQkJwdmVuRTJGV1ZMVHdLekQ2S3htemFBSkRjSlpW?=
 =?utf-8?B?d1E3clJMR0JhWkRiVmM0RWpUTUNBaEZUMU5ubEs4ckFMa3lSZ3hDTHB3U2JS?=
 =?utf-8?B?TWRPdWhLTmNMNHlLc1k3ZkRiVE5Xa3U3Ky85YVlsSDlTS1F3TlJrNitYcURa?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1380057e-b401-4f36-c1d9-08dbb3b983b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 17:55:56.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFQVNmMB7OY2y/UDIrcfSjFrIXazhBKPX2qVyxrJh1Q/4332/9pzWWzj0Asy3YWh9O4QCN1l+7JEY/eo3sNPYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7626

On 04.09.23 18:34, Florian Bezdeka wrote:
> Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> ---
> 
> Hi all,
> 
> once 6.1 is supported by the Xenomai stable 3.2.x series we should
> enable CI tests accordingly.
> 
> Related to 
> https://lore.kernel.org/xenomai/20230828-florian-enable-stable-3-2-for-6-1-v2-0-5189cfb05a62@siemens.com/T/#t
> 
> Best regards,
> Florian
> 
>  ci/xenomai_3_2_x.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/ci/xenomai_3_2_x.yml b/ci/xenomai_3_2_x.yml
> index 781eec8..a0e777c 100644
> --- a/ci/xenomai_3_2_x.yml
> +++ b/ci/xenomai_3_2_x.yml
> @@ -15,9 +15,10 @@ include:
>    - local: '/ci/kernel_5_4.yml'
>    - local: '/ci/kernel_5_10.yml'
>    - local: '/ci/kernel_5_15.yml'
> +  - local: '/ci/kernel_6_1.yml'
>    - local: '/ci/xenomai_3_2_x_compat.yml'
>  
>  variables:
>    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
>    XENOMAI_VERSION: "3.2.x"
> -  LATEST_KERNEL_VERSION: "5.15"
> +  LATEST_KERNEL_VERSION: "6.1"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

