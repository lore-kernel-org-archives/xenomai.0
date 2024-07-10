Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0574629AB
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595931; cv=fail; b=EQmm+U0P3e9sEwKglH5U9FBDmsXEGPpkvf4I2EXuR/dO+KSFJLxtYMkNjUO5+ojLHtwwyvjiI1jSU99Ws+hsz9WAbmUtVKDbkPKLTSAdTmz2KA1VvUogszlQcWgD/fIj31pOPPObbbxRzbbmBeHCqaSAUNVWeufH20defBpZVig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595931; c=relaxed/simple;
	bh=8xoa9O72enQ5NSmf2EiwNO3yoyiplhUROQHHcKNJpgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bIC7MAvaaioUmKLjpuHdiJ9OEtN/8nl+F6iohHagU/54JoPS70EQgJUs21YAQOrCytufnMqWW8n9PY7oU9vdqUkQ6EtxeSLuquAtwKJBmG80dNT1uYXJCOQptDUE05X5Iu0bZs8UYPcBH3SqjMxuYe+pwCc3do1niiuKbjEB4Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=wNZGdBor; arc=fail smtp.client-ip=40.107.241.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="wNZGdBor"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxOYruTVncjULKZZZPOrBDcw2fzUuLoohosLg0EnJYFEEiQQvsRHK92qlu5gc2KqFdsusgEuryLccFm8/mYjD5Sd2F9k9EVmFLFuVwykD/J/aQ2cF4/qerrbGqHEXGON3elncAdSr4tGOWSf7eAUjbI4AVWbKCrptcop69UtYeq1xEfyeuZoSfwJ44I1wfnqJZ+nZd2cjpaBqEFQraO2QcQF3zjf04/ihqef7iRpTAt/BrKONIf4gOHLQh2Rfwxy92io4IBdM5XepCJIykiOuMy/N7yl7z0G6rv/l5ISwH/exjPbvOb4LG6xRvX1IUyuzaIconSOi+fcsZAx42gFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGcSigK0IaoGyS+lgi5pETTYlT5vj44evCLe6wOYGrQ=;
 b=V0MIEP8Q8eXV6/MEd3cKx15/f0VNhuZjP0Yy3BQy96pjokyq8Vil8nY3iGwcrTEDWHI9tB2gw+VvcPp0y00V7lYWvK0EYrtBnDJyp1LZHQhaE8r182A9PClL9CE6ouSxo4VdCgVnJYK9wu54Jh1zhhWUp3eG+wnc+eaYoVLYFIrIJ7y+JBEk5kBSIE9HwjWo14ByXa6tu4j76l2mm8sTVuOrxm1+fW11jPcwkCb9vvGOb7uj9ckKUq/ylpjgsGE32GCGgU9PrzhILkY0U/iKpC10xCRA/ZjBURI2XCT9V2TBxuzjzDixsd/SeEG1jwJRGeX12sLaBHjEJerEA4p25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGcSigK0IaoGyS+lgi5pETTYlT5vj44evCLe6wOYGrQ=;
 b=wNZGdBor62x5et/oaJTsmensRi3pORWxL1awocUFJsQnSsMnkpWr8AgiP3jl00AchgzjUnlycz0vEzp2ETMGgSKV8S/Jtv7cTHanMZO3kiTk2ZBwwe03jk7tp4YKl66xl8gfrSAxSRyqbr2CqmFtQxCWn13Tszlj/qBTTLx3Oe0Oq0oSBB8pqyOS7q6uHrVpC/OmEFAZEpSIsu9A2UYl2pnLiqhbICOFeugXrPtUSBksxf8Y6FstToat8JGE/uwv9PY8DKxAfd/41+UPn2FdrfxC3pDwJxaRvUKCPQATi7D1rRYQO4nhtGiiaLzrNyCRX+bxzMqlVHjWuwAVUwlY/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:550::8)
 by GV2PR10MB6720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 07:18:44 +0000
Received: from AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082]) by AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4cbc:c0b7:27cc:2082%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 07:18:44 +0000
Message-ID: <5802c802-6002-4652-9a23-89ac70b2bf3a@siemens.com>
Date: Wed, 10 Jul 2024 09:18:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [libevl][PATCH 3/4] evl-test: Start evl-test with load by default
To: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>,
 Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, jan.kiszka@siemens.com
