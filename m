Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F203594E
	for <xenomai@lists.linux.dev>; Mon, 26 May 2025 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748238230; cv=fail; b=PtwibuG6ts2dnRUql5GCBwIHXYktYUExRYuEGOidxYGBlN1CSLM1nktyCBIba+NTouyZDYKQ3Gix0E6WOl0VAUa6bEzPkJMpWlElOJKq3M4w9eVyf3+gE68xShHo2HBlRjJhQ49qG4OMdaidk6qv3pwMTJk5ZROWUP67xhcFyuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748238230; c=relaxed/simple;
	bh=pm4GBKwW+OFG+Hcc5cbvFnUcLxUR6vC/a8XzvDDAYZo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=exnF2btY9jmkFTmpunFUtp4HTs6yw7UlQo/alqI0TH58i3a8YFMVhn6MNkl7dr5dBttX1GpqxFD4CnhZK31oE+AXVxj4itn1DUNanQdNC4rgAT1RjSaZPCPryuI1qQd/pPbtarkwVpoi9kfFGGLkccCV8gbUS0A9gOX0XKlfoDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=TrBJIWC9; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="TrBJIWC9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgAuweJdIKBmQSXWTMXf54HuQZbIp22wlp8nDMsCE3EXEYPXxeLMwGQ0sRhp/IHBMtAjOfI6MeyjTMD/yzJ7kJGzrBuqtZuc9DuqnQkiM/1lfWA+eK7/hoPrVd5IxfbysrxFRHY68RXXvlTXeA3m5PDGRFASfFFbZBpJLLNGsa5yT6zOOw4xWZ1MkhCPNM6l+qjel9i4zpg3y2sv6TQ3eGbn7eukbwxPf65pf99ldALiDvsikHk/KOW/m5SVg94foPMrIBBy1xbniMjyJSFo27geJ2nGURfuuuYeL00D1jGTRjBeTmwlJzZooGrHKWBaJ94To0V/Rb5WGb7guEnm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TesHKaFAh78xTHSrwafqE5fQVJQEKzN+yQThbE8ND1w=;
 b=bqDZLAuXZkEbc4T8cB/GPskBCOTfkUjPm9Q2HZf46QivvFZ+8Wee+UxIjdFCi9cJqMtKnvEcNsIEQBabekq20u1mqaRdZJx4v0Efsxg1Yb64p9wRLjOywSISGyuLhdCtlOYsX0ruuyfd0KGgB/VxqNyoUvP3x66Psi5LgktzevUjdfI8lw7a2wPVTYOVZkhh7aMr/Mv7Z4eiKaD46JCKJe5wui3mnnywKxmJP+4wx+kLlQ8/3JSWI/ogYHHR99LRNZSb8mMy+EGmOTyrABboC8j57AdJ6U5wgsCq4G0Nxe5G6ivPDD3TBbU84CBCxzg1GwTMTiLgYhPzzDxG45fXSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TesHKaFAh78xTHSrwafqE5fQVJQEKzN+yQThbE8ND1w=;
 b=TrBJIWC9XcJ18WVNacHjUA6o3PzPtCwAWo+Rc1NNWcSphMXQs1NB6iCbisRP/y4nsVVBsotynpqoWJmIY/Y4OKF8KW1k915rNnEzaOJEb8BkUP7ImgfPScOePJq4NTYrHcHv+dq4VW47lCknTbt/X0IQWwUtnY9BiaLPmii7xWlCjVZ0nt3UEMCApnskNQCyGoTzy5VfkuyR3Ee7hsS7bWwCOmD2qrYiDo9ZYy79hsVBQ3rFiOQNUDyOXJhV8s5HR7QgnnyaUoQHegcp/5PzU1HraOgPLC6h9oQRhvkA/SbzGm4S5q0/eHqPNIJUId2EKgoAGLRKzwDbB0Fo6oMH3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 26 May
 2025 05:43:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 05:43:45 +0000
