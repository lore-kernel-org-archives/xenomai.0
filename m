Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129B306B12
	for <xenomai@lists.linux.dev>; Mon, 12 Jan 2026 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234750; cv=fail; b=LMHKEDNFpusfUlVZ0L1KuajTyounYol8x4ry0quks2rsXWKRYMe2jMtXQEfZSIbwG3FPEt9sTMWeJKlk1XvAosaRGfTRoxpc688Cswj+vMQ6gDvuxHPeNZIgVVuu1Smem5zRZIVJmsTNy5SlY387R9L4cZgALUp3PEJfEZT+u+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234750; c=relaxed/simple;
	bh=6KXJ5/Jx/d5zi7PBH84gc9Bh8eFW6lvS8QYI68BBkAQ=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qhIHr3yaObw44lyB7YbUMZ8bjiCdQJ10hexRgCpGF3Yw4O/HXL43jKwU+zsvo9norffXYsnOzBSMY3XJe2ngabRzhEUrvo7hUzcFvHrzaK5diuKbeAJR71id/bA9HrnP2qBhrsJTbTGrnRFrAZUbR6PC4ET2RTPI9UW8ocewSQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aVgtTfA/; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aVgtTfA/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+Gp6Of5tMuj1z9RHE1hM+1jIowXol2kjOBJsyuE3Lf5KyzEHuTFTiBZu3S5kZq8fY6ovXJyOMoPMkhCtAO0Q/mBOeRKgWhfZYwnXVZo00qJQqu3r2QP0Zz1bokeLltscf3JJ6QaPBp343K2HlJKuSPLS+Q0FE6fQMhyhrqDylfQKytqFN6t8oK3pCntz8OXLFKJ1IEhvAmEnFwujX+Fcsrfc5SwaZZ9hJpchJir1n6l+urn4PxU6iQBLjL8IutO1JSUz2tpwYMVZZNlQohYTDIxrYgd3fGYz/FAJLz068lle+YcLp4FFoc4vZJqDbucIXMD62X75vNyg00+JcpcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08YW7WirM4xrhsajB71F1SPnVg2YdFuaGGaIkuY5//g=;
 b=rZE2nV9OJWRCUUgrO8HajhhPAgyfDDsUGqhEc7xSPPILEDX7381DT2TbvpcN0qTojluR34Efwx5J/U1FCR5OJVtn+xN9Oq4IGzkKywGwGL9YFmNUYnWSnwo12RprbsfckmdCjUsuqx946dYFy1gne9zSN6ebIZct5g5P4huZZWw17eJPOfAi8kEOr3qkCV0AmpaX+jJq83m9YrveItK2kz7GtfUIRuw3VZF9UeYsMUqEIBWuSxG5SOLKDBV/SZmLn34EEmFTH/RTz6nEt8mpqvnsEXKGwaD4+39lOguWRK5ictPJN8SrswIRv+jgOWOr9S0u2LfXRtaf5tYkM6D63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08YW7WirM4xrhsajB71F1SPnVg2YdFuaGGaIkuY5//g=;
 b=aVgtTfA/GGE00Vp16Pu+tLUvtGINPvTHv2Sm3bfDWfWsaze+RK168gySJkRYJaW88qf5lRRe1rMDJKqOSK553eycWCuJN5JPYxNZ+GVNSqABq00sB/eeObNzUVtdxHUmP8xXN0gwegS1PgbYj7hIBXkGFY4/o12SyzJqGWoRRpbV6+udE0mbXXoMu78PMTT+az9Ygw9rA0W840s5EvWoVLIUzBP5huIHew8MYnlv22QyywYnhJNdcc5TogE4GP6ipfdfmsVYq+GLFWSaDyMVlGP1/XXmZGn5oNm781NV7iseBes5sqH/0wB1kBI56xv+2VZhTKu7i+V7MdF0hP0mwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 16:19:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 16:19:06 +0000
