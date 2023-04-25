Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043F07B
	for <xenomai@lists.linux.dev>; Tue, 25 Apr 2023 11:47:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3vgd/LntOMqYEAVsGBCc4V7HlmWK9SqpLUcTmJHPvXl0PsJuNZl1+FdLCuBOMdOJ7MbVP0eEsEWxOswyfQsBQtrysCn3KqMFKErNMRjpDYW8c50Injdfx96HCTdzhDLVrG9JQof8pxawVI/27wxV3ux16EJfXh8q3twBYKFBVg9H0y0NH9CUtbgK5tWxIy8eTthWs3j8Tp1BjL6LHPao1EnnM15gZXPjSjtcE9vipkfaAUQbRbPi9yN1e0tl5FyLtNXIGZdD0zvMhpKRpybsbN8LohhS56DGvGddXs6YPK8t0wFSTwjiKPCFJ3kq1Y+srcRazanxEZXMTgOREVvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gy1b0hK9kSumzdlG4oNlAG99+0hTrMav5dTQ/+d8vKk=;
 b=fiWZmdGPISb20sIEZnGsq2p4SNY3P/MMSpTkDc7Txw70jmhLoXXDr08Qp5HWOzpTuqrBOKo57SklUX4BHwRSwoTPxt3PTX05hcrZB9xHBC+bOeF821qeUGKjnZC2wa97XHBrxqzV0DwIwPPtSHNTpaBL9NnrKX6WRYTlr1+tNXeb2drkzT2gNAgibqGx1kPci8uhMPLar8PhxV/zkg7EtF18xYGNRaGPz1f0lRKRWMbH4GUtvxUtCvxd1xMX/xEGFxNr/m9nE1cBLdoWgmKCZvwNX9G0SzZGFHOZK5ustci81zLtf1UJ1B/RjVPjloR7h17k0EzLHd+DgzZZC3PZdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy1b0hK9kSumzdlG4oNlAG99+0hTrMav5dTQ/+d8vKk=;
 b=fmaCk2pWWkCKDipNgzh35eYVl22YOmOZ326dxnidn4pGdjKjeouaJCNJKTl6JGkfIU443Y0xxuKjNJ83tCwm217RzxEVKBpeKrdoOBOWKiKDn/z98iSA/fzW56HedHlTRuFOwa4u/nrp/JaN5c+9XCu2K7q983o7sVWMG5kuX6MRb1lWLvpRXA2732s89QsJkNvB/RAlAOJAuyqAnA5rtkvqfDob/AymkvtsLmQpuAEguwQKgqFpB5nwHj0V5iRDnd9bOZbh83Ivqmt3WoPbVQVzpZkxKme7HjLgEf8lZibSAPmAC5pN8jKu7QrM+Z5RO9rMzF/H8Kn2A9rGoPfbUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3943.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Tue, 25 Apr
 2023 11:47:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f5ab:5f59:3b47:fc2e%4]) with mapi id 15.20.6340.019; Tue, 25 Apr 2023
 11:47:10 +0000
