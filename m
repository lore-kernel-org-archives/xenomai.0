Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BE1E5B7D
	for <xenomai@lists.linux.dev>; Tue, 27 May 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355513; cv=fail; b=qMoMnrgSIfXad7f02fb3ol7hu+jkdLyc0aTHD3Tz1LuAEOETjJhraqEEzEvh00IIgMKRfbqTqcD3g47EcmRDXyu/KNmbbjDlR7P1wT/Ewga/tdYfcB9Bv9EVPnNzVjjrqCZumlXeI53p+7BI66vknWS2MGul7fC9+wY0s1XyhAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355513; c=relaxed/simple;
	bh=C2BbnM3t1wPY/lNK3UrOHFCGlXdUdThJvHGwrnv+9VE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SFK+dqoC7RmklIqvucvOGCoU2svvKgApwYgrTS3bzJBq1zwc0BE+DFYeiN61TbkfJYHSEdW1asG7NxmxdgHrG419Zd9LnbSFtvI55OF/EI+x3AyYhN7FPEK/BP3HaHRXA6rBRtET5f8G7lHP8hTv9nR7qFJ1OWvgGkxzlch+fo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xWmQ0eQ9; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xWmQ0eQ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4MVaZs+WM+Ax47ZZtLJHOYNBLpFRMOOA/fbEtEzD2gfSZ6H+qSPduEyzOIMfirKb69n+zrMa4BQDNrge/AvHADlkVzuUSbp7mwedAADUDmhCULQE2wBiATejGpdNKAFWX17/jTigK8BoGMd98c48FfNBVeW4C6p6FpnuA4Y0aXU2Ms+bQrYMpSvK8ggaVKAK9fln2doF3Gt9NHRzNhiCtsckSmnYIYnMao9ywNVENs4RVJT9zpe+fm9PnZpqFcnSU43/ZSux0RNwCXokf19j3BIsFczMuk8q0MiPRcMAiJeoWe+zbxuF0v4rlB/FH5e1ab3lQkQ8j8yoac1szMf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZl9uBNBL7b0fIYQGU8tYtQnPs1asJPr3yF0dX7MlfE=;
 b=mh8NJcC3ZV0dicAyhxT3krVfP/bypWctdZuy06e/19IB/mdlfgzuNBWktv5f5a5pWIC36oVFqdCUpV9As9v15tlm7oX8tZXu2by6LjaZLH1H9zK1kYjUGP5fEN81lZ3cIIn5U4Gld+c3Kz98FX0RXyjXzMpcvHHxJQnlzqpE7j3H+oVyOUlV1TDDC1mZ1BRtlGa0u6ieuYSspLpARd8D5UWffXtBnLHNGZzMakIC+GqMBtohbwOyNxhwVxy1zu9XjMgCg//Otk+Q8qpQ5hjvWbbMFkDbck/wSpEx5InQB3bCcUa1qxwn0z96UO/GHKT5PQQN10nZrlgtMG/vWawrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZl9uBNBL7b0fIYQGU8tYtQnPs1asJPr3yF0dX7MlfE=;
 b=xWmQ0eQ9jNNlvv7PObp8+Ilow0Q6L02fsPef2kFMzM+ceddccNN1hPEZinOrDtNZfCG/g1D9Hoh22C6S6kOtargU5jhOwDXVicpme9f14Vw2o5xqHkYR62BIsNsi/AFwK2FBn4o+ZR2c/sfP4hEpfC2NM7rEn/K1ojyVMCq30zQ89kbeqeSldzv0eSuGTNkNXHqKL2fm6K0g0jQdd3pckZN4V76iMyL38eX3rdf7MjWVYW7oZ48Y0+2RwFFE5v6n8Ysdl1OcBoeTERbXvwcJh5GFonQ1LyACzKfu9BG6iG6d6qHoPxrA9mkQor1SMr6UN7OvPS3ZEo0XhpvbWTYgYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Tue, 27 May
 2025 14:18:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 14:18:27 +0000