Message-ID: <3f9b3e63-c94e-4482-ba34-63ef0110cd10@siemens.com>
Date: Mon, 12 Jan 2026 17:19:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [xenomai-images][PATCH v3 0/3] Trigger CI job for dovetail
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Clara Kowalsky <clara.kowalsky@siemens.com>, xenomai@lists.linux.dev
References: <20260112123349.3945734-1-clara.kowalsky@siemens.com>
 <6648e0df-6b8f-4cac-b050-90e961d1cc49@siemens.com>
 <a65891c8-90fa-4923-946a-c6a3830dc75f@siemens.com>
 <9586e808-89a8-4495-9543-fa9b1ea52fc8@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <9586e808-89a8-4495-9543-fa9b1ea52fc8@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: efc8b585-c62b-4e4a-082a-08de51f64ee8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cThzSEF1UnBBb0pnY2JmdzVGaEl6djBYRzg3Q0JMN2xiYVdsMTVrUWh1VTF3?=
 =?utf-8?B?L1hqQUc4UmtNcEFxdjJUTDdtQm56Q3RtVk9JZW1XTnMzMlNkc3IrYnpQdG5y?=
 =?utf-8?B?cHNpOWJOc0hZbXBOOW0vYWE0VzRxNG9WdU5Ta2dwOHZ6RW9tRGVycDBwT2tN?=
 =?utf-8?B?YzhGazNyYmxsRHd4ZzhiRVBKQUxWWUZ1UUU1andRa2FyYUxVTnhmOFFZa0cw?=
 =?utf-8?B?Uld5dm1LYVZHU1k5Sm1MaS9vWUd6Ymx0RHoyaDVoODJLbFFTMUw2czcvTzFB?=
 =?utf-8?B?Q3dNQlJ0Zzl5Q0MvMGE3Z3pRWUc2anc1c1JjZUR0RUt2NHV4NWxiRFBJVTRn?=
 =?utf-8?B?YUVmOFZQWWZnMjA5VTJrS0Vld0dtdGZ0VjJOcXhnSWdRc2dUSU9wRXNUbDB1?=
 =?utf-8?B?T3lmV2pJeFlKcnhtZThmbWlUN1EvVm12ak12TUc0RW1pbUZqWnZRNGcxT1k4?=
 =?utf-8?B?Szc2SEl4dFRqNFowMTFnc0hJTG5BSVBqVFFqZm02S3lzZzNCWjV6NjJHRSth?=
 =?utf-8?B?Um00Zk5YTDlwaUdwRlgwVzlNNmxoc1dhc0NjNkFjQkpUZE4wbTB5OFY1Q0tO?=
 =?utf-8?B?bGVNbDlzMjFQc3c2ZmlUYXBRQWtTRmRyMDJKcDN5ODdGS3VyWVZHSktzWUVU?=
 =?utf-8?B?OGVOYlpMalVEb2swRStwUjhxL1VUd21FZUFCUHYzMS92UGluWStKVGRMcWZY?=
 =?utf-8?B?UTNFUnZQOFpWRFFiVXU2UVptV2t0eHpTSk9rSDVLNjNTblQ0Umxjb2NQYXFX?=
 =?utf-8?B?RGNhWFJYYVdUZTRmazJPMElHQnRzMHd0bm15MkNyeXRCWTF1U2hjTVIxZXZx?=
 =?utf-8?B?RzQ4alpTZkk5R0Q0b2diNzZxelYzajNJZkRhM3NvNWQ2VkVUNDlIY0ZUK3NE?=
 =?utf-8?B?eW14cWlBT2ZUUUFtYnFaVVFLUFR0UytRWTlvWUtzZ3o5dmYrV04rRndrcitz?=
 =?utf-8?B?bWZRMEZEZng2RGxNTSszZWhselU0RG9jbkR1dmdpVWQrUXZjWE5PaEoyNUxC?=
 =?utf-8?B?YVhhNDdraTQ3SzVBeHpoZVltR0NYRU9UM2FMbVdlcFNBRDJaNVhSY0RKcUNy?=
 =?utf-8?B?dXErb0lQajFISTVCVnRkR3dyeE5NM0VoY3J5eGRLVTJNenNsdEkvVGd0ZW9x?=
 =?utf-8?B?NmZXKzYwUlJxQXh0YWg0UXpteE02R0NPRjBROFB6anpXU2xxL2hSTGNLVEll?=
 =?utf-8?B?cjFzREZDc2pHaW0yNmVyVnFrZDE5Wms2VzN4RWlnbjJlNVNNRjljVWIxNENK?=
 =?utf-8?B?TEI0bTNiSUJOZUlDQ0crcndkbktNZnRacWI0VHFWRzNpTkhtWmZDY09meG5P?=
 =?utf-8?B?eVd1c3UxYjlUL0NCWEtkTHpsN2Fsdmo5dEtjZDBjNE91cXhjZTdtck1OL2Vn?=
 =?utf-8?B?bVhEbC9CNCs5TlVEVzFwc1pGS2JteG1RU1VjVXc2RE0yUDRuaXF6ZkdTYUdr?=
 =?utf-8?B?MFYxZ0NPamFwQ0V1Sks4OFEzNTlHNmY4TmwvZHduMzNqK21CQlRMcVFsZkU3?=
 =?utf-8?B?cjN5OXk2aFYzOFROdElLMiszZnFIS2dwWU1zVWZ1ZkVZVU5tUXZIeXRtRHpX?=
 =?utf-8?B?emZkdFZLa2VaQkJnWGE4aUlwTFZPcFQ4UkFZZGZkbFJOTjR6WHRRSnBvRjlC?=
 =?utf-8?B?Wms4eTFmQmNCTGRQa0NnR2FzTUQ2ZE82RWhvMk5WZHQ1TGR5TmR1OHhKQkc2?=
 =?utf-8?B?YTA1b05wYWhmZXNBZFd6NDVlcE1wSkYvOUxvQUlqd1F6MjdCeU9NVnBGSWw3?=
 =?utf-8?B?TkFOZTlnQ04rT3o3SGdTYjlOUUwyT3htNWxWZXVHY0VDbWlLZnY4RmI2STBp?=
 =?utf-8?B?dmJXcWNNU3NqMFowaXh0RWowbEZuazhDNytlbFdIS055eTY4VWNnRFRCYlBa?=
 =?utf-8?B?OXVWV2d0NXE3T1FTS3hMQnZwQzh5MTkyc3ZZcHdCcHlKbnpBU1BOZ0FydGRB?=
 =?utf-8?B?b05CVmt3Y1BFY3A2dHczbGRJdXdiTENCUDNrLzJBL3R6aU1HcE15RXF6OUQ1?=
 =?utf-8?B?WUFuSTNUb2p3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2lzRVp4aUswelJjZHJJSFI2aTlrVHZuVDAxQkZPY0taUDZyeDZtVHJUMkpK?=
 =?utf-8?B?RWIxZnhldURIcmpMSjMraUNxY2FORlNEelpQQzczdGJkd05ocDFwQTR4NXNa?=
 =?utf-8?B?cFR2eGh3V2hZMjdnWGlXaXlMaVJXcktsczhja2NIdzlIait5QlNXSjNKSGJV?=
 =?utf-8?B?YXBPMnZsR2h0dFZ1MVdUTkswSFdnN0JhVGRaZ2k2WGtuMmR0amlLRFdWMlQ5?=
 =?utf-8?B?dVZNZVZBcVlPaC8rZ3pubWJ5WFBYdVRDTmgvb3BQMWIweGdxMDJwM3lMS3li?=
 =?utf-8?B?YW8vNDI1WXE0bDNSZlB0eXpqVUJabHBpMklHdUI3aEUrMnc2Mzg2clh5aXJt?=
 =?utf-8?B?R210a29yaG9rdXk0R1crMU5MRWZhRE5KRko1WWF0NjY5Z3hSQ1dKamFZb2F2?=
 =?utf-8?B?Zy9HcUJaL0pxSzFacW5BZmQ5UEJxOWdiSWlKS1pYSTdMOUgyYm5WRXp3cVNS?=
 =?utf-8?B?M3J5M1kwbXFPNXF4T0x4dklCaVlSWWhTUTRVN3MyN01CZkFGTTh4OFpjRWRU?=
 =?utf-8?B?K0luREx6V3k0dE9oQlc4UllLRnQ1OUlyOC8yM2JrejJtMGU0S3hoY0ZVOVE2?=
 =?utf-8?B?MVovL0JtczFJUmdPWmd6L21CL2FINkZ4U0xNVU5EY1pna3g3RTBjSm1wT1JW?=
 =?utf-8?B?eXB5NTRqVCtUdUtlcWgwKzkxU3pHd0VMQ1EvS0g4dmJXbzFVdTRlcjg5Y1dz?=
 =?utf-8?B?cjhGcTNoZE9jVWNWMmx1NG9lenkxL3NGWWtJNHpyZnNNV0o3Q2hsTzZuN2VR?=
 =?utf-8?B?WjZJaDBrQTF5WDZaTWtrSEZkRTBSeEhuenE4SXUrRmFGRmJRSUNBTE5mdkVr?=
 =?utf-8?B?UnNwR0ErSjZxUFV0UzQ0Mkd4aG9QRVlrbXdwT3BTajBVR0t3U0VtZDFJM2tH?=
 =?utf-8?B?dTc1S1JXSXRaZEl2TytPVUNva1k4L3M1cmRmWWlodlpkMlJqb1pzQit1WUhz?=
 =?utf-8?B?NHFuejBsMzBPcjFRQy9FSmZiREhqT2d5Qzl2TGhRTmxBcm9CcXQrNnU3Ukdp?=
 =?utf-8?B?RlJkQ3lReG5FTDdXUGNEMTZEdkdYenVvdFZJcVZWTVozeXFFWjR0RDY2VDNn?=
 =?utf-8?B?azd1YkRlYUV0NlRlckgydHljOGtURG1TYmtBUG84TjhSNGoreU5BYlgwWmZl?=
 =?utf-8?B?SzhydDVUUDdPTWszUzZzS1lIS1lFUXdlWENVUWNYQ1FRVHRBTGY2cGhKT2ta?=
 =?utf-8?B?STlGSkFDYUg1ZlMzYzNFUWFxT2Y3ekkySkNoeHMzUEJsaFErTyt4eW0yQmtt?=
 =?utf-8?B?UTNTU1duNGw4UklRZEpjRTFyU29NT09tbGl0TXVxZWxqOGxpaDVTMDBDRk9a?=
 =?utf-8?B?c0I4czBJYksrMUw3eUhqckNnMjRVMDg2b1BjRzQwN0JSZ2tSSmR3NGR2SU01?=
 =?utf-8?B?T1pSK3JDQ3g0UVpPUVlpMWxKbmdJMTdndUk2Z1l1ZmUwQkQ1eE1UZGRzK2Vr?=
 =?utf-8?B?Q0NHSE5jd1pUbW8zR2RTRVJmWGs1YitrOXBCRVcxM1JJRjFydUxlUU1abUZG?=
 =?utf-8?B?Tlo2U2VjT2tCcUdmdFpXNW95SzlwRlgvWUxpVENtYkV2SWN2TFBSaC96cGJh?=
 =?utf-8?B?NGdiaFNOT05jbFhvaXFtQitHVElPcDR6Qkl6U0ZFK21aN1lLWkdQdUR1Wi90?=
 =?utf-8?B?NDR2aDRKVlNhMjJYVmhsV2ZUbFN3QWp4ayt2QUlYNDBQRCt0SFloSmZWSTZo?=
 =?utf-8?B?MnVqRDBaY3BqanhVeFFHcUFNcGQ2emphaUVaK001V0IyREFCOTY3NmY2and1?=
 =?utf-8?B?aE5MaUt4S1c4bWZSaXlpZjIwSjJYZEN4Nk1tcnNYcExUYzltWFpLOFErQ0tp?=
 =?utf-8?B?YlZTSWdseVFlYXNZRUNGZFR5Z0R0YzBaelFaYUN5YmZzWmFEa2dOaktxODgw?=
 =?utf-8?B?ekJadVYxQkp2Y0o4enVHajFiR05RbFRObTh4SXhMY1hteEJCKzBwRTdYbnVH?=
 =?utf-8?B?aDNBcTN0Ymx2eEhVdkF6OXVoY1BzZllVQmh0SmphTENNQVZqS3lFUEFMaW16?=
 =?utf-8?B?cXFMR2VGaDh2Q3QvSzk2M21oUVBOSGZRekk3ZklOQ3RwVXZ0SGxHWUI4T0VV?=
 =?utf-8?B?b2piTkhzSDdGWkNPc0VwSVJVRkIwQmRXUVlzamtRT0pTclFSMGx6VnV2RnZh?=
 =?utf-8?B?alhRNFhNT2Z0ZmUvck1BaTA2czhaRlF5KzlFZ1dhM1NoSmR5eXRkRW5kVkVu?=
 =?utf-8?B?aXdHMlNFMHdjTmN0bXdrSUE4ZnFTMHdRV0liaWhRVmgyTldkTFdCNE5UdXc5?=
 =?utf-8?B?b2JNQTFpZWwzcEZhanBwUEJqekJhd0doeURiSzB1cEpjbm9JU3VtcWZVR08y?=
 =?utf-8?B?blczdmZ2d0o1MUoxNnZuT3RJOHdGakdoQTc5OWFrUjIxUGVPQU1zdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc8b585-c62b-4e4a-082a-08de51f64ee8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 16:19:06.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi/blq9VwO+VyEyxjdXMllNpkYC8IOwJOg5XhtP3CAcdNv5EZLU19qMAAKnTUJFcK/gY4p6chfhSoVCw/MlYBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7068

