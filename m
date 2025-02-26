Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A484A2B
	for <xenomai@lists.linux.dev>; Wed, 26 Feb 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574491; cv=fail; b=umB3s9FbYXm55yPBFatAqj9nIDOhjLHN203sJawTMB7Bqv845DRWcseeiZfT9apO7foDOOd8ysa75OE4du4sJNtMIfMsZ4GfQP9HOimf7xrKepcVMoC+7fSOOos8EK2CnsT62uPCcHPwW76qGfA3c5aQpW5IgD9tNmJkgG9y/xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574491; c=relaxed/simple;
	bh=+eGKnbRONaJAFI7QgZL40iJ+UbuWiuRHpEb1vyNB7VQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPKv4nZJVnIhZ6pVXrt3CnE7p+SuirqtIqQAncA9otvQ+GOqrbukfjZIf65h9UalPMukIufoLCgPRTePrYMmDUo3o2/etvCkXVqroumAu2EIdTgystA3X+SXgEiHMhrsQ0YAVqwjsfQKMKlvUil4Dp1DODG3IcCpDMhgNriEw9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=SHLjQbH7; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="SHLjQbH7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4eHUpmCI30o6vyVDUYf6yJu/9tp+i6tLsY5Eigxna2Nh9rzsB70Qmk54ReghEfj49iRoU8q+mh7s+EFpSJtnVVxbBw4PlGtxOzXFudNszlSSDCYQNAYRP7IJjiNeCo/acG0gnhSSD4ZVXaJ8sVkgO543NK+bSt4SPds0b9lwHAHhSvJl4YWUR+QYWiyBeBsr1VxA8PAofa1RI/nCT4n5H+Z8FXZ3OTn7mQt3u0+nN5jVGa+QxDwHiMjmekl8yTEUQrrPIyywdDC+aIETbp1jK7Fk6ai4u5gme5Z4lagZy/H+0bgbNU+oi8MHoTa0LeNiJnaTtFHg/ORa83vZRseWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lmd/cZpXhPb7n9tM/CUJFNjPIhbkVFm8VqC00x5tjms=;
 b=ZDHUltJPKW1FDOQKqANuvAldbrH2xPyMBM19/y4OSxOWJZtnvAILC24Gc0WfC58zn0Etk2ZMz77yMVQg6EjXQBfzfpD0D9a/FwqXS1uIu3bybiJjDjUYha82pBIlVP/DAXoRLguVyRwHhTrRmDc/dG33nPy1uV3UOeQXcdmiaAwbUm/pz9BWcEe+OgdNVOFqXf61Ip4YC6CiIJU2ID56H5qC7PTrYTdT4or0s3qC4OEYf6LcixHZ3YlILSrorMpDkEWNympsV96PcBVd4g32G1OHTSBWD5y587cE899NNh1LJkhQHO2Sx/Fd8cthM7dYInAVq4LCrSuByf/STpgwOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lmd/cZpXhPb7n9tM/CUJFNjPIhbkVFm8VqC00x5tjms=;
 b=SHLjQbH72u4laEZEYYseo6lPiX3TrirmWM8a24j9OXUbBB1la/T0teBMHqsk81oB3gNu/jqBCv4eJy5x5S5dAdbf0mhbQ9U6vscInFKsp43kywj+905Xiy4hfpTPFMRdS97TGHHPkol2zb+zn63sNZma22cFBHD8qPCdLKjWN//fy1ZpKojx6/RLljiaJKHpKvhz9kJuzfQ+iVbcb6A7jer2SnG/xm7Rh1D7mdA5TipGuo9sj3hEqujz7KabeRT9qduJRtmvu7YY5GGwBD6yGoDncBiHbY3kvJ5tG5iG0plZ+EzkCMs+1VZeL7c/NCM5FSSDWfeG9ddP8XU9/oSljA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6661.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 12:54:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 12:54:46 +0000
Message-ID: <f542f588-d56b-4e74-9963-992c72335300@siemens.com>
Date: Wed, 26 Feb 2025 13:54:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cobalt/intr: Restore support for IRQ sharing
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Xenomai <xenomai@lists.linux.dev>,
 Johann Obermayr <johann@fam-obermayr.at>
