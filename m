Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D27147C9D
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310109; cv=fail; b=uAU+QYLrn6CSEDj8CbrEoG1F4E8Qioz/pzt19uAokxjEgCIyLDMj3BdCqBdo6Fe8n7D7xpHKZ23uMrwidRzj/Jgfg9HbZrAliOVsCWMXMiLouh9jprQ3j4iUDJI222hPloUgMHXIV2f+BYzHjb0fwVCEsHKisQc35YlFWiUy4bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310109; c=relaxed/simple;
	bh=glyUidhw9i0GenE9vHr9NrOb+MpNWUaeSDGD2p9BTQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dw3SpExzn2XJjO7dwx/GPvqboD2NOOtxVKdjr4ju7IGiyeW+bp5uS4GKAr3/wEPaWL7AGNCmC2t5HlY2t44RIyoG24I7Zi72KDN3N7lXDE18cSwpf9llEGBfFQCtZY3LXbxVdZZJTNRFfS14zH+xsmYcLXdZdjjbKGAQBYe14BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=gct6I5gK; arc=fail smtp.client-ip=40.107.14.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="gct6I5gK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlHyQc/cJcQLDR9X3CYjGEYrp8ffjQQhl6qv9ZVOg/YwsrWoCmmzFYqA45zUx4cw/iIKWMk+V5VNyw/Z3RkIYVNfH2FdBAhHbKXuYPKX6o/oY2hHs+63woixjpruTiqCAOqNolEyGPVGb4Nc6ABtv2N5eOriWwcJMWyn+PraXTU9JLQnhbe/s1/+uDYIi0rN9LHD08tlaDs6T2CRAK1mjudNoyN0kNTpAlnMIjdNQky3fms5rH22PpzvSXRSxORH+xsEOyMcNFAwCBxLLRiYlIH3wPpWvojq+aPH1FV46rXgIgcG4z/PlEdhOyW6kv7KDXD4Kl4vh3XR876i7OKZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLYM84uTb9Fj1rcLm2qA++W3kB86cvIyh9Z38Z0Xw4E=;
 b=CLEcjJmWZTwDmH3C9QgP+/zPG10oTeZe4Brgy8zKWpNu8wwipLcputVEPHJOgGCcC5FDWYgbnwMOOSyqi5MazvwkOLg5Ei4VLvnJwHI61P6DLyDfKbBCCrshF2+AprojgJBfZwae9OntgXAJfKfXRzo+bMUESj7B8jzhHQMPThVkoYO2VGTvRP8kPJANWoOV3pFSlVcbLpIOePdweJ21mM9Muk+jAcfGu4LaQflUt5IJFiyBNb6cvMr8cGDu89j/BCZFqfuIkjX+b8ZqZooENXykQ0v3YbTcrzvCr76V6EG0+5p2o1EIYaf03yQO9AAGJ9qXdfsecqzKxOvaaBn9eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLYM84uTb9Fj1rcLm2qA++W3kB86cvIyh9Z38Z0Xw4E=;
 b=gct6I5gKlpn54mMTHCSY2hWe81JKllkN+OCWcdANRw1oX49hbDTd13+yiJ/hiQ9CuyJ7vSj+ThWZRegHj65M2ebTjzGULB9ZEPgu9zLQg+T3F2mUGIWgGJwZWvC81Q1qClOSN0DR8lTywoqt8VJmUg5tfsKNehzseS7lCOGERcv4pDCSx/uJQTXaS1lVENO66Wuq+/Gxco/6Sncvkju/+PlfTK7oe9Bes1GCV7+5X2eaNdCQtUvoR0VNLjiBLdGRBgH1XhU4FvWZGDIjt3ONWMqGRYzHP9E8mAxhGf8Qp0soOW/ZSqqW6ZjQAm7/arl6SIZGXYmp5oZF0Hfl9BX5Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7645.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:497::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 16:48:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 16:48:21 +0000
