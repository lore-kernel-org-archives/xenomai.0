Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3C2868B0
	for <xenomai@lists.linux.dev>; Tue, 24 Feb 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958272; cv=fail; b=o1kvP/R3HFNNe65KcTT+N7kKv1vc8ZRmno+k3WbdvAKdLGDXextOsesxdDrLceMtm0+U8hIqzSkCwtJIg2e43qWH+wQt3T+HBDPZD1gQ7ZIC86VU/8FkwQ5270iZ7qW/4/x/cJ+69cwoC2DV0h72K5q3cW+ElQ8kww3eIFxn9Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958272; c=relaxed/simple;
	bh=qUiQQdDhVIShXWFvlzBq0rbpc2oxHcxHl3jBSfWC30s=;
	h=Message-ID:Date:From:To:Subject:Content-Type:MIME-Version; b=Qn41ETZrwwnnxBwPfsK/FSDUC4UQvct90G0AlE3TlNvMgokZGl+tEg9CQkeX/iylvl1fMnrjdWN94mxObG9MQlKfoJftX4kAPY5fxV33UUmnCXufKdSaIJFaRd6M/6N1hN/verdKWotIDvYeM9tI/AydksGtQGkM2sjBvytJIAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wW/BmB9C; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wW/BmB9C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0mqheva6g3MVeYmrCPTOGFyo6HNnhZZdfPij2LL512+nhHAIUvIF90u6cxM6llrjPer356unlnSAzbRZdNuSalWq78llZ4IBYGDAcqgTcJVOADOyp8kuK6+toGXX+2VELNpuipBlQW/lPUpliDiAXmfok6T5O1m6DX1ytI8QYmy9ZegPWjtlruv+IBXUUctkgf1ncc+g/j5M8kRIxP2i2Ijp9w4VwxkEQDbKVKXtXhwlAYvwoj6XgLAcnDnxHHQPx4/s0QviHcpBkHDRYktsD7aRX4ZpGZiL0i+j6n6GwnPwyU2nr6Arf9CYT9m5inhfEWp6Opk3J12RfSUXKP75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/dOQHmajsyREq4nl7rCnwc2x/+1ZKdLpTlxTkRYZm0=;
 b=iIKoSqr0vvJUKlM0qRiEfdOZDCuI87aQNJfMB6VlPcixGCm5k7uPGohNkf/MVc1VOUJBXUpW6im6a+505+eHRnOSLZxCLmg4uSDZukGKB4qK89qKVYANE6fLBSAwptjk8DzmZYvv7GyJRmb27l8WUpxbpcsO1KERZtM/sYA0kcoJ2HVECreSkMklqz4HMgzWzEzpNSzWAjC+QiKQZze4dLRCdykwU/6DAGOOKE3q/ukWbXp9/zX1ChZIzbZ1l2LIxiLiSgjjw33CaMe9xLDZqmGbN3bkHfG9GdxbRlCI/IFVEGIB/xY1YXebE/B2hUseAiJaKXqnlFO3nqOL01kYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/dOQHmajsyREq4nl7rCnwc2x/+1ZKdLpTlxTkRYZm0=;
 b=wW/BmB9CpQ7sYBPVGX3DM3QjzuUHIU4rdaEdLc1lLoYbVgFypdfxzai9Wgc0wNCjHv3uIr+yCogBBos4Y7XJVXeH1Uk5tgbGb0HmQVr87BZWHQXzlYCcpc6UnsOABPzy6TQ7nGW51QJ0THSMswbMgi5oIhK5WiLwtrZ4SPc4GYQxoM2mZ/timeu92rvd1KMG4m2YCesSZlxPEc0s2qmW5V4di+k70qURjSIQEUaswz0GcEcQ/TY1726V4iItA/pTMbWb6pqfsgzXVyAWUtEsL4kpvlA3Y44RT6m3pg/432mxfoPxImo+duaXPFWjKwlCAzpat7yV8qYB4Ikgt/IWaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 18:37:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 18:37:48 +0000
