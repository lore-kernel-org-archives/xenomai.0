Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917B1509BF
	for <xenomai@lists.linux.dev>; Fri, 30 Aug 2024 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023507; cv=fail; b=BJLPS1V+xLrWM39BTGb3YM+h7+5SfCtFO+60o/Pc+pQAPd5VEMuatKFiSl4ujFxaBNYlXqU4F/kbGp9a4FlO0HaLfA8m/TJRScfkQGDOCLMelM3AMzmQW1FIIXZEIJ4hT1C6iwMwxIlv1/LW4rq8jmKzdZh0CHg90sc2uvv6JbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023507; c=relaxed/simple;
	bh=A1kwRB3+ROdYAiowuCgdQj4KpErvXbYNHDj5w0azi4M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZM5zoYYX/D7WE1+MpCgPbFlcQ5742inwwoayoxfr7uzNKM7Hlk8KxDqUyCmWHiBgzG+M7lSVCbyXkLQ0iYyjjf9hTUgsUs70z9irCG9Jna5V7ra+QPKFWc2GkHlhAMA+ZeWGRC4nfxOTzxusUUhz7xolRCBuSCc2L5FjLY4k57c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=vAZElfde; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="vAZElfde"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkHXRyV7amQXGJzqfm7dU7iUuUeeDLuOTqwSqxQgnKPCbaugb2ij3Oo6ZItIXREqW3t4ZBMpLmjAH6EK1q6WX4ed3qH/IB2LKsN67akkliFqCCb8ZOUNgjcMHdkAnxgdPKfZofwPggqggvHsZV1iQcUbp1g7jsoujd9hhBZ/hNB6tL+DysAPetQx1Lld5zQ/Id8TmisjxLPnSoU2vT7BFHZhuxC2ubmx3+F+axOpgPr6UNtI1ysaoLL3r15u15DwotMvN5aD04c7sI9PT/9p3apN0O0776CKrJ6IoboqE2SCjUe18anx81o0fG6QQY3B4L1DwiKV6CWGJH3syECHSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja6SpN3xornaV56X0Nie2w2Vj91+r1KxI4ne4vsD3hc=;
 b=m4SyWQEhpI4YQlHY60u9o9Rfkq+9wmV76VNgY6Sxqsk/ydzK3+nDO3MreIqCJ7puTK3JZwmIBaN8+U0Cj8Z1OD65Ia472Y0W/3a/jJRybVLVNontU+t0aSfyo9HCGq0mainR2xtFiw4qyyo/ZkpC+lPoYMrspzzfC1zmRsom6grJapJ7S0oRgtWC/UgkrCs6sUjqZ6iJevkxnv1IHqlq8bFdZl0ibJNAmgxMO7vPhZUl8GWuz6D2ogrQmCE8XiIX5DCjytpbVZcGl0BjtTh8cimUWm1Hs9cR1LR0ve52LNMUbJtasVHjZvY7AjZiq7L9OLYwonxJLym5sRdG4HwvPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ja6SpN3xornaV56X0Nie2w2Vj91+r1KxI4ne4vsD3hc=;
 b=vAZElfdemWXXjkqmITIXGNg4WxCMe+kwehfE/k3PqRGL+DMjyn8dozOJYj1h83GNT5c68Vo6GYE+oKpv8nlTMTrF0khDkpWOIDwUmofGxvA11v/Xbq2Dvs0XaPW+1Hh0WErTyg4l+lf5rNhWoBIm0xtgqso3btEcHnujxhU/fagfAJ2ZB6Yy7VIC35rCg2TfwiJjqYWE5kJXiNbIDJJ2mILCY8B7pMgOBYkMuF9vCWVoidaJrJF6E71xUJrh/Ak8nJj5RRxNr7y9n0uiNutWhAINpQtXVU6dSlvecQLKFVw1VZhdF5B2t/uFc7VHgZzR7njZKjJVMWPT9Eulb7qpdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c3::21)
 by GVXPR10MB6007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:11:40 +0000
