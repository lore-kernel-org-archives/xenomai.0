Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA1E1DD864
	for <xenomai@lists.linux.dev>; Mon, 28 Oct 2024 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127984; cv=fail; b=Rfe7adle4iVH+b5lgBNw7o+B2li5S7/T0323o5dp4cBbaPnF+7F8F7JzZQ+yrATx7rPyxpMbFlkApyFQg1+D63HM1V4GOWguizrku8WwmQQYfYZ6fDLFqa0zbGUugQd5DzN7GFesaWuYRkgbo9Gv3d9uyBeozJkUh9SlM7GUGNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127984; c=relaxed/simple;
	bh=hIsCu2xqgqul3vzBoDH1Vjm2VhCGPRzrcuLs1WXYElw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ulykJevWJzllz4f0DOQNFWPTKO0ONGfV/w4SaOd1B7bHnO16IGtes586yt6WfjNpnGnYS5RG/5zHfBXcOCLNDfokykHIe8mQroUHiKLRpzBEXeZDOjsxptWGag1Kd7AxAC28t9eiS1IraPNmNm2vNWlbyvNexfZvizhSU6v6250=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=CwFVtXps; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="CwFVtXps"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIOIqV1/joTn466fkJmp8ZZpTPPOgS5aV7SBhz935e8iLDhMdwwVcCt/G8MkWq3NwDozq0wBvb7kTFgPWz3uQIqqho30gUhnFgF9j3aPGt4w+apgB1SzHkUIXCLKhgGWctCuYepm9od2l0/VwBvgdH8YERKk3te9qAiXbr4CehmNRQVQSaJAv3fMPtNxKXUg2vG8NLA2fXELu3llk7z7l0h3cUM6l3LZnjzFOcLu+dsVmdT2SauPwVyk3rdjN5nddObsnejVyq3MViK+JCeaN0lOyN0KColYpnYsohvIrtYXhhDF/OAYk7jikYZkGCZk/1UG1AK8qtYxAkL+paOymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xANZrhvmHLtA5ge3B4bu7eNZ4zMCDo7qgxNsuLxEsuk=;
 b=JrsYXNhTcQH+i0Vgkj6bMnlhtPDVCUa0/oycAFIstWs4DdrlYryQ3thSzbQhcPaauTrXjC2fm3t1IKUQkiWWaTOBFOqGfaSOPkMp2gzSZ/Gk3xKSnlhCIAbl0xKq6DYO5Sn1GN/+az4YzQ/RbBOQRQQ4sd0JM85uVUplg7plLp585yjq7eVAr3GB7Pq71k8+hJQDS3/0m/++FVOc0ArBbVAij3KYeBPh4yKMm36gzaD/v/UijH3QGJ3A6XtWDWu9JBSGVDrJujwDV0P8vyTVOdSmZd+R42HYUq1HIjeqO7J0umS0nz41mc7POv4vtRH5qKmDms4Soh2fOhYsbK59DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xANZrhvmHLtA5ge3B4bu7eNZ4zMCDo7qgxNsuLxEsuk=;
 b=CwFVtXpsmhOZTJQqr21k3ZgFS9NLmNgkbzbixoFeFxe/ltmfalQa3C3A3R+4mArepSaU6psf3mCtY7N9OXD2lkIskldmg0e3TQfXOs7dC78QJVehthwqvVZff8wyUjwsAmnPNJVM3xCFhD1Lmitw6p0kZtjSKYQmrigCaa8jo8X7zyMvxSWCo045Cpe/2azy43x2gJ9KCnjUvQCzhQrPCYlNUnU31PU0m4kOGk6i1shY4sMA1R094ElZbX2h8aty8TqOPw+rV2EZC7NaCj09eE/gOW40Inh+u+yQAb2G5t62A60h0xJ8kcwz1WlCcd+H/YpGeyf4sl/wdZDcQFDMMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.15; Mon, 28 Oct
 2024 15:06:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8114.007; Mon, 28 Oct 2024
 15:06:18 +0000
Message-ID: <a30a2750-38e6-4a90-9b5e-17670ca8a6e2@siemens.com>
Date: Mon, 28 Oct 2024 16:06:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel/cobalt: replace unsafe strcpy with memcpy in
 hash_symbol()