Message-ID: <ac011848-d87e-4f5e-adc8-31296fe60f06@siemens.com>
Date: Tue, 24 Feb 2026 19:37:45 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [xenomai-images][PATCH] Update releases of dovetail, evl, and libevl
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0017.namprd12.prod.outlook.com
 (2603:10b6:610:57::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 162e2fb7-dfce-4cb6-cf46-08de73d3cef5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1gyTUNmRVZ6aUlkNzQ4eitwTFRieFp6dVBaak5FcVVVOFM4bEt3SElGWjV1?=
 =?utf-8?B?OWtMWFd2cW0wS0xoTE0xKzlmRjI5NjlQQksrN3FqZ3pOdnpVUlZFSHRTME5s?=
 =?utf-8?B?anRHcjBSVGhqT2pFeDQwaXNUQWlKTk8xSWtITzM1MGRla29kengwaEY1V1FY?=
 =?utf-8?B?M2UzSWR6TTNndWJGaklzZjZsQ3JzMFBkRXMzQ1BYb3BEdmU3TXNsSlc1MnZW?=
 =?utf-8?B?VFhqakpleFhyeU03RHhVWVQvNmtXa0JGVHVYaWgwbTl2Y1d0SndhVjVFcWNG?=
 =?utf-8?B?R09zZytLMVJiVGZCaGk4WlRjUjY1QXZ2RFBVV2YzZVJIbVNuSGhsSDljcHpv?=
 =?utf-8?B?aGFGZUNMZWV0dlA5YUVKcHdtU2lqb3ZiNjlCNWdJWC80b2hMZ1gwQWhXVUU1?=
 =?utf-8?B?MmJNa3lxbHBMbzJKeHpxNml2YXhKblB5UjVvUjBIRStPSncxK0kxeU9qUmRE?=
 =?utf-8?B?V0c3bUtqV01HSnB0TUNvMXg4SXd4UnpSaDNhT0U0UTlCUjhUTHFja0xqeEhE?=
 =?utf-8?B?a29HU0pWWkw3ZDFMVVlMWFF3M2ZCRnJ1eXpxY2VveDNNVDduZXUxYmE5L05T?=
 =?utf-8?B?aWFoSXI1ZjVBcXJaMFQzODh2NmJhamNmTEtuQ2J1cFNuN3drSndiWTA0a3ha?=
 =?utf-8?B?UFRxT2F5Qm1JUS9vTTRCZUtCZk5GeUthWXZuSkJTS0dua0lJSE4rV0dCbmND?=
 =?utf-8?B?a053U21ZTCsxU0NUL1FvYkxGOWNoWkx4SzZHQ2R6bDVpSU4xQTJSNGM1M1FU?=
 =?utf-8?B?dWJtcEFQR3cvTnpqeEJrRnA0ejNoZGZEZzNQcXVvSXB3T0V1emJOWW52TU1W?=
 =?utf-8?B?dVFKdTZ0bU45bFJPVGlidlVVTlNTMkpqTnk3N2IydEd3dVhXMlUrYTZYSUNK?=
 =?utf-8?B?UVRtdzBUWGc1dktJOEp6b2c2c2VjaHRSbDJ4bkVJaU5MR2NOTmtyUlBGQi9X?=
 =?utf-8?B?enlkN2lYU240bmhPMkppNFN0WHJKdDlFSldqZCs4TlpoUnN2ZHRjM1Z1OVlm?=
 =?utf-8?B?cmtLRjZ6bE90MVpvYUh6ZVYxTHA4VmFHSENlb2EzTkd4bGUzeDB3M3hiR3Iy?=
 =?utf-8?B?dnZqRldiWk1PNEl0YTJkRTlKNmJEby9FNFE5c2pUYnpQRjZGRjNFUWNYcUtV?=
 =?utf-8?B?WWdmcmE2RGFCbUVwdDluWWkvZkZBNFFUaFM1WUloWnU5YlVPWHBUVEdvanI2?=
 =?utf-8?B?Vyt3WXVEK2tJSHR1OEFEaWtzaWhjMjRyNGNleWlKQlZYNkx6bjB4WWVBaXl2?=
 =?utf-8?B?WDFxNnU3N0hxS0dyN21Kc1ExYWxCN0lOL1ZsYUxQVld1SHZJZGd6K25TY0s0?=
 =?utf-8?B?enZJZld6eG04dEZ2Q0JUNmwwWTNhbThhcUd0WXBzQnZwU05kWkk0TkU0U0JM?=
 =?utf-8?B?a1FsYkVwcGppNEJWOHIzTFdITHV6MmtwK3dLYmgzRmRkUVluYmxRbEI5TnJy?=
 =?utf-8?B?YlFFb3dub3NMRmNVQ0RhNmF5WmJvZFk2eHp2eU1Uc0k1MlZha2JPLzRSd3B3?=
 =?utf-8?B?TC9lQ2dhQUt5OEo2UXhCNWoxdWpaOGVRZUt3aWpzZlV5R0JkdjM3dHYrN3lF?=
 =?utf-8?B?SjN5b1JZN3ZsYk5IcHhTakJwNlZ1c01sR2E2blRZSkY4cThib1FrbGpQQU45?=
 =?utf-8?B?SlJ5ODBVM2JWU3RNM1NiMStBWFFBU1NBMmN5aVY5eGMxZzc3ZnlEbmNpM0NG?=
 =?utf-8?B?R2p3K3ZWQkRZcExFSGg5OHhMNzFYdGt1WEpySkxWZStFeURBY1NiMm9EL1pu?=
 =?utf-8?B?OEZHdjZUK0RGdjNuenRrZkJnRzVqc0tpUFFUY25QQ1BLTkFiQWJEM0FpNmpB?=
 =?utf-8?B?UGl4Y2pmT3FGVmdod1NvZEFHL0tNQVl6OUNzYWJXQXU2RHpnTER6clk4MmRB?=
 =?utf-8?B?SmtJZXN1RjIxZUs1c3JuR01xY2hYemNEamdaa0twL0Z1VitzSDZDbWVTbjlT?=
 =?utf-8?B?Tk9SbjhMSncxbDRIcnNKdWh1cEQrT0hPY1g1WDZaYlgwY1liYzdpRzQ5S2p6?=
 =?utf-8?B?Uk9WZlljaEIyc00yOTlUTUFyRjJaWndhRzNvS04yRXBnd3B4ZjBIektmOXA1?=
 =?utf-8?B?NlFZMTM5dUVCSjlSdmkwNnJLNzhKVTNrdk40YzFuNXo2aDVzaEl3eFVQRWZh?=
 =?utf-8?Q?j6gU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUZEVHN0OThvZkVocGFTdmJrUU9SRDFwOGQyelR0TkV4aGUyYjJ4ZGtHMjl0?=
 =?utf-8?B?aHMwZnRDeUltRnIrYlNYQTBCbVJXVWtmejgxVEtIQnZMZW0veTkxVmYrY3BD?=
 =?utf-8?B?NFpKZnpRQnd1NWI1U1ZHMDhRZFA1NmdrK2E1UlRxK05wYS8wN1BvM3FsR1lE?=
 =?utf-8?B?N2cvdjVDbGxjditpMnIyWWdUMnE5NnJ0OHE0RE90S1YwTGlkY05HMjA5MGxR?=
 =?utf-8?B?WnlPZ05tSU1QKzJmV3cwazdFR0dxaFY0V3hYU3U4R1lKbktMc3NCVkZXU3pT?=
 =?utf-8?B?dzQ5d2FhdzZPM3padEQ2LzBPUStISDV0NC92dmhDK0dTUDNzZzQ1d0JRNFNv?=
 =?utf-8?B?ODQyaUdSKzVkdGNuMXlUZE9iRW9uVVplcFlkMEJsUUl6MXgvWHR1ODlDb3Zz?=
 =?utf-8?B?NGpqME4ycDk4aU5lUWcvckpyYzV5SXJVTzk3MEZpNFpqeG5LaVRiYVg1bkNl?=
 =?utf-8?B?NDAybVB1VEMrQXkxODdMOHVoNjdNbk9Ld3haemdyd1U3dy9qZE9TdFF6UHVm?=
 =?utf-8?B?SnFmUjQvWExWdUJvOWV0dm1yZmY0TWFlVFdiazBxY2tmck51WnltZmdRaGFW?=
 =?utf-8?B?SUx2U1BJaU55RkJQTkZESFNlNnNGUVlsTkhCVWQzdTYycWs5Uks0cUw4MVJY?=
 =?utf-8?B?eEM1L0htVERTdnhwOHNwNnc5ME4rQ0FyZ2NyUGh1ek5URk05TmFUMDZzUHA1?=
 =?utf-8?B?ZGdGbGQxMnRxazdndEwwV1pORERpM2RtNzdUdmZrQk1rT0pUdlFDQUhocHRW?=
 =?utf-8?B?VXNUZEthZjJFUUhlaHBnakppQ3lyRDZET2lKaVdEdnMyV3Q5emhMaUhRdVI4?=
 =?utf-8?B?UXBxMjhTT0tmak1GcmNpNTI3OWxMNW4xN0s4a2FXU1MzWndQK2Zsc3NFYmg0?=
 =?utf-8?B?OHExUW5aS25ONDQreEpyeHV4OFUyalJYbzNmNmV4VUVBWXZrWXUyR0ZoY3ZQ?=
 =?utf-8?B?OUNRYytJYjFhMTRKc1hrWjRHT0o4dUp3YXNmYml6c0Z3ZVZjamthaU9XYitV?=
 =?utf-8?B?QlZESDJEem16KzJBTDhkMk5GVXI3d09MclhKYnYrcThOQXlvSE1RViswRWJr?=
 =?utf-8?B?bXo0NDViU1IwWDVZVTJkMUlQT1dUbDg1WVhWSDBXbnRsZmpBb0dDQUgwSk00?=
 =?utf-8?B?SmhYcTZXMGwvVmNhWDhNVURkdkdhUjhYaUkyQm1aWk4wcUlpSmoybVFNM3Vv?=
 =?utf-8?B?NzVxODJzYzltdnEwaURyS0t4dmFqMXI2VTljVmRtMUNsaHFWRnlFVklwejRz?=
 =?utf-8?B?cnBnU0NRbm55M25JUnpwOStqbTIxc2lUY01nN3lhV3FQZGNHVXRuVjQ5OENQ?=
 =?utf-8?B?THBVV0ErNnhraFRFODlodG9QYXpybTZmUHVPVGZCajZFTDhGdVpWMGpzaWln?=
 =?utf-8?B?RlNJUzYvK1BzY29NbnNSM1JqclpMT0tSR042dHJtWWFsZzlPNDAwZStOYWt3?=
 =?utf-8?B?ODlZOG9WNldUU1pHMGNmekttbGtxbzFCZ1JQcytmVjVCL0pqNnpLMDQ5ZHVV?=
 =?utf-8?B?RFJENHAvRUxDdWliQWdFV2tWbHh3d3JTSjhmWU8rWW5vUjMxdzliRnd3aTBG?=
 =?utf-8?B?RUsvV3luS21TNlA1bmZtNkNYT1JFTEMrMGlwUGJZcS90VTc4cnlZb1Z6SVMz?=
 =?utf-8?B?UmpuU3l5TzJGN3ZrQytiODdMWGh3MVB1b1pWUmU1YlcxYVkvV2JPTnhRSEtG?=
 =?utf-8?B?VGJ1MmVzb3oxK0ZIWC8zbENwQTQ2VEo2eVAxbnNiaW9qWU9BSVN3T2VNYmoz?=
 =?utf-8?B?VnJzWlAyekRNWTFYOWtuVGtEeENGQVgzNlVLTDExZ01NV0g4KzFMMllaWmdC?=
 =?utf-8?B?R3N1THpVV1kyazhXYWgxSCsrcFliMWE2RU00Tm1VZlRFRE5idVM1RU1YMHBC?=
 =?utf-8?B?SXhvRXFUNDZZZ1dNME8wK09DVFIyZnE2d1g2ZWdSdFA0dW1ySTlJMzNNWEpw?=
 =?utf-8?B?cXVNQzhpeDV0UzJTWjdMS1lwa0lwQzBkMzByMlN0LzZjaGtiTDhKeGI5VU1q?=
 =?utf-8?B?RnJ4ZS9QUjBZcEhMVUZBRFVwa3Rja0xQSk1LNi81cVVyMmxRRDgwZjM0TzVC?=
 =?utf-8?B?NnljbzE4WlJqVGd4K0xua1BQQzhGWnEvcEtpNzV5VkJKNG1lNm4wMmk4RElV?=
 =?utf-8?B?WnE5VTYrZDN1QmsyUEJBdnh0djN1S0dMam9abUloNVNaclBFaEVVbTJPbnVV?=
 =?utf-8?B?VXVmUEpOOFNsa3hBYXlCZTc2MkorUzI5elJFN1lwNmE2ZzJNRUxrZXdmUnpy?=
 =?utf-8?B?azVvaS9xdlpEbmxhRW9mdVErcjEwNFQ1bzd1TDhjZG5MVm9yNHdadDNzU3Nw?=
 =?utf-8?B?RXNET3NMWWhuOHJrZkI5d0lSU0NkdVAxZ1Z6bUx6RXBBOHd3V1JWUC9lR21G?=
 =?utf-8?Q?JrqP6hLWF+jBUM4c=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 162e2fb7-dfce-4cb6-cf46-08de73d3cef5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 18:37:48.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iW77PGVmb5sSC7bi4MLtBRO9UXIH4SBofrgiSoOySjLVC8BAr7/a9hJsawplSVT21wnvusOk0D1OiEBy34qHaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7652

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai-3_5.10.bb          | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_5.15.bb          | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_6.1.bb           | 4 ++--
 recipes-kernel/linux/linux-xenomai-3_6.12.bb          | 4 ++--
 recipes-kernel/linux/linux-xenomai-4_6.1.bb           | 4 ++--
 recipes-kernel/linux/linux-xenomai-4_6.12.bb          | 4 ++--
 recipes-xenomai/libevl/{libevl_55.bb => libevl_56.bb} | 0
 7 files changed, 12 insertions(+), 12 deletions(-)
 rename recipes-xenomai/libevl/{libevl_55.bb => libevl_56.bb} (100%)

diff --git a/recipes-kernel/linux/linux-xenomai-3_5.10.bb b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
index 04d0129..0fdf535 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.10.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.10.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2025
+# Copyright (c) Siemens AG, 2021-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v5.10.245-cip65-dovetail1"
+SRCREV ?= "v5.10.247-cip68-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_5.15.bb b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
index 87e7a26..d84de49 100644
--- a/recipes-kernel/linux/linux-xenomai-3_5.15.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_5.15.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2025
+# Copyright (c) Siemens AG, 2021-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v5.15.196-dovetail1"
+SRCREV ?= "v5.15.198-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.1.bb b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
index 49e584e..c35cdb1 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.1.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2021-2025
+# Copyright (c) Siemens AG, 2021-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.1.155-cip47-dovetail1"
+SRCREV ?= "v6.1.159-cip50-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-3_6.12.bb b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
index c066037..bfc7dd7 100644
--- a/recipes-kernel/linux/linux-xenomai-3_6.12.bb
+++ b/recipes-kernel/linux/linux-xenomai-3_6.12.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2025-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-3-dovetail.inc
 
-SRCREV ?= "v6.12.55-dovetail1"
+SRCREV ?= "v6.12.67-dovetail1"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.1.bb b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
index c0ae308..e5bf810 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.1.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.1.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2023-2025
+# Copyright (c) Siemens AG, 2023-2026
 #
 # Authors:
 #  Clara Kowalsky <clara.kowalsky@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.1.155-cip47-evl1-rebase"
+SRCREV ?= "v6.1.162-cip51-evl1-rebase"
diff --git a/recipes-kernel/linux/linux-xenomai-4_6.12.bb b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
index 380c2a4..ec559ec 100644
--- a/recipes-kernel/linux/linux-xenomai-4_6.12.bb
+++ b/recipes-kernel/linux/linux-xenomai-4_6.12.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2025
+# Copyright (c) Siemens AG, 2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -11,4 +11,4 @@
 
 require recipes-kernel/linux/linux-xenomai-4-evl.inc
 
-SRCREV ?= "v6.12.55-evl1-rebase"
+SRCREV ?= "v6.12.67-evl2-rebase"
diff --git a/recipes-xenomai/libevl/libevl_55.bb b/recipes-xenomai/libevl/libevl_56.bb
similarity index 100%
rename from recipes-xenomai/libevl/libevl_55.bb
rename to recipes-xenomai/libevl/libevl_56.bb
-- 
2.47.3