Received: from VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::500a:8636:bbec:bbc2]) by VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::500a:8636:bbec:bbc2%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 13:11:40 +0000
Message-ID: <98e1c485-a314-46c6-bbe8-348870857a9d@siemens.com>
Date: Fri, 30 Aug 2024 15:11:39 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] testsuite/smokey/posix-mutex: Fix race-condition
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
References: <20240830111952.26651-1-Fabian.Scheler@siemens.com>
 <4c253f1d-7a32-4113-b016-400cf1f7e045@siemens.com>
Content-Language: de-DE
From: "Scheler, Fabian" <Fabian.Scheler@siemens.com>
In-Reply-To: <4c253f1d-7a32-4113-b016-400cf1f7e045@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::9) To VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1c3::21)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB7672:EE_|GVXPR10MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 9360a987-b063-481e-6754-08dcc8f54929
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y21rUklscWE4NlpEanFCbmR3WlBhVjdQK3U0TUphcy9GaVAyMzhaWDgvMTB1?=
 =?utf-8?B?ZDk4ZWkyczBwSWQ5d1NndlRSQkJoK25Lc1lwSkhXd2lYY1ZKZHRCNGdkV0hI?=
 =?utf-8?B?TjBVbDJlMGR6aXNiK0NkRVNLQ2Y4c0MrQVlRNkRGdWs5MHpkbGN0Rlk3OXNs?=
 =?utf-8?B?QVNkMzBnSEIzd0l6WEYyckFRS3FEM3hHMWJzYUpYM0x0RFhJSkoxdks1ckc0?=
 =?utf-8?B?YmdlWURFYU0yb2F4a252SktBSWxyeW1scFdOQ2hJdUpPRXFuY3UwYjNNWkR5?=
 =?utf-8?B?dmpGclh0SGpnQ0FUTzFNMW01YlptckkzL2FjK2ZzT2k4OWNhb2Viam9BTzNa?=
 =?utf-8?B?NU4rNGVvM1YzVGtUVzQrVERsTUVsYjB0WlBKVXI2S2hqaVowZUFkY2hmazdw?=
 =?utf-8?B?U3puQkkzRURlOGlLbUhDVTF3V0VjeGZwVXl1Snk3ZlRwNkRSUjdIZUhKVHpw?=
 =?utf-8?B?L0NraVV5dkJSbkttSHJteGxxY3NJK1ZQQU9udTk0bmpXeVpwckUvcS9qSEY2?=
 =?utf-8?B?L1c1TnVid3JvdVpJMC9OakdrVnVhRXgvR3Z3N3FCNmc5RU91Slk2dFZUbHN6?=
 =?utf-8?B?aTRCVEswVTVWNStkVlE1V2ZlUDU3aUZZMVQ1bjA5Ulhvb0FRbEV3QWxvWElw?=
 =?utf-8?B?ZE5QWjVvUmkzMGhSK0pzTkRsZUFDS1Z4R3RUYkpSS1kxRGVJL2thV2VYVXoz?=
 =?utf-8?B?Ly9qSVBRVjZ6TG5UQmpvUVlrSkk1UUx1N2FCSHFobkx5MWNmRHBneUIyQ2ov?=
 =?utf-8?B?SGJDS09pL0xFTjNyWHUxQ1NRYjMwak84ZDFqTmVIcHpPc2p6UHRQdmdyeXRS?=
 =?utf-8?B?Ylk3T2lacE9BL2tUQlFQcWwyTWx6QXlvSnJFSWx6Tk80ZmZ2amkzRnJYekVG?=
 =?utf-8?B?MWJ5L2tDSmp0dDFCWTFkSDUwUGlrWlJQU0VBV2E3UHBOZzJpTVVpcW94SENR?=
 =?utf-8?B?LzVHTjBud2RKSnRJL2VBUVZjaVlhMFNrNlo3WTJkNTVHVkJpQWUxaXdxTURw?=
 =?utf-8?B?SFlVKytoL1FzZHJPcTFDQWpjZHFrQlhhbCthL2QrZFBlSFU5OXZmWWtTRGZP?=
 =?utf-8?B?c1ZSMko4eXRVZFhZMlVReHZpQXpSVHFWa1I0MVBsT1E0Ri9QY1EySUlMUWNB?=
 =?utf-8?B?WGJqU2RPNWMyNnd2RnppS0hFRXl4N0I0SkpDeEFQUW9oaXZQTlRTdUw2aGwv?=
 =?utf-8?B?UEtlakp5aldCUVZYODVSa1g3UVNaNGNBRGIxekozVFhMMDJrT0U1clMwbWgv?=
 =?utf-8?B?em0rZVVOT3ZVUVFaaGx0N0ZFRWQyejBoS1lrOWpwbExFRzF5bFBQY3YrQ1p2?=
 =?utf-8?B?SEFIUFBnUWdueUxQN2JhMVlSYTh1K2xLQjZrY1ZtSE40c1d2UytRSnJhQWR4?=
 =?utf-8?B?NGxkTTdTbTBqNXd2WnVucVdqdGxRYWRGck1vOFB5b3FJVFdySllZclBmcEs1?=
 =?utf-8?B?bHlId0lIa3AxOTNySTBVczNWMWZUZURCRGZBdGk0SkRqcUJ6d3VIdEsxUWYy?=
 =?utf-8?B?bHQxbGhuSUVKZ3ZNaTlhRTdiYlZIOS9nVDh3Tmd2YUZMS3lzU1JuL2MwMFkv?=
 =?utf-8?B?T256U1B5Ym1McFRKa01BWTcrY2JQSUNlL3lKZlNjN3pXSFZ2NkEzeXlpVjZW?=
 =?utf-8?B?TGZPT0YyMmJBYmp3em4wYzk2bnZoMDVrWllRdW1tbklCb3Y2Qy9CcUEyajh5?=
 =?utf-8?B?cnlhK0ZIQ0xtREMxS0RwWjZVQlp0MUFGNWRSNE1xQitzamZ0dlM0eVhsdENG?=
 =?utf-8?Q?PT4MYMZk0LgHtPtq9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ymt1NEJOZGpyQXBQa0FJRWpncG1pWS9GMWVCNmdjVGl6aTJUem9Ybmk5R3Js?=
 =?utf-8?B?T3RxWUlKTnVvQ25iUmJNVzl2SnFUVndQNHFhcVlIUWE1VGFBcjZ4MnZ4d1VS?=
 =?utf-8?B?cXY4NU1TN3I3YkRlUzJhR3hpVnVHNUh1UjVmNDJibWg1WU9KaFBla0dtdE5K?=
 =?utf-8?B?eUl2UGh0WnZPaUxJbEsxdXRVSU9sNkljYkk0MkRXMGhDNE1JVlMxY2VwTC82?=
 =?utf-8?B?YzE1eE9QWCtJR2VNZ3VjcjRHbzZEQjhaWFRYSUFhOW1jRDMzam95TXZGVzRP?=
 =?utf-8?B?anBDQVRKcy91S1YwdHJoOHVrejlqakRoWnJKQ3JBaXdTamlQOFpsOHdKbnFS?=
 =?utf-8?B?SDNJTVFKL1p5RzlLYVZyM0lrMENITGtuSzhsN3l2dGRmcjVNenBWR1ZYRjFm?=
 =?utf-8?B?OGErZHkyUlI5OE05YUF6eTNsM0Y0STlFRzhGeFpHYXR2NmhKSTRwM096NnNK?=
 =?utf-8?B?ak5TbDMxck5pckFGcVpibzl6dFAxVzVuMlhNdWorcTNnK1pjdnJxbDYzbHZF?=
 =?utf-8?B?KzFjWk94czNwTC9xR3JoZjE1Vm9taGRjdWwzRWp2RndHQ3hOc0NaTHVEMTJB?=
 =?utf-8?B?SkY0TlRhQWkrbkJ2QUhEeEY5aEJHRjA5RDFHbU5OWnpTSkJDSlBRMDFOSDh3?=
 =?utf-8?B?Q3N2RnJLblRxQTdMZUl3aXJFSnBoYXFyQzhvRFdPVGxRZDY1VlE5Y0lxeFhz?=
 =?utf-8?B?VUxwYk03aVNWbnNMeFBkM3k3OGRlWE1DQTRUWDBHYitOQW9PR1BON1ZJeHdI?=
 =?utf-8?B?Ym0wcGpWY1M0QWJuaWZ0SnBQVi8zaXRYNC83eFFXbHpNUm96UjU3c1RlUjFQ?=
 =?utf-8?B?N1FOR3FHd1RHM0Vib3grM0d4ajV1bGlnSlhBdW1ONHBsV3JrRzllbUlUVmd2?=
 =?utf-8?B?THIvK1A4dGpjT3VKcFFtQjVTN3JtejRzdFpRMlBmRHdxYlNGM0FUdlNYT3Rp?=
 =?utf-8?B?a1pJRUVObHJJalpYVFh6bjdsVjczUW5DdFA0cmhaSi9SS2VaREs3QjZYMG0z?=
 =?utf-8?B?Z1c2b2dudXkyWHNLMU81QXMwUkhKSDMwV2NCemhVcGhZdkJrdDhtaEU0NDU2?=
 =?utf-8?B?eVJGT3cwOEdrWmtzc0FQb1pwNWlVUWZ0MUlQRi9kVE8vYWk1MFVIcUFrRGM1?=
 =?utf-8?B?RFFxTzlCNXVzZ0dUNUVKWjV4ay96UWdUK1daZHhlVk1zT1FaR3MzdXJPZmpt?=
 =?utf-8?B?dFFkQjVkZFkrR3UxOEtjWXlwbjIwK1BmOCtjaUtDSk5RVGR6WVI0RVNwMmhV?=
 =?utf-8?B?UkJFbGZCNmlRT0tld2RZQjA4UUs4eFpwMStRR29oRHBDa0pNZVJjd0RURlc1?=
 =?utf-8?B?anV2M0pzSFJsampzV3c5aDRqdFlSUmNtdE1xa1NLR25qSk5mNnlnM2txU05n?=
 =?utf-8?B?MG5LSSt6d3ZxT05WNXlNZTZORmYvQlRrSjhJcVJlUm9TRk9MclFkTkZaWENi?=
 =?utf-8?B?c3FERlpzY21jTlVxQ3BVYmtrSk4vU2VVKzJ3VERLQjVWSmZlRjBUclh6Zkc1?=
 =?utf-8?B?cllQZ0d0RkRueS9DQXFyUllvdi9nOGlaNVFWYlB3ZFB5WHNwcXFGZGRzRUJx?=
 =?utf-8?B?ekx5MVo3Vm1nMllIWGI4RFUzT3BVb0FxVnBGcXNBL2RDaU5FenJMNG5hTlJi?=
 =?utf-8?B?TVRyUzhlTTlTOHFpRmtDaVRGOFRIQXgzU2c0S0xyM0UrRUthQjdHVUplcy9N?=
 =?utf-8?B?ZXVSL1ZqKy8yUHgvejJTcVhHcktsdGNCK0wvaXAzcS9lTDZDMWZuOVNaSnZj?=
 =?utf-8?B?aHVqbzc1RFpIczNzNHhRUEdNcWxiNjg4ajVlRlowbmxJQ1ZEd0FVb2k2Rnc4?=
 =?utf-8?B?dk5LWE9HWmtGL0xRNEpXTFZ1bnU1TU9YajJ5TkxTUTN4Vll6OS90a1RmUTlW?=
 =?utf-8?B?TmZWWHRDdUpHdThHb01rQzRmYzY2UzJMT2hXbytQaTdQSWlsRC9jdTJEMjQx?=
 =?utf-8?B?eVZJU3ZENTBoc2RVZDl4MkdwOG5oMnhZeVhtZ3U2bDZiR3Q5RFJKYXE1QjRF?=
 =?utf-8?B?a096OHYxcnFIeHFRK0hia2Mwazc4OFlQK21zOHJ3RzMzSys1WjhaVVRlTFY0?=
 =?utf-8?B?b2pJN0R3WDFBR0ZDWERmMkRRSFJQZnBkZTEwclA5Z1hSQWpaUkowLzBwWVRD?=
 =?utf-8?B?SFJ4NE1RQitMSVhndmhYR09rSDQzZlJnVmRNaElpTVlMcjAyY2hSZkRlaWtB?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9360a987-b063-481e-6754-08dcc8f54929
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB7672.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:11:40.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdQLs4JD74JPZCQrxatIiGOVvMxGDCAopzqYXw8pswKX0l6fJTOJIzrzVrWSyZFnnVOM5B42L2pQQ0EAWA8EZZecPSBWe3W/mcn654fn+QA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB6007

