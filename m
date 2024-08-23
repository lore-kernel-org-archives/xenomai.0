Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E2E1917D0
	for <xenomai@lists.linux.dev>; Fri, 23 Aug 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432098; cv=fail; b=NleokQ27XHxjNDHoAbkeIbQrGv0DNWHlGW+AD3r6NifEMH3A3sMnMfh592HnvWfy2EaEBidcQxJbsk/fIE7B5vE7tR769sckCNe2JluPhmFKQ4HBD+98Szn5FOKvVVSjRAeIPaFcK6GDWzmYzIoI5D0Wd7svBzyu7qBEgYYonoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432098; c=relaxed/simple;
	bh=1F0H1CuXWAelCthUXaZM3nGsXx2rxJQxH7B3AQcQSBA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hH/94bEiSD73WvzAwNybOf1NMf7ghdUcHa0K/S6VI3365c+91rIk3k3bHuIEcXZKay3EbiFH7wg4zwop6AKh63pdKXBgEaMsK6zgQ5qL4ddnm8jzaKjMBAASWnPsEg8WLWR/rygGAcOERNZMhjQy36jYp/jwh1B9B30OywnevDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=FRPmSHTu; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="FRPmSHTu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8jGd45I9KCrfdnt03/B2JBOIsaKlHE4XfCRVl6wON0KTynkl8GMbTGfyR31+2ZDSooubUqwM0kDE1NL8eaFJtLEnoSRVHNQeFk5den5rsGj7ywMVZ3RtF2JNFuhke3TOGd7id/9SKGmdE3kZJoxwY2KNant5nj8b95RVTjHQBP6fzvaIbk0nHKT6ahjbFA5E38SmSd8EoJX/RpqodUkwsPESy/Ilf9bLcSyAm9jWrP1RWWL6WReoYWGRzx51jn0dMgR89umITWK2FAB/ahXZesPaJR6GfsaQnlXI5aJilPWeOOB2uMi1/0p8hgDTNqHtwc9EpruuzvoZt2oiMhiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvj0seRONYC6+33+3zxG/aOhOYFbYnkwS/XYvqa2VK8=;
 b=fBOAYmyUAWWoHbIxf5uwg9kb5XxO+6KOXWYlhdNR5ea9qihr6wTOOGuXKalLL4F2tTwNxFQHd3/KNdS64yZFI34X2duACEcQJdr2UoG5Xwah1AvX+xjB9AFpNu563XY6W3uxhOdUvTNIX19ff/eA84QK4UNH5N6e/ajL+jmkTaiVt6vFmIKK5Np0Cb/RLKCNtNM65FchQlufuZeEVKxalOfebd7D2gjmVwD0tI8svSJ5zWPwhD3G+h9IOR78fjQyD/3ekE8LWplmDy0KD6vf7OXfheNQr9NHpTRLgavISXEr/fDJXn4WldFi2gpVJUevr7CL0pSJkTXJ30QGgIMl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvj0seRONYC6+33+3zxG/aOhOYFbYnkwS/XYvqa2VK8=;
 b=FRPmSHTug78W6cL3yV/HJ2N5o/4SLMnYrlPIH1PhHFyYEn7AxaE6bF5fM6hYRRaqikDQ4EMFO2DhqPmaLfMIj8p1C+dwaUGzONgqShXVAq471d2+T/ha0FzALdNm0dtfVGZTlTJX+kZDtxB17W6tZlQma/+zpsm0FQZCQwoLGv4/10XdzcmYTim7wd9um75/S4vUt05ayQ6l5aTkDSiOWdyNjL69Z6+FHDNxkTcjrXn/062tX/kDAMQB9BmTKqXrtUs29a/VulLxFySgRTuOl5QKPuEcoXuSm2De+C9NjV2bmgcRuMmwbqsLBjvLPRAkOjkTDjUJvZHpg4Y0mXNbig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7690.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 16:54:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 16:54:50 +0000