Message-ID: <c2c6666c-7275-1e16-33d9-a62c4e0cb7ad@siemens.com>
Date: Tue, 25 Apr 2023 13:47:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/1] rtnet_fec: Get build working with linux 6.3
Content-Language: en-US
To: Gunter Grau <gunter.grau@philips.com>, Xenomai <xenomai@lists.linux.dev>
References: <dd9c6665-ca22-b93c-c68b-75ce825119f3@siemens.com>
 <20230425090855.883471-1-guntgrau@bbl.ms.philips.com>
 <20230425090855.883471-2-guntgrau@bbl.ms.philips.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230425090855.883471-2-guntgrau@bbl.ms.philips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3943:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eba14d1-ffef-4540-d83d-08db4582cdd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R7mLYyRFrCToLTuEwRLq1HUMU3drmA0oDaKJAywSu/x3OmkQAsgJM+r5G9StEXqNhUM4zr21nYzygwIPkOw7ailcYJo9eZfEmBFZyj5NoWgzdsVJCLJgQj8ePcPb6LUaf+MJ6yxmJd30OzFSyTjwhqyrCC8pXeVZ3KjbqikcJhccYFfMMkYXhkaSFpYqZtsU2GjTEU50D7xFmyc7PNsnNxEgCi3FfveSOAvkOeTl2Yqbc7/WtxSiMPWbyV8R0FnOW80zAdsSsBkqU232Mny0AyMStJvPgXLl/iKMbDbO7w40P4ZeYBZqUdj7ktU0AqM9hRa7U+nsP5nHh2WtfGevcwxR2f/H7bNjuWBSBUY+o5MOr7js7StTqZSrtHj9mkcg8dWaqNSVAidaM6SlmardXGkj1Fib95/UH3oNcOjOaKaW1W184Sn/j0kp7rkgJm39P9XrCx7YmfqaKu2mOyqnMXxXHPWv7gTesZDXgjOlMSdTBLsDQfE2WBq7qMkIW8iF4DzAmqg1bHA7b1melTBK6bYjaM24ngnbf3+oB1B6VpWm0ksjuM0yZSw81B7FiuygInsyQfIt1sFs75Kx6yNPKAukvZrBy+itlzkdG5QlrIgUcfHXsNm7+iCGB1YeZPw6vsAiEQCDr+7HAZg0mcET/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199021)(44832011)(86362001)(31696002)(5660300002)(8936002)(8676002)(30864003)(2906002)(66476007)(31686004)(66556008)(66946007)(296002)(316002)(82960400001)(41300700001)(38100700002)(478600001)(110136005)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(6512007)(26005)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1RWRXV0cHlsYUxTOW1Ob3dtZnhzMmxJYm1iMUVTaERULzBvd2hsTjFMbElz?=
 =?utf-8?B?YzFqL2tuYThHZ1N4YVU0SFExM0M2ZFlYRnZ0Yk1rVENpUm9jWlU0Mm9jajJw?=
 =?utf-8?B?UXBOVFpTd0hZMGtZLy8vcVNQY0taczdvM1FVcmdCaS9FWENVeHYyV3NaTXND?=
 =?utf-8?B?OGw1a21hZUY4dkg2Q3Z3ODFzb1I4MnhGNEsySVdlbVNScDVLQmxrMERTVVlF?=
 =?utf-8?B?YjFQRWRvSjkxWmhzMkx1WW8rNDVPc2F0L0FoSHV3eWhxV2RZTHNkV0d2V212?=
 =?utf-8?B?SmREWE8zZk1FZFo1RUtrcy9RR1BUSmJpMUNEeXFFMWlnbDdqaWo3NUNoVmhB?=
 =?utf-8?B?aWxmUlV4aWRSN2xpZ3VSMVdUaHBSSjh3NkdLM243QkxkdFZxWVpBZ1BiUjMw?=
 =?utf-8?B?MjBqSFZSUzZ1T0lRT09Pc09vUCtla1dKVGlSZkRUZCtRK2pNNnIzQm9MWncx?=
 =?utf-8?B?TnkyZTFjM0g5WTAwNjBsMnMvNVBYMXdJeU9TeXZpU2E5Ym1YbWVvUklaNjJH?=
 =?utf-8?B?ZDlyMXgzZW9wRHRXb2d5TWo3SXphNXZaTHBVQjNQSUh6a0tlNkh1aUxZSXhF?=
 =?utf-8?B?NEdocFRFMVlXbTFpOFpzNXRZaHdaK0JPSHlUN08rUFlVam9TMGkwNXRhbldr?=
 =?utf-8?B?Y1BIY0pRUW03RDQyVE1xRytlMEJLMmhqTVNpWlZFL3FDMWVwYXdJN1NPUXlZ?=
 =?utf-8?B?Vi9VYm4wTDFrakdwUHZlT0QxajJKdTRLQUFVbFdoMVZtMkdQaUJwQXRuQ1d6?=
 =?utf-8?B?MHVkWkRSUjhqSHpId0tsU0thSEFpN013b212NVFFaHh3NmwxOHlGa0czTUNw?=
 =?utf-8?B?TFNwaDZ3cnAzQUtieG5jRTdXbUhNUnRqOTJWMHpkb2I4L3F6NTRnS2FxNFdX?=
 =?utf-8?B?MVo2U2duUk5GaWZGaWZ0M3dJMDRxN3hzYzhsaU5XUndHZlJoK2dYMlhxd2tB?=
 =?utf-8?B?VFMrcytDVzI2cUZRUmNVR1BPR09jZkpKLzJ5eit4ZU1oNmRhYkJxY1dGUlNX?=
 =?utf-8?B?TlhmQW1OTmQvM0JieGErT3Y0cXFUbzJxYXovRlhqVFAzcHY2SUg0VEg2QnBP?=
 =?utf-8?B?M2JpWXFNN0NPYmN3Vzc4VGgyWDJxTE03dFdtT1hteWNRcUtwZEZnYytRSDFq?=
 =?utf-8?B?THNQOU9hdFh4aFhSeXlxY1RmMUwwaVlIdUdzZW4wSFVURVNxcnJKM3NJRzJp?=
 =?utf-8?B?TXlYeG5pRkFyU2tVUmlLek5mNXRSRFdoU2xoeU9qMDFDV2E5Y0FxTVVON0s1?=
 =?utf-8?B?UmMrdkV5bHhsZE9tS3VERGVsNjY2NUw1bDlMNzZpdmhHM2R1Q2VPcnBrTjZM?=
 =?utf-8?B?eUdaMEY5K3V4QTVMQ2dyRFJSR1RCNmF4eVN0S1AvNEJwN0pDa29CdjJydlNO?=
 =?utf-8?B?QjZ5OEk4RnNhNWZQeXV4aElVbFFvSGp4cm93b0dnOTBqa2FtRGwrU0VhSmd5?=
 =?utf-8?B?TXgxZWFPdGJBTUFaSlJPNHZvcUcyMnMwOTAva283djN3eGVMQ2wzdlYrcjRt?=
 =?utf-8?B?SlhLWUsyc0EwY05wREZVMGc1VUJUUDh5WEFSQWgrUG9qQjY2cXNob09XSHpN?=
 =?utf-8?B?ZzUyTTdqVkdINnl5dnNsaEhPL0FXb09Mbjg0dW85eStpaURCMVVrSTNRbTRq?=
 =?utf-8?B?ejRYRm1VUUdEZkdJbGp4MHEyT05xSGRUd1pVditJM0hKemxmTC9OOERKMXR1?=
 =?utf-8?B?bXVkUHdMWmpaN09JS1Nwb0x3eU8wYVVaT3Y1YkNmZU5qMGpTSVc4WVlTOW1B?=
 =?utf-8?B?RlJPRDFoT0pnREkzMmVsTkhNUmRPVEJCaXZvUW1KUkY0L0N3QUlGSlpGMG1q?=
 =?utf-8?B?SmJBVi8wVmVJMFh2VUYvNG1TdGRGVkh0OUp1bVUzdHYrejQxNVJPVnowZ1pO?=
 =?utf-8?B?YUJPaUllMlphK1UxVWhEWW5hV2I2NllTMFl1YzJreTQyY3RGZXB0MFhWbjRn?=
 =?utf-8?B?QkJBK2tYR3dwc00yZlJJYlN4T01aWWRkRXVHL1BBUGhBZC9ucjV6K2pZZlhx?=
 =?utf-8?B?YktuWS95cVl2b2duMU41d05WM1ZsaFhweVgzMUYvV1cyeDJGT0VWbTd0T1J3?=
 =?utf-8?B?aUJaNHo5OVlPVlhRL2M4dkdaM1UwNHhUL0JOWndndnlXeVhkRVNEeHFZcE11?=
 =?utf-8?Q?TVdLv3vCZPpJnX4Uy/NOAazWl?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eba14d1-ffef-4540-d83d-08db4582cdd7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 11:47:10.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVBNcZMbIs6ptpq3ZMB78B4WDQ+Hw5ASmen7wA/4qjpRYcK8aQoRQ2gHQvOZTOwTKr8ZyX8ps5lCJUwGjGlx5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3943

