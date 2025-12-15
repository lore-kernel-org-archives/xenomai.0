Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F481DDC33
	for <xenomai@lists.linux.dev>; Mon, 15 Dec 2025 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781920; cv=fail; b=ryjVjBkIelXzjtBr0VpS14ScUjGgqcMc3hT5in/ANyBlpt5WAUzhSWPpjb6+NdvOLFyfeZgCXHcsrMb0JtIMBykcS7GGiTAsOSUVr+HBaApk+frTQ7oOdDvApCc+J3o6v4i//+7qxxVyCis9g3xh7rzQ3dhETNF9gZfkjB7i5B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781920; c=relaxed/simple;
	bh=mdZuivT9ot7ii4c6AexCOMm5wHszUVNdR4KJr36u4ck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LyK5s5CkTiUr16WB3VMdLDU0QezorYUxr9x64yScARxyctgS93/QZ3ZpKje666cAlFqhQn79yKlok7mrhtWG+3zf5Cl2K4Eu99lbjZwRuw9omz1u3z71WIGn2fwob/dZcZFkyOruLAQf0lhbbfGRwnHZRXK/BIVZxaxSKoUjmu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WGpITJaT; arc=fail smtp.client-ip=52.101.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WGpITJaT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDucer+ofjItEeU2XgWl38E6xa3D05uIvaIvoHP23+eYgb9iCiP4en5/c4XXNKuvImVfYUhW9whxfRxKEckuoXfjYGSyoq+ZEbT5q409mm47hixY72RrMLQb3ypLPRVEmVsXcFmt9yVJpXoi9RmWDcIKVRmBPzUgi01PKrxYEG5oC7bPTdIYlYWA3IJv/+ME8r4GKSKGmYNI2IL/YZ560oZcZ4cSxCzM1wk1ACWojXmfKVNEp7lQ6guaIQwrgSxz1Nz4CChS3khYz5QJi80f95F+/ljdndt7iZp6hYBle1/YhWUSc196mozRT457CddgoINFzRkwZDcUmmIe7JmRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlS4SKSomzhgHvUbyhFCmBPAoJFDkno5lRLxbZs5dow=;
 b=mT28Zk604QkwqUtj9Itw3JZhQw4jC5OnV/ybllAln4K4OBA86r27PdqcWyhPJlizt2urdwKDrXUYLlqA0mrWbW+OcRU6qabagUFIskreWyJVNnBIfdGKuDNcegy7cFIRrcNHR7Oyop0M5GrgXk59vp7b7D4N2AqSk7/APjJUZ8SquKjfROBQ5Z+WmNdGWsceU39TO2yocDPIMQtOAXmdbKEgU4xiX6+xzxdZ+QZ8S+7NNERCPT1KxzI6wZGm2J978uo4A5q8MF+F3zIH7yoUJv2B/IzMl7Ee8/wpQ1yI5mzsmXu9zKqWkg+FIluX6EpqVYbEwECzAB8TYSP595BDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlS4SKSomzhgHvUbyhFCmBPAoJFDkno5lRLxbZs5dow=;
 b=WGpITJaT+iziVz76vX9r8s5YfbWrIXMwaFX6X0Um1LCRhoyuqHzLNmMZirC2YaN0LOwtDr1/h86J6xCBbBdCWi5SD6Kke3XsvBRwDrHtI0wFK+7v6HdB4ByjqHlmsda/o3uNSy6Px09OPXxPKcUlWFqGOE4gmnanuaBAg/ZfWm0U45DBXzfoGxpYJBwuDE4Crj9yOLky3KobWpU8LhCy4d6Y0nNOknPi7dmR1obSENjDXxfsGSytyuVbTNFX9a8KjaZZtsd0K4PwJUWTiXwfpziv3HrF4vo35m2qeEui1+SW464nl5pp4DF3hl1uPFcpbTZV5PnyUmFxYf7mX3N8NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:58:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 06:58:35 +0000
Message-ID: <a4b1a462-c36f-40f9-ba20-9010d8c972cc@siemens.com>
Date: Mon, 15 Dec 2025 07:58:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Some fixes for the select syscall
To: Florian Bezdeka <florian.bezdeka@siemens.com>, xenomai@lists.linux.dev
Cc: Andreas Ziegler <ziegler.andreas@siemens.com>
References: <20251204-flo-fix-select-syscall-v1-0-7f9c545a63ce@siemens.com>
 <7bf94e8c64a09fc98850d7bc923e2ce47e713f9e.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7bf94e8c64a09fc98850d7bc923e2ce47e713f9e.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3218:EE_
