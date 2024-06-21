Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2086.outbound.protection.outlook.com [40.107.6.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7E17B419
	for <xenomai@lists.linux.dev>; Fri, 21 Jun 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998710; cv=fail; b=AdfAeP3yHU2xF4yD6mARtqwRcXuTQq+8lsZmw5K8EhK9HbVZx7a/HTi+vJiUvLul1pPUuuts0tKa6BBVDU2FAeLgXpzMRm+1kyRz1XdnbhCWaBtRq8ALsunFVx/3P7/B8690nzQs0z01S15Ye9c+E3Lkv5EtbsCCkJ3OhDQzNGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998710; c=relaxed/simple;
	bh=0e110qZDWMggN/tKakeBw6VXSjItivnZZsFNYBsAu4U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TMal7grl2bg+27yvEuylgLhRWSxcj6+qcLgEtsDNi7KVHuiqvyzeB/0uMUelCEHNykp9D9a6DNZJ9l5wfEmWlcWGqyGv/HRVwZ2V0mlokT/k5yX4DyLjSF2bzWpHSxccnPowfuuQ4i+T6ojRkFwH7fT3mT/1A390TUn9nZbrQI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=fMIxojic; arc=fail smtp.client-ip=40.107.6.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="fMIxojic"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8MdjzEV9AGux22V78fyqhketfnX0levA764U0ltlwgyTHgDgIt+e1uKr7E7OVBE+WHMfHO2J7/8uN1fR41vlsaHuyNZQoburyxQDmvroeNTwgh3AC641lj8CF/yiZEdYzyhwiZsum86WysAriS3oYHnuEJKmnexdY6taoOPsTJZHSds375v6e3iNCodT57NaXQ5Qwp3UHAcT1S/7c1NzWLw54vNQkuNVtjXugT0bm/bvhmvb7ZUb+gfeHOKiIBWt5hHZAC8mzF1ImSghCbEpu0i4ALFfGztXiDN06C+6hKGXXDjRpZaMXMFP2P+Sn0l+3XGqL8Vy2colbRTDtrJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8f064PbsVOZn59wb35AIWfGTk8gL2sh2d9TVBRHV7E=;
 b=ZSi0n+LMjUUazDN7ABzG+3EZAN10Va+YR7g5x9u3hPJhhxEHyb622N6uXTD64EDcwENHr+i2r48lKamzzNhX4WsQ6xyeEZPl/DJxxhsSIoIoAUEQQAc/Ni7U9b+wtu11rxQPzqYj5dZNSbJcjzdc45URCyDsdcDHrknb9451bx7tcBF5ZHpMW7sf4ytZvwvBmOsS9jtefppP2fjLvgCrNswC6zAduPc+z4l6fIRxLMPhw+VIDpM5FsrpW0jocZDZYfvP/+w3uwvK65NxHE2GbEZA6WijAVRddJo+NZn3zsSVbhKBZe6qB3pEx9p8QHk+Qs8g5JqaDXba+DPPU1pJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8f064PbsVOZn59wb35AIWfGTk8gL2sh2d9TVBRHV7E=;
 b=fMIxojicqcWD8pEA0TV7LtTEkefI9OEEyMNk1QeTum2GChbvSw7G+2yfs+/jyQ4NSZQXKxGHl1qCI7C4Q3aIp7a1dnItMtVUsEj8BYp5iwHwVGoYI9JXe6LKaxiR/XVaoOaiV5qyJEn6nPoPzoivE4IxdYBfITQHZ008vyn7i851E8E+wWyubgkr731ke5UUVBNl9/IM9SUvHxFxYpBRy79rhlTtGTOUsZOY1AiV+EG9U4gBeKwn2EPIsnq0v4vFOZWuaO9UZVZlQatgTG6Z1x8yiF7SvfPmGUHs0wGOQFj1Czv8RofrZPSqhwCLCo7SPy5OiBPVVpDxj+x1ChZY2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 19:38:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 19:38:19 +0000
Message-ID: <e5d7e162-3e1a-4c2f-bd38-707ff8f9f197@siemens.com>
Date: Fri, 21 Jun 2024 21:38:17 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 4/4] testsuite: smokey - new testcase alchemy/task-11
From: Jan Kiszka <jan.kiszka@siemens.com>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 xenomai@lists.linux.dev
Cc: richard@nod.at, lorenz@sigma-star.at
References: <20240617091654.66342-1-david.oberhollenzer@sigma-star.at>
 <20240617091654.66342-5-david.oberhollenzer@sigma-star.at>
 <655ed859-97cf-4a9d-b9ad-08ad9dedeab5@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <655ed859-97cf-4a9d-b9ad-08ad9dedeab5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: b65bf470-17f3-42b7-c7da-08dc9229b425
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFZEVHZlUmVFa2U1VDVKdlh5OXBJcjErTllOMEhuWG9xMWdXWHZRRER3Unc4?=
 =?utf-8?B?ZSsrSG9XcUtaQk5tbHQyUXduNlVGVVZpRmlEZ1U1UFNXeVNCcGlSZXh0M05F?=
 =?utf-8?B?bEFUMXpROVdmSm1xWlo4Y2tmYVZlanNyYlVxWTVuS2hPWGxKQks4MEIxV1N3?=
 =?utf-8?B?T3NXUTFyUGYyaDdlaE5LYjZ0elNmVlRXTGp4SEIvSEZ5bHptMjJxWm9sMXVw?=
 =?utf-8?B?dVVzRk9Ucm5CWURGcjJLclFKck1OWXFKZnZUY3FMOGx5L2pYTWdUQlJVVWwr?=
 =?utf-8?B?STRVb0VFQ3JNVlNJYVI0Q05Bd2g4RElIb2JySGkxN3pDM0ZsV082aDg5Zkxw?=
 =?utf-8?B?Z1VoQ2VtQTRkWU1KbDBKV1hIdVM4OUxkTFU5WnZ5b1VwUStObkErRG9MWWVT?=
 =?utf-8?B?M1JBdHZ3aDliRkk5Wml5M1ZOSVVlZHJKMDBiaVJ4MU8vaXpyeGFWYXYrRFZN?=
 =?utf-8?B?bkUzVHB0cm1FZ0VXNlhXeGxtK0FtV21ZMjlIWmc5eDk1cUt1VmF3TlgvQ3hE?=
 =?utf-8?B?YzZUOVBtOXV1RFFBMkVMMmdGK3B4NmVaK2R4UEY1WTFNWUI2VkkxVnY1TVBF?=
 =?utf-8?B?V2R6RXJHZXMyYk93QlZuaHp3L1NZeTA1VzNpSmZockUwVjFyV0FhdVJnNFp5?=
 =?utf-8?B?UnliVlN3ZUx4NHpCclhhaTZBYytBdWVNaDQweUQzYm9HSWNOb212NVZ6ZkVi?=
 =?utf-8?B?S0R1MDl3NkRhMVZxSjRXWWhCN2VtNklueUw3Wmo2MDRWTThEcXN2d2s5OGNL?=
 =?utf-8?B?ZFVhbm15ZUxzQ2piVjd0eGN2MldHeGFwWHlTTmFGL3R5QkFvTStlWngxalBL?=
 =?utf-8?B?Yjdudm4vMTF3VlBsRmNvbEhSazVFMVUwVHZnUjlTOE9LVDNSVWZJMnd0T3Iw?=
 =?utf-8?B?VWw5YU1UdW9ITEJhVXZSbWJ3Y0c5eXVtQW1GSG16SVZSVDZrTFBLeGVyTXhO?=
 =?utf-8?B?MnpFTXZOaWxXV0VCUzduVnkxSzZzd0VGV2ZZSEFZbXBQRGZPaFdvRit3MVlv?=
 =?utf-8?B?UktyRk5JckJ2ZVh0NkE3Z2lBVkdnR2ZCMjA1YkFyeCtRaitDTyt0MXBkVWg0?=
 =?utf-8?B?cCtFVy9uVzVDbnJYQmdxZnpVdWYwNGZNM0NMVVA0eFcyaWNESW8rR1hqM1Y4?=
 =?utf-8?B?ak1RLzhQem92ZDA0c2xxQWdhS1dsYUd2WUNSZnExYXd4VzZXVmo4SUg1ZkdD?=
 =?utf-8?B?clQyVzdpcHl5RFlEYVdUQXFSa2RZd3JKeVRLT0FzVmtoeHl4VDk2Mi9SaTNK?=
 =?utf-8?B?NGQrSG5aaGh2L0JubVZpQlp4REIwOFhXc2FSdk94VXgwaklkK01MaEVhZG9F?=
 =?utf-8?B?bVh4Q2w4TyszN0M2RnNod2w2bmJxeTVsTWcwSnJyZ20rZ2RnREtuaFYvSC9Q?=
 =?utf-8?B?TGZSSEJCUkNwMVJ0T0tsZmJ6MmJRNnllNllwVCtKa0ZhazkxQ3dVWHdBQnU0?=
 =?utf-8?B?Zm93K25Ydi9MQVhTSmdaZEIvc29HV21Ra012a1VlUFQ0S0NIUFJZdDFrMDVR?=
 =?utf-8?B?ejRGUWd0SU5lM0d1TmtXRTF5aGxrVmprYVcrN2ltU1BwaFZPY1EyOWt0L3J5?=
 =?utf-8?B?U3NjQm1ZRlU2RHg4WTIwOTZ5d1QyY2RONGt0d0xSMGtMLysrNnBZekl0RkRC?=
 =?utf-8?B?L0xEYmw4MkUyNEk4SmZ2ZGJLR3pRdi9sL29ab2w3bUNuNm56UGZCUzFFRUdN?=
 =?utf-8?B?WnY0S3IydHN0YkR2WVJZbHhJVHpVbEdPeTlaR1VHUHI3VjZkbVExNTE3RjBq?=
 =?utf-8?Q?h/xUvKx91j0Ad9o81WFgrYI88AHCyALRksTSJOG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1Z5a09zcXJ3NDAyWHl2SDBNenRjTU94dXdpUjNDOUU1emx5L3RBS2RmTEZF?=
 =?utf-8?B?QkxuNVhjd0J5Vjd5amhEenBnQmg1b2I1b3pTRExTY2lWVEJTeWwwUzJkMlQ0?=
 =?utf-8?B?WG1vMlVYU1IyOVlEeExjaVlrdlJZMW9STGtXbS8rVGRmbUVWMU9yU3dyNndk?=
 =?utf-8?B?QXhmQnV3TiswZkRVK2h5M3pETzdXdlhkaXJnT0Z5K05sM1phOUcydWJjRWlP?=
 =?utf-8?B?RzV0UnUvUnlGenhaRFVsa0R6Nno4OGQ1ekljUE02cHhYckRyUW5BRmEySGJ5?=
 =?utf-8?B?NnBUY2NkZkVYSDU2WXlPRlUzRFExSVVyMW9HNjdTMDZkWmVVT0c1YkZpY2or?=
 =?utf-8?B?cytpM2hRK010U212SFIyZUpiYWxSdTN4ZG5RREJYaU9tN3FrMHcrT3VzcTR4?=
 =?utf-8?B?dzUrSnp2V2hodmtrU3g0K00vWDAvelIyZUhUYndQNkVXRUNpRndkZUV2Rmho?=
 =?utf-8?B?RHBpQVRJcDlkR3k5UXFNMVFhTGNTYUQ3L2trVENsR3VrekFKTU0wczd3UEd2?=
 =?utf-8?B?dGVYZTlqRHJIS3krSUsrNGFTaDNRYkdxWFZuZit5TG5RZGwvY0NrVUsyank5?=
 =?utf-8?B?RzBGd01HWkdXMmxNbEZ0c1JHTzd4QTM0bmNXSjdkWEUvam9NR2tGbUYyeWdu?=
 =?utf-8?B?RXY3UFRzNlRYdHhiNmFSZDJHbFlEN2x6aG1SWnFUOFdZZngzcEwrTFFZemZ6?=
 =?utf-8?B?eXpjOTdOOXNnbEp2Q2JVMCtlVUJMcW03ZHgvR1hJZHV2SEYwVVNoQjFLZHpr?=
 =?utf-8?B?aVdPSjhTaTJ5dURqUDQxeGJJWGdJbDR3YkdMUEV0TVdyMUFGMHBER2svY0Qy?=
 =?utf-8?B?K3VHZUlibVl6VUZmb0JLNEdueWV6UlpYREFBMDFOZTRFN09ra0hJaXQxMmpw?=
 =?utf-8?B?NGZFTVQvblNiUldkcUNTSkM1eHBjbzF5SDJFenhDZXZQSmEreUV4dVROZHU2?=
 =?utf-8?B?WFkyUkowOWtQOElOaTVLbTl0VFprZlNYVVM1TXg5cVU5a2lFa0FZK3NnbEda?=
 =?utf-8?B?eTRGTW5KSnlrb3g3K0FHTVdXNXMwanVHVTNwT1krUFFDNmpXUjJwSDFDRVJq?=
 =?utf-8?B?T3BVUUxzazNTNHRwTW9KekZQNk10Q0R1ZGQybEdmd1JORmZSRjlmcWF3T0E5?=
 =?utf-8?B?RjJZa0J0RURJS2RuUHBXWGtxRmRwQ3JiRS83WTJXeGtwTHppRHFPcFlicnhB?=
 =?utf-8?B?ZlZXMFZGWUFCajVXVVR2REhFNXd4YUxDcys5NXRRcGpHZ01Ma0U2VDg1ZUs2?=
 =?utf-8?B?ZU80NTlHNE9sbDY0K3JTcjJqV0F0Y1BheWxhUzBneGY5OThCdDdpeEdiS0t6?=
 =?utf-8?B?R1d3aTR6QXlHRkZNZkpPTmZmck5NQStLWlRKdXpQKy9Dc3JJbmZoRGh6bzhH?=
 =?utf-8?B?aXgySEZDTHltNnlmaERxOVdCZnluL0RUNXRJTTIxSzc4T29JaDdKRTEzakdu?=
 =?utf-8?B?QjRnVVJmVmkwNjlXZzJ0TTlrZm5FWlRHYlpQMXdiOUhiREVTNHRNOVh6NTdl?=
 =?utf-8?B?Y015cXBrTkp1SFJFeXJtcjQ5V0puN0VZSGpWTmZFV3M0T3h6dG1kbFNxT3Ey?=
 =?utf-8?B?V2ZNRStiaktaV2gwTjFhVWRqLy9rVHFMVDZPY3dyZWJpdDBNQ0R0azZwdTN4?=
 =?utf-8?B?V3NVSy9ZRWJNeDQrVHFHWmg5SXZDTThFZ3pNVHZWRVBoclkySytJWlJKcm91?=
 =?utf-8?B?S1ZjeCtVSW5RYjYrbWdTdThXZ3pCS2pEQzRRRVF6WFBtMW04VnpTSVYyR0h2?=
 =?utf-8?B?TXVJeFVFaFkvdjRLYktPWXh5SGs2ODdYNTFlcGdGKzNGM2dmUWhjaEtuNXFo?=
 =?utf-8?B?OGRKa2Jhb1pJSldQSk5yaDJBc0p4dUIyYnYwTjVaVTRYWTZEUGt3QWxydDdY?=
 =?utf-8?B?SkZreUowWWZ4NHlzZXEvMFlZbWhvTWlobnFienlCWUdRUlo5bjZqd2NNd2l2?=
 =?utf-8?B?eThkeUtzKy9TYXM2aHBkV2RxTmo4NFovQmM4NmpCaU9UQnFhMWljRFVoWVBM?=
 =?utf-8?B?M2FFd25EMG9PQTdNTlB1MWFjdDZCejJFQkpuSk9lT0REQUNBSHdidWxqaHE2?=
 =?utf-8?B?ZzFIdGZOS05xckpQdWpkMWpkUmtsOWpyRmxjcFRVYld5Tlh3V2tDUGFIN1Bm?=
 =?utf-8?B?YW9pcUo0WHVmUFNBYUwrQWxIRU96WTdsQ0FDVDNvTDNQMXJsMFJKdHdsZ3Ji?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65bf470-17f3-42b7-c7da-08dc9229b425
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 19:38:19.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGzVcpzAMc+bWPs9zXnvCXlYOiRsqtddA5ErmEeASpJEWlXTMlQraofOxXrhVVW6ywzaDbHZe5NKcO4E/FYjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7248

