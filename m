Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F8142919
	for <xenomai@lists.linux.dev>; Tue, 21 May 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303298; cv=fail; b=hdHVwFs06Web2FHgfnMNZSPOP4+G1swHiRFiakWtfzsp+NX7a+jLSLK0pWEd0ZlfH4unRwXzL/18gJvexfK3s+Aux1w+S7co5aPoKrgZoOnwEIJddEVCx4G4OT5jmZkQOUAslvCTF67kmIbgjRWvLsHMiv/LOZHUWWnEz3Y9RBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303298; c=relaxed/simple;
	bh=28UOTLfa+QMiHvmHz+odGnvE7Z9X5UscAy+tALlTK44=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ERFnGOx3cbWe1E2ffAQdMPaKRcf0FHdjG+R4m7jvAA8qBlFrP5O5FsS2LfEwiGKUxbEvU4EqzPtiPJ3g95aCU5AaQ+C7BJDphxGCKf4kJpLI+0PetqlQw6sJdd/SA3fOkr/cTp5seL0HG1745RdAinIdJoVGUX7cjCxD+ziw+X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dgjhnHQp; arc=fail smtp.client-ip=40.107.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dgjhnHQp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+LkaPWQAqLMem7kVrZKzn35TB2OJ10FaV6+9zknt8D+1eXThs0FVCspJlHx8W55pGiv/3y/snkkYhK69W3zNaFNJbAADNJ/4RWZ2YQw3bYJv9jRClHhArjPyOI3Q7FfUJNA+95Ulf8NVtrA+aYa5JulWdewjg3XofBxfLkX6f2gZH5KQsqmsUl/uqkNZD6/Wsr1JMS75N3+yVnjX1ftb2Jlacu37BTtEXXmX5/hTVh7dz8z6l8Iz6L3vNKnrso4eK+loHaQV5H/TTV8XXYwxBayKq+QgRfBjed0cRg1Lp71r/VQnHG0DBYx9L4bK6mtCS4cSn4HqTL9CrA8bGwlnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nbd/vypB0/QtKgL8q7qsGtqJaGdhSVkcif1sZllFtAw=;
 b=EHW1aQwimFLpWsQ+WVT80TZrWuTRft38zpS0xRCkujNZuBSKhot6ZJf6q/CFA66MFUzK9t/suujRQlCDyKbOArNaPXcd+kOCRtYPr6D4QdxwooyDu+htI8+rPq46RroCw5nPMVYuNP8/W6BoagxSKJYZblyr00XER5I4DM8MxrCXMepj5Wzc9X1CxshbvHY02znMWF32z/Nm4rSZCs9slw8lxMSzzdFWGey0SmepaNMTSGVnlOBfSGbxTLS3g7y8P0GRnfjz02GmP7v72hFOrEBVlxUROW7ZjZ3UVgd/4SiAsimrpdOVuJWyEeMSN3gKyLlwx88DIvIazNQ/uYlNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nbd/vypB0/QtKgL8q7qsGtqJaGdhSVkcif1sZllFtAw=;
 b=dgjhnHQpJDEU9cBW4ssxaigkqSBz7iFrm1qBBcuGhiIETR1be/PFAJEC9uBEfZgHDxTygMQqmSqUsI9fhJ7F20iAwiqTPOIzXoc/nID4Ybia8urb7WdXV189nKdk6RJ9FbcXW9PwvVIHhsV69gkOX7i43g+BipSzwBvlG2QzuX10yubk+3ozmKWUB2joufnwibv3amg0i4OoUdxdPoKNEnEuKj2R4yLIHbDLwlJC6nmz4W8ttmVfnvNAOkbFbqsp34L/KEQevPxrQzI2AkvVeYOwNunNOzhfNT2QeDZXyLOSMrZLKtyTffaMxWgUsi2t/GmSEJxfAkhWo5fBBJC0qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 14:54:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 14:54:52 +0000
Message-ID: <7a404b5e-77b3-4f95-a088-f4a36e97ce03@siemens.com>
Date: Tue, 21 May 2024 16:54:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rpi4: add building options, remove old kernel and
 Xenomai versions in kas menu.