X-MS-Office365-Filtering-Correlation-Id: dff6df98-59c7-477e-aa66-08de3ba75ded
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFJVcHlMWFNiUXdKeHJsWWRzU2U2STBFclJLN3VZMjdwdTJLSlFsM05KUHBS?=
 =?utf-8?B?L1RJNVEvYXdQWXJmdkxnSHRxWkNUVWhibnNQVjFnc3dSejBsN1c4Ujd3dE43?=
 =?utf-8?B?YlpNSmoxY0lxeTNreFpMMVhGTllSbVBkajBnSjdXRXJUVmp6RUU0ZWxaQk8z?=
 =?utf-8?B?MHFDZFFWa0xFY05ScGxrQ0doOFk2MmZuT3c2ZUxRSzF3UlJDcDJtRGtCYmZB?=
 =?utf-8?B?TDc1SkFvQnpFQng3MDg0dngrMlhENkFjMXJGTXRld1RoeTFncGptWnlZbDVH?=
 =?utf-8?B?THlHYVZjUmNMZ1NqTDlTYVZNVDg2a1NaclJuSE1NSmk0Q1pRbnlabU9udERp?=
 =?utf-8?B?Z05YWU1vTzJqeWJwZ2p2VUp4L1hBZHBvMnlSVExnRHVueUwzSUZNcmxGaURJ?=
 =?utf-8?B?cjdSUUt4cUFtaTdTdXh1aTFxMlZqUENSWWRxVkpSVjhnYmlpVDhKdjV1ZGZB?=
 =?utf-8?B?eGFteXorcDNoM3pKUS9ac01SZ1k3UTJKWEI5SkpJc2xtMUk3eUtacGplMFVz?=
 =?utf-8?B?RXFFc041bUEzemcrTHNMK2FqQllPTUIwWUk3SGp5MGhZQVRHeno2RlZRN1Zs?=
 =?utf-8?B?YjU1a2hxNUhvV3dIV2RNWUlIZ0lZSEdua3BoRUdVeWp1Rk1ZYThsOTdJWkZV?=
 =?utf-8?B?dnJVZEVjMzlRSkpoallSdEJSdnNlMTdSVkxLL0UrWmpONEs4d3IrcFgyZlcv?=
 =?utf-8?B?eTU2d1NiQVRueXFwamhBMTlrdmFDRm1nbDBEY0o3NkJHSkk0ZGgxeW5xNjU0?=
 =?utf-8?B?Zko4NWZZRzBsWU8rYWYxMGUrMGlIdnUvdFhIT0g5Skpnb0VibXNlbXhuVkVS?=
 =?utf-8?B?TVN4ci9XMUdPYlcvNTVKZWVQaWRQNlNyOW9ORXJseHpleTRtRVdSSFBiTFVs?=
 =?utf-8?B?ODg1S1hCc3JxWFZueUNiTDJaUy9nZXU1TE51RzBkak13enhudktYbFJoVzY4?=
 =?utf-8?B?YWMrMGdBRkR6MWZyZTdITlFMMVJFWEtlc2VTbDEyamVRQkxLblFJUnlBTG9D?=
 =?utf-8?B?ZVlBWkRUWVJ5OWU0UXFDOE01SXIwN2FaQ29nV0lCNnk1QXloeGNqc1VxNG9x?=
 =?utf-8?B?SVVQbkNUNzJjdW9FUUZWODExck0wcmxSTW96R3ptSldxYWJpc2swdDFlVEww?=
 =?utf-8?B?VnN4VFdnTCt3K1M3bm5ObUpXUThreGU4QWQ1RlNTRTYyVmlYNkhKczJ4Z0RF?=
 =?utf-8?B?ZE83QVB3RVJ2TkI4bS9HV05OUjhSamNzRmQxWEc4RlNKQzNybkpVWWRUZjJI?=
 =?utf-8?B?em1ZOE5yYlkyVm9XM2dUbDl5di9NKzMzZW5aaTdpYnBXaG5QaDh6VUZHdkFy?=
 =?utf-8?B?R2NhV1FIS1hUZk1ManYrTkpsdWpDR2hOaHVzTWtPekdyTE52RGNGZGRNaEtS?=
 =?utf-8?B?aW9KVDFvbHpZSk9lWTBHajNuSDRjbFltRmprbmdXWVRadkJaT0xOZlVvdEpP?=
 =?utf-8?B?OXJXc2w0WWM4dnZwTzYxU3B6OXk3VEs1TTBIWjJ6bVAxVGxGV1Y2Y1BORU0x?=
 =?utf-8?B?enF3b29EbmZvajIvODhSelZ4NmZtYzNPU1F4eHdKSnhGK2o0bjgzRmRoeksw?=
 =?utf-8?B?RGFKajBpZm1aaXQvd1BSZzlKaEgvSU5pUnBqdU51Z3ZMclhpbkhQME9zN3Jx?=
 =?utf-8?B?SmpXbDY5cjlhOGdBdU9RSzJ4RkFiLzFTRTYvLy9ycnZSc0hOOHJWcW1CdjZJ?=
 =?utf-8?B?SXVYc2lhVDdSajFCcllVRUMxRW1RK0ZTQ0FFekVPZ1hjb1RtRUd5OUtNV1V5?=
 =?utf-8?B?RC9aSnJ6SXRpVjBxeEtVWmZtTWMwUFZSQWIxOUtzREJVU1ZjTEthU2k5UHBo?=
 =?utf-8?B?M0NIWCtnT1Q0K01RM0oxRHFxQkpodHk0SlJzcHoyNUp4VnR5dm5JRk1zY1lR?=
 =?utf-8?B?WXJhUWszYVpUamwyUGhXMEErcDMzTlR2ZjUvUzMzN0hCQy9GMnhLcDNaMk1v?=
 =?utf-8?Q?NBERcK/E2/USBpojhu09BjgM1Nefihlj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmQwQnFFTFcxalNYZWd4Njd1elVCMnRUQS9OcHpKVmZhclpYUjd6bXk2aHQr?=
 =?utf-8?B?aEZRNG11SkpmdzZHeXkreG5aSW5hYWdzTVcrZTN3QnJqNUx0TllEYWEzMkhx?=
 =?utf-8?B?bGZLakE1ZSt2Q2xEQ2R3ckowYmlYakdVY0hGelg3VzlFS1BTTGcxVkEwRlNl?=
 =?utf-8?B?aVBWTXpab2pmcG9haURsNzZPa050d2dhU3cyQW9RMGlCNWt5V3hveDdqeDYr?=
 =?utf-8?B?aE55RmIwY2Q0ZkRyU0U2NTM4MzhNNjZHVWNRYXJCd1lUYlJEa093ZTZXN2cw?=
 =?utf-8?B?aE1xVUZCT0xIYXMwMEdjZWtzcGRXWHBLVVVsbGlkNDJHbnNTMWJ1Nm5xZmh3?=
 =?utf-8?B?T0RjWU0zdStsMGtrbmM4QWpwcXFpTmpuQnl2NStQUEg3alJJdk5JZFBTUG16?=
 =?utf-8?B?dFh6Y1JwQkRYcm5yaXBZRER3UXdRMk9lKzd3QUlKY0lBMC9SZGFwendNMDlW?=
 =?utf-8?B?WDFjcTVQU2FBU042Z3A1VlJVU1hEajJWdituazdqcVA3dmZ1RE8rR1R3T3Zs?=
 =?utf-8?B?NXErM1ozdWxwcy95NWd0NVNMalFvZDJUcjdqVTFTQ0llckhRUUhheEw1WGQ5?=
 =?utf-8?B?dnNQeE9HYTdNRjNJK2FuRnVZS1pGTzcvNWZHQTBaN1dOVUw3dFkxQ3V2ajhj?=
 =?utf-8?B?Q0owMVZLaU5nMWFMd00yVENjWFI0TnRCdU1aQ2I0TC9OUEJBRUc5SE9VbmNv?=
 =?utf-8?B?b1NyVHBUcVNIN3YzS1FtS1d3MWp5MHByV3dsNGdBQjVEZUFFR1RGU3JMSGQw?=
 =?utf-8?B?WDg4b1N1UnhuTzdFMnQrbWZ5bC9aTnBpclVvdW1NeVN2d2h1ejJmRko2M1lW?=
 =?utf-8?B?bHd4a1pLbzZrWnN6eGtBMDVFelgwOUhmek02TkpRRHRKUkd2RStzRTdNc2Fr?=
 =?utf-8?B?cXBSdEtuN20rODBQOGJ5TUhFTmtsLzEvd1ZiZDh2dzMrSzlLeGdoOEhyWVhW?=
 =?utf-8?B?SHdmN05GQ2hzOXpKZFZub0MzSEYyNCtsamdYbERzbTFBNzdON3N0RG5rQlZY?=
 =?utf-8?B?OVVVRzlYNVB2SFg3VnRuWkZGMytGL3pBQnhiQVl6bXpQN3hBQTg5c3ZyMFRz?=
 =?utf-8?B?aWF4UXdCM2RrY3NCV2QzbGxIa1V1YXprYmlCV3NtdUZGVWc4Z0FNRDg4cEZh?=
 =?utf-8?B?R2tJcUNEejcwMVQvYU15aDErcTY0SWt2ZC9WNmJTYzFJUlg4blZiamlFOVhU?=
 =?utf-8?B?Vmk2MkY2aDRib2FNMGhjQ0xQZERMcDJ2K0lZZVE3S0daWFJjUjFZak1BSkV4?=
 =?utf-8?B?NVgzNWg4am9DSDFHejFmbkRYam5rbGh0Y1NaTmNUdEpXZnJsZUJ1Uml2MUJs?=
 =?utf-8?B?YVZFcm42ZlpYRVZDVkh3MlAyODFpTWVzWVlHczVEY3N1dzBac25GSElXNUtI?=
 =?utf-8?B?ZTE0eStHbm1jcXQ5R0VLVm9VTndueEp4eVZpQzBLTWl3Sk9pKzd1dm96SVd4?=
 =?utf-8?B?bnpJeS9qSmY5dWpPN2t6OEJieTMvZFRHTVlpREdtQTM3anUvUjBiRUVDSFd5?=
 =?utf-8?B?WHl2VE1GY09TT0JHMmQ3Q05pcm01clpheGl5UGxtbk5XdGtOS2FIdWNCYThZ?=
 =?utf-8?B?Y2pRTFlFbkptQVE2eU5VelRSSzB3L0c0bXRXYi80L0pDUDNVMlhtMDh3MVc2?=
 =?utf-8?B?U1FHalpHb3Y5ZldBMGY1Slg1NDAwSWg4SkFRYk82ZkpFU3gwYWQwQ2tkeVVo?=
 =?utf-8?B?QWllVFI2cXkxdkVMSzVHblYvWCt2Y0xYQTZ5VzdKU2VCVXBZcHpNYXcxM2wx?=
 =?utf-8?B?N0hDWi81SXF4M040TGVHWVhkVUQxU1J4WnkvZDhCQVhZR3RSZkhUR0F3dnNC?=
 =?utf-8?B?MisvM1c3RmFSZm1mK3pySHNlcDI2VHFXSkp4OVU4ckJRYUZyS2ZrWHRLdjJr?=
 =?utf-8?B?SHE0d0FiVTJCZ2E5d0Rxb3dIZkl0K0VMODZZZzUyVUxza0QyQXU2M1Zkb3hn?=
 =?utf-8?B?bmVkTE95WVc1ODRUVDE5TVlQNWJSa3VRbDB3Y1BWcTRyWVFVYXdXTkQ3K0FV?=
 =?utf-8?B?TVZiUW1rK0hZaFh3ZlVRZnVkVU9lME9YeGxkK1dSdzhRNmpBSTAyYXBmYmsw?=
 =?utf-8?B?MnA2M3JXQ2lvYStQQ3cvdW1MWVJmdGVmcnJURUUwdFlWWWxIWWdxM1l4bmUy?=
 =?utf-8?Q?0nmfyOo0ZrleKAtCvN7uymQj4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff6df98-59c7-477e-aa66-08de3ba75ded
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 06:58:35.6053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HW8SXX+o9IAzrpexChWqOxxkxq6a8KKhIu0Uc9mc3govQdmEpvvE+wYYLKrA6WlpNN+H8YfavPAME8JF35RoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3218