Am 30.08.2024 um 13:24 schrieb Jan Kiszka:
> On 30.08.24 13:19, Fabian.Scheler@siemens.com wrote:
>> From: Fabian Scheler <Fabian.Scheler@siemens.com>
>>
>> In the testcase pi_nesting_contend_multicore the thread low may be unblocked to
>> early preventing the thread medium from running until the end of the testcase,
>> making the testcase fail, as the thread medium is expected to run before the
>> thread low exits.
>>
>> This is fixed by ensuring that all threads are properly setup within the
>> init-phase of the testcase, by additional instances of smokey_barrier used to
>> signal that a particular thread has been started during the init-phase of the
>> testcase.
>>
>> Signed-off-by: Fabian Scheler <Fabian.Scheler@siemens.com>
>> ---
>>   testsuite/smokey/posix-mutex/posix-mutex.c | 54 ++++++++++++++++++++--
>>   1 file changed, 50 insertions(+), 4 deletions(-)
>>
>> diff --git a/testsuite/smokey/posix-mutex/posix-mutex.c b/testsuite/smokey/posix-mutex/posix-mutex.c
>> index 5cca0d2a1..249fc6c06 100644
>> --- a/testsuite/smokey/posix-mutex/posix-mutex.c
>> +++ b/testsuite/smokey/posix-mutex/posix-mutex.c
>> @@ -551,17 +551,20 @@ struct multicore_low_context {
>>   	struct smokey_barrier *locker1_barrier;
>>   	struct smokey_barrier *locker2_barrier;
>>   	struct smokey_barrier *medium_barrier;
>> +	struct smokey_barrier *ready_barrier;
>>   	int *medium_flag;
>>   };
>>   
>>   struct multicore_mutex_locker_context {
>>   	pthread_mutex_t *mutex;
>>   	struct smokey_barrier *barrier;
>> +	struct smokey_barrier *ready_barrier;
>>   };
>>   
>>   struct multicore_medium_context {
>>   	int *flag;
>>   	struct smokey_barrier *barrier;
>> +	struct smokey_barrier *ready_barrier;
>>   };
>>   
>>   static void *pi_nesting_contend_multicore_low(void *arg)
>> @@ -570,6 +573,8 @@ static void *pi_nesting_contend_multicore_low(void *arg)
>>   		(struct multicore_low_context *)arg;
>>   	int ret;
>>   
>> +	smokey_barrier_release(context->ready_barrier);
>> +
>>   	if (!__T(ret, smokey_barrier_wait(context->low_barrier)))
>>   		return (void *)(long)ret;
>>   
>> @@ -604,6 +609,8 @@ static void *pi_nesting_contend_multicore_mutex_locker(void *arg)
>>   		(struct multicore_mutex_locker_context *)arg;
>>   	int ret;
>>   
>> +	smokey_barrier_release(context->ready_barrier);
>> +
>>   	if (!__T(ret, smokey_barrier_wait(context->barrier)))
>>   		return (void *)(long)ret;
>>   
>> @@ -622,6 +629,8 @@ static void *pi_nesting_contend_multicore_medium(void *arg)
>>   		(struct multicore_medium_context *)arg;
>>   	int ret;
>>   
>> +	smokey_barrier_release(context->ready_barrier);
>> +
>>   	if (!__T(ret, smokey_barrier_wait(context->barrier)))
>>   		return (void *)(long)ret;
>>   
>> @@ -687,9 +696,11 @@ static int pi_nesting_contend_multicore_getcpu(cpu_set_t *rt_cpus,
>>   static int pi_nesting_contend_multicore(void)
>>   {
>>   	struct multicore_mutex_locker_context locker1_args, locker2_args;
>> -	int cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
>> -	struct smokey_barrier locker1_barrier, locker2_barrier;
>> -	struct smokey_barrier low_barrier, medium_barrier;
>> +	int ret, cpu, num_cpus, low_medium_cpu, locker1_cpu, locker2_cpu;
>> +	struct smokey_barrier locker1_barrier, locker1_ready_barrier;
>> +	struct smokey_barrier locker2_barrier, locker2_ready_barrier;
>> +	struct smokey_barrier medium_barrier, medium_ready_barrier;
>> +	struct smokey_barrier low_barrier, low_ready_barrier;
>>   	struct multicore_medium_context medium_args;
>>   	pthread_t low, locker1, locker2, medium;
>>   	struct multicore_low_context low_args;
>> @@ -697,7 +708,6 @@ static int pi_nesting_contend_multicore(void)
>>   	cpu_set_t rt_cpus, online_cpus;
>>   	int medium_flag = 0;
>>   	void *status;
>> -	int ret;
>>   
>>   	/* setup test */
>>   
>> @@ -718,18 +728,33 @@ static int pi_nesting_contend_multicore(void)
>>   	locker2_cpu = pi_nesting_contend_multicore_getcpu(
>>   		&rt_cpus, &online_cpus, num_cpus, locker1_cpu);
>>   
>> +	smokey_trace("low_medium_cpu: %d, locker1_cpu: %d, locker2_cpu: %d\n",
>> +		low_medium_cpu, locker1_cpu, locker2_cpu);
>> +
>>   	if (!__T(ret, smokey_barrier_init(&low_barrier)))
>>   		return ret;
>>   
>> +	if (!__T(ret, smokey_barrier_init(&low_ready_barrier)))
>> +		return ret;
>> +
>>   	if (!__T(ret, smokey_barrier_init(&locker1_barrier)))
>>   		return ret;
>>   
>> +	if (!__T(ret, smokey_barrier_init(&locker1_ready_barrier)))
>> +		return ret;
>> +
>>   	if (!__T(ret, smokey_barrier_init(&locker2_barrier)))
>>   		return ret;
>>   
>> +	if (!__T(ret, smokey_barrier_init(&locker2_ready_barrier)))
>> +		return ret;
>> +
>>   	if (!__T(ret, smokey_barrier_init(&medium_barrier)))
>>   		return ret;
>>   
>> +	if (!__T(ret, smokey_barrier_init(&medium_ready_barrier)))
>> +		return ret;
>> +
>>   	ret = do_init_mutex(&mutex1, PTHREAD_MUTEX_NORMAL,
>>   			    PTHREAD_PRIO_INHERIT);
>>   	if (ret)
>> @@ -746,40 +771,56 @@ static int pi_nesting_contend_multicore(void)
>>   	low_args.locker1_barrier = &locker1_barrier;
>>   	low_args.locker2_barrier = &locker2_barrier;
>>   	low_args.medium_barrier = &medium_barrier;
>> +	low_args.ready_barrier = &low_ready_barrier;
>>   	low_args.medium_flag = &medium_flag;
>>   
>>   	locker1_args.mutex = &mutex1;
>>   	locker1_args.barrier = &locker1_barrier;
>> +	locker1_args.ready_barrier = &locker1_ready_barrier;
>>   
>>   	locker2_args.mutex = &mutex2;
>>   	locker2_args.barrier = &locker2_barrier;
>> +	locker2_args.ready_barrier = &locker2_ready_barrier;
>>   
>>   	medium_args.barrier = &medium_barrier;
>>   	medium_args.flag = &medium_flag;
>> +	medium_args.ready_barrier = &medium_ready_barrier;
>>   
>>   	if (!__T(ret, create_thread(
>>   			      &low, SCHED_FIFO, THREAD_PRIO_LOW, low_medium_cpu,
>>   			      pi_nesting_contend_multicore_low, &low_args)))
>>   		return ret;
>>   
>> +	if (!__T(ret, smokey_barrier_wait(&low_ready_barrier)))
>> +		return ret;
>> +
>>   	if (!__T(ret, create_thread(&locker1, SCHED_FIFO, THREAD_PRIO_HIGH,
>>   				    locker1_cpu,
>>   				    pi_nesting_contend_multicore_mutex_locker,
>>   				    &locker1_args)))
>>   		return ret;
>>   
>> +	if (!__T(ret, smokey_barrier_wait(&locker1_ready_barrier)))
>> +		return ret;
>> +
>>   	if (!__T(ret, create_thread(&locker2, SCHED_FIFO, THREAD_PRIO_VERY_HIGH,
>>   				    locker2_cpu,
>>   				    pi_nesting_contend_multicore_mutex_locker,
>>   				    &locker2_args)))
>>   		return ret;
>>   
>> +	if (!__T(ret, smokey_barrier_wait(&locker2_ready_barrier)))
>> +		return ret;
>> +
>>   	if (!__T(ret, create_thread(&medium, SCHED_FIFO, THREAD_PRIO_MEDIUM,
>>   				    low_medium_cpu,
>>   				    pi_nesting_contend_multicore_medium,
>>   				    &medium_args)))
>>   		return ret;
>>   
>> +	if (!__T(ret, smokey_barrier_wait(&medium_ready_barrier)))
>> +		return ret;
>> +
>>   	/* start test */
>>   
>>   	smokey_barrier_release(&low_barrier);
>> @@ -813,6 +854,11 @@ static int pi_nesting_contend_multicore(void)
>>   	smokey_barrier_destroy(&locker2_barrier);
>>   	smokey_barrier_destroy(&medium_barrier);
>>   
>> +	smokey_barrier_destroy(&low_ready_barrier);
>> +	smokey_barrier_destroy(&locker1_ready_barrier);
>> +	smokey_barrier_destroy(&locker2_ready_barrier);
>> +	smokey_barrier_destroy(&medium_ready_barrier);
>> +
>>   	if (!__T(ret, pthread_mutex_destroy(&mutex1)))
>>   		return ret;
>>   	if (!__T(ret, pthread_mutex_destroy(&mutex2)))
> 
> This was seen at least once in
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/890675
> 
> Were you able to enforce this issue locally (artificial delay etc) and
> then validate the this patch?

Yes, I was able to reproduce this via qemu and was also able to validate 
the patch via qemu.

Ciao
Fabian
-- 
With best regards,
Dr. Fabian Scheler

Siemens AG
T CED EDC-DE
Hertha-Sponer-Weg 3
91058 Erlangen, Germany
Phone: +49 (1522) 1702973
Mobile: +49 (1522) 1702973
mailto:fabian.scheler@siemens.com
www.siemens.com

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim 
Hagemann Snabe; Managing Board: Roland Busch, Chairman, President and 
Chief Executive Officer; Cedrik Neike, Matthias Rebellius, Ralf P. 
Thomas, Judith Wiese; Registered offices: Berlin and Munich, Germany; 
Commercial registries: Berlin-Charlottenburg, HRB 12300, Munich, HRB 
6684; WEEE-Reg.-No. DE 23691322