To: Yi Jiang <yi.jiang@siemens.com>, xenomai@lists.linux.dev
References: <20240521134841.21749-1-yi.jiang@siemens.com>
 <20240521134841.21749-3-yi.jiang@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240521134841.21749-3-yi.jiang@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: 82630793-7a29-484c-d1d1-08dc79a5f894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZiSXg3OERtcDFJMEhibkxydWdtaC9JVStVY2hoblpHUUJZeVJVblA4ZHNt?=
 =?utf-8?B?Z1FZWHFFQ3daL3BvU1VBQi9PWFpwSkx1V3gyelJHMHU0RmozZy9qVmJqeTZ4?=
 =?utf-8?B?dXdhbGxjRndydHdCMGFjMUF3RlprTWNwb1p6YzJGb3hCaUtLSjFFVko3STVY?=
 =?utf-8?B?NFFhYmIzOFlvUGhkaFZvM3QvZHVmdXplVjBFdHNtM3B5TzVoK2x0SjgxZDA2?=
 =?utf-8?B?c2xHTkljcnA1N2hEWHpNU0hRNGxOdThpa1dNczlUYU5Ha1RubWhOaEpidi9D?=
 =?utf-8?B?QUxQak9BM05tVFJFYm0xK2JlTS9qOVU5RzhybUlkaTdrTk0rV3prWk9TbjI1?=
 =?utf-8?B?VDlncklTaXRJcHpadWFsWGFjVVZ6ekhNZ1ArZUdselBkSUxWcG5takQ0QnNt?=
 =?utf-8?B?cUVzOHNrcCs5dWpHeS9JMXUzcUU5Ry9wRWVVMEgya1NCejR4K1VaMk5nM1Z6?=
 =?utf-8?B?MlZ3RGVGeFFkSW5EWnVGQkFhcy9wR1VNUWpEdEVQM3JTWlI2ZXFFMC8wdkVk?=
 =?utf-8?B?Qm0rOGozREIrVFZZOU9lQVZmK1VPdE9yYTJKTklWK2ZGcEhLa0dSMWQ4LzJ0?=
 =?utf-8?B?Z2k3WG9NNnFpZ0pYb0tLNjVzVDJLMFVkalFpZmRPK0VqUkk4eVFLQ2gzQjd6?=
 =?utf-8?B?c2NCNU1ocG5oNmpMOW1wTlVBK3lRcXFhbE1DMXVkVVdNeXhTSUJDY1hoclRx?=
 =?utf-8?B?dGxLS3VUbjdjalFCREZNeTRnY2NzMHFNN1pEcDVvSE5rdi9aR3lmdnloZHdG?=
 =?utf-8?B?OXBEcnQ1SEx5VFpEVURJZkVCZDdRTUQzaU5oQ1hqOWh0c1kyamRXRnB2ZHJH?=
 =?utf-8?B?eXg0ZUNqaUg4dDBXMWM1M2RaQUtkdUNieHlBbnhSajN5dDlUR2o2bkxKRTJN?=
 =?utf-8?B?U3lNUEt1T3NWSlJhcXQ5dXFxUG9XRmRiMjJuMmZmNU80WGEwN29KZVova0dp?=
 =?utf-8?B?Nzg2YUN0N2lPK0x3YkNETFpIbkZ6cEVxY1BDb0J3KzFxNWNLQnNvSlBGbVVV?=
 =?utf-8?B?Z2V2NVVVVFA0L0lJcHdIUjU1QUVCZzliVThxNG5VS1ZqdzNaeDB5Y3NVeUFQ?=
 =?utf-8?B?SWhGNkg5UEZ5WGZDWUtIMXF2RkN1WngxUU1vQ3RYMGRuekNiQ1FROEp4dDFR?=
 =?utf-8?B?ZXc0U2xIS2lad09nZEdOczlXdzhBN0RMcndZNng0aHBaOHE4cUZ4OWFoRHp0?=
 =?utf-8?B?dHpxc3RESGZ6Q0dacThWNUxTZFdPYlZpd1dCTTRjMEVUNmJyTEFoRzN5dzVT?=
 =?utf-8?B?KzBlZ2cvOFk5a0x2aWkyY3cxYjVYMlhPUWdhZWhaVXd0QjVCbDN5VVJrL3lm?=
 =?utf-8?B?N1ZUNHRFenZvTy9aeWFMOExPUEl3MWtVUHEvOGFyOVRmcmdnTnFtbzlzb0J5?=
 =?utf-8?B?bTkvVDl2Q0luQmhWdWhkREk4UFhTQ2QrdEpLek94eXpDVEdyRmREWDErWkJO?=
 =?utf-8?B?S0NZQWt5ZU8rVG90UVVYNkhyNHFuY2o5SWhUZGJsUm9kYmtnM281SkVzR3o1?=
 =?utf-8?B?TGNPRkZWODJraGhuUmdYM2h6eFgzM2lBVVFMRjVCUjhkNHNzVmlkU0x3Y1c4?=
 =?utf-8?B?bXRjd1VEdW1xNGdETzVsSFQwdEtUVGVUbU5FMlVGOGNpUG1GbUI5MmVyeDVE?=
 =?utf-8?B?MUZBYm1vYU04YW5BN3NoQlNJcUxJc29WQ0NEL3N1UDNBNmlGbUZwUHc2bDJW?=
 =?utf-8?B?RVp3aGVta09UT21oM2w1M0lLRHdkY3FzZW1ZbUQzKzVKVHF4RkpLVGZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUNRdlZZU21kT0w5cS9KWkw5dW9DcEpRTHQxT1VWTEVpeFVLd0RxOVlVL2NN?=
 =?utf-8?B?YzF2MjZDdE1pWjNnS00yQURnQ1pENjE3a1ZZczZoZlpiZ2ZibUxyeGxTaUFi?=
 =?utf-8?B?ZlFOYTJLc3Q2TEN2U0Q2OGQ3ZFBMU3Y1VHhWZEprZnowcDBNVDNtOHJVbE9r?=
 =?utf-8?B?Y2YrMlVISTBlREQ2TUYvT3NOTk5BelVuM05jT2NBc0NjWkNoRnhjdHdVdHVW?=
 =?utf-8?B?bWMxbG4yUDJpcmdnWmU4cFIySk9XUldDNGN1cHdGSG9IcG83WUZ1TWNpWENP?=
 =?utf-8?B?dnVpUTFxbzMySWZ3TzZvMDRaSUdHN1NUSjkzVXc4QUQ3dUgrdDNIUG5XUDk3?=
 =?utf-8?B?R1BNK2RVMlFCNDBGVEZmTFE5Wmh3YldsWjdSbHJYNTA1RGhGNWVMZEZEN0Zm?=
 =?utf-8?B?a29oZFVDRTFJU0Ntazl5NEF1REZWcHF3NUFkNEhpNXNhL1VkcjNyMnBGVFpM?=
 =?utf-8?B?RHhJTXlXUDJ6cG1WamJLYkZBK2xKNnc5UjVPdjNwLzdkVkhXUHZ3cEU3MUVB?=
 =?utf-8?B?YTdXNmtvemt2MDI1WDZrMlplRy9tSkNxcWhUZDhGM0p2SklTOXlxOEtoVzdR?=
 =?utf-8?B?RnJ3T3VaS0V6NytNbGpvWmhsdE45bmRqVllrZUdUb3hqdzExcjRYYmVBQmtQ?=
 =?utf-8?B?QUI0VjYxS3FoN1pFcVhUUGVpTFEvV0F0YjFuQnJkQ1dVeFVJQ01IakE3MWFw?=
 =?utf-8?B?SnVncFFCREhaZVVIcWI5WWhjc3cxSVVzTzkrNStKTmxpZzFWWTZqVy8xNC9u?=
 =?utf-8?B?WEJEUW1POWRvSDVYWmZPU3V6WjRXOTVoZHdXblNRM3ZPYldJUWpkRHNMcmdM?=
 =?utf-8?B?WlVxMXoxbi9GT0ZwSFo4ZXhRYWg4c0g5dzF5VTlsUFF6VE9UVzNta1lRRjEz?=
 =?utf-8?B?ZGNpcVN2TEplcGtSYkpZZSs2Yncyb25LZGNhTFp4NnNoNlNkTFNINnlUYUZt?=
 =?utf-8?B?bk5Ec1FrZkRjRXpKOVZZRUw4aFpnU09MR3VJMSsrRDhMaHZZWUhPZERFQS94?=
 =?utf-8?B?ZCs2b0dwNU0vRDF4MnV4WTJLVjc5ODZIQkd6VFl1ME9lbTkxUXdMYVlFMGxp?=
 =?utf-8?B?ZmhTVlZCOStjVFpJTjNNcmluYmhsQkEwWDZiTDFTRmFuVUJQZFVNbzVpTkxS?=
 =?utf-8?B?WVlKN3hCekV4TzRHeUwrODhvUEFaOXRKbU1wYUxkcWs5VnlkcXJsbXRQc2Mz?=
 =?utf-8?B?a2NpSzFMQzBkc2crc29aWk1zL21Uamg1MHVoMEsrUUpEeWt3T2FaQ3RKVmhn?=
 =?utf-8?B?aUQzRzY1MTVrWTZCQ3d0WVRkUi9zNVlTaVR1a0JZaWFnVVBKNFJGNTQ0aWNC?=
 =?utf-8?B?QnBBZDJIdnZVT0VXYzZOWUhLak5aNm5KOU5KZGFFcjJETHZ1bm1NTWZ4cWcz?=
 =?utf-8?B?UEppcTIzNENQL24vS0RRSnlIK2ZWV0NhSjErSHFJeThZcWtBMmN6ZlgxU1Yw?=
 =?utf-8?B?WEhySjJCV3oxaGZOVVVqc25nSXM4WXhWazRWaklDa0FQN29KczJ2dHF4K3JC?=
 =?utf-8?B?NkJLYms0VENsaFVYOHFqRU9rRXlveVN2VENaK2F6WldkZFdKWndOUWF3MGl0?=
 =?utf-8?B?eTl0TUxCREwwK0ZzNUZGR2VnSVJUQ1V4WkNad0VXNmdRUGF5SUJoTit1UXdl?=
 =?utf-8?B?d2dpMVJyLzV5OHV5YUhrUnZOMUQ2ajB6dVpIOWZDaEVod0JmZjdIemxNdUFC?=
 =?utf-8?B?MjdqMHNwVHlUNTF4TituWXlpUnpsWUI5bFVNM3hHK3MvUTlabjhlcExFbWVG?=
 =?utf-8?B?Uk5TVU9yOFlqSCtyUVhIVTNDVS9jTExLK3F1VWtqNFVXaGZVc2hZSU8zM3Fr?=
 =?utf-8?B?QUJqWUNTTldwUCtCcVpkdGhWeWR0bXZvajVaR2twVEVObitwTG5yUUszamto?=
 =?utf-8?B?VmQ4MnhxWmM0d3pGVmJhb3Z4MUxXUGhoQjg5SHcrNG50akNXMCs0MEU4WWJV?=
 =?utf-8?B?MXpFV3hUUmJ6ZXI0eVBlVDM3ejZyUy9mKytRNCtpL01XUW0vUExzNlZwR0hm?=
 =?utf-8?B?ZnQ5TFIwUnI3SnRFUWQzVHMrVDJiZnFyL01La2xsMWlYcnVjUzRVY0xyWk1a?=
 =?utf-8?B?MFoxMVF6dWJxY3ViUXUxQ1g3bFNPOTc5SEpRY0pmc1U4dDFybUZJckdCbUU3?=
 =?utf-8?Q?U2wvqLBd1jbh4EY6GqIvjqdG2?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82630793-7a29-484c-d1d1-08dc79a5f894
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 14:54:52.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FU9Hf7L/NtuQVr43PKcQglWubuQhFgjP9A26KizFqrJQfKisf0f2/FeNjJjGgHciacDyZSvFaCrpB9MlfIYIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5518