On 25.04.23 11:08, Gunter Grau wrote:
> From: Gunter Grau <gunter.grau@philips.com>
> 
> Due to separation of C22 and C45 phy access in kernel 6.3 the built
> broke. This is the port from the regular freescale fec driver of
> following commits:
> 	8d03ad1ab0b0 net: fec: Separate C22 and C45 transactions
> 	abc33494ddd5 net: fec: make use of MDIO C45 quirk
> 
> In case of older kernels then 6.3 the old implementation will be
> used.
> 
> Signed-off-by: Gunter Grau <gunter.grau@philips.com>
> ---
>  kernel/drivers/net/drivers/freescale/fec.h    |   5 +
>  .../drivers/net/drivers/freescale/fec_main.c  | 197 +++++++++++++++++-
>  2 files changed, 193 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/drivers/net/drivers/freescale/fec.h b/kernel/drivers/net/drivers/freescale/fec.h
> index 0e2566296..e5c08b349 100644
> --- a/kernel/drivers/net/drivers/freescale/fec.h
> +++ b/kernel/drivers/net/drivers/freescale/fec.h
> @@ -469,6 +469,11 @@ struct bufdesc_ex {
>   */
>  #define FEC_QUIRK_DELAYED_CLKS_SUPPORT	(1 << 18)
>  
> +/* Not all FEC hardware block MDIOs support accesses in C45 mode.
> + * Older blocks in the ColdFire parts do not support it.
> + */
> +#define FEC_QUIRK_HAS_MDIO_C45		BIT(24)
> +
>  struct bufdesc_prop {
>  	int qid;
>  	/* Address of Rx and Tx buffers */
> diff --git a/kernel/drivers/net/drivers/freescale/fec_main.c b/kernel/drivers/net/drivers/freescale/fec_main.c
> index 5abf5e822..63285bf1b 100644
> --- a/kernel/drivers/net/drivers/freescale/fec_main.c
> +++ b/kernel/drivers/net/drivers/freescale/fec_main.c
> @@ -92,28 +92,32 @@ struct fec_devinfo {
>  
>  static const struct fec_devinfo fec_imx25_info = {
>  	.quirks = FEC_QUIRK_USE_GASKET | FEC_QUIRK_MIB_CLEAR |
> -		  FEC_QUIRK_HAS_FRREG,
> +		  FEC_QUIRK_HAS_FRREG | FEC_QUIRK_HAS_MDIO_C45,
>  };
>  
>  static const struct fec_devinfo fec_imx27_info = {
> -	.quirks = FEC_QUIRK_MIB_CLEAR | FEC_QUIRK_HAS_FRREG,
> +	.quirks = FEC_QUIRK_MIB_CLEAR | FEC_QUIRK_HAS_FRREG |
> +		  FEC_QUIRK_HAS_MDIO_C45,
>  };
>  
>  static const struct fec_devinfo fec_imx28_info = {
>  	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_SWAP_FRAME |
>  		  FEC_QUIRK_SINGLE_MDIO | FEC_QUIRK_HAS_RACC |
> -		  FEC_QUIRK_HAS_FRREG | FEC_QUIRK_CLEAR_SETUP_MII,
> +		  FEC_QUIRK_HAS_FRREG | FEC_QUIRK_CLEAR_SETUP_MII |
> +		  FEC_QUIRK_HAS_MDIO_C45,
>  };
>  
>  static const struct fec_devinfo fec_imx6q_info = {
>  	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
>  		  FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
>  		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR006358 |
> -		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_CLEAR_SETUP_MII,
> +		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_CLEAR_SETUP_MII |
> +		  FEC_QUIRK_HAS_MDIO_C45,
>  };
>  
>  static const struct fec_devinfo fec_mvf600_info = {
> -	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_RACC,
> +	.quirks = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_RACC |
> +		  FEC_QUIRK_HAS_MDIO_C45,
>  };
>  
>  static const struct fec_devinfo fec_imx6x_info = {
> @@ -122,7 +126,7 @@ static const struct fec_devinfo fec_imx6x_info = {
>  		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
>  		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
>  		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
> -		  FEC_QUIRK_CLEAR_SETUP_MII,
> +		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MDIO_C45,
>  };
>  
>  static const struct fec_devinfo fec_imx6ul_info = {
> @@ -130,7 +134,8 @@ static const struct fec_devinfo fec_imx6ul_info = {
>  		  FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
>  		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR007885 |
>  		  FEC_QUIRK_BUG_CAPTURE | FEC_QUIRK_HAS_RACC |
> -		  FEC_QUIRK_HAS_COALESCE | FEC_QUIRK_CLEAR_SETUP_MII,
> +		  FEC_QUIRK_HAS_COALESCE | FEC_QUIRK_CLEAR_SETUP_MII |
> +		  FEC_QUIRK_HAS_MDIO_C45,
>  };
>  
>  static const struct fec_devinfo fec_imx8mq_info = {
> @@ -139,7 +144,7 @@ static const struct fec_devinfo fec_imx8mq_info = {
>  		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
>  		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
>  		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
> -		  FEC_QUIRK_CLEAR_SETUP_MII,
> +		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MDIO_C45,
>  };
>  
>  static const struct fec_devinfo fec_imx8qm_info = {
> @@ -148,7 +153,7 @@ static const struct fec_devinfo fec_imx8qm_info = {
>  		  FEC_QUIRK_HAS_VLAN | FEC_QUIRK_HAS_AVB |
>  		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
>  		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
> -		  FEC_QUIRK_DELAYED_CLKS_SUPPORT,
> +		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
>  };
>  
>  static struct platform_device_id fec_devtype[] = {
> @@ -1394,6 +1399,7 @@ static int fec_enet_mdio_wait(struct fec_enet_private *fep)
>  	return ret;
>  }
>  
> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(6, 3, 0))
>  static int fec_enet_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
>  {
>  	struct fec_enet_private *fep = bus->priv;
> @@ -1504,6 +1510,170 @@ out:
>  	return ret;
>  }
>  
> +#else
> +
> +static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int regnum)
> +{
> +	struct fec_enet_private *fep = bus->priv;
> +	struct device *dev = &fep->pdev->dev;
> +	int ret = 0, frame_start, frame_addr, frame_op;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* C22 read */
> +	frame_op = FEC_MMFR_OP_READ;
> +	frame_start = FEC_MMFR_ST;
> +	frame_addr = regnum;
> +
> +	/* start a read op */
> +	writel(frame_start | frame_op |
> +	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
> +	       FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
> +
> +	/* wait for end of transfer */
> +	ret = fec_enet_mdio_wait(fep);
> +	if (ret) {
> +		netdev_err(fep->netdev, "MDIO read timeout\n");
> +		goto out;
> +	}
> +
> +	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
> +
> +out:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +static int fec_enet_mdio_read_c45(struct mii_bus *bus, int mii_id,
> +				  int devad, int regnum)
> +{
> +	struct fec_enet_private *fep = bus->priv;
> +	struct device *dev = &fep->pdev->dev;
> +	int ret = 0, frame_start, frame_op;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	frame_start = FEC_MMFR_ST_C45;
> +
> +	/* write address */
> +	writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
> +	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
> +	       FEC_MMFR_TA | (regnum & 0xFFFF),
> +	       fep->hwp + FEC_MII_DATA);
> +
> +	/* wait for end of transfer */
> +	ret = fec_enet_mdio_wait(fep);
> +	if (ret) {
> +		netdev_err(fep->netdev, "MDIO address write timeout\n");
> +		goto out;
> +	}
> +
> +	frame_op = FEC_MMFR_OP_READ_C45;
> +
> +	/* start a read op */
> +	writel(frame_start | frame_op |
> +	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
> +	       FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
> +
> +	/* wait for end of transfer */
> +	ret = fec_enet_mdio_wait(fep);
> +	if (ret) {
> +		netdev_err(fep->netdev, "MDIO read timeout\n");
> +		goto out;
> +	}
> +
> +	ret = FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
> +
> +out:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +static int fec_enet_mdio_write_c22(struct mii_bus *bus, int mii_id, int regnum,
> +				   u16 value)
> +{
> +	struct fec_enet_private *fep = bus->priv;
> +	struct device *dev = &fep->pdev->dev;
> +	int ret, frame_start, frame_addr;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* C22 write */
> +	frame_start = FEC_MMFR_ST;
> +	frame_addr = regnum;
> +
> +	/* start a write op */
> +	writel(frame_start | FEC_MMFR_OP_WRITE |
> +	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
> +	       FEC_MMFR_TA | FEC_MMFR_DATA(value),
> +	       fep->hwp + FEC_MII_DATA);
> +
> +	/* wait for end of transfer */
> +	ret = fec_enet_mdio_wait(fep);
> +	if (ret)
> +		netdev_err(fep->netdev, "MDIO write timeout\n");
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +
> +static int fec_enet_mdio_write_c45(struct mii_bus *bus, int mii_id,
> +				   int devad, int regnum, u16 value)
> +{
> +	struct fec_enet_private *fep = bus->priv;
> +	struct device *dev = &fep->pdev->dev;
> +	int ret, frame_start;
> +
> +	ret = pm_runtime_resume_and_get(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	frame_start = FEC_MMFR_ST_C45;
> +
> +	/* write address */
> +	writel(frame_start | FEC_MMFR_OP_ADDR_WRITE |
> +	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
> +	       FEC_MMFR_TA | (regnum & 0xFFFF),
> +	       fep->hwp + FEC_MII_DATA);
> +
> +	/* wait for end of transfer */
> +	ret = fec_enet_mdio_wait(fep);
> +	if (ret) {
> +		netdev_err(fep->netdev, "MDIO address write timeout\n");
> +		goto out;
> +	}
> +
> +	/* start a write op */
> +	writel(frame_start | FEC_MMFR_OP_WRITE |
> +	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(devad) |
> +	       FEC_MMFR_TA | FEC_MMFR_DATA(value),
> +	       fep->hwp + FEC_MII_DATA);
> +
> +	/* wait for end of transfer */
> +	ret = fec_enet_mdio_wait(fep);
> +	if (ret)
> +		netdev_err(fep->netdev, "MDIO write timeout\n");
> +
> +out:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return ret;
> +}
> +#endif
> +
>  static void fec_enet_phy_reset_after_clk_enable(struct net_device *ndev)
>  {
>  	struct fec_enet_private *fep = netdev_priv(ndev);
> @@ -1750,8 +1920,17 @@ static int fec_enet_mii_init(struct platform_device *pdev)
>  	}
>  
>  	fep->mii_bus->name = "fec_enet_mii_bus";
> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(6, 3, 0))
>  	fep->mii_bus->read = fec_enet_mdio_read;
>  	fep->mii_bus->write = fec_enet_mdio_write;
> +#else
> +	fep->mii_bus->read = fec_enet_mdio_read_c22;
> +	fep->mii_bus->write = fec_enet_mdio_write_c22;
> +	if (fep->quirks & FEC_QUIRK_HAS_MDIO_C45) {
> +		fep->mii_bus->read_c45 = fec_enet_mdio_read_c45;
> +		fep->mii_bus->write_c45 = fec_enet_mdio_write_c45;
> +	}
> +#endif
>  	snprintf(fep->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
>  		pdev->name, fep->dev_id + 1);
>  	fep->mii_bus->priv = fep;

Thanks for the patch!

I was just wondering if we could do fec_enet_mdio_read via a wrapper
that either calls fec_enet_mdio_read_c22 or fec_enet_mdio_read_c45
(write likewise). Would save code and ensure that the old code would
directly benefit from changes on the new callbacks.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