From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>

The testcase ensures the correct switching of the task period. If we
switch the period after a number of iterations, the current iteration
still needs to complete with the old period. The iterations following
that need to complete with the new period.

Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
[Jan: allow test to fail in VM, use rt_timer_read]
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/alchemytests/Makefile.am    |   7 +-
 testsuite/smokey/alchemytests/alchemytests.c |   7 +-
 testsuite/smokey/alchemytests/task-11.c      | 102 +++++++++++++++++++
 3 files changed, 113 insertions(+), 3 deletions(-)
 create mode 100644 testsuite/smokey/alchemytests/task-11.c

diff --git a/testsuite/smokey/alchemytests/Makefile.am b/testsuite/smokey/alchemytests/Makefile.am
index eba82f8ec4..5fe481c29c 100644
--- a/testsuite/smokey/alchemytests/Makefile.am
+++ b/testsuite/smokey/alchemytests/Makefile.am
@@ -33,7 +33,8 @@ test_PROGRAMS =				\
 		alchemytests_task7	\
 		alchemytests_task8	\
 		alchemytests_task9	\
-		alchemytests_task10
+		alchemytests_task10	\
+		alchemytests_task11
 
 alchemycppflags =			\
 	$(XENO_USER_CFLAGS)		\
@@ -138,3 +139,7 @@ alchemytests_task10_SOURCES = task-10.c
 alchemytests_task10_CPPFLAGS = $(alchemycppflags)
 alchemytests_task10_LDADD = $(alchemyldadd)
 alchemytests_task10_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