On 21.05.24 15:48, Yi Jiang wrote:
> The following kernel versions are removed from kas menu:
> 
>  - Xenomai 3, Head of stable/v3.1.x branch.
> 
> The following Xenomai versions are removed from kas menu:
> 
>  - Xenomai 3, Latest 4.19-cip I-pipe release;
>  - Xenomai 3, Head of 4.19-cip I-pipe branch;
>  - Xenomai 3, Latest 5.4 I-pipe release;
>  - Xenomai 3, Head of 5.4 I-pipe branch.

This message is confusing. It reads like those configurations are
removed in general. But what you are rather doing is to prevent that
unsupported combinations can be selected in the menu. Please reword.

Jan

> 
> Signed-off-by: Yi Jiang <yi.jiang@siemens.com>
> ---
>  Kconfig | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 669ea65..13699bf 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -45,6 +45,10 @@ config TARGET_HIKEY
>  	bool "LeMaker HiKey"
>  	select ARCH_ARM64
>  
> +config TARGET_RPI4
> +	bool "Raspberry Pi 4"
> +	select ARCH_ARM64
> +
>  endchoice
>  
>  config KAS_INCLUDE_TARGET
> @@ -55,6 +59,7 @@ config KAS_INCLUDE_TARGET
>  	default "board-beagle-bone-black.yml" if TARGET_BBB
>  	default "board-qemu-arm64.yml" if TARGET_QEMU_ARM64
>  	default "board-hikey.yml" if TARGET_HIKEY
> +	default "board-rpi4.yml" if TARGET_RPI4
>  
>  choice
>  	prompt "Xenomai version"
> @@ -85,6 +90,7 @@ config XENOMAI_3_2
>  
>  config XENOMAI_3_1_LATEST
>  	bool "Head of stable/v3.1.x branch"
> +	depends on !TARGET_RPI4
>  
>  config XENOMAI_3_0_LATEST
>  	bool "Head of stable/v3.0.x branch"
> @@ -141,19 +147,19 @@ config KERNEL_5_10
>  
>  config KERNEL_5_4_LATEST
>  	bool "Head of 5.4 I-pipe branch"
> -	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
> +	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
>  
>  config KERNEL_5_4
>  	bool "Latest 5.4 I-pipe release"
> -	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
> +	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
>  
>  config KERNEL_4_19_LATEST
>  	bool "Head of 4.19-cip I-pipe branch"
> -	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
> +	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
>  
>  config KERNEL_4_19
>  	bool "Latest 4.19-cip I-pipe release"
> -	depends on XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1
> +	depends on !TARGET_RPI4 && (XENOMAI_3_2_LATEST || XENOMAI_3_2 || XENOMAI_3_1_LATEST || XENOMAI_3_1)
>  
>  config KERNEL_4_4_LATEST
>  	bool "Head of 4.4-cip I-pipe branch"

-- 
Siemens AG, Technology
Linux Expert Center

