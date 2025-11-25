Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180478F51
	for <xenomai@lists.linux.dev>; Tue, 25 Nov 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089480; cv=fail; b=fEILDAM/nYCvapuoY7aHcQECs+5jfCI8tIwnYkp1BzObWv5ziCWkQvKRTkB9w6SHpS05O8Dxaii9QBjZ5yAOARg4DEx82cAogONJeWP+7snhxgh6AfNgPRyV5Avym5beaaetWuzmCSu0fKuvE1gSd8FAj1YKbISHjIbAUE/piO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089480; c=relaxed/simple;
	bh=JBYBX0391Pke6nz9gnrKNL+1i40Y8i6SydDsyZ93XUY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cKaSyf/2PPfDVIeA56qKn/GGWfbIFaN9TmVUCXwKWGGF2G3xLW7exTCbbf2jx/lJJEC0Cvw+ECDWdPl5PxaNqn/TQ8VyfAuAlA7odOKaKNHvmRL24PK9ajrwtuU+2sXYJHematD9K89QL8u3rXIWTQuNlc/IuasOmx3f05vqWqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=aK8LZ1O4; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="aK8LZ1O4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPaYmrIaopup4JGmoIF36bZekTMi5IvoURQq3O9+zNJgsfuI3/dPJ9A9uA+6rue73M4BhoTEReARbxcW8WzlwQYuH0w5CVC0Ojvo7u8KCHsTDa0pdZxq1RomZl3ETZrldK8aXdqjmpdRXP2LWG412HQLYm0EaMAyKhXVAPnv/2Yvdo8yQ5D2Cl4Ghk1LukYoLtJEcEQb8yDYNwQgvV8WIDXHL6WMRReC0wSisylZZeUuPng1Z73L4IznI7Ukg+m3ZiX5ujM3CNy5pozJl4XSngE33N3JEDL90YDWHwnAJqpZVfLHygszKbH61f3VClhOmW4EGqKVH8h8MkZMDByRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTBmX9qOIUcReO4jIoZUr18xikGSYYJTXY5/0NZSCgk=;
 b=B0UAZiN9Mb9aCYYFXqQ4ZQT4ZPfs5kF8j+D2N4WAqB5tLMB1bjhN9JQ2ZBwDE7P8Sg/5YdpgeYzPdCO1cJ3sVjf6lxxd3QwWDR4N3Bou3aAdbL3e2VGU3Gl6sKsPEVkP+5JQTVSJk5xeDYXlhH67T3P3/OFBKF3fmvHlp9QKWAXD9aYK4yC//NbMypoHUv90IYruoXiDmw+3P9goYviu05+DwySCe/pZ9iYHtU7Z4gnHgFH4KVvu7ERGvSsJ/3aCbNX7npSRLdnh72MRPeflRT7FJLff67JJOOcJLJYf7QTh3Mi572s8MoZ0z1q5F+PFjCng0wwPrwh6t184w0g12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTBmX9qOIUcReO4jIoZUr18xikGSYYJTXY5/0NZSCgk=;
 b=aK8LZ1O4W7L+4LkdjI7QtVv2Mz5hUovQKQ7QQaOrWSgnewK9fjm/oObklEnV+F8ui25WSUIQF8kzwiFgs/XhgVm5fsmV4XVXuhZCPNBgRhXLZBLzftrF1KMtAlCJbJiJ2+DUTgvnuesO5nY7e6I4V1qgcfOakJWS2hsvUCovLGD5+wKYeS256FQKFc11gePrbLHIMSyRgqF+/n7sPMzSyqCiMf6vsPhFmsXqKoHL07lPZ8eFEBS/VnzBnXI/U0Ef8nzxRQuxBSH+tVPas6aug7tOIHQ2C/+QvSTBbhtItGsMmNxrqNX6af5ZV6lH0o9zvuss3lMx5w834EBhld6kqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9072.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 16:51:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 16:51:14 +0000