Message-ID: <98e0639c-0571-4a5d-8ab9-73863472ac48@siemens.com>
Date: Tue, 21 May 2024 18:48:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] drivers/gpio: Add driver for BCM2711-based SoCs
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
Cc: florian.bezdeka@siemens.com
References: <20240416085911.62073-1-clara.kowalsky@siemens.com>
 <20240416085911.62073-2-clara.kowalsky@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240416085911.62073-2-clara.kowalsky@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0394.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f2bd71-cc48-4136-fa32-08dc79b5d2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnBLNExDbG1OeStyWlg3U3hMUW9CM0V5Z1hnOGliWlIrc3V2azdydlU4K3B1?=
 =?utf-8?B?T292Smt3aWlWRGhoNG53STNXTUpXN0tRcGUwUjB5QTI0L1lxeEFzNUtBUHNK?=
 =?utf-8?B?VXBGMU42TE92dk04TldJRG9ZbFpkSnNsZUo3U0w5cGZ6Vmx6UmI4RUZBTkd0?=
 =?utf-8?B?RDZBOFpleXhuNmVxUmpUQUI1dnVwaUdtUEl6V1R0VGdLcFJieUs3c2RQR2JT?=
 =?utf-8?B?SG0xV2xWWWNqT1JvRVd6UjY2SXBpTnNyR3R5bmh0MGQwZ0NJdjJtTUU3ckFt?=
 =?utf-8?B?TGQ1MEhtOEYySWx6b1Y3ZDJUQVJ0UWZZYXA1bTY2S0hoZWIzTjhmTVZ3Nk1v?=
 =?utf-8?B?Y2JQV0dubVdrUk9qRGw1SDJuYmE3b0ZIeXZzbW1UT0xWRXNSaE9wUkF1c1hN?=
 =?utf-8?B?dThwM3lQTjExR3p0U2RVcXhMTWluWk5kMThnNnhHYzBCaWxxbGx6SGpKeEhT?=
 =?utf-8?B?UFFBS2JJK040ak9jK25BdWxMSkRzQWVGSFBURkk0R3Z3RExERllBbG9rSEYr?=
 =?utf-8?B?TkFzT0RETXFCR0tBYVR6Z1ZiczRoUThWSUUvOTEyRTRrK0dMaUZFSVBUdkha?=
 =?utf-8?B?Y2ozZ1VkMElNQVNMc1FmaldnNFVPMnRKcXhhc0VGTFUxbFg2ejRYOVVaZnZs?=
 =?utf-8?B?aUdycXU0WGRwM3Rjd0xnWXpFTGc0WFhZL09TTlN4emlTQWJLNC94UHJheTVZ?=
 =?utf-8?B?eXhzVC9jcGZLQTVreGJMUHF0ODREcmFQenZpSkpVakNKQzdkcjN5eEt4YTl5?=
 =?utf-8?B?T04vTWdBakp6Ykx3R01xQndydFV6bCt4QW50aXMzc1NKWWxTckxoSzdYeDRl?=
 =?utf-8?B?WHQ2K1VNS0pyRlFrVjVwYVFreFdQMlNCL0FKZVd1WjQwRUwzZFlub0FRWm4y?=
 =?utf-8?B?YW5PUzJOcjJaN1R4KzJBV1hRcFRzZm9MUXkyWlE0ZGN6RkxhTEtFTWFoZkVD?=
 =?utf-8?B?QmppL2trb1Y5MUdDYVYrbjBhMlF3N3ZXdDdJaGFKSTF1QWNJeUQ1SHcyTWU1?=
 =?utf-8?B?b0d0M1MzSXkvQkZqRDlOWktJLzVaSXBodkV3UWtYNWhSd2V6bWZ1ZmJSbzZq?=
 =?utf-8?B?RkZBZW1zQlZhZ3FROFdvMWdmSGdDbEhoN3RDZWNWRmNsWWNmQkNlV3l5NW9n?=
 =?utf-8?B?SjlJQjdyU1BVN0xHbEY5cFlORDV4M1dodXk5MmNZWFFnc29QWWRBaVN4a01B?=
 =?utf-8?B?bEJaZkNNTWIxeTM1RHR5NUZCTnc1djU5Vmh5aWFhVkx5RW0xMFR2b2FISDJV?=
 =?utf-8?B?YVJLbzFhSE8waVBJdXF5c3M0Qm4rZGVYdS9mUzc2VVJudnQzdEsvWTNBRS9h?=
 =?utf-8?B?MkFEYTdyTllOeGtjVVA5ekhyTjZVSXh4QUthMzNTZE9kK1o5aXNyaUJBL2U5?=
 =?utf-8?B?MnVYV0NjTUNaSEFSY0djYlRHQ0tGT2NsYW1RY2d6akIrUUpTdk1hNWswZzFi?=
 =?utf-8?B?VDBDSlR1SURJa0VBaCt6djBpUlN6OHNSb2o3aUx6RnY1VE1DcnVGNTZoV1RH?=
 =?utf-8?B?MkdTMUNXS2Z1eWUyVlhmaDlMcVU1cEJiUzlCTnA2cDVnVms2Qnk1NmNpcGdn?=
 =?utf-8?B?M25WY0JTYTZjZHBaQ0VkY3NYRFFzOG5KdG5TcHJGdnJnME84UHFQaGV5NGJw?=
 =?utf-8?B?NVNDcmhSbjU4TnhpUzZLYzlvbGZOMVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlB1b09leExzQkJ1WjUwWFVWbzNjVmtZS2lESU9rSXp4c1VISUEvL2l6UXVv?=
 =?utf-8?B?S05YZHhRSVNIUGdJaTJ1MWtqYVNrWEcrU0xQSXBtQWpUdkZqQlIrMUVkWVBa?=
 =?utf-8?B?a1F6VkZRMllrTzhRWkV1bCtkOWxJS1ZNb0d5SGY5ZjZ4UzZ0T2ZHVEZsM09v?=
 =?utf-8?B?blBlNVdGWksyZmRSUzlBdUgzS1FacTBHK0lySkpuVVh2ZGYwakQ3Ull4Mk9Z?=
 =?utf-8?B?NjhESHd6TUFUdnRQL0JGYUVoa3NFTURmMC9Ia0VOU0hPa0szWUdRbEl4Y3FH?=
 =?utf-8?B?dzFteTExY3NWQ3dpNFhvRVRoRW9SRWhvMVVsY1AwQXpxK25BOFVaalNZREQ2?=
 =?utf-8?B?WnhCQytsTDJzRm52S2hDcjlyM0N2S1pmRFJxNm5sVGlJZU5UckR3ak0xSFU4?=
 =?utf-8?B?ZEQ2ajlFNlhJUkRqN3JXWmphdGI3TlJXTFZrTEN1dUVSWmxFTmdFOWNKWE8x?=
 =?utf-8?B?Y29wSklvWm05eVFLT1g0TG5BVW5iNnR2MlBKeTRnaVM2Q0FTclIrRzVQV0Fw?=
 =?utf-8?B?N3ZFeitJZkNTQ1lFMjV0eHRZYkxrSjBmR3Y0ZDZUMGRrTDNwTGZyTWlhbVdT?=
 =?utf-8?B?RzBxaktydEVCSHJOZEN3cHVwR1VPOGZoT045Mld5Y3Z6ZHkrWjQrMFFLMHY3?=
 =?utf-8?B?Ri9hRjdqK2FEWFJRR3hzSHNMNTFGZzlQTVlrekY3eWRoWEtGVVJvajZrNElJ?=
 =?utf-8?B?WS9veWs0TDUyZU1pczh3Wjh6T3NueEFES3hScWUrYkVCOFZxS2srWkYzTEVY?=
 =?utf-8?B?TGR3dlplZExiMDRtbmpxVVp5Ui8xRmJOL0NTcDV1RzVaMmZKeEp0RXdvb3hY?=
 =?utf-8?B?RmcxZXlTTTg5bUJISUlDQ2dhTnBoWEJ6bkViMUZFcVRkNzVIWnZoUlB4dXpp?=
 =?utf-8?B?TkltbTEvVS82YXUwV1NoL2c1cWVEV1ZCQnpEcG9IQS95SURRMUFTcEZ5SkJw?=
 =?utf-8?B?NTlVc3AvU1dLM0hmRzMzWHU5RXJLRlNTU28rSWpRZzV3cFIwUnAvZGFyVTJ2?=
 =?utf-8?B?TUsrUmhmTnp4OGNYVWZqZVJCRW1YMHVCa0h5c2hVMGJKem5qWkxCSDNGMThJ?=
 =?utf-8?B?SGxjc2NUMkROdU10RGFWUC9kUVRQWGVzUmREcnhFYk5OMnhyaFlYRC9hakFL?=
 =?utf-8?B?SW1IMW9Gd05qU2dJUzU1ODZpaVFqeXFMZWZ2di9ydEFlOCtNWDNWSXlwajdM?=
 =?utf-8?B?UHZUZDlLTytmSDJYK0t4WC81aGsweWNSOGlFUzF1eFdxSjVXRHdiWnh6L1ZL?=
 =?utf-8?B?MW5rZEdkZ3Z3NzNJRjRFY29NZmhzUUN1SURUTEZtMi96eVRCempQcTJkcklI?=
 =?utf-8?B?bk9WZWN2aUpxVUJvNFR0TnRJa1pYMFQ4cDB6d0kvc0VVNGdKWWxKN3lVOUVj?=
 =?utf-8?B?U0puYU5KVUxGWG01RXBuOTd2alJJRThiR2FEVk43SGozUzdnZHZUNlR5MVNJ?=
 =?utf-8?B?dStCSWQrSmYyNDZzMXRyREtvOXVxSC9lSGtKc0VZYkU0VTlYb2xwNzJ2a3Jq?=
 =?utf-8?B?WEJlSzl0T1NHTEU4N1p4Qml4V2o5bTJsMHVwSVlwRHdJRFR3NWJBTXljUWNt?=
 =?utf-8?B?NTl1Z2RmK01yN25sSEEyV0pGL0JOd0NLRTdaRE1FbjJ3YXpvRkY0OVVvamp5?=
 =?utf-8?B?Y0J1OXVEOGIzenI4anNncE1HTnV0S3dXNndDVUU1ZGkvQ3dCRFpTWlU0VXRh?=
 =?utf-8?B?NnpZRFJwa2tHakYweG80aHpGdlpsbG82KzkzUFBQRUxTZjlSbHdkYVRiZ1dT?=
 =?utf-8?B?b1FWeHY2WHE4bE85ZUxiSXM2Tmk5bk5lUWtOQkF6UVhnVEk5YkJhV0lwOE0x?=
 =?utf-8?B?SkJoOTMrWVg5OFNpTXdrTjRkdWI1eS9TUnhweWcvbkI4UkJxZkdFSE9PTjNG?=
 =?utf-8?B?d0FwbGZUakhjb2FBcjl2Y2IxWDRmTlpucDFlLzhsR3FsMktieThlLzJ3VVAw?=
 =?utf-8?B?c1ZvdUN0TXQxd2NPUFVqWjZ0akJQeVhMWTB1WU52VGpjNWlvV0d6QVJzWDZl?=
 =?utf-8?B?KzlITjlWeWtHaHBMUTcvVVpDR1hqaGxZaVd4MWlSUHJ6R2I4ZmlLcW52ZEUw?=
 =?utf-8?B?YU16L25SQjFsRTV3bVNpdUV3R05rSnlPYWhmMnljVG9zelhRVEtHZFI5WE5n?=
 =?utf-8?Q?iWbp4pmqFiL8KNKe6XKjSDsAj?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f2bd71-cc48-4136-fa32-08dc79b5d2e8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 16:48:21.5353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Q9OWmFduN6BFJ1c76psoH7n4KOeVy3KIyayoBZz1YyoGjdlpFpKxizSxiKwV1SJsEkHkIKKxTS9rFoLmz7X/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7645

