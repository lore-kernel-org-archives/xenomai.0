Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0213957E
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515492; cv=fail; b=bQz0mZvzE2ZHfDnCHhnSCHl2JtvK089srUkQRJbF8VUi0fwDugfyvePOtmSVqMlNIPFB0t9UQN7dB5UEl9SQOkZDJi3IFXeOVlmifE7Uup/Og0L8GWfF1TptbnYX8qbIp7j0wZ6DY3KF8Hbo1uwHjoIsnOkMI0gFuWMSii8gryc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515492; c=relaxed/simple;
	bh=vbe85gXa4I0ZgjhyVrmePu6rRfyQkg5+BAKx0CWPji8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d8YF7e05isZBrVOBEIFQM6TsiZPNw8AveLNFSn6z/8CWLoDIGPuiXr3h08osD1FTltYoawnBEABQhEBD6knUTbVEWACgHh3hPjnoldsouiDeXfqSg/A2Zx/XyjVprolf/9Moe4hx5bwyLe31+5YOfMr0SKDy3tuqL4Sz97CF2IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=v52unEuO; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="v52unEuO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLlUnIaUVNkJVfJVX6Fb47Q287SJbMB4sGi9LFXZRZo3xHpMyvOVVCN/B8SbTtkpQb/mAUSSJkgOGFPcr2dblNKtkRp4/5CMno39UtbmVshWmJamASC2rSPNLgeEZas5wKgkAOmZBZbUCtA35I3Kbf6MXhEZzk55+ZS3H+RgIDg+D/KuQ0OLJnt9teL9AfGJh/giocPwyw/UHDbuFEj5jOh6raagUB64LZeqJ1dUHKY7i+OQbwOKe3DB/2HIXP6wEqYmHZCbhLEn45r/7c46tlL1GRHKoAolidCN1DsJLqW+i2ouIMmJ31lsRcrJL7++dpZ7pnf5Gl95kRDLXIQRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeGCfkannAOdG3YCKG3537jBlSWDfA3hmiVRlHrjyGM=;
 b=xHdNByusWdqjBVuWqwsUJkK2krAay4RqLedkMtfEGyBLl6rnTKE+j5fPusd3mtjzPIfKLbjMZva45dRGY49hgeKp6LfLApzuVAayPhwck0iGmYdp4FMOPfxdpCSWp0b9KgFzE5JBiKOY76sk91EZoPwpY7nfxrF8VA7mSa7Pvm/JBgNhhTUGiEUoW79O8ObGyIyhkepnIR0fc23LCtKsCQ4b3f4KHnsIeVoarBeMFJqbxsMyAeAkT9/ecCo0Bb0XzibWL2fJ2MUu+cq1+47bh0qvDPL88gEAOHls1vWhqoh4CrfrKZDlycjXxAei9Zbmngb3i8BpWv2RxyGkmdHyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeGCfkannAOdG3YCKG3537jBlSWDfA3hmiVRlHrjyGM=;
 b=v52unEuO4+J9mz+8+/bE7PFkXB3se9G1iYRcFNdCKh3dOLTqOV/zDx21C6rkfak11Xz5Ty7iYj11BaG9Tkxj2LgR29EJ2V0FF0U/uelmSi+QmJiIDWQghCvn+ESCfVCl4O7GVGmckpLMHzvNA8eD+1+UXLokKClyyQ6kJr9iLc4WjjOiGVWhKvGkANvJUpAl0NvC2uvlEHqJ+J5jGthuvZS1w7lQq3ffWBE9mNmS7mPcRQVXlrgmCPeqmycDMkzTeBa+nBYOh4oQKmajKkcJZKIQUrqDSHeaChb9FQMaK2S0cZ/YrOD20gPVOY8/dTvgjrUZwVkB/phPC5AJ+5nX/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB8062.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1df::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:04:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 08:04:45 +0000