Message-ID: <90450dcc-6293-4835-8f75-788090a867ba@siemens.com>
Date: Tue, 25 Nov 2025 17:51:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: rt_task_resume() resumes a wrong task
To: Mauro S <mau.salvi@yahoo.com>, xenomai@lists.linux.dev
References: <144fcdcd-0944-4971-80fb-80ee7e72cb83.ref@yahoo.com>
 <144fcdcd-0944-4971-80fb-80ee7e72cb83@yahoo.com>
 <348b1bfc-8f0b-4e97-a100-999928f67ab5@siemens.com>
 <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <172ca47c-acb1-45cc-8e2c-3282c17354f5@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 05fa488b-c468-49bc-a68e-08de2c42d84a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEhrSGFFTnFraXJBTmNXb01PbzBVOUkxZW5ITlM3Rm9GRjFQZ2dnRFhIem9z?=
 =?utf-8?B?cG1makhsVTJPYlZSV2tId0ZSTHFKZWo4ZTljaXhQZE1JU3J0RkpjKzN5K2pI?=
 =?utf-8?B?US94YXJRNVdadTByVENhbytMWUFPemhLVnYvbmNEYUdyd0N5c1d0Mko1dEZL?=
 =?utf-8?B?M2N2bkNKOW1GOGZzQ0EyVDI0NmYwSUROcWZCa1Q5U1dqdjgwMUh3eUp5OEoy?=
 =?utf-8?B?RGFmWWl6eXJWemp6bXljWklGQ2IzMFU2TWVGQmVJcTJTWjEwV1Q5VEpNbHZB?=
 =?utf-8?B?ZEhnNDBnMEs3QmFJanhoRTZYOGFBTjQvSERaRGVESnlsSmk3U2FPb0loZWRG?=
 =?utf-8?B?OUU2b0M2a0piMG9pdytxbXhnMjhZTWhNdDVGdFAvOVNkejNjem1iejl0V251?=
 =?utf-8?B?RTFYaURETTRiZ29lbVVaTDFNWkhmSlR4MXJxU1ZpalpCaGJVV1Nhc01LT253?=
 =?utf-8?B?YmdtV0tIeEdodTJ5OVM3M1VxMGtBWnF2YmdnY2tHV1U4cVRGZlVhSmttYjd6?=
 =?utf-8?B?Z01iajFCTStuZTJmemJTWmk4MVBISWQwYjVhSTR1b093SXBGUWRONUtyaTFa?=
 =?utf-8?B?bGxXUXlkQWM1eGM1NFUzTzUyb2pjUHhHekxhZTNIU1VyK1hTK2x5UFM0dXh3?=
 =?utf-8?B?SGZUL2RUVzhudmRFR2o5dHIwNjdUT2pHQnU5NThidUhqeC8rbHNJVURENUlU?=
 =?utf-8?B?MkJQaEZJSytuOE5MQjdiZm5tcVdzUzVXWDZ0MmRoVFJtaDlpK1VPNk1XSnlp?=
 =?utf-8?B?Q0JUY2ZYcXFNV2FOVDZkNFdld1VCbFptaHNBQ2syTlh5b1pkanZJOTFFakNw?=
 =?utf-8?B?amtPMHdCL09mbkpoUlY0WTBldzZiVWNuT3NUQjV5MFNydzNERHNPZ2NlbHFH?=
 =?utf-8?B?VkdhVmVMRENGNGM2WFg4RjZXanZ0eEd0Ry9jYVdxYm9uRFBpTHF4am9BRU9C?=
 =?utf-8?B?cC82UTlxZGNRbGVacmhxVkY1Qy82TnRYbmVGU2JVbnVrWkZITDFlNzAzU3l3?=
 =?utf-8?B?emtZNEJNK0U4VGJnZnA2NW9yYkV4UjdzTXphM3lMQk1CbzBpaXdaV2Fpb2xI?=
 =?utf-8?B?c2h3YUlaTGZQU1A1OGlCT2hEa0pNTGpHWWJtUnh2ZVV4SVFhUFJhZ1JteEJo?=
 =?utf-8?B?cHZWbGdYU0FVbzhlY1M2TjlrOUphL0k2RVhmNkVQTk1EWFRzTkpkTVRhdUxh?=
 =?utf-8?B?UHRWZ0hsdWpMcVZoQ3FwQUFWSXdDa1NzUEMzSXRoTzZ4dFd0Q3JtWDd6R0No?=
 =?utf-8?B?bjQ2dmZZcW94WTVJUGsweGMxKytwdnFFV3FXMC85cW84c0tSUlluYWNvZlBG?=
 =?utf-8?B?SElHNjlaQzFxZlBkSG5sTFlDRmRvMEFxMWx3aDNHRFVZNlJqNXlPMEdLTVNi?=
 =?utf-8?B?dmFReWZ2MEZnWmJtanBYL1Q0NkdZRStxaCtLWGw0aHJTSHF6WjVDbG1sVTZ1?=
 =?utf-8?B?QjVpZmpYem01M0NEZEN6NUFFeTVrb1NSVnQwSGFBNU5rWnJrQzNpSW1VVWpl?=
 =?utf-8?B?SlJBeHQ4TEtoRXZma2tiTmFMVjdWWWxBc0JLeHB5cmh0Z2FKVi85MEVMc0RZ?=
 =?utf-8?B?M1V1aXIydG5GQXlhQzM2N2tMcjRtOUtXVE9rN1VjMVFaZnVCdVlwbGpJZTc4?=
 =?utf-8?B?d1FrRTFiSWNPS2gwaFpCMUlVYU03MzJhYmZtWC9hQXV5S3NZSGphL2c0T2Fn?=
 =?utf-8?B?S2wrdlVZSkl2OFZldXdIZWxKaE5OenpOd2kzM3FsMGNkY0J4NDFFSU9WSlZW?=
 =?utf-8?B?a0hYc0ZrN09RY1dCNTBzSzFHMHNQcXdlNTBzYk1BU3B4blo0M1F3dHpTbEpx?=
 =?utf-8?B?OVdSZjNHZ3puTzJmV1RRTmZKMWhGb1kvV1JBNVpMdVh2TW12RGlTY1VXc2tm?=
 =?utf-8?B?VHZ6aWhtLzMrTGFMZmJHcS84RS9JZGx6V2ZEUzFnWVloRllsUEJKWnVueXl5?=
 =?utf-8?Q?Bz+rm4/XX4QsjWeVqB82q9XtGqCdmdF1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUlUOTBobW4xMWYxeWlFcFpVb3J0aUdid3FtWmdGbVU3RzNKYXBlNkZNemZQ?=
 =?utf-8?B?NUFHcFMwNzQ3OEppeEdjbERkNU5ZTHdiRlR1Z2ovbHdPVXdqZVozL1R3ekll?=
 =?utf-8?B?MXMvSCtCczZYOFFJR0t5UnRWdFl0b2hpTyt4RDRGQjQ3N1JxbUQybm5qVjdl?=
 =?utf-8?B?OTBjd2VwNkVlWDhBY09oQnZlUFUremNyRXhLMjNKTGhuLzZSWStlb0tYV3Jx?=
 =?utf-8?B?dk54azVSRmNGMGR0b2kyRS9PWEgwZFk3aFZGRm1Ka3ZoOE9GLzg5Y2JjVHNF?=
 =?utf-8?B?NVNnd3d0U0lsZWNxdlpXdVpMZ1VtWW8wMFljRUZsWVJZQnFhenQ0dEk5bW4r?=
 =?utf-8?B?OGEzOFFnVWVNNXZwbTFaOTFVeUpYV1I1T0xUbVdML1FqTEhWYkp3YXphRDlZ?=
 =?utf-8?B?RkFQOHhVWENtbkM2SDY4Vmk2Q0R0VFEyTGQvVFd6c0g3OXo4citTYnlwY1ZQ?=
 =?utf-8?B?aVVHSUFEVndhc1JrdmlsbmF3eTZTelpNbVRCSlBkY0gzOWxzcmtEcUdBQWp2?=
 =?utf-8?B?d0NweS9ycW1KemMyRGp4YU9iZTcrS3hnZjFmc1RYc2laZDVIMWR3VWx1N1ZB?=
 =?utf-8?B?bmZRcVgvNGVsb090cVM0TFpaYklHcE9UR2YvUCtFVmdRTDl0djBIa3gwY2Jm?=
 =?utf-8?B?OE4yMXVJbUtCYmlFOUh5VGF3bk9QQS9JM3RJZHdoemFOSUhBMjJ5bkZjZkRD?=
 =?utf-8?B?WEhOZnZhdUQzVVM4QU1OcGoxQmJFaDNyNmFneS9ZYUFaSUpCbU8wRFlucjNB?=
 =?utf-8?B?QUZQM29LdXV4bW1LVzVBQlZHL21CUXE1RWdmbGtQZ0wwaFR1dFZ3SkRWUUVi?=
 =?utf-8?B?WWtZUUY3MW83UXlvMDZGK1d4SVVsTVRJa3hmTWlsT2JHOE9DL1pmZUp2U2d3?=
 =?utf-8?B?MWVqYlNxK2hnb2lxOVdKOHB0YWQ2WlZvcitEc0VPbmxQajZmZUJYTlpCRDRK?=
 =?utf-8?B?OWdJdGRQeVFhOW9NSWZoZHpaRUIxS3djNDhPZ1dFS2ZTNksrKzlwc2ZHNzZW?=
 =?utf-8?B?cnNRNGhvaVE1R0UzRWVSbEtWNFJLeUpHMjZjZjY5ZXNRYktkamdlbnZNVFNl?=
 =?utf-8?B?Ti8xVm9OTjVFUmVzUThLS2MxbFhKaXo1aEdwWkUveVZOWEpPY2xvaFY2MWJ1?=
 =?utf-8?B?V1IxR1RjRldrYWp4eE5Dc25OK1lxaXlNYTJOYWMvaktTQXArOWZXQzdZa1lB?=
 =?utf-8?B?SnA1Y2c2eDRlU0FBU012V3hlTzhDM1dIZHFSUXlOU09BYXg4V25KcWpIYlJ4?=
 =?utf-8?B?Q3R3ZkxOZENzbEk2dTd2Wko4UGY2aUxocUN1bjhMNlBIUEtUMlcyR3hQL2ti?=
 =?utf-8?B?U25kdncxYVdsa3hISHFNTGQ1aTFmcGNDbFAxenZQWXNaamFKalhSc3BsZVBP?=
 =?utf-8?B?dGltd3oxNStyd1Njc3ZBbXV0Tko0L3cyaDRBUk8yaThTQVczdENWUDFhaTd6?=
 =?utf-8?B?Ykg3NFRjNmhZYjlpMUhjbGppNjBRVUdDbnRSQ2hXSE5YSXYxQ0c3ZUJUeHQv?=
 =?utf-8?B?NUNQWDNuUlpEbFJCM2l1MVlaU2x4elkzQ0tiZ0NYREVEL1JMeVRJK2VKZ1ov?=
 =?utf-8?B?ZWVkQkg5V3p0dHk5VS9qSHFORXpqTWxiL1dJSU5xeURlRWN0UTFobUdURzRF?=
 =?utf-8?B?QTVsWFpOclhmemNsRU9lQVIrQWhBcTZMbUdYWWNicDZyV1BlWVVkY2tLenZh?=
 =?utf-8?B?VGJ6blhlUThNcC9vVHp5RHVZVDlzS1RZblV4VElGRHBmTzlSQU5pdmZlVG1H?=
 =?utf-8?B?ZzI3RHhCWmlrK3poNVFpSHIvb2wvZVVKYnBUVTVsRGNzelB5ajhRZ1NYSjI1?=
 =?utf-8?B?QXMxTnBPTkZTemdhamNCU0lPUUgyVmlwb2pZcXp4UU1LZXNncDNpMUdzelVz?=
 =?utf-8?B?ZU14QWJjM3ZVL25wMmJHcEh2SlowRmdlRDBBSytmeXdwcWowd0doN3dsT1l3?=
 =?utf-8?B?Y3NKZkdselRWNitmb0Q5UnlvZFJiZXFQUDRmZG50NVNIVlZWdHFnd2E2THMz?=
 =?utf-8?B?MGZqTEhkd1NMTCtURUVLTDkzSFVDbjB1RVliZmdUZTQ0djUzZFd1YjFDaW9F?=
 =?utf-8?B?dE5rNmRPeUYwTnRkc2xaWE5LdHRyMUx2N2JhQi8yRm1CUG1LbFFLOHViZk9z?=
 =?utf-8?B?dndpS05lemhOU1pDbmV3czNMWTBaRllUd29ITmNUS3hmREJncHNnZTBIc1ZX?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05fa488b-c468-49bc-a68e-08de2c42d84a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 16:51:14.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GSp0wPJR0uIUia5zzF0SsI9gJi7bie0Fiv4YWW2rbzXn1vYhNPx98v/Z6V0Icw/MnFztYAonlwh+JYtORDBbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9072

