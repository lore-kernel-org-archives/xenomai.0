Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010020.outbound.protection.outlook.com [52.101.69.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D22AE6F
	for <xenomai@lists.linux.dev>; Fri, 30 May 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591738; cv=fail; b=p+W2Gs0EWYdL0ByRsyPzotcZZ6+T4svXcV32tbiiNGS9E1Qy3ppeRROTrbzdQAefhwiXyBpxIH6LCyUEykJV/2On9HPHzCyFSXoaaM8CbZcuQiytwXXBvwypdiig58Q4ObeOrvHUOw4EpkmNMlVSAAMVD0Ql5R5k7ZtLG9ZKrfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591738; c=relaxed/simple;
	bh=tF9ON+IPJX2VZYAb77m1fr0bhGqrH+MQ5lf0nveRW9s=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lrTlIOOKn5msWFocKtPVB7FpocmMt/X3iGZjIH5LgtJGYF2JdmKUfAjyovoZbKp1U+PIkDW6XKQMDWmRR+Lv7P13zMKiPFOou3o+tkyEOg+kRP8HVrmUy9CUzAN0IF/eT8wGx1TLGRHyv/tSQY3epQR4UK4UpgTNQEqnZpVjG0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=F8QkXKYl; arc=fail smtp.client-ip=52.101.69.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="F8QkXKYl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHP8zUPR1z7dmnMm5/gc6pgZOZwyWQjU5xIla0o4MHcnufb5q3naaj7+zoc8oKPHQNzbERRpLnJWSHJtT8RPnUm/4FW4Dy9dHL7VemVmJQI8rceJc331T86JJ+Ka++zPZzgVvh8EvBUcBF0Wmb1zKOUQNKX36SaFhUREo2y/zUJXFsgFwkJx8ENd+7C7UMlJNPyCzZlfZdlhNXi9oNEGtxAZVPCskWjNiSp5JHR6+hipBeaOIbhCYgEwDXwobgRwLmDHAZULzG5EGMmD6O+YkmNHLUOEWouBVwSzK8kc46BroYAn4/QFUKJ1oz6Q0EWE6PJ/Yy/fiWWymQoQo+A1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG4RSDMW0rr6loxHYAqUgfMNi/h9x6vd8eJweaulKNM=;
 b=P6FnA7gAlPYnfQbPpLEv9NcZZg5S1pYEnkfe+cf/0EZkISqR0vKgbKjCmx1bF6JDZQVfmySRU9w9QqPjVAow3ms2G6hYmI64vnkYv1OTvuayzPljP7dXqc4ANnUiSBT5BapCWYHTR130s1XR0B682MJj4hT/p9cYvLZk4+qefoc5Z5Rv0LZ3J4PnTBbU9u8wVKjSG7T8AN3gmQCINOHEZwn5EsN8KQ7M7hVWYaO2mG4udImTbR/RFGCcWtez+heEpLdF10Ah5nhlAAT2GZkEUUHJM6+R6mxgyue8kxTqfADomGzQ5LdQGxO9+ZtnqwifEkiJxWYDCwUXk4efghsKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG4RSDMW0rr6loxHYAqUgfMNi/h9x6vd8eJweaulKNM=;
 b=F8QkXKYlO2w5JaeZisQ1++VneQM5Kl4ffvS3Nax21dYX41Hxzhn3ErzSZ+yePcZM9FAwMCElne1Okm4a5O8MwWR42V719oMjFK3TfwcYhaxaK2sXBHt/RBy5/IILSTpitQUTiBI0JZPV8JgQZ2ze+rs7epEVj4qIvCSIeqyqhcoQgM3wfRoBRTUqsVi6d0bUo7UcOeCFO1goWst29Yv9P+Z0YVPDzzmZ7yarrBzEh6soV3zoqBKR5xgvz9iKBxaQRgq7W6WG2K+eJs9fGYrGmkEWJqw7g+eSoBWsxMUaJrVOQg8hfHRcqU5PgXAfQeLkPo8TQhrYawFvJDoUoL2LnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7335.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:445::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 30 May
 2025 07:55:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:55:31 +0000
Message-ID: <5b7a4ded-2147-47c5-887b-c400694c9eec@siemens.com>
Date: Fri, 30 May 2025 09:55:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Port of a RTAI based code
To: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>, xenomai@lists.linux.dev
References: <1d29632f21dc51b0f1d5434b8ccd16239bb73c37.camel@lapp.in2p3.fr>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1d29632f21dc51b0f1d5434b8ccd16239bb73c37.camel@lapp.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 50167c18-8ad6-49bc-cf1c-08dd9f4f598c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXZRbUM1TXZDdGkweTVETFZLL082OXRmTE5VQmwxTE9oYTBRaS9GRXlZaG1w?=
 =?utf-8?B?M2VobU4rR0Z3c0x5d1hWVDFKSWpjYzRyOTZhYSttTHdZbFZobWJsOFloOGZw?=
 =?utf-8?B?SFhVZ0J5Wkg3dGx6SGt4bWZ2UWUwWmQrcDhyMlpURjFmaDNWM3hoMEtPaUdQ?=
 =?utf-8?B?QnpJTEdZNWlPSVE4cU13MC9zWjlPKzRhT1NSQm52bHFtZmVldlZacEx6YnFG?=
 =?utf-8?B?Yk9uY1J1RHdQL0FjSEgvZXhkcitvY3lLZ0Q4RS9mQ2hUbUpCazRhSlVlR3RT?=
 =?utf-8?B?YVRkRTZjZEdJTWEyNkhEWTBseVB0b2YvTE9iUDJxMUhRSHhUN0wvbm81OGNr?=
 =?utf-8?B?ait2N3JQUUtEVGdvaDQ1STJiQjlWeHRlbUV1U1VpWVZXQjNqQWNrVFF1Q215?=
 =?utf-8?B?N2pIWnlIeGlTUEo3R0ZPZWxWK28xNklTM085dVlHNUpKeWMzNGFiY3BJanVH?=
 =?utf-8?B?NnlGQ2ZxaDFvazBKd2ZEZmVlS2t0UGhsYkMrMTRneXM3WUU0dXkvcXhLWThs?=
 =?utf-8?B?eTE5anhjYklablpOZkU1VTdtYy8yeUpMeks4SjF6VVNGcWU2c1JmSXNKVFky?=
 =?utf-8?B?VEJFdDh4K3dNdHhGMldycVU1WXRqbldTY1RoNDl3V0ExWXduSnhHOHNaMDJu?=
 =?utf-8?B?aTFkZUVjbzQxdTFzODRJSnM1V2RLZkR3bTJ2bWk3S0MxZ0c4RUhXcktvZG1m?=
 =?utf-8?B?clplaUc5ZUFSdHpLd0hqNWIwUHNvbWtWNjhSUk41NndWMjluRWFVK2xxRFRB?=
 =?utf-8?B?L2o5M2R4NTRBdCtLaWxmUEdjZ0s5ejZ6OXMyYTNHMHQ5VTh6TTFmdXFBTWhL?=
 =?utf-8?B?cEtIYUY2a1ZJMzI1RnVhUTdHQURzNW5LZmRIZlorRTVQNmE4UmNhSkkwMnBB?=
 =?utf-8?B?K2kxSFRUcWRHTWhyNnZPMDh4bnpyc0J0citzaHlnTkZzRzFBL3VBek5LWElE?=
 =?utf-8?B?ZGJhdCt1MjFkcWY4YnJldjdWVkpCdGRCWVA1N3dla2NKQnh3UTRyZm1uZUh4?=
 =?utf-8?B?dHJreWZoR0dDRkEzUm5nVm1peHQrVmdBL0pHRkVuaGc0Nnp6cUo4YTJWUlRr?=
 =?utf-8?B?SGoxa01ZdVhzYVZ0YmE3YlI4OE4rckdaRUlDcXpiNWpkZnd2U0ZSdENic2dB?=
 =?utf-8?B?MjAwUjN2eFpHMDlkdXV3TE0xMWFCK2FzWHdYSzQzTTZPMXFnWS9sMElEemh6?=
 =?utf-8?B?US9jOGxBcDV3ZzRxeDBUTUpITmxwL1ZlTnorcU5oQlVrOXFvNzJPVFd5Y3I0?=
 =?utf-8?B?UVZBUUZQQlpwWXZ1K05ha0FKRHlzUmtlSkRzTkx6QTI5eHBzZVdRL1VuQTBw?=
 =?utf-8?B?ZDJaeGErQ1hIWlhST2JBSjYzSWtGYjN3UzVuMkw2MG0wWHJZMmplNFRJUkh6?=
 =?utf-8?B?K1R5M0V4Y1YrWlAwTHBkQ1VJYkNiN2doV3RPVnUwZWk1TnUxOTI3YTM0OUd2?=
 =?utf-8?B?OHhxZVRqK2toanozMVlNTngwa0Eyak5xK2hSZUxENjRwVU1wOVpVTDhYWkFj?=
 =?utf-8?B?eTdTNkNkdXNLZUlXdC9wcDVtWGxueHJ0Y1pvaE5GcURsUGY1QUVGcFJ4ejJm?=
 =?utf-8?B?eWQ5ZUlpSjZzMTlrTW5PWmRhdGpSV2JpWndJSENXVDRFZUNNUlJ5NmxMZVhH?=
 =?utf-8?B?cXROQlZGRzlJd3lLSmpwdFEyRnRCeHNNY3F0QW5WM0YxTTVOQmM3R2x5eHNY?=
 =?utf-8?B?TVNqbGRYL21yLzR2YWwrV2lxRTBxZkYyNW1jc0oyZCs2R0c4TkNTMG9nNlVu?=
 =?utf-8?B?VEkvM3AyOXpUZENsTTlRYjhmaEpVT3g4YzFMTkJTZjRUWXAzTFRiZUhqaTEx?=
 =?utf-8?Q?/NkEq5WBRse/bX/1VU0Af3FVoInBjffDp97gU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDdJblRRRHVlYmg3bVlJYjV6ZmhrNm80WktseVZYcnA1SXRreHkrVjd3bHkr?=
 =?utf-8?B?M3hwbDI2WWdtV1YyZXI0RE5jd3FuVVNtZGx2NXpCRHlrV0hPM1o5UHNER2Np?=
 =?utf-8?B?RTc4S0RXRTJyMmVvb2YvaFNpaTZ2Ty9XaDcrazYzODhKamViMjJNamVxSXl3?=
 =?utf-8?B?cE5OaFdxMlQvclRYblNvUFBEcXh3WG04MFBiUXMvcFZVem5CTWc2djZ2bGdp?=
 =?utf-8?B?eUtTSHVWR21CcDRKOWlHam92VnA3cFQxZ0xKb2F4ZmlFN1BZWUZzMlQ4QVlQ?=
 =?utf-8?B?Q1owRkFGWWhEU3VleWVmcTR5Vnh5WWlOcXdEcTVFL1BkWFhsUWx3a0p0cUJa?=
 =?utf-8?B?MTU5WW1MRzJaazNCNzdJbGF1RElXY1Y5Z2tnSG05cjZnZmlETURsWVk1TTJ6?=
 =?utf-8?B?NER0cXYvTXIxa3ZOWTIwdmxCQWlWZm80cUpHRXZhbXRtbGVrVjZZUTlRdzc2?=
 =?utf-8?B?bUdIQnRFbkk4aUNPelQ4VW1jWVN1d3E0L3VGNDAzdlhGbzRiK2NSWUhlSGx0?=
 =?utf-8?B?OFFrL1VWY2pYVVRSZzFuK0dBOGoxSytPKzBxVnRaUmg2aHI1dTVpTjkwTWhL?=
 =?utf-8?B?VTQvSTRndWozcnQ4dWdIUXU2RXpZZGN1QW4wT241RW5qcEU1YytXM0JXRzRZ?=
 =?utf-8?B?a3JuVGRoazNMZTlyeEVpWVAybHJ3MlNwcFRNd1ZRT09wT1NhbnBxZFRQK1RW?=
 =?utf-8?B?MjdOdzVRUkNaOXd4cXA3a3hCWU91N2kzalg1QXJ6ZzBDV28vbmFzVENkdDYv?=
 =?utf-8?B?dGxPUXRoRVoxenEvODcwenhYY0Z2Z1l5dzBmdXBGbnZyQ2dYdFBIYUJyOUIv?=
 =?utf-8?B?WEQ3TURzYzMwdDJXZ05JNnIvSS9GZWVyRW9ta2RLaVRTaEo1R0NwaEFKZjRS?=
 =?utf-8?B?UkhaenVBcUNhb3BmQU1sTnUrcGVMR0hDQnFDMG5scmZDd3NtTmxSU2tlb2tH?=
 =?utf-8?B?NWUvaGFjaXVTQ2ZoQUxpY25rOGF0UjY1amxaclM4R1NBWWdTQktuZ3l4OEx0?=
 =?utf-8?B?alNYdlFiUWE3VEhjWlM5M0twWjc0NW1wMk40U3NzbVJOdGsvb09XTFJmQUxF?=
 =?utf-8?B?dGpEKytLeEJCeFNxTUhRYTJ6cHFKRnFPWkZmaXNFUERxQThNc044Z3hMRzdL?=
 =?utf-8?B?MUJmZ3NoOFZlN2QrN1N2bWNiQ0lmVmx4ZTFYZEJmSWhhVUFORWI5UG9qZ3Jv?=
 =?utf-8?B?VHZiZGZVV0NTSjVoZnU4cUoySTdJcXE0clFZK1JjTTZKU2R0RGFtalp4bFpD?=
 =?utf-8?B?MnJzbllxWlNGMmw2V0dpbDhEcU9jeUphUFk3YUxoUVJIaDNlWG56UVpwOGUw?=
 =?utf-8?B?L2xVelU4V3dMN0QwbnM5blZ6dXVGZ0VRQjgwNEpUQ2ZXZEVjZU9hN1kva0Uv?=
 =?utf-8?B?a2Iwek5WcDZ1bXFzVk5PVGxvd2lBdU1qcW9pcHpra2Fwajc2ME50S2JrR3U5?=
 =?utf-8?B?QUR1emlUd0t5R3V2OVNCbVJvOHJVSXVQMFVaUzloVU1nMG1JVVB2YUhjR2tX?=
 =?utf-8?B?c0hQNFdCTnhkNnNqN2NhZzRGdHVqS3JkcDdEQmluUElmait5S29ab1o5RUpk?=
 =?utf-8?B?MXo2L0NQOFBncHBjZEN4dGdwSWhRT2xCMFgyYmRObnlJRUoyeXF5UG9obU9Z?=
 =?utf-8?B?WWFFamJPNk1HUStrdEE1WWlEVGJ2aE5DeDdNYUs4cTlHRjg1VE4zQ3NuSmw2?=
 =?utf-8?B?dXAwUWhVSklQOXp5eXoyWTNZTVcxL21JM2JhZzlNMVFzUEJObVdPd1FQUE1r?=
 =?utf-8?B?ME1TZGRrc3hHRFJPc1JjeWVWZG10ZU13QnN2azFKcXJON214VVEzdjAvUGpE?=
 =?utf-8?B?Z0laOG1aeldBdUpQcDRZbWkvMmsrOXlUbEJuV1ZXcTFtWnJMVEt1M1MxMGtq?=
 =?utf-8?B?MmE3UjNRcjBEOG1JYjQ5NTZScDZzOXpiVk9YTFJnSVpNaW11eE4xVWNrRVE2?=
 =?utf-8?B?MGNCUU4xT3Q5S1Jsd0hPVVBPTkZ2MGRFRzBjWEhiSGc3UFVYdisvTmlUM0t1?=
 =?utf-8?B?NFdXZGlKNlptUHl0cmVNRUxGRkxRS0xpdVJjMWxrQWtFdU90SmEwSjBvQUxY?=
 =?utf-8?B?MmF3U0E3V25jaGVVNEtYL0pUNHdOWXFCbVdjcFZGeGZlMEZ1RVM2eUh1N0pV?=
 =?utf-8?Q?jNbQqUktvjGuEGm/WnlqERr+u?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50167c18-8ad6-49bc-cf1c-08dd9f4f598c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:31.1653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu2+FriMwkCCWfjYSDVzP/kSmvFzwG16Mlql2hBmm+t4SpqKr1UMPLPVdgBI90XqkI75PEwxlXbHUjGuRfW5Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7335

On 28.05.25 18:13, Emmanuel Pacaud wrote:
> Hi,
> 
> A bit of context: we are happily running a bunch of control loops for the [Virgo gravitational wave detector](https://en.wikipedia.org/wiki/Virgo_interferometer) since 2008 using a realtime code based on RTAI. This realtime code runs on DELL R7x0 servers, exchanging data through optical fibers using custom PCIe boards. We are able to implement loops up to 50kHz (data reception, packet parsing, computation, data packing and data emission). Each iteration of the loop is triggered by an interruption generated by the PCIe board. Data reception/emission and packet parsing/packing is done in the interrupt handler, the computation being done in one or more user space process called from the interrupt handler. It works fine, but the latest kernel supported by RTAI being 5.4.x, we want to port the code base to Xenomai.
> 
> The way things are done currently relies on the fact RTAI schedules the user space processes as soon as we are waking them using `rt_sem_signal()`. If the process runs on the same CPU, `rt_sem_signal()` returns only when the computing task is done.
> 
> In pseudocode, the kernel code is:
> 
> ```
> irq_handler() 
> {
>   parse_imput_DMA_buffer() /* Data packets are parsed and stored in a shared memory */
> 
>   foreach user_space_tasks:
>     rt_sem_signal(task_sem)
> 
>   fill_output_DMA_buffer()
>   ask_PCI_board_for_DMA_transfer()
>   acknowledge_interrupt()
> }
> ```
> 
> In the user space process:
> 
> ```
> task_thread()
> {
>   while (!stop_task):
>     rt_sem_wait(task_sem)
>     do_computing()
> 
> }
> ```
> 
> I'm currently working on the port of this code to xenomai4, trying to minimize the refactoring.
> 
> Would it be possible to obtain a similar behaviour using evl ? I understood the user space processes will not be scheduled during the interrupt handler execution. So I suppose I have split the interrupt handler and implement the process waking part in a kernel thread. But what would be the right approach to wake the user space processes from the kernel space ?
> 

You will need to write an EVL kernel driver
(https://v4.xenomai.org/core/kernel-api/) that implement some OOB read
or ioctl which your EVL application can call. That driver will then
block the application in the kernel using an in-kernel OOB mechanism -
e.g. https://v4.xenomai.org/core/kernel-api/semaphore/. The driver also
implements an OOB interrupt handler that will signal that evl semaphore
(e.g.) and, thus, unblock the userspace thread.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