Message-ID: <8a6c0009-d926-4da2-90e8-cf644579ff5e@siemens.com>
Date: Wed, 15 Oct 2025 10:04:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] arm: fptest: Ensure that fp_regs_set/check functions
 are truly inline
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
References: <cover.1760374860.git.jan.kiszka@siemens.com>
 <f601ea1438f94ac28c28d6eaca0eab2eac0de096.1760374860.git.jan.kiszka@siemens.com>
 <ab02742a9249b19717a91c33572bad16efed73a2.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <ab02742a9249b19717a91c33572bad16efed73a2.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae339fc-6444-4438-2f79-08de0bc180c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHJtTDh1aFJZVW9wbDBybXh2YnpzVWJZcnplMGFNYVp0WmNRbkdtdC9hcDhv?=
 =?utf-8?B?cFhBUzdOSEVzTjBxTGFtZGJxanpaVFowUGg0Ny95L3Rpd00vZVhkSWQyRlFM?=
 =?utf-8?B?aTZOMktHSS85V2NzS0ExbUZ0YlU1TlZ3ak9iR0ZHRlNYK21NZ3l3V21DL3hK?=
 =?utf-8?B?Y0t0QVhmaklscnlsUDZHcjBzem8zTXFCc2RHVEx0dFBwSWpvYkpKVHg3bEV3?=
 =?utf-8?B?OGcwU2IyOUxpL2c1M2pNK0NwQ0dxaE5sZmFXa2wrY2xsK2ZOaG5PelNGaEM0?=
 =?utf-8?B?bG5YeDh1UG1kdHMzL09HdWxFNUhwazRxaU9DZmZEME01S2cxZStZcGh4KzlJ?=
 =?utf-8?B?R05JdDh6MkR5NGwxbEI0bFR0UDN1ME1rc0F5Q1I4SnRMbHMxWXJla1hSV3Iw?=
 =?utf-8?B?blQrUVN3UytlWHhLQThDTUw1QWViR1hSSmxXYm1SSWkvR0pSdEoxN25pWE5k?=
 =?utf-8?B?Nm9jVDhmYWdlb2phUUh5aUhjYjZYTXM3SnVJdE9iRlNFN2VBMFVrZUdWWitX?=
 =?utf-8?B?SmtBK3phNVZURGdBbzB2N2VGUSs4MDY0MDdoaW1hQ0gxWHpPb1J0Q1hjT1Yy?=
 =?utf-8?B?L2swWjNXRVBRczYraitFRjZCc1ROUm1obEpzL1V1K0hOS2p6bXVZZ1pXUlZ4?=
 =?utf-8?B?MURHNzZVMGtMYTkzYXlhRktFQlZnL3lwNjF2OXNVU0FvYUlJSmt2a3JuZnAz?=
 =?utf-8?B?VExLN2hiUGd1MW80TUoyRXVqOTIwMzZlWGNLejUrZ0pEUkY2VUdlUmZxZTZU?=
 =?utf-8?B?VUtISnJsNXpONUoyS1E1eThiSWsydFBSWklRYitZMm5nTFZPN0d4YS8zdEMw?=
 =?utf-8?B?K0Q5azNYT1JjbGFxYitZNWszc25CY242VXRHSk5OS0Vwamk2bm1zTFVneUJx?=
 =?utf-8?B?czV6blV0WE8xclloMVg0QzF3NnY5cWdvcHJHMkl1Ujg3Z1VCbXBWcmtFZTll?=
 =?utf-8?B?R3BkQmNidFpENDBzanZwOVQxUkhiTmNsbjNyMVRlbzFYdTMvMktGb25rZUpB?=
 =?utf-8?B?NnNZUnM2K0pCWExpYjlPTmRFdzQzeWUvU3c0MU14T2RCeDcwZlgzamRTWFpt?=
 =?utf-8?B?aXN3MzRSNDQ2SjZ2bVlSYjNaMUVuZXdTTWRGbWFzc1NsOFBhUkc5dDZaZ1VI?=
 =?utf-8?B?ajBLMFEwRjdZWG5ISnptUE9URkpiWnY2UUNhclg4Mm0zWGxZcXRYRlpiVngx?=
 =?utf-8?B?MmN1am52Zy80ZWh6aGQxTDhBbXpqV0M3dW1rUFRpd0plYkZJUkhqT25TZEVk?=
 =?utf-8?B?ajQzTldBSGh4RXR4UjR0ZlVFb0puQlltM2NOVXF0NGhOWGwrTGZyVTY2K2Vk?=
 =?utf-8?B?K2FoNzZTM0Vvd1VId3ZOZVc5V2pKaStOZEM0Tk1GM1U2SlMyR0kyQUlmU2dX?=
 =?utf-8?B?VUlVbXZVMmFDdFMxbEU1QlZHUDlCUTMyTTBPVkl4VzJOenNDUW1jYUNhRlRI?=
 =?utf-8?B?Y3dzbWJTYUFoUWxQYkRyWm1aazBQU3pGMWNSTW1VaUYyTTh0TnN6bTRjSitF?=
 =?utf-8?B?VVhzazI0VnNySmhzZTdibXNNQ3FWeWxrcTc0SnUwczkyY25ycUpFOHVuUS9k?=
 =?utf-8?B?dXJBMWRwTENMeFNPQ1JZSjdscTRiS3RoMnFYMkplS1JVdnJuUzdqWWJTUDV2?=
 =?utf-8?B?bndIWkFmWWxXZmk5NDRCTmxHWDlDaHZ2ODQwNkJySXBhd284N1VGR1FlQ2I2?=
 =?utf-8?B?aTA2WEpYNjN5NFFONzBwVEZpTysvT2ZIMXVUT29TMGlMYXhMdFI2UmlkN2lo?=
 =?utf-8?B?cUJ3WlJZSnppLzNMWWNtbHErN0lQNUYwN1l3U0NFdzRxelhUTmxYUHFZYVI4?=
 =?utf-8?B?bWV3Z2JqSkNGNVoxbVc1dGdYRDBBMndzTEpjYmpyTWhBM3d5cTNQYkJldVo0?=
 =?utf-8?B?K0lIamo2bEw3VEd6REpNRldiVEpyeDVQcE9YNDhFeGFUNkRsREZPMFZCaVNY?=
 =?utf-8?Q?/2NpeD1IOrYOYdU2/wbQaPJxl/YWPLYL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHBpdEMyNlduRWg5bVhYT25TbzdvKzEvK0xTbnJLYjdEV2prcUFCRWNTYkhp?=
 =?utf-8?B?amlsa1cvZS9sZWtLbFYxZkErcFEwWW1FUFFaeVZ3dDJwUWxQM3FVUmlVVlZa?=
 =?utf-8?B?aVNjKzhNS1lCUm5paUlaSzNXV2dmWVovTnRIcmxFTGoxblNMN3RxQ0ZiNERZ?=
 =?utf-8?B?VGdmc0Nhd0c2U0pSaFNsK1VRWis4a2tTblhkVjhFTFR2WWFSSEFjVlNtdXZq?=
 =?utf-8?B?NXNobEJvSG5wUXZ2WmJrRytvd2tVNElKeUF6WGNZNlVzKzVZTnNhcDgwdlNP?=
 =?utf-8?B?eThBZHRDRXFLa3MzWStYYzBWaXQycTkxK2h5bTNtSnNVLzJWQ1RrMUVYVDhZ?=
 =?utf-8?B?MWE5d0VNQlNhUVEyZEkvTEpjNTVyMjRkcEgyQ0Y4NUxRSjhsdXBZTlpHQkpS?=
 =?utf-8?B?UDZyQmtEN3BhaTAvZkZPUkx1UWs3RVgyZVl5VUVFS05SSjdSRytUNk4rWXNC?=
 =?utf-8?B?ditDZlJDL1FxaEZaN0VjY0g3aGJ2OHFMWm5uRHgzT2ZiNnFkMlllQXRCUXJB?=
 =?utf-8?B?K3RTNFlUZ2ptRXZmL3BiT0FnbjNORUhDVkpOa1NEa2FDekE3QTdJOHM3NnA4?=
 =?utf-8?B?TWs3WGJjd3FpZ0J2WGphVTdFbHBYM2NIaCtwcnZoVnR0R29pMC9qTUVFeS9W?=
 =?utf-8?B?QXZNb2psSmgwbG9IdytwaVpneFk2cWZYOEVRTThjMTFtWk5IeS9ySXJJRHpj?=
 =?utf-8?B?aGxYZWRjZysvWXJ3TDJXZVBLUE15aUhwNlBFTnVwdDJFSnBJZm95a1hxNUov?=
 =?utf-8?B?MVZhc1pQV2Z1ZE90UXIxM3FKbGVWMFZhL3N5eDVYSXVYelZPT0lHNFQ0dk5q?=
 =?utf-8?B?bWJpV24xRy9vWUVqalBzaUxNa0xMaG5yWS95YVg1R3J1L2laRnF0UkYzdXNp?=
 =?utf-8?B?STFMQjJua0tUNHF3Q1RlTkpmeVpIV0cxVEkrVEJTamY2eEt5K1lWOHVJUDl3?=
 =?utf-8?B?OHllaTAxbG5YYWtoUlV6d2VRdXJIaUZCOENuRnpSbHJJSVFQejBJTi9vY0RE?=
 =?utf-8?B?dmdHdzQrNWJkU2NhdDNiSkN5emdZOWZrcDQ2N0taVkxiTHRUUm4wdmhBZVVI?=
 =?utf-8?B?WUEzeHhLdzFxVEkwK0lESHBKbkcxZEo2a1l6WXJRVUx4dHJWNHFaWnpLVHlF?=
 =?utf-8?B?UmR6SGtpNHZMb2wvbXk5VS8wNjJYZHJ0UjVwcU84Nm9DUWdWRHFiN0tGbFE4?=
 =?utf-8?B?R05LVmJlM1M0aElQc2x3Z0ZQN0tHNC9yWEJ4bVZRSWNWT0tWYllieHBNV01W?=
 =?utf-8?B?Vi9RZk45SEdDZ1FlWGFRK2dnbnB6eXczbFhwa0RSK2kwbmR2SllzWDIzQjBO?=
 =?utf-8?B?RTQrTlY1dTQvQkhMM3kvMFNjbzdwSjhZWlIvb1FyUFdjUTNxS2lCb3A5Vmtl?=
 =?utf-8?B?V2FzSTRUOVIxOTlzR2dQNHRwMCthRlUxZjhIbk8zcS9GaTBYQ0N1MTVyM2NK?=
 =?utf-8?B?ZUNURmxmRGgwR2R2WkFDRGMrWWxVdllPYlM4WHBPOFhOQkN3QllEbGkvbmE1?=
 =?utf-8?B?VkJ6ZUx1Q25tYlJKWkl3dm9JdVI3V1REWnZGVGR6dDVZcm90UzI0VTdvaUMr?=
 =?utf-8?B?d2RNazRRUzBtSTg1K3pCRmxYa1RtV2Zkd25jaHczZDcvOHp1RWtOc3ZRTHNv?=
 =?utf-8?B?QTZKUzBPTE5OQ0pqT2ZpeFVmSkw3cE1ObDRGWW9jUWgrVXlNOHZKWk1xekNq?=
 =?utf-8?B?TmZNb0cvRHRTL0RpaDVRSmlwRDQybDBtVWNuanpuVFVPM0FkblBhMjdhUkxJ?=
 =?utf-8?B?YnVlMHRLRmwzeTBadU43dkVFbitaemRSK1dnNGxUQVY3M3RnSG51TlJKbzJw?=
 =?utf-8?B?Z1k2cHkycHRiWVJkeHBEN0Z0S0U0bWFxVnVrTHR4TnE0REJIZ2JrVHVUVVRs?=
 =?utf-8?B?QzZiMmxNK3J2a3J6ajFva2czNzFnSU9ueER4dVhPL1o5d1oxeFFRSm1NUmlW?=
 =?utf-8?B?WDZ1WGRuK28yVy9tMkk0TlVhcExNaWk2WGpVK3RCVFBaOUxOaWNUd09rS240?=
 =?utf-8?B?dHhkL2c1NGlrN21nbnJ4MGkvU3lPYTMrRXZJMlRqcFdGSVM5ODR5SE16ejJW?=
 =?utf-8?B?c3lXeUdmd2IyM0ZRZlNzQzM5dDR3aEZQbllqMlMvWjdobENjTndsWUhLdFdO?=
 =?utf-8?B?aG5lZXlqZUh6cUoza09JVS83VjJidkFEc0JLclpzbkthWkRGSVpRU0JpSmpr?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae339fc-6444-4438-2f79-08de0bc180c4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:04:45.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUfWjeDtAz+CkI7FJcLnYyjhzO+5FsEHOQETmV/0vdHf0SiYs1IwVLtljHX9MNnhEL+oR7w4gC7OPDFE7xZzUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8062