References: <20240613134557.4013044-1-tobias.schaffner@siemens.com>
 <20240613134557.4013044-4-tobias.schaffner@siemens.com>
 <87jzisrkfo.fsf@xenomai.org> <87v82cpvl8.fsf@xenomai.org>
 <ZmvxUGDwvbyg3vnW@trex>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <ZmvxUGDwvbyg3vnW@trex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:550::8)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6349:EE_|GV2PR10MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c6d586-d50a-43d4-9c1c-08dca0b0880f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlJlUWZtUzVtZFNZR2FTRkE0SDhFYm1ydlJXRlc3K013OExsdG5NNTJxMGZE?=
 =?utf-8?B?emhxL0szczFRcVJuN0Y2dTR3L1pTY0lXZWRYb0FBUzUyVytUL3FvcFowMXdC?=
 =?utf-8?B?cW13MW1RUW5xR1V3b0FVSkFrYlpmeGZOeGFQaTN1OUNlNEE4bVN6TWhjOTJK?=
 =?utf-8?B?Slo5Z2d1aFlzbnZtOXBkejlWeU1xc2tiN0trVnZyaDh0RldlZEVLQldYWkFS?=
 =?utf-8?B?Z2FCT25XZW45cWtFMFNjckljV2hGNnB5eFlvenpmNGdvMk1KcVFWY1dDYjFW?=
 =?utf-8?B?bHFRbkRKczgzK3IyUHh1Zm1wSXV1enlseHFBWVVvWmw2dDQ1NXJPRWg3V1ZO?=
 =?utf-8?B?YVBBTnNWVHUwbUxjanlZNThkRWsxMm44M2F1eTFtd3ZYODE4OTVpRm1UWGdw?=
 =?utf-8?B?MUNTb2FyOEdmRk1HVzQ0ZVc3SEZ4YS80ZjRrMVVuNVl5cEs2UUtHYlRCM2xE?=
 =?utf-8?B?WWEwQ0gwYkJvNXlwS2dHSDVhcGZyWmp6ZFhmTks2bWVoN1hqU1NKRWd3WDJ1?=
 =?utf-8?B?NzFnZzhWMFp5bTMrMm9iM2JrNFNwZlJUbmJUYThYcDJtUmM3U3paVUtaZ1Vm?=
 =?utf-8?B?cjJRNTVHejdDL1NJZk1PdkQ2RVpWNDNWUWFPcmVqN2tkOU1oRi9LakJIb0Nw?=
 =?utf-8?B?RmVXSWExV0pyR2lITXZnUnJ3ZGw1Z0JjNEc3Sy9zcHU5MWs3S1VzdDFYY1Q5?=
 =?utf-8?B?aG84RmNRMkl4a1ZUYmt4NlE1dWg2REwwR1drM0lpZ0p1YzZqK1I1QWpVSEw4?=
 =?utf-8?B?UEdyeERnLzB0MjRTU21aT3p4ZkpmeUVEQnowVmNjTi9JRWJUVUg4K2lmZW55?=
 =?utf-8?B?aEhlem1TVHBTYmFIa0NlQjZONE84MFZsNzRWOE1SbldLOWppa1dxMWl5TEZk?=
 =?utf-8?B?TW1QNm1HY2xsdWZZR1VxVFcra1JndjY3SnZoeWM4R2Uzb20xejg4WndoMlZp?=
 =?utf-8?B?QnVtN2lyRTdkSjd2SDBqcDU5bW5lbG91RGhFcW92NWdMbUdrMk9oM256SEYx?=
 =?utf-8?B?cnRRbmpVZjNqQnE0SDZQMmkwc1dmaGtEZ3JJUGNka2J3Kzc0dE9kTTIzMFZz?=
 =?utf-8?B?YXdrWVFKSkozMlR3WlFRSy8vLzM1NVBTTUZOWkYwdGNsYkthdDc4TzI4OW9r?=
 =?utf-8?B?RXNJUGlsdWpXYm1nRFRXZEh4emlOaWs2QnUxWXF4YUVIOWdLaW9JaFQ5Nmd0?=
 =?utf-8?B?Mk9NNTJ4RnU2OWRiak04eVVxKytWSkI4Vkt6QnVjTGhLUmg4VXAxM3hMc0c2?=
 =?utf-8?B?YTlmRnFGUS8rMkdKK1p0TUVhaHVkWTJydGR1VXRBUVQyc3hPNGNrRWFxSmhE?=
 =?utf-8?B?SmtpVUNLa1Z1aUYrelp6SERxNC84L3AvUE9wbmRWOU50d0J5Qkk0STVwM0RQ?=
 =?utf-8?B?MDR0Y1FEbmMrQ2V3TlZrU3d0NmYvTjBybXliZ2xtQ1h1MlVwN0FzbkdxVjhX?=
 =?utf-8?B?aHJ5YTFWMGV6SkJWYmRNU0dPNzJOTU8zOWtsZG5kQXg2Q0FHUVRUTHhZMDJR?=
 =?utf-8?B?ZnFHc2dKQm5YaVhRQmNSb2JPUGRrMHdiRXZHalVUdTRuTXhTNENZbmxDcW0x?=
 =?utf-8?B?OUplb3FSQlBVQm9UNWh4K2NRblliQ0pQcHlyOGFkUkUxR2pVNjdGMkNSbC9L?=
 =?utf-8?B?SlM5QnkxaTk2WExQMVVxekNaaG05WC9rQ25JcG5ON0piU1plcm8rZXVsUmt2?=
 =?utf-8?B?UWtaQVE1L1VYWXBtQ2ZJajdxOXVvalFJekdXbzlROUd3VGhHWGIzUGNvVWRV?=
 =?utf-8?B?emt3dFhWcVZxT2ptZkJCUDdhSDRRVlVqc1Q4ZXJPTWRXbFFBdERaeFNFQzB5?=
 =?utf-8?B?YmsvU3lnZHhCS0ZwRXFKdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0UrZ3hEM2RYTVN6OXhPZ1hCR09ETGE1d1Z2YWV5ZE5INTVPWDREUXRCQ1hj?=
 =?utf-8?B?azZjdHB6c2lrcEp5NGpnZGljTE9MMWJFMUYvem1sMmQ3ZW0xYkNaWjRWRE9m?=
 =?utf-8?B?cGtJVzBTRjJEQjRMWEJmVXp6bHJjR0JGSHBwK1JkQU1rM3Aya243dnA5Vldo?=
 =?utf-8?B?dDFxbHBtQ3hTcXhqSU1LczVwajZoNlBTTktFUkQ0QXpoVEFEb2VoYmxtM0R1?=
 =?utf-8?B?aXovQUdFeHZsODErQ2psckxjVkpoL0hmVWh2alNSMFVTOFpFaEhPYjNMdUl0?=
 =?utf-8?B?b0Yvd1J2dGVQSVBpNTYxbGx5bHcvWjdwVGRYcnRSUXc4UEczdC90MTBxN0N6?=
 =?utf-8?B?MHlvdk9RNkhtVUhjeTRpc2RtSVA1NEticnR6WEFYNHFxUm5LY3NlVkZFRDAy?=
 =?utf-8?B?cHV6cFh6REd0RitwOXcvZGw5OFZJcWxMeUtSbUJvdlhGNUVRdFFMZmZldHZY?=
 =?utf-8?B?TGtRbzFRb2tlUFBPd1hoODdXcFFDNUNwSXRUYTd0V0puY2UyMFZwOUdaWDR3?=
 =?utf-8?B?dUtmdnB1czFRaFFiL3VIVmE0Uzd0YnNOMmVXRG04Y0Z0Uk1EdHJFYnFNcC9r?=
 =?utf-8?B?alpmc3JDbDNFTGxON1hqbHJoeHZrS21OR2dNQ1BQY1FYbmZMSVZtVU5ibkt3?=
 =?utf-8?B?d1NJYTF4SDM0Z09YenZJNmFNci96N0ZoWmZKZ0I2ZzRUd3BISDNZaThsNlA2?=
 =?utf-8?B?WmxyVnlwZXh1R2xFZjhvSThvK3hpUHkxSHlTRmRLOTUweXppd0hFeHA0T3pF?=
 =?utf-8?B?M2gxbHlFUTVTdFBUNkRBWGYzOWNHdVQ3MmdOTEZBY2ZXZitVdW0xRnhncC92?=
 =?utf-8?B?a1lvTjdrdjRETllpRVdJYmx0V21tQll1TEE4MVd0NHhBamVycGN2RmRHSDV1?=
 =?utf-8?B?UjNoSTRuaGMrbkJqVVlJM2dwSkFMUVNwZ3pSeUJHSExVTHFvaWdqRDIyaWJi?=
 =?utf-8?B?WEF6T2tySXhJRElIVUNzaWJCMHEzWTA4RkxKekxYNXpCSURPNm1JU3ppNlNG?=
 =?utf-8?B?eU5ZaUVVU3d5SnF3QmdhMlNUSUhWNjF1YVczT0VNUkdQSHZKZDJvWEprM2lL?=
 =?utf-8?B?V04ySDhUR0pPVitkTWVJc3JvUkNFbC9LUFlxSC9zaUhJY0V1Q0ZZOFdLWTBN?=
 =?utf-8?B?aDNOZ3VjUkxWODNkVFFiQ0JwNTQxekNUMTBvOU1jMUltOU8wZzFiRUQyam5H?=
 =?utf-8?B?U25ya2NkeWxaOG9QTm5zc09wM0YydTYxVXdaL0VHT3BlZTc2YWtuR1RTMUI0?=
 =?utf-8?B?SDA5MFNQOWQ1WGVRclI1SlJnV3ZBYk5KOU9RSGxqSVpXMFV4cDRSeGQ1QzVG?=
 =?utf-8?B?RzJvUzc1MW9xTEFFSUlOb2xJWE4zcUo4RHVoenphb1JzQ3FLTEEwdHNYQm1a?=
 =?utf-8?B?V29YaVkvWjhra3RLR0tvcXBQanlreVlXYXpmaHVLSElEWlBycENlVlE2ZDBy?=
 =?utf-8?B?NE1mQ001eUNqTGxMWXdKcjFRNnRFZVVVbldVV3pXUVdmUEsrRnFxdW9GdXRU?=
 =?utf-8?B?TGF5R1owMjd4bEdKbllqNE9YTFpkY3c1WU9ZcDF1Y01tV3hYSm93bG9UcGto?=
 =?utf-8?B?UVg0ZGhLVDFEdUQ5SmpSZHh2dlp6ZWZTTXVPWlQ5cmhkcHBoQk9lVUtZNUxX?=
 =?utf-8?B?eDFjOGV3VjB6V0VOZUF2S1MvTmF5azVQQ3gwWHhPZ2g2TVpGZTVuL05vdmlQ?=
 =?utf-8?B?R2xFN0dIdEt4djZYc1ZxU0lVV3ZpaXdBUVdkMVd1cXFQM0VzbkxzdktyZTV1?=
 =?utf-8?B?d3M5MGFmeTNqWlJwaEU3UURRY3Q0UWRNd3ppNk5Gd2phdkd0UWZUTUxZYmFU?=
 =?utf-8?B?aWdUUUowa0dybTUvTDRxWDA4Y3hYdURlZk1DMlpkWHgzWFBOakZzbm8rQXZi?=
 =?utf-8?B?cjBRTkVMVHFRaUV3Z2FQT1VDeDBlbEJLS0hIdG9nYTlDTUIwa1lDY0dDWjlN?=
 =?utf-8?B?R2lVNTZBKzI0T0JacTBJUkc0cGRVa1RJSXpScm4wMXQ4UWhHUUpzZHk2b0Ri?=
 =?utf-8?B?R3VGZU81U2NmenQrZ2xwdGl5QVZtVUVtK0dXY3BGWmRRMDh0YVZUSlkzR2lk?=
 =?utf-8?B?MyszK3o1UFg1N3lvZThyN1NiZldVYmhLM2EraXFvZTN2eUlSVVQrR2E3aFl3?=
 =?utf-8?B?NzR4WnlTNWJSeGpPRkFUVTZkNzAwQ0g1dldkM1FEUU1UZU5HT2RRRE4zOHQ0?=
 =?utf-8?B?YlhvY0RRZmpncVJFTjJvY05reVNQcHl0SzVxU2tEdHdROTgvSjJuYTdVVFBE?=
 =?utf-8?B?dU9MaTVBTzJBempiNnN4cTIyNDBBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c6d586-d50a-43d4-9c1c-08dca0b0880f
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6349.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 07:18:44.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6y6/FQ9cSqsiEwYIHc/DiPXUKPsh/sdcksae33qwgiEqFVTqoLyTkYPNvG4SwPfBUbndBRN8lHNTA2rYOrhxcz7057CbsxYS0mUQoAodgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6720