References: <51ff9147-9af7-4f5c-9407-b7a73bd1d290@siemens.com>
 <CAFLxGvz9YrUh0_mh0H-_r0of+4JOKz7eCxRMX+7KRmmXs8ewcw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFLxGvz9YrUh0_mh0H-_r0of+4JOKz7eCxRMX+7KRmmXs8ewcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 6040875d-fa0b-4e6c-c203-08dd5664bf7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K09ISXBReFJqZlRLektVbWkvRnpzSVN3SE1Ud0t1dzdtMlFNUmhCTVdHR0tn?=
 =?utf-8?B?alh6cVdnTWlzMURmT1dzaStVdWlzQytCMkdHRW50QkYwYS9FV1d2RFVsNEdG?=
 =?utf-8?B?NlM4QnU2dW5ralVLZDZTaGJDcEhRVVFOaXVDN3ZjNGpLZEZ1OVkxTHZ1Z2oy?=
 =?utf-8?B?UksvelNHeFlCcmwvbTFiVU9BWk9ybFVZWUNZUlBva3M5TzhaVlNxeHRTRllj?=
 =?utf-8?B?R2x4TlFzYmZxSjMvVDRqOWZWcXdzY0hrYXFSZjZHbjdFMnhYaGk4VHNzYmNi?=
 =?utf-8?B?c1FVQ3FZeVpwbVRwaEc2LzF6UUpEU1haYU1RcGQyL1ZOMmRPak95K0tBMUp3?=
 =?utf-8?B?QjNheWgzMXBOSWtJTWxxcDBOMzJzK3JmY2FCakJKTWZKaFhUZ0pQTWdWRlB3?=
 =?utf-8?B?WjRVZ2NHZEttQlJhMkltWlN4Ym5hNFI0cEp0T29BWGc3Y3k1a0ZxRGNwMXd4?=
 =?utf-8?B?NmZXSzN6NUZPcEQ2VlFuV2t5SzhtakJ6aHB0MklSd2YxR1AvUWk1MHl5OGhU?=
 =?utf-8?B?S0pFN3FGN2dwRVVpM3RUNGZMOVhzektTczJhZXdUbWJ6ci9aaVc4eVRhcm9I?=
 =?utf-8?B?VUE1bVVOOFIzSVZ5K05rV2xtb3BjWHN1WUV4MFprK2dsQXhKQnlOVXo2cVVB?=
 =?utf-8?B?RFArNGdpZ01OVVRrVUk2RWxMamV6WlFKdFk0bFVCSWZjckYzcDk1OGtuSUxm?=
 =?utf-8?B?OXlWR1AxSTE4Q2hlZEVRMTIrQm85UGw3Ky9pQzVuNGJIWWVZazBxVklaN2ZK?=
 =?utf-8?B?cEhsNU1YQkJ4WURibSs1VFgyaU5mV2tnRzJ3RFFpeno2VUJEam1PNkRybzVO?=
 =?utf-8?B?ZkJoTmM2Ukd5VjhYUXhGWVAvMmwzVlNwdWE0WGFhZjRFcHJmYkVPeDBqUEVj?=
 =?utf-8?B?UXMzMU1vdHZudFV1RG5PWXFUcDNUajU4TkJOVmFqbmRxWDNicXYrckRDNXk3?=
 =?utf-8?B?R2s1bmd5K1dNOEZvN0FzUkxpUlEwU3Q2WlhjQThQN2dMVnlJSXVHWWczeXdn?=
 =?utf-8?B?bUZLYXR4d0pTSTIvTDMydHhYaFNieTdaa0hkdVlKaHltMEs1MVBwQ2tTTnNk?=
 =?utf-8?B?TlZ3M3JjbkJTMFdqRDZ6SXJMZEpzUkplUEpoK3Y4R0ExSzFjOGlxbDlmMFlE?=
 =?utf-8?B?TTZ1T2dtdWFnaVJhOGVWcTZLanpRRXd5dXZYNDNVeFlYUzZiNzhGL1cxbnc1?=
 =?utf-8?B?c3UyZllpTHFrZEl0b0ZTenhNT0piWDNKR09IS3M4a2w3RlFZRlJJV2VTc0NC?=
 =?utf-8?B?aEsxNER4aDdBN0RzQXR4bmJvR2VURDU1MGphRWY2cFZGM2lJVWJrTDYzZ2Jx?=
 =?utf-8?B?WGZBY3U1MlJCR0ZhZDFRbXV2Sm9MbFJmNmdQRFpUR2hWWUpYRUY2VVJxMzBq?=
 =?utf-8?B?dkVNRUxsQ2hLemNIUmJLeDV3OTZKL0VUUzcxTGtBZDcwM3RpSHEycS9RUXFY?=
 =?utf-8?B?NExoVEhaaTJxNnVnQU5XWUZEVDJ4SDRmTEJzSkRrUjQrRmM5d3dHTzM1R1E3?=
 =?utf-8?B?a2F4ZzdFcnlHd1pYUzNpazBvdlpWcW5qUXEraHRGUE5xenFhQmJzMDRGSllx?=
 =?utf-8?B?cjdPQWREWXBUYlBlQUx6bCtCcEc2clRQNmFSVW5XTVJCTmpaNFg5SnpoZ2F1?=
 =?utf-8?B?QTMyMW5VRGQ1S09YVUYrcWhkN1Jva0g4dWlNcTVhRm0yN2lBUzA4L21KWXV1?=
 =?utf-8?B?TTNuZ2FqZEtwN2VXOExLcWdERC8zaTJJMGxZcU1XZ3IzOWx2MjkrcnYzMVpG?=
 =?utf-8?B?TE9Da3RWL0dROVRxQURIenE3RVlTRU52YzFHV3hjbTV0YjJUSmZTZk15Z2Jq?=
 =?utf-8?B?djZ0bUlUY3h6SzFsa1JuTE1UcUNQK3N4Z1lYOTZnUCtXWHNZRzNDMDRteVdM?=
 =?utf-8?Q?rbF3dy1JB5bgK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkhXa2l4NW1ybTZ0V2Z0SVd3NlNjeGV4OU1KWWRNcGxqTWpBNGY4RzNjamw3?=
 =?utf-8?B?RUFZa0hCZm01M0h0S01DSTN3V0NqZGFSdzdzS1NiRWdyR2Q1ZmFrZ0IxTkM2?=
 =?utf-8?B?aVh1OElPQllaU0x0NkFvUnRGUVZKZVJjaEtrcjVObnhEUy9sWFNuVnBYN2hX?=
 =?utf-8?B?OGRHSHJYUTJ5T2REMkpTb21qYkJCMkZJRmNaUDZ5MStYSHlwUkY3Um10MlFI?=
 =?utf-8?B?bEtNZTBMbDh3RkRIQlkwRGQxRVprUWNvUDBFQ3NjVU1RUDBKRXN2NisvUGto?=
 =?utf-8?B?VW8yOUVCdVZweHlBNTVUK2RNNVErR2lrQ0VFK3R3am9ZMmVHUk9xMTJIZFN2?=
 =?utf-8?B?QWkyMXR0YUhUbjNpZDNETXgzZDhGWGJOdklhUVJxbTBCcEJLYXA5LzdSdncx?=
 =?utf-8?B?c29RWi8xd3gycjBYSFp6L1MzWTVQc0FFcFNEMURTZ016N2FYUlgySjhYdGVz?=
 =?utf-8?B?U1NEeUdUZmQzMm1raXl4ZmpUMVFkUG5BeXB4UHgzNFUvMnExSCt2QUFZeUQ2?=
 =?utf-8?B?VE42Smh4bm1UUDhFb2F1TzZzc0pBOHhOVTJ5MzRTUEM5NlNoMlIzaFRZa1l4?=
 =?utf-8?B?RTVtTUY4SVlYWnlOMkxVSW9lbUdJcExkY1JIL1dYNFYrRHFrYVZUSGNTd3pz?=
 =?utf-8?B?MC9kZFBhcCtLdk43QzZJWTB6NTlEUWJSRVlHdGFDWnRheWF4SHRCbzNHbnNN?=
 =?utf-8?B?TU5ucnRpUG1hR0pBTUlKUysxZkhlUW9JMXhNSFh1Sk1uTEl0WTBxVzVEaGM4?=
 =?utf-8?B?YWM0K0dCQ0srMWdENHpLQ3FQM3FIeUthdWlHQ0tveXEvRFh5UjNITVYvWGZU?=
 =?utf-8?B?QWVFdmFNczQrNkhHU0htLzVpUHkzdmVJS0VLZXBjVzlwY0RIWi83K0g2azU2?=
 =?utf-8?B?dmtVeFRtV2FhNDJKUHd2bXRkcWY0VWRtQi91QW0xVm1GTDNpK0plZ05qZVpG?=
 =?utf-8?B?WVpKbXcxZ2FaUnJFRzV1WkwzcEVlRGFHS1dGaUduZTFKcUdUT2xPUWlqSUNV?=
 =?utf-8?B?Nk1jRWtRU3J6d25pWlIrNGRrV21tRHpTY2xERnR5MDhXN3JmbEZhSnBzV3Nu?=
 =?utf-8?B?bDJnWFlaMWdKTUc4a1MrZDRBNGtySlhPNE9rUGc4Rk5PMGYyUWxwQkRXQm5W?=
 =?utf-8?B?dDI3aU9RMVEvTjBCL3JNTWsyWk1Kc1pUazMxejZEZklGM3d6cUozTHdYcUVi?=
 =?utf-8?B?aFNvTGZEd2lJSGFyZHpBMFk4U3hOK2dtTm5UdXRxL3g2dHVzWVl0OVREekdm?=
 =?utf-8?B?UVJJMitHV1BqM0R1ZVU5RC9ub3Boc2NETXVZTzBQMTBPSzBkWHNFdmN5VTJ1?=
 =?utf-8?B?VG5QUG56WVVPbXpVcGFhZTYyeHRuWmVhaVBZMHcwb1ZFa2VCb0tmdlRab3Zi?=
 =?utf-8?B?ZUMvOVBUc2YwRXVQRG5GY0dodGRBOCtxTmVVSXFxQmY0Q3hSSW9zYklGcHdr?=
 =?utf-8?B?L0pVaUJOTzN3Um9PbDZsdjFVL0J4ZlRuL3YwN05VWWRsT2ZJZlNXZG9OZkFl?=
 =?utf-8?B?eTFzTUhPVDhLbUVpTVJRdFdnbjd2c3NkZXZwdFBYZXU4U3lXNDY5S3NxU3E1?=
 =?utf-8?B?Vi9rQTJyQTBwai9GeG5aWVJSYmlnVU9ZMDlDZlR0NlAvSW93a2dqekRIT2xI?=
 =?utf-8?B?SmZXQkdhNVlzaUNhQVFtb3hQUDcyRldIMms0cUlFOHJzSWlDcEd6QnZPZnR5?=
 =?utf-8?B?M2hOYzFFRURSRGROL1pRQ2EzNEJYMEEwdlFWdS9yRXhEOEZ2cXZPTXk0R1VV?=
 =?utf-8?B?UE15Q0lPZDJQMTA0TjU0RGIzWUNhcWtQa3NuMDVUTko4ZU52MkFCUXZ6TGty?=
 =?utf-8?B?d3k4czFjaHVrLzg2eExCUm1BM1VpVC9YTU1SWisvQm5oeXNDNU56Tm1uWWpO?=
 =?utf-8?B?NFRTbzJXYkk3b3g1bitiMTVWQmk3ZGpDN3NZSlRscWh4MUN1ZEpHVHE4UFcz?=
 =?utf-8?B?aFFPcm5GTUlscEZaMURva1Fta1BzUXpVcG5uS2FMc3V0Q0xlRWVmZEs3ZDY5?=
 =?utf-8?B?U2lEbURhN1lyOWxEU1pIbVp2UzhYS2d2STFGTFNTRkJrOUdUODBxZzlLb2FL?=
 =?utf-8?B?MWRYSmM1VGVpcTZ0T0J2OUpHbS9nT1VBU1NSRlU3bWRvYzlqT1NQSU9OMWx5?=
 =?utf-8?B?NkhBVldjZkhQaFFzbk1LQStRUXF2VHFnTGU0TFIrdW1wUFNFdHJsWGk3RC9y?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6040875d-fa0b-4e6c-c203-08dd5664bf7a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:54:46.7074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNRYtRI9JfJrirRs3jwVyXvP/6gnstGPsopOehpsv3hMXE9FUrPAgP02A6UKeq6s0sMSbq8ZXIx4riyADa+5sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6661

On 26.02.25 12:11, Richard Weinberger wrote:
> On Wed, Feb 26, 2025 at 6:48 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> +       if (intr->flags & XN_IRQTYPE_SHARED)
>> +               flags |= IRQF_PROBE_SHARED;
> 
> Hmm, I expected IRQF_SHARED | IRQF_PROBE_SHARED.
> Why is IRQF_PROBE_SHARED alone sufficient?
> 

Look at the time when I sent the patch...

I only looked at the line that threw the error in Johann's case, rather
than at the semantic of the IRQF bits.

V2 on the way.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
