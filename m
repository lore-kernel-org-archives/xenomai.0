Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2080.outbound.protection.outlook.com [40.107.103.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA52192E7
	for <xenomai@lists.linux.dev>; Thu, 27 Feb 2025 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740637300; cv=fail; b=UIi8r8jaQk48Q3iATqHdcQf/JH8iZ+TxeekLsQ5rfJqjQcx84rpeCF81Vm6eKAKhYj8EjiILB4HfIdPPomQ0Ltm9/Rx9vNmSTo0J4NH9iRy7pPDJht9u15amRPv6v7ZXSm6rDO5+jkteOqjbu2EYad7hyT4A/14rz/27fjL1DQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740637300; c=relaxed/simple;
	bh=D3+Soa+N0NVniJgaa9R+Dmn1BaDA2YFNj20/u9aKpec=;
	h=Message-ID:Date:From:To:Subject:Cc:Content-Type:MIME-Version; b=fToYmOFIX5W67OQTp+lw5vhliwNpnnD0A4yot7BBP3NZRwcnCh6si7jxMfMPpIf7soEZBkuyZIVqDF9cESEukb9aPQF4xRPyX5N1+wNwdp6yI4rTxxFU33qYPgruq2y323ffSHeWO+nwIpLhGxv1FBM6QZjlEO4MVjAxG3pfbF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=M8mK/1Xd; arc=fail smtp.client-ip=40.107.103.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="M8mK/1Xd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+gIBh3EcmBrX51xwESuAefhQlj/CuoU7sdhjUAthofv2wBdJd4nBvrlE2sfbLMSjZq3wvbaeB4IIyBgvZ6Juq49QFyhCCr9EOkJZkYNWV2l0xPSr4VC3NjIB3suFEAwnSTjGkSYjPK3CI/9ou81SmFJuJRplfBhduZl5/t6saghJHAH1QotLEno9lQy9xHsqKusAxKRkkjYDtrGMHKwjVaXBnQjBHWkpaL3Z+2IHzLFWi6K4z2JgFeNUmbTVNRLmaxxizs1V012ygLlcwsS/CwIP4pfAXGBU6+Rr19eugH0cbOu+XkV9gLPSb/WkoektTzp0ST2KFs9j9Qu2/vNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6aymzWkrmwzy8UkwQtZUviSWSvrQZSUp6D5XihtbZU=;
 b=aIui44MrIMZnO1tKOdz8JfBYOYPNczumX7JFLSQgB9ZCCZTzq4odnPiO4MyLyq8WZ15VvZ1wFU7rZmskU0F2NDkMBAjvaC7ozmDsXI99jSejflK+jDGdWfXvTqfzLZPmCOF85a641QyA6/yGLVmEhz6WVPgWQWpLy2RH4I/fO4H+gTsFTUu4tJjIqmPEw9UEUK0c04uB6Qz1v7QAqsXkqCIlGWr/C8Fue5KwdinTEEirkW8P3cqloQJP2DhhaXjhvEyjDhTcF4W/7IJOqJXyv6C7hPxA1OV5xX4Xe6s0mgHHLKjDK4E63sQUygF5KTt/q8E9fA3eBk/2xWeCZiRxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6aymzWkrmwzy8UkwQtZUviSWSvrQZSUp6D5XihtbZU=;
 b=M8mK/1XdmFsHypjWtYPhJ1VNfOhExyEVA6hAB+qSz5hQ9RQWFJ9e+TIKo9FBIzdR+x0wHl2Ym8NNby241H2Nlo8laqmbEFpFQhMs1EUKIq0ARmwvQwsEiLtxxxXes63RULeLr7LfJtdd1CVZBxqX7fzsJPHQ3OASYBAsNvc9XpbXAnNAmKRmiuFXvnHrmRQtemtTNq0Vjgn1CYBl5wkAJs5D+Wo+ZbefiF/DwGYoqoUWp2ImFLC/cb6qLwASUMthrAsCUplsJ1mMoPYGJQh/Gu+46RUyWrjcMOtnZDHhpkG1kM8sGtDoe9zoaAJ5InJpy9OlbbbcNyCic+XtxPIVtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB9133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 06:21:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 06:21:35 +0000
Message-ID: <6a92bcba-99a9-4467-9308-a21ed7693eec@siemens.com>
Date: Thu, 27 Feb 2025 07:21:35 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Xenomai <xenomai@lists.linux.dev>
Subject: [PATCH] testsuite/smokey/y2038: Plug race between interruption
 signaler and waiter
Content-Language: en-US
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fe1292-9ee5-4fdf-d346-08dd56f6fca9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjcwK2FQWDNrbWNkbmtNUHBhMDRBaEh5aFNWMkw0aEs0ODNaZXZQckIvMkJH?=
 =?utf-8?B?VGhSVytnVUsvSlROTzljTDd1ZERSOUZBZnd6NTB3dlNuRG9NUEo4aUU1VFdH?=
 =?utf-8?B?Y290MGIzS0NwUDJ2cDV5dG83UUJhV09uWDdscG1wbmRvNUFDU3JBUy9LNmh5?=
 =?utf-8?B?Zys3dmk4MUNvdDhwVXhVbk1pZyszMTVJMkxXcWZ3Q1F6ZTJpeVVrak9LczhU?=
 =?utf-8?B?U1lSU1VMbTMwS2dKWmpoelpxWFJrZ1JlbU1aT0RUYzMzclB3Zm1QbS9kU2Zi?=
 =?utf-8?B?YWtuZllHZGxYODhhS0MyRWg0RDhSR25uMnFxQ0RTS2t6SHZHenVjeFZ1U2FJ?=
 =?utf-8?B?ZzV5MjhoTFRRYVdsNmZ5WVZGcktSa3Y0dzB2cU5vVFRET256cm8rQVFBeSts?=
 =?utf-8?B?Z1BBeUQ0VjZPNTd1bTE3U2psZnpKemY5Y0xGZFhzMHk0UUI0byszWmd0Zmhs?=
 =?utf-8?B?eG5UV2JlWHFoeHZaVE1xWW4xQnp1VEZvUHp6aXUrbFJNL1B2YW9hUjhBeXhT?=
 =?utf-8?B?cFhMR0tQYjJhWkZVRTZoZG96RlRIOHU2YnBrYmVKdG8wSVpHdlBIQXBib1o3?=
 =?utf-8?B?aTh3OW1XcE4raTV5SCtwUCt1ajRsMlF5eGppSTFiczdCOEk4QzhqZGQvK084?=
 =?utf-8?B?eFBiMTB3NEcraENMdzFqVXY4YTdxTHp3UTVBQ1krQVQ4QnV3Y3ZWeHZuMDE4?=
 =?utf-8?B?MkFXSEF1VkdpTlMxRkh3OHNEVWR1Lys3dFJNWDJEa1gyYzhQelMrcWxaVGpK?=
 =?utf-8?B?M3dFZWFkVExwUWF2cVZuZDVTNWx1YWpjTSsrT3pXR1RmL2xvZWlUL1VUQVFJ?=
 =?utf-8?B?ZlVUamdjS3FJZnM1Y1RlVkVlNGgyY20vaGdrS0piKzhuaUl4bWNmSjE0VzQy?=
 =?utf-8?B?dHFObmV3eGN1bUhFMGg4dllkLzducDNmbWlpZ1RLQ0oxSlVOaEVHT3JlYTBL?=
 =?utf-8?B?ajVNK0t6VVlsbnpCUVhpMi9Ja3dkV1FIL0krNmgzRUJPOHhWaCtiR0tOdUtG?=
 =?utf-8?B?b3lQZXZqbVU3dENnWm9Pcjd4NTk5dkZVSTJvQjB4Z05vMjRTUG1QbkErdXBU?=
 =?utf-8?B?Z0VadFZOQjN3SFlrUUUyeFlXVzhpTVptQ1ZYZGFlTTVkeVdOMzErOVVvbENx?=
 =?utf-8?B?cUtob1VVY3N3c3BqdFN2OTJodC9FZ00zcVF5TXo2UCtFRGc2TmljYTErT0pE?=
 =?utf-8?B?TGttR0Z6L3EvWFl0UkxWMlNraFE0MmRQY2txNVprOXFKWWtWejQ1VTVRaEpL?=
 =?utf-8?B?T05RVFpSZGtUek5BdXFNS1Bnd1kyOXpBM0hFRXF0Vi80MmpFZlNlR0g5Q01U?=
 =?utf-8?B?c1pIRzI5WEVTQnE0aWtjKzIyV3ZiN2U0UUhzY3RNMk1hQ05XV0lKWks0bU50?=
 =?utf-8?B?K0J1V2h3R25CRWViSFBZWm9tUHF1Q0JOMFJJaUNNREdxVWhnTllQTklZYTBI?=
 =?utf-8?B?Y25MWWk4M01vYytZUkgxSm1tcVc1bkNaM29HbW9mMGJiZ3JRY20vdmRBVVBY?=
 =?utf-8?B?RFRrbG1CbGwrT1k4UTlxSEtLNE51c0JQSUVsWDVnbkd2N3ZOSVB5REdRVlM0?=
 =?utf-8?B?bmJZOHA4RWFvWng2MkdadVBTbjduV3pjemxEMVJRQjh1RGZvb3NZNm1OdVk2?=
 =?utf-8?B?TGtLSGxJZWwwbUJnWmVrbkFmL2dabEE3NUg4aC80TWdwRFppNG9HR3RaMWNZ?=
 =?utf-8?B?QWxGZzgvSDljYTVLSDMydi8rL0ZheU1welhjN25aVXJxMUdhYitxRUp1UUl3?=
 =?utf-8?B?Z1diZkhOejFabEcwTndRMXorVFppWTNNazc1V083a1FzQ0poaHlOZDgrUkNH?=
 =?utf-8?B?V1pOZkwyNU9zQWxTMnNaT21MUTl6bkRhSk55aXJxbTN3cXpHcXhTRkxnWEdv?=
 =?utf-8?Q?RZhJx1hl0edeI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUNNcEFWZWFHSHN1V2hQYk9ZbXFtYjdWMkpUU3ZMMkFkZW0zZEk5S3dDMGhM?=
 =?utf-8?B?QmpKeGZYb3BPSEd3RWxwdXk1dlF1dkg0M3d2SEYvSTZ2K3g3MzE4VHdISXR6?=
 =?utf-8?B?VmdnU3RwbW15M3Y1OXhGTWxpZ25velJha25KVUlnQkhCZWI2RGpMWG5zUTJ5?=
 =?utf-8?B?b2ExQkpiaVlYc2NucUlmS1JBamhqcFB0Mk5lV1VwckdFMVJPRzVrakU3T0NP?=
 =?utf-8?B?V2JVMklnSWFLZExqeGRFTncvaGptVEhoVlU5T09sMWRpa3IyVUJYRGoxYVNw?=
 =?utf-8?B?eFEweTh3SE5PMlcyc1Jicm5DMkNLQjRLSndteEF5YW1mV0dZWG1aZ3JmVTBO?=
 =?utf-8?B?ZVdEUDBENTBQZ0swOW9Ma2FuMy93cVFOdDA5ZS94Ny9ObTRxVFlxbWhidlRF?=
 =?utf-8?B?aFNBVWpZRjhHcmR2d2djVkVTUmdYTlFKajJ5YlY2OGlQOFVKSFJ2WnFxR2JG?=
 =?utf-8?B?L3Iwb0phRnFzKzJHVXJMZ08yd1pwWmNyTk1tZ0FFcFpMREhud0VnS1dBTTkr?=
 =?utf-8?B?UEN0c1NjNnJkd2w5NzBLblRjRkppanM5cmZNTCtxKzFjQVNZVmhBNzVaRlAr?=
 =?utf-8?B?UG85czRYS1dIeDB0Y25EYVZvK0FhYjFLdnRGYml1T0N4LzJ6RTRrd0JiOUth?=
 =?utf-8?B?d1YyaUduMDVjYis1TWtHMFhTY3FGeTIydHp0aGMxS3FJRDZqamFZTkN3N2Vi?=
 =?utf-8?B?djRYLzA5MVgyejlPWHhlUFBNcHZYaEJHMFZ1ckxmVmQ0OEJFcklPY0ZPUzhj?=
 =?utf-8?B?V3prczNOU3RIZW05SjQ3R1ViUXdiYzZ2ZFduMW9VS1crcFJPOXZNTmFnamZE?=
 =?utf-8?B?VmVRTVFPRFlPOXZiQVNrZmVCczFyY21aM0ZlUEdTbkRtSjZKdzNJL0NzNFlh?=
 =?utf-8?B?dmkrNmdNS0g0VU54ZjY2L0V1L2pQYWlZUklzTDl3ajQzNXlKK2I4bEVuZVdB?=
 =?utf-8?B?VHdVRW9HM1F0MG9vbzVrUDVlSXVxRTk0VmcvazVyQnQycXJzQi9BVGppeFRj?=
 =?utf-8?B?T1hhSkhuQVd5MkpJOUIvZEJQWUtiRnE0UE9IRjlqUjh5Y1BacWp3Mk5GaVF5?=
 =?utf-8?B?ay8rR1VnUml2Z3ovV3lXTEg2Tkpvak01S0tOd3Q4VmRVT3lzQ1hDQ01RcFpO?=
 =?utf-8?B?M0ZveWt5MWk4Z0FsVVpyUGdxTnVleU1zY2FTQU9mU3E1SUkyaGNXK0RDUWR0?=
 =?utf-8?B?blRIYkRIb1BCVVAwcjRVbVNUTGR3RzRZWnYwUFdLeEt1ZDk0b1pwNWREWmdk?=
 =?utf-8?B?NGhXZDRPcXBLNENCdldnbTc3RG5HQ0N0Rjh1UjQrVlJ0RFRlaXljY01OZm50?=
 =?utf-8?B?emlvdFdodDdOZHdOTHB1KzY0eHZFQm5kTlpqR3k0RTVMZ09NekRUSzJnSTdW?=
 =?utf-8?B?WTVlTXRrUGJVbU93UkdtWWZhTlZYRjc5ZHdIODhmSkhlb1pHT1VYbExBLzEr?=
 =?utf-8?B?TkpEYWo4YXJTNHZzaFI3bVRhalo4VXQrVnZ0ODhQbmFDeEhXejZqZFNVZlg2?=
 =?utf-8?B?UXlUSTByaU1yK2dGZnZIRUVVM21pNExuTXJsT3pDbkExMHJMMHk3enJucTI2?=
 =?utf-8?B?bXlSZVloTFBHZlZKekhqb2hYUlBaU200cE9Kc3pxTXMzOW5kczFDL0dtMmZL?=
 =?utf-8?B?VzFhZnRoUmJYcHluajZscUxQYmNvYXZEK01kZUFkS05lU0o2RS9Bd3JpUDBZ?=
 =?utf-8?B?Z2pIVjdYUWNCTnNVSnZPeEJFYVZ6SlluanppN0pSOGxwdnlrSjRuWE12L0dU?=
 =?utf-8?B?OU9uRVBmdmJSbkpiYkc2QWoxSnFINXVpRFRuSkt3L2R1NXFqTWlZUDNsSzEr?=
 =?utf-8?B?TnVwNStkcStKeFg3cTNqNEhoNzBmaWhUV2ZEeWcrNHRaTWxNS3BEbU9JL0t0?=
 =?utf-8?B?RFBFV1N4QWcvVGRqMytLWHZ0ZThZWDVKS3hyWkp0cEJJYkNHWGhUTDFrd0Rx?=
 =?utf-8?B?ckZxazRYSVB1Y1k3K3NqaVp2eUpnSjYvSUQwdlBJUnZXeVFVUlRrNHVseHdr?=
 =?utf-8?B?WFFEdkFZKzVXeDk3TEp5cWFlbDVVV0gvY0lzU0c3TGF2WGZjc1FVajdkdUlN?=
 =?utf-8?B?TkI2KzZvUUxSM2VBTFRRL0h3dUdvYU53cmEvYjhpeVhISDRSL3pXazBXMVJm?=
 =?utf-8?B?cEExWVpRTDFGZVo0V0pPazZZL0NpemtiMldrWXVZRXQrNFVhM2hZM0xvQUZH?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fe1292-9ee5-4fdf-d346-08dd56f6fca9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 06:21:35.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDtFLAXfkjZh6rvnyqK/fqA0TOgiV3uchGASTuFAdGDunwWtgCbhKiZD1kQVWgz4pWkU4JT6IY0cN3kjRIT0tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9133

From: Jan Kiszka <jan.kiszka@siemens.com>

While testing pselect interruption, force signaler and waiter on the
same CPU and prioritize the latter over the former. This avoids a race
between sending the signal right after being unblocked from the
semaphore and blocking in pselect. Seen rather frequently now with
qemu-arm 4-core machines.

With the schedule-based ordering in place, we can safely drop the
nanosleep before signalling.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/y2038/syscall-tests.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/testsuite/smokey/y2038/syscall-tests.c b/testsuite/smokey/y2038/syscall-tests.c
index 29e9c66c0a..b614d3ba07 100644
--- a/testsuite/smokey/y2038/syscall-tests.c
+++ b/testsuite/smokey/y2038/syscall-tests.c
@@ -13,6 +13,7 @@
 #include <sys/timerfd.h>
 #include <sys/utsname.h>
 #include <mqueue.h>
+#include <sched.h>
 #include <rtdm/ipc.h>
 
 smokey_test_plugin(y2038, SMOKEY_NOARGS, "Validate correct y2038 support");
@@ -1422,9 +1423,11 @@ static void pselect64_sig_handler(int sig)
 static void *pselect64_waiting_thread(void *arg)
 {
 	struct thread_context *ctx = (struct thread_context *)arg;
+	struct sched_param schedp = {.sched_priority = 99};
 	struct xn_timespec64 ts;
 	int sock = ctx->sock;
 	struct sigaction sa;
+	cpu_set_t cpuset;
 	fd_set rfds;
 	int ret;
 
@@ -1439,6 +1442,18 @@ static void *pselect64_waiting_thread(void *arg)
 	if (ret)
 		goto out;
 
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+	ret = sched_setaffinity(0, sizeof(cpuset), &cpuset);
+	if (!smokey_assert(ret == 0)) {
+		ret = -errno;
+		goto out;
+	}
+
+	ret = sched_setscheduler(0, SCHED_FIFO, &schedp);
+	if (!smokey_assert(ret == 0))
+		goto out;
+
 	/* Waiting for 1sec should be enough to get a signal */
 	ts.tv_sec = 1;
 	ts.tv_nsec = 0;
@@ -1461,9 +1476,9 @@ out:
 
 static int test_pselect64_interruption(void)
 {
-	struct timespec ts = { .tv_sec = 0, .tv_nsec = 100000 };
 	struct thread_context ctx = { 0 };
 	void *w_ret = NULL;
+	cpu_set_t cpuset;
 	pthread_t w;
 	sem_t sem;
 	int sock;
@@ -1481,6 +1496,12 @@ static int test_pselect64_interruption(void)
 	if (ret)
 		return ret;
 
+	CPU_ZERO(&cpuset);
+	CPU_SET(0, &cpuset);
+	ret = sched_setaffinity(0, sizeof(cpuset), &cpuset);
+	if (!smokey_assert(ret == 0))
+		return -errno;
+
 	ctx.sock = sock;
 	ctx.sc_nr = sc_cobalt_pselect64;
 	ctx.sem = &sem;
@@ -1493,9 +1514,6 @@ static int test_pselect64_interruption(void)
 	/* Wait for the waiting thread to be ready */
 	sem_wait(&sem);
 
-	/* Allow the waiting thread to enter the pselect64() syscall */
-	nanosleep(&ts, NULL);
-
 	/* Send a signal to interrupt the syscall and trigger -EINTR */
 	__STD(pthread_kill(w, SIGUSR1));
 
-- 
2.43.0