Message-ID: <8e932f85-88c1-49fd-a5d8-6ab8af86e2f7@siemens.com>
Date: Fri, 23 Aug 2024 18:54:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH] ci: Enable Extension of Test Timeout for
 Specific Targets
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
References: <20240823145914.3587235-1-tobias.schaffner@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240823145914.3587235-1-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 81199d95-0d27-4a12-03ea-08dcc3944dc6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1BkZVRsb09FR2p1ZzJnbFRSU0J6c1htUklYTy9wWHhhNCtyenJldTVSWGEw?=
 =?utf-8?B?RWVmSkFRY3QvR3JqQjM0WU5GOUFqVVlnQ2ZMSFFoVENjVXh5NW1JZ2szK044?=
 =?utf-8?B?bFMyTkRSSHo3ZnRvdG5HeGY3Wklac0Z2YWMveVh3eVZQc3p0UzdTUkV3K3Zv?=
 =?utf-8?B?WTZDRkFaWFV5M1dLNXJDTXFrL21YNXdaLyttcDVFZzJqaitEU1FyUFJXQnVW?=
 =?utf-8?B?eElUdjFyb0l0ZFZHZ3l1aDUxMnNWc1huNS9UQjl2Uy9sbE05dG8ycW5SWGdx?=
 =?utf-8?B?c1JZM3djeERmWGdWcDJLVWtIckI2QmV0RE1vb2V3Mmp3bFByMWx1c3hWcVVQ?=
 =?utf-8?B?dTRRLy9JemxKZG5mWERmVlVKRkJCVEFMSzQ1Z1dCMDJZWlBuRDFoWHVLT045?=
 =?utf-8?B?RVNheVdCcFl1cFpESkxBMmsyTlpvdzFEM09QRnpRZmZYL1BBY3lmSU90QlJh?=
 =?utf-8?B?aTJKVXdyVk9sOGYzWjBLNGljMG4wZjZNYS96eHA1YktjSHZYQkxILzJlVGN4?=
 =?utf-8?B?NkJPQ1MrZUl6UjVYK3Zibzd1MFc3R2RaZmQ5SWVLL3ZIRzlTYzkyMER2bEp3?=
 =?utf-8?B?ZEVadkJ3dEIveVJZeVozVEhCNS9jTk1scFprWDBWeVhMeHYrNGR0R20vanlZ?=
 =?utf-8?B?OHZLUE4vTW50aUVRaXZvY3A0ajJVQ1RnVlpZY25XWVR6blVQZmdaV2pYRTJW?=
 =?utf-8?B?VDRXcStTQjlvZHJ5aThST0svd21IUFlIdVZ0emtOOXdWK0doUGFoTVdvUmov?=
 =?utf-8?B?eWFuWnBINWk4cmVKOXd0OCtxbGFOOG1YdTR2enhtZEdJayt3UkhPS2xUS3pV?=
 =?utf-8?B?SE5YVnRScDN1RE8zZlBPS1NXdjFmdW9XRWdCcS85eXEwNUM3Q0FwVThsT0VO?=
 =?utf-8?B?NlNUcUhVcjVlbVo5dmRKRmVnMSt6ZGN6c1hQVHltanZMZVhEMk5pY0J6UDNx?=
 =?utf-8?B?N3FaTlJjZ2FXMmY1L0xHOG8xU0RNanpralVpckY2cC9YT1NEZEhZd0xlUmRn?=
 =?utf-8?B?bkc1V3F6OXo3U2RkL3BCUnVseE9VM04xWkEzQnhwRGtNdm0ybEdEa0lrTkRK?=
 =?utf-8?B?NlFncmdRSVZvWVBtMVNFVGhwR3hhSWhPYjk4Wnd5SEVZS1RRNUcvNGpMZUxk?=
 =?utf-8?B?eUJObTZNcjh1ZEZTNWk5UkpTV085RXdmV1BSZGxnMUtSVGVrSXFtZ24wZFg2?=
 =?utf-8?B?eFJsc095Q0xrUmd6M2tFaWtXM0tZZ0dGTW1NR21CempvRHhZM0lTVngzMWpZ?=
 =?utf-8?B?Yjd3OWhWdVovVTFtemcyWkVEb0E5TTR6RUs3dzk0U2hEK2RBeWNyQXpZT25Z?=
 =?utf-8?B?VDVPcm9HVzdGNGhoam1BcmFsTCtwZlNuU0ZtVUFpdURtbE5xZWl2Zjg3d3Ir?=
 =?utf-8?B?SVhRTGIwSmpJYy8vNGhiNzM3SXdnNVdrc056anV4N1VNeGU1ZjBrMVR1NUxE?=
 =?utf-8?B?NW5PZDM3UzBkSkwrZnZLT0I0eHE3c3lZK1c1Y243UktadGp1dHJxcGNJNVl2?=
 =?utf-8?B?eHpPSjlxajBQRGgyWWtKOVk1M3JsZGlLWGVNNlNyMU0zT3UvaFFuT1greXVq?=
 =?utf-8?B?ZkdMQUk5N3BrbUgrRTVXN0pnVWNDQ2ZjY2ZhbFRkUDdlaUNMWmlBVUJ5Sjlt?=
 =?utf-8?B?Y2pMMnJqKzBYM1lMMjNTK2ZzVXpIdDNEZjFjZTVObUprb3Vsby9ZdGVXcFpq?=
 =?utf-8?B?WXlnMmU1UGw1Ym9DeFhjVjE5a0JhTEZEMVFPTFFZZ05Jc2RQZ1dJUmoyZVRI?=
 =?utf-8?B?dlRGRnpBZEhlVm1FNGhjRVJ6bTFtS0lES0I4SDl2RFBmcWRBbk5PMUlNZFFD?=
 =?utf-8?B?VVhxSFFWQjdnQzI3aUMvdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0NWYkx0ZUEvT0RZMVJwWmRjc0htWVFucXF4U3QySlJheVRjd0dEd0ZucUtK?=
 =?utf-8?B?L2s2MkEvMWtaUXBTNDh1TCtFU3gydHBjekF2K0J5TWRCaFRNZURGeVEyeXNT?=
 =?utf-8?B?WnBoRnlMTVUvMmxZS3phQjBoc2lkWDNyMVpVOXY5V2tuU0Y3T3NEVmZDSHEr?=
 =?utf-8?B?VFBEOEsrQkZqMVFiZFd5Q3Q5M0d6MlgreGcxdmtpR0UyS0RNdG5Qem9uWnJD?=
 =?utf-8?B?THFhRlNKMDM2dnJJQkdhYktoUlB5b3dCb1Yzd21lajIvQWxFTy9HelZBY09y?=
 =?utf-8?B?UFNWMTFaTmNIZTVJU3hvblB3M2ZXeERoVER6OUdFVHdpSXlWTS9YckNyczds?=
 =?utf-8?B?QitoNEVEMXpDWngrWGE4OFcxdm5NcWZJcU03bDFaNkxrMHlONmFMTUpYSEdC?=
 =?utf-8?B?bXkyV1R2Q2xQSVVGNllTQ3dZcFczK09aTWtnUzd4ZjllQ0NWdE5MNnJ3aEdE?=
 =?utf-8?B?Q055VHFDaVRiVUNkM29IMFBvTFpyd2pBZjVpcTg2NnNoZ1FDSVZkMFRjOGRI?=
 =?utf-8?B?a0I2TStLclpMeVdweUFWLzhuM1NUOVNVVlJhRll2b1dYZktVNFl4a3BBRmR3?=
 =?utf-8?B?VE5ieHVFZnVRbDExNVl0RTA0OEZ0NUpqQlM3bGlyQ08wd3huRGlrdE1laDZB?=
 =?utf-8?B?dzIyMnV4d29sR1ltdDlxOEhkQU45QzVyZWtwT1N5UUVyVVVJLzRjRVgzMldt?=
 =?utf-8?B?RHZoOFZJVEF4cDBJcVZtMXkyNHk4YUZtKzBmNm5lbEZyeGZ1c0F1Y3pSTUw0?=
 =?utf-8?B?M3RodG1SY2VCbXhTd2dxNFlkMWZkbzdzVGNRd0RPVDRwdTZLekNsSzNOQjRD?=
 =?utf-8?B?NklGZ2Y3anFVc2cyaE02TjE2eXlvV1AzK0x1TUprSjlzNUc2aEltWVdJMVBv?=
 =?utf-8?B?RlZMd3dBRTROU2lpSi9lZldtTG9GL0NHaTl1VndHVkFua2t3N0RDWG14T3dY?=
 =?utf-8?B?U0JtNy9KSWJkdFNsalJ1Nm13dlY3d0lsYlFDdnFHVUxoUng0MzFIZm8xRzJ0?=
 =?utf-8?B?S0x6eEp3N3pSU0t4dU1GcFd2bFduN3Babk5JWnpuNVpwdzVwYTI4NmJwWEgr?=
 =?utf-8?B?RFdNRlZET0xYUkh4ekY2cjVvam1tWDE3dDRiRVUwVXArazFhK1lsRTFRSEcw?=
 =?utf-8?B?V1gxZXYrSUdScElEVUZZUHlXaElkT2NUUzA0aXBZdU9sTzFqZzA4NEJ3L2lG?=
 =?utf-8?B?cVRoczRCWVJmV1RYQlcxbXU4aDIxWnhmcEJLeGdVKzk0VDN6YzNzMGtabVZq?=
 =?utf-8?B?dFhkRzNqUVJ4c3NrZTBiaWxwNjBKcVBhVDA0VExJeDRwRnN2UThDaTR5NUls?=
 =?utf-8?B?T2Jka0h6NWpOMHBtRkp4SjJIR0pIUWN2b0t1bDFEaFdmTUZxb2tXZnZKMnFm?=
 =?utf-8?B?cmFVd0VxZlA1ejQ2ZGxKeXM2b2dKKzl3aW9yb1NRejBDWi8vOHoycU02WkJG?=
 =?utf-8?B?NEY4QU4xSDhYNjVOYkNWTVNpTHptYmZ6bzJaT2pNVVYzRUZ0ZFR3bDZtZnFv?=
 =?utf-8?B?Vm8yUHJUaUVqc2FLdlUwb2Jqd1BxN0VrY3QyalFTMU4xM2JBczRSL0JvaWt1?=
 =?utf-8?B?KzUycEFOUTkvaDg5bnY1N1E3REJLaUQzQXNKUGh0Z3pnekVIMHc0am1lVllC?=
 =?utf-8?B?WVFYNjFTNGFWNEZ4THVGZ2lGNkw4L3dKN3F0VVF6VWJTL1gyQVBDZTB0ODNC?=
 =?utf-8?B?bWFJUVVVYUpYditUdkxiZCtwRTA4d2t4YS9PYnNTVG1aNjQ1WEFLQ3g4ZWNC?=
 =?utf-8?B?dzlxWExiYUQyd0lZUWEyTTE5WkdodndLSVgvTHdLT0tHM0cwK3BLVE9scE5Y?=
 =?utf-8?B?eEpzQkhHYUZ0bGhYZ1NrdWtVTndVVlp2RG52d1YrdEU3Y3lMbTRTdXR2ekMr?=
 =?utf-8?B?MCtNM3ZyMzM4L2pXQnVCT3dQWFRWcDE4cDBqdGtPdEhqWm9PV1VqQ1d4dHdM?=
 =?utf-8?B?ZHBXOW5wTFcxV1Y3QmppaEJNbmZOUkY2MnBtMWFTOThnc2xYc1ZWWFpFUDVw?=
 =?utf-8?B?KzBQVURML1NqTHFITU1lbTJ2c0RlWlZWMW5qR1J5TTRlQkdGL3NiZzdMY0pK?=
 =?utf-8?B?NDROUm4rVk9xOVZSVm84cGhWZ1l1bzZVcXBUWFZ6Q1BvRzFDWEp6OWJISmlj?=
 =?utf-8?Q?9UkFTqflQEE3O+JDp1KwIl0Kd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81199d95-0d27-4a12-03ea-08dcc3944dc6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:54:50.8065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V71j4c+dFibdX3gT21HOF8PaIuahR14psPXnCWhQcQsVFNTB6goKm3Sf942qAk+TE1DAQ9XOLmR3BZb8ErE/Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7690