Message-ID: <7cb2e103-c4a3-4456-9deb-adf9bdcc20a7@siemens.com>
Date: Tue, 27 May 2025 16:18:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cobalt/posix/clock: Allow NULL resolution on
 clock_getres64
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 Xenomai <xenomai@lists.linux.dev>
Cc: chensong <chensong@tj.kylinos.cn>
References: <00e27ff6-15e8-4b24-9c2b-181755ec2cba@siemens.com>
 <569ce07695ba9d09a81ae8b521e1a072fc5283ea.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <569ce07695ba9d09a81ae8b521e1a072fc5283ea.camel@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1d70a1-68e9-4e28-6752-08dd9d29593b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0VLTm1WSGE4UFM0WkJXVnlLTG0wYytwamlyUE5FRkk3bWsyeFNBWUlKWXBF?=
 =?utf-8?B?VEhyZUxBSHh4aEgxSko2Qzl2eXdMM0Zqd0FXR0lZWU82OWw4ZzA5YnNxY0tV?=
 =?utf-8?B?SERmcHVXT0Rqa1N5Y0FydjYxeG0zTStmZVNPSzJ4M0xvTG1XdUZ6QUxaTGUy?=
 =?utf-8?B?M0tYQ1pzYmRQRkJOWU9BRlBvazN5aFZTbnZWN2JEZ204UWpxZ0d4Mm1vYk9J?=
 =?utf-8?B?emFhZmtKVERyOU82YW9SSVl1Sk1FK3U2dUZwSXBsR3ZHU0V4bzU5bGVUZE96?=
 =?utf-8?B?dVJ5RVd2YmZiRWtPNC9ENmpNVDJxY2h2SGRxb0ZxSXFBMEhFbzZScUdjM0hW?=
 =?utf-8?B?SWlaRmo1SUc5dGdqWEdGbkxWOSthZC8rTkRYdVI4aENXeGlYL0txNmtkQmtw?=
 =?utf-8?B?SlB0VCthYXZNVUZYZHNsTE1wSWFXMWRwY3l5clJvbnV2TFFsWGpxK1BSK1Zv?=
 =?utf-8?B?Yjc3cHo4aDNKTTVOQ0RHdndmeWkxTmtGNkdneVV2a2JCNFVORXM4N0lQeDB1?=
 =?utf-8?B?Y1U2QzdMd2FVdVhmVWNlOFYyVm1odmt0SFhKWEhtY1dPcDdqNE1hZWNEVW1o?=
 =?utf-8?B?dGZMSy9oME1SYlBYYWN0TVpyOFdWeFl4cHNsQXFOR2VJYjFLYWhuOU9kdCsx?=
 =?utf-8?B?RHJZeGFzaG44U0N5dGhBVmJvbnVvOERhL3owcS9rY0hvOW5qbE5Kb1Z0OTl4?=
 =?utf-8?B?NEFzSklDNjlZbVBsU3RjbmRSbTd3Y3NMSUN2VG5UUVZ1UmxPRUUydDQvOTlT?=
 =?utf-8?B?SkRBZEtWamRJUTVTK1g0ZWIzSE9kUk00V2FoMWdqOUVCKzkzR2c2S0g3aXBS?=
 =?utf-8?B?b2F0WExPbHp3SHZaRTBTSDFDYURjZUNob0Z4SEU4c2NGOGxUb0NSaTJRdnNh?=
 =?utf-8?B?UnJaRWFHb2srd0tOUER3dVNnY3J2V2FYSDdXU2IyZDVGK21WNVBSUTdTVGR3?=
 =?utf-8?B?U0VWN2piR05JcmZoSTRwSnlkTUEwSVJOQThSbGY2anh6MDliUm9VVmZZaC8z?=
 =?utf-8?B?L0h1ZjdUUU5Zd09RZlNpQlp4QnFPNXRxVU1oeFg2bG0yUXVZMDhPMmk4bXlQ?=
 =?utf-8?B?My9YV2E5a09pUzkzUEs5SEJXaWE2dytidmJQS2d0VExVUXJDMUJYcDZ0aHVn?=
 =?utf-8?B?QWpCdkZrVzRaa1lwTVhqZG9sYXN2T2U2RzdHbXg0NHBtQjNCMlVQU2tCZEdU?=
 =?utf-8?B?SGtYV0d0T3RlK2E1TWhlQWt4WXJ0VFZkaDFUdnRSUzRFZUNQY2VrTUFheWJl?=
 =?utf-8?B?SVUzTUNReHFXZUNab2pCNS8rYmdRUkVrZzVSU0N2YXZOdmdTZUtQR2EzalNR?=
 =?utf-8?B?d1R4cDh2Zmw3aHRBbkpzRzkraTRFdHdmcDc2dndFKzU2WENVSmIyY2JUd2Yx?=
 =?utf-8?B?Y0R6eDJKZGpOd0crNmxQZU5rVUsvTzJSQW1UakdaRnY2clBtMFk2S1pnODdm?=
 =?utf-8?B?OFFuVlFuajJUMDR0eUpNNWdxeUFRVU16L1R4azg5VHU4ei9YclY4c0pLYkVQ?=
 =?utf-8?B?MGdxVlJkNzMvcTNTanVYK3VqRzRPejFxdXZ5T2xRYXNKdnFpbFZHZDRiY2ND?=
 =?utf-8?B?WVFEWkRVVm9ZeG0weWM1STcvclE2dWsxU3N1bzBvUXgxY2h3ZDVkK2V5ZDJz?=
 =?utf-8?B?K0E0QU5rbkZFZ21VRy90NEZvcmdMb1NPRG5rNDYzZ01nWDBSOFNQQ0loZlp4?=
 =?utf-8?B?d2V1VjJSNmo0QVRJc0IwRFc3TE1wYVZSUVI1eXV2VlBJWkdRdHpaMllYamlk?=
 =?utf-8?B?eGE0TmYzTUY5SzliNlo1NHVXQmNwRk5zMGZ0Vk1EcitBZUgvclc5aVJOS0Zh?=
 =?utf-8?B?U2F3YktGMHBacWlkWjhqbWk2MEI1YURTM21vaHpHcU5BRkhGcUFReHhXMkdy?=
 =?utf-8?B?dHhuS0JtZzhPUGFnNkxWbUcxNWtMZUo0UUtkNDZSVnlCRldKclBtTmp4ZmpW?=
 =?utf-8?Q?HGVfZANSC28=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3Yva3c1SFZiN2Ixdzh2WVVHTmdMY1JxZ0R4K2UrZm5LMGNjOEFFNEFpSlZO?=
 =?utf-8?B?bWFDaWhsbm9CZ00rZ2Y2ZmlHYnU2Vkt2UVd4RElHVnIwWFUvQUNXeEhaRW8r?=
 =?utf-8?B?U1VheGFvSTdvUFdkYzZUcEtIMEJ4cWVTbGpxeTRBd2EvcjdTeVphb1pldy9R?=
 =?utf-8?B?SDA4NFp3cXZKRUpESGtuQ0pxVDMyTnNFbjJDdjJJWS9pTWkrTjNFeStNZlBa?=
 =?utf-8?B?eGNyNSs0bUxMcVAwMWZiRmdLdk1EeGdhUE5lbkVpelZrK0MvN21JcHhUVEhK?=
 =?utf-8?B?V1FDeXYvY1VMNk1FdUYvbHUvMFk5czVrOWkrVmQza2VOclV5b1JlWjFEdllG?=
 =?utf-8?B?eVJKa254NERjYlRmRDFZUGloNWgzR0tFV0ptYVd0V0JoSVg0QTZSaWhWcCt1?=
 =?utf-8?B?YVlQMU5GWVFMTWs0SFdIUDkzdGh2OXBPYjF0NjhhRHhXMUNMcEc4ckdxQU5Z?=
 =?utf-8?B?WElueXhwSzg1dDY4Ry9iY2txamJmK0E3dlpaYi9ZM1k4NVUvdTJ5UEt3eHJQ?=
 =?utf-8?B?b0lhNk5ObTNBa0xCUEd2TmlXNDYyRmpFd0dsSnU3VjIrKzBlcHBDOE4ycEp0?=
 =?utf-8?B?NEp5ZHgwazFUejBBbU84VTR6UlpQRmkxK1FlYWxmMklqVVQ0ck54VVFPQXR1?=
 =?utf-8?B?N3h1OXNqclJLR1JHQlEvQlJtTkNMMUJ5K256bDFGeXpMQkNyVXRnWUxMRDRy?=
 =?utf-8?B?M1BwbzRONncwM0FTejlibE1qU3gwVm96SW9uakR4WEwvWE1NZnpMSEppMHVI?=
 =?utf-8?B?Z2FhR0hsc09kNVc4cm1Zc1FTL0xxd2treExabXFDRlQ1cEwxZXBvd1Z4WTRB?=
 =?utf-8?B?WGp4ekRQL2txaE5PNWxEdlBiK29EZE1FUlMxdmlKSHpnVE5qVlFVbXFqdmc2?=
 =?utf-8?B?ZDBTd1A5LzRVUEErSmwybnZyTEdHWXJxblBpTFpsNjdMQmdtRXhma0pmNWt3?=
 =?utf-8?B?T0lHOVpmSjNTaU1ya1BIaThBdGg3TEtjM3V0ZkRZL3RZK1lhcWp4VVI1OGw4?=
 =?utf-8?B?bXloWXBiMUNPckhhLzg4aHVkYlBoZGF2azVIb1ZpQk9uWitHVjAydDN0QVJx?=
 =?utf-8?B?OXBTcE5Jd1dIVmR0K2NmZHFSeFRoL1lmWXg5YkVvcWtTZHIrd0hCdTk1VHJ6?=
 =?utf-8?B?bU9HNlVYb1lBVWNRejhiYkxERmU1dmI3MVVUWFY5c0xvWlZOeitIRTJoZmZv?=
 =?utf-8?B?anhwWGpaNU9naThGRVFubVZrOEdTcW9KOWJFM0c0Zm5qT0w3RVVIbGZGa3g3?=
 =?utf-8?B?SmEzV2pBelUzUXViTC9jOUxEazBwYTZZWlhBbkp0aFgxcmVmcEZ0dTZLSG1B?=
 =?utf-8?B?NzgzZC9aeEZJVmJLUmF0YnBNRmdNelBLc1JQanBGVmZlNEpFcUVKWFlFZEgz?=
 =?utf-8?B?RDRLU0RaWmhBa0MzTU1UMXBWdXdCWFFKcXNkY2NhVVJvZEZKUWxSaUhGMFpW?=
 =?utf-8?B?NUdKRHhpVVNzcElCZTV1dXBXemNQTjR0NUNjR0VMazZzV2xaU2FFc0ZpVkdk?=
 =?utf-8?B?R1h6cnAxcU1mbFNxY016dkxFT1k1ajFEZVp0RHBVTzFXZEVMV3VVWUYySjFY?=
 =?utf-8?B?QlNtWjE5YWpBanN3UmZ3czFKM3Uzbi9KY0RmK0lBcjFhRWNWYWZGdDlkRTg5?=
 =?utf-8?B?ZzBkWGZIcGNSTGRiV3NiYm9qVEpJamhDSStjbGdiK044aXdUWm5hTFJQWEdj?=
 =?utf-8?B?Q09zNm1DdklSYStLdWU1anZxSDh6clI4dE5oaFE3dk4wMURKWEE3U1ExNkJl?=
 =?utf-8?B?dTBvTU9XQnFuUHpON0VKV0hmbGRGVjhhYmZVbHhoYU83NGYyZmM5c1ZhT2lF?=
 =?utf-8?B?aWNJL3dJWU9xdURVQXNmUlVvaGFoQmFTTi85cXdpbXlKeDlKK25DZnhlTE4v?=
 =?utf-8?B?aWZYZ2VqTURXeVJkTERWV01EUmVWZklnWDJyRGZvSUFkTjkrdUhJbGNMOE1u?=
 =?utf-8?B?SGpCZ0N4SCt4VVVTbmxiWE10bzRVZENCSGJlcDJMYjJ5K05DcmIxekVVa3Ev?=
 =?utf-8?B?OGs3enR6TjFSVmJsU0l2YTcwWEpjM1dEbE1CejUwd0g0RDRCeVRwUERlamo4?=
 =?utf-8?B?cEpGQWxFVDdmT2lNWXlBY0NQY3RyQzdRV0RoV0pMTjRjSTdNYVVyTy9OQUhn?=
 =?utf-8?B?VE5SUTJnamRqT2VWcmk2TkM3UzIxa1haMVh5Tk82VnFUejI0VG9rMjhjVFFj?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1d70a1-68e9-4e28-6752-08dd9d29593b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 14:18:27.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5k35P3CbNrPNNyBaR2mibe5iEoUZOVz+I4/6dz4b026YE0T+iVpYAwU0Jr7F+Yz2V2rmu29qzgE5vHivYW9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7824