On 25.11.25 16:10, Mauro S wrote:
> 
> 
> On 11/25/25 15:33, Jan Kiszka wrote:
>> On 25.11.25 13:23, Mauro S wrote:
>>> Hi all,
>>>
>>> Not sure if I found an obscure corner case or I'm doing something nasty.
>>>
>>> I'm using Xenomai 3.2.8 on an Intel Atom system with Linux 5.4.299.
>>> Target image and toolchain generated by Yocto.
>>>
>>> Please find attached test case code.
>>> Program is very simple: the main task starts a bunch of joinable tasks
>>> that immediately suspend theirselves. After starting tasks, the main
>>> task resumes all tasks. They do a small sleep and then terminates.
>>> Terminated tasks are joined by another task, that was launched at the
>>> beginning of the program execution.
>>> Subsequently, main task continues to recreate, restart and resume joined
>>> tasks, on and on, until a CTRL+C is issued.
>>>
>>> What I observe is that, when calling rt_task_resume(), the wrong task is
>>> resumed.
>>> Please see the attached log. In this log I'm printing the .handle
>>> and .thread data in RT_TASK function as hexadecimal.
>>> At row 19 you can see that Task1 (that has .handle value fc1c9, the same
>>> of the terminated but not yet joined task 0) has been resumed when the
>>> rt_task_resume() was called on Task0. Task0 has been terminated its
>>> execution, but has NOT been joined yet: if I'm not wrong its resources
>>> should not be usable until join is done (at least this is what I
>>> understand by documentation). I expect that calling rt_task_resume() on
>>> a terminated-but-not-yet-joined joinable task should return an error,
>>> not resume another task. Am I wrong?
>>>
>>> I know that is some of a stressful test: in fact if I call the
>>> rt_task_resume() only if task is not terminated (checking also the
>>> executed flag adding "&& TaskList[i].executed == 0" into the if) the
>>> problem obviously does not happen, but as I said I expect an error
>>> instead of a wrong resume.
>>>
>>> Launching the attached code, you should be able to reproduce the problem
>>> on your side. When the test detects a wrong resume, program terminates
>>> automatically.
>>>
>>
>> Can you rule out data races on the shared TaskList structure? Seems both
>> your sub-tasks and the main one are accessing it, and that possibly
>> concurrently and/or unordered. Or does this also trigger in a uni-core
>> setup?
>>
>> Jan
>>
> 
> Hi Jan,
> 
> attached the modified code: each access to a TaskList element is now
> protected with a semaphore (one semaphore each element).
> Strange behavior happens anyway.
> 

...would have been too easy. Ok, will try the other day if I can
reproduce and maybe even understand.

If you would like to understand a bit more already, you could catch an
event trace (trace-cmd record -e "cobalt*" -e "sched*" -e "signal*") and
study the task interaction (trace-cmd report / kernelshark).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