To: =?UTF-8?B?5p2O6IOk6aKJ?= <liyinjie@sinsegye.com.cn>
Cc: xenomai@lists.linux.dev, songjianwei@sinsegye.com.cn
References: <20241028115903.1727776-1-liyinjie@sinsegye.com.cn>
 <be618cf4-7a8c-4e00-beda-f65bc6a278d5@siemens.com>
 <769DF691-AE8A-4CD5-9009-BDED1BC41C9A@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <769DF691-AE8A-4CD5-9009-BDED1BC41C9A@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 0632fe76-dc84-4ce2-38ad-08dcf762133a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUpuNFVoVGxKU056UHlmK3VtdXFUSDlCVnN1WkF3Q0NNcEF2QTBBNTZZZ051?=
 =?utf-8?B?aWdObmU1MkJ3Y0xTMHZiMzl1WGlyU3hNVEFZejUwU1lOU2FzYlJvVHgxbm1Z?=
 =?utf-8?B?dEludGdITzFtdEJnbU10MkpjK3ltT0VmcTdOcHRDL040SzNXL3RWZER1bmpl?=
 =?utf-8?B?WjBtRGpPc1dwSFpmdHpINlovcmhzdkJHcGRKTlUraHRXRVBmeW5hQ0tDdTZX?=
 =?utf-8?B?ZGxvTGR0d2ZBSTlVbVY5Rzl5ZzlTSllvcTdLMnd1S2tXc0FuQkNSOXZYcWVZ?=
 =?utf-8?B?dEU1R1pkZnNxK0EyQUN6cm5xUGczeG00LzRtbFJCQTRFYjIzRFp1NkFJeElq?=
 =?utf-8?B?Z0ZMWmlCSjh0d3ZIU1NWVTQ0TzFFMGs4aFFGTVkxcUZJdmlWMisxQkNrSGxo?=
 =?utf-8?B?ODRVMncxZDJNZTJPaWRtMHViRzU5NWtGUUpWeEVHcUVNN200ek5IOWIreU5R?=
 =?utf-8?B?T3U5bmxNbzd1SnNQT1RablRoRk56RFJYWnlrdDRhTWhCbEdSaWJkVnVWSTJR?=
 =?utf-8?B?M1NVbktYK0RCMkNma0VpMFBzdFhjak5lSEc2UmhERnVRT1pRYTJ3OEMxeFVT?=
 =?utf-8?B?dGRGUmJHVUFrbG9ab2JYQ2xaVjJHTW9pQVNydE5RZHY1ZGl5cDJkZjh6OVlh?=
 =?utf-8?B?T3MwYUZoakdXeWlCR252Um9LRXc2aTNGb01QNlRUc3VnWG9PenN5cnNhVk5N?=
 =?utf-8?B?NDZ2MTJ1ZzlzN0MySFQ0ejd0OUwvQXA4dURHRzJ1RjAxRXp3cFBERXNKOW4z?=
 =?utf-8?B?V1lySDRJRjBUbHhiektCeFJtR3A1dkI5bHkwNG5NOVlXOVZUWlpOWnNwR2pm?=
 =?utf-8?B?Yk81ZkZkblpOWTlBRCtwbmxCK01FKzNWVWYxaTFwaks5dDgrSDcyUm4xNHZq?=
 =?utf-8?B?TzczU2Z3KzMvUkhpQms0ZlByWHJMaUZLWHI5S1VQM29qTDFCcW95RUc2RnZp?=
 =?utf-8?B?TXZ1aE01M1hYZlZNY3V3U3psSFJ3SWNselJmTHN5dHhOMFVBakZaSVc3Q21V?=
 =?utf-8?B?Mmh6c29PUlhTMUt0U3cveGhDQ01GeGpjeUpjK1dQK2Y2S1hHMWFlczU2djhR?=
 =?utf-8?B?RlVWU0xmS1Q3YUgzT1NwNkFiRU5sMjE1NitxWmdnV3JMSkVPbzk4dzFhVm5K?=
 =?utf-8?B?YlBIUkRNc2VZQUU3UW9YRmtJM0RJYk1JSy9VUkxWbGFCczdpZi8za0dNZGoy?=
 =?utf-8?B?NWhxWUZ3aFBGbW5jODBtTjZJZWVoRjNjNWZNMFJQekcvZVVOd3lWZEVzQXRp?=
 =?utf-8?B?Wjk3aUhFdEJSaGo2MjhUTkIzOWJmdUZHMkh3R1FmM3M0T0JVSVZqQk5mME1j?=
 =?utf-8?B?Qk5aazM5VTFBcXQ0VnJ4bUt4TERIckVwNjQrRVZ0TEg1VEtCMmIvSmcrR1lG?=
 =?utf-8?B?QzhsRGt4MjBrWFdYUVlEUlpJQVFKRXNUWW91VDJoVG9sN3VvKzdLa1NNdzZV?=
 =?utf-8?B?NkdqZ2p6NVdjdnptM2Z6dmhUZm8vb3cyb3FSMUNYUkJzOWlIeDNuOFVDWmpx?=
 =?utf-8?B?eWpseDZzME9pME0zZzNUTkRqMmUzRHA5anU3a3kxcVYxQlpVSktKczZ2azRy?=
 =?utf-8?B?RTNpL2ZITkZESUdvSFd3SDc4NTR5R05HYWxQT0ZnZFRLVzE4YmFQTGp2aGtq?=
 =?utf-8?B?cGxyWXM1WHRabU9PbWZiTFprbTNRV3lqb20vaTdEb1F5M1lINCttL215TVZQ?=
 =?utf-8?B?T091RU5reGxsZlJjL0YxbFpIUjVoemhSSE1qK253L01pNkVxOUFDSUduWDY0?=
 =?utf-8?Q?NBYDnDHFC93YGKE+YgvAMGhcKChhg67kpgUB5v5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXdlM1AxdU9wSERVWDFDUmQvRGxYejI2MGhNN1B2aTRtR1dDRGdZWmUvZkNE?=
 =?utf-8?B?bmllbjJxam5temRVSkJZVkdOUEZjZEJLOS9lTXN1T2NJSStLRnEzTmhUY2Rw?=
 =?utf-8?B?aHNzSVNYWUFNVWNPT1lkZnZ1b2FJYnAxaG8wa1dZb0F0MFpTWmJPbjdsZ3NF?=
 =?utf-8?B?bktZZ0FUMlRQdFRxenF5M1JvekdUY1IrYkJTWHJWWDlXa2txRWZ0UDYreGta?=
 =?utf-8?B?R3hmZENwbS8xMlRwemFhSmxYYW80b3VlWWd6QjRFTWJiWkhwTGlXVVJSLzVm?=
 =?utf-8?B?OS9iUW9JaHVZbnIzZ2xNSjJKODlHdjlWSWhvZW5GNnVMY0dUWCt3VTJKMytl?=
 =?utf-8?B?SUlTY0ZJbzgxSzQxK2F3cEFOZytVQllaOGw0YUdxaURwcml4OU95MFVaYWRl?=
 =?utf-8?B?WVU1RTd4RlJ2L3dpT3VwTGpzM0R2QzVQZlpOcFFvbVpPQ09IVGJ6WlFQa1hy?=
 =?utf-8?B?dUM5NHJaUGFSbFZXSDBLUVBkSDNacW41SlJmYmdlKzhpS2x6SFpHWCtJWEZ1?=
 =?utf-8?B?dm1tUnIxQ0MrbE8zMDJTclJ4V2ZtQTB1bk5nU1hBdU05aWJTNk1kaVJIeTJR?=
 =?utf-8?B?ZXlWNlJOaklwYTZ1Rm9aUjFWcUhta3M1UVlURnJlWEhXZWJrbjBVZnR0Y0I1?=
 =?utf-8?B?SGF5NnQ2WjFiYWlEMG0xOFgybUlOQUNoZWpIQWdXbGRhcktoQkt5ZjQ3Mk9Q?=
 =?utf-8?B?b1lHcmRrYTFRMk9aU2FaZUNUYk1XWkdCbjg2NnVLbC94SlczNEJDQmFVZkhu?=
 =?utf-8?B?cmFWaTlBeGtqbnRBU09XTFJyYVp5SCtxa2Z6MVQ1SlZYZ2dWV2dHbDVJSUVV?=
 =?utf-8?B?Ri9xVjh5SHZIWjFyOUdjN3VCdlZpTy9QQ2E2UWI0b1RhVzRVOTlOUWdXSXRi?=
 =?utf-8?B?dEUzWFVJcUJzaDNwZUFRZTZydS9Lb096cStiM1MvUlI5KzVSUDNQWkVSZTVE?=
 =?utf-8?B?Q3RxVWNWcERYV21ZaUpORWo2V0FmbWRqaDhVbXlXQXZrdFRGWmhGdmFPc0hQ?=
 =?utf-8?B?LzJkSGZKNXpMOGZOc0VEVW1ka1hLMFVvVlA0MWlsNEdOT09PN0s2NkF6QUkx?=
 =?utf-8?B?NHRlL1BZYXcwTkpPaVpPUWdNZEpEcU40RUMxL2Zlbk0wVXhxUnZTSlo3ZkVO?=
 =?utf-8?B?d0NGdWlTQkJXUmdjU2dNU09ncmZQWTcxZTc0NW1sWldBaUJQMmhDelFkYndO?=
 =?utf-8?B?eVpsRnhBNEZLK2I0YVB5YVpTNXVzSkNYRmZ0bno5TmVmNEFhOUxJWFQ2T1py?=
 =?utf-8?B?T01CQUxCdmFxU0JSbGdna1RzRGxnOFRSTnNOM1hSbndJZHNNK0w4M1owQnJt?=
 =?utf-8?B?WVdUYTIxWVFGVFFZWnV0ZkVYK1puL1REMXZSSXB5S3dmQVIxdW42WVpMK2Q1?=
 =?utf-8?B?MmNBVmlZdDNmQ1JzN2RTV09ZN0ZTeWlIMjFveFhBeFkxNzJYdW5wUmNxdFR5?=
 =?utf-8?B?NUloZWpwbWw0OFFaV2xoUEdJQ3BOSjFaUHVGN3RoZHZOWk9ka2JoaSt4MFIr?=
 =?utf-8?B?c3RnbzdON096Q1pDckM5UEJqRHdPdFlOWVE4ZTRFYmxwbDRIV0c1RUVuZml1?=
 =?utf-8?B?UXhPb1NIbG41MXBRclhmdmZZa3RqNktkbjdsSkZWOWsweGgrKzZnTDhOWnVO?=
 =?utf-8?B?Z2xiY29RQkVXaWJaUG1HbWZaYTRNZWdSenNlais4ZTJiZ1R5T2hHWDVJV2gz?=
 =?utf-8?B?THBOZDFTcDhFTFV4VUVvb1NhcEFGbVltVW9lTHpjSkpXSWZ5K3phenJRYk9j?=
 =?utf-8?B?cERWS2FnOVZsSktyYzNSVkNxakNBTXdXOFpDL3FmdFI5d09HaVBqN1NXVmM3?=
 =?utf-8?B?UmZyWG1zK1dSMmhmS2R4MER5UHpiRldHYjlBRXBDYWFab1FOWmk1cnhvUFM3?=
 =?utf-8?B?cWJaMGM4dWFLRGZ3bW9pdEdVL3Y1Mk1BUTFsS1d3RDV5YVhqWkRUR0J1MnJ3?=
 =?utf-8?B?TnQvcHpHTVlqemhxbmZpNDhZb1lOWE9IUkxSUHMyckVtVFg5bG5zblBBTGkv?=
 =?utf-8?B?WE5jWGVYMEtXTnRZY1E1MERrTkR4OE0zbVBTWTRka1NUVVoycDVDNEpQNzA5?=
 =?utf-8?B?M3JnUHhSbFRwTllLd2EvendBVVFwVXl4cGs4Ny9WNndwZk5jOHdqS2ZXOGp5?=
 =?utf-8?B?aWxlZWk1eHZvR3M2dVcwWjMvYkNTK3I1MXV5ZlM0OTJkbFhERVlTblBiL3pC?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0632fe76-dc84-4ce2-38ad-08dcf762133a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:06:18.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdBWdjZs8jQetXt2KUFbs0W6v1Ws5/MuE1Vbhn0z0Vwmk4S1SwA6uqm7cxpqrB7tcfhPfDwqaWgfD2qGhKb6OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6349