On 27.05.25 15:18, Florian Bezdeka wrote:
> On Tue, 2025-05-27 at 14:59 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Permitted according to POSIX spec. Adjust the testsuite accordingly.
>>
>> Fixes: 633022801750 ("y2038: cobalt/posix/clock: Adding clock_getres64")
> 
> Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> Changes in v2:
>>  - also adjust the test case
>>
>>  kernel/cobalt/posix/clock.c            | 2 +-
>>  testsuite/smokey/y2038/syscall-tests.c | 6 +++---
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
>> index 845918a4a1..e6c187ca40 100644
>> --- a/kernel/cobalt/posix/clock.c
>> +++ b/kernel/cobalt/posix/clock.c
>> @@ -103,7 +103,7 @@ COBALT_SYSCALL(clock_getres64, current,
>>  	if (ret)
>>  		return ret;
>>  
>> -	if (cobalt_put_timespec64(&ts, u_ts))
>> +	if (u_ts && cobalt_put_timespec64(&ts, u_ts))
>>  		return -EFAULT;
>>  
>>  	trace_cobalt_clock_getres(clock_id, &ts);
>> diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
>> index 7b56d281a6..4318712cc4 100644
>> --- a/testsuite/smokey/y2038/syscall-tests.c
>> +++ b/testsuite/smokey/y2038/syscall-tests.c
>> @@ -363,13 +363,13 @@ static int test_sc_cobalt_clock_getres64(void)
>>  	struct xn_timespec64 ts64;
>>  	int ret;
>>  
>> -	/* Make sure we don't crash because of NULL pointers */
>> -	ret = XENOMAI_SYSCALL2(sc_nr, NULL, NULL);
>> +	/* Make sure we accept a NULL pointer */
>> +	ret = XENOMAI_SYSCALL2(sc_nr, CLOCK_MONOTONIC, NULL);
>>  	if (ret == -ENOSYS) {
>>  		smokey_note("clock_getres64: skipped. (no kernel support)");
>>  		return 0; // Not implemented, nothing to test, success
>>  	}
>> -	if (!smokey_assert(ret == -EFAULT))
>> +	if (!smokey_assert(ret == 0))
>>  		return ret ? ret : -EINVAL;
> 
> Seems a pipeline run revealed the missing test adjustments ;-)
> 

Yes...

That should also cover you comment on v1 which I only saw now.

Jan

> 
>>  	/* Providing an invalid address has to deliver EFAULT */
>> -- 
>> 2.43.0
> 


-- 
Siemens AG, Foundational Technologies
Linux Expert Center
