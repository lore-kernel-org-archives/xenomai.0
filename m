Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F552F88
	for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732796450; cv=fail; b=hA8SjML5gqiRY3pRauLwaGCPMAUEmkgqIITOmb+lwacI2Q3s5BgJQ0QqJefG1VdhqsB4MtbZT3GM1P/oedmWHhCrH0B9mA2E+c0hbB00kZ9NvOR9vZMzFlIlLiy8/0hcOtvTotm/k11rlWrPwfg4KZOFEo0XTvCjIF8swJg0dDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732796450; c=relaxed/simple;
	bh=EdzjxOxkWu51dBuBcK+6Lyo5icRfcSaGI+MqkuGPu5U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TB01K6N+OFpPN/i/sdIyG66SN4NRIKLPnH9gwpwmWYlSCuIhLfS7qhXrXN6MzQlXTToC8I4kwHhZzpxDCDxQyu7h5MnTJacq5nXzLIaaF4ZkcxBzhuwnwW37CKFxn5pVgoWV79NhVbZXsdghlS6uCFI9hLI4grBLn+ak9Zf1NJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=cD1/IJ3m; arc=fail smtp.client-ip=40.107.22.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cD1/IJ3m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s89eJk6+eyz3dLrSarrY57x6ji0uOijy3r9lusycVrJSbc1DbsdsYGElgmE2uQ6CrkYuvYIu6NSz/l4xsbZ/rQrZbwWcf9bFbxcIQTL73CFRnZIrM6GDvbe+HuzlIN8QazjK5f4wBnLuzv1btUYAXsYOWcCiiJzEA9L4IZMi0ZQJ/ADrUgtFAqzeaY/EihwYLhPXbzbUy8zM7RojShPzcQKMdSdCWItlNoqMYCmGrLuvwQ1tDRHT8iHMEs8L4SAu5fczeTjFBLrb4+qBzGeMkl07tTiCTrRNenLrgVLj/jR/7Q37plRfykU2kCV0jD4uwa6nEtsSNvDJXwYGUv/gFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc4qLo7bSQmGddAv6e89NHsFsTdyQwyuj1KzJ3i1UVA=;
 b=S3DkWvHTMBn0ixT5kEOgRxhs7jycZLUSxpqQUu3CfJSXou7JllyHxw1BLipUZgL4kDUf4whm3jVZgRTpiQEBX9r/uvksqIiw3DhMcAhne3mERtqDwhZ6HvH5ipskWKsIaQEz5NSgGjpf/2Uc73OUHXxTxDS9O5T5W9f32uktGXeDLWUQs2XgCqapt5PBftK06LzvUqoQjiIb8aDJAdmC9sYcq3tCHvVkmPfY07z5OkL3ftuoA3vYifFh/sYlDrQGZzppiHUPmLO/cKLd3f1GioqHL9dKFITgGXzgnEL/JTb/ElsUY24EuzoA2PdxrqWW3K1xOEHTOqST12fMNDfXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc4qLo7bSQmGddAv6e89NHsFsTdyQwyuj1KzJ3i1UVA=;
 b=cD1/IJ3meR1hhpzoO/G2qAJajlwZam6SkrTNPtUOpT+OKXLzp5S8QivXkzi+VMu4CBZH0HKKIan0AfkChs0o5pJUkcimDmkYVsA1Jb/CZ/TrTvOMayLYU0qwr5AFSS40cdjXslT+nrYJqEETuii1Pp/QfmpirfaxFbViHqSob3jb/frPqNxsJGgFQOYJW9xH5/ETc6PSdkUl8mOIBThzvpXEEp3NIsjJOTFTbEg4f5II2WHBlDqMTj2epE+ZmMZUvmtq/iMJ0TNaZfG7TVI0OUigv/cwRDlzNhlU28ktgSDCGWPhwx0tbucHXXqEZpcUuCQ/c5u6YDOkirNOF7fbcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8379.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.4; Thu, 28 Nov
 2024 12:20:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Thu, 28 Nov 2024
 12:20:44 +0000