Message-ID: <73cde4e2-3c34-4db2-b1da-622e3a31b299@siemens.com>
Date: Mon, 26 May 2025 07:43:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/wrap-link.sh: Add support for -h|-help option
To: Haiyang He <aspirestro@163.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: xenomai@lists.linux.dev
References: <20250525080648.353288-1-aspirestro@163.com>
 <12ce1549fe564a2225490b7e2f10f8151fb2f790.camel@siemens.com>
 <991f7ec.2380.19707a1d2e6.Coremail.aspirestro@163.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <991f7ec.2380.19707a1d2e6.Coremail.aspirestro@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b183a1-634a-47a6-0c0b-08dd9c184801
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU43enJnSTZJem9sMG80eFAvM3lncjhKZjlLVUw0SFhVZUc2T1N2UmxvKzJM?=
 =?utf-8?B?c21aR2poVW96QStMSytDVWNKNW1uSFJDOU5ody90QnF6NTJ5KzJqajJPQ2VH?=
 =?utf-8?B?VTRPRitaZUoyUXRkZFpxWlNXYWwrZ2dBV3FIZDRuSk9pRm1IMmV4WUtVd0x6?=
 =?utf-8?B?cGR6b1oxKzNxdHE5eFE1eEV2S1FzU3FRM1Q4ZnRaeDFPeUUzSUhONU02YXRU?=
 =?utf-8?B?QUt3M2RiclhBUXRQRFlyMkxCNE1LQ1Q1ME00Yll5NEhKa3F6eHpadVBYQnN6?=
 =?utf-8?B?Z1IzZEwvSGtVaFkwYWszWVZuL3V4SmdCaThIUEFBMHdOQnA1UkZtcWh5K2tM?=
 =?utf-8?B?b2pRYkk4L0FkTStQQTIyNTZuNmJuR0w5bjJFblMvVGxMcmpJK1hvUXArZm83?=
 =?utf-8?B?cktGNjdBeWE4YTc0a0lYY1VtcWY3QTN6TXprbDRQeGtFdFVBOVBISHVHRjNn?=
 =?utf-8?B?Z3lMU2tOcFdXenMwekFSZUpWQ0JzVmVGdFVlZFlBY1h0bVVYQmN1T2gxTm1r?=
 =?utf-8?B?dWx5VWdnc29xakhGYjhRTmtmMXRsbDg4Skt3Sk8waHAwbE1wL0wvVnZnN3k1?=
 =?utf-8?B?OGhmWU9Rei9Kc0pRZFp0eGJsZ1JWY05tTmhpenYxSCtyaW9zUUZ3QkNZcEZH?=
 =?utf-8?B?ZjB5Qjl4Rk9TdXY2WTR2eWFwK2xSYlJma0JUcHFxTDd4S2xKL1FlU3pLM1hO?=
 =?utf-8?B?Y3JhdFA0RTMxbGZMUzVpTW1kMExNTzZickIvdk5TeFRyM1ROOVFkTFFidVhG?=
 =?utf-8?B?ZGFIWE9NdlJKY256YklUWS9CNCtEOUM5Rk5BS2FrMXdIWkFqWDFCMkVwNjBn?=
 =?utf-8?B?NXJLOWc1YTYxYkl1RllCaUsxRDNLSDM3cmlKT0NrNlhiU1NqSmVIVEZVOVRu?=
 =?utf-8?B?UC9VVlFmMXlKa1l6S3JBUzJvaEw1RUhHVHJ5UWt4bXYvNmdpbWQ0ZitHVC91?=
 =?utf-8?B?VHBCMXBJTTU3UGdPK1NLOFJDbmhPMUJqVkhuZlFIK1VxYUphSnY5bnRtOGF3?=
 =?utf-8?B?Z2dyYTNoTHJEZk9aYUhnd0VuQzRNbHkzUWFDU2dEbXVMTlkxTWVHTkdweHQz?=
 =?utf-8?B?aDdHL2JXN2pRWGljNmp6OXc1QmUwU01UbkJnUzZCbWRsTWFTdE05aEhsRUZi?=
 =?utf-8?B?VkVKdjhwOTdxWjJtM3haODVKVWdOQ3VYay9oN3N2U0ZIVW5FOGNXb2c5Ly9N?=
 =?utf-8?B?bEJQWnpad3hOQ0RhS0Q3MnhGdVNoYkx0a0drZnUzcS9EMkRaWWZrTERqV1h2?=
 =?utf-8?B?VVA1Z3lwc3I5bTlZMnp1aVlPNGJvdDM1d3FYdDc0aC9MNk4rYUZYalhEcFE5?=
 =?utf-8?B?NkszZTdxejhEVVpYQkNrWjNqTDhjYzRGazB6SjBMN25tNk9SOVU5aDdVZ3lJ?=
 =?utf-8?B?bkVxMkc5V0JRZ2VDdDNSZWtBZHR4SEZUMVJRNlF3UXlyMGlFamgxbEkzY25R?=
 =?utf-8?B?UTFqaUxFVkc1K2NOU0NhWW4wL3paQk1NV1ZubWNpbVVrQk5XblRWSGZNUm5l?=
 =?utf-8?B?ZmV6ai9DY1pwL1lVTmxPQ1M2OVliYXpndjFTUTRFYll0MGFMWG4vQ1hHVEth?=
 =?utf-8?B?RERYa0o3TVJoYlE0akRSV1Y5SnYrOGNUR2k3UDA2djRNL0lhRi84TzVSS3hE?=
 =?utf-8?B?UDVkVU4yNFN0Z3BoTUpZSGc5dDI4SU5ja1NoVGplQ21VQ0pwK0xySFV1K2tO?=
 =?utf-8?B?NHE2czhUU3JVWHdkUDhQSjFnQTZYL2Y2T2dVQkhBc0pqRTBWRFllMmZEaXdh?=
 =?utf-8?B?QkZmeC9hNCtDaGdqSXJ0d3JQVnVhZmRlZWx6V0ljanczMUNaTzd4TVB2eUFF?=
 =?utf-8?B?NnZzVzZqVUZLMXdQSG9nUWZHS2h0RGJyTy9mcUF4em1ucG1wQlU1QVk1ejF4?=
 =?utf-8?B?TGZjLzArM1I0TlBJZGlidkxJaGNtcmhrUDBuWGVVOVBDVEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU5xTTJTQjFQQXVNbi9aYlZ0cW91dkR3WXF4Wlk5aExGR3ZsNmExeFBvc2xQ?=
 =?utf-8?B?WXBjb3ZvOVhadG9pL0I5MFR4WVV0OXgzNmlmaU5aajBMNmxlMTJLcGtXMlFz?=
 =?utf-8?B?NW9od0lNRzl6Ykh1UWZpYU9LSXVJSFllbjA0M1BXcit6SWpHaml5YVRZYnRp?=
 =?utf-8?B?MTRwb0Q3dXUzWWNkaXU2MHM5T3VSd1dTUHhISGJuR3R3MElVelorempwcWJC?=
 =?utf-8?B?L05IYjUyY2RsVk1IMmppZXBWbFZheklEWEVET1FDZm1sVFNFbnlzb3l2U3Rv?=
 =?utf-8?B?aEFiNDZGYnBNZkkzeHROM0FhaEhJRENCUlJydWxwMnZZQUFpUVQ1Wm9XSjJC?=
 =?utf-8?B?T2M1Q1dsV0FkQUFhK04vSE9lbjF5ZytMNkZGMFF1WG00T0NxbkhhZTd1eHpr?=
 =?utf-8?B?Wk82dVhmOUJpTkxMU3ZNVGJpY2FJOGFLOXMxdnhIS2QwUlRnTnZzQWIxaXQ2?=
 =?utf-8?B?MlU5VHc5a2kwQ0drZTF4eUY0aWxqTU5tSy9ub1RvRnJMQ09QRDEvajAyWnVF?=
 =?utf-8?B?Nks1REpLTmtTZ25VbUNJVUJwaVYrZ2czbHBWY3UrU3RMazNzV3JZWDhGZkoz?=
 =?utf-8?B?NTVRV3labSs2L0k1bldTWWhqRjRINWtsOFBDUzlLelc2b2dmcWRDTXE4cDJq?=
 =?utf-8?B?TDNLV0NZWG1nUmhPY3FVcHBTS3dVU2N0Lzd6Z1hPcU1za1JtcHNLOVd2V043?=
 =?utf-8?B?blQxekd3VitVSFVCRExzUHNkekJmYWdsUHgwMVl4WE85aDlRU3lQVHVjNUY2?=
 =?utf-8?B?VkZzRk5VTkcwQTNYa1BwbTM1VVhvU0dnS0UwdzNHcW9iZDFldGxhdVRlbU4z?=
 =?utf-8?B?UU5jWkpxQys5NlZmRlhTRmJEdjRGd3NaY3VRaVNrNHh2aDhibjkveXpJOUls?=
 =?utf-8?B?Z1BDTmZITnpqV1hIbDBzZzk4c3c3ejJMU1RNWHZPNUFKT0dwQlhudC85VFkr?=
 =?utf-8?B?WkRsUDFNS1N5VmtmaWwzR25sOFpTOXhGcG5BTjFobXpaUmE3UWd3VkwrRTlE?=
 =?utf-8?B?OXp4TlRMSnh6c0wvbG45VWVlRWRjNkRmdzRDTkU5elNzWTRNY3VqYzc4TEFq?=
 =?utf-8?B?b1hRRGJuMVhSaU1NK0Nwc1JMTiswaDJPYkV2UkJ0NFFWdncxZndaZ1AvUmdz?=
 =?utf-8?B?WWNCayttNjlHWkZDVGlKU2NzTW9td2lhR0NjUVJKbjZwSGhQZWt3V2JhUEh1?=
 =?utf-8?B?clJ1RklXS3E0TXRDS0hXRGR4WE5pVFpHQTVGZ29qVkF0c2YxdHd2ZkxBWlBo?=
 =?utf-8?B?Q043VTRzMHh6b1pNaFhOMXcyQzU0MjdiZzVXK3I4czdnekE4U3AyL2ZTZzNJ?=
 =?utf-8?B?SG5HMDUvMDd3Y3Y5TFlpV09CVFlDWGJla1BXR0ZvN1l0VDVFeXB6R09PNmRH?=
 =?utf-8?B?cXd6a3RPcmR1YlRBVEpqOFBySkpyYythc2RFTXRiWGsvcHNtbHo2bjhqbEk0?=
 =?utf-8?B?U3VDYlF5UHVqMXpXTFBUaEhBbmFIcjBuKzZOSXpZL0drNTNNVmp3V21iM0RS?=
 =?utf-8?B?U29YK3ZlaEZRc0NwMTZZckJOMGhSZ3F2WDNQTnl4b29OYXRIZGg4MlMwbkFB?=
 =?utf-8?B?K2xXa01iNnkxVXN6UDhzUTJZS1dHMHFpclh3UXdsRFE3RUlkT3N5SGladXVU?=
 =?utf-8?B?RWhZYUR4WXN2RXNEdU1CWDI5OWlQZURzaXFCMEZkcTc1VHdvMlVrTUZDT1dz?=
 =?utf-8?B?eDlhbHIyN2x2dUJINkNCbVdMajRtNEJiREt4d0tZQzZLczJRYzV1dDl6R1Bs?=
 =?utf-8?B?ekpsMjdXMHVLMmdtaFpCMnJERlZRZ0RobDkxUTBqc0QzRDlOWTRoWjl1ZDJr?=
 =?utf-8?B?NEZCSFQ3WGpnRmdieE5Id2ZwS08yZUt1aTVsRkYwZ01TSmZZMFNmRjErRTV6?=
 =?utf-8?B?eDU5S1RTRGhqN2JwNmk0MmRtcFR1U2QrOWxueHUyZEdCdXIrRG9BdkRlT0Ni?=
 =?utf-8?B?LzlxNGF6ekFiNkdVNkZMVmRNMXY2WGRRYThmdlJwRG1nWDg4YU13U2RnSWlQ?=
 =?utf-8?B?V2w1eGkvZEJQRFRQOFEwTlAxcGQ2ZVFBN1VqMEtPVUx5V1dERUU1dm5YVW4y?=
 =?utf-8?B?cDF3SkZUV05sM1hZTlBHRmNaOGl4T2U5RjBCeEkvcGpXaVUyUUJVbWdQNTdI?=
 =?utf-8?Q?yZbdoOkUxY3UsHt5be4M2C1OV?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b183a1-634a-47a6-0c0b-08dd9c184801
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 05:43:45.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CqqzgcaPNowHI2mwOkP20Ku741XBODbQzoRR7vNE3BWq/OglpGNxPB1LkcEay/MT0iQ7xQvwPpg6DgBL70dWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5190

On 25.05.25 15:28, Haiyang He wrote:
> At 2025-05-25 17:51:32, "Florian Bezdeka" <florian.bezdeka@siemens.com> wrote:
>> On Sun, 2025-05-25 at 16:06 +0800, Haiyang He wrote:
>>> Following the porting-posix tip, add support for -h|-help option.
>>
>> I think the long option should be --help (instead of -help).
>>
> Well, it should usually be --help. 
> I'm just keeping it consistent with the porting-posix tip webpage.
> If the content of webpage could change, I prefer to only add -h option.
> 

This is a rendering issue of the webpage: "--" becomes long "-".

I've changed that while merging and will also update the website.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
