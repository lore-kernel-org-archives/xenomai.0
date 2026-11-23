Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795433970;
	b=rHk+Kl7BkFB6/TsCboePyUg6JghZbjA1NfVt96y3sGa9HiZ9asMeJ+8elOmbsMVz9shc
	 8mNf9yIs1vDS05m2d1Mn9uoRt7tyfUD9Dl7PYvIPNfrXlotLjq0nofKWlT4SMYE+I0J7K
	 /7TyEPeyGe8q0wNRHg4YZxqkzHyNsDh61BMQRE/T5Wbx0h8AvpLgASeyK+9+/Z+IWFaDS
	 vQZRcuZVU65f1hV+wGROYSNhwUQ7VMFjLKF8+LvxY7K/WnK8BjcpLn5k0u5VvKj/UXeQ4
	 nbPbCRAyheDAyYlmY2IAh1OJSV4mH6QkFkaOoMIdw06eZyr6typ1kiTKuLw+Tg1vn+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795433970;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=shrxlwvizxveaMTLyabeXl3muqTqXRq1d2JMU4wbgxw=;
	b=SjyR8QbhA6U5UfGJcI0nIWm1uUO/CFQitv1l8lXkpmUiBHEpjzr7RrmtMH6nhni3KtFN
	 qdRzped6U/MeeQe3uwEbSUpJE/g/GQ3IrYziXhqo+aRYOTc9E+ltFp3NR0r8ZpXC45wMY
	 1nV1Bs4YL4FteVV7QU/Gt/JquX5L8qPJ6uFgHOVkjXjQ8V+ryLGi3LvB6X3KAk8UC6sez
	 6bSJDv/2p7POYzZ7VACJkK5UIDAfjDaozUFYG/b0u2+qe2xzlXf2CBoxdOnIaM3a6bb3G
	 +VQh8U+retTKVErbvWus3XGn21rvhswBgXFYLISPK8MEWxQsQqGK13eGFTO/sZsdUKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=qWsf3isP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.11
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013011.outbound.protection.outlook.com [52.101.83.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA0606A31A
	for <xenomai@lists.linux.dev>; Mon, 23 Nov 2026 11:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56DA0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=qWsf3isP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gS9zUO1601niOelr+ySw5pZq4eDd/XwpIdPjIrPoTOZQ90X3NmcWbEhZ4TQGYYdQeB1f3Be5VMdTNhcroArB0G5fmAnHuOUDaZ3TIyiGV5wxnUz5xRqYmc8YmrsenaynwxgMo0h5OoRbIR1fLeXuI8ExKDAaE2zExbwPa3QYBP4lTB+csCHZOTxDURHp3N025L0rQtt+weLBZDC2iQwaA4xzp9eL5KkdUy6TlwRIo/rKKqSo5l47oX7s/Mw8IAb43BaJ3dUcPhaqtO/4KZ0subg5qtTnVMNSG9UaG57M/vsTpFiq6njefT7HcoqQjk4twbFkTbqIfnPQE+0QXpsRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shrxlwvizxveaMTLyabeXl3muqTqXRq1d2JMU4wbgxw=;
 b=ZZPWByrbrszLQSTcNltJjaGSxJ+w27cBTRwROkbmXq4DM3X/1bOl+CgIP71+xEiel7QuiCkOZWkC6FTNoLo8k8CqvAplt0VQ2z1EatAqaaVkqCEPiH62n1PShGYYRJ4QMK7PQn0mBmQ6Yugjgto4kpRxDWzq/Ve4NCJXBQJMjME2TfuHY91WoHU8M4n5yQUAxUg9fgOvU41HaQW8i4CpMYCyMx3oE9jDZDd6KX75HS0Mza5ANKe2W0bTiCjpSpQ8cegyY9h/Th6gRMjrC0w8LWQ+ObVT+bn+cbG6OLK7yKul/mc1d998lrkCVX3TMrEgSRy9efWEWLG/PBoIUUZKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shrxlwvizxveaMTLyabeXl3muqTqXRq1d2JMU4wbgxw=;
 b=qWsf3isP4VEcYcWt5Sboz1F6mnpig1Z4nqcujiQcs0G2oz1FzTmg0UoHVsq4dS7DvbvTB6k0BNlWdCzRxWFv8zHGP5klwUxNQpaxDzWxPiyleSItDFmhW5tKK6JB6b392hwZd1Ld/st0RhG+UQWH2f/k56HoNFGVfwVipLMvm7xzh4lHkbvPBXpluylKpdmYp+8o0MNOmv7DpzAx31EF4BfTIWRkESvBICh2R1pw7EHTq8tB0NXC49uapEh8kXvLITwHeFA/ia29fwN7IIUOrr2mdjxeqayP0rrHakwLnTiw+ZFFLz8FSUU70yETPFWslBsfvHgOCaV8p1qTMuIZMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PAWPR10MB7221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Mon, 23 Nov
 2026 11:39:25 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0662.001; Mon, 23 Nov 2026
 11:39:25 +0000
Message-ID: <915d53fb-fc8b-4c07-935f-a9d4680ee8a5@siemens.com>
Date: Mon, 23 Nov 2026 12:39:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dovetail v2 3/4] riscv: dovetail: inherit the hard irq
 state on kernel page faults
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
References: <20261121165933.57310-1-tobias.schaffner@siemens.com>
 <20261121165933.57310-4-tobias.schaffner@siemens.com>
 <DN2371TJAB7G.334DTWMEPJTQI@siemens.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <DN2371TJAB7G.334DTWMEPJTQI@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PAWPR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: f5569707-66e7-4e98-8dd0-08df49566cee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|23010399003|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261021121427099003|261009223027099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261028144727099003|261102123227099003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iPem5oexuKzjA2TMiA7QOyXk9f36kY8YXhZ1GoxjWG3bHz6vmNfNUYhnk0QJ3eJzdIvNz3dLk2y/XNKQl2rY+WM5a8OLhZ3yZBgZnVgWY6BMzWhrYS0ZrbfCQxcx1YQL5Ps8yitBLj8J1a/VnGO1MGFmzJZvgFZ46J0sOYO/0Xk9e+8r0cw31agpHNPO8+Add0y5E3ad7DGRernvxdj0aDG4RD7q9NxLbp+m65sc6z8FoFvaxkMvuf7n6sdMmrE+vy4ti+DJSAEdxovbYzT/Sj8GeHvwbMsv3hc06/T15j9tHmq+DM+4mXv7dyIxAO7BB1F34VLix8OL6YJaVYQRpl9ROx20CTVgHiTRjy34LsiqQSLOkZI4cw8DIc3etnE2xR1nE8SsQuuB6VYXT/AWaq0H6douvuNer/GYhz3pxxR1DttYxG+MIDsKeAPvzOf9uGAvq4kNy02Bz9kWsz+2mnB2Fmt7rVd3rygfZzwRp/CtrgYgegDQLWASMtrLrJojaX21h8P945ox7osGKu9l58z6g2GCGxZS+4NjecjwrvYtA3R5LeQs5pZDjjk9m46wBoD/N+yksItDikXvoVjSALYLnwJGlVNtRXSb7S4Tn0WUxj6RdL+dqIa8+DEs5a/cQhVv9hU7qYdYFcQaB1v8nRuH+Y5O/iQ9Oy8dP5nV5Gw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261028144727099003)(261102123227099003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anNFNVlvQzJiNnNLSDFkUURHT0dId0ovWktWS1JSb3c3TldyTVZQM3BKMEtx?=
 =?utf-8?B?UFBlS2J3U0E2ZEx1U0VaRFlwaHZLWUYyZVQ2YUZkUkpuSFZEejJJc3dqT0ZO?=
 =?utf-8?B?M2swc20yQ0d2TVlIa0M1L2Y1Z1N1VDhKYkY1RkM4ZUR1VU1VQjFLV3BGRlZi?=
 =?utf-8?B?eC9SL1FNeGI4WGJHOHZGWEtmbVpyTWdKSUh3T0c4eUI5Y00xV2F0aUgzWDlD?=
 =?utf-8?B?OVdYcldCeU80VEM0T1pKN2dwMEFGWG1IMm00cVBzenNFazNhTUpFdTlsenI2?=
 =?utf-8?B?K2JNeUlrNFMzb24yallJQ3RLM3Ywa0xCenU2RkJqbERzTjAraWRmZVJjNnNq?=
 =?utf-8?B?TFMrcEhXWXlNYUxYcVBtWnhUS09zQUJFTE9WYXBXOCtRR2JNak9jV1hPZFlT?=
 =?utf-8?B?ZVJ1T0RBRUdRQ1dDZ3NEbS9VUkZFZ2hhRTc2UXhxaGliK0FnMUlnejNEcUhs?=
 =?utf-8?B?UVBCWUduU1dSdDMxR2l5SW12U1lQRnZWQm92TjVRR21XZHZNd2diclkxblFn?=
 =?utf-8?B?cGU0QS8yWXlIc2FYUmhzMXIrQ29GUHl3dlovdXhoTlNjdXhtZW5aM1diQnZB?=
 =?utf-8?B?TUxqSVNrTDQ1OVArdllMeitqLytnT3JvdDVUcEtpSVdITkFudUd3N1lTbDRy?=
 =?utf-8?B?OVlRTTdubm0xeEZveXp3L3NvUnphVE4ycXZyUENPN2F0c3JiV0ZsOWhNZDJr?=
 =?utf-8?B?bFBVUVdjMTJGeDZPSWl0Ny9semtvb0lZdjJSeWUxSlF4NXVobHl2VGJieDFW?=
 =?utf-8?B?Y1pRNmFrdi9HQ2FQWDNOSnpzMDdGdHNNT3VhanVDd2lVYTZsaEZ5TFI0dlhJ?=
 =?utf-8?B?cHM3UlE4alpPeEZ1MEJqRXRIdVNCUm95UC9UUng2QkovaEtxbEJwbDNsNU1M?=
 =?utf-8?B?cmpqTGdjT2RkMUFBU0hWalZFUC9JRzJJNTM0N2hQNmxaeHQxOFJBZjJzb0U4?=
 =?utf-8?B?Y1pyaWwrTHN6UHVwb29iOXZTY0lBSTNGMW5iU3czcTFaWmpocnZDL0tRdU5I?=
 =?utf-8?B?eDF0UnFXMmJZMGxCYUZOenNFVXMwTDRhMUtrQTByZnE1QThrK3BhTHZVVkNw?=
 =?utf-8?B?a0RGRENXaWIrQ1NhV2RPUGlxZE12TVRObmJQMW5rZ3FYQ3o1U0V5UnYwRlZt?=
 =?utf-8?B?UnlpN1pJNFJOdCtTOEFvNEZKYStjWWt3bGVNeUpYajhad2lUSmg3WVZkTmIw?=
 =?utf-8?B?anRYUjdUYmhISXRxQVVLaDQwWWQ3aWs4ZTNKSS8vaDZKOEk5dDBnRk1oZW9H?=
 =?utf-8?B?Vm82T3ZyZlJHMW1pVnduTHNUN1lKL2V2dTlpNVJYQlhDWjFKY1dYcWRSUGpD?=
 =?utf-8?B?OGdYbnFLRG9jbzBHK0ZnUGhtUTMwSnFyVVhJc0ExMzFsZ1p5N0Ewd09ad1dH?=
 =?utf-8?B?L3AxVzZCdFhLckVNbnh4S1lablB4Y05CWEpvNnYxNHJsQW9uSm9iaXE4SGRY?=
 =?utf-8?B?NTJVeDQySXhEMy9VUU5keUNzMlZhODlodCswNDRGTzNMMlNqSFMxY21GWTZ2?=
 =?utf-8?B?dDc3RzRlY05tY0pvTUFZbXZub2hSUW5lRkJqSHBZOFZnNVVGdTdGNXdYQXMx?=
 =?utf-8?B?dGNqUFJFNGlra1RqdnJ5am9kb3ZQSWJjSXNjY3RLUkJSc1NSZzl3N2FOMVRw?=
 =?utf-8?B?REJKSFJoVTFYc1Y5Y3BRNVhqbVIvUHJiSitacjF4d0lQdzNKRGNieWgvOTJB?=
 =?utf-8?B?NGhpVWxqUkllaTd6TGZTS3QwSmwrQU5WdGVlVjJTN0RvZmZhWE5JOGtMZzFs?=
 =?utf-8?B?bUVYRjFZc3FLNDI2T21XMExjaG4rNWI3SmV5NE83emxMTUExNjZ1UnB0WWpi?=
 =?utf-8?B?WEJBS0NKaTcyRlFGL2Z6bnNqSk1ndndWOHVpeUJGME15dWszdk92TFBjQXZr?=
 =?utf-8?B?eFlYQWM5REtidU94WFJpYmNITGJuelloWUxuUDkvTHJaV3ZVY2J3T3B1RlF2?=
 =?utf-8?B?Ynh5Y2xFa2RmcGF0ZUFFOFJHWFk0MVU0SEpMS1hWNWlRQnRYdy9nWkw2N2dB?=
 =?utf-8?B?bkh1S2F2bXlUUHhVQ2tsQk9tTXRPOHJUL3FQT3ZKaHNCOUdmQmxQenBES1NC?=
 =?utf-8?B?NFEyaFZvTDFDeTNNZVE4cGRtQXlaVWdxWDRScmIrdTRjYVVHcFRRZnpCdTh3?=
 =?utf-8?B?STd5U0o5Zm5tdjY0MlVpbk9YSzhYaFpsVGlTNXJEbFhTNGhvVzZPd1E4ZENx?=
 =?utf-8?B?MGhycXFJQ21ucXhPRXZIVkh4L1QrUWtCcFltMEkrU0hQcU11eWhiT3hrWHFs?=
 =?utf-8?B?a25SdWhmd09IS1paWWJnT3ZDdE8zV2s4VGpSMUhOSWxZRDlCTStjMFBwOHJv?=
 =?utf-8?B?Y1ZhRW1JMjZ0RVo4Rm1MUWRMUlRoamVaaW1qdWtHLytINnMwQTRKd25LanJO?=
 =?utf-8?Q?bLgpgz00PvFY2Px/rJZtJZ2PtK8zlpkokOTn/acysGLrs?=
X-MS-Exchange-AntiSpam-MessageData-1: E7IuW4tQIL0Sx/UYDgVArehC1rKu4j2TYFc=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5569707-66e7-4e98-8dd0-08df49566cee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 11:39:25.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uO3r6AQF6hN1IhsSOTOBaeFLQNOuVfkaq1EWsXfxujnN6GZnguqRYOwDuAj075H0TK4TZMjVzopcXafK9x6VfkDdJZmxUOc9aOkdEAru5Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7221

On 11/22/26 23:18, Florian Bezdeka wrote:
> On Sat Nov 21, 2026 at 5:59 PM CET, Tobias Schaffner wrote:
>> A page fault may hit kernel code which runs with hard irqs off, e.g. a
>> kprobe whose fetch argument faults within the breakpoint trap. The fault
>> handler still enables hard irqs for every kernel mode fault, so an
>> interrupt may break into that code. If the fault is handled out-of-band,
>> the handler also unstalls the in-band stage over the out-of-band stage.
>>
>> Enable hard irqs in handle_page_fault() only if the faulting code had
>> them on and we run in-band, and stall the in-band stage on exit only if
>> we run in-band.
>>
>> Fixes: 1d1fdeccecef ("riscv: dovetail: add core support")
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   arch/riscv/kernel/traps.c | 11 ++++-------
>>   arch/riscv/mm/fault.c     |  7 +++++--
>>   2 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index a8e37ec27cc2..47799f18fa7d 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -488,17 +488,14 @@ asmlinkage __visible __trap_section void do_trap_software_check(struct pt_regs *
>>   asmlinkage __visible noinstr void do_page_fault(struct pt_regs *regs)
>>   {
>>   	irqentry_state_t state = irqentry_enter(regs);
>> +	bool inband = mark_trap_entry(regs);
>>   
>> -	mark_trap_entry(regs);
>> -
>> -	BUG_ON(dovetail_debug() && !running_inband());
>> -
>> -	if (!user_mode(regs))
>> -		hard_cond_local_irq_enable();
>> +	BUG_ON(dovetail_debug() && !inband && user_mode(regs));
>>   
>>   	handle_page_fault(regs, state);
>>   
>> -	local_irq_disable();
>> +	if (inband)
>> +		local_irq_disable();
>>   
>>   	mark_trap_exit(regs);
>>   
>> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
>> index c5709112c346..f72b49d8f15a 100644
>> --- a/arch/riscv/mm/fault.c
>> +++ b/arch/riscv/mm/fault.c
>> @@ -317,8 +317,11 @@ void handle_page_fault(struct pt_regs *regs, irqentry_state_t state)
>>   
>>   	/* Enable interrupts if they were enabled in the parent context. */
>>   #ifdef CONFIG_IRQ_PIPELINE
>> -	if (state.stage_info != IRQENTRY_INBAND_STALLED)
>> -		local_irq_enable_full();
>> +	if (running_inband() && !regs_irqs_disabled(regs)) {
>> +		hard_local_irq_enable();
>> +		if (state.stage_info != IRQENTRY_INBAND_STALLED)
>> +			local_irq_enable();
>> +	}
> 
> Is that part aligned with any of the other architectures?

Yes. This pattern is taken from cond_reenable_irqs_kernel() in
arch/x86/mm/fault.c

> I'm asking because it seems that the pattern used here has an ordering
> problem.
> 
> Once we enabled hard IRQs with hard_local_irq_enable() hardware events
> might come in, hitting an stalled inband stage. Means we log all the
> events into the IRQ log.
> 
> When we unstall the inband stage with local_irq_enable(), that will
> bring us a full IRQ log synchronization - over page fault handling.

Is this really a problem? We are handling the running_inband() case here.

Mainline is doing this at the same point to allow IRQ handlers to run
while page faulting. Why should we prevent handle this differently?
As long as hard IRQs have been enabled before this should be fine,
shouldn't it?

> As local_irq_enable_full() does it the other way around as well, I
> think that the ordering is wrong.
> 
> If taken / aligned from/with an other arch: we should check that as well.
> 
>>   #else
>>   	if (!regs_irqs_disabled(regs))
>>   		local_irq_enable();
> 