Message-ID: <88eea3e7-5bf7-4043-bede-c68c94f1d113@siemens.com>
Date: Thu, 28 Nov 2024 20:20:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fix user get ifindex error issue
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn
References: <20241128091411.73192-1-liuyang@sinsegye.com.cn>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241128091411.73192-1-liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: 371a993f-1041-46d1-1e25-08dd0fa714c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlpPbzkrY2VaSmN6allsaW5kd3dLcDNhR3QwMFlVZmxmeDFaTWNmZlZuYUxT?=
 =?utf-8?B?ZmRwMENHdGZmMTBBVVBGcC9PdllKRk9WOGhJMTQ2U0NNV29MTXpqWW93QjZ0?=
 =?utf-8?B?T09KbTM0dGpldWpsYVdUOERzOHBSQ0lQSjIrUXpTZlo5dHhZNkN2dmZlWCtq?=
 =?utf-8?B?bjR5QWhvYzE5alZudXlGZGhFdGNuQ050SkgzTWFMa0VmODlSdFp6SDh5NGV1?=
 =?utf-8?B?akZZSUx1RkhtU2c0bDBKdFlaRWJ3UytiN3dET3VqWlhva2M3RGVQR2FTN0Mz?=
 =?utf-8?B?QjBrd253NlRJUkZMeTAxMTh5ZzJhRVpzSU9zam1CcUVWek9TVnNsdUx4QTlU?=
 =?utf-8?B?ditZUnlPalVTdEtIeHJSbTJQUUhTNEZXejQrMUJKQXFCbiszbzBVdG1JRWJJ?=
 =?utf-8?B?eWZkM3RSa0cyRlRSTVo0VnFpYytaQzdMUTNjMURyTjRaSXF6U0xpTmp0T2I5?=
 =?utf-8?B?V2g5bE44aGJMRjFqSUJlenlIRVNMZXVWNy9GRXdWVW9jbnlYYUIwRkwzUVpM?=
 =?utf-8?B?OVZYczFDajh1a0NsUUhnd0pRcDVLWXNoS2xpNVVYNmdYRGREbENpTFV2SFhn?=
 =?utf-8?B?Yk5LQzh4RkxTMzUyNk9QUDZFTjN3bHY2UElpYithM2hJZDh6RzErS2lPTEdX?=
 =?utf-8?B?blJ3cGhRSnAxWEQ5YmdMbS80MGQ3a2JFU3VHK3lhMklJS1NhNGtRcVFwRjV5?=
 =?utf-8?B?S1orZkVxNTYvYVRDcTYwK0t5WnpPUDVCY2M4d1duYUJmRlgxOXpzQ1hITGdI?=
 =?utf-8?B?L29Hd2Y0UjFrbXpHeHo4MytFbzAxNE03Ukprb0hXdWc1M1F4ekNzSjEwS25r?=
 =?utf-8?B?L0RjaVByby8zcDI4VWRncEZBS3E5MHhIaWtaRjFYckUzZXFxRnNKUm9vTVFy?=
 =?utf-8?B?VEVuNHAwKzJ3SnJHdVdidlVra1kxdjlEK3dGdm9uZ1BrajdIOTFWbkEzUUt2?=
 =?utf-8?B?SHhjakxydU5sVmRRbThlK3IxcDdVcDlxNllYRmJIOFBiWERJbHl1SjVJNTZp?=
 =?utf-8?B?RktFZ0JIeW1zRCtKczRpT2dOL2VVeTRORGhsVmZydXVzMWp0ZnozTGV5UHFV?=
 =?utf-8?B?YkY4ZzdwUGYrS1RLeXMvbVMrV3ZhL0syUmJwQXppN0Q0bFVKLzRpbEFtWW45?=
 =?utf-8?B?L3lVNVNKTWtwTE1xV1BNY2ZBWGlod3pjaklIVG9mS3JhWnpTOEpwM0JHbW5T?=
 =?utf-8?B?QisyeExvdmJ5UFFLVnJhbHdvd09HcWl6aTFLM0xuWWpkRkxheVRjS3k2VXlw?=
 =?utf-8?B?RUgvUjJ0di82ZmFDSzExSHd3YVlGVjBVck5WbmpOTncvUDFBbUZxL3Qwd2w2?=
 =?utf-8?B?WnhIQ1JyOWpqaGZGT2RIZmdzNm8zNW1Cb2FyL3Zjc0txUzJ5c2NMSWtOZG91?=
 =?utf-8?B?L0RpaUVMYi9BWldMN2F3T0FBdmo2SVlQazlFeEtqdk0zWG1OZndWYXI4cWxp?=
 =?utf-8?B?UFJ6S0ltZ3FJZVk3WGhyYmc4QjY3NWljNElsYWx6VG45VDZVcXdQYldoSURV?=
 =?utf-8?B?eUFpTzlFT1RhOC9hczYzdUNEcEhwbGNQdVh0dU42TmhDUTlLZ0NEbTRKVmNX?=
 =?utf-8?B?VmhSdVZkalNhbkw3U3RSNWV2ZG1zUmFrd000eE9xWG1ucXptSG9iOVZyL1pE?=
 =?utf-8?B?bnFKQTJ1TEM3b2ViY2NiZ3creFBIbEtoUHJoa0dIUnoxSjRTSFhzVlVhRGIw?=
 =?utf-8?B?eTFoV3pFcDJPK2ZKYnlFcmFpU3RxQ1JoNjlhcWJCL2gwWGlTRnh4RmQ4OEVt?=
 =?utf-8?Q?B9SzfUqEDNohh2bo/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzZzdElYanNKNE9zL2FZMXJZNytTcFJDTGxqUzZYakZzdkowWmg1UUpLU1hU?=
 =?utf-8?B?T21ybnhsU1pFR2VUeWVBYitnRXVMekM5bnZIQmxsRnRwWVppaUgzRldBS0JG?=
 =?utf-8?B?VTQzTTNTTGlUeUFnczRQbDkrNXNMYmd1aFdOeGpBbjExeVF0aVpZWC8vTDA3?=
 =?utf-8?B?Z1JnQ2diYUR1dXFuamRYL3NNcTRuTStGRVNNeUorRlVNdWx4QUU2dkdkMjhU?=
 =?utf-8?B?OGNnNlU4a2NPZk0wSkpRQmpPZTdtbXdZSGF6dS9DZW9zeC9FWmgwaHVYV3hS?=
 =?utf-8?B?RHJlaU9uUGk3dEd1V2FISXlHZWVXYmRkKzlWditBdUdJOHZzYmtuMmRMekdO?=
 =?utf-8?B?SDV0TTJGTk04OVdEOXZialV6bWQ5clk3WS9tSTFrVmtRbml4TFhORlRCak8x?=
 =?utf-8?B?c1VTWTVnSEg1a0hBVnh2TnNIY3VlOVNYWHJrZmtleE05ZlhqNStTRWx3Y0tB?=
 =?utf-8?B?MEdlTTFqTlNXV0I1ZkpndHY4RWxBUzZBUEhxRDZSdFl1V2wreGpJZlZDTUxF?=
 =?utf-8?B?YngyNXlvRkFkVzFORE1CbGhwWW5ENFp5VTVEQkFQUHJXS04vMDBTQ0FEVWlD?=
 =?utf-8?B?RDYyZlBJVWczSy9LdXZkVXZDMzRpWWwxUW9mWVBmTExRK1JSTXdmZ0JnZlpI?=
 =?utf-8?B?N2J4cWlBdStaV3R2djUvRzVLcTlPM3YyM2hrRjFnVHI4UXFmME1Xdkh2K1U0?=
 =?utf-8?B?QkNaZ1ltNGJKQU9oVjcxWlZXS3ZSdHhOSmVxTGVMaGFYMjhEQndlSWszc0x0?=
 =?utf-8?B?VzU4Kzk1QlZIaXo1UXZTNjVVNHpreTZodVF0SUtMMDBQVmt6bVFsQTdXUDYw?=
 =?utf-8?B?enFsV1RGdTVnd29wUE8ydjhoVWhHdHRxc3BrZ2tVVXNNYzZvM1BjVXo2UXc0?=
 =?utf-8?B?enZRTitCUjZBVHZmVkM3dWRESlRKdFBXRk9RNmxSNHhZZHprNlVmMU5temx1?=
 =?utf-8?B?MzZSaHBnWWJCNFU4R3A3Q090QzlnZW1IdkI3SFRKQXVmQmxCTW05SW5FaWgz?=
 =?utf-8?B?TGpmWDhISFdmTXFjT1NCRkxxUG1Sb1VmRnZmcndBOUtmYkV6VGdLcDIrTjdT?=
 =?utf-8?B?VC9XMENKQUJyVHNKN3REelphcWdwaVdVT29XZG8vay94ZXZ2bmlyZEY0d0RC?=
 =?utf-8?B?dXMvcURhS21tc052WXFxVHNPVmJJaGY5MzdMMGplUi9xNTlHUnpneFZaUVEv?=
 =?utf-8?B?NVNDOE5tMVY5a0tvS1BuUkZSVDQzN3RvVmxXYWROdGF4S3NPdlpNOXFCYXp5?=
 =?utf-8?B?Y1kzWHBpeWFzL0xmNVZBYnZ6RlIvNmlTY0tFTVdNYUV1VXRmMkVjaitjM3l2?=
 =?utf-8?B?RFhTOWl4RzlWbm80dzN0MDZVMXdESjJJMXA1VkRaZEUzdHYvRzd2OUxzbyth?=
 =?utf-8?B?UDQrSVdmWXdJUmppQkhZRkpMejAwdGM3WjBCMGJWRk5GdjZhV2MyUXA3RHFO?=
 =?utf-8?B?dXJteFFPVHhGL1REOWl0VmdmcFFkNnlGakhZbFpUQWJ0LzRndEh1Wnk1bGlo?=
 =?utf-8?B?a2wvdTVWbS9DTzNMTFJNeEd2MTEvYXBRUUhXbFFjUDNwVkNKMFp1V1JYeTNh?=
 =?utf-8?B?d3RiRkYvWlk5ak9QTWVVOVRmLzN0SUo3dEQzU01WTzhiTkRRMXIyWERUSWR4?=
 =?utf-8?B?UVg2SzIxMEU3M1hFVjJ0TXcyZTJyaVZ6dmJGeVFuWWl1enpZbUUwWDdCMEdW?=
 =?utf-8?B?N3JxWlEyNHJpNmNlSXhoLzlSRERJWUxHejVkSS9ad1I0dXFoMUh5ejNUWjBn?=
 =?utf-8?B?SmdSTmRmVmQ1SHJhMGI2QUdhaU9RT3Q0UlN5L3hxazUzdGZWS1ZhUkRMRWEr?=
 =?utf-8?B?ZHp2UHVuODdnR0xCM0RkbDBiK2RNazQ4ZHUvREVlb2daODJDVEdWY3BYM1hO?=
 =?utf-8?B?OXVOdkRvMldTdC9OUXY0NmZ4Si9qTno2bUJUYXBFeVg4L1dvRHQ5em5ONTg5?=
 =?utf-8?B?VThrdUdIOHU2amhwYnF3MFhvU0RUMGFkOFVDUE1LZkxjOUpXaVYrUXJXRnkw?=
 =?utf-8?B?cHh4N282ZmZZNmZZZ1RBTk8ya1hDa0krdUFBeEZJMVgrM1JLYlNWaW9OYXFi?=
 =?utf-8?B?SEU0Z3RKQkpOaVAxUmZBbmxhQ3FDWFFmb2pLRVB5dmFad2NEUERHRFJYdCtn?=
 =?utf-8?B?L0krUnBpVnZVcEZIWGtYRUMrblJMa3RzRFRpbWhpbjFGRHNBYVZwSUhBM1lK?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371a993f-1041-46d1-1e25-08dd0fa714c6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 12:20:44.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXDzw4mlhVGyUSOhfoOyh/2ZValJwQvUT2J0vMdjNIPxvtqhCSduYCvYncewMMIjcUJ//EFRBv2PhwxP7Eu/hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8379