Hey Jorge,

On 14.06.24 09:29, Jorge Ramirez-Ortiz, Gmail wrote:
> On 13/06/24 19:27:10, Philippe Gerum wrote:
>>
>> Philippe Gerum <rpm@xenomai.org> writes:
>>
>>> Tobias Schaffner <tobias.schaffner@siemens.com> writes:
>>>
>>>> Stress evl with a load command while running the tests. The load command
>>>> may be set to an empty string to run tests without stressing the system.
>>>>
>>>> To align with xeno-test the -l command line argument was used for the load
>>>> command. Listing of the unittests can now be done with --list and --List.
>>>>
>>>
>>> Nak. Compat with xeno-test is definitely not a requirement if this means
>>> breaking the existing evl command line usage. Besides, --List looks
>>> strange as an option. Let's pick a different option for the load command
>>> instead.
>>>
>>
>> We may want to implement the stress utility as a separate evl-stress
>> command, keeping evl-test for unit testing which has a different
>> purpose. evl-stress as a script could generate the load (dohell) and
>> possibly check the latency figures reported by latmus (using the -K and
>> -A switches to detect weird behavior).
>>
>> PS: Jorge is going to look into leveraging stress-ng for load
>> generation.
> 
> yes I am going to start looking into it. I think that maintaining Linux
> stressors should not be Xenomai's business. If we can't replicate the
> load with todays stress-ng perhaps we could just usptream what is
> needed (stress-ng is well maintained)

Do you already have an update on this? I would like to resolve this 
story to be able to integrate standardized long term tests for EVL into 
the CI.

>>
>> -- 
>> Philippe.