On 05.12.25 11:53, Florian Bezdeka wrote:
> On Fri, 2025-12-05 at 10:03 +0100, Florian Bezdeka wrote:
>> Hi all,
>>
>> this is the result of a short debug session triggered by Andreas who was
>> staring at some strange select() behavior.
>>
>> The issues were introduced while working at the y2038 support, so
>> backports should go into the stable 3.2 and 3.3 series as well.
> 
> Still true for 3.3, for 3.2 some more details:
> 
> 
> After looking at the problematic user again, we realized that there is a
> different behavior regarding select() between Xenomai 3.2 and 3.3.
> 
> 3.3 comes with the following commit (see Fixes: of patches) which
> aligned the cobalt select() implementation with Linux, by doing the
> additional normalization.
> 
> faef02b5e76f ("y2038: cobalt/posix/select: Refactor __cobalt_select()")
> 
> That was done to make sure select() behaves identical under Xenomai and
> Linux.
> 
> To harmonize 3.2 and 3.3 in this regard we need to backport the
> mentioned commit upfront. It doesn't apply 1:1 but seems doable. Not
> sure if all kernels still supported by 3.2 would build, though. Needs
> checking. In case some users somehow relied on failing select() calls
> they might be surprised by a stable update.

I'm not sure yet why we should backport to 3.2. The normalization
(instead of rejection) for tv_usec >= USEC_PER_SEC was added to 3.3.
Patch 2 references a commit that is 3.3-only as well. I do not see a
reason to bother stable/v3.2.x with this series.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