On 12.01.26 17:07, Jan Kiszka wrote:
> On 12.01.26 15:52, Jan Kiszka wrote:
>> On 12.01.26 14:11, Jan Kiszka wrote:
>>> On 12.01.26 13:33, Clara Kowalsky wrote:
>>>> Hi,
>>>>
>>>> this adds the functionality that if new commits are pushed to dovetail,
>>>> the corresponding kernel builds in xenomai-images are triggered.
>>>> I tested this for dovetail/v6.12.y-dovetail-rebase and
>>>> xenomai-images/next.
>>>> Thanks Jan and Florian for your comments in v1.
>>>>
>>>> Changes in v2:
>>>> - removed 4.19 handling for now, as suggested
>>>> - in ci/ci-dovetail.yml, add a comment that this file is configured as
>>>>   CI/CD configuration file of the linux-dovetail repo
>>>> - in ci/ci-dovetail.yml, use a debian:trixie-slim image
>>>> - add commit to rename LATEST_KERNEL_VERSION to KERNEL_VERSION_WITH_QEMU
>>>> - in ci/xenomai_3_dovetail.yml, sort kernel versions and rename
>>>>   templates
>>>>
>>>> There was also an issue that the QEMU jobs were not triggered in v1. 
>>>> KERNEL_VERSION_WITH_QEMU is now set as pipeline variable, in order to
>>>> make sure that the rules in the .build-qemu job are evaluated when
>>>> having the variable info available (by setting KERNEL_VERSION_WITH_QEMU
>>>> in a template previously, KERNEL_VERSION_WITH_QEMU in the .build-qemu
>>>> job was still empty and the QEMU jobs were not triggered).
>>>>
>>>> Changes in v3:
>>>> - the v2 had my test branch in ci/ci-dovetail.yml
>>>>
>>>> Best regards,
>>>> Clara
>>>>
>>>> Clara Kowalsky (3):
>>>>   ci: replace LATEST_KERNEL_VERSION by KERNEL_VERSION_WITH_QEMU
>>>>   ci: Add build job for pipeline triggered by linux-dovetail
>>>>   ci: Add CI for linux-dovetail
>>>>
>>>>  .gitlab-ci.yml                  |  8 ++++++
>>>>  ci/ci-dovetail.yml              | 47 +++++++++++++++++++++++++++++++++
>>>>  ci/gitlab-ci-base.yml           |  4 +--
>>>>  ci/xenomai_3_3_x.yml            |  2 +-
>>>>  ci/xenomai_3_dovetail.yml       | 39 +++++++++++++++++++++++++++
>>>>  ci/xenomai_3_next.yml           |  2 +-
>>>>  ci/xenomai_3_next_long_term.yml |  2 +-
>>>>  ci/xenomai_4_next.yml           |  2 +-
>>>>  8 files changed, 100 insertions(+), 6 deletions(-)
>>>>  create mode 100644 ci/ci-dovetail.yml
>>>>  create mode 100644 ci/xenomai_3_dovetail.yml
>>>>
>>>
>>> Thanks, applied to next, and I will soon also configure linux-dovetail
>>> accordingly. Let's give this some practical exposure.
>>>
>>
>> Ok, here is an issue already:
>>
>> https://gitlab.com/Xenomai/linux-dovetail/-/pipelines/2258056311
>>
>> We are currently missing a rules (and also recipes) for that kernel on
>> xenomai-images side. However, the same will likely happen when pushing
>> any of the merged branches (e.g. v6.12.y-dovetail, instead of
>> v6.12.y-dovetail-rebase). Those pushes should just be ignored rather
>> than raising alarms.
>>
> 
> There is unfortunately more going wrong:
> 
> https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2257965129
> 
> Looks like as if we are not building Xenomai-enabled images, for
> whatever reason. Some magic variable must be missing, some kas config
> file, who knows.
> 

At least some XENOMAI_BUILD_OPTION(s) aren't making it, see logs.

I can drop the top 2 commits again when you have a v4. The renaming
patch can stay, I think.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