On 16.04.24 10:59, Clara Kowalsky wrote:
> Add support for BCM2711 pin control driver.
> 
> Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> ---
>  kernel/drivers/gpio/Kconfig        |  8 ++++++++
>  kernel/drivers/gpio/Makefile       |  2 ++
>  kernel/drivers/gpio/gpio-bcm2711.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 kernel/drivers/gpio/gpio-bcm2711.c
> 
> diff --git a/kernel/drivers/gpio/Kconfig b/kernel/drivers/gpio/Kconfig
> index c257444f0..bc9cbc5e9 100644
> --- a/kernel/drivers/gpio/Kconfig
> +++ b/kernel/drivers/gpio/Kconfig
> @@ -17,6 +17,14 @@ config XENO_DRIVERS_GPIO_BCM2835
>  	Enables support for the GPIO controller available from
>  	Broadcom's BCM2835 SoC.
>  
> +config XENO_DRIVERS_GPIO_BCM2711
> +	depends on MACH_BCM2708 || ARCH_BCM2835
> +	tristate "Support for BCM2711 GPIOs"
> +	help
> +
> +	Enables support for the GPIO controller available from
> +	Broadcom's BCM2711 SoC.
> +
>  config XENO_DRIVERS_GPIO_MXC
>  	depends on GPIO_MXC
>  	tristate "Support for MXC GPIOs"
> diff --git a/kernel/drivers/gpio/Makefile b/kernel/drivers/gpio/Makefile
> index e534eab93..89337e3f3 100644
> --- a/kernel/drivers/gpio/Makefile
> +++ b/kernel/drivers/gpio/Makefile
> @@ -1,6 +1,7 @@
>  ccflags-$(CONFIG_XENO_DRIVERS_GPIO_DEBUG) := -DDEBUG
>  
>  obj-$(CONFIG_XENO_DRIVERS_GPIO_BCM2835) += xeno-gpio-bcm2835.o
> +obj-$(CONFIG_XENO_DRIVERS_GPIO_BCM2711) += xeno-gpio-bcm2711.o
>  obj-$(CONFIG_XENO_DRIVERS_GPIO_MXC) += xeno-gpio-mxc.o
>  obj-$(CONFIG_XENO_DRIVERS_GPIO_SUN8I_H3) += xeno-gpio-sun8i-h3.o
>  obj-$(CONFIG_XENO_DRIVERS_GPIO_ZYNQ7000) += xeno-gpio-zynq7000.o
> @@ -10,6 +11,7 @@ obj-$(CONFIG_XENO_DRIVERS_GPIO_CHERRYVIEW) += xeno-gpio-cherryview.o
>  obj-$(CONFIG_XENO_DRIVERS_GPIO) += gpio-core.o
>  
>  xeno-gpio-bcm2835-y := gpio-bcm2835.o
> +xeno-gpio-bcm2711-y := gpio-bcm2711.o
>  xeno-gpio-mxc-y := gpio-mxc.o
>  xeno-gpio-sun8i-h3-y := gpio-sun8i-h3.o
>  xeno-gpio-zynq7000-y := gpio-zynq7000.o
> diff --git a/kernel/drivers/gpio/gpio-bcm2711.c b/kernel/drivers/gpio/gpio-bcm2711.c
> new file mode 100644
> index 000000000..a861def27
> --- /dev/null
> +++ b/kernel/drivers/gpio/gpio-bcm2711.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) Siemens AG 2024
> + *
> + * Authors:
> + *  Clara Kowalsky <clara.kowalsky@siemens.com>
> + */
> +#include <linux/module.h>
> +#include <rtdm/gpio.h>
> +
> +#define RTDM_SUBCLASS_BCM2711  1
> +
> +static int __init bcm2711_gpio_init(void)
> +{
> +	return rtdm_gpiochip_scan_of(NULL, "brcm,bcm2711-gpio",
> +				     RTDM_SUBCLASS_BCM2711);
> +}
> +module_init(bcm2711_gpio_init);
> +
> +static void __exit bcm2711_gpio_exit(void)
> +{
> +	rtdm_gpiochip_remove_by_type(RTDM_SUBCLASS_BCM2711);
> +}
> +module_exit(bcm2711_gpio_exit);
> +
> +MODULE_LICENSE("GPL");
> +

Thanks, looks good - but can we also make sure it is built in gitlab-ci
(https://source.denx.de/Xenomai/xenomai/-/blob/a34701b78e07c9157c10a888c53381b1621c7a87/.gitlab-ci.yml#L166)?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