On 15.10.25 09:00, Florian Bezdeka wrote:
> On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> If they aren't, d8-d15 will be saved/restored, and that is ruining our
>> tests.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
>> index d5c2c7515b..2b21bc5f55 100644
>> --- a/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
>> +++ b/kernel/cobalt/arch/arm/include/asm/xenomai/uapi/fptest.h
>> @@ -20,7 +20,8 @@
>>  
>>  #define __COBALT_HAVE_VFP  0x1
>>  
>> -static inline void fp_regs_set(int features, unsigned int val)
>> +static inline void __attribute__ ((always_inline))
>> +fp_regs_set(int features, unsigned int val)
>>  {
>>  	unsigned long long e[16];
>>  	unsigned int i;
>> @@ -41,8 +42,9 @@ static inline void fp_regs_set(int features, unsigned int val)
>>  	}
>>  }
> 
> Could we use the __always_inline macro from Linux here?
> 

This is (also) userland code (uapi...).

Jan

>>  
>> -static inline unsigned int fp_regs_check(int features, unsigned int val,
>> -					 int (*report)(const char *fmt, ...))
>> +static inline unsigned int __attribute__ ((always_inline))
>> +fp_regs_check(int features, unsigned int val,
>> +	      int (*report)(const char *fmt, ...))
>>  {
>>  	unsigned int result = val, i;
>>  	unsigned long long e[16];
>> -- 
>> 2.51.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