On 28.10.24 15:28, 李胤颉 wrote:
> Hi Jan,
> 
> I have updated the struct hashed_symbol structure to use a “flexible array member", This change 
> resolved the compilation error, and the build successfully completed with this modification. 
> The updated patch is attached below, including the DCO.
> 
> Thank you for your time and support.
> 
> 
> From 92e7f1f467822533efd4bfaac56b40589e2fabac Mon Sep 17 00:00:00 2001
> From: liyinjie <liyinjie@sinsegye.com.cn>
> Date: Mon, 28 Oct 2024 12:01:28 +0800
> Subject: [PATCH] kernel/cobalt: use flexible array member for symbol in struct
> hashed_symbol
> 
> Replace the zero-length array `char symbol[0];` with a flexible array member `char symbol[];`
> in `struct hashed_symbol` to resolve build errors flagged by FORTIFY_SOURCE in recent GCC
> versions. This change prevents potential buffer overflow risks.

"This change helps the compiler to find potential buffer overflow."

The change by itself does not prevent overflows. I've updated the commit
message.

> 
> Signed-off-by: liyinjie <liyinjie@sinsegye.com.cn>
> ---
> kernel/cobalt/debug.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cobalt/debug.c b/kernel/cobalt/debug.c
> index cde0c17ab..25b194c26 100644
> --- a/kernel/cobalt/debug.c
> +++ b/kernel/cobalt/debug.c
> @@ -47,7 +47,7 @@ EXPORT_SYMBOL_GPL(cobalt_debug_vfroot);
> struct hashed_symbol {
> struct hashed_symbol *next;
> - char symbol[0];
> + char symbol[];
> };
> static struct hashed_symbol *symbol_jhash[SYMBOL_HSLOTS];

Please send as separate patch next time (e.g. via git send-email) to
prevent mangling like above. As this change was simple, I manually applied.

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center