On 28.11.24 17:14, liuyang wrote:
> when user program get the ifindex cross the ioctl SIOCGIFINDEX, the ifindex is a random data.
> this patch fix the user program getting ifindex error issue.
> 
> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> ---
>  kernel/drivers/can/m_can/rtcan_m_can.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/drivers/can/m_can/rtcan_m_can.c b/kernel/drivers/can/m_can/rtcan_m_can.c
> index c2bd16660..f647c6f7f 100644
> --- a/kernel/drivers/can/m_can/rtcan_m_can.c
> +++ b/kernel/drivers/can/m_can/rtcan_m_can.c
> @@ -474,6 +474,8 @@ static int m_can_read_fifo(struct rtcan_device *dev, u32 rxfs)
>  	u32 timestamp = 0;
>  	int err;
>  
> +	cf->can_ifindex = dev->ifindex;
> +
>  	/* calculate the fifo get index for where to read data */
>  	fgi = FIELD_GET(RXFS_FGI_MASK, rxfs);
>  	err = m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &fifo_header, 2);
> @@ -550,7 +552,8 @@ static int m_can_handle_lost_msg(struct rtcan_device *dev)
>  
>  	rtcandev_err(dev, "msg lost in rxf0\n");
>  	skb.rb_frame_size = EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
> -
> +	

Minor detail for the future: Please avoid style changes away from kernel
coding style.

> +	frame->can_ifindex = dev->ifindex;
>  	frame->can_id |= CAN_ERR_CRTL;
>  	frame->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
>  	frame->can_dlc = CAN_ERR_DLC;

The patch would otherwise be fine - if the code that your are patching
here was already accepted upstream.

I assume this applies on top of [1]. So, as there are open issues with
[1] anyway (see my feedback), you should address this issues here along
with the other remarks in a version 3 of that patch.

Thanks,
Jan

[1]
https://lore.kernel.org/xenomai/d7263ac8-ab84-4028-a617-6a8a8cd293ce@siemens.com/T/#t

-- 
Siemens AG, Technology
Linux Expert Center