On 23.08.24 16:59, Tobias Schaffner wrote:
> Introduce the ADDITIONAL_TEST_TIMEOUT_MINUTES variable, which can be
> utilized to extend the test timeout by a specified number of minutes.
> 
> Use this for QEMU targets that occasionally require extended durations
> for their memory tests.
> 
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> ---
>  ci/gitlab-ci-base.yml     | 2 ++
>  scripts/run-lava-tests.sh | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
> index bd300df..2936f18 100644
> --- a/ci/gitlab-ci-base.yml
> +++ b/ci/gitlab-ci-base.yml
> @@ -22,6 +22,7 @@ variables:
>    ISAR_DISTRIBUTION: xenomai-demo
>    BUILD_IDENTIFIER: "xenomai-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>    TEST_RUNTIME_SECONDS: 300
> +  ADDITIONAL_TEST_TIMEOUT_MINUTES: 0
>    TEST_MAXIMUM_LATENCY: 0
>    TEST_COMMAND: "xeno-test -k -l 'dohell -m /tmp ${TEST_RUNTIME_SECONDS}' ${ADDITIONAL_XENO_TEST_ARGS}"
>    SSTATE_LOCATION: "s3://xenomai-images-artifacts/sstate"
> @@ -114,6 +115,7 @@ default:
>    extends: .test
>    variables:
>      ADDITIONAL_XENO_TEST_ARGS: "--vm"
> +    ADDITIONAL_TEST_TIMEOUT_MINUTES: 15
>    rules:
>      - if: '$LAVA_TESTS_ENABLED != "true"'
>        when: never
> diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
> index 97061cd..3ac1be2 100755
> --- a/scripts/run-lava-tests.sh
> +++ b/scripts/run-lava-tests.sh
> @@ -38,7 +38,7 @@ lavacli identities add --token "${LAVA_MASTER_TOKEN}" --uri "${lava_master_uri}"
>  DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${BUILD_IDENTIFIER}"
>  export DEPLOY_URL
>  
> -TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + 10))
> +TEST_TIMEOUT_MINUTES=$((TEST_RUNTIME_SECONDS / 60 + 10 + ADDITIONAL_TEST_TIMEOUT_MINUTES))

Let's make those 10 min the default of ADDITIONAL_TEST_TIMEOUT_MINUTES
and use 25 for QEMU.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