+alchemytests_task11_SOURCES = task-11.c
+alchemytests_task11_CPPFLAGS = $(alchemycppflags)
+alchemytests_task11_LDADD = $(alchemyldadd)
+alchemytests_task11_LDFLAGS = @XENO_AUTOINIT_LDFLAGS@
diff --git a/testsuite/smokey/alchemytests/alchemytests.c b/testsuite/smokey/alchemytests/alchemytests.c
index 947fa37b92..cf9f970f15 100644
--- a/testsuite/smokey/alchemytests/alchemytests.c
+++ b/testsuite/smokey/alchemytests/alchemytests.c
@@ -25,11 +25,13 @@ static const char * const tests[] = {
 	"alchemytests_task7",
 	"alchemytests_task8",
 	"alchemytests_task9",
-	"alchemytests_task10"
+	"alchemytests_task10",
+	"alchemytests_task11"
 };
 
 static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 {
+	const char *args = "--vm --cpu-affinity=0";
 	const char *const mod = "xeno_rtipc";
 	int test_ret = 0;
 	int ret = 0;
@@ -42,7 +44,8 @@ static int run_alchemytests(struct smokey_test *t, int argc, char *const argv[])
 
 	for (size_t i = 0; i < ARRAY_SIZE(tests); i++) {
 		tmp = smokey_run_extprog(XENO_TEST_DIR, tests[i],
-					 "--cpu-affinity=0", &test_ret);
+					 smokey_on_vm ? args : args + 5,
+					 &test_ret);
 		if (test_ret)
 			ret = test_ret; /* Return the last failed test result */
 		if (tmp)
diff --git a/testsuite/smokey/alchemytests/task-11.c b/testsuite/smokey/alchemytests/task-11.c
new file mode 100644
index 0000000000..5ed8b34199
--- /dev/null
+++ b/testsuite/smokey/alchemytests/task-11.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <copperplate/traceobj.h>
+#include <alchemy/task.h>
+#include <alchemy/timer.h>
+
+#define TEST_ITERATIONS (10)
+#define PERIOD_SWITCH_ITERATION (5)
+
+#define PERIOD_INITIAL (2000 * 1000)
+#define PERIOD_SWITCH (1000 * 1000)
+#define PERIOD_ERROR_MAX (5)
+
+static RT_TASK t_test;
+static RTIME duration[TEST_ITERATIONS];
+
+static struct traceobj trobj;
+
+static int tseq[] = {
+	1, 2,
+	3, 4, 3, 4, 3, 4, 3, 4, 3, 4,
+	3, 4, 3, 4, 3, 4, 3, 4, 3, 4,
+	5, 6, 7
+};
+
+static void test_task(void *arg)
+{
+	(void)arg;
+
+	traceobj_enter(&trobj);
+
+	traceobj_mark(&trobj, 2);
+
+	rt_task_set_periodic(NULL, TM_NOW, PERIOD_INITIAL);
+
+	for (size_t i = 0; i < TEST_ITERATIONS; ++i) {
+		RTIME start, end;
+		int ret;
+
+		traceobj_mark(&trobj, 3);
+
+		start = rt_timer_read();
+
+		if (i == PERIOD_SWITCH_ITERATION)
+			rt_task_set_periodic(NULL, TM_NOW, PERIOD_SWITCH);
+
+		ret = rt_task_wait_period(NULL);
+		traceobj_check(&trobj, ret, 0);
+
+		end = rt_timer_read();
+
+		duration[i] = end - start;
+
+		traceobj_mark(&trobj, 4);
+	}
+
+	traceobj_mark(&trobj, 5);
+
+	traceobj_exit(&trobj);
+}
+
+int main(int argc, char *const argv[])
+{
+	bool on_vm = argc > 1 && strcmp(argv[1], "--vm") == 0;
+	int ret;
+
+	traceobj_init(&trobj, argv[0], sizeof(tseq) / sizeof(int));
+
+	ret = rt_task_create(&t_test, "test_task", 0, 99, 0);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_mark(&trobj, 1);
+
+	ret = rt_task_start(&t_test, test_task, NULL);
+	traceobj_check(&trobj, ret, 0);
+
+	traceobj_join(&trobj);
+
+	traceobj_mark(&trobj, 6);
+
+	for (size_t i = 0; i < TEST_ITERATIONS; ++i) {
+		RTIME value, expect, diff, error;
+
+		expect = PERIOD_INITIAL;
+		if (i > PERIOD_SWITCH_ITERATION)
+			expect = PERIOD_SWITCH;
+
+		value = duration[i];
+
+		diff = value < expect ? (expect - value) : (value - expect);
+		error = (100 * diff) / expect;
+
+		traceobj_assert(&trobj, error <= PERIOD_ERROR_MAX || on_vm);
+	}
+
+	traceobj_mark(&trobj, 7);
+
+	traceobj_verify(&trobj, tseq, sizeof(tseq) / sizeof(int));
+
+	exit(0);
+}
-- 
2.43.0
